Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA96535EBE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 12:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351085AbiE0K4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 06:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236319AbiE0Kz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 06:55:57 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CB412E304;
        Fri, 27 May 2022 03:55:56 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id g12so4470829lja.3;
        Fri, 27 May 2022 03:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fdkXpnkboxk4nm32J7B3CHhLnCRMyMEytr9AQ7eMpu0=;
        b=MAuIfXqrGoRoD5I5KBeQSvXNVjMvALgBKSkmCGirJuPloh9GBOC/mJ9ShaajV+JXUF
         IDFS5ZAXsUjX6ZC47wt/FuDaNigR/NtdH1Ry3blLdNVcanuzuGsGgLJ+esO2EhpLwYvT
         GMdbIOeTXO82ucvkClp+BmgxE34h/7pz87A12ABoGwUKw/uXvt2JgQL8so21RrLV7vnj
         NKyrb6RFi2cdXOeHhBifIBP2xXSbIMYoCFlWEmCjYgj/aG3oQgHDv0k1+BT+f7h4fgmV
         DnCu5W6zn46qMP3yOnh5mRNcAd8arlAoyh8l3bViyUaY7ulWy3v1lEc941FO3fMw+o54
         N5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fdkXpnkboxk4nm32J7B3CHhLnCRMyMEytr9AQ7eMpu0=;
        b=3gcdW5p+wq8p5tFLH9g9RMW1kVfi5OaFtIGzNM7wtANa1N6iYRicfDkNDp9mnA4eD2
         dD63v+SyM74wyDzPcrqVQ5QInoqMMnXzS37m6vPu44Ru4bxh3hx6MsYeGS4gvtckU+YC
         zT5eVuUuTB5yK7PkhvTNqk8ST4lsd+mZChLgrA6QRYCmx9lRxgWJ2U6xrgCNzBlfdNut
         j5FXsnMNnQyhH66zpvPLrtQdUePq8HpX1/tHCsgGoag8v19asyH2vCT/fGS2qu+TZalk
         DMB++FbXFVnuv+GiSE78GMGspDpGvbSDwcRthTW1QbM3VfsWh35HRUKua+Scipg/o58Y
         yv1g==
X-Gm-Message-State: AOAM5316syYmU75pZrxJuDReb4RU9W75DI5/rw7jEwHs4yFCxrUhHLtC
        bGCZNsniPS1KbwOdAvotWgw=
X-Google-Smtp-Source: ABdhPJxun0ojAyYfMyLqTrhvE1OmE6AmpSS3BVOqA+iC0QxIbnP7rQNv0kAnjNI3PPRuevJULqMm0Q==
X-Received: by 2002:a2e:a589:0:b0:253:e412:57e4 with SMTP id m9-20020a2ea589000000b00253e41257e4mr17546730ljp.237.1653648954151;
        Fri, 27 May 2022 03:55:54 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id a20-20020ac25054000000b0047862c69e83sm825234lfm.40.2022.05.27.03.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 03:55:53 -0700 (PDT)
Date:   Fri, 27 May 2022 13:55:51 +0300
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
Subject: Re: [PATCH v3 20/23] dt-bindings: ata: ahci: Add Baikal-T1 AHCI SATA
 controller DT schema
Message-ID: <20220527105551.7glbytyurbk5rxnb@mobilestation>
References: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
 <20220511231810.4928-21-Sergey.Semin@baikalelectronics.ru>
 <20220517201332.GB1462130-robh@kernel.org>
 <20220522204931.rcgqyyctxivyfmv7@mobilestation>
 <20220524153345.GC3730540-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524153345.GC3730540-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 10:33:45AM -0500, Rob Herring wrote:
> On Sun, May 22, 2022 at 11:49:31PM +0300, Serge Semin wrote:
> > On Tue, May 17, 2022 at 03:13:32PM -0500, Rob Herring wrote:
> > > On Thu, May 12, 2022 at 02:18:07AM +0300, Serge Semin wrote:
> > > > Baikal-T1 AHCI controller is based on the DWC AHCI SATA IP-core v4.10a
> > > > with the next specific settings: two SATA ports, cascaded CSR access based
> > > > on two clock domains (APB and AXI), selectable source of the reference
> > > > clock (though stable work is currently available from the external source
> > > > only), two reset lanes for the application and SATA ports domains. Other
> > > > than that the device is fully compatible with the generic DWC AHCI SATA
> > > > bindings.
> > > > 
> > > > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > > 
> > > > ---
> > > > 
> > > > Changelog v2:
> > > > - Rename 'syscon' property to 'baikal,bt1-syscon'.
> > > > - Drop macro usage from the example node.
> > > > ---
> > > >  .../bindings/ata/baikal,bt1-ahci.yaml         | 127 ++++++++++++++++++
> > > >  1 file changed, 127 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml b/Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml
> > > > new file mode 100644
> > > > index 000000000000..7c2eae75434f
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml
> > > > @@ -0,0 +1,127 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/ata/baikal,bt1-ahci.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Baikal-T1 SoC AHCI SATA controller
> > > > +
> > > > +maintainers:
> > > > +  - Serge Semin <fancer.lancer@gmail.com>
> > > > +
> > > > +description: |
> > > > +  AHCI SATA controller embedded into the Baikal-T1 SoC is based on the
> > > > +  DWC AHCI SATA v4.10a IP-core.
> > > > +
> > > > +allOf:
> > > > +  - $ref: snps,dwc-ahci.yaml#
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    contains:
> > > > +      const: baikal,bt1-ahci
> > > > +
> > > > +  clocks:
> > > > +    items:
> > > > +      - description: Peripheral APB bus clock source
> > > > +      - description: Application AXI BIU clock
> > > > +      - description: Internal SATA Ports reference clock
> > > > +      - description: External SATA Ports reference clock
> > > > +
> > > > +  clock-names:
> > > > +    items:
> > > > +      - const: pclk
> > > > +      - const: aclk
> > > > +      - const: ref_int
> > > > +      - const: ref_ext
> > > > +
> > > > +  resets:
> > > > +    items:
> > > > +      - description: Application AXI BIU domain reset
> > > > +      - description: SATA Ports clock domain reset
> > > > +
> > > > +  reset-names:
> > > > +    items:
> > > > +      - const: arst
> > > > +      - const: ref
> > > > +
> > > > +  baikal,bt1-syscon:
> > > > +    $ref: /schemas/types.yaml#/definitions/phandle
> > > > +    description:
> > > > +      Phandle reference to the CCU system controller. It is required to
> > > > +      switch between internal and external SATA reference clock sources.
> > > 
> > 
> > > Seems like the CCU system ctrlr should be a clock provider that provides 
> > > 'ref' clock and then assigned-clocks can be used to pick internal vs. 
> > > external ref.
> > 

> > By assigned-clocks do you mean using the "assigned-clock-parents"
> > property? 
> 
> Yes, I meant any of those properties.
> 
> > Does it mean creating additional clocks exported from the
> > CCU controller, which could have got one of the two parental clocks?
> 
> Yes, I believe so.

Ok. I hoped to avoid this since it isn't that easy... but seems like I
have not choice now.(

> 
> 
> > > > +
> > > > +  ports-implemented:
> > > > +    maximum: 0x3
> > > > +
> > > > +patternProperties:
> > > > +  "^sata-port@[0-9a-e]$":
> > > > +    type: object
> > > 
> > >        unevaluatedProperties: false
> > > 
> > 
> > > and then a $ref to a sata-port schema.
> > 

> > Can I set additional sata-port properties constraints afterwards? Like
> > I've done for the reg, snps,tx-ts-max and snps,rx-ts-max properties
> > here?
> 
> Yes. All the constraints are effectively ANDed together.

Ok.

> 
> > > > +
> > > > +    properties:
> > > > +      reg:
> > > > +        minimum: 0
> > > > +        maximum: 1
> > > > +
> > > > +      snps,tx-ts-max:
> > > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > > +        description:
> > > > +          Due to having AXI3 bus interface utilized the maximum Tx DMA
> > > > +          transaction size can't exceed 16 beats (AxLEN[3:0]).
> > > > +        minimum: 1
> > > > +        maximum: 16
> > > > +
> > > > +      snps,rx-ts-max:
> > > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > > +        description:
> > > > +          Due to having AXI3 bus interface utilized the maximum Rx DMA
> > > > +          transaction size can't exceed 16 beats (AxLEN[3:0]).
> > > 
> > 
> > > That's not a per port limitation (even though it's a per port register)? 
> > > I think this should be implied by the compatible string.
> > 
> > The snps,{rx,tx}-ts-max property is a per-port property. I'd better
> > explicitly set the property limitation here rather than having the
> > value implicitly clamped by hardware especially seeing the limitation
> > is set by the formulae
> > (CC_MSTR_BURST_LEN * M_HDATA_WIDTH/32)) / (M_HDATA_WIDTH/32),
> > which consists of the IP-core synthesized parameters.
> 
> I did not say use the h/w default.
> 

> What I asking is do you have any need for this to be different per port? 
> Seems unlikely given it's just 1 bus interface for all ports IIRC. I 
> can't see why you would want to tune the performance per port to 
> anything but the max burst length. If you have no need, use the 
> compatible string to determine what to set the register value to.

Well it's not what I need, it's about the way the system and AHCI
interfaces are used for on the particular platform. The Tx/Rx DMA max
burst length affects the system interconnect bus response latency (bus
to which all the system devices are attached to: CPU cores, DDR
controller, Ethernet, PCIe, SATA, etc). The higher the max-burst
length the higher the latency for the other devices to start executing
their IO ops. At the same time maximizing the burst length increases
the corresponding device performance. Should there be a high priority
storage (like system/swap SSD) and a low priority device (data hard drive)
attached to the AHCI ports, I would rise the max burst length of the
hi-prio device and decrease it for the other one. As such the
high-priority traffic would flow with max speed, while the
low-priority device would work slower than the other(s) giving a
chance for the other devices to start their system bus transfers more
frequently. All of that is the platform-specific settings.

> 
> > > Really, firmware should configure this IMO.
> > 
> > We don't have comprehensive firmware setting these and generic HBA parameters.
> > In our case dtb is the main platform firmware.
> 

> No u-boot?

Aside with the default u-boot bootloader there are customers using their
own boot-up software. In addition to that the controller can be
hard-reset before being used in the kernel, which defaults all the
registers state including the state of the PnDMACR one.

-Sergey 

> 
> Rob
