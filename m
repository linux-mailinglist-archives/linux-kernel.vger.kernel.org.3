Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B95F0467F59
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 22:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383250AbhLCVew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 16:34:52 -0500
Received: from mga03.intel.com ([134.134.136.65]:15695 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353975AbhLCVen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 16:34:43 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="237000626"
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="237000626"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 13:31:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="598116257"
Received: from skl-02.jf.intel.com ([10.54.74.28])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Dec 2021 13:31:14 -0800
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
Subject: [PATCH 2/5] scheduler: Add SD_CLUSTER topology flag to cluster sched domain
Date:   Fri,  3 Dec 2021 12:32:39 -0800
Message-Id: <efda38b9a2c629aa7270aeba0e65ae420383bdb7.1638563225.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1638563225.git.tim.c.chen@linux.intel.com>
References: <cover.1638563225.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SD_CLUSTER to flag cluster sched domain topology.

Scheduler needs to know if a topology level is at cluster level. It can
then decide if cluster sched domain should be built based on boot or run
time configuration specified in next patch.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 include/linux/sched/sd_flags.h | 7 +++++++
 include/linux/sched/topology.h | 2 +-
 kernel/sched/topology.c        | 3 +++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
index 57bde66d95f7..2321f1b4cee6 100644
--- a/include/linux/sched/sd_flags.h
+++ b/include/linux/sched/sd_flags.h
@@ -164,3 +164,10 @@ SD_FLAG(SD_OVERLAP, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
  * NEEDS_GROUPS: No point in preserving domain if it has a single group.
  */
 SD_FLAG(SD_NUMA, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
+
+/*
+ * Domain members in the same CPU cluster
+ *
+ * NEEDS_GROUPS: Cluster resroucres are shared between groups.
+ */
+SD_FLAG(SD_CLUSTER, SDF_NEEDS_GROUPS)
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index a6ad1e02e57a..d71e75f03619 100644
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
 
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index ee6b14ad3324..0c11531a64a0 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1504,6 +1504,8 @@ static unsigned long __read_mostly *sched_numa_onlined_nodes;
  * function:
  *
  *   SD_SHARE_CPUCAPACITY   - describes SMT topologies
+ *   SD_CLUSTER             - describes multiple CPU clusters in a
+ *                            last level cache
  *   SD_SHARE_PKG_RESOURCES - describes shared caches
  *   SD_NUMA                - describes NUMA topologies
  *
@@ -1514,6 +1516,7 @@ static unsigned long __read_mostly *sched_numa_onlined_nodes;
  */
 #define TOPOLOGY_SD_FLAGS		\
 	(SD_SHARE_CPUCAPACITY	|	\
+	 SD_CLUSTER		|	\
 	 SD_SHARE_PKG_RESOURCES |	\
 	 SD_NUMA		|	\
 	 SD_ASYM_PACKING)
-- 
2.20.1

