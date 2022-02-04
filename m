Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458C84AA404
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377970AbiBDXI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:08:28 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53370 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377901AbiBDXIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:08:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B7EDB83969;
        Fri,  4 Feb 2022 23:08:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1673CC340F3;
        Fri,  4 Feb 2022 23:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644016087;
        bh=mPWgAdkyrX/RwbFRVrRX5RqVqjHoL8oAY4muj7gz8PI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BuVPuasbQiMjDpJkz7nIdLTaoS7fpqwBtnINOH+qHg7MH2ZkT/ZZIhnrHFWYXLnVk
         i+IlXLompFRpHDXhQekytUVjeEJVuEx4abBXRPl5+SjjuX/CshH6G1Ab2ci4+yIOQj
         W5And4cME3M2AXQ8to0cDcym77q2L2hA/nWoUgcw/W8BoYBeHXzdT0qCWmBdkPuPuq
         ix1SJ+CcsM+oEeRFM93vGtrTQXhzLcqy2TC5HMnxBebTZfQfroS65xhuh0BZMA0KHn
         1BKOXzKYxoC/TuuXnvjHIZIUOttrA8QIL6CTqUdQ4Ac5prF8pUA5/cy2q28265NkNn
         qyQ89g2KsjaqQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9CBEA5C08DD; Fri,  4 Feb 2022 15:08:06 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 4/9] rcu: Inline __call_rcu() into call_rcu()
Date:   Fri,  4 Feb 2022 15:08:00 -0800
Message-Id: <20220204230805.4193767-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204230751.GA4193671@paulmck-ThinkPad-P17-Gen-1>
References: <20220204230751.GA4193671@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because __call_rcu() is invoked only by call_rcu(), this commit inlines
the former into the latter.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 91 ++++++++++++++++++++++-------------------------
 1 file changed, 42 insertions(+), 49 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d1d1a8c51223b..f1bb7ccc00847 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2995,9 +2995,47 @@ static void check_cb_ovld(struct rcu_data *rdp)
 	raw_spin_unlock_rcu_node(rnp);
 }
 
-/* Helper function for call_rcu() and friends.  */
-static void
-__call_rcu(struct rcu_head *head, rcu_callback_t func)
+/**
+ * call_rcu() - Queue an RCU callback for invocation after a grace period.
+ * @head: structure to be used for queueing the RCU updates.
+ * @func: actual callback function to be invoked after the grace period
+ *
+ * The callback function will be invoked some time after a full grace
+ * period elapses, in other words after all pre-existing RCU read-side
+ * critical sections have completed.  However, the callback function
+ * might well execute concurrently with RCU read-side critical sections
+ * that started after call_rcu() was invoked.
+ *
+ * RCU read-side critical sections are delimited by rcu_read_lock()
+ * and rcu_read_unlock(), and may be nested.  In addition, but only in
+ * v5.0 and later, regions of code across which interrupts, preemption,
+ * or softirqs have been disabled also serve as RCU read-side critical
+ * sections.  This includes hardware interrupt handlers, softirq handlers,
+ * and NMI handlers.
+ *
+ * Note that all CPUs must agree that the grace period extended beyond
+ * all pre-existing RCU read-side critical section.  On systems with more
+ * than one CPU, this means that when "func()" is invoked, each CPU is
+ * guaranteed to have executed a full memory barrier since the end of its
+ * last RCU read-side critical section whose beginning preceded the call
+ * to call_rcu().  It also means that each CPU executing an RCU read-side
+ * critical section that continues beyond the start of "func()" must have
+ * executed a memory barrier after the call_rcu() but before the beginning
+ * of that RCU read-side critical section.  Note that these guarantees
+ * include CPUs that are offline, idle, or executing in user mode, as
+ * well as CPUs that are executing in the kernel.
+ *
+ * Furthermore, if CPU A invoked call_rcu() and CPU B invoked the
+ * resulting RCU callback function "func()", then both CPU A and CPU B are
+ * guaranteed to execute a full memory barrier during the time interval
+ * between the call to call_rcu() and the invocation of "func()" -- even
+ * if CPU A and CPU B are the same CPU (but again only if the system has
+ * more than one CPU).
+ *
+ * Implementation of these memory-ordering guarantees is described here:
+ * Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst.
+ */
+void call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
 	static atomic_t doublefrees;
 	unsigned long flags;
@@ -3011,7 +3049,7 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
 		/*
 		 * Probable double call_rcu(), so leak the callback.
 		 * Use rcu:rcu_callback trace event to find the previous
-		 * time callback was passed to __call_rcu().
+		 * time callback was passed to call_rcu().
 		 */
 		if (atomic_inc_return(&doublefrees) < 4) {
 			pr_err("%s(): Double-freed CB %p->%pS()!!!  ", __func__, head, head->func);
@@ -3060,51 +3098,6 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
 		local_irq_restore(flags);
 	}
 }
-
-/**
- * call_rcu() - Queue an RCU callback for invocation after a grace period.
- * @head: structure to be used for queueing the RCU updates.
- * @func: actual callback function to be invoked after the grace period
- *
- * The callback function will be invoked some time after a full grace
- * period elapses, in other words after all pre-existing RCU read-side
- * critical sections have completed.  However, the callback function
- * might well execute concurrently with RCU read-side critical sections
- * that started after call_rcu() was invoked.
- *
- * RCU read-side critical sections are delimited by rcu_read_lock()
- * and rcu_read_unlock(), and may be nested.  In addition, but only in
- * v5.0 and later, regions of code across which interrupts, preemption,
- * or softirqs have been disabled also serve as RCU read-side critical
- * sections.  This includes hardware interrupt handlers, softirq handlers,
- * and NMI handlers.
- *
- * Note that all CPUs must agree that the grace period extended beyond
- * all pre-existing RCU read-side critical section.  On systems with more
- * than one CPU, this means that when "func()" is invoked, each CPU is
- * guaranteed to have executed a full memory barrier since the end of its
- * last RCU read-side critical section whose beginning preceded the call
- * to call_rcu().  It also means that each CPU executing an RCU read-side
- * critical section that continues beyond the start of "func()" must have
- * executed a memory barrier after the call_rcu() but before the beginning
- * of that RCU read-side critical section.  Note that these guarantees
- * include CPUs that are offline, idle, or executing in user mode, as
- * well as CPUs that are executing in the kernel.
- *
- * Furthermore, if CPU A invoked call_rcu() and CPU B invoked the
- * resulting RCU callback function "func()", then both CPU A and CPU B are
- * guaranteed to execute a full memory barrier during the time interval
- * between the call to call_rcu() and the invocation of "func()" -- even
- * if CPU A and CPU B are the same CPU (but again only if the system has
- * more than one CPU).
- *
- * Implementation of these memory-ordering guarantees is described here:
- * Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst.
- */
-void call_rcu(struct rcu_head *head, rcu_callback_t func)
-{
-	__call_rcu(head, func);
-}
 EXPORT_SYMBOL_GPL(call_rcu);
 
 
-- 
2.31.1.189.g2e36527f23

