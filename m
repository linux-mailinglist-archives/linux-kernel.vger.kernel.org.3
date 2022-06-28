Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0FC55E452
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346271AbiF1NSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346437AbiF1NRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:17:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFE431528
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:17:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0A5061773
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 13:17:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64934C385A5;
        Tue, 28 Jun 2022 13:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656422252;
        bh=VzJewbr+8o3nhJgYgTousbQudsZyR0v/61689sA3FgQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gHipzaCK1Sa285GLKXYir+QrHedGhRDFHQPdl68w9thBczokGQnVHL9lTwgdukCOZ
         NgQ7lf+IsF5utW9lPoWSf5vnat5dQ5WTBQXHvCm3w5B+Bao7SVz7CKnSxXrKCxq/8D
         WxWv1SWFQ8NufJzJZuv2NG+FhiSFyMHV1lkWmYMTlqPbfrYHRCo1hPhyGcMu5zB4F4
         mEohNdHoVpmoGSfi7N0LxZXUvrOJbttVqJCMjod/blzEYxNmccFd52dxXG/rVh8dsg
         Ii1Iidsa5eFARI6uN5JuTP3mgUQ09e0Ord9gofexsR2d2xUbJrUnYJa3VnwOpohW1h
         r8Ob/Mk+rPcwg==
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
Subject: [PATCH 15/20] rcu/context-tracking: Move deferred nocb resched to context tracking
Date:   Tue, 28 Jun 2022 15:16:14 +0200
Message-Id: <20220628131619.2109651-16-frederic@kernel.org>
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
Reviewed-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
Tested-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---
 include/linux/rcupdate.h  |  6 ++++++
 kernel/context_tracking.c |  8 ++++++++
 kernel/rcu/tree.c         | 15 ++-------------
 3 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index f1562d91c67d..3717cad983a6 100644
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
index 7c3033e9a518..8cf59d8a6af6 100644
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
index 006939b29e82..8c0c3490532e 100644
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
2.25.1

