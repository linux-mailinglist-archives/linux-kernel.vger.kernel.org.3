Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392FE55E442
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346177AbiF1NRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346243AbiF1NQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:16:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1E231DD3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:16:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC88261772
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 13:16:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 633B7C341CA;
        Tue, 28 Jun 2022 13:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656422196;
        bh=JfWjYKKaa+/eRVP0NAX9I6c1SUl+tMPhMJ8kWS6S19I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WN/DTAVwYvY5yjlIGU16bZC94NFI3sPb4F9iLGNq/X/nmcinfgQs5bi7gpuGqBx24
         mRIEL0lgVehS7lIrvdpCxgdIn9VSaxJEWOXYDmhYHleGqlUuygPBlf4viNkWfYzzYm
         Irnxrt49tDlhQpxOdwKrrhUgJLm4CxMAgLmwLWUBt01h0zsRZ83NKgzY/xRMbYzJLK
         DsOUIU17AdwGDGFSluiYRSCG8oEse8IGKfAwf3ktF8brzaQaDeWDdnMMlE9Y8bfsIy
         j3kvKd+xitkf0v1pR3t00hZwO/DDfB+r0TGolimrkeXVBJA0XAwfoUlCEIMEWzme/K
         1Eb7eJLnvBdNw==
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
Subject: [PATCH 02/20] context_tracking: Add a note about noinstr VS unsafe context tracking functions
Date:   Tue, 28 Jun 2022 15:16:01 +0200
Message-Id: <20220628131619.2109651-3-frederic@kernel.org>
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
Reviewed-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
Tested-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---
 kernel/context_tracking.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 36a98c48aedc..3082332f6476 100644
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
2.25.1

