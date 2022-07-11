Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6595700A9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbiGKL3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbiGKL25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:28:57 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1933126AEA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 04:10:24 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id ez10so8172979ejc.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 04:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zkANRKcZbCaKSgW3zgTNeMUMr8X2SBwRfvqFLff+8ZA=;
        b=ZBgFbOgBqk32UIWTND6ietHkpJ9TJrOwwXtkzswaVpoU8cqklMCFk81fOuqvtO9b9+
         193XC1MSSCbyeRCTelx7Em66ORq+FmDBSYBVSERNcNEchxozN6pHqlwerTuLzywh1PJ7
         PPr5INbdvszlJtgdHO6XhLDVfxRYSD+EpLfYzREdWmvAqfTXb1AYuMVQyzz+UgfSKZsT
         OipXrh2/XOdyT0NtEXhNWLcAzerxjK/m2z7jd3nRq6uX7U+n5jKV+w1Tq89vDB1ZQFIh
         KjdKi2LPGjl7/fc3L/TZkwDsVRLWhTZ+cQonFNbttvBLHusUdIQosAAUe4FLvsRMbyrB
         i/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zkANRKcZbCaKSgW3zgTNeMUMr8X2SBwRfvqFLff+8ZA=;
        b=R8StLp5tcSSWsAWWoy/6wPuc5eY0384lGamia7P8+XZ78Tvo9nqtMawKtHYx+88QXz
         4h2Y0GzkeKlAl84ljXHbjE7K4kdsKMWJqZXAob5DDxWDKGu9+ljT5DVcu4nB5GU+ufPJ
         38hMhetwU/OQmpxTWUpUkP5Eey5+n8WshXlRbDJbkeNAMD3Qx579xApLyIoIMZ7mO+2r
         q6WXOshIRQOqdX2y8og8kldpnOepUL8e7Yu3xjrGCAFnA1RL0vA4Hl8Hv5bTQwxY/Zr5
         ZMQe6Gl6ytL4u4xXuPnhdFqLSxdlFi8x7xF3SeA0MOkAIHT58mKKpczL2mcg66J5u6jo
         TOtA==
X-Gm-Message-State: AJIora/Djed4hTAaJjsoAAmuCYK88BHr7VBKQP4zSRqRne9MAu60XcOx
        WMJ5iD283iEHkIVM2iqqIS2Hpg==
X-Google-Smtp-Source: AGRyM1uSmvI2XhE/U0vJsp/yH6sycrVAD/rDP9hVX00y91ePkUQ92JzvhV0TAf2kqlLOX6iymV68bw==
X-Received: by 2002:a17:907:6ea3:b0:726:ca39:5d98 with SMTP id sh35-20020a1709076ea300b00726ca395d98mr17992224ejc.400.1657537822607;
        Mon, 11 Jul 2022 04:10:22 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id gx16-20020a170906f1d000b0072b1bb3cc08sm2562448ejb.120.2022.07.11.04.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 04:10:22 -0700 (PDT)
Date:   Mon, 11 Jul 2022 14:10:19 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Viorel Suman <viorel.suman@nxp.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Peng Fan <peng.fan@nxp.com>, Liu Ying <victor.liu@nxp.com>,
        Shijie Qin <shijie.qin@nxp.com>, Ming Qian <ming.qian@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 01/15] dt-bindings: clk: imx: Add fsl,scu-clk yaml file
Message-ID: <YswFG/JdjGC03rHU@linaro.org>
References: <20220707125022.1156498-1-viorel.suman@oss.nxp.com>
 <20220707125022.1156498-2-viorel.suman@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707125022.1156498-2-viorel.suman@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-07-07 15:50:08, Viorel Suman (OSS) wrote:
> From: Abel Vesa <abel.vesa@nxp.com>
>
> In order to replace the fsl,scu txt file from bindings/arm/freescale,
> we need to split it between the right subsystems. This patch documents
> separately the 'clock' child node of the SCU main node.
>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Shawn, I'm assuming you're going to pick this up through your tree,
right?

> ---
>  .../bindings/arm/freescale/fsl,scu.txt        | 31 -------------
>  .../bindings/clock/fsl,scu-clk.yaml           | 43 +++++++++++++++++++
>  2 files changed, 43 insertions(+), 31 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/fsl,scu-clk.yaml
>
> diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> index a87ec15e28d2..ef7f5222ac48 100644
> --- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> @@ -79,29 +79,6 @@ Required properties:
>  			See detailed Resource ID list from:
>  			include/dt-bindings/firmware/imx/rsrc.h
>
> -Clock bindings based on SCU Message Protocol
> -------------------------------------------------------------
> -
> -This binding uses the common clock binding[1].
> -
> -Required properties:
> -- compatible:		Should be one of:
> -			  "fsl,imx8dxl-clk"
> -			  "fsl,imx8qm-clk"
> -			  "fsl,imx8qxp-clk"
> -			followed by "fsl,scu-clk"
> -- #clock-cells:		Should be 2.
> -			Contains the Resource and Clock ID value.
> -- clocks:		List of clock specifiers, must contain an entry for
> -			each required entry in clock-names
> -- clock-names:		Should include entries "xtal_32KHz", "xtal_24MHz"
> -
> -The clock consumer should specify the desired clock by having the clock
> -ID in its "clocks" phandle cell.
> -
> -See the full list of clock IDs from:
> -include/dt-bindings/clock/imx8qxp-clock.h
> -
>  Pinctrl bindings based on SCU Message Protocol
>  ------------------------------------------------------------
>
> @@ -127,7 +104,6 @@ Required properties for Pinctrl sub nodes:
>  			Please refer to i.MX8QXP Reference Manual for detailed
>  			CONFIG settings.
>
> -[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
>  [2] Documentation/devicetree/bindings/power/power-domain.yaml
>  [3] Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt
>
> @@ -208,11 +184,6 @@ firmware {
>  			  &lsio_mu1 1 3
>  			  &lsio_mu1 3 3>;
>
> -		clk: clk {
> -			compatible = "fsl,imx8qxp-clk", "fsl,scu-clk";
> -			#clock-cells = <2>;
> -		};
> -
>  		iomuxc {
>  			compatible = "fsl,imx8qxp-iomuxc";
>
> @@ -265,7 +236,5 @@ serial@5a060000 {
>  	...
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_lpuart0>;
> -	clocks = <&uart0_clk IMX_SC_R_UART_0 IMX_SC_PM_CLK_PER>;
> -	clock-names = "ipg";
>  	power-domains = <&pd IMX_SC_R_UART_0>;
>  };
> diff --git a/Documentation/devicetree/bindings/clock/fsl,scu-clk.yaml b/Documentation/devicetree/bindings/clock/fsl,scu-clk.yaml
> new file mode 100644
> index 000000000000..f2c48460a399
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/fsl,scu-clk.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/fsl,scu-clk.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: i.MX SCU Client Device Node - Clock bindings based on SCU Message Protocol
> +
> +maintainers:
> +  - Abel Vesa <abel.vesa@nxp.com>
> +
> +description: i.MX SCU Client Device Node
> +  Client nodes are maintained as children of the relevant IMX-SCU device node.
> +  This binding uses the common clock binding.
> +  (Documentation/devicetree/bindings/clock/clock-bindings.txt)
> +  The clock consumer should specify the desired clock by having the clock
> +  ID in its "clocks" phandle cell. See the full list of clock IDs from
> +  include/dt-bindings/clock/imx8qxp-clock.h
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - fsl,imx8dxl-clk
> +          - fsl,imx8qm-clk
> +          - fsl,imx8qxp-clk
> +      - const: fsl,scu-clk
> +
> +  '#clock-cells':
> +    const: 2
> +
> +required:
> +  - compatible
> +  - '#clock-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    clock-controller {
> +        compatible = "fsl,imx8qxp-clk", "fsl,scu-clk";
> +        #clock-cells = <2>;
> +    };
> --
> 2.25.1
>
