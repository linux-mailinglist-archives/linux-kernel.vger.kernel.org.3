Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8664AA0A2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237403AbiBDUBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236701AbiBDT7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB2CC061401
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=+b17a7xWPsDHLBoFxBH2f4z0dvE7rwxxtb0mRTsSrxU=; b=XgcKn+yw5+o9xIunYyq3fy7GL/
        MIoJJqlMYqgoy6GJUjjEwxJXwsgwbAa4auq9YcipIiucw4y5+lvrecu9vNiq4swDxxNU7KCcbuys9
        kqHAxBFj95IfTEOW7os2VcjIMFiSrzI18GjMSCzwErnAloog5vfUxlmGt/C84IAdxLCAT9hwIY/Xb
        QdeIUbJP+H34GJsYvNUg9xRkgUJpa0LvYrnDrI8R5TGkcHCC82aFbX4XOF6NVZp9/DhegLbDA5ZAw
        TBCf7X1RHlSvByyFYLA2IkWqY9mgVcPxlNLq53/1YRveoCL9yi1hnJWG6zRFST7y249l9wbH/qIKF
        TyNiAKcw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jU-007Lld-Ut; Fri, 04 Feb 2022 19:59:00 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH 15/75] mm/gup: Add try_get_folio() and try_grab_folio()
Date:   Fri,  4 Feb 2022 19:57:52 +0000
Message-Id: <20220204195852.1751729-16-willy@infradead.org>
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

Convert try_get_compound_head() into try_get_folio() and convert
try_grab_compound_head() into try_grab_folio().  Add a temporary
try_grab_compound_head() wrapper around try_grab_folio() to let us
convert callers individually.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 mm/gup.c      | 99 +++++++++++++++++++++++++--------------------------
 mm/internal.h |  5 +++
 2 files changed, 54 insertions(+), 50 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index a444b94c96fd..4f1669db92f5 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -47,75 +47,70 @@ static void put_page_refs(struct page *page, int refs)
 }
 
 /*
- * Return the compound head page with ref appropriately incremented,
+ * Return the folio with ref appropriately incremented,
  * or NULL if that failed.
  */
-static inline struct page *try_get_compound_head(struct page *page, int refs)
+static inline struct folio *try_get_folio(struct page *page, int refs)
 {
-	struct page *head;
+	struct folio *folio;
 
 retry:
-	head = compound_head(page);
-
-	if (WARN_ON_ONCE(page_ref_count(head) < 0))
+	folio = page_folio(page);
+	if (WARN_ON_ONCE(folio_ref_count(folio) < 0))
 		return NULL;
-	if (unlikely(!page_cache_add_speculative(head, refs)))
+	if (unlikely(!folio_ref_try_add_rcu(folio, refs)))
 		return NULL;
 
 	/*
-	 * At this point we have a stable reference to the head page; but it
-	 * could be that between the compound_head() lookup and the refcount
-	 * increment, the compound page was split, in which case we'd end up
-	 * holding a reference on a page that has nothing to do with the page
+	 * At this point we have a stable reference to the folio; but it
+	 * could be that between calling page_folio() and the refcount
+	 * increment, the folio was split, in which case we'd end up
+	 * holding a reference on a folio that has nothing to do with the page
 	 * we were given anymore.
-	 * So now that the head page is stable, recheck that the pages still
-	 * belong together.
+	 * So now that the folio is stable, recheck that the page still
+	 * belongs to this folio.
 	 */
-	if (unlikely(compound_head(page) != head)) {
-		put_page_refs(head, refs);
+	if (unlikely(page_folio(page) != folio)) {
+		folio_put_refs(folio, refs);
 		goto retry;
 	}
 
-	return head;
+	return folio;
 }
 
 /**
- * try_grab_compound_head() - attempt to elevate a page's refcount, by a
- * flags-dependent amount.
- *
- * Even though the name includes "compound_head", this function is still
- * appropriate for callers that have a non-compound @page to get.
- *
+ * try_grab_folio() - Attempt to get or pin a folio.
  * @page:  pointer to page to be grabbed
- * @refs:  the value to (effectively) add to the page's refcount
+ * @refs:  the value to (effectively) add to the folio's refcount
  * @flags: gup flags: these are the FOLL_* flag values.
  *
  * "grab" names in this file mean, "look at flags to decide whether to use
- * FOLL_PIN or FOLL_GET behavior, when incrementing the page's refcount.
+ * FOLL_PIN or FOLL_GET behavior, when incrementing the folio's refcount.
  *
  * Either FOLL_PIN or FOLL_GET (or neither) must be set, but not both at the
  * same time. (That's true throughout the get_user_pages*() and
  * pin_user_pages*() APIs.) Cases:
  *
- *    FOLL_GET: page's refcount will be incremented by @refs.
+ *    FOLL_GET: folio's refcount will be incremented by @refs.
  *
- *    FOLL_PIN on compound pages: page's refcount will be incremented by
- *    @refs, and page[1].compound_pincount will be incremented by @refs.
+ *    FOLL_PIN on large folios: folio's refcount will be incremented by
+ *    @refs, and its compound_pincount will be incremented by @refs.
  *
- *    FOLL_PIN on normal pages: page's refcount will be incremented by
+ *    FOLL_PIN on single-page folios: folio's refcount will be incremented by
  *    @refs * GUP_PIN_COUNTING_BIAS.
  *
- * Return: head page (with refcount appropriately incremented) for success, or
- * NULL upon failure. If neither FOLL_GET nor FOLL_PIN was set, that's
- * considered failure, and furthermore, a likely bug in the caller, so a warning
- * is also emitted.
+ * Return: The folio containing @page (with refcount appropriately
+ * incremented) for success, or NULL upon failure. If neither FOLL_GET
+ * nor FOLL_PIN was set, that's considered failure, and furthermore,
+ * a likely bug in the caller, so a warning is also emitted.
  */
-__maybe_unused struct page *try_grab_compound_head(struct page *page,
-						   int refs, unsigned int flags)
+struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
 {
 	if (flags & FOLL_GET)
-		return try_get_compound_head(page, refs);
+		return try_get_folio(page, refs);
 	else if (flags & FOLL_PIN) {
+		struct folio *folio;
+
 		/*
 		 * Can't do FOLL_LONGTERM + FOLL_PIN gup fast path if not in a
 		 * right zone, so fail and let the caller fall back to the slow
@@ -129,34 +124,38 @@ __maybe_unused struct page *try_grab_compound_head(struct page *page,
 		 * CAUTION: Don't use compound_head() on the page before this
 		 * point, the result won't be stable.
 		 */
-		page = try_get_compound_head(page, refs);
-		if (!page)
+		folio = try_get_folio(page, refs);
+		if (!folio)
 			return NULL;
 
 		/*
-		 * When pinning a compound page, use an exact count to
-		 * track it.
+		 * When pinning a large folio, use an exact count to track it.
 		 *
-		 * However, be sure to *also* increment the normal page
-		 * refcount field at least once, so that the page really
+		 * However, be sure to *also* increment the normal folio
+		 * refcount field at least once, so that the folio really
 		 * is pinned.  That's why the refcount from the earlier
-		 * try_get_compound_head() is left intact.
+		 * try_get_folio() is left intact.
 		 */
-		if (PageHead(page))
-			atomic_add(refs, compound_pincount_ptr(page));
+		if (folio_test_large(folio))
+			atomic_add(refs, folio_pincount_ptr(folio));
 		else
-			page_ref_add(page, refs * (GUP_PIN_COUNTING_BIAS - 1));
+			folio_ref_add(folio,
+					refs * (GUP_PIN_COUNTING_BIAS - 1));
+		node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, refs);
 
-		mod_node_page_state(page_pgdat(page), NR_FOLL_PIN_ACQUIRED,
-				    refs);
-
-		return page;
+		return folio;
 	}
 
 	WARN_ON_ONCE(1);
 	return NULL;
 }
 
+struct page *try_grab_compound_head(struct page *page,
+		int refs, unsigned int flags)
+{
+	return &try_grab_folio(page, refs, flags)->page;
+}
+
 static void put_compound_head(struct page *page, int refs, unsigned int flags)
 {
 	VM_BUG_ON_PAGE(PageTail(page), page);
@@ -185,7 +184,7 @@ static void put_compound_head(struct page *page, int refs, unsigned int flags)
  * @flags:   gup flags: these are the FOLL_* flag values.
  *
  * Either FOLL_PIN or FOLL_GET (or neither) may be set, but not both at the same
- * time. Cases: please see the try_grab_compound_head() documentation, with
+ * time. Cases: please see the try_grab_folio() documentation, with
  * "refs=1".
  *
  * Return: true for success, or if no action was required (if neither FOLL_PIN
diff --git a/mm/internal.h b/mm/internal.h
index d80300392a19..08a44802c80e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -718,4 +718,9 @@ void vunmap_range_noflush(unsigned long start, unsigned long end);
 int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
 		      unsigned long addr, int page_nid, int *flags);
 
+/*
+ * mm/gup.c
+ */
+struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags);
+
 #endif	/* __MM_INTERNAL_H */
-- 
2.34.1

