Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954085AFC1E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiIGGEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiIGGE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:04:29 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD227B2D
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 23:04:25 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MMs8V6mtCznVh2;
        Wed,  7 Sep 2022 14:01:46 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 7 Sep 2022 14:04:20 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 7 Sep 2022 14:04:20 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        <linux-kernel@vger.kernel.org>, "Vlastimil Babka" <vbabka@suse.cz>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 3/3] mm: add pageblock_aligned() macro
Date:   Wed, 7 Sep 2022 14:08:44 +0800
Message-ID: <20220907060844.126891-3-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220907060844.126891-1-wangkefeng.wang@huawei.com>
References: <20220907060844.126891-1-wangkefeng.wang@huawei.com>
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

Add pageblock_aligned() and use it to simplify code.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
v2: fix convert in page_alloc.c
 include/linux/pageblock-flags.h |  1 +
 mm/compaction.c                 |  8 ++++----
 mm/memory_hotplug.c             |  6 ++----
 mm/page_alloc.c                 | 17 +++++++----------
 mm/page_isolation.c             |  2 +-
 5 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/include/linux/pageblock-flags.h b/include/linux/pageblock-flags.h
index 293c76630fa8..5f1ae07d724b 100644
--- a/include/linux/pageblock-flags.h
+++ b/include/linux/pageblock-flags.h
@@ -54,6 +54,7 @@ extern unsigned int pageblock_order;
 
 #define pageblock_nr_pages	(1UL << pageblock_order)
 #define pageblock_align(pfn)	ALIGN((pfn), pageblock_nr_pages)
+#define pageblock_aligned(pfn)	IS_ALIGNED((pfn), pageblock_nr_pages)
 #define pageblock_start_pfn(pfn)	ALIGN_DOWN((pfn), pageblock_nr_pages)
 #define pageblock_end_pfn(pfn)		ALIGN((pfn) + 1, pageblock_nr_pages)
 
diff --git a/mm/compaction.c b/mm/compaction.c
index 65bef5f78897..c4e4453187a2 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -402,7 +402,7 @@ static bool test_and_set_skip(struct compact_control *cc, struct page *page,
 	if (cc->ignore_skip_hint)
 		return false;
 
-	if (!IS_ALIGNED(pfn, pageblock_nr_pages))
+	if (!pageblock_aligned(pfn))
 		return false;
 
 	skip = get_pageblock_skip(page);
@@ -884,7 +884,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		 * COMPACT_CLUSTER_MAX at a time so the second call must
 		 * not falsely conclude that the block should be skipped.
 		 */
-		if (!valid_page && IS_ALIGNED(low_pfn, pageblock_nr_pages)) {
+		if (!valid_page && pageblock_aligned(low_pfn)) {
 			if (!isolation_suitable(cc, page)) {
 				low_pfn = end_pfn;
 				page = NULL;
@@ -1936,7 +1936,7 @@ static isolate_migrate_t isolate_migratepages(struct compact_control *cc)
 		 * before making it "skip" so other compaction instances do
 		 * not scan the same block.
 		 */
-		if (IS_ALIGNED(low_pfn, pageblock_nr_pages) &&
+		if (pageblock_aligned(low_pfn) &&
 		    !fast_find_block && !isolation_suitable(cc, page))
 			continue;
 
@@ -2122,7 +2122,7 @@ static enum compact_result __compact_finished(struct compact_control *cc)
 	 * migration source is unmovable/reclaimable but it's not worth
 	 * special casing.
 	 */
-	if (!IS_ALIGNED(cc->migrate_pfn, pageblock_nr_pages))
+	if (!pageblock_aligned(cc->migrate_pfn))
 		return COMPACT_CONTINUE;
 
 	/* Direct compactor: Is a suitable page free? */
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 9ae1f98548b1..fd40f7e9f176 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1085,8 +1085,7 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 	 * of the physical memory space for vmemmaps. That space is pageblock
 	 * aligned.
 	 */
-	if (WARN_ON_ONCE(!nr_pages ||
-			 !IS_ALIGNED(pfn, pageblock_nr_pages) ||
+	if (WARN_ON_ONCE(!nr_pages || !pageblock_aligned(pfn) ||
 			 !IS_ALIGNED(pfn + nr_pages, PAGES_PER_SECTION)))
 		return -EINVAL;
 
@@ -1806,8 +1805,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 	 * of the physical memory space for vmemmaps. That space is pageblock
 	 * aligned.
 	 */
-	if (WARN_ON_ONCE(!nr_pages ||
-			 !IS_ALIGNED(start_pfn, pageblock_nr_pages) ||
+	if (WARN_ON_ONCE(!nr_pages || !pageblock_aligned(start_pfn) ||
 			 !IS_ALIGNED(start_pfn + nr_pages, PAGES_PER_SECTION)))
 		return -EINVAL;
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7f2fdb8944ae..ba5c9402a5cb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1902,15 +1902,14 @@ static void __init deferred_free_range(unsigned long pfn,
 	page = pfn_to_page(pfn);
 
 	/* Free a large naturally-aligned chunk if possible */
-	if (nr_pages == pageblock_nr_pages &&
-	    (pfn & (pageblock_nr_pages - 1)) == 0) {
+	if (nr_pages == pageblock_nr_pages && pageblock_aligned(pfn)) {
 		set_pageblock_migratetype(page, MIGRATE_MOVABLE);
 		__free_pages_core(page, pageblock_order);
 		return;
 	}
 
 	for (i = 0; i < nr_pages; i++, page++, pfn++) {
-		if ((pfn & (pageblock_nr_pages - 1)) == 0)
+		if (pageblock_aligned(pfn))
 			set_pageblock_migratetype(page, MIGRATE_MOVABLE);
 		__free_pages_core(page, 0);
 	}
@@ -1938,7 +1937,7 @@ static inline void __init pgdat_init_report_one_done(void)
  */
 static inline bool __init deferred_pfn_valid(unsigned long pfn)
 {
-	if (!(pfn & (pageblock_nr_pages - 1)) && !pfn_valid(pfn))
+	if (pageblock_aligned(pfn) && !pfn_valid(pfn))
 		return false;
 	return true;
 }
@@ -1950,14 +1949,13 @@ static inline bool __init deferred_pfn_valid(unsigned long pfn)
 static void __init deferred_free_pages(unsigned long pfn,
 				       unsigned long end_pfn)
 {
-	unsigned long nr_pgmask = pageblock_nr_pages - 1;
 	unsigned long nr_free = 0;
 
 	for (; pfn < end_pfn; pfn++) {
 		if (!deferred_pfn_valid(pfn)) {
 			deferred_free_range(pfn - nr_free, nr_free);
 			nr_free = 0;
-		} else if (!(pfn & nr_pgmask)) {
+		} else if (pageblock_aligned(pfn)) {
 			deferred_free_range(pfn - nr_free, nr_free);
 			nr_free = 1;
 		} else {
@@ -1977,7 +1975,6 @@ static unsigned long  __init deferred_init_pages(struct zone *zone,
 						 unsigned long pfn,
 						 unsigned long end_pfn)
 {
-	unsigned long nr_pgmask = pageblock_nr_pages - 1;
 	int nid = zone_to_nid(zone);
 	unsigned long nr_pages = 0;
 	int zid = zone_idx(zone);
@@ -1987,7 +1984,7 @@ static unsigned long  __init deferred_init_pages(struct zone *zone,
 		if (!deferred_pfn_valid(pfn)) {
 			page = NULL;
 			continue;
-		} else if (!page || !(pfn & nr_pgmask)) {
+		} else if (!page || pageblock_aligned(pfn)) {
 			page = pfn_to_page(pfn);
 		} else {
 			page++;
@@ -6770,7 +6767,7 @@ void __meminit memmap_init_range(unsigned long size, int nid, unsigned long zone
 		 * such that unmovable allocations won't be scattered all
 		 * over the place during system boot.
 		 */
-		if (IS_ALIGNED(pfn, pageblock_nr_pages)) {
+		if (pageblock_aligned(pfn)) {
 			set_pageblock_migratetype(page, migratetype);
 			cond_resched();
 		}
@@ -6813,7 +6810,7 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
 	 * Please note that MEMINIT_HOTPLUG path doesn't clear memmap
 	 * because this is done early in section_activate()
 	 */
-	if (IS_ALIGNED(pfn, pageblock_nr_pages)) {
+	if (pageblock_aligned(pfn)) {
 		set_pageblock_migratetype(page, MIGRATE_MOVABLE);
 		cond_resched();
 	}
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index abd74bd24a35..c66d61e0bc72 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -311,7 +311,7 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
 	struct zone *zone;
 	int ret;
 
-	VM_BUG_ON(!IS_ALIGNED(boundary_pfn, pageblock_nr_pages));
+	VM_BUG_ON(!pageblock_aligned(boundary_pfn));
 
 	if (isolate_before)
 		isolate_pageblock = boundary_pfn - pageblock_nr_pages;
-- 
2.35.3

