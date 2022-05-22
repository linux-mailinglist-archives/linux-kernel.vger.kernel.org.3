Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0D35303B4
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 17:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347624AbiEVPDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 11:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232611AbiEVPCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 11:02:55 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB9D33A27;
        Sun, 22 May 2022 08:02:52 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 1so1155442ljh.8;
        Sun, 22 May 2022 08:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=75ZrULyIimS7dfT77EINFSzLNNEdV0JagULcFY0Tf7M=;
        b=USwJrbsr/oNmu+onR1bwu1GnogEDOxxHnKCJEeEzPAmF9mr3XUuPDOUBFtXXoPj+V0
         2REdYXcbSTYa6EDCARGxKhQ+pPpBKEXUFe1PnXPDnTmdg+omh5E0kG+DMZkiRCcmYP+h
         HeJCuCEZWvn4/QLWyu92umsFTysGdxfPqDsNxPzgW7rsJ1ltYEdHGBUDlsDmyGXC8Qly
         ArhwITePQIsi1ZxwrF3ust2HAZvPbtrxw0/q4oKYgf6vAugSzamwTNBdUfrjDiHGJpKB
         kfk+O06+bUU8xanQu6KHtcV3SFyq5hFMBnCWEm5t2Nay29oBeT4aEHz+alAMKPayYnHJ
         +a/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=75ZrULyIimS7dfT77EINFSzLNNEdV0JagULcFY0Tf7M=;
        b=u0wqIPQZhR713tRYG0Ga1BrzAbRpAK1ObKv9vAgy49Y9uy9DkNz8wAappoictIkb3o
         2PhLh3UyqNjLnixHVszN7/KnFYUEJCnZ92jqGEcEazt9eP+4M2uSYySfIke+GQqfH1Rr
         RbQi6iK4vT6DpZLnxdi9lNGU0H+2ZPZdvId7Xc8BNkU6IT4gFTeN3yTv9Xr0FvVxScXr
         g/pDSuXLkyxQ9u8tfKGhe5FYC1QBZ5MmVpv2G70FlxYGsK7BsFl2iaG4oseufBJGlq/1
         gNz7dtEwuaIVy1FpvqWgfGnPTONtjJArXg32VbRmKRDhy0lz6Gxk4jnRdeTZIXxXN6tj
         X8Eg==
X-Gm-Message-State: AOAM533DJWlzxpAR0s0lXlXQrZp32XqbcreRXWcKW3d9yXnL+c4MOyE4
        dQhikyjpn1iTgzHTT2MgLhs=
X-Google-Smtp-Source: ABdhPJzG+MkrF0yCrXAGZBnH4UJ2KHBYma4v3X/9bfia7ClTP7ljfnP7OjcAlT/5/4E9+zB48UEgTA==
X-Received: by 2002:a2e:9b4e:0:b0:253:b917:aede with SMTP id o14-20020a2e9b4e000000b00253b917aedemr10795605ljj.275.1653231770733;
        Sun, 22 May 2022 08:02:50 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id x4-20020a2e9c84000000b0024f3d1daeabsm1230584lji.51.2022.05.22.08.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 08:02:50 -0700 (PDT)
Date:   Sun, 22 May 2022 18:02:47 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 02/23] dt-bindings: ata: ahci-platform: Detach common
 AHCI bindings
Message-ID: <20220522150247.zznapdonuq7dsbup@mobilestation>
References: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
 <20220511231810.4928-3-Sergey.Semin@baikalelectronics.ru>
 <20220517191055.GA1424316-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517191055.GA1424316-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 02:10:55PM -0500, Rob Herring wrote:
> On Thu, May 12, 2022 at 02:17:49AM +0300, Serge Semin wrote:
> > In order to create a more sophisticated AHCI controller DT bindings let's
> > divide the already available generic AHCI platform YAML schema into the
> > platform part and a set of the common AHCI properties. The former part
> > will be used to evaluate the AHCI DT nodes mainly compatible with the
> > generic AHCI controller while the later schema will be used for more
> > thorough AHCI DT nodes description. For instance such YAML schemas design
> > will be useful for our DW AHCI SATA controller derivative with four clock
> > sources, two reset lines, one system controller reference and specific
> > max Rx/Tx DMA xfers size constraints.
> > 
> > Note the phys and target-supply property requirement is preserved in the
> > generic AHCI platform bindings because some platforms can lack of the
> > explicitly specified PHYs or target device power regulators.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > ---
> > 
> > Folks, I don't really see why the phys/target-supply requirement has been
> > added to the generic AHCI DT schema in the first place. Probably just to
> > imply some meaning for the sub-nodes definition. Anyway in one of the
> > further patches I am adding the DW AHCI SATA controller DT bindings which
> > won't require having these properties specified in the sub-nodes, but will
> > describe additional port-specific properties. That's why I get to keep the
> > constraints in the ahci-platform.yaml schema instead of moving them to the
> > common schema.
> > 
> > Changelog v2:
> > - This is a new patch created after rebasing v1 onto the 5.18-rc3 kernel.
> > 
> > Changelog v3:
> > - Replace Jens's email address with Damien's one in the list of the
> >   schema maintainers. (@Damien)
> > ---
> >  .../devicetree/bindings/ata/ahci-common.yaml  | 117 ++++++++++++++++++
> >  .../bindings/ata/ahci-platform.yaml           |  68 +---------
> >  2 files changed, 123 insertions(+), 62 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/ata/ahci-common.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/ata/ahci-common.yaml b/Documentation/devicetree/bindings/ata/ahci-common.yaml
> > new file mode 100644
> > index 000000000000..620042ca12e7
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/ata/ahci-common.yaml
> > @@ -0,0 +1,117 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/ata/ahci-common.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Common Properties for Serial ATA AHCI controllers
> > +
> > +maintainers:
> > +  - Hans de Goede <hdegoede@redhat.com>
> > +  - Damien Le Moal <damien.lemoal@opensource.wdc.com>
> > +
> > +description:
> > +  This document defines device tree properties for a common AHCI SATA
> > +  controller implementation. It's hardware interface is supposed to
> > +  conform to the technical standard defined by Intel (see Serial ATA
> > +  Advanced Host Controller Interface specification for details). The
> > +  document doesn't constitute a DT-node binding by itself but merely
> > +  defines a set of common properties for the AHCI-compatible devices.
> > +
> > +select: false
> > +
> > +allOf:
> > +  - $ref: sata-common.yaml#
> > +
> > +properties:
> > +  reg:
> > +    description:
> > +      Generic AHCI registers space conforming to the Serial ATA AHCI
> > +      specification.
> > +
> > +  reg-names:
> > +    description: CSR space IDs
> > +
> > +  interrupts:
> > +    description:
> > +      Generic AHCI state change interrupt. Can be implemented either as a
> > +      single line attached to the controller as a set of the dedicated signals
> > +      for the global and particular port events.
> > +
> > +  clocks:
> > +    description:
> > +      List of all the reference clocks connected to the controller.
> > +
> > +  clock-names:
> > +    description: Reference clocks IDs
> > +
> > +  resets:
> > +    description:
> > +      List of the reset control lines to reset the controller clock
> > +      domains.
> > +
> > +  reset-names:
> > +    description: Reset line IDs
> > +
> > +  power-domains:
> > +    description:
> > +      List of the power domain the AHCI controller being a part of.
> 

> There's not really any point in listing all the above properties here, 
> because they all have to be listed in the device specific schemas.

I agree with dropping the reset, clocks and power-related properties,
but it would be good to somehow signify that at least one IRQ is
required. Is it possible to somehow set such constraint with open
upper bound? If currently it isn't what about setting minItems: 1 (one
generic IRQ) and maxItems: 32 (in case of the per-port IRQs platform)?

Regarding the reg and reg-names properties. Some constraints are added
in one of the next patches of this series (you have already noticed
that).

> 
> > +
> > +  ahci-supply:
> > +    description: Power regulator for AHCI controller
> > +
> > +  target-supply:
> > +    description: Power regulator for SATA target device
> > +
> > +  phy-supply:
> > +    description: Power regulator for SATA PHY
> > +
> > +  phys:
> > +    description: Reference to the SATA PHY node
> > +    maxItems: 1
> > +
> > +  phy-names:
> > +    maxItems: 1
> > +
> > +  ports-implemented:
> > +    $ref: '/schemas/types.yaml#/definitions/uint32'
> > +    description:
> > +      Mask that indicates which ports the HBA supports. Useful if PI is not
> > +      programmed by the BIOS, which is true for some embedded SoC's.
> > +    maximum: 0x1f
> 

> The AHCI spec says there's a max of 32 ports, not 5.
> 
> https://www.intel.com/content/dam/www/public/us/en/documents/technical-specifications/serial-ata-ahci-spec-rev1-3-1.pdf

Right. The maximum constraint is dropped in the patch:
[PATCH v3 03/23] dt-bindings: ata: ahci-platform: Clarify common AHCI props constraints

> 
> > +
> > +patternProperties:
> > +  "^sata-port@[0-9a-f]+$":
> > +    type: object
> > +    description:
> > +      It is optionally possible to describe the ports as sub-nodes so
> > +      to enable each port independently when dealing with multiple PHYs.
> > +
> > +    properties:
> > +      reg:
> > +        description: AHCI SATA port identifier
> > +        maxItems: 1
> > +
> > +      phys:
> > +        description: Individual AHCI SATA port PHY
> > +        maxItems: 1
> > +
> > +      phy-names:
> > +        description: AHCI SATA port PHY ID
> > +        maxItems: 1
> > +
> > +      target-supply:
> > +        description: Power regulator for SATA port target device
> > +
> > +    required:
> > +      - reg
> > +
> > +    additionalProperties: true
> 

> If device specific bindings can add their own properties (as this 
> allows), then all the common sata-port properties needs to be its own 
> schema document. That way the device binding can reference it, define 
> extra properties and set 'unevaluatedProperties: false'.
> 

Could you please be more specific the way it is supposed to look? We
have already got the sata-port@.* object defined in the sata-common.yaml
super-schema. Here I just redefine it with more specific properties.

Is it ok if I moved the sata-port@.* properties in the "definitions"
section of the sata-common.yaml and ahci-common.yaml schema and
re-used them right in the common bindings and, if required, in the
device-specific schema?

Please confirm that the next schema hierarchy is what you were talking
about and it will be ok in this case:

> Documentation/devicetree/bindings/ata/sata-common.yaml:
...
+ patternProperties:
+   "^sata-port@[0-9a-e]$":
+     $ref: '#/definitions/sata-port'
+ 
+ definitions:
+   sata-port:
+     type: object
+   
+     properties:
+       reg:
+         minimum: 0
+ 
+     additionalProperties: true

> Documentation/devicetree/bindings/ata/ahci-common.yaml:
...
+ patternProperties:
+   "^sata-port@[0-9a-e]$":
+     $ref: '#/definitions/ahci-port'
+ 
+ definitions:
+   ahci-port:
+     $ref: /schemas/ata/sata-common.yaml#/definitions/sata-port
+     properties:
+       reg:
+         minimum: 0
+         maximum: 31
...
+ 
+     additionalProperties: true

> Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml:
...
+ patternProperties:
+   "^sata-port@[0-9a-e]$":
+     $ref: /schemas/ata/ahci-common.yaml#/definitions/ahci-port
+     properties:
+       reg:
+         minimum: 0
+         maximum: 7
+ 
+       snps,tx-ts-max:
+         $ref: /schemas/types.yaml#/definitions/uint32
+ 
+       snps,rx-ts-max:
+         $ref: /schemas/types.yaml#/definitions/uint32
+
+     unevaluatedProperties: true

So what do you think about the schemas hierarchy above?


> If other properties aren't allowed, then you can just change this to 
> false. That's what we had before this change.

Before this change the schemas design was the same except it was intended
that the sub-schemas can't extend the sata-port node properties set
(ahci-platform.yaml had additional properties disallowed),
while both the ahci-platform.yaml and parental sata-common.yaml
schemas have sata-port object definition.

In my case for just a lucky coincident it turned out that each sub-schemas
has the sata-port object properties set extended with properties and
new constraints. Anyway if what I suggested in the previous paragraph
is ok for you, I'll update the patch that way.

-Sergey

> 
> > +
> > +required:
> > +  - reg
> > +  - interrupts
> > +
> > +additionalProperties: true
> > +
> > +...
> > diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.yaml b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> > index 9304e4731965..76075d3c8987 100644
> > --- a/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> > +++ b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> > @@ -36,8 +36,7 @@ select:
> >      - compatible
> >  
> >  allOf:
> > -  - $ref: "sata-common.yaml#"
> > -
> > +  - $ref: "ahci-common.yaml#"
> >  
> >  properties:
> >    compatible:
> > @@ -69,90 +68,35 @@ properties:
> >      maxItems: 1
> >  
> >    clocks:
> > -    description:
> > -      Clock IDs array as required by the controller.
> >      minItems: 1
> >      maxItems: 3
> >  
> >    clock-names:
> > -    description:
> > -      Names of clocks corresponding to IDs in the clock property.
> >      minItems: 1
> >      maxItems: 3
> >  
> >    interrupts:
> >      maxItems: 1
> >  
> > -  ahci-supply:
> > -    description:
> > -      regulator for AHCI controller
> > -
> > -  phy-supply:
> > -    description:
> > -      regulator for PHY power
> > -
> > -  phys:
> > -    description:
> > -      List of all PHYs on this controller
> > -    maxItems: 1
> > -
> > -  phy-names:
> > -    description:
> > -      Name specifier for the PHYs
> > -    maxItems: 1
> > -
> > -  ports-implemented:
> > -    $ref: '/schemas/types.yaml#/definitions/uint32'
> > -    description: |
> > -      Mask that indicates which ports that the HBA supports
> > -      are available for software to use. Useful if PORTS_IMPL
> > -      is not programmed by the BIOS, which is true with
> > -      some embedded SoCs.
> > -    maximum: 0x1f
> > -
> >    power-domains:
> >      maxItems: 1
> >  
> >    resets:
> >      maxItems: 1
> >  
> > -  target-supply:
> > -    description:
> > -      regulator for SATA target power
> > -
> > -required:
> > -  - compatible
> > -  - reg
> > -  - interrupts
> > -
> >  patternProperties:
> >    "^sata-port@[0-9a-f]+$":
> >      type: object
> > -    additionalProperties: false
> > -    description:
> > -      Subnode with configuration of the Ports.
> > -
> > -    properties:
> > -      reg:
> > -        maxItems: 1
> > -
> > -      phys:
> > -        maxItems: 1
> > -
> > -      phy-names:
> > -        maxItems: 1
> > -
> > -      target-supply:
> > -        description:
> > -          regulator for SATA target power
> > -
> > -    required:
> > -      - reg
> >  
> >      anyOf:
> >        - required: [ phys ]
> >        - required: [ target-supply ]
> >  
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +
> >  unevaluatedProperties: false
> >  
> >  examples:
> > -- 
> > 2.35.1
> > 
> > 
