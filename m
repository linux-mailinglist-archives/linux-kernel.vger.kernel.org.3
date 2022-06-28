Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93DD455E450
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346142AbiF1NSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346237AbiF1NQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:16:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CC2313A0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:16:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58E0AB81E17
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 13:16:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4717FC341CB;
        Tue, 28 Jun 2022 13:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656422209;
        bh=tnqPqA2oD4BjlAaPLdbcLMOT3lL0ZYNCbAEtnt8Wmq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LXHd/SzIaLQsYL2YUaMPnCxLWhRwMXCtgofzrgt3ZNIewoQG3LEMnZyLXhA4xj3yI
         5iPhVMrh/poyGnRX+hX/q9PWM3Ad4Lc23SvUMOm+/pBZvhmQ9mV5LlAiSwQaSIAfr8
         XEyDHURWnP3Z+cq2tjSSpY6U8VsHO+zY1ou7W8wC+L5DvHVCXmlcbw10NY3DSdU1rh
         DhVWPEagcqB0+pWbWHmZLuUNQfbDvqrWdEaSNf+DBegsIMMaSdZvJwvbX+K4FEbSQY
         GVgQbmMij7qVi0t+7p8owovaz6OZ/rATlk+EMmvfdfVqgjMXsXcIfcsStlSV79YuVR
         s+QTUEOdDEUig==
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
Subject: [PATCH 05/20] context_tracking: Rename context_tracking_enter/exit() to ct_user_enter/exit()
Date:   Tue, 28 Jun 2022 15:16:04 +0200
Message-Id: <20220628131619.2109651-6-frederic@kernel.org>
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

context_tracking_enter() and context_tracking_exit() have confusing
names that don't explain the fact they are referring to user/guest state.

Use more self-explanatory names and shrink to the new context tracking
prefix instead.

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
index 8f7dd5799bda..590c920ad57f 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -112,7 +112,7 @@ EXPORT_SYMBOL_GPL(__ct_user_enter);
  * or context_tracking_guest_enter(). It should be the arch entry code
  * responsibility to call into context tracking with IRQs disabled.
  */
-void context_tracking_enter(enum ctx_state state)
+void ct_user_enter(enum ctx_state state)
 {
 	unsigned long flags;
 
@@ -131,8 +131,8 @@ void context_tracking_enter(enum ctx_state state)
 	__ct_user_enter(state);
 	local_irq_restore(flags);
 }
-NOKPROBE_SYMBOL(context_tracking_enter);
-EXPORT_SYMBOL_GPL(context_tracking_enter);
+NOKPROBE_SYMBOL(ct_user_enter);
+EXPORT_SYMBOL_GPL(ct_user_enter);
 
 /**
  * user_enter_callable() - Unfortunate ASM callable version of user_enter() for
@@ -197,7 +197,7 @@ EXPORT_SYMBOL_GPL(__ct_user_exit);
  * or context_tracking_guest_exit(). It should be the arch entry code
  * responsibility to call into context tracking with IRQs disabled.
  */
-void context_tracking_exit(enum ctx_state state)
+void ct_user_exit(enum ctx_state state)
 {
 	unsigned long flags;
 
@@ -208,8 +208,8 @@ void context_tracking_exit(enum ctx_state state)
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

