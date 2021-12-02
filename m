Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BECC465ADD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354631AbhLBAeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:34:46 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60084 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354214AbhLBAcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:32:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6757B821A4;
        Thu,  2 Dec 2021 00:29:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363D0C84002;
        Thu,  2 Dec 2021 00:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638404955;
        bh=wnWj9C/HY6SdM6WKhHvoIWPJ+tLMRpSzJCCtNJqaQZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r/IVs22gPTRomHZHaIDznab9J0FVzTU/JoOEX+JPZ1J8gLyOi7GsDtWDmiXauT2bU
         aj43zRIJYQwC1RlfoolUkdYOceftg0hQM+G5VIs+9d8tQLskrHTZwOKimD/AqjWe8O
         v6RF+IvxCvYvehLVbvLiyHOB5arRnxcFD5RRGsEc5UoUOPXYMtF+YUgC9i1P4Mj4xw
         FXMbovoRndk9lh66ZMmukEWf5kNQgMiyUd7iD+pU7so3oH9k3eq6M94CIqTJNchQy8
         zarVA7yqDxBFAK5GijjWprZmLS9FM08a5YKIgtBvTnEY/S6osuQlqTDBeIuV9MV0e5
         JloSC/Cy5K0uA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7C7F95C14CB; Wed,  1 Dec 2021 16:29:14 -0800 (PST)
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
Subject: [PATCH rcu 16/18] rcu/nocb: Create kthreads on all CPUs if "rcu_nocbs=" or "nohz_full=" are passed
Date:   Wed,  1 Dec 2021 16:29:10 -0800
Message-Id: <20211202002912.3127710-16-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202002848.GA3127439@paulmck-ThinkPad-P17-Gen-1>
References: <20211202002848.GA3127439@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

In order to be able to (de-)offload any CPU using cpusets in the future,
create the NOCB data structures for all possible CPUs.  For now this is
done only as long as the "rcu_nocbs=" or "nohz_full=" kernel parameters
are passed to avoid the unnecessary overhead for most users.

Note that the rcuog and rcuoc kthreads are not created until at least
one of the corresponding CPUs comes online.  This approach avoids the
creation of excess kthreads when firmware lies about the number of CPUs
present on the system.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Tested-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_nocb.h | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 42092de677054..f580a6b2e74e3 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1237,11 +1237,8 @@ static void rcu_spawn_one_nocb_kthread(int cpu)
 	struct rcu_data *rdp_gp;
 	struct task_struct *t;
 
-	/*
-	 * If this isn't a no-CBs CPU or if it already has an rcuo kthread,
-	 * then nothing to do.
-	 */
-	if (!rcu_is_nocb_cpu(cpu) || rdp->nocb_cb_kthread)
+	/* If there already is an rcuo kthread, then nothing to do. */
+	if (rdp->nocb_cb_kthread)
 		return;
 
 	/* If we didn't spawn the GP kthread first, reorganize! */
@@ -1269,7 +1266,7 @@ static void rcu_spawn_one_nocb_kthread(int cpu)
  */
 static void rcu_spawn_cpu_nocb_kthread(int cpu)
 {
-	if (rcu_scheduler_fully_active)
+	if (rcu_scheduler_fully_active && rcu_nocb_is_setup)
 		rcu_spawn_one_nocb_kthread(cpu);
 }
 
@@ -1319,7 +1316,7 @@ static void __init rcu_organize_nocb_kthreads(void)
 	 * Should the corresponding CPU come online in the future, then
 	 * we will spawn the needed set of rcu_nocb_kthread() kthreads.
 	 */
-	for_each_cpu(cpu, rcu_nocb_mask) {
+	for_each_possible_cpu(cpu) {
 		rdp = per_cpu_ptr(&rcu_data, cpu);
 		if (rdp->cpu >= nl) {
 			/* New GP kthread, set up for CBs & next GP. */
@@ -1343,7 +1340,8 @@ static void __init rcu_organize_nocb_kthreads(void)
 				pr_cont(" %d", cpu);
 		}
 		rdp->nocb_gp_rdp = rdp_gp;
-		list_add_tail(&rdp->nocb_entry_rdp, &rdp_gp->nocb_head_rdp);
+		if (cpumask_test_cpu(cpu, rcu_nocb_mask))
+			list_add_tail(&rdp->nocb_entry_rdp, &rdp_gp->nocb_head_rdp);
 	}
 	if (gotnocbs && dump_tree)
 		pr_cont("%s\n", gotnocbscbs ? "" : " (self only)");
-- 
2.31.1.189.g2e36527f23

