Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9CE6488F40
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 05:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238760AbiAJEZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 23:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238499AbiAJEYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 23:24:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A3AC06175F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 20:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=VLn5Ly3DUFPdVtS0Qgb2wjVa3EHIQfZkAoJn3cqa2FI=; b=WGawqvxoO+CJRv74HiwyOdh+PN
        b+iQoWlITUT1w+6C4IlF/R++bv9in4Be37KvHIuECtLahc6W0KIgt/GAMMqp7P7WpHE5mIrDwf8sb
        3P9ICkI1fOtX8ZV4dS98NLmbQ3egwI/s4PJGcnr8Uyuy3Xe9dO0EQ+qWDdNxy0V+9orxqUSEwOdWb
        jIdk+NCjOkxSLoIa/SNHILdCRpzaiw9sS9cZC045N+jicqjrxbru+BnZsLIvtu1ZfVlWiDX7OdBG6
        oDZ8rGVSiyu4DimzjxWlKuHI2T1zfLh9RCKaBvOV3Vk5kNcOW5GRc1nl6ks9KoTLb3NNF4HomPZld
        2kCdk9AQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6mE9-0025ww-3i; Mon, 10 Jan 2022 04:24:13 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH v2 16/28] mm: Remove page_cache_add_speculative() and page_cache_get_speculative()
Date:   Mon, 10 Jan 2022 04:23:54 +0000
Message-Id: <20220110042406.499429-17-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220110042406.499429-1-willy@infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These wrappers have no more callers, so delete them.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h      |  7 +++----
 include/linux/pagemap.h | 11 -----------
 2 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d3769897c8ac..b249156f7cf1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1291,10 +1291,9 @@ static inline void put_page(struct page *page)
  * applications that don't have huge page reference counts, this won't be an
  * issue.
  *
- * Locking: the lockless algorithm described in page_cache_get_speculative()
- * and page_cache_gup_pin_speculative() provides safe operation for
- * get_user_pages and page_mkclean and other calls that race to set up page
- * table entries.
+ * Locking: the lockless algorithm described in folio_try_get_rcu()
+ * provides safe operation for get_user_pages(), page_mkclean() and
+ * other calls that race to set up page table entries.
  */
 #define GUP_PIN_COUNTING_BIAS (1U << 10)
 
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 704cb1b4b15d..4a63176b6417 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -283,17 +283,6 @@ static inline struct inode *folio_inode(struct folio *folio)
 	return folio->mapping->host;
 }
 
-static inline bool page_cache_add_speculative(struct page *page, int count)
-{
-	VM_BUG_ON_PAGE(PageTail(page), page);
-	return folio_ref_try_add_rcu((struct folio *)page, count);
-}
-
-static inline bool page_cache_get_speculative(struct page *page)
-{
-	return page_cache_add_speculative(page, 1);
-}
-
 /**
  * folio_attach_private - Attach private data to a folio.
  * @folio: Folio to attach data to.
-- 
2.33.0

