Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A470A50855A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 12:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377428AbiDTKCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 06:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377430AbiDTKCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 06:02:15 -0400
Received: from outbound-smtp07.blacknight.com (outbound-smtp07.blacknight.com [46.22.139.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170253C727
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 02:59:29 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp07.blacknight.com (Postfix) with ESMTPS id B5CC41C418C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 10:59:28 +0100 (IST)
Received: (qmail 10287 invoked from network); 20 Apr 2022 09:59:28 -0000
Received: from unknown (HELO morpheus.112glenside.lan) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPA; 20 Apr 2022 09:59:28 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 1/6] mm/page_alloc: Add page->buddy_list and page->pcp_list
Date:   Wed, 20 Apr 2022 10:59:01 +0100
Message-Id: <20220420095906.27349-2-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220420095906.27349-1-mgorman@techsingularity.net>
References: <20220420095906.27349-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The page allocator uses page->lru for storing pages on either buddy or
PCP lists. Create page->buddy_list and page->pcp_list as a union with
page->lru. This is simply to clarify what type of list a page is on
in the page allocator.

No functional change intended.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 include/linux/mm_types.h |  5 +++++
 mm/page_alloc.c          | 18 +++++++++---------
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 8834e38c06a4..a2782e8af307 100644
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
index 2db95780e003..63976ad4b7f1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -780,7 +780,7 @@ static inline bool set_page_guard(struct zone *zone, struct page *page,
 		return false;
 
 	__SetPageGuard(page);
-	INIT_LIST_HEAD(&page->lru);
+	INIT_LIST_HEAD(&page->buddy_list);
 	set_page_private(page, order);
 	/* Guard pages are not available for any usage */
 	__mod_zone_freepage_state(zone, -(1 << order), migratetype);
@@ -957,7 +957,7 @@ static inline void add_to_free_list(struct page *page, struct zone *zone,
 {
 	struct free_area *area = &zone->free_area[order];
 
-	list_add(&page->lru, &area->free_list[migratetype]);
+	list_add(&page->buddy_list, &area->free_list[migratetype]);
 	area->nr_free++;
 }
 
@@ -967,7 +967,7 @@ static inline void add_to_free_list_tail(struct page *page, struct zone *zone,
 {
 	struct free_area *area = &zone->free_area[order];
 
-	list_add_tail(&page->lru, &area->free_list[migratetype]);
+	list_add_tail(&page->buddy_list, &area->free_list[migratetype]);
 	area->nr_free++;
 }
 
@@ -981,7 +981,7 @@ static inline void move_to_free_list(struct page *page, struct zone *zone,
 {
 	struct free_area *area = &zone->free_area[order];
 
-	list_move_tail(&page->lru, &area->free_list[migratetype]);
+	list_move_tail(&page->buddy_list, &area->free_list[migratetype]);
 }
 
 static inline void del_page_from_free_list(struct page *page, struct zone *zone,
@@ -991,7 +991,7 @@ static inline void del_page_from_free_list(struct page *page, struct zone *zone,
 	if (page_reported(page))
 		__ClearPageReported(page);
 
-	list_del(&page->lru);
+	list_del(&page->buddy_list);
 	__ClearPageBuddy(page);
 	set_page_private(page, 0);
 	zone->free_area[order].nr_free--;
@@ -1493,7 +1493,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 			mt = get_pcppage_migratetype(page);
 
 			/* must delete to avoid corrupting pcp list */
-			list_del(&page->lru);
+			list_del(&page->pcp_list);
 			count -= nr_pages;
 			pcp->count -= nr_pages;
 
@@ -3053,7 +3053,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 		 * for IO devices that can merge IO requests if the physical
 		 * pages are ordered properly.
 		 */
-		list_add_tail(&page->lru, list);
+		list_add_tail(&page->pcp_list, list);
 		allocated++;
 		if (is_migrate_cma(get_pcppage_migratetype(page)))
 			__mod_zone_page_state(zone, NR_FREE_CMA_PAGES,
@@ -3392,7 +3392,7 @@ static void free_unref_page_commit(struct page *page, int migratetype,
 	__count_vm_event(PGFREE);
 	pcp = this_cpu_ptr(zone->per_cpu_pageset);
 	pindex = order_to_pindex(migratetype, order);
-	list_add(&page->lru, &pcp->lists[pindex]);
+	list_add(&page->pcp_list, &pcp->lists[pindex]);
 	pcp->count += 1 << order;
 
 	/*
@@ -3656,7 +3656,7 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 		}
 
 		page = list_first_entry(list, struct page, lru);
-		list_del(&page->lru);
+		list_del(&page->pcp_list);
 		pcp->count -= 1 << order;
 	} while (check_new_pcp(page, order));
 
-- 
2.34.1

