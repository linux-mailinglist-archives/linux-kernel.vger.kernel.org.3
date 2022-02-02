Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8CB4A745E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 16:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345415AbiBBPOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 10:14:24 -0500
Received: from foss.arm.com ([217.140.110.172]:37116 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239830AbiBBPOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 10:14:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0AB33113E;
        Wed,  2 Feb 2022 07:14:06 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.87.240])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 835533F73B;
        Wed,  2 Feb 2022 07:14:04 -0800 (PST)
Date:   Wed, 2 Feb 2022 15:13:57 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, ardb@kernel.org,
        catalin.marinas@arm.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH 2/6] sched/preempt: refactor sched_dynamic_update()
Message-ID: <YfqftfWSJfuH60Mi@FVFF77S0Q05N>
References: <20211109172408.49641-1-mark.rutland@arm.com>
 <20211109172408.49641-3-mark.rutland@arm.com>
 <20211210151343.GA755274@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210151343.GA755274@lothringen>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm looking at what I need to do to rebase/repost this atop v5.17-rc2, and I
realised I need your S-o-B to take your suggestion below.

On Fri, Dec 10, 2021 at 04:13:43PM +0100, Frederic Weisbecker wrote:
> On Tue, Nov 09, 2021 at 05:24:04PM +0000, Mark Rutland wrote:
> > Currently sched_dynamic_update needs to open-code the enabled/disabled
> > function names for each preemption model it supoprts, when in practice
> > this is a boolean enabled/disabled state for each function.
> > 
> > Make this clearer and avoid repetition by defining the enabled/disabled
> > states at the function definition, and using helper macros to peform the
> > static_call_update(). Where x86 currently overrides the enabled
> > function, it is made to provide both the enabled and disabled states for
> > consistency, with defaults provided by the core code otherwise.

> > -#define __preempt_schedule_notrace_func preempt_schedule_notrace_thunk
> > +#define preempt_schedule_notrace_dynamic_enabled	preempt_schedule_notrace_thunk
> > +#define preempt_schedule_notrace_dynamic_disabled	NULL
> 
> I'm worried about un-greppable macro definitions like this.
I assume you mean that it's hard to go from:

  preempt_dynamic_enable(preempt_schedule_notrace);

... to this, because the `_dynamic_enabled` or `_dynamic_disabled` part gets
token-pasted on?

The above will show up in a grep for `preempt_schedule_notrace`, but I agree
it's not necessarily ideal, especially if grepping for an exact match.

> Also this enable/disable switch look like a common pattern on static call so
> how about moving that logic to static call itself? As in below (only
> build-tested):

Sure; if others also prefer that I'm more than happy to build atop.

Can I have your Signed-off-by for that, or can you post that as its own patch?

Thanks,
Mark.

> 
> diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
> index fe5efbcba824..64320c0a00a6 100644
> --- a/arch/x86/include/asm/preempt.h
> +++ b/arch/x86/include/asm/preempt.h
> @@ -117,7 +117,7 @@ extern asmlinkage void preempt_schedule_notrace_thunk(void);
>  
>  #ifdef CONFIG_PREEMPT_DYNAMIC
>  
> -DECLARE_STATIC_CALL(preempt_schedule, __preempt_schedule_func);
> +DECLARE_STATIC_CALL_TOGGLE(preempt_schedule, __preempt_schedule_func);
>  
>  #define __preempt_schedule() \
>  do { \
> @@ -125,7 +125,7 @@ do { \
>  	asm volatile ("call " STATIC_CALL_TRAMP_STR(preempt_schedule) : ASM_CALL_CONSTRAINT); \
>  } while (0)
>  
> -DECLARE_STATIC_CALL(preempt_schedule_notrace, __preempt_schedule_notrace_func);
> +DECLARE_STATIC_CALL_TOGGLE(preempt_schedule_notrace, __preempt_schedule_notrace_func);
>  
>  #define __preempt_schedule_notrace() \
>  do { \
> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
> index 2e2b8d6140ed..a3d99ffc32ca 100644
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -456,7 +456,7 @@ irqentry_state_t noinstr irqentry_enter(struct pt_regs *regs);
>   */
>  void irqentry_exit_cond_resched(void);
>  #ifdef CONFIG_PREEMPT_DYNAMIC
> -DECLARE_STATIC_CALL(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
> +DECLARE_STATIC_CALL_TOGGLE(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
>  #endif
>  
>  /**
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 77755ac3e189..f4f5f4f3b496 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -94,7 +94,7 @@ extern int __cond_resched(void);
>  
>  extern int __cond_resched(void);
>  
> -DECLARE_STATIC_CALL(might_resched, __cond_resched);
> +DECLARE_STATIC_CALL_TOGGLE(might_resched, __cond_resched);
>  
>  static __always_inline void might_resched(void)
>  {
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 78c351e35fec..01a9e8590ea0 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -2010,7 +2010,7 @@ extern int __cond_resched(void);
>  
>  #ifdef CONFIG_PREEMPT_DYNAMIC
>  
> -DECLARE_STATIC_CALL(cond_resched, __cond_resched);
> +DECLARE_STATIC_CALL_TOGGLE(cond_resched, __cond_resched);
>  
>  static __always_inline int _cond_resched(void)
>  {
> diff --git a/include/linux/static_call.h b/include/linux/static_call.h
> index 3e56a9751c06..351ac27fa9d1 100644
> --- a/include/linux/static_call.h
> +++ b/include/linux/static_call.h
> @@ -156,6 +156,19 @@ extern void arch_static_call_transform(void *site, void *tramp, void *func, bool
>  			     STATIC_CALL_TRAMP_ADDR(name), __F);	\
>  })
>  
> +#define static_call_toggle(name, enable)				\
> +({									\
> +	struct static_call_toggle *__G = &STATIC_CALL_TOGGLE(name);	\
> +	if (enable)							\
> +		static_call_update(name, __G->func_enabled);		\
> +	else								\
> +		static_call_update(name, __G->func_disabled);		\
> +})
> +
> +#define static_call_enable(name) static_call_toggle(name, 1);
> +#define static_call_disable(name) static_call_toggle(name, 0);
> +
> +
>  #define static_call_query(name) (READ_ONCE(STATIC_CALL_KEY(name).func))
>  
>  #ifdef CONFIG_HAVE_STATIC_CALL_INLINE
> @@ -333,4 +346,27 @@ static inline int static_call_text_reserved(void *start, void *end)
>  #define DEFINE_STATIC_CALL_RET0(name, _func)				\
>  	__DEFINE_STATIC_CALL(name, _func, __static_call_return0)
>  
> +#define __DEFINE_STATIC_CALL_TOGGLE(name, _func_enabled, _func_disabled) \
> +	struct static_call_toggle STATIC_CALL_TOGGLE(name) = {			\
> +		.key = &STATIC_CALL_KEY(name),					\
> +		.func_enabled = _func_enabled,					\
> +		.func_disabled = _func_disabled,				\
> +	}
> +
> +#define DEFINE_STATIC_CALL_ENABLED(name, _func)					\
> +	DEFINE_STATIC_CALL(name, _func);					\
> +	__DEFINE_STATIC_CALL_TOGGLE(name, _func, NULL)
> +
> +#define DEFINE_STATIC_CALL_DISABLED(name, _func)				\
> +	DEFINE_STATIC_CALL_NULL(name, _func);					\
> +	__DEFINE_STATIC_CALL_TOGGLE(name, _func, NULL)
> +
> +#define DEFINE_STATIC_CALL_ENABLED_RET0(name, _func)				\
> +	DEFINE_STATIC_CALL(name, _func);					\
> +	__DEFINE_STATIC_CALL_TOGGLE(name, _func, __static_call_return0)
> +
> +#define DEFINE_STATIC_CALL_DISABLED_RET0(name, _func)				\
> +	DEFINE_STATIC_CALL_RET0(name, _func);					\
> +	__DEFINE_STATIC_CALL_TOGGLE(name, _func, __static_call_return0)
> +
>  #endif /* _LINUX_STATIC_CALL_H */
> diff --git a/include/linux/static_call_types.h b/include/linux/static_call_types.h
> index 5a00b8b2cf9f..e150f29aee2d 100644
> --- a/include/linux/static_call_types.h
> +++ b/include/linux/static_call_types.h
> @@ -18,6 +18,9 @@
>  #define STATIC_CALL_TRAMP(name)		__PASTE(STATIC_CALL_TRAMP_PREFIX, name)
>  #define STATIC_CALL_TRAMP_STR(name)	__stringify(STATIC_CALL_TRAMP(name))
>  
> +#define STATIC_CALL_TOGGLE_PREFIX	__SCG_
> +#define STATIC_CALL_TOGGLE(name)	__PASTE(STATIC_CALL_TOGGLE_PREFIX, name)
> +
>  /*
>   * Flags in the low bits of static_call_site::key.
>   */
> @@ -38,6 +41,10 @@ struct static_call_site {
>  	extern struct static_call_key STATIC_CALL_KEY(name);		\
>  	extern typeof(func) STATIC_CALL_TRAMP(name);
>  
> +#define DECLARE_STATIC_CALL_TOGGLE(name, func)				\
> +	DECLARE_STATIC_CALL(name, func);				\
> +	extern struct static_call_toggle STATIC_CALL_TOGGLE(name);
> +
>  #ifdef CONFIG_HAVE_STATIC_CALL
>  
>  #define __raw_static_call(name)	(&STATIC_CALL_TRAMP(name))
> @@ -68,6 +75,13 @@ struct static_call_key {
>  	};
>  };
>  
> +struct static_call_toggle {
> +	struct static_call_key *key;
> +	void *func_enabled;
> +	void *func_disabled;
> +};
> +
> +
>  #else /* !CONFIG_HAVE_STATIC_CALL_INLINE */
>  
>  #define __STATIC_CALL_ADDRESSABLE(name)
> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index d5a61d565ad5..d48b91579475 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -392,7 +392,7 @@ void irqentry_exit_cond_resched(void)
>  	}
>  }
>  #ifdef CONFIG_PREEMPT_DYNAMIC
> -DEFINE_STATIC_CALL(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
> +DEFINE_STATIC_CALL_ENABLED(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
>  #endif
>  
>  noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 27c795fbcaaf..389fcc412e6b 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6447,7 +6447,7 @@ NOKPROBE_SYMBOL(preempt_schedule);
>  EXPORT_SYMBOL(preempt_schedule);
>  
>  #ifdef CONFIG_PREEMPT_DYNAMIC
> -DEFINE_STATIC_CALL(preempt_schedule, __preempt_schedule_func);
> +DEFINE_STATIC_CALL_ENABLED(preempt_schedule, __preempt_schedule_func);
>  EXPORT_STATIC_CALL_TRAMP(preempt_schedule);
>  #endif
>  
> @@ -6505,7 +6505,7 @@ asmlinkage __visible void __sched notrace preempt_schedule_notrace(void)
>  EXPORT_SYMBOL_GPL(preempt_schedule_notrace);
>  
>  #ifdef CONFIG_PREEMPT_DYNAMIC
> -DEFINE_STATIC_CALL(preempt_schedule_notrace, __preempt_schedule_notrace_func);
> +DEFINE_STATIC_CALL_ENABLED(preempt_schedule_notrace, __preempt_schedule_notrace_func);
>  EXPORT_STATIC_CALL_TRAMP(preempt_schedule_notrace);
>  #endif
>  
> @@ -8016,10 +8016,9 @@ EXPORT_SYMBOL(__cond_resched);
>  #endif
>  
>  #ifdef CONFIG_PREEMPT_DYNAMIC
> -DEFINE_STATIC_CALL_RET0(cond_resched, __cond_resched);
> +DEFINE_STATIC_CALL_DISABLED_RET0(cond_resched, __cond_resched);
>  EXPORT_STATIC_CALL_TRAMP(cond_resched);
> -
> -DEFINE_STATIC_CALL_RET0(might_resched, __cond_resched);
> +DEFINE_STATIC_CALL_DISABLED_RET0(might_resched, __cond_resched);
>  EXPORT_STATIC_CALL_TRAMP(might_resched);
>  #endif
>  
> @@ -8154,37 +8153,37 @@ void sched_dynamic_update(int mode)
>  	 * Avoid {NONE,VOLUNTARY} -> FULL transitions from ever ending up in
>  	 * the ZERO state, which is invalid.
>  	 */
> -	static_call_update(cond_resched, __cond_resched);
> -	static_call_update(might_resched, __cond_resched);
> -	static_call_update(preempt_schedule, __preempt_schedule_func);
> -	static_call_update(preempt_schedule_notrace, __preempt_schedule_notrace_func);
> -	static_call_update(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
> +	static_call_enable(cond_resched);
> +	static_call_enable(might_resched);
> +	static_call_enable(preempt_schedule);
> +	static_call_enable(preempt_schedule_notrace);
> +	static_call_enable(irqentry_exit_cond_resched);
>  
>  	switch (mode) {
>  	case preempt_dynamic_none:
> -		static_call_update(cond_resched, __cond_resched);
> -		static_call_update(might_resched, (void *)&__static_call_return0);
> -		static_call_update(preempt_schedule, NULL);
> -		static_call_update(preempt_schedule_notrace, NULL);
> -		static_call_update(irqentry_exit_cond_resched, NULL);
> +		static_call_enable(cond_resched);
> +		static_call_disable(might_resched);
> +		static_call_disable(preempt_schedule);
> +		static_call_disable(preempt_schedule_notrace);
> +		static_call_disable(irqentry_exit_cond_resched);
>  		pr_info("Dynamic Preempt: none\n");
>  		break;
>  
>  	case preempt_dynamic_voluntary:
> -		static_call_update(cond_resched, __cond_resched);
> -		static_call_update(might_resched, __cond_resched);
> -		static_call_update(preempt_schedule, NULL);
> -		static_call_update(preempt_schedule_notrace, NULL);
> -		static_call_update(irqentry_exit_cond_resched, NULL);
> +		static_call_enable(cond_resched);
> +		static_call_enable(might_resched);
> +		static_call_disable(preempt_schedule);
> +		static_call_disable(preempt_schedule_notrace);
> +		static_call_disable(irqentry_exit_cond_resched);
>  		pr_info("Dynamic Preempt: voluntary\n");
>  		break;
>  
>  	case preempt_dynamic_full:
> -		static_call_update(cond_resched, (void *)&__static_call_return0);
> -		static_call_update(might_resched, (void *)&__static_call_return0);
> -		static_call_update(preempt_schedule, __preempt_schedule_func);
> -		static_call_update(preempt_schedule_notrace, __preempt_schedule_notrace_func);
> -		static_call_update(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
> +		static_call_disable(cond_resched);
> +		static_call_disable(might_resched);
> +		static_call_enable(preempt_schedule);
> +		static_call_enable(preempt_schedule_notrace);
> +		static_call_enable(irqentry_exit_cond_resched);
>  		pr_info("Dynamic Preempt: full\n");
>  		break;
>  	}
