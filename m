Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BAA575121
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 16:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239161AbiGNOyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 10:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiGNOyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:54:13 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04D1D79;
        Thu, 14 Jul 2022 07:54:11 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so8856159pjl.5;
        Thu, 14 Jul 2022 07:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1f7yVekuROTEUGgx6GsaKGUVoDNAizXJ+17gsqlYs7k=;
        b=g60MPCQ5/QBCBBCFcsLOf2L0Rwz2uZJOS8KrMBK0zcQMMnncsQJ/zw8xWB7P+bfc3I
         pJ/rjUFfRZMrWGru0g+bVZOE5AnSG/z4IP8yJpfRkAcUkeu5+whQS2hnRnBi9AYnzt5Y
         2gR/dhQw1kxQzH9uVQvU7TOfS+079pa4BRq8Q+hAFHmu6wsvLjmDslZshF9Kf9+cdcbV
         Q+fLbFZIvrxxZATVG7redWJFilHcX8I04GCbNiaZhpAc23pCuH07Wak3KYmK2xuy663J
         XSlskJCzEYXBIi9fOjyPZp2J+lgzrQBi36bAtGO7JyMf6p2ZiqrnNWAB/5KA0vBYtnpw
         w9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1f7yVekuROTEUGgx6GsaKGUVoDNAizXJ+17gsqlYs7k=;
        b=cL4TcDVNfH3rQyHDOP7nGRmbQRu8uUvpTtgaHChWjgVonMn4/ETihd5g4dxlwG6GQr
         CEPGnVC31GhvxoCqMuqt89iaYNbfd+nrw+YrRTec96GHTfFFHe6MJrBw/c6wlrDnwizA
         i3S1QtlIHz0NRvS2RpcaZvANlgwlEM+MxC8r8KLnwQO8UhzsZOPx6wh+crmVqV350V28
         TPLhzuEuoFVOKUeH4V9nmJFn3qoucWnlSxvA8S7uqtcPTu7/YyoWOb23NTC0oPljdBSK
         6NF3D3f7lvfGKKA3EofOPMv9Cp+OQo448os77ceFSl8GEy1Pw64wNe5AfJx8o4aPZ7OZ
         f5iQ==
X-Gm-Message-State: AJIora8zH7+cBTpVtY0b0FQ1lIMSbt0ts/5SubupCVhpOhfZ1q9B2S6D
        U9vXQDQ7Yf37HiPn6bCzHvI2l5lfeyuOnAQHw58=
X-Google-Smtp-Source: AGRyM1s2q9mZDD+r6Olh7IzCB74jFksokOGlfbu2QutJJGJzLfBBQtDTN055JK7KtQ+Kv63FsA8J2MhPMwb82dafE/0=
X-Received: by 2002:a17:90b:1c07:b0:1f0:2077:6a9 with SMTP id
 oc7-20020a17090b1c0700b001f0207706a9mr17088428pjb.90.1657810451096; Thu, 14
 Jul 2022 07:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220713074118.14733-1-frieder@fris.de> <20220713074118.14733-3-frieder@fris.de>
In-Reply-To: <20220713074118.14733-3-frieder@fris.de>
From:   Heiko Thiery <heiko.thiery@gmail.com>
Date:   Thu, 14 Jul 2022 16:53:58 +0200
Message-ID: <CAEyMn7bzfThcC9oZyTsu9QSbete-G-n=YWtj510NP5w3AXV7jw@mail.gmail.com>
Subject: Re: [PATCH 2/6] arm64: dts: imx8mm-kontron: Use the VSELECT signal to
 switch SD card IO voltage
To:     Frieder Schrempf <frieder@fris.de>
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
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

Hi,

Am Mi., 13. Juli 2022 um 09:41 Uhr schrieb Frieder Schrempf <frieder@fris.de>:
>
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>
> It turns out that it is not necessary to declare the VSELECT signal as
> GPIO and let the PMIC driver set it to a fixed high level. This switches
> the voltage between 3.3V and 1.8V by setting the PMIC register for LDO5
> accordingly.
>
> Instead we can do it like other boards already do and simply mux the
> VSELECT signal of the USDHC interface to the pin. This makes sure that
> the correct voltage is selected by setting the PMIC's SD_VSEL input
> to high or low accordingly.
>
> Reported-by: Heiko Thiery <heiko.thiery@gmail.com>
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Reviewed-by: Heiko Thiery <heiko.thiery@gmail.com>

> ---
>  arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts    | 3 +++
>  arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi | 2 --
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
> index cb8102bb8db5..bc46426ad8f6 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
> @@ -321,6 +321,7 @@ MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1         0x1d0
>                         MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2             0x1d0
>                         MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3             0x1d0
>                         MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12                0x019
> +                       MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT          0x1d0
>                 >;
>         };
>
> @@ -333,6 +334,7 @@ MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1         0x1d4
>                         MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2             0x1d4
>                         MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3             0x1d4
>                         MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12                0x019
> +                       MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT          0x1d0
>                 >;
>         };
>
> @@ -345,6 +347,7 @@ MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1         0x1d6
>                         MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2             0x1d6
>                         MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3             0x1d6
>                         MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12                0x019
> +                       MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT          0x1d0
>                 >;
>         };
>  };
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
> index b6d90d646a5f..77c074b491a6 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
> @@ -86,7 +86,6 @@ pca9450: pmic@25 {
>                 pinctrl-0 = <&pinctrl_pmic>;
>                 interrupt-parent = <&gpio1>;
>                 interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> -               sd-vsel-gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
>
>                 regulators {
>                         reg_vdd_soc: BUCK1 {
> @@ -229,7 +228,6 @@ MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA                      0x400001c3
>         pinctrl_pmic: pmicgrp {
>                 fsl,pins = <
>                         MX8MM_IOMUXC_GPIO1_IO00_GPIO1_IO0               0x141
> -                       MX8MM_IOMUXC_GPIO1_IO04_GPIO1_IO4               0x141
>                 >;
>         };
>
> --
> 2.37.0
>
