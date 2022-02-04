Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8324A9B98
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 16:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359549AbiBDPGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 10:06:17 -0500
Received: from foss.arm.com ([217.140.110.172]:50218 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1359520AbiBDPGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 10:06:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B52121477;
        Fri,  4 Feb 2022 07:06:14 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7D0083F774;
        Fri,  4 Feb 2022 07:06:12 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     ardb@kernel.org, bp@alien8.de, catalin.marinas@arm.com,
        dave.hansen@linux.intel.com, frederic@kernel.org,
        james.morse@arm.com, joey.gouly@arm.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, luto@kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, peterz@infradead.org,
        tglx@linutronix.de, valentin.schneider@arm.com, will@kernel.org
Subject: [PATCH v2 2/7] sched/preempt: refactor sched_dynamic_update()
Date:   Fri,  4 Feb 2022 15:05:52 +0000
Message-Id: <20220204150557.434610-3-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220204150557.434610-1-mark.rutland@arm.com>
References: <20220204150557.434610-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently sched_dynamic_update needs to open-code the enabled/disabled
function names for each preemption model it supports, when in practice
this is a boolean enabled/disabled state for each function.

Make this clearer and avoid repetition by defining the enabled/disabled
states at the function definition, and using helper macros to perform the
static_call_update(). Where x86 currently overrides the enabled
function, it is made to provide both the enabled and disabled states for
consistency, with defaults provided by the core code otherwise.

In subsequent patches this will allow us to support PREEMPT_DYNAMIC
without static calls.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>
---
 arch/x86/include/asm/preempt.h | 10 +++---
 include/linux/entry-common.h   |  2 ++
 kernel/sched/core.c            | 59 +++++++++++++++++++++-------------
 3 files changed, 45 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index fe5efbcba824..5f6daea1ee24 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -108,16 +108,18 @@ static __always_inline bool should_resched(int preempt_offset)
 extern asmlinkage void preempt_schedule(void);
 extern asmlinkage void preempt_schedule_thunk(void);
 
-#define __preempt_schedule_func preempt_schedule_thunk
+#define preempt_schedule_dynamic_enabled	preempt_schedule_thunk
+#define preempt_schedule_dynamic_disabled	NULL
 
 extern asmlinkage void preempt_schedule_notrace(void);
 extern asmlinkage void preempt_schedule_notrace_thunk(void);
 
-#define __preempt_schedule_notrace_func preempt_schedule_notrace_thunk
+#define preempt_schedule_notrace_dynamic_enabled	preempt_schedule_notrace_thunk
+#define preempt_schedule_notrace_dynamic_disabled	NULL
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 
-DECLARE_STATIC_CALL(preempt_schedule, __preempt_schedule_func);
+DECLARE_STATIC_CALL(preempt_schedule, preempt_schedule_dynamic_enabled);
 
 #define __preempt_schedule() \
 do { \
@@ -125,7 +127,7 @@ do { \
 	asm volatile ("call " STATIC_CALL_TRAMP_STR(preempt_schedule) : ASM_CALL_CONSTRAINT); \
 } while (0)
 
-DECLARE_STATIC_CALL(preempt_schedule_notrace, __preempt_schedule_notrace_func);
+DECLARE_STATIC_CALL(preempt_schedule_notrace, preempt_schedule_notrace_dynamic_enabled);
 
 #define __preempt_schedule_notrace() \
 do { \
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 2e2b8d6140ed..a01ac1a0a292 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -456,6 +456,8 @@ irqentry_state_t noinstr irqentry_enter(struct pt_regs *regs);
  */
 void irqentry_exit_cond_resched(void);
 #ifdef CONFIG_PREEMPT_DYNAMIC
+#define irqentry_exit_cond_resched_dynamic_enabled	irqentry_exit_cond_resched
+#define irqentry_exit_cond_resched_dynamic_disabled	NULL
 DECLARE_STATIC_CALL(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
 #endif
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6e8998267102..414165c430f4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6489,7 +6489,11 @@ NOKPROBE_SYMBOL(preempt_schedule);
 EXPORT_SYMBOL(preempt_schedule);
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
-DEFINE_STATIC_CALL(preempt_schedule, __preempt_schedule_func);
+#ifndef preempt_schedule_dynamic_enabled
+#define preempt_schedule_dynamic_enabled	preempt_schedule
+#define preempt_schedule_dynamic_disabled	NULL
+#endif
+DEFINE_STATIC_CALL(preempt_schedule, preempt_schedule_dynamic_enabled);
 EXPORT_STATIC_CALL_TRAMP(preempt_schedule);
 #endif
 
@@ -6547,7 +6551,11 @@ asmlinkage __visible void __sched notrace preempt_schedule_notrace(void)
 EXPORT_SYMBOL_GPL(preempt_schedule_notrace);
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
-DEFINE_STATIC_CALL(preempt_schedule_notrace, __preempt_schedule_notrace_func);
+#ifndef preempt_schedule_notrace_dynamic_enabled
+#define preempt_schedule_notrace_dynamic_enabled	preempt_schedule_notrace
+#define preempt_schedule_notrace_dynamic_disabled	NULL
+#endif
+DEFINE_STATIC_CALL(preempt_schedule_notrace, preempt_schedule_notrace_dynamic_enabled);
 EXPORT_STATIC_CALL_TRAMP(preempt_schedule_notrace);
 #endif
 
@@ -8058,9 +8066,13 @@ EXPORT_SYMBOL(__cond_resched);
 #endif
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
+#define cond_resched_dynamic_enabled	__cond_resched
+#define cond_resched_dynamic_disabled	((void *)&__static_call_return0)
 DEFINE_STATIC_CALL_RET0(cond_resched, __cond_resched);
 EXPORT_STATIC_CALL_TRAMP(cond_resched);
 
+#define might_resched_dynamic_enabled	__cond_resched
+#define might_resched_dynamic_disabled	((void *)&__static_call_return0)
 DEFINE_STATIC_CALL_RET0(might_resched, __cond_resched);
 EXPORT_STATIC_CALL_TRAMP(might_resched);
 #endif
@@ -8184,43 +8196,46 @@ int sched_dynamic_mode(const char *str)
 	return -EINVAL;
 }
 
+#define preempt_dynamic_enable(f)	static_call_update(f, f##_dynamic_enabled)
+#define preempt_dynamic_disable(f)	static_call_update(f, f##_dynamic_disabled)
+
 void sched_dynamic_update(int mode)
 {
 	/*
 	 * Avoid {NONE,VOLUNTARY} -> FULL transitions from ever ending up in
 	 * the ZERO state, which is invalid.
 	 */
-	static_call_update(cond_resched, __cond_resched);
-	static_call_update(might_resched, __cond_resched);
-	static_call_update(preempt_schedule, __preempt_schedule_func);
-	static_call_update(preempt_schedule_notrace, __preempt_schedule_notrace_func);
-	static_call_update(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
+	preempt_dynamic_enable(cond_resched);
+	preempt_dynamic_enable(might_resched);
+	preempt_dynamic_enable(preempt_schedule);
+	preempt_dynamic_enable(preempt_schedule_notrace);
+	preempt_dynamic_enable(irqentry_exit_cond_resched);
 
 	switch (mode) {
 	case preempt_dynamic_none:
-		static_call_update(cond_resched, __cond_resched);
-		static_call_update(might_resched, (void *)&__static_call_return0);
-		static_call_update(preempt_schedule, NULL);
-		static_call_update(preempt_schedule_notrace, NULL);
-		static_call_update(irqentry_exit_cond_resched, NULL);
+		preempt_dynamic_enable(cond_resched);
+		preempt_dynamic_disable(might_resched);
+		preempt_dynamic_disable(preempt_schedule);
+		preempt_dynamic_disable(preempt_schedule_notrace);
+		preempt_dynamic_disable(irqentry_exit_cond_resched);
 		pr_info("Dynamic Preempt: none\n");
 		break;
 
 	case preempt_dynamic_voluntary:
-		static_call_update(cond_resched, __cond_resched);
-		static_call_update(might_resched, __cond_resched);
-		static_call_update(preempt_schedule, NULL);
-		static_call_update(preempt_schedule_notrace, NULL);
-		static_call_update(irqentry_exit_cond_resched, NULL);
+		preempt_dynamic_enable(cond_resched);
+		preempt_dynamic_enable(might_resched);
+		preempt_dynamic_disable(preempt_schedule);
+		preempt_dynamic_disable(preempt_schedule_notrace);
+		preempt_dynamic_disable(irqentry_exit_cond_resched);
 		pr_info("Dynamic Preempt: voluntary\n");
 		break;
 
 	case preempt_dynamic_full:
-		static_call_update(cond_resched, (void *)&__static_call_return0);
-		static_call_update(might_resched, (void *)&__static_call_return0);
-		static_call_update(preempt_schedule, __preempt_schedule_func);
-		static_call_update(preempt_schedule_notrace, __preempt_schedule_notrace_func);
-		static_call_update(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
+		preempt_dynamic_disable(cond_resched);
+		preempt_dynamic_disable(might_resched);
+		preempt_dynamic_enable(preempt_schedule);
+		preempt_dynamic_enable(preempt_schedule_notrace);
+		preempt_dynamic_enable(irqentry_exit_cond_resched);
 		pr_info("Dynamic Preempt: full\n");
 		break;
 	}
-- 
2.30.2

