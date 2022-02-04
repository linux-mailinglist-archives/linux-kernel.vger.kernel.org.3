Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995034AA0B0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239563AbiBDUCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236707AbiBDT7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD18EC061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=NpQTZRmbyZ8ig7SC3y4xH9qVn8a+1Pb7Y1x76z9zPRc=; b=aRLETaj7P4lPBQxBSFPwi4eY26
        bFKvswEOwAbJQfhZbeRPFYhgmzH+g8O+lRfRMheKKCpIiTiKTABPGsvvSxH4EYrrg8BwQ7LrPlGlq
        sbY0LVfNVK3y/sPfdD7dv/CBAXGeXs0HfdI55v+UAX175XhxtLI6odZ4aznlbMWiMc5Z86aHrh9Tk
        HtrDbr0ak//EC2YSeOYEltNnXYHeCnuKBulzCYJt0mmsqGJfPXIbot4C5KRIrPl4T0zxhb2GrxMK0
        bQu3oo9x0rda2lyrco7SQnVN9lAoR4H8Duj+X0i8fRyTzHC2GgKp1Kiax++ioGB3tgjLGDX9Kl94V
        WcqQ5Oaw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jU-007LlZ-SD; Fri, 04 Feb 2022 19:59:00 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH 14/75] mm: Turn page_maybe_dma_pinned() into folio_maybe_dma_pinned()
Date:   Fri,  4 Feb 2022 19:57:51 +0000
Message-Id: <20220204195852.1751729-15-willy@infradead.org>
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

Replace three calls to compound_head() with one.  This removes the last
user of compound_pincount(), so remove that helper too.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 include/linux/mm.h | 49 ++++++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 26 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d5f0f2cfd552..a29dacec7294 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -901,13 +901,6 @@ static inline int head_compound_pincount(struct page *head)
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
@@ -1280,48 +1273,52 @@ void unpin_user_page_range_dirty_lock(struct page *page, unsigned long npages,
 void unpin_user_pages(struct page **pages, unsigned long npages);
 
 /**
- * page_maybe_dma_pinned - Report if a page is pinned for DMA.
- * @page: The page.
+ * folio_maybe_dma_pinned - Report if a folio may be pinned for DMA.
+ * @folio: The folio.
  *
- * This function checks if a page has been pinned via a call to
+ * This function checks if a folio has been pinned via a call to
  * a function in the pin_user_pages() family.
  *
- * For non-huge pages, the return value is partially fuzzy: false is not fuzzy,
+ * For small folios, the return value is partially fuzzy: false is not fuzzy,
  * because it means "definitely not pinned for DMA", but true means "probably
  * pinned for DMA, but possibly a false positive due to having at least
- * GUP_PIN_COUNTING_BIAS worth of normal page references".
+ * GUP_PIN_COUNTING_BIAS worth of normal folio references".
  *
- * False positives are OK, because: a) it's unlikely for a page to get that many
- * refcounts, and b) all the callers of this routine are expected to be able to
- * deal gracefully with a false positive.
+ * False positives are OK, because: a) it's unlikely for a folio to
+ * get that many refcounts, and b) all the callers of this routine are
+ * expected to be able to deal gracefully with a false positive.
  *
- * For huge pages, the result will be exactly correct. That's because we have
- * more tracking data available: the 3rd struct page in the compound page is
- * used to track the pincount (instead using of the GUP_PIN_COUNTING_BIAS
- * scheme).
+ * For large folios, the result will be exactly correct. That's because
+ * we have more tracking data available: the compound_pincount is used
+ * instead of the GUP_PIN_COUNTING_BIAS scheme.
  *
  * For more information, please see Documentation/core-api/pin_user_pages.rst.
  *
  * Return: True, if it is likely that the page has been "dma-pinned".
  * False, if the page is definitely not dma-pinned.
  */
-static inline bool page_maybe_dma_pinned(struct page *page)
+static inline bool folio_maybe_dma_pinned(struct folio *folio)
 {
-	if (PageCompound(page))
-		return compound_pincount(page) > 0;
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
 
+static inline bool page_maybe_dma_pinned(struct page *page)
+{
+	return folio_maybe_dma_pinned(page_folio(page));
+}
+
 static inline bool is_cow_mapping(vm_flags_t flags)
 {
 	return (flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
-- 
2.34.1

