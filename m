Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21D25A9A26
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbiIAOWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234652AbiIAOVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:21:49 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918CC72ECA;
        Thu,  1 Sep 2022 07:21:30 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2B4846CD;
        Thu,  1 Sep 2022 16:21:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1662042088;
        bh=A5gkBR9bPfI62fiXWS9MBQdkIPuX3rhZB6oxYtEU7sc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UpYA6BFhSUdU8txv9sZ2xFyWokhbwkCjKKCPikq1hPctQaIdop/y9Nj3Jl5fR5sVJ
         kzTb1dap0tPiMNh+RDtJUVq8vTpicd2AvWEzo0dXqKbNhE6Iwc7TzOVnRdR4auWExG
         ty4J+5/QDmMW8XyiY1cCWC9TbkvdSB4NFvSN6dxg=
Date:   Thu, 1 Sep 2022 17:21:16 +0300
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
Message-ID: <YxC/3KLfJHpld+jx@pendragon.ideasonboard.com>
References: <20220826182803.604563-1-paul.kocialkowski@bootlin.com>
 <20220826182803.604563-6-paul.kocialkowski@bootlin.com>
 <YwkYKcffdRGnq+pK@pendragon.ideasonboard.com>
 <YxC7+Pi4v3Bc1oXc@aptenodytes>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YxC7+Pi4v3Bc1oXc@aptenodytes>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 04:04:40PM +0200, Paul Kocialkowski wrote:
> Hi Laurent,
> 
> On Fri 26 Aug 22, 21:59, Laurent Pinchart wrote:
> > Hi Paul,
> > 
> > Thank you for the patch.
> > 
> > On Fri, Aug 26, 2022 at 08:28:02PM +0200, Paul Kocialkowski wrote:
> > > MIPI CSI-2 is supported on the A83T with a dedicated controller that
> > > covers both the protocol and D-PHY. It can be connected to the CSI
> > > interface as a V4L2 subdev through the fwnode graph.
> > > 
> > > This is not done by default since connecting the bridge without a
> > > subdev attached to it will cause a failure on the CSI driver.
> > 
> > No urgency, but would it be possible to fix this so that the CSI-2
> > receiver can be connected to the CSI unconditionally in DT ? The
> > connection exists at the hardware level in the SoC, and should thus
> > exist here too, regardless of whether or not a sensor is connected.
> 
> Yes it's true that having the link always would be legitimate.
> 
> For the context, this CSI controller can be switched between the MIPI CSI-2
> controller and a parallel sensor input (i.e. it's not dedicated to one or the
> other like on the V3).
> 
> Last time I tried, having the connection between the two always there resulted
> in the unability to use a parallel sensor when no sensor is attached to the
> mipi csi-2 receiver. Probably because the async notifier never completes since
> the mipi csi-2's subdev is never registered without a sensor subdev attached.
> 
> Do you see a way to handle this case properly?

It sounds like an issue in the CSI-2 receiver driver. If there's no
input device attached to it, it should register its subdev directly,
without its own async notifier.

> > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > ---
> > >  arch/arm/boot/dts/sun8i-a83t.dtsi | 26 ++++++++++++++++++++++++++
> > >  1 file changed, 26 insertions(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
> > > index 82fdb04122ca..ecf9f3b2c0c0 100644
> > > --- a/arch/arm/boot/dts/sun8i-a83t.dtsi
> > > +++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
> > > @@ -1064,6 +1064,32 @@ csi: camera@1cb0000 {
> > >  			status = "disabled";
> > >  		};
> > >  
> > > +		mipi_csi2: csi@1cb1000 {
> > > +			compatible = "allwinner,sun8i-a83t-mipi-csi2";
> > > +			reg = <0x01cb1000 0x1000>;
> > > +			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> > > +			clocks = <&ccu CLK_BUS_CSI>,
> > > +				 <&ccu CLK_CSI_SCLK>,
> > > +				 <&ccu CLK_MIPI_CSI>,
> > > +				 <&ccu CLK_CSI_MISC>;
> > > +			clock-names = "bus", "mod", "mipi", "misc";
> > > +			resets = <&ccu RST_BUS_CSI>;
> > > +			status = "disabled";
> > > +
> > > +			ports {
> > > +				#address-cells = <1>;
> > > +				#size-cells = <0>;
> > > +
> > > +				mipi_csi2_in: port@0 {
> > > +					reg = <0>;
> > > +				};
> > > +
> > > +				mipi_csi2_out: port@1 {
> > > +					reg = <1>;
> > > +				};
> > > +			};
> > > +		};
> > > +
> > >  		hdmi: hdmi@1ee0000 {
> > >  			compatible = "allwinner,sun8i-a83t-dw-hdmi";
> > >  			reg = <0x01ee0000 0x10000>;

-- 
Regards,

Laurent Pinchart
