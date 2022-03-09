Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1774D3B43
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 21:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237254AbiCIUnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 15:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236983AbiCIUnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 15:43:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB914972B3;
        Wed,  9 Mar 2022 12:42:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A00F61A3E;
        Wed,  9 Mar 2022 20:42:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8383EC36AE3;
        Wed,  9 Mar 2022 20:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646858562;
        bh=Sntq42ahBVZXgzPBFrt+wDsjyJ+Ih0DKF1/UyiP16JM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=c7Bxwod8XcBD4QnecCFu2c8Tmk02WPX3ORtAC3zG831AHJPaXcMphjOqYysTdaYx2
         ByCEMIAO4u9e20DGDMWej0NArecZARpthE8qmCCjPvDjkOf4mQ4FS6BIzXKMt61//9
         +Ey8d//kzo34L0LXJtOwy9cS4xSpKQ76n9NI7lrwhccw9DcANguV6RQXpyA6JFwbN5
         t3Vs1Hd0a/1IEyREyjgJryrAbbOjm91lSnJhlK/Hi7fPlJTEvDh218P/CVYyJMkavA
         29QDLmGugESzpd3x5h+qUl7Cfl51GP2xRKX4+t6L0+wtYrh0xjV+9p9sR2/0QlSkHA
         FQREs7Cp8zd+Q==
Received: by mail-yb1-f179.google.com with SMTP id u61so6827916ybi.11;
        Wed, 09 Mar 2022 12:42:42 -0800 (PST)
X-Gm-Message-State: AOAM533DLPUqBfyn99SymlPCEZg+Kd5en4S3fCYpTBPKOkTaX0Y/gLnX
        Tj9KWgkESSv+p+qk+l81ekwMkDL+pmHHPZgEFEw=
X-Google-Smtp-Source: ABdhPJysdF5vuZAmfsHsL9o8l/IBRAJzjjd+dlQ7flGgWd5ZFFyeZdXTNCb87FNKHhKswJIyKRr1L81eibe+8NYOO9Q=
X-Received: by 2002:a25:53c4:0:b0:628:a0de:b4d6 with SMTP id
 h187-20020a2553c4000000b00628a0deb4d6mr1308534ybb.299.1646858561392; Wed, 09
 Mar 2022 12:42:41 -0800 (PST)
MIME-Version: 1.0
References: <CAMj1kXHTdk1Abm7ShoZzrW6EpM9eyFMPSdaa58Ziie4ZMecCnQ@mail.gmail.com>
 <CA+G9fYvCvBBi+dZ+CnUy=ZK6GhCFhBw72_==Cav=Q8QP5T1r5w@mail.gmail.com>
 <CA+G9fYt73AYs=z-BeZh22RBp==sf73pKky6m4iPSH7a4FssK7w@mail.gmail.com>
 <CAMj1kXEFZVeWLaRQJmwO+Nn6uW4q6vXJOaNNTVKju1p2bMQksA@mail.gmail.com>
 <YijCkHHhpleeADAO@shell.armlinux.org.uk> <CA+G9fYtjrAMg8TykZdRyZEfRthyqom_73x87F-60C_QFeEL8Bg@mail.gmail.com>
 <YijfzAhWAgfGGqCO@shell.armlinux.org.uk> <CAMj1kXFvjawvOzeTb2m1H=P-_aXgW-ozvaOK1FtjBv7G0sCDFA@mail.gmail.com>
 <Yij2cZVKwPexGsTf@shell.armlinux.org.uk> <CAMj1kXE02HH7vRUjF3iKAL+1idKTy-oOYyGnBd3g90m6eObBxg@mail.gmail.com>
 <YikByJteDEtKi4Xv@shell.armlinux.org.uk>
In-Reply-To: <YikByJteDEtKi4Xv@shell.armlinux.org.uk>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 9 Mar 2022 21:42:29 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGnwbe=YYWaRxaXioEfTJOdXg9JYcNddO8iifpWLRZCWg@mail.gmail.com>
Message-ID: <CAMj1kXGnwbe=YYWaRxaXioEfTJOdXg9JYcNddO8iifpWLRZCWg@mail.gmail.com>
Subject: Re: [next] arm: Internal error: Oops: 5 PC is at __read_once_word_nocheck
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Mar 2022 at 20:39, Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Wed, Mar 09, 2022 at 08:14:30PM +0100, Ard Biesheuvel wrote:
> > On Wed, 9 Mar 2022 at 19:48, Russell King (Oracle)
> > <linux@armlinux.org.uk> wrote:
> > >
> > > On Wed, Mar 09, 2022 at 06:43:42PM +0100, Ard Biesheuvel wrote:
> > > > On Wed, 9 Mar 2022 at 18:11, Russell King (Oracle)
> > > > <linux@armlinux.org.uk> wrote:
> > > > >
> > > > > On Wed, Mar 09, 2022 at 10:08:25PM +0530, Naresh Kamboju wrote:
> > > > > > Hi Russell,
> > > > > >
> > > > > > On Wed, 9 Mar 2022 at 20:37, Russell King (Oracle)
> > > > > > <linux@armlinux.org.uk> wrote:
> > > > > > >
> > > > > > > On Wed, Mar 09, 2022 at 03:57:32PM +0100, Ard Biesheuvel wrote:
> > > > > > > > On Wed, 9 Mar 2022 at 15:44, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > > > > > > > >
> > > > > > <trim>
> > > > > > > Well, we unwound until:
> > > > > > >
> > > > > > >  __irq_svc from migrate_disable+0x0/0x70
> > > > > > >
> > > > > > > and then crashed - and the key thing there is that we're at the start
> > > > > > > of migrate_disable() when we took an interrupt.
> > > > > > >
> > > > > > > For some reason, this triggers an access to address 0x10, which faults.
> > > > > > > We then try unwinding again, and successfully unwind all the way back
> > > > > > > to the same point (the line above) which then causes the unwinder to
> > > > > > > again access address 0x10, and the cycle repeats with the stack
> > > > > > > growing bigger and bigger.
> > > > > > >
> > > > > > > I'd suggest also testing without the revert but with my patch.
> > > > > >
> > > > > > I have tested your patch on top of linux next-20220309 and still see kernel
> > > > > > crash as below [1]. build link [2].
> > > > > >
> > > > > > [   26.812060] 8<--- cut here ---
> > > > > > [   26.813459] Unhandled fault: page domain fault (0x01b) at 0xb6a3ab70
> > > > > > [   26.816139] [b6a3ab70] *pgd=fb28a835
> > > > > > [   26.817770] Internal error: : 1b [#1] SMP ARM
> > > > > > [   26.819636] Modules linked in:
> > > > > > [   26.820956] CPU: 0 PID: 211 Comm: haveged Not tainted
> > > > > > 5.17.0-rc7-next-20220309 #1
> > > > > > [   26.824519] Hardware name: Generic DT based system
> > > > > > [   26.827148] PC is at __read_once_word_nocheck+0x0/0x8
> > > > > > [   26.829856] LR is at unwind_frame+0x7dc/0xab4
> > > > > >
> > > > > > - Naresh
> > > > > >
> > > > > > [1] https://lkft.validation.linaro.org/scheduler/job/4688599#L596
> > > > > > [2] https://builds.tuxbuild.com/269gYLGuAdmltuLhIUDAjS2fg1Q/
> > > > >
> > > > > I think the problem has just moved:
> > > > >
> > > > > [   27.113085]  __irq_svc from __copy_to_user_std+0x24/0x378
> > > > >
> > > > > The code at the start of __copy_to_user_std is:
> > > > >
> > > > >    0:   e3a034bf        mov     r3, #-1090519040        ; 0xbf000000
> > > > >    4:   e243c001        sub     ip, r3, #1
> > > > >    8:   e05cc000        subs    ip, ip, r0
> > > > >    c:   228cc001        addcs   ip, ip, #1
> > > > >   10:   205cc002        subscs  ip, ip, r2
> > > > >   14:   33a00000        movcc   r0, #0
> > > > >   18:   e320f014        csdb
> > > > >   1c:   e3a03000        mov     r3, #0
> > > > >   20:   e92d481d        push    {r0, r2, r3, r4, fp, lr}
> > > > >   24:   e1a0b00d        mov     fp, sp
> > > > >
> > > > > and the unwind information will be:
> > > > >
> > > > > 0xc056f14c <arm_copy_to_user+0x1c>: @0xc0b89b84
> > > > >   Compact model index: 1
> > > > >   0x9b      vsp = r11
> > > > >   0xb1 0x0d pop {r0, r2, r3}
> > > > >   0x84 0x81 pop {r4, r11, r14}
> > > > >   0xb0      finish
> > > > >
> > > > > The problem is that the unwind information says "starting at offset
> > > > > 0x1c, to unwind do the following operations". The first of which is
> > > > > to move r11 (fp) to the stack pointer. However, r11 isn't setup
> > > > > until function offset 0x24. You've hit that instruction, which hasn't
> > > > > executed yet, but the stack has been modified by pushing r0, r2-r4,
> > > > > fp and lr onto it.
> > > > >
> > > > > Given this, there is no way that the unwinder (as it currently stands)
> > > > > can do its job properly between 0x1c and 0x24.
> > > > >
> > > > > I don't think this is specifically caused by Ard's patches, but by
> > > > > the addition of KASAN, which has the effect of calling the unwinder
> > > > > at random points in the kernel (when an interrupt happens) and it's
> > > > > clear from the above that there are windows in the code where, if
> > > > > we attempt to unwind using the unwind information, we faill fail
> > > > > because the program state is not consistent with the unwind
> > > > > information.
> > > > >
> > > > > Ard's patch that changes:
> > > > >
> > > > >         ctrl->vrs[reg] = READ_ONCE_NOCHECK(*(*vsp));
> > > > >
> > > > > to use get_kernel_nofault() should have the effect of protecting
> > > > > against the oops, but the side effect is that it is fundamentally not
> > > > > possible with the way these things are to unwind at these points -
> > > > > which means its not possible to get a stacktrace there.
> > > > >
> > > > > So, I don't think this is a "new" problem, but a weakness of using
> > > > > the unwinder to get a backtrace for KASAN.
> > > > >
> > > >
> > > > It essentially means that we cannot unwind through asynchronous
> > > > exceptions, and so we should probably make the svc_entry macro
> > > > .nounwind, instead of pretending that we can reliably unwind through
> > > > it.
> > >
> > > Doesn't that impact the ability to debug the kernel over things like
> > > oopses and the like?
> > >
> >
> > The backtrace dumped by __die() uses the pt_regs from the exception
> > context as the starting point, so the exception entry code that deals
> > with the condition that triggered the oops is omitted, and does not
> > have to be unwound.
>
> That is true, but that's not really the case I was thinking about.
> I was thinking more about cases such as RCU stalls, soft lockups,
> etc.
>
> For example:
>
> https://www.linuxquestions.org/questions/linux-kernel-70/kenel-v4-4-60-panic-in-igmp6_send-and-and-__neigh_create-4175704721/
>
> In that stack trace, the interesting bits are not the beginning of
> the stack trace down to __irq_svc, but everything beyond __irq_svc,
> since the lockup is probably caused by being stuck in
> _raw_write_lock_bh().
>
> It's these situations that we will totally destroy debuggability for,
> and the only way around that would be to force frame pointers and
> ARM builds (not Thumb-2 as that requires the unwinder... which means
> a Thumb-2 kernel soft lockup would be undebuggable.
>

Indeed.

But that means that the only other choice we have is to retain the
imprecise nature of the current solution (which usually works fine
btw), and simply deal with the faulting double dereference of vsp in
the unwinder code. We simply don't know whether the exception was
taken at a point where the stack frame is consistent with the unwind
data.
