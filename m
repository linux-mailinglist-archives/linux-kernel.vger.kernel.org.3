Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFFF759962B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 09:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346683AbiHSHgH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 19 Aug 2022 03:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346639AbiHSHf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 03:35:59 -0400
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1238CACBE;
        Fri, 19 Aug 2022 00:35:55 -0700 (PDT)
Received: by mail-qv1-f50.google.com with SMTP id m17so2823242qvv.7;
        Fri, 19 Aug 2022 00:35:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=XRbV7J+2A2p1Es19V1DJXlJ5MTO6MnMsKMF62Ysfi58=;
        b=ayoQFi0HbRGHkvIJEnkfRugePk5YSwhWB/hNc7ZJ8OTHOvCWpPTgJ9RlgYnEj2M0ds
         Lcsmt6ARJ/y8obiGdLFEvw9IIfTPBkgeeWO/GHPinSbZVg/yt4N/W9dGAZtdLkY7Mfl+
         4rXSpMH1W+QCbUfsXIRY/tw43NaCFuX18HjeU+MmPR6sLriwZNhIZeAsdFyWI/zeK/Dj
         L3xc6TWHK0UTt1hdLAdVQUf0VfJN3YsnoWQPzp3akLvl2BI0LMuaO+wfbhgcym6iXF4X
         Br0jdqyJ2e22GfmnuAE4Q5MG/v5dPEj28luwEacoFZcKqwf5ExPcmFUJYqIkIPRWUlEL
         XxGg==
X-Gm-Message-State: ACgBeo01rVg6tc1G7WS3Tc1Sn1wSwsME5EVTFkgCUbDA5nXa4plaX2Er
        xYlJoPCx+NT+9TxMQ0hQyEO21Vvqp7GtCQ==
X-Google-Smtp-Source: AA6agR74Q1HXwdqQiTR3l0jvRGi+PALCd7mB25L96CAWRp1bEnuGKifVLLF3SbZ5nd4S5id7KTo2Xw==
X-Received: by 2002:ad4:5dcd:0:b0:476:a48d:4c43 with SMTP id m13-20020ad45dcd000000b00476a48d4c43mr5581966qvh.13.1660894554552;
        Fri, 19 Aug 2022 00:35:54 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id ge8-20020a05622a5c8800b003437a694049sm2527677qtb.96.2022.08.19.00.35.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 00:35:53 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-3378303138bso60761727b3.9;
        Fri, 19 Aug 2022 00:35:52 -0700 (PDT)
X-Received: by 2002:a5b:bcd:0:b0:68f:b4c0:7eca with SMTP id
 c13-20020a5b0bcd000000b0068fb4c07ecamr6552996ybr.202.1660894552417; Fri, 19
 Aug 2022 00:35:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220815151451.23293-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220815151451.23293-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdW29Q40hypWZ05KRj5cc=DY8XjnDwOPVw3kJPNUrnL0fA@mail.gmail.com>
 <CA+V-a8sVpEx==R6QXF8qxhVSsv2mVnZ_R3N2wTt+JPcQWNqCWQ@mail.gmail.com> <eeadea8e-a6bc-0965-1246-82b0042838e4@microchip.com>
In-Reply-To: <eeadea8e-a6bc-0965-1246-82b0042838e4@microchip.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 19 Aug 2022 09:35:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUPzukO8Cqk86NbPU-ytidr--Qumg6KzVcUqE4GWmumaQ@mail.gmail.com>
Message-ID: <CAMuHMdUPzukO8Cqk86NbPU-ytidr--Qumg6KzVcUqE4GWmumaQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] RISC-V: Kconfig.socs: Add Renesas RZ/Five SoC
 kconfig option
To:     Conor Dooley <Conor.Dooley@microchip.com>
Cc:     Prabhakar Lad <prabhakar.csengg@gmail.com>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Samuel Holland <samuel@sholland.org>
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

Hi Conor,

On Thu, Aug 18, 2022 at 8:54 PM <Conor.Dooley@microchip.com> wrote:
> On 18/08/2022 19:19, Lad, Prabhakar wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > On Thu, Aug 18, 2022 at 4:16 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >> On Mon, Aug 15, 2022 at 5:16 PM Lad Prabhakar
> >> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> >>> Introduce SOC_RENESAS_RZFIVE config option to enable Renesas RZ/Five
> >>> (R9A07G043) SoC, along side also add ARCH_RENESAS config option as most
> >>> of the Renesas drivers depend on this config option.
> >>>
> >>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >>
> >> Thanks for your patch!
> >>
> >> The technical part LGTM, so
> >> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >>
> >>> --- a/arch/riscv/Kconfig.socs
> >>> +++ b/arch/riscv/Kconfig.socs
> >>> @@ -80,4 +80,18 @@ config SOC_CANAAN_K210_DTB_SOURCE
> >>>
> >>>  endif # SOC_CANAAN
> >>>
> >>> +config ARCH_RENESAS
> >>
> >> We definitely want ARCH_RENESAS, as it serves as a gatekeeper for
> >> Kconfig options for IP cores found on Renesas ARM and RISC-V SoCs.
> >>
> > Agreed, or else we will end up touching too many Kconfig files.
> >
> >>> +       bool
> >>> +       select GPIOLIB
> >>> +       select PINCTRL
> >>> +       select SOC_BUS
> >>> +
> >>> +config SOC_RENESAS_RZFIVE
> >>
> >> Do we need this symbol? You could as well make ARCH_RENESAS above
> >> visible, and defer the actual SoC selection to ARCH_R9A07G043 in
> >> drivers/soc/renesas/Kconfig[1].
> >>
> > I think we could drop it and just defer the actual SoC selection to
> > ARCH_R9A07G043 as you said.
> >
> >> I don't know what is the policy on RISC-V. ARM64 has a "single-symbol
> >> in arch/arm64/Kconfig.platforms"-policy, so we handle SoC selection
> >> in drivers/soc/renesas/Kconfig, and that is fine, as it avoids merge
> >> conflicts.
> >>
> > Agreed.
> >
> > @Conor - Does the above sound OK?
>
> It's not my decision to be honest - Palmer's the boss :)
>
> I would rather have a single symbol & a single approach so that we are
> all doing the same thing here. As of now, we have all basically done
> different things for each SOC that was added - there's SOC_SIFIVE &
> SOC_MICROCHIP_POLARFIRE which are obviously not doing the same thing
> for starters & then how the symbol is used: selects vs depends + default
> all varies between the symbols.
>
> I tried to make some changes to the PolarFire one a few months ago to
> add some peripherals but Palmer was not too keen on the changes. We had
> a conversation on IRC, the upshot of which was deciding to talk about it
> at Plumbers (which is in 3 weeks) as none of them follow his original
> intent:
> <quote>
> the original idea behind Kconfig.socs was to provide an easy place for
> users to say "I want all the support for SOC X", and then just have one
> Kconfig to turn that on
> <\quote>

For whatever definition of "all"? Does this include e.g. all
multi-media stuff?

For Renesas ARM SoCs, we make sure to select the critical core parts,
cfr. the selects above, and in drivers/soc/renesas/Kconfig.
These selects do not include optional drivers, including the serial
port (cfr. your confusion about adding CONFIG_SERIAL_SH_SCI=y
to the defconfig).
All the rest is handled by the defconfigs (shmobile_defconfig on
arm32, single defconfig on arm64, and out-of-tree renesas_defconfig
in my renesas-devel tree).

> In theory, that's lovely but not really maintainable & none of us were
> doing it anyway. Hopefully we can come up with a plan at Plumbers - so
> feel free to chime in (or maybe it gets sorted out here and I don't
> have to do any public speaking 😍).

Ah, there is my good reason for registering for LPC ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
