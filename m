Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF875473F52
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 10:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbhLNJYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 04:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbhLNJYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 04:24:31 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75C7C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 01:24:30 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1mx42o-0007Z5-5r; Tue, 14 Dec 2021 10:24:22 +0100
Message-ID: <0c64fff9eedee4e6d9cbd2244d7304236f5dcc8d.camel@pengutronix.de>
Subject: Re: [PATCH V4 9/9] arm64: dts: imx8mn: Enable GPU
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
Date:   Tue, 14 Dec 2021 10:24:20 +0100
In-Reply-To: <20211128131853.15125-10-aford173@gmail.com>
References: <20211128131853.15125-1-aford173@gmail.com>
         <20211128131853.15125-10-aford173@gmail.com>
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
> The i.MX8M-Nano features a GC7000. The Etnaviv driver detects it as:
> 
>     etnaviv-gpu 38000000.gpu: model: GC7000, revision: 6203
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mn.dtsi | 25 +++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> index d8726d0ce326..5b8f8488e362 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> @@ -1117,6 +1117,31 @@ gpmi: nand-controller@33002000 {
>  			status = "disabled";
>  		};
> 
> +		gpu: gpu@38000000 {
> +			compatible = "vivante,gc";
> +			reg = <0x38000000 0x8000>;
> +			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clk IMX8MN_CLK_GPU_AHB>,
> +				<&clk IMX8MN_CLK_GPU_BUS_ROOT>,
> +				<&clk IMX8MN_CLK_GPU_CORE_ROOT>,
> +				<&clk IMX8MN_CLK_GPU_SHADER>;
> +			clock-names = "reg", "bus", "core", "shader";
> +			assigned-clocks = <&clk IMX8MN_CLK_GPU_CORE>,
> +					  <&clk IMX8MN_CLK_GPU_SHADER>,
> +					  <&clk IMX8MN_CLK_GPU_AXI>,
> +					  <&clk IMX8MN_CLK_GPU_AHB>,
> +					  <&clk IMX8MN_GPU_PLL>,
> +					  <&clk IMX8MN_CLK_GPU_CORE>,
> +					  <&clk IMX8MN_CLK_GPU_SHADER>;

This repeated CORE and SHADER clock looks odd. Wouldn't it be possible
to avoid this by reordering the assigned-clocks?

Regards,
Lucas

> +			assigned-clock-parents = <&clk IMX8MN_GPU_PLL_OUT>,
> +						  <&clk IMX8MN_GPU_PLL_OUT>,
> +						  <&clk IMX8MN_SYS_PLL1_800M>,
> +						  <&clk IMX8MN_SYS_PLL1_800M>;
> +			assigned-clock-rates = <0>, <0>, <800000000>, <400000000>, <1200000000>,
> +				<400000000>, <400000000>;
> +			power-domains = <&pgc_gpumix>;
> +		};
> +
>  		gic: interrupt-controller@38800000 {
>  			compatible = "arm,gic-v3";
>  			reg = <0x38800000 0x10000>,
> --
> 2.32.0
> 


