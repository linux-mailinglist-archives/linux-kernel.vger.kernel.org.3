Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544434B81D3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 08:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiBPHkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 02:40:37 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiBPHkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:40:21 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1541802A3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 23:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644997197; x=1676533197;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jzRy520WWDo/AX3mjPDsVEI5uaY1vqJgxYe4BhleBm0=;
  b=RZRGArq8jnylU/CdPLRUfebObeP+vC6JqY4XtIYGi6qaPjyINDs6GJw0
   eDzrzXkrxY9I8rTzvIICMr5Cu3NGXGtf7yB/nGD0H80NzwcGfXWCDXmkm
   OzjVCMPfmUu39vC5AKH2+BRSUDN6XPt9D80RzhNN7aYTB9O0yQlVPfApb
   0NEYBSeTwNVg6DN0SA0dhn9+Cq137FxNKLpuEMDK0dODOVXRQ0pWbtWs9
   L9jGU5HgD/CmJvxLd4xQifmWEmJU6x2P8ye0DTS4eZv2t2mNpdKg7urpY
   iylKoRXTTOx5HQq6FJsfms/p6PbB64SJao0PUyxJOdhQyTv/anqBl+6gD
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="250487365"
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="250487365"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 23:38:35 -0800
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="498414860"
Received: from yhuang6-desk2.sh.intel.com ([10.239.13.11])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 23:38:31 -0800
From:   Huang Ying <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Feng Tang <feng.tang@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Zi Yan <ziy@nvidia.com>, Wei Xu <weixugc@google.com>,
        osalvador <osalvador@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        zhongjiang-ali <zhongjiang-ali@linux.alibaba.com>
Subject: [PATCH -V12 1/3] NUMA Balancing: add page promotion counter
Date:   Wed, 16 Feb 2022 15:38:13 +0800
Message-Id: <20220216073815.2505536-2-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220216073815.2505536-1-ying.huang@intel.com>
References: <20220216073815.2505536-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
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
index 665dbe8cad72..cb6f3d2a57ce 100644
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
+			mod_node_page_state(pgdat, PGPROMOTE_SUCCESS,
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

