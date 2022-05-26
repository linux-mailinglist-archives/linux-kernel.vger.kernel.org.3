Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62416535501
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344407AbiEZUrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbiEZUre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:47:34 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70978A443;
        Thu, 26 May 2022 13:47:33 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ck4so5075628ejb.8;
        Thu, 26 May 2022 13:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zF0dlNUACtjt+qkupNMI+W9KO4LXB81LDpLHAqqq8bU=;
        b=KKvIvjxG35BgXYRE5GUSWo2W1Eh3brqlBtN2mpq5uc0lPq2xirit4nJHH0YMVit0ak
         8jI3FQhvBmg5xAWR0TS+e8BBm80miOcQ3xIZgyyZlB0RIwCwqMFrWwFpQlv0HZsj16Rd
         wFvPF48VR006mQuYqtErwUgKQC1BRWHqfIFWZukdwJzmFaX2yjm2KLcvT7PnZW1VPuDE
         C1pWoEqmVbu0eaWC8Q9p08E8wjGTFDvwDgnikIBNzIMktt3znlazEwdI4dflMdxvOwNB
         WTiiKyJUHo7uJZUzytM4uXOeu3j15TCEiV3Zb33spBgB59tRP6lsP4A/1Q0C07LsXOxK
         E8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zF0dlNUACtjt+qkupNMI+W9KO4LXB81LDpLHAqqq8bU=;
        b=gUPY9EmF9rxHVMneSpg5BnrXS09qzn1ONjb/XZakZfIBg6OZIvIJ7EMLWyfVFjUbdE
         0pJUDNzEYm+vAQFR0S3XahJpcowNHz2nVjUsu5cJ1t/4qIzALTsTds754QtNeWEuEzeM
         5ocRykZvQpA6ZGLq5uT3MgcCYXhwvMho99I/UOFnVVWuXsQrtds4K8FAb7IzOhCGdccA
         uEGPY1C3/rDngJMXVwIZgee6hhUiCBg8ygkVkNQkcuoc2nWehfgQtYOu409aL2meLSAX
         Y6lZ3REuXHZXQJ41LLj2o74jCoQwOA9Aub1lD4EaNF+bYqU3uySklGyEObMoXLiuS6a7
         T1XQ==
X-Gm-Message-State: AOAM5300vlCfYXd66/EwpdwcdjOE+ILYtAM+2lxudPfhUAWQzMCIPvSB
        SFRjocDmkeXojf2LUB5e2eY=
X-Google-Smtp-Source: ABdhPJw0IIXSFXU9ghub7BEMgfUTM2n9AyloyVrpCQcpB3A7OI/7nUffW+7qG0Yk/U2dJqjtpLXiUw==
X-Received: by 2002:a17:906:3a92:b0:6fe:9029:b62c with SMTP id y18-20020a1709063a9200b006fe9029b62cmr35511240ejd.569.1653598051959;
        Thu, 26 May 2022 13:47:31 -0700 (PDT)
Received: from kista.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id sb22-20020a1709076d9600b006f3ef214dd9sm823554ejc.63.2022.05.26.13.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 13:47:31 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ARM: dts: sun5i: adjust whitespace around '='
Date:   Thu, 26 May 2022 22:47:30 +0200
Message-ID: <1893171.PYKUYFuaPT@kista>
In-Reply-To: <20220526203547.830848-1-krzysztof.kozlowski@linaro.org>
References: <20220526203547.830848-1-krzysztof.kozlowski@linaro.org>
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

Dne =C4=8Detrtek, 26. maj 2022 ob 22:35:46 CEST je Krzysztof Kozlowski napi=
sal(a):
> Fix whitespace coding style: use single space instead of tabs or
> multiple spaces around '=3D' sign in property assignment.  No functional
> changes (same DTB).
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

>=20
> ---
>=20
> Output compared with dtx_diff and fdtdump.
> ---
>  arch/arm/boot/dts/sun5i-a13-licheepi-one.dts | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/sun5i-a13-licheepi-one.dts b/arch/arm/boot/
dts/sun5i-a13-licheepi-one.dts
> index 2ce361f8fede..3a6c4bd0a44f 100644
> --- a/arch/arm/boot/dts/sun5i-a13-licheepi-one.dts
> +++ b/arch/arm/boot/dts/sun5i-a13-licheepi-one.dts
> @@ -67,18 +67,18 @@ leds {
>  		compatible =3D "gpio-leds";
> =20
>  		led-0 {
> -			label =3D"licheepi:red:usr";
> +			label =3D "licheepi:red:usr";
>  			gpios =3D <&pio 2 5 GPIO_ACTIVE_LOW>;
>  		};
> =20
>  		led-1 {
> -			label =3D"licheepi:green:usr";
> +			label =3D "licheepi:green:usr";
>  			gpios =3D <&pio 2 19 GPIO_ACTIVE_LOW>;
>  			default-state =3D "on";
>  		};
> =20
>  		led-2 {
> -			label =3D"licheepi:blue:usr";
> +			label =3D "licheepi:blue:usr";
>  			gpios =3D <&pio 2 4 GPIO_ACTIVE_LOW>;
>  		};
> =20
> --=20
> 2.34.1
>=20
>=20


