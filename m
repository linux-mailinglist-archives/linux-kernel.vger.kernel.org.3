Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB17508303
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 09:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376584AbiDTH7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 03:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376567AbiDTH7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 03:59:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C19F2668;
        Wed, 20 Apr 2022 00:56:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CF8ADB81D57;
        Wed, 20 Apr 2022 07:56:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 730F5C385A1;
        Wed, 20 Apr 2022 07:56:30 +0000 (UTC)
Message-ID: <c3d0d176-252b-5823-0c34-f1bfc7c4978c@xs4all.nl>
Date:   Wed, 20 Apr 2022 09:56:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/5] dt-bindings: media: platform: visconti: Add
 Toshiba Visconti Video Input Interface bindings
Content-Language: en-US
To:     Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220414053528.31460-1-yuji2.ishikawa@toshiba.co.jp>
 <20220414053528.31460-2-yuji2.ishikawa@toshiba.co.jp>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20220414053528.31460-2-yuji2.ishikawa@toshiba.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2022 07:35, Yuji Ishikawa wrote:
> Adds the Device Tree binding documentation that allows to describe
> the Video Input Interface found in Toshiba Visconti SoCs.
> 
> Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  .../bindings/media/toshiba,visconti-viif.yaml | 103 ++++++++++++++++++
>  1 file changed, 103 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/toshiba,visconti-viif.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/toshiba,visconti-viif.yaml b/Documentation/devicetree/bindings/media/toshiba,visconti-viif.yaml
> new file mode 100644

You need to CC this series to devicetree@vger.kernel.org so that the device tree reviewers
can take a look at this.

Regards,

	Hans

> index 000000000..848ea5019
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/toshiba,visconti-viif.yaml
> @@ -0,0 +1,103 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/toshiba,visconti-viif.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Toshiba Visconti5 SoC Video Input Interface Device Tree Bindings
> +
> +maintainers:
> +  - Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> +
> +description: |
> +  Toshiba Visconti5 SoC Video Input Interface (VIIF) receives MIPI CSI2 video stream,
> +  processes the stream with embedded image signal processor (L1ISP, L2ISP), then stores pictures to main memory.
> +
> +properties:
> +  compatible:
> +    const: toshiba,visconti-viif
> +
> +  reg:
> +    items:
> +      - description: registers for capture control
> +      - description: registers for CSI2 receiver control
> +
> +  interrupts:
> +    items:
> +      - description: Sync Interrupt
> +      - description: Status (Error) Interrupt
> +      - description: CSI2 Receiver Interrupt
> +      - description: L1ISP Interrupt
> +
> +  index:
> +    enum: [0, 1]
> +
> +  port:
> +    $ref: /schemas/graph.yaml#/$defs/port-base
> +    unevaluatedProperties: false
> +    description: Input port node, single endpoint describing the CSI-2 transmitter.
> +
> +    properties:
> +      endpoint:
> +        $ref: video-interfaces.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          data-lanes:
> +            description: VIIF supports 2 or 4 data lines
> +            items:
> +              minItems: 1
> +              maxItems: 4
> +              items:
> +                - const: 1
> +                - const: 2
> +                - const: 3
> +                - const: 4
> +          clock-lanes:
> +            description: VIIF supports 1 clock line
> +            const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        viif0: viif@1c000000 {
> +            compatible = "toshiba,visconti-viif";
> +            reg = <0 0x1c000000 0 0x6000>,
> +                  <0 0x1c008000 0 0x400>;
> +            interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
> +            index = <0>;
> +            status = "disabled";
> +
> +            port {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                csi_in0: endpoint {
> +                    remote-endpoint = <&imx219_out0>;
> +                    bus-type = <4>;
> +                    data-lanes = <1 2>;
> +                    clock-lanes = <0>;
> +                    clock-noncontinuous;
> +                    link-frequencies = /bits/ 64 <456000000>;
> +                };
> +            };
> +        };
> +    };
> +

