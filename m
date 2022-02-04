Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5214AA097
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236245AbiBDT7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 14:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235502AbiBDT7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5261C061748
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=bef0cZGDuU+YbKujs3r8MKTZ9MxxmLgLhjNfcds/vHs=; b=ZuQO5Ny4EwFYv7QZX8DPglu2sW
        S/1xbJCd/issskPZ7rvxxvlkBk8xrhJycNf9d0yPNpa4VOf4g9KsLncba7ius02/1k92rSsITvw0y
        1DSqevdHkOiOSx+78PYLjbyamkNnEgEvqH19qvBuv542czbKW1TbJCtLdvoY0w08HHHMir+Aum+gw
        Klha0sJWu6Z8GxdZY7KH7OgZhaBtfLjX5l9YHG+dYwKCmeNIipOkxGjZz9sThsZfGgchWYSF6SVhu
        37yFUEkP/Gox8NpAao6qfm80wwlS8QoRhe6nd6miljHg7MI3Fr0kAO5x2yaEKuk+C052XTCk2XliC
        sxYpxlwg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jW-007Lm9-82; Fri, 04 Feb 2022 19:59:02 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 29/75] mm/workingset: Convert workingset_eviction() to take a folio
Date:   Fri,  4 Feb 2022 19:58:06 +0000
Message-Id: <20220204195852.1751729-30-willy@infradead.org>
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

This removes an assumption that THPs are the only kind of compound
pages and removes a few hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/swap.h |  2 +-
 mm/vmscan.c          |  7 ++++---
 mm/workingset.c      | 25 +++++++++++++------------
 3 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 1d38d9475c4d..de36f140227e 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -328,7 +328,7 @@ static inline swp_entry_t folio_swap_entry(struct folio *folio)
 
 /* linux/mm/workingset.c */
 void workingset_age_nonresident(struct lruvec *lruvec, unsigned long nr_pages);
-void *workingset_eviction(struct page *page, struct mem_cgroup *target_memcg);
+void *workingset_eviction(struct folio *folio, struct mem_cgroup *target_memcg);
 void workingset_refault(struct folio *folio, void *shadow);
 void workingset_activation(struct folio *folio);
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index e0cc5f0cb999..75223b7d98ec 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1240,6 +1240,7 @@ static pageout_t pageout(struct page *page, struct address_space *mapping)
 static int __remove_mapping(struct address_space *mapping, struct page *page,
 			    bool reclaimed, struct mem_cgroup *target_memcg)
 {
+	struct folio *folio = page_folio(page);
 	int refcount;
 	void *shadow = NULL;
 
@@ -1287,7 +1288,7 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
 		swp_entry_t swap = { .val = page_private(page) };
 		mem_cgroup_swapout(page, swap);
 		if (reclaimed && !mapping_exiting(mapping))
-			shadow = workingset_eviction(page, target_memcg);
+			shadow = workingset_eviction(folio, target_memcg);
 		__delete_from_swap_cache(page, swap, shadow);
 		xa_unlock_irq(&mapping->i_pages);
 		put_swap_page(page, swap);
@@ -1313,8 +1314,8 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
 		 */
 		if (reclaimed && page_is_file_lru(page) &&
 		    !mapping_exiting(mapping) && !dax_mapping(mapping))
-			shadow = workingset_eviction(page, target_memcg);
-		__delete_from_page_cache(page, shadow);
+			shadow = workingset_eviction(folio, target_memcg);
+		__filemap_remove_folio(folio, shadow);
 		xa_unlock_irq(&mapping->i_pages);
 		if (mapping_shrinkable(mapping))
 			inode_add_lru(mapping->host);
diff --git a/mm/workingset.c b/mm/workingset.c
index 8c03afe1d67c..b717eae4e0dd 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -245,31 +245,32 @@ void workingset_age_nonresident(struct lruvec *lruvec, unsigned long nr_pages)
 }
 
 /**
- * workingset_eviction - note the eviction of a page from memory
+ * workingset_eviction - note the eviction of a folio from memory
  * @target_memcg: the cgroup that is causing the reclaim
- * @page: the page being evicted
+ * @folio: the folio being evicted
  *
- * Return: a shadow entry to be stored in @page->mapping->i_pages in place
- * of the evicted @page so that a later refault can be detected.
+ * Return: a shadow entry to be stored in @folio->mapping->i_pages in place
+ * of the evicted @folio so that a later refault can be detected.
  */
-void *workingset_eviction(struct page *page, struct mem_cgroup *target_memcg)
+void *workingset_eviction(struct folio *folio, struct mem_cgroup *target_memcg)
 {
-	struct pglist_data *pgdat = page_pgdat(page);
+	struct pglist_data *pgdat = folio_pgdat(folio);
 	unsigned long eviction;
 	struct lruvec *lruvec;
 	int memcgid;
 
-	/* Page is fully exclusive and pins page's memory cgroup pointer */
-	VM_BUG_ON_PAGE(PageLRU(page), page);
-	VM_BUG_ON_PAGE(page_count(page), page);
-	VM_BUG_ON_PAGE(!PageLocked(page), page);
+	/* Folio is fully exclusive and pins folio's memory cgroup pointer */
+	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
+	VM_BUG_ON_FOLIO(folio_ref_count(folio), folio);
+	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 
 	lruvec = mem_cgroup_lruvec(target_memcg, pgdat);
 	/* XXX: target_memcg can be NULL, go through lruvec */
 	memcgid = mem_cgroup_id(lruvec_memcg(lruvec));
 	eviction = atomic_long_read(&lruvec->nonresident_age);
-	workingset_age_nonresident(lruvec, thp_nr_pages(page));
-	return pack_shadow(memcgid, pgdat, eviction, PageWorkingset(page));
+	workingset_age_nonresident(lruvec, folio_nr_pages(folio));
+	return pack_shadow(memcgid, pgdat, eviction,
+				folio_test_workingset(folio));
 }
 
 /**
-- 
2.34.1

