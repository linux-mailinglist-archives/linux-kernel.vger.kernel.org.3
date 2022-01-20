Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E1F494EA5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 14:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359226AbiATNLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 08:11:00 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38304 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358903AbiATNK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 08:10:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 800DFB81CE2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 13:10:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0764CC340E0;
        Thu, 20 Jan 2022 13:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642684256;
        bh=RPytYW4cUkzX5lKrjMDB5tI8NLNX7cdMDRiOGw0yy0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mN4yiBGKKLuHK08vrum6hGew7gy+Vc47wSbUzgk/rCRGx8GJpT3miA0AKkv0yfHAd
         suypRZZbFlTIuLMfmx2rMnFbfW5bT3mP3gIVx+4tiTzyjVi1LGIzDYmKl37SY2q5KS
         fFykeVa1T2fl+TGoTSw+sKNNCPka2MKxHiZwJvK5WpCZF28c8IYZ2OVsNNTqR3vmqs
         4M9J7/v5Bb88CbFKWQmHNZOO6oFm/+mmOPSxMQXJq2CsAkU1INtnjbl3HB9adL6Pm4
         f4/w+RYJnKP+3U1NgncJ5ceGfVVsVRasCkF5m5zzfr+gYGH2qNLGNaI+Lp1BrKAvhJ
         VapLgFpTEElmA==
From:   alexs@kernel.org
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alex Shi <alexs@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Yu Zhao <yuzhao@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 1/5] mm: remove page_is_file_lru function
Date:   Thu, 20 Jan 2022 21:10:20 +0800
Message-Id: <20220120131024.502877-2-alexs@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220120131024.502877-1-alexs@kernel.org>
References: <20220120131024.502877-1-alexs@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Shi <alexs@kernel.org>

This function could be full replaced by folio_is_file_lru, so no reason
to keep a duplicate function.

Signed-off-by: Alex Shi <alexs@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 include/linux/mm_inline.h     |  5 -----
 include/trace/events/vmscan.h |  2 +-
 mm/compaction.c               |  2 +-
 mm/gup.c                      |  2 +-
 mm/khugepaged.c               |  4 ++--
 mm/memory-failure.c           |  2 +-
 mm/memory_hotplug.c           |  2 +-
 mm/mempolicy.c                |  2 +-
 mm/migrate.c                  | 14 +++++++-------
 mm/mprotect.c                 |  2 +-
 mm/vmscan.c                   | 13 +++++++------
 11 files changed, 23 insertions(+), 27 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index b725839dfe71..f0aa34b0f2c4 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -27,11 +27,6 @@ static inline int folio_is_file_lru(struct folio *folio)
 	return !folio_test_swapbacked(folio);
 }
 
-static inline int page_is_file_lru(struct page *page)
-{
-	return folio_is_file_lru(page_folio(page));
-}
-
 static __always_inline void update_lru_size(struct lruvec *lruvec,
 				enum lru_list lru, enum zone_type zid,
 				long nr_pages)
diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index ca2e9009a651..51a2b1766b05 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -341,7 +341,7 @@ TRACE_EVENT(mm_vmscan_writepage,
 	TP_fast_assign(
 		__entry->pfn = page_to_pfn(page);
 		__entry->reclaim_flags = trace_reclaim_flags(
-						page_is_file_lru(page));
+						folio_is_file_lru(page_folio(page)));
 	),
 
 	TP_printk("page=%p pfn=0x%lx flags=%s",
diff --git a/mm/compaction.c b/mm/compaction.c
index b4e94cda3019..12f2af6ac484 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1066,7 +1066,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		/* Successfully isolated */
 		del_page_from_lru_list(page, lruvec);
 		mod_node_page_state(page_pgdat(page),
-				NR_ISOLATED_ANON + page_is_file_lru(page),
+				NR_ISOLATED_ANON + folio_is_file_lru(page_folio(page)),
 				thp_nr_pages(page));
 
 isolate_success:
diff --git a/mm/gup.c b/mm/gup.c
index f4c7645ccf8f..f3fea1efc2e2 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1900,7 +1900,7 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 				list_add_tail(&head->lru, &movable_page_list);
 				mod_node_page_state(page_pgdat(head),
 						    NR_ISOLATED_ANON +
-						    page_is_file_lru(head),
+						    folio_is_file_lru(page_folio(head)),
 						    thp_nr_pages(head));
 			}
 		}
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 35f14d0a00a6..8caed4089242 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -561,7 +561,7 @@ void __khugepaged_exit(struct mm_struct *mm)
 static void release_pte_page(struct page *page)
 {
 	mod_node_page_state(page_pgdat(page),
-			NR_ISOLATED_ANON + page_is_file_lru(page),
+			NR_ISOLATED_ANON + folio_is_file_lru(page_folio(page)),
 			-compound_nr(page));
 	unlock_page(page);
 	putback_lru_page(page);
@@ -703,7 +703,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 			goto out;
 		}
 		mod_node_page_state(page_pgdat(page),
-				NR_ISOLATED_ANON + page_is_file_lru(page),
+				NR_ISOLATED_ANON + folio_is_file_lru(page_folio(page)),
 				compound_nr(page));
 		VM_BUG_ON_PAGE(!PageLocked(page), page);
 		VM_BUG_ON_PAGE(PageLRU(page), page);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 14ae5c18e776..9405388ab852 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2113,7 +2113,7 @@ static bool isolate_page(struct page *page, struct list_head *pagelist)
 
 	if (isolated && lru)
 		inc_node_page_state(page, NR_ISOLATED_ANON +
-				    page_is_file_lru(page));
+				    folio_is_file_lru(page_folio(page)));
 
 	/*
 	 * If we succeed to isolate the page, we grabbed another refcount on
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 0139b77c51d5..94b0d14da0af 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1731,7 +1731,7 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 			list_add_tail(&page->lru, &source);
 			if (!__PageMovable(page))
 				inc_node_page_state(page, NR_ISOLATED_ANON +
-						    page_is_file_lru(page));
+						    folio_is_file_lru(page_folio(page)));
 
 		} else {
 			if (__ratelimit(&migrate_rs)) {
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index a86590b2507d..f5c3c86d7c31 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1032,7 +1032,7 @@ static int migrate_page_add(struct page *page, struct list_head *pagelist,
 		if (!isolate_lru_page(head)) {
 			list_add_tail(&head->lru, pagelist);
 			mod_node_page_state(page_pgdat(head),
-				NR_ISOLATED_ANON + page_is_file_lru(head),
+				NR_ISOLATED_ANON + folio_is_file_lru(page_folio(head)),
 				thp_nr_pages(head));
 		} else if (flags & MPOL_MF_STRICT) {
 			/*
diff --git a/mm/migrate.c b/mm/migrate.c
index c7da064b4781..bdd7425556db 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -164,7 +164,7 @@ void putback_movable_pages(struct list_head *l)
 			put_page(page);
 		} else {
 			mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON +
-					page_is_file_lru(page), -thp_nr_pages(page));
+					folio_is_file_lru(page_folio(page)), -thp_nr_pages(page));
 			putback_lru_page(page);
 		}
 	}
@@ -1129,7 +1129,7 @@ static int unmap_and_move(new_page_t get_new_page,
 		 */
 		if (likely(!__PageMovable(page)))
 			mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON +
-					page_is_file_lru(page), -thp_nr_pages(page));
+					folio_is_file_lru(page_folio(page)), -thp_nr_pages(page));
 
 		if (reason != MR_MEMORY_FAILURE)
 			/*
@@ -1657,7 +1657,7 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
 		err = 1;
 		list_add_tail(&head->lru, pagelist);
 		mod_node_page_state(page_pgdat(head),
-			NR_ISOLATED_ANON + page_is_file_lru(head),
+			NR_ISOLATED_ANON + folio_is_file_lru(page_folio(head)),
 			thp_nr_pages(head));
 	}
 out_putpage:
@@ -2048,7 +2048,7 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
 	if (isolate_lru_page(page))
 		return 0;
 
-	page_lru = page_is_file_lru(page);
+	page_lru = folio_is_file_lru(page_folio(page));
 	mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON + page_lru,
 			    nr_pages);
 
@@ -2093,7 +2093,7 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 	 * Don't migrate file pages that are mapped in multiple processes
 	 * with execute permissions as they are probably shared libraries.
 	 */
-	if (page_mapcount(page) != 1 && page_is_file_lru(page) &&
+	if (page_mapcount(page) != 1 && folio_is_file_lru(page_folio(page)) &&
 	    (vma->vm_flags & VM_EXEC))
 		goto out;
 
@@ -2101,7 +2101,7 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 	 * Also do not migrate dirty pages as not all filesystems can move
 	 * dirty pages in MIGRATE_ASYNC mode which is a waste of cycles.
 	 */
-	if (page_is_file_lru(page) && PageDirty(page))
+	if (folio_is_file_lru(page_folio(page)) && PageDirty(page))
 		goto out;
 
 	isolated = numamigrate_isolate_page(pgdat, page);
@@ -2115,7 +2115,7 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 		if (!list_empty(&migratepages)) {
 			list_del(&page->lru);
 			mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON +
-					page_is_file_lru(page), -nr_pages);
+					folio_is_file_lru(page_folio(page)), -nr_pages);
 			putback_lru_page(page);
 		}
 		isolated = 0;
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 0138dfcdb1d8..31d1270deb4f 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -102,7 +102,7 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 				 * it cannot move them all from MIGRATE_ASYNC
 				 * context.
 				 */
-				if (page_is_file_lru(page) && PageDirty(page))
+				if (folio_is_file_lru(page_folio(page)) && PageDirty(page))
 					continue;
 
 				/*
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 0dbfa3a69567..c361973774b4 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1311,7 +1311,7 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
 		 * exceptional entries and shadow exceptional entries in the
 		 * same address_space.
 		 */
-		if (reclaimed && page_is_file_lru(page) &&
+		if (reclaimed && folio_is_file_lru(page_folio(page)) &&
 		    !mapping_exiting(mapping) && !dax_mapping(mapping))
 			shadow = workingset_eviction(page, target_memcg);
 		__delete_from_page_cache(page, shadow);
@@ -1438,7 +1438,7 @@ static void page_check_dirty_writeback(struct page *page,
 	 * Anonymous pages are not handled by flushers and must be written
 	 * from reclaim context. Do not stall reclaim based on them
 	 */
-	if (!page_is_file_lru(page) ||
+	if (!folio_is_file_lru(page_folio(page)) ||
 	    (PageAnon(page) && !PageSwapBacked(page))) {
 		*dirty = false;
 		*writeback = false;
@@ -1777,7 +1777,7 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 			 * the rest of the LRU for clean pages and see
 			 * the same dirty pages again (PageReclaim).
 			 */
-			if (page_is_file_lru(page) &&
+			if (folio_is_file_lru(page_folio(page)) &&
 			    (!current_is_kswapd() || !PageReclaim(page) ||
 			     !test_bit(PGDAT_DIRTY, &pgdat->flags))) {
 				/*
@@ -1927,7 +1927,7 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 			try_to_free_swap(page);
 		VM_BUG_ON_PAGE(PageActive(page), page);
 		if (!PageMlocked(page)) {
-			int type = page_is_file_lru(page);
+			int type = folio_is_file_lru(page_folio(page));
 			SetPageActive(page);
 			stat->nr_activate[type] += nr_pages;
 			count_memcg_page_event(page, PGACTIVATE);
@@ -1976,7 +1976,7 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 	unsigned int noreclaim_flag;
 
 	list_for_each_entry_safe(page, next, page_list, lru) {
-		if (!PageHuge(page) && page_is_file_lru(page) &&
+		if (!PageHuge(page) && folio_is_file_lru(page_folio(page)) &&
 		    !PageDirty(page) && !__PageMovable(page) &&
 		    !PageUnevictable(page)) {
 			ClearPageActive(page);
@@ -2555,7 +2555,8 @@ static void shrink_active_list(unsigned long nr_to_scan,
 			 * IO, plus JVM can create lots of anon VM_EXEC pages,
 			 * so we ignore them here.
 			 */
-			if ((vm_flags & VM_EXEC) && page_is_file_lru(page)) {
+			if ((vm_flags & VM_EXEC) &&
+					folio_is_file_lru(page_folio(page))) {
 				nr_rotated += thp_nr_pages(page);
 				list_add(&page->lru, &l_active);
 				continue;
-- 
2.25.1

