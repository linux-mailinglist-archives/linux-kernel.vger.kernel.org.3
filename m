Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948284ED709
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 11:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbiCaJel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 05:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbiCaJeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 05:34:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5792018462A
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 02:32:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1AF6923A;
        Thu, 31 Mar 2022 02:32:50 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B0083F718;
        Thu, 31 Mar 2022 02:32:47 -0700 (PDT)
Date:   Thu, 31 Mar 2022 10:32:41 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v2 3/4] arm64: implement stack_trace_save_shadow
Message-ID: <YkV1ORaR97g45Fag@FVFF77S0Q05N>
References: <cover.1648049113.git.andreyknvl@google.com>
 <0bb72ea8fa88ef9ae3508c23d993952a0ae6f0f9.1648049113.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bb72ea8fa88ef9ae3508c23d993952a0ae6f0f9.1648049113.git.andreyknvl@google.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 04:32:54PM +0100, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> Implement the stack_trace_save_shadow() interface that collects stack
> traces based on the Shadow Call Stack (SCS) for arm64.
> 
> The implementation walks through available SCS pointers (the per-task one
> and the per-interrupt-type ones) and copies the frames.
> 
> Note that the frame of the interrupted function is not included into
> the stack trace, as it is not yet saved on the SCS when an interrupt
> happens.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  arch/arm64/Kconfig             |  1 +
>  arch/arm64/kernel/stacktrace.c | 83 ++++++++++++++++++++++++++++++++++
>  2 files changed, 84 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index a659e238f196..d89cecf6c923 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -201,6 +201,7 @@ config ARM64
>  	select MMU_GATHER_RCU_TABLE_FREE
>  	select HAVE_RSEQ
>  	select HAVE_RUST
> +	select HAVE_SHADOW_STACKTRACE
>  	select HAVE_STACKPROTECTOR
>  	select HAVE_SYSCALL_TRACEPOINTS
>  	select HAVE_KPROBES
> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
> index e4103e085681..89daa710d91b 100644
> --- a/arch/arm64/kernel/stacktrace.c
> +++ b/arch/arm64/kernel/stacktrace.c
> @@ -12,9 +12,11 @@
>  #include <linux/sched/debug.h>
>  #include <linux/sched/task_stack.h>
>  #include <linux/stacktrace.h>
> +#include <linux/scs.h>
>  
>  #include <asm/irq.h>
>  #include <asm/pointer_auth.h>
> +#include <asm/scs.h>
>  #include <asm/stack_pointer.h>
>  #include <asm/stacktrace.h>
>  
> @@ -210,3 +212,84 @@ noinline notrace void arch_stack_walk(stack_trace_consume_fn consume_entry,
>  
>  	walk_stackframe(task, &frame, consume_entry, cookie);
>  }
> +
> +static const struct {
> +	unsigned long ** __percpu saved;
> +	unsigned long ** __percpu base;
> +} scs_parts[] = {
> +#ifdef CONFIG_ARM_SDE_INTERFACE
> +	{
> +		.saved = &sdei_shadow_call_stack_critical_saved_ptr,
> +		.base = &sdei_shadow_call_stack_critical_ptr,
> +	},
> +	{
> +		.saved = &sdei_shadow_call_stack_normal_saved_ptr,
> +		.base = &sdei_shadow_call_stack_normal_ptr,
> +	},
> +#endif /* CONFIG_ARM_SDE_INTERFACE */
> +	{
> +		.saved = &irq_shadow_call_stack_saved_ptr,
> +		.base = &irq_shadow_call_stack_ptr,
> +	},
> +};
> +
> +static inline bool walk_shadow_stack_part(
> +				unsigned long *scs_top, unsigned long *scs_base,
> +				unsigned long *store, unsigned int size,
> +				unsigned int *skipnr, unsigned int *len)
> +{
> +	unsigned long *frame;
> +
> +	for (frame = scs_top; frame >= scs_base; frame--) {
> +		if (*skipnr > 0) {
> +			(*skipnr)--;
> +			continue;
> +		}
> +		/*
> +		 * Do not leak PTR_AUTH tags in stack traces.
> +		 * Use READ_ONCE_NOCHECK as SCS is poisoned with Generic KASAN.
> +		 */
> +		store[(*len)++] =
> +			ptrauth_strip_insn_pac(READ_ONCE_NOCHECK(*frame));
> +		if (*len >= size)
> +			return true;
> +	}
> +
> +	return false;
> +}

This doesn't do any of the trampoline repatinting (e.g. for kretprobes or
ftrace graph caller) that the regular unwinder does, so if either of those are
in use this is going to produce bogus results.

I really don't want to have to duplicate this logic.

> +
> +noinline notrace int arch_stack_walk_shadow(unsigned long *store,
> +					    unsigned int size,
> +					    unsigned int skipnr)
> +{
> +	unsigned long *scs_top, *scs_base, *scs_next;
> +	unsigned int len = 0, part;
> +
> +	preempt_disable();

This doesn't look necessary; it's certinaly not needed for the regular unwinder.

Critically, in the common case of unwinding just the task stack, we don't need
to look at any of the per-cpu stacks, and so there's no need to disable
preemption. See the stack nesting logic in the regular unwinder.

If we *do* need to unwind per-cpu stacks, we figure that out and verify our
countext *at* the transition point.

> +
> +	/* Get the SCS pointer. */
> +	asm volatile("mov %0, x18" : "=&r" (scs_top));

Does the compiler guarantee where this happens relative to any prologue
manipulation of x18?

This seems like something we should be using a compilar intrinsic for, or have
a wrapper that passes this in if necessary.

> +
> +	/* The top SCS slot is empty. */
> +	scs_top -= 1;
> +
> +	/* Handle SDEI and hardirq frames. */
> +	for (part = 0; part < ARRAY_SIZE(scs_parts); part++) {
> +		scs_next = *this_cpu_ptr(scs_parts[part].saved);
> +		if (scs_next) {
> +			scs_base = *this_cpu_ptr(scs_parts[part].base);
> +			if (walk_shadow_stack_part(scs_top, scs_base, store,
> +						   size, &skipnr, &len))
> +				goto out;
> +			scs_top = scs_next;
> +		}
> +	}

We have a number of portential stack nesting orders (and may need to introduce
more stacks in future), so I think we need to be more careful with this. The
regular unwinder handles that dynamically.

Thanks,
Mark.

> +
> +	/* Handle task and softirq frames. */
> +	scs_base = task_scs(current);
> +	walk_shadow_stack_part(scs_top, scs_base, store, size, &skipnr, &len);
> +
> +out:
> +	preempt_enable();
> +	return len;
> +}
> -- 
> 2.25.1
> 
