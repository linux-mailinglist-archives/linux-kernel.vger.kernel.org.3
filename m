Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991C64A9B9B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 16:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359576AbiBDPG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 10:06:26 -0500
Received: from foss.arm.com ([217.140.110.172]:50288 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1359535AbiBDPGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 10:06:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A12C1477;
        Fri,  4 Feb 2022 07:06:23 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 52D0F3F774;
        Fri,  4 Feb 2022 07:06:21 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     ardb@kernel.org, bp@alien8.de, catalin.marinas@arm.com,
        dave.hansen@linux.intel.com, frederic@kernel.org,
        james.morse@arm.com, joey.gouly@arm.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, luto@kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, peterz@infradead.org,
        tglx@linutronix.de, valentin.schneider@arm.com, will@kernel.org
Subject: [PATCH v2 5/7] sched/preempt: add PREEMPT_DYNAMIC using static keys
Date:   Fri,  4 Feb 2022 15:05:55 +0000
Message-Id: <20220204150557.434610-6-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220204150557.434610-1-mark.rutland@arm.com>
References: <20220204150557.434610-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Where an architecture selects HAVE_STATIC_CALL but not
HAVE_STATIC_CALL_INLINE, each static call has an out-of-line trampoline
which will either branch to a callee or return to the caller.

On such architectures, a number of constraints can conspire to make
those trampolines more complicated and potentially less useful than we'd
like. For example:

* Hardware and software control flow integrity schemes can require the
  addition of "landing pad" instructions (e.g. `BTI` for arm64), which
  will also be present at the "real" callee.

* Limited branch ranges can require that trampolines generate or load an
  address into a register and perform an indirect branch (or at least
  have a slow path that does so). This loses some of the benefits of
  having a direct branch.

* Interaction with SW CFI schemes can be complicated and fragile, e.g.
  requiring that we can recognise idiomatic codegen and remove
  indirections understand, at least until clang proves more helpful
  mechanisms for dealing with this.

For PREEMPT_DYNAMIC, we don't need the full power of static calls, as we
really only need to enable/disable specific preemption functions. We can
achieve the same effect without a number of the pain points above by
using static keys to fold early returns into the preemption functions
themselves rather than in an out-of-line trampoline, effectively
inlining the trampoline into the start of the function.

For arm64, this results in good code generation, e.g. the
dynamic_cond_resched() wrapper looks as follows (with the first `B` being
replaced with a `NOP` when the function is disabled):

| <dynamic_cond_resched>:
|        bti     c
|        b       <dynamic_cond_resched+0x10>
|        mov     w0, #0x0                        // #0
|        ret
|        mrs     x0, sp_el0
|        ldr     x0, [x0, #8]
|        cbnz    x0, <dynamic_cond_resched+0x8>
|        paciasp
|        stp     x29, x30, [sp, #-16]!
|        mov     x29, sp
|        bl      <preempt_schedule_common>
|        mov     w0, #0x1                        // #1
|        ldp     x29, x30, [sp], #16
|        autiasp
|        ret

... compared to the regular form of the function:

| <__cond_resched>:
|        bti     c
|        mrs     x0, sp_el0
|        ldr     x1, [x0, #8]
|        cbz     x1, <__cond_resched+0x18>
|        mov     w0, #0x0                        // #0
|        ret
|        paciasp
|        stp     x29, x30, [sp, #-16]!
|        mov     x29, sp
|        bl      <preempt_schedule_common>
|        mov     w0, #0x1                        // #1
|        ldp     x29, x30, [sp], #16
|        autiasp
|        ret

Any architecture which implements static keys should be able to use this
to implement PREEMPT_DYNAMIC with similar cost to non-inlined static
calls.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>
---
 arch/Kconfig                 | 36 ++++++++++++++++++++++--
 arch/x86/Kconfig             |  2 +-
 include/linux/entry-common.h | 10 +++++--
 include/linux/kernel.h       |  7 ++++-
 include/linux/sched.h        | 10 ++++++-
 kernel/entry/common.c        | 10 +++++++
 kernel/sched/core.c          | 53 ++++++++++++++++++++++++++++++++++--
 7 files changed, 118 insertions(+), 10 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 601691f1570f..7587ed30b9dc 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1278,11 +1278,41 @@ config HAVE_STATIC_CALL_INLINE
 
 config HAVE_PREEMPT_DYNAMIC
 	bool
+
+config HAVE_PREEMPT_DYNAMIC_CALL
+	bool
 	depends on HAVE_STATIC_CALL
+	select HAVE_PREEMPT_DYNAMIC
 	help
-	   Select this if the architecture support boot time preempt setting
-	   on top of static calls. It is strongly advised to support inline
-	   static call to avoid any overhead.
+	   An architecture should select this if it can handle the preemption
+	   model being selected at boot time using static calls.
+
+	   Where an architecture selects HAVE_STATIC_CALL_INLINE, any call to a
+	   preemption function will be patched directly.
+
+	   Where an architecture does not select HAVE_STATIC_CALL_INLINE, any
+	   call to a preemption function will go through a trampoline, and the
+	   trampoline will be patched.
+
+	   It is strongly advised to support inline static call to avoid any
+	   overhead.
+
+config HAVE_PREEMPT_DYNAMIC_KEY
+	bool
+	depends on JUMP_LABEL
+	select HAVE_PREEMPT_DYNAMIC
+	help
+	   An architecture should select this if it can handle the preemption
+	   model being selected at boot time using static keys.
+
+	   Each preemption function will be given an early return based on a
+	   static key. This should have slightly lower overhead than non-inline
+	   static calls, as this effectively inlines each trampoline into the
+	   start of its callee. This may avoid redundant work, and may
+	   integrate better with CFI schemes.
+
+	   This will have greater overhead than using inline static calls as
+	   the call to the preemption function cannot be entirely elided.
 
 config ARCH_WANT_LD_ORPHAN_WARN
 	bool
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9f5bd41bf660..70f94094fd6f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -246,7 +246,7 @@ config X86
 	select HAVE_STACK_VALIDATION		if X86_64
 	select HAVE_STATIC_CALL
 	select HAVE_STATIC_CALL_INLINE		if HAVE_STACK_VALIDATION
-	select HAVE_PREEMPT_DYNAMIC
+	select HAVE_PREEMPT_DYNAMIC_CALL
 	select HAVE_RSEQ
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UNSTABLE_SCHED_CLOCK
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index dfd84c59b144..141952f4fee8 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -456,13 +456,19 @@ irqentry_state_t noinstr irqentry_enter(struct pt_regs *regs);
  */
 void raw_irqentry_exit_cond_resched(void);
 #ifdef CONFIG_PREEMPT_DYNAMIC
+#if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
 #define irqentry_exit_cond_resched_dynamic_enabled	raw_irqentry_exit_cond_resched
 #define irqentry_exit_cond_resched_dynamic_disabled	NULL
 DECLARE_STATIC_CALL(irqentry_exit_cond_resched, raw_irqentry_exit_cond_resched);
 #define irqentry_exit_cond_resched()	static_call(irqentry_exit_cond_resched)()
-#else
-#define irqentry_exit_cond_resched()	raw_irqentry_exit_cond_resched()
+#elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
+DECLARE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
+void dynamic_irqentry_exit_cond_resched(void);
+#define irqentry_exit_cond_resched()	dynamic_irqentry_exit_cond_resched()
 #endif
+#else /* CONFIG_PREEMPT_DYNAMIC */
+#define irqentry_exit_cond_resched()	raw_irqentry_exit_cond_resched()
+#endif /* CONFIG_PREEMPT_DYNAMIC */
 
 /**
  * irqentry_exit - Handle return from exception that used irqentry_enter()
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 33f47a996513..a890428bcc1a 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -99,7 +99,7 @@ struct user;
 extern int __cond_resched(void);
 # define might_resched() __cond_resched()
 
-#elif defined(CONFIG_PREEMPT_DYNAMIC)
+#elif defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
 
 extern int __cond_resched(void);
 
@@ -110,6 +110,11 @@ static __always_inline void might_resched(void)
 	static_call_mod(might_resched)();
 }
 
+#elif defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
+
+extern int dynamic_might_resched(void);
+# define might_resched() dynamic_might_resched()
+
 #else
 
 # define might_resched() do { } while (0)
diff --git a/include/linux/sched.h b/include/linux/sched.h
index f5b2be39a78c..8b320fb54290 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2016,7 +2016,7 @@ static inline int test_tsk_need_resched(struct task_struct *tsk)
 #if !defined(CONFIG_PREEMPTION) || defined(CONFIG_PREEMPT_DYNAMIC)
 extern int __cond_resched(void);
 
-#ifdef CONFIG_PREEMPT_DYNAMIC
+#if defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
 
 DECLARE_STATIC_CALL(cond_resched, __cond_resched);
 
@@ -2025,6 +2025,14 @@ static __always_inline int _cond_resched(void)
 	return static_call_mod(cond_resched)();
 }
 
+#elif defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
+extern int dynamic_cond_resched(void);
+
+static __always_inline int _cond_resched(void)
+{
+	return dynamic_cond_resched();
+}
+
 #else
 
 static inline int _cond_resched(void)
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 1739ca79613b..90e4b7ba4bf6 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -392,7 +392,17 @@ void raw_irqentry_exit_cond_resched(void)
 	}
 }
 #ifdef CONFIG_PREEMPT_DYNAMIC
+#if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
 DEFINE_STATIC_CALL(irqentry_exit_cond_resched, raw_irqentry_exit_cond_resched);
+#elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
+DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
+void dynamic_irqentry_exit_cond_resched(void)
+{
+	if (!static_key_unlikely(&sk_dynamic_irqentry_exit_cond_resched))
+		return;
+	raw_irqentry_exit_cond_resched();
+}
+#endif
 #endif
 
 noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3bf7f90d0ef7..4cb72e62b67b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6482,21 +6482,31 @@ asmlinkage __visible void __sched notrace preempt_schedule(void)
 	 */
 	if (likely(!preemptible()))
 		return;
-
 	preempt_schedule_common();
 }
 NOKPROBE_SYMBOL(preempt_schedule);
 EXPORT_SYMBOL(preempt_schedule);
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
+#if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
 #ifndef preempt_schedule_dynamic_enabled
 #define preempt_schedule_dynamic_enabled	preempt_schedule
 #define preempt_schedule_dynamic_disabled	NULL
 #endif
 DEFINE_STATIC_CALL(preempt_schedule, preempt_schedule_dynamic_enabled);
 EXPORT_STATIC_CALL_TRAMP(preempt_schedule);
+#elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
+static DEFINE_STATIC_KEY_TRUE(sk_dynamic_preempt_schedule);
+void __sched notrace dynamic_preempt_schedule(void)
+{
+	if (!static_branch_unlikely(&sk_dynamic_preempt_schedule))
+		return;
+	preempt_schedule();
+}
+NOKPROBE_SYMBOL(dynamic_preempt_schedule);
+EXPORT_SYMBOL(dynamic_preempt_schedule);
+#endif
 #endif
-
 
 /**
  * preempt_schedule_notrace - preempt_schedule called by tracing
@@ -6551,12 +6561,24 @@ asmlinkage __visible void __sched notrace preempt_schedule_notrace(void)
 EXPORT_SYMBOL_GPL(preempt_schedule_notrace);
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
+#if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
 #ifndef preempt_schedule_notrace_dynamic_enabled
 #define preempt_schedule_notrace_dynamic_enabled	preempt_schedule_notrace
 #define preempt_schedule_notrace_dynamic_disabled	NULL
 #endif
 DEFINE_STATIC_CALL(preempt_schedule_notrace, preempt_schedule_notrace_dynamic_enabled);
 EXPORT_STATIC_CALL_TRAMP(preempt_schedule_notrace);
+#elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
+static DEFINE_STATIC_KEY_TRUE(sk_dynamic_preempt_schedule_notrace);
+void __sched notrace dynamic_preempt_schedule_notrace(void)
+{
+	if (!static_branch_unlikely(&sk_dynamic_preempt_schedule_notrace))
+		return;
+	preempt_schedule_notrace();
+}
+NOKPROBE_SYMBOL(dynamic_preempt_schedule_notrace);
+EXPORT_SYMBOL(dynamic_preempt_schedule_notrace);
+#endif
 #endif
 
 #endif /* CONFIG_PREEMPTION */
@@ -8066,6 +8088,7 @@ EXPORT_SYMBOL(__cond_resched);
 #endif
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
+#if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
 #define cond_resched_dynamic_enabled	__cond_resched
 #define cond_resched_dynamic_disabled	((void *)&__static_call_return0)
 DEFINE_STATIC_CALL_RET0(cond_resched, __cond_resched);
@@ -8075,6 +8098,25 @@ EXPORT_STATIC_CALL_TRAMP(cond_resched);
 #define might_resched_dynamic_disabled	((void *)&__static_call_return0)
 DEFINE_STATIC_CALL_RET0(might_resched, __cond_resched);
 EXPORT_STATIC_CALL_TRAMP(might_resched);
+#elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
+static DEFINE_STATIC_KEY_TRUE(sk_dynamic_cond_resched);
+int __sched dynamic_cond_resched(void)
+{
+	if (!static_branch_unlikely(&sk_dynamic_cond_resched))
+		return 0;
+	return __cond_resched();
+}
+EXPORT_SYMBOL(dynamic_cond_resched);
+
+static DEFINE_STATIC_KEY_TRUE(sk_dynamic_might_resched);
+int __sched dynamic_might_resched(void)
+{
+	if (!static_branch_unlikely(&sk_dynamic_might_resched))
+		return 0;
+	return __cond_resched();
+}
+EXPORT_SYMBOL(dynamic_might_resched);
+#endif
 #endif
 
 /*
@@ -8198,8 +8240,15 @@ int sched_dynamic_mode(const char *str)
 	return -EINVAL;
 }
 
+#if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
 #define preempt_dynamic_enable(f)	static_call_update(f, f##_dynamic_enabled)
 #define preempt_dynamic_disable(f)	static_call_update(f, f##_dynamic_disabled)
+#elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
+#define preempt_dynamic_enable(f)	static_key_enable(&sk_dynamic_##f.key)
+#define preempt_dynamic_disable(f)	static_key_disable(&sk_dynamic_##f.key)
+#else
+#error "Unsupported PREEMPT_DYNAMIC mechanism"
+#endif
 
 void sched_dynamic_update(int mode)
 {
-- 
2.30.2

