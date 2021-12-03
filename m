Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFAAD467EA5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 21:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383019AbhLCULk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 15:11:40 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:57052 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383020AbhLCULg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 15:11:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7CFDBB8293D;
        Fri,  3 Dec 2021 20:08:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C93C53FCD;
        Fri,  3 Dec 2021 20:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638562089;
        bh=eIm0LQXQ7LaCGNOp4mV8WUsoxv4zNluQOJ0CqZwn6aw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=g2zd/0JmGk+oY3ct7QTPRKNmIp0oZYZmj1qJoVcfQVU2W/pbGLgEwqLWUs5fyiByW
         +R6TBxVedajdoQdgrTFnR3V7uLVajQM9iQakNjdLvbUBErcwDTqK0lytHPPO449cxr
         JvSI4w0Bzs265OYNxvmx8oGnqyUFHSPsrfw3pSve4tyffmf43CnXRV8WwzOqqSSM+o
         1jpfdK93z/I/tute5LqJI3tBVxZNu4KN3Qm7PDtBszmIjGEq9JoNdHCPLXNtn/BurW
         B+UUgNz45tgje4wzLOke4GNa+Uya3AltrmPYdp6IQI7/rLqYIjM2wcb6JL4liba5VL
         ddqrF0kaIjamg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C55465C1108; Fri,  3 Dec 2021 12:08:08 -0800 (PST)
Date:   Fri, 3 Dec 2021 12:08:08 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        rcu@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        mtosatti <mtosatti@redhat.com>, frederic <frederic@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2] Documentation: Fill the gaps about entry/noinstr
 constraints
Message-ID: <20211203200808.GT641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <8719ad46cc29a2c5d7baac3c35770e5460ab8d5c.camel@redhat.com>
 <875ys9dacq.ffs@tglx>
 <20211130091356.7336e277@gandalf.local.home>
 <878rx5b7i5.ffs@tglx>
 <YadU1aSE6/0yGWny@FVFF77S0Q05N>
 <87v9088a5q.ffs@tglx>
 <Yae9tbtZW5mjcBVt@FVFF77S0Q05N>
 <87ee6w83yw.ffs@tglx>
 <87bl2083mu.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bl2083mu.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 09:35:37PM +0100, Thomas Gleixner wrote:
> The entry/exit handling for exceptions, interrupts, syscalls and KVM is
> not really documented except for some comments.
> 
> Fill the gaps.
> 
> Reported-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Good stuff, thank you very much!  I hope that this documentation helps
people bringing up new hardware, and from a more selfish viewpoint, I
especially hope that it reduces the number of "RCU is broken!" complaints
from them.  ;-)

Some native-English-speaker wordsmithing below.  Anything that might be
important from a technical viewpoint is marked "!!!".

							Thanx, Paul

> ---
> V2: Be more precise, fix formatting and typos - Mark 
> ---
>  Documentation/core-api/entry.rst |  274 +++++++++++++++++++++++++++++++++++++++
>  Documentation/core-api/index.rst |    8 +
>  2 files changed, 282 insertions(+)
> 
> --- /dev/null
> +++ b/Documentation/core-api/entry.rst
> @@ -0,0 +1,274 @@
> +Entry/exit handling for exceptions, interrupts, syscalls and KVM
> +================================================================
> +
> +For any transition from one execution domain into another the kernel
> +requires update of various states. The state updates have strict rules
> +versus ordering.
> +
> +
> +The states which need to be updated are:

I suggest reworking the above two paragraphs together something like
the following:

All transitions between execution domains require state updates which
are subject to strict ordering constraints.  State updates are required
for the following:

> +  * Lockdep
> +  * RCU

!!! As you do below, I suggest replacing "RCU" with:

  * RCU / Context tracking

With some luck, RCU's dyntick-idle tracking will be pulled into the
context-tracking code.  Doing this could allow a pair of atomic RMW
operations to be combined into one, at least if appropriate adjustments
can be applied.

> +  * Preemption counter
> +  * Tracing
> +  * Time accounting
> +
> +The update order depends on the transition type and is explained below in
> +the transition type sections.
@@@
> +
> +Non-instrumentable code - noinstr
> +---------------------------------
> +
> +Low level transition code cannot be instrumented before RCU is watching and
> +after RCU went into a non watching state (NOHZ, NOHZ_FULL) as most
> +instrumentation facilities depend on RCU.
> +
> +Aside of that many architectures have to save register state, e.g. debug or
> +cause registers before another exception of the same type can happen. A
> +breakpoint in the breakpoint entry code would overwrite the debug registers
> +of the inital breakpoint.

I suggest combining the above two paragraphs something like the following:

Most instrumentation facilities depend on RCU, so intrumentation is
prohibited for entry code before RCU starts watching and exit code
after RCU stops watching.  In addition, many architectures must save
and restore register state, which means that (for example) a breakpoint
in the breakpoint entry code would overwrite the debug registers of the
initial breakpoint.

> +Such code has to be marked with the 'noinstr' attribute. That places the
> +code into a special section which is taboo for instrumentation and debug
> +facilities.
> +
> +In a function which is marked 'noinstr' it's only allowed to call into
> +non-instrumentable code except when the invocation of instrumentable code
> +is annotated with a instrumentation_begin()/instrumentation_end() pair:

I suggest combining the above two paragraphs something like the following:

Such code must be marked with the 'noinstr' attribute, placing that
code into a special section inaccessible to instrumentation and debug
facilities.  Some functions are partially instrumentable, which is
handled by marking them nointr and using instrumentation_begin() and
instrumentation_end() to flag the instrumentable ranges of code:

> +.. code-block:: c
> +
> +  noinstr void entry(void)
> +  {
> +  	handle_entry();     // <-- must be 'noinstr' or '__always_inline'
> +	...
> +
> +	instrumentation_begin();
> +	handle_context();   // <-- instrumentable code
> +	instrumentation_end();
> +
> +	...
> +	handle_exit();      // <-- must be 'noinstr' or '__always_inline'
> +  }
> +
> +This allows verification of the 'noinstr' restrictions via objtool on
> +supported architectures.
> +
> +Invoking non-instrumentable functions from instrumentable context has no
> +restrictions and is useful to protect e.g. state switching which would
> +cause malfunction if instrumented.
> +
> +All non-instrumentable entry/exit code sections before and after the RCU
> +state transitions must run with interrupts disabled.
> +
> +Syscalls
> +--------
> +
> +Syscall entry code starts in low level architecture specific assembly code
> +and calls out into C-code after establishing low level architecture
> +specific state and stack frames. This low level code must not be
> +instrumented. A typical syscall handling function invoked from low level
> +assembly code looks like this:

(Nits, but whatever.  I am (perhaps misguidedly) asserting that assembly
code is by definition low-level and architecture-specific.  That lets
"low-level" tag the C code, helping the reader make the connection
between the two mentions of C code.  The above paragraph then looks
something like this.)

Syscall-entry code starts in assembly code and calls out into low-level
C code after establishing low-level architecture-specific state and stack
frames. This low-level C code must not be instrumented. A typical syscall
handling function invoked from low-level assembly code looks like this:

> +.. code-block:: c
> +
> +  noinstr void syscall(struct pt_regs *regs, int nr)
> +  {
> +	arch_syscall_enter(regs);
> +	nr = syscall_enter_from_user_mode(regs, nr);
> +
> +	instrumentation_begin();
> +	if (!invoke_syscall(regs, nr) && nr != -1)
> +	 	result_reg(regs) = __sys_ni_syscall(regs);
> +	instrumentation_end();
> +
> +	syscall_exit_to_user_mode(regs);
> +  }
> +
> +syscall_enter_from_user_mode() first invokes enter_from_user_mode() which
> +establishes state in the following order:
> +
> +  * Lockdep
> +  * RCU / Context tracking
> +  * Tracing
> +
> +and then invokes the various entry work functions like ptrace, seccomp,
> +audit, syscall tracing etc. After the function returns instrumentable code
> +can be invoked. After returning from the syscall handler the instrumentable
> +code section ends and syscall_exit_to_user_mode() is invoked.

Not at all a big deal, but I suggest reworking the above paragraphs as
follows to avoid the ambiguous "the function" in the second sentence:

and then invokes the various entry work functions like ptrace, seccomp,
audit, syscall tracing, etc. After all that is done, the instrumentable
invoke_syscall function can be invoked. The instrumentable code section
then ends, after which syscall_exit_to_user_mode() is invoked.

> +syscall_exit_to_user_mode() handles all work which needs to be done before
> +returning to user space like tracing, audit, signals, task work etc. After
> +that it invokes exit_to_user_mode() which again handles the state
> +transition in the reverse order:
> +
> +  * Tracing
> +  * RCU / Context tracking
> +  * Lockdep
> +
> +syscall_enter_from_user_mode() and syscall_exit_to_user_mode() are also
> +available as fine grained subfunctions in cases where the architecture code
> +has to do extra work between the various steps. In such cases it has to
> +ensure that enter_from_user_mode() is called first on entry and
> +exit_to_user_mode() is called last on exit.

!!! Here I have a question.  Can calls to enter_from_user_mode()
be nested?  RCU is OK with this, but I am not so sure that everything
else is.  If nesting is prohibited, this paragraph should explicitly
say that.  If nesting is theoretically possible, but should be avoided,
it would be good to say that as well.  (Otherwise "It looks like it
might work, so let's go for it!")

> +KVM
> +---
> +
> +Entering or exiting guest mode is very similar to syscalls. From the host
> +kernel point of view the CPU goes off into user space when entering the
> +guest and returns to the kernel on exit.
> +
> +kvm_guest_enter_irqoff() is a KVM specific variant of exit_to_user_mode()
> +and kvm_guest_exit_irqoff() is the KVM variant of enter_from_user_mode().
> +The state operations have the same ordering.
> +
> +Task work handling is done separately for guest at the boundary of the
> +vcpu_run() loop via xfer_to_guest_mode_handle_work() which is a subset of
> +the work handled on return to user space.
> +
> +
> +Interrupts and regular exceptions
> +---------------------------------
> +
> +Interrupts entry and exit handling is slightly more complex than syscalls
> +and KVM transitions.
> +
> +If an interrupt is raised while the CPU executes in user space, the entry
> +and exit handling is exactly the same as for syscalls.
> +
> +If the interrupt is raised while the CPU executes in kernel space the entry
> +and exit handling is slightly different. RCU state is only updated when the
> +interrupt was raised in context of the CPU's idle task because that's the
> +only kernel context where RCU can be not watching on NOHZ enabled kernels.
> +Lockdep and tracing have to be updated unconditionally.

!!! You lost me on this one.  Does that second-to-last sentence instead
want to end something like this?  "... where RCU will not be watching
when running on non-nohz_full CPUs."

> +irqentry_enter() and irqentry_exit() provide the implementation for this.
> +
> +The architecture specific part looks similar to syscall handling:
> +
> +.. code-block:: c
> +
> +  noinstr void interrupt(struct pt_regs *regs, int nr)
> +  {
> +	arch_interrupt_enter(regs);
> +	state = irqentry_enter(regs);
> +
> +	instrumentation_begin();
> +
> +	irq_enter_rcu();
> +	invoke_irq_handler(regs, nr);
> +	irq_exit_rcu();
> +
> +	instrumentation_end();
> +
> +	irqentry_exit(regs, state);
> +  }
> +
> +Note, that the invocation of the actual interrupt handler is within a
> +irq_enter_rcu() and irq_exit_rcu() pair.

Nit:  You don't need the comma.  "Note that the invocation..."

> +irq_enter_rcu() updates the preemption count which makes in_hardirq()
> +return true, handles NOHZ tick state and interrupt time accounting. This
> +means that up to the point where irq_enter_rcu() is invoked in_hardirq()
> +returns false.
> +
> +irq_exit_rcu() handles interrupt time accounting, undoes the preemption
> +count update and eventually handles soft interrupts and NOHZ tick state.
> +
> +The preemption count could be established in irqentry_enter() already, but
> +there is no real value to do so. This allows the preemption count to be
> +traced and just puts a restriction on the early entry code up to
> +irq_enter_rcu().

It took me awhile to work out that the "This" refers to in "This
allows".  So I suggest the following for that last paragraph:

In theory, the preemption count could be updated in irqentry_enter().
In practice, deferring this update to irq_enter_rcu() allows the
preemption-count code to be traced, while also maintaining symmetry
with irq_exit_rcu() and irqentry_exit(), which are described in the
next paragraph.  The only downside is that the early entry code up to
irq_enter_rcu() must be aware that the preemption count has not yet been
updated with the HARDIRQ_OFFSET state.

> +This also keeps the handling vs. irq_exit_rcu() symmetric and
> +irq_exit_rcu() must undo the preempt count elevation before handling soft
> +interrupts and irqentry_exit() also requires that because it might
> +schedule.

I suggest reworking the preceding paragraph something like this:

Note that irq_exit_rcu() must remove HARDIRQ_OFFSET from the preemption
count before it handles soft interrupts, whose handlers must run in BH
context rather than irq-disabled context.  In addition, irqentry_exit()
might schedule, which also requires that HARDIRQ_OFFSET has been removed
from the preemption count.

> +NMI and NMI-like exceptions
> +---------------------------
> +
> +NMIs and NMI like exceptions, e.g. Machine checks, double faults, debug
> +interrupts etc. can hit any context and have to be extra careful vs. the
> +state.

I suggest the following for the above paragraph, but at least please
translate "Maschine" the rest of the way to "machine".  ;-)

NMIs and NMI-like exceptions (machine checks, double faults, debug
interrupts, etc.) can hit any context and must be extra careful with
the state.

> +Debug exceptions can handle user space breakpoints or watchpoints in the
> +same way as an interrupt which was raised while executing in user space,
> +but kernel mode debug exceptions have to be treated like NMIs as they can
> +even happen in NMI context, e.g. due to code patching.
> +
> +Also Machine check exceptions can handle user mode exceptions like regular
> +interrupts, but for kernel mode exceptions they have to be treated like
> +NMIs.

If I understand correctly, for the purpose of state transitions, debug
exceptions work the same way as machine-check exceptions.  If so, I
suggest combining the above two paragraphs something like the following:

State changes for debug exceptions and machine-check exceptions depend
on whether these exceptions happened in userspace (breakpoints or
watchpoints) or in kernel mode (code patching).  From userspace, they
are treated like interrupts, while from kernel mode they are treated
like NMIs.

> +NMIs and the other NMI-like exceptions handle state transitions in the most
> +straight forward way and do not differentiate between user and kernel mode
> +origin.

I suggest something like the following for the above paragraph:

NMIs and other NMI-like exceptions handle state transitions without
distinguishing between user-mode and kernel-mode origin.

> +The state update on entry is handled in irqentry_nmi_enter() which updates
> +state in the following order:
> +
> +  * Preemption counter
> +  * Lockdep
> +  * RCU

Here too, I suggest replacing that "RCU" with this:

  * RCU / Context tracking

> +  * Tracing
> +
> +The exit counterpart irqentry_nmi_exit() does the reverse operation in the
> +reverse order.
> +
> +Note, that the update of the preemption counter has to be the first
> +operation on enter and the last operation on exit. The reason is that both
> +lockdep and RCU rely on in_nmi() returning true in this case. The
> +preemption count modification in the NMI entry/exit case must not be
> +traced.

Please remove the comma following "Note".

> +Architecture specific code looks like this:
> +
> +.. code-block:: c
> +
> +  noinstr void nmi(struct pt_regs *regs)
> +  {
> +	arch_nmi_enter(regs);
> +	state = irqentry_nmi_enter(regs);
> +
> +	instrumentation_begin();
> +	nmi_handler(regs);
> +	instrumentation_end();
> +
> +	irqentry_nmi_exit(regs);
> +  }
> +
> +and for e.g. a debug exception it can look like this:
> +
> +.. code-block:: c
> +
> +  noinstr void debug(struct pt_regs *regs)
> +  {
> +	arch_nmi_enter(regs);
> +
> +	debug_regs = save_debug_regs();
> +
> +	if (user_mode(regs)) {
> +		state = irqentry_enter(regs);
> +
> +		instrumentation_begin();
> +		user_mode_debug_handler(regs, debug_regs);
> +		instrumentation_end();
> +
> +		irqentry_exit(regs, state);
> +  	} else {
> +  		state = irqentry_nmi_enter(regs);
> +
> +		instrumentation_begin();
> +		kernel_mode_debug_handler(regs, debug_regs);
> +		instrumentation_end();
> +
> +		irqentry_nmi_exit(regs, state);
> +	}
> +  }
> +
> +There is no combined irqentry_nmi_if_kernel() function available as the
> +above cannot be handled in an exception agnostic way.
> --- a/Documentation/core-api/index.rst
> +++ b/Documentation/core-api/index.rst
> @@ -44,6 +44,14 @@ Library functionality that is used throu
>     timekeeping
>     errseq
>  
> +Low level entry and exit
> +========================
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   entry
> +
>  Concurrency primitives
>  ======================
>  
