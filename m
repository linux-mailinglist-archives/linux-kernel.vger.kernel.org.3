Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBD946B1FA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 05:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236276AbhLGEsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 23:48:54 -0500
Received: from mga12.intel.com ([192.55.52.136]:27297 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236121AbhLGEsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 23:48:53 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="217518103"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="217518103"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 20:45:23 -0800
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="461110828"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 20:45:23 -0800
Date:   Mon, 6 Dec 2021 20:45:22 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-mm@kvack.org
Subject: Re: [PATCH V7 08/18] x86/entry: Preserve PKRS MSR across exceptions
Message-ID: <20211207044522.GE3538886@iweiny-DESK2.sc.intel.com>
References: <20210804043231.2655537-1-ira.weiny@intel.com>
 <20210804043231.2655537-9-ira.weiny@intel.com>
 <87r1b4l3xc.ffs@tglx>
 <20211207015423.GA4012679@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207015423.GA4012679@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 05:54:23PM -0800, 'Ira Weiny' wrote:

[snip]

> > 
> > Though, if you look at the xen_pv_evtchn_do_upcall() part where you
> > added this extra invocation you might figure out that adding
> > pkrs_restore_irq() to irqentry_exit_cond_resched() and explicitely to
> > the 'else' path in irqentry_exit() makes it magically consistent for
> > both use cases.
> > 
> 
> Thank you, yes good catch.  However, I think I need at least 1 more call in the
> !regs_irqs_disabled() && state.exit_rcu case right?
> 
> 11:29:48 > git di
> diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> index 717091910ebc..667676ebc129 100644
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -363,8 +363,6 @@ __visible noinstr void xen_pv_evtchn_do_upcall(struct pt_regs *regs)
>  
>         inhcall = get_and_clear_inhcall();
>         if (inhcall && !WARN_ON_ONCE(state.exit_rcu)) {
> -               /* Normally called by irqentry_exit, restore pkrs here */
> -               pkrs_restore_irq(regs);
>                 irqentry_exit_cond_resched();
>                 instrumentation_end();
>                 restore_inhcall(inhcall);
> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index 1c0a70a17e93..60ae3d4c9cc0 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -385,6 +385,7 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
>  
>  void irqentry_exit_cond_resched(void)

Opps...  Of course regs will need to be passed in here now...

Ira

>  {
> +       pkrs_restore_irq(regs);
>         if (!preempt_count()) {
>                 /* Sanity check RCU and thread stack */
>                 rcu_irq_exit_check_preempt();
> @@ -408,8 +409,6 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
>                 return;
>         }
>  
> -       pkrs_restore_irq(regs);
> -
>         if (!regs_irqs_disabled(regs)) {
>                 /*
>                  * If RCU was not watching on entry this needs to be done
> @@ -421,6 +420,7 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
>                         /* Tell the tracer that IRET will enable interrupts */
>                         trace_hardirqs_on_prepare();
>                         lockdep_hardirqs_on_prepare(CALLER_ADDR0);
> +                       pkrs_restore_irq(regs);
>                         instrumentation_end();
>                         rcu_irq_exit();
>                         lockdep_hardirqs_on(CALLER_ADDR0);
> @@ -439,6 +439,10 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
>                 trace_hardirqs_on();
>                 instrumentation_end();
>         } else {
> +               instrumentation_begin();
> +               pkrs_restore_irq(regs);
> +               instrumentation_end();
> +
>                 /*
>                  * IRQ flags state is correct already. Just tell RCU if it
>                  * was not watching on entry.
> @@ -470,8 +474,8 @@ irqentry_state_t noinstr irqentry_nmi_enter(struct pt_regs *regs)
>  
>  void noinstr irqentry_nmi_exit(struct pt_regs *regs, irqentry_state_t irq_state)
>  {
> -       pkrs_restore_irq(regs);
>         instrumentation_begin();
> +       pkrs_restore_irq(regs);
>         ftrace_nmi_exit();
>         if (irq_state.lockdep) {
>                 trace_hardirqs_on_prepare();
> 
> 
> Thank you again for the review,
> Ira
> 
> 
> [0] https://lore.kernel.org/lkml/20210804043231.2655537-5-ira.weiny@intel.com/
> [1] https://lore.kernel.org/lkml/20201217131924.GW3040@hirez.programming.kicks-ass.net/
> [2] https://lore.kernel.org/lkml/20201216013202.GY1563847@iweiny-DESK2.sc.intel.com/
> [3] https://lore.kernel.org/lkml/87y2hwqwng.fsf@nanos.tec.linutronix.de/
> 
> > Thanks,
> > 
> >         tglx
