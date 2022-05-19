Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F7F52D697
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 16:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240107AbiESO7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 10:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240085AbiESO6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 10:58:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B46AD809D
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 07:58:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51850B8235B
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 14:58:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C433DC34117;
        Thu, 19 May 2022 14:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652972330;
        bh=Ez/muF9+kjJrmlCOLg5f0MjmhahBJ1sWlDpnRqsrmKg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qSMJssJQUH8FPhYY8G1KHQy8NC3dAVyznjot4OJ/yXnANY3PaZEV+oc1IycR+TNz7
         VrmxBOyGT4ArxHNT4sntSwI+8q1CnQXV0nj63qVGalgjhJv5rAFhVOIHhwrJA0XceK
         X0iat5GLrPAq/v/F4X+t6P/VetdA66I2RDmo1OvImYzJyifApqTMe//PMM5fX0OLP5
         3vmKLb0+ZBqwI7tYunZ87jw34QsytQ4NouQMwxAxreiZIG1yA/m9of3yH0LXoxPywT
         GF4mu1jJdcI0rHknW64pK9rR8fHngTi/ESmRJ8dmnjTSVs/6ubpDLLo4gxQFwBze8s
         1dDCwY2x3v5FQ==
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
        Joel Fernandes <joel@joelfernandes.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 05/21] context_tracking: Rename context_tracking_user_enter/exit() to user_enter/exit_callable()
Date:   Thu, 19 May 2022 16:58:07 +0200
Message-Id: <20220519145823.618983-6-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220519145823.618983-1-frederic@kernel.org>
References: <20220519145823.618983-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

context_tracking_user_enter() and context_tracking_user_exit() are
ASM callable versions of user_enter() and user_exit() for architectures
that didn't manage to check the context tracking static key from ASM.
Change those function names to better reflect their purpose.

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
 arch/arm/kernel/entry-header.S   |  8 ++++----
 arch/csky/kernel/entry.S         |  4 ++--
 arch/riscv/kernel/entry.S        |  6 +++---
 include/linux/context_tracking.h |  4 ++--
 kernel/context_tracking.c        | 20 ++++++++++++++------
 5 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index 9a1dc142f782..0c14dcc43e58 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -370,10 +370,10 @@ ALT_UP_B(.L1_\@)
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
@@ -382,10 +382,10 @@ ALT_UP_B(.L1_\@)
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
index a4ababf25e24..bc734d17c16f 100644
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
index c8b9ce274b9a..ecd132af2edf 100644
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
 
@@ -256,7 +256,7 @@ resume_userspace:
 	bnez s1, work_pending
 
 #ifdef CONFIG_CONTEXT_TRACKING
-	call context_tracking_user_enter
+	call user_enter_callable
 #endif
 
 	/* Save unwound kernel stack pointer in thread_info */
diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index 773035124bad..69532cd18f72 100644
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
index 554c2c9587eb..e4e7aad6c2bc 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -130,15 +130,19 @@ void context_tracking_enter(enum ctx_state state)
 NOKPROBE_SYMBOL(context_tracking_enter);
 EXPORT_SYMBOL_GPL(context_tracking_enter);
 
-/*
+/**
+ * user_enter_callable() - Unfortunate ASM callable version of user_enter() for
+ * 			   archs that didn't manage to check the context tracking
+ * 			   static key from low level code.
+ *
  * FIXME: This function should be noinstr but it unsafely calls local_irq_restore(),
  * involving illegal RCU uses through tracing and lockdep. This must be fixed first.
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
@@ -196,15 +200,19 @@ void context_tracking_exit(enum ctx_state state)
 NOKPROBE_SYMBOL(context_tracking_exit);
 EXPORT_SYMBOL_GPL(context_tracking_exit);
 
-/*
+/**
+ * user_exit_callable() - Unfortunate ASM callable version of user_exit() for
+ * 			  archs that didn't manage to check the context tracking
+ * 			  static key from low level code.
+ *
  * FIXME: This function should be noinstr but it unsafely calls local_irq_save(),
  * involving illegal RCU uses through tracing and lockdep. This must be fixed first.
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
2.25.1

