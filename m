Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A4049F515
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 09:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347283AbiA1I2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 03:28:14 -0500
Received: from mga01.intel.com ([192.55.52.88]:54784 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347139AbiA1I2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 03:28:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643358492; x=1674894492;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vbZJdK5LKiAu7te1Is/DA1saWsH5GBMr92L9qszkh5c=;
  b=bR+zg1EDxI/rBDFrggevmVZUePXjuKq+Rrkx5Erxl16PgaRt9TWV7iIZ
   hFIov17HG7MlnWuF71Yf45XG6dCVqyaJ40aDrv18gBlZyISULodekMwdR
   /fbvz8GJ13muAZKYtohbtbjWwNcLfsRkQ66r3LjdyZ2hhvg6BpK9XkF8/
   ZLIL+BSdxQz0vHUuCdIMGU9yqH0YWn/Fb1Dj8cU4vecDucJHFRrDpl6ny
   QwABp18A8m5epS1BWvrRyDcUx3X4pmRZb24NQiKLQFAsUU3DDJRhSoGPL
   q/dQn2GVOYHC60aThyRGmHn3pvmDrgdUxZETI+00r5fqF6QorDzHfIPeE
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="271537180"
X-IronPort-AV: E=Sophos;i="5.88,323,1635231600"; 
   d="scan'208";a="271537180"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 00:28:12 -0800
X-IronPort-AV: E=Sophos;i="5.88,323,1635231600"; 
   d="scan'208";a="697019619"
Received: from yhuang6-desk2.sh.intel.com ([10.239.13.11])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 00:28:08 -0800
From:   Huang Ying <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>, Mel Gorman <mgorman@suse.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Feng Tang <feng.tang@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Zi Yan <ziy@nvidia.com>, Wei Xu <weixugc@google.com>,
        osalvador <osalvador@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        zhongjiang-ali <zhongjiang-ali@linux.alibaba.com>
Subject: [PATCH -V11 1/3] NUMA Balancing: add page promotion counter
Date:   Fri, 28 Jan 2022 16:27:49 +0800
Message-Id: <20220128082751.593478-2-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220128082751.593478-1-ying.huang@intel.com>
References: <20220128082751.593478-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a system with multiple memory types, e.g. DRAM and PMEM, the CPU
and DRAM in one socket will be put in one NUMA node as before, while
the PMEM will be put in another NUMA node as described in the
description of the commit c221c0b0308f ("device-dax: "Hotplug"
persistent memory for use like normal RAM").  So, the NUMA balancing
mechanism will identify all PMEM accesses as remote access and try to
promote the PMEM pages to DRAM.

To distinguish the number of the inter-type promoted pages from that
of the inter-socket migrated pages.  A new vmstat count is added.  The
counter is per-node (count in the target node).  So this can be used
to identify promotion imbalance among the NUMA nodes.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Yang Shi <shy828301@gmail.com>
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Wei Xu <weixugc@google.com>
Cc: osalvador <osalvador@suse.de>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: zhongjiang-ali <zhongjiang-ali@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 include/linux/mmzone.h |  3 +++
 include/linux/node.h   |  5 +++++
 mm/migrate.c           | 13 ++++++++++---
 mm/vmstat.c            |  3 +++
 4 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index aed44e9b5d89..44bd054ca12b 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -210,6 +210,9 @@ enum node_stat_item {
 	NR_PAGETABLE,		/* used for pagetables */
 #ifdef CONFIG_SWAP
 	NR_SWAPCACHE,
+#endif
+#ifdef CONFIG_NUMA_BALANCING
+	PGPROMOTE_SUCCESS,	/* promote successfully */
 #endif
 	NR_VM_NODE_STAT_ITEMS
 };
diff --git a/include/linux/node.h b/include/linux/node.h
index bb21fd631b16..81bbf1c0afd3 100644
--- a/include/linux/node.h
+++ b/include/linux/node.h
@@ -181,4 +181,9 @@ static inline void register_hugetlbfs_with_node(node_registration_func_t reg,
 
 #define to_node(device) container_of(device, struct node, dev)
 
+static inline bool node_is_toptier(int node)
+{
+	return node_state(node, N_CPU);
+}
+
 #endif /* _LINUX_NODE_H_ */
diff --git a/mm/migrate.c b/mm/migrate.c
index 665dbe8cad72..a5971e9f6e6a 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2072,6 +2072,7 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 	pg_data_t *pgdat = NODE_DATA(node);
 	int isolated;
 	int nr_remaining;
+	int nr_succeeded;
 	LIST_HEAD(migratepages);
 	new_page_t *new;
 	bool compound;
@@ -2110,7 +2111,8 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 
 	list_add(&page->lru, &migratepages);
 	nr_remaining = migrate_pages(&migratepages, *new, NULL, node,
-				     MIGRATE_ASYNC, MR_NUMA_MISPLACED, NULL);
+				     MIGRATE_ASYNC, MR_NUMA_MISPLACED,
+				     &nr_succeeded);
 	if (nr_remaining) {
 		if (!list_empty(&migratepages)) {
 			list_del(&page->lru);
@@ -2119,8 +2121,13 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 			putback_lru_page(page);
 		}
 		isolated = 0;
-	} else
-		count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_pages);
+	}
+	if (nr_succeeded) {
+		count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_succeeded);
+		if (!node_is_toptier(page_to_nid(page)) && node_is_toptier(node))
+			mod_node_page_state(NODE_DATA(node), PGPROMOTE_SUCCESS,
+					    nr_succeeded);
+	}
 	BUG_ON(!list_empty(&migratepages));
 	return isolated;
 
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 4057372745d0..846b670dd346 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1242,6 +1242,9 @@ const char * const vmstat_text[] = {
 #ifdef CONFIG_SWAP
 	"nr_swapcached",
 #endif
+#ifdef CONFIG_NUMA_BALANCING
+	"pgpromote_success",
+#endif
 
 	/* enum writeback_stat_item counters */
 	"nr_dirty_threshold",
-- 
2.30.2

