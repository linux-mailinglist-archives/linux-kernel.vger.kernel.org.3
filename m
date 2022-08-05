Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDE158AEF1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 19:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241335AbiHERbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 13:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241317AbiHERag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 13:30:36 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337ED1D32B
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 10:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659720630; x=1691256630;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vh4l5KbAwI6TXvI2LGgnuBRyb+jKRxL2UjEp25aMitU=;
  b=kR4USEvk/dpFs9ScC9nUSL2PNkV4QMokZvrRF4ohNYl5PC+vvM7lhF/V
   XMdp9UDnRch4j+yTP1p6RaARiXhgCunj23i8OLB9fO//nbDjEYCJ2ZCet
   fbQJrsZsVIYWzvdtMS/HGnQAB1MMYcASLG3iSOZPeNtUfem187VeIo+6N
   8qmrIdGVz8kHh0wkTVPTHeqWjm5WMrqMV8OJKOrN6DdaU+OmybN0Yc33+
   NWqQuhN+d+HwIBX+hL6zL174Mc9zCW+LXFDLFYZdk6F3d2FUVI1R7hBbS
   MOu2HdL7sZRMi8oHfpPwSxfRmL52StoiEAjbQfTsPAtg770jFq0NSlsxp
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="287814613"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="287814613"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 10:30:21 -0700
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="663064585"
Received: from amecham-mobl.amr.corp.intel.com (HELO localhost) ([10.255.0.242])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 10:30:21 -0700
From:   ira.weiny@intel.com
To:     Rik van Riel <riel@surriel.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [RFC PATCH 1/5] entry: Pass pt_regs to irqentry_exit_cond_resched()
Date:   Fri,  5 Aug 2022 10:30:05 -0700
Message-Id: <20220805173009.3128098-2-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220805173009.3128098-1-ira.weiny@intel.com>
References: <20220805173009.3128098-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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

Cc: Rik van Riel <riel@surriel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Forward ported from PKS series:
	https://lore.kernel.org/lkml/20220419170649.1022246-19-ira.weiny@intel.com/
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
index c75ca36b4a49..a1cc8795b729 100644
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
index 84a466b176cf..976cce7cf803 100644
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
index 063068a9ea9b..8c0f334c4b75 100644
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
index 189999007f32..38dd74ba1c86 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8419,29 +8419,29 @@ EXPORT_SYMBOL(__cond_resched_rwlock_write);
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
@@ -8487,7 +8487,7 @@ void sched_dynamic_update(int mode)
 	preempt_dynamic_enable(might_resched);
 	preempt_dynamic_enable(preempt_schedule);
 	preempt_dynamic_enable(preempt_schedule_notrace);
-	preempt_dynamic_enable(irqentry_exit_cond_resched);
+	preempt_dynamic_enable(irqentry_exit_cond_resched_internal);
 
 	switch (mode) {
 	case preempt_dynamic_none:
@@ -8495,7 +8495,7 @@ void sched_dynamic_update(int mode)
 		preempt_dynamic_disable(might_resched);
 		preempt_dynamic_disable(preempt_schedule);
 		preempt_dynamic_disable(preempt_schedule_notrace);
-		preempt_dynamic_disable(irqentry_exit_cond_resched);
+		preempt_dynamic_disable(irqentry_exit_cond_resched_internal);
 		pr_info("Dynamic Preempt: none\n");
 		break;
 
@@ -8504,7 +8504,7 @@ void sched_dynamic_update(int mode)
 		preempt_dynamic_enable(might_resched);
 		preempt_dynamic_disable(preempt_schedule);
 		preempt_dynamic_disable(preempt_schedule_notrace);
-		preempt_dynamic_disable(irqentry_exit_cond_resched);
+		preempt_dynamic_disable(irqentry_exit_cond_resched_internal);
 		pr_info("Dynamic Preempt: voluntary\n");
 		break;
 
@@ -8513,7 +8513,7 @@ void sched_dynamic_update(int mode)
 		preempt_dynamic_disable(might_resched);
 		preempt_dynamic_enable(preempt_schedule);
 		preempt_dynamic_enable(preempt_schedule_notrace);
-		preempt_dynamic_enable(irqentry_exit_cond_resched);
+		preempt_dynamic_enable(irqentry_exit_cond_resched_internal);
 		pr_info("Dynamic Preempt: full\n");
 		break;
 	}
-- 
2.35.3

