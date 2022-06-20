Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E09552803
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 01:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347157AbiFTXP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 19:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346466AbiFTXMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 19:12:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4219B22530;
        Mon, 20 Jun 2022 16:10:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E7C4B81657;
        Mon, 20 Jun 2022 23:10:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 537A2C341EC;
        Mon, 20 Jun 2022 23:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655766632;
        bh=1Hw+Z13zCUSvb97yNzRE+bRuAmwtfwyZkgGq4kgP9Sk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fwLipl4HvqrT9GqLyYFdB0MV4eACdbKDFaBBAKGwn95u9IMhUnKTLkyYZw6Kpp6FE
         BQE7uuVyg4Bi8XXq3+IRfnocivg80zTtIjdDZMuLEDKhTvuXtaG0IG12BI75gZLC+C
         i+mR5jXDgze1N5IlBlcXUlDT/ZCGKhgtKGbDpc4+VB8nL7zsFfOjR/VZ0YkKZ+FCL/
         F4GOAYgpuW9/FQdIegCuL3PM7m30iJsNzbfmmtKTbCh7WSXyOI1fadyLD2iwjWrw4n
         5ISWY5J4HlDBZLtw//dzePR3H1fMtXSG2VAzH26De9j0Tha3+x7kQPpKqGpezd13JU
         QD7hrayiv3dDw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6D8CE5C118A; Mon, 20 Jun 2022 16:10:31 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
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
        Alex Belits <abelits@marvell.com>
Subject: [PATCH rcu 17/23] rcu/context-tracking: Move deferred nocb resched to context tracking
Date:   Mon, 20 Jun 2022 16:10:23 -0700
Message-Id: <20220620231029.3844583-17-paulmck@kernel.org>
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

To prepare for migrating the RCU eqs accounting code to context tracking,
split the last-resort deferred nocb resched from rcu_user_enter() and
move it into a separate call from context tracking.

Acked-by: Paul E. McKenney <paulmck@kernel.org>
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
 include/linux/rcupdate.h  |  6 ++++++
 kernel/context_tracking.c |  8 ++++++++
 kernel/rcu/tree.c         | 15 ++-------------
 3 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index f1562d91c67d2..3717cad983a67 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -112,6 +112,12 @@ static inline void rcu_user_enter(void) { }
 static inline void rcu_user_exit(void) { }
 #endif /* CONFIG_NO_HZ_FULL */
 
+#if defined(CONFIG_NO_HZ_FULL) && (!defined(CONFIG_GENERIC_ENTRY) || !defined(CONFIG_KVM_XFER_TO_GUEST_WORK))
+void rcu_irq_work_resched(void);
+#else
+static inline void rcu_irq_work_resched(void) { }
+#endif
+
 #ifdef CONFIG_RCU_NOCB_CPU
 void rcu_init_nohz(void);
 int rcu_nocb_cpu_offload(int cpu);
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index bf5f498b21d39..8affa0092fab5 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -177,6 +177,8 @@ static __always_inline void context_tracking_recursion_exit(void)
  */
 void noinstr __ct_user_enter(enum ctx_state state)
 {
+	lockdep_assert_irqs_disabled();
+
 	/* Kernel threads aren't supposed to go to userspace */
 	WARN_ON_ONCE(!current->mm);
 
@@ -198,6 +200,12 @@ void noinstr __ct_user_enter(enum ctx_state state)
 				vtime_user_enter(current);
 				instrumentation_end();
 			}
+			/*
+			 * Other than generic entry implementation, we may be past the last
+			 * rescheduling opportunity in the entry code. Trigger a self IPI
+			 * that will fire and reschedule once we resume in user/guest mode.
+			 */
+			rcu_irq_work_resched();
 			rcu_user_enter();
 		}
 		/*
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 006939b29e823..8c0c3490532e3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -681,7 +681,7 @@ static DEFINE_PER_CPU(struct irq_work, late_wakeup_work) =
  * last resort is to fire a local irq_work that will trigger a reschedule once IRQs
  * get re-enabled again.
  */
-noinstr static void rcu_irq_work_resched(void)
+noinstr void rcu_irq_work_resched(void)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
@@ -697,10 +697,7 @@ noinstr static void rcu_irq_work_resched(void)
 	}
 	instrumentation_end();
 }
-
-#else
-static inline void rcu_irq_work_resched(void) { }
-#endif
+#endif /* #if !defined(CONFIG_GENERIC_ENTRY) || !defined(CONFIG_KVM_XFER_TO_GUEST_WORK) */
 
 /**
  * rcu_user_enter - inform RCU that we are resuming userspace.
@@ -715,14 +712,6 @@ static inline void rcu_irq_work_resched(void) { }
  */
 noinstr void rcu_user_enter(void)
 {
-	lockdep_assert_irqs_disabled();
-
-	/*
-	 * Other than generic entry implementation, we may be past the last
-	 * rescheduling opportunity in the entry code. Trigger a self IPI
-	 * that will fire and reschedule once we resume in user/guest mode.
-	 */
-	rcu_irq_work_resched();
 	rcu_eqs_enter(true);
 }
 
-- 
2.31.1.189.g2e36527f23

