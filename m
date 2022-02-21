Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48AE4BDC8B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344707AbiBUIqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 03:46:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344697AbiBUIqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 03:46:18 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8374313D11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 00:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645433155; x=1676969155;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2jFYkOLpJQTm151XXqbE3K+wUCWHeMwkY3j//vsl+6s=;
  b=IvTXwGZEMWkQYq3ePZkp7ogNj1csGZyNOJhvP1l+u3eJjc96EzXEpk76
   v0oJSQCsfJLAGPbxUxK7HKotjjCfhDIbnndc9V9bc0+E1tEncOOnt0yvT
   WVBTDTB0PEzvLbiHLA1vmwLFmRrzpy6aEb//6T7GfoYCUmJ1xOG1iAXRk
   YNj2exHgzgW9VU4IlXdAa6i+L/wBRLWU5nMyBhgtW24REQkV5xNeLdlWt
   VQk6S/fLhtZMs/1qP3TMeL6NGkklHI02GRJPEGCgQ934bEZ0gvYXA/jQ/
   xq1kNaJu4N6wzZ70NP5iFDlkJj1RGmWA2vM5I/xk57TeXrUVxViDYMfEU
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="249045796"
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="249045796"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 00:45:55 -0800
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="531774868"
Received: from yhuang6-desk2.sh.intel.com ([10.239.13.11])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 00:45:50 -0800
From:   Huang Ying <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Feng Tang <feng.tang@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Wei Xu <weixugc@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        zhongjiang-ali <zhongjiang-ali@linux.alibaba.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: [PATCH -V13 2/3] NUMA balancing: optimize page placement for memory tiering system
Date:   Mon, 21 Feb 2022 16:45:28 +0800
Message-Id: <20220221084529.1052339-3-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220221084529.1052339-1-ying.huang@intel.com>
References: <20220221084529.1052339-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

b. Make kswapd of the fast memory node to reclaim pages until the free
   pages are a little more than the high watermark (named as promo
   watermark).  Then, if the free pages of the fast memory node reaches
   high watermark, and some hot pages need to be promoted, kswapd of the
   fast memory node will be waken up to demote more cold pages in the
   fast memory node to the slow memory node.  This will free some extra
   space in the fast memory node, so the hot pages in the slow memory
   node can be promoted to the fast memory node.

The choice "a" may create high memory pressure in the fast memory
node.  If the memory pressure of the workload is high, the memory
pressure may become so high that the memory allocation latency of the
workload is influenced, e.g. the direct reclaiming may be triggered.

The choice "b" works much better at this aspect.  If the memory
pressure of the workload is high, the hot pages promotion will stop
earlier because its allocation watermark is higher than that of the
normal memory allocation.  So in this patch, choice "b" is
implemented.  A new zone watermark (WMARK_PROMO) is added.  Which is
larger than the high watermark and can be controlled via
watermark_scale_factor.

In addition to the original page placement optimization among sockets,
the NUMA balancing mechanism is extended to be used to optimize page
placement according to hot/cold among different memory types.  So the
sysctl user space interface (numa_balancing) is extended in a backward
compatible way as follow, so that the users can enable/disable these
functionality individually.

The sysctl is converted from a Boolean value to a bits field.  The
definition of the flags is,

- 0: NUMA_BALANCING_DISABLED
- 1: NUMA_BALANCING_NORMAL
- 2: NUMA_BALANCING_MEMORY_TIERING

We have tested the patch with the pmbench memory accessing benchmark
with the 80:20 read/write ratio and the Gauss access address
distribution on a 2 socket Intel server with Optane DC Persistent
Memory Model.  The test results shows that the pmbench score can
improve up to 95.9%.

Thanks Andrew Morton to help fix the document format error.

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
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: zhongjiang-ali <zhongjiang-ali@linux.alibaba.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 Documentation/admin-guide/sysctl/kernel.rst | 29 ++++++++++++++-------
 include/linux/mmzone.h                      |  1 +
 include/linux/sched/sysctl.h                | 10 +++++++
 kernel/sched/core.c                         | 21 ++++++++++++---
 kernel/sysctl.c                             |  2 +-
 mm/migrate.c                                | 16 ++++++++++--
 mm/page_alloc.c                             |  3 ++-
 mm/vmscan.c                                 |  6 ++++-
 8 files changed, 70 insertions(+), 18 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index d359bcfadd39..fdfd2b684822 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -595,16 +595,23 @@ Documentation/admin-guide/kernel-parameters.rst).
 numa_balancing
 ==============
 
-Enables/disables automatic page fault based NUMA memory
-balancing. Memory is moved automatically to nodes
-that access it often.
+Enables/disables and configures automatic page fault based NUMA memory
+balancing.  Memory is moved automatically to nodes that access it often.
+The value to set can be the result of ORing the following:
 
-Enables/disables automatic NUMA memory balancing. On NUMA machines, there
-is a performance penalty if remote memory is accessed by a CPU. When this
-feature is enabled the kernel samples what task thread is accessing memory
-by periodically unmapping pages and later trapping a page fault. At the
-time of the page fault, it is determined if the data being accessed should
-be migrated to a local memory node.
+= =================================
+0 NUMA_BALANCING_DISABLED
+1 NUMA_BALANCING_NORMAL
+2 NUMA_BALANCING_MEMORY_TIERING
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
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 44bd054ca12b..06bc55db19bf 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -342,6 +342,7 @@ enum zone_watermarks {
 	WMARK_MIN,
 	WMARK_LOW,
 	WMARK_HIGH,
+	WMARK_PROMO,
 	NR_WMARK
 };
 
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
index fcf0c180617c..c25348e9ae3a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4280,7 +4280,9 @@ DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
 
 #ifdef CONFIG_NUMA_BALANCING
 
-void set_numabalancing_state(bool enabled)
+int sysctl_numa_balancing_mode;
+
+static void __set_numabalancing_state(bool enabled)
 {
 	if (enabled)
 		static_branch_enable(&sched_numa_balancing);
@@ -4288,13 +4290,22 @@ void set_numabalancing_state(bool enabled)
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
@@ -4304,8 +4315,10 @@ int sysctl_numa_balancing(struct ctl_table *table, int write,
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
index cdeaf01e601a..08ca9b9b142e 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -51,6 +51,7 @@
 #include <linux/oom.h>
 #include <linux/memory.h>
 #include <linux/random.h>
+#include <linux/sched/sysctl.h>
 
 #include <asm/tlbflush.h>
 
@@ -2034,16 +2035,27 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
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
+		if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING))
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
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3589febc6d31..295b8f1fc31d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8474,7 +8474,8 @@ static void __setup_per_zone_wmarks(void)
 
 		zone->watermark_boost = 0;
 		zone->_watermark[WMARK_LOW]  = min_wmark_pages(zone) + tmp;
-		zone->_watermark[WMARK_HIGH] = min_wmark_pages(zone) + tmp * 2;
+		zone->_watermark[WMARK_HIGH] = low_wmark_pages(zone) + tmp;
+		zone->_watermark[WMARK_PROMO] = high_wmark_pages(zone) + tmp;
 
 		spin_unlock_irqrestore(&zone->lock, flags);
 	}
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6dd8f455bb82..199b8aadbdd6 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -56,6 +56,7 @@
 
 #include <linux/swapops.h>
 #include <linux/balloon_compaction.h>
+#include <linux/sched/sysctl.h>
 
 #include "internal.h"
 
@@ -3988,7 +3989,10 @@ static bool pgdat_balanced(pg_data_t *pgdat, int order, int highest_zoneidx)
 		if (!managed_zone(zone))
 			continue;
 
-		mark = high_wmark_pages(zone);
+		if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING)
+			mark = wmark_pages(zone, WMARK_PROMO);
+		else
+			mark = high_wmark_pages(zone);
 		if (zone_watermark_ok_safe(zone, order, mark, highest_zoneidx))
 			return true;
 	}
-- 
2.30.2

