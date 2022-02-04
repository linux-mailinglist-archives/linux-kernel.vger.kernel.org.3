Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FCC4A926A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 03:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356680AbiBDCpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 21:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238546AbiBDCpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 21:45:53 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A399C06173B;
        Thu,  3 Feb 2022 18:45:53 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D2369472;
        Fri,  4 Feb 2022 03:45:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1643942752;
        bh=Ww77pEJ0JD3MpMT6SOSp/Bw7CEXi4obbTVPJFpoonWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vu2xr+V4VxG3ZYXvNabAXdesaMQOJdYiECyhJ4w1PlYwy8DTR55jQhgmN9VpTJMeC
         PZPULzEz52n3x6W2DqLPhMQHEQCkz6hYxMCjxsA679rKgGoagcr8g1cGQ+me72qB2G
         Q7RkAHvii6MBYkGT7T8MT6FSpkWtuUpdOdSUeKic=
Date:   Fri, 4 Feb 2022 04:45:28 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
Cc:     dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        kernel-list@raspberrypi.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, lukasz@jany.st,
        mchehab@kernel.org, naush@raspberrypi.com, robh@kernel.org,
        tomi.valkeinen@ideasonboard.com, nsaenz@kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [RFC PATCH v4 06/12] ARM: dts: bcm2711: Add unicam CSI nodes
Message-ID: <YfyTSPMwxbYAjFBn@pendragon.ideasonboard.com>
References: <20220203175009.558868-1-jeanmichel.hautbois@ideasonboard.com>
 <20220203175009.558868-7-jeanmichel.hautbois@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220203175009.558868-7-jeanmichel.hautbois@ideasonboard.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Michel,

Thank you for the patch.

On Thu, Feb 03, 2022 at 06:50:03PM +0100, Jean-Michel Hautbois wrote:
> Add both MIPI CSI-2 nodes in the core bcm2711 tree. Use the 3-cells
> interrupt declaration, corresponding clocks and default as disabled.
> 
> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
> ---
>  arch/arm/boot/dts/bcm2711-rpi.dtsi | 15 +++++++++++++++
>  arch/arm/boot/dts/bcm2711.dtsi     | 16 ++++++++++++++++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/bcm2711-rpi.dtsi b/arch/arm/boot/dts/bcm2711-rpi.dtsi
> index ca266c5d9f9b..97ee494891af 100644
> --- a/arch/arm/boot/dts/bcm2711-rpi.dtsi
> +++ b/arch/arm/boot/dts/bcm2711-rpi.dtsi
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include "bcm2835-rpi.dtsi"
>  
> +#include <dt-bindings/power/raspberrypi-power.h>
>  #include <dt-bindings/reset/raspberrypi,firmware-reset.h>
>  
>  / {
> @@ -18,6 +19,20 @@ aliases {
>  	};
>  };
>  
> +&csi0 {
> +	clocks = <&clocks BCM2835_CLOCK_CAM0>,
> +		 <&firmware_clocks 4>;
> +	clock-names = "lp", "vpu";
> +	power-domains = <&power RPI_POWER_DOMAIN_UNICAM0>;
> +};
> +
> +&csi1 {
> +	clocks = <&clocks BCM2835_CLOCK_CAM1>,
> +		 <&firmware_clocks 4>;
> +	clock-names = "lp", "vpu";
> +	power-domains = <&power RPI_POWER_DOMAIN_UNICAM1>;
> +};
> +
>  &firmware {
>  	firmware_clocks: clocks {
>  		compatible = "raspberrypi,firmware-clocks";
> diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711.dtsi
> index dff18fc9a906..312a74601839 100644
> --- a/arch/arm/boot/dts/bcm2711.dtsi
> +++ b/arch/arm/boot/dts/bcm2711.dtsi
> @@ -293,6 +293,22 @@ hvs: hvs@7e400000 {
>  			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>  
> +		csi0: csi@7e800000 {
> +			compatible = "brcm,bcm2835-unicam";
> +			reg = <0x7e800000 0x800>,
> +			      <0x7e802000 0x4>;

You should add reg-names here.

> +			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";

And I'd add
			port {
			};

too, as it's listed as required in the bindings.

The two comments apply to csi1 too.

With these fixed,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +		};
> +
> +		csi1: csi@7e801000 {
> +			compatible = "brcm,bcm2835-unicam";
> +			reg = <0x7e801000 0x800>,
> +			      <0x7e802004 0x4>;
> +			interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
> +
>  		pixelvalve3: pixelvalve@7ec12000 {
>  			compatible = "brcm,bcm2711-pixelvalve3";
>  			reg = <0x7ec12000 0x100>;

-- 
Regards,

Laurent Pinchart
