Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD1746B017
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 02:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236330AbhLGB5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 20:57:54 -0500
Received: from mga11.intel.com ([192.55.52.93]:20526 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233991AbhLGB5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 20:57:53 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="234970557"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="234970557"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 17:54:24 -0800
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="605350478"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 17:54:24 -0800
Date:   Mon, 6 Dec 2021 17:54:23 -0800
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
Message-ID: <20211207015423.GA4012679@iweiny-DESK2.sc.intel.com>
References: <20210804043231.2655537-1-ira.weiny@intel.com>
 <20210804043231.2655537-9-ira.weiny@intel.com>
 <87r1b4l3xc.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1b4l3xc.ffs@tglx>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas,

Thanks for the review.  Sorry for being so late to respond I was sick all last
week and so it took me longer to figure out some of this stuff.

On Thu, Nov 25, 2021 at 03:12:47PM +0100, Thomas Gleixner wrote:
> Ira,
> 
> On Tue, Aug 03 2021 at 21:32, ira weiny wrote:
> > +/*
> > + * __call_ext_ptregs - Helper macro to call into C with extended pt_regs
> > + * @cfunc:		C function to be called
> > + *
> > + * This will ensure that extended_ptregs is added and removed as needed during
> > + * a call into C code.
> > + */
> > +.macro __call_ext_ptregs cfunc annotate_retpoline_safe:req
> > +#ifdef CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS
> > +	/* add space for extended_pt_regs */
> > +	subq    $EXTENDED_PT_REGS_SIZE, %rsp
> > +#endif
> > +	.if \annotate_retpoline_safe == 1
> > +		ANNOTATE_RETPOLINE_SAFE
> > +	.endif
> 
> This annotation is new and nowhere mentioned why it is part of this
> patch.

I don't understand.  ANNOTATE_RETPOLINE_SAFE has been around since:

9e0e3c5130e9 x86/speculation, objtool: Annotate indirect calls/jumps for objtool

> 
> Can you please do _ONE_ functional change per patch and not a
> unreviewable pile of changes in one go? Same applies for the ASM and the
> C code changes. The ASM change has to go first and then the C code can
> build upon it.

I'm sorry for having the ASM and C code together but this all seemed like 1
change to me.

I can split it if you prefer.  How about a patch with just the x86 extended
pt_regs stuff but that would leave a zero size for the extended stuff?  Then
followed by the pks bits?

> 
> > +	call	\cfunc
> > +#ifdef CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS
> > +	/* remove space for extended_pt_regs */
> > +	addq    $EXTENDED_PT_REGS_SIZE, %rsp
> > +#endif
> 
> I really have to ask the question whether this #ifdeffery has any value
> at all. 8 bytes extra stack usage is not going to be the end of the
> world and distro kernels will enable that config anyway.

My goal with this has always been 0 overhead if turned off.  So this seemed
like a logical addition.  Furthermore, ARCH_ENABLE_SUPERVISOR_PKEYS is
predicated on ARCH_HAS_SUPERVISOR_PKEYS which is only available with x86_64.
This removes the space for x86 when not needed.

All the config stuff was introduced in patch 04/18.[0]

> 
> If we really want to save the space then certainly not by sprinkling
> CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS all over the place and hiding the
> extra sized ptregs in the pkrs header.
> 
> You are changing generic architecture code so you better think about
> making such a change generic and extensible.

I agree.  And I tried to do so.  The generic entry code is modified only by the
addition of pkrs_[save|restore]_irq().  These are only defined if the arch
defines ARCH_HAS_SUPERVISOR_PKEYS and furthermore, if something triggers
enabling ARCH_ENABLE_SUPERVISOR_PKEYS.

ARCH_HAS_SUPERVISOR_PKEYS is restricted to x86_64 at the moment.  All other
arch's including x86 should not see any changes in the generic code.

I thought we had agreed that it was ok for me to restrict the addition of the
extended pt_regs to what was required for PKS when these changes were
discussed.  Because at the time I was concerned about my lack of knowledge of
all the other architectures.[1]

>
> Can folks please start
> thinking beyond the brim of their teacup and not pretend that the
> feature they are working on is the unicorn which requires unique magic
> brandnamed after the unicorn of the day.
> 
> If the next feature comes around which needs to save something in that
> extended area then we are going to change the world again, right?

I'm not sure what you mean by 'change the world'.  I would anticipate the entry
code to be modified with something similar to pks_[save|restore]_irq() and let
the arch deal with the specifics.

Also in [1] I thought Peter and Andy agreed that placing additional generic
state in the extended pt_regs was not needed and does not buy us anything.  I
specifically asked if that was something we wanted to do in.[2]

> Certainly not.
> 
> This wants to go into asm/ptrace.h:
> 
> struct pt_regs_aux {
> 	u32	pkrs;
> };
> 
> struct pt_regs_extended {
> 	struct pt_regs_aux	aux;
>         struct pt_regs		regs __attribute__((aligned(8)));
> };

Ok the aligned attribute does what I was doing much more gracefully.  This is a
good idea yes, thank you.

> 
> and then have in asm-offset:
> 
>    DEFINE(PT_REGS_AUX_SIZE, sizeof(struct pt_regs_extended) - sizeof(struct pt_regs));
> 
> which does the right thing whatever the size of pt_regs_aux is. So for
> the above it will have:
> 
>  #define PT_REGS_AUX_SIZE 8 /* sizeof(struct pt_regs_extended) - sizeof(struct pt_regs) */
> 
> Even, if you do
> 
> struct pt_regs_aux {
> #ifdef CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS
> 	u32	pkrs;
> #endif        
> };
> 
> and the config switch is disabled. It's still correct:
> 
>  #define PT_REGS_AUX_SIZE 0 /* sizeof(struct pt_regs_extended) - sizeof(struct pt_regs) */
> 
> See? No magic hardcoded constant, no build time error checking for that
> constant. Nothing, it just works.

Yes agreed definitely an improvement.

> 
> That's one part, but let me come back to this:
> 
> > +#ifdef CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS
> > +	/* add space for extended_pt_regs */
> > +	subq    $EXTENDED_PT_REGS_SIZE, %rsp
> 
> What guarantees that RSP points to pt_regs at this point?  Nothing at
> all. It's just pure luck and a question of time until this explodes in
> hard to diagnose ways.

It took me a bit to wrap my head around what I think you mean.  My initial
response was that rsp should be the stack pointer for __call_ext_ptregs() just
like it was for call.  But I think I see that it is better to open code this
since others may want to play the same trick without using this code and
therefore we may not be getting the extended pt_regs structure on the stack
like we think.  For example if someone did...

	movq	%rsp, %rdi
	RSP_ADD_OTHER_STACK_STUFF
	__call_ext_ptregs	...
	RSP_REMOVE_OTHER_STACK_STUFF

... it would be broken.

My assumption was that would be illegal after this patch.  But indeed there is
no way to easily see that in the future.

> 
> Because between
> 
>         movq	%rsp, %rdi
> and
>         call    ....
> 
> can legitimately be other code which causes the stack pointer to
> change. It's not the case today, but nothing prevents this in the
> future.
> 
> The correct thing to do is:
> 
>         movq	%rsp, %rdi
>         RSP_MAKE_PT_REGS_AUX_SPACE
>         call	...
>         RSP_REMOVE_PT_REGS_AUX_SPACE
> 
> The few extra macro lines in the actual code are way better as they make
> it completely obvious what's going on and any misuse can be spotted
> easily.

Sure FWIW this is what I had originally but thought it would be cleaner to wrap
the 'call'.  I will convert it back.  Also this removes the
annotate_retpoline_safe stuff above.

> 
> > +#ifdef CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS
> > +/*
> > + * PKRS is a per-logical-processor MSR which overlays additional protection for
> > + * pages which have been mapped with a protection key.
> > + *
> > + * Context switches save the MSR in the task struct thus taking that value to
> > + * other processors if necessary.
> > + *
> > + * To protect against exceptions having access to this memory save the current
> > + * thread value and set the PKRS value to be used during the exception.
> > + */
> > +void pkrs_save_irq(struct pt_regs *regs)
> 
> That's a misnomer as this is invoked for _any_ exception not just
> interrupts.

I'm confused by the naming in kernel/entry/common.c then.  I'm more than
willing to change the name.  But I only see irq* for almost everything in that
file.  And I was trying to follow that convention.

> 
> >  #ifdef CONFIG_XEN_PV
> >  #ifndef CONFIG_PREEMPTION
> >  /*
> > @@ -309,6 +361,8 @@ __visible noinstr void xen_pv_evtchn_do_upcall(struct pt_regs *regs)
> >  
> >  	inhcall = get_and_clear_inhcall();
> >  	if (inhcall && !WARN_ON_ONCE(state.exit_rcu)) {
> > +		/* Normally called by irqentry_exit, restore pkrs here */
> > +		pkrs_restore_irq(regs);
> > 		irqentry_exit_cond_resched();
> 
> Sigh. Consistency is overrated....

I'm not that familiar with the xen code so perhaps I missed something?

> 
> > +
> >  void setup_pks(void);
> >  void pkrs_write_current(void);
> >  void pks_init_task(struct task_struct *task);
> > +void write_pkrs(u32 new_pkrs);
> 
> So we have pkrs_write_current() and write_pkrs() now. Can you please
> stick to a common prefix, i.e. pkrs_ ?

Sorry, yes.

> 
> > diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> > index bf16395b9e13..aa0b1e8dd742 100644
> > --- a/kernel/entry/common.c
> > +++ b/kernel/entry/common.c
> > @@ -6,6 +6,7 @@
> >  #include <linux/livepatch.h>
> >  #include <linux/audit.h>
> >  #include <linux/tick.h>
> > +#include <linux/pkeys.h>
> >  
> >  #include "common.h"
> >  
> > @@ -364,7 +365,7 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
> >  		instrumentation_end();
> >  
> >  		ret.exit_rcu = true;
> > -		return ret;
> > +		goto done;
> >  	}
> >  
> >  	/*
> > @@ -379,6 +380,8 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
> >  	trace_hardirqs_off_finish();
> >  	instrumentation_end();
> >  
> > +done:
> > +	pkrs_save_irq(regs);
> 
> This still calls out into instrumentable code. I explained you before
> why this is wrong. Also objtool emits warnings to that effect if you do a
> proper verified build.

I was not sure what a 'proper verified build' was and objtool was not throwing
any warnings for me even if I ran it directly.

10:49:27 > ./tools/objtool/objtool check -n vmlinux.o
vmlinux.o: warning: objtool: ftrace_caller()+0x94: call without frame pointer save/setup
vmlinux.o: warning: objtool: ftrace_regs_caller()+0xde: call without frame pointer save/setup
vmlinux.o: warning: objtool: return_to_handler()+0x10: call without frame pointer save/setup
vmlinux.o: warning: objtool: copy_mc_fragile() falls through to next function copy_mc_fragile_handle_tail()
vmlinux.o: warning: objtool: copy_user_enhanced_fast_string() falls through to next function copy_user_generic_unrolled()
vmlinux.o: warning: objtool: __memset() falls through to next function memset_erms()
vmlinux.o: warning: objtool: __memcpy() falls through to next function memcpy_erms()
vmlinux.o: warning: objtool: file already has .static_call_sites section, skipping


After asking around and digging quite a bit I found CONFIG_DEBUG_ENTRY which
enabled the check and the error.  [But only during a build and not with the
above command???  Shouldn't the above command work too?]

What other config options should we be running with to verify the build?

Regardless, reading more about noinstr and looking at the code more carefully I
realize I _completely_ misunderstood what you meant before in [3].  I should
have asked for clarification.

Yes this was originally marked noinstr because it was called from a noinstr
function.  I see now, or at least I think I see, that you were taking exception
to my blindly marking pkrs_save_irq() noinstr without a good reason.

When you said 'there is absolutely no reason to have this marked noinstr.'  I
thought that meant we could simply remove it from noinstr.  But what I think
you meant is that there is no reason to have it _be_ noinstr _and_ I should
also make it called from the instrumentable sections of the irqentry_*() calls.

So something like this patch on top of this series?  [With an equivalent change
for pkrs_restore_irq().]

11:03:18 > git di
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index c7356733632e..1c0a70a17e93 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -360,10 +360,11 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
                rcu_irq_enter();
                instrumentation_begin();
                trace_hardirqs_off_finish();
+               pkrs_save_irq(regs);
                instrumentation_end();
 
                ret.exit_rcu = true;
-               goto done;
+               return ret;
        }
 
        /*
@@ -376,10 +377,9 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
        instrumentation_begin();
        rcu_irq_enter_check_tick();
        trace_hardirqs_off_finish();
+       pkrs_save_irq(regs);
        instrumentation_end();
 
-done:
-       pkrs_save_irq(regs);
        return ret;
 }
 
@@ -462,9 +462,9 @@ irqentry_state_t noinstr irqentry_nmi_enter(struct pt_regs *regs)
        instrumentation_begin();
        trace_hardirqs_off_finish();
        ftrace_nmi_enter();
+       pkrs_save_irq(regs);
        instrumentation_end();
 
-       pkrs_save_irq(regs);
        return irq_state;
 }


> 
> >  	return ret;
> >  }
> >  
> > @@ -404,7 +407,12 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
> >  	/* Check whether this returns to user mode */
> >  	if (user_mode(regs)) {
> >  		irqentry_exit_to_user_mode(regs);
> > -	} else if (!regs_irqs_disabled(regs)) {
> > +		return;
> > +	}
> > +
> > +	pkrs_restore_irq(regs);
> 
> At least you are now putting it consistently at the wrong place
> vs. noinstr.

Indeed.  Sorry about not understanding noinstr fully.

> 
> Though, if you look at the xen_pv_evtchn_do_upcall() part where you
> added this extra invocation you might figure out that adding
> pkrs_restore_irq() to irqentry_exit_cond_resched() and explicitely to
> the 'else' path in irqentry_exit() makes it magically consistent for
> both use cases.
> 

Thank you, yes good catch.  However, I think I need at least 1 more call in the
!regs_irqs_disabled() && state.exit_rcu case right?

11:29:48 > git di
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 717091910ebc..667676ebc129 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -363,8 +363,6 @@ __visible noinstr void xen_pv_evtchn_do_upcall(struct pt_regs *regs)
 
        inhcall = get_and_clear_inhcall();
        if (inhcall && !WARN_ON_ONCE(state.exit_rcu)) {
-               /* Normally called by irqentry_exit, restore pkrs here */
-               pkrs_restore_irq(regs);
                irqentry_exit_cond_resched();
                instrumentation_end();
                restore_inhcall(inhcall);
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 1c0a70a17e93..60ae3d4c9cc0 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -385,6 +385,7 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 
 void irqentry_exit_cond_resched(void)
 {
+       pkrs_restore_irq(regs);
        if (!preempt_count()) {
                /* Sanity check RCU and thread stack */
                rcu_irq_exit_check_preempt();
@@ -408,8 +409,6 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
                return;
        }
 
-       pkrs_restore_irq(regs);
-
        if (!regs_irqs_disabled(regs)) {
                /*
                 * If RCU was not watching on entry this needs to be done
@@ -421,6 +420,7 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
                        /* Tell the tracer that IRET will enable interrupts */
                        trace_hardirqs_on_prepare();
                        lockdep_hardirqs_on_prepare(CALLER_ADDR0);
+                       pkrs_restore_irq(regs);
                        instrumentation_end();
                        rcu_irq_exit();
                        lockdep_hardirqs_on(CALLER_ADDR0);
@@ -439,6 +439,10 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
                trace_hardirqs_on();
                instrumentation_end();
        } else {
+               instrumentation_begin();
+               pkrs_restore_irq(regs);
+               instrumentation_end();
+
                /*
                 * IRQ flags state is correct already. Just tell RCU if it
                 * was not watching on entry.
@@ -470,8 +474,8 @@ irqentry_state_t noinstr irqentry_nmi_enter(struct pt_regs *regs)
 
 void noinstr irqentry_nmi_exit(struct pt_regs *regs, irqentry_state_t irq_state)
 {
-       pkrs_restore_irq(regs);
        instrumentation_begin();
+       pkrs_restore_irq(regs);
        ftrace_nmi_exit();
        if (irq_state.lockdep) {
                trace_hardirqs_on_prepare();


Thank you again for the review,
Ira


[0] https://lore.kernel.org/lkml/20210804043231.2655537-5-ira.weiny@intel.com/
[1] https://lore.kernel.org/lkml/20201217131924.GW3040@hirez.programming.kicks-ass.net/
[2] https://lore.kernel.org/lkml/20201216013202.GY1563847@iweiny-DESK2.sc.intel.com/
[3] https://lore.kernel.org/lkml/87y2hwqwng.fsf@nanos.tec.linutronix.de/

> Thanks,
> 
>         tglx
