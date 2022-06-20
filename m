Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B39D5527D5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 01:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346680AbiFTXMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 19:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346822AbiFTXLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 19:11:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EDF2613E;
        Mon, 20 Jun 2022 16:10:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98B0EB81213;
        Mon, 20 Jun 2022 23:10:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8A6C341D4;
        Mon, 20 Jun 2022 23:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655766632;
        bh=23nB7ajTFW78bIbwshi6o8yum8ua3pcV5XlbBQQNSC4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qaUlGOjzgIO5d1ozOafOsuWFdNy+cb+mdKnd72PXWcAI2nc9Mwldtf+O2SaqTzk2R
         MkyhS4AbCe1bISJgR0DUvPIjdPyl0fpS731dd9XTddxJqUadpQ+R+n1CLa6bPmnj66
         iiZ8K4duTD150J1ywxxEEBNSTt1w25GQe76Wi/L/AfFSPhyRyi0SxYBtjSJsPL6qSS
         PBNiZI0QOc95vJCXGrIUfzj+3nIt+HuqE0Q4s1wmHaiBmr7bwc0TplomoBQ3z8E6PC
         ySw57rLlr06kvpX8RwynNSJ4btunZTRDLisM573R41K4IquWtsS756R+lpoed/gakr
         EAPldSEl6JFCg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 588FD5C0BCC; Mon, 20 Jun 2022 16:10:31 -0700 (PDT)
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
Subject: [PATCH rcu 07/23] context_tracking: Rename context_tracking_enter/exit() to ct_user_enter/exit()
Date:   Mon, 20 Jun 2022 16:10:13 -0700
Message-Id: <20220620231029.3844583-7-paulmck@kernel.org>
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
---
 include/linux/context_tracking.h | 13 +++++++------
 kernel/context_tracking.c        | 12 ++++++------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index 69532cd18f72c..7a5f04ae1758f 100644
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
index 9d4a872ca92c4..87454e3515546 100644
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
2.31.1.189.g2e36527f23

