Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE78470392
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 16:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242687AbhLJPRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 10:17:24 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37980 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235322AbhLJPRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 10:17:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D628FB8286F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 15:13:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA8CC341C5;
        Fri, 10 Dec 2021 15:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639149226;
        bh=3O+yGmKb5TcBHq+JfXPEbxaO41OuisjptqHsv2owU8Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=klK5/hXkpmul9mrKQhn5oiPv5IUFlsppgUdPw60MzZdn3x+XJHrkN/Z5BoXzH8V6i
         jt244aoRUjxFjbLAn3lTs4AlnawVUlLEP8ed/+GzDN/5V7dEMB4zVzTyQf+3pkIJlr
         3j0121kXg8bTbAR7iv4W8FIlv67seWMFwVygg1YV/156dQrFN/ccAKfTLAiu1ISWMF
         zd0zaz37zcpTvQFkTsYRIh0nPURLzSHwILsuthcrnPv7yQ4tR8QrhEVrr/12EkD6KK
         FcUCdZ8uXuppDisimA4ShBYpkwkN32b4pbe2PRD8DCwP74JKP+GjJAaN0Ab4Q1pjMp
         X9xlMYNVIt5yg==
Date:   Fri, 10 Dec 2021 16:13:43 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, ardb@kernel.org,
        catalin.marinas@arm.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH 2/6] sched/preempt: refactor sched_dynamic_update()
Message-ID: <20211210151343.GA755274@lothringen>
References: <20211109172408.49641-1-mark.rutland@arm.com>
 <20211109172408.49641-3-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109172408.49641-3-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2021 at 05:24:04PM +0000, Mark Rutland wrote:
> Currently sched_dynamic_update needs to open-code the enabled/disabled
> function names for each preemption model it supoprts, when in practice
> this is a boolean enabled/disabled state for each function.
> 
> Make this clearer and avoid repetition by defining the enabled/disabled
> states at the function definition, and using helper macros to peform the
> static_call_update(). Where x86 currently overrides the enabled
> function, it is made to provide both the enabled and disabled states for
> consistency, with defaults provided by the core code otherwise.
> 
> In subsequent patches this will allow us to support PREEMPT_DYNAMIC
> without static calls.
> 
> There shoud be no functional change as a result of this patch.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> ---
>  arch/x86/include/asm/preempt.h | 10 ++++---
>  include/linux/entry-common.h   |  2 ++
>  kernel/sched/core.c            | 59 ++++++++++++++++++++++++++----------------
>  3 files changed, 45 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
> index fe5efbcba824..5f6daea1ee24 100644
> --- a/arch/x86/include/asm/preempt.h
> +++ b/arch/x86/include/asm/preempt.h
> @@ -108,16 +108,18 @@ static __always_inline bool should_resched(int preempt_offset)
>  extern asmlinkage void preempt_schedule(void);
>  extern asmlinkage void preempt_schedule_thunk(void);
>  
> -#define __preempt_schedule_func preempt_schedule_thunk
> +#define preempt_schedule_dynamic_enabled	preempt_schedule_thunk
> +#define preempt_schedule_dynamic_disabled	NULL
>  
>  extern asmlinkage void preempt_schedule_notrace(void);
>  extern asmlinkage void preempt_schedule_notrace_thunk(void);
>  
> -#define __preempt_schedule_notrace_func preempt_schedule_notrace_thunk
> +#define preempt_schedule_notrace_dynamic_enabled	preempt_schedule_notrace_thunk
> +#define preempt_schedule_notrace_dynamic_disabled	NULL

I'm worried about un-greppable macro definitions like this. Also this
enable/disable switch look like a common pattern on static call so how
about moving that logic to static call itself? As in below (only build-tested):

diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index fe5efbcba824..64320c0a00a6 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -117,7 +117,7 @@ extern asmlinkage void preempt_schedule_notrace_thunk(void);
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 
-DECLARE_STATIC_CALL(preempt_schedule, __preempt_schedule_func);
+DECLARE_STATIC_CALL_TOGGLE(preempt_schedule, __preempt_schedule_func);
 
 #define __preempt_schedule() \
 do { \
@@ -125,7 +125,7 @@ do { \
 	asm volatile ("call " STATIC_CALL_TRAMP_STR(preempt_schedule) : ASM_CALL_CONSTRAINT); \
 } while (0)
 
-DECLARE_STATIC_CALL(preempt_schedule_notrace, __preempt_schedule_notrace_func);
+DECLARE_STATIC_CALL_TOGGLE(preempt_schedule_notrace, __preempt_schedule_notrace_func);
 
 #define __preempt_schedule_notrace() \
 do { \
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 2e2b8d6140ed..a3d99ffc32ca 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -456,7 +456,7 @@ irqentry_state_t noinstr irqentry_enter(struct pt_regs *regs);
  */
 void irqentry_exit_cond_resched(void);
 #ifdef CONFIG_PREEMPT_DYNAMIC
-DECLARE_STATIC_CALL(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
+DECLARE_STATIC_CALL_TOGGLE(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
 #endif
 
 /**
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 77755ac3e189..f4f5f4f3b496 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -94,7 +94,7 @@ extern int __cond_resched(void);
 
 extern int __cond_resched(void);
 
-DECLARE_STATIC_CALL(might_resched, __cond_resched);
+DECLARE_STATIC_CALL_TOGGLE(might_resched, __cond_resched);
 
 static __always_inline void might_resched(void)
 {
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 78c351e35fec..01a9e8590ea0 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2010,7 +2010,7 @@ extern int __cond_resched(void);
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 
-DECLARE_STATIC_CALL(cond_resched, __cond_resched);
+DECLARE_STATIC_CALL_TOGGLE(cond_resched, __cond_resched);
 
 static __always_inline int _cond_resched(void)
 {
diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 3e56a9751c06..351ac27fa9d1 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -156,6 +156,19 @@ extern void arch_static_call_transform(void *site, void *tramp, void *func, bool
 			     STATIC_CALL_TRAMP_ADDR(name), __F);	\
 })
 
+#define static_call_toggle(name, enable)				\
+({									\
+	struct static_call_toggle *__G = &STATIC_CALL_TOGGLE(name);	\
+	if (enable)							\
+		static_call_update(name, __G->func_enabled);		\
+	else								\
+		static_call_update(name, __G->func_disabled);		\
+})
+
+#define static_call_enable(name) static_call_toggle(name, 1);
+#define static_call_disable(name) static_call_toggle(name, 0);
+
+
 #define static_call_query(name) (READ_ONCE(STATIC_CALL_KEY(name).func))
 
 #ifdef CONFIG_HAVE_STATIC_CALL_INLINE
@@ -333,4 +346,27 @@ static inline int static_call_text_reserved(void *start, void *end)
 #define DEFINE_STATIC_CALL_RET0(name, _func)				\
 	__DEFINE_STATIC_CALL(name, _func, __static_call_return0)
 
+#define __DEFINE_STATIC_CALL_TOGGLE(name, _func_enabled, _func_disabled) \
+	struct static_call_toggle STATIC_CALL_TOGGLE(name) = {			\
+		.key = &STATIC_CALL_KEY(name),					\
+		.func_enabled = _func_enabled,					\
+		.func_disabled = _func_disabled,				\
+	}
+
+#define DEFINE_STATIC_CALL_ENABLED(name, _func)					\
+	DEFINE_STATIC_CALL(name, _func);					\
+	__DEFINE_STATIC_CALL_TOGGLE(name, _func, NULL)
+
+#define DEFINE_STATIC_CALL_DISABLED(name, _func)				\
+	DEFINE_STATIC_CALL_NULL(name, _func);					\
+	__DEFINE_STATIC_CALL_TOGGLE(name, _func, NULL)
+
+#define DEFINE_STATIC_CALL_ENABLED_RET0(name, _func)				\
+	DEFINE_STATIC_CALL(name, _func);					\
+	__DEFINE_STATIC_CALL_TOGGLE(name, _func, __static_call_return0)
+
+#define DEFINE_STATIC_CALL_DISABLED_RET0(name, _func)				\
+	DEFINE_STATIC_CALL_RET0(name, _func);					\
+	__DEFINE_STATIC_CALL_TOGGLE(name, _func, __static_call_return0)
+
 #endif /* _LINUX_STATIC_CALL_H */
diff --git a/include/linux/static_call_types.h b/include/linux/static_call_types.h
index 5a00b8b2cf9f..e150f29aee2d 100644
--- a/include/linux/static_call_types.h
+++ b/include/linux/static_call_types.h
@@ -18,6 +18,9 @@
 #define STATIC_CALL_TRAMP(name)		__PASTE(STATIC_CALL_TRAMP_PREFIX, name)
 #define STATIC_CALL_TRAMP_STR(name)	__stringify(STATIC_CALL_TRAMP(name))
 
+#define STATIC_CALL_TOGGLE_PREFIX	__SCG_
+#define STATIC_CALL_TOGGLE(name)	__PASTE(STATIC_CALL_TOGGLE_PREFIX, name)
+
 /*
  * Flags in the low bits of static_call_site::key.
  */
@@ -38,6 +41,10 @@ struct static_call_site {
 	extern struct static_call_key STATIC_CALL_KEY(name);		\
 	extern typeof(func) STATIC_CALL_TRAMP(name);
 
+#define DECLARE_STATIC_CALL_TOGGLE(name, func)				\
+	DECLARE_STATIC_CALL(name, func);				\
+	extern struct static_call_toggle STATIC_CALL_TOGGLE(name);
+
 #ifdef CONFIG_HAVE_STATIC_CALL
 
 #define __raw_static_call(name)	(&STATIC_CALL_TRAMP(name))
@@ -68,6 +75,13 @@ struct static_call_key {
 	};
 };
 
+struct static_call_toggle {
+	struct static_call_key *key;
+	void *func_enabled;
+	void *func_disabled;
+};
+
+
 #else /* !CONFIG_HAVE_STATIC_CALL_INLINE */
 
 #define __STATIC_CALL_ADDRESSABLE(name)
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index d5a61d565ad5..d48b91579475 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -392,7 +392,7 @@ void irqentry_exit_cond_resched(void)
 	}
 }
 #ifdef CONFIG_PREEMPT_DYNAMIC
-DEFINE_STATIC_CALL(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
+DEFINE_STATIC_CALL_ENABLED(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
 #endif
 
 noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 27c795fbcaaf..389fcc412e6b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6447,7 +6447,7 @@ NOKPROBE_SYMBOL(preempt_schedule);
 EXPORT_SYMBOL(preempt_schedule);
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
-DEFINE_STATIC_CALL(preempt_schedule, __preempt_schedule_func);
+DEFINE_STATIC_CALL_ENABLED(preempt_schedule, __preempt_schedule_func);
 EXPORT_STATIC_CALL_TRAMP(preempt_schedule);
 #endif
 
@@ -6505,7 +6505,7 @@ asmlinkage __visible void __sched notrace preempt_schedule_notrace(void)
 EXPORT_SYMBOL_GPL(preempt_schedule_notrace);
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
-DEFINE_STATIC_CALL(preempt_schedule_notrace, __preempt_schedule_notrace_func);
+DEFINE_STATIC_CALL_ENABLED(preempt_schedule_notrace, __preempt_schedule_notrace_func);
 EXPORT_STATIC_CALL_TRAMP(preempt_schedule_notrace);
 #endif
 
@@ -8016,10 +8016,9 @@ EXPORT_SYMBOL(__cond_resched);
 #endif
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
-DEFINE_STATIC_CALL_RET0(cond_resched, __cond_resched);
+DEFINE_STATIC_CALL_DISABLED_RET0(cond_resched, __cond_resched);
 EXPORT_STATIC_CALL_TRAMP(cond_resched);
-
-DEFINE_STATIC_CALL_RET0(might_resched, __cond_resched);
+DEFINE_STATIC_CALL_DISABLED_RET0(might_resched, __cond_resched);
 EXPORT_STATIC_CALL_TRAMP(might_resched);
 #endif
 
@@ -8154,37 +8153,37 @@ void sched_dynamic_update(int mode)
 	 * Avoid {NONE,VOLUNTARY} -> FULL transitions from ever ending up in
 	 * the ZERO state, which is invalid.
 	 */
-	static_call_update(cond_resched, __cond_resched);
-	static_call_update(might_resched, __cond_resched);
-	static_call_update(preempt_schedule, __preempt_schedule_func);
-	static_call_update(preempt_schedule_notrace, __preempt_schedule_notrace_func);
-	static_call_update(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
+	static_call_enable(cond_resched);
+	static_call_enable(might_resched);
+	static_call_enable(preempt_schedule);
+	static_call_enable(preempt_schedule_notrace);
+	static_call_enable(irqentry_exit_cond_resched);
 
 	switch (mode) {
 	case preempt_dynamic_none:
-		static_call_update(cond_resched, __cond_resched);
-		static_call_update(might_resched, (void *)&__static_call_return0);
-		static_call_update(preempt_schedule, NULL);
-		static_call_update(preempt_schedule_notrace, NULL);
-		static_call_update(irqentry_exit_cond_resched, NULL);
+		static_call_enable(cond_resched);
+		static_call_disable(might_resched);
+		static_call_disable(preempt_schedule);
+		static_call_disable(preempt_schedule_notrace);
+		static_call_disable(irqentry_exit_cond_resched);
 		pr_info("Dynamic Preempt: none\n");
 		break;
 
 	case preempt_dynamic_voluntary:
-		static_call_update(cond_resched, __cond_resched);
-		static_call_update(might_resched, __cond_resched);
-		static_call_update(preempt_schedule, NULL);
-		static_call_update(preempt_schedule_notrace, NULL);
-		static_call_update(irqentry_exit_cond_resched, NULL);
+		static_call_enable(cond_resched);
+		static_call_enable(might_resched);
+		static_call_disable(preempt_schedule);
+		static_call_disable(preempt_schedule_notrace);
+		static_call_disable(irqentry_exit_cond_resched);
 		pr_info("Dynamic Preempt: voluntary\n");
 		break;
 
 	case preempt_dynamic_full:
-		static_call_update(cond_resched, (void *)&__static_call_return0);
-		static_call_update(might_resched, (void *)&__static_call_return0);
-		static_call_update(preempt_schedule, __preempt_schedule_func);
-		static_call_update(preempt_schedule_notrace, __preempt_schedule_notrace_func);
-		static_call_update(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
+		static_call_disable(cond_resched);
+		static_call_disable(might_resched);
+		static_call_enable(preempt_schedule);
+		static_call_enable(preempt_schedule_notrace);
+		static_call_enable(irqentry_exit_cond_resched);
 		pr_info("Dynamic Preempt: full\n");
 		break;
 	}
