Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D4D520D24
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 07:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236647AbiEJFQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 01:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235891AbiEJFQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 01:16:01 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3A12A83F5
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 22:12:01 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id c11so15758558plg.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 22:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xglU4uKywVoEyAxCezpCYH941xv/viED131sJU5IUh8=;
        b=E3wxcqD5lkn8BNcSRFIsYjFe121yjU+68BlrQPvf7H3On379DZqIFr7VLjkCurkC3P
         +v38397qqnbkHlaikeaKJS0t89LUaryKU9hpOzVaMhFSZj9vvBPljnICE9w9JWk4auKw
         2468ainlWZzIOlo9ua7Uj6c6PiPHI60nPp3SAjZPYhPwm3SwRRKe34j/t5T4B040K9pN
         xuAR7zagcwrDTiV4CkUdX6WPAivEnSMwtZnj2cPtGBQUpUOoW4fUyKktmq+qrRQ+eIgu
         pNB1nIs+wI+xFDrJz9RfryGTyDpSdGg1nCtNidyyoBiaW7aV6DH/skSl+nJ0iHrizmzq
         Sm1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xglU4uKywVoEyAxCezpCYH941xv/viED131sJU5IUh8=;
        b=6mI+kXTr3tXR4kMnGvmQAb/GHVfXUfmT8TSGv3saelYaGOCDNEnCxZWrb/YTmfa9aU
         mDfv+Z8vIGE5cLhY91gKYjayZp0fOErXY7HRzImGf9DCL79wGC1UO6QqA9oddOzJlk+p
         OHUchu4y95GM1v+cMaa2ix+rdAo/h60XoMxF0hkUgc5AVBsYHJ/xRV0yxwqrV71MWVui
         lko8QolMZQQdcSbotHrG2qsSVq2ERnuhFSCrZAG02nsRsmDYtqbxpg8uncCzMXu/qWdh
         yFkuY/0kr6CPUuIatAXdBDdwtaciDS2fd4t7drxVE/pyKflhfiXuSgUYtlXA3JL7Ymzp
         oYFw==
X-Gm-Message-State: AOAM532z6St8vrDv9bV2bUVly9DnilAI5lBLaZ+RVFaKAuiCnW+fV4ab
        RppCdNdwXJ6e7Aa0Z22eQ6o6kvMy9AcHgVkZ1QCH+A==
X-Google-Smtp-Source: ABdhPJxq5pEUQH3Y1nd5JebcUNOSt3+TuoALLAWoc/4KKg2v80ks4xtEILSopBsFfRrGvBKKHS2DnO3F+bdZwNodppE=
X-Received: by 2002:a17:90b:2241:b0:1dc:d4d3:3047 with SMTP id
 hk1-20020a17090b224100b001dcd4d33047mr21737805pjb.128.1652159520443; Mon, 09
 May 2022 22:12:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220413065458.88541-1-sumit.garg@linaro.org> <20220413065458.88541-2-sumit.garg@linaro.org>
 <20220506160649.ojwc4rqpyhxqyrdo@maple.lan> <CAFA6WYOCz2uFU81YTA+GpWhq3k=bfjBKJhKST1VjnjW2GTVq3A@mail.gmail.com>
 <20220509092511.vey3tigggg6tnek7@maple.lan>
In-Reply-To: <20220509092511.vey3tigggg6tnek7@maple.lan>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 10 May 2022 10:41:48 +0530
Message-ID: <CAFA6WYMfxss0yhz0cB4NuX8sY9sBfFRoMkFb71u134XpFees0w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm64: entry: Skip single stepping interrupt handlers
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, dianders@chromium.org,
        will@kernel.org, liwei391@huawei.com, catalin.marinas@arm.com,
        mark.rutland@arm.com, mhiramat@kernel.org,
        jason.wessel@windriver.com, maz@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 May 2022 at 14:55, Daniel Thompson <daniel.thompson@linaro.org> wrote:
>
> On Mon, May 09, 2022 at 01:25:21PM +0530, Sumit Garg wrote:
> > Hi Daniel,
> >
> > On Fri, 6 May 2022 at 21:36, Daniel Thompson <daniel.thompson@linaro.org> wrote:
> > >
> > > On Wed, Apr 13, 2022 at 12:24:57PM +0530, Sumit Garg wrote:
> > > > Current implementation allows single stepping into interrupt handlers
> > > > for interrupts that were received during single stepping. But interrupt
> > > > handlers aren't something that the user expect to debug. Moreover single
> > > > stepping interrupt handlers is risky as it may sometimes leads to
> > > > unbalanced locking when we resume from single-step debug.
> > >
> > > Why does single stepping interrupt handlers cause unbalanced locking
> > > (with the current code)?
> > >
> >
> > I have to dig deeper to completely answer this question but this is
> > based on observation from following warning splats seen while single
> > stepping interrupt handlers:
> >
> > [  300.328300] WARNING: bad unlock balance detected!
> > [  300.328608] 5.18.0-rc1-00016-g3e732ebf7316-dirty #6 Not tainted
> > [  300.329058] -------------------------------------
> > [  300.329298] sh/173 is trying to release lock (dbg_slave_lock) at:
> > [  300.329718] [<ffffd57c951c016c>] kgdb_cpu_enter+0x7ac/0x820
> > [  300.330029] but there are no more locks to release!
> > [  300.330265]
> > [  300.330265] other info that might help us debug this:
> > [  300.330668] 4 locks held by sh/173:
> > [  300.330891]  #0: ffff4f5e454d8438 (sb_writers#3){.+.+}-{0:0}, at:
> > vfs_write+0x98/0x204
> > [  300.331735]  #1: ffffd57c973bc2f0 (dbg_slave_lock){+.+.}-{2:2}, at:
> > kgdb_cpu_enter+0x5b4/0x820
> > [  300.332259]  #2: ffffd57c973a9460 (rcu_read_lock){....}-{1:2}, at:
> > kgdb_cpu_enter+0xe0/0x820
> > [  300.332717]  #3: ffffd57c973bc2a8 (dbg_master_lock){....}-{2:2},
> > at: kgdb_cpu_enter+0x1ec/0x820
>
> This splat tells us we entered the debugger from a regular task
> (echo g > /proc/sysrq-trigger by the looks of it) and exited the
> debugger from interrupt.
>
> As such I'd be inclined to describe this as a false positive: it occurs
> because we have not taught lockdep that the locks are effectively
> owned by the debug trap handler rather than the task/interrupt we trapped
> from.
>
> To be honest, for a very long time been inclined to replace
> dbg_slave_lock with an atomic flag instead. dbg_slave_lock isn't a lock
> in any meaningful sense since it is never contended for and literally
> only exists so that other cores can use raw_spin_is_locked() on it.
> However sorting out dbg_master_lock is a bit more complex though which
> is why I've never found the time for it (at least not yet).
>
> BTW I suspect this patch only avoids the simplest reproduction of this
> splat: I think a temporary breakpoint in the ISR that runs during the
> single step would also cause the single step to complete early, yielding
> the same splat.
>

Okay, this sounds reasonable to me. I will remove reference to these
false positive warning splats.

>
> > > > Fix broken single-step implementation via skipping single-step over
> > > > interrupt handlers. The methodology is when we receive an interrupt from
> > > > EL1, check if we are single stepping (pstate.SS). If yes then we save
> > > > MDSCR_EL1.SS and clear the register bit if it was set. Then unmask only
> > > > D and leave I set. On return from the interrupt, set D and restore
> > > > MDSCR_EL1.SS. Along with this skip reschedule if we were stepping.
> > >
> > > Does this description really explains the motivation here.
> > >
> > > Isn't the goal to meet the user's expectation that when they step then
> > > the system will stop at PC+4 relative the instruction they are stepping
> > > (or PC+I for a branch that gets taken)?
> > >
> >
> > Yeah this matches my understanding as well.
> >
> > > To be clear, I've no objections to leaving interrupt handling enabled
> > > when single stepping (AFAIK it is similar to what x86 does) but I think
> > > this patch description will be difficult for future adventurers to
> > > comprehend.
> > >
> >
> > Okay, so does the below patch description sound apt?
>
> Not entirely.
>
> The lockdep splat still distracts from any explanation about why the
> patch is "the right thing to do".
>
> That the patch partially conceals a (false-positive) lockdep splat is
> nice but I don't think it should dominate the description of why
> single-step is unusable if a single step ends during interrupt handling.
>
> Surely a far more powerful motivation is that (currently) on systems when
> the timer interrupt (or any other fast-at-human-scale periodic interrupt)
> is active then it is impossible to step any code with interrupts unlocked
> because we will always end up stepping into the timer interrupt instead of
> stepping the user code.
>

Agree.

>
> > "
> >     Current implementation allows single stepping into interrupt handlers
> >     for interrupts that were received during single stepping. But interrupt
> >     handlers aren't something that the user expect to debug.
>
> As above, I think it is more than user expectation. With a 100Hz timer
> humans cannot react to the debugger fast enough to step before the next timer
> interrupt is due.
>

Thanks for your inputs, I will update the commit description in v3.

-Sumit

>
> >     Moreover single
> >     stepping interrupt handlers is risky as it may sometimes leads to
> >     unbalanced locking when we resume from single-step debug:
>
> If you want to keep the comments about lockdep as an aside at the bottom
> the it is important to:
>
> s/stepping interrupt handlers/stepping into interrupt handlers/
>                                       ^^^^^^
>
> >     [  300.328300] WARNING: bad unlock balance detected!
> >     [  300.328608] 5.18.0-rc1-00016-g3e732ebf7316-dirty #6 Not tainted
> >     [  300.329058] -------------------------------------
> >     [  300.329298] sh/173 is trying to release lock (dbg_slave_lock) at:
> >     [  300.329718] [<ffffd57c951c016c>] kgdb_cpu_enter+0x7ac/0x820
> >     [  300.330029] but there are no more locks to release!
> >     [  300.330265]
> >     [  300.330265] other info that might help us debug this:
> >     [  300.330668] 4 locks held by sh/173:
> >     [  300.330891]  #0: ffff4f5e454d8438 (sb_writers#3){.+.+}-{0:0},
> > at: vfs_write+0x98/0x204
> >     [  300.331735]  #1: ffffd57c973bc2f0 (dbg_slave_lock){+.+.}-{2:2},
> > at: kgdb_cpu_enter+0x5b4/0x820
> >     [  300.332259]  #2: ffffd57c973a9460 (rcu_read_lock){....}-{1:2},
> > at: kgdb_cpu_enter+0xe0/0x820
> >     [  300.332717]  #3: ffffd57c973bc2a8
> > (dbg_master_lock){....}-{2:2}, at: kgdb_cpu_enter+0x1ec/0x820
> >
> >     The common user's expectation while single stepping is that when they
> >     step then the system will stop at PC+4 or PC+I for a branch that gets
> >     taken relative to the instruction they are stepping. So, fix broken single
> >     step implementation via skipping single stepping interrupt handlers.
> >
> >     The methodology is when we receive an interrupt from EL1, check if we
> >     are single stepping (pstate.SS). If yes then we save MDSCR_EL1.SS and
> >     clear the register bit if it was set. Then unmask only D and leave I set. On
> >     return from the interrupt, set D and restore MDSCR_EL1.SS. Along with this
> >     skip reschedule if we were stepping.
> > "
> >
> > -Sumit
> >
> > >
> > > Daniel.
> > >
> > >
> > > > Suggested-by: Will Deacon <will@kernel.org>
> > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > ---
> > > >  arch/arm64/kernel/entry-common.c | 18 +++++++++++++++++-
> > > >  1 file changed, 17 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> > > > index 878c65aa7206..dd2d3af615de 100644
> > > > --- a/arch/arm64/kernel/entry-common.c
> > > > +++ b/arch/arm64/kernel/entry-common.c
> > > > @@ -458,19 +458,35 @@ static __always_inline void __el1_irq(struct pt_regs *regs,
> > > >       do_interrupt_handler(regs, handler);
> > > >       irq_exit_rcu();
> > > >
> > > > -     arm64_preempt_schedule_irq();
> > > > +     /* Don't reschedule in case we are single stepping */
> > > > +     if (!(regs->pstate & DBG_SPSR_SS))
> > > > +             arm64_preempt_schedule_irq();
> > > >
> > > >       exit_to_kernel_mode(regs);
> > > >  }
> > > > +
> > > >  static void noinstr el1_interrupt(struct pt_regs *regs,
> > > >                                 void (*handler)(struct pt_regs *))
> > > >  {
> > > > +     unsigned long reg;
> > > > +
> > > > +     /* Disable single stepping within interrupt handler */
> > > > +     if (regs->pstate & DBG_SPSR_SS) {
> > > > +             reg = read_sysreg(mdscr_el1);
> > > > +             write_sysreg(reg & ~DBG_MDSCR_SS, mdscr_el1);
> > > > +     }
> > > > +
> > > >       write_sysreg(DAIF_PROCCTX_NOIRQ, daif);
> > > >
> > > >       if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && !interrupts_enabled(regs))
> > > >               __el1_pnmi(regs, handler);
> > > >       else
> > > >               __el1_irq(regs, handler);
> > > > +
> > > > +     if (regs->pstate & DBG_SPSR_SS) {
> > > > +             write_sysreg(DAIF_PROCCTX_NOIRQ | PSR_D_BIT, daif);
> > > > +             write_sysreg(reg, mdscr_el1);
> > > > +     }
> > > >  }
> > > >
> > > >  asmlinkage void noinstr el1h_64_irq_handler(struct pt_regs *regs)
> > > > --
> > > > 2.25.1
