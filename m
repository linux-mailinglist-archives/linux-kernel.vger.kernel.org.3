Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28DD35A2F84
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 21:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344861AbiHZTAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 15:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344234AbiHZTAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 15:00:24 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF32B7FB;
        Fri, 26 Aug 2022 12:00:03 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 519BE2B3;
        Fri, 26 Aug 2022 21:00:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1661540400;
        bh=ssabbTy5MKSrv/V8sgDdoX5TEjDpuV0Khzcx+zOOY9E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I7P/V+m4ueBHnBc1to1KT6ZebT537tW55GmSelssGNZL1o8f/3o6V7nNu4UhUR6Jn
         rPLpJ87mZrj0IaXwJXCuIrd2UoTDgnwhfo9YVuAb3ULuYC9+Ja/bEo822nT5ItE3U4
         bSaMvJAtzCxdzJ5MOTvJG08xaKTVk3hVggJymnbw=
Date:   Fri, 26 Aug 2022 21:59:53 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 5/6] ARM: dts: sun8i: a83t: Add MIPI CSI-2 controller
 node
Message-ID: <YwkYKcffdRGnq+pK@pendragon.ideasonboard.com>
References: <20220826182803.604563-1-paul.kocialkowski@bootlin.com>
 <20220826182803.604563-6-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220826182803.604563-6-paul.kocialkowski@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Thank you for the patch.

On Fri, Aug 26, 2022 at 08:28:02PM +0200, Paul Kocialkowski wrote:
> MIPI CSI-2 is supported on the A83T with a dedicated controller that
> covers both the protocol and D-PHY. It can be connected to the CSI
> interface as a V4L2 subdev through the fwnode graph.
> 
> This is not done by default since connecting the bridge without a
> subdev attached to it will cause a failure on the CSI driver.

No urgency, but would it be possible to fix this so that the CSI-2
receiver can be connected to the CSI unconditionally in DT ? The
connection exists at the hardware level in the SoC, and should thus
exist here too, regardless of whether or not a sensor is connected.

> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  arch/arm/boot/dts/sun8i-a83t.dtsi | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
> index 82fdb04122ca..ecf9f3b2c0c0 100644
> --- a/arch/arm/boot/dts/sun8i-a83t.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
> @@ -1064,6 +1064,32 @@ csi: camera@1cb0000 {
>  			status = "disabled";
>  		};
>  
> +		mipi_csi2: csi@1cb1000 {
> +			compatible = "allwinner,sun8i-a83t-mipi-csi2";
> +			reg = <0x01cb1000 0x1000>;
> +			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ccu CLK_BUS_CSI>,
> +				 <&ccu CLK_CSI_SCLK>,
> +				 <&ccu CLK_MIPI_CSI>,
> +				 <&ccu CLK_CSI_MISC>;
> +			clock-names = "bus", "mod", "mipi", "misc";
> +			resets = <&ccu RST_BUS_CSI>;
> +			status = "disabled";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				mipi_csi2_in: port@0 {
> +					reg = <0>;
> +				};
> +
> +				mipi_csi2_out: port@1 {
> +					reg = <1>;
> +				};
> +			};
> +		};
> +
>  		hdmi: hdmi@1ee0000 {
>  			compatible = "allwinner,sun8i-a83t-dw-hdmi";
>  			reg = <0x01ee0000 0x10000>;

-- 
Regards,

Laurent Pinchart
