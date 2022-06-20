Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D105527F6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 01:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347294AbiFTXQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 19:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347106AbiFTXMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 19:12:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92F022296;
        Mon, 20 Jun 2022 16:10:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F71961505;
        Mon, 20 Jun 2022 23:10:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5459BC341EE;
        Mon, 20 Jun 2022 23:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655766632;
        bh=yH3rcc6h4bxkbl4PBwXYAQclBPLiEgWRFDrMwOLKi5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kTFwUd47L6m/G992pjcvZo2kRrAFTbAn8KMWAd3NI3qCX40S5Z9grrlYkv31W+20t
         hrW9PTOM5UjZnsXlfmy77Og3zu1gAfQQbm0CoFE0k1Tcn9po8QihEeJ17E92Cpqu7z
         H9TmEJ9eYMHVZ/dkBzOv9wQLRo58l4/3ahHX2TcgKCWgckt544luPpkHHUFxzSGkwA
         jFsYA2FdWEPYay3nIYJJpmiZmYlxGbk5QCFHARDQ/W36JeXIqKLjQMSVBAEZkah65q
         W2g+TdIhNgsi5ZzIWFZYaTJC2f+M7Z3hcmf0q48al3eBVJTRTTJMLXOltFzd7fRknV
         QWM+uypkMBvog==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 73E035C11DC; Mon, 20 Jun 2022 16:10:31 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Yu Liao <liaoyu15@huawei.com>, Phil Auld <pauld@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Alex Belits <abelits@marvell.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 20/23] context_tracking: Convert state to atomic_t
Date:   Mon, 20 Jun 2022 16:10:26 -0700
Message-Id: <20220620231029.3844583-20-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620231027.GA3844372@paulmck-ThinkPad-P17-Gen-1>
References: <20220620231027.GA3844372@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

Context tracking's state and dynticks counter are going to be merged
in a single field so that both updates can happen atomically and at the
same time. Prepare for that with converting the state into an atomic_t.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc: Yu Liao <liaoyu15@huawei.com>
Cc: Phil Auld <pauld@redhat.com>
Cc: Paul Gortmaker<paul.gortmaker@windriver.com>
Cc: Alex Belits <abelits@marvell.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/context_tracking.h       | 24 +++++-------------
 include/linux/context_tracking_state.h | 34 +++++++++++++++++++++++---
 kernel/context_tracking.c              | 15 +++++++-----
 3 files changed, 45 insertions(+), 28 deletions(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index 1f568676bc1d2..a8c1db0a3f65a 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -56,7 +56,7 @@ static inline enum ctx_state exception_enter(void)
 	    !context_tracking_enabled())
 		return 0;
 
-	prev_ctx = this_cpu_read(context_tracking.state);
+	prev_ctx = __ct_state();
 	if (prev_ctx != CONTEXT_KERNEL)
 		ct_user_exit(prev_ctx);
 
@@ -86,33 +86,21 @@ static __always_inline void context_tracking_guest_exit(void)
 		__ct_user_exit(CONTEXT_GUEST);
 }
 
-/**
- * ct_state() - return the current context tracking state if known
- *
- * Returns the current cpu's context tracking state if context tracking
- * is enabled.  If context tracking is disabled, returns
- * CONTEXT_DISABLED.  This should be used primarily for debugging.
- */
-static __always_inline enum ctx_state ct_state(void)
-{
-	return context_tracking_enabled() ?
-		this_cpu_read(context_tracking.state) : CONTEXT_DISABLED;
-}
+#define CT_WARN_ON(cond) WARN_ON(context_tracking_enabled() && (cond))
+
 #else
 static inline void user_enter(void) { }
 static inline void user_exit(void) { }
 static inline void user_enter_irqoff(void) { }
 static inline void user_exit_irqoff(void) { }
-static inline enum ctx_state exception_enter(void) { return 0; }
+static inline int exception_enter(void) { return 0; }
 static inline void exception_exit(enum ctx_state prev_ctx) { }
-static inline enum ctx_state ct_state(void) { return CONTEXT_DISABLED; }
+static inline int ct_state(void) { return -1; }
 static __always_inline bool context_tracking_guest_enter(void) { return false; }
 static inline void context_tracking_guest_exit(void) { }
-
+#define CT_WARN_ON(cond)
 #endif /* !CONFIG_CONTEXT_TRACKING_USER */
 
-#define CT_WARN_ON(cond) WARN_ON(context_tracking_enabled() && (cond))
-
 #ifdef CONFIG_CONTEXT_TRACKING_USER_FORCE
 extern void context_tracking_init(void);
 #else
diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index 2f957b48e24f9..7d2dddf0da690 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -6,6 +6,9 @@
 #include <linux/static_key.h>
 #include <linux/context_tracking_irq.h>
 
+/* Offset to allow distinguishing irq vs. task-based idle entry/exit. */
+#define DYNTICK_IRQ_NONIDLE	((LONG_MAX / 2) + 1)
+
 enum ctx_state {
 	CONTEXT_DISABLED = -1,	/* returned by ct_state() if unknown */
 	CONTEXT_KERNEL = 0,
@@ -13,9 +16,6 @@ enum ctx_state {
 	CONTEXT_GUEST,
 };
 
-/* Offset to allow distinguishing irq vs. task-based idle entry/exit. */
-#define DYNTICK_IRQ_NONIDLE	((LONG_MAX / 2) + 1)
-
 struct context_tracking {
 #ifdef CONFIG_CONTEXT_TRACKING_USER
 	/*
@@ -26,7 +26,7 @@ struct context_tracking {
 	 */
 	bool active;
 	int recursion;
-	enum ctx_state state;
+	atomic_t state;
 #endif
 #ifdef CONFIG_CONTEXT_TRACKING_IDLE
 	atomic_t dynticks;		/* Even value for idle, else odd. */
@@ -98,6 +98,32 @@ static inline bool context_tracking_enabled_this_cpu(void)
 	return context_tracking_enabled() && __this_cpu_read(context_tracking.active);
 }
 
+static __always_inline int __ct_state(void)
+{
+	return atomic_read(this_cpu_ptr(&context_tracking.state));
+}
+
+/**
+ * ct_state() - return the current context tracking state if known
+ *
+ * Returns the current cpu's context tracking state if context tracking
+ * is enabled.  If context tracking is disabled, returns
+ * CONTEXT_DISABLED.  This should be used primarily for debugging.
+ */
+static __always_inline int ct_state(void)
+{
+	int ret;
+
+	if (!context_tracking_enabled())
+		return CONTEXT_DISABLED;
+
+	preempt_disable();
+	ret = __ct_state();
+	preempt_enable();
+
+	return ret;
+}
+
 #else
 static __always_inline bool context_tracking_enabled(void) { return false; }
 static __always_inline bool context_tracking_enabled_cpu(int cpu) { return false; }
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 8b0979412f755..c477c7d696e0f 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -463,6 +463,7 @@ static __always_inline void context_tracking_recursion_exit(void)
  */
 void noinstr __ct_user_enter(enum ctx_state state)
 {
+	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
 	lockdep_assert_irqs_disabled();
 
 	/* Kernel threads aren't supposed to go to userspace */
@@ -471,8 +472,8 @@ void noinstr __ct_user_enter(enum ctx_state state)
 	if (!context_tracking_recursion_enter())
 		return;
 
-	if ( __this_cpu_read(context_tracking.state) != state) {
-		if (__this_cpu_read(context_tracking.active)) {
+	if (__ct_state() != state) {
+		if (ct->active) {
 			/*
 			 * At this stage, only low level arch entry code remains and
 			 * then we'll run in userspace. We can assume there won't be
@@ -513,7 +514,7 @@ void noinstr __ct_user_enter(enum ctx_state state)
 		 * OTOH we can spare the calls to vtime and RCU when context_tracking.active
 		 * is false because we know that CPU is not tickless.
 		 */
-		__this_cpu_write(context_tracking.state, state);
+		atomic_set(&ct->state, state);
 	}
 	context_tracking_recursion_exit();
 }
@@ -581,11 +582,13 @@ NOKPROBE_SYMBOL(user_enter_callable);
  */
 void noinstr __ct_user_exit(enum ctx_state state)
 {
+	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
+
 	if (!context_tracking_recursion_enter())
 		return;
 
-	if (__this_cpu_read(context_tracking.state) == state) {
-		if (__this_cpu_read(context_tracking.active)) {
+	if (__ct_state() == state) {
+		if (ct->active) {
 			/*
 			 * Exit RCU idle mode while entering the kernel because it can
 			 * run a RCU read side critical section anytime.
@@ -598,7 +601,7 @@ void noinstr __ct_user_exit(enum ctx_state state)
 				instrumentation_end();
 			}
 		}
-		__this_cpu_write(context_tracking.state, CONTEXT_KERNEL);
+		atomic_set(&ct->state, CONTEXT_KERNEL);
 	}
 	context_tracking_recursion_exit();
 }
-- 
2.31.1.189.g2e36527f23

