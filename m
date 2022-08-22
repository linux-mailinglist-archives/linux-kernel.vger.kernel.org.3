Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E9059BFA1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 14:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbiHVMjN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 22 Aug 2022 08:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbiHVMjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 08:39:11 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30E427FE3;
        Mon, 22 Aug 2022 05:39:10 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-11d2dcc31dbso4534381fac.7;
        Mon, 22 Aug 2022 05:39:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=JCvE0tIGIUKI4T1pwdPJfxx9bq80QkcidAq/OURkvig=;
        b=TnFomN9yc9WJqaezfls/7EEodCjHDxDUWZvyLb/4SIfQkIEPbjV6FZQjsFy9SbJn1K
         sc/yA/KXIpq0uz/wBmfomi86JLC8m4cHPSqKdJTPJuzmBs/VL8QRECcyqnViyN8MK1Tg
         MwtGNYQFNcizQy7cqowHRGJ1w3fal+kHUMAlEc2btRlRPmw0BmcXlPZljJ03cT6KfD+N
         Wdqg1rzX2QHr1cZuzSQk6bEMz3Txg7Gv/BzlLnzpc66mbxwfppa9tIEMFS1rvBVV2mup
         U888Y43rTMBYJ3FNvLQSFuG0m1hjoJ9E1gyFSK53YlxUjhsbmpEm8/+oaPb79k3iNWGB
         SsJg==
X-Gm-Message-State: ACgBeo1sSS6MJaChNqkLxCPvY4yVKWNtMJG0sRcNCBktdw1ViT3ps+An
        smNid+HbmadwGYvC5gNvQjlIGchIEEo0pA==
X-Google-Smtp-Source: AA6agR60TzS5gSPuA5PbCprheU8HG/PMfogIWug9+T4yzYfrI24U0mUg9HYllyIAVFD8GXO9VKyDyg==
X-Received: by 2002:a05:6870:b28d:b0:10b:d7fb:ba63 with SMTP id c13-20020a056870b28d00b0010bd7fbba63mr12399831oao.90.1661171949870;
        Mon, 22 Aug 2022 05:39:09 -0700 (PDT)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com. [209.85.210.46])
        by smtp.gmail.com with ESMTPSA id s3-20020a9d7583000000b0063703952843sm2971185otk.47.2022.08.22.05.39.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 05:39:09 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id q39-20020a056830442700b0063889adc0ddso7605930otv.1;
        Mon, 22 Aug 2022 05:39:09 -0700 (PDT)
X-Received: by 2002:a5b:6c1:0:b0:669:a7c3:4c33 with SMTP id
 r1-20020a5b06c1000000b00669a7c34c33mr18348478ybq.543.1661171513514; Mon, 22
 Aug 2022 05:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220815050815.22340-1-samuel@sholland.org> <20220815050815.22340-7-samuel@sholland.org>
 <20220815141159.10edeba5@donnerap.cambridge.arm.com> <3cd9ed5b-8348-38ac-feb1-9a7da858cebc@microchip.com>
 <932aaefd-e2ca-ef26-bf30-e315fb271ec5@sholland.org> <ff9e8bd3-c5f7-6319-060e-250151087a8e@microchip.com>
 <c6cba83ea9eea7fc41a9e78d0e45487b21f0f560.camel@icenowy.me>
 <c7599abd-c4cf-9ddd-1e74-e47dec9366d4@microchip.com> <CAMuHMdUHVpj9ikE2NxpBSBtTG8K6v92vGdbw3GLmEYUoVzatvg@mail.gmail.com>
 <538ae41e-664f-2efb-f941-9a063b727b6a@microchip.com>
In-Reply-To: <538ae41e-664f-2efb-f941-9a063b727b6a@microchip.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 22 Aug 2022 14:31:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWWbR+Y=bJ7gdqV3d+ffHE1-hwQf-Owb8FAvZAaScdOgA@mail.gmail.com>
Message-ID: <CAMuHMdWWbR+Y=bJ7gdqV3d+ffHE1-hwQf-Owb8FAvZAaScdOgA@mail.gmail.com>
Subject: Re: [PATCH 06/12] riscv: dts: allwinner: Add the D1 SoC base devicetree
To:     Conor Dooley <Conor.Dooley@microchip.com>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Mon, Aug 22, 2022 at 2:13 PM <Conor.Dooley@microchip.com> wrote:
> On 22/08/2022 12:46, Geert Uytterhoeven wrote:
> > On Sun, Aug 21, 2022 at 12:07 PM <Conor.Dooley@microchip.com> wrote:
> >> On 21/08/2022 07:45, Icenowy Zheng wrote:
> >>> 在 2022-08-20星期六的 17:29 +0000，Conor.Dooley@microchip.com写道：
> >>>> On 20/08/2022 18:24, Samuel Holland wrote:
>
> >>>>> This is not feasible, due to the different #interrupt-cells. See
> >>>>> https://lore.kernel.org/linux-riscv/CAMuHMdXHSMcrVOH+vcrdRRF+i2TkMcFisGxHMBPUEa8nTMFpzw@mail.gmail.com/
> >>>>>
> >>>>> Even if we share some file across architectures, you still have to
> >>>>> update files
> >>>>> in both places to get the interrupts properties correct.
> >>>>>
> >>>>> I get the desire to deduplicate things, but we already deal with
> >>>>> updating the
> >>>>> same/similar nodes across several SoCs, so that is nothing new. I
> >>>>> think it would
> >>>>> be more confusing/complicated to have all of the interrupts
> >>>>> properties
> >>>>> overridden in a separate file.
> >>>>
> >>>> Yeah, should maybe have circled back after that conversation, would
> >>>> have been
> >>>> nice but if the DTC can't do it nicely then w/e.
> >>>
> >>> Well, maybe we can overuse the facility of C preprocessor?
> >>>
> >>> e.g.
> >>>
> >>> ```
> >>> // For ARM
> >>> #define SOC_PERIPHERAL_IRQ(n) GIC_SPI n
> >>> // For RISC-V
> >>> #define SOC_PERIPHERAL_IRQ(n) n
> >>> ```
> >>>
> >>
> >> Geert pointed out that this is not possible (at least on the Renesas
> >> stuff) because the GIC interrupt numbers are not the same as the
> >> PLIC's & the DTC is not able to handle the addition:
> >> https://lore.kernel.org/linux-riscv/CAMuHMdXHSMcrVOH+vcrdRRF+i2TkMcFisGxHMBPUEa8nTMFpzw@mail.gmail.com/
> >
> > Without the ability to do additions in DTC, we could e.g. list both
> > interrupts in the macro, like:
> >
> >      // For ARM
> >      #define SOC_PERIPHERAL_IRQ(na, nr) GIC_SPI na
> >      // For RISC-V
> >      #define SOC_PERIPHERAL_IRQ(na, nr) nr
>
> Do you think this is worth doing? Or are you just providing an
> example of what could be done?

Just some brainstorming...

> Where would you envisage putting these macros? I forget the order
> of the CPP operations that are done, can they be put in the dts?

The SOC_PERIPHERAL_IRQ() macro should be defined in the
ARM-based SoC.dtsi file and the RISC-V-based SoC.dtsi file.

> > On Mon, Aug 22, 2022 at 12:52 PM Andre Przywara <andre.przywara@arm.com> wrote:
> >> There are interrupt-maps for that:
> >> sun8i-r528.dtsi:
> >>          soc {
> >>                  #interrupt-cells = <1>;
> >>                  interrupt-map = <0  18 &gic GIC_SPI  2 IRQ_TYPE_LEVEL_HIGH>,
> >>                                  <0  19 &gic GIC_SPI  3 IRQ_TYPE_LEVEL_HIGH>,
> >>                                  ....
> >>
> >> sun20i-d1.dtsi:
> >>          soc {
> >>                  #interrupt-cells = <1>;
> >>                  interrupt-map = <0  18 &plic  18 IRQ_TYPE_LEVEL_HIGH>,
> >>                                  <0  19 &plic  19 IRQ_TYPE_LEVEL_HIGH>,
> >>
> >> then, in the shared .dtsi:
> >>                  uart0: serial@2500000 {
> >>                          compatible = "snps,dw-apb-uart";
> >>                          ...
> >>                          interrupts = <18>;
> >
> > Nice! But it's gonna be a very large interrupt-map.
>
> I quite like the idea of not duplicating files across the archs
> if it can be helped, but not at the expense of making them hard to
> understand & I feel like unfortunately the large interrupt map is
> in that territory.

I feel the same.
Even listing both interrupt numbers in SOC_PERIPHERAL_IRQ(na, nr)
is a risk for making mistakes.

So personally, I'm in favor of teaching dtc arithmetic, so we can
handle the offset in SOC_PERIPHERAL_IRQ().

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
