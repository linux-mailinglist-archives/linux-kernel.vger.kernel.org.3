Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852CD52D6A1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 16:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240138AbiESO70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 10:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240113AbiESO7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 10:59:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C03D9E86
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 07:58:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C1CE61A21
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 14:58:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F594C34116;
        Thu, 19 May 2022 14:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652972333;
        bh=VbESeDYHIHGEyPhJM9sQpDnZacs3e6ZczXrBfGPfyQk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VFdDj7D76tjutOp61jUSG/5axm8fSTtaPYweayRga+2E7CsS3bt+9fjUFCs/4Lxof
         QNRDis1+NYMGkv//iimjpaU7RL7Zc3dIBiZJiKhH9BKmQSNa0kP/rBtZ5cDW0uzjje
         h+dXj772czZ048yo1YxSQJIdGZYfTm0E+7/XcCwZ3E/RwaqfcH8fuHDtLeiFmiP459
         4xytl4auIe57Oa88iL0fQ6DJqmktTTv6hE+n7jEe/hTcI7Y0/jP5bMKHCcTk/Ftf6V
         /6VOzRFQakZBhP3v1RE5qWHYxtYKi8zJIUWsTPmvvavSw5eqleNq0dk4vsCUML2kMp
         Xvzj/GApTbnTA==
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
Subject: [PATCH 06/21] context_tracking: Rename context_tracking_enter/exit() to ct_user_enter/exit()
Date:   Thu, 19 May 2022 16:58:08 +0200
Message-Id: <20220519145823.618983-7-frederic@kernel.org>
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

context_tracking_enter() and context_tracking_exit() have confusing
names that don't explain the fact they are referring to user/guest state.

Use more self-explanatory names and shrink to the new context tracking
prefix instead.

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
 include/linux/context_tracking.h | 13 +++++++------
 kernel/context_tracking.c        | 12 ++++++------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index 69532cd18f72..7a5f04ae1758 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -17,21 +17,22 @@ extern void context_tracking_cpu_set(int cpu);
 extern void __ct_user_enter(enum ctx_state state);
 extern void __ct_user_exit(enum ctx_state state);
 
-extern void context_tracking_enter(enum ctx_state state);
-extern void context_tracking_exit(enum ctx_state state);
+extern void ct_user_enter(enum ctx_state state);
+extern void ct_user_exit(enum ctx_state state);
+
 extern void user_enter_callable(void);
 extern void user_exit_callable(void);
 
 static inline void user_enter(void)
 {
 	if (context_tracking_enabled())
-		context_tracking_enter(CONTEXT_USER);
+		ct_user_enter(CONTEXT_USER);
 
 }
 static inline void user_exit(void)
 {
 	if (context_tracking_enabled())
-		context_tracking_exit(CONTEXT_USER);
+		ct_user_exit(CONTEXT_USER);
 }
 
 /* Called with interrupts disabled.  */
@@ -57,7 +58,7 @@ static inline enum ctx_state exception_enter(void)
 
 	prev_ctx = this_cpu_read(context_tracking.state);
 	if (prev_ctx != CONTEXT_KERNEL)
-		context_tracking_exit(prev_ctx);
+		ct_user_exit(prev_ctx);
 
 	return prev_ctx;
 }
@@ -67,7 +68,7 @@ static inline void exception_exit(enum ctx_state prev_ctx)
 	if (!IS_ENABLED(CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK) &&
 	    context_tracking_enabled()) {
 		if (prev_ctx != CONTEXT_KERNEL)
-			context_tracking_enter(prev_ctx);
+			ct_user_enter(prev_ctx);
 	}
 }
 
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index e4e7aad6c2bc..bfbc5d846a62 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -108,7 +108,7 @@ EXPORT_SYMBOL_GPL(__ct_user_enter);
  * unsafe because it involves illegal RCU uses through tracing and lockdep. This
  * must be fixed first.
  */
-void context_tracking_enter(enum ctx_state state)
+void ct_user_enter(enum ctx_state state)
 {
 	unsigned long flags;
 
@@ -127,8 +127,8 @@ void context_tracking_enter(enum ctx_state state)
 	__ct_user_enter(state);
 	local_irq_restore(flags);
 }
-NOKPROBE_SYMBOL(context_tracking_enter);
-EXPORT_SYMBOL_GPL(context_tracking_enter);
+NOKPROBE_SYMBOL(ct_user_enter);
+EXPORT_SYMBOL_GPL(ct_user_enter);
 
 /**
  * user_enter_callable() - Unfortunate ASM callable version of user_enter() for
@@ -186,7 +186,7 @@ EXPORT_SYMBOL_GPL(__ct_user_exit);
  * unsafe because it involves illegal RCU uses through tracing and lockdep. This
  * must be fixed first.
  */
-void context_tracking_exit(enum ctx_state state)
+void ct_user_exit(enum ctx_state state)
 {
 	unsigned long flags;
 
@@ -197,8 +197,8 @@ void context_tracking_exit(enum ctx_state state)
 	__ct_user_exit(state);
 	local_irq_restore(flags);
 }
-NOKPROBE_SYMBOL(context_tracking_exit);
-EXPORT_SYMBOL_GPL(context_tracking_exit);
+NOKPROBE_SYMBOL(ct_user_exit);
+EXPORT_SYMBOL_GPL(ct_user_exit);
 
 /**
  * user_exit_callable() - Unfortunate ASM callable version of user_exit() for
-- 
2.25.1

