Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34DCC47FB6A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 10:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbhL0JpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 04:45:24 -0500
Received: from mail-ua1-f54.google.com ([209.85.222.54]:39908 "EHLO
        mail-ua1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbhL0JpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 04:45:22 -0500
Received: by mail-ua1-f54.google.com with SMTP id i6so25777111uae.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 01:45:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9VWkN9Ic5T8Pvesa2u60ac8nLrKPkt/2hy5C5DzE2lk=;
        b=yHBL6GsfpPSoKZTRa5a27jusd1RrftmI03XvU0MpBzK9NDYRxF5Ov6e8eKnVmzeHJY
         F7lIFueYjByYs9hMiFX8Vtao6Cn1RZCkGFoyJUAjQPTCsnC2clzeJUD+95uVd4biUNI6
         NqPYffjtv53sqlWnfSrt66TXjPNMib9hhFK0S0wmGt6eZk7GOjUQgUlkPwCA8dG0eCNv
         PiGkd5P7vE952eyNnE+UlPJx34jvWdt53MtNsmPxw4AjraHZ63rpf0gyUj/z8J6uad6D
         TK1FoMLeNVMK6DDIRc9+eo4+AWpYnzJZIMZScS7yfh0kLARI2iUh8zxk1s2eRSB9bVnk
         /l5g==
X-Gm-Message-State: AOAM530NvIJeG88PsiCV4Hb3iFXl9p4RlAQSPZxwxDXYXGTh4N3pVVPj
        Jki2QQs3GQG5/n9JhXvn+TCEXqkFNSW5kA==
X-Google-Smtp-Source: ABdhPJz9QOQ9/UgSEigzexyIR1oOXuLxyMK+uIMSkWjNHOBcpX4K33n2I1r33G+leAyL/0/MZRTzzw==
X-Received: by 2002:a05:6102:242a:: with SMTP id l10mr4568763vsi.26.1640598321795;
        Mon, 27 Dec 2021 01:45:21 -0800 (PST)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id n184sm2906087vkn.12.2021.12.27.01.45.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Dec 2021 01:45:21 -0800 (PST)
Received: by mail-ua1-f46.google.com with SMTP id p2so25799665uad.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 01:45:21 -0800 (PST)
X-Received: by 2002:a05:6102:21dc:: with SMTP id r28mr4536107vsg.57.1640598321199;
 Mon, 27 Dec 2021 01:45:21 -0800 (PST)
MIME-Version: 1.0
References: <20211215234946.6494-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAHp75VfGwQ7G2b39GO4tN=sxQoiahO2uudy25ALxEkrNcP9eVw@mail.gmail.com>
 <CA+V-a8t1myOt0rhJExem_T2tJUM3PLL9KuXn0=_LtucJPHLkbA@mail.gmail.com>
 <CAHp75VdXKVAZMKqC=0RbkAKKxFsdcxBc0M3N6OQMivHj-w+DHw@mail.gmail.com>
 <CA+V-a8vbsy94MvRpqWQQuRqfEGiX_ZZTTt+dr0r6qnnJAPaEmA@mail.gmail.com> <CAHp75VfvOOzwcTBjYg3OzbbdhcpWfaPWZ0h7HZRFOPEQAQMT=A@mail.gmail.com>
In-Reply-To: <CAHp75VfvOOzwcTBjYg3OzbbdhcpWfaPWZ0h7HZRFOPEQAQMT=A@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 27 Dec 2021 10:45:09 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWSAOEAvqvr1UqKKmVDMzY3Tb8Y_4XowFPBN6L3TESqYA@mail.gmail.com>
Message-ID: <CAMuHMdWSAOEAvqvr1UqKKmVDMzY3Tb8Y_4XowFPBN6L3TESqYA@mail.gmail.com>
Subject: Re: [PATCH] irqchip/renesas-irqc: Use platform_get_irq_optional() to
 get the interrupt
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Sun, Dec 26, 2021 at 9:49 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Sun, Dec 26, 2021 at 1:59 AM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> > On Sat, Dec 25, 2021 at 5:40 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Sat, Dec 25, 2021 at 7:28 PM Lad, Prabhakar
> > > <prabhakar.csengg@gmail.com> wrote:
> > > > On Sat, Dec 25, 2021 at 4:46 PM Andy Shevchenko
> > > > <andy.shevchenko@gmail.com> wrote:
> > > > > On Thu, Dec 16, 2021 at 9:52 AM Lad Prabhakar
> > > > > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > >
> > > > > ret = platform_get_irq_optional(...);
> > > > > if (ret < 0 && ret != -ENXIO)
> > > > >   return ret;
> > > > > if (ret > 0)
> > > > >   ...we got it...
> > > > >
> > > > > It will allow the future API fix of platform_get_irq_optional() to be
> > > > > really optional.
> > > > >
> > > > Later patch [0] (merged into -next) does check for -ENXIO first.
> > > >
> > > > [0] https://lore.kernel.org/lkml/20211216182121.5323-1-prabhakar.mahadev-lad.rj@bp.renesas.com/t/
> > >
> > > The problem is that it doesn't consider 0 as no IRQ.
> > >
> > Can you please point me to the discussion/patch where this API change
> > is considered/discussed. Just to clarify now the new API for
> > platform_get_irq_optional() will return "0" in case there is no
> > interrupt and not not -ENXIO anymore?
>
> The longest one happened here:
> https://lore.kernel.org/linux-ide/20211209145937.77719-1-andriy.shevchenko@linux.intel.com/T/#u
>
> It has links to some other discussions on the topic.
>
> > When will this patch be merged for the new api, so that I can base my
> > patches on top of it to avoid more changes?
>
> You can simply imply that, I dunno when it gets merged (from my point
> of view the users should be fixed first, and since you are adding
> users, the burden is increasing).

Not only users (drivers), but also providers (architecture-specific code).
IRQ zero is still valid on some architectures, e.g. on SH[1].

[1] https://lore.kernel.org/linux-renesas-soc/CAMuHMdUg3=q7gyaVHP0XcYUOo3PQUUv8Hc8wp5faVQ+bTBpg4A@mail.gmail.com/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
