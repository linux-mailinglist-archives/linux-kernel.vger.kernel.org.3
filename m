Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76A15A9857
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbiIANTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234346AbiIANSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:18:51 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CDF5C9C4;
        Thu,  1 Sep 2022 06:16:05 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MJM0M1hJJzlWh9;
        Thu,  1 Sep 2022 21:12:35 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 1 Sep 2022 21:16:01 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 1 Sep 2022 21:16:00 +0800
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
Subject: [PATCH v6 1/2] rcu: Simplify rcu_init_nohz() cpumask handling
Date:   Thu, 1 Sep 2022 21:14:35 +0800
Message-ID: <20220901131436.986-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20220901131436.986-1-thunder.leizhen@huawei.com>
References: <20220901131436.986-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

In kernels built with either CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y or
CONFIG_NO_HZ_FULL=y, additional CPUs must be added to rcu_nocb_mask.
Except that kernels booted without the rcu_nocbs= will not have
allocated rcu_nocb_mask.  And the current rcu_init_nohz() function uses
its need_rcu_nocb_mask and offload_all local variables to track the
rcu_nocb and nohz_full state.

But there is a much simpler approach, namely creating a cpumask pointer
to track the default and then using cpumask_available() to check the
rcu_nocb_mask state.  This commit takes this approach, thereby simplifying
and shortening the rcu_init_nohz() function.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree_nocb.h | 35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 0a5f0ef41484518..8b6dceeabde0b4d 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1210,45 +1210,34 @@ EXPORT_SYMBOL_GPL(rcu_nocb_cpu_offload);
 void __init rcu_init_nohz(void)
 {
 	int cpu;
-	bool need_rcu_nocb_mask = false;
-	bool offload_all = false;
 	struct rcu_data *rdp;
-
-#if defined(CONFIG_RCU_NOCB_CPU_DEFAULT_ALL)
-	if (!rcu_state.nocb_is_setup) {
-		need_rcu_nocb_mask = true;
-		offload_all = true;
-	}
-#endif /* #if defined(CONFIG_RCU_NOCB_CPU_DEFAULT_ALL) */
+	const struct cpumask *cpumask = NULL;
 
 #if defined(CONFIG_NO_HZ_FULL)
-	if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask)) {
-		need_rcu_nocb_mask = true;
-		offload_all = false; /* NO_HZ_FULL has its own mask. */
-	}
-#endif /* #if defined(CONFIG_NO_HZ_FULL) */
+	if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask))
+		cpumask = tick_nohz_full_mask;
+#endif
+
+#if defined(CONFIG_RCU_NOCB_CPU_DEFAULT_ALL)
+	if (!rcu_state.nocb_is_setup && !cpumask)
+		cpumask = cpu_possible_mask;
+#endif
 
-	if (need_rcu_nocb_mask) {
+	if (cpumask) {
 		if (!cpumask_available(rcu_nocb_mask)) {
 			if (!zalloc_cpumask_var(&rcu_nocb_mask, GFP_KERNEL)) {
 				pr_info("rcu_nocb_mask allocation failed, callback offloading disabled.\n");
 				return;
 			}
 		}
+
+		cpumask_or(rcu_nocb_mask, rcu_nocb_mask, cpumask);
 		rcu_state.nocb_is_setup = true;
 	}
 
 	if (!rcu_state.nocb_is_setup)
 		return;
 
-#if defined(CONFIG_NO_HZ_FULL)
-	if (tick_nohz_full_running)
-		cpumask_or(rcu_nocb_mask, rcu_nocb_mask, tick_nohz_full_mask);
-#endif /* #if defined(CONFIG_NO_HZ_FULL) */
-
-	if (offload_all)
-		cpumask_setall(rcu_nocb_mask);
-
 	if (!cpumask_subset(rcu_nocb_mask, cpu_possible_mask)) {
 		pr_info("\tNote: kernel parameter 'rcu_nocbs=', 'nohz_full', or 'isolcpus=' contains nonexistent CPUs.\n");
 		cpumask_and(rcu_nocb_mask, cpu_possible_mask,
-- 
2.25.1

