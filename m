Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706A5507626
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355991AbiDSRL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355705AbiDSRKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:10:20 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093D713D38
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650388048; x=1681924048;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MdeiJnA9pcMmVctsMXdiSwINVFM1oa0cvnMci6E9E0w=;
  b=QhYvBksSt16mr3Q71wdISUnfLemXhueqjMUuZlUPWek1br0l95wZQ9i7
   7zEzWaF7/xiGIm5VfKfaGwPX/AJFFKYarD/2QforTiLlSIHbRqrMUHdkW
   E7wRA0b/zfOHxjSu+ywD7RnO6xzzHtzFqUJZVcQ5vnnZe7Zn0xjeZ/zd4
   uiziLULBAe5gtG716YOEH0+k6kUsaQDy2Q/XNb5B+6XA2WjZiQSI9/EVs
   K2czhlO8m36Kwlakg5XfOY7fMuwBE7LDOBJe+56T73DTyyor/7Qo1/Tta
   Njr21x13LNQPsrVarZcSIPFEiWIx5ySf+/Ebc4CGTdLUhwAKeWBB1eMZb
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="243750587"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="243750587"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:05 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="530498666"
Received: from ajacosta-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.11.4])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:05 -0700
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V10 18/44] entry: Pass pt_regs to irqentry_exit_cond_resched()
Date:   Tue, 19 Apr 2022 10:06:23 -0700
Message-Id: <20220419170649.1022246-19-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419170649.1022246-1-ira.weiny@intel.com>
References: <20220419170649.1022246-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Auxiliary pt_regs space needs to be manipulated by the generic
entry/exit code.

Ideally irqentry_exit() would take care of handling any auxiliary
pt_regs on exit.  Unfortunately, irqentry_exit() is not the only exit
from exception path.  The call to irqentry_exit_cond_resched() from
xen_pv_evtchn_do_upcall() bypasses irqentry_exit().

Make irqentry_exit_cond_resched() symmetrical with irqentry_enter() by
passing pt_regs to it.  This makes irqentry_exit_cond_resched() capable
of handling auxiliary pt_regs in future patches.

Separate out the internal functionality of irqentry_exit_cond_resched()
and call that internally from irqentry_exit().

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V10
	Patch used to be: entry: Split up irqentry_exit_cond_resched()
		Upstream changes forced this change.

Changes for V9
	Update commit message

Changes for V8
	New Patch
---
 arch/arm64/include/asm/preempt.h |  2 +-
 arch/arm64/kernel/entry-common.c |  4 ++--
 arch/x86/entry/common.c          |  2 +-
 include/linux/entry-common.h     | 17 ++++++++------
 kernel/entry/common.c            | 13 +++++++----
 kernel/sched/core.c              | 40 ++++++++++++++++----------------
 6 files changed, 43 insertions(+), 35 deletions(-)

diff --git a/arch/arm64/include/asm/preempt.h b/arch/arm64/include/asm/preempt.h
index 0159b625cc7f..bd185a214096 100644
--- a/arch/arm64/include/asm/preempt.h
+++ b/arch/arm64/include/asm/preempt.h
@@ -87,7 +87,7 @@ void preempt_schedule_notrace(void);
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 
-DECLARE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
+DECLARE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched_internal);
 void dynamic_preempt_schedule(void);
 #define __preempt_schedule()		dynamic_preempt_schedule()
 void dynamic_preempt_schedule_notrace(void);
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 878c65aa7206..593d31154a62 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -224,9 +224,9 @@ static void noinstr arm64_exit_el1_dbg(struct pt_regs *regs)
 }
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
-DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
+DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched_internal);
 #define need_irq_preemption() \
-	(static_branch_unlikely(&sk_dynamic_irqentry_exit_cond_resched))
+	(static_branch_unlikely(&sk_dynamic_irqentry_exit_cond_resched_internal))
 #else
 #define need_irq_preemption()	(IS_ENABLED(CONFIG_PREEMPTION))
 #endif
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 6c2826417b33..f1ba770d035d 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -309,7 +309,7 @@ __visible noinstr void xen_pv_evtchn_do_upcall(struct pt_regs *regs)
 
 	inhcall = get_and_clear_inhcall();
 	if (inhcall && !WARN_ON_ONCE(state.exit_rcu)) {
-		irqentry_exit_cond_resched();
+		irqentry_exit_cond_resched(regs);
 		instrumentation_end();
 		restore_inhcall(inhcall);
 	} else {
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index ab78bd4c2eb0..f35086d2a258 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -412,23 +412,26 @@ irqentry_state_t noinstr irqentry_enter(struct pt_regs *regs);
 
 /**
  * irqentry_exit_cond_resched - Conditionally reschedule on return from interrupt
+ * @regs:	Pointer to pt_regs of interrupted context
  *
  * Conditional reschedule with additional sanity checks.
  */
+void irqentry_exit_cond_resched(struct pt_regs *regs);
+
 void raw_irqentry_exit_cond_resched(void);
 #ifdef CONFIG_PREEMPT_DYNAMIC
 #if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
-#define irqentry_exit_cond_resched_dynamic_enabled	raw_irqentry_exit_cond_resched
-#define irqentry_exit_cond_resched_dynamic_disabled	NULL
-DECLARE_STATIC_CALL(irqentry_exit_cond_resched, raw_irqentry_exit_cond_resched);
-#define irqentry_exit_cond_resched()	static_call(irqentry_exit_cond_resched)()
+#define irqentry_exit_cond_resched_internal_dynamic_enabled	raw_irqentry_exit_cond_resched
+#define irqentry_exit_cond_resched_internal_dynamic_disabled	NULL
+DECLARE_STATIC_CALL(irqentry_exit_cond_resched_internal, raw_irqentry_exit_cond_resched);
+#define irqentry_exit_cond_resched_internal() static_call(irqentry_exit_cond_resched_internal)()
 #elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
-DECLARE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
+DECLARE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched_internal);
 void dynamic_irqentry_exit_cond_resched(void);
-#define irqentry_exit_cond_resched()	dynamic_irqentry_exit_cond_resched()
+#define irqentry_exit_cond_resched_internal()	dynamic_irqentry_exit_cond_resched()
 #endif
 #else /* CONFIG_PREEMPT_DYNAMIC */
-#define irqentry_exit_cond_resched()	raw_irqentry_exit_cond_resched()
+#define irqentry_exit_cond_resched_internal()	raw_irqentry_exit_cond_resched()
 #endif /* CONFIG_PREEMPT_DYNAMIC */
 
 /**
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 93c3b86e781c..8f73b54bfa56 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -387,18 +387,23 @@ void raw_irqentry_exit_cond_resched(void)
 }
 #ifdef CONFIG_PREEMPT_DYNAMIC
 #if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
-DEFINE_STATIC_CALL(irqentry_exit_cond_resched, raw_irqentry_exit_cond_resched);
+DEFINE_STATIC_CALL(irqentry_exit_cond_resched_internal, raw_irqentry_exit_cond_resched);
 #elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
-DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
+DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched_internal);
 void dynamic_irqentry_exit_cond_resched(void)
 {
-	if (!static_branch_unlikely(&sk_dynamic_irqentry_exit_cond_resched))
+	if (!static_branch_unlikely(&sk_dynamic_irqentry_exit_cond_resched_internal))
 		return;
 	raw_irqentry_exit_cond_resched();
 }
 #endif
 #endif
 
+void irqentry_exit_cond_resched(struct pt_regs *regs)
+{
+	irqentry_exit_cond_resched_internal();
+}
+
 noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 {
 	lockdep_assert_irqs_disabled();
@@ -425,7 +430,7 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 
 		instrumentation_begin();
 		if (IS_ENABLED(CONFIG_PREEMPTION))
-			irqentry_exit_cond_resched();
+			irqentry_exit_cond_resched_internal();
 
 		/* Covers both tracing and lockdep */
 		trace_hardirqs_on();
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 51efaabac3e4..139ccd2c4b66 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8284,29 +8284,29 @@ EXPORT_SYMBOL(__cond_resched_rwlock_write);
  * SC:might_resched
  * SC:preempt_schedule
  * SC:preempt_schedule_notrace
- * SC:irqentry_exit_cond_resched
+ * SC:irqentry_exit_cond_resched_internal
  *
  *
  * NONE:
- *   cond_resched               <- __cond_resched
- *   might_resched              <- RET0
- *   preempt_schedule           <- NOP
- *   preempt_schedule_notrace   <- NOP
- *   irqentry_exit_cond_resched <- NOP
+ *   cond_resched                        <- __cond_resched
+ *   might_resched                       <- RET0
+ *   preempt_schedule                    <- NOP
+ *   preempt_schedule_notrace            <- NOP
+ *   irqentry_exit_cond_resched_internal <- NOP
  *
  * VOLUNTARY:
- *   cond_resched               <- __cond_resched
- *   might_resched              <- __cond_resched
- *   preempt_schedule           <- NOP
- *   preempt_schedule_notrace   <- NOP
- *   irqentry_exit_cond_resched <- NOP
+ *   cond_resched                        <- __cond_resched
+ *   might_resched                       <- __cond_resched
+ *   preempt_schedule                    <- NOP
+ *   preempt_schedule_notrace            <- NOP
+ *   irqentry_exit_cond_resched_internal <- NOP
  *
  * FULL:
- *   cond_resched               <- RET0
- *   might_resched              <- RET0
- *   preempt_schedule           <- preempt_schedule
- *   preempt_schedule_notrace   <- preempt_schedule_notrace
- *   irqentry_exit_cond_resched <- irqentry_exit_cond_resched
+ *   cond_resched                        <- RET0
+ *   might_resched                       <- RET0
+ *   preempt_schedule                    <- preempt_schedule
+ *   preempt_schedule_notrace            <- preempt_schedule_notrace
+ *   irqentry_exit_cond_resched_internal <- irqentry_exit_cond_resched_internal
  */
 
 enum {
@@ -8352,7 +8352,7 @@ void sched_dynamic_update(int mode)
 	preempt_dynamic_enable(might_resched);
 	preempt_dynamic_enable(preempt_schedule);
 	preempt_dynamic_enable(preempt_schedule_notrace);
-	preempt_dynamic_enable(irqentry_exit_cond_resched);
+	preempt_dynamic_enable(irqentry_exit_cond_resched_internal);
 
 	switch (mode) {
 	case preempt_dynamic_none:
@@ -8360,7 +8360,7 @@ void sched_dynamic_update(int mode)
 		preempt_dynamic_disable(might_resched);
 		preempt_dynamic_disable(preempt_schedule);
 		preempt_dynamic_disable(preempt_schedule_notrace);
-		preempt_dynamic_disable(irqentry_exit_cond_resched);
+		preempt_dynamic_disable(irqentry_exit_cond_resched_internal);
 		pr_info("Dynamic Preempt: none\n");
 		break;
 
@@ -8369,7 +8369,7 @@ void sched_dynamic_update(int mode)
 		preempt_dynamic_enable(might_resched);
 		preempt_dynamic_disable(preempt_schedule);
 		preempt_dynamic_disable(preempt_schedule_notrace);
-		preempt_dynamic_disable(irqentry_exit_cond_resched);
+		preempt_dynamic_disable(irqentry_exit_cond_resched_internal);
 		pr_info("Dynamic Preempt: voluntary\n");
 		break;
 
@@ -8378,7 +8378,7 @@ void sched_dynamic_update(int mode)
 		preempt_dynamic_disable(might_resched);
 		preempt_dynamic_enable(preempt_schedule);
 		preempt_dynamic_enable(preempt_schedule_notrace);
-		preempt_dynamic_enable(irqentry_exit_cond_resched);
+		preempt_dynamic_enable(irqentry_exit_cond_resched_internal);
 		pr_info("Dynamic Preempt: full\n");
 		break;
 	}
-- 
2.35.1

