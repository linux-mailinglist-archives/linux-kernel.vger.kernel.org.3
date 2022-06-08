Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7702B5432E1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 16:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242092AbiFHOoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 10:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241923AbiFHOmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 10:42:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C8818F85B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 07:41:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E565161B96
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 14:41:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26DADC3411D;
        Wed,  8 Jun 2022 14:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654699299;
        bh=thLW1AdTFUGR2qp/zVtupKcplrWYxLzE4qfZIs11S9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UXMd76+gq41l5m27KnPwIxsF/GEKVechCLIJAg/3KanqL9j0uYerjSneewQKU5RWv
         K0NQkaFpV7pp0Z9v/r/ARL+KOwlx3eoc0yfig0MdHyth7CwgqXV/mHUcErnyHi4ez0
         xyN+fv/H//G5EjJ5AtNtEBTIGKgQRnEvJdvJ1R0zE9w9DVrV9YPVmoElSJh4fJS2oL
         A++zsqS5RmNBCTpt5V7ZxyZuBlfAndKcNWjzJmZvFAmpaqIrQhl9QoNfwMZjpxhphc
         UAbyXzMzkGQHk4/ObljyKhqEWkQ3KLxq08ybKT3Hc8W4JGz6t6CZQjq9MecllNVmcf
         aIsFNS3i6nlGw==
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
Subject: [PATCH 15/20] rcu/context-tracking: Move deferred nocb resched to context tracking
Date:   Wed,  8 Jun 2022 16:40:32 +0200
Message-Id: <20220608144037.1765000-16-frederic@kernel.org>
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
 include/linux/rcupdate.h  |  6 ++++++
 kernel/context_tracking.c |  8 ++++++++
 kernel/rcu/tree.c         | 15 ++-------------
 3 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 910328f2f51a..1d120dca6548 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -113,6 +113,12 @@ static inline void rcu_user_enter(void) { }
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
index 95ce83904287..d782c868f36f 100644
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
index ef734577b63d..beddb4fb5d07 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -685,7 +685,7 @@ static DEFINE_PER_CPU(struct irq_work, late_wakeup_work) =
  * last resort is to fire a local irq_work that will trigger a reschedule once IRQs
  * get re-enabled again.
  */
-noinstr static void rcu_irq_work_resched(void)
+noinstr void rcu_irq_work_resched(void)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
@@ -701,10 +701,7 @@ noinstr static void rcu_irq_work_resched(void)
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
@@ -719,14 +716,6 @@ static inline void rcu_irq_work_resched(void) { }
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

