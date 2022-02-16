Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01154B8D54
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 17:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236030AbiBPQJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 11:09:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236013AbiBPQJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 11:09:29 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1D3BD2CD
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 08:09:15 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id n5so110239ilk.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 08:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X1DbyhBVBvnUPYaFyX9FKtS0pYUg5/jmB2DYqrFTT5U=;
        b=J+IlJwKwqNmOWrnf9XmZjoqXa0NqIoyKOJfIcTZrmFWEeZLQaOlywhGandqivrs4pJ
         B89cnA5e/+9qJQzIowUnlXGsCr65LTNHTGRRyzH5tTmj1I2LpsNBTLDSMItBBmKJuPVZ
         f4twJbUofcE5FHVhwVxSjSLIeQ71xPPXnfWFL1Tv0cdLNLR5Ou5czua9VLjsjBWmcJUr
         XCGwJtkNEmHkcsMwl0WkstoebpSHASn+bBGPtRt7JDqF46ZWwteM9qav+cGSv74qfNvJ
         e+5a+XgdW2fSFzlxfQ2ruUrOLVuaB/neINyCjXDMLwnj41WMvQXFGlS19PYvPvu6hqBL
         buXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X1DbyhBVBvnUPYaFyX9FKtS0pYUg5/jmB2DYqrFTT5U=;
        b=kBD7UXYPtc5Ljdmn8t2lFErT+deCzPUzJIoVQNja6l2uRkPBrj0+9jR70fdeh4lvTo
         xTy0Zzz+6GKrEKzRsgPO+Og3g/fmzONiW5jaOGhabCcXm+4GONiqdsbs9BIQW6pzT1gV
         +8FcQ2rZWfsqgGgQ12zFcujwCa4VMRYFg5McBg8iplTnUOlgIwP81P0OWQrPTe+8REHg
         tfOXaqV+YYClUQ885zGXU3tAocK6ocUdrikMSEcAFiRqltrJbO6aelttp2ozfq8wjSlO
         i1g0uez9ASNtJq2xE+aGAbSayRqrqUFEo+SWVF1kKepowgysWIXHINfThwh9uGIu8m7P
         JhHQ==
X-Gm-Message-State: AOAM5305v1SKhlhp5DSW9X90Vh8D8AxO4yebKxqs35/+1NpTUnNQYCgx
        CT5V+4woqn+scTV83HTERC4vc5Yj8W4AIewQ7Jc/e5iqBKMhXxpj
X-Google-Smtp-Source: ABdhPJzW137+bxo/BCmaOoW3nCBMoRhmtQOnwHbg2dFkNZBf4NGOeG+OlNhTXXA6mrUdvAiuLoTMApI3sUxPNcHaTLc=
X-Received: by 2002:a05:6e02:1a26:b0:2bc:2e01:ae73 with SMTP id
 g6-20020a056e021a2600b002bc2e01ae73mr2263040ile.44.1645027754573; Wed, 16 Feb
 2022 08:09:14 -0800 (PST)
MIME-Version: 1.0
References: <00000000000038779505d5d8b372@google.com> <CANp29Y7WjwXwgxPrNq0XXjXPu+wGFqTreh9gry=O6aE7+cKpLQ@mail.gmail.com>
 <CA+zEjCvu76yW7zfM+qJUe+t5y23oPdzR4KDV1mOdqH8bB4GmTw@mail.gmail.com>
 <CACT4Y+arufrRgwmN66wUU+_FGxMy-sTkjMQnRN8U2H2tQuhB7A@mail.gmail.com>
 <a0769218-c84a-a1d3-71e7-aefd40bf54fe@ghiti.fr> <CANp29Y4WMhsE_-VWvNbwq18+qvb1Qc-ES80h_j_G-N_hcAnRAw@mail.gmail.com>
 <CANp29Y4ujmz901aE9oiBDx9dYWHti4-Jw=6Ewtotm6ck6MN9FQ@mail.gmail.com> <CACT4Y+ZvStiHLYBOcPDoAJnk8hquXwm9BgjQTv=APwh7AvgEUQ@mail.gmail.com>
In-Reply-To: <CACT4Y+ZvStiHLYBOcPDoAJnk8hquXwm9BgjQTv=APwh7AvgEUQ@mail.gmail.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Wed, 16 Feb 2022 17:09:03 +0100
Message-ID: <CANp29Y56Or0V1AG7rzBfV_ZTph2Crg4JKKHiuw1kcGFFxeWqiQ@mail.gmail.com>
Subject: Re: [syzbot] riscv/fixes boot error: can't ssh into the instance
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Alexandre Ghiti <alex@ghiti.fr>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        linux-riscv@lists.infradead.org,
        kasan-dev <kasan-dev@googlegroups.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        syzbot <syzbot+330a558d94b58f7601be@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 12:56 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Wed, 16 Feb 2022 at 12:47, Aleksandr Nogikh <nogikh@google.com> wrote:
> >
> > On Wed, Feb 16, 2022 at 11:37 AM Aleksandr Nogikh <nogikh@google.com> wrote:
> > >
> > > Hi Alex,
> > >
> > > On Wed, Feb 16, 2022 at 5:14 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
> > > >
> > > > Hi Dmitry,
> > > >
> > > > On 2/15/22 18:12, Dmitry Vyukov wrote:
> > > > > On Wed, 2 Feb 2022 at 14:18, Alexandre Ghiti
> > > > > <alexandre.ghiti@canonical.com> wrote:
> > > > >> Hi Aleksandr,
> > > > >>
> > > > >> On Wed, Feb 2, 2022 at 12:08 PM Aleksandr Nogikh <nogikh@google.com> wrote:
> > > > >>> Hello,
> > > > >>>
> > > > >>> syzbot has already not been able to fuzz its RISC-V instance for 97
> > > > >> That's a longtime, I'll take a look more regularly.
> > > > >>
> > > > >>> days now because the compiled kernel cannot boot. I bisected the issue
> > > > >>> to the following commit:
> > > > >>>
> > > > >>> commit 54c5639d8f507ebefa814f574cb6f763033a72a5
> > > > >>> Author: Alexandre Ghiti <alexandre.ghiti@canonical.com>
> > > > >>> Date:   Fri Oct 29 06:59:27 2021 +0200
> > > > >>>
> > > > >>>      riscv: Fix asan-stack clang build
> > > > >>>
> > > > >>> Apparently, the problem appears on GCC-built RISC-V kernels with KASAN
> > > > >>> enabled. In the previous message syzbot mentions
> > > > >>> "riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU
> > > > >>> Binutils for Debian) 2.35.2", but the issue also reproduces finely on
> > > > >>> a newer GCC compiler: "riscv64-linux-gnu-gcc (Debian 11.2.0-10)
> > > > >>> 11.2.0, GNU ld (GNU Binutils for Debian) 2.37".
> > > > >>> For convenience, I also duplicate the .config file from the bot's
> > > > >>> message: https://syzkaller.appspot.com/x/.config?x=522544a2e0ef2a7d
> > > > >>>
> > > > >>> Can someone with KASAN and RISC-V expertise please take a look?
> > > > >> I'll take a look at that today.
> > > > >>
> > > > >> Thanks for reporting the issue,
> > > > >
> > > >
> > > > I took a quick look, not enough to fix it but I know the issue comes
> > > > from the inline instrumentation, I have no problem with the outline
> > > > instrumentation. I need to find some cycles to work on this, my goal is
> > > > to fix this for 5.17.
> > >
> > > Thanks for the update!
> > >
> > > Can you please share the .config with which you tested the outline
> > > instrumentation?
> > > I updated the syzbot config to use KASAN_OUTLINE instead of KASAN_INLINE,
> > > but it still does not boot :(
> > >
> > > Here's what I used:
> > > https://gist.github.com/a-nogikh/279c85c2d24f47efcc3e865c08844138
> >
> > Update: it doesn't boot with that big config, but boots if I generate
> > a simple one with KASAN_OUTLINE:
> >
> > make defconfig ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu-
> > ./scripts/config -e KASAN -e KASAN_OUTLINE
> > make olddefconfig ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu-
> >
> > And it indeed doesn't work if I use KASAN_INLINE.
>
> It may be an issue with code size. Full syzbot config + KASAN + KCOV
> produce hugely massive .text. It may be hitting some limitation in the
> bootloader/kernel bootstrap code.

I bisected the difference between the config we use on syzbot and the
simple one that was generated like I described above.
Turns out that it's the DEBUG_VIRTUAL config that makes the difference.

make defconfig ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu-
./scripts/config -e KASAN -e KASAN_OUTLINE -e DEBUG_VIRTUAL
make olddefconfig ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu-

And the resulting kernel does not boot.
My env: the `riscv/fixes` branch, commit
6df2a016c0c8a3d0933ef33dd192ea6606b115e3, qemu 6.2.0.
