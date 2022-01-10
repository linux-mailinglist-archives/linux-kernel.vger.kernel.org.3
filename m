Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47703488F46
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 05:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbiAJE0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 23:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238543AbiAJEYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 23:24:34 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3215C061757
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 20:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Fb1nGJRKTWWZNwZ6nVvnMjBwiTsGQjxg+7diVdo/Ofc=; b=Dmsv6SlX9hxCR2dO33GsQIoQlw
        yIjfiUE/WRcLyJ7IjHBPc/JcqVXtuQYDNDvtGXi48grWo9YT8gUI/nmO5sGTVS13s+GDsjcop2UpS
        KbPsO1/RLw+Q8vlrvP0klzrRiJxitQQJsPEd6hCOm+wHihLZvovsyu6czW9xZrV5dntD+Ip9Fv2xn
        VwMphye2h29mC/1n3wonvq+9dKiNbz7VIhAKFfVxMk3cVVb+izq2ODz+CJM/OWZnmuyYuxAgWUY/D
        f4vktvA96JVvGLjqngotNfvJAw75IOBJIutxW/IWMPmVLlsvJAic9D0OSQgPAQ6hh6n+bYnE0fLgJ
        ealpxBSw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6mE9-0025wy-6A; Mon, 10 Jan 2022 04:24:13 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH v2 17/28] gup: Add gup_put_folio()
Date:   Mon, 10 Jan 2022 04:23:55 +0000
Message-Id: <20220110042406.499429-18-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220110042406.499429-1-willy@infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert put_compound_head() to gup_put_folio() and hpage_pincount_sub()
to folio_pincount_sub().  This removes the last call to put_page_refs(),
so delete it.  Add a temporary put_compound_head() wrapper which will
be deleted by the end of this series.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/gup.c | 42 ++++++++++++++----------------------------
 1 file changed, 14 insertions(+), 28 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 9e581201d679..719252fa0402 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -45,34 +45,15 @@ static void folio_pincount_add(struct folio *folio, int refs)
 		folio_ref_add(folio, refs * (GUP_PIN_COUNTING_BIAS - 1));
 }
 
-static int page_pincount_sub(struct page *page, int refs)
+static int folio_pincount_sub(struct folio *folio, int refs)
 {
-	VM_BUG_ON_PAGE(page != compound_head(page), page);
-
-	if (PageHead(page))
-		atomic_sub(refs, compound_pincount_ptr(page));
+	if (folio_test_large(folio))
+		atomic_sub(refs, folio_pincount_ptr(folio));
 	else
 		refs *= GUP_PIN_COUNTING_BIAS;
 	return refs;
 }
 
-/* Equivalent to calling put_page() @refs times. */
-static void put_page_refs(struct page *page, int refs)
-{
-#ifdef CONFIG_DEBUG_VM
-	if (VM_WARN_ON_ONCE_PAGE(page_ref_count(page) < refs, page))
-		return;
-#endif
-
-	/*
-	 * Calling put_page() for each ref is unnecessarily slow. Only the last
-	 * ref needs a put_page().
-	 */
-	if (refs > 1)
-		page_ref_sub(page, refs - 1);
-	put_page(page);
-}
-
 /*
  * Return the folio with ref appropriately incremented,
  * or NULL if that failed.
@@ -171,15 +152,20 @@ struct page *try_grab_compound_head(struct page *page,
 	return &try_grab_folio(page, refs, flags)->page;
 }
 
-static void put_compound_head(struct page *page, int refs, unsigned int flags)
+static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
 {
 	if (flags & FOLL_PIN) {
-		mod_node_page_state(page_pgdat(page), NR_FOLL_PIN_RELEASED,
-				    refs);
-		refs = page_pincount_sub(page, refs);
+		node_stat_mod_folio(folio, NR_FOLL_PIN_RELEASED, refs);
+		refs = folio_pincount_sub(folio, refs);
 	}
 
-	put_page_refs(page, refs);
+	folio_put_refs(folio, refs);
+}
+
+static void put_compound_head(struct page *page, int refs, unsigned int flags)
+{
+	VM_BUG_ON_PAGE(PageTail(page), page);
+	gup_put_folio((struct folio *)page, refs, flags);
 }
 
 /**
@@ -220,7 +206,7 @@ bool __must_check try_grab_page(struct page *page, unsigned int flags)
  */
 void unpin_user_page(struct page *page)
 {
-	put_compound_head(compound_head(page), 1, FOLL_PIN);
+	gup_put_folio(page_folio(page), 1, FOLL_PIN);
 }
 EXPORT_SYMBOL(unpin_user_page);
 
-- 
2.33.0

