Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967295432CF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 16:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241732AbiFHOlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 10:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241773AbiFHOlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 10:41:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2E014CDFF
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 07:40:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3ABFB61B9D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 14:40:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A431C34116;
        Wed,  8 Jun 2022 14:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654699251;
        bh=y5jci0bqRsZ94ArUjZ+9wtURoMvqstdDqOTJ7Eps920=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jMTVaqAHpvYtuYZbDdq0xRaTEYUoMoxdL9RzYX4fvHhmmIBADbynz/isWETDuuZpr
         6rJLLQYsgYy129uWysAmkBqNofZdLzW7C+wmpUEVoCyg17DfCD7JGASvG7FlH+YIT0
         fvmpBkcK4PEb8PzrBYx9kQkT7plW75ia0RgIIS7DX1vB2HeOMlTQg2IewoOtb4GjHd
         tnZQhW+VOqvI45IfoRAZoo91ft0oROL/ZpPHA2UxpsAtbmXUy1FxddX8/4EDfuf4BQ
         83Xb6Y3B/i4rijDVLjWO0LzJut9JvBe9AllEVr9eIVkfi3wHbGaBRE6/tjrWgtDovR
         i7hcI8RcnZEgQ==
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
Subject: [PATCH 02/20] context_tracking: Add a note about noinstr VS unsafe context tracking functions
Date:   Wed,  8 Jun 2022 16:40:19 +0200
Message-Id: <20220608144037.1765000-3-frederic@kernel.org>
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

Some context tracking functions enter or exit into/from RCU idle mode
while using trace-able and lockdep-aware IRQs (un-)masking. As a result
those functions can't get tagged as noinstr. This is unlikely to be
fixed since these are obsolete APIs. Drop a note about this matter.

Reported-by: Peter Zijlstra <peterz@infradead.org>
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
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/context_tracking.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 36a98c48aedc..b8032ebf4314 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -103,6 +103,16 @@ void noinstr __context_tracking_enter(enum ctx_state state)
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
+
+ */
 void context_tracking_enter(enum ctx_state state)
 {
 	unsigned long flags;
@@ -125,6 +135,14 @@ void context_tracking_enter(enum ctx_state state)
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
@@ -168,6 +186,15 @@ void noinstr __context_tracking_exit(enum ctx_state state)
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
@@ -182,6 +209,14 @@ void context_tracking_exit(enum ctx_state state)
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
2.25.1

