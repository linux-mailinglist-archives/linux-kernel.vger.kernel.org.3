Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945D0488F47
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 05:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238673AbiAJE0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 23:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238569AbiAJEYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 23:24:36 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5D9C061748
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 20:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=pr6dwM9p32xFGkENVfW8ccHIrI0fREnA+ZakTJ73Pp8=; b=diLvaBxsmnGNc0FH5T2NoqikDX
        Q4Ygnsy6APbDxF2yhgPg/bUDT/ZZl5VKG73fA3Wb/qUY1yr/6zw06e9ozJDWRpziaMw2g2IVFIu6U
        QnHwvyE3ecy9hBMdhQhrtNPVBoIQRVfVsI3wVBFTXIjA17sjB/F36yzkUY1r2uMTg8eCIyjpcgs9o
        HERYwayFGxgm8bF0MKu0UBGFNSiWSAGYzZjJQKryikGkg7Sgy50thISU/Y4S9hK8usWe9Zha3lydG
        neZjS1K3jtVAYFKarLfjPxhFpKfl6hIaB5iteXtDUv2QkKsgaiFuxpgj50rTbXDia0Jtfj3fRnA79
        jjHXkc7g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6mE8-0025wo-Pi; Mon, 10 Jan 2022 04:24:12 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH v2 12/28] mm: Add folio_put_refs()
Date:   Mon, 10 Jan 2022 04:23:50 +0000
Message-Id: <20220110042406.499429-13-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220110042406.499429-1-willy@infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is like folio_put(), but puts N references at once instead of
just one.  It's like put_page_refs(), but does one atomic operation
instead of two, and is available to more than just gup.c.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 598be27d4d2e..bf9624ca61c3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1234,6 +1234,26 @@ static inline void folio_put(struct folio *folio)
 		__put_page(&folio->page);
 }
 
+/**
+ * folio_put_refs - Reduce the reference count on a folio.
+ * @folio: The folio.
+ * @refs: The number of references to reduce.
+ *
+ * If the folio's reference count reaches zero, the memory will be
+ * released back to the page allocator and may be used by another
+ * allocation immediately.  Do not access the memory or the struct folio
+ * after calling folio_put_refs() unless you can be sure that these weren't
+ * the last references.
+ *
+ * Context: May be called in process or interrupt context, but not in NMI
+ * context.  May be called while holding a spinlock.
+ */
+static inline void folio_put_refs(struct folio *folio, int refs)
+{
+	if (folio_ref_sub_and_test(folio, refs))
+		__put_page(&folio->page);
+}
+
 static inline void put_page(struct page *page)
 {
 	struct folio *folio = page_folio(page);
-- 
2.33.0

