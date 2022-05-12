Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77377524C21
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 13:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353453AbiELLva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 07:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353434AbiELLv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 07:51:26 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001F7590A6;
        Thu, 12 May 2022 04:51:24 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id p10so8546563lfa.12;
        Thu, 12 May 2022 04:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=EUjVrc2K5bLVxl3NrlyKWSj4CU1en5+UNwLoJZN982s=;
        b=V8UV1KdBl4k3/BLJ2fMDOz4xubHLHLRj7Bi9zC+5S6H9Ii/UMBOiKm9B8Qt/WbMG7K
         /A+fxBTfurBttDVhMrBn7sp/GksRDYpKUh/m4hyvUHnky2fYiza5MhvmaqFJ503xwO84
         TlijBVmwlEvg0ZhIIa8OU63ZKWYBrRBTUKAdQemZqiKoYXuwm+csxIGLjWjW2Zpu2WLt
         fQkMsBaj00rhWznW1+vXRgdGyjXBDp5uE1JepNP56UHXsYKoNExiHWMjMTRsPJQ8mae5
         04G3AGU/YSsVGgSA1Tscbd77L7YtlVGuDdosHnLR36IzEzzVC4D+1q3dP6ea1pQe11i/
         Wx1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=EUjVrc2K5bLVxl3NrlyKWSj4CU1en5+UNwLoJZN982s=;
        b=xEVh1BWyFbq0Abkoo3hwoXGLzzr8MucIXkurvyVRAL5p3D1YXF5GFjUs80h/7bKVCE
         Fux3q5UjIyUMWmkOib0gTZHEVXkI8WZzC6AZe8wtB8Xe4TFFjQ93I9dLe+1kAsYUUUPP
         +9UvnnuBW24QHVh5gXT+JynAYDEZykdQq0RAeBwMqmoXvwgAMCR8D/ljXWBKp27q+ZLZ
         mJWQKJV3AzN/FgqH0lL4qvXaY1UvcjmDaz718wxXsj/xciJC9VVBlt4nNTdOYCEr9G1V
         7DDBeU8dKg278kXaZ1IJjqMEompEV03qbEfNLgVP7ouUO4UT+xIL21Cv4142Uwj1ACBP
         QFoQ==
X-Gm-Message-State: AOAM532uOzmVjRwPKZ0I0TNHatJfyRUP06ukXtJAUxbX0J5mBTJ1ZL4I
        PoXr3IfRQXXtnI4JiRyjirE=
X-Google-Smtp-Source: ABdhPJwUu7aLoe89cjqzzFvPMLXWMQdSxQo2Zlq6b7FiRW7cDJJ61ZKYAZZNJJq4YxNPv2Th1vo6TA==
X-Received: by 2002:a05:6512:3341:b0:44a:eb29:c59c with SMTP id y1-20020a056512334100b0044aeb29c59cmr23857599lfd.596.1652356283293;
        Thu, 12 May 2022 04:51:23 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id j6-20020a2e3c06000000b0024f3d1daeb2sm854717lja.58.2022.05.12.04.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 04:51:22 -0700 (PDT)
Date:   Thu, 12 May 2022 14:51:19 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 02/23] dt-bindings: ata: ahci-platform: Detach common
 AHCI bindings
Message-ID: <20220512115119.o55eskn5xlouxjur@mobilestation>
References: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
 <20220511231810.4928-3-Sergey.Semin@baikalelectronics.ru>
 <63a15d7a-df10-3f6c-3eb5-1fb9e9742c16@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63a15d7a-df10-3f6c-3eb5-1fb9e9742c16@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 08:19:34AM +0200, Hannes Reinecke wrote:
> On 5/12/22 01:17, Serge Semin wrote:
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
> >    schema maintainers. (@Damien)
> > ---
> >   .../devicetree/bindings/ata/ahci-common.yaml  | 117 ++++++++++++++++++
> >   .../bindings/ata/ahci-platform.yaml           |  68 +---------
> >   2 files changed, 123 insertions(+), 62 deletions(-)
> >   create mode 100644 Documentation/devicetree/bindings/ata/ahci-common.yaml
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
> >       - compatible
> >   allOf:
> > -  - $ref: "sata-common.yaml#"
> > -
> > +  - $ref: "ahci-common.yaml#"
> 

> What happened to 'sata-common.yaml' ?

Nothing. It's still relevant for some devices.

> Not needed anymore? Included via other means?

Included by the SATA-compatible devices. Mainly that schema is relevant
to the devices which aren't AHCI-compatible.

> 
> Please clarify.

sata-common.yaml is a common schema for the SATA devices (including
AHCI-devices), while ahci-common.yaml is a common schema for the
AHCI-compatible devices. So the later is more restrictive, than the
former one. The SATA DT-indings can be used by the
AHCI-incompatible devices for instance by the ones handled in the
drivers drivers/ata/sata_*.c. The AHCI DT-schema can be used by the
AHCI-enabled platforms like described in the LLDDs drivers/ata/ahci_*.
This means if your device is based on AHCI, then its bindings should
refer to the ahci-common.yaml schema and specify the platform-specific
DT-bindings: new properties and common properties constraints. If it
isn't AHCI-compatible but is a Serial ATA device, then it's bindings
should refer to the sata-common.yaml schema (which is much less
restrictive and defines just some small set of the properties).

For instance the brcm,sata-brcm.yaml DT-bindings can be converted to
using the ahci-common.yaml schema instead of the sata-common.yaml
schema, while the renesas,rcar-sata.yaml bindings can refer to the
sata-common.yaml schema thus for instance restricting the DT-node name
to be 'sata' for which in the current RCAR SATA bindings there is no
relevant constraints.

-Sergey

> 
> Cheers,
> 
> Hannes
> -- 
> Dr. Hannes Reinecke		           Kernel Storage Architect
> hare@suse.de			                  +49 911 74053 688
> SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
> HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
