Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811A7518F3E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 22:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240437AbiECUrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 16:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbiECUrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 16:47:13 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C0E2C114;
        Tue,  3 May 2022 13:43:39 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id q14so23455047ljc.12;
        Tue, 03 May 2022 13:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tpAiOFcuu3dIHbvSksLXy2Po/tDlC0C+LeabTLxnH8o=;
        b=mG8h06ua9lMXysgqojZl1ocM78F910whL6WsFVG5yhBzYzVQ/LXVbvt7PdO1sPzW6z
         zS6BsMRRlKDtMbnGtJj2TaSUiOLh3egm5QdoCDUqgFOUQ2ntvh2ga++UWVRtLBbZStlW
         k+rlHjUwmb6OLhJllDC/j49noYyaLR68ZCQfxDWtPWRjud1lqIoOJDP2df3swPdL9wo2
         dbzlNQOWntw3ZnDgbv4C17/Uybu4caH+StQiHYCeekCOSTyi1lPIKaULSc0m4GCefzgU
         tAp6O20MlW7PfB2T09q+DPhHUqh2m4NSdoLOaNBhPnlu+Ci9yi8Egag1k+4wVpka3DIk
         x3Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tpAiOFcuu3dIHbvSksLXy2Po/tDlC0C+LeabTLxnH8o=;
        b=1ncLYujtqbz2qlXDEV2IP08EBnHl00M64UNBBzPGqHVyYoP1c3JZugX6RaHKlQ/V9X
         uEk8FNUVBSmqVb4JAI+dPYwkjP1CJLln8ilYILpehgfJ53OMBWOVEPEKNiVjh8JxuPjI
         205vPM6B8c8OoIgslBq97o0dtIE2kGD3+iSbloEM9NjwF1MZ7EHDohnhvRHjIrso4N9K
         wlOCEx3PcG7mKhDOg0+uYLMRnDuehpbPuCx6uAjY1cb7GnAqsCGgFQv8ccr04FiB+ZQl
         3hLDgA/i6AMd5wPnxto7b72buY6MZ2Z8s/xw6MfwJcahl6Ds5c0Hj2RcZ/DQjO4Kdtnm
         o/Sg==
X-Gm-Message-State: AOAM533fM/LwKcXmld1zwJ4xD5nYoj+KBI+nvYkPPdKOpzsiRUzYwXhM
        u6IX96Ec40c64IP0+hBSN8Q=
X-Google-Smtp-Source: ABdhPJyEa4QMlArKeeC93tabJlLXCfVH1R372maz70XNgN+ky32Bbi+4S/7Mof1XKiidge8mS3s48A==
X-Received: by 2002:a2e:94ce:0:b0:24b:3811:b242 with SMTP id r14-20020a2e94ce000000b0024b3811b242mr10940644ljh.197.1651610617820;
        Tue, 03 May 2022 13:43:37 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id e27-20020ac2547b000000b0047255d21160sm1024118lfn.143.2022.05.03.13.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 13:43:37 -0700 (PDT)
Date:   Tue, 3 May 2022 23:43:34 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 02/23] dt-bindings: ata: ahci-platform: Detach common
 AHCI bindings
Message-ID: <20220503204334.tbmpcdfozylubrjn@mobilestation>
References: <20220503200938.18027-1-Sergey.Semin@baikalelectronics.ru>
 <20220503200938.18027-3-Sergey.Semin@baikalelectronics.ru>
 <773f5323-43af-6764-ea74-2a3bac2022e8@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <773f5323-43af-6764-ea74-2a3bac2022e8@opensource.wdc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 05:29:23AM +0900, Damien Le Moal wrote:
> On 2022/05/04 5:09, Serge Semin wrote:
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
> > ---
> >  .../devicetree/bindings/ata/ahci-common.yaml  | 117 ++++++++++++++++++
> >  .../bindings/ata/ahci-platform.yaml           |  68 +---------
> >  2 files changed, 123 insertions(+), 62 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/ata/ahci-common.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/ata/ahci-common.yaml b/Documentation/devicetree/bindings/ata/ahci-common.yaml
> > new file mode 100644
> > index 000000000000..72e24b246040
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
> > +  - Jens Axboe <axboe@kernel.dk>
> 

> This should probably be me rather than Jens since Jens is no longer maintaining
> libata/ahci.

Ok. I'll replace his email address with yours in v3.

-Sergey

> 
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
> 
> 
> -- 
> Damien Le Moal
> Western Digital Research
