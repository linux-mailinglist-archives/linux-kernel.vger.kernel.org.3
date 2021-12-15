Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F152475199
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 05:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235754AbhLOEMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 23:12:03 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:15739 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbhLOEL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 23:11:58 -0500
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JDMF50S2bzZdfD;
        Wed, 15 Dec 2021 12:08:57 +0800 (CST)
Received: from localhost.localdomain (10.67.165.103) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 12:11:56 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <tim.c.chen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <bristot@redhat.com>,
        <prime.zeng@huawei.com>, <yangyicong@hisilicon.com>,
        <jonathan.cameron@huawei.com>, <ego@linux.vnet.ibm.com>,
        <srikar@linux.vnet.ibm.com>, <linuxarm@huawei.com>,
        <21cnbao@gmail.com>, <song.bao.hua@hisilicon.com>,
        <guodong.xu@linaro.org>
Subject: [PATCH 1/2] sched: Add per_cpu cluster domain info and cpus_share_cluster API
Date:   Wed, 15 Dec 2021 12:11:48 +0800
Message-ID: <20211215041149.73171-2-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211215041149.73171-1-yangyicong@hisilicon.com>
References: <20211215041149.73171-1-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.103]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Barry Song <song.bao.hua@hisilicon.com>

Add per-cpu cluster domain info and cpus_share_cluster() API.
This is the preparation for the optimization of select_idle_cpu()
on platforms with cluster scheduler level.

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 include/linux/sched/sd_flags.h |  5 +++++
 include/linux/sched/topology.h |  8 +++++++-
 kernel/sched/core.c            | 12 ++++++++++++
 kernel/sched/sched.h           |  2 ++
 kernel/sched/topology.c        |  9 +++++++++
 5 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
index 57bde66d95f7..0f732bcfbb2c 100644
--- a/include/linux/sched/sd_flags.h
+++ b/include/linux/sched/sd_flags.h
@@ -109,6 +109,11 @@ SD_FLAG(SD_ASYM_CPUCAPACITY_FULL, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
  */
 SD_FLAG(SD_SHARE_CPUCAPACITY, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
 
+/*
+ * Set up for cluster domains sharing resources such as llc tags or l2
+ */
+SD_FLAG(SD_CLUSTER, SDF_NEEDS_GROUPS)
+
 /*
  * Domain members share CPU package resources (i.e. caches)
  *
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index c07bfa2d80f2..78c3a94fae66 100644
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
 
@@ -177,6 +177,7 @@ cpumask_var_t *alloc_sched_domains(unsigned int ndoms);
 void free_sched_domains(cpumask_var_t doms[], unsigned int ndoms);
 
 bool cpus_share_cache(int this_cpu, int that_cpu);
+bool cpus_share_cluster(int this_cpu, int that_cpu);
 
 typedef const struct cpumask *(*sched_domain_mask_f)(int cpu);
 typedef int (*sched_domain_flags_f)(void);
@@ -230,6 +231,11 @@ static inline bool cpus_share_cache(int this_cpu, int that_cpu)
 	return true;
 }
 
+static inline bool cpus_share_cluster(int this_cpu, int that_cpu)
+{
+	return true;
+}
+
 #endif	/* !CONFIG_SMP */
 
 #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3c9b0fda64ac..11f9b25c3068 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3732,6 +3732,18 @@ bool cpus_share_cache(int this_cpu, int that_cpu)
 	return per_cpu(sd_llc_id, this_cpu) == per_cpu(sd_llc_id, that_cpu);
 }
 
+/*
+ * On non-Cluster machine this function works same with cpus_share_cache()
+ * as sd_cluster_id equals to sd_llc_id.
+ */
+bool cpus_share_cluster(int this_cpu, int that_cpu)
+{
+	if (this_cpu == that_cpu)
+		return true;
+
+	return per_cpu(sd_cluster_id, this_cpu) == per_cpu(sd_cluster_id, that_cpu);
+}
+
 static inline bool ttwu_queue_cond(int cpu, int wake_flags)
 {
 	/*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0e66749486e7..ddd29879ad40 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1763,7 +1763,9 @@ static inline struct sched_domain *lowest_flag_domain(int cpu, int flag)
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_llc);
 DECLARE_PER_CPU(int, sd_llc_size);
 DECLARE_PER_CPU(int, sd_llc_id);
+DECLARE_PER_CPU(int, sd_cluster_id);
 DECLARE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
+DECLARE_PER_CPU(struct sched_domain __rcu *, sd_cluster);
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_numa);
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index d201a7052a29..5642df384904 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -644,6 +644,8 @@ static void destroy_sched_domains(struct sched_domain *sd)
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_llc);
 DEFINE_PER_CPU(int, sd_llc_size);
 DEFINE_PER_CPU(int, sd_llc_id);
+DEFINE_PER_CPU(int, sd_cluster_id);
+DEFINE_PER_CPU(struct sched_domain __rcu *, sd_cluster);
 DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
@@ -669,6 +671,12 @@ static void update_top_cache_domain(int cpu)
 	per_cpu(sd_llc_id, cpu) = id;
 	rcu_assign_pointer(per_cpu(sd_llc_shared, cpu), sds);
 
+	sd = lowest_flag_domain(cpu, SD_CLUSTER);
+	if (sd)
+		id = cpumask_first(sched_domain_span(sd));
+	rcu_assign_pointer(per_cpu(sd_cluster, cpu), sd);
+	per_cpu(sd_cluster_id, cpu) = id;
+
 	sd = lowest_flag_domain(cpu, SD_NUMA);
 	rcu_assign_pointer(per_cpu(sd_numa, cpu), sd);
 
@@ -1514,6 +1522,7 @@ static unsigned long __read_mostly *sched_numa_onlined_nodes;
  */
 #define TOPOLOGY_SD_FLAGS		\
 	(SD_SHARE_CPUCAPACITY	|	\
+	 SD_CLUSTER		|	\
 	 SD_SHARE_PKG_RESOURCES |	\
 	 SD_NUMA		|	\
 	 SD_ASYM_PACKING)
-- 
2.33.0

