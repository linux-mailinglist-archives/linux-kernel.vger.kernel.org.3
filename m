Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379BA564AAD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 02:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbiGCX63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 19:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiGCX6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 19:58:25 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DCF115C
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 16:58:21 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id s1so11087688wra.9
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 16:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SeuYhb+fR/O+JId5F96JaZYYxL72Jc9GQ+pLBmOD004=;
        b=0k8eK8Jojjb91pV+KBQCP6oj1RV40aN8Eu4gH5wQycs8andxXEGKXlAf0hsT21B1Ck
         6sc49V0peyXIOiZpGcMDu0uO5WKzc4sEY4qV4UPIFM4f4fEMsLJuK/928u1RoHtGqqpE
         /Ewo7BkSUqyDPUG79XYgf3noOrAN/OIFJtkylSDE7pxH8cGw4OY7Cyvfk/RVaS0L88CG
         XOViAGcM1pDmq8BoM9aNwihCNg9KAxhwy87pJzql1nw+XZwqKNNs6p5U6fqCwF3zQpD4
         PVz2b8w6zowYAcLQk7KZOfle07Ssp+3EQmTErDS0iCUJuT7n8E3aq8X9mGElJ+8k36OH
         zlIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SeuYhb+fR/O+JId5F96JaZYYxL72Jc9GQ+pLBmOD004=;
        b=W30HV03ZF5dDefS58LBVcTz9k8yz1i9gchSPogia1jyXB2S5z/ZuELGcHJwgUr35bG
         jEMmG30hbf14k0REh8pFDoD/E00HtvHDkVATIGTqtS/RfSM60i6hQdGlTvZD9ntZJwUs
         UYuRyc/aJTCmA/zLHe4yhr2OpKD5mJbhY8StfK7oji/XM3x7fmGjGRJA8kBU9w6+YAwf
         mXzJuGcCQd597fCCb66NIdUffOXKk4vQafKIw3noPkDI4KHtHpfhGtI5bbFr941T449G
         MztErtdIy1jTyJQiYENqq+EMepXEi+1MThUrFcLgNVkorAUKNr61LQsh2Nit70Tw2jlI
         6y+w==
X-Gm-Message-State: AJIora+UJcMo6tCU1yedaOFhfIwfsd87n8IgkbZ9gIr/aI6huBwv4GeD
        Yj9tjwvLs6lmbQK0vi3e3ir3cxnVuRDyeQovSaSiKA==
X-Google-Smtp-Source: AGRyM1tygYh1HzmV04U05tqlPo+WqSVuTRuUoHZi496RPSpLnW4G6fq23HZuTWqnGbIVJFet5kSc/JWgWzgI+wii0fg=
X-Received: by 2002:a5d:5a15:0:b0:21d:630c:a609 with SMTP id
 bq21-20020a5d5a15000000b0021d630ca609mr7333830wrb.468.1656892700065; Sun, 03
 Jul 2022 16:58:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220613195658.5607-1-brad@pensando.io> <20220613195658.5607-5-brad@pensando.io>
 <20220620193044.ihxfn6kddif7j5la@mobilestation> <0a68aa72-df85-cf78-dcca-2d75038234c6@kernel.org>
 <20220620200445.yew3vo3pnjhos7rs@mobilestation> <4ff85493-665a-ee58-07d3-80178c49223b@linaro.org>
 <20220621101159.stvan53rvr6qugna@mobilestation>
In-Reply-To: <20220621101159.stvan53rvr6qugna@mobilestation>
From:   Brad Larson <brad@pensando.io>
Date:   Sun, 3 Jul 2022 16:58:09 -0700
Message-ID: <CAK9rFnwOq6X5-uDS+SKiU4XQbSVQYiBUe0rEDvzdHy3CO6gUHQ@mail.gmail.com>
Subject: Re: [PATCH v5 04/15] dt-bindings: spi: dw: Add AMD Pensando Elba SoC
 SPI Controller bindings
To:     Serge Semin <fancer.lancer@gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

On Tue, Jun 21, 2022 at 3:12 AM Serge Semin <fancer.lancer@gmail.com> wrote:
>
> On Tue, Jun 21, 2022 at 09:00:36AM +0200, Krzysztof Kozlowski wrote:
> > On 20/06/2022 22:04, Serge Semin wrote:
> > > On Mon, Jun 20, 2022 at 09:46:25PM +0200, Krzysztof Kozlowski wrote:
> > >> On 20/06/2022 21:30, Serge Semin wrote:
> > >>> On Mon, Jun 13, 2022 at 12:56:47PM -0700, Brad Larson wrote:
> > >>>> From: Brad Larson <blarson@amd.com>
> > >>>>
> > >>>> The AMD Pensando Elba SoC has integrated the DW APB SPI Controller
> > >>>>
> > >>>> Signed-off-by: Brad Larson <blarson@amd.com>
> > >>>> ---
> > >>>>  Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 2 ++
> > >>>>  1 file changed, 2 insertions(+)
> > >>>>
> > >>>> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> > >>>> index e25d44c218f2..2a55b947cffc 100644
> > >>>> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> > >>>> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> > >>>> @@ -73,6 +73,8 @@ properties:
> > >>>>                - renesas,r9a06g032-spi # RZ/N1D
> > >>>>                - renesas,r9a06g033-spi # RZ/N1S
> > >>>>            - const: renesas,rzn1-spi   # RZ/N1
> > >>>
> > >>>> +      - description: AMD Pensando Elba SoC SPI Controller
> > >>>> +        const: amd,pensando-elba-spi
> > >>>
> > >>> Not enough. The driver requires to have a phandle reference to the
> > >>> Pensando System Controller. So the property like
> > >>> "amd,pensando-elba-syscon" is also needed to be added to the DT schema
> > >>> otherwise should the dt-schema tool correctly handle the
> > >>> "unevaluatedProperties: false" setting (Rob says it isn't fully
> > >>> supported at the moment), the dtbs_check procedure will fail on your
> > >>> dts evaluation.
> > >>
> > >
> > >> The property was here before, now removed, so I assume it was also
> > >> removed from the driver and DTS. Isn't that the case?
> > >
> > > Ah, the property has been indeed removed. The driver now searches for
> > > the system controller by the next compatible string:
> > > "amd,pensando-elba-syscon" using the
> > > syscon_regmap_lookup_by_compatible() method. My mistake. Sorry for the
> > > noise.
> > >
>
> > > * Though personally I'd prefer to have a property with the phandle
> > > reference in order to signify the connection between the system controller
> > > and the SPI-controller. Otherwise the implicit DT bindings like having
> > > the "amd,pensando-elba-syscon"-compatible syscon gets to be
> > > hidden behind the DT scene. But seeing we have already got the Microsemi
> > > platform with such semantic, I can't insist on fixing this.
> >
> > I agree entirely, this should be explicit syscon-type property. Looking
> > up for compatibles:
> >  - creates hidden (not expressed via bindings) dependency between nodes,
> >  - is not portable and several people struggled with it later and needed
> > backward-compatible code (many examples, let's just give recent one: [1])
> >
> >
> > [1]
> > https://lore.kernel.org/all/20220619151225.209029-10-tmaimon77@gmail.com/
>
> Seems even more reasonable now. Thanks for providing a bright example
> justifying the property-based approach.
>
> @Brad, could you get back the property with a phandle to the syscon
> DT-node? (No need in adding the CS CSR address as the phandle argument,
> just a phandle.)

Replying to the sequence of review inputs.  The below change to
version 5 brings back the phandle without the earlier argument that
complicated the binding (was the motivation for moving in this
direction in earlier version).  Passes dtbs_check.

--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -285,12 +285,17 @@ static void dw_spi_elba_set_cs(struct spi_device
*spi, bool enable)
 static int dw_spi_elba_init(struct platform_device *pdev,
                            struct dw_spi_mmio *dwsmmio)
 {
+       struct device_node *np = pdev->dev.of_node;
+       struct device_node *node;
        struct dw_spi_elba *dwselba;
        struct regmap *regmap;

-       regmap = syscon_regmap_lookup_by_compatible("amd,pensando-elba-syscon");
-       if (IS_ERR(regmap))
-               return PTR_ERR(regmap);
+       node = of_parse_phandle(np, "pensando,elba-syscon-spics", 0);
+       if (node) {
+               regmap = syscon_node_to_regmap(node);
+               if (IS_ERR(regmap))
+                       return PTR_ERR(regmap);
+       }

diff --git a/arch/arm64/boot/dts/amd/elba.dtsi
b/arch/arm64/boot/dts/amd/elba.dtsi
index 9739641261c3..ec48be4cfe48 100644
--- a/arch/arm64/boot/dts/amd/elba.dtsi
+++ b/arch/arm64/boot/dts/amd/elba.dtsi
@@ -98,6 +98,7 @@
                        reg = <0x0 0x2800 0x0 0x100>;
                        #address-cells = <1>;
                        #size-cells = <0>;
+                       pensando,elba-syscon-spics = <&syscon>;
                        clocks = <&ahb_clk>;
                        interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
                        num-cs = <2>;

--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -37,6 +37,15 @@ allOf:
     else:
       required:
         - interrupts
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - amd,pensando-elba-spi
+    then:
+      required:
+        - pensando,elba-syscon-spics

 properties:
   compatible:

Regards,
Brad
