Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02ABE55270E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245715AbiFTWpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244004AbiFTWpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:45:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB70B1400F;
        Mon, 20 Jun 2022 15:45:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B4556135A;
        Mon, 20 Jun 2022 22:45:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90953C341C8;
        Mon, 20 Jun 2022 22:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765105;
        bh=YeBHehtFq6AdT6OCOL99JKnvZVJzXnbqY95m1WmhH7E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QwwfJdbr1zUhilxZV10pPyd3wRCsuY28CIvT80dRwy/rjvRlzEEAcSAZyhhzQ77zr
         XwMXMgp9GWIcj8e7EalIHffLystOsPfi4xqJ1KDb1Uckr8RQwutPo0iPEKJ67G/3BF
         kw7oS+VGEYtDSxAiQk4vdCHdsR1pQS94J8Ljxaq0TWQD+PvoCWCnXhwg4PGfpoXmX5
         BMqoZdmMBb7AOFRt7qA5qmabQ/ESzBgW7BMJLcuxzZidRDKewrhVfmmdvnaUzgdUNN
         mXanotKBen1cPJBJEpfUYm2dxN7YI82/3BdI3tmTM2dR3OcX7I3N+c4ZIUnqP3H31+
         D+Nl+PAP8UflA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F1E055C0B06; Mon, 20 Jun 2022 15:45:04 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH rcu 6/7] rcu/nocb: Add option to opt rcuo kthreads out of RT priority
Date:   Mon, 20 Jun 2022 15:45:02 -0700
Message-Id: <20220620224503.3841196-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620224455.GA3840881@paulmck-ThinkPad-P17-Gen-1>
References: <20220620224455.GA3840881@paulmck-ThinkPad-P17-Gen-1>
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

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

This commit introduces a RCU_NOCB_CPU_CB_BOOST Kconfig option that
prevents rcuo kthreads from running at real-time priority, even in
kernels built with RCU_BOOST.  This capability is important to devices
needing low-latency (as in a few milliseconds) response from expedited
RCU grace periods, but which are not running a classic real-time workload.
On such devices, permitting the rcuo kthreads to run at real-time priority
results in unacceptable latencies imposed on the application tasks,
which run as SCHED_OTHER.

See for example the following trace output:

<snip>
<...>-60 [006] d..1 2979.028717: rcu_batch_start: rcu_preempt CBs=34619 bl=270
<snip>

If that rcuop kthread were permitted to run at real-time SCHED_FIFO
priority, it would monopolize its CPU for hundreds of milliseconds
while invoking those 34619 RCU callback functions, which would cause an
unacceptably long latency spike for many application stacks on Android
platforms.

However, some existing real-time workloads require that callback
invocation run at SCHED_FIFO priority, for example, those running on
systems with heavy SCHED_OTHER background loads.  (It is the real-time
system's administrator's responsibility to make sure that important
real-time tasks run at a higher priority than do RCU's kthreads.)

Therefore, this new RCU_NOCB_CPU_CB_BOOST Kconfig option defaults to
"y" on kernels built with PREEMPT_RT and defaults to "n" otherwise.
The effect is to preserve current behavior for real-time systems, but for
other systems to allow expedited RCU grace periods to run with real-time
priority while continuing to invoke RCU callbacks as SCHED_OTHER.

As you would expect, this RCU_NOCB_CPU_CB_BOOST Kconfig option has no
effect except on CPUs with offloaded RCU callbacks.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/Kconfig     | 16 ++++++++++++++++
 kernel/rcu/tree.c      |  6 +++++-
 kernel/rcu/tree_nocb.h |  3 ++-
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 27aab870ae4cf..c05ca52cdf64d 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -275,6 +275,22 @@ config RCU_NOCB_CPU_DEFAULT_ALL
 	  Say Y here if you want offload all CPUs by default on boot.
 	  Say N here if you are unsure.
 
+config RCU_NOCB_CPU_CB_BOOST
+	bool "Offload RCU callback from real-time kthread"
+	depends on RCU_NOCB_CPU && RCU_BOOST
+	default y if PREEMPT_RT
+	help
+	  Use this option to invoke offloaded callbacks as SCHED_FIFO
+	  to avoid starvation by heavy SCHED_OTHER background load.
+	  Of course, running as SCHED_FIFO during callback floods will
+	  cause the rcuo[ps] kthreads to monopolize the CPU for hundreds
+	  of milliseconds or more.  Therefore, when enabling this option,
+	  it is your responsibility to ensure that latency-sensitive
+	  tasks either run with higher priority or run on some other CPU.
+
+	  Say Y here if you want to set RT priority for offloading kthreads.
+	  Say N here if you are building a !PREEMPT_RT kernel and are unsure.
+
 config TASKS_TRACE_RCU_READ_MB
 	bool "Tasks Trace RCU readers use memory barriers in user and idle"
 	depends on RCU_EXPERT && TASKS_TRACE_RCU
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 74455671e6cf2..3b9f45ebb4999 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -154,7 +154,11 @@ static void sync_sched_exp_online_cleanup(int cpu);
 static void check_cb_ovld_locked(struct rcu_data *rdp, struct rcu_node *rnp);
 static bool rcu_rdp_is_offloaded(struct rcu_data *rdp);
 
-/* rcuc/rcub/rcuop kthread realtime priority */
+/*
+ * rcuc/rcub/rcuop kthread realtime priority. The "rcuop"
+ * real-time priority(enabling/disabling) is controlled by
+ * the extra CONFIG_RCU_NOCB_CPU_CB_BOOST configuration.
+ */
 static int kthread_prio = IS_ENABLED(CONFIG_RCU_BOOST) ? 1 : 0;
 module_param(kthread_prio, int, 0444);
 
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 60cc92cc66552..fa8e4f82e60c0 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1315,8 +1315,9 @@ static void rcu_spawn_cpu_nocb_kthread(int cpu)
 	if (WARN_ONCE(IS_ERR(t), "%s: Could not start rcuo CB kthread, OOM is now expected behavior\n", __func__))
 		goto end;
 
-	if (kthread_prio)
+	if (IS_ENABLED(CONFIG_RCU_NOCB_CPU_CB_BOOST) && kthread_prio)
 		sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
+
 	WRITE_ONCE(rdp->nocb_cb_kthread, t);
 	WRITE_ONCE(rdp->nocb_gp_kthread, rdp_gp->nocb_gp_kthread);
 	return;
-- 
2.31.1.189.g2e36527f23

