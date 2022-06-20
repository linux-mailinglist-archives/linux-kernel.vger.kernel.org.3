Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44574552737
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345266AbiFTWzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344370AbiFTWyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:54:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E406B1D0C7;
        Mon, 20 Jun 2022 15:54:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 086F161419;
        Mon, 20 Jun 2022 22:54:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B1CC3411B;
        Mon, 20 Jun 2022 22:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765653;
        bh=nq74XM5qmGdjh3JWiMU9VuScVmOfgvRYRWhx5zG5Cgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u4diseL4f7wtGTHQBT5oIZfE/zehbrhk/ZrOIs0eoiVhVOMOoTp2uZbDuvJbIRZz6
         TRoVIUUwp9LCFG8XCEoChIOIFH5KEBXEEgoz39/qp6raBcfkwbUArOQpIa+pislsZ4
         Yl0+lW8s6VTsmBrCJvPq9LrV+r4lkoYafdcXk35iXkp9t3mHAIFxzQIzHEydXQ2JTc
         L1l1YdX6vUgh0aBxfWmPDJpHD6UofJwud+a1tOKx+I2yEY/rh2ys66+zDMt2wZ+C8U
         u3+6IJNMD2d1zlcOMcNeZ4OzAS7nmROCEi6trqrFec6YElgwgUNBJPkoKSZRb7ecHO
         XJBXqMdTk+8sw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 29B995C05C8; Mon, 20 Jun 2022 15:54:13 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 02/32] rcu-tasks: Split rcu_tasks_one_gp() from rcu_tasks_kthread()
Date:   Mon, 20 Jun 2022 15:53:41 -0700
Message-Id: <20220620225411.3842519-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620225402.GA3842369@paulmck-ThinkPad-P17-Gen-1>
References: <20220620225402.GA3842369@paulmck-ThinkPad-P17-Gen-1>
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

This commit abstracts most of the rcu_tasks_kthread() function's loop
body into a new rcu_tasks_one_gp() function.  It also introduces
a new ->tasks_gp_mutex to synchronize concurrent calls to this new
rcu_tasks_one_gp() function.  This commit is preparation for allowing
RCU tasks grace periods to be driven by the calling task during the
mid-boot dead zone.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 58 ++++++++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 22 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index b8690a412c5bf..d7b12f524e81c 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -48,6 +48,7 @@ struct rcu_tasks_percpu {
  * struct rcu_tasks - Definition for a Tasks-RCU-like mechanism.
  * @cbs_wait: RCU wait allowing a new callback to get kthread's attention.
  * @cbs_gbl_lock: Lock protecting callback list.
+ * @tasks_gp_mutex: Mutex protecting grace period, needed during mid-boot dead zone.
  * @kthread_ptr: This flavor's grace-period/callback-invocation kthread.
  * @gp_func: This flavor's grace-period-wait function.
  * @gp_state: Grace period's most recent state transition (debugging).
@@ -79,6 +80,7 @@ struct rcu_tasks_percpu {
 struct rcu_tasks {
 	struct rcuwait cbs_wait;
 	raw_spinlock_t cbs_gbl_lock;
+	struct mutex tasks_gp_mutex;
 	int gp_state;
 	int gp_sleep;
 	int init_fract;
@@ -119,6 +121,7 @@ static struct rcu_tasks rt_name =							\
 {											\
 	.cbs_wait = __RCUWAIT_INITIALIZER(rt_name.wait),				\
 	.cbs_gbl_lock = __RAW_SPIN_LOCK_UNLOCKED(rt_name.cbs_gbl_lock),			\
+	.tasks_gp_mutex = __MUTEX_INITIALIZER(rt_name.tasks_gp_mutex),			\
 	.gp_func = gp,									\
 	.call_func = call,								\
 	.rtpcpu = &rt_name ## __percpu,							\
@@ -502,10 +505,37 @@ static void rcu_tasks_invoke_cbs_wq(struct work_struct *wp)
 	rcu_tasks_invoke_cbs(rtp, rtpcp);
 }
 
-/* RCU-tasks kthread that detects grace periods and invokes callbacks. */
-static int __noreturn rcu_tasks_kthread(void *arg)
+// Wait for one grace period.
+static void rcu_tasks_one_gp(struct rcu_tasks *rtp)
 {
 	int needgpcb;
+
+	mutex_lock(&rtp->tasks_gp_mutex);
+	set_tasks_gp_state(rtp, RTGS_WAIT_CBS);
+
+	// If there were none, wait a bit and start over.
+	rcuwait_wait_event(&rtp->cbs_wait,
+			   (needgpcb = rcu_tasks_need_gpcb(rtp)),
+			   TASK_IDLE);
+
+	if (needgpcb & 0x2) {
+		// Wait for one grace period.
+		set_tasks_gp_state(rtp, RTGS_WAIT_GP);
+		rtp->gp_start = jiffies;
+		rcu_seq_start(&rtp->tasks_gp_seq);
+		rtp->gp_func(rtp);
+		rcu_seq_end(&rtp->tasks_gp_seq);
+	}
+
+	// Invoke callbacks.
+	set_tasks_gp_state(rtp, RTGS_INVOKE_CBS);
+	rcu_tasks_invoke_cbs(rtp, per_cpu_ptr(rtp->rtpcpu, 0));
+	mutex_unlock(&rtp->tasks_gp_mutex);
+}
+
+// RCU-tasks kthread that detects grace periods and invokes callbacks.
+static int __noreturn rcu_tasks_kthread(void *arg)
+{
 	struct rcu_tasks *rtp = arg;
 
 	/* Run on housekeeping CPUs by default.  Sysadm can move if desired. */
@@ -519,27 +549,11 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 	 * This loop is terminated by the system going down.  ;-)
 	 */
 	for (;;) {
-		set_tasks_gp_state(rtp, RTGS_WAIT_CBS);
-
-		/* If there were none, wait a bit and start over. */
-		rcuwait_wait_event(&rtp->cbs_wait,
-				   (needgpcb = rcu_tasks_need_gpcb(rtp)),
-				   TASK_IDLE);
-
-		if (needgpcb & 0x2) {
-			// Wait for one grace period.
-			set_tasks_gp_state(rtp, RTGS_WAIT_GP);
-			rtp->gp_start = jiffies;
-			rcu_seq_start(&rtp->tasks_gp_seq);
-			rtp->gp_func(rtp);
-			rcu_seq_end(&rtp->tasks_gp_seq);
-		}
-
-		/* Invoke callbacks. */
-		set_tasks_gp_state(rtp, RTGS_INVOKE_CBS);
-		rcu_tasks_invoke_cbs(rtp, per_cpu_ptr(rtp->rtpcpu, 0));
+		// Wait for one grace period and invoke any callbacks
+		// that are ready.
+		rcu_tasks_one_gp(rtp);
 
-		/* Paranoid sleep to keep this from entering a tight loop */
+		// Paranoid sleep to keep this from entering a tight loop.
 		schedule_timeout_idle(rtp->gp_sleep);
 	}
 }
-- 
2.31.1.189.g2e36527f23

