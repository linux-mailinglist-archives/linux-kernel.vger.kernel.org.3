Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B483465AD9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354453AbhLBAeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:34:14 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:51986 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354180AbhLBAcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:32:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2C9FBCE2142;
        Thu,  2 Dec 2021 00:29:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 179FEC5832F;
        Thu,  2 Dec 2021 00:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638404955;
        bh=beDapzlZgPoLwOnmgZM5CD7uAxWFWnmr6J+gEgPYz1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RrmtixT/+Zz/JBn6i5OKUrrcuc1K9kH8dfP9gYHaaekSzMr952hVEQmedeyDIbx0K
         18/ONPUdko6O1zxo0YY6Fc+vOKyzzGhK2NLsik9adNTlDzBMMGSQsq+xoJZxh9q447
         KQhBWlERrnOxpvGX2/+i3/bLf+3PruxJfCSHt5fUygHcviIdVNeqtQkWEs6cUIzaFu
         hyW0NPj5x1+bGwKaWagZviKc/J4jygRmTYVrbu6yefcnTdV66chr8i9xLa14MOmxEj
         /9yf9m9YvYU9V67qBa+Hq8AZnKYPQo4nPxn21uWpoihLAJkiHSghF6yz3p6OVrVM8p
         dISAnhl8DoJKw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 76B315C1412; Wed,  1 Dec 2021 16:29:14 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 13/18] rcu/nocb: Remove rcu_node structure from nocb list when de-offloaded
Date:   Wed,  1 Dec 2021 16:29:07 -0800
Message-Id: <20211202002912.3127710-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202002848.GA3127439@paulmck-ThinkPad-P17-Gen-1>
References: <20211202002848.GA3127439@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

The nocb_gp_wait() function iterates over all CPUs in its group,
including even those CPUs that have been de-offloaded.  This is of
course suboptimal, especially if none of the CPUs within the group are
currently offloaded.  This will become even more of a problem once a
nocb kthread is created for all possible CPUs.

Therefore use a standard double linked list to link all the offloaded
rcu_data structures and safely add or delete these structure as we
offload or de-offload them, respectively.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Tested-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.h      |  7 +++++--
 kernel/rcu/tree_nocb.h | 45 +++++++++++++++++++++++++++++++++++-------
 2 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 4f6c67b3ccd5e..5884380f4039c 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -227,8 +227,11 @@ struct rcu_data {
 	struct swait_queue_head nocb_gp_wq; /* For nocb kthreads to sleep on. */
 	bool nocb_cb_sleep;		/* Is the nocb CB thread asleep? */
 	struct task_struct *nocb_cb_kthread;
-	struct rcu_data *nocb_next_cb_rdp;
-					/* Next rcu_data in wakeup chain. */
+	struct list_head nocb_head_rdp; /*
+					 * Head of rcu_data list in wakeup chain,
+					 * if rdp_gp.
+					 */
+	struct list_head nocb_entry_rdp; /* rcu_data node in wakeup chain. */
 
 	/* The following fields are used by CB kthread, hence new cacheline. */
 	struct rcu_data *nocb_gp_rdp ____cacheline_internodealigned_in_smp;
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 2461fe8d0c23a..8e94a5344afed 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -625,7 +625,21 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 	 * and the global grace-period kthread are awakened if needed.
 	 */
 	WARN_ON_ONCE(my_rdp->nocb_gp_rdp != my_rdp);
-	for (rdp = my_rdp; rdp; rdp = rdp->nocb_next_cb_rdp) {
+	/*
+	 * An rcu_data structure is removed from the list after its
+	 * CPU is de-offloaded and added to the list before that CPU is
+	 * (re-)offloaded.  If the following loop happens to be referencing
+	 * that rcu_data structure during the time that the corresponding
+	 * CPU is de-offloaded and then immediately re-offloaded, this
+	 * loop's rdp pointer will be carried to the end of the list by
+	 * the resulting pair of list operations.  This can cause the loop
+	 * to skip over some of the rcu_data structures that were supposed
+	 * to have been scanned.  Fortunately a new iteration through the
+	 * entire loop is forced after a given CPU's rcu_data structure
+	 * is added to the list, so the skipped-over rcu_data structures
+	 * won't be ignored for long.
+	 */
+	list_for_each_entry_rcu(rdp, &my_rdp->nocb_head_rdp, nocb_entry_rdp, 1) {
 		bool needwake_state = false;
 
 		if (!nocb_gp_enabled_cb(rdp))
@@ -1003,6 +1017,8 @@ static long rcu_nocb_rdp_deoffload(void *arg)
 	swait_event_exclusive(rdp->nocb_state_wq,
 			      !rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB |
 							SEGCBLIST_KTHREAD_GP));
+	/* Stop nocb_gp_wait() from iterating over this structure. */
+	list_del_rcu(&rdp->nocb_entry_rdp);
 	/*
 	 * Lock one last time to acquire latest callback updates from kthreads
 	 * so we can later handle callbacks locally without locking.
@@ -1066,6 +1082,17 @@ static long rcu_nocb_rdp_offload(void *arg)
 		return -EINVAL;
 
 	pr_info("Offloading %d\n", rdp->cpu);
+
+	/*
+	 * Cause future nocb_gp_wait() invocations to iterate over
+	 * structure, resetting ->nocb_gp_sleep and waking up the related
+	 * "rcuog".  Since nocb_gp_wait() in turn locks ->nocb_gp_lock
+	 * before setting ->nocb_gp_sleep again, we are guaranteed to
+	 * iterate this newly added structure before "rcuog" goes to
+	 * sleep again.
+	 */
+	list_add_tail_rcu(&rdp->nocb_entry_rdp, &rdp->nocb_gp_rdp->nocb_head_rdp);
+
 	/*
 	 * Can't use rcu_nocb_lock_irqsave() before SEGCBLIST_LOCKING
 	 * is set.
@@ -1268,7 +1295,6 @@ static void __init rcu_organize_nocb_kthreads(void)
 	int nl = 0;  /* Next GP kthread. */
 	struct rcu_data *rdp;
 	struct rcu_data *rdp_gp = NULL;  /* Suppress misguided gcc warn. */
-	struct rcu_data *rdp_prev = NULL;
 
 	if (!cpumask_available(rcu_nocb_mask))
 		return;
@@ -1288,8 +1314,8 @@ static void __init rcu_organize_nocb_kthreads(void)
 			/* New GP kthread, set up for CBs & next GP. */
 			gotnocbs = true;
 			nl = DIV_ROUND_UP(rdp->cpu + 1, ls) * ls;
-			rdp->nocb_gp_rdp = rdp;
 			rdp_gp = rdp;
+			INIT_LIST_HEAD(&rdp->nocb_head_rdp);
 			if (dump_tree) {
 				if (!firsttime)
 					pr_cont("%s\n", gotnocbscbs
@@ -1302,12 +1328,11 @@ static void __init rcu_organize_nocb_kthreads(void)
 		} else {
 			/* Another CB kthread, link to previous GP kthread. */
 			gotnocbscbs = true;
-			rdp->nocb_gp_rdp = rdp_gp;
-			rdp_prev->nocb_next_cb_rdp = rdp;
 			if (dump_tree)
 				pr_cont(" %d", cpu);
 		}
-		rdp_prev = rdp;
+		rdp->nocb_gp_rdp = rdp_gp;
+		list_add_tail(&rdp->nocb_entry_rdp, &rdp_gp->nocb_head_rdp);
 	}
 	if (gotnocbs && dump_tree)
 		pr_cont("%s\n", gotnocbscbs ? "" : " (self only)");
@@ -1369,6 +1394,7 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
 {
 	char bufw[20];
 	char bufr[20];
+	struct rcu_data *nocb_next_rdp;
 	struct rcu_segcblist *rsclp = &rdp->cblist;
 	bool waslocked;
 	bool wassleep;
@@ -1376,11 +1402,16 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
 	if (rdp->nocb_gp_rdp == rdp)
 		show_rcu_nocb_gp_state(rdp);
 
+	nocb_next_rdp = list_next_or_null_rcu(&rdp->nocb_gp_rdp->nocb_head_rdp,
+					      &rdp->nocb_entry_rdp,
+					      typeof(*rdp),
+					      nocb_entry_rdp);
+
 	sprintf(bufw, "%ld", rsclp->gp_seq[RCU_WAIT_TAIL]);
 	sprintf(bufr, "%ld", rsclp->gp_seq[RCU_NEXT_READY_TAIL]);
 	pr_info("   CB %d^%d->%d %c%c%c%c%c%c F%ld L%ld C%d %c%c%s%c%s%c%c q%ld %c CPU %d%s\n",
 		rdp->cpu, rdp->nocb_gp_rdp->cpu,
-		rdp->nocb_next_cb_rdp ? rdp->nocb_next_cb_rdp->cpu : -1,
+		nocb_next_rdp ? nocb_next_rdp->cpu : -1,
 		"kK"[!!rdp->nocb_cb_kthread],
 		"bB"[raw_spin_is_locked(&rdp->nocb_bypass_lock)],
 		"cC"[!!atomic_read(&rdp->nocb_lock_contended)],
-- 
2.31.1.189.g2e36527f23

