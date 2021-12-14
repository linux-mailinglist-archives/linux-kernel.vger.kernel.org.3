Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94FF9473F27
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 10:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbhLNJRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 04:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbhLNJRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 04:17:35 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5576CC06173F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 01:17:35 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1mx3w6-0006pa-FU; Tue, 14 Dec 2021 10:17:26 +0100
Message-ID: <5d1df18f4bf8f3e1d62cf2d9b1e003d91c1bfcec.camel@pengutronix.de>
Subject: Re: [PATCH V4 6/9] arm64: dts: imx8mn: add GPC node
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Adam Ford <aford173@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, tharvey@gateworks.com,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 14 Dec 2021 10:17:25 +0100
In-Reply-To: <20211128131853.15125-7-aford173@gmail.com>
References: <20211128131853.15125-1-aford173@gmail.com>
         <20211128131853.15125-7-aford173@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, dem 28.11.2021 um 07:18 -0600 schrieb Adam Ford:
> Add the DT node for the GPC, including all the PGC power domains,
> some of them are not fully functional yet, as they require interaction
> with the blk-ctrls to properly power up/down the peripherals.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  arch/arm64/boot/dts/freescale/imx8mn.dtsi | 49 +++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> index ba23b416b5e6..ef1699a9cd7d 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> @@ -4,6 +4,8 @@
>   */
> 
>  #include <dt-bindings/clock/imx8mn-clock.h>
> +#include <dt-bindings/power/imx8mn-power.h>
> +#include <dt-bindings/reset/imx8mq-reset.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> @@ -640,6 +642,53 @@ src: reset-controller@30390000 {
>  				interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
>  				#reset-cells = <1>;
>  			};
> +
> +			gpc: gpc@303a0000 {
> +				compatible = "fsl,imx8mn-gpc";
> +				reg = <0x303a0000 0x10000>;
> +				interrupt-parent = <&gic>;
> +				interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
> +
> +				pgc {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					pgc_hsiomix: power-domain@0 {
> +						#power-domain-cells = <0>;
> +						reg = <IMX8MN_POWER_DOMAIN_HSIOMIX>;
> +						clocks = <&clk IMX8MN_CLK_USB_BUS>;
> +					};
> +
> +					pgc_otg1: power-domain@1 {
> +						#power-domain-cells = <0>;
> +						reg = <IMX8MN_POWER_DOMAIN_OTG1>;
> +						power-domains = <&pgc_hsiomix>;
> +					};
> +
> +					pgc_gpumix: power-domain@2 {
> +						#power-domain-cells = <0>;
> +						reg = <IMX8MN_POWER_DOMAIN_GPUMIX>;
> +						clocks = <&clk IMX8MN_CLK_GPU_CORE_ROOT>,
> +							 <&clk IMX8MN_CLK_GPU_SHADER>,
> +							 <&clk IMX8MN_CLK_GPU_BUS_ROOT>,
> +							 <&clk IMX8MN_CLK_GPU_AHB>;
> +						resets = <&src IMX8MQ_RESET_GPU_RESET>;
> +					};
> +
> +					pgc_dispmix: power-domain@3 {
> +						#power-domain-cells = <0>;
> +						reg = <IMX8MN_POWER_DOMAIN_DISPMIX>;
> +						clocks = <&clk IMX8MN_CLK_DISP_AXI_ROOT>,
> +							 <&clk IMX8MN_CLK_DISP_APB_ROOT>;
> +					};
> +
> +					pgc_mipi: power-domain@4 {
> +						#power-domain-cells = <0>;
> +						reg = <IMX8MN_POWER_DOMAIN_MIPI>;
> +						power-domains = <&pgc_dispmix>;
> +					};
> +				};
> +			};
>  		};
> 
>  		aips2: bus@30400000 {
> --
> 2.32.0
> 


