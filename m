Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB8349E95B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244853AbiA0Rz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:55:26 -0500
Received: from mga12.intel.com ([192.55.52.136]:65462 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240185AbiA0RzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:55:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643306115; x=1674842115;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ER6JviQv6ox2UPy2iIeHIKlZtZEKY0Z2BX0fYT7NB20=;
  b=SCKANevs47lIrsZziijA2bCoDRTQ1HeG2HfYJAYrZjN+yJ0gOBcSE8aq
   xyvVJYbD63JNRrHLd6y3psaUouLp0E2hqAu0VW3iaGPUbATdzFuDb5Smk
   7rJvNwUjJvrX+ZTwzil3j60i086qmqwGtZVM+ofc2xINVcmbhjjlMo6Rc
   kfjn9U4g8mwjM1MjInsulSO1seWubzB5Yqkit5zp6xv4OpQ/8xPNOIk5Q
   Y0w8ne7dN9mjz/N1ws+rGKnEEvKo52hAKy/tQ6cuvL1Dpd477mg2KCxc2
   WqkeXt/4iJkBLZry7N9wXHZWA0heFDVT2AnEY1YFA+J6BjJNhylSkfPLB
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="226899115"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="226899115"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:07 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="674796044"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:07 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V8 01/44] entry: Create an internal irqentry_exit_cond_resched() call
Date:   Thu, 27 Jan 2022 09:54:22 -0800
Message-Id: <20220127175505.851391-2-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220127175505.851391-1-ira.weiny@intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The call to irqentry_exit_cond_resched() was not properly being
overridden when called from xen_pv_evtchn_do_upcall().

Define __irqentry_exit_cond_resched() as the static call and place the
override logic in irqentry_exit_cond_resched().

Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Because this was found via code inspection and it does not actually fix
any seen bug I've not added a fixes tag.

But for reference:
Fixes: 40607ee97e4e ("preempt/dynamic: Provide irqentry_exit_cond_resched() static call")
---
 include/linux/entry-common.h |  5 ++++-
 kernel/entry/common.c        | 23 +++++++++++++--------
 kernel/sched/core.c          | 40 ++++++++++++++++++------------------
 3 files changed, 38 insertions(+), 30 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 2e2b8d6140ed..ddaffc983e62 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -455,10 +455,13 @@ irqentry_state_t noinstr irqentry_enter(struct pt_regs *regs);
  * Conditional reschedule with additional sanity checks.
  */
 void irqentry_exit_cond_resched(void);
+
+void __irqentry_exit_cond_resched(void);
 #ifdef CONFIG_PREEMPT_DYNAMIC
-DECLARE_STATIC_CALL(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
+DECLARE_STATIC_CALL(__irqentry_exit_cond_resched, __irqentry_exit_cond_resched);
 #endif
 
+
 /**
  * irqentry_exit - Handle return from exception that used irqentry_enter()
  * @regs:	Pointer to pt_regs (exception entry regs)
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index bad713684c2e..490442a48332 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -380,7 +380,7 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 	return ret;
 }
 
-void irqentry_exit_cond_resched(void)
+void __irqentry_exit_cond_resched(void)
 {
 	if (!preempt_count()) {
 		/* Sanity check RCU and thread stack */
@@ -392,9 +392,20 @@ void irqentry_exit_cond_resched(void)
 	}
 }
 #ifdef CONFIG_PREEMPT_DYNAMIC
-DEFINE_STATIC_CALL(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
+DEFINE_STATIC_CALL(__irqentry_exit_cond_resched, __irqentry_exit_cond_resched);
 #endif
 
+void irqentry_exit_cond_resched(void)
+{
+	if (IS_ENABLED(CONFIG_PREEMPTION)) {
+#ifdef CONFIG_PREEMPT_DYNAMIC
+		static_call(__irqentry_exit_cond_resched)();
+#else
+		__irqentry_exit_cond_resched();
+#endif
+	}
+}
+
 noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 {
 	lockdep_assert_irqs_disabled();
@@ -420,13 +431,7 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 		}
 
 		instrumentation_begin();
-		if (IS_ENABLED(CONFIG_PREEMPTION)) {
-#ifdef CONFIG_PREEMPT_DYNAMIC
-			static_call(irqentry_exit_cond_resched)();
-#else
-			irqentry_exit_cond_resched();
-#endif
-		}
+		irqentry_exit_cond_resched();
 		/* Covers both tracing and lockdep */
 		trace_hardirqs_on();
 		instrumentation_end();
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 848eaa0efe0e..7197c33beb39 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6562,29 +6562,29 @@ EXPORT_STATIC_CALL_TRAMP(preempt_schedule_notrace);
  * SC:might_resched
  * SC:preempt_schedule
  * SC:preempt_schedule_notrace
- * SC:irqentry_exit_cond_resched
+ * SC:__irqentry_exit_cond_resched
  *
  *
  * NONE:
- *   cond_resched               <- __cond_resched
- *   might_resched              <- RET0
- *   preempt_schedule           <- NOP
- *   preempt_schedule_notrace   <- NOP
- *   irqentry_exit_cond_resched <- NOP
+ *   cond_resched                 <- __cond_resched
+ *   might_resched                <- RET0
+ *   preempt_schedule             <- NOP
+ *   preempt_schedule_notrace     <- NOP
+ *   __irqentry_exit_cond_resched <- NOP
  *
  * VOLUNTARY:
- *   cond_resched               <- __cond_resched
- *   might_resched              <- __cond_resched
- *   preempt_schedule           <- NOP
- *   preempt_schedule_notrace   <- NOP
- *   irqentry_exit_cond_resched <- NOP
+ *   cond_resched                 <- __cond_resched
+ *   might_resched                <- __cond_resched
+ *   preempt_schedule             <- NOP
+ *   preempt_schedule_notrace     <- NOP
+ *   __irqentry_exit_cond_resched <- NOP
  *
  * FULL:
- *   cond_resched               <- RET0
- *   might_resched              <- RET0
- *   preempt_schedule           <- preempt_schedule
- *   preempt_schedule_notrace   <- preempt_schedule_notrace
- *   irqentry_exit_cond_resched <- irqentry_exit_cond_resched
+ *   cond_resched                 <- RET0
+ *   might_resched                <- RET0
+ *   preempt_schedule             <- preempt_schedule
+ *   preempt_schedule_notrace     <- preempt_schedule_notrace
+ *   __irqentry_exit_cond_resched <- __irqentry_exit_cond_resched
  */
 
 enum {
@@ -6620,7 +6620,7 @@ void sched_dynamic_update(int mode)
 	static_call_update(might_resched, __cond_resched);
 	static_call_update(preempt_schedule, __preempt_schedule_func);
 	static_call_update(preempt_schedule_notrace, __preempt_schedule_notrace_func);
-	static_call_update(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
+	static_call_update(__irqentry_exit_cond_resched, __irqentry_exit_cond_resched);
 
 	switch (mode) {
 	case preempt_dynamic_none:
@@ -6628,7 +6628,7 @@ void sched_dynamic_update(int mode)
 		static_call_update(might_resched, (void *)&__static_call_return0);
 		static_call_update(preempt_schedule, NULL);
 		static_call_update(preempt_schedule_notrace, NULL);
-		static_call_update(irqentry_exit_cond_resched, NULL);
+		static_call_update(__irqentry_exit_cond_resched, NULL);
 		pr_info("Dynamic Preempt: none\n");
 		break;
 
@@ -6637,7 +6637,7 @@ void sched_dynamic_update(int mode)
 		static_call_update(might_resched, __cond_resched);
 		static_call_update(preempt_schedule, NULL);
 		static_call_update(preempt_schedule_notrace, NULL);
-		static_call_update(irqentry_exit_cond_resched, NULL);
+		static_call_update(__irqentry_exit_cond_resched, NULL);
 		pr_info("Dynamic Preempt: voluntary\n");
 		break;
 
@@ -6646,7 +6646,7 @@ void sched_dynamic_update(int mode)
 		static_call_update(might_resched, (void *)&__static_call_return0);
 		static_call_update(preempt_schedule, __preempt_schedule_func);
 		static_call_update(preempt_schedule_notrace, __preempt_schedule_notrace_func);
-		static_call_update(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
+		static_call_update(__irqentry_exit_cond_resched, __irqentry_exit_cond_resched);
 		pr_info("Dynamic Preempt: full\n");
 		break;
 	}
-- 
2.31.1

