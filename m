Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB6C4714D7
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 18:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbhLKRBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 12:01:50 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:6878 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230329AbhLKRBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 12:01:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1639242110; x=1670778110;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=kc4ChivxnKqTtqShprBba873IHUEimnTHtXQZYmU6UA=;
  b=COR4TfFsAZMWS4ugmTZGGfvq+eYQVHoLY3u834cP21qWJT58zXs3FZKG
   nS7ekQ9iMDouuPjRo1N9TmO3xOrgg+QkeeaoW69+PD1niRXOn3BFB0e7B
   3+kJTR9QCsuN+2a4k6E3xAJjs61+WdCJhxWX8j3+tyECrs+nsGWZwRvtv
   U=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 11 Dec 2021 09:01:50 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2021 09:01:49 -0800
Received: from localhost (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Sat, 11 Dec
 2021 09:01:48 -0800
From:   Neeraj Upadhyay <quic_neeraju@quicinc.com>
To:     <paulmck@kernel.org>, <frederic@kernel.org>, <dwmw@amazon.co.uk>,
        <josh@joshtriplett.org>, <rostedt@goodmis.org>,
        <mathieu.desnoyers@efficios.com>, <jiangshanlai@gmail.com>,
        <joel@joelfernandes.org>
CC:     <rcu@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <urezki@gmail.com>, <boqun.feng@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>
Subject: [PATCH v2] rcu/nocb: Handle concurrent nocb kthreads creation
Date:   Sat, 11 Dec 2021 22:31:39 +0530
Message-ID: <20211211170139.27711-1-quic_neeraju@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When multiple CPUs in the same nocb gp/cb group concurrently
come online, they might try to concurrently create the same
rcuog kthread. Fix this by using nocb gp CPU's spawn mutex to
provide mutual exclusion for the rcuog kthread creation code.

Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
---
Change in v2:
 Fix missing mutex_unlock in nocb gp kthread creation err path.

 kernel/rcu/tree.h      | 2 ++
 kernel/rcu/tree_nocb.h | 7 ++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 4b889081f4f4..9815b7844e58 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -204,6 +204,8 @@ struct rcu_data {
 	int nocb_defer_wakeup;		/* Defer wakeup of nocb_kthread. */
 	struct timer_list nocb_timer;	/* Enforce finite deferral. */
 	unsigned long nocb_gp_adv_time;	/* Last call_rcu() CB adv (jiffies). */
+	struct mutex nocb_gp_kthread_mutex; /* Exclusion for nocb gp kthread */
+					    /* spawning */
 
 	/* The following fields are used by call_rcu, hence own cacheline. */
 	raw_spinlock_t nocb_bypass_lock ____cacheline_internodealigned_in_smp;
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index eeafb546a7a0..dd4753219dca 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1226,6 +1226,7 @@ static void __init rcu_boot_init_nocb_percpu_data(struct rcu_data *rdp)
 	raw_spin_lock_init(&rdp->nocb_gp_lock);
 	timer_setup(&rdp->nocb_timer, do_nocb_deferred_wakeup_timer, 0);
 	rcu_cblist_init(&rdp->nocb_bypass);
+	mutex_init(&rdp->nocb_gp_kthread_mutex);
 }
 
 /*
@@ -1248,13 +1249,17 @@ static void rcu_spawn_cpu_nocb_kthread(int cpu)
 
 	/* If we didn't spawn the GP kthread first, reorganize! */
 	rdp_gp = rdp->nocb_gp_rdp;
+	mutex_lock(&rdp_gp->nocb_gp_kthread_mutex);
 	if (!rdp_gp->nocb_gp_kthread) {
 		t = kthread_run(rcu_nocb_gp_kthread, rdp_gp,
 				"rcuog/%d", rdp_gp->cpu);
-		if (WARN_ONCE(IS_ERR(t), "%s: Could not start rcuo GP kthread, OOM is now expected behavior\n", __func__))
+		if (WARN_ONCE(IS_ERR(t), "%s: Could not start rcuo GP kthread, OOM is now expected behavior\n", __func__)) {
+			mutex_unlock(&rdp_gp->nocb_gp_kthread_mutex);
 			return;
+		}
 		WRITE_ONCE(rdp_gp->nocb_gp_kthread, t);
 	}
+	 mutex_unlock(&rdp_gp->nocb_gp_kthread_mutex);
 
 	/* Spawn the kthread for this CPU. */
 	t = kthread_run(rcu_nocb_cb_kthread, rdp,
-- 
2.17.1

