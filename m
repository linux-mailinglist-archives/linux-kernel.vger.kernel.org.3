Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7784E5346EC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 01:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343916AbiEYXKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 19:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239952AbiEYXKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 19:10:40 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9D466ADA;
        Wed, 25 May 2022 16:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1653520235; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G94xiIYp4JaD6Z24NCSIZA2hrRe2VgRo6jmt+CqtRoA=;
        b=EvXdrcy6vMz4imZ/1j/gjWx4E9yc2khxmyi8Vah6S991CnSswjFfQZleYS9Cr0AYwbvlJ+
        6pXEwleMXHiZ5Wu2dKWzSpxzszkdh54BJ9NMN9Ir9rRZCLsZgopJo4iWEruq1ZVGr+Xy9e
        pGaNkYUA0kIthfhnzrRJuDqpyBhnLu0=
Date:   Thu, 26 May 2022 00:10:25 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] dt-bindings: memory-controllers: ingenic: Split out child
 node properties
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mtd@lists.infradead.org
Message-Id: <DDOGCR.THWZ3JUKPSSB@crapouillou.net>
In-Reply-To: <20220525210140.2489866-1-robh@kernel.org>
References: <20220525210140.2489866-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Le mer., mai 25 2022 at 16:01:40 -0500, Rob Herring <robh@kernel.org> a=20
=E9crit :
> Binding schemas which define child node properties such as memory
> controllers with timing properties need a separate schema which can be
> referenced from child device schemas. This is necessary for
> unevaluatedProperties checks to work properly.
>=20
> Move the ingenic,nemc child properties to its own file and reference
> from ingenic,nand.yaml which describes a child NAND controller.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  .../ingenic,nemc-peripherals.yaml             | 46=20
> +++++++++++++++++++
>  .../memory-controllers/ingenic,nemc.yaml      | 32 -------------
>  .../devicetree/bindings/mtd/ingenic,nand.yaml |  1 +
>  3 files changed, 47 insertions(+), 32 deletions(-)
>  create mode 100644=20
> Documentation/devicetree/bindings/memory-controllers/ingenic,nemc-periphe=
rals.yaml
>=20
> diff --git=20
> a/Documentation/devicetree/bindings/memory-controllers/ingenic,nemc-perip=
herals.yaml=20
> b/Documentation/devicetree/bindings/memory-controllers/ingenic,nemc-perip=
herals.yaml
> new file mode 100644
> index 000000000000..b8ed52a44d57
> --- /dev/null
> +++=20
> b/Documentation/devicetree/bindings/memory-controllers/ingenic,nemc-perip=
herals.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id:=20
> http://devicetree.org/schemas/memory-controllers/ingenic,nemc-peripherals=
.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Ingenic SoCs NAND / External Memory Controller (NEMC)=20
> devicetree bindings
> +
> +maintainers:
> +  - Paul Cercueil <paul@crapouillou.net>
> +
> +properties:
> +  reg:
> +    minItems: 1
> +    maxItems: 255
> +
> +  ingenic,nemc-bus-width:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [8, 16]
> +    description: Specifies the bus width in bits.
> +
> +  ingenic,nemc-tAS:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Address setup time in nanoseconds.
> +
> +  ingenic,nemc-tAH:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Address hold time in nanoseconds.
> +
> +  ingenic,nemc-tBP:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Burst pitch time in nanoseconds.
> +
> +  ingenic,nemc-tAW:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Address wait time in nanoseconds.
> +
> +  ingenic,nemc-tSTRV:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Static memory recovery time in nanoseconds.
> +
> +required:
> +  - reg
> +
> +additionalProperties: true
> +...
> diff --git=20
> a/Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.yaml=20
> b/Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.yaml
> index 24f9e1982028..dd13a5106d6c 100644
> ---=20
> a/Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.yaml
> +++=20
> b/Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.yaml
> @@ -39,38 +39,6 @@ properties:
>  patternProperties:
>    ".*@[0-9]+$":
>      type: object
> -    properties:
> -      reg:
> -        minItems: 1
> -        maxItems: 255
> -
> -      ingenic,nemc-bus-width:
> -        $ref: /schemas/types.yaml#/definitions/uint32
> -        enum: [8, 16]
> -        description: Specifies the bus width in bits.
> -
> -      ingenic,nemc-tAS:
> -        $ref: /schemas/types.yaml#/definitions/uint32
> -        description: Address setup time in nanoseconds.
> -
> -      ingenic,nemc-tAH:
> -        $ref: /schemas/types.yaml#/definitions/uint32
> -        description: Address hold time in nanoseconds.
> -
> -      ingenic,nemc-tBP:
> -        $ref: /schemas/types.yaml#/definitions/uint32
> -        description: Burst pitch time in nanoseconds.
> -
> -      ingenic,nemc-tAW:
> -        $ref: /schemas/types.yaml#/definitions/uint32
> -        description: Address wait time in nanoseconds.
> -
> -      ingenic,nemc-tSTRV:
> -        $ref: /schemas/types.yaml#/definitions/uint32
> -        description: Static memory recovery time in nanoseconds.
> -
> -    required:
> -      - reg
>=20
>  required:
>    - compatible
> diff --git a/Documentation/devicetree/bindings/mtd/ingenic,nand.yaml=20
> b/Documentation/devicetree/bindings/mtd/ingenic,nand.yaml
> index 9de8ef6e59ca..8c272c842bfd 100644
> --- a/Documentation/devicetree/bindings/mtd/ingenic,nand.yaml
> +++ b/Documentation/devicetree/bindings/mtd/ingenic,nand.yaml
> @@ -11,6 +11,7 @@ maintainers:
>=20
>  allOf:
>    - $ref: nand-controller.yaml#
> +  - $ref: /schemas/memory-controllers/ingenic,nemc-peripherals.yaml#
>=20
>  properties:
>    compatible:
> --
> 2.34.1
>=20


