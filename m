Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706B44FFB5B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 18:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236871AbiDMQeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 12:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbiDMQeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 12:34:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4CC58E7B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 09:31:41 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1nefu5-0004wI-4P; Wed, 13 Apr 2022 18:31:37 +0200
Message-ID: <11f8bf43-d6f7-12fe-f5da-1f7a397c4317@pengutronix.de>
Date:   Wed, 13 Apr 2022 18:31:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3] arm64: dts: imx8mm-evk: add pwm1/backlight support
Content-Language: en-US
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        linux-amarula@amarulasolutions.com,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        linux-arm-kernel@lists.infradead.org, Li Jun <jun.li@nxp.com>
References: <20220413160900.36271-1-tommaso.merciai@amarulasolutions.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20220413160900.36271-1-tommaso.merciai@amarulasolutions.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tomasso,

On 13.04.22 18:08, Tommaso Merciai wrote:
> Add pwm1/backlight support nodes for imx8mm_evk board.
> Align with u-boot dts
> 
> References:
>  - https://patchwork.ozlabs.org/project/uboot/patch/20220326111911.13720-9-tommaso.merciai@amarulasolutions.com/
> 
> Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> ---
> Changes since v1:
>  - Fix commit body
>  - Enable pwm, backlight
> 
> Changes since v2:
>  - Remove status okay from pwm1,backlight (enable as default)
> 
>  arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> index 6d67df7692f1..c50d2cc3ca71 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> @@ -59,6 +59,14 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
>  		enable-active-high;
>  	};
>  
> +	backlight: backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm1 0 5000000>;
> +		brightness-levels = <0 255>;
> +		num-interpolated-steps = <255>;
> +		default-brightness-level = <250>;
> +	};
> +
>  	ir-receiver {
>  		compatible = "gpio-ir-receiver";
>  		gpios = <&gpio1 13 GPIO_ACTIVE_LOW>;
> @@ -395,6 +403,11 @@ &wdog1 {
>  	status = "okay";
>  };
>  
> +&pwm1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_backlight>;

imx8mm.dtsi has &pwm1 { status = "disabled" };
Where is it enabled?

> +};
> +
>  &iomuxc {
>  	pinctrl_fec1: fec1grp {
>  		fsl,pins = <
> @@ -549,4 +562,10 @@ pinctrl_wdog: wdoggrp {
>  			MX8MM_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B	0x166
>  		>;
>  	};
> +
> +	pinctrl_backlight: backlightgrp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_GPIO1_IO01_PWM1_OUT	0x06
> +		>;
> +	};
>  };


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
