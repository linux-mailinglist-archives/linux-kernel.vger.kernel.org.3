Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E3F4BA6BC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 18:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243585AbiBQRI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 12:08:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237119AbiBQRI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 12:08:27 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7127B171286
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 09:08:12 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id q20so2149788ioi.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 09:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M11Cv6Sf/j5dBAWER/x//EgaASJgRbtSRPsqwYtb7M4=;
        b=AQ/k55OjpjGBB1pLkNFlC+B4Rqjq1fFpYg5CWkuHo4cjDdAbCAo3Lc79LQGsvtj/RF
         rDW48u3nVT+DhEbuxVoUB8m6H25pvVyJICHiCp1Aw41/bpjCeoe0T4oces4UdzEB+tMD
         7rIPNu/QXKZttNEFVzZn+psJ0FHqQV+FbrCxEGPtGOKHloBGt/HoRprd9lUGW1k2Pdy4
         FUhDkepXMh/hblE2VOmrhVy1ZlyjDYgOwNkzPsWc0aauENwk24GT8UD4SypDWGKX26Sl
         1NKFiSXKBflQPL/NtcN1Llc1XlrcmvxRs1DDRH/YOuTt714XkvP67ZUsoCIBGP5DQt+v
         2F5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M11Cv6Sf/j5dBAWER/x//EgaASJgRbtSRPsqwYtb7M4=;
        b=UN/wqa3pxWXx0B6vug2KlY2pKfOp9V2YIXbwwipZFTADIuKNL+HAgazjGLPAOJQiTc
         NSOdgXMdHLHVX/6KixEzoSfQhhjLA3WO8Z4gl1v611fTXX2we+PmZ0sC2Dh7U87uuy1d
         7f2k10XzmJ6uzu4eSMQJDd421BY1QSAv2UeA9i8FAVHhKHIgA6Yzyq8t4p2HxwUB76l5
         HcM9Ce+hzBgHRAgzzo1eErhtLWBJSEa9sOgMwZq0Va35wQ5d+mnqK+bJC4MiOvmFGwnK
         0PCy1WLG1iNDtwlXY826Po5expNqFm1UcNqCKxHreM0NKwVinadtylUmVoYel7+BD3U6
         /9Zg==
X-Gm-Message-State: AOAM533zZPQXtP85zKbb24B6TYOStsRMVB2HvK5Pg8wO88adxqtw8t+M
        FglCPQ6eAmjpdLk2mDZB/BaINRdFl8bNDhh8myEHvQ==
X-Google-Smtp-Source: ABdhPJyilzR9QVcWD7iWcOH8FJUnoZ1sJLTQbCGDblWFfwASjChV0x5rcZZZLRppbnsEtWInlhUNc/BOGQygTfvfwLM=
X-Received: by 2002:a02:6308:0:b0:30e:7e14:848b with SMTP id
 j8-20020a026308000000b0030e7e14848bmr2446771jac.139.1645117690194; Thu, 17
 Feb 2022 09:08:10 -0800 (PST)
MIME-Version: 1.0
References: <00000000000038779505d5d8b372@google.com> <CANp29Y7WjwXwgxPrNq0XXjXPu+wGFqTreh9gry=O6aE7+cKpLQ@mail.gmail.com>
 <CA+zEjCvu76yW7zfM+qJUe+t5y23oPdzR4KDV1mOdqH8bB4GmTw@mail.gmail.com>
 <CACT4Y+arufrRgwmN66wUU+_FGxMy-sTkjMQnRN8U2H2tQuhB7A@mail.gmail.com>
 <a0769218-c84a-a1d3-71e7-aefd40bf54fe@ghiti.fr> <CANp29Y4WMhsE_-VWvNbwq18+qvb1Qc-ES80h_j_G-N_hcAnRAw@mail.gmail.com>
 <CANp29Y4ujmz901aE9oiBDx9dYWHti4-Jw=6Ewtotm6ck6MN9FQ@mail.gmail.com>
 <CACT4Y+ZvStiHLYBOcPDoAJnk8hquXwm9BgjQTv=APwh7AvgEUQ@mail.gmail.com>
 <CANp29Y56Or0V1AG7rzBfV_ZTph2Crg4JKKHiuw1kcGFFxeWqiQ@mail.gmail.com>
 <CANp29Y5+MuhKAzVxzEDb_k9voXmKWrUFx8k4wnW5=2+5enVFVA@mail.gmail.com>
 <CA+zEjCtvaT0YsxxUgnEGM+V4b5sWuCAs3=3J+Xocf580uT3t1g@mail.gmail.com> <CA+zEjCs1FEUTcM+pgV+_MZnixSO5c2hexZFxGxuCQWc2ZMQiRg@mail.gmail.com>
In-Reply-To: <CA+zEjCs1FEUTcM+pgV+_MZnixSO5c2hexZFxGxuCQWc2ZMQiRg@mail.gmail.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Thu, 17 Feb 2022 18:07:59 +0100
Message-ID: <CANp29Y4rDSjrfTOxcQqwh+Qm+ocR0v6Oxr7EkFxScf+24M1tNA@mail.gmail.com>
Subject: Re: [syzbot] riscv/fixes boot error: can't ssh into the instance
To:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Alexandre Ghiti <alex@ghiti.fr>,
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

Hi Alex,

On Thu, Feb 17, 2022 at 5:53 PM Alexandre Ghiti
<alexandre.ghiti@canonical.com> wrote:
>
> Aleksandr,
>
> On Wed, Feb 16, 2022 at 5:58 PM Alexandre Ghiti
> <alexandre.ghiti@canonical.com> wrote:
> >
> > First, thank you for working on this.
> >
> > On Wed, Feb 16, 2022 at 5:17 PM Aleksandr Nogikh <nogikh@google.com> wrote:
> > >
> > > If I use just defconfig + DEBUG_VIRTUAL, without any KASAN, it begins
> > > to boot, but overwhelms me with tons of `virt_to_phys used for
> > > non-linear address:` errors.
> > >
> > > Like that
> > >
> > > [    2.701271] virt_to_phys used for non-linear address:
> > > 00000000b59e31b6 (0xffffffff806c2000)
> > > [    2.701727] WARNING: CPU: 0 PID: 1 at arch/riscv/mm/physaddr.c:16
> > > __virt_to_phys+0x7e/0x86
> > > [    2.702207] Modules linked in:
> > > [    2.702393] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W
> > >   5.17.0-rc1 #1
> > > [    2.702806] Hardware name: riscv-virtio,qemu (DT)
> > > [    2.703051] epc : __virt_to_phys+0x7e/0x86
> > > [    2.703298]  ra : __virt_to_phys+0x7e/0x86
> > > [    2.703547] epc : ffffffff80008448 ra : ffffffff80008448 sp :
> > > ffff8f800021bde0
> > > [    2.703977]  gp : ffffffff80ed9b30 tp : ffffaf8001230000 t0 :
> > > ffffffff80eea56f
> > > [    2.704704]  t1 : ffffffff80eea560 t2 : 0000000000000000 s0 :
> > > ffff8f800021be00
> > > [    2.705153]  s1 : ffffffff806c2000 a0 : 000000000000004f a1 :
> > > ffffffff80e723d8
> > > [    2.705555]  a2 : 0000000000000010 a3 : fffffffffffffffe a4 :
> > > 0000000000000000
> > > [    2.706027]  a5 : 0000000000000000 a6 : 0000000000000005 a7 :
> > > ffffffffffffffff
> > > [    2.706474]  s2 : ffffffff80b80b08 s3 : 00000000000000c2 s4 :
> > > ffffffff806c2000
> > > [    2.706891]  s5 : ffffffff80edba10 s6 : ffffffff80edb960 s7 :
> > > 0000000000000001
> > > [    2.707290]  s8 : 00000000000000ff s9 : ffffffff80b80b40 s10:
> > > 00000000000000cc
> > > [    2.707689]  s11: ffffaf807e1fcf00 t3 : 0000000000000076 t4 :
> > > ffffffffffffffff
> > > [    2.708092]  t5 : 00000000000001f2 t6 : ffff8f800021bb48
> > > [    2.708433] status: 0000000000000120 badaddr: 0000000000000000
> > > cause: 0000000000000003
> > > [    2.708919] [<ffffffff8011416a>] free_reserved_area+0x72/0x19a
> > > [    2.709296] [<ffffffff80003a5a>] free_initmem+0x6c/0x7c
> > > [    2.709648] [<ffffffff805f60c8>] kernel_init+0x3a/0x10a
> > > [    2.709993] [<ffffffff80002fda>] ret_from_exception+0x0/0xc
> > > [    2.710310] ---[ end trace 0000000000000000 ]---
> > >
> >
> > I was able to reproduce this: the first one regarding init_zero_pfn is
> > legit but not wrong, I have to check when it was introduced and how to
> > fix this.
> > Regarding the huge batch that follows, at first sight, I would say
> > this is linked to my sv48 patchset but that does not seem important as
> > the address is a kernel mapping address so the use of virt_to_phys is
> > right.
> >
> > > On Wed, Feb 16, 2022 at 5:09 PM Aleksandr Nogikh <nogikh@google.com> wrote:
> > > >
> > > > On Wed, Feb 16, 2022 at 12:56 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > > >
> > > > > On Wed, 16 Feb 2022 at 12:47, Aleksandr Nogikh <nogikh@google.com> wrote:
> > > > > >
> > > > > > On Wed, Feb 16, 2022 at 11:37 AM Aleksandr Nogikh <nogikh@google.com> wrote:
> > > > > > >
> > > > > > > Hi Alex,
> > > > > > >
> > > > > > > On Wed, Feb 16, 2022 at 5:14 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
> > > > > > > >
> > > > > > > > Hi Dmitry,
> > > > > > > >
> > > > > > > > On 2/15/22 18:12, Dmitry Vyukov wrote:
> > > > > > > > > On Wed, 2 Feb 2022 at 14:18, Alexandre Ghiti
> > > > > > > > > <alexandre.ghiti@canonical.com> wrote:
> > > > > > > > >> Hi Aleksandr,
> > > > > > > > >>
> > > > > > > > >> On Wed, Feb 2, 2022 at 12:08 PM Aleksandr Nogikh <nogikh@google.com> wrote:
> > > > > > > > >>> Hello,
> > > > > > > > >>>
> > > > > > > > >>> syzbot has already not been able to fuzz its RISC-V instance for 97
> > > > > > > > >> That's a longtime, I'll take a look more regularly.
> > > > > > > > >>
> > > > > > > > >>> days now because the compiled kernel cannot boot. I bisected the issue
> > > > > > > > >>> to the following commit:
> > > > > > > > >>>
> > > > > > > > >>> commit 54c5639d8f507ebefa814f574cb6f763033a72a5
> > > > > > > > >>> Author: Alexandre Ghiti <alexandre.ghiti@canonical.com>
> > > > > > > > >>> Date:   Fri Oct 29 06:59:27 2021 +0200
> > > > > > > > >>>
> > > > > > > > >>>      riscv: Fix asan-stack clang build
> > > > > > > > >>>
> > > > > > > > >>> Apparently, the problem appears on GCC-built RISC-V kernels with KASAN
> > > > > > > > >>> enabled. In the previous message syzbot mentions
> > > > > > > > >>> "riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU
> > > > > > > > >>> Binutils for Debian) 2.35.2", but the issue also reproduces finely on
> > > > > > > > >>> a newer GCC compiler: "riscv64-linux-gnu-gcc (Debian 11.2.0-10)
> > > > > > > > >>> 11.2.0, GNU ld (GNU Binutils for Debian) 2.37".
> > > > > > > > >>> For convenience, I also duplicate the .config file from the bot's
> > > > > > > > >>> message: https://syzkaller.appspot.com/x/.config?x=522544a2e0ef2a7d
> > > > > > > > >>>
> > > > > > > > >>> Can someone with KASAN and RISC-V expertise please take a look?
> > > > > > > > >> I'll take a look at that today.
> > > > > > > > >>
> > > > > > > > >> Thanks for reporting the issue,
> > > > > > > > >
> > > > > > > >
> > > > > > > > I took a quick look, not enough to fix it but I know the issue comes
> > > > > > > > from the inline instrumentation, I have no problem with the outline
> > > > > > > > instrumentation. I need to find some cycles to work on this, my goal is
> > > > > > > > to fix this for 5.17.
> > > > > > >
> > > > > > > Thanks for the update!
> > > > > > >
> > > > > > > Can you please share the .config with which you tested the outline
> > > > > > > instrumentation?
> > > > > > > I updated the syzbot config to use KASAN_OUTLINE instead of KASAN_INLINE,
> > > > > > > but it still does not boot :(
> > > > > > >
> > > > > > > Here's what I used:
> > > > > > > https://gist.github.com/a-nogikh/279c85c2d24f47efcc3e865c08844138
> > > > > >
> > > > > > Update: it doesn't boot with that big config, but boots if I generate
> > > > > > a simple one with KASAN_OUTLINE:
> > > > > >
> > > > > > make defconfig ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu-
> > > > > > ./scripts/config -e KASAN -e KASAN_OUTLINE
> > > > > > make olddefconfig ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu-
> > > > > >
> > > > > > And it indeed doesn't work if I use KASAN_INLINE.
> > > > >
> > > > > It may be an issue with code size. Full syzbot config + KASAN + KCOV
> > > > > produce hugely massive .text. It may be hitting some limitation in the
> > > > > bootloader/kernel bootstrap code.
> >
> > I took a quick glance and it traps on a KASAN address that is not
> > mapped, either because it is too soon or because the mapping failed
> > somehow.
> >
> > I'll definitely dive into that tomorrow, sorry for being slow here and
> > thanks again for all your work, that helps a lot.
> >
> > Thanks,
> >
> > Alex
> >
> > > >
> > > > I bisected the difference between the config we use on syzbot and the
> > > > simple one that was generated like I described above.
> > > > Turns out that it's the DEBUG_VIRTUAL config that makes the difference.
> > > >
> > > > make defconfig ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu-
> > > > ./scripts/config -e KASAN -e KASAN_OUTLINE -e DEBUG_VIRTUAL
> > > > make olddefconfig ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu-
> > > >
> > > > And the resulting kernel does not boot.
> > > > My env: the `riscv/fixes` branch, commit
> > > > 6df2a016c0c8a3d0933ef33dd192ea6606b115e3, qemu 6.2.0.
>
> I fixed a few things today: KASAN + SPARSE_VMEMMAP, DEBUG_VIRTUAL and
> maybe KASAN  + KCOV.
>
> With those small fixes, I was able to boot your large dotconfig with
> KASAN_OUTLINE, the inline version still fails, this is my next target
> :)
> I'll push that tomorrow!

Awesome, thank you very much!
Looking forward to finally seeing the instance run :)

--
Best Regards,
Aleksandr

>
> Thanks again,
>
> Alex
