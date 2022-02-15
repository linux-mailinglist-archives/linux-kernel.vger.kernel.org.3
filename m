Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC74A4B6CFD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 14:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238079AbiBONGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 08:06:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238071AbiBONGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 08:06:03 -0500
X-Greylist: delayed 335 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Feb 2022 05:05:49 PST
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8C1A2503;
        Tue, 15 Feb 2022 05:05:49 -0800 (PST)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 1F9F720007;
        Tue, 15 Feb 2022 13:05:42 +0000 (UTC)
Date:   Tue, 15 Feb 2022 14:06:51 +0100
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [RFC PATCH v2 2/4] media: dt-bindings: media: Document RZ/G2L CRU
Message-ID: <20220215130651.hh3zb7ogl756pigt@uno.localdomain>
References: <20220121010543.31385-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220121010543.31385-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220121010543.31385-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Fri, Jan 21, 2022 at 01:05:41AM +0000, Lad Prabhakar wrote:
> Document the CRU block found on Renesas RZ/G2L SoC's.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2
> * Dropped CSI
> ---
>  .../bindings/media/renesas,rzg2l-cru.yaml     | 152 ++++++++++++++++++
>  1 file changed, 152 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
>
> diff --git a/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml b/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
> new file mode 100644
> index 000000000000..a03fc6ef0117
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
> @@ -0,0 +1,152 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (C) 2022 Renesas Electronics Corp.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/renesas,rzg2l-cru.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas RZ/G2L Camera Data Receiving Unit (CRU)
> +
> +maintainers:
> +  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> +
> +description:
> +  The RZ/G2L Camera Data Receiving Unit (CRU) device provides video input
> +  capabilities for the Renesas RZ/G2L family of devices.
> +
> +  Depending on the instance the Image Processing input is connected to
> +  external SoC pins or to a CSI-2 receiver.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - renesas,r9a07g044-cru     # RZ/G2{L,LC}
> +          - const: renesas,rzg2l-cru
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 3
> +
> +  interrupt-names:
> +    items:
> +      - const: image_conv
> +      - const: image_conv_err
> +      - const: axi_mst_err
> +
> +  clocks:
> +    items:
> +      - description: CRU Main clock
> +      - description: CPU Register access clock
> +      - description: CRU image transfer clock
> +
> +  clock-names:
> +    items:
> +      - const: vclk
> +      - const: pclk
> +      - const: aclk
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  resets:
> +    items:
> +      - description: CRU_PRESETN reset terminal
> +      - description: CRU_ARESETN reset terminal
> +
> +  reset-names:
> +    items:
> +      - const: presetn
> +      - const: aresetn
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description:
> +          Input port node, single endpoint describing a parallel input source.
> +
> +        properties:
> +          endpoint:
> +            $ref: video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +            properties:
> +              hsync-active: true
> +              vsync-active: true
> +              bus-width: true
> +              data-shift: true
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          Output port node, describing the RZ/G2L Image Processing module
> +          connected the CSI-2 receiver

Isn't this the port dedicated to the CSI-2 receiver input ?

> +
> +        properties:
> +          endpoint@0:
> +            $ref: /schemas/graph.yaml#/properties/endpoint
> +            description: Endpoint connected to CSI2.

And the andpoint should describe the connection between the CRU and
the CSI-2 receiver ? (ie it should not contain CSI-2 specific
properties, as those are specified by the CSI-2 receiver device node?)

Thanks
  j
> +
> +        anyOf:
> +          - required:
> +              - endpoint@0
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-names
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +  - power-domains
> +
> +additionalProperties: false
> +
> +examples:
> +  # Device node example with CSI-2
> +  - |
> +    #include <dt-bindings/clock/r9a07g044-cpg.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    cru: video@10830000 {
> +            compatible = "renesas,r9a07g044-cru", "renesas,rzg2l-cru";
> +            reg = <0x10830000 0x400>;
> +            interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "image_conv", "image_conv_err", "axi_mst_err";
> +            clocks = <&cpg CPG_MOD R9A07G044_CRU_VCLK>,
> +                     <&cpg CPG_MOD R9A07G044_CRU_PCLK>,
> +                     <&cpg CPG_MOD R9A07G044_CRU_ACLK>;
> +            clock-names = "vclk", "pclk", "aclk";
> +            power-domains = <&cpg>;
> +            resets = <&cpg R9A07G044_CRU_PRESETN>,
> +                     <&cpg R9A07G044_CRU_ARESETN>;
> +            reset-names = "presetn", "aresetn";
> +
> +            ports {
> +                    #address-cells = <1>;
> +                    #size-cells = <0>;
> +
> +                    port@1 {
> +                            #address-cells = <1>;
> +                            #size-cells = <0>;
> +
> +                            reg = <1>;
> +
> +                            crucsi2: endpoint@0 {
> +                                    reg = <0>;
> +                                    remote-endpoint= <&csi2cru>;
> +                            };
> +                    };
> +            };
> +    };
> --
> 2.17.1
>
