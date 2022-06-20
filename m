Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBEEC5527DC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 01:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346492AbiFTXMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 19:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245682AbiFTXLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 19:11:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5BE2611E;
        Mon, 20 Jun 2022 16:10:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CF40614DF;
        Mon, 20 Jun 2022 23:10:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2732C341C5;
        Mon, 20 Jun 2022 23:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655766631;
        bh=jyKzInLCGfGE6kjpqCH9px1pTWGwep4tsb1DYTRrcV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K4GMK53BeskJ2T2AJmQqaLY15iKZk3aH+9z0mrrBe+r/JQD9wyF/C1c7bx5oBrAEv
         nzLTkAn762PP/OTdbXyEs+MMrxCBMil2aZXBWtt6VCGiSXrJWxwa2YmzYuZ1+KldLK
         g2Q4Qsa+SCCd39aoIC9HS1+BmflQFe/GfzXKCks93EaQG8a8XhJWildU9HiTmJYbFR
         EE8uZM11Df9W/IE+ZTpW9Yd0TN+NQHBOekQNkabnTHIJuOQarQaWutsobZUvfXKP2Y
         Fxta4A+PfQ3J9fHMGmKMgHT72UJHucPoKcpH14w4yB7eMzJOnwjprqwHHP3mwNrRwf
         H3uLBVl94Bp2Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 51E8B5C0A33; Mon, 20 Jun 2022 16:10:31 -0700 (PDT)
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
Subject: [PATCH rcu 04/23] context_tracking: Add a note about noinstr VS unsafe context tracking functions
Date:   Mon, 20 Jun 2022 16:10:10 -0700
Message-Id: <20220620231029.3844583-4-paulmck@kernel.org>
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

Some context tracking functions enter or exit into/from RCU idle mode
while using trace-able and lockdep-aware IRQs (un-)masking. As a result
those functions can't get tagged as noinstr. This is unlikely to be
fixed since these are obsolete APIs. Drop a note about this matter.

[ paulmck: Apply Peter Zijlstra feedback. ]

Reported-by: Peter Zijlstra <peterz@infradead.org>
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
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/context_tracking.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 36a98c48aedc7..3082332f64765 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -103,6 +103,15 @@ void noinstr __context_tracking_enter(enum ctx_state state)
 }
 EXPORT_SYMBOL_GPL(__context_tracking_enter);
 
+/*
+ * OBSOLETE:
+ * This function should be noinstr but the below local_irq_restore() is
+ * unsafe because it involves illegal RCU uses through tracing and lockdep.
+ * This is unlikely to be fixed as this function is obsolete. The preferred
+ * way is to call __context_tracking_enter() through user_enter_irqoff()
+ * or context_tracking_guest_enter(). It should be the arch entry code
+ * responsibility to call into context tracking with IRQs disabled.
+ */
 void context_tracking_enter(enum ctx_state state)
 {
 	unsigned long flags;
@@ -125,6 +134,14 @@ void context_tracking_enter(enum ctx_state state)
 NOKPROBE_SYMBOL(context_tracking_enter);
 EXPORT_SYMBOL_GPL(context_tracking_enter);
 
+/*
+ * OBSOLETE:
+ * This function should be noinstr but it unsafely calls local_irq_restore(),
+ * involving illegal RCU uses through tracing and lockdep.
+ * This is unlikely to be fixed as this function is obsolete. The preferred
+ * way is to call user_enter_irqoff(). It should be the arch entry code
+ * responsibility to call into context tracking with IRQs disabled.
+ */
 void context_tracking_user_enter(void)
 {
 	user_enter();
@@ -168,6 +185,15 @@ void noinstr __context_tracking_exit(enum ctx_state state)
 }
 EXPORT_SYMBOL_GPL(__context_tracking_exit);
 
+/*
+ * OBSOLETE:
+ * This function should be noinstr but the below local_irq_save() is
+ * unsafe because it involves illegal RCU uses through tracing and lockdep.
+ * This is unlikely to be fixed as this function is obsolete. The preferred
+ * way is to call __context_tracking_exit() through user_exit_irqoff()
+ * or context_tracking_guest_exit(). It should be the arch entry code
+ * responsibility to call into context tracking with IRQs disabled.
+ */
 void context_tracking_exit(enum ctx_state state)
 {
 	unsigned long flags;
@@ -182,6 +208,14 @@ void context_tracking_exit(enum ctx_state state)
 NOKPROBE_SYMBOL(context_tracking_exit);
 EXPORT_SYMBOL_GPL(context_tracking_exit);
 
+/*
+ * OBSOLETE:
+ * This function should be noinstr but it unsafely calls local_irq_save(),
+ * involving illegal RCU uses through tracing and lockdep. This is unlikely
+ * to be fixed as this function is obsolete. The preferred way is to call
+ * user_exit_irqoff(). It should be the arch entry code responsibility to
+ * call into context tracking with IRQs disabled.
+ */
 void context_tracking_user_exit(void)
 {
 	user_exit();
-- 
2.31.1.189.g2e36527f23

