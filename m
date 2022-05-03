Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672565181FC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 12:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbiECKGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 06:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234099AbiECKGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 06:06:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A8739699
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 03:02:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A4216150F
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 10:02:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7FE6C385B2;
        Tue,  3 May 2022 10:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651572124;
        bh=GUwBGopfqbKnbt7MNtk8uSBv/T4L7ECAAqia+WZIoIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WQGXipaNRRbarkWzrRKldD4cVd3gKFGollLWsYALUhXlAyPiBEV6vUzeYKMU0rbPj
         qqTIITSIMTfJJrpYGEI7xpTWNXmfvXF2+/iRz7oGPVzCfu2V1p8b5AO/0KfZHivtmu
         PLFNheI5vJOC8uHAE4sm5rZN+HFvBlJFZPQyX0SR9Ff/C+4TqiqUDz4zDlyvUdkzov
         /ObgHq59HZuCmOtTViuLZXz1+FlhIOh5ZqWaBY8xYd6VUACcto5O4xVZCeiLDdG4eT
         Aeom6O2w5H5EGEnJoMpoVfhyacpms3gy3jSCxL5IAq8RAlxSj7PJG/KC/f8GGIX8/5
         NB6PVQ2eeXb/w==
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
Subject: [PATCH 17/21] rcu/context-tracking: Move deferred nocb resched to context tracking
Date:   Tue,  3 May 2022 12:00:47 +0200
Message-Id: <20220503100051.2799723-18-frederic@kernel.org>
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
Cc: Yu Liao<liaoyu15@huawei.com>
Cc: Phil Auld <pauld@redhat.com>
Cc: Paul Gortmaker<paul.gortmaker@windriver.com>
Cc: Alex Belits <abelits@marvell.com>
---
 include/linux/rcutree.h   |  6 ++++++
 kernel/context_tracking.c |  8 ++++++++
 kernel/rcu/tree.c         | 15 ++-------------
 3 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index cafe3fbf4272..6294271f1615 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -76,4 +76,10 @@ int rcutree_dead_cpu(unsigned int cpu);
 int rcutree_dying_cpu(unsigned int cpu);
 void rcu_cpu_starting(unsigned int cpu);
 
+#if defined(CONFIG_NO_HZ_FULL) && (!defined(CONFIG_GENERIC_ENTRY) || !defined(CONFIG_KVM_XFER_TO_GUEST_WORK))
+void rcu_irq_work_resched(void);
+#else
+static inline void rcu_irq_work_resched(void) { }
+#endif
+
 #endif /* __LINUX_RCUTREE_H */
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 14f04c521573..4ca4aeadad06 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -60,6 +60,8 @@ static __always_inline void context_tracking_recursion_exit(void)
  */
 void noinstr __ct_user_enter(enum ctx_state state)
 {
+	lockdep_assert_irqs_disabled();
+
 	/* Kernel threads aren't supposed to go to userspace */
 	WARN_ON_ONCE(!current->mm);
 
@@ -81,6 +83,12 @@ void noinstr __ct_user_enter(enum ctx_state state)
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
index 7b1404db3c17..7d1a3e73ff25 100644
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

