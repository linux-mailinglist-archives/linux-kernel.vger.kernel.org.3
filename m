Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A18B8494EA6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 14:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358903AbiATNLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 08:11:02 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38322 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359533AbiATNLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 08:11:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 595E4B81CE3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 13:11:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35A2C340E2;
        Thu, 20 Jan 2022 13:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642684259;
        bh=b+tRqGpXikoPLthE/HgxBkFyjXAq1yPdeoFS7WY6SrE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ATtlz/W5UoACydVrU+nbgN08od1PSQVib9LIkZRlbqVd8cEuKd+ciUqkbNZif5DT7
         CREIzttbg4AUCHewm8oLt5aeJnfEKjHZhLhui8/jqWoOEdcV9oBJVnOMGJlsu/bEk3
         vQQ4kMEQEZ/NvF9iTpizMSkJ9eUYyoPLWFF9aO0uV8Bbqi47dJhgOH7IGpSKf0tlwf
         9aQIyucyaBpHkapj56vtbiRxeQepa5u7oSTMG0Z5i2PZ6KXUrZmQWyDajsUATpA34B
         lurdQWtzqvIwW1X/DYdv3KrCvbGP6y7bKxjwRGhF1prS+OVUaGUZ/vTdQBXeovvYV8
         clxpnpDscorJA==
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
Subject: [PATCH 2/5] mm: remove __clear_page_lru_flags()
Date:   Thu, 20 Jan 2022 21:10:21 +0800
Message-Id: <20220120131024.502877-3-alexs@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220120131024.502877-1-alexs@kernel.org>
References: <20220120131024.502877-1-alexs@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Shi <alexs@kernel.org>

The function could be fully replaced by __folio_clear_lru_flags(), no
reason to keep a duplicate one.

Signed-off-by: Alex Shi <alexs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Alex Shi <alexs@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 include/linux/mm_inline.h | 5 -----
 mm/swap.c                 | 4 ++--
 mm/vmscan.c               | 2 +-
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index f0aa34b0f2c4..c2384da888b4 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -59,11 +59,6 @@ static __always_inline void __folio_clear_lru_flags(struct folio *folio)
 	__folio_clear_unevictable(folio);
 }
 
-static __always_inline void __clear_page_lru_flags(struct page *page)
-{
-	__folio_clear_lru_flags(page_folio(page));
-}
-
 /**
  * folio_lru_list - Which LRU list should a folio be on?
  * @folio: The folio to test.
diff --git a/mm/swap.c b/mm/swap.c
index bcf3ac288b56..953cf8860542 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -86,7 +86,7 @@ static void __page_cache_release(struct page *page)
 
 		lruvec = folio_lruvec_lock_irqsave(folio, &flags);
 		del_page_from_lru_list(page, lruvec);
-		__clear_page_lru_flags(page);
+		__folio_clear_lru_flags(page_folio(page));
 		unlock_page_lruvec_irqrestore(lruvec, flags);
 	}
 	__ClearPageWaiters(page);
@@ -966,7 +966,7 @@ void release_pages(struct page **pages, int nr)
 				lock_batch = 0;
 
 			del_page_from_lru_list(page, lruvec);
-			__clear_page_lru_flags(page);
+			__folio_clear_lru_flags(page_folio(page));
 		}
 
 		__ClearPageWaiters(page);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index c361973774b4..59a52ba8b52a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2337,7 +2337,7 @@ static unsigned int move_pages_to_lru(struct lruvec *lruvec,
 		SetPageLRU(page);
 
 		if (unlikely(put_page_testzero(page))) {
-			__clear_page_lru_flags(page);
+			__folio_clear_lru_flags(page_folio(page));
 
 			if (unlikely(PageCompound(page))) {
 				spin_unlock_irq(&lruvec->lru_lock);
-- 
2.25.1

