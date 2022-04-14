Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1745D500DF6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 14:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240175AbiDNMsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 08:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234116AbiDNMsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 08:48:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9BB2191362
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 05:46:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62BBC1424;
        Thu, 14 Apr 2022 05:46:06 -0700 (PDT)
Received: from lakrids (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 133923F70D;
        Thu, 14 Apr 2022 05:46:03 -0700 (PDT)
Date:   Thu, 14 Apr 2022 13:46:01 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v3 2/3] kasan, arm64: implement stack_trace_save_shadow
Message-ID: <YlgXiddhNAQxzmTC@lakrids>
References: <cover.1649877511.git.andreyknvl@google.com>
 <78cd352296ceb14da1d0136ff7d0a6818e594ab7.1649877511.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78cd352296ceb14da1d0136ff7d0a6818e594ab7.1649877511.git.andreyknvl@google.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 09:26:45PM +0200, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> Implement stack_trace_save_shadow() that collects stack traces based on
> the Shadow Call Stack (SCS) for arm64 by copiing the frames from SCS.
> 
> The implementation is best-effort and thus has limitations.
> 
> stack_trace_save_shadow() fully handles task and softirq contexts, which
> are both processed on the per-task SCS.
> 
> For hardirqs, the support is limited: stack_trace_save_shadow() does not
> collect the task part of the stack trace. For KASAN, this is not a problem,
> as stack depot only saves the interrupt part of the stack anyway.
> 
> Otherwise, stack_trace_save_shadow() also takes a best-effort approach
> with a focus on performance. Thus, it:
> 
> - Does not try to collect stack traces from other exceptions like SDEI.
> - Does not try to recover frames modified by KRETPROBES or by FTRACE.
> 
> However, stack_trace_save_shadow() does strip PTR_AUTH tags to avoid
> leaking them in stack traces.
> 
> The -ENOSYS return value is deliberatly used to match
> stack_trace_save_tsk_reliable().
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  mm/kasan/common.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)

As things stand, NAK to this patch, for the reasons I have laid out in
my replies to earlier postings and to my reply to the cover letter of
this posting.

To be clear, that NAK applies regardless of where this is placed within
the kernel tree. If we *really* need to have a special unwinder, that
should live under arch/arm64/, but my first objection is that it is not
necessary.

I am more than happy to extend the existing unwinder with some options
to minimize overhead (e.g. to stop dumping at an exception boundary),
since that sounds useful to you, and I know is relatively simple to
implement.

Thanks,
Mark.

> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index d9079ec11f31..23b30fa6e270 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -30,6 +30,68 @@
>  #include "kasan.h"
>  #include "../slab.h"
>  
> +#ifdef CONFIG_SHADOW_CALL_STACK
> +#include <linux/scs.h>
> +#include <asm/scs.h>
> +
> +/*
> + * Collect the stack trace from the Shadow Call Stack in a best-effort manner:
> + *
> + * - Do not collect the task part of the stack trace when in a hardirq.
> + * - Do not collect stack traces from other exception levels like SDEI.
> + * - Do not recover frames modified by KRETPROBES or by FTRACE.
> + *
> + * Note that marking the function with __noscs leads to unnacceptable
> + * performance impact, as helper functions stop being inlined.
> + */
> +static inline int stack_trace_save_shadow(unsigned long *store,
> +					  unsigned int size)
> +{
> +	unsigned long *scs_top, *scs_base, *frame;
> +	unsigned int len = 0;
> +
> +	/* Get the SCS base. */
> +	if (in_task() || in_serving_softirq()) {
> +		/* Softirqs reuse the task SCS area. */
> +		scs_base = task_scs(current);
> +	} else if (in_hardirq()) {
> +		/* Hardirqs use a per-CPU SCS area. */
> +		scs_base = *this_cpu_ptr(&irq_shadow_call_stack_ptr);
> +	} else {
> +		/* Ignore other exception levels. */
> +		return 0;
> +	}
> +
> +	/*
> +	 * Get the SCS pointer.
> +	 *
> +	 * Note that this assembly might be placed before the function's
> +	 * prologue. In this case, the last stack frame will be lost. This is
> +	 * acceptable: the lost frame will correspond to an internal KASAN
> +	 * function, which is not relevant to identify the external call site.
> +	 */
> +	asm volatile("mov %0, x18" : "=&r" (scs_top));
> +
> +	/* The top SCS slot is empty. */
> +	scs_top -= 1;
> +
> +	for (frame = scs_top; frame >= scs_base; frame--) {
> +		if (len >= size)
> +			break;
> +		/* Do not leak PTR_AUTH tags in stack traces. */
> +		store[len++] = ptrauth_strip_insn_pac(*frame);
> +	}
> +
> +	return len;
> +}
> +#else /* CONFIG_SHADOW_CALL_STACK */
> +static inline int stack_trace_save_shadow(unsigned long *store,
> +					  unsigned int size)
> +{
> +	return -ENOSYS;
> +}
> +#endif /* CONFIG_SHADOW_CALL_STACK */
> +
>  depot_stack_handle_t kasan_save_stack(gfp_t flags, bool can_alloc)
>  {
>  	unsigned long entries[KASAN_STACK_DEPTH];
> -- 
> 2.25.1
> 
