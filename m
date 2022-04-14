Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADCEC50063A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 08:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237725AbiDNGkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 02:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234478AbiDNGkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 02:40:32 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A25331DFB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 23:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649918288; x=1681454288;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oqzJFIA8p1Ys2vDrqeXTbt3/uml2YLpsvidLaH77ORE=;
  b=UfVaisZWaSMffPHG1fp/9z3iZZAAZquShrWYZpSUQm+aPnSAD3hCYu0f
   TnlxdyUG/O29ietyC2k8b4OyO8rAngOXO1q4+FGVEgk8ya6FIppfLeKUq
   3TVVQ+MNAdgB7RjDiWrjzepTyigDi2hmOiE2AtsyzGxLUrMO5kc2D08ia
   QK3glNYrV/SB31TBDxaakLCZnrOg+VS3WgfyYgucPeO+1MaaxXd30v7N0
   DZmdu9us6R8B9d0lxQPS0lZniA9K2qzd3G/SpRQTrMHXlZzhbj/nn6eft
   6jvWlSwPTIUE4H/6PX3UAYFzaw5MeBkj0uA9h4xSmFX0EmD6u0rYpPgbI
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="262301463"
X-IronPort-AV: E=Sophos;i="5.90,259,1643702400"; 
   d="scan'208";a="262301463"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 23:38:08 -0700
X-IronPort-AV: E=Sophos;i="5.90,259,1643702400"; 
   d="scan'208";a="527271989"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 23:38:06 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     akpm@linux-foundation.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] irq_work: Add event-tracing points for irq_work
Date:   Thu, 14 Apr 2022 14:38:29 +0800
Message-Id: <20220414063829.2472251-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add irq_work_queue_on tracepoints allow tracing when and how
a irq-work is queued, irq_work_execute_start/end tracepoints
allow know when a irq-work is executed and the executed time.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 include/trace/events/irq_work.h | 79 +++++++++++++++++++++++++++++++++
 kernel/irq_work.c               |  9 +++-
 2 files changed, 87 insertions(+), 1 deletion(-)
 create mode 100644 include/trace/events/irq_work.h

diff --git a/include/trace/events/irq_work.h b/include/trace/events/irq_work.h
new file mode 100644
index 000000000000..823cb48666c4
--- /dev/null
+++ b/include/trace/events/irq_work.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM irq_work
+
+#if !defined(_TRACE_IRQ_WORK_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_IRQ_WORK_H
+
+#include <linux/tracepoint.h>
+#include <linux/irq_work.h>
+
+TRACE_EVENT(irq_work_queue_on,
+
+	TP_PROTO(unsigned int req_cpu, struct irq_work *work),
+
+	TP_ARGS(req_cpu, work),
+
+	TP_STRUCT__entry(
+		__field( void *,	work	)
+		__field( void *,	function)
+		__field( unsigned int,	req_cpu	)
+		__field( int,		flags	)
+	),
+
+	TP_fast_assign(
+		__entry->work		= work;
+		__entry->function	= work->func;
+		__entry->req_cpu	= req_cpu;
+		__entry->flags		= atomic_read(&work->node.a_flags);
+	),
+
+	TP_printk("irq_work=%p func=%ps req_cpu=%u flags=%x",
+			__entry->work, __entry->function, __entry->req_cpu, __entry->flags)
+);
+
+TRACE_EVENT(irq_work_execute_start,
+
+	TP_PROTO(struct irq_work *work),
+
+	TP_ARGS(work),
+
+	TP_STRUCT__entry(
+		__field( void *,	work	)
+		__field( void *,	function)
+		__field( int,		flags	)
+	),
+
+	TP_fast_assign(
+		__entry->work		= work;
+		__entry->function	= work->func;
+		__entry->flags		= atomic_read(&work->node.a_flags);
+	),
+
+	TP_printk("irq_work=%p: func=%ps flags=%x",
+			__entry->work, __entry->function,  __entry->flags)
+);
+
+TRACE_EVENT(irq_work_execute_end,
+
+	TP_PROTO(struct irq_work *work),
+
+	TP_ARGS(work),
+
+	TP_STRUCT__entry(
+		__field( void *,	work	)
+		__field( void *,	function)
+		__field( int,		flags	)
+	),
+
+	TP_fast_assign(
+		__entry->work		= work;
+		__entry->function	= work->func;
+		__entry->flags		= atomic_read(&work->node.a_flags);
+	),
+
+	TP_printk("irq_work=%p: func=%ps flags=%x",
+			__entry->work, __entry->function, __entry->flags)
+);
+#endif
+#include <trace/define_trace.h>
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 7afa40fe5cc4..edad992556d0 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -22,6 +22,9 @@
 #include <asm/processor.h>
 #include <linux/kasan.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/irq_work.h>
+
 static DEFINE_PER_CPU(struct llist_head, raised_list);
 static DEFINE_PER_CPU(struct llist_head, lazy_list);
 static DEFINE_PER_CPU(struct task_struct *, irq_workd);
@@ -81,7 +84,9 @@ static void __irq_work_queue_local(struct irq_work *work)
 	bool rt_lazy_work = false;
 	bool lazy_work = false;
 	int work_flags;
+	int cpu = smp_processor_id();
 
+	trace_irq_work_queue_on(cpu, work);
 	work_flags = atomic_read(&work->node.a_flags);
 	if (work_flags & IRQ_WORK_LAZY)
 		lazy_work = true;
@@ -143,7 +148,7 @@ bool irq_work_queue_on(struct irq_work *work, int cpu)
 	if (cpu != smp_processor_id()) {
 		/* Arch remote IPI send/receive backend aren't NMI safe */
 		WARN_ON_ONCE(in_nmi());
-
+		trace_irq_work_queue_on(cpu, work);
 		/*
 		 * On PREEMPT_RT the items which are not marked as
 		 * IRQ_WORK_HARD_IRQ are added to the lazy list and a HARD work
@@ -208,7 +213,9 @@ void irq_work_single(void *arg)
 	smp_mb();
 
 	lockdep_irq_work_enter(flags);
+	trace_irq_work_execute_start(work);
 	work->func(work);
+	trace_irq_work_execute_end(work);
 	lockdep_irq_work_exit(flags);
 
 	/*
-- 
2.25.1

