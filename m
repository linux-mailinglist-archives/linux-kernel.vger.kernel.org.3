Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B894F4AA0A4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237906AbiBDUBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236518AbiBDT73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58AFC061773
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=0LceE9B2JPqGhIU6U3dA6i1Q/WxXKHP1DiDrPes4GUc=; b=D8Lg78R9RvJ4RORcxDBYl/EBQn
        K7LC2HKWQorvJHKtxhlrGFyem8Ior8x/yVGRH6wsmJEJeOuOdx5xI1tBGMNX9fPMsZUyxlwQz2gJo
        kEcUHqbBY2sHAi7O+bO37w/4JMA3qFPErjW7/+WhbL/fuojhNLNFNOVoS5OWcpwWf4Dd03xCHjztW
        kUYXMhtalHrgNm3eojK+I9hXUjtFICEea9aus+bWInyXB99aCWytSVKuC89KvRH4DSGV0rVToFxfA
        JWWiX2dfjGQW3FydlxpLAQbdI4ooOJ7zGxI4UhM6UUd0qpdVvpAvu0eHwS1CpDEG6HaIQ8BHXBwBy
        WIXMVGaQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jb-007LqT-4Y; Fri, 04 Feb 2022 19:59:07 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 65/75] mm/vmscan: Convert pageout() to take a folio
Date:   Fri,  4 Feb 2022 19:58:42 +0000
Message-Id: <20220204195852.1751729-66-willy@infradead.org>
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

We always write out an entire folio at once.  This conversion removes
a few calls to compound_head() and gets the NR_VMSCAN_WRITE statistic
right when writing out a large folio.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/trace/events/vmscan.h | 10 +++---
 mm/vmscan.c                   | 64 +++++++++++++++++------------------
 2 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index ca2e9009a651..de136dbd623a 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -327,11 +327,11 @@ TRACE_EVENT(mm_vmscan_lru_isolate,
 		__print_symbolic(__entry->lru, LRU_NAMES))
 );
 
-TRACE_EVENT(mm_vmscan_writepage,
+TRACE_EVENT(mm_vmscan_write_folio,
 
-	TP_PROTO(struct page *page),
+	TP_PROTO(struct folio *folio),
 
-	TP_ARGS(page),
+	TP_ARGS(folio),
 
 	TP_STRUCT__entry(
 		__field(unsigned long, pfn)
@@ -339,9 +339,9 @@ TRACE_EVENT(mm_vmscan_writepage,
 	),
 
 	TP_fast_assign(
-		__entry->pfn = page_to_pfn(page);
+		__entry->pfn = folio_pfn(folio);
 		__entry->reclaim_flags = trace_reclaim_flags(
-						page_is_file_lru(page));
+						folio_is_file_lru(folio));
 	),
 
 	TP_printk("page=%p pfn=0x%lx flags=%s",
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 450dd9c3395f..efe041c2859d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -978,15 +978,15 @@ void drop_slab(void)
 		drop_slab_node(nid);
 }
 
-static inline int is_page_cache_freeable(struct page *page)
+static inline int is_page_cache_freeable(struct folio *folio)
 {
 	/*
 	 * A freeable page cache page is referenced only by the caller
 	 * that isolated the page, the page cache and optional buffer
 	 * heads at page->private.
 	 */
-	int page_cache_pins = thp_nr_pages(page);
-	return page_count(page) - page_has_private(page) == 1 + page_cache_pins;
+	return folio_ref_count(folio) - folio_test_private(folio) ==
+		1 + folio_nr_pages(folio);
 }
 
 static int may_write_to_inode(struct inode *inode)
@@ -1001,24 +1001,24 @@ static int may_write_to_inode(struct inode *inode)
 }
 
 /*
- * We detected a synchronous write error writing a page out.  Probably
+ * We detected a synchronous write error writing a folio out.  Probably
  * -ENOSPC.  We need to propagate that into the address_space for a subsequent
  * fsync(), msync() or close().
  *
  * The tricky part is that after writepage we cannot touch the mapping: nothing
- * prevents it from being freed up.  But we have a ref on the page and once
- * that page is locked, the mapping is pinned.
+ * prevents it from being freed up.  But we have a ref on the folio and once
+ * that folio is locked, the mapping is pinned.
  *
- * We're allowed to run sleeping lock_page() here because we know the caller has
+ * We're allowed to run sleeping folio_lock() here because we know the caller has
  * __GFP_FS.
  */
 static void handle_write_error(struct address_space *mapping,
-				struct page *page, int error)
+				struct folio *folio, int error)
 {
-	lock_page(page);
-	if (page_mapping(page) == mapping)
+	folio_lock(folio);
+	if (folio_mapping(folio) == mapping)
 		mapping_set_error(mapping, error);
-	unlock_page(page);
+	folio_unlock(folio);
 }
 
 static bool skip_throttle_noprogress(pg_data_t *pgdat)
@@ -1163,35 +1163,35 @@ typedef enum {
  * pageout is called by shrink_page_list() for each dirty page.
  * Calls ->writepage().
  */
-static pageout_t pageout(struct page *page, struct address_space *mapping)
+static pageout_t pageout(struct folio *folio, struct address_space *mapping)
 {
 	/*
-	 * If the page is dirty, only perform writeback if that write
+	 * If the folio is dirty, only perform writeback if that write
 	 * will be non-blocking.  To prevent this allocation from being
 	 * stalled by pagecache activity.  But note that there may be
 	 * stalls if we need to run get_block().  We could test
 	 * PagePrivate for that.
 	 *
 	 * If this process is currently in __generic_file_write_iter() against
-	 * this page's queue, we can perform writeback even if that
+	 * this folio's queue, we can perform writeback even if that
 	 * will block.
 	 *
-	 * If the page is swapcache, write it back even if that would
+	 * If the folio is swapcache, write it back even if that would
 	 * block, for some throttling. This happens by accident, because
 	 * swap_backing_dev_info is bust: it doesn't reflect the
 	 * congestion state of the swapdevs.  Easy to fix, if needed.
 	 */
-	if (!is_page_cache_freeable(page))
+	if (!is_page_cache_freeable(folio))
 		return PAGE_KEEP;
 	if (!mapping) {
 		/*
-		 * Some data journaling orphaned pages can have
-		 * page->mapping == NULL while being dirty with clean buffers.
+		 * Some data journaling orphaned folios can have
+		 * folio->mapping == NULL while being dirty with clean buffers.
 		 */
-		if (page_has_private(page)) {
-			if (try_to_free_buffers(page)) {
-				ClearPageDirty(page);
-				pr_info("%s: orphaned page\n", __func__);
+		if (folio_test_private(folio)) {
+			if (try_to_free_buffers(&folio->page)) {
+				folio_clear_dirty(folio);
+				pr_info("%s: orphaned folio\n", __func__);
 				return PAGE_CLEAN;
 			}
 		}
@@ -1202,7 +1202,7 @@ static pageout_t pageout(struct page *page, struct address_space *mapping)
 	if (!may_write_to_inode(mapping->host))
 		return PAGE_KEEP;
 
-	if (clear_page_dirty_for_io(page)) {
+	if (folio_clear_dirty_for_io(folio)) {
 		int res;
 		struct writeback_control wbc = {
 			.sync_mode = WB_SYNC_NONE,
@@ -1212,21 +1212,21 @@ static pageout_t pageout(struct page *page, struct address_space *mapping)
 			.for_reclaim = 1,
 		};
 
-		SetPageReclaim(page);
-		res = mapping->a_ops->writepage(page, &wbc);
+		folio_set_reclaim(folio);
+		res = mapping->a_ops->writepage(&folio->page, &wbc);
 		if (res < 0)
-			handle_write_error(mapping, page, res);
+			handle_write_error(mapping, folio, res);
 		if (res == AOP_WRITEPAGE_ACTIVATE) {
-			ClearPageReclaim(page);
+			folio_clear_reclaim(folio);
 			return PAGE_ACTIVATE;
 		}
 
-		if (!PageWriteback(page)) {
+		if (!folio_test_writeback(folio)) {
 			/* synchronous write or broken a_ops? */
-			ClearPageReclaim(page);
+			folio_clear_reclaim(folio);
 		}
-		trace_mm_vmscan_writepage(page);
-		inc_node_page_state(page, NR_VMSCAN_WRITE);
+		trace_mm_vmscan_write_folio(folio);
+		node_stat_add_folio(folio, NR_VMSCAN_WRITE);
 		return PAGE_SUCCESS;
 	}
 
@@ -1809,7 +1809,7 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 			 * starts and then write it out here.
 			 */
 			try_to_unmap_flush_dirty();
-			switch (pageout(page, mapping)) {
+			switch (pageout(folio, mapping)) {
 			case PAGE_KEEP:
 				goto keep_locked;
 			case PAGE_ACTIVATE:
-- 
2.34.1

