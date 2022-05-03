Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6E25181E7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 12:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbiECKFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 06:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbiECKE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 06:04:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB6937A83
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 03:01:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6332A614A7
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 10:01:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6BBAC385B1;
        Tue,  3 May 2022 10:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651572077;
        bh=uGn4/MomNIQOvt1kVzK6g2/4eo2NkPnsPiqsExJKXrY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fPa1gBwHddN2GTHFmzaXKJTfNGwuYoqQq2uQH2mQ+zjFGoiGJb6jUM/+g3HRamuBi
         W+N9XW4ooBhF1D8h6t/Lc84wDIgNxH0nkOlQ34GMzJ5qPF13PNWLfUcPiduwIsrle1
         p4XLb0vO25tPdXKja3CzFckGrwu3gdBYk/AgrA8708vPyE+gzBQOzBWoUeplAU+dIL
         z0f8R2FI46i0Jg9z1XGzriwq8Rz9Z/4KrbcCixEhgmiBjflzN0OSAMkDEznWmBhMeT
         ChbWHP08l87/OkrjaZyMTTMsDm9a5ZDAd0Rr3+sg8p2W8zaDMvir4UEDzRzaGfwnl5
         bxdzapIrFjKAQ==
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
Subject: [PATCH 04/21] context_tracking: Add a note about noinstr VS unsafe context tracking functions
Date:   Tue,  3 May 2022 12:00:34 +0200
Message-Id: <20220503100051.2799723-5-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220503100051.2799723-1-frederic@kernel.org>
References: <20220503100051.2799723-1-frederic@kernel.org>
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

Some context tracking functions enter or exit into/from RCU idle mode
while using trace-able and lockdep-aware IRQs (un-)masking. This could
be easily solved with using raw versions of local_irq_*() but we would
then lose some precious debugging informations.

Another possible way to solve this may consist in using rude RCU-tasks
in lockdep and irqsoff tracing.

In any case and until this get solved, those functions can't get
tagged as noinstr even though they should.

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
 kernel/context_tracking.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 36a98c48aedc..1f44b0461d14 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -103,6 +103,11 @@ void noinstr __context_tracking_enter(enum ctx_state state)
 }
 EXPORT_SYMBOL_GPL(__context_tracking_enter);
 
+/*
+ * FIXME: This function should be noinstr but the below local_irq_restore() is
+ * unsafe because it involves illegal RCU uses through tracing and lockdep. This
+ * must be fixed first.
+ */
 void context_tracking_enter(enum ctx_state state)
 {
 	unsigned long flags;
@@ -125,6 +130,10 @@ void context_tracking_enter(enum ctx_state state)
 NOKPROBE_SYMBOL(context_tracking_enter);
 EXPORT_SYMBOL_GPL(context_tracking_enter);
 
+/*
+ * FIXME: This function should be noinstr but it unsafely calls local_irq_restore(),
+ * involving illegal RCU uses through tracing and lockdep. This must be fixed first.
+ */
 void context_tracking_user_enter(void)
 {
 	user_enter();
@@ -168,6 +177,11 @@ void noinstr __context_tracking_exit(enum ctx_state state)
 }
 EXPORT_SYMBOL_GPL(__context_tracking_exit);
 
+/*
+ * FIXME: This function should be noinstr but the below local_irq_save() is
+ * unsafe because it involves illegal RCU uses through tracing and lockdep. This
+ * must be fixed first.
+ */
 void context_tracking_exit(enum ctx_state state)
 {
 	unsigned long flags;
@@ -182,6 +196,10 @@ void context_tracking_exit(enum ctx_state state)
 NOKPROBE_SYMBOL(context_tracking_exit);
 EXPORT_SYMBOL_GPL(context_tracking_exit);
 
+/*
+ * FIXME: This function should be noinstr but it unsafely calls local_irq_save(),
+ * involving illegal RCU uses through tracing and lockdep. This must be fixed first.
+ */
 void context_tracking_user_exit(void)
 {
 	user_exit();
-- 
2.25.1

