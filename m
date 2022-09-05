Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093F15AD854
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 19:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238015AbiIERXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 13:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbiIERXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 13:23:18 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1219852FC4;
        Mon,  5 Sep 2022 10:23:17 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id gb36so18281826ejc.10;
        Mon, 05 Sep 2022 10:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=3g5pXO8vt8VikNU0nvZUDcJj8Xo4WnKc2gEqOdfk/2Q=;
        b=kMTQO0WUPetKeIUvcWZYfOX/DronrP0ofp64pmqZgKYCc0kUackunOXwB4iHEeqOyH
         CfavNCA+7H6XKO3VvCOJ/R6dsoRzdJrPTTjKXyNKUSquYd+u80h3DQdTIQTeCYymaS/b
         88trMIUvJgHYJgRd1SULijR8wyvxd9HcssorkQripYdLDxrGpKxzGnEifUWjDo9Iflm5
         BMUHeZ8tvzZsSBnuzKuft+KeU3XLBCDLjG3VfSoy+n+zKLJ5flEoU+8+s+MhpvsktleV
         ZinXicUkywI0oDWEgr4o/7QmSDaiHRjNTRgU3tzBLdW9Uwb5GPJxWV4XlXrcwbt+Grb7
         a8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=3g5pXO8vt8VikNU0nvZUDcJj8Xo4WnKc2gEqOdfk/2Q=;
        b=rHn6dL+hyHL/FkcyAA5Wi4gKCppLld4rCUuBQrycXRKDfMIc2YjPH1lpQ/RPHJbq0v
         eETSFi8GM6+cGfOBnEo3aIBfHbUUVqIKMAva+OwC0yf/Mb/0QAkqEFG07vIo0c5gbjac
         ds9XL3I3H2CBsNSoFB4DXOTMQlzdNhFnpR1RPO6a980EnxuNAqEKXhkq3UPq1DBRsNXj
         FI7TeHMXlJHZEahPpVs5h8Q66xvJPuUn5ugARqoINBLwIYA2JZZJrR4gY5bIrhTYqZ79
         wROn4tRXP/9L9wnVw2kSOmy9Kvu+MLHVBUe0DIqUCZoMAwhd3MuO1+PnL7pgqFnAdi6o
         pUZA==
X-Gm-Message-State: ACgBeo2tR/tgzfyhyZini7bHAyEwdALq6dZzBvkefsLrIVFuZKlRf/+I
        k/G5xrH2AInwvKLFRbjRl6k=
X-Google-Smtp-Source: AA6agR5mO71WxQwcBosJgPPuyOgbeJkdL8BB5q4tXfaGtIduchOQwHXDPDKlqipYIz267eLU8kBI3Q==
X-Received: by 2002:a17:907:7fa5:b0:730:5d54:4c24 with SMTP id qk37-20020a1709077fa500b007305d544c24mr36795658ejc.641.1662398595531;
        Mon, 05 Sep 2022 10:23:15 -0700 (PDT)
Received: from kista.localnet (82-149-1-172.dynamic.telemach.net. [82.149.1.172])
        by smtp.gmail.com with ESMTPSA id r21-20020aa7d595000000b0043cc2c9f5adsm2699473edq.40.2022.09.05.10.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 10:23:15 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        =?ISO-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        =?ISO-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Subject: Re: [PATCH v3 2/5] arm64: dts: allwinner: h6: Add cooling map for GPU
Date:   Mon, 05 Sep 2022 19:23:13 +0200
Message-ID: <5855006.lOV4Wx5bFT@kista>
In-Reply-To: <20220905171601.79284-3-peron.clem@gmail.com>
References: <20220905171601.79284-1-peron.clem@gmail.com> <20220905171601.79284-3-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 05. september 2022 ob 19:15:58 CEST je Cl=E9ment P=E9ron=20
napisal(a):
> Add a simple cooling map for the GPU.
>=20
> This cooling map come from the vendor kernel 4.9 with a
> 2=B0C hysteresis added.
>=20
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 51 +++++++++++++++++++-
>  1 file changed, 49 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi index
> 5a28303d3d4c..1259ab0c3956 100644
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
> @@ -1072,9 +1073,55 @@ map0 {
>  		};
>=20
>  		gpu-thermal {
> -			polling-delay-passive =3D <0>;
> -			polling-delay =3D <0>;
> +			polling-delay-passive =3D <1000>;
> +			polling-delay =3D <2000>;
>  			thermal-sensors =3D <&ths 1>;
> +
> +			trips {
> +				gpu_alert0: gpu-alert-0 {
> +					temperature =3D <95000>;
> +					hysteresis =3D <2000>;
> +					type =3D "passive";
> +				};
> +
> +				gpu_alert1: gpu-alert-1 {
> +					temperature =3D=20
> <100000>;
> +					hysteresis =3D <2000>;
> +					type =3D "passive";
> +				};
> +
> +				gpu_alert2: gpu-alert-2 {
> +					temperature =3D=20
> <105000>;
> +					hysteresis =3D <2000>;
> +					type =3D "passive";
> +				};
> +
> +				gpu-crit {
> +					temperature =3D=20
> <115000>;
> +					hysteresis =3D <0>;
> +					type =3D "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				// Fordid the GPU to go over=20
756MHz

Typo: Fordid -> Forbid

Also next below.

Best regards,
Jernej

> +				map0 {
> +					trip =3D <&gpu_alert0>;
> +					cooling-device =3D <&gpu
>  1 THERMAL_NO_LIMIT>;
> +				};
> +
> +				// Fordid the GPU to go over
> 624MHz
> +				map1 {
> +					trip =3D <&gpu_alert1>;
> +					cooling-device =3D <&gpu=20
> 2 THERMAL_NO_LIMIT>;
> +				};
> +
> +				// Fordid the GPU to go over=20
> 576MHz
> +				map2 {
> +					trip =3D <&gpu_alert2>;
> +					cooling-device =3D <&gpu=20
> 3 THERMAL_NO_LIMIT>;
> +				};
> +			};
>  		};
>  	};
>  };
> --
> 2.34.1


