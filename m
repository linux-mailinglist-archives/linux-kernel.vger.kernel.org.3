Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5699B4AA0D6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240298AbiBDUEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237547AbiBDUCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 15:02:36 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E83C061758
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=BiQ0QWuI9mezri/gHhkMbqNNBh1ntqomogdBFez09R4=; b=ia4K0m1QScGbUNOeiEth1cIdVh
        /7lB0O3bbSv5Pwo3H/GvUK2PHMKgObvSe1l8LscZcQBghmcDCFqL+jj4wuMa2s9doRZ+HaEmPVAob
        VqIr1g2KA04nXH6eBECX++TCjo2/SEBUIzGIJ3iXq0X+0uEXufh4g8LDUVb4iLYmhb4bph1xVtkYB
        WC/BFxWfZDmwu8tnuvaSfgUYKki9ilcTQzz6OaGYsWfjXEYOfnUBR7LXcrIskIzVD+Rm3FWwotsAu
        NRSV2is58dgEtLVPFTtk9ldIiaz2BZV79usZkHkT+W4G1zhemBa1EKeIl4m/8wvgiBe6L916Ny7rc
        QRK/1l7Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jU-007LlP-K6; Fri, 04 Feb 2022 19:59:00 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH 12/75] mm: Make compound_pincount always available
Date:   Fri,  4 Feb 2022 19:57:49 +0000
Message-Id: <20220204195852.1751729-13-willy@infradead.org>
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

Move compound_pincount from the third page to the second page, which
means it's available for all compound pages.  That lets us delete
hpage_pincount_available().

On 32-bit systems, there isn't enough space for both compound_pincount
and compound_nr in the second page (it would collide with page->private,
which is in use for pages in the swap cache), so revert the optimisation
of storing both compound_order and compound_nr on 32-bit systems.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 Documentation/core-api/pin_user_pages.rst | 18 +++++++++---------
 include/linux/mm.h                        | 21 ++++++++-------------
 include/linux/mm_types.h                  |  7 +++++--
 mm/debug.c                                | 14 ++++----------
 mm/gup.c                                  | 20 +++++++++-----------
 mm/page_alloc.c                           |  3 +--
 mm/rmap.c                                 |  6 ++----
 7 files changed, 38 insertions(+), 51 deletions(-)

diff --git a/Documentation/core-api/pin_user_pages.rst b/Documentation/core-api/pin_user_pages.rst
index fcf605be43d0..b18416f4500f 100644
--- a/Documentation/core-api/pin_user_pages.rst
+++ b/Documentation/core-api/pin_user_pages.rst
@@ -55,18 +55,18 @@ flags the caller provides. The caller is required to pass in a non-null struct
 pages* array, and the function then pins pages by incrementing each by a special
 value: GUP_PIN_COUNTING_BIAS.
 
-For huge pages (and in fact, any compound page of more than 2 pages), the
-GUP_PIN_COUNTING_BIAS scheme is not used. Instead, an exact form of pin counting
-is achieved, by using the 3rd struct page in the compound page. A new struct
-page field, hpage_pinned_refcount, has been added in order to support this.
+For compound pages, the GUP_PIN_COUNTING_BIAS scheme is not used. Instead,
+an exact form of pin counting is achieved, by using the 2nd struct page
+in the compound page. A new struct page field, compound_pincount, has
+been added in order to support this.
 
 This approach for compound pages avoids the counting upper limit problems that
 are discussed below. Those limitations would have been aggravated severely by
 huge pages, because each tail page adds a refcount to the head page. And in
-fact, testing revealed that, without a separate hpage_pinned_refcount field,
+fact, testing revealed that, without a separate compound_pincount field,
 page overflows were seen in some huge page stress tests.
 
-This also means that huge pages and compound pages (of order > 1) do not suffer
+This also means that huge pages and compound pages do not suffer
 from the false positives problem that is mentioned below.::
 
  Function
@@ -264,9 +264,9 @@ place.)
 Other diagnostics
 =================
 
-dump_page() has been enhanced slightly, to handle these new counting fields, and
-to better report on compound pages in general. Specifically, for compound pages
-with order > 1, the exact (hpage_pinned_refcount) pincount is reported.
+dump_page() has been enhanced slightly, to handle these new counting
+fields, and to better report on compound pages in general. Specifically,
+for compound pages, the exact (compound_pincount) pincount is reported.
 
 References
 ==========
diff --git a/include/linux/mm.h b/include/linux/mm.h
index e679a7d66200..dd7d6e95e43b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -891,17 +891,6 @@ static inline void destroy_compound_page(struct page *page)
 	compound_page_dtors[page[1].compound_dtor](page);
 }
 
-static inline bool hpage_pincount_available(struct page *page)
-{
-	/*
-	 * Can the page->hpage_pinned_refcount field be used? That field is in
-	 * the 3rd page of the compound page, so the smallest (2-page) compound
-	 * pages cannot support it.
-	 */
-	page = compound_head(page);
-	return PageCompound(page) && compound_order(page) > 1;
-}
-
 static inline int head_compound_pincount(struct page *head)
 {
 	return atomic_read(compound_pincount_ptr(head));
@@ -909,7 +898,7 @@ static inline int head_compound_pincount(struct page *head)
 
 static inline int compound_pincount(struct page *page)
 {
-	VM_BUG_ON_PAGE(!hpage_pincount_available(page), page);
+	VM_BUG_ON_PAGE(!PageCompound(page), page);
 	page = compound_head(page);
 	return head_compound_pincount(page);
 }
@@ -917,7 +906,9 @@ static inline int compound_pincount(struct page *page)
 static inline void set_compound_order(struct page *page, unsigned int order)
 {
 	page[1].compound_order = order;
+#ifdef CONFIG_64BIT
 	page[1].compound_nr = 1U << order;
+#endif
 }
 
 /* Returns the number of pages in this potentially compound page. */
@@ -925,7 +916,11 @@ static inline unsigned long compound_nr(struct page *page)
 {
 	if (!PageHead(page))
 		return 1;
+#ifdef CONFIG_64BIT
 	return page[1].compound_nr;
+#else
+	return 1UL << compound_order(page);
+#endif
 }
 
 /* Returns the number of bytes in this potentially compound page. */
@@ -1307,7 +1302,7 @@ void unpin_user_pages(struct page **pages, unsigned long npages);
  */
 static inline bool page_maybe_dma_pinned(struct page *page)
 {
-	if (hpage_pincount_available(page))
+	if (PageCompound(page))
 		return compound_pincount(page) > 0;
 
 	/*
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5140e5feb486..e510ff214acf 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -126,11 +126,14 @@ struct page {
 			unsigned char compound_dtor;
 			unsigned char compound_order;
 			atomic_t compound_mapcount;
+			atomic_t compound_pincount;
+#ifdef CONFIG_64BIT
 			unsigned int compound_nr; /* 1 << compound_order */
+#endif
 		};
 		struct {	/* Second tail page of compound page */
 			unsigned long _compound_pad_1;	/* compound_head */
-			atomic_t hpage_pinned_refcount;
+			unsigned long _compound_pad_2;
 			/* For both global and memcg */
 			struct list_head deferred_list;
 		};
@@ -285,7 +288,7 @@ static inline atomic_t *compound_mapcount_ptr(struct page *page)
 
 static inline atomic_t *compound_pincount_ptr(struct page *page)
 {
-	return &page[2].hpage_pinned_refcount;
+	return &page[1].compound_pincount;
 }
 
 /*
diff --git a/mm/debug.c b/mm/debug.c
index bc9ac87f0e08..c4cf44266430 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -92,16 +92,10 @@ static void __dump_page(struct page *page)
 			page, page_ref_count(head), mapcount, mapping,
 			page_to_pgoff(page), page_to_pfn(page));
 	if (compound) {
-		if (hpage_pincount_available(page)) {
-			pr_warn("head:%p order:%u compound_mapcount:%d compound_pincount:%d\n",
-					head, compound_order(head),
-					head_compound_mapcount(head),
-					head_compound_pincount(head));
-		} else {
-			pr_warn("head:%p order:%u compound_mapcount:%d\n",
-					head, compound_order(head),
-					head_compound_mapcount(head));
-		}
+		pr_warn("head:%p order:%u compound_mapcount:%d compound_pincount:%d\n",
+				head, compound_order(head),
+				head_compound_mapcount(head),
+				head_compound_pincount(head));
 	}
 
 #ifdef CONFIG_MEMCG
diff --git a/mm/gup.c b/mm/gup.c
index af623a139995..a444b94c96fd 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -99,12 +99,11 @@ static inline struct page *try_get_compound_head(struct page *page, int refs)
  *
  *    FOLL_GET: page's refcount will be incremented by @refs.
  *
- *    FOLL_PIN on compound pages that are > two pages long: page's refcount will
- *    be incremented by @refs, and page[2].hpage_pinned_refcount will be
- *    incremented by @refs * GUP_PIN_COUNTING_BIAS.
+ *    FOLL_PIN on compound pages: page's refcount will be incremented by
+ *    @refs, and page[1].compound_pincount will be incremented by @refs.
  *
- *    FOLL_PIN on normal pages, or compound pages that are two pages long:
- *    page's refcount will be incremented by @refs * GUP_PIN_COUNTING_BIAS.
+ *    FOLL_PIN on normal pages: page's refcount will be incremented by
+ *    @refs * GUP_PIN_COUNTING_BIAS.
  *
  * Return: head page (with refcount appropriately incremented) for success, or
  * NULL upon failure. If neither FOLL_GET nor FOLL_PIN was set, that's
@@ -135,16 +134,15 @@ __maybe_unused struct page *try_grab_compound_head(struct page *page,
 			return NULL;
 
 		/*
-		 * When pinning a compound page of order > 1 (which is
-		 * what hpage_pincount_available() checks for), use an
-		 * exact count to track it.
+		 * When pinning a compound page, use an exact count to
+		 * track it.
 		 *
 		 * However, be sure to *also* increment the normal page
 		 * refcount field at least once, so that the page really
 		 * is pinned.  That's why the refcount from the earlier
 		 * try_get_compound_head() is left intact.
 		 */
-		if (hpage_pincount_available(page))
+		if (PageHead(page))
 			atomic_add(refs, compound_pincount_ptr(page));
 		else
 			page_ref_add(page, refs * (GUP_PIN_COUNTING_BIAS - 1));
@@ -166,7 +164,7 @@ static void put_compound_head(struct page *page, int refs, unsigned int flags)
 	if (flags & FOLL_PIN) {
 		mod_node_page_state(page_pgdat(page), NR_FOLL_PIN_RELEASED,
 				    refs);
-		if (hpage_pincount_available(page))
+		if (PageHead(page))
 			atomic_sub(refs, compound_pincount_ptr(page));
 		else
 			refs *= GUP_PIN_COUNTING_BIAS;
@@ -211,7 +209,7 @@ bool __must_check try_grab_page(struct page *page, unsigned int flags)
 		 * increment the normal page refcount field at least once,
 		 * so that the page really is pinned.
 		 */
-		if (hpage_pincount_available(page)) {
+		if (PageHead(page)) {
 			page_ref_add(page, 1);
 			atomic_add(1, compound_pincount_ptr(page));
 		} else {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3589febc6d31..02283598fd14 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -734,8 +734,7 @@ static void prep_compound_head(struct page *page, unsigned int order)
 	set_compound_page_dtor(page, COMPOUND_PAGE_DTOR);
 	set_compound_order(page, order);
 	atomic_set(compound_mapcount_ptr(page), -1);
-	if (hpage_pincount_available(page))
-		atomic_set(compound_pincount_ptr(page), 0);
+	atomic_set(compound_pincount_ptr(page), 0);
 }
 
 static void prep_compound_tail(struct page *head, int tail_idx)
diff --git a/mm/rmap.c b/mm/rmap.c
index 6a1e8c7f6213..a531b64d53fa 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1216,8 +1216,7 @@ void page_add_new_anon_rmap(struct page *page,
 		VM_BUG_ON_PAGE(!PageTransHuge(page), page);
 		/* increment count (starts at -1) */
 		atomic_set(compound_mapcount_ptr(page), 0);
-		if (hpage_pincount_available(page))
-			atomic_set(compound_pincount_ptr(page), 0);
+		atomic_set(compound_pincount_ptr(page), 0);
 
 		__mod_lruvec_page_state(page, NR_ANON_THPS, nr);
 	} else {
@@ -2439,8 +2438,7 @@ void hugepage_add_new_anon_rmap(struct page *page,
 {
 	BUG_ON(address < vma->vm_start || address >= vma->vm_end);
 	atomic_set(compound_mapcount_ptr(page), 0);
-	if (hpage_pincount_available(page))
-		atomic_set(compound_pincount_ptr(page), 0);
+	atomic_set(compound_pincount_ptr(page), 0);
 
 	__page_set_anon_rmap(page, vma, address, 1);
 }
-- 
2.34.1

