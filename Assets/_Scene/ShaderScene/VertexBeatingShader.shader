﻿Shader "ShaderTest/VertexBeatingShader"
{
	Properties
	{
		_ScaleAmount ("Scale Amount", Range(0.5, 5)) = 1
		_Speed  ("Speed", Range(1, 50)) = 10
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float4 vertColor : COLOR;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			float _ScaleAmount;
			float _Speed;
			
			v2f vert (appdata v)
			{
				v2f o;

				o.vertColor = v.vertex + float4(0.5, 0.5, 0.5, 0);

				float sinValue = 1 + (sin(_Speed * _Time) / 2);	// 0.5 ~ 1.5
				float finalScale = sinValue * _ScaleAmount;

				o.vertex = UnityObjectToClipPos(v.vertex * finalScale);

				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				// sample the texture
				return i.vertColor;
			}
			ENDCG
		}
	}
}