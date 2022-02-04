Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B5D4A926F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 03:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356695AbiBDCuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 21:50:19 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:38916 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234466AbiBDCuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 21:50:18 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 976F0472;
        Fri,  4 Feb 2022 03:50:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1643943016;
        bh=4D9ZUdocc/EvxfG/j/v8Qw9znRFvN1wAeoIDVJJr1Hs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gIWc56z7y+aAvfH2+NClaH/QHsYVIFWnYOeV/ZkdaLgXkogya7SqtwQNBaX6uJUdY
         WXmlOKXilN9DhB00z+/439V+yWnfzxmhfFrwVTAVnIoST8del9eFovBnnx6xv4eOAD
         PAeThU+SA8Wc8nClnTQwFTRu7okINpXclBOGUAaI=
Date:   Fri, 4 Feb 2022 04:49:52 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
Cc:     dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        kernel-list@raspberrypi.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, lukasz@jany.st,
        mchehab@kernel.org, naush@raspberrypi.com, robh@kernel.org,
        tomi.valkeinen@ideasonboard.com, nsaenz@kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [RFC PATCH v4 12/12] media: bcm283x: Include the imx219 node
Message-ID: <YfyUUCaC65H8Yofj@pendragon.ideasonboard.com>
References: <20220203175009.558868-1-jeanmichel.hautbois@ideasonboard.com>
 <20220203175009.558868-13-jeanmichel.hautbois@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220203175009.558868-13-jeanmichel.hautbois@ideasonboard.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Michel,

Thank you for the patch.

On Thu, Feb 03, 2022 at 06:50:09PM +0100, Jean-Michel Hautbois wrote:
> WARNING:
> This patch is only used to demonstrate how the imx219 node is included
> in the bcm2711-rpi-4-b device tree, and is not intended to be merged.

You can add a [DNI] (it stands for Do Not Integrate) tag at the
beginning of the subject line to indicate this.

> Configure the csi1 endpoint, add the imx219 node and connect it through
> the i2c mux.
> 
> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
> ---
>  arch/arm/boot/dts/bcm2711-rpi-4-b.dts     |   1 +
>  arch/arm/boot/dts/bcm283x-rpi-imx219.dtsi | 102 ++++++++++++++++++++++
>  2 files changed, 103 insertions(+)
>  create mode 100644 arch/arm/boot/dts/bcm283x-rpi-imx219.dtsi
> 
> diff --git a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
> index 4432412044de..f7625b70fe57 100644
> --- a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
> +++ b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
> @@ -4,6 +4,7 @@
>  #include "bcm2711-rpi.dtsi"
>  #include "bcm283x-rpi-usb-peripheral.dtsi"
>  #include "bcm283x-rpi-wifi-bt.dtsi"
> +#include "bcm283x-rpi-imx219.dtsi"

Drop this, and turn arch/arm/boot/dts/bcm283x-rpi-imx219.dtsi into an
overlay. That can be merged in mainline. It can be done separately from
this series too.

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

You also need a header for GPIO_ACTIVE_HIGH.

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
> +
> +	i2c0mux {
> +		compatible = "i2c-mux-pinctrl";

The mux shouldn't be part of this overlay, this has been discussed
separately.

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

Missing spaces around =.

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
