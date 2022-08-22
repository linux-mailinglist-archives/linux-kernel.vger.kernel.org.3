Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C91759BA65
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 09:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiHVHia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 03:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233287AbiHVHiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 03:38:17 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610A9D62
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 00:38:15 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MB3yD3yrFzXdhw;
        Mon, 22 Aug 2022 15:33:56 +0800 (CST)
Received: from localhost.localdomain (10.67.164.66) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 22 Aug 2022 15:38:12 +0800
From:   Yicong Yang <yangyicong@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <tim.c.chen@linux.intel.com>, <gautham.shenoy@amd.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <bristot@redhat.com>,
        <prime.zeng@huawei.com>, <yangyicong@hisilicon.com>,
        <jonathan.cameron@huawei.com>, <ego@linux.vnet.ibm.com>,
        <srikar@linux.vnet.ibm.com>, <linuxarm@huawei.com>,
        <21cnbao@gmail.com>, <guodong.xu@linaro.org>,
        <hesham.almatary@huawei.com>, <john.garry@huawei.com>,
        <shenyang39@huawei.com>, <kprateek.nayak@amd.com>,
        <yu.c.chen@intel.com>, <wuyun.abel@bytedance.com>
Subject: [PATCH v7 2/2] sched/fair: Scan cluster before scanning LLC in wake-up path
Date:   Mon, 22 Aug 2022 15:36:10 +0800
Message-ID: <20220822073610.27205-3-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220822073610.27205-1-yangyicong@huawei.com>
References: <20220822073610.27205-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Barry Song <song.bao.hua@hisilicon.com>

For platforms having clusters like Kunpeng920, CPUs within the same cluster
have lower latency when synchronizing and accessing shared resources like
cache. Thus, this patch tries to find an idle cpu within the cluster of the
target CPU before scanning the whole LLC to gain lower latency.

Testing has been done on Kunpeng920 by pinning tasks to one numa and two
numa. On Kunpeng920, Each numa has 8 clusters and each cluster has 4 CPUs.

With this patch, We noticed enhancement on tbench within one numa or cross
two numa.

On numa 0:
                             6.0-rc1                patched
Hmean     1        351.20 (   0.00%)      396.45 *  12.88%*
Hmean     2        700.43 (   0.00%)      793.76 *  13.32%*
Hmean     4       1404.42 (   0.00%)     1583.62 *  12.76%*
Hmean     8       2833.31 (   0.00%)     3147.85 *  11.10%*
Hmean     16      5501.90 (   0.00%)     6089.89 *  10.69%*
Hmean     32     10428.59 (   0.00%)    10619.63 *   1.83%*
Hmean     64      8223.39 (   0.00%)     8306.93 *   1.02%*
Hmean     128     7042.88 (   0.00%)     7068.03 *   0.36%*

On numa 0-1:
                             6.0-rc1                patched
Hmean     1        363.06 (   0.00%)      397.13 *   9.38%*
Hmean     2        721.68 (   0.00%)      789.84 *   9.44%*
Hmean     4       1435.15 (   0.00%)     1566.01 *   9.12%*
Hmean     8       2776.17 (   0.00%)     3007.05 *   8.32%*
Hmean     16      5471.71 (   0.00%)     6103.91 *  11.55%*
Hmean     32     10164.98 (   0.00%)    11531.81 *  13.45%*
Hmean     64     17143.28 (   0.00%)    20078.68 *  17.12%*
Hmean     128    14552.70 (   0.00%)    15156.41 *   4.15%*
Hmean     256    12827.37 (   0.00%)    13326.86 *   3.89%*

Note neither Kunpeng920 nor x86 Jacobsville supports SMT, so the SMT branch
in the code has not been tested but it supposed to work.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
[https://lore.kernel.org/lkml/Ytfjs+m1kUs0ScSn@worktop.programming.kicks-ass.net]
Tested-by: Yicong Yang <yangyicong@hisilicon.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c     | 30 +++++++++++++++++++++++++++---
 kernel/sched/sched.h    |  2 ++
 kernel/sched/topology.c | 10 ++++++++++
 3 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 914096c5b1ae..6fa77610d0f5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6437,6 +6437,30 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 		}
 	}
 
+	if (static_branch_unlikely(&sched_cluster_active)) {
+		struct sched_domain *sdc = rcu_dereference(per_cpu(sd_cluster, target));
+
+		if (sdc) {
+			for_each_cpu_wrap(cpu, sched_domain_span(sdc), target + 1) {
+				if (!cpumask_test_cpu(cpu, cpus))
+					continue;
+
+				if (has_idle_core) {
+					i = select_idle_core(p, cpu, cpus, &idle_cpu);
+					if ((unsigned int)i < nr_cpumask_bits)
+						return i;
+				} else {
+					if (--nr <= 0)
+						return -1;
+					idle_cpu = __select_idle_cpu(cpu, p);
+					if ((unsigned int)idle_cpu < nr_cpumask_bits)
+						return idle_cpu;
+				}
+			}
+			cpumask_andnot(cpus, cpus, sched_domain_span(sdc));
+		}
+	}
+
 	for_each_cpu_wrap(cpu, cpus, target + 1) {
 		if (has_idle_core) {
 			i = select_idle_core(p, cpu, cpus, &idle_cpu);
@@ -6444,7 +6468,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 				return i;
 
 		} else {
-			if (!--nr)
+			if (--nr <= 0)
 				return -1;
 			idle_cpu = __select_idle_cpu(cpu, p);
 			if ((unsigned int)idle_cpu < nr_cpumask_bits)
@@ -6543,7 +6567,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	/*
 	 * If the previous CPU is cache affine and idle, don't be stupid:
 	 */
-	if (prev != target && cpus_share_cache(prev, target) &&
+	if (prev != target && cpus_share_lowest_cache(prev, target) &&
 	    (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
 	    asym_fits_capacity(task_util, prev))
 		return prev;
@@ -6569,7 +6593,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	p->recent_used_cpu = prev;
 	if (recent_used_cpu != prev &&
 	    recent_used_cpu != target &&
-	    cpus_share_cache(recent_used_cpu, target) &&
+	    cpus_share_lowest_cache(recent_used_cpu, target) &&
 	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
 	    cpumask_test_cpu(p->recent_used_cpu, p->cpus_ptr) &&
 	    asym_fits_capacity(task_util, recent_used_cpu)) {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e9f0935605e2..60e8a91e29d1 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1815,7 +1815,9 @@ DECLARE_PER_CPU(struct sched_domain __rcu *, sd_cluster);
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_numa);
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
+
 extern struct static_key_false sched_asym_cpucapacity;
+extern struct static_key_false sched_cluster_active;
 
 struct sched_group_capacity {
 	atomic_t		ref;
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 8ab27c0d6d1f..04ead3227201 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -670,7 +670,9 @@ DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
+
 DEFINE_STATIC_KEY_FALSE(sched_asym_cpucapacity);
+DEFINE_STATIC_KEY_FALSE(sched_cluster_active);
 
 static void update_top_cache_domain(int cpu)
 {
@@ -2268,6 +2270,7 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 	struct rq *rq = NULL;
 	int i, ret = -ENOMEM;
 	bool has_asym = false;
+	bool has_cluster = false;
 
 	if (WARN_ON(cpumask_empty(cpu_map)))
 		goto error;
@@ -2289,6 +2292,7 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 			sd = build_sched_domain(tl, cpu_map, attr, sd, i);
 
 			has_asym |= sd->flags & SD_ASYM_CPUCAPACITY;
+			has_cluster |= sd->flags & SD_CLUSTER;
 
 			if (tl == sched_domain_topology)
 				*per_cpu_ptr(d.sd, i) = sd;
@@ -2399,6 +2403,9 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 	if (has_asym)
 		static_branch_inc_cpuslocked(&sched_asym_cpucapacity);
 
+	if (has_cluster)
+		static_branch_inc_cpuslocked(&sched_cluster_active);
+
 	if (rq && sched_debug_verbose) {
 		pr_info("root domain span: %*pbl (max cpu_capacity = %lu)\n",
 			cpumask_pr_args(cpu_map), rq->rd->max_cpu_capacity);
@@ -2498,6 +2505,9 @@ static void detach_destroy_domains(const struct cpumask *cpu_map)
 	if (rcu_access_pointer(per_cpu(sd_asym_cpucapacity, cpu)))
 		static_branch_dec_cpuslocked(&sched_asym_cpucapacity);
 
+	if (rcu_access_pointer(per_cpu(sd_cluster, cpu)))
+		static_branch_dec_cpuslocked(&sched_cluster_active);
+
 	rcu_read_lock();
 	for_each_cpu(i, cpu_map)
 		cpu_attach_domain(NULL, &def_root_domain, i);
-- 
2.24.0

