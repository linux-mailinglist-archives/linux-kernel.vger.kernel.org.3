Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9F648CB10
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 19:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356252AbiALSea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 13:34:30 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:48366 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348741AbiALSe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 13:34:28 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2032F340;
        Wed, 12 Jan 2022 19:34:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1642012465;
        bh=r0JlbAYka/rfL4R9AwfiOnTQOM0NQ/mYi/0TwwUzfuE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q6ibHjl0CEbwGjQqAlh/Ct+/eQTsXadkNhaaZcHF3g4/Tl+/zAoXXHrDLOMA3uCE6
         fDyQNuE8mBD32JGW+ohEkPt0TIj/88wTBETJonWza1+YKF+bMRbnKa271iDF5tjNTO
         /R4pK3EEZktgvQ6Py/WimWengz5xPVTKip0tHttA=
Date:   Wed, 12 Jan 2022 20:34:13 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, kernel-list@raspberrypi.com,
        mchehab@kernel.org, dave.stevenson@raspberrypi.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        naush@raspberrypi.com, lukasz@jany.st, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] media: dt-bindings: media: Add bindings for
 bcm2835-unicam
Message-ID: <Yd8fJd2SASGkhOjm@pendragon.ideasonboard.com>
References: <20220112172719.1178446-1-jeanmichel.hautbois@ideasonboard.com>
 <20220112172719.1178446-2-jeanmichel.hautbois@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220112172719.1178446-2-jeanmichel.hautbois@ideasonboard.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Michel,

Thank you for the patch.

On Wed, Jan 12, 2022 at 06:27:18PM +0100, Jean-Michel Hautbois wrote:
> Introduce the dt-bindinds documentation for bcm2835 CCP2/CSI2 camera
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
> +
> +properties:
> +  compatible:
> +    const: brcm,bcm2835-unicam
> +
> +  reg:
> +    description:
> +      physical base address and length of the register sets for the device.

You can drop the description, that's the default for the reg property.

> +    maxItems: 1
> +
> +  interrupts:
> +    description: the IRQ line for this Unicam instance.

Same here.

> +    maxItems: 1
> +
> +  clocks:
> +    description: |-
> +      list of clock specifiers, corresponding to entries in clock-names
> +      property.

Same here, but a description of each entry would be useful.

  clocks:
    items:
      - description: Clock for foo.
      - description: Clock for bar.

> +
> +  clock-names:
> +    items:
> +      - const: lp
> +      - const: vpu
> +
> +  port:
> +    $ref: /schemas/graph.yaml#/properties/port

You need to use port-base and list the valid endpoint properties.

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

s/False/false/

> +
> +examples:
> +  - |

Does this validate without #include'ing headers that define the
BCM2835_CLOCK_CAM1 macro ?

> +    csi1: csi1@7e801000 {

You can drop the label.

> +        compatible = "brcm,bcm2835-unicam";
> +        reg = <0x7e801000 0x800>,
> +              <0x7e802004 0x4>;

That's two items, while the bindings document one item only. Please run
the DT bindings validation, it will validate the examples.

> +        interrupts = <2 7>;

On RPi 4 don't we need 3 interrupt cells ?

> +        clocks = <&clocks BCM2835_CLOCK_CAM1>,
> +                 <&firmware_clocks 4>;
> +        clock-names = "lp", "vpu";

A blank line would be good here.

> +        port {
> +                csi1_ep: endpoint {

Inconsistent indentation. Same below.

> +                        remote-endpoint = <&tc358743_0>;
> +                        data-lanes = <1 2>;
> +                };
> +        };
> +    };
> +
> +    i2c0: i2c@7e205000 {
> +        tc358743: csi-hdmi-bridge@0f {

You can drop those two labels.

> +            compatible = "toshiba,tc358743";

This isn't documented upstream in yaml. How about using an imx219 sensor
instead ?

> +            reg = <0x0f>;
> +            clocks = <&tc358743_clk>;
> +            clock-names = "refclk";
> +
> +            tc358743_clk: bridge-clk {
> +                    compatible = "fixed-clock";
> +                    #clock-cells = <0>;
> +                    clock-frequency = <27000000>;
> +            };

You can drop this, there's no need to declare the clock in the example.

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
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 269aa4d6b94a..7484255cad31 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3653,6 +3653,12 @@ N:	bcm113*
>  N:	bcm216*
>  N:	kona
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
