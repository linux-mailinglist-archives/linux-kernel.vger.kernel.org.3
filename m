Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294D748D05D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 03:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbiAMCPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 21:15:45 -0500
Received: from ec2-13-52-33-57.us-west-1.compute.amazonaws.com ([13.52.33.57]:5569
        "EHLO aurora.tech" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231591AbiAMCPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 21:15:42 -0500
Received: by aurora.tech (Postfix, from userid 1001)
        id 5A0E116402F5; Tue, 11 Jan 2022 15:33:19 -0800 (PST)
From:   Alison Chaiken <achaiken@aurora.tech>
To:     tglx@linutronix.de
Cc:     peterz@infradead.org, paulmck@kernel.org,
        valentin.schneider@arm.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org, glenn@aurora.tech,
        alison@she-devel.com, Alison Chaiken <achaiken@aurora.tech>
Subject: [PATCH 2/4] RCU: make priority of grace-period thread consistent
Date:   Tue, 11 Jan 2022 15:32:51 -0800
Message-Id: <20220111233253.21692-3-achaiken@aurora.tech>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220111233253.21692-1-achaiken@aurora.tech>
References: <20220111233253.21692-1-achaiken@aurora.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The priority of RCU grace period threads is set to kthread_prio when
they are launched from rcu_spawn_gp_kthread().  The same is not true
of rcu_spawn_one_nocb_kthread().  Accordingly, add priority elevation
to rcu_spawn_one_nocb_kthread().

Signed-off-by: Alison Chaiken <achaiken@aurora.tech>
---
 kernel/rcu/tree_nocb.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 8fdf44f8523f..08b5c0042979 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1183,7 +1183,9 @@ static void rcu_spawn_one_nocb_kthread(int cpu)
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	struct rcu_data *rdp_gp;
 	struct task_struct *t;
+	struct sched_param sp;
 
+	sp.sched_priority = kthread_prio;
 	/*
 	 * If this isn't a no-CBs CPU or if it already has an rcuo kthread,
 	 * then nothing to do.
@@ -1199,6 +1201,8 @@ static void rcu_spawn_one_nocb_kthread(int cpu)
 		if (WARN_ONCE(IS_ERR(t), "%s: Could not start rcuo GP kthread, OOM is now expected behavior\n", __func__))
 			return;
 		WRITE_ONCE(rdp_gp->nocb_gp_kthread, t);
+		if (kthread_prio)
+			sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
 	}
 
 	/* Spawn the kthread for this CPU. */
-- 
2.32.0

