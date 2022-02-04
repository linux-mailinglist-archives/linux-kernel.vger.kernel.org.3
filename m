Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866244AA0D4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240394AbiBDUEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237582AbiBDUCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 15:02:36 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C006C06175F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=K6uEGcItdUrB9ALQsjiHycs0qsgg2DOtdk6zEZO9ZH8=; b=n73jIEwQuwyZQTxixXDE8DRSEr
        fymqdlimxMnwCcTSv9IuxYl8sQKA1JpD3eEiuccMG3IEFT1HYjS49KzfF8/U3PDltvy57wCBPsWnt
        YH9eWWCKO/9VWIPK/769yE5J2l/fkKh8/0mjj/29nQvVIb9w91hacHHFwUODHw0hi6iTQckvL/FGy
        cR2iY8AtuFjx3wjyadcFYGX7PNz/V+QWgojvvSEih07ec1P2NxoE+n8YgNghDcUzQjX5jNMazCymo
        D1gtZd8j8zkO5OMRtBd8p2woBnoLJ36NO9gvRXF6DnKmHL05PDJ85v4baLqEOksFNHcRp0IQnwW2l
        H4jaf5vA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jV-007Llh-3D; Fri, 04 Feb 2022 19:59:01 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH 17/75] mm: Remove page_cache_add_speculative() and page_cache_get_speculative()
Date:   Fri,  4 Feb 2022 19:57:54 +0000
Message-Id: <20220204195852.1751729-18-willy@infradead.org>
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

These wrappers have no more callers, so delete them.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 include/linux/mm.h      |  7 +++----
 include/linux/pagemap.h | 10 ----------
 2 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a29dacec7294..703bc2ec40a9 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1258,10 +1258,9 @@ static inline void put_page(struct page *page)
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
index 270bf5136c34..cdb3f118603a 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -283,16 +283,6 @@ static inline struct inode *folio_inode(struct folio *folio)
 	return folio->mapping->host;
 }
 
-static inline bool page_cache_add_speculative(struct page *page, int count)
-{
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
2.34.1

