Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5AB4CE2A1
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 06:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiCEFCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 00:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiCEFCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 00:02:01 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327D3243151
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 21:01:12 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id j5so8174170qvs.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 21:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version;
        bh=2eHN3M1iaBOEXAhuMwT4K/TklzzBAZXqZy5TjPog49E=;
        b=fTJpKc4Ukfqz8n9hmt3kieVLQFx9jGVKMlQmPJDr+Ph//7kasa7068NmKEPFsK9YJC
         mHAg0eyxUW2ZIilDzYThgESADnYqzavU6gCXek9MzCRIzl4xmUNmJLmJzvZWbz0mgKs5
         9P2KBoKcOBNyYVBNCr/cQ6pp96z5Dvx0gvOGOULVLJrmndNXjXgENgUWBGd2eVrlS0DD
         DA93zQ4FyZgQgb+0ky9tQ2OqlZ16Z9Olo2azdKtjLATUQ/jyzwuwDfyPODx5Jkb3761w
         TwdKiq66ZA55pf4+E6MD+uih8DrfG5wX7hnRhsBB1yfa0uoe3OQ5XmwE/A3BV9p1midp
         NAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version;
        bh=2eHN3M1iaBOEXAhuMwT4K/TklzzBAZXqZy5TjPog49E=;
        b=SgfIVoyVkei/qEogpwravd5WN1rhU/FnnnIPC7an3RY/x8kNs7aAd+WGm+eu3NH+fd
         MXsk3y6QG5UTr1s/m3lupd+YoSgb3Qp7oYQxgJtZk/mENTmBxDxVAhp4uorrtKEde976
         1ttJxjTapJ8x88rJS5+Br/lneyLhwlk0nDiRBTPANBq4Wpb53UeNa3fi2K7In/PVre0q
         s/wrg4QRj14GYEpkixUbTq1UyYBvkgyybJkjOkfdK9O1bPjoxSe/A8kwDAdMdsIkgHmP
         VmjnwPr6F744JvYVsgXUN1nfqMM9Zp2sDGBXxOaoeaGFtQjcPUvi7NEg8GFY6bd6U5DD
         XvYQ==
X-Gm-Message-State: AOAM530lpxCJERnAfRu1P+JeGT4fK0CnAUlxAGXP7FZZojh1GpKl9LR0
        Xb3SYmOMf+ad1d4+bq6wvef0cg==
X-Google-Smtp-Source: ABdhPJw2+Pvs5efe6ArxppAsDNI4CrNs4kOH1t66NFlCbZ+Sv7hGfQZsWJF7sTgzsx26KcPSZaUyoQ==
X-Received: by 2002:a05:6214:5199:b0:435:32a:13af with SMTP id kl25-20020a056214519900b00435032a13afmr1648511qvb.116.1646456470976;
        Fri, 04 Mar 2022 21:01:10 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id t18-20020ac85892000000b002de3a8bf768sm4853239qta.52.2022.03.04.21.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 21:01:10 -0800 (PST)
Date:   Fri, 4 Mar 2022 21:00:57 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Alex Shi <alexs@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH mmotm] mm: __isolate_lru_page_prepare() in
 isolate_migratepages_block()
Message-ID: <879d62a8-91cc-d3c6-fb3b-69768236df68@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__isolate_lru_page_prepare() conflates two unrelated functions, with
the flags to one disjoint from the flags to the other; and hides some
of the important checks outside of isolate_migratepages_block(), where
the sequence is better to be visible.  It comes from the days of lumpy
reclaim, before compaction, when the combination made more sense.

Move what's needed by mm/compaction.c isolate_migratepages_block() inline
there, and what's needed by mm/vmscan.c isolate_lru_pages() inline there.

Shorten "isolate_mode" to "mode", so the sequence of conditions is easier
to read.  Declare a "mapping" variable, to save one call to page_mapping()
(but not another: calling again after page is locked is necessary).
Simplify isolate_lru_pages() with a "move_to" list pointer.

Signed-off-by: Hugh Dickins <hughd@google.com>
---

 include/linux/swap.h |   1 -
 mm/compaction.c      |  51 ++++++++++++++++++++++----
 mm/vmscan.c          | 101 +++++++++------------------------------------------
 3 files changed, 62 insertions(+), 91 deletions(-)

--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -386,7 +386,6 @@ extern void lru_cache_add_inactive_or_unevictable(struct page *page,
 extern unsigned long zone_reclaimable_pages(struct zone *zone);
 extern unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
 					gfp_t gfp_mask, nodemask_t *mask);
-extern bool __isolate_lru_page_prepare(struct page *page, isolate_mode_t mode);
 extern unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 						  unsigned long nr_pages,
 						  gfp_t gfp_mask,
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -785,7 +785,7 @@ static bool too_many_isolated(pg_data_t *pgdat)
  * @cc:		Compaction control structure.
  * @low_pfn:	The first PFN to isolate
  * @end_pfn:	The one-past-the-last PFN to isolate, within same pageblock
- * @isolate_mode: Isolation mode to be used.
+ * @mode:	Isolation mode to be used.
  *
  * Isolate all pages that can be migrated from the range specified by
  * [low_pfn, end_pfn). The range is expected to be within same pageblock.
@@ -798,7 +798,7 @@ static bool too_many_isolated(pg_data_t *pgdat)
  */
 static int
 isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
-			unsigned long end_pfn, isolate_mode_t isolate_mode)
+			unsigned long end_pfn, isolate_mode_t mode)
 {
 	pg_data_t *pgdat = cc->zone->zone_pgdat;
 	unsigned long nr_scanned = 0, nr_isolated = 0;
@@ -806,6 +806,7 @@ static bool too_many_isolated(pg_data_t *pgdat)
 	unsigned long flags = 0;
 	struct lruvec *locked = NULL;
 	struct page *page = NULL, *valid_page = NULL;
+	struct address_space *mapping;
 	unsigned long start_pfn = low_pfn;
 	bool skip_on_failure = false;
 	unsigned long next_skip_pfn = 0;
@@ -990,7 +991,7 @@ static bool too_many_isolated(pg_data_t *pgdat)
 					locked = NULL;
 				}
 
-				if (!isolate_movable_page(page, isolate_mode))
+				if (!isolate_movable_page(page, mode))
 					goto isolate_success;
 			}
 
@@ -1002,15 +1003,15 @@ static bool too_many_isolated(pg_data_t *pgdat)
 		 * so avoid taking lru_lock and isolating it unnecessarily in an
 		 * admittedly racy check.
 		 */
-		if (!page_mapping(page) &&
-		    page_count(page) > page_mapcount(page))
+		mapping = page_mapping(page);
+		if (!mapping && page_count(page) > page_mapcount(page))
 			goto isolate_fail;
 
 		/*
 		 * Only allow to migrate anonymous pages in GFP_NOFS context
 		 * because those do not depend on fs locks.
 		 */
-		if (!(cc->gfp_mask & __GFP_FS) && page_mapping(page))
+		if (!(cc->gfp_mask & __GFP_FS) && mapping)
 			goto isolate_fail;
 
 		/*
@@ -1021,9 +1022,45 @@ static bool too_many_isolated(pg_data_t *pgdat)
 		if (unlikely(!get_page_unless_zero(page)))
 			goto isolate_fail;
 
-		if (!__isolate_lru_page_prepare(page, isolate_mode))
+		/* Only take pages on LRU: a check now makes later tests safe */
+		if (!PageLRU(page))
+			goto isolate_fail_put;
+
+		/* Compaction might skip unevictable pages but CMA takes them */
+		if (!(mode & ISOLATE_UNEVICTABLE) && PageUnevictable(page))
+			goto isolate_fail_put;
+
+		/*
+		 * To minimise LRU disruption, the caller can indicate with
+		 * ISOLATE_ASYNC_MIGRATE that it only wants to isolate pages
+		 * it will be able to migrate without blocking - clean pages
+		 * for the most part.  PageWriteback would require blocking.
+		 */
+		if ((mode & ISOLATE_ASYNC_MIGRATE) && PageWriteback(page))
 			goto isolate_fail_put;
 
+		if ((mode & ISOLATE_ASYNC_MIGRATE) && PageDirty(page)) {
+			bool migrate_dirty;
+
+			/*
+			 * Only pages without mappings or that have a
+			 * ->migratepage callback are possible to migrate
+			 * without blocking. However, we can be racing with
+			 * truncation so it's necessary to lock the page
+			 * to stabilise the mapping as truncation holds
+			 * the page lock until after the page is removed
+			 * from the page cache.
+			 */
+			if (!trylock_page(page))
+				goto isolate_fail_put;
+
+			mapping = page_mapping(page);
+			migrate_dirty = !mapping || mapping->a_ops->migratepage;
+			unlock_page(page);
+			if (!migrate_dirty)
+				goto isolate_fail_put;
+		}
+
 		/* Try isolate the page */
 		if (!TestClearPageLRU(page))
 			goto isolate_fail_put;
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2009,69 +2009,6 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 }
 
 /*
- * Attempt to remove the specified page from its LRU.  Only take this page
- * if it is of the appropriate PageActive status.  Pages which are being
- * freed elsewhere are also ignored.
- *
- * page:	page to consider
- * mode:	one of the LRU isolation modes defined above
- *
- * returns true on success, false on failure.
- */
-bool __isolate_lru_page_prepare(struct page *page, isolate_mode_t mode)
-{
-	/* Only take pages on the LRU. */
-	if (!PageLRU(page))
-		return false;
-
-	/* Compaction should not handle unevictable pages but CMA can do so */
-	if (PageUnevictable(page) && !(mode & ISOLATE_UNEVICTABLE))
-		return false;
-
-	/*
-	 * To minimise LRU disruption, the caller can indicate that it only
-	 * wants to isolate pages it will be able to operate on without
-	 * blocking - clean pages for the most part.
-	 *
-	 * ISOLATE_ASYNC_MIGRATE is used to indicate that it only wants to pages
-	 * that it is possible to migrate without blocking
-	 */
-	if (mode & ISOLATE_ASYNC_MIGRATE) {
-		/* All the caller can do on PageWriteback is block */
-		if (PageWriteback(page))
-			return false;
-
-		if (PageDirty(page)) {
-			struct address_space *mapping;
-			bool migrate_dirty;
-
-			/*
-			 * Only pages without mappings or that have a
-			 * ->migratepage callback are possible to migrate
-			 * without blocking. However, we can be racing with
-			 * truncation so it's necessary to lock the page
-			 * to stabilise the mapping as truncation holds
-			 * the page lock until after the page is removed
-			 * from the page cache.
-			 */
-			if (!trylock_page(page))
-				return false;
-
-			mapping = page_mapping(page);
-			migrate_dirty = !mapping || mapping->a_ops->migratepage;
-			unlock_page(page);
-			if (!migrate_dirty)
-				return false;
-		}
-	}
-
-	if ((mode & ISOLATE_UNMAPPED) && page_mapped(page))
-		return false;
-
-	return true;
-}
-
-/*
  * Update LRU sizes after isolating pages. The LRU size updates must
  * be complete before mem_cgroup_update_lru_size due to a sanity check.
  */
@@ -2122,11 +2059,11 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
 	unsigned long skipped = 0;
 	unsigned long scan, total_scan, nr_pages;
 	LIST_HEAD(pages_skipped);
-	isolate_mode_t mode = (sc->may_unmap ? 0 : ISOLATE_UNMAPPED);
 
 	total_scan = 0;
 	scan = 0;
 	while (scan < nr_to_scan && !list_empty(src)) {
+		struct list_head *move_to = src;
 		struct page *page;
 
 		page = lru_to_page(src);
@@ -2136,9 +2073,9 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
 		total_scan += nr_pages;
 
 		if (page_zonenum(page) > sc->reclaim_idx) {
-			list_move(&page->lru, &pages_skipped);
 			nr_skipped[page_zonenum(page)] += nr_pages;
-			continue;
+			move_to = &pages_skipped;
+			goto move;
 		}
 
 		/*
@@ -2146,37 +2083,34 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
 		 * return with no isolated pages if the LRU mostly contains
 		 * ineligible pages.  This causes the VM to not reclaim any
 		 * pages, triggering a premature OOM.
-		 *
-		 * Account all tail pages of THP.  This would not cause
-		 * premature OOM since __isolate_lru_page() returns -EBUSY
-		 * only when the page is being freed somewhere else.
+		 * Account all tail pages of THP.
 		 */
 		scan += nr_pages;
-		if (!__isolate_lru_page_prepare(page, mode)) {
-			/* It is being freed elsewhere */
-			list_move(&page->lru, src);
-			continue;
-		}
+
+		if (!PageLRU(page))
+			goto move;
+		if (!sc->may_unmap && page_mapped(page))
+			goto move;
+
 		/*
 		 * Be careful not to clear PageLRU until after we're
 		 * sure the page is not being freed elsewhere -- the
 		 * page release code relies on it.
 		 */
-		if (unlikely(!get_page_unless_zero(page))) {
-			list_move(&page->lru, src);
-			continue;
-		}
+		if (unlikely(!get_page_unless_zero(page)))
+			goto move;
 
 		if (!TestClearPageLRU(page)) {
 			/* Another thread is already isolating this page */
 			put_page(page);
-			list_move(&page->lru, src);
-			continue;
+			goto move;
 		}
 
 		nr_taken += nr_pages;
 		nr_zone_taken[page_zonenum(page)] += nr_pages;
-		list_move(&page->lru, dst);
+		move_to = dst;
+move:
+		list_move(&page->lru, move_to);
 	}
 
 	/*
@@ -2200,7 +2134,8 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
 	}
 	*nr_scanned = total_scan;
 	trace_mm_vmscan_lru_isolate(sc->reclaim_idx, sc->order, nr_to_scan,
-				    total_scan, skipped, nr_taken, mode, lru);
+				    total_scan, skipped, nr_taken,
+				    sc->may_unmap ? 0 : ISOLATE_UNMAPPED, lru);
 	update_lru_sizes(lruvec, lru, nr_zone_taken);
 	return nr_taken;
 }
