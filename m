Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5595527E0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 01:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241099AbiFTXMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 19:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346758AbiFTXLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 19:11:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E32B26124;
        Mon, 20 Jun 2022 16:10:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDB7661500;
        Mon, 20 Jun 2022 23:10:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E6EC341CE;
        Mon, 20 Jun 2022 23:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655766632;
        bh=KtHjEpf1/cXjxzwYm5DHi+7YCN/waSSuMPLxua1t+1A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZQbA+gwBjoSE4v4P3VausRMgyZCW++aiavo3foW0jVxOFPGMZl68MBf2hMB8kLfro
         Qi3yMukrzKYhkHUooecXgd2z7/gh+JYCupzRSAELwyZD3AE4AIOS+nygThJ6hRq8Ml
         Pv/YplGFxanA9acxji++eyyK6YrH41LTbiwWDDDje76cYzGwtL8PTbjYbuy7+ccFE1
         kt+GUTt+/DF2dgWB7TD7eJVWgxoUmRZV9sipA2hVX/ncLpUewmvZI7/23+4fU8Kdtj
         YNIaSOLnRdyC1SJMOLYwVV1GdJ7qhaEW6UP30QRI5iMqW2ZAiBZPEyyfba7Zz/PRQI
         vp9iIsvzSxOYA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 563015C0B06; Mon, 20 Jun 2022 16:10:31 -0700 (PDT)
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
Subject: [PATCH rcu 06/23] context_tracking: Rename context_tracking_user_enter/exit() to user_enter/exit_callable()
Date:   Mon, 20 Jun 2022 16:10:12 -0700
Message-Id: <20220620231029.3844583-6-paulmck@kernel.org>
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

context_tracking_user_enter() and context_tracking_user_exit() are
ASM callable versions of user_enter() and user_exit() for architectures
that didn't manage to check the context tracking static key from ASM.
Change those function names to better reflect their purpose.

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
 arch/arm/kernel/entry-header.S   |  8 ++++----
 arch/csky/kernel/entry.S         |  4 ++--
 arch/riscv/kernel/entry.S        |  6 +++---
 include/linux/context_tracking.h |  4 ++--
 kernel/context_tracking.c        | 28 +++++++++++++++++-----------
 5 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index 5865621bf6912..95def2b38d1ca 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -369,10 +369,10 @@ ALT_UP_B(.L1_\@)
 #ifdef CONFIG_CONTEXT_TRACKING
 	.if	\save
 	stmdb   sp!, {r0-r3, ip, lr}
-	bl	context_tracking_user_exit
+	bl	user_exit_callable
 	ldmia	sp!, {r0-r3, ip, lr}
 	.else
-	bl	context_tracking_user_exit
+	bl	user_exit_callable
 	.endif
 #endif
 	.endm
@@ -381,10 +381,10 @@ ALT_UP_B(.L1_\@)
 #ifdef CONFIG_CONTEXT_TRACKING
 	.if	\save
 	stmdb   sp!, {r0-r3, ip, lr}
-	bl	context_tracking_user_enter
+	bl	user_enter_callable
 	ldmia	sp!, {r0-r3, ip, lr}
 	.else
-	bl	context_tracking_user_enter
+	bl	user_enter_callable
 	.endif
 #endif
 	.endm
diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
index a4ababf25e243..bc734d17c16f4 100644
--- a/arch/csky/kernel/entry.S
+++ b/arch/csky/kernel/entry.S
@@ -23,7 +23,7 @@
 	mfcr	a0, epsr
 	btsti	a0, 31
 	bt	1f
-	jbsr	context_tracking_user_exit
+	jbsr	user_exit_callable
 	ldw	a0, (sp, LSAVE_A0)
 	ldw	a1, (sp, LSAVE_A1)
 	ldw	a2, (sp, LSAVE_A2)
@@ -160,7 +160,7 @@ ret_from_exception:
 	cmpnei	r10, 0
 	bt	exit_work
 #ifdef CONFIG_CONTEXT_TRACKING
-	jbsr	context_tracking_user_enter
+	jbsr	user_enter_callable
 #endif
 1:
 #ifdef CONFIG_PREEMPTION
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 2e5b88ca11ce1..12f6bba57e335 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -112,11 +112,11 @@ _save_context:
 #endif
 
 #ifdef CONFIG_CONTEXT_TRACKING
-	/* If previous state is in user mode, call context_tracking_user_exit. */
+	/* If previous state is in user mode, call user_exit_callable(). */
 	li   a0, SR_PP
 	and a0, s1, a0
 	bnez a0, skip_context_tracking
-	call context_tracking_user_exit
+	call user_exit_callable
 skip_context_tracking:
 #endif
 
@@ -270,7 +270,7 @@ resume_userspace:
 	bnez s1, work_pending
 
 #ifdef CONFIG_CONTEXT_TRACKING
-	call context_tracking_user_enter
+	call user_enter_callable
 #endif
 
 	/* Save unwound kernel stack pointer in thread_info */
diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index 773035124badb..69532cd18f72c 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -19,8 +19,8 @@ extern void __ct_user_exit(enum ctx_state state);
 
 extern void context_tracking_enter(enum ctx_state state);
 extern void context_tracking_exit(enum ctx_state state);
-extern void context_tracking_user_enter(void);
-extern void context_tracking_user_exit(void);
+extern void user_enter_callable(void);
+extern void user_exit_callable(void);
 
 static inline void user_enter(void)
 {
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index e36395598095e..9d4a872ca92c4 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -134,19 +134,22 @@ void context_tracking_enter(enum ctx_state state)
 NOKPROBE_SYMBOL(context_tracking_enter);
 EXPORT_SYMBOL_GPL(context_tracking_enter);
 
-/*
- * OBSOLETE:
- * This function should be noinstr but it unsafely calls local_irq_restore(),
- * involving illegal RCU uses through tracing and lockdep.
+/**
+ * user_enter_callable() - Unfortunate ASM callable version of user_enter() for
+ * 			   archs that didn't manage to check the context tracking
+ * 			   static key from low level code.
+ *
+ * This OBSOLETE function should be noinstr but it unsafely calls
+ * local_irq_restore(), involving illegal RCU uses through tracing and lockdep.
  * This is unlikely to be fixed as this function is obsolete. The preferred
  * way is to call user_enter_irqoff(). It should be the arch entry code
  * responsibility to call into context tracking with IRQs disabled.
  */
-void context_tracking_user_enter(void)
+void user_enter_callable(void)
 {
 	user_enter();
 }
-NOKPROBE_SYMBOL(context_tracking_user_enter);
+NOKPROBE_SYMBOL(user_enter_callable);
 
 /**
  * __ct_user_exit - Inform the context tracking that the CPU is
@@ -208,19 +211,22 @@ void context_tracking_exit(enum ctx_state state)
 NOKPROBE_SYMBOL(context_tracking_exit);
 EXPORT_SYMBOL_GPL(context_tracking_exit);
 
-/*
- * OBSOLETE:
- * This function should be noinstr but it unsafely calls local_irq_save(),
+/**
+ * user_exit_callable() - Unfortunate ASM callable version of user_exit() for
+ * 			  archs that didn't manage to check the context tracking
+ * 			  static key from low level code.
+ *
+ * This OBSOLETE function should be noinstr but it unsafely calls local_irq_save(),
  * involving illegal RCU uses through tracing and lockdep. This is unlikely
  * to be fixed as this function is obsolete. The preferred way is to call
  * user_exit_irqoff(). It should be the arch entry code responsibility to
  * call into context tracking with IRQs disabled.
  */
-void context_tracking_user_exit(void)
+void user_exit_callable(void)
 {
 	user_exit();
 }
-NOKPROBE_SYMBOL(context_tracking_user_exit);
+NOKPROBE_SYMBOL(user_exit_callable);
 
 void __init context_tracking_cpu_set(int cpu)
 {
-- 
2.31.1.189.g2e36527f23

