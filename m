Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7A94967F4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 23:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbiAUWp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 17:45:27 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:55592 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiAUWp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 17:45:26 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9F37525B;
        Fri, 21 Jan 2022 23:45:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1642805123;
        bh=MTvhs1Ji3raiFOvOg+D9/nZXJCTIHgAe9pLcbHUqokA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vOlt4XVRAgTLlKVZ8KyU5yTSTLG60rdslIJRDihqW7EhDcVE6ayoUEZ/HiQBD5fO6
         MtgAvIhAdtFYrBl/y8FfwSM93KP+NlW2zGer8XRgy+fHJjZaXkaNCYDn6dn6M7hkIH
         RFHQK/2tu80u5DbhwgUQcrkhV5asm/soaBjWlKxY=
Date:   Sat, 22 Jan 2022 00:45:07 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
Cc:     dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        kernel-list@raspberrypi.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, lukasz@jany.st,
        mchehab@kernel.org, naush@raspberrypi.com, robh@kernel.org,
        tomi.valkeinen@ideasonboard.com
Subject: Re: [RFC PATCH v2 5/7] ARM: dts: bcm2711: Add unicam CSI nodes
Message-ID: <Yes3c1v+V1hMlWfW@pendragon.ideasonboard.com>
References: <20220121081810.155500-1-jeanmichel.hautbois@ideasonboard.com>
 <20220121081810.155500-6-jeanmichel.hautbois@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220121081810.155500-6-jeanmichel.hautbois@ideasonboard.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Michel,

Thank you for the patch.

On Fri, Jan 21, 2022 at 09:18:08AM +0100, Jean-Michel Hautbois wrote:
> Add both MIPI CSI-2 nodes in the core bcm2711 tree. Use the 3-cells
> interrupt declaration, corresponding clocks and default as disabled.
> 
> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
> ---
>  arch/arm/boot/dts/bcm2711.dtsi | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711.dtsi
> index dff18fc9a906..077141df7024 100644
> --- a/arch/arm/boot/dts/bcm2711.dtsi
> +++ b/arch/arm/boot/dts/bcm2711.dtsi
> @@ -3,6 +3,7 @@
>  
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/soc/bcm2835-pm.h>
> +#include <dt-bindings/power/raspberrypi-power.h>
>  
>  / {
>  	compatible = "brcm,bcm2711";
> @@ -293,6 +294,36 @@ hvs: hvs@7e400000 {
>  			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>  
> +		csi0: csi1@7e800000 {

The node name should be csi@7e800000, not csi1@7e800000. Now, this will
probably cause issues with the firmware that looks for csi1 (and csi0 ?)
to hand over control of the Unicam CSI-2 receiver to the kernel. I
wonder if this is something that could be handled by a firmware update,
to also recognize nodes named "csi" ?

> +			compatible = "brcm,bcm2835-unicam";
> +			reg = <0x7e800000 0x800>,
> +			      <0x7e802000 0x4>;
> +			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clocks BCM2835_CLOCK_CAM0>,
> +				 <&firmware_clocks 4>;
> +			clock-names = "lp", "vpu";
> +			power-domains = <&power RPI_POWER_DOMAIN_UNICAM0>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			#clock-cells = <1>;

Why do you need #address-cells, #size-cells and #clock-cells ? They're
not mentioned in the binding.

> +			status="disabled";

Missing spaces around the =.

Same comment for the next node.

> +		};
> +
> +		csi1: csi1@7e801000 {
> +			compatible = "brcm,bcm2835-unicam";
> +			reg = <0x7e801000 0x800>,
> +			      <0x7e802004 0x4>;
> +			interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clocks BCM2835_CLOCK_CAM1>,
> +				 <&firmware_clocks 4>;
> +			clock-names = "lp", "vpu";
> +			power-domains = <&power RPI_POWER_DOMAIN_UNICAM1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			#clock-cells = <1>;
> +			status="disabled";
> +		};
> +
>  		pixelvalve3: pixelvalve@7ec12000 {
>  			compatible = "brcm,bcm2711-pixelvalve3";
>  			reg = <0x7ec12000 0x100>;

-- 
Regards,

Laurent Pinchart
