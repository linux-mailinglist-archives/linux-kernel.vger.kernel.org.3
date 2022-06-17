Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097EE54FDCA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 21:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239036AbiFQThw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 15:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbiFQThv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 15:37:51 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D621A1A396;
        Fri, 17 Jun 2022 12:37:48 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id s6so8323510lfo.13;
        Fri, 17 Jun 2022 12:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x6g2E/RC2MEAPi9nkuXxVBMo/zSoleb8Sr+XS8bc7nY=;
        b=lRHxRuKyvB3h2Dydu/M1IrvAnR65RPyOWTev2+f/IskR1FFJvZ8tJ9zQfchrwc4aev
         Y78mVSfKnUI6/KEURRqL+8SNswpqKnIriBKMFd1nrfjdxYrnGZ9nSA+ZAItmUZPku1yi
         sFUtQ5xblDZwh/OpVScdAtdrzH1ESEUitQyqJcUrMeT1S3VtAwH2O9WcgjKIJvmpe4X7
         3/+pIwBKPJ1ZNGqRCQa8IOrJdAD9Tb3leHdgfb/uOxCR4ftmo8IfIY1MBXOuMk7OvTUg
         oIrGi6DUv0CVINp9NFcAvS5Av7uhJPr9eDZBFw5S2GPyqe7XiCBcKduGcGrFPBMNWFit
         +g/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x6g2E/RC2MEAPi9nkuXxVBMo/zSoleb8Sr+XS8bc7nY=;
        b=1RD9lBnmO43/4a/cbnHdGPhDElcl5vh6Sj0fgPnacd6S7dDZOVHxZ3/I29F/XVS4Ud
         4uUq6Sy/62OHWJCyrjOxvn93O/BKv/D9mgrKqUTwZoLmYHSzzDdhHKlXhhW3UvZkUEeK
         g/WNR3JYE3Idmb2oRFyXkOC/A8m6wHs0TjnagzBK3mbOh7QRZZ3HRsDgec4M1q3kRML3
         wDB/20WHtUe2sQSQkUrkewDOAxYfl3WvAXk9STXIXW+BZEZMBCu+mi+aZaWmlvAghxU1
         Hwkbkno//kCTonTYras55s86WIARMw9/lGmDB4Ua72hyHQ5264jjVjGNniv76VVr93f6
         px2Q==
X-Gm-Message-State: AJIora/v+Ze5yuNl6XyfemA8rZsQ7Dl0M3M5KHmRDUjqErmVW4M0FerO
        lXSwApVPP882x9gzEljj3ZQ=
X-Google-Smtp-Source: AGRyM1svq4kcgguvPttsqYx1cM3J6lm3ymbjR8zCKQl8Ad0btvpQoEj3i3drD8OxsUPkhDgWDU8+xA==
X-Received: by 2002:ac2:5c1b:0:b0:478:fc5d:9ddf with SMTP id r27-20020ac25c1b000000b00478fc5d9ddfmr6427860lfp.635.1655494666992;
        Fri, 17 Jun 2022 12:37:46 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id t20-20020a195f14000000b00478e9b136f6sm736345lfb.221.2022.06.17.12.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 12:37:46 -0700 (PDT)
Date:   Fri, 17 Jun 2022 22:37:44 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 17/23] dt-bindings: ata: ahci: Add DWC AHCI SATA
 controller DT schema
Message-ID: <20220617193744.av27axznbogademt@mobilestation>
References: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
 <20220610081801.11854-18-Sergey.Semin@baikalelectronics.ru>
 <20220614222754.GA2830345-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614222754.GA2830345-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 04:27:54PM -0600, Rob Herring wrote:
> On Fri, Jun 10, 2022 at 11:17:55AM +0300, Serge Semin wrote:
> > Synopsys AHCI SATA controller is mainly compatible with the generic AHCI
> > SATA controller except a few peculiarities and the platform environment
> > requirements. In particular it can have one or two reference clocks to
> > feed up its AXI/AHB interface and SATA PHYs domain and at least one reset
> > control for the application clock domain. In addition to that the DMA
> > interface of each port can be tuned up to work with the predefined maximum
> > data chunk size. Note unlike generic AHCI controller DWC AHCI can't have
> > more than 8 ports. All of that is reflected in the new DWC AHCI SATA
> > device DT binding.
> > 
> > Note the DWC AHCI SATA controller DT-schema has been created in a way so
> > to be reused for the vendor-specific DT-schemas (see for example the
> > "snps,dwc-ahci" compatible string binding). One of which we are about to
> > introduce.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > ---
> > 
> > Changelog v2:
> > - Replace min/max constraints of the snps,{tx,rx}-ts-max property with
> >   enum [ 1, 2, 4, ..., 1024 ]. (@Rob)
> > 
> > Changelog v4:
> > - Decrease the "additionalProperties" property identation otherwise it's
> >   percieved as the node property instead of the key one. (@Rob)
> > - Use the ahci-port properties definition from the AHCI common schema
> >   in order to extend it with DWC AHCI SATA port properties. (@Rob)
> > - Remove the Hannes' rb tag since the patch content has changed.
> > ---
> >  .../bindings/ata/ahci-platform.yaml           |   8 --
> >  .../bindings/ata/snps,dwc-ahci.yaml           | 129 ++++++++++++++++++
> >  2 files changed, 129 insertions(+), 8 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.yaml b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> > index e19cf9828e68..7dc2a2e8f598 100644
> > --- a/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> > +++ b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> > @@ -30,8 +30,6 @@ select:
> >            - marvell,armada-3700-ahci
> >            - marvell,armada-8k-ahci
> >            - marvell,berlin2q-ahci
> > -          - snps,dwc-ahci
> > -          - snps,spear-ahci
> >    required:
> >      - compatible
> >  
> > @@ -48,17 +46,11 @@ properties:
> >                - marvell,berlin2-ahci
> >                - marvell,berlin2q-ahci
> >            - const: generic-ahci
> > -      - items:
> > -          - enum:
> > -              - rockchip,rk3568-dwc-ahci
> > -          - const: snps,dwc-ahci
> >        - enum:
> >            - cavium,octeon-7130-ahci
> >            - hisilicon,hisi-ahci
> >            - ibm,476gtr-ahci
> >            - marvell,armada-3700-ahci
> > -          - snps,dwc-ahci
> > -          - snps,spear-ahci
> >  
> >    reg:
> >      minItems: 1
> > diff --git a/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml b/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
> > new file mode 100644
> > index 000000000000..af78f6c9b857
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
> > @@ -0,0 +1,129 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/ata/snps,dwc-ahci.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Synopsys DWC AHCI SATA controller
> > +
> > +maintainers:
> > +  - Serge Semin <fancer.lancer@gmail.com>
> > +
> > +description:
> > +  This document defines device tree bindings for the Synopsys DWC
> > +  implementation of the AHCI SATA controller.
> > +
> > +allOf:
> > +  - $ref: ahci-common.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - description: Synopsys AHCI SATA-compatible devices
> > +        contains:
> > +          const: snps,dwc-ahci
> > +      - description: SPEAr1340 AHCI SATA device
> > +        const: snps,spear-ahci
> > +      - description: Rockhip RK3568 ahci controller
> > +        const: rockchip,rk3568-dwc-ahci
> 

> This is never true because there is a fallback. We should keep what we 
> had before.

Could you be more specific what you meant? I don't see
"snps,spear-ahci" and "rockchip,rk3568-dwc-ahci" used with the fallback
string so modification is correct in that case.

My idea was to have the compatible strings with the required generic
fallback "snps,dwc-ahci" for all new devices thus identifying the
controller IP-core origin. But later you said "The generic IP block
fallbacks have proven to be useless." I do agree that functionally it
isn't that often used, but in some cases it can be handy for instance
to implement quirks in the generic code or use the fallback as an
additional info regarding the IP-core origin/version. So if I were you
I wouldn't be that strict about dropping the generic IP-core fallback
identifier. It's much easier to have it specified from the very
beginning than adding it after it has been declared as not required.

> 
> 
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    description:
> > +      Basic DWC AHCI SATA clock sources like application AXI/AHB BIU clock
> > +      and embedded PHYs reference clock together with vendor-specific set
> > +      of clocks.
> > +    minItems: 1
> > +    maxItems: 4
> > +
> > +  clock-names:
> > +    contains:
> > +      anyOf:
> > +        - description: Application AXI/AHB BIU clock source
> > +          enum:
> > +            - aclk
> > +            - sata
> > +        - description: SATA Ports reference clock
> > +          enum:
> > +            - ref
> > +            - sata_ref
> > +
> > +  resets:
> > +    description:
> > +      At least basic core and application clock domains reset is normally
> > +      supported by the DWC AHCI SATA controller. Some platform specific
> > +      clocks can be also specified though.
> 

> s/clocks/resets/ ?

Right, but only in the reference to "platform specific clocks" -> "... resets".

> 
> This allows any number of resets which isn't great. I think this schema 
> should just be the 'simple' cases where there's only 1 reset and 1 
> clock (or how many the DWC block actually has if you have that info). 
> More complicated cases get there own schema.

DWC SATA reference manual claims there can be resets implemented to
each clock domain.
1) PM-clk <- PM-rst - PM keep-alive clock/reset.
2) aclk/hclk <- aresetn/hresetn - AXI/AHB clock domain/reset.
3) rbc*_clk <- rbc*_rst - PHY Receive Clock domain/reset. (Up to
number of ports <= 8.)
4) asic*_clk <- asic*_rst - PHY Transmit Clock domain/reset. (Up to
number of ports <= 8.)
5) rxoob*_clk <- rxoob*_rst - RxOOB Detection Clock domain/reset. (Up
to number of ports <= 8.)

So to speak the IP-core can be equipped with up to 26 clocks and
resets. Should we be more strict we would have needed to define the
properties with all the names above and permit up to 26 clocks/resets
items. (Do you want it to be done?). In our case for instance there
is "aclk" and a single common "ref" clock for all 3, 4 and 5 domain
(clock 1 is missing).

-Sergey

> 
> > +
> > +  reset-names:
> > +    contains:
> > +      description: Core and application clock domains reset control
> > +      const: arst
> > +
> > +patternProperties:
> > +  "^sata-port@[0-9a-e]$":
> > +    $ref: '#/$defs/dwc-ahci-port'
> > +
> > +    unevaluatedProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +
> > +unevaluatedProperties: false
> > +
> > +$defs:
> > +  dwc-ahci-port:
> > +    $ref: /schemas/ata/ahci-common.yaml#/$defs/ahci-port
> > +
> > +    properties:
> > +      reg:
> > +        minimum: 0
> > +        maximum: 7
> > +
> > +      snps,tx-ts-max:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        description: Maximal size of Tx DMA transactions in FIFO words
> > +        enum: [ 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024 ]
> > +
> > +      snps,rx-ts-max:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        description: Maximal size of Rx DMA transactions in FIFO words
> > +        enum: [ 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024 ]
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/ata/ahci.h>
> > +
> > +    sata@122f0000 {
> > +      compatible = "snps,dwc-ahci";
> > +      reg = <0x122F0000 0x1ff>;
> > +      #address-cells = <1>;
> > +      #size-cells = <0>;
> > +
> > +      interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
> > +
> > +      clocks = <&clock1>, <&clock2>;
> > +      clock-names = "aclk", "ref";
> > +
> > +      phys = <&sata_phy>;
> > +      phy-names = "sata-phy";
> > +
> > +      ports-implemented = <0x1>;
> > +
> > +      sata-port@0 {
> > +        reg = <0>;
> > +
> > +        hba-port-cap = <HBA_PORT_FBSCP>;
> > +
> > +        snps,tx-ts-max = <512>;
> > +        snps,rx-ts-max = <512>;
> > +      };
> > +    };
> > +...
> > -- 
> > 2.35.1
> > 
> > 
