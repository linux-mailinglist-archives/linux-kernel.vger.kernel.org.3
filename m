Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A90F8467F5B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 22:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383290AbhLCVe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 16:34:57 -0500
Received: from mga03.intel.com ([134.134.136.65]:15695 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354032AbhLCVep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 16:34:45 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="237000635"
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="237000635"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 13:31:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="598116284"
Received: from skl-02.jf.intel.com ([10.54.74.28])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Dec 2021 13:31:18 -0800
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
Subject: [PATCH 5/5] scheduler: Default cluster scheduling to off on x86 hybrid CPU
Date:   Fri,  3 Dec 2021 12:32:42 -0800
Message-Id: <0c69821b57261c10818fba146bd31ea88bb41093.1638563225.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1638563225.git.tim.c.chen@linux.intel.com>
References: <cover.1638563225.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For x86 hybrid CPUs like Alder Lake, the order of CPU selection should
be based stricly on CPU priority.  Turn off cluster scheduling
to avoid interference with such CPU selection order.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 arch/x86/kernel/smpboot.c    | 18 ++++++++++++++++++
 drivers/base/arch_topology.c | 10 ++++++++++
 include/linux/topology.h     |  6 ++++++
 kernel/sched/topology.c      |  4 +++-
 4 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index bab5251f8e03..4aa1c859dcea 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -46,6 +46,7 @@
 #include <linux/sched/topology.h>
 #include <linux/sched/hotplug.h>
 #include <linux/sched/task_stack.h>
+#include <linux/sched/sysctl.h>
 #include <linux/percpu.h>
 #include <linux/memblock.h>
 #include <linux/err.h>
@@ -135,6 +136,23 @@ void arch_rebuild_cpu_topology(void)
 	x86_topology_update = false;
 }
 
+#ifdef CONFIG_SCHED_CLUSTER
+void arch_set_def_cluster_topology(void)
+{
+	/*
+	 * For hybrid CPUs, scheduling order between the CPUs should be
+	 * based strictly on CPU priority. Turn off cluster scheduling
+	 * for hybrid CPUs.
+	 */
+	if (sysctl_sched_cluster > 1) {
+		if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
+			sysctl_sched_cluster = 0;
+		else
+			sysctl_sched_cluster = 1;
+	}
+}
+#endif
+
 static inline void smpboot_setup_warm_reset_vector(unsigned long start_eip)
 {
 	unsigned long flags;
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index bb129929410b..a3668cc4b727 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -18,6 +18,7 @@
 #include <linux/init.h>
 #include <linux/rcupdate.h>
 #include <linux/sched.h>
+#include <linux/sched/sysctl.h>
 
 static DEFINE_PER_CPU(struct scale_freq_data __rcu *, sft_data);
 static struct cpumask scale_freq_counters_mask;
@@ -213,6 +214,15 @@ void __weak arch_rebuild_cpu_topology(void)
 	update_topology = 0;
 }
 
+#ifdef CONFIG_SCHED_CLUSTER
+void __weak arch_set_def_cluster_topology(void)
+{
+	/* Use cluster topology by default unless disabled in boot option */
+	if (sysctl_sched_cluster > 1)
+		sysctl_sched_cluster = 1;
+}
+#endif
+
 /*
  * Updating the sched_domains can't be done directly from cpufreq callbacks
  * due to locking, so queue the work for later.
diff --git a/include/linux/topology.h b/include/linux/topology.h
index 42bcfd5d9fdb..87d893c05f0c 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -46,6 +46,12 @@
 int arch_update_cpu_topology(void);
 void arch_rebuild_cpu_topology(void);
 
+#ifdef CONFIG_SCHED_CLUSTER
+void arch_set_def_cluster_topology(void);
+#else
+static inline void arch_set_def_sched_cluster(void) { };
+#endif
+
 /* Conform to ACPI 2.0 SLIT distance definitions */
 #define LOCAL_DISTANCE		10
 #define REMOTE_DISTANCE		20
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 087854d505f7..07dfc4666c09 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1660,6 +1660,8 @@ void set_sched_cluster(void)
 {
 	struct sched_domain_topology_level *tl;
 
+	arch_set_def_cluster_topology();
+
 	for (tl = sched_domain_topology; tl->mask; tl++) {
 		if (tl->sd_flags && (tl->sd_flags() & SD_CLUSTER)) {
 			if (!sysctl_sched_cluster)
@@ -1672,7 +1674,7 @@ void set_sched_cluster(void)
 }
 
 /* set via /proc/sys/kernel/sched_cluster */
-unsigned int __read_mostly sysctl_sched_cluster = 1;
+unsigned int __read_mostly sysctl_sched_cluster = 2;
 
 static DEFINE_MUTEX(sched_cluster_mutex);
 int sched_cluster_handler(struct ctl_table *table, int write,
-- 
2.20.1

