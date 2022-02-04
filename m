Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A8E4AA099
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236423AbiBDT7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 14:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235547AbiBDT7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04D0C061744
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=EiTl9q/RuSenIeiy7aVDh11eq3USPRI+K+nzMLYhC1I=; b=nYZFnIE/kJm3rIxMWsdUQ5p1+1
        UsF5/II5qPuYXhFuNeCVTlWtyNQs+MeMp9rxkcPz/VBTqSb25An8emwpcu3Fs224hzJNrTWCScZqn
        j+Bb52waX55cC/s/UvSfTbVwLA4F1fo8Ae/WyDZzmZZMChbckb+ONSZzNEDkdf8Zk9tBiXw0jb+dj
        2aZoPNEHMlLP9XGKIpoRHZDSg20KeRZcP+hFiD+rqUOWU39cbG/BOjIBQ1PqJ1GaM0xzdDkeLpNFt
        TsZc+IL19ZluYAkNp1rhKNQ8JclyA882yv0p4/eCKZf+R9B9VWgQWzpASvW9ioUPdx2Fpi8HWqk7p
        id6mdA+w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jW-007LmT-OJ; Fri, 04 Feb 2022 19:59:02 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 33/75] mm/vmscan: Convert __remove_mapping() to take a folio
Date:   Fri,  4 Feb 2022 19:58:10 +0000
Message-Id: <20220204195852.1751729-34-willy@infradead.org>
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

This removes a few hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/vmscan.c | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 9f11960b1db8..15cbfae0d8ec 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1237,17 +1237,16 @@ static pageout_t pageout(struct page *page, struct address_space *mapping)
  * Same as remove_mapping, but if the page is removed from the mapping, it
  * gets returned with a refcount of 0.
  */
-static int __remove_mapping(struct address_space *mapping, struct page *page,
+static int __remove_mapping(struct address_space *mapping, struct folio *folio,
 			    bool reclaimed, struct mem_cgroup *target_memcg)
 {
-	struct folio *folio = page_folio(page);
 	int refcount;
 	void *shadow = NULL;
 
-	BUG_ON(!PageLocked(page));
-	BUG_ON(mapping != page_mapping(page));
+	BUG_ON(!folio_test_locked(folio));
+	BUG_ON(mapping != folio_mapping(folio));
 
-	if (!PageSwapCache(page))
+	if (!folio_test_swapcache(folio))
 		spin_lock(&mapping->host->i_lock);
 	xa_lock_irq(&mapping->i_pages);
 	/*
@@ -1275,23 +1274,23 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
 	 * Note that if SetPageDirty is always performed via set_page_dirty,
 	 * and thus under the i_pages lock, then this ordering is not required.
 	 */
-	refcount = 1 + compound_nr(page);
-	if (!page_ref_freeze(page, refcount))
+	refcount = 1 + folio_nr_pages(folio);
+	if (!folio_ref_freeze(folio, refcount))
 		goto cannot_free;
 	/* note: atomic_cmpxchg in page_ref_freeze provides the smp_rmb */
-	if (unlikely(PageDirty(page))) {
-		page_ref_unfreeze(page, refcount);
+	if (unlikely(folio_test_dirty(folio))) {
+		folio_ref_unfreeze(folio, refcount);
 		goto cannot_free;
 	}
 
-	if (PageSwapCache(page)) {
-		swp_entry_t swap = { .val = page_private(page) };
+	if (folio_test_swapcache(folio)) {
+		swp_entry_t swap = folio_swap_entry(folio);
 		mem_cgroup_swapout(folio, swap);
 		if (reclaimed && !mapping_exiting(mapping))
 			shadow = workingset_eviction(folio, target_memcg);
-		__delete_from_swap_cache(page, swap, shadow);
+		__delete_from_swap_cache(&folio->page, swap, shadow);
 		xa_unlock_irq(&mapping->i_pages);
-		put_swap_page(page, swap);
+		put_swap_page(&folio->page, swap);
 	} else {
 		void (*freepage)(struct page *);
 
@@ -1312,7 +1311,7 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
 		 * exceptional entries and shadow exceptional entries in the
 		 * same address_space.
 		 */
-		if (reclaimed && page_is_file_lru(page) &&
+		if (reclaimed && folio_is_file_lru(folio) &&
 		    !mapping_exiting(mapping) && !dax_mapping(mapping))
 			shadow = workingset_eviction(folio, target_memcg);
 		__filemap_remove_folio(folio, shadow);
@@ -1322,14 +1321,14 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
 		spin_unlock(&mapping->host->i_lock);
 
 		if (freepage != NULL)
-			freepage(page);
+			freepage(&folio->page);
 	}
 
 	return 1;
 
 cannot_free:
 	xa_unlock_irq(&mapping->i_pages);
-	if (!PageSwapCache(page))
+	if (!folio_test_swapcache(folio))
 		spin_unlock(&mapping->host->i_lock);
 	return 0;
 }
@@ -1342,13 +1341,14 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
  */
 int remove_mapping(struct address_space *mapping, struct page *page)
 {
-	if (__remove_mapping(mapping, page, false, NULL)) {
+	struct folio *folio = page_folio(page);
+	if (__remove_mapping(mapping, folio, false, NULL)) {
 		/*
 		 * Unfreezing the refcount with 1 rather than 2 effectively
 		 * drops the pagecache ref for us without requiring another
 		 * atomic operation.
 		 */
-		page_ref_unfreeze(page, 1);
+		folio_ref_unfreeze(folio, 1);
 		return 1;
 	}
 	return 0;
@@ -1530,14 +1530,16 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 	while (!list_empty(page_list)) {
 		struct address_space *mapping;
 		struct page *page;
+		struct folio *folio;
 		enum page_references references = PAGEREF_RECLAIM;
 		bool dirty, writeback, may_enter_fs;
 		unsigned int nr_pages;
 
 		cond_resched();
 
-		page = lru_to_page(page_list);
-		list_del(&page->lru);
+		folio = lru_to_folio(page_list);
+		list_del(&folio->lru);
+		page = &folio->page;
 
 		if (!trylock_page(page))
 			goto keep;
@@ -1890,7 +1892,7 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 			 */
 			count_vm_event(PGLAZYFREED);
 			count_memcg_page_event(page, PGLAZYFREED);
-		} else if (!mapping || !__remove_mapping(mapping, page, true,
+		} else if (!mapping || !__remove_mapping(mapping, folio, true,
 							 sc->target_mem_cgroup))
 			goto keep_locked;
 
-- 
2.34.1

