Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25EB9506069
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236509AbiDSADL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236098AbiDSAC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:02:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA6011C38;
        Mon, 18 Apr 2022 17:00:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D38D861290;
        Tue, 19 Apr 2022 00:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3083CC385A7;
        Tue, 19 Apr 2022 00:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650326416;
        bh=15WmndtzksixwsdyWx7zI/CoD8NXMZvP4L24gel6g5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K614iE0sBFKWi1b858MHkARE9dhOxftOh3hBjwl4nM91zm6YjAMJ69fOVJyMfYrwH
         R9d67UpJZpKN3ywRs7poOMxCNirzr+VF3M02RIH85Qb6mfCOfx6CHNjRVCwJ2ostEw
         O8C2YX+KF1KHDkwaOeJWtjhYEYkF202re59kEKNcUlpUMUOt5BTIkb9hhQ1ht5FYEz
         dkwa8bJtrZFcbeFleC2I0xhipUUCiea8dtnyBi7qobiU1DZqxap2/OSBXDJjVVJJ6+
         QumrKNyKzxu1c35u4R+wnPM5qU0iI4+rF/vOV8/sm/RT1fqWn9aY8oSEoAH07orjPu
         F52wF73G8vtxw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D970F5C04C6; Mon, 18 Apr 2022 17:00:15 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 2/9] rcu-tasks: Print pre-stall-warning informational messages
Date:   Mon, 18 Apr 2022 17:00:07 -0700
Message-Id: <20220419000014.3948512-2-paulmck@kernel.org>
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

RCU-tasks stall-warning messages are printed after the grace period is ten
minutes old.  Unfortunately, most of us will have rebooted the system in
response to an apparently-hung command long before the ten minutes is up,
and will thus see what looks to be a silent hang.

This commit therefore adds pr_info() messages that are printed earlier.
These should avoid being classified as errors, but should give impatient
users a hint.  These are controlled by new rcupdate.rcu_task_stall_info
and rcupdate.rcu_task_stall_info_mult kernel-boot parameters.  The former
defines the initial delay in jiffies (defaulting to 10 seconds) and the
latter defines the multiplier (defaulting to 3).  Thus, by default, the
first message will appear 10 seconds into the RCU-tasks grace period,
the second 40 seconds in, and the third 160 seconds in.  There would be
a fourth at 640 seconds in, but the stall warning message appears 600
seconds in, and once a stall warning is printed for a given grace period,
no further informational messages are printed.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         | 30 ++++++++++++--
 kernel/rcu/tasks.h                            | 40 ++++++++++++++++---
 2 files changed, 62 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3f1cc5e317ed..babc701d4864 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4955,10 +4955,34 @@
 			number avoids disturbing real-time workloads,
 			but lengthens grace periods.
 
+	rcupdate.rcu_task_stall_info= [KNL]
+			Set initial timeout in jiffies for RCU task stall
+			informational messages, which give some indication
+			of the problem for those not patient enough to
+			wait for ten minutes.  Informational messages are
+			only printed prior to the stall-warning message
+			for a given grace period. Disable with a value
+			less than or equal to zero.  Defaults to ten
+			seconds.  A change in value does not take effect
+			until the beginning of the next grace period.
+
+	rcupdate.rcu_task_stall_info_mult= [KNL]
+			Multiplier for time interval between successive
+			RCU task stall informational messages for a given
+			RCU tasks grace period.  This value is clamped
+			to one through ten, inclusive.	It defaults to
+			the value three, so that the first informational
+			message is printed 10 seconds into the grace
+			period, the second at 40 seconds, the third at
+			160 seconds, and then the stall warning at 600
+			seconds would prevent a fourth at 640 seconds.
+
 	rcupdate.rcu_task_stall_timeout= [KNL]
-			Set timeout in jiffies for RCU task stall warning
-			messages.  Disable with a value less than or equal
-			to zero.
+			Set timeout in jiffies for RCU task stall
+			warning messages.  Disable with a value less
+			than or equal to zero.	Defaults to ten minutes.
+			A change in value does not take effect until
+			the beginning of the next grace period.
 
 	rcupdate.rcu_self_test= [KNL]
 			Run the RCU early boot self tests
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index b43320b149d2..76799c81d4be 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -143,6 +143,11 @@ module_param(rcu_task_ipi_delay, int, 0644);
 #define RCU_TASK_STALL_TIMEOUT (HZ * 60 * 10)
 static int rcu_task_stall_timeout __read_mostly = RCU_TASK_STALL_TIMEOUT;
 module_param(rcu_task_stall_timeout, int, 0644);
+#define RCU_TASK_STALL_INFO (HZ * 10)
+static int rcu_task_stall_info __read_mostly = RCU_TASK_STALL_INFO;
+module_param(rcu_task_stall_info, int, 0644);
+static int rcu_task_stall_info_mult __read_mostly = 3;
+module_param(rcu_task_stall_info_mult, int, 0444);
 
 static int rcu_task_enqueue_lim __read_mostly = -1;
 module_param(rcu_task_enqueue_lim, int, 0444);
@@ -548,8 +553,15 @@ static void __init rcu_spawn_tasks_kthread_generic(struct rcu_tasks *rtp)
 static void __init rcu_tasks_bootup_oddness(void)
 {
 #if defined(CONFIG_TASKS_RCU) || defined(CONFIG_TASKS_TRACE_RCU)
+	int rtsimc;
+
 	if (rcu_task_stall_timeout != RCU_TASK_STALL_TIMEOUT)
 		pr_info("\tTasks-RCU CPU stall warnings timeout set to %d (rcu_task_stall_timeout).\n", rcu_task_stall_timeout);
+	rtsimc = clamp(rcu_task_stall_info_mult, 1, 10);
+	if (rtsimc != rcu_task_stall_info_mult) {
+		pr_info("\tTasks-RCU CPU stall info multiplier clamped to %d (rcu_task_stall_info_mult).\n", rtsimc);
+		rcu_task_stall_info_mult = rtsimc;
+	}
 #endif /* #ifdef CONFIG_TASKS_RCU */
 #ifdef CONFIG_TASKS_RCU
 	pr_info("\tTrampoline variant of Tasks RCU enabled.\n");
@@ -592,10 +604,15 @@ static void exit_tasks_rcu_finish_trace(struct task_struct *t);
 /* Wait for one RCU-tasks grace period. */
 static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 {
-	struct task_struct *g, *t;
-	unsigned long lastreport;
-	LIST_HEAD(holdouts);
+	struct task_struct *g;
 	int fract;
+	LIST_HEAD(holdouts);
+	unsigned long j;
+	unsigned long lastinfo;
+	unsigned long lastreport;
+	bool reported = false;
+	int rtsi;
+	struct task_struct *t;
 
 	set_tasks_gp_state(rtp, RTGS_PRE_WAIT_GP);
 	rtp->pregp_func();
@@ -621,6 +638,8 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 	 * is empty, we are done.
 	 */
 	lastreport = jiffies;
+	lastinfo = lastreport;
+	rtsi = READ_ONCE(rcu_task_stall_info);
 
 	// Start off with initial wait and slowly back off to 1 HZ wait.
 	fract = rtp->init_fract;
@@ -630,7 +649,7 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 		bool needreport;
 		int rtst;
 
-		/* Slowly back off waiting for holdouts */
+		// Slowly back off waiting for holdouts
 		set_tasks_gp_state(rtp, RTGS_WAIT_SCAN_HOLDOUTS);
 		schedule_timeout_idle(fract);
 
@@ -639,12 +658,23 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 
 		rtst = READ_ONCE(rcu_task_stall_timeout);
 		needreport = rtst > 0 && time_after(jiffies, lastreport + rtst);
-		if (needreport)
+		if (needreport) {
 			lastreport = jiffies;
+			reported = true;
+		}
 		firstreport = true;
 		WARN_ON(signal_pending(current));
 		set_tasks_gp_state(rtp, RTGS_SCAN_HOLDOUTS);
 		rtp->holdouts_func(&holdouts, needreport, &firstreport);
+
+		// Print pre-stall informational messages if needed.
+		j = jiffies;
+		if (rtsi > 0 && !reported && time_after(j, lastinfo + rtsi)) {
+			lastinfo = j;
+			rtsi = rtsi * rcu_task_stall_info_mult;
+			pr_info("%s: %s grace period %lu is %lu jiffies old.\n",
+				__func__, rtp->kname, rtp->tasks_gp_seq, j - rtp->gp_start);
+		}
 	}
 
 	set_tasks_gp_state(rtp, RTGS_POST_GP);
-- 
2.31.1.189.g2e36527f23

