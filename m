Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6497854667D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 14:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345195AbiFJMUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 08:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239840AbiFJMUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 08:20:02 -0400
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B712CFE8B
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 05:19:59 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1nzdbt-000793-Ry; Fri, 10 Jun 2022 14:19:30 +0200
Date:   Fri, 10 Jun 2022 13:19:24 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rini <trini@konsulko.com>,
        Ricardo Salveti <ricardo@foundries.io>,
        Michal Simek <michal.simek@xilinx.com>,
        Jorge Ramirez-Ortiz <jorge@foundries.io>,
        Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH] dt-bindings: mtd: partitions: add UBI binding
Message-ID: <YqM2zPcJAqFM8SA8@makrotopia.org>
References: <20220217102448.27586-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220217102448.27586-1-zajec5@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 11:24:48AM +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> UBI is often used on embedded devices to store UBI volumes with device
> configuration / calibration data. Such volumes may need to be documented
> and referenced for proper boot & setup.
> 
> Some examples:
> 1. U-Boot environment variables
> 2. Device calibration data
> 3. Default setup (e.g. initial password)
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

This is very useful and can replace the downstream hacks we are
currently using for this purpose in OpenWrt.

Reviewed-by: Daniel Golle <daniel@makrotopia.org>

> ---
>  .../bindings/mtd/partitions/ubi.yaml          | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/ubi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/ubi.yaml b/Documentation/devicetree/bindings/mtd/partitions/ubi.yaml
> new file mode 100644
> index 000000000000..cd081f06d4cb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/partitions/ubi.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/partitions/ubi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: UBI (Unsorted Block Images) device
> +
> +description: |
> +  UBI is a layer providing logical volumes (consisting of logical blocks) on top
> +  of raw flash devices. It deals with low-level flash issues (bit-flips, bad
> +  physical eraseblocks, wearing) providing a reliable data storage.
> +
> +  UBI device is built and stored in a single flash partition.
> +
> +  Some (usually embedded) devices use UBI volumes of specific names or indexes
> +  to store setup / configuration data. This binding allows describing such
> +  volumes so they can be identified and referenced by consumers.
> +
> +maintainers:
> +  - Rafał Miłecki <rafal@milecki.pl>
> +
> +allOf:
> +  - $ref: partition.yaml#
> +
> +properties:
> +  compatible:
> +    const: ubi
> +
> +patternProperties:
> +  "^volume-[0-9a-f]+$":
> +    type: object
> +    description: UBI volume
> +    properties:
> +      volume-name:
> +        $ref: /schemas/types.yaml#/definitions/string
> +      volume-id:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +    anyOf:
> +      - required:
> +          - volume-name
> +      - required:
> +          - volume-id
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    partitions {
> +        compatible = "fixed-partitions";
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        partition@0 {
> +            compatible = "ubi";
> +            reg = <0x0000000 0x1000000>;
> +            label = "filesystem";
> +
> +            env: volume-0 {
> +                volume-name = "u-boot-env";
> +            };
> +
> +            calibration: volume-1 {
> +                volume-id = <99>;
> +            };
> +        };
> +    };
> -- 
> 2.34.1
> 
