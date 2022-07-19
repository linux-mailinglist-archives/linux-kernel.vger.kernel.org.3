Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9A1579859
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 13:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236495AbiGSLYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 07:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235462AbiGSLY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 07:24:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F6FC402E8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 04:24:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A4A81424;
        Tue, 19 Jul 2022 04:24:28 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.86.74])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC1483F766;
        Tue, 19 Jul 2022 04:24:26 -0700 (PDT)
Date:   Tue, 19 Jul 2022 12:24:20 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] arm64: support HAVE_IRQ_EXIT_ON_IRQ_STACK
Message-ID: <YtaUZCabQw7nrv4A@FVFF77S0Q05N>
References: <20220708094950.41944-1-zhengqi.arch@bytedance.com>
 <20220708094950.41944-3-zhengqi.arch@bytedance.com>
 <CAK8P3a3rp6R1kWNHBxgDf5xrECj-F5AVn++qR9_Y7GiRrDBpDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3rp6R1kWNHBxgDf5xrECj-F5AVn++qR9_Y7GiRrDBpDw@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 01:37:31PM +0200, Arnd Bergmann wrote:
> On Fri, Jul 8, 2022 at 11:49 AM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> >
> > Since softirqs are handled on the per-CPU IRQ stack,
> > let's support HAVE_IRQ_EXIT_ON_IRQ_STACK which causes
> > the core code to invoke __do_softirq() directly without
> > going through do_softirq_own_stack().
> >
> > Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> Adding Mark Rutland to Cc, he's the one that worked on this area the most in the
> past and should probably review your patch. I still feel like there
> should be a way
> to improve readability of the IRQ entry path rather than just adding another
> level of indirection, but the ideas I had so far have not led to
> anything useful.
> 
> Overall I suppose your version is an improvement over the extra double stack
> switch when entering softirq.

The cost of the switch is fairly trivial, so performance-wise I would expect
that to fall within the noise. So if this is just about avoiding the extra
switch, I'd prefer to leave this as-is.

If we want to move more work after the stack switch, I think we'd want a more
in depth rethink of the structure of this code (since e.g. we could make the
common case have almost everything on the IRQ stack, at the cost of making
preemption require more work).

Thanks,
Mark.

> 
>         Arnd
> 
> > ---
> >  arch/arm64/Kconfig                 |  1 +
> >  arch/arm64/include/asm/exception.h |  4 +++-
> >  arch/arm64/kernel/entry-common.c   | 30 ++++++++++++++++++++----------
> >  arch/arm64/kernel/entry.S          |  6 ++++--
> >  arch/arm64/kernel/irq.c            |  5 +++--
> >  5 files changed, 31 insertions(+), 15 deletions(-)
> >
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index be0a9f0052ee..d2cc7daecce3 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -231,6 +231,7 @@ config ARM64
> >         select TRACE_IRQFLAGS_SUPPORT
> >         select TRACE_IRQFLAGS_NMI_SUPPORT
> >         select HAVE_SOFTIRQ_ON_OWN_STACK
> > +       select HAVE_IRQ_EXIT_ON_IRQ_STACK
> >         help
> >           ARM 64-bit (AArch64) Linux support.
> >
> > diff --git a/arch/arm64/include/asm/exception.h b/arch/arm64/include/asm/exception.h
> > index d94aecff9690..8bff0aa7ab50 100644
> > --- a/arch/arm64/include/asm/exception.h
> > +++ b/arch/arm64/include/asm/exception.h
> > @@ -54,7 +54,9 @@ asmlinkage void el0t_32_fiq_handler(struct pt_regs *regs);
> >  asmlinkage void el0t_32_error_handler(struct pt_regs *regs);
> >
> >  asmlinkage void call_on_irq_stack(struct pt_regs *regs,
> > -                                 void (*func)(struct pt_regs *));
> > +                                 void (*func)(struct pt_regs *),
> > +                                 void (*do_func)(struct pt_regs *,
> > +                                                 void (*)(struct pt_regs *)));
> >  asmlinkage void asm_exit_to_user_mode(struct pt_regs *regs);
> >
> >  void do_mem_abort(unsigned long far, unsigned long esr, struct pt_regs *regs);
> > diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> > index c75ca36b4a49..935d1ab150b5 100644
> > --- a/arch/arm64/kernel/entry-common.c
> > +++ b/arch/arm64/kernel/entry-common.c
> > @@ -266,14 +266,16 @@ static void __sched arm64_preempt_schedule_irq(void)
> >  }
> >
> >  static void do_interrupt_handler(struct pt_regs *regs,
> > -                                void (*handler)(struct pt_regs *))
> > +                                void (*handler)(struct pt_regs *),
> > +                                void (*do_handler)(struct pt_regs *,
> > +                                                   void (*)(struct pt_regs *)))
> >  {
> >         struct pt_regs *old_regs = set_irq_regs(regs);
> >
> >         if (on_thread_stack())
> > -               call_on_irq_stack(regs, handler);
> > +               call_on_irq_stack(regs, handler, do_handler);
> >         else
> > -               handler(regs);
> > +               do_handler(regs, handler);
> >
> >         set_irq_regs(old_regs);
> >  }
> > @@ -441,22 +443,32 @@ asmlinkage void noinstr el1h_64_sync_handler(struct pt_regs *regs)
> >         }
> >  }
> >
> > +static void nmi_handler(struct pt_regs *regs, void (*handler)(struct pt_regs *))
> > +{
> > +       handler(regs);
> > +}
> > +
> >  static __always_inline void __el1_pnmi(struct pt_regs *regs,
> >                                        void (*handler)(struct pt_regs *))
> >  {
> >         arm64_enter_nmi(regs);
> > -       do_interrupt_handler(regs, handler);
> > +       do_interrupt_handler(regs, handler, nmi_handler);
> >         arm64_exit_nmi(regs);
> >  }
> >
> > +static void irq_handler(struct pt_regs *regs, void (*handler)(struct pt_regs *))
> > +{
> > +       irq_enter_rcu();
> > +       handler(regs);
> > +       irq_exit_rcu();
> > +}
> > +
> >  static __always_inline void __el1_irq(struct pt_regs *regs,
> >                                       void (*handler)(struct pt_regs *))
> >  {
> >         enter_from_kernel_mode(regs);
> >
> > -       irq_enter_rcu();
> > -       do_interrupt_handler(regs, handler);
> > -       irq_exit_rcu();
> > +       do_interrupt_handler(regs, handler, irq_handler);
> >
> >         arm64_preempt_schedule_irq();
> >
> > @@ -699,9 +711,7 @@ static void noinstr el0_interrupt(struct pt_regs *regs,
> >         if (regs->pc & BIT(55))
> >                 arm64_apply_bp_hardening();
> >
> > -       irq_enter_rcu();
> > -       do_interrupt_handler(regs, handler);
> > -       irq_exit_rcu();
> > +       do_interrupt_handler(regs, handler, irq_handler);
> >
> >         exit_to_user_mode(regs);
> >  }
> > diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> > index 254fe31c03a0..1c351391f6bd 100644
> > --- a/arch/arm64/kernel/entry.S
> > +++ b/arch/arm64/kernel/entry.S
> > @@ -867,7 +867,9 @@ NOKPROBE(ret_from_fork)
> >
> >  /*
> >   * void call_on_irq_stack(struct pt_regs *regs,
> > - *                       void (*func)(struct pt_regs *));
> > + *                       void (*func)(struct pt_regs *)
> > + *                       void (*do_func)(struct pt_regs *,
> > + *                                       void (*)(struct pt_regs *)));
> >   *
> >   * Calls func(regs) using this CPU's irq stack and shadow irq stack.
> >   */
> > @@ -886,7 +888,7 @@ SYM_FUNC_START(call_on_irq_stack)
> >
> >         /* Move to the new stack and call the function there */
> >         mov     sp, x16
> > -       blr     x1
> > +       blr     x2
> >
> >         /*
> >          * Restore the SP from the FP, and restore the FP and LR from the frame
> > diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
> > index c36ad20a52f3..003db605bc4f 100644
> > --- a/arch/arm64/kernel/irq.c
> > +++ b/arch/arm64/kernel/irq.c
> > @@ -73,14 +73,15 @@ static void init_irq_stacks(void)
> >  #endif
> >
> >  #ifndef CONFIG_PREEMPT_RT
> > -static void ____do_softirq(struct pt_regs *regs)
> > +static void ____do_softirq(struct pt_regs *regs,
> > +                          void (*handler)(struct pt_regs *))
> >  {
> >         __do_softirq();
> >  }
> >
> >  void do_softirq_own_stack(void)
> >  {
> > -       call_on_irq_stack(NULL, ____do_softirq);
> > +       call_on_irq_stack(NULL, NULL, ____do_softirq);
> >  }
> >  #endif
> >
> > --
> > 2.20.1
> >
