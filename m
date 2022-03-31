Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078514ED6AC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 11:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbiCaJV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 05:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233723AbiCaJVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 05:21:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E9D1232EC9
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 02:19:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9652723A;
        Thu, 31 Mar 2022 02:19:35 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B74053F718;
        Thu, 31 Mar 2022 02:19:32 -0700 (PDT)
Date:   Thu, 31 Mar 2022 10:19:21 +0100
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
Subject: Re: [PATCH v2 1/4] stacktrace: add interface based on shadow call
 stack
Message-ID: <YkVyGdniIBXf4t8/@FVFF77S0Q05N>
References: <cover.1648049113.git.andreyknvl@google.com>
 <21e3e20ea58e242e3c82c19abbfe65b579e0e4b8.1648049113.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21e3e20ea58e242e3c82c19abbfe65b579e0e4b8.1648049113.git.andreyknvl@google.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 04:32:52PM +0100, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> Add a new interface stack_trace_save_shadow() for collecting stack traces
> by copying frames from the Shadow Call Stack.
> 
> Collecting stack traces this way is significantly faster: boot time
> of a defconfig build with KASAN enabled gets descreased by ~30%.

Hmm... just to check, do ou know if that's just because of hte linear copy, or
because we're skipping other work we have to do in the regular stacktrace?

> The few patches following this one add an implementation of
> stack_trace_save_shadow() for arm64.
> 
> The implementation of the added interface is not meant to use
> stack_trace_consume_fn to avoid making a function call for each
> collected frame to further improve performance.

... because we could easily provide an inline-optimized stack copy *without*
having to write a distinct unwinder, and I'd *really* like to avoid having a
bunch of distinct unwinders for arm64, as it really hinders maintenance. We're
working on fixing/improving the arm64 unwinder for things like
RELIABLE_STACKTRACE, and I know that some of that work is non-trivial to make
work with an SCS-based unwind rather than an FP-based unwind, and/or will
undermine the saving anyway.

> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  arch/Kconfig               |  6 ++++++
>  include/linux/stacktrace.h | 15 +++++++++++++++
>  kernel/stacktrace.c        | 21 +++++++++++++++++++++
>  3 files changed, 42 insertions(+)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index e12a4268c01d..207c1679c53a 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -1041,6 +1041,12 @@ config HAVE_RELIABLE_STACKTRACE
>  	  arch_stack_walk_reliable() function which only returns a stack trace
>  	  if it can guarantee the trace is reliable.
>  
> +config HAVE_SHADOW_STACKTRACE
> +	bool
> +	help
> +	  If this is set, the architecture provides the arch_stack_walk_shadow()
> +	  function, which collects the stack trace from the shadow call stack.
> +
>  config HAVE_ARCH_HASH
>  	bool
>  	default n
> diff --git a/include/linux/stacktrace.h b/include/linux/stacktrace.h
> index 97455880ac41..b74d1e42e157 100644
> --- a/include/linux/stacktrace.h
> +++ b/include/linux/stacktrace.h
> @@ -60,6 +60,9 @@ int arch_stack_walk_reliable(stack_trace_consume_fn consume_entry, void *cookie,
>  
>  void arch_stack_walk_user(stack_trace_consume_fn consume_entry, void *cookie,
>  			  const struct pt_regs *regs);
> +
> +int arch_stack_walk_shadow(unsigned long *store, unsigned int size,
> +			   unsigned int skipnr);
>  #endif /* CONFIG_ARCH_STACKWALK */
>  
>  #ifdef CONFIG_STACKTRACE
> @@ -108,4 +111,16 @@ static inline int stack_trace_save_tsk_reliable(struct task_struct *tsk,
>  }
>  #endif
>  
> +#if defined(CONFIG_STACKTRACE) && defined(CONFIG_HAVE_SHADOW_STACKTRACE)
> +int stack_trace_save_shadow(unsigned long *store, unsigned int size,
> +			    unsigned int skipnr);
> +#else
> +static inline int stack_trace_save_shadow(unsigned long *store,
> +					  unsigned int size,
> +					  unsigned int skipnr)
> +{
> +	return -ENOSYS;
> +}
> +#endif
> +
>  #endif /* __LINUX_STACKTRACE_H */
> diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
> index 9ed5ce989415..fe305861fd55 100644
> --- a/kernel/stacktrace.c
> +++ b/kernel/stacktrace.c
> @@ -237,6 +237,27 @@ unsigned int stack_trace_save_user(unsigned long *store, unsigned int size)
>  }
>  #endif
>  
> +#ifdef CONFIG_HAVE_SHADOW_STACKTRACE
> +/**
> + * stack_trace_save_shadow - Save a stack trace based on shadow call stack
> + * @store:	Pointer to the storage array
> + * @size:	Size of the storage array
> + * @skipnr:	Number of entries to skip at the start of the stack trace
> + *
> + * Return: Number of trace entries stored.
> + */
> +int stack_trace_save_shadow(unsigned long *store, unsigned int size,
> +			    unsigned int skipnr)
> +{
> +	/*
> +	 * Do not use stack_trace_consume_fn to avoid making a function
> +	 * call for each collected frame to improve performance.
> +	 * Skip + 1 frame to skip stack_trace_save_shadow.
> +	 */
> +	return arch_stack_walk_shadow(store, size, skipnr + 1);
> +}
> +#endif

If we really need this, can we make it an __always_inline in a header so that
we can avoid the skip? Generally the skipping is problematic due to
inlining/outlining and LTO, and I'd like to avoid adding more of it
unnecessarily.

Thanks,
Mark.

> +
>  #else /* CONFIG_ARCH_STACKWALK */
>  
>  /*
> -- 
> 2.25.1
> 
