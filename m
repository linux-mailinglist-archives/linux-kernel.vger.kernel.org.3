Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26675A2FA7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 21:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344764AbiHZTIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 15:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiHZTIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 15:08:13 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC823DC5D3;
        Fri, 26 Aug 2022 12:08:12 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 16817547;
        Fri, 26 Aug 2022 21:08:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1661540891;
        bh=3x5c84ET66BZj+Rj//NkR71TpQss27e3h7UwwnNl6YA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GkRyHFtwQwQHvovGaGdQVI2oadFmuvach8EPNPJ20on2n6dEdOZNzZja/xZoOibm4
         C6uC6mAOX/hxsOp8njVgUgO9Yq0L+5oSAYAVBFTz35thZRW9bfoVTZBF3gAv7IYxc7
         IMpr7/u/ar6ar3IcH6YEgxP9ZUQ833aS3rCG2jd4=
Date:   Fri, 26 Aug 2022 22:08:04 +0300
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
Message-ID: <YwkaFC2tm96X5qon@pendragon.ideasonboard.com>
References: <20220826182803.604563-1-paul.kocialkowski@bootlin.com>
 <20220826182803.604563-7-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220826182803.604563-7-paul.kocialkowski@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul and Kévin,

Thank you for the patch.

On Fri, Aug 26, 2022 at 08:28:03PM +0200, Paul Kocialkowski wrote:
> From: Kévin L'hôpital <kevin.lhopital@bootlin.com>
> 
> The Bananapi M3 supports a camera module which includes an OV8865 sensor
> connected via the parallel CSI interface and an OV8865 sensor connected
> via MIPI CSI-2.
> 
> The I2C2 bus is shared by the two sensors as well as the (active-low)
> reset signal, but each sensor has it own shutdown line.

I see a single sensor in this file, am I missing something ?

Sounds like a perfect candidate for an overlay, it could then be merged
upstream.

> Signed-off-by: Kévin L'hôpital <kevin.lhopital@bootlin.com>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts | 102 +++++++++++++++++++
>  1 file changed, 102 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
> index 5a7e1bd5f825..80fd99cf24b2 100644
> --- a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
> +++ b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
> @@ -85,6 +85,30 @@ led-1 {
>  		};
>  	};
>  
> +	reg_ov8865_avdd: ov8865-avdd {
> +		compatible = "regulator-fixed";
> +		regulator-name = "ov8865-avdd";
> +		regulator-min-microvolt = <2800000>;
> +		regulator-max-microvolt = <2800000>;
> +		vin-supply = <&reg_dldo4>;
> +	};
> +
> +	reg_ov8865_dovdd: ov8865-dovdd {
> +		compatible = "regulator-fixed";
> +		regulator-name = "ov8865-dovdd";
> +		regulator-min-microvolt = <2800000>;
> +		regulator-max-microvolt = <2800000>;
> +		vin-supply = <&reg_dldo4>;
> +	};
> +
> +	reg_ov8865_dvdd: ov8865-dvdd {
> +		compatible = "regulator-fixed";
> +		regulator-name = "ov8865-dvdd";
> +		regulator-min-microvolt = <1200000>;
> +		regulator-max-microvolt = <1200000>;
> +		vin-supply = <&reg_eldo1>;
> +	};

Are those three regulators on the Banana Pi, or on the camera module ?

> +
>  	reg_usb1_vbus: reg-usb1-vbus {
>  		compatible = "regulator-fixed";
>  		regulator-name = "usb1-vbus";
> @@ -115,6 +139,23 @@ &cpu100 {
>  	cpu-supply = <&reg_dcdc3>;
>  };
>  
> +&csi {
> +	status = "okay";
> +
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		port@1 {
> +			reg = <1>;

All of this (except the status = "okay") should go to sun8i-a83t.dtsi.

> +
> +			csi_in_mipi_csi2: endpoint {
> +				remote-endpoint = <&mipi_csi2_out_csi>;
> +			};

This too actually, once the issue mentioned in patch 5/6 gets fixed.

> +		};
> +	};
> +};
> +
>  &de {
>  	status = "okay";
>  };
> @@ -147,6 +188,36 @@ hdmi_out_con: endpoint {
>  	};
>  };
>  
> +&i2c2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c2_pe_pins>;

This looks like a candidate for upstreaming in
sun8i-a83t-bananapi-m3.dts, it shouldn't be in the overlay.

> +	status = "okay";
> +
> +	ov8865: camera@36 {
> +		compatible = "ovti,ov8865";
> +		reg = <0x36>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&csi_mclk_pin>;
> +		clocks = <&ccu CLK_CSI_MCLK>;
> +		assigned-clocks = <&ccu CLK_CSI_MCLK>;
> +		assigned-clock-rates = <24000000>;
> +		avdd-supply = <&reg_ov8865_avdd>;
> +		dovdd-supply = <&reg_ov8865_dovdd>;
> +		dvdd-supply = <&reg_ov8865_dvdd>;
> +		powerdown-gpios = <&pio 4 17 GPIO_ACTIVE_LOW>; /* PE17 */
> +		reset-gpios = <&pio 4 16 GPIO_ACTIVE_LOW>; /* PE16 */
> +
> +		port {
> +			ov8865_out_mipi_csi2: endpoint {
> +				data-lanes = <1 2 3 4>;
> +				link-frequencies = /bits/ 64 <360000000>;
> +
> +				remote-endpoint = <&mipi_csi2_in_ov8865>;
> +			};
> +		};
> +	};
> +};
> +
>  &mdio {
>  	rgmii_phy: ethernet-phy@1 {
>  		compatible = "ethernet-phy-ieee802.3-c22";
> @@ -154,6 +225,24 @@ rgmii_phy: ethernet-phy@1 {
>  	};
>  };
>  
> +&mipi_csi2 {
> +	status = "okay";
> +};
> +
> +&mipi_csi2_in {
> +	mipi_csi2_in_ov8865: endpoint {
> +		data-lanes = <1 2 3 4>;
> +
> +		remote-endpoint = <&ov8865_out_mipi_csi2>;
> +	};
> +};
> +
> +&mipi_csi2_out {
> +	mipi_csi2_out_csi: endpoint {
> +		remote-endpoint = <&csi_in_mipi_csi2>;
> +	};
> +};
> +
>  &mmc0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&mmc0_pins>;
> @@ -327,11 +416,24 @@ &reg_dldo3 {
>  	regulator-name = "vcc-pd";
>  };
>  
> +&reg_dldo4 {
> +	regulator-always-on;

Does it have to be always on ?

> +	regulator-min-microvolt = <2800000>;
> +	regulator-max-microvolt = <2800000>;
> +	regulator-name = "avdd-csi";

Doesn't this belong to the base board .dts ? Same below.

> +};
> +
>  &reg_drivevbus {
>  	regulator-name = "usb0-vbus";
>  	status = "okay";
>  };
>  
> +&reg_eldo1 {
> +	regulator-min-microvolt = <1200000>;
> +	regulator-max-microvolt = <1200000>;
> +	regulator-name = "dvdd-csi-r";
> +};
> +
>  &reg_fldo1 {
>  	regulator-min-microvolt = <1080000>;
>  	regulator-max-microvolt = <1320000>;

-- 
Regards,

Laurent Pinchart
