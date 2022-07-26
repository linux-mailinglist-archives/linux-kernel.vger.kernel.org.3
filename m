Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0094580E3D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 09:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238490AbiGZHtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 03:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238141AbiGZHto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:49:44 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF062A418
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:49:42 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LsTYW1G1Xz9svY;
        Tue, 26 Jul 2022 15:48:31 +0800 (CST)
Received: from localhost.localdomain (10.67.164.66) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Jul 2022 15:49:39 +0800
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
Subject: [PATCH v6 1/2] sched: Add per_cpu cluster domain info and cpus_share_lowest_cache API
Date:   Tue, 26 Jul 2022 15:47:57 +0800
Message-ID: <20220726074758.46686-2-yangyicong@huawei.com>
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

Add per-cpu cluster domain info and cpus_share_lowest_cache() API.
This is the preparation for the optimization of select_idle_cpu()
on platforms with cluster scheduler level.

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 include/linux/sched/sd_flags.h |  7 +++++++
 include/linux/sched/topology.h |  8 +++++++-
 kernel/sched/core.c            | 12 ++++++++++++
 kernel/sched/sched.h           |  2 ++
 kernel/sched/topology.c        | 15 +++++++++++++++
 5 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
index 57bde66d95f7..42ed454e8b18 100644
--- a/include/linux/sched/sd_flags.h
+++ b/include/linux/sched/sd_flags.h
@@ -109,6 +109,13 @@ SD_FLAG(SD_ASYM_CPUCAPACITY_FULL, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
  */
 SD_FLAG(SD_SHARE_CPUCAPACITY, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
 
+/*
+ * Domain members share CPU cluster (LLC tags or L2 cache)
+ *
+ * NEEDS_GROUPS: Clusters are shared between groups.
+ */
+SD_FLAG(SD_CLUSTER, SDF_NEEDS_GROUPS)
+
 /*
  * Domain members share CPU package resources (i.e. caches)
  *
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 816df6cc444e..c0d21667ddf3 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -45,7 +45,7 @@ static inline int cpu_smt_flags(void)
 #ifdef CONFIG_SCHED_CLUSTER
 static inline int cpu_cluster_flags(void)
 {
-	return SD_SHARE_PKG_RESOURCES;
+	return SD_CLUSTER | SD_SHARE_PKG_RESOURCES;
 }
 #endif
 
@@ -179,6 +179,7 @@ cpumask_var_t *alloc_sched_domains(unsigned int ndoms);
 void free_sched_domains(cpumask_var_t doms[], unsigned int ndoms);
 
 bool cpus_share_cache(int this_cpu, int that_cpu);
+bool cpus_share_lowest_cache(int this_cpu, int that_cpu);
 
 typedef const struct cpumask *(*sched_domain_mask_f)(int cpu);
 typedef int (*sched_domain_flags_f)(void);
@@ -232,6 +233,11 @@ static inline bool cpus_share_cache(int this_cpu, int that_cpu)
 	return true;
 }
 
+static inline bool cpus_share_lowest_cache(int this_cpu, int that_cpu)
+{
+	return true;
+}
+
 #endif	/* !CONFIG_SMP */
 
 #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a463dbc92fcd..96109ad82694 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3802,6 +3802,18 @@ bool cpus_share_cache(int this_cpu, int that_cpu)
 	return per_cpu(sd_llc_id, this_cpu) == per_cpu(sd_llc_id, that_cpu);
 }
 
+/*
+ * Whether CPUs are share lowest cache, which means LLC on non-cluster
+ * machines and LLC tag or L2 on machines with clusters.
+ */
+bool cpus_share_lowest_cache(int this_cpu, int that_cpu)
+{
+	if (this_cpu == that_cpu)
+		return true;
+
+	return per_cpu(sd_lowest_cache_id, this_cpu) == per_cpu(sd_lowest_cache_id, that_cpu);
+}
+
 static inline bool ttwu_queue_cond(int cpu)
 {
 	/*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 73ae32898f25..845cd029d572 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1802,7 +1802,9 @@ static inline struct sched_domain *lowest_flag_domain(int cpu, int flag)
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_llc);
 DECLARE_PER_CPU(int, sd_llc_size);
 DECLARE_PER_CPU(int, sd_llc_id);
+DECLARE_PER_CPU(int, sd_lowest_cache_id);
 DECLARE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
+DECLARE_PER_CPU(struct sched_domain __rcu *, sd_cluster);
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_numa);
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 8739c2a5a54e..8ab27c0d6d1f 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -664,6 +664,8 @@ static void destroy_sched_domains(struct sched_domain *sd)
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_llc);
 DEFINE_PER_CPU(int, sd_llc_size);
 DEFINE_PER_CPU(int, sd_llc_id);
+DEFINE_PER_CPU(int, sd_lowest_cache_id);
+DEFINE_PER_CPU(struct sched_domain __rcu *, sd_cluster);
 DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
@@ -689,6 +691,18 @@ static void update_top_cache_domain(int cpu)
 	per_cpu(sd_llc_id, cpu) = id;
 	rcu_assign_pointer(per_cpu(sd_llc_shared, cpu), sds);
 
+	sd = lowest_flag_domain(cpu, SD_CLUSTER);
+	if (sd)
+		id = cpumask_first(sched_domain_span(sd));
+	rcu_assign_pointer(per_cpu(sd_cluster, cpu), sd);
+
+	/*
+	 * This assignment should be placed after the sd_llc_id as
+	 * we want this id equals to cluster id on cluster machines
+	 * but equals to LLC id on non-Cluster machines.
+	 */
+	per_cpu(sd_lowest_cache_id, cpu) = id;
+
 	sd = lowest_flag_domain(cpu, SD_NUMA);
 	rcu_assign_pointer(per_cpu(sd_numa, cpu), sd);
 
@@ -1532,6 +1546,7 @@ static struct cpumask		***sched_domains_numa_masks;
  */
 #define TOPOLOGY_SD_FLAGS		\
 	(SD_SHARE_CPUCAPACITY	|	\
+	 SD_CLUSTER		|	\
 	 SD_SHARE_PKG_RESOURCES |	\
 	 SD_NUMA		|	\
 	 SD_ASYM_PACKING)
-- 
2.24.0

