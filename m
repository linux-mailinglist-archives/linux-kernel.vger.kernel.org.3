Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298B95432DC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 16:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241802AbiFHOmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 10:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242030AbiFHOmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 10:42:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3C41AFACB
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 07:41:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94492B827F3
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 14:41:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BBE9C341C4;
        Wed,  8 Jun 2022 14:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654699310;
        bh=7cRn/Fj9tWxbW/Il7XA+vQwNrK/qxuPSHeS31wD8ijA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mo3U8vk1fLJBkZ1I6U59rrYHlnd8CYEZkmY9NwZU69CrEQ5Z+yth03zTSIxBI73Bb
         6WGKZ4t8B0J5/TC2x3K6MU8AFXMj197NRqJz7pDXrLRISgUSsD4M96pNYXliPcFD9K
         uAQUvCW+cl7+t7uJOVI6DpW6nhDUeUz6QD9g2QBitSP66Ucyvu+5ycOf0jEUEabGKT
         QFKuAsYmqtCZiE6GLHrz0QiIfPnyI4Tc30/7DKe6Z681vxowtFeSgNAWyc9Sx6onQE
         cGTEzRee5wtWAeM+K2xuhxF/6Q/r3ipC8iOrQb/FEH7/w2m4rnscoha+L9lI6qan8l
         obG4tffq5AMFQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu Liao <liaoyu15@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 18/20] context_tracking: Convert state to atomic_t
Date:   Wed,  8 Jun 2022 16:40:35 +0200
Message-Id: <20220608144037.1765000-19-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220608144037.1765000-1-frederic@kernel.org>
References: <20220608144037.1765000-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Context tracking's state and dynticks counter are going to be merged
in a single field so that both updates can happen atomically and at the
same time. Prepare for that with converting the state into an atomic_t.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc: Yu Liao<liaoyu15@huawei.com>
Cc: Phil Auld <pauld@redhat.com>
Cc: Paul Gortmaker<paul.gortmaker@windriver.com>
Cc: Alex Belits <abelits@marvell.com>
---
 include/linux/context_tracking.h       | 24 ++++------------
 include/linux/context_tracking_state.h | 40 ++++++++++++++++++++++----
 kernel/context_tracking.c              | 15 ++++++----
 3 files changed, 49 insertions(+), 30 deletions(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index 1f568676bc1d..a8c1db0a3f65 100644
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
index b99e9827cc08..1501df6d4cfa 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -9,6 +9,13 @@
 /* Offset to allow distinguishing irq vs. task-based idle entry/exit. */
 #define DYNTICK_IRQ_NONIDLE	((LONG_MAX / 2) + 1)
 
+enum ctx_state {
+	CONTEXT_DISABLED = -1,	/* returned by ct_state() if unknown */
+	CONTEXT_KERNEL = 0,
+	CONTEXT_USER,
+	CONTEXT_GUEST,
+};
+
 struct context_tracking {
 #ifdef CONFIG_CONTEXT_TRACKING_USER
 	/*
@@ -19,12 +26,7 @@ struct context_tracking {
 	 */
 	bool active;
 	int recursion;
-	enum ctx_state {
-		CONTEXT_DISABLED = -1,	/* returned by ct_state() if unknown */
-		CONTEXT_KERNEL = 0,
-		CONTEXT_USER,
-		CONTEXT_GUEST,
-	} state;
+	atomic_t state;
 #endif
 #ifdef CONFIG_CONTEXT_TRACKING_IDLE
 	atomic_t dynticks;		/* Even value for idle, else odd. */
@@ -96,6 +98,32 @@ static inline bool context_tracking_enabled_this_cpu(void)
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
 static inline bool context_tracking_enabled(void) { return false; }
 static inline bool context_tracking_enabled_cpu(int cpu) { return false; }
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 3e93a9a93a84..810bca217151 100644
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
@@ -582,11 +583,13 @@ NOKPROBE_SYMBOL(user_enter_callable);
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
@@ -599,7 +602,7 @@ void noinstr __ct_user_exit(enum ctx_state state)
 				instrumentation_end();
 			}
 		}
-		__this_cpu_write(context_tracking.state, CONTEXT_KERNEL);
+		atomic_set(&ct->state, CONTEXT_KERNEL);
 	}
 	context_tracking_recursion_exit();
 }
-- 
2.25.1

