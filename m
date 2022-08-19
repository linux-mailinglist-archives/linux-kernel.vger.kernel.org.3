Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17855993ED
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 06:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344497AbiHSENu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 00:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345163AbiHSENp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 00:13:45 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA9D61721;
        Thu, 18 Aug 2022 21:13:41 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id i14so6682656ejg.6;
        Thu, 18 Aug 2022 21:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=BxxIf4ICLTKnjJ5aVGidvHQIOHUtRRv6urv+Qzj5jkI=;
        b=ZJip5BfO3l92GgahTctqVpvWnm2m24EXsmFyL4EG5YkVZUo/Ss8bZzi4HTqY/Kn+T2
         1LaPg1nXPqo7gDGCigaTTN0utOVD932QdCjO7X0/B67eKt8U0l+MFLMqHzkiT/IJUXxD
         0hxbj1FdPgz+F9OHaTaVcdQDarlBOJ3G8KSkAMCrQJKRF5hBCaBF/m4iALsMuEgixJxA
         F1DCFPl44aeH0KOcTZM1b3yQyT70KrgYbDLhrNNeM4rXw3Zpth55vt7apy3gmREF4NVm
         tQdMVJWJY4jNUK3nKBp++jz9scKFQZElxV1iM/Bvhq/XmIZH+7JveVx9hAyWbRopi2dP
         TZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=BxxIf4ICLTKnjJ5aVGidvHQIOHUtRRv6urv+Qzj5jkI=;
        b=WXM4mwd57Xe+w2H8XHZ0pItV6QaJFKlTtxiw1dgqOHNEbJyVYm9v6VERz0Nrzzkxvc
         RThRIJmXAQvkHpmiHGU5NWA+1P2cKV0Otxkf6+8WPfzyzP3zR4OwRz4jDE2v8FC5lVpb
         Oblc1NyIv4NpgZKgKHzMBUK5Sti8b+f4NVrNhsmdkAqmdAlD3lMrgQc2J1w9miGkXozR
         Qde772DORyVhSHqu4mvYktKQSGDhSWAm4kAwd3z8xbcHhVxHS8wuG+LCRrDcT/yXn0CM
         qBF5uj6bJxZjTODcc4sTV+hpCjM6qVrova0B+3E+SROCaQ8+Gk77XsJ+ILjO2DvZ0YRQ
         Sn9g==
X-Gm-Message-State: ACgBeo3gwexkV1sx3kB3LoSt1aU5dzecRtc8yOoHdxAA+QLECceJNDs6
        1IuIADi2JCkke6YciPN2S2w=
X-Google-Smtp-Source: AA6agR7xtwZPWKgGk3TjC9bSK4HxhNAbu5i2li1AQjQzmEN9t/rm3PEEKTFcDnUEuidxsKm+N92oRw==
X-Received: by 2002:a17:907:2c42:b0:730:aacf:1b69 with SMTP id hf2-20020a1709072c4200b00730aacf1b69mr3667025ejc.381.1660882419432;
        Thu, 18 Aug 2022 21:13:39 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-172.dynamic.telemach.net. [82.149.1.172])
        by smtp.gmail.com with ESMTPSA id n22-20020aa7d056000000b0043bbf79b3ebsm2324523edo.54.2022.08.18.21.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 21:13:38 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        =?ISO-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     =?ISO-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] arm64: dts: allwinner: h6: Add cooling map for GPU
Date:   Fri, 19 Aug 2022 06:13:37 +0200
Message-ID: <2641460.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <20220818203928.131059-3-cpe@outsight.tech>
References: <20220818203928.131059-1-cpe@outsight.tech> <20220818203928.131059-3-cpe@outsight.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne =C4=8Detrtek, 18. avgust 2022 ob 22:39:26 CEST je Cl=C3=A9ment P=C3=A9r=
on napisal(a):
> From: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
>=20
> Add a simple cooling map for the GPU.
>=20
> Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>

Is this really patch 2/4? I only got patches 2-4, but not patch 1.

Best regards,
Jernej

> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 22 ++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi index
> 5a28303d3d4c..943ae5374dd6 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -186,6 +186,7 @@ gpu: gpu@1800000 {
>  			clocks =3D <&ccu CLK_GPU>, <&ccu CLK_BUS_GPU>;
>  			clock-names =3D "core", "bus";
>  			resets =3D <&ccu RST_BUS_GPU>;
> +			#cooling-cells =3D <2>;
>  			status =3D "disabled";
>  		};
>=20
> @@ -1075,6 +1076,27 @@ gpu-thermal {
>  			polling-delay-passive =3D <0>;
>  			polling-delay =3D <0>;
>  			thermal-sensors =3D <&ths 1>;
> +
> +			trips {
> +				gpu_alert: gpu-alert {
> +					temperature =3D <85000>;
> +					hysteresis =3D <2000>;
> +					type =3D "passive";
> +				};
> +
> +				gpu-crit {
> +					temperature =3D=20
<100000>;
> +					hysteresis =3D <0>;
> +					type =3D "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip =3D <&gpu_alert>;
> +					cooling-device =3D <&gpu=20
THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
>  		};
>  	};
>  };




