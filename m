Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4F94AA09B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbiBDUAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235966AbiBDT7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B275C06175E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=cuGkyAFOQfL5bVQqvk6Qt9S1Xyv5/CUvEOJSA3z2JA4=; b=jB5EWxe1wkvjtwoUKi9itzym7U
        7JdC3/tO+viBbDdeQyOm+vcqNytohwf5/uFx9nu9kl8N7/tfHWas71CDkAXUICy4l6j6iqHjqvjzc
        WeWzFNWcMTV0p7TIAwCeUQKO1glrZ6jVXs8ilVY87VQ7StkB6vdsGZ6M98zz7o6WR/iix0tpajLIh
        4vzWZcFZnAlDxaUo/1809ZMNu4QURSkv7Zr9vGrR88Vqsl93tS3NYlaUsc/RzGOxwbiG5jLfpLJgu
        ArHnSHI3FlsFfsAhtkXTU+lhhOdkc5QIO0MB6qBnUSpMkhrK8BQcisA/tcLNFvTDqoKwCmYt0zxxZ
        J8SjrsCQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jY-007Lnw-Gr; Fri, 04 Feb 2022 19:59:04 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 47/75] mm/mlock: Turn mlock_vma_page() into mlock_vma_folio()
Date:   Fri,  4 Feb 2022 19:58:24 +0000
Message-Id: <20220204195852.1751729-48-willy@infradead.org>
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

Add mlock_vma_page() back as a wrapper.  Saves a few calls to
compound_head() and an assertion that the page is not a tail page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/folio-compat.c |  5 +++++
 mm/internal.h     |  3 ++-
 mm/mlock.c        | 18 +++++++++---------
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index bcb037d9cec3..9cb0867d5b38 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -169,3 +169,8 @@ void clear_page_mlock(struct page *page)
 {
 	folio_end_mlock(page_folio(page));
 }
+
+void mlock_vma_page(struct page *page)
+{
+	mlock_vma_folio(page_folio(page));
+}
diff --git a/mm/internal.h b/mm/internal.h
index 041c76a4c284..18b024aa7e59 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -411,7 +411,8 @@ static inline void munlock_vma_pages_all(struct vm_area_struct *vma)
 /*
  * must be called with vma's mmap_lock held for read or write, and page locked.
  */
-extern void mlock_vma_page(struct page *page);
+void mlock_vma_page(struct page *page);
+void mlock_vma_folio(struct folio *folio);
 extern unsigned int munlock_vma_page(struct page *page);
 
 extern int mlock_future_check(struct mm_struct *mm, unsigned long flags,
diff --git a/mm/mlock.c b/mm/mlock.c
index ff067d64acc5..d998fd5c84bf 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -94,21 +94,21 @@ void folio_end_mlock(struct folio *folio)
  * Mark page as mlocked if not already.
  * If page on LRU, isolate and putback to move to unevictable list.
  */
-void mlock_vma_page(struct page *page)
+void mlock_vma_folio(struct folio *folio)
 {
 	/* Serialize with page migration */
-	BUG_ON(!PageLocked(page));
+	BUG_ON(!folio_test_locked(folio));
 
-	VM_BUG_ON_PAGE(PageTail(page), page);
-	VM_BUG_ON_PAGE(PageCompound(page) && PageDoubleMap(page), page);
+	VM_BUG_ON_FOLIO(folio_test_large(folio) && folio_test_double_map(folio),
+			folio);
 
-	if (!TestSetPageMlocked(page)) {
-		int nr_pages = thp_nr_pages(page);
+	if (!folio_test_set_mlocked(folio)) {
+		long nr_pages = folio_nr_pages(folio);
 
-		mod_zone_page_state(page_zone(page), NR_MLOCK, nr_pages);
+		zone_stat_mod_folio(folio, NR_MLOCK, nr_pages);
 		count_vm_events(UNEVICTABLE_PGMLOCKED, nr_pages);
-		if (!isolate_lru_page(page))
-			putback_lru_page(page);
+		if (!folio_isolate_lru(folio))
+			folio_putback_lru(folio);
 	}
 }
 
-- 
2.34.1

