Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29975599F2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 14:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbiFXMys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 08:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiFXMyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 08:54:47 -0400
Received: from outbound-smtp51.blacknight.com (outbound-smtp51.blacknight.com [46.22.136.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A552F4F9E5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 05:54:46 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp51.blacknight.com (Postfix) with ESMTPS id 50B78FAC5F
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 13:54:45 +0100 (IST)
Received: (qmail 7081 invoked from network); 24 Jun 2022 12:54:44 -0000
Received: from unknown (HELO morpheus.112glenside.lan) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPA; 24 Jun 2022 12:54:44 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 1/7] mm/page_alloc: Add page->buddy_list and page->pcp_list
Date:   Fri, 24 Jun 2022 13:54:17 +0100
Message-Id: <20220624125423.6126-2-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220624125423.6126-1-mgorman@techsingularity.net>
References: <20220624125423.6126-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The page allocator uses page->lru for storing pages on either buddy or PCP
lists.  Create page->buddy_list and page->pcp_list as a union with
page->lru.  This is simply to clarify what type of list a page is on in
the page allocator.

No functional change intended.

[minchan@kernel.org: fix page lru fields in macros]
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Tested-by: Minchan Kim <minchan@kernel.org>
Acked-by: Minchan Kim <minchan@kernel.org>
Reviewed-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/mm_types.h |  5 +++++
 mm/page_alloc.c          | 24 ++++++++++++------------
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index c29ab4c0cd5c..e6321ec7621d 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -87,6 +87,7 @@ struct page {
 			 */
 			union {
 				struct list_head lru;
+
 				/* Or, for the Unevictable "LRU list" slot */
 				struct {
 					/* Always even, to negate PageTail */
@@ -94,6 +95,10 @@ struct page {
 					/* Count page's or folio's mlocks */
 					unsigned int mlock_count;
 				};
+
+				/* Or, free page */
+				struct list_head buddy_list;
+				struct list_head pcp_list;
 			};
 			/* See page-flags.h for PAGE_MAPPING_FLAGS */
 			struct address_space *mapping;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e008a3df0485..247fa7502199 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -785,7 +785,7 @@ static inline bool set_page_guard(struct zone *zone, struct page *page,
 		return false;
 
 	__SetPageGuard(page);
-	INIT_LIST_HEAD(&page->lru);
+	INIT_LIST_HEAD(&page->buddy_list);
 	set_page_private(page, order);
 	/* Guard pages are not available for any usage */
 	__mod_zone_freepage_state(zone, -(1 << order), migratetype);
@@ -928,7 +928,7 @@ static inline void add_to_free_list(struct page *page, struct zone *zone,
 {
 	struct free_area *area = &zone->free_area[order];
 
-	list_add(&page->lru, &area->free_list[migratetype]);
+	list_add(&page->buddy_list, &area->free_list[migratetype]);
 	area->nr_free++;
 }
 
@@ -938,7 +938,7 @@ static inline void add_to_free_list_tail(struct page *page, struct zone *zone,
 {
 	struct free_area *area = &zone->free_area[order];
 
-	list_add_tail(&page->lru, &area->free_list[migratetype]);
+	list_add_tail(&page->buddy_list, &area->free_list[migratetype]);
 	area->nr_free++;
 }
 
@@ -952,7 +952,7 @@ static inline void move_to_free_list(struct page *page, struct zone *zone,
 {
 	struct free_area *area = &zone->free_area[order];
 
-	list_move_tail(&page->lru, &area->free_list[migratetype]);
+	list_move_tail(&page->buddy_list, &area->free_list[migratetype]);
 }
 
 static inline void del_page_from_free_list(struct page *page, struct zone *zone,
@@ -962,7 +962,7 @@ static inline void del_page_from_free_list(struct page *page, struct zone *zone,
 	if (page_reported(page))
 		__ClearPageReported(page);
 
-	list_del(&page->lru);
+	list_del(&page->buddy_list);
 	__ClearPageBuddy(page);
 	set_page_private(page, 0);
 	zone->free_area[order].nr_free--;
@@ -1504,11 +1504,11 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 		do {
 			int mt;
 
-			page = list_last_entry(list, struct page, lru);
+			page = list_last_entry(list, struct page, pcp_list);
 			mt = get_pcppage_migratetype(page);
 
 			/* must delete to avoid corrupting pcp list */
-			list_del(&page->lru);
+			list_del(&page->pcp_list);
 			count -= nr_pages;
 			pcp->count -= nr_pages;
 
@@ -3068,7 +3068,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 		 * for IO devices that can merge IO requests if the physical
 		 * pages are ordered properly.
 		 */
-		list_add_tail(&page->lru, list);
+		list_add_tail(&page->pcp_list, list);
 		allocated++;
 		if (is_migrate_cma(get_pcppage_migratetype(page)))
 			__mod_zone_page_state(zone, NR_FREE_CMA_PAGES,
@@ -3318,7 +3318,7 @@ void mark_free_pages(struct zone *zone)
 
 	for_each_migratetype_order(order, t) {
 		list_for_each_entry(page,
-				&zone->free_area[order].free_list[t], lru) {
+				&zone->free_area[order].free_list[t], buddy_list) {
 			unsigned long i;
 
 			pfn = page_to_pfn(page);
@@ -3407,7 +3407,7 @@ static void free_unref_page_commit(struct page *page, int migratetype,
 	__count_vm_event(PGFREE);
 	pcp = this_cpu_ptr(zone->per_cpu_pageset);
 	pindex = order_to_pindex(migratetype, order);
-	list_add(&page->lru, &pcp->lists[pindex]);
+	list_add(&page->pcp_list, &pcp->lists[pindex]);
 	pcp->count += 1 << order;
 
 	/*
@@ -3670,8 +3670,8 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 				return NULL;
 		}
 
-		page = list_first_entry(list, struct page, lru);
-		list_del(&page->lru);
+		page = list_first_entry(list, struct page, pcp_list);
+		list_del(&page->pcp_list);
 		pcp->count -= 1 << order;
 	} while (check_new_pcp(page, order));
 
-- 
2.35.3

