Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D59DD472144
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 08:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbhLMHBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 02:01:06 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:29420 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230448AbhLMHBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 02:01:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1639378865; x=1670914865;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=3FY3fCWzD9sAw2TIOMfDe+NxjQSz+JlxGuoFvhy2Oh0=;
  b=wUhlDSupWSPHTYIkCUn330/GQ12UNxTvWvJT/2AaEXFN/5SuABiswCix
   6rSXba8+oyGB5OhfcG+cnzG/03Z6hPwD57st3ooJhrzu4F+vb12aPiAsW
   Ea2DLEM3PnmLmV8/LOn/SQnm6u75cmPBAUzkamUu+dK+5TU+s9+PFGJid
   8=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 12 Dec 2021 23:01:05 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2021 23:01:05 -0800
Received: from localhost (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Sun, 12 Dec
 2021 23:01:03 -0800
From:   Neeraj Upadhyay <quic_neeraju@quicinc.com>
To:     <paulmck@kernel.org>, <dwmw@amazon.co.uk>, <josh@joshtriplett.org>,
        <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
        <jiangshanlai@gmail.com>, <joel@joelfernandes.org>
CC:     <rcu@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <urezki@gmail.com>, <frederic@kernel.org>, <boqun.feng@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>
Subject: [PATCH] rcu: Make rcu_state.n_online_cpus updates atomic
Date:   Mon, 13 Dec 2021 12:30:59 +0530
Message-ID: <20211213070059.6381-1-quic_neeraju@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support onlining multiple CPUs concurrently,
change rcu_state.n_online_cpus updates to be atomic.
Note, it's ok for rcu_blocking_is_gp() to do a
atomic_read(&rcu_state.n_online_cpus), as the
value of .n_online_cpus switches from 1->2, in
rcutree_prepare_cpu(), which runs before the new
CPU comes online. Similarly 2->1 transition happens
from rcutree_dead_cpu(), which executes after the
CPU is offlined, and runs on the last online CPU.

Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
---
 kernel/rcu/tree.c | 6 +++---
 kernel/rcu/tree.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 3da7826865f7..c1db01c4ea39 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2460,7 +2460,7 @@ int rcutree_dead_cpu(unsigned int cpu)
 	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
 		return 0;
 
-	WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus - 1);
+	atomic_dec(&rcu_state.n_online_cpus);
 	/* Adjust any no-longer-needed kthreads. */
 	rcu_boost_kthread_setaffinity(rnp, -1);
 	// Stop-machine done, so allow nohz_full to disable tick.
@@ -3740,7 +3740,7 @@ static int rcu_blocking_is_gp(void)
 	 * in the code, without the need for additional memory barriers.
 	 * Those memory barriers are provided by CPU-hotplug code.
 	 */
-	ret = READ_ONCE(rcu_state.n_online_cpus) <= 1;
+	ret = atomic_read(&rcu_state.n_online_cpus) <= 1;
 	preempt_enable();
 	return ret;
 }
@@ -4199,7 +4199,7 @@ int rcutree_prepare_cpu(unsigned int cpu)
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	rcu_spawn_one_boost_kthread(rnp);
 	rcu_spawn_cpu_nocb_kthread(cpu);
-	WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus + 1);
+	atomic_inc(&rcu_state.n_online_cpus);
 
 	return 0;
 }
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 4b889081f4f4..f1017e7e1e9e 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -299,7 +299,7 @@ struct rcu_state {
 						/* Hierarchy levels (+1 to */
 						/*  shut bogus gcc warning) */
 	int ncpus;				/* # CPUs seen so far. */
-	int n_online_cpus;			/* # CPUs online for RCU. */
+	atomic_t n_online_cpus;			/* # CPUs online for RCU. */
 
 	/* The following fields are guarded by the root rcu_node's lock. */
 
-- 
2.17.1

