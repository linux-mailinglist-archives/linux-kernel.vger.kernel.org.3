Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF10473F3A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 10:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbhLNJTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 04:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbhLNJTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 04:19:36 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58990C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 01:19:36 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1mx3y4-000709-GS; Tue, 14 Dec 2021 10:19:28 +0100
Message-ID: <be86f831da91ff44ff627f605d03b315260a2b7c.camel@pengutronix.de>
Subject: Re: [PATCH V4 8/9] arm64: dts: imx8mn: add DISP blk-ctrl
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
Date:   Tue, 14 Dec 2021 10:19:27 +0100
In-Reply-To: <20211128131853.15125-9-aford173@gmail.com>
References: <20211128131853.15125-1-aford173@gmail.com>
         <20211128131853.15125-9-aford173@gmail.com>
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
> Add the DT node for the DISP blk-ctrl. With this in place the
> display/mipi power domains should be functional.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  arch/arm64/boot/dts/freescale/imx8mn.dtsi | 28 +++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> index 902d5725dc55..d8726d0ce326 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> @@ -1039,6 +1039,34 @@ aips4: bus@32c00000 {
>  			#size-cells = <1>;
>  			ranges;
> 
> +			disp_blk_ctrl: blk-ctrl@32e28000 {
> +				compatible = "fsl,imx8mn-disp-blk-ctrl", "syscon";
> +				reg = <0x32e28000 0x100>;
> +				power-domains = <&pgc_dispmix>, <&pgc_dispmix>,
> +						<&pgc_dispmix>, <&pgc_mipi>,
> +						<&pgc_mipi>;
> +				power-domain-names = "bus", "isi",
> +						     "lcdif", "mipi-dsi",
> +						     "mipi-csi";
> +				clocks = <&clk IMX8MN_CLK_DISP_AXI>,
> +					 <&clk IMX8MN_CLK_DISP_APB>,
> +					 <&clk IMX8MN_CLK_DISP_AXI_ROOT>,
> +					 <&clk IMX8MN_CLK_DISP_APB_ROOT>,
> +					 <&clk IMX8MN_CLK_DISP_AXI_ROOT>,
> +					 <&clk IMX8MN_CLK_DISP_APB_ROOT>,
> +					 <&clk IMX8MN_CLK_DISP_PIXEL_ROOT>,
> +					 <&clk IMX8MN_CLK_DSI_CORE>,
> +					 <&clk IMX8MN_CLK_DSI_PHY_REF>,
> +					 <&clk IMX8MN_CLK_CSI1_PHY_REF>,
> +					 <&clk IMX8MN_CLK_CAMERA_PIXEL_ROOT>;
> +				clock-names = "disp_axi", "disp_apb",
> +					      "disp_axi_root", "disp_apb_root",
> +					      "lcdif-axi", "lcdif-apb", "lcdif-pix",
> +					      "dsi-pclk", "dsi-ref",
> +					      "csi-aclk", "csi-pclk";
> +				#power-domain-cells = <1>;
> +			};
> +
>  			usbotg1: usb@32e40000 {
>  				compatible = "fsl,imx8mn-usb", "fsl,imx7d-usb";
>  				reg = <0x32e40000 0x200>;
> --
> 2.32.0
> 


