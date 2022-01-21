Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF2349683B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 00:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiAUXaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 18:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiAUXai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 18:30:38 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB910C06173B;
        Fri, 21 Jan 2022 15:30:37 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DEDB2E51;
        Sat, 22 Jan 2022 00:30:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1642807834;
        bh=KQ0Hr6Z8amphyQBRIxQGNR2EMiK2F+TIpQNXyIvXSnU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JIimzzy/LjjhsE3p8veM0Sm4rXiTtpXNGJLkP1CAs50k152YuJNikpAe1c3lwISU+
         JFi3wApfsc1aACQDKyg0HF2Xo179226KiFpwY7XCmcsiZtFbJzRvrQFxxj0Ovf0QqD
         I3z3PxeANtDBd75h0bAWq5UupifCqpAvsM6MN+eM=
Date:   Sat, 22 Jan 2022 01:30:17 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
Cc:     dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        kernel-list@raspberrypi.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, lukasz@jany.st,
        mchehab@kernel.org, naush@raspberrypi.com, robh@kernel.org,
        tomi.valkeinen@ideasonboard.com
Subject: Re: [RFC PATCH v2 7/7] media: bcm283x: Include the imx219 node
Message-ID: <YetCCUFd1F0yTJgU@pendragon.ideasonboard.com>
References: <20220121081810.155500-1-jeanmichel.hautbois@ideasonboard.com>
 <20220121081810.155500-8-jeanmichel.hautbois@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220121081810.155500-8-jeanmichel.hautbois@ideasonboard.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Michel,

Thank you for the patch.

On Fri, Jan 21, 2022 at 09:18:10AM +0100, Jean-Michel Hautbois wrote:
> Configure the csi1 endpoint, add the imx219 node and connect it through
> the i2c mux.

This is not meant to be upstreamed, is it ? Please say so very loudly in
the commit message.

> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
> ---
>  MAINTAINERS                               |   1 +
>  arch/arm/boot/dts/bcm2711-rpi-4-b.dts     |   1 +
>  arch/arm/boot/dts/bcm283x-rpi-imx219.dtsi | 102 ++++++++++++++++++++++
>  3 files changed, 104 insertions(+)
>  create mode 100644 arch/arm/boot/dts/bcm283x-rpi-imx219.dtsi
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b17bb533e007..56544ac98d69 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3684,6 +3684,7 @@ M:	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
>  L:	linux-media@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml
> +F:	arch/arm/boot/dts/bcm283x*
>  F:	drivers/media/platform/bcm2835/
>  
>  BROADCOM BCM47XX MIPS ARCHITECTURE
> diff --git a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
> index 4432412044de..f7625b70fe57 100644
> --- a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
> +++ b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
> @@ -4,6 +4,7 @@
>  #include "bcm2711-rpi.dtsi"
>  #include "bcm283x-rpi-usb-peripheral.dtsi"
>  #include "bcm283x-rpi-wifi-bt.dtsi"
> +#include "bcm283x-rpi-imx219.dtsi"

Let's use an overlay instead.

>  
>  / {
>  	compatible = "raspberrypi,4-model-b", "brcm,bcm2711";
> diff --git a/arch/arm/boot/dts/bcm283x-rpi-imx219.dtsi b/arch/arm/boot/dts/bcm283x-rpi-imx219.dtsi
> new file mode 100644
> index 000000000000..f2c6a85fd731
> --- /dev/null
> +++ b/arch/arm/boot/dts/bcm283x-rpi-imx219.dtsi
> @@ -0,0 +1,102 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <dt-bindings/clock/bcm2835.h>
> +
> +/ {
> +	compatible = "brcm,bcm2835";
> +
> +	imx219_vdig: fixedregulator@1 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "imx219_vdig";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +	};
> +
> +	imx219_vddl: fixedregulator@2 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "imx219_vddl";
> +		regulator-min-microvolt = <1200000>;
> +		regulator-max-microvolt = <1200000>;
> +	};
> +
> +	imx219_clk: imx219_clk {
> +		#clock-cells = <0>;
> +		compatible = "fixed-clock";
> +		clock-frequency = <24000000>;
> +		clock-output-names = "24MHz-clock";
> +	};
> +
> +	cam1_reg: cam1_reg {
> +		compatible = "regulator-fixed";
> +		regulator-name = "imx219_vana";
> +		enable-active-high;
> +		status = "okay";
> +		gpio = <&expgpio 5 GPIO_ACTIVE_HIGH>;
> +	};

This regulator belongs to the board dtsi. Same for the I2C mux below
(but not the imx219 of course).

> +
> +	i2c0mux {
> +		compatible = "i2c-mux-pinctrl";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		i2c-parent = <&i2c0>;
> +
> +		pinctrl-names = "i2c0", "i2c_csi_dsi";
> +		pinctrl-0 = <&i2c0_gpio0>;
> +		pinctrl-1 = <&i2c0_gpio44>;
> +
> +		i2c@0 {
> +			reg = <0>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		i2c@1 {
> +			reg = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			imx219: sensor@10 {
> +				compatible = "sony,imx219";
> +				reg = <0x10>;
> +				status = "okay";
> +
> +				clocks = <&imx219_clk>;
> +				clock-names = "xclk";
> +
> +				VANA-supply = <&cam1_reg>;   /* 2.8v */
> +				VDIG-supply = <&imx219_vdig>;   /* 1.8v */
> +				VDDL-supply = <&imx219_vddl>;   /* 1.2v */
> +
> +				rotation = <0>;
> +				orientation = <0>;
> +
> +				port {
> +					imx219_0: endpoint {
> +						remote-endpoint = <&csi1_ep>;
> +						clock-lanes = <0>;
> +						data-lanes = <1 2>;
> +						clock-noncontinuous;
> +						link-frequencies = /bits/ 64 <456000000>;
> +					};
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&csi1 {
> +	status="okay";
> +	num-data-lanes = <2>;
> +	port {
> +		csi1_ep: endpoint {
> +			remote-endpoint = <&imx219_0>;
> +			data-lanes = <1 2>;
> +			clock-lanes = <0>;
> +		};
> +	};
> +};
> +
> +&i2c0 {
> +	/delete-property/ pinctrl-names;
> +	/delete-property/ pinctrl-0;
> +};
> +

-- 
Regards,

Laurent Pinchart
