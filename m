Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D90E494EA9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 14:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376364AbiATNLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 08:11:23 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38432 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359843AbiATNLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 08:11:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49722B81CE3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 13:11:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69FAEC340E5;
        Thu, 20 Jan 2022 13:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642684268;
        bh=OrxCmCwhcQs7JjUADDB5MvCyW968j/WDiJS5l2hCkFI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CI1V8t3qE2cDKMYaaBkvTZQ4d//l97YE4n8brHshtJvbP/v6FjyNy+ic/WcgigQTn
         3w7nQsMbtkZvZCYVAniIkVkmgYo9UYEIXE5b2Y/QBSm6plbJ0RScCtx88FqPjP2RtL
         mb6VRPaznEN5W1nVOhuGul5mvnG5FQjFVukWA5v6Tnq5HTQDDgSzGtr2syk6sTpqX8
         LnxSonhHwm6RByHfWGTphrWwlo2jeJXFIETbzjIFgidL5k8wDdAlEO1EksSGmyVtyJ
         DLZx+POdELc6DrLiLF1ue5A+rPF42FGxvCAQjEqJA11NpaG/JhiebCraYlZgYfMENC
         Geib0IgHSKKiw==
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
Subject: [PATCH 5/5] mm: remove del_page_from_lru_list()
Date:   Thu, 20 Jan 2022 21:10:24 +0800
Message-Id: <20220120131024.502877-6-alexs@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220120131024.502877-1-alexs@kernel.org>
References: <20220120131024.502877-1-alexs@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Shi <alexs@kernel.org>

The function could be fully replaced by lruvec_del_folio(), no reason to
keep a duplicate one.

Signed-off-by: Alex Shi <alexs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Alex Shi <alexs@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 include/linux/mm_inline.h |  6 ------
 mm/compaction.c           |  2 +-
 mm/mlock.c                |  2 +-
 mm/swap.c                 | 10 +++++-----
 mm/vmscan.c               |  4 ++--
 5 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 4df5b39cc97b..a66c08079675 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -110,12 +110,6 @@ void lruvec_del_folio(struct lruvec *lruvec, struct folio *folio)
 			-folio_nr_pages(folio));
 }
 
-static __always_inline void del_page_from_lru_list(struct page *page,
-				struct lruvec *lruvec)
-{
-	lruvec_del_folio(lruvec, page_folio(page));
-}
-
 #ifdef CONFIG_ANON_VMA_NAME
 /*
  * mmap_lock should be read-locked when calling vma_anon_name() and while using
diff --git a/mm/compaction.c b/mm/compaction.c
index 12f2af6ac484..385e0bb7aad5 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1064,7 +1064,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 			low_pfn += compound_nr(page) - 1;
 
 		/* Successfully isolated */
-		del_page_from_lru_list(page, lruvec);
+		lruvec_del_folio(lruvec, page_folio(page));
 		mod_node_page_state(page_pgdat(page),
 				NR_ISOLATED_ANON + folio_is_file_lru(page_folio(page)),
 				thp_nr_pages(page));
diff --git a/mm/mlock.c b/mm/mlock.c
index 8f584eddd305..6b64758b5d8c 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -280,7 +280,7 @@ static void __munlock_pagevec(struct pagevec *pvec, struct zone *zone)
 			 */
 			if (TestClearPageLRU(page)) {
 				lruvec = folio_lruvec_relock_irq(folio, lruvec);
-				del_page_from_lru_list(page, lruvec);
+				lruvec_del_folio(lruvec, page_folio(page));
 				continue;
 			} else
 				__munlock_isolation_failed(page);
diff --git a/mm/swap.c b/mm/swap.c
index 23c0afb76be6..359821740e0f 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -85,7 +85,7 @@ static void __page_cache_release(struct page *page)
 		unsigned long flags;
 
 		lruvec = folio_lruvec_lock_irqsave(folio, &flags);
-		del_page_from_lru_list(page, lruvec);
+		lruvec_del_folio(lruvec, page_folio(page));
 		__folio_clear_lru_flags(page_folio(page));
 		unlock_page_lruvec_irqrestore(lruvec, flags);
 	}
@@ -533,7 +533,7 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec)
 	if (page_mapped(page))
 		return;
 
-	del_page_from_lru_list(page, lruvec);
+	lruvec_del_folio(lruvec, page_folio(page));
 	ClearPageActive(page);
 	ClearPageReferenced(page);
 
@@ -566,7 +566,7 @@ static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec)
 	if (PageActive(page) && !PageUnevictable(page)) {
 		int nr_pages = thp_nr_pages(page);
 
-		del_page_from_lru_list(page, lruvec);
+		lruvec_del_folio(lruvec, page_folio(page));
 		ClearPageActive(page);
 		ClearPageReferenced(page);
 		lruvec_add_folio(lruvec, page_folio(page));
@@ -583,7 +583,7 @@ static void lru_lazyfree_fn(struct page *page, struct lruvec *lruvec)
 	    !PageSwapCache(page) && !PageUnevictable(page)) {
 		int nr_pages = thp_nr_pages(page);
 
-		del_page_from_lru_list(page, lruvec);
+		lruvec_del_folio(lruvec, page_folio(page));
 		ClearPageActive(page);
 		ClearPageReferenced(page);
 		/*
@@ -965,7 +965,7 @@ void release_pages(struct page **pages, int nr)
 			if (prev_lruvec != lruvec)
 				lock_batch = 0;
 
-			del_page_from_lru_list(page, lruvec);
+			lruvec_del_folio(lruvec, page_folio(page));
 			__folio_clear_lru_flags(page_folio(page));
 		}
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index f09473c9ff35..8ab97eac284a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2247,7 +2247,7 @@ int isolate_lru_page(struct page *page)
 
 		get_page(page);
 		lruvec = folio_lruvec_lock_irq(folio);
-		del_page_from_lru_list(page, lruvec);
+		lruvec_del_folio(lruvec, page_folio(page));
 		unlock_page_lruvec_irq(lruvec);
 		ret = 0;
 	}
@@ -4873,7 +4873,7 @@ void check_move_unevictable_pages(struct pagevec *pvec)
 
 		lruvec = folio_lruvec_relock_irq(folio, lruvec);
 		if (page_evictable(page) && PageUnevictable(page)) {
-			del_page_from_lru_list(page, lruvec);
+			lruvec_del_folio(lruvec, page_folio(page));
 			ClearPageUnevictable(page);
 			lruvec_add_folio(lruvec, page_folio(page));
 			pgrescued += nr_pages;
-- 
2.25.1

