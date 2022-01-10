Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27485488F35
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 05:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238507AbiAJEY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 23:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbiAJEYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 23:24:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FA7C061748
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 20:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=8lkIQ5pzUHptX+PQh07i+5GbGN5xDvd48mKak705GKI=; b=Lxrx0VGaelZR0XiQE/gKbFnugO
        prDvQ//ra4faWoP9k9x+hSjkLVWobcO2IlV2gT8KfuDeRx6xvoGP2AljqzpW5E9vj7OhN4bgWIFP4
        JB39/sj6YfIja85XpZXV2AKYX0aY7i7/uAjwftPYg48TULXlaI8K5hdPfxN1/2uYBeUKllI2lzo+1
        z8em1rbCoqk4oZ0b7ZGaPpEfzO0OWqkEIUZEZQvILtyeMWKnKXaEwFcTa7Nsgx6NVtx95GFS4vVcF
        I9QuY8oq4dgp/RLADuZ6z+wEXco9L1LLv5QmFvvAHvmcCeNhqYVXG/8ATpb6AvVgO5jnhedDHobxG
        zXBSVyWw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6mE8-0025ws-Uo; Mon, 10 Jan 2022 04:24:12 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH v2 14/28] mm: Convert page_maybe_dma_pinned() to use a folio
Date:   Mon, 10 Jan 2022 04:23:52 +0000
Message-Id: <20220110042406.499429-15-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220110042406.499429-1-willy@infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace three calls to compound_head() with one.  This removes the last
user of compound_pincount(), so remove that helper too.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index bf9624ca61c3..d3769897c8ac 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -934,13 +934,6 @@ static inline int head_compound_pincount(struct page *head)
 	return atomic_read(compound_pincount_ptr(head));
 }
 
-static inline int compound_pincount(struct page *page)
-{
-	VM_BUG_ON_PAGE(!PageCompound(page), page);
-	page = compound_head(page);
-	return head_compound_pincount(page);
-}
-
 static inline void set_compound_order(struct page *page, unsigned int order)
 {
 	page[1].compound_order = order;
@@ -1340,18 +1333,20 @@ void unpin_user_pages(struct page **pages, unsigned long npages);
  */
 static inline bool page_maybe_dma_pinned(struct page *page)
 {
-	if (PageCompound(page))
-		return compound_pincount(page) > 0;
+	struct folio *folio = page_folio(page);
+
+	if (folio_test_large(folio))
+		return atomic_read(folio_pincount_ptr(folio)) > 0;
 
 	/*
-	 * page_ref_count() is signed. If that refcount overflows, then
-	 * page_ref_count() returns a negative value, and callers will avoid
+	 * folio_ref_count() is signed. If that refcount overflows, then
+	 * folio_ref_count() returns a negative value, and callers will avoid
 	 * further incrementing the refcount.
 	 *
-	 * Here, for that overflow case, use the signed bit to count a little
+	 * Here, for that overflow case, use the sign bit to count a little
 	 * bit higher via unsigned math, and thus still get an accurate result.
 	 */
-	return ((unsigned int)page_ref_count(compound_head(page))) >=
+	return ((unsigned int)folio_ref_count(folio)) >=
 		GUP_PIN_COUNTING_BIAS;
 }
 
-- 
2.33.0

