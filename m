Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0656E5656DE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 15:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiGDNSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 09:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiGDNSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:18:16 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D2DDEA7;
        Mon,  4 Jul 2022 06:18:14 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id j21so15809481lfe.1;
        Mon, 04 Jul 2022 06:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j4ru8U8jKWuRPXMVrHPNbelWfbH6icHmyGNqevEsy44=;
        b=prmeeVRZXWaZymBNhKhVTandDHZG1o+rThilBug7gUaXY+WD8UoNR37q30DfYoYT7F
         B9gh9MM6tt8NqWOWJADeWAnYZv0/pMpRAGaOpIqQXyHfPjrVUSCdN22EZJK5XxoGyd2Y
         IzYKCx4kI3LTTo2Zuifp6pDdlRhkJuOK8yoJfk1oTY/QKBITbR0mot6xAIW/DrQni1+X
         ZTa0VlqoSXnND02xIeZnWGqQyJkQaaRL37/KpW/Dj2X7pbuW3BDmAQfwCXqVSeDs1fyR
         M98uvoEZfjFgQiBVvAku9GDDjhlrdFdqySYr9zRxVWQb+mXJz7IFMpti6cWE3el6vWGV
         uXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j4ru8U8jKWuRPXMVrHPNbelWfbH6icHmyGNqevEsy44=;
        b=S52l81eUgI99RY7LLw8HHgKiou884iI5le1QdGcgPEPMOiKW0sFOFhFtvBjulH3LHj
         Up3bV8zCaAx/RBKdQ5eVhohGWeL4AgawAey0zhGwtdgvJapEAXH1PiTqcX6ykzfhBb0j
         Bxtt+RkU4gUW2UQsgKt/VV1WDo3r2VR2Zsqqxajc/qprgxPmkxsGnDIsfPRQeq6+BCIF
         QZzCE3I5xcJLmohikPmmfc7HkTPKaP//d4CFSk6fGlVPMIt38HFXIdcXZejJ3Y2qxP7K
         4fJvSDRSWqRYlnXSLRQ+67xWATOJ7fzxgIBLEwCR8IYBQIHLa3DQZwCBe+5iLewAuN/j
         XgXA==
X-Gm-Message-State: AJIora/eW0ayJ9uOuo24M9gM7vZC4XqeWH61p8jwffkMz80tqesob4Qd
        IFNySR5MzXZ8IWHot3juon0=
X-Google-Smtp-Source: AGRyM1u5uMuqVFvU0o30xAxxkDLHZCxB/aYjcpR+huFHnetjwt2k3PcbFhzZrRLzOFVr6bcmaO0vOA==
X-Received: by 2002:a05:6512:3b1e:b0:481:20ff:434a with SMTP id f30-20020a0565123b1e00b0048120ff434amr19895767lfv.111.1656940693180;
        Mon, 04 Jul 2022 06:18:13 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id y2-20020ac24e62000000b0047960b50c26sm5127160lfs.78.2022.07.04.06.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 06:18:12 -0700 (PDT)
Date:   Mon, 4 Jul 2022 16:18:10 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Brad Larson <brad@pensando.io>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Al Cooper <alcooperx@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, blarson@amd.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Gabriel Somlo <gsomlo@gmail.com>, gerg@linux-m68k.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Pratyush Yadav <p.yadav@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>, samuel@sholland.org,
        suravee.suthikulpanit@amd.com,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Will Deacon <will@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 04/15] dt-bindings: spi: dw: Add AMD Pensando Elba SoC
 SPI Controller bindings
Message-ID: <20220704131810.kabkuy6e4qmhfm3n@mobilestation>
References: <20220613195658.5607-1-brad@pensando.io>
 <20220613195658.5607-5-brad@pensando.io>
 <20220620193044.ihxfn6kddif7j5la@mobilestation>
 <0a68aa72-df85-cf78-dcca-2d75038234c6@kernel.org>
 <20220620200445.yew3vo3pnjhos7rs@mobilestation>
 <4ff85493-665a-ee58-07d3-80178c49223b@linaro.org>
 <20220621101159.stvan53rvr6qugna@mobilestation>
 <CAK9rFnwOq6X5-uDS+SKiU4XQbSVQYiBUe0rEDvzdHy3CO6gUHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK9rFnwOq6X5-uDS+SKiU4XQbSVQYiBUe0rEDvzdHy3CO6gUHQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 03, 2022 at 04:58:09PM -0700, Brad Larson wrote:
> Hi Sergey,
> 
> On Tue, Jun 21, 2022 at 3:12 AM Serge Semin <fancer.lancer@gmail.com> wrote:
> >
> > On Tue, Jun 21, 2022 at 09:00:36AM +0200, Krzysztof Kozlowski wrote:
> > > On 20/06/2022 22:04, Serge Semin wrote:
> > > > On Mon, Jun 20, 2022 at 09:46:25PM +0200, Krzysztof Kozlowski wrote:
> > > >> On 20/06/2022 21:30, Serge Semin wrote:
> > > >>> On Mon, Jun 13, 2022 at 12:56:47PM -0700, Brad Larson wrote:
> > > >>>> From: Brad Larson <blarson@amd.com>
> > > >>>>
> > > >>>> The AMD Pensando Elba SoC has integrated the DW APB SPI Controller
> > > >>>>
> > > >>>> Signed-off-by: Brad Larson <blarson@amd.com>
> > > >>>> ---
> > > >>>>  Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 2 ++
> > > >>>>  1 file changed, 2 insertions(+)
> > > >>>>
> > > >>>> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> > > >>>> index e25d44c218f2..2a55b947cffc 100644
> > > >>>> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> > > >>>> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> > > >>>> @@ -73,6 +73,8 @@ properties:
> > > >>>>                - renesas,r9a06g032-spi # RZ/N1D
> > > >>>>                - renesas,r9a06g033-spi # RZ/N1S
> > > >>>>            - const: renesas,rzn1-spi   # RZ/N1
> > > >>>
> > > >>>> +      - description: AMD Pensando Elba SoC SPI Controller
> > > >>>> +        const: amd,pensando-elba-spi
> > > >>>
> > > >>> Not enough. The driver requires to have a phandle reference to the
> > > >>> Pensando System Controller. So the property like
> > > >>> "amd,pensando-elba-syscon" is also needed to be added to the DT schema
> > > >>> otherwise should the dt-schema tool correctly handle the
> > > >>> "unevaluatedProperties: false" setting (Rob says it isn't fully
> > > >>> supported at the moment), the dtbs_check procedure will fail on your
> > > >>> dts evaluation.
> > > >>
> > > >
> > > >> The property was here before, now removed, so I assume it was also
> > > >> removed from the driver and DTS. Isn't that the case?
> > > >
> > > > Ah, the property has been indeed removed. The driver now searches for
> > > > the system controller by the next compatible string:
> > > > "amd,pensando-elba-syscon" using the
> > > > syscon_regmap_lookup_by_compatible() method. My mistake. Sorry for the
> > > > noise.
> > > >
> >
> > > > * Though personally I'd prefer to have a property with the phandle
> > > > reference in order to signify the connection between the system controller
> > > > and the SPI-controller. Otherwise the implicit DT bindings like having
> > > > the "amd,pensando-elba-syscon"-compatible syscon gets to be
> > > > hidden behind the DT scene. But seeing we have already got the Microsemi
> > > > platform with such semantic, I can't insist on fixing this.
> > >
> > > I agree entirely, this should be explicit syscon-type property. Looking
> > > up for compatibles:
> > >  - creates hidden (not expressed via bindings) dependency between nodes,
> > >  - is not portable and several people struggled with it later and needed
> > > backward-compatible code (many examples, let's just give recent one: [1])
> > >
> > >
> > > [1]
> > > https://lore.kernel.org/all/20220619151225.209029-10-tmaimon77@gmail.com/
> >
> > Seems even more reasonable now. Thanks for providing a bright example
> > justifying the property-based approach.
> >
> > @Brad, could you get back the property with a phandle to the syscon
> > DT-node? (No need in adding the CS CSR address as the phandle argument,
> > just a phandle.)
> 
> Replying to the sequence of review inputs.  The below change to
> version 5 brings back the phandle without the earlier argument that
> complicated the binding (was the motivation for moving in this
> direction in earlier version).  Passes dtbs_check.
> 
> --- a/drivers/spi/spi-dw-mmio.c
> +++ b/drivers/spi/spi-dw-mmio.c
> @@ -285,12 +285,17 @@ static void dw_spi_elba_set_cs(struct spi_device
> *spi, bool enable)
>  static int dw_spi_elba_init(struct platform_device *pdev,
>                             struct dw_spi_mmio *dwsmmio)
>  {
> +       struct device_node *np = pdev->dev.of_node;
> +       struct device_node *node;
>         struct dw_spi_elba *dwselba;
>         struct regmap *regmap;
> 
> -       regmap = syscon_regmap_lookup_by_compatible("amd,pensando-elba-syscon");
> -       if (IS_ERR(regmap))
> -               return PTR_ERR(regmap);

> +       node = of_parse_phandle(np, "pensando,elba-syscon-spics", 0);

1. Property name must be structured with the permitted vendor-prefix. In
your case it's "amd," not "pensando,".
2. Having 'spics' in the property name doesn't make much sense since
the property is supposed to contain a phandle reference to the whole
syscon node.

So to speak the property with name like 'amd,pensando-elba-syscon'
seems more appropriate here.

> +       if (node) {
> +               regmap = syscon_node_to_regmap(node);
> +               if (IS_ERR(regmap))
> +                       return PTR_ERR(regmap);
> +       }
> 
> diff --git a/arch/arm64/boot/dts/amd/elba.dtsi
> b/arch/arm64/boot/dts/amd/elba.dtsi
> index 9739641261c3..ec48be4cfe48 100644
> --- a/arch/arm64/boot/dts/amd/elba.dtsi
> +++ b/arch/arm64/boot/dts/amd/elba.dtsi
> @@ -98,6 +98,7 @@
>                         reg = <0x0 0x2800 0x0 0x100>;
>                         #address-cells = <1>;
>                         #size-cells = <0>;

> +                       pensando,elba-syscon-spics = <&syscon>;
  +                       amd,pensando-elba-syscon = <&syscon>;

ditto

>                         clocks = <&ahb_clk>;
>                         interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
>                         num-cs = <2>;
> 
> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> @@ -37,6 +37,15 @@ allOf:
>      else:
>        required:
>          - interrupts
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - amd,pensando-elba-spi
> +    then:
  +      properties:
  +        amd,pensando-elba-syscon
  +          $ref: /schemas/types.yaml#/definitions/phandle
  +          description: AMD Pensando Elba SoC system controller
> +      required:
> +        - amd,pensando-elba-syscon

Please make sure the DT-bindings check passes correctly.

-Sergey

> 
>  properties:
>    compatible:
> 
> Regards,
> Brad
