Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9E4467F58
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 22:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354017AbhLCVet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 16:34:49 -0500
Received: from mga03.intel.com ([134.134.136.65]:15695 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353950AbhLCVel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 16:34:41 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="237000625"
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="237000625"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 13:31:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="598116271"
Received: from skl-02.jf.intel.com ([10.54.74.28])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Dec 2021 13:31:15 -0800
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Song Bao Hua <song.bao.hua@hisilicon.com>,
        yangyicong <yangyicong@huawei.com>,
        Michael Larabel <Michael@MichaelLarabel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] scheduler: Add runtime knob sysctl_sched_cluster
Date:   Fri,  3 Dec 2021 12:32:40 -0800
Message-Id: <573fbedc1e15cd533f8e183bd3770bf58da2f379.1638563225.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1638563225.git.tim.c.chen@linux.intel.com>
References: <cover.1638563225.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow run time configuration of the scheduler to use cluster
scheduling.  Configuration can be changed via the sysctl variable
/proc/sys/kernel/sched_cluster. Setting it to 1 enable cluster
scheduling and setting it to 0 turns it off.

Cluster scheduling should benefit independent tasks by load balancing
them between clusters.  It reaps the most benefit when the system's CPUs
are not fully busy, so we can spread the tasks out between the clusters to
reduce contention on cluster resource (e.g. L2 cache).

However, if the system is expected to operate close to full utilization,
the system admin could turn this feature off so as not to incur
extra load balancing overhead between the cluster domains.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 arch/x86/kernel/smpboot.c    |  8 +++++++
 drivers/base/arch_topology.c | 13 +++++++----
 include/linux/sched/sysctl.h |  6 +++++
 include/linux/topology.h     |  1 +
 kernel/sched/core.c          |  1 +
 kernel/sched/sched.h         |  6 +++++
 kernel/sched/topology.c      | 44 ++++++++++++++++++++++++++++++++++++
 kernel/sysctl.c              | 11 +++++++++
 8 files changed, 86 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index ac2909f0cab3..bab5251f8e03 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -57,6 +57,7 @@
 #include <linux/pgtable.h>
 #include <linux/overflow.h>
 #include <linux/syscore_ops.h>
+#include <linux/cpuset.h>
 
 #include <asm/acpi.h>
 #include <asm/desc.h>
@@ -127,6 +128,13 @@ int arch_update_cpu_topology(void)
 	return retval;
 }
 
+void arch_rebuild_cpu_topology(void)
+{
+	x86_topology_update = true;
+	rebuild_sched_domains();
+	x86_topology_update = false;
+}
+
 static inline void smpboot_setup_warm_reset_vector(unsigned long start_eip)
 {
 	unsigned long flags;
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index ff16a36a908b..bb129929410b 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -205,16 +205,21 @@ int topology_update_cpu_topology(void)
 	return update_topology;
 }
 
+void __weak arch_rebuild_cpu_topology(void)
+{
+	update_topology = 1;
+	rebuild_sched_domains();
+	pr_debug("sched_domain hierarchy rebuilt, flags updated\n");
+	update_topology = 0;
+}
+
 /*
  * Updating the sched_domains can't be done directly from cpufreq callbacks
  * due to locking, so queue the work for later.
  */
 static void update_topology_flags_workfn(struct work_struct *work)
 {
-	update_topology = 1;
-	rebuild_sched_domains();
-	pr_debug("sched_domain hierarchy rebuilt, flags updated\n");
-	update_topology = 0;
+	arch_rebuild_cpu_topology();
 }
 
 static DEFINE_PER_CPU(u32, freq_factor) = 1;
diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 304f431178fd..bd1c29e8be50 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -75,6 +75,12 @@ int sysctl_numa_balancing(struct ctl_table *table, int write, void *buffer,
 int sysctl_schedstats(struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
 
+#ifdef CONFIG_SCHED_CLUSTER
+extern unsigned int sysctl_sched_cluster;
+int sched_cluster_handler(struct ctl_table *table, int write,
+		void *buffer, size_t *lenp, loff_t *ppos);
+#endif
+
 #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
 extern unsigned int sysctl_sched_energy_aware;
 int sched_energy_aware_handler(struct ctl_table *table, int write,
diff --git a/include/linux/topology.h b/include/linux/topology.h
index 0b3704ad13c8..42bcfd5d9fdb 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -44,6 +44,7 @@
 		if (nr_cpus_node(node))
 
 int arch_update_cpu_topology(void);
+void arch_rebuild_cpu_topology(void);
 
 /* Conform to ACPI 2.0 SLIT distance definitions */
 #define LOCAL_DISTANCE		10
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 76f9deeaa942..42b5890a9873 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9201,6 +9201,7 @@ int sched_cpu_dying(unsigned int cpu)
 void __init sched_init_smp(void)
 {
 	sched_init_numa();
+	set_sched_cluster();
 
 	/*
 	 * There's no userspace yet to cause hotplug operations; hence all the
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0e66749486e7..867ec74d9de0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1651,6 +1651,12 @@ this_rq_lock_irq(struct rq_flags *rf)
 	return rq;
 }
 
+#ifdef CONFIG_SCHED_CLUSTER
+extern void set_sched_cluster(void);
+#else
+static inline void set_sched_cluster(void) { }
+#endif
+
 #ifdef CONFIG_NUMA
 enum numa_topology_type {
 	NUMA_DIRECT,
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 0c11531a64a0..e362bba29f95 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1655,6 +1655,50 @@ static struct sched_domain_topology_level default_topology[] = {
 static struct sched_domain_topology_level *sched_domain_topology =
 	default_topology;
 
+#ifdef CONFIG_SCHED_CLUSTER
+void set_sched_cluster(void)
+{
+	struct sched_domain_topology_level *tl;
+
+	for (tl = sched_domain_topology; tl->mask; tl++) {
+		if (tl->sd_flags && (tl->sd_flags() & SD_CLUSTER)) {
+			if (!sysctl_sched_cluster)
+				tl->flags |= SDTL_SKIP;
+			else
+				tl->flags &= ~SDTL_SKIP;
+			break;
+		}
+	}
+}
+
+/* set via /proc/sys/kernel/sched_cluster */
+unsigned int __read_mostly sysctl_sched_cluster = 1;
+
+static DEFINE_MUTEX(sched_cluster_mutex);
+int sched_cluster_handler(struct ctl_table *table, int write,
+		void *buffer, size_t *lenp, loff_t *ppos)
+{
+	int ret;
+	unsigned int oldval;
+
+	if (write && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	mutex_lock(&sched_cluster_mutex);
+	oldval = sysctl_sched_cluster;
+	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+	if (!ret && write) {
+		if (oldval != sysctl_sched_cluster) {
+			set_sched_cluster();
+			arch_rebuild_cpu_topology();
+		}
+	}
+	mutex_unlock(&sched_cluster_mutex);
+
+	return ret;
+}
+#endif
+
 static struct sched_domain_topology_level *next_tl(struct sched_domain_topology_level *tl)
 {
 	++tl;
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 083be6af29d7..149ddfafaacc 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1901,6 +1901,17 @@ static struct ctl_table kern_table[] = {
 		.extra2		= SYSCTL_ONE,
 	},
 #endif
+#ifdef CONFIG_SCHED_CLUSTER
+	{
+		.procname	= "sched_cluster",
+		.data		= &sysctl_sched_cluster,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= sched_cluster_handler,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+#endif
 #ifdef CONFIG_PROVE_LOCKING
 	{
 		.procname	= "prove_locking",
-- 
2.20.1

