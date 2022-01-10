Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7C8488F38
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 05:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238560AbiAJEYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 23:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238483AbiAJEYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 23:24:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8FDC061756
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 20:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=vDqLbEnHUcTnSYJT/+8mqVyuYK0UxluPC/+3yXrlqME=; b=S68kUEDi9O306wA5NqLmOLyEqz
        ofgAfH/kLeUxCOEyNQjHk/dUz9c6MqDDSgGn9Jcgokac4kcE7pwJPLIAgEiMI7AdxS7mhPM7fJrwh
        iGls2n+779gV1uiExYzSEQ04Cnqu1bU14xGITfWI36NS7yD9ubEA9vztiAdURco2svLcOnMYinUtm
        BWU8R+MpN978d0ZJ+cldutqVeyp4Zk/aygpZWKzalb95VVbAaCEPrD6iO04KDtjvVPkPY/CKJzpCl
        WcFWM/rMEbNJa70OZpu3H4Pza5h2bShSsopOEgB73Jsy+jtg3nre+A5iiMqQUN1cMjZOhZEHiGw12
        2WJMM5Eg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6mE8-0025wm-Mz; Mon, 10 Jan 2022 04:24:12 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH v2 11/28] mm: Make compound_pincount always available
Date:   Mon, 10 Jan 2022 04:23:49 +0000
Message-Id: <20220110042406.499429-12-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220110042406.499429-1-willy@infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
---
 Documentation/core-api/pin_user_pages.rst | 18 +++++++++---------
 include/linux/mm.h                        | 21 ++++++++-------------
 include/linux/mm_types.h                  |  7 +++++--
 mm/debug.c                                | 14 ++++----------
 mm/gup.c                                  | 18 ++++++++----------
 mm/page_alloc.c                           |  3 +--
 mm/rmap.c                                 |  6 ++----
 7 files changed, 37 insertions(+), 50 deletions(-)

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
index f2f3400665a4..598be27d4d2e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -929,17 +929,6 @@ static inline void destroy_compound_page(struct page *page)
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
@@ -947,7 +936,7 @@ static inline int head_compound_pincount(struct page *head)
 
 static inline int compound_pincount(struct page *page)
 {
-	VM_BUG_ON_PAGE(!hpage_pincount_available(page), page);
+	VM_BUG_ON_PAGE(!PageCompound(page), page);
 	page = compound_head(page);
 	return head_compound_pincount(page);
 }
@@ -955,7 +944,9 @@ static inline int compound_pincount(struct page *page)
 static inline void set_compound_order(struct page *page, unsigned int order)
 {
 	page[1].compound_order = order;
+#ifdef CONFIG_64BIT
 	page[1].compound_nr = 1U << order;
+#endif
 }
 
 /* Returns the number of pages in this potentially compound page. */
@@ -963,7 +954,11 @@ static inline unsigned long compound_nr(struct page *page)
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
@@ -1325,7 +1320,7 @@ void unpin_user_pages(struct page **pages, unsigned long npages);
  */
 static inline bool page_maybe_dma_pinned(struct page *page)
 {
-	if (hpage_pincount_available(page))
+	if (PageCompound(page))
 		return compound_pincount(page) > 0;
 
 	/*
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index c3a6e6209600..60e4595eaf63 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -150,11 +150,14 @@ struct page {
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
@@ -311,7 +314,7 @@ static inline atomic_t *compound_mapcount_ptr(struct page *page)
 
 static inline atomic_t *compound_pincount_ptr(struct page *page)
 {
-	return &page[2].hpage_pinned_refcount;
+	return &page[1].compound_pincount;
 }
 
 /*
diff --git a/mm/debug.c b/mm/debug.c
index a05a39ff8fe4..7925fac2bd8e 100644
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
index aed48de3912e..1282d29357b7 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -30,9 +30,8 @@ struct follow_page_context {
 };
 
 /*
- * When pinning a compound page of order > 1 (which is what
- * hpage_pincount_available() checks for), use an exact count to track
- * it, via page_pincount_add/_sub().
+ * When pinning a compound page, use an exact count to track it, via
+ * page_pincount_add/_sub().
  *
  * However, be sure to *also* increment the normal page refcount field
  * at least once, so that the page really is pinned.  That's why the
@@ -42,7 +41,7 @@ static void page_pincount_add(struct page *page, int refs)
 {
 	VM_BUG_ON_PAGE(page != compound_head(page), page);
 
-	if (hpage_pincount_available(page))
+	if (PageHead(page))
 		atomic_add(refs, compound_pincount_ptr(page));
 	else
 		page_ref_add(page, refs * (GUP_PIN_COUNTING_BIAS - 1));
@@ -52,7 +51,7 @@ static int page_pincount_sub(struct page *page, int refs)
 {
 	VM_BUG_ON_PAGE(page != compound_head(page), page);
 
-	if (hpage_pincount_available(page))
+	if (PageHead(page))
 		atomic_sub(refs, compound_pincount_ptr(page));
 	else
 		refs *= GUP_PIN_COUNTING_BIAS;
@@ -129,12 +128,11 @@ static inline struct page *try_get_compound_head(struct page *page, int refs)
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
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c5952749ad40..6b030c0cb207 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -741,8 +741,7 @@ void prep_compound_page(struct page *page, unsigned int order)
 	set_compound_page_dtor(page, COMPOUND_PAGE_DTOR);
 	set_compound_order(page, order);
 	atomic_set(compound_mapcount_ptr(page), -1);
-	if (hpage_pincount_available(page))
-		atomic_set(compound_pincount_ptr(page), 0);
+	atomic_set(compound_pincount_ptr(page), 0);
 }
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
diff --git a/mm/rmap.c b/mm/rmap.c
index 163ac4e6bcee..a44a32db4803 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1187,8 +1187,7 @@ void page_add_new_anon_rmap(struct page *page,
 		VM_BUG_ON_PAGE(!PageTransHuge(page), page);
 		/* increment count (starts at -1) */
 		atomic_set(compound_mapcount_ptr(page), 0);
-		if (hpage_pincount_available(page))
-			atomic_set(compound_pincount_ptr(page), 0);
+		atomic_set(compound_pincount_ptr(page), 0);
 
 		__mod_lruvec_page_state(page, NR_ANON_THPS, nr);
 	} else {
@@ -2410,8 +2409,7 @@ void hugepage_add_new_anon_rmap(struct page *page,
 {
 	BUG_ON(address < vma->vm_start || address >= vma->vm_end);
 	atomic_set(compound_mapcount_ptr(page), 0);
-	if (hpage_pincount_available(page))
-		atomic_set(compound_pincount_ptr(page), 0);
+	atomic_set(compound_pincount_ptr(page), 0);
 
 	__page_set_anon_rmap(page, vma, address, 1);
 }
-- 
2.33.0

