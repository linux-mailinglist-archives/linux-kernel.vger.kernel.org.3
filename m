Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAEC595C45
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 14:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbiHPMt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 08:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbiHPMti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:49:38 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1002591096;
        Tue, 16 Aug 2022 05:49:11 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M6W9C0r2wzlVpX;
        Tue, 16 Aug 2022 20:46:07 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 16 Aug 2022 20:49:09 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 16 Aug 2022 20:49:09 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        "Josh Triplett" <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, <rcu@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v3 1/2] rcu: Eliminate rcu_state.nocb_is_setup
Date:   Tue, 16 Aug 2022 20:48:38 +0800
Message-ID: <20220816124839.1911-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20220816124839.1911-1-thunder.leizhen@huawei.com>
References: <20220816124839.1911-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'rcu_state.nocb_is_setup' is initialized to true only if 'rcu_nocb_mask'
successfully allocates memory. So it can be replaced by
'cpumask_available(rcu_nocb_mask)'. More importantly, the latter is more
intuitive, and it has been used in several places.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 kernel/rcu/tree.h      | 1 -
 kernel/rcu/tree_nocb.h | 8 +++-----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index d4a97e40ea9c3e2..06f659c63d2d192 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -375,7 +375,6 @@ struct rcu_state {
 	arch_spinlock_t ofl_lock ____cacheline_internodealigned_in_smp;
 						/* Synchronize offline with */
 						/*  GP pre-initialization. */
-	int nocb_is_setup;			/* nocb is setup from boot */
 };
 
 /* Values for rcu_state structure's gp_flags field. */
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 0a5f0ef41484518..ff763e7dc53551f 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -69,7 +69,6 @@ static int __init rcu_nocb_setup(char *str)
 			cpumask_setall(rcu_nocb_mask);
 		}
 	}
-	rcu_state.nocb_is_setup = true;
 	return 1;
 }
 __setup("rcu_nocbs", rcu_nocb_setup);
@@ -1215,7 +1214,7 @@ void __init rcu_init_nohz(void)
 	struct rcu_data *rdp;
 
 #if defined(CONFIG_RCU_NOCB_CPU_DEFAULT_ALL)
-	if (!rcu_state.nocb_is_setup) {
+	if (!cpumask_available(rcu_nocb_mask)) {
 		need_rcu_nocb_mask = true;
 		offload_all = true;
 	}
@@ -1235,10 +1234,9 @@ void __init rcu_init_nohz(void)
 				return;
 			}
 		}
-		rcu_state.nocb_is_setup = true;
 	}
 
-	if (!rcu_state.nocb_is_setup)
+	if (!cpumask_available(rcu_nocb_mask))
 		return;
 
 #if defined(CONFIG_NO_HZ_FULL)
@@ -1299,7 +1297,7 @@ static void rcu_spawn_cpu_nocb_kthread(int cpu)
 	struct task_struct *t;
 	struct sched_param sp;
 
-	if (!rcu_scheduler_fully_active || !rcu_state.nocb_is_setup)
+	if (!rcu_scheduler_fully_active || !cpumask_available(rcu_nocb_mask))
 		return;
 
 	/* If there already is an rcuo kthread, then nothing to do. */
-- 
2.25.1

