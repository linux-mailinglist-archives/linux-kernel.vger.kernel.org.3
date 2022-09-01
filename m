Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87BB5A9819
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbiIANHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbiIANHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:07:21 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B50BA9F9;
        Thu,  1 Sep 2022 06:01:46 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A3C356D1;
        Thu,  1 Sep 2022 15:00:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1662037228;
        bh=Ek9xvHUgwJfU0sGMBKk7EZKPxBzprp7PA6EP8DsGhOM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P0jnZzLba+sh/JxiGcynNr6Vl2uXafSKWfXEH/m69Ns2VWCAdnEAh5n81ie2KJRsl
         xS4pJtVkL0kjnKyvUl0lXMou8TR3kVUrq6dchX6x7N3TPgLaWqnhjCy2u2muFaTBG8
         iBYagt0uTj2QOdJ9rvFqQcps3RsA+K4Xk/DGvwv0=
Date:   Thu, 1 Sep 2022 16:00:17 +0300
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
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?utf-8?B?S8OpdmluIEwnaMO0cGl0YWw=?= <kevin.lhopital@bootlin.com>
Subject: Re: [PATCH NOT FOR MERGE v5 6/6] ARM: dts: sun8i: a83t: bananapi-m3:
 Enable MIPI CSI-2 with OV8865
Message-ID: <YxCs4fhx+Qx7uCAF@pendragon.ideasonboard.com>
References: <20220826182803.604563-1-paul.kocialkowski@bootlin.com>
 <20220826182803.604563-7-paul.kocialkowski@bootlin.com>
 <YwkaFC2tm96X5qon@pendragon.ideasonboard.com>
 <YxCqZ8GhiTJlZ8MC@aptenodytes>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YxCqZ8GhiTJlZ8MC@aptenodytes>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 02:49:43PM +0200, Paul Kocialkowski wrote:
> On Fri 26 Aug 22, 22:08, Laurent Pinchart wrote:
> > On Fri, Aug 26, 2022 at 08:28:03PM +0200, Paul Kocialkowski wrote:
> > > From: Kévin L'hôpital <kevin.lhopital@bootlin.com>
> > > 
> > > The Bananapi M3 supports a camera module which includes an OV8865 sensor
> > > connected via the parallel CSI interface and an OV8865 sensor connected
> > > via MIPI CSI-2.
> > > 
> > > The I2C2 bus is shared by the two sensors as well as the (active-low)
> > > reset signal, but each sensor has it own shutdown line.
> > 
> > I see a single sensor in this file, am I missing something ?
> 
> Indeed this patch only adds the OV8865, not the OV5640 which is also present
> on the same camera board extension.
> 
> A patch was submitted some time ago adding support for (only) the OV5640:
> https://lore.kernel.org/lkml/20190408165744.11672-7-wens@kernel.org/

OK. That's fine, let's just reword the commit message.

> > Sounds like a perfect candidate for an overlay, it could then be merged
> > upstream.
> 
> Do we have an upstream place to merge device-tree overlays now?

They're accepted in the upstream kernel as far as I know, a git grep for
/plugin/ in .dts files produces 18 matches.

> I'll check if it's possible to describe both sensors together and actually
> be able to select one or the other properly from userspace. Last time I tried
> this wasn't possible: there's at least the shared reset GPIO used by both
> sensors, which cannot be requested by the two drivers in parallel.
> 
> To be honest this is very poor hardware design and it was almost certainly
> designed with the idea that only one sensor will be configured per boot.
> See https://wiki.banana-pi.org/Camera and
> https://drive.google.com/file/d/0B4PAo2nW2KfnOEFTMjZ2aEVGUVU/view?usp=sharing
> for the schematics pdf

It's not great indeed, but not that uncommon either (unfortunately). I
wonder if we need some kind of reset GPIO API, but that would be a hack
at most I think.

> > > Signed-off-by: Kévin L'hôpital <kevin.lhopital@bootlin.com>
> > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > ---
> > >  arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts | 102 +++++++++++++++++++
> > >  1 file changed, 102 insertions(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
> > > index 5a7e1bd5f825..80fd99cf24b2 100644
> > > --- a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
> > > +++ b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
> > > @@ -85,6 +85,30 @@ led-1 {
> > >  		};
> > >  	};
> > >  
> > > +	reg_ov8865_avdd: ov8865-avdd {
> > > +		compatible = "regulator-fixed";
> > > +		regulator-name = "ov8865-avdd";
> > > +		regulator-min-microvolt = <2800000>;
> > > +		regulator-max-microvolt = <2800000>;
> > > +		vin-supply = <&reg_dldo4>;
> > > +	};
> > > +
> > > +	reg_ov8865_dovdd: ov8865-dovdd {
> > > +		compatible = "regulator-fixed";
> > > +		regulator-name = "ov8865-dovdd";
> > > +		regulator-min-microvolt = <2800000>;
> > > +		regulator-max-microvolt = <2800000>;
> > > +		vin-supply = <&reg_dldo4>;
> > > +	};
> > > +
> > > +	reg_ov8865_dvdd: ov8865-dvdd {
> > > +		compatible = "regulator-fixed";
> > > +		regulator-name = "ov8865-dvdd";
> > > +		regulator-min-microvolt = <1200000>;
> > > +		regulator-max-microvolt = <1200000>;
> > > +		vin-supply = <&reg_eldo1>;
> > > +	};
> > 
> > Are those three regulators on the Banana Pi, or on the camera module ?
> 
> That's on the camera module.
> 
> > > +
> > >  	reg_usb1_vbus: reg-usb1-vbus {
> > >  		compatible = "regulator-fixed";
> > >  		regulator-name = "usb1-vbus";
> > > @@ -115,6 +139,23 @@ &cpu100 {
> > >  	cpu-supply = <&reg_dcdc3>;
> > >  };
> > >  
> > > +&csi {
> > > +	status = "okay";
> > > +
> > > +	ports {
> > > +		#address-cells = <1>;
> > > +		#size-cells = <0>;
> > > +
> > > +		port@1 {
> > > +			reg = <1>;
> > 
> > All of this (except the status = "okay") should go to sun8i-a83t.dtsi.
> > 
> > > +
> > > +			csi_in_mipi_csi2: endpoint {
> > > +				remote-endpoint = <&mipi_csi2_out_csi>;
> > > +			};
> > 
> > This too actually, once the issue mentioned in patch 5/6 gets fixed.
> > 
> > > +		};
> > > +	};
> > > +};
> > > +
> > >  &de {
> > >  	status = "okay";
> > >  };
> > > @@ -147,6 +188,36 @@ hdmi_out_con: endpoint {
> > >  	};
> > >  };
> > >  
> > > +&i2c2 {
> > > +	pinctrl-names = "default";
> > > +	pinctrl-0 = <&i2c2_pe_pins>;
> > 
> > This looks like a candidate for upstreaming in
> > sun8i-a83t-bananapi-m3.dts, it shouldn't be in the overlay.
> 
> I2C2 is actually also exported in the PH pins, which is available on the board
> header, so it's not obvious that using the PE pins should be the default.
> 
> The context is that Allwinner SoCs usually have a dedicated I2C controller for
> cameras, but also route a "generic" I2C controller on the same pins.

Out of curiosity, what features do those dedicated camera I2C
controllers provide, compared to "normal" I2C controllers ?

> Here that's on the PE14/15 pins. Since we don't have mainline support for this
> camera-dedicated I2C controller, we end up routing the generic one to the PE
> pins, which are routed to the camera connector.

OK.

> In the future we could add support for this camera-dedicated controller, which
> would then allow routing i2c2 to the PH pins independently. This is what the
> downstream Allwinner BSP kernel does.
> 
> > > +	status = "okay";
> > > +
> > > +	ov8865: camera@36 {
> > > +		compatible = "ovti,ov8865";
> > > +		reg = <0x36>;
> > > +		pinctrl-names = "default";
> > > +		pinctrl-0 = <&csi_mclk_pin>;
> > > +		clocks = <&ccu CLK_CSI_MCLK>;
> > > +		assigned-clocks = <&ccu CLK_CSI_MCLK>;
> > > +		assigned-clock-rates = <24000000>;
> > > +		avdd-supply = <&reg_ov8865_avdd>;
> > > +		dovdd-supply = <&reg_ov8865_dovdd>;
> > > +		dvdd-supply = <&reg_ov8865_dvdd>;
> > > +		powerdown-gpios = <&pio 4 17 GPIO_ACTIVE_LOW>; /* PE17 */
> > > +		reset-gpios = <&pio 4 16 GPIO_ACTIVE_LOW>; /* PE16 */
> > > +
> > > +		port {
> > > +			ov8865_out_mipi_csi2: endpoint {
> > > +				data-lanes = <1 2 3 4>;
> > > +				link-frequencies = /bits/ 64 <360000000>;
> > > +
> > > +				remote-endpoint = <&mipi_csi2_in_ov8865>;
> > > +			};
> > > +		};
> > > +	};
> > > +};
> > > +
> > >  &mdio {
> > >  	rgmii_phy: ethernet-phy@1 {
> > >  		compatible = "ethernet-phy-ieee802.3-c22";
> > > @@ -154,6 +225,24 @@ rgmii_phy: ethernet-phy@1 {
> > >  	};
> > >  };
> > >  
> > > +&mipi_csi2 {
> > > +	status = "okay";
> > > +};
> > > +
> > > +&mipi_csi2_in {
> > > +	mipi_csi2_in_ov8865: endpoint {
> > > +		data-lanes = <1 2 3 4>;
> > > +
> > > +		remote-endpoint = <&ov8865_out_mipi_csi2>;
> > > +	};
> > > +};
> > > +
> > > +&mipi_csi2_out {
> > > +	mipi_csi2_out_csi: endpoint {
> > > +		remote-endpoint = <&csi_in_mipi_csi2>;
> > > +	};
> > > +};
> > > +
> > >  &mmc0 {
> > >  	pinctrl-names = "default";
> > >  	pinctrl-0 = <&mmc0_pins>;
> > > @@ -327,11 +416,24 @@ &reg_dldo3 {
> > >  	regulator-name = "vcc-pd";
> > >  };
> > >  
> > > +&reg_dldo4 {
> > > +	regulator-always-on;
> > 
> > Does it have to be always on ?
> 
> Mhh so I realize the regulators handling here is quite messy.
> I guess I didn't do such a good review of this patch internally.
> 
> The situation is that the regulators on the camera board all have their
> enable pin tied to the DLDO4 output, but that would be best described as
> a vin-supply of the ov8865 regulators above. Their real vin supply is an
> always-on board-wide power source but I don't think we can represent another
> regulator acting as enable signal in a better way.

That's right. I've modeled that as a parent regulator in the past, even
if it doesn't reflect the exact hardware topology, it's functionally
equivalent.

> Now beware that the camera board schematics are confusing as they show resistors
> (R17, R18, R19, R20, R23) connecting some power lines together, but they are not
> populated on the board (I guess the point is to make a variant of the design
> without regulators on the camera board and to use ones from the PMU instead).
> This probably confused Kevin and I back when this patch was made.
> 
> > > +	regulator-min-microvolt = <2800000>;
> > > +	regulator-max-microvolt = <2800000>;
> > > +	regulator-name = "avdd-csi";
> > 
> > Doesn't this belong to the base board .dts ? Same below.
> > 
> > > +};
> > > +
> > >  &reg_drivevbus {
> > >  	regulator-name = "usb0-vbus";AVDD-CSI
> > >  	status = "okay";
> > >  };
> > >  
> > > +&reg_eldo1 {
> > > +	regulator-min-microvolt = <1200000>;
> > > +	regulator-max-microvolt = <1200000>;
> > > +	regulator-name = "dvdd-csi-r";
> > > +};
> > > +
> > >  &reg_fldo1 {
> > >  	regulator-min-microvolt = <1080000>;
> > >  	regulator-max-microvolt = <1320000>;

-- 
Regards,

Laurent Pinchart
