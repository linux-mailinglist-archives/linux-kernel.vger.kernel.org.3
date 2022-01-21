Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9BC7496837
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 00:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiAUX2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 18:28:08 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:55754 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiAUX2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 18:28:07 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 89CB3E51;
        Sat, 22 Jan 2022 00:28:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1642807685;
        bh=WBsVLZLHVoz+Srdhcn8MwEJ8reYksppYcP6TQmVP9AA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r8xmmdsCQ7Y7+7qNuDh5sUuslgpi9UD/ovQS3MS1y1wRuY2/9Z3DNfDBVvi5qeibW
         GLZGLMUeEesIAQFrNWFTAkNBoY9WyhMg5NT8K+OkGHrNLupOoAp7CeH0ToKPTL6dpC
         x2T3Kn5fXCcO4yJ2msyU+1gxm7JHSUBn8ltTrjds=
Date:   Sat, 22 Jan 2022 01:27:49 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
Cc:     dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        kernel-list@raspberrypi.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, lukasz@jany.st,
        mchehab@kernel.org, naush@raspberrypi.com, robh@kernel.org,
        tomi.valkeinen@ideasonboard.com
Subject: Re: [RFC PATCH v2 3/7] media: dt-bindings: media: Add bindings for
 bcm2835-unicam
Message-ID: <YetBdVY57T3QrUNa@pendragon.ideasonboard.com>
References: <20220121081810.155500-1-jeanmichel.hautbois@ideasonboard.com>
 <20220121081810.155500-4-jeanmichel.hautbois@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220121081810.155500-4-jeanmichel.hautbois@ideasonboard.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Michel,

Thank you for the patch.

On Fri, Jan 21, 2022 at 09:18:06AM +0100, Jean-Michel Hautbois wrote:
> Introduce the dt-bindinds documentation for bcm2835 CCP2/CSI2 camera

s/bindinds/bindings/

I'd mention "Unicam" somewhere here.

> interface. Also add a MAINTAINERS entry for it.
> 
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
> ---
> Dave: I assumed you were the maintainer for this file, as I based it on the
> bcm2835-unicam.txt file. Are  you happy to be added directly as the
> maintainer, or should this be specified as "Raspberry Pi Kernel
> Maintenance <kernel-list@raspberrypi.com>"
> - in v2: multiple corrections to pass the bot checking as Rob kindly
>   told me.
> ---
>  .../bindings/media/brcm,bcm2835-unicam.yaml   | 103 ++++++++++++++++++
>  MAINTAINERS                                   |   6 +
>  2 files changed, 109 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml b/Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml
> new file mode 100644
> index 000000000000..1427514142cf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml
> @@ -0,0 +1,103 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/brcm,bcm2835-unicam.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom BCM283x Camera Interface (Unicam)
> +
> +maintainers:
> +  - Dave Stevenson <dave.stevenson@raspberrypi.com>
> +
> +description: |-
> +  The Unicam block on BCM283x SoCs is the receiver for either
> +  CSI-2 or CCP2 data from image sensors or similar devices.
> +
> +  The main platform using this SoC is the Raspberry Pi family of boards.
> +  On the Pi the VideoCore firmware can also control this hardware block,
> +  and driving it from two different processors will cause issues.
> +  To avoid this, the firmware checks the device tree configuration
> +  during boot. If it finds device tree nodes called csi0 or csi1 then
> +  it will stop the firmware accessing the block, and it can then
> +  safely be used via the device tree binding.

As mentioned in the review of the DT integration, the nodes should
ideally be called just "csi", not "csi0" and "csi1" (maybe Rob could
confirm this ?). Dave, is there a way the firmware could be updated to
also hand over control of the Unicam instances to Linux when a "csi"
node is found, not just "csi0" or "csi1" ?

Given that the node names are significant, they should be enforced in
the YAML schema.

> +
> +properties:
> +  compatible:
> +    const: brcm,bcm2835-unicam
> +
> +  reg:
> +    description:
> +      physical base address and length of the register sets for the device.

This can be dropped.

> +    maxItems: 1

There are two items in the example below. How does this validate ?

> +
> +  interrupts:
> +    description: the IRQ line for this Unicam instance.

This can be dropped.

> +    maxItems: 1
> +
> +  clocks:
> +    description: |-
> +      list of clock specifiers, corresponding to entries in clock-names
> +      property.

  clocks:
    items:
      - description: The clock for ...
      - description: The clock for ...

(with the two descriptions matching the LP and VPU clocks, I don't know
what they are).

> +
> +  clock-names:
> +    items:
> +      - const: lp
> +      - const: vpu
> +
> +  port:
> +    $ref: /schemas/graph.yaml#/properties/port
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - port
> +
> +additionalProperties: False
> +
> +examples:
> +  - |
> +    csi1: csi1@7e801000 {
> +        compatible = "brcm,bcm2835-unicam";
> +        reg = <0x7e801000 0x800>,
> +              <0x7e802004 0x4>;
> +        interrupts = <2 7>;

Let's use the Pi 4 device tree as an example, as that's what we're
upstreaming first.

> +        clocks = <&clocks BCM2835_CLOCK_CAM1>,

This will fail to compile without a proper #include, did you get this to
pass validation ?

> +                 <&firmware_clocks 4>;
> +        clock-names = "lp", "vpu";
> +        port {
> +                csi1_ep: endpoint {
> +                        remote-endpoint = <&tc358743_0>;
> +                        data-lanes = <1 2>;
> +                };
> +        };
> +    };
> +
> +    i2c0: i2c@7e205000 {
> +        tc358743: csi-hdmi-bridge@0f {
> +            compatible = "toshiba,tc358743";
> +            reg = <0x0f>;
> +            clocks = <&tc358743_clk>;
> +            clock-names = "refclk";
> +
> +            tc358743_clk: bridge-clk {
> +                    compatible = "fixed-clock";
> +                    #clock-cells = <0>;
> +                    clock-frequency = <27000000>;
> +            };
> +
> +            port {
> +                    tc358743_0: endpoint {
> +                            remote-endpoint = <&csi1_ep>;
> +                            clock-lanes = <0>;
> +                            data-lanes = <1 2>;
> +                            clock-noncontinuous;
> +                            link-frequencies =
> +                                /bits/ 64 <297000000>;
> +                    };
> +            };
> +        };
> +    };

I'd drop this node completely.

> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 33f75892f98e..07f238fd5ff9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3679,6 +3679,12 @@ F:	Documentation/media/v4l-drivers/bcm2835-isp.rst
>  F:	drivers/staging/vc04_services/bcm2835-isp
>  F:	include/uapi/linux/bcm2835-isp.h
>  
> +BROADCOM BCM2835 CAMERA DRIVER
> +M:	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
> +L:	linux-media@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml
> +
>  BROADCOM BCM47XX MIPS ARCHITECTURE
>  M:	Hauke Mehrtens <hauke@hauke-m.de>
>  M:	Rafał Miłecki <zajec5@gmail.com>

-- 
Regards,

Laurent Pinchart
