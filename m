Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39E54CA97A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 16:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240990AbiCBPtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 10:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240739AbiCBPtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 10:49:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624AE28992
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 07:48:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B507B82082
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 15:48:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 995BFC340ED;
        Wed,  2 Mar 2022 15:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646236104;
        bh=xdaFWjEPuZZ7+O1T/pWENcxRLDLAM4Um3CNcb2LkEbM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PMa3KGaRCHoapiIry4hesvZv+djJ4pqgxEX7ey67y9R4tpzGS5PBCkEAJtqc6G0C6
         L9tTHPwiYoZBVFGUfUvP2I4W+xoTje7eej2JD459RaU5LSlAIAnKVf4tMhj99pfifs
         zEm2xbjziErlN3Qe6cqeNUDsToJM62L4NEMQznEJo6lrw9NOrJydE92tzKlqGEYxXI
         oZvjdW9t3uXcOhn2SOaJLKYgYKoJWuO5DMvU0I2LYqWHrbZ19e7XFuLEkpwboR2IRK
         2MkZFTzEFvaCzYaywC/19mJ4xgNDzs9ytWXEKiwtcCiQc7C8cSNnBINa1JzrXXepql
         rhRB2c7TyL5qA==
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
Subject: [PATCH 02/19] context_tracking: Rename context_tracking_user_enter/exit() to user_enter/exit_callable()
Date:   Wed,  2 Mar 2022 16:47:53 +0100
Message-Id: <20220302154810.42308-3-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220302154810.42308-1-frederic@kernel.org>
References: <20220302154810.42308-1-frederic@kernel.org>
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
 kernel/context_tracking.c        | 18 ++++++++++++++----
 5 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index ae24dd54e9ef..3af2a521e1d6 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -364,10 +364,10 @@
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
@@ -376,10 +376,10 @@
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
index ed29e9c8f660..5fbaa7be18a2 100644
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
 
@@ -252,7 +252,7 @@ resume_userspace:
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
index ad2a973393a6..83e050675b23 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -125,11 +125,16 @@ void context_tracking_enter(enum ctx_state state)
 NOKPROBE_SYMBOL(context_tracking_enter);
 EXPORT_SYMBOL_GPL(context_tracking_enter);
 
-void context_tracking_user_enter(void)
+/**
+ * user_enter_callable() - Unfortunate ASM callable version of user_enter() for
+ * 			   archs that didn't manage to check the context tracking
+ * 			   static key from low level code.
+ */
+void user_enter_callable(void)
 {
 	user_enter();
 }
-NOKPROBE_SYMBOL(context_tracking_user_enter);
+NOKPROBE_SYMBOL(user_enter_callable);
 
 /**
  * __ct_user_exit - Inform the context tracking that the CPU is
@@ -182,11 +187,16 @@ void context_tracking_exit(enum ctx_state state)
 NOKPROBE_SYMBOL(context_tracking_exit);
 EXPORT_SYMBOL_GPL(context_tracking_exit);
 
-void context_tracking_user_exit(void)
+/**
+ * user_exit_callable() - Unfortunate ASM callable version of user_exit() for
+ * 			  archs that didn't manage to check the context tracking
+ * 			  static key from low level code.
+ */
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

