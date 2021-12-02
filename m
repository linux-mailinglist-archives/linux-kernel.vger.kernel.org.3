Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8361466116
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 11:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241274AbhLBKHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 05:07:09 -0500
Received: from foss.arm.com ([217.140.110.172]:60890 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356743AbhLBKGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 05:06:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6032142F;
        Thu,  2 Dec 2021 02:03:08 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.65.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB3303F7D7;
        Thu,  2 Dec 2021 02:03:06 -0800 (PST)
Date:   Thu, 2 Dec 2021 10:03:02 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        rcu@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        paulmck@kernel.org, mtosatti <mtosatti@redhat.com>,
        frederic <frederic@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2] Documentation: Fill the gaps about entry/noinstr
 constraints
Message-ID: <YaiZ1rXsxWsuDbe3@FVFF77S0Q05N>
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

The content looks good, and I'm all out of nits to pick, so FWIW:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

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
> +The states which need to be updated are:
> +
> +  * Lockdep
> +  * RCU
> +  * Preemption counter
> +  * Tracing
> +  * Time accounting
> +
> +The update order depends on the transition type and is explained below in
> +the transition type sections.
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
> +
> +Such code has to be marked with the 'noinstr' attribute. That places the
> +code into a special section which is taboo for instrumentation and debug
> +facilities.
> +
> +In a function which is marked 'noinstr' it's only allowed to call into
> +non-instrumentable code except when the invocation of instrumentable code
> +is annotated with a instrumentation_begin()/instrumentation_end() pair:
> +
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
> +
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
> +
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
> +
> +
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
> +
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
> +
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
> +
> +This also keeps the handling vs. irq_exit_rcu() symmetric and
> +irq_exit_rcu() must undo the preempt count elevation before handling soft
> +interrupts and irqentry_exit() also requires that because it might
> +schedule.
> +
> +
> +NMI and NMI-like exceptions
> +---------------------------
> +
> +NMIs and NMI like exceptions, e.g. Machine checks, double faults, debug
> +interrupts etc. can hit any context and have to be extra careful vs. the
> +state.
> +
> +Debug exceptions can handle user space breakpoints or watchpoints in the
> +same way as an interrupt which was raised while executing in user space,
> +but kernel mode debug exceptions have to be treated like NMIs as they can
> +even happen in NMI context, e.g. due to code patching.
> +
> +Also Machine check exceptions can handle user mode exceptions like regular
> +interrupts, but for kernel mode exceptions they have to be treated like
> +NMIs.
> +
> +NMIs and the other NMI-like exceptions handle state transitions in the most
> +straight forward way and do not differentiate between user and kernel mode
> +origin.
> +
> +The state update on entry is handled in irqentry_nmi_enter() which updates
> +state in the following order:
> +
> +  * Preemption counter
> +  * Lockdep
> +  * RCU
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
> +
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
