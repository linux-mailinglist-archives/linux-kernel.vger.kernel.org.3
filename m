Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7084D461527
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 13:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377182AbhK2Mfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 07:35:50 -0500
Received: from mail-ua1-f46.google.com ([209.85.222.46]:42740 "EHLO
        mail-ua1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbhK2Mdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 07:33:47 -0500
Received: by mail-ua1-f46.google.com with SMTP id t13so33585678uad.9;
        Mon, 29 Nov 2021 04:30:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8PEIUoQlSa7P3fpibfgMKclAfPeJy9X1SLFDcaBhJyE=;
        b=K2aaS7zXrvDEYVP0xed/pUw49q4ajUL4AIK3rAs4e8NCha4ekvjJQEidhwTZI7vQec
         NBFvQAAzEAmNMTsqfIJplvxvdyYUYGBmjlv7k8e1vjOvm9GIt2fl+gZfnZ+L2kAyTH/6
         otZvq5oU4k0rhEPVZ3aUr3ckw9S2waFaMKNzaX8wLsJknsZYyS6SuYDD6fC2QzmVsaPX
         awvPxdLP3X9GJUyCwGoMF8A7t702Q7Th6x7TzHKhOBPCPYL9Xig4pwrbnjeCkxVIzXEA
         ICRmQZj6XYpOAg+XOZl/03TmQJeagPPwwvzdvyEPKteKZ6kR8qqACWGAy2DwMpGE703e
         ptMg==
X-Gm-Message-State: AOAM531NTxKJhD+RWvo4mqqUfzRgR1LYMq+iy1E0ouMv6cPc97kwImgm
        it6RKHNSNKNyG2guHhtL13zepwujDdKGig==
X-Google-Smtp-Source: ABdhPJxSF2tx4Ox31Gi2K8SyOdzDnIJzOUHx/0L011hyyduJh/7QOAZmPTQ+eeUSn0pZWXUpHJlB5Q==
X-Received: by 2002:a67:2f05:: with SMTP id v5mr30798497vsv.25.1638189029670;
        Mon, 29 Nov 2021 04:30:29 -0800 (PST)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id c21sm8290589vso.21.2021.11.29.04.30.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 04:30:29 -0800 (PST)
Received: by mail-vk1-f172.google.com with SMTP id s17so10907864vka.5;
        Mon, 29 Nov 2021 04:30:29 -0800 (PST)
X-Received: by 2002:a1f:4641:: with SMTP id t62mr17689913vka.0.1638189029111;
 Mon, 29 Nov 2021 04:30:29 -0800 (PST)
MIME-Version: 1.0
References: <20211126102339.28908-1-andriy.shevchenko@linux.intel.com>
 <CAK8P3a3GuGgdp7Gq5N9XKTGhKbBUym9BiEb94RWyL1CDxS0ffw@mail.gmail.com>
 <CAMuHMdV4HVn+GcCBNQ+1-Kva2XiHQ03L5y9JLXH7qONtBvkV+w@mail.gmail.com> <20211129122052.GA7921@alpha.franken.de>
In-Reply-To: <20211129122052.GA7921@alpha.franken.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 29 Nov 2021 13:30:17 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWbvpzZCs4HOXErbVYQTiQAB0syuiR6Wd7=sTA2vFpXzw@mail.gmail.com>
Message-ID: <CAMuHMdWbvpzZCs4HOXErbVYQTiQAB0syuiR6Wd7=sTA2vFpXzw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] MIPS: TXx9: Convert SPI platform data to software nodes
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Mon, Nov 29, 2021 at 1:21 PM Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:
> On Fri, Nov 26, 2021 at 01:16:22PM +0100, Geert Uytterhoeven wrote:
> > On Fri, Nov 26, 2021 at 11:58 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Fri, Nov 26, 2021 at 11:23 AM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > In order to get rid of legacy platform data in AT25 driver,
> > > > convert its users to use software nodes.
> > > >
> > > > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > >
> > > This looks good to me, thanks for cleaning this up! I think Geert has this
> > > hardware, adding him to Cc in case he wants to give it a spin.
> >
> > The SPI controller is only present on TX4938, not on TX4927, so it is
> > unused on my rbtx4927 board.
> >
> > > >  arch/mips/include/asm/txx9/spi.h    |  4 ++--
> > > >  arch/mips/txx9/generic/spi_eeprom.c | 32 +++++++++++++++++------------
> > > >  arch/mips/txx9/rbtx4938/setup.c     |  6 +++---
> > > >  3 files changed, 24 insertions(+), 18 deletions(-)
> >
> > Probably all of this can be removed, given the SPI controller driver
> > itself was removed in commit 74523a5dae0c96d6 ("spi: txx9: Remove
> > driver")?
>
> are you ok with completly removing rbtx4938 support ? Can I rbtx4939
> board support, too ?

Fine for me, I only have rbtx4927.

BTW, I'm using it in 32-bit mode, as the VxWorks bootloader cannot boot
64-bit images. Are there other boards with such a limitation? Perhaps
there's even shim support for booting 64-bit kernels on such boards,
so I can test both 32-bit and 64-bit kernels?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
