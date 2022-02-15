Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60704B6CE2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 14:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238038AbiBONAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 08:00:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238044AbiBONA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 08:00:29 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D4480214
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 05:00:18 -0800 (PST)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 2FA58240019;
        Tue, 15 Feb 2022 13:00:07 +0000 (UTC)
Date:   Tue, 15 Feb 2022 14:01:16 +0100
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
Subject: Re: [RFC PATCH v2 1/4] media: dt-bindings: media: Document RZ/G2L
 CSI-2 block
Message-ID: <20220215130116.fmqhoakn5fl4aout@uno.localdomain>
References: <20220121010543.31385-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220121010543.31385-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220121010543.31385-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar

On Fri, Jan 21, 2022 at 01:05:40AM +0000, Lad Prabhakar wrote:
> Document the CSI-2 block which is part of CRU found in Renesas
> RZ/G2L SoC.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> Hi Geert/All,
>
> vclk and pclk clocks are shared with CRU both CSI and CRU driver are using
> pm_runtime. pclk clock is necessary for register access where as vclk clock
> is only used for calculations. So would you suggest passing vclk as part of
> clocks (as currently implemented) or pass the vclk clock rate as a dt property.
>
> Cheers,
> Prabhakar
>
> v1->v2
> * New patch
> ---
>  .../bindings/media/renesas,rzg2l-csi2.yaml    | 151 ++++++++++++++++++
>  1 file changed, 151 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml
>
> diff --git a/Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml b/Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml
> new file mode 100644
> index 000000000000..bf907768a157
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml
> @@ -0,0 +1,151 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (C) 2022 Renesas Electronics Corp.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/renesas,rzg2l-csi2.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas RZ/G2L MIPI CSI-2 receiver
> +
> +maintainers:
> +  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> +
> +description:
> +  The RZ/G2L CSI-2 receiver device provides MIPI CSI-2 capabilities for the
> +  Renesas RZ/G2L family of devices. MIPI CSI-2 is part of the CRU block which
> +  is used in conjunction with the Image Processing module, which provides the
> +  video capture capabilities.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - renesas,r9a07g044-csi2     # RZ/G2{L,LC}
> +          - const: renesas,rzg2l-csi2

As per Rob's comment on the CRU bindings, you can remove oneOf:

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-names:
> +    items:
> +      - const: csi2_link

Can this be just

  interrupt-names:
    const: csi2_link
?

(I've run dt_binding_check and it does not complain)

> +
> +  clocks:
> +    items:
> +      - description: Internal clock for connecting CRU and MIPI
> +      - description: CRU Main clock
> +      - description: CPU Register access clock
> +
> +  clock-names:
> +    items:
> +      - const: sysclk
> +      - const: vclk
> +      - const: pclk
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  resets:
> +    items:
> +      - description: CRU_CMN_RSTB reset terminal
> +
> +  reset-names:
> +    items:
> +      - const: cmn-rstb

Here and above, is items: needed for a single entry ?
(again, dt_binding_check does not complain if I remove it)

> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description:
> +          Input port node, single endpoint describing the CSI-2 transmitter.
> +
> +        properties:
> +          endpoint:
> +            $ref: video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +            properties:
> +              data-lanes:
> +                minItems: 1
> +                maxItems: 4
> +                items:
> +                  maximum: 4
> +
> +            required:
> +              - clock-lanes
> +              - data-lanes
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          Output port node, Image Processing block connected to the CSI-2 receiver.

Isn't the next processing block the CRU ? IOW, isn't this driver the
CSI-2 receiver ?

> +
> +    required:
> +      - port@0
> +      - port@1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - power-domains
> +  - resets
> +  - reset-names
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/r9a07g044-cpg.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    csi20: csi2@10830400 {
> +            compatible = "renesas,r9a07g044-csi2", "renesas,rzg2l-csi2";
> +            reg = <0x10830400 0xfc00>;
> +            interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks = <&cpg CPG_MOD R9A07G044_CRU_SYSCLK>,
> +                     <&cpg CPG_MOD R9A07G044_CRU_VCLK>,
> +                     <&cpg CPG_MOD R9A07G044_CRU_PCLK>;
> +            clock-names = "sysclk", "vclk", "pclk";
> +            power-domains = <&cpg>;
> +            resets = <&cpg R9A07G044_CRU_CMN_RSTB>;
> +            reset-names = "cmn-rstb";
> +
> +            ports {
> +                    #address-cells = <1>;
> +                    #size-cells = <0>;
> +
> +                    port@0 {
> +                            reg = <0>;
> +
> +                            csi2_in: endpoint {
> +                                    clock-lanes = <0>;
> +                                    data-lanes = <1 2>;
> +                                    remote-endpoint = <&ov5645_ep>;
> +                            };
> +                    };
> +
> +                    port@1 {
> +                            #address-cells = <1>;
> +                            #size-cells = <0>;
> +
> +                            reg = <1>;
> +
> +                            csi2cru: endpoint@0 {
> +                                    reg = <0>;
> +                                    remote-endpoint = <&crucsi2>;
> +                            };
> +                    };
> +            };
> +    };
> --
> 2.17.1
>
