Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50E44AA0D7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242477AbiBDUEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237486AbiBDUCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 15:02:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37ED1C061755
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=+4tBeaklvdvGu9XohLA9vxxPNHHKx5nKgsj0F1FKj0c=; b=DiQigXf5g5q1WBeijr3T1+Ztct
        Ex2brtDykM3E0jjFQaI2yvvVX2hXIsgXkoq954ulIwx/YKlSD916xFhT6yy36eyP0foeVdihwim4c
        M5gNnr4WQMhBRzta9v1oH5JOohzU1O/NuYUI5dKAsfMx6ybh6q9rC7sAsTILltQb4VVuuc2AVll1K
        PWSXqLd0y2vDy3ty9ND6nsyVPYIOs/v3ixwweResIX3UxJdZm/8mqEl7PFgxk6ZFWdFRbwf4B+tlM
        lEfMYNlyYXTmhHLBoKE0i4hJsm4/pEg72jvGHsIdof+RxAzXFb/q/EBR53RWfyZVAHQPM5OwHTpV9
        Ei6rUr7A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jV-007Lln-6m; Fri, 04 Feb 2022 19:59:01 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH 18/75] mm/gup: Add gup_put_folio()
Date:   Fri,  4 Feb 2022 19:57:55 +0000
Message-Id: <20220204195852.1751729-19-willy@infradead.org>
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

Convert put_compound_head() to gup_put_folio() and hpage_pincount_sub()
to folio_pincount_sub().  This removes the last call to put_page_refs(),
so delete it.  Add a temporary put_compound_head() wrapper which will
be deleted by the end of this series.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 mm/gup.c | 38 ++++++++++++--------------------------
 1 file changed, 12 insertions(+), 26 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index d18ce4da573f..04a370b1580e 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -29,23 +29,6 @@ struct follow_page_context {
 	unsigned int page_mask;
 };
 
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
@@ -156,20 +139,23 @@ struct page *try_grab_compound_head(struct page *page,
 	return &try_grab_folio(page, refs, flags)->page;
 }
 
-static void put_compound_head(struct page *page, int refs, unsigned int flags)
+static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
 {
-	VM_BUG_ON_PAGE(PageTail(page), page);
-
 	if (flags & FOLL_PIN) {
-		mod_node_page_state(page_pgdat(page), NR_FOLL_PIN_RELEASED,
-				    refs);
-		if (PageHead(page))
-			atomic_sub(refs, compound_pincount_ptr(page));
+		node_stat_mod_folio(folio, NR_FOLL_PIN_RELEASED, refs);
+		if (folio_test_large(folio))
+			atomic_sub(refs, folio_pincount_ptr(folio));
 		else
 			refs *= GUP_PIN_COUNTING_BIAS;
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
@@ -230,7 +216,7 @@ bool __must_check try_grab_page(struct page *page, unsigned int flags)
  */
 void unpin_user_page(struct page *page)
 {
-	put_compound_head(compound_head(page), 1, FOLL_PIN);
+	gup_put_folio(page_folio(page), 1, FOLL_PIN);
 }
 EXPORT_SYMBOL(unpin_user_page);
 
-- 
2.34.1

