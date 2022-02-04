Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCF84AA09A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236656AbiBDUAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236525AbiBDT73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7352C061777
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=TcquNu2GjfQJyfxq8hgdegm77gZgKaMIuUwOTeONZRk=; b=F9BhQjkRzUZmcxq8EgkR8kYIzr
        2AdAWttomEYGMxGUvWiRnTh/sVF00uHtKMlELqdsyPXW3DsUX4TW2vk/JJRtcZoZQnyFp497XAqO/
        MID290vHvfvVVi+6F/UhMeAyILcChN1f0zDCvJPf/Km5k6QympUV07QuioYfvLma4vgkVL4ozij4+
        lU/n8p+76fqr6Pin08Ad0D8ci49LT6rq6tN4fSziSk7q8CF+cV1Y4qAjAd4y+Xy4QptTl+35+4RVM
        taKiyjQ6447lAMYFmYl6UR6UgX5XL03ZPqNY2ggl6s2SmG+AtSQE1gyhounEiLS3KBlU7297VApo3
        4NrU1Kgg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jb-007LrT-U7; Fri, 04 Feb 2022 19:59:08 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 71/75] mm/readahead: Add large folio readahead
Date:   Fri,  4 Feb 2022 19:58:48 +0000
Message-Id: <20220204195852.1751729-72-willy@infradead.org>
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

Allocate large folios in the readahead code when the filesystem supports
them and it seems worth doing.  The heuristic for choosing which folio
sizes will surely need some tuning, but this aggressive ramp-up has been
good for testing.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/readahead.c | 106 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 99 insertions(+), 7 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index cf0dcf89eb69..5100eaf5b0ee 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -148,7 +148,7 @@ static void read_pages(struct readahead_control *rac, struct list_head *pages,
 
 	blk_finish_plug(&plug);
 
-	BUG_ON(!list_empty(pages));
+	BUG_ON(pages && !list_empty(pages));
 	BUG_ON(readahead_count(rac));
 
 out:
@@ -431,11 +431,103 @@ static int try_context_readahead(struct address_space *mapping,
 	return 1;
 }
 
+/*
+ * There are some parts of the kernel which assume that PMD entries
+ * are exactly HPAGE_PMD_ORDER.  Those should be fixed, but until then,
+ * limit the maximum allocation order to PMD size.  I'm not aware of any
+ * assumptions about maximum order if THP are disabled, but 8 seems like
+ * a good order (that's 1MB if you're using 4kB pages)
+ */
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#define MAX_PAGECACHE_ORDER	HPAGE_PMD_ORDER
+#else
+#define MAX_PAGECACHE_ORDER	8
+#endif
+
+static inline int ra_alloc_folio(struct readahead_control *ractl, pgoff_t index,
+		pgoff_t mark, unsigned int order, gfp_t gfp)
+{
+	int err;
+	struct folio *folio = filemap_alloc_folio(gfp, order);
+
+	if (!folio)
+		return -ENOMEM;
+	if (mark - index < (1UL << order))
+		folio_set_readahead(folio);
+	err = filemap_add_folio(ractl->mapping, folio, index, gfp);
+	if (err)
+		folio_put(folio);
+	else
+		ractl->_nr_pages += 1UL << order;
+	return err;
+}
+
+static void page_cache_ra_order(struct readahead_control *ractl,
+		struct file_ra_state *ra, unsigned int new_order)
+{
+	struct address_space *mapping = ractl->mapping;
+	pgoff_t index = readahead_index(ractl);
+	pgoff_t limit = (i_size_read(mapping->host) - 1) >> PAGE_SHIFT;
+	pgoff_t mark = index + ra->size - ra->async_size;
+	int err = 0;
+	gfp_t gfp = readahead_gfp_mask(mapping);
+
+	if (!mapping_large_folio_support(mapping) || ra->size < 4)
+		goto fallback;
+
+	limit = min(limit, index + ra->size - 1);
+
+	if (new_order < MAX_PAGECACHE_ORDER) {
+		new_order += 2;
+		if (new_order > MAX_PAGECACHE_ORDER)
+			new_order = MAX_PAGECACHE_ORDER;
+		while ((1 << new_order) > ra->size)
+			new_order--;
+	}
+
+	while (index <= limit) {
+		unsigned int order = new_order;
+
+		/* Align with smaller pages if needed */
+		if (index & ((1UL << order) - 1)) {
+			order = __ffs(index);
+			if (order == 1)
+				order = 0;
+		}
+		/* Don't allocate pages past EOF */
+		while (index + (1UL << order) - 1 > limit) {
+			if (--order == 1)
+				order = 0;
+		}
+		err = ra_alloc_folio(ractl, index, mark, order, gfp);
+		if (err)
+			break;
+		index += 1UL << order;
+	}
+
+	if (index > limit) {
+		ra->size += index - limit - 1;
+		ra->async_size += index - limit - 1;
+	}
+
+	read_pages(ractl, NULL, false);
+
+	/*
+	 * If there were already pages in the page cache, then we may have
+	 * left some gaps.  Let the regular readahead code take care of this
+	 * situation.
+	 */
+	if (!err)
+		return;
+fallback:
+	do_page_cache_ra(ractl, ra->size, ra->async_size);
+}
+
 /*
  * A minimal readahead algorithm for trivial sequential/random reads.
  */
 static void ondemand_readahead(struct readahead_control *ractl,
-		bool hit_readahead_marker, unsigned long req_size)
+		struct folio *folio, unsigned long req_size)
 {
 	struct backing_dev_info *bdi = inode_to_bdi(ractl->mapping->host);
 	struct file_ra_state *ra = ractl->ra;
@@ -470,12 +562,12 @@ static void ondemand_readahead(struct readahead_control *ractl,
 	}
 
 	/*
-	 * Hit a marked page without valid readahead state.
+	 * Hit a marked folio without valid readahead state.
 	 * E.g. interleaved reads.
 	 * Query the pagecache for async_size, which normally equals to
 	 * readahead size. Ramp it up and use it as the new readahead size.
 	 */
-	if (hit_readahead_marker) {
+	if (folio) {
 		pgoff_t start;
 
 		rcu_read_lock();
@@ -548,7 +640,7 @@ static void ondemand_readahead(struct readahead_control *ractl,
 	}
 
 	ractl->_index = ra->start;
-	do_page_cache_ra(ractl, ra->size, ra->async_size);
+	page_cache_ra_order(ractl, ra, folio ? folio_order(folio) : 0);
 }
 
 void page_cache_sync_ra(struct readahead_control *ractl,
@@ -576,7 +668,7 @@ void page_cache_sync_ra(struct readahead_control *ractl,
 	}
 
 	/* do read-ahead */
-	ondemand_readahead(ractl, false, req_count);
+	ondemand_readahead(ractl, NULL, req_count);
 }
 EXPORT_SYMBOL_GPL(page_cache_sync_ra);
 
@@ -605,7 +697,7 @@ void page_cache_async_ra(struct readahead_control *ractl,
 		return;
 
 	/* do read-ahead */
-	ondemand_readahead(ractl, true, req_count);
+	ondemand_readahead(ractl, folio, req_count);
 }
 EXPORT_SYMBOL_GPL(page_cache_async_ra);
 
-- 
2.34.1

