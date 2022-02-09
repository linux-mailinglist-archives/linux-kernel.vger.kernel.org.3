Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6AF4AF577
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 16:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbiBIPgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 10:36:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236049AbiBIPgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 10:36:05 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF21FC05CB97
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 07:36:06 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE34C12FC;
        Wed,  9 Feb 2022 07:36:06 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 93CA43F73B;
        Wed,  9 Feb 2022 07:36:04 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     ardb@kernel.org, bp@alien8.de, catalin.marinas@arm.com,
        dave.hansen@linux.intel.com, frederic@kernel.org,
        james.morse@arm.com, joey.gouly@arm.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, luto@kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, peterz@infradead.org,
        tglx@linutronix.de, valentin.schneider@arm.com, will@kernel.org
Subject: [PATCH v3 7/7] arm64: support PREEMPT_DYNAMIC
Date:   Wed,  9 Feb 2022 15:35:35 +0000
Message-Id: <20220209153535.818830-8-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220209153535.818830-1-mark.rutland@arm.com>
References: <20220209153535.818830-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables support for PREEMPT_DYNAMIC on arm64, allowing the
preemption model to be chosen at boot time.

Specifically, this patch selects HAVE_PREEMPT_DYNAMIC_KEY, so that each
preemption function is an out-of-line call with an early return
depending upon a static key. This leaves almost all the codegen up to
the compiler, and side-steps a number of pain points with static calls
(e.g. interaction with CFI schemes). This should have no worse overhead
than using non-inline static calls, as those use out-of-line trampolines
with early returns.

For example, the dynamic_cond_resched() wrapper looks as follows when
enabled. When disabled, the first `B` is replaced with a `NOP`,
resulting in an early return.

| <dynamic_cond_resched>:
|        bti     c
|        b       <dynamic_cond_resched+0x10>     // or `nop`
|        mov     w0, #0x0
|        ret
|        mrs     x0, sp_el0
|        ldr     x0, [x0, #8]
|        cbnz    x0, <dynamic_cond_resched+0x8>
|        paciasp
|        stp     x29, x30, [sp, #-16]!
|        mov     x29, sp
|        bl      <preempt_schedule_common>
|        mov     w0, #0x1
|        ldp     x29, x30, [sp], #16
|        autiasp
|        ret

... compared to the regular form of the function:

| <__cond_resched>:
|        bti     c
|        mrs     x0, sp_el0
|        ldr     x1, [x0, #8]
|        cbz     x1, <__cond_resched+0x18>
|        mov     w0, #0x0
|        ret
|        paciasp
|        stp     x29, x30, [sp, #-16]!
|        mov     x29, sp
|        bl      <preempt_schedule_common>
|        mov     w0, #0x1
|        ldp     x29, x30, [sp], #16
|        autiasp
|        ret

Since arm64 does not yet use the generic entry code, we must define our
own `sk_dynamic_irqentry_exit_cond_resched`, which will be
enabled/disabled by the common code in kernel/sched/core.c. All other
preemption functions and associated static keys are defined there.

Note that PREEMPT_DYNAMIC is `def bool y`, so this will default to
enabled.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/Kconfig               |  1 +
 arch/arm64/include/asm/preempt.h | 19 +++++++++++++++++--
 arch/arm64/kernel/entry-common.c | 10 +++++++++-
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index f2b5a4abef21..3831d922a81d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -192,6 +192,7 @@ config ARM64
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
+	select HAVE_PREEMPT_DYNAMIC_KEY
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
 	select HAVE_FUNCTION_ARG_ACCESS_API
diff --git a/arch/arm64/include/asm/preempt.h b/arch/arm64/include/asm/preempt.h
index e83f0982b99c..0159b625cc7f 100644
--- a/arch/arm64/include/asm/preempt.h
+++ b/arch/arm64/include/asm/preempt.h
@@ -2,6 +2,7 @@
 #ifndef __ASM_PREEMPT_H
 #define __ASM_PREEMPT_H
 
+#include <linux/jump_label.h>
 #include <linux/thread_info.h>
 
 #define PREEMPT_NEED_RESCHED	BIT(32)
@@ -80,10 +81,24 @@ static inline bool should_resched(int preempt_offset)
 }
 
 #ifdef CONFIG_PREEMPTION
+
 void preempt_schedule(void);
-#define __preempt_schedule() preempt_schedule()
 void preempt_schedule_notrace(void);
-#define __preempt_schedule_notrace() preempt_schedule_notrace()
+
+#ifdef CONFIG_PREEMPT_DYNAMIC
+
+DECLARE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
+void dynamic_preempt_schedule(void);
+#define __preempt_schedule()		dynamic_preempt_schedule()
+void dynamic_preempt_schedule_notrace(void);
+#define __preempt_schedule_notrace()	dynamic_preempt_schedule_notrace()
+
+#else /* CONFIG_PREEMPT_DYNAMIC */
+
+#define __preempt_schedule()		preempt_schedule()
+#define __preempt_schedule_notrace()	preempt_schedule_notrace()
+
+#endif /* CONFIG_PREEMPT_DYNAMIC */
 #endif /* CONFIG_PREEMPTION */
 
 #endif /* __ASM_PREEMPT_H */
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 2c639b6b676d..675352ec1368 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -220,9 +220,17 @@ static void noinstr arm64_exit_el1_dbg(struct pt_regs *regs)
 		lockdep_hardirqs_on(CALLER_ADDR0);
 }
 
+#ifdef CONFIG_PREEMPT_DYNAMIC
+DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
+#define need_irq_preemption() \
+	(static_branch_unlikely(&sk_dynamic_irqentry_exit_cond_resched))
+#else
+#define need_irq_preemption()	(IS_ENABLED(CONFIG_PREEMPTION))
+#endif
+
 static void __sched arm64_preempt_schedule_irq(void)
 {
-	if (!IS_ENABLED(CONFIG_PREEMPTION))
+	if (!need_irq_preemption())
 		return;
 
 	/*
-- 
2.30.2

