Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B9E4AA094
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235920AbiBDUAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235314AbiBDT7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC953C06174E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=z3sPhSbLDlsnaAomIZZPLnOqHhZ/qq70m6emg2A+ypQ=; b=K/ngvCfbirTWidLKv3SUZSSl0v
        dzHdbtLw5VaV24sQnq07oLhjjHPA00pdvzQ5XXmuGai+KYKkbS9qSFnZfuRi1y0uzBN575Ud21i5U
        8dGIqEXz8PPUkcn4Dpvd+f55TI5LtSvpfBRy2VPwlW8ljBsm6tuwZKaryMQ9NSopDBx6TLCdyCp8d
        vOUajyHC4Cn94aJZ8jNhawiVbMyVQeQgizbSRntnFD5YAEJbZsblumJePTjQRLAbon5GwS91U7OHg
        bnm2A8lzk66JRJRnvIi+bAe7G0OVOcvw+dAlgyspnIs1NJlu6WnOOIwsQRqh8zdDCcVFlVra3s20B
        b1/dFB9g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jX-007Lml-43; Fri, 04 Feb 2022 19:59:03 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 36/75] mm: Add folio_mapcount()
Date:   Fri,  4 Feb 2022 19:58:13 +0000
Message-Id: <20220204195852.1751729-37-willy@infradead.org>
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

This implements the same algorithm as total_mapcount(), which is
transformed into a wrapper function.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h |  8 +++++++-
 mm/huge_memory.c   | 24 ------------------------
 mm/util.c          | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 25 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6ddf655f9279..6a19cd97d5aa 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -826,8 +826,14 @@ static inline int page_mapcount(struct page *page)
 	return atomic_read(&page->_mapcount) + 1;
 }
 
+int folio_mapcount(struct folio *folio);
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-int total_mapcount(struct page *page);
+static inline int total_mapcount(struct page *page)
+{
+	return folio_mapcount(page_folio(page));
+}
+
 int page_trans_huge_mapcount(struct page *page);
 #else
 static inline int total_mapcount(struct page *page)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 406a3c28c026..94e591d638eb 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2494,30 +2494,6 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	}
 }
 
-int total_mapcount(struct page *page)
-{
-	int i, compound, nr, ret;
-
-	VM_BUG_ON_PAGE(PageTail(page), page);
-
-	if (likely(!PageCompound(page)))
-		return atomic_read(&page->_mapcount) + 1;
-
-	compound = compound_mapcount(page);
-	nr = compound_nr(page);
-	if (PageHuge(page))
-		return compound;
-	ret = compound;
-	for (i = 0; i < nr; i++)
-		ret += atomic_read(&page[i]._mapcount) + 1;
-	/* File pages has compound_mapcount included in _mapcount */
-	if (!PageAnon(page))
-		return ret - compound * nr;
-	if (PageDoubleMap(page))
-		ret -= nr;
-	return ret;
-}
-
 /*
  * This calculates accurately how many mappings a transparent hugepage
  * has (unlike page_mapcount() which isn't fully accurate). This full
diff --git a/mm/util.c b/mm/util.c
index 7e43369064c8..b614f423aaa4 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -740,6 +740,39 @@ int __page_mapcount(struct page *page)
 }
 EXPORT_SYMBOL_GPL(__page_mapcount);
 
+/**
+ * folio_mapcount() - Calculate the number of mappings of this folio.
+ * @folio: The folio.
+ *
+ * A large folio tracks both how many times the entire folio is mapped,
+ * and how many times each individual page in the folio is mapped.
+ * This function calculates the total number of times the folio is
+ * mapped.
+ *
+ * Return: The number of times this folio is mapped.
+ */
+int folio_mapcount(struct folio *folio)
+{
+	int i, compound, nr, ret;
+
+	if (likely(!folio_test_large(folio)))
+		return atomic_read(&folio->_mapcount) + 1;
+
+	compound = folio_entire_mapcount(folio);
+	nr = folio_nr_pages(folio);
+	if (folio_test_hugetlb(folio))
+		return compound;
+	ret = compound;
+	for (i = 0; i < nr; i++)
+		ret += atomic_read(&folio_page(folio, i)->_mapcount) + 1;
+	/* File pages has compound_mapcount included in _mapcount */
+	if (!folio_test_anon(folio))
+		return ret - compound * nr;
+	if (folio_test_double_map(folio))
+		ret -= nr;
+	return ret;
+}
+
 /**
  * folio_copy - Copy the contents of one folio to another.
  * @dst: Folio to copy to.
-- 
2.34.1

