Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A98CF496380
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 17:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381466AbiAUQ6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 11:58:46 -0500
Received: from foss.arm.com ([217.140.110.172]:56662 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1380415AbiAUQ5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 11:57:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47AE51FB;
        Fri, 21 Jan 2022 08:57:35 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.1.33])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B3723F73D;
        Fri, 21 Jan 2022 08:57:32 -0800 (PST)
Date:   Fri, 21 Jan 2022 16:57:29 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, x86@kernel.org,
        pjt@google.com, posk@google.com, avagin@google.com,
        jannh@google.com, tdelisle@uwaterloo.ca, posk@posk.io
Subject: Re: [RFC][PATCH v2 5/5] sched: User Mode Concurency Groups
Message-ID: <Yerl+ZrZ2qflIMyg@FVFF77S0Q05N>
References: <20220120155517.066795336@infradead.org>
 <20220120160822.914418096@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120160822.914418096@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 04:55:22PM +0100, Peter Zijlstra wrote:
> User Managed Concurrency Groups is an M:N threading toolkit that allows
> constructing user space schedulers designed to efficiently manage
> heterogeneous in-process workloads while maintaining high CPU
> utilization (95%+).
> 
> XXX moar changelog explaining how this is moar awesome than
> traditional user-space threading.

Awaiting a commit message that I can parse, I'm just looking at the entry bits
for now. TBH I have no idea what this is actually trying to do...

[...]

> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -23,6 +23,10 @@
>  # define _TIF_UPROBE			(0)
>  #endif
>  
> +#ifndef _TIF_UMCG
> +# define _TIF_UMCG			(0)
> +#endif
> +
>  /*
>   * SYSCALL_WORK flags handled in syscall_enter_from_user_mode()
>   */
> @@ -43,11 +47,13 @@
>  				 SYSCALL_WORK_SYSCALL_EMU |		\
>  				 SYSCALL_WORK_SYSCALL_AUDIT |		\
>  				 SYSCALL_WORK_SYSCALL_USER_DISPATCH |	\
> +				 SYSCALL_WORK_SYSCALL_UMCG |		\
>  				 ARCH_SYSCALL_WORK_ENTER)
>  #define SYSCALL_WORK_EXIT	(SYSCALL_WORK_SYSCALL_TRACEPOINT |	\
>  				 SYSCALL_WORK_SYSCALL_TRACE |		\
>  				 SYSCALL_WORK_SYSCALL_AUDIT |		\
>  				 SYSCALL_WORK_SYSCALL_USER_DISPATCH |	\
> +				 SYSCALL_WORK_SYSCALL_UMCG |		\
>  				 SYSCALL_WORK_SYSCALL_EXIT_TRAP	|	\
>  				 ARCH_SYSCALL_WORK_EXIT)
>  
> @@ -221,8 +227,11 @@ static inline void local_irq_disable_exi
>   */
>  static inline void irqentry_irq_enable(struct pt_regs *regs)
>  {
> -	if (!regs_irqs_disabled(regs))
> +	if (!regs_irqs_disabled(regs)) {
>  		local_irq_enable();
> +		if (user_mode(regs) && (current->flags & PF_UMCG_WORKER))
> +			umcg_sys_enter(regs, -1);
> +	}
>  }

Perhaps it would make sense to have separate umcg_sys_enter(regs) and
umcg_sys_enter_syscall(regs, syscallno)? Even if the former is just a wrapper,
to make the entry/exit bits clearly correspond for all the !syscall cases?

Also, is the syscall case meant to nest within this, or syscall entry paths not
supposed to call irqentry_irq_enable() ?

>  
>  /**
> @@ -232,8 +241,11 @@ static inline void irqentry_irq_enable(s
>   */
>  static inline void irqentry_irq_disable(struct pt_regs *regs)
>  {
> -	if (!regs_irqs_disabled(regs))
> +	if (!regs_irqs_disabled(regs)) {
> +		if (user_mode(regs) && (current->flags & PF_UMCG_WORKER))
> +			umcg_sys_exit(regs);
>  		local_irq_disable();
> +	}
>  }

Do the umcg_sys_{enter,exit}() calls need to happen with IRQs unmasked?

* If not (and this nests): for arm64 these can live in our
  enter_from_user_mode() and exit_to_user_mode() helpers.

* If so (or this doesn't nest): for arm64 we'd need to rework our
  local_daif_{inherit,restore,mask}() calls to handle this, though I've been
  meaning to do that anyway to handle pseudo-NMI better.

Either way, it looks like we'd need helpers along the lines of:

| static __always_inline void umcg_enter_from_user(struct pt_regs *regs)
| {
| 	if (current->flags & PF_UMCG_WORKER)
| 		umcg_sys_enter(regs, -1);
| }
| 
| static __always_inline void umcg_exit_to_user(struct pt_regs *regs)
| {
| 	if (current->flags & PF_UMCG_WORKER)
| 		umcg_sys_exit(regs);
| }

Thanks,
Mark.
