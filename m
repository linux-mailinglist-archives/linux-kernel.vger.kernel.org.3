Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93BF56ABD2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 21:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235546AbiGGTZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 15:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236529AbiGGTZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 15:25:50 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AC617E2F;
        Thu,  7 Jul 2022 12:25:49 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id d12so9478523lfq.12;
        Thu, 07 Jul 2022 12:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bn2ko38Sm2cdbXvB1Bb2L53qXiUYxOL53jCizCZafgc=;
        b=l00be4910K1/R1ROYSKRrGgeztBQZqzgKGj4PhxCjlXBMLOyuJ5FWDsWoBoZAgoinO
         aMAQTxGwdZE98h1waVFPn+lHd1gQcuIBVVGUS6lZcwoNQVnZJgz74qYm5oQiebn21vmf
         01cKcDaaaWp/gltRk/XGJxgv1vOGvFPxcFw4Fg845OUKhrp7lKsyHHlvEeuEcgNE26St
         gKpecRLO34O++PoUErEKCcGOREsriTQEdBD4m+zhvxSmKjplDWQfWh0HRbM/zCRyqQCw
         gIMVsFZpYRXVM6nJhz8gazqQw2jzcAQ8qSumqM6l2GTrY3KDj4ZM0nLESzZC7rgFfFvM
         GWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bn2ko38Sm2cdbXvB1Bb2L53qXiUYxOL53jCizCZafgc=;
        b=Zv9CrKvukgRgYk0dRJTaPlGwWfUOHCR4vZb6SOMWuvuysc0+nzgjtnVI+uUuOtHfaV
         f/nVdEijkaJtw2jcIUiBgOVNzh+0iV8VJDs3MhsPj1RZXKUmcr2Wyds3W63MO+tYFgH0
         tfxNOYfigqz46qHw3z9/lnVfEtHdcLjCZJsprc9CuGjNbTKtRfGW8kRCOCZ1kaFAMw1h
         Rb97rQnI7rxGXRxymk8uSW4mRMZ1fQYjcbvopBRJ7ffYzHubyc8wkWlPYwq27NRM/nAm
         CxUTqgU9oV1NoZO4BAP2i7WsfTihAZe+Gc1XUn6Svl+l130k3QRnQcS6PHxG90YEGOAZ
         S+Yw==
X-Gm-Message-State: AJIora8NW1rHC6vNcYXRhSblbhcxnoQBOflhI5d4wSH7RffxFpl4wOzE
        Ou1O2F8ZPGBxsgUa4bpOi5M=
X-Google-Smtp-Source: AGRyM1vEd40ybANyU2A+lmLQ5HucaokHX6acry1wBBtRWYfvqH7FoSUpRJZ+qnM00Nfthi9ekeioCw==
X-Received: by 2002:a05:6512:2811:b0:47f:6d20:6a71 with SMTP id cf17-20020a056512281100b0047f6d206a71mr29699429lfb.60.1657221947562;
        Thu, 07 Jul 2022 12:25:47 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id s21-20020a056512315500b0047f6e91d4fesm4596000lfi.141.2022.07.07.12.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 12:25:46 -0700 (PDT)
Date:   Thu, 7 Jul 2022 22:25:44 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/17] dt-bindings: PCI: dwc: Add
 interrupts/interrupt-names common properties
Message-ID: <20220707192544.qrxz2b7cbtqtfddw@mobilestation>
References: <20220610085706.15741-1-Sergey.Semin@baikalelectronics.ru>
 <20220610085706.15741-8-Sergey.Semin@baikalelectronics.ru>
 <20220615153201.GB1069883-robh@kernel.org>
 <20220619163727.xjdlx2jf565uhids@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220619163727.xjdlx2jf565uhids@mobilestation>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob,
You must have missed this email. I desperately need to get your
opinion on the possible solution suggested below. It's the main issue
regarding this series, which blocks me from going further with the
patchset re-spin. Let's finally settle things down.

-Sergey

On Sun, Jun 19, 2022 at 07:37:27PM +0300, Serge Semin wrote:
> On Wed, Jun 15, 2022 at 09:32:01AM -0600, Rob Herring wrote:
> > On Fri, Jun 10, 2022 at 11:56:55AM +0300, Serge Semin wrote:
> > > Currently the 'interrupts' and 'interrupt-names' are defined being too
> > > generic to really describe any actual IRQ interface. Moreover the DW PCIe
> > > End-point devices are left with no IRQ signals. All of that can be fixed
> > > by adding the IRQ-related properties to the common DW PCIe DT-schema and
> > > defining a common and device-specific set of the IRQ names in accordance
> > > with the hardware reference manual. Seeing there are common and dedicated
> > > IRQ signals for DW PCIe Root Port and End-point controllers we suggest to
> > > split the IRQ names up into two sets: common definitions available in the
> > > snps,dw-pcie-common.yaml schema and Root Port specific names defined in
> > > the snps,dw-pcie.yaml schema. The former one will be applied to both DW
> > > PCIe RP and EP controllers, while the later one - for the RP only.
> > > 
> > > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > 
> > > ---
> > > 
> > > Changelog v3:
> > > - This is a new patch unpinned from the next one:
> > >   https://lore.kernel.org/linux-pci/20220503214638.1895-2-Sergey.Semin@baikalelectronics.ru/
> > >   by the Rob' request. (@Rob)
> > > ---
> > >  .../bindings/pci/snps,dw-pcie-common.yaml     | 51 +++++++++++++++
> > >  .../bindings/pci/snps,dw-pcie-ep.yaml         | 17 +++++
> > >  .../devicetree/bindings/pci/snps,dw-pcie.yaml | 63 ++++++++++++++++++-
> > >  3 files changed, 128 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> > > index b2fbe886981b..0a524e916a9f 100644
> > > --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> > > +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> > > @@ -17,6 +17,25 @@ description:
> > >  select: false
> > >  
> > >  properties:
> > > +  interrupts:
> > > +    description:
> > > +      There are two main sub-blocks which are normally capable of
> > > +      generating interrupts. It's System Information Interface and MSI
> > > +      interface. While the former one has some common for the Host and
> > > +      Endpoint controllers IRQ-signals, the later interface is obviously
> > > +      Root Complex specific since it's responsible for the incoming MSI
> > > +      messages signalling. The System Information IRQ signals are mainly
> > > +      responsible for reporting the generic PCIe hierarchy and Root
> > > +      Complex events like VPD IO request, general AER, PME, Hot-plug, link
> > > +      bandwidth change, link equalization request, INTx asserted/deasserted
> > > +      Message detection, embedded DMA Tx/Rx/Error.
> > > +    minItems: 1
> > > +    maxItems: 26
> > > +
> > > +  interrupt-names:
> > > +    minItems: 1
> > > +    maxItems: 26
> > > +
> > >    phys:
> > >      description:
> > >        There can be up to the number of possible lanes PHYs specified.
> > > @@ -91,4 +110,36 @@ properties:
> > >  
> > >  additionalProperties: true
> > >  
> > > +definitions:
> > 
> 
> > $defs:
> > 
> > But I suppose this is the applying fixups or not issue. That's certainly 
> > not behavior we should rely on. If we need a way to specify applying 
> > fixups or not, we should do that. But really I'd prefer not to need 
> > that.
> 
> $defs doesn't work in this case. Please see the patchlog to the v2
> of this patch:
> https://lore.kernel.org/linux-pci/20220503214638.1895-2-Sergey.Semin@baikalelectronics.ru/
> 
> Anyway see my next comment. Let's settle the next issue first, then
> get back to the implementation details.
> 
> > 
> > > +  interrupt-names:
> > > +    description:
> > > +      IRQ signal names common for the DWC PCIe Root Port and Endpoint
> > > +      controllers.
> > > +    oneOf:
> > > +      - description:
> > > +          Controller request to read or write virtual product data
> > > +          from/to the VPD capability registers.
> > > +        const: vpd
> > > +      - description:
> > > +          Link Equalization Request flag is set in the Link Status 2
> > > +          register (applicable if the corresponding IRQ is enabled in
> > > +          the Link Control 3 register).
> > > +        const: l_eq
> > > +      - description:
> > > +          Indicates that the eDMA Tx/Rx transfer is complete or that an
> > > +          error has occurred on the corresponding channel. eDMA can have
> > > +          eight Tx (Write) and Rx (Read) eDMA channels thus supporting up
> > > +          to 16 IRQ signals all together. Write eDMA channels shall go
> > > +          first in the ordered row as per default edma_int[*] bus setup.
> > > +        pattern: '^dma([0-9]|1[0-5])?$'
> > > +      - description:
> > > +          PCIe protocol correctable error or a Data Path protection
> > > +          correctable error is detected by the automotive/safety
> > > +          feature.
> > > +        const: sft_ce
> > > +      - description:
> > > +          Indicates that the internal safety mechanism detected and
> > > +          uncorrectable error.
> > > +        const: sft_ue
> > 
> > I still don't really like this pattern. My first read of it makes me 
> > think only 1 interrupt is supported, and I have to go look that this is 
> > referenced from 'items'.
> > 
> > Could we do a lot more with json-schema like you have? Yes, but the 
> > schemas are optimized for simplicity and a relatively fixed pattern of 
> > what's allowed as json-schema is new to most folks. It's also easy to 
> > create things that simply don't work (silently). Just reviewing this 
> > series is hard.
> > 
> 
> > This series is trying to do lots of things. Refactoring, adding 
> > constraints, and adding a new binding. I would split it up if you want 
> > to make progress.
> 
> This series has been refactored three times already! First I created
> it as the legacy bindings conversion to the yaml schema. I missed just
> a few weeks, but someone has already submitted the converted bindings.
> So I had to rebase my work on top of the already performed conversion.
> After that you asked me to split it up into the series of patches.
> Now you want the patchset to be refactored again and to be split up
> again. Each such action takes a lot of my time which I've already
> spent too much on this update taking into account the time spent on
> looking for a way to implement the extendable array property pattern.
> And there is no guaranty you won't refuse the suggested update should
> I re-submit the separate patchset. So please don't ask me to split it
> up again especially seeing there are only eleven DT-related patches
> here. I just can't afford it, but am still very much eager to get the
> work merged in in a suitable for you and me form.
> 
> Let's finally settle the main issue here so I could re-submit the
> series what you'd be ok with. On each iteration you said you didn't
> like the pattern I've used here. It looks like this:
> 
> 1) The most common schema:
> pci/snps,dw-pcie-common.yaml:
> > definitions:
> >   interrupt-names:
> >     oneOf:
> >       - const: i1
> >       - const: i2
> 
> 2) Generic Dw PCIe Root Port schema:
> pci/snps,dw-pcie.yaml:
> > properties:
> >   interrupt-names:
> >     items:
> >       anyOf:
> >         - $ref: /schemas/pci/snps,dw-pcie-common.yaml#/definitions/interrupt-names
> >         - $ref: '#/definitions/interrupt-names'
> > definitions:
> >   interrupt-names:
> >     oneOf:
> >       - const: i3
> >       - const: i4
> 
> 3) Generic Dw PCIe Endpoint schema:
> pci/snps,dw-pcie-ep.yaml:
> > properties:
> >   interrupt-names:
> >     items:
> >       anyOf:
> >         - $ref: /schemas/pci/snps,dw-pcie-common.yaml#/definitions/interrupt-names
> >         - $ref: '#/definitions/interrupt-names'
> > definitions:
> >   interrupt-names:
> >     oneOf:
> >       - const: i5
> >       - const: i6
> 
> I am not that much happy with it either, but first I didn't find any
> alternative, and second by using it I've solved several complex
> problems persistent in the currently implemented DW PCIe bindings:
> 1) Drop the duplicated properties defined in the Root Port and Endpoint
> schemas and create a common DT bindings for both of these devices
> seeing in accordance with the ref. manual they are very much alike.
> 2) Create the generic DW PCIe Root Port and Endpoint DT-schemas with
> more restrictive constraints so to stop the new drivers from creating
> their own regs/clocks/resets/interrupts bindings implementation.
> 3) Fix the already defined DW PCIe vendor-specific DT-bindings to use
> either 1) or 2) schema depending on what is applicable for them.
> 
> So to speak I was willing to bring some order to the already
> implemented DT-schemas and to make sure the new bindings wouldn't
> define the new names to the already known resources. As a result the
> next schemas hierarchy has been provided:
>                        1. Common DW PCIe schema
>                        snps,dw-pcie-common.yaml
>                                   |
>           +-----------------------+----------------------+
>           |                       |                      |
>           v                       v                      V
>  2.DW PCIe Root Port     3. DW PCIe Endpoint   4. DW PCIe Vendor-spec
>   snps,dw-pcie.yaml     snps,dw-pcie-ep.yaml             |
>           |                       |                      |
>           v                       v                      V
>  baikal,bt1-pcie.yaml                         hisilicon,kirin-pcie.yaml
>   intel-gw-pcie.yaml                            sifive,fu740-pcie.yaml
>                                               toshiba,visconti-pcie.yaml
>                                             socionext,uniphier-pcie-ep.yaml
>                                                  fsl,imx6q-pcie.yaml
> 
> As you can see the suggested in this patchset approach is very flexible
> and permits using the common DW PCIe schema in the particular device
> bindings while still have the vendor-specific constraints defined in
> the particular schemas. So the new devices drivers are supposed to use
> the schemas (2) and (3), while the already added drivers can
> following the path (4), apply the schema (1), but still use the names
> "definitions" added to (1), (2) and (3).
> 
> You keep saying that what I've done here is misleading since what was
> created under the "definitions" property is perceived as the "only 1
> interrupt/clock/reg/reset is supported, and you have to go look that
> this is referenced from 'items'". If so then what alternative to this
> solution can you suggest? Do you know a schema pattern which would be
> more suitable? If there is none, then what? Do you suggest to drop
> trying to solve the problems I've listed above? Please answer to these
> questions (or go on on this comment for a possible but IMO less
> suitable alternative solution).
> 
> Anyway in my opinion the currently implemented approach of the names
> array properties:
> >   reg-names:
> >     items:
> >       enum: [dbi, dbi2, config, atu, addr_space, link, atu_dma, appl]
> isn't much more descriptive, since it doesn't provide much info
> regarding the resources but just lists all the common and
> vendor-specific names to the same resources.
> 
> As IMO a much less suitable, but "definitions"-less alternative to my
> approach we can use the next pattern:
> 
> 1) The most common schema:
> pci/snps,dw-pcie-common.yaml:
> > properties:
> >   interrupt-names:
> >     anyOf:
> >       - const: i1
> >       - const: i2
> >       - true
> 
> 2) Generic Dw PCIe Root Port schema:
> pci/snps,dw-pcie.yaml:
> > allOf:
> >   - $ref: /schemas/pci/snps,dw-pcie-common.yaml#
> >
> > properties:
> >   interrupt-names:
> >     items:
> >       anyOf:
> >         - const: i3
> >         - const: i4
> >         - true
> 
> 3) etc
> 
> It will give us a more generic and less restrictive bindings. Thus due
> to using the "true" schema in there we won't be able to automatically
> deny the new resource names adding. But it won't have any
> "definitions" or "$defs" utilized as you seem do not like.
> 
> -Sergey
> 
> > 
> > Rob
