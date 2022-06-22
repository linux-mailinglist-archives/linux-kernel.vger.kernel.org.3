Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CAC5549C5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354107AbiFVIfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235752AbiFVIfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:35:36 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CE3387A7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655886934; x=1687422934;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YArFnKgq4SeFXR29zesZOHzq0irUs/K2a0FJQu/MuJU=;
  b=Ai62issFcLOIEoM8ZRxAw69v62bdDDxTOYqrSXR7jL/vHIypgjKJBao9
   suD5ue4JY2imRbqeFcIQ51vigrIFMIOBFsZKXGHdEgbGpq1CVo05JRobX
   5iEGFAEBlOIzJCiR6TcEhCso1uYrOSVZ2bGvz7364x1Tl9UdwKyUPiQyT
   8aPeNq3+bRJicYCjrvusrIQ82cTjPFpRS7aC30TdCczKHkKZ4O8SQsu4y
   TqXPyUm0Le7EqF7En8RoSBCE5ht2rQIkSbrBicTRwjo6+9KJiKckq9oly
   nZdr1dAZ+aFXIk4yaE33UHC19q25IsURqpvupFr8YTP0kEmd2J1ByCN90
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="281429392"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="281429392"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 01:35:34 -0700
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="644076933"
Received: from lzha111-mobl.ccr.corp.intel.com (HELO yhuang6-mobl1.ccr.corp.intel.com) ([10.254.215.232])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 01:35:30 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Wei Xu <weixugc@google.com>, osalvador <osalvador@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Zhong Jiang <zhongjiang-ali@linux.alibaba.com>
Subject: [PATCH -V4 1/3] memory tiering: hot page selection with hint page fault latency
Date:   Wed, 22 Jun 2022 16:35:17 +0800
Message-Id: <20220622083519.708236-2-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220622083519.708236-1-ying.huang@intel.com>
References: <20220622083519.708236-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
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
index bc8f326be0ce..6fd23267597d 100644
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
index 77b2048a9326..edc3d741ef84 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1070,6 +1070,9 @@ unsigned int sysctl_numa_balancing_scan_size = 256;
 /* Scan @scan_size MB every @scan_period after an initial @scan_delay in ms */
 unsigned int sysctl_numa_balancing_scan_delay = 1000;
 
+/* The page with hint page fault latency < threshold in ms is considered hot */
+unsigned int sysctl_numa_balancing_hot_threshold = MSEC_PER_SEC;
+
 struct numa_group {
 	refcount_t refcount;
 
@@ -1412,6 +1415,68 @@ static inline unsigned long group_weight(struct task_struct *p, int nid,
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
@@ -1419,9 +1484,34 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
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
@@ -2654,6 +2744,15 @@ void task_numa_fault(int last_cpupid, int mem_node, int pages, int flags)
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
index 47b89a0fc6e5..64a7f15be0e3 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2411,6 +2411,7 @@ extern unsigned int sysctl_numa_balancing_scan_delay;
 extern unsigned int sysctl_numa_balancing_scan_period_min;
 extern unsigned int sysctl_numa_balancing_scan_period_max;
 extern unsigned int sysctl_numa_balancing_scan_size;
+extern unsigned int sysctl_numa_balancing_hot_threshold;
 #endif
 
 #ifdef CONFIG_SCHED_HRTICK
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f7248002dad9..2b1ef95c1d7b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1410,7 +1410,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	struct page *page;
 	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
 	int page_nid = NUMA_NO_NODE;
-	int target_nid, last_cpupid = -1;
+	int target_nid, last_cpupid = (-1 & LAST_CPUPID_MASK);
 	bool migrated = false;
 	bool was_writable = pmd_savedwrite(oldpmd);
 	int flags = 0;
@@ -1431,7 +1431,12 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
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
 
@@ -1755,6 +1760,7 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 
 	if (prot_numa) {
 		struct page *page;
+		bool toptier;
 		/*
 		 * Avoid trapping faults against the zero page. The read-only
 		 * data is likely to be read-cached on the local CPU and
@@ -1767,13 +1773,18 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
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
index 3383d3530a4f..c1dac8095880 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -74,6 +74,7 @@
 #include <linux/perf_event.h>
 #include <linux/ptrace.h>
 #include <linux/vmalloc.h>
+#include <linux/sched/sysctl.h>
 
 #include <trace/events/kmem.h>
 
@@ -4726,8 +4727,16 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
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
index 8a897f34ce2c..bb0bb604a5f7 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -541,6 +541,18 @@ void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
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
index ba5592655ee3..4da10376a23b 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -89,6 +89,7 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
 			if (prot_numa) {
 				struct page *page;
 				int nid;
+				bool toptier;
 
 				/* Avoid TLB flush if possible */
 				if (pte_protnone(oldpte))
@@ -118,14 +119,19 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
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

