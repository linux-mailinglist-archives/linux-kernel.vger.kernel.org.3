Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE225AFC1D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiIGGEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiIGGE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:04:29 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410D2C5B
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 23:04:23 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MMs7K0Ck1zmVDD;
        Wed,  7 Sep 2022 14:00:45 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 7 Sep 2022 14:04:19 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 7 Sep 2022 14:04:19 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        <linux-kernel@vger.kernel.org>, "Vlastimil Babka" <vbabka@suse.cz>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 1/3] mm: reuse pageblock_start/end_pfn() macro
Date:   Wed, 7 Sep 2022 14:08:42 +0800
Message-ID: <20220907060844.126891-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move pageblock_start_pfn/pageblock_end_pfn() into pageblock-flags.h,
then they could be used somewhere else, not only in compaction, also
use ALIGN_DOWN() instead of round_down() to be pair with ALIGN(), which
should be same for pageblock usage.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/pageblock-flags.h |  2 ++
 mm/compaction.c                 |  2 --
 mm/memblock.c                   |  2 +-
 mm/page_alloc.c                 | 13 ++++++-------
 mm/page_isolation.c             | 11 +++++------
 mm/page_owner.c                 |  4 ++--
 6 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/include/linux/pageblock-flags.h b/include/linux/pageblock-flags.h
index 83c7248053a1..a09b7fe6bbf8 100644
--- a/include/linux/pageblock-flags.h
+++ b/include/linux/pageblock-flags.h
@@ -53,6 +53,8 @@ extern unsigned int pageblock_order;
 #endif /* CONFIG_HUGETLB_PAGE */
 
 #define pageblock_nr_pages	(1UL << pageblock_order)
+#define pageblock_start_pfn(pfn)	ALIGN_DOWN((pfn), pageblock_nr_pages)
+#define pageblock_end_pfn(pfn)		ALIGN((pfn) + 1, pageblock_nr_pages)
 
 /* Forward declaration */
 struct page;
diff --git a/mm/compaction.c b/mm/compaction.c
index f72907c7cfef..65bef5f78897 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -52,8 +52,6 @@ static inline void count_compact_events(enum vm_event_item item, long delta)
 
 #define block_start_pfn(pfn, order)	round_down(pfn, 1UL << (order))
 #define block_end_pfn(pfn, order)	ALIGN((pfn) + 1, 1UL << (order))
-#define pageblock_start_pfn(pfn)	block_start_pfn(pfn, pageblock_order)
-#define pageblock_end_pfn(pfn)		block_end_pfn(pfn, pageblock_order)
 
 /*
  * Page order with-respect-to which proactive compaction
diff --git a/mm/memblock.c b/mm/memblock.c
index b5d3026979fc..46fe7575f03c 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2000,7 +2000,7 @@ static void __init free_unused_memmap(void)
 		 * presume that there are no holes in the memory map inside
 		 * a pageblock
 		 */
-		start = round_down(start, pageblock_nr_pages);
+		start = pageblock_start_pfn(start);
 
 		/*
 		 * If we had a previous bank, and there is a space
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e6916d5a25de..7f2fdb8944ae 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -545,7 +545,7 @@ static inline int pfn_to_bitidx(const struct page *page, unsigned long pfn)
 #ifdef CONFIG_SPARSEMEM
 	pfn &= (PAGES_PER_SECTION-1);
 #else
-	pfn = pfn - round_down(page_zone(page)->zone_start_pfn, pageblock_nr_pages);
+	pfn = pfn - pageblock_start_pfn(page_zone(page)->zone_start_pfn);
 #endif /* CONFIG_SPARSEMEM */
 	return (pfn >> pageblock_order) * NR_PAGEBLOCK_BITS;
 }
@@ -1867,7 +1867,7 @@ void set_zone_contiguous(struct zone *zone)
 	unsigned long block_start_pfn = zone->zone_start_pfn;
 	unsigned long block_end_pfn;
 
-	block_end_pfn = ALIGN(block_start_pfn + 1, pageblock_nr_pages);
+	block_end_pfn = pageblock_end_pfn(block_start_pfn);
 	for (; block_start_pfn < zone_end_pfn(zone);
 			block_start_pfn = block_end_pfn,
 			 block_end_pfn += pageblock_nr_pages) {
@@ -2663,8 +2663,8 @@ int move_freepages_block(struct zone *zone, struct page *page,
 		*num_movable = 0;
 
 	pfn = page_to_pfn(page);
-	start_pfn = pfn & ~(pageblock_nr_pages - 1);
-	end_pfn = start_pfn + pageblock_nr_pages - 1;
+	start_pfn = pageblock_start_pfn(pfn);
+	end_pfn = pageblock_end_pfn(pfn) - 1;
 
 	/* Do not cross zone boundaries */
 	if (!zone_spans_pfn(zone, start_pfn))
@@ -6950,9 +6950,8 @@ static void __init init_unavailable_range(unsigned long spfn,
 	u64 pgcnt = 0;
 
 	for (pfn = spfn; pfn < epfn; pfn++) {
-		if (!pfn_valid(ALIGN_DOWN(pfn, pageblock_nr_pages))) {
-			pfn = ALIGN_DOWN(pfn, pageblock_nr_pages)
-				+ pageblock_nr_pages - 1;
+		if (!pfn_valid(pageblock_start_pfn(pfn))) {
+			pfn = pageblock_end_pfn(pfn) - 1;
 			continue;
 		}
 		__init_single_page(pfn_to_page(pfn), pfn, zone, node);
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 9d73dc38e3d7..9c75170980ab 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -37,8 +37,8 @@ static struct page *has_unmovable_pages(unsigned long start_pfn, unsigned long e
 	struct zone *zone = page_zone(page);
 	unsigned long pfn;
 
-	VM_BUG_ON(ALIGN_DOWN(start_pfn, pageblock_nr_pages) !=
-		  ALIGN_DOWN(end_pfn - 1, pageblock_nr_pages));
+	VM_BUG_ON(pageblock_start_pfn(start_pfn) !=
+		  pageblock_start_pfn(end_pfn - 1));
 
 	if (is_migrate_cma_page(page)) {
 		/*
@@ -172,7 +172,7 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
 	 * to avoid redundant checks.
 	 */
 	check_unmovable_start = max(page_to_pfn(page), start_pfn);
-	check_unmovable_end = min(ALIGN(page_to_pfn(page) + 1, pageblock_nr_pages),
+	check_unmovable_end = min(pageblock_end_pfn(page_to_pfn(page)),
 				  end_pfn);
 
 	unmovable = has_unmovable_pages(check_unmovable_start, check_unmovable_end,
@@ -531,7 +531,7 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 	unsigned long pfn;
 	struct page *page;
 	/* isolation is done at page block granularity */
-	unsigned long isolate_start = ALIGN_DOWN(start_pfn, pageblock_nr_pages);
+	unsigned long isolate_start = pageblock_start_pfn(start_pfn);
 	unsigned long isolate_end = ALIGN(end_pfn, pageblock_nr_pages);
 	int ret;
 	bool skip_isolation = false;
@@ -576,10 +576,9 @@ void undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 {
 	unsigned long pfn;
 	struct page *page;
-	unsigned long isolate_start = ALIGN_DOWN(start_pfn, pageblock_nr_pages);
+	unsigned long isolate_start = pageblock_start_pfn(start_pfn);
 	unsigned long isolate_end = ALIGN(end_pfn, pageblock_nr_pages);
 
-
 	for (pfn = isolate_start;
 	     pfn < isolate_end;
 	     pfn += pageblock_nr_pages) {
diff --git a/mm/page_owner.c b/mm/page_owner.c
index 90023f938c19..c91664a4b768 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -297,7 +297,7 @@ void pagetypeinfo_showmixedcount_print(struct seq_file *m,
 			continue;
 		}
 
-		block_end_pfn = ALIGN(pfn + 1, pageblock_nr_pages);
+		block_end_pfn = pageblock_end_pfn(pfn);
 		block_end_pfn = min(block_end_pfn, end_pfn);
 
 		pageblock_mt = get_pageblock_migratetype(page);
@@ -637,7 +637,7 @@ static void init_pages_in_zone(pg_data_t *pgdat, struct zone *zone)
 			continue;
 		}
 
-		block_end_pfn = ALIGN(pfn + 1, pageblock_nr_pages);
+		block_end_pfn = pageblock_end_pfn(pfn);
 		block_end_pfn = min(block_end_pfn, end_pfn);
 
 		for (; pfn < block_end_pfn; pfn++) {
-- 
2.35.3

