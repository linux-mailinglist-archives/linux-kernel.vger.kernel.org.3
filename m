Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD094A9B99
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 16:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359528AbiBDPGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 10:06:10 -0500
Received: from foss.arm.com ([217.140.110.172]:50196 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1359520AbiBDPGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 10:06:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D77DC1476;
        Fri,  4 Feb 2022 07:06:08 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B8DD13F774;
        Fri,  4 Feb 2022 07:06:06 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     ardb@kernel.org, bp@alien8.de, catalin.marinas@arm.com,
        dave.hansen@linux.intel.com, frederic@kernel.org,
        james.morse@arm.com, joey.gouly@arm.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, luto@kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, peterz@infradead.org,
        tglx@linutronix.de, valentin.schneider@arm.com, will@kernel.org
Subject: [PATCH v2 1/7] sched/preempt: move PREEMPT_DYNAMIC logic later
Date:   Fri,  4 Feb 2022 15:05:51 +0000
Message-Id: <20220204150557.434610-2-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220204150557.434610-1-mark.rutland@arm.com>
References: <20220204150557.434610-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PREEMPT_DYNAMIC logic in kernel/sched/core.c patches static calls
for a bunch of preemption functions. While most are defined prior to
this, the definition of cond_resched() is later in the file, and so we
only have its declarations from include/linux/sched.h.

In subsequent patches we'd like to define some macros alongside the
definition of each of the preemption functions, which we can use within
sched_dynamic_update(). For this to be possible, the PREEMPT_DYNAMIC
logic needs to be placed after the various preemption functions.

As a preparatory step, this patch moves the PREEMPT_DYNAMIC logic after
the various preemption functions, with no other changes -- this is
purely a move.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/core.c | 272 ++++++++++++++++++++++----------------------
 1 file changed, 136 insertions(+), 136 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 848eaa0efe0e..6e8998267102 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6553,142 +6553,6 @@ EXPORT_STATIC_CALL_TRAMP(preempt_schedule_notrace);
 
 #endif /* CONFIG_PREEMPTION */
 
-#ifdef CONFIG_PREEMPT_DYNAMIC
-
-#include <linux/entry-common.h>
-
-/*
- * SC:cond_resched
- * SC:might_resched
- * SC:preempt_schedule
- * SC:preempt_schedule_notrace
- * SC:irqentry_exit_cond_resched
- *
- *
- * NONE:
- *   cond_resched               <- __cond_resched
- *   might_resched              <- RET0
- *   preempt_schedule           <- NOP
- *   preempt_schedule_notrace   <- NOP
- *   irqentry_exit_cond_resched <- NOP
- *
- * VOLUNTARY:
- *   cond_resched               <- __cond_resched
- *   might_resched              <- __cond_resched
- *   preempt_schedule           <- NOP
- *   preempt_schedule_notrace   <- NOP
- *   irqentry_exit_cond_resched <- NOP
- *
- * FULL:
- *   cond_resched               <- RET0
- *   might_resched              <- RET0
- *   preempt_schedule           <- preempt_schedule
- *   preempt_schedule_notrace   <- preempt_schedule_notrace
- *   irqentry_exit_cond_resched <- irqentry_exit_cond_resched
- */
-
-enum {
-	preempt_dynamic_undefined = -1,
-	preempt_dynamic_none,
-	preempt_dynamic_voluntary,
-	preempt_dynamic_full,
-};
-
-int preempt_dynamic_mode = preempt_dynamic_undefined;
-
-int sched_dynamic_mode(const char *str)
-{
-	if (!strcmp(str, "none"))
-		return preempt_dynamic_none;
-
-	if (!strcmp(str, "voluntary"))
-		return preempt_dynamic_voluntary;
-
-	if (!strcmp(str, "full"))
-		return preempt_dynamic_full;
-
-	return -EINVAL;
-}
-
-void sched_dynamic_update(int mode)
-{
-	/*
-	 * Avoid {NONE,VOLUNTARY} -> FULL transitions from ever ending up in
-	 * the ZERO state, which is invalid.
-	 */
-	static_call_update(cond_resched, __cond_resched);
-	static_call_update(might_resched, __cond_resched);
-	static_call_update(preempt_schedule, __preempt_schedule_func);
-	static_call_update(preempt_schedule_notrace, __preempt_schedule_notrace_func);
-	static_call_update(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
-
-	switch (mode) {
-	case preempt_dynamic_none:
-		static_call_update(cond_resched, __cond_resched);
-		static_call_update(might_resched, (void *)&__static_call_return0);
-		static_call_update(preempt_schedule, NULL);
-		static_call_update(preempt_schedule_notrace, NULL);
-		static_call_update(irqentry_exit_cond_resched, NULL);
-		pr_info("Dynamic Preempt: none\n");
-		break;
-
-	case preempt_dynamic_voluntary:
-		static_call_update(cond_resched, __cond_resched);
-		static_call_update(might_resched, __cond_resched);
-		static_call_update(preempt_schedule, NULL);
-		static_call_update(preempt_schedule_notrace, NULL);
-		static_call_update(irqentry_exit_cond_resched, NULL);
-		pr_info("Dynamic Preempt: voluntary\n");
-		break;
-
-	case preempt_dynamic_full:
-		static_call_update(cond_resched, (void *)&__static_call_return0);
-		static_call_update(might_resched, (void *)&__static_call_return0);
-		static_call_update(preempt_schedule, __preempt_schedule_func);
-		static_call_update(preempt_schedule_notrace, __preempt_schedule_notrace_func);
-		static_call_update(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
-		pr_info("Dynamic Preempt: full\n");
-		break;
-	}
-
-	preempt_dynamic_mode = mode;
-}
-
-static int __init setup_preempt_mode(char *str)
-{
-	int mode = sched_dynamic_mode(str);
-	if (mode < 0) {
-		pr_warn("Dynamic Preempt: unsupported mode: %s\n", str);
-		return 0;
-	}
-
-	sched_dynamic_update(mode);
-	return 1;
-}
-__setup("preempt=", setup_preempt_mode);
-
-static void __init preempt_dynamic_init(void)
-{
-	if (preempt_dynamic_mode == preempt_dynamic_undefined) {
-		if (IS_ENABLED(CONFIG_PREEMPT_NONE)) {
-			sched_dynamic_update(preempt_dynamic_none);
-		} else if (IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY)) {
-			sched_dynamic_update(preempt_dynamic_voluntary);
-		} else {
-			/* Default static call setting, nothing to do */
-			WARN_ON_ONCE(!IS_ENABLED(CONFIG_PREEMPT));
-			preempt_dynamic_mode = preempt_dynamic_full;
-			pr_info("Dynamic Preempt: full\n");
-		}
-	}
-}
-
-#else /* !CONFIG_PREEMPT_DYNAMIC */
-
-static inline void preempt_dynamic_init(void) { }
-
-#endif /* #ifdef CONFIG_PREEMPT_DYNAMIC */
-
 /*
  * This is the entry point to schedule() from kernel preemption
  * off of irq context.
@@ -8263,6 +8127,142 @@ int __cond_resched_rwlock_write(rwlock_t *lock)
 }
 EXPORT_SYMBOL(__cond_resched_rwlock_write);
 
+#ifdef CONFIG_PREEMPT_DYNAMIC
+
+#include <linux/entry-common.h>
+
+/*
+ * SC:cond_resched
+ * SC:might_resched
+ * SC:preempt_schedule
+ * SC:preempt_schedule_notrace
+ * SC:irqentry_exit_cond_resched
+ *
+ *
+ * NONE:
+ *   cond_resched               <- __cond_resched
+ *   might_resched              <- RET0
+ *   preempt_schedule           <- NOP
+ *   preempt_schedule_notrace   <- NOP
+ *   irqentry_exit_cond_resched <- NOP
+ *
+ * VOLUNTARY:
+ *   cond_resched               <- __cond_resched
+ *   might_resched              <- __cond_resched
+ *   preempt_schedule           <- NOP
+ *   preempt_schedule_notrace   <- NOP
+ *   irqentry_exit_cond_resched <- NOP
+ *
+ * FULL:
+ *   cond_resched               <- RET0
+ *   might_resched              <- RET0
+ *   preempt_schedule           <- preempt_schedule
+ *   preempt_schedule_notrace   <- preempt_schedule_notrace
+ *   irqentry_exit_cond_resched <- irqentry_exit_cond_resched
+ */
+
+enum {
+	preempt_dynamic_undefined = -1,
+	preempt_dynamic_none,
+	preempt_dynamic_voluntary,
+	preempt_dynamic_full,
+};
+
+int preempt_dynamic_mode = preempt_dynamic_undefined;
+
+int sched_dynamic_mode(const char *str)
+{
+	if (!strcmp(str, "none"))
+		return preempt_dynamic_none;
+
+	if (!strcmp(str, "voluntary"))
+		return preempt_dynamic_voluntary;
+
+	if (!strcmp(str, "full"))
+		return preempt_dynamic_full;
+
+	return -EINVAL;
+}
+
+void sched_dynamic_update(int mode)
+{
+	/*
+	 * Avoid {NONE,VOLUNTARY} -> FULL transitions from ever ending up in
+	 * the ZERO state, which is invalid.
+	 */
+	static_call_update(cond_resched, __cond_resched);
+	static_call_update(might_resched, __cond_resched);
+	static_call_update(preempt_schedule, __preempt_schedule_func);
+	static_call_update(preempt_schedule_notrace, __preempt_schedule_notrace_func);
+	static_call_update(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
+
+	switch (mode) {
+	case preempt_dynamic_none:
+		static_call_update(cond_resched, __cond_resched);
+		static_call_update(might_resched, (void *)&__static_call_return0);
+		static_call_update(preempt_schedule, NULL);
+		static_call_update(preempt_schedule_notrace, NULL);
+		static_call_update(irqentry_exit_cond_resched, NULL);
+		pr_info("Dynamic Preempt: none\n");
+		break;
+
+	case preempt_dynamic_voluntary:
+		static_call_update(cond_resched, __cond_resched);
+		static_call_update(might_resched, __cond_resched);
+		static_call_update(preempt_schedule, NULL);
+		static_call_update(preempt_schedule_notrace, NULL);
+		static_call_update(irqentry_exit_cond_resched, NULL);
+		pr_info("Dynamic Preempt: voluntary\n");
+		break;
+
+	case preempt_dynamic_full:
+		static_call_update(cond_resched, (void *)&__static_call_return0);
+		static_call_update(might_resched, (void *)&__static_call_return0);
+		static_call_update(preempt_schedule, __preempt_schedule_func);
+		static_call_update(preempt_schedule_notrace, __preempt_schedule_notrace_func);
+		static_call_update(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
+		pr_info("Dynamic Preempt: full\n");
+		break;
+	}
+
+	preempt_dynamic_mode = mode;
+}
+
+static int __init setup_preempt_mode(char *str)
+{
+	int mode = sched_dynamic_mode(str);
+	if (mode < 0) {
+		pr_warn("Dynamic Preempt: unsupported mode: %s\n", str);
+		return 0;
+	}
+
+	sched_dynamic_update(mode);
+	return 1;
+}
+__setup("preempt=", setup_preempt_mode);
+
+static void __init preempt_dynamic_init(void)
+{
+	if (preempt_dynamic_mode == preempt_dynamic_undefined) {
+		if (IS_ENABLED(CONFIG_PREEMPT_NONE)) {
+			sched_dynamic_update(preempt_dynamic_none);
+		} else if (IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY)) {
+			sched_dynamic_update(preempt_dynamic_voluntary);
+		} else {
+			/* Default static call setting, nothing to do */
+			WARN_ON_ONCE(!IS_ENABLED(CONFIG_PREEMPT));
+			preempt_dynamic_mode = preempt_dynamic_full;
+			pr_info("Dynamic Preempt: full\n");
+		}
+	}
+}
+
+#else /* !CONFIG_PREEMPT_DYNAMIC */
+
+static inline void preempt_dynamic_init(void) { }
+
+#endif /* #ifdef CONFIG_PREEMPT_DYNAMIC */
+
 /**
  * yield - yield the current processor to other threads.
  *
-- 
2.30.2

