Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806EF55E443
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346280AbiF1NRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346181AbiF1NQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:16:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E3631506
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:16:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EE7E61772
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 13:16:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB95C3411D;
        Tue, 28 Jun 2022 13:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656422200;
        bh=UWLh02OpnQOZ2d4ib+RW33PZK/HTKO5gxdSPfiYDQ1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TK8zbgmxlWDjyzd1XwuznbEAKdlkoMUm3zU3eVYKD6gbro+qhyCmAQ1fJlf5lvkQe
         0ldReeqAUXevGQ+TaTScpWo9mhRsHvuW0rUZYms6PxY1gSbNO1EZQ1aMyw78wNZJYl
         5/9Wqzk0rbLjcHP+mOcHKFzJ05MAdrk7Fmp2NeuznIEEM3sFc6emd9ZO67vtI4FkTY
         Gvk0BYnCtn0Ck6o1rMWxL6WWWf2s6WVSQ/EqZhL1usmCRys1izuQHsMRTA52x5n+3q
         3xZID/42TMEBl960Cu//PXpoYhPJIsW6nHa1OAioau8UXwNKN8kXVCwgm+y3VifVpK
         /f1TuI9FLpW0w==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Marco Elver <elver@google.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Yu Liao <liaoyu15@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        kernel test robot <lkp@intel.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 03/20] context_tracking: Rename __context_tracking_enter/exit() to __ct_user_enter/exit()
Date:   Tue, 28 Jun 2022 15:16:02 +0200
Message-Id: <20220628131619.2109651-4-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220628131619.2109651-1-frederic@kernel.org>
References: <20220628131619.2109651-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The context tracking namespace is going to expand and some new functions
will require even longer names. Start shrinking the context_tracking
prefix to "ct" as is already the case for some existing macros, this
will make the introduction of new functions easier.

Acked-by: Paul E. McKenney <paulmck@kernel.org>
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
Reviewed-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
Tested-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---
 include/linux/context_tracking.h | 12 ++++++------
 kernel/context_tracking.c        | 20 ++++++++++----------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index 7a14807c9d1a..773035124bad 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -14,8 +14,8 @@
 extern void context_tracking_cpu_set(int cpu);
 
 /* Called with interrupts disabled.  */
-extern void __context_tracking_enter(enum ctx_state state);
-extern void __context_tracking_exit(enum ctx_state state);
+extern void __ct_user_enter(enum ctx_state state);
+extern void __ct_user_exit(enum ctx_state state);
 
 extern void context_tracking_enter(enum ctx_state state);
 extern void context_tracking_exit(enum ctx_state state);
@@ -38,13 +38,13 @@ static inline void user_exit(void)
 static __always_inline void user_enter_irqoff(void)
 {
 	if (context_tracking_enabled())
-		__context_tracking_enter(CONTEXT_USER);
+		__ct_user_enter(CONTEXT_USER);
 
 }
 static __always_inline void user_exit_irqoff(void)
 {
 	if (context_tracking_enabled())
-		__context_tracking_exit(CONTEXT_USER);
+		__ct_user_exit(CONTEXT_USER);
 }
 
 static inline enum ctx_state exception_enter(void)
@@ -74,7 +74,7 @@ static inline void exception_exit(enum ctx_state prev_ctx)
 static __always_inline bool context_tracking_guest_enter(void)
 {
 	if (context_tracking_enabled())
-		__context_tracking_enter(CONTEXT_GUEST);
+		__ct_user_enter(CONTEXT_GUEST);
 
 	return context_tracking_enabled_this_cpu();
 }
@@ -82,7 +82,7 @@ static __always_inline bool context_tracking_guest_enter(void)
 static __always_inline void context_tracking_guest_exit(void)
 {
 	if (context_tracking_enabled())
-		__context_tracking_exit(CONTEXT_GUEST);
+		__ct_user_exit(CONTEXT_GUEST);
 }
 
 /**
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 3082332f6476..88c60ab39fbb 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -51,15 +51,15 @@ static __always_inline void context_tracking_recursion_exit(void)
 }
 
 /**
- * context_tracking_enter - Inform the context tracking that the CPU is going
- *                          enter user or guest space mode.
+ * __ct_user_enter - Inform the context tracking that the CPU is going
+ *		     to enter user or guest space mode.
  *
  * This function must be called right before we switch from the kernel
  * to user or guest space, when it's guaranteed the remaining kernel
  * instructions to execute won't use any RCU read side critical section
  * because this function sets RCU in extended quiescent state.
  */
-void noinstr __context_tracking_enter(enum ctx_state state)
+void noinstr __ct_user_enter(enum ctx_state state)
 {
 	/* Kernel threads aren't supposed to go to userspace */
 	WARN_ON_ONCE(!current->mm);
@@ -101,7 +101,7 @@ void noinstr __context_tracking_enter(enum ctx_state state)
 	}
 	context_tracking_recursion_exit();
 }
-EXPORT_SYMBOL_GPL(__context_tracking_enter);
+EXPORT_SYMBOL_GPL(__ct_user_enter);
 
 /*
  * OBSOLETE:
@@ -128,7 +128,7 @@ void context_tracking_enter(enum ctx_state state)
 		return;
 
 	local_irq_save(flags);
-	__context_tracking_enter(state);
+	__ct_user_enter(state);
 	local_irq_restore(flags);
 }
 NOKPROBE_SYMBOL(context_tracking_enter);
@@ -149,8 +149,8 @@ void context_tracking_user_enter(void)
 NOKPROBE_SYMBOL(context_tracking_user_enter);
 
 /**
- * context_tracking_exit - Inform the context tracking that the CPU is
- *                         exiting user or guest mode and entering the kernel.
+ * __ct_user_exit - Inform the context tracking that the CPU is
+ *		    exiting user or guest mode and entering the kernel.
  *
  * This function must be called after we entered the kernel from user or
  * guest space before any use of RCU read side critical section. This
@@ -160,7 +160,7 @@ NOKPROBE_SYMBOL(context_tracking_user_enter);
  * This call supports re-entrancy. This way it can be called from any exception
  * handler without needing to know if we came from userspace or not.
  */
-void noinstr __context_tracking_exit(enum ctx_state state)
+void noinstr __ct_user_exit(enum ctx_state state)
 {
 	if (!context_tracking_recursion_enter())
 		return;
@@ -183,7 +183,7 @@ void noinstr __context_tracking_exit(enum ctx_state state)
 	}
 	context_tracking_recursion_exit();
 }
-EXPORT_SYMBOL_GPL(__context_tracking_exit);
+EXPORT_SYMBOL_GPL(__ct_user_exit);
 
 /*
  * OBSOLETE:
@@ -202,7 +202,7 @@ void context_tracking_exit(enum ctx_state state)
 		return;
 
 	local_irq_save(flags);
-	__context_tracking_exit(state);
+	__ct_user_exit(state);
 	local_irq_restore(flags);
 }
 NOKPROBE_SYMBOL(context_tracking_exit);
-- 
2.25.1

