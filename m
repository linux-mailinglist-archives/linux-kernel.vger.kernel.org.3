Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E3559BED3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 13:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbiHVLrE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 22 Aug 2022 07:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiHVLrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 07:47:03 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B48B33E22;
        Mon, 22 Aug 2022 04:47:02 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id s11so7614479qtx.6;
        Mon, 22 Aug 2022 04:47:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=2XJZ/Imo2dVNd0H4SfuBgLAT9QYlxOPB6r7l1kGv5p8=;
        b=CUp9H9Z9MnEA00D52dA9uPlykWCdBmhiiZixbz6ua5096TApkwqpTOSBh8BcW6uVEe
         mF35ibcjm86XWXnSR59zZ+9XJ451/4s7d64i0pVZfPzzlhzoAY/ZTYAYjh2q6ZS9UR/r
         cnjusCMYjxxloV4lcjHmj/8ZJ1JZZ52omuuxXCyFxTKdLOJjs4A4RTBKxIHkoDtsbBtG
         Ozb72UR0W06LVBVcOwFNvJn+Df1Tq7lG37TXbE3GTdjTgLWD4+oDb6L9NAsPopyrdJ4g
         /C6kS15NKE2VwY6/C9TdW4gKbcfHMyP2Boa11q9n3nrm0gRpkqhTDDkw0j3g/xYqGOok
         Sp2w==
X-Gm-Message-State: ACgBeo0w2rHgAnaTmi67xA6zuuBUmYD4ETGYwNj0z/a1KG+Esgx7wqLg
        tIcAumBlCs3lHSypwnhW4nwk5J61yJ1xdQ==
X-Google-Smtp-Source: AA6agR45c8R5zmLVoCcaWl9OFFKl4X7Ju1osidR5GMsOOp33iBuc2Ent/3G7nLEzf6vSmtAgkeKzfQ==
X-Received: by 2002:a05:622a:591:b0:344:5946:8da5 with SMTP id c17-20020a05622a059100b0034459468da5mr14933246qtb.473.1661168820943;
        Mon, 22 Aug 2022 04:47:00 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id o13-20020a05620a2a0d00b006bad7a2964fsm10505731qkp.78.2022.08.22.04.46.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 04:46:59 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-3378303138bso244746567b3.9;
        Mon, 22 Aug 2022 04:46:59 -0700 (PDT)
X-Received: by 2002:a25:1f02:0:b0:695:92f8:5a58 with SMTP id
 f2-20020a251f02000000b0069592f85a58mr6143444ybf.604.1661168819290; Mon, 22
 Aug 2022 04:46:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220815050815.22340-1-samuel@sholland.org> <20220815050815.22340-7-samuel@sholland.org>
 <20220815141159.10edeba5@donnerap.cambridge.arm.com> <3cd9ed5b-8348-38ac-feb1-9a7da858cebc@microchip.com>
 <932aaefd-e2ca-ef26-bf30-e315fb271ec5@sholland.org> <ff9e8bd3-c5f7-6319-060e-250151087a8e@microchip.com>
 <c6cba83ea9eea7fc41a9e78d0e45487b21f0f560.camel@icenowy.me> <c7599abd-c4cf-9ddd-1e74-e47dec9366d4@microchip.com>
In-Reply-To: <c7599abd-c4cf-9ddd-1e74-e47dec9366d4@microchip.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 22 Aug 2022 13:46:47 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUHVpj9ikE2NxpBSBtTG8K6v92vGdbw3GLmEYUoVzatvg@mail.gmail.com>
Message-ID: <CAMuHMdUHVpj9ikE2NxpBSBtTG8K6v92vGdbw3GLmEYUoVzatvg@mail.gmail.com>
Subject: Re: [PATCH 06/12] riscv: dts: allwinner: Add the D1 SoC base devicetree
To:     Conor Dooley <Conor.Dooley@microchip.com>
Cc:     uwu@icenowy.me, Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor, Andre,

On Sun, Aug 21, 2022 at 12:07 PM <Conor.Dooley@microchip.com> wrote:
> On 21/08/2022 07:45, Icenowy Zheng wrote:
> > 在 2022-08-20星期六的 17:29 +0000，Conor.Dooley@microchip.com写道：
> >> On 20/08/2022 18:24, Samuel Holland wrote:
> >>> On 8/15/22 12:01 PM, Conor.Dooley@microchip.com wrote:
> >>>> On 15/08/2022 14:11, Andre Przywara wrote:
> >>>>> EXTERNAL EMAIL: Do not click links or open attachments unless
> >>>>> you know the content is safe
> >>>>>
> >>>>> On Mon, 15 Aug 2022 00:08:09 -0500
> >>>>> Samuel Holland <samuel@sholland.org> wrote:
> >>>>>
> >>>>> Hi,
> >>>>>
> >>>>> thanks for all the efforts in getting those SoC peripherals
> >>>>> supported!
> >>>>>
> >>>>>> D1 is a SoC containing a single-core T-HEAD Xuantie C906 CPU,
> >>>>>> as well as
> >>>>>> one HiFi 4 DSP. The SoC is based on a design that
> >>>>>> additionally contained
> >>>>>> a pair of Cortex A7's. For that reason, some peripherals are
> >>>>>> duplicated.
> >>>>>
> >>>>> So because of this, the Allwinner R528 and T113 SoCs would
> >>>>> share almost
> >>>>> everything in this file. Would it be useful to already split
> >>>>> this DT up?
> >>>>> To have a base .dtsi, basically this file without /cpus and
> >>>>> /soc/plic,
> >>>>> then have a RISC-V specific file with just those, including the
> >>>>> base?
> >>>>> There is precedence for this across-arch(-directories) sharing
> >>>>> with the
> >>>>> Raspberry Pi and Allwinner H3/H5 SoCs.
> >>>>
> >>>> For those playing along at home, one example is the arm64
> >>>> bananapi m2
> >>>> dts which looks like:
> >>>>> /dts-v1/;
> >>>>> #include "sun50i-h5.dtsi"
> >>>>> #include "sun50i-h5-cpu-opp.dtsi"
> >>>>> #include <arm/sunxi-bananapi-m2-plus-v1.2.dtsi>
> >>>>>
> >>>>> / {
> >>>>>         model = "Banana Pi BPI-M2-Plus v1.2 H5";
> >>>>>         compatible = "bananapi,bpi-m2-plus-v1.2",
> >>>>> "allwinner,sun50i-h5";
> >>>>> };
> >>>>
> >>>> I think this is a pretty good idea, and putting in the modularity
> >>>> up
> >>>> front seems logical to me, so when the arm one does eventually
> >>>> get
> >>>> added it can be done by only touching a single arch.
> >>>
> >>> This is not feasible, due to the different #interrupt-cells. See
> >>> https://lore.kernel.org/linux-riscv/CAMuHMdXHSMcrVOH+vcrdRRF+i2TkMcFisGxHMBPUEa8nTMFpzw@mail.gmail.com/
> >>>
> >>> Even if we share some file across architectures, you still have to
> >>> update files
> >>> in both places to get the interrupts properties correct.
> >>>
> >>> I get the desire to deduplicate things, but we already deal with
> >>> updating the
> >>> same/similar nodes across several SoCs, so that is nothing new. I
> >>> think it would
> >>> be more confusing/complicated to have all of the interrupts
> >>> properties
> >>> overridden in a separate file.
> >>
> >> Yeah, should maybe have circled back after that conversation, would
> >> have been
> >> nice but if the DTC can't do it nicely then w/e.
> >
> > Well, maybe we can overuse the facility of C preprocessor?
> >
> > e.g.
> >
> > ```
> > // For ARM
> > #define SOC_PERIPHERAL_IRQ(n) GIC_SPI n
> > // For RISC-V
> > #define SOC_PERIPHERAL_IRQ(n) n
> > ```
> >
>
> Geert pointed out that this is not possible (at least on the Renesas
> stuff) because the GIC interrupt numbers are not the same as the
> PLIC's & the DTC is not able to handle the addition:
> https://lore.kernel.org/linux-riscv/CAMuHMdXHSMcrVOH+vcrdRRF+i2TkMcFisGxHMBPUEa8nTMFpzw@mail.gmail.com/

Without the ability to do additions in DTC, we could e.g. list both
interrupts in the macro, like:

    // For ARM
    #define SOC_PERIPHERAL_IRQ(na, nr) GIC_SPI na
    // For RISC-V
    #define SOC_PERIPHERAL_IRQ(na, nr) nr

On Mon, Aug 22, 2022 at 12:52 PM Andre Przywara <andre.przywara@arm.com> wrote:
> There are interrupt-maps for that:
> sun8i-r528.dtsi:
>         soc {
>                 #interrupt-cells = <1>;
>                 interrupt-map = <0  18 &gic GIC_SPI  2 IRQ_TYPE_LEVEL_HIGH>,
>                                 <0  19 &gic GIC_SPI  3 IRQ_TYPE_LEVEL_HIGH>,
>                                 ....
>
> sun20i-d1.dtsi:
>         soc {
>                 #interrupt-cells = <1>;
>                 interrupt-map = <0  18 &plic  18 IRQ_TYPE_LEVEL_HIGH>,
>                                 <0  19 &plic  19 IRQ_TYPE_LEVEL_HIGH>,
>
> then, in the shared .dtsi:
>                 uart0: serial@2500000 {
>                         compatible = "snps,dw-apb-uart";
>                         ...
>                         interrupts = <18>;

Nice! But it's gonna be a very large interrupt-map.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
