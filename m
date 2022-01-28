Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1D6949F516
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 09:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347287AbiA1I2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 03:28:22 -0500
Received: from mga01.intel.com ([192.55.52.88]:54806 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347278AbiA1I2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 03:28:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643358500; x=1674894500;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WC4PhiGrPDzzmC5jvoDf7DFGko0uF8nz7i7hvigSZ+Q=;
  b=NJhuxeag68n0IgufckH+LiGpzWDafZsLrWeXw32AO2Blx1ODZPMuzjtI
   gNUcfoU/kzeCFRYkgNPYXs1Ab1w38esxs0YbRzjyLe6/4Z8LxkWdekFvP
   f8lqloJBFDpYJMxq/mZ4rVAQklgxTQAMBCgfHHQ8oEazKYjsHuc8SQZpp
   S42jGcREpSVunLOPH+r3bzz6UVnLCCQgXpZW/mnoPS6a1ph5v2QfKLftn
   HHH6j3mLDMI+dQyEUsGuaMJoG738D8bX93lVUlA1CYhOZstdIeOZcI+h5
   opmNocIXrzd4d8VSgBLVODU9zY0+93g73z6RO8S7FY4/8sejSFOkBeFw8
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="271537206"
X-IronPort-AV: E=Sophos;i="5.88,323,1635231600"; 
   d="scan'208";a="271537206"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 00:28:17 -0800
X-IronPort-AV: E=Sophos;i="5.88,323,1635231600"; 
   d="scan'208";a="697019661"
Received: from yhuang6-desk2.sh.intel.com ([10.239.13.11])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 00:28:12 -0800
From:   Huang Ying <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>, Mel Gorman <mgorman@suse.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Feng Tang <feng.tang@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Wei Xu <weixugc@google.com>, osalvador <osalvador@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        zhongjiang-ali <zhongjiang-ali@linux.alibaba.com>
Subject: [PATCH -V11 2/3] NUMA balancing: optimize page placement for memory tiering system
Date:   Fri, 28 Jan 2022 16:27:50 +0800
Message-Id: <20220128082751.593478-3-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220128082751.593478-1-ying.huang@intel.com>
References: <20220128082751.593478-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the advent of various new memory types, some machines will have
multiple types of memory, e.g. DRAM and PMEM (persistent memory).  The
memory subsystem of these machines can be called memory tiering
system, because the performance of the different types of memory are
usually different.

In such system, because of the memory accessing pattern changing etc,
some pages in the slow memory may become hot globally.  So in this
patch, the NUMA balancing mechanism is enhanced to optimize the page
placement among the different memory types according to hot/cold
dynamically.

In a typical memory tiering system, there are CPUs, fast memory and
slow memory in each physical NUMA node.  The CPUs and the fast memory
will be put in one logical node (called fast memory node), while the
slow memory will be put in another (faked) logical node (called slow
memory node).  That is, the fast memory is regarded as local while the
slow memory is regarded as remote.  So it's possible for the recently
accessed pages in the slow memory node to be promoted to the fast
memory node via the existing NUMA balancing mechanism.

The original NUMA balancing mechanism will stop to migrate pages if
the free memory of the target node becomes below the high watermark.
This is a reasonable policy if there's only one memory type.  But this
makes the original NUMA balancing mechanism almost do not work to
optimize page placement among different memory types.  Details are as
follows.

It's the common cases that the working-set size of the workload is
larger than the size of the fast memory nodes.  Otherwise, it's
unnecessary to use the slow memory at all.  So, there are almost
always no enough free pages in the fast memory nodes, so that the
globally hot pages in the slow memory node cannot be promoted to the
fast memory node.  To solve the issue, we have 2 choices as follows,

a. Ignore the free pages watermark checking when promoting hot pages
   from the slow memory node to the fast memory node.  This will
   create some memory pressure in the fast memory node, thus trigger
   the memory reclaiming.  So that, the cold pages in the fast memory
   node will be demoted to the slow memory node.

b. Make kswapd of the fast memory node to reclaim pages until the
   free pages are a little (for example, high_watermark / 4) more than
   the high watermark.  Then, if the free pages of the fast memory
   node reaches high watermark, and some hot pages need to be
   promoted, kswapd of the fast memory node will be waken up to demote
   more cold pages in the fast memory node to the slow memory node.
   This will free some extra space in the fast memory node, so the hot
   pages in the slow memory node can be promoted to the fast memory
   node.

The choice "a" may create high memory pressure in the fast memory
node.  If the memory pressure of the workload is high, the memory
pressure may become so high that the memory allocation latency of the
workload is influenced, e.g. the direct reclaiming may be triggered.

The choice "b" works much better at this aspect.  If the memory
pressure of the workload is high, the hot pages promotion will stop
earlier because its allocation watermark is higher than that of the
normal memory allocation.  So in this patch, choice "b" is
implemented.

In addition to the original page placement optimization among sockets,
the NUMA balancing mechanism is extended to be used to optimize page
placement according to hot/cold among different memory types.  So the
sysctl user space interface (numa_balancing) is extended in a backward
compatible way as follow, so that the users can enable/disable these
functionality individually.

The sysctl is converted from a Boolean value to a bits field.  The
definition of the flags is,

- 0x0: NUMA_BALANCING_DISABLED
- 0x1: NUMA_BALANCING_NORMAL
- 0x2: NUMA_BALANCING_MEMORY_TIERING

We have tested the patch with the pmbench memory accessing benchmark
with the 80:20 read/write ratio and the Gauss access address
distribution on a 2 socket Intel server with Optane DC Persistent
Memory Model.  The test results shows that the pmbench score can
improve up to 95.9%.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Wei Xu <weixugc@google.com>
Cc: osalvador <osalvador@suse.de>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: zhongjiang-ali <zhongjiang-ali@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 Documentation/admin-guide/sysctl/kernel.rst | 29 ++++++++++++++-------
 include/linux/sched/sysctl.h                | 10 +++++++
 kernel/sched/core.c                         | 21 ++++++++++++---
 kernel/sysctl.c                             |  2 +-
 mm/migrate.c                                | 19 ++++++++++++--
 mm/vmscan.c                                 | 17 ++++++++++++
 6 files changed, 82 insertions(+), 16 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index d359bcfadd39..ea32ba0c5d3c 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -595,16 +595,23 @@ Documentation/admin-guide/kernel-parameters.rst).
 numa_balancing
 ==============
 
-Enables/disables automatic page fault based NUMA memory
-balancing. Memory is moved automatically to nodes
-that access it often.
+Enables/disables and configure automatic page fault based NUMA memory
+balancing.  Memory is moved automatically to nodes that access it
+often.  The value to set can be the result to OR the following,
 
-Enables/disables automatic NUMA memory balancing. On NUMA machines, there
-is a performance penalty if remote memory is accessed by a CPU. When this
-feature is enabled the kernel samples what task thread is accessing memory
-by periodically unmapping pages and later trapping a page fault. At the
-time of the page fault, it is determined if the data being accessed should
-be migrated to a local memory node.
+= =================================
+0x0 NUMA_BALANCING_DISABLED
+0x1 NUMA_BALANCING_NORMAL
+0x2 NUMA_BALANCING_MEMORY_TIERING
+= =================================
+
+Or NUMA_BALANCING_NORMAL to optimize page placement among different
+NUMA nodes to reduce remote accessing.  On NUMA machines, there is a
+performance penalty if remote memory is accessed by a CPU. When this
+feature is enabled the kernel samples what task thread is accessing
+memory by periodically unmapping pages and later trapping a page
+fault. At the time of the page fault, it is determined if the data
+being accessed should be migrated to a local memory node.
 
 The unmapping of pages and trapping faults incur additional overhead that
 ideally is offset by improved memory locality but there is no universal
@@ -615,6 +622,10 @@ faults may be controlled by the `numa_balancing_scan_period_min_ms,
 numa_balancing_scan_delay_ms, numa_balancing_scan_period_max_ms,
 numa_balancing_scan_size_mb`_, and numa_balancing_settle_count sysctls.
 
+Or NUMA_BALANCING_MEMORY_TIERING to optimize page placement among
+different types of memory (represented as different NUMA nodes) to
+place the hot pages in the fast memory.  This is implemented based on
+unmapping and page fault too.
 
 numa_balancing_scan_period_min_ms, numa_balancing_scan_delay_ms, numa_balancing_scan_period_max_ms, numa_balancing_scan_size_mb
 ===============================================================================================================================
diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index c19dd5a2c05c..b5eec8854c5a 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -23,6 +23,16 @@ enum sched_tunable_scaling {
 	SCHED_TUNABLESCALING_END,
 };
 
+#define NUMA_BALANCING_DISABLED		0x0
+#define NUMA_BALANCING_NORMAL		0x1
+#define NUMA_BALANCING_MEMORY_TIERING	0x2
+
+#ifdef CONFIG_NUMA_BALANCING
+extern int sysctl_numa_balancing_mode;
+#else
+#define sysctl_numa_balancing_mode	0
+#endif
+
 /*
  *  control realtime throttling:
  *
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 848eaa0efe0e..b8b8e5feb8ef 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4279,7 +4279,9 @@ DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
 
 #ifdef CONFIG_NUMA_BALANCING
 
-void set_numabalancing_state(bool enabled)
+int sysctl_numa_balancing_mode;
+
+static void __set_numabalancing_state(bool enabled)
 {
 	if (enabled)
 		static_branch_enable(&sched_numa_balancing);
@@ -4287,13 +4289,22 @@ void set_numabalancing_state(bool enabled)
 		static_branch_disable(&sched_numa_balancing);
 }
 
+void set_numabalancing_state(bool enabled)
+{
+	if (enabled)
+		sysctl_numa_balancing_mode = NUMA_BALANCING_NORMAL;
+	else
+		sysctl_numa_balancing_mode = NUMA_BALANCING_DISABLED;
+	__set_numabalancing_state(enabled);
+}
+
 #ifdef CONFIG_PROC_SYSCTL
 int sysctl_numa_balancing(struct ctl_table *table, int write,
 			  void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table t;
 	int err;
-	int state = static_branch_likely(&sched_numa_balancing);
+	int state = sysctl_numa_balancing_mode;
 
 	if (write && !capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -4303,8 +4314,10 @@ int sysctl_numa_balancing(struct ctl_table *table, int write,
 	err = proc_dointvec_minmax(&t, write, buffer, lenp, ppos);
 	if (err < 0)
 		return err;
-	if (write)
-		set_numabalancing_state(state);
+	if (write) {
+		sysctl_numa_balancing_mode = state;
+		__set_numabalancing_state(state);
+	}
 	return err;
 }
 #endif
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 5ae443b2882e..c90a564af720 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1689,7 +1689,7 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= sysctl_numa_balancing,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.extra2		= SYSCTL_FOUR,
 	},
 #endif /* CONFIG_NUMA_BALANCING */
 	{
diff --git a/mm/migrate.c b/mm/migrate.c
index a5971e9f6e6a..61f7e82e6708 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -51,6 +51,7 @@
 #include <linux/oom.h>
 #include <linux/memory.h>
 #include <linux/random.h>
+#include <linux/sched/sysctl.h>
 
 #include <asm/tlbflush.h>
 
@@ -2034,16 +2035,30 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
 {
 	int page_lru;
 	int nr_pages = thp_nr_pages(page);
+	int order = compound_order(page);
 
-	VM_BUG_ON_PAGE(compound_order(page) && !PageTransHuge(page), page);
+	VM_BUG_ON_PAGE(order && !PageTransHuge(page), page);
 
 	/* Do not migrate THP mapped by multiple processes */
 	if (PageTransHuge(page) && total_mapcount(page) > 1)
 		return 0;
 
 	/* Avoid migrating to a node that is nearly full */
-	if (!migrate_balanced_pgdat(pgdat, nr_pages))
+	if (!migrate_balanced_pgdat(pgdat, nr_pages)) {
+		int z;
+
+		if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) ||
+		    !numa_demotion_enabled)
+			return 0;
+		if (next_demotion_node(pgdat->node_id) == NUMA_NO_NODE)
+			return 0;
+		for (z = pgdat->nr_zones - 1; z >= 0; z--) {
+			if (populated_zone(pgdat->node_zones + z))
+				break;
+		}
+		wakeup_kswapd(pgdat->node_zones + z, 0, order, ZONE_MOVABLE);
 		return 0;
+	}
 
 	if (isolate_lru_page(page))
 		return 0;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 08ab556c7678..bc6fbbc8bedd 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -56,6 +56,7 @@
 
 #include <linux/swapops.h>
 #include <linux/balloon_compaction.h>
+#include <linux/sched/sysctl.h>
 
 #include "internal.h"
 
@@ -3966,6 +3967,13 @@ static bool pgdat_watermark_boosted(pg_data_t *pgdat, int highest_zoneidx)
 	return false;
 }
 
+/*
+ * Keep the free pages on fast memory node a little more than the high
+ * watermark to accommodate the promoted pages.
+ */
+#define NUMA_BALANCING_PROMOTE_WATERMARK_DIV	4
+#define NUMA_BALANCING_PROMOTE_WATERMARK_MIN	(10UL * 1024 * 1024 >> PAGE_SHIFT)
+
 /*
  * Returns true if there is an eligible zone balanced for the request order
  * and highest_zoneidx
@@ -3987,6 +3995,15 @@ static bool pgdat_balanced(pg_data_t *pgdat, int order, int highest_zoneidx)
 			continue;
 
 		mark = high_wmark_pages(zone);
+		if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
+		    numa_demotion_enabled &&
+		    next_demotion_node(pgdat->node_id) != NUMA_NO_NODE) {
+			unsigned long promote_mark;
+
+			promote_mark = max(NUMA_BALANCING_PROMOTE_WATERMARK_MIN,
+				mark / NUMA_BALANCING_PROMOTE_WATERMARK_DIV);
+			mark += promote_mark;
+		}
 		if (zone_watermark_ok_safe(zone, order, mark, highest_zoneidx))
 			return true;
 	}
-- 
2.30.2

