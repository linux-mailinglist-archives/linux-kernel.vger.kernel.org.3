Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A1E506068
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236379AbiDSADD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236116AbiDSAC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:02:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC2111C3F;
        Mon, 18 Apr 2022 17:00:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5BA96123D;
        Tue, 19 Apr 2022 00:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39513C385A1;
        Tue, 19 Apr 2022 00:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650326416;
        bh=3PHr6DaJm3KpAi0VoxU2Z4Urf23rCyOQHDJiKZI+ijM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sGet6K9vISgKGjn1gS6P1dcO4kA+em3X3NGknBPDrM8g6pTs/v4MrfdShT6NJtaEh
         a+MrX7faiqb7QF4jamJwhFlmvld3MxR5wcOSnDBJjcFFWi0JN31QI3chf0rrHF1FBA
         XW7TtAspSmObUrE388VxRCdqdDWAK9dORLe4nfGRJynRCyHvA4BJxzl6Av6Gk1UuZg
         eG3lY7scaX8nfyAZvqIA7IoYiX8N0yKx/reQoypmfmtP2erRQ0OIBujfRIvuzeLgBz
         YLbVyJEGJ2LcD2zRfi987OCcRNWsv3PSh5fW7vLd7Fs6NdSreK3ppt9offb2lwuNIX
         y60smg8R3tYCg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DB7245C0848; Mon, 18 Apr 2022 17:00:15 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 3/9] rcu-tasks: Use rcuwait for the rcu_tasks_kthread()
Date:   Mon, 18 Apr 2022 17:00:08 -0700
Message-Id: <20220419000014.3948512-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419000007.GA3945818@paulmck-ThinkPad-P17-Gen-1>
References: <20220419000007.GA3945818@paulmck-ThinkPad-P17-Gen-1>
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

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The waitqueue used by rcu_tasks_kthread() has always only one waiter.
With a guaranteed only one waiter, this can be replaced with rcuwait
which is smaller and simpler. With rcuwait based wake counterpart, the
irqwork function (call_rcu_tasks_iw_wakeup()) can be invoked hardirq
context because it is only a wake up and no sleeping locks are involved
(unlike the wait_queue_head).
As a side effect, this is also one piece of the puzzle to pass the RCU
selftest at early boot on PREEMPT_RT.

Replace wait_queue_head with rcuwait and let the irqwork run in hardirq
context on PREEMPT_RT.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 76799c81d4be..4b91cb214ca7 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -46,7 +46,7 @@ struct rcu_tasks_percpu {
 
 /**
  * struct rcu_tasks - Definition for a Tasks-RCU-like mechanism.
- * @cbs_wq: Wait queue allowing new callback to get kthread's attention.
+ * @cbs_wait: RCU wait allowing a new callback to get kthread's attention.
  * @cbs_gbl_lock: Lock protecting callback list.
  * @kthread_ptr: This flavor's grace-period/callback-invocation kthread.
  * @gp_func: This flavor's grace-period-wait function.
@@ -77,7 +77,7 @@ struct rcu_tasks_percpu {
  * @kname: This flavor's kthread name.
  */
 struct rcu_tasks {
-	struct wait_queue_head cbs_wq;
+	struct rcuwait cbs_wait;
 	raw_spinlock_t cbs_gbl_lock;
 	int gp_state;
 	int gp_sleep;
@@ -113,11 +113,11 @@ static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp);
 #define DEFINE_RCU_TASKS(rt_name, gp, call, n)						\
 static DEFINE_PER_CPU(struct rcu_tasks_percpu, rt_name ## __percpu) = {			\
 	.lock = __RAW_SPIN_LOCK_UNLOCKED(rt_name ## __percpu.cbs_pcpu_lock),		\
-	.rtp_irq_work = IRQ_WORK_INIT(call_rcu_tasks_iw_wakeup),			\
+	.rtp_irq_work = IRQ_WORK_INIT_HARD(call_rcu_tasks_iw_wakeup),			\
 };											\
 static struct rcu_tasks rt_name =							\
 {											\
-	.cbs_wq = __WAIT_QUEUE_HEAD_INITIALIZER(rt_name.cbs_wq),			\
+	.cbs_wait = __RCUWAIT_INITIALIZER(rt_name.wait),				\
 	.cbs_gbl_lock = __RAW_SPIN_LOCK_UNLOCKED(rt_name.cbs_gbl_lock),			\
 	.gp_func = gp,									\
 	.call_func = call,								\
@@ -266,7 +266,7 @@ static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp)
 	struct rcu_tasks_percpu *rtpcp = container_of(iwp, struct rcu_tasks_percpu, rtp_irq_work);
 
 	rtp = rtpcp->rtpp;
-	wake_up(&rtp->cbs_wq);
+	rcuwait_wake_up(&rtp->cbs_wait);
 }
 
 // Enqueue a callback for the specified flavor of Tasks RCU.
@@ -514,7 +514,9 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 		set_tasks_gp_state(rtp, RTGS_WAIT_CBS);
 
 		/* If there were none, wait a bit and start over. */
-		wait_event_idle(rtp->cbs_wq, (needgpcb = rcu_tasks_need_gpcb(rtp)));
+		rcuwait_wait_event(&rtp->cbs_wait,
+				   (needgpcb = rcu_tasks_need_gpcb(rtp)),
+				   TASK_IDLE);
 
 		if (needgpcb & 0x2) {
 			// Wait for one grace period.
-- 
2.31.1.189.g2e36527f23

