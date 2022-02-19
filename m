Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5DE4BC7AF
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 11:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242078AbiBSKWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 05:22:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241959AbiBSKVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 05:21:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F176316;
        Sat, 19 Feb 2022 02:21:30 -0800 (PST)
Date:   Sat, 19 Feb 2022 10:21:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645266089;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zI2Q6n3of6P85/qCQUOyZ21T/+NmhFhsj3BbBT9kZAQ=;
        b=DAFchMrBJcA29viPwqy30VN0nM2OP/OWMBs8zNUHZtLAoX1mRnTTGW6U2FLBOPlmm36MsL
        NigrG5hz4VsiqkY92/ozXnJcQjYBnVSlHYrIxht9q0XBY7KIfifSdUqPXot/EmEkMe1+0x
        Mv8NXLU03kJbSfGIrUXzlSTjMzwSivPQgGQw5YzfcOB0I+OcwwQ7djfdTCvjk1qtVZwz4w
        D+A6tK6Dv/ra4d2An3iAuG06IWWNEr5irYscKVk1WJphbVSdSehOmtYI+39+ZTfotWkBmL
        /qsB/84qnoX1BwyOXjsAmoyFgaxJwGMVXazH0dE0BTS4EJ+PAtM3YNxSthiBdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645266089;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zI2Q6n3of6P85/qCQUOyZ21T/+NmhFhsj3BbBT9kZAQ=;
        b=os21Xt417A0bOvjbso9d4FGkvCOflq4mRye5OoeD3vUZCqJeKH1E2XNtY+PXBNauKj+5u0
        8/J8Ioz05evVtYBQ==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/preempt: Move PREEMPT_DYNAMIC logic later
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220214165216.2231574-2-mark.rutland@arm.com>
References: <20220214165216.2231574-2-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <164526608858.16921.4085095758644727666.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     4c7485584d48f60b1e742c7c6a3a1fa503d48d97
Gitweb:        https://git.kernel.org/tip/4c7485584d48f60b1e742c7c6a3a1fa503d48d97
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Mon, 14 Feb 2022 16:52:10 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 19 Feb 2022 11:11:07 +01:00

sched/preempt: Move PREEMPT_DYNAMIC logic later

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20220214165216.2231574-2-mark.rutland@arm.com
---
 kernel/sched/core.c | 272 +++++++++++++++++++++----------------------
 1 file changed, 136 insertions(+), 136 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1e08b02..a123ffa 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6555,142 +6555,6 @@ EXPORT_STATIC_CALL_TRAMP(preempt_schedule_notrace);
 
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
@@ -8271,6 +8135,142 @@ int __cond_resched_rwlock_write(rwlock_t *lock)
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
