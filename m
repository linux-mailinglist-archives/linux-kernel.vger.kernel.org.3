Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5337463640
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 15:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242066AbhK3ORc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 09:17:32 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:45878 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242035AbhK3ORV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 09:17:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 36FD0CE1A23;
        Tue, 30 Nov 2021 14:14:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67DC7C53FC1;
        Tue, 30 Nov 2021 14:13:58 +0000 (UTC)
Date:   Tue, 30 Nov 2021 09:13:56 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        rcu@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>, paulmck@kernel.org,
        mtosatti <mtosatti@redhat.com>, frederic <frederic@kernel.org>
Subject: Re: Question WRT early IRQ/NMI entry code
Message-ID: <20211130091356.7336e277@gandalf.local.home>
In-Reply-To: <875ys9dacq.ffs@tglx>
References: <8719ad46cc29a2c5d7baac3c35770e5460ab8d5c.camel@redhat.com>
        <875ys9dacq.ffs@tglx>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2021 14:47:01 +0100
Thomas Gleixner <tglx@linutronix.de> wrote:

> The reason is symmetry vs. returning from interupt / exception:
> 
>  irqentry_enter()
>       exit_rcu = false;
> 
>       if (user_mode(regs)) {
>           irqentry_enter_from_user_mode(regs)
>             __enter_from_user_mode(regs)
>               user_exit_irqoff();       <- RCU handling for NOHZ full
> 
>       } else if (is_idle_task_current()) {
>             rcu_irq_enter()
>             exit_rcu = true;
>       }
> 
>  irq_enter_rcu()
>      __irq_enter_raw()
>      preempt_count_add(HARDIRQ_OFFSET);
> 
>  irq_handler()
> 
>  irq_exit_rcu()
>      preempt_count_sub(HARDIRQ_OFFSET);
>      if (!in_interrupt() && local_softirq_pending())
>      	 invoke_softirq();
> 
>  irqentry_exit(regs, exit_rcu)
> 
>      if (user_mode(regs)) {
>          irqentry_exit_to_usermode(regs)
>            user_enter_irqoff();     <- RCU handling for NOHZ full
>      } else if (irqs_enabled(regs)) {
>            if (exit_rcu) {          <- Idle task special case
>                rcu_irq_exit();
>            } else {
>               irqentry_exit_cond_resched();
>            }
> 
>      } else if (exit_rcu) {
>          rcu_irq_exit();
>      }
> 
> On return from interrupt HARDIRQ_OFFSET has to be removed _before_
> handling soft interrupts. It's also required that the preempt count has
> the original state _before_ reaching irqentry_exit() which
> might schedule if the interrupt/exception hit user space or kernel space
> with interrupts enabled.
> 
> So doing it symmetric makes sense.
> 
> For NMIs the above conditionals do not apply at all and we just do
> 
>     __nmi_enter()
>         preempt_count_add(NMI_COUNT + HARDIRQ_COUNT);
>     rcu_nmi_enter();
> 
>     handle_nmi();
> 
>     rcu_nmi_exit();
>     __nmi_exit()
>         preempt_count_sub(NMI_COUNT + HARDIRQ_COUNT);
> 
> The reason why preempt count is incremented before invoking
> rcu_nmi_enter() is simply that RCU has to know about being in NMI
> context, i.e. in_nmi() has to return the correct answer.

Seems like there should be a comment in the code somewhere that explains
this.

-- Steve
