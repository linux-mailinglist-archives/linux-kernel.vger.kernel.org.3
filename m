Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5BE4A9262
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 03:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356665AbiBDCnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 21:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbiBDCnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 21:43:02 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11BEC061714;
        Thu,  3 Feb 2022 18:43:02 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C419B472;
        Fri,  4 Feb 2022 03:42:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1643942580;
        bh=0ZU9+PU+RLMnbfCx5GO4SHCpwrlVZ8Gy4RJmr7f64sI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PbzZp0FWWADNGqYU2WhqKo1CKUHUBBQ1hc+6kkrpYg9QCM00OFXKuzv3lzyz2jJes
         3Te8rgh2xTTuyl/gxldI/yGYRNkzvjW8qPSkz/r+Qa7THrwvB0odHymuQUxyJFkvev
         hjnek+DfCXHRcNqzkXUfXXaHF8b4P/ppiVVqaQFk=
Date:   Fri, 4 Feb 2022 04:42:35 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
Cc:     dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        kernel-list@raspberrypi.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, lukasz@jany.st,
        mchehab@kernel.org, naush@raspberrypi.com, robh@kernel.org,
        tomi.valkeinen@ideasonboard.com, nsaenz@kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [RFC PATCH v4 03/12] dt-bindings: media: Add bindings for
 bcm2835-unicam
Message-ID: <YfySmx/unIvHolh3@pendragon.ideasonboard.com>
References: <20220203175009.558868-1-jeanmichel.hautbois@ideasonboard.com>
 <20220203175009.558868-4-jeanmichel.hautbois@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220203175009.558868-4-jeanmichel.hautbois@ideasonboard.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Michel,

Thank you for the patch.

On Thu, Feb 03, 2022 at 06:50:00PM +0100, Jean-Michel Hautbois wrote:
> Introduce the dt-bindings documentation for bcm2835 CCP2/CSI2 Unicam
> camera interface. Also add a MAINTAINERS entry for it.

You can drop the last sentence now that the MAINTAINERS entry has been
moved out.

> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
> 
> ---
> v4:
> - make MAINTAINERS its own patch
> - describe the reg and clocks correctly
> - use a vendor entry for the number of data lanes
> ---
>  .../bindings/media/brcm,bcm2835-unicam.yaml   | 110 ++++++++++++++++++
>  1 file changed, 110 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml b/Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml
> new file mode 100644
> index 000000000000..0725a0267c60
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml
> @@ -0,0 +1,110 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/brcm,bcm2835-unicam.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom BCM283x Camera Interface (Unicam)
> +
> +maintainers:
> +  - Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
> +
> +description: |-
> +  The Unicam block on BCM283x SoCs is the receiver for either
> +  CSI-2 or CCP2 data from image sensors or similar devices.
> +
> +  The main platform using this SoC is the Raspberry Pi family of boards.
> +  On the Pi the VideoCore firmware can also control this hardware block,
> +  and driving it from two different processors will cause issues.
> +  To avoid this, the firmware checks the device tree configuration
> +  during boot. If it finds device tree nodes starting by csi then

"[...] device tree nodes whose name starts with 'csi' then [...]"

> +  it will stop the firmware accessing the block, and it can then
> +  safely be used via the device tree binding.
> +
> +properties:
> +  compatible:
> +    const: brcm,bcm2835-unicam
> +
> +  reg:
> +    items:
> +      - description: Unicam block.
> +      - description: Clock Manager Image (CMI) block.

As Stefan pointed out, you need

  reg-names:
    items:
      - const: main
      - const: cmi

Alternatives for main could be core or unicam. Dave, do you have a
preference ?

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Clock to drive the LP state machine of Unicam.
> +      - description: Clock for the vpu (core clock).

s/vpu/VPU/

> +
> +  clock-names:
> +    items:
> +      - const: lp
> +      - const: vpu
> +
> +  power-domains:
> +    items:
> +      - description: Unicam power domain
> +
> +  brcm,num-data-lanes:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 2, 4 ]
> +    description: Number of data lanes on the csi bus

I'd write

    description: |
      Number of CSI-2 data lanes supported by this Unicam instance. The number
      of data lanes actively used is specified with the data-lanes endpoint
      property.

> +
> +  port:
> +    additionalProperties: false

Shouldn't this be unevaluatedProperties ?

I would also put it after the $ref line.

> +    $ref: /schemas/graph.yaml#/$defs/port-base
> +
> +    properties:
> +      endpoint:
> +        $ref: /schemas/media/video-interfaces.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          data-lanes: true
> +          link-frequencies: true

link-frequencies is specified on the sensor side, not here. You can drop
it.

> +
> +        required:
> +          - data-lanes
> +          - link-frequencies
> +
> +    required:
> +      - endpoint
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - power-domains
> +  - brcm,num-data-lanes
> +  - port
> +
> +additionalProperties: False
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/bcm2835.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/power/raspberrypi-power.h>
> +    csi1: csi@7e801000 {
> +        compatible = "brcm,bcm2835-unicam";
> +        reg = <0x7e801000 0x800>,
> +              <0x7e802004 0x4>;
> +        interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&clocks BCM2835_CLOCK_CAM1>,
> +                 <&firmware_clocks 4>;
> +        clock-names = "lp", "vpu";
> +        power-domains = <&power RPI_POWER_DOMAIN_UNICAM1>;
> +        brcm,num-data-lanes = <2>;
> +        port {
> +                csi1_ep: endpoint {

Wrong indentation.

> +                        remote-endpoint = <&imx219_0>;
> +                        data-lanes = <1 2>;
> +                        link-frequencies = /bits/ 64 <456000000>;

Drop link-frequencies here too.

With these small issues fixed,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +                };
> +        };
> +    };
> +...

-- 
Regards,

Laurent Pinchart
