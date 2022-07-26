Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C81580E3C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 09:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238484AbiGZHtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 03:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238114AbiGZHto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:49:44 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965FE2A422
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:49:42 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LsTYW3VW9z9svw;
        Tue, 26 Jul 2022 15:48:31 +0800 (CST)
Received: from localhost.localdomain (10.67.164.66) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Jul 2022 15:49:40 +0800
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
Subject: [PATCH v6 2/2] sched/fair: Scan cluster before scanning LLC in wake-up path
Date:   Tue, 26 Jul 2022 15:47:58 +0800
Message-ID: <20220726074758.46686-3-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220726074758.46686-1-yangyicong@huawei.com>
References: <20220726074758.46686-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
                     tip/sched/core                 patched
Hmean     1        345.89 (   0.00%)      398.43 *  15.19%*
Hmean     2        697.77 (   0.00%)      794.40 *  13.85%*
Hmean     4       1392.51 (   0.00%)     1577.60 *  13.29%*
Hmean     8       2800.61 (   0.00%)     3118.38 *  11.35%*
Hmean     16      5514.27 (   0.00%)     6124.51 *  11.07%*
Hmean     32     10869.81 (   0.00%)    10690.97 *  -1.65%*
Hmean     64      8315.22 (   0.00%)     8520.73 *   2.47%*
Hmean     128     6324.47 (   0.00%)     7253.65 *  14.69%*

On numa 0-1:
                     tip/sched/core                 patched
Hmean     1        348.68 (   0.00%)      397.74 *  14.07%*
Hmean     2        693.57 (   0.00%)      795.54 *  14.70%*
Hmean     4       1369.26 (   0.00%)     1548.72 *  13.11%*
Hmean     8       2772.99 (   0.00%)     3055.54 *  10.19%*
Hmean     16      4825.83 (   0.00%)     5936.64 *  23.02%*
Hmean     32     10250.32 (   0.00%)    11780.59 *  14.93%*
Hmean     64     16309.51 (   0.00%)    19864.38 *  21.80%*
Hmean     128    13022.32 (   0.00%)    16365.43 *  25.67%*
Hmean     256    11335.79 (   0.00%)    13991.33 *  23.43%*

Note neither Kunpeng920 nor x86 Jacobsville supports SMT, so the SMT branch
in the code has not been tested but it supposed to work.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
[https://lore.kernel.org/lkml/Ytfjs+m1kUs0ScSn@worktop.programming.kicks-ass.net]
Tested-by: Yicong Yang <yangyicong@hisilicon.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c     | 31 ++++++++++++++++++++++++++++---
 kernel/sched/sched.h    |  2 ++
 kernel/sched/topology.c | 10 ++++++++++
 3 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2fc47257ae91..1100fbf7baaf 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6437,6 +6437,31 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 		}
 	}
 
+	if (IS_ENABLED(CONFIG_SCHED_CLUSTER) &&
+	    static_branch_unlikely(&sched_cluster_active)) {
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
@@ -6444,7 +6469,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 				return i;
 
 		} else {
-			if (!--nr)
+			if (--nr <= 0)
 				return -1;
 			idle_cpu = __select_idle_cpu(cpu, p);
 			if ((unsigned int)idle_cpu < nr_cpumask_bits)
@@ -6543,7 +6568,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	/*
 	 * If the previous CPU is cache affine and idle, don't be stupid:
 	 */
-	if (prev != target && cpus_share_cache(prev, target) &&
+	if (prev != target && cpus_share_lowest_cache(prev, target) &&
 	    (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
 	    asym_fits_capacity(task_util, prev))
 		return prev;
@@ -6569,7 +6594,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	p->recent_used_cpu = prev;
 	if (recent_used_cpu != prev &&
 	    recent_used_cpu != target &&
-	    cpus_share_cache(recent_used_cpu, target) &&
+	    cpus_share_lowest_cache(recent_used_cpu, target) &&
 	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
 	    cpumask_test_cpu(p->recent_used_cpu, p->cpus_ptr) &&
 	    asym_fits_capacity(task_util, recent_used_cpu)) {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 845cd029d572..4f0d3a74a532 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1808,7 +1808,9 @@ DECLARE_PER_CPU(struct sched_domain __rcu *, sd_cluster);
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

