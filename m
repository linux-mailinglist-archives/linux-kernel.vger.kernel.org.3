Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0603C494EA7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 14:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359675AbiATNLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 08:11:04 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:44908 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359601AbiATNLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 08:11:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61E88616B7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 13:11:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8150CC340E7;
        Thu, 20 Jan 2022 13:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642684261;
        bh=trAm6qhV2AxtHG/93R7Wnd9+hGYx/SylLR/GP3OdBf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oiD1Cl3MrN4U8YuD+9BRofhf9vP1ui5TG1iJHLB3lIG67n29ypCdGsnv5aBMw/37f
         NJSTKlXZw5xN6AVwtK4Mz18hRdL0R7NsYvZhlwI8a5V8vXsOmzhAyjUmH5FMfzTVI2
         nNWJ5jAVQrRr26jctDAkiPJFZVTxpM1lmv23kxOKg4CfdMrWoqMbv1/ocY1sjzMoM5
         gIGL30/XiNjU3Mp2AslYoSOO+s5cMI/BcFoiq4UbrMssE6iObNNJa3kV47RSqDVrH/
         +jENH16w6tg9pFDAmn3juqBlVkKyP09yU4BoG26llAbMgfxqgh3eazLR83AbPCYwU6
         0AZsK9joQyI9g==
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
Subject: [PATCH 3/5] mm: remove add_page_to_lru_list() function
Date:   Thu, 20 Jan 2022 21:10:22 +0800
Message-Id: <20220120131024.502877-4-alexs@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220120131024.502877-1-alexs@kernel.org>
References: <20220120131024.502877-1-alexs@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Shi <alexs@kernel.org>

The function could be fully replaced by ruvec_add_folio(), no reason to
keep a duplicate one.

Signed-off-by: Alex Shi <alexs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Alex Shi <alexs@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 include/linux/mm_inline.h | 6 ------
 mm/swap.c                 | 6 +++---
 mm/vmscan.c               | 4 ++--
 3 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index c2384da888b4..7d7abd5ff73f 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -92,12 +92,6 @@ void lruvec_add_folio(struct lruvec *lruvec, struct folio *folio)
 	list_add(&folio->lru, &lruvec->lists[lru]);
 }
 
-static __always_inline void add_page_to_lru_list(struct page *page,
-				struct lruvec *lruvec)
-{
-	lruvec_add_folio(lruvec, page_folio(page));
-}
-
 static __always_inline
 void lruvec_add_folio_tail(struct lruvec *lruvec, struct folio *folio)
 {
diff --git a/mm/swap.c b/mm/swap.c
index 953cf8860542..fb101a06dce4 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -543,7 +543,7 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec)
 		 * It can make readahead confusing.  But race window
 		 * is _really_ small and  it's non-critical problem.
 		 */
-		add_page_to_lru_list(page, lruvec);
+		lruvec_add_folio(lruvec, page_folio(page));
 		SetPageReclaim(page);
 	} else {
 		/*
@@ -569,7 +569,7 @@ static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec)
 		del_page_from_lru_list(page, lruvec);
 		ClearPageActive(page);
 		ClearPageReferenced(page);
-		add_page_to_lru_list(page, lruvec);
+		lruvec_add_folio(lruvec, page_folio(page));
 
 		__count_vm_events(PGDEACTIVATE, nr_pages);
 		__count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE,
@@ -592,7 +592,7 @@ static void lru_lazyfree_fn(struct page *page, struct lruvec *lruvec)
 		 * anonymous pages
 		 */
 		ClearPageSwapBacked(page);
-		add_page_to_lru_list(page, lruvec);
+		lruvec_add_folio(lruvec, page_folio(page));
 
 		__count_vm_events(PGLAZYFREE, nr_pages);
 		__count_memcg_events(lruvec_memcg(lruvec), PGLAZYFREE,
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 59a52ba8b52a..f09473c9ff35 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2354,7 +2354,7 @@ static unsigned int move_pages_to_lru(struct lruvec *lruvec,
 		 * inhibits memcg migration).
 		 */
 		VM_BUG_ON_PAGE(!folio_matches_lruvec(page_folio(page), lruvec), page);
-		add_page_to_lru_list(page, lruvec);
+		lruvec_add_folio(lruvec, page_folio(page));
 		nr_pages = thp_nr_pages(page);
 		nr_moved += nr_pages;
 		if (PageActive(page))
@@ -4875,7 +4875,7 @@ void check_move_unevictable_pages(struct pagevec *pvec)
 		if (page_evictable(page) && PageUnevictable(page)) {
 			del_page_from_lru_list(page, lruvec);
 			ClearPageUnevictable(page);
-			add_page_to_lru_list(page, lruvec);
+			lruvec_add_folio(lruvec, page_folio(page));
 			pgrescued += nr_pages;
 		}
 		SetPageLRU(page);
-- 
2.25.1

