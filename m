Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E874AA0CB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237218AbiBDUDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235550AbiBDT7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFBCC061741
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Sgx8Fjq6qqzcgQGSU/1PfueaWRrZ8ccNlDS2H7vaf+o=; b=kvcAxm3npVVgyLHs+F3BhU9PM9
        LGD9ExxMb9kS+2UOY/oUT8rOCAddLdmkmauGq7Ud3IImpTiZzy9QGdSD/ldP6Hs/8YqNuKc5g/cmP
        443VMQlaXpiIaqJ3n2aYgShP0iuOLYbJK+SWHE31eAQ0ZwsRvu41NjUPj6TXi6X32zj6HEPX0yZxn
        S0SU73ffvRXgm0gtYHQNmKppBSmWN2B37DRR283N/CcaNnzQFyiklhIx9bH2TbCowBqLjof+OWeCI
        9kXkhuSXZBgpzwVhqJE2O1oxTfHSyeWacgxJBJJORW0PmR52BPB5RqowMg1Z3WRF8bwjQm5G3dMMt
        kYqEQ9ZQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jW-007LmN-KG; Fri, 04 Feb 2022 19:59:02 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 32/75] mm: Turn putback_lru_page() into folio_putback_lru()
Date:   Fri,  4 Feb 2022 19:58:09 +0000
Message-Id: <20220204195852.1751729-33-willy@infradead.org>
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

Add a putback_lru_page() wrapper.  Removes a couple of compound_head()
calls.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/folio-compat.c |  5 +++++
 mm/internal.h     |  3 ++-
 mm/vmscan.c       | 16 ++++++++--------
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index a4a7725f4486..46fa179e32fb 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -159,3 +159,8 @@ int isolate_lru_page(struct page *page)
 		return -EBUSY;
 	return folio_isolate_lru((struct folio *)page);
 }
+
+void putback_lru_page(struct page *page)
+{
+	folio_putback_lru(page_folio(page));
+}
diff --git a/mm/internal.h b/mm/internal.h
index 8b0249909b06..b7a2195c12b1 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -159,7 +159,8 @@ extern unsigned long highest_memmap_pfn;
  */
 int isolate_lru_page(struct page *page);
 int folio_isolate_lru(struct folio *folio);
-extern void putback_lru_page(struct page *page);
+void putback_lru_page(struct page *page);
+void folio_putback_lru(struct folio *folio);
 extern void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason);
 
 /*
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 08dcb1897f58..9f11960b1db8 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1355,18 +1355,18 @@ int remove_mapping(struct address_space *mapping, struct page *page)
 }
 
 /**
- * putback_lru_page - put previously isolated page onto appropriate LRU list
- * @page: page to be put back to appropriate lru list
+ * folio_putback_lru - Put previously isolated folio onto appropriate LRU list.
+ * @folio: Folio to be returned to an LRU list.
  *
- * Add previously isolated @page to appropriate LRU list.
- * Page may still be unevictable for other reasons.
+ * Add previously isolated @folio to appropriate LRU list.
+ * The folio may still be unevictable for other reasons.
  *
- * lru_lock must not be held, interrupts must be enabled.
+ * Context: lru_lock must not be held, interrupts must be enabled.
  */
-void putback_lru_page(struct page *page)
+void folio_putback_lru(struct folio *folio)
 {
-	lru_cache_add(page);
-	put_page(page);		/* drop ref from isolate */
+	folio_add_lru(folio);
+	folio_put(folio);		/* drop ref from isolate */
 }
 
 enum page_references {
-- 
2.34.1

