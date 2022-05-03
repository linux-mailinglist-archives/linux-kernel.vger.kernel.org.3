Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB675181E5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 12:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbiECKFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 06:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbiECKEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 06:04:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EA137A2D
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 03:01:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D220161519
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 10:01:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D8CC385A4;
        Tue,  3 May 2022 10:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651572074;
        bh=1zuNr9aZbocCTXcOg+LUMS7leXk/IsG5o8dXhATCIOE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QHMecCv0A+1dlx7SuDLWJi02/MeKHB0hqnxlPOOQWHd/mJLFXdvnN1PupQwat4wix
         FWq4JWLW3vi+9mHfMpPbcBxc7nE+DIBbn7qLAWtCz0XceDTDkV3f/81nenyYn2uc2+
         hno7OG9/VfSnFT1T6mzjC8bRID4fnAKe6J5nt9YKWjwLVhj0jyaUcfSE4S5WX5RuyS
         Ezqpl9cKBVSTYCJ0ysSoWsxUY2fZrM0bLiT5toQ8O4T9p3fFrwoldwiJ7gTtxcpr6r
         ZXlTSZHRx5lBMPbU1KnlXlhf6LYyqWwhYdpdXCZi4liAjlhbJ3apYuH+b3RQekXWoZ
         WaTrg+t5jc6RQ==
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
Subject: [PATCH 03/21] rcu: Add a note about noinstr VS unsafe eqs functions
Date:   Tue,  3 May 2022 12:00:33 +0200
Message-Id: <20220503100051.2799723-4-frederic@kernel.org>
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

Some RCU functions enter or exit into/from RCU idle mode while using
trace-able and lockdep-aware IRQs (un-)masking. This could be easily
solved with using raw versions of local_irq_*() but we would then
lose some precious debugging informations.

Another possible way to solve this may consist in using rude RCU-tasks
in lockdep and irqsoff tracing.

In any case and until this get solved, those RCU functions can't get
tagged as noinstr even though they should.

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
 kernel/rcu/tree.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a5da4b87afde..2a6e7723fc4d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -838,6 +838,10 @@ void rcu_irq_exit_check_preempt(void)
  *
  * If you add or remove a call to rcu_irq_exit_irqson(), be sure to test
  * with CONFIG_RCU_EQS_DEBUG=y.
+ *
+ * FIXME: This function should be noinstr but the below local_irq_restore() is
+ * unsafe because it involves illegal RCU uses through tracing and lockdep.
+ * This must be fixed first.
  */
 void rcu_irq_exit_irqson(void)
 {
@@ -895,6 +899,10 @@ static void noinstr rcu_eqs_exit(bool user)
  *
  * If you add or remove a call to rcu_idle_exit(), be sure to test with
  * CONFIG_RCU_EQS_DEBUG=y.
+ *
+ * FIXME: This function should be noinstr but the below local_irq_save() is
+ * unsafe because it involves illegal RCU uses through tracing and lockdep.
+ * This must be fixed first.
  */
 void rcu_idle_exit(void)
 {
@@ -1076,6 +1084,10 @@ noinstr void rcu_irq_enter(void)
  *
  * If you add or remove a call to rcu_irq_enter_irqson(), be sure to test
  * with CONFIG_RCU_EQS_DEBUG=y.
+ *
+ * FIXME: This function should be noinstr but the below local_irq_save() is
+ * unsafe because it involves illegal RCU uses through tracing and lockdep.
+ * This must be fixed first.
  */
 void rcu_irq_enter_irqson(void)
 {
-- 
2.25.1

