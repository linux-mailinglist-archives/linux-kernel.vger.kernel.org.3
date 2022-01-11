Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9276248D05B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 03:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbiAMCPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 21:15:16 -0500
Received: from ec2-13-52-33-57.us-west-1.compute.amazonaws.com ([13.52.33.57]:36229
        "EHLO aurora.tech" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231528AbiAMCPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 21:15:12 -0500
Received: by aurora.tech (Postfix, from userid 1001)
        id 6104416402F7; Tue, 11 Jan 2022 15:33:22 -0800 (PST)
From:   Alison Chaiken <achaiken@aurora.tech>
To:     tglx@linutronix.de
Cc:     peterz@infradead.org, paulmck@kernel.org,
        valentin.schneider@arm.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org, glenn@aurora.tech,
        alison@she-devel.com, Alison Chaiken <achaiken@aurora.tech>
Subject: [PATCH 3/4] RCU: elevate priority of offloaded callback threads
Date:   Tue, 11 Jan 2022 15:32:52 -0800
Message-Id: <20220111233253.21692-4-achaiken@aurora.tech>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220111233253.21692-1-achaiken@aurora.tech>
References: <20220111233253.21692-1-achaiken@aurora.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_PREEMPT_RT=y, the rcutree.kthread_prio command-line
parameter signals initialization code to boost the priority of rcuc
callbacks to the designated value.  With the additional
CONFIG_RCU_NOCB_CPU=y configuration and an additional rcu_nocbs
command-line parameter, the callbacks on the listed cores are
offloaded to new rcuop threads that are not pinned to the cores whose
post-grace-period work is performed.  While the rcuop threads perform
the same function as the rcuc threads they offload, the kthread_prio
parameter only boosts the priority of the rcuc threads.  Fix this
inconsistency by elevating rcuop threads to the same priority as rcuc
ones.

Signed-off-by: Alison Chaiken <achaiken@aurora.tech>
---
 kernel/rcu/tree.c      | 2 +-
 kernel/rcu/tree_nocb.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 15cabb288a1c..ba9eaa9a72b0 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -153,7 +153,7 @@ static void sync_sched_exp_online_cleanup(int cpu);
 static void check_cb_ovld_locked(struct rcu_data *rdp, struct rcu_node *rnp);
 static bool rcu_rdp_is_offloaded(struct rcu_data *rdp);
 
-/* rcuc/rcub kthread realtime priority */
+/* rcuc/rcub/rcuop kthread realtime priority */
 static int kthread_prio = IS_ENABLED(CONFIG_RCU_BOOST) ? 1 : 0;
 module_param(kthread_prio, int, 0444);
 
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 08b5c0042979..3343e42685dc 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1210,6 +1210,9 @@ static void rcu_spawn_one_nocb_kthread(int cpu)
 			"rcuo%c/%d", rcu_state.abbr, cpu);
 	if (WARN_ONCE(IS_ERR(t), "%s: Could not start rcuo CB kthread, OOM is now expected behavior\n", __func__))
 		return;
+
+	if (kthread_prio)
+		sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
 	WRITE_ONCE(rdp->nocb_cb_kthread, t);
 	WRITE_ONCE(rdp->nocb_gp_kthread, rdp_gp->nocb_gp_kthread);
 }
-- 
2.32.0

