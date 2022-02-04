Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5843B4AA09D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236692AbiBDUAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236344AbiBDT7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095BBC061775
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=SyU2ekv64a6Ug5ueH4gEC0ZqdQjiGm8CPqA8DmfHZ40=; b=LxsQS5a/zCubbdsHeLJ3dllqE7
        v5a1vgizqkjOAOoxUc9CoDwb+eQ42LuzNXZFBP/ejQDaZuStTBpbAO6lwF8lpssVZISs/+FYWWbkt
        IzkaDKAHrLfIwks57eRhRi295hFsVS/gYfgXEa64vLHN8cPfJYoI6CM+3Qqg1T6AHevUMlmcTEmXF
        JR/JTccSlmGgp9KIJN1Hy+3FQZ9eGuXyfHll1fjDPStM3+w0VdGNJbDUeR77vsCHQ+nsnV61qWSml
        GW+DSQQxKABcMVyOXWWYcsujMxt5x3wNw97fF7Q5eLn0n64Y7nYksEedFea571/H+PTBgZTQ4FDcr
        IlyWG6YQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jb-007Lqg-9R; Fri, 04 Feb 2022 19:59:07 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 66/75] mm: Turn can_split_huge_page() into can_split_folio()
Date:   Fri,  4 Feb 2022 19:58:43 +0000
Message-Id: <20220204195852.1751729-67-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220204195852.1751729-1-willy@infradead.org>
References: <20220204195852.1751729-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function already required a head page to be passed, so this
just adds type-safety and removes a few implicit calls to
compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/huge_mm.h |  4 ++--
 mm/huge_memory.c        | 15 ++++++++-------
 mm/vmscan.c             |  6 +++---
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 4368b314d9c8..e0348bca3d66 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -185,7 +185,7 @@ void prep_transhuge_page(struct page *page);
 void free_transhuge_page(struct page *page);
 bool is_transparent_hugepage(struct page *page);
 
-bool can_split_huge_page(struct page *page, int *pextra_pins);
+bool can_split_folio(struct folio *folio, int *pextra_pins);
 int split_huge_page_to_list(struct page *page, struct list_head *list);
 static inline int split_huge_page(struct page *page)
 {
@@ -387,7 +387,7 @@ static inline bool is_transparent_hugepage(struct page *page)
 #define thp_get_unmapped_area	NULL
 
 static inline bool
-can_split_huge_page(struct page *page, int *pextra_pins)
+can_split_folio(struct folio *folio, int *pextra_pins)
 {
 	BUILD_BUG();
 	return false;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f711dabc9c62..a80d0408ebf4 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2545,18 +2545,19 @@ int page_trans_huge_mapcount(struct page *page)
 }
 
 /* Racy check whether the huge page can be split */
-bool can_split_huge_page(struct page *page, int *pextra_pins)
+bool can_split_folio(struct folio *folio, int *pextra_pins)
 {
 	int extra_pins;
 
 	/* Additional pins from page cache */
-	if (PageAnon(page))
-		extra_pins = PageSwapCache(page) ? thp_nr_pages(page) : 0;
+	if (folio_test_anon(folio))
+		extra_pins = folio_test_swapcache(folio) ?
+				folio_nr_pages(folio) : 0;
 	else
-		extra_pins = thp_nr_pages(page);
+		extra_pins = folio_nr_pages(folio);
 	if (pextra_pins)
 		*pextra_pins = extra_pins;
-	return total_mapcount(page) == page_count(page) - extra_pins - 1;
+	return folio_mapcount(folio) == folio_ref_count(folio) - extra_pins - 1;
 }
 
 /*
@@ -2648,7 +2649,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	 * Racy check if we can split the page, before unmap_page() will
 	 * split PMDs
 	 */
-	if (!can_split_huge_page(head, &extra_pins)) {
+	if (!can_split_folio(folio, &extra_pins)) {
 		ret = -EBUSY;
 		goto out_unlock;
 	}
@@ -2957,7 +2958,7 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 			goto next;
 
 		total++;
-		if (!can_split_huge_page(compound_head(page), NULL))
+		if (!can_split_folio(page_folio(page), NULL))
 			goto next;
 
 		if (!trylock_page(page))
diff --git a/mm/vmscan.c b/mm/vmscan.c
index efe041c2859d..6d2e4da77392 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1696,18 +1696,18 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 			if (!PageSwapCache(page)) {
 				if (!(sc->gfp_mask & __GFP_IO))
 					goto keep_locked;
-				if (page_maybe_dma_pinned(page))
+				if (folio_maybe_dma_pinned(folio))
 					goto keep_locked;
 				if (PageTransHuge(page)) {
 					/* cannot split THP, skip it */
-					if (!can_split_huge_page(page, NULL))
+					if (!can_split_folio(folio, NULL))
 						goto activate_locked;
 					/*
 					 * Split pages without a PMD map right
 					 * away. Chances are some or all of the
 					 * tail pages can be freed without IO.
 					 */
-					if (!compound_mapcount(page) &&
+					if (!folio_entire_mapcount(folio) &&
 					    split_folio_to_list(folio,
 								page_list))
 						goto activate_locked;
-- 
2.34.1

