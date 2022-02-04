Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BA74AA0D0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238465AbiBDUEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236379AbiBDT7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCB2C061776
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=mfpEiN7V6KgAhYQJ/BCt5XzV5Jg5e40eIBNMqzHDryo=; b=He9m6FmGDJ0fshJUZG1ER3KtNZ
        XkvendKeN9NIJIRB96CVvmCr3VOweyDhF/RuDLJwKezs9NLO0PV7biQke9AbKvN8GBV79i5IE4/nL
        Yqj8jcT8241iwONoxUGMLDUy0e3fdz9HpqfmQa+JVVV7PjBlUMeMil7pAhxDkatkFPJKR9NEnoZ73
        WSvHAOqBym6YwU+tTpwao9gZPwMrdR/aAKHBDDNtcKtcQcuA2tfX/99+f5py322DsDvXVE8/oR4vm
        A3V5t3CAtUw842HOJx7c1gqEvf4u1SFcPWWVRyUewJ6V8gWhIPQ2v+65lEENbtjAzLWlHxd+fTftN
        a9iWI8eQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jb-007LrN-R7; Fri, 04 Feb 2022 19:59:07 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 70/75] mm: Support arbitrary THP sizes
Date:   Fri,  4 Feb 2022 19:58:47 +0000
Message-Id: <20220204195852.1751729-71-willy@infradead.org>
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

For code which has not yet been converted from THP to folios, use the
compound size of the page instead of assuming PTE or PMD size.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/huge_mm.h | 47 -----------------------------------------
 include/linux/mm.h      | 31 +++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 47 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index e0348bca3d66..0734aff8fa19 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -250,30 +250,6 @@ static inline spinlock_t *pud_trans_huge_lock(pud_t *pud,
 		return NULL;
 }
 
-/**
- * thp_order - Order of a transparent huge page.
- * @page: Head page of a transparent huge page.
- */
-static inline unsigned int thp_order(struct page *page)
-{
-	VM_BUG_ON_PGFLAGS(PageTail(page), page);
-	if (PageHead(page))
-		return HPAGE_PMD_ORDER;
-	return 0;
-}
-
-/**
- * thp_nr_pages - The number of regular pages in this huge page.
- * @page: The head page of a huge page.
- */
-static inline int thp_nr_pages(struct page *page)
-{
-	VM_BUG_ON_PGFLAGS(PageTail(page), page);
-	if (PageHead(page))
-		return HPAGE_PMD_NR;
-	return 1;
-}
-
 /**
  * folio_test_pmd_mappable - Can we map this folio with a PMD?
  * @folio: The folio to test
@@ -336,18 +312,6 @@ static inline struct list_head *page_deferred_list(struct page *page)
 #define HPAGE_PUD_MASK ({ BUILD_BUG(); 0; })
 #define HPAGE_PUD_SIZE ({ BUILD_BUG(); 0; })
 
-static inline unsigned int thp_order(struct page *page)
-{
-	VM_BUG_ON_PGFLAGS(PageTail(page), page);
-	return 0;
-}
-
-static inline int thp_nr_pages(struct page *page)
-{
-	VM_BUG_ON_PGFLAGS(PageTail(page), page);
-	return 1;
-}
-
 static inline bool folio_test_pmd_mappable(struct folio *folio)
 {
 	return false;
@@ -489,15 +453,4 @@ static inline int split_folio_to_list(struct folio *folio,
 	return split_huge_page_to_list(&folio->page, list);
 }
 
-/**
- * thp_size - Size of a transparent huge page.
- * @page: Head page of a transparent huge page.
- *
- * Return: Number of bytes in this page.
- */
-static inline unsigned long thp_size(struct page *page)
-{
-	return PAGE_SIZE << thp_order(page);
-}
-
 #endif /* _LINUX_HUGE_MM_H */
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 74d9cda7cfd6..0c2a0f4bda1b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -945,6 +945,37 @@ static inline unsigned int page_shift(struct page *page)
 	return PAGE_SHIFT + compound_order(page);
 }
 
+/**
+ * thp_order - Order of a transparent huge page.
+ * @page: Head page of a transparent huge page.
+ */
+static inline unsigned int thp_order(struct page *page)
+{
+	VM_BUG_ON_PGFLAGS(PageTail(page), page);
+	return compound_order(page);
+}
+
+/**
+ * thp_nr_pages - The number of regular pages in this huge page.
+ * @page: The head page of a huge page.
+ */
+static inline int thp_nr_pages(struct page *page)
+{
+	VM_BUG_ON_PGFLAGS(PageTail(page), page);
+	return compound_nr(page);
+}
+
+/**
+ * thp_size - Size of a transparent huge page.
+ * @page: Head page of a transparent huge page.
+ *
+ * Return: Number of bytes in this page.
+ */
+static inline unsigned long thp_size(struct page *page)
+{
+	return PAGE_SIZE << thp_order(page);
+}
+
 void free_compound_page(struct page *page);
 
 #ifdef CONFIG_MMU
-- 
2.34.1

