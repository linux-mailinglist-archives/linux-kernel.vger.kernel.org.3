Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0F650F800
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 11:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240778AbiDZJlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 05:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347973AbiDZJZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 05:25:00 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F99E13EBC
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 01:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650963331; x=1682499331;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zuMR8Y90KK1QlYPlTe9hd94XJBGAiVcIKtzAHdTSzG4=;
  b=Uy39VdDS91skvx2I+2KVtslnVY4WuXAQkarmbAxWlOZjaLzELSV1xViE
   acWAOj+9e5Yd5kMFA2zk61SSWy6Km5CdHM6PFsnF4w6YX2Q8HGEUKFY9b
   F+iw6/RupzZH/mlsYcdwh6DEZvoUeKaEejL0AaVmc64QyS1Xxf2lm/vwI
   aYlXOheVQ5C8MVdriCc0/OYSptd7gBOXVE+7OG6mAgFbPABeAsjJVG80N
   jn5P4rVL+m/aStoLTmMHrWdx+4R3ODxpujJmO120ffw23OMmuGyZpEMMC
   9gzSFnp7UgvTUhJNAh41GGuDCTZsghRTy57e58Sdh+K6sklExu60d+RrS
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="245428647"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="245428647"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 01:52:38 -0700
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="579775854"
Received: from yyu16-mobl.ccr.corp.intel.com (HELO yhuang6-mobl1.ccr.corp.intel.com) ([10.254.212.128])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 01:52:30 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Wei Xu <weixugc@google.com>, osalvador <osalvador@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Zhong Jiang <zhongjiang-ali@linux.alibaba.com>
Subject: [PATCH -V2 1/3] memory tiering: hot page selection with hint page fault latency
Date:   Tue, 26 Apr 2022 16:51:03 +0800
Message-Id: <20220426085105.60822-2-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220426085105.60822-1-ying.huang@intel.com>
References: <20220426085105.60822-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To optimize page placement in a memory tiering system with NUMA
balancing, the hot pages in the slow memory node need to be
identified.  Essentially, the original NUMA balancing implementation
selects the mostly recently accessed (MRU) pages to promote.  But this
isn't a perfect algorithm to identify the hot pages.  Because the
pages with quite low access frequency may be accessed eventually given
the NUMA balancing page table scanning period could be quite
long (e.g. 60 seconds).  The most frequently accessed (MFU) algorithm
is better.

So, in this patch we implemented a better hot page selection
algorithm.  Which is based on NUMA balancing page table scanning and
hint page fault as follows,

- When the page tables of the processes are scanned to change PTE/PMD
  to be PROT_NONE, the current time is recorded in struct page as scan
  time.

- When the page is accessed, hint page fault will occur.  The scan
  time is gotten from the struct page.  And The hint page fault
  latency is defined as

    hint page fault time - scan time

The shorter the hint page fault latency of a page is, the higher the
probability of their access frequency to be higher.  So the hint page
fault latency is a better estimation of the page hot/cold.

It's hard to find some extra space in struct page to hold the scan
time.  Fortunately, we can reuse some bits used by the original NUMA
balancing.

NUMA balancing uses some bits in struct page to store the page
accessing CPU and PID (referring to page_cpupid_xchg_last()).  Which
is used by the multi-stage node selection algorithm to avoid to
migrate pages shared accessed by the NUMA nodes back and forth.  But
for pages in the slow memory node, even if they are shared accessed by
multiple NUMA nodes, as long as the pages are hot, they need to be
promoted to the fast memory node.  So the accessing CPU and PID
information are unnecessary for the slow memory pages.  We can reuse
these bits in struct page to record the scan time.  For the fast
memory pages, these bits are used as before.

For the hot threshold, the default value is 1 second, which works well
in our performance test.  All pages with hint page fault latency < hot
threshold will be considered hot.

It's hard for users to determine the hot threshold.  So we don't
provide a kernel ABI to set it, just provide a debugfs interface for
advanced users to experiment.  We will continue to work on a hot
threshold automatic adjustment mechanism.

The downside of the above method is that the response time to the
workload hot spot changing may be much longer.  For example,

- A previous cold memory area becomes hot

- The hint page fault will be triggered.  But the hint page fault
  latency isn't shorter than the hot threshold.  So the pages will
  not be promoted.

- When the memory area is scanned again, maybe after a scan period,
  the hint page fault latency measured will be shorter than the hot
  threshold and the pages will be promoted.

To mitigate this, if there are enough free space in the fast memory
node, the hot threshold will not be used, all pages will be promoted
upon the hint page fault for fast response.

Thanks Zhong Jiang reported and tested the fix for a bug when
disabling memory tiering mode dynamically.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
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
Cc: Zhong Jiang <zhongjiang-ali@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 include/linux/mm.h   | 25 +++++++++++
 kernel/sched/debug.c |  1 +
 kernel/sched/fair.c  | 99 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h |  1 +
 mm/huge_memory.c     | 17 ++++++--
 mm/memory.c          | 11 ++++-
 mm/migrate.c         | 12 ++++++
 mm/mprotect.c        |  8 +++-
 8 files changed, 169 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index e34edb775334..c53d2c2aff5f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1311,6 +1311,18 @@ static inline int folio_nid(const struct folio *folio)
 }
 
 #ifdef CONFIG_NUMA_BALANCING
+/* page access time bits needs to hold at least 4 seconds */
+#define PAGE_ACCESS_TIME_MIN_BITS	12
+#if LAST_CPUPID_SHIFT < PAGE_ACCESS_TIME_MIN_BITS
+#define PAGE_ACCESS_TIME_BUCKETS				\
+	(PAGE_ACCESS_TIME_MIN_BITS - LAST_CPUPID_SHIFT)
+#else
+#define PAGE_ACCESS_TIME_BUCKETS	0
+#endif
+
+#define PAGE_ACCESS_TIME_MASK				\
+	(LAST_CPUPID_MASK << PAGE_ACCESS_TIME_BUCKETS)
+
 static inline int cpu_pid_to_cpupid(int cpu, int pid)
 {
 	return ((cpu & LAST__CPU_MASK) << LAST__PID_SHIFT) | (pid & LAST__PID_MASK);
@@ -1374,12 +1386,25 @@ static inline void page_cpupid_reset_last(struct page *page)
 	page->flags |= LAST_CPUPID_MASK << LAST_CPUPID_PGSHIFT;
 }
 #endif /* LAST_CPUPID_NOT_IN_PAGE_FLAGS */
+
+static inline int xchg_page_access_time(struct page *page, int time)
+{
+	int last_time;
+
+	last_time = page_cpupid_xchg_last(page, time >> PAGE_ACCESS_TIME_BUCKETS);
+	return last_time << PAGE_ACCESS_TIME_BUCKETS;
+}
 #else /* !CONFIG_NUMA_BALANCING */
 static inline int page_cpupid_xchg_last(struct page *page, int cpupid)
 {
 	return page_to_nid(page); /* XXX */
 }
 
+static inline int xchg_page_access_time(struct page *page, int time)
+{
+	return 0;
+}
+
 static inline int page_cpupid_last(struct page *page)
 {
 	return page_to_nid(page); /* XXX */
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index bb3d63bdf4ae..ad63dbfc54f1 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -333,6 +333,7 @@ static __init int sched_init_debug(void)
 	debugfs_create_u32("scan_period_min_ms", 0644, numa, &sysctl_numa_balancing_scan_period_min);
 	debugfs_create_u32("scan_period_max_ms", 0644, numa, &sysctl_numa_balancing_scan_period_max);
 	debugfs_create_u32("scan_size_mb", 0644, numa, &sysctl_numa_balancing_scan_size);
+	debugfs_create_u32("hot_threshold_ms", 0644, numa, &sysctl_numa_balancing_hot_threshold);
 #endif
 
 	debugfs_create_file("debug", 0444, debugfs_sched, NULL, &sched_debug_fops);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d4bd299d67ab..9d1bbfb140f1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1058,6 +1058,9 @@ unsigned int sysctl_numa_balancing_scan_size = 256;
 /* Scan @scan_size MB every @scan_period after an initial @scan_delay in ms */
 unsigned int sysctl_numa_balancing_scan_delay = 1000;
 
+/* The page with hint page fault latency < threshold in ms is considered hot */
+unsigned int sysctl_numa_balancing_hot_threshold = MSEC_PER_SEC;
+
 struct numa_group {
 	refcount_t refcount;
 
@@ -1400,6 +1403,68 @@ static inline unsigned long group_weight(struct task_struct *p, int nid,
 	return 1000 * faults / total_faults;
 }
 
+/*
+ * If memory tiering mode is enabled, cpupid of slow memory page is
+ * used to record scan time instead of CPU and PID.  When tiering mode
+ * is disabled at run time, the scan time (in cpupid) will be
+ * interpreted as CPU and PID.  So CPU needs to be checked to avoid to
+ * access out of array bound.
+ */
+static inline bool cpupid_valid(int cpupid)
+{
+	return cpupid_to_cpu(cpupid) < nr_cpu_ids;
+}
+
+/*
+ * For memory tiering mode, if there are enough free pages (more than
+ * enough watermark defined here) in fast memory node, to take full
+ * advantage of fast memory capacity, all recently accessed slow
+ * memory pages will be migrated to fast memory node without
+ * considering hot threshold.
+ */
+static bool pgdat_free_space_enough(struct pglist_data *pgdat)
+{
+	int z;
+	unsigned long enough_wmark;
+
+	enough_wmark = max(1UL * 1024 * 1024 * 1024 >> PAGE_SHIFT,
+			   pgdat->node_present_pages >> 4);
+	for (z = pgdat->nr_zones - 1; z >= 0; z--) {
+		struct zone *zone = pgdat->node_zones + z;
+
+		if (!populated_zone(zone))
+			continue;
+
+		if (zone_watermark_ok(zone, 0,
+				      wmark_pages(zone, WMARK_PROMO) + enough_wmark,
+				      ZONE_MOVABLE, 0))
+			return true;
+	}
+	return false;
+}
+
+/*
+ * For memory tiering mode, when page tables are scanned, the scan
+ * time will be recorded in struct page in addition to make page
+ * PROT_NONE for slow memory page.  So when the page is accessed, in
+ * hint page fault handler, the hint page fault latency is calculated
+ * via,
+ *
+ *	hint page fault latency = hint page fault time - scan time
+ *
+ * The smaller the hint page fault latency, the higher the possibility
+ * for the page to be hot.
+ */
+static int numa_hint_fault_latency(struct page *page)
+{
+	int last_time, time;
+
+	time = jiffies_to_msecs(jiffies);
+	last_time = xchg_page_access_time(page, time);
+
+	return (time - last_time) & PAGE_ACCESS_TIME_MASK;
+}
+
 bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 				int src_nid, int dst_cpu)
 {
@@ -1407,9 +1472,34 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 	int dst_nid = cpu_to_node(dst_cpu);
 	int last_cpupid, this_cpupid;
 
+	/*
+	 * The pages in slow memory node should be migrated according
+	 * to hot/cold instead of private/shared.
+	 */
+	if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
+	    !node_is_toptier(src_nid)) {
+		struct pglist_data *pgdat;
+		unsigned long latency, th;
+
+		pgdat = NODE_DATA(dst_nid);
+		if (pgdat_free_space_enough(pgdat))
+			return true;
+
+		th = sysctl_numa_balancing_hot_threshold;
+		latency = numa_hint_fault_latency(page);
+		if (latency >= th)
+			return false;
+
+		return true;
+	}
+
 	this_cpupid = cpu_pid_to_cpupid(dst_cpu, current->pid);
 	last_cpupid = page_cpupid_xchg_last(page, this_cpupid);
 
+	if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) &&
+	    !node_is_toptier(src_nid) && !cpupid_valid(last_cpupid))
+		return false;
+
 	/*
 	 * Allow first faults or private faults to migrate immediately early in
 	 * the lifetime of a task. The magic number 4 is based on waiting for
@@ -2642,6 +2732,15 @@ void task_numa_fault(int last_cpupid, int mem_node, int pages, int flags)
 	if (!p->mm)
 		return;
 
+	/*
+	 * NUMA faults statistics are unnecessary for the slow memory
+	 * node for memory tiering mode.
+	 */
+	if (!node_is_toptier(mem_node) &&
+	    (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING ||
+	     !cpupid_valid(last_cpupid)))
+		return;
+
 	/* Allocate buffer to track faults on a per-node basis */
 	if (unlikely(!p->numa_faults)) {
 		int size = sizeof(*p->numa_faults) *
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8dccb34eb190..67ea7fec98b8 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2402,6 +2402,7 @@ extern unsigned int sysctl_numa_balancing_scan_delay;
 extern unsigned int sysctl_numa_balancing_scan_period_min;
 extern unsigned int sysctl_numa_balancing_scan_period_max;
 extern unsigned int sysctl_numa_balancing_scan_size;
+extern unsigned int sysctl_numa_balancing_hot_threshold;
 #endif
 
 #ifdef CONFIG_SCHED_HRTICK
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c468fee595ff..3b85e7d6fbb3 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1401,7 +1401,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	struct page *page;
 	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
 	int page_nid = NUMA_NO_NODE;
-	int target_nid, last_cpupid = -1;
+	int target_nid, last_cpupid = (-1 & LAST_CPUPID_MASK);
 	bool migrated = false;
 	bool was_writable = pmd_savedwrite(oldpmd);
 	int flags = 0;
@@ -1422,7 +1422,12 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 		flags |= TNF_NO_GROUP;
 
 	page_nid = page_to_nid(page);
-	last_cpupid = page_cpupid_last(page);
+	/*
+	 * For memory tiering mode, cpupid of slow memory page is used
+	 * to record page access time.  So use default value.
+	 */
+	if (node_is_toptier(page_nid))
+		last_cpupid = page_cpupid_last(page);
 	target_nid = numa_migrate_prep(page, vma, haddr, page_nid,
 				       &flags);
 
@@ -1740,6 +1745,7 @@ int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 
 	if (prot_numa) {
 		struct page *page;
+		bool toptier;
 		/*
 		 * Avoid trapping faults against the zero page. The read-only
 		 * data is likely to be read-cached on the local CPU and
@@ -1752,13 +1758,18 @@ int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 			goto unlock;
 
 		page = pmd_page(*pmd);
+		toptier = node_is_toptier(page_to_nid(page));
 		/*
 		 * Skip scanning top tier node if normal numa
 		 * balancing is disabled
 		 */
 		if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_NORMAL) &&
-		    node_is_toptier(page_to_nid(page)))
+		    toptier)
 			goto unlock;
+
+		if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
+		    !toptier)
+			xchg_page_access_time(page, jiffies_to_msecs(jiffies));
 	}
 	/*
 	 * In case prot_numa, we are under mmap_read_lock(mm). It's critical
diff --git a/mm/memory.c b/mm/memory.c
index b370ed118767..58ccac731d06 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -74,6 +74,7 @@
 #include <linux/perf_event.h>
 #include <linux/ptrace.h>
 #include <linux/vmalloc.h>
+#include <linux/sched/sysctl.h>
 
 #include <trace/events/kmem.h>
 
@@ -4455,8 +4456,16 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	if (page_mapcount(page) > 1 && (vma->vm_flags & VM_SHARED))
 		flags |= TNF_SHARED;
 
-	last_cpupid = page_cpupid_last(page);
 	page_nid = page_to_nid(page);
+	/*
+	 * For memory tiering mode, cpupid of slow memory page is used
+	 * to record page access time.  So use default value.
+	 */
+	if ((sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) &&
+	    !node_is_toptier(page_nid))
+		last_cpupid = (-1 & LAST_CPUPID_MASK);
+	else
+		last_cpupid = page_cpupid_last(page);
 	target_nid = numa_migrate_prep(page, vma, vmf->address, page_nid,
 			&flags);
 	if (target_nid == NUMA_NO_NODE) {
diff --git a/mm/migrate.c b/mm/migrate.c
index 5afab404889a..c3bd0cdb031d 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -534,6 +534,18 @@ void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
 	 * future migrations of this same page.
 	 */
 	cpupid = page_cpupid_xchg_last(&folio->page, -1);
+	/*
+	 * For memory tiering mode, when migrate between slow and fast
+	 * memory node, reset cpupid, because that is used to record
+	 * page access time in slow memory node.
+	 */
+	if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) {
+		bool f_toptier = node_is_toptier(page_to_nid(&folio->page));
+		bool t_toptier = node_is_toptier(page_to_nid(&newfolio->page));
+
+		if (f_toptier != t_toptier)
+			cpupid = -1;
+	}
 	page_cpupid_xchg_last(&newfolio->page, cpupid);
 
 	folio_migrate_ksm(newfolio, folio);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index b69ce7a7b2b7..e7cb90d84fac 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -85,6 +85,7 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 			if (prot_numa) {
 				struct page *page;
 				int nid;
+				bool toptier;
 
 				/* Avoid TLB flush if possible */
 				if (pte_protnone(oldpte))
@@ -114,14 +115,19 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 				nid = page_to_nid(page);
 				if (target_node == nid)
 					continue;
+				toptier = node_is_toptier(nid);
 
 				/*
 				 * Skip scanning top tier node if normal numa
 				 * balancing is disabled
 				 */
 				if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_NORMAL) &&
-				    node_is_toptier(nid))
+				    toptier)
 					continue;
+				if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
+				    !toptier)
+					xchg_page_access_time(page,
+						jiffies_to_msecs(jiffies));
 			}
 
 			oldpte = ptep_modify_prot_start(vma, addr, pte);
-- 
2.30.2

