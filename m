Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3EB5314D0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237626AbiEWPME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 11:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237587AbiEWPL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 11:11:59 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDAC47AEC;
        Mon, 23 May 2022 08:11:57 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id c10so19567049edr.2;
        Mon, 23 May 2022 08:11:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0QPzY5dv4g1MBNtDQB96ePR1IDzyzraTlb4TcmcBYLI=;
        b=drb7p5u1yRpP455qf5piYTpoXrza+dHWO3cX6HwTu/Cp9ZtutdaTNwvhMHrxngkXA2
         z2a/m6JoN/+dNwk7NTKEiJ4RFyAiZhaTC6XPLqucHQmrxyA95AvumfbRqoVBvOrrhipH
         67QIdfCuixdD/0khTRXF2Gt3iAuYvT9XTOFpnNOjF9Ab46zRfeuT4OGktMkIgyO52HYE
         qL6IVp7GFU36/AxJeM/UK2V7TuZA720sG/KEzF0HmI2G0tcZ+RdxOz2lbX3qD72dZejE
         AJLu6c1qnXvgIuVQt93KGbuUxE3oHKO+NQFpPYc7j8RJVZPQolvuxZXwhrrf1XY8D8Ot
         mwrQ==
X-Gm-Message-State: AOAM531303ivmkc6X5ETqX2Qgtp8OEwR0qT2sNYfjOxjMDUe1o6l8/VS
        lDtNphR1y80nm6jp35OyDp7vE7OUxK66fbon
X-Google-Smtp-Source: ABdhPJyzJtYNQF9FW8ZDSNAhOVugSa25KhyQNGZ8/xGycXW0STeEPhPlSRI9XDapoAu/NQaJ1Y1c4A==
X-Received: by 2002:a50:fe8d:0:b0:42a:b3a4:6ac2 with SMTP id d13-20020a50fe8d000000b0042ab3a46ac2mr24108454edt.131.1653318714696;
        Mon, 23 May 2022 08:11:54 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id ci18-20020a170907267200b006fe8c831632sm5794165ejc.73.2022.05.23.08.11.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 08:11:54 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id f2so21873480wrc.0;
        Mon, 23 May 2022 08:11:54 -0700 (PDT)
X-Received: by 2002:a05:6512:1520:b0:443:ec43:5fe8 with SMTP id
 bq32-20020a056512152000b00443ec435fe8mr16745443lfb.589.1653318703688; Mon, 23
 May 2022 08:11:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220522155046.260146-1-tmaimon77@gmail.com> <20220522155046.260146-12-tmaimon77@gmail.com>
 <86cd6a37-70ad-3a90-bc8a-dcd8b41f1175@linaro.org> <CAP6Zq1i2Wj4FCA4-eseVoJyMof5=ocFCUcitVquJqYJ4Z3JTYQ@mail.gmail.com>
 <CAMuHMdVCCrKTpNHng2_kKGViuEXf=O3MsfpjjzMusuUcKE6HiA@mail.gmail.com> <62562cdf-93e3-f642-5bbd-48329eff33ea@linaro.org>
In-Reply-To: <62562cdf-93e3-f642-5bbd-48329eff33ea@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 23 May 2022 17:11:30 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVFV02t+vbwzEpNbpkSP4M3sGnJpzFMPBw7RkrJ9YvyKw@mail.gmail.com>
Message-ID: <CAMuHMdVFV02t+vbwzEpNbpkSP4M3sGnJpzFMPBw7RkrJ9YvyKw@mail.gmail.com>
Subject: Re: [PATCH v1 11/19] dt-bindings: reset: npcm: Add support for NPCM8XX
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Tomer Maimon <tmaimon77@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        =?UTF-8?Q?Bj=C3=B6rn_Andersson?= <bjorn.andersson@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Vinod Koul <vkoul@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Robert Hancock <robert.hancock@calian.com>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Lubomir Rintel <lkundrak@v3.sk>, arm-soc <soc@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Mon, May 23, 2022 at 4:26 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 23/05/2022 16:22, Geert Uytterhoeven wrote:
> > On Mon, May 23, 2022 at 4:03 PM Tomer Maimon <tmaimon77@gmail.com> wrote:
> >> On Mon, 23 May 2022 at 12:01, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> >>> On 22/05/2022 17:50, Tomer Maimon wrote:
> >>>> Add binding document and device tree binding
> >>>> constants for Nuvoton BMC NPCM8XX reset controller.
> >>>>
> >>>> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> >
> >>>> --- /dev/null
> >>>> +++ b/include/dt-bindings/reset/nuvoton,npcm8xx-reset.h
> >>>> @@ -0,0 +1,124 @@
> >>>> +/* SPDX-License-Identifier: GPL-2.0 */
> >>>> +// Copyright (c) 2022 Nuvoton Technology corporation.
> >>>> +
> >>>> +#ifndef _DT_BINDINGS_NPCM8XX_RESET_H
> >>>> +#define _DT_BINDINGS_NPCM8XX_RESET_H
> >>>> +
> >>>> +#define NPCM8XX_RESET_IPSRST1                0x20
> >>>> +#define NPCM8XX_RESET_IPSRST2                0x24
> >>>> +#define NPCM8XX_RESET_IPSRST3                0x34
> >>>> +#define NPCM8XX_RESET_IPSRST4                0x74
> >>>
> >>> What are these? All IDs should be incremental, decimal and start from 0.
> >>
> >> Register offset, we use the same method in NPCM7xx. please refer
> >> https://elixir.bootlin.com/linux/v5.18/source/include/dt-bindings/reset/nuvoton,npcm7xx-reset.h
> >>
> >> and the driver asserts the reset according to the reset include definitions
> >
> > So if they're easy to look up the values, you could do without the
> > definitions? Cfr. the interrupts properties in .dtsi files, where we
> > typically just use the hardcoded numbers.
> >
> > If you do decide to keep them, a comment explaining their origins
> > would be useful.
> >
> >>>> +
> >>>> +/* Reset lines on IP1 reset module (NPCM8XX_RESET_IPSRST1) */
> >>>> +#define NPCM8XX_RESET_GDMA0          3
> >>>
> >>> IDs start from 0 and do not have holes.
> >>
> >> This represents the reset BIT in the reset register.
> >
> > Likewise, I think it's a good idea to document that in a comment, cfr.
> > https://elixir.bootlin.com/linux/v5.18/source/include/dt-bindings/power/r8a7795-sysc.h#L8
>
> Renesas is also doing it not correct (just like many others). The
> bindings are not for register bits or offsets. Such data can be DTS but
> not part of bindings.

I think you are taking a too-extremist standpoint.
The two extremes are:
  1. Numbers correspond to hardware numbers, and are easy to look up
    in the hardware documentation (e.g. GIC SPI interrupt numbers).
     => Use the hardcoded numbers in DTS.
  2. Numbers do not correspond to hardware numbers, so we had to
     invent our own definitions and numbers, usually loosely
     based on some table in the hardware documentation.
     The driver will have to look up the numbers in a data
     structure, to know how to program the hardware.
     The numbers become part of the DT ABI, and cannot be changed
     (header file is append-only).
     => Use the binding definitions in DTS.

We are taking the middle ground: there is a one-to-one relation between
numbers and hardware numbers that can be looked up in or derived from
the hardware documentation, but the conversion is non-trivial (for the
casual human reviewer), or the documentation refers to names instead
of numbers in most sections (e.g. named power domains). Then why not
let the numbers match some feature in the hardware (e.g. register
offset or register bit)?

> Imagine now you made mistake in this register
> offset and hardware uses slightly different value. What now? Change
> bindings? No. Bindings hold here ID, the abstraction, and ID stays fixed.

I see no difference here with using the wrong interrupt number in an
interrupts property in DTS.  What do we do in that case? Fix the DTS.

BTW, are you aware of any driver that transforms interrupt numbers
obtained from DTS, because the DTS used the wrong number?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
