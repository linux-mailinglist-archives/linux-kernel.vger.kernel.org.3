Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D7252D696
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 16:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240089AbiESO6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 10:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240062AbiESO6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 10:58:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDAED6819
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 07:58:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1896EB82559
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 14:58:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C99C385AA;
        Thu, 19 May 2022 14:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652972318;
        bh=QnZHsoFGGDrgc6gDM8i1CtC1GfXotTEDdEW7fOq4DJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SCcSxDBHc3EjqOSX9CTn8JfRdE2qAWLPE6CQSiOcI50le/xpR5meMkJsW1Ws5YFKW
         84m05df44EiCby4AbTzdj+oUqzMIBrk4OjPZekSjWyZEqvFUvYV81gEiXa/j2ZyUl8
         Q1SQs7DZweaW0+FvSJJOSHCjoVqFj4w0TxhSiOegOz1bdbIe2NV/bLF37w6xqUjR+G
         gGSKT3Ykj4YKMEo6I4rMComriEHDiVX5kU1ltu9MkdQj5KU0KU9A1FR0pvyewxBqs6
         DnmPAt1Uce1gpDZaZmZYfA8tJ/AsGb1GDJdOpO9kFIVkQ2KZ0VJClC8UZ2QzOGULOH
         vzWoGUgou6qvw==
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
Subject: [PATCH 02/21] rcu: Tag rcu_irq_*_irqson() as noinstr
Date:   Thu, 19 May 2022 16:58:04 +0200
Message-Id: <20220519145823.618983-3-frederic@kernel.org>
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

rcu_irq_*_irqson() functions can't be safely instrumented. Since they
enter/exit to/from RCU idle mode, those functions must be tagged as
"noinstr".

Unfortunately this involves converting the instrumentable
local_irq_save()/local_irq_restore() to their raw counterparts. Precious
debugging informations might be lost on the way until a better way out
is found.

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
 kernel/rcu/tree.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 02233b17cce0..ff97264d8077 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -843,13 +843,13 @@ void rcu_irq_exit_check_preempt(void)
  * If you add or remove a call to rcu_irq_exit_irqson(), be sure to test
  * with CONFIG_RCU_EQS_DEBUG=y.
  */
-void rcu_irq_exit_irqson(void)
+void noinstr rcu_irq_exit_irqson(void)
 {
 	unsigned long flags;
 
-	local_irq_save(flags);
+	raw_local_irq_save(flags);
 	rcu_irq_exit();
-	local_irq_restore(flags);
+	raw_local_irq_restore(flags);
 }
 
 /*
@@ -1081,13 +1081,13 @@ noinstr void rcu_irq_enter(void)
  * If you add or remove a call to rcu_irq_enter_irqson(), be sure to test
  * with CONFIG_RCU_EQS_DEBUG=y.
  */
-void rcu_irq_enter_irqson(void)
+void noinstr rcu_irq_enter_irqson(void)
 {
 	unsigned long flags;
 
-	local_irq_save(flags);
+	raw_local_irq_save(flags);
 	rcu_irq_enter();
-	local_irq_restore(flags);
+	raw_local_irq_restore(flags);
 }
 
 /*
-- 
2.25.1

