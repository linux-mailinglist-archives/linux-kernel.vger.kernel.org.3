Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768054AA0D9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239042AbiBDUE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237328AbiBDUCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 15:02:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05177C061757
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=PDfDz/oaz4L+aABam7Kbhp4ZsvE+ZH2V505Pz0ioVSI=; b=VvalZs9KsnrtIMbf36IKhtipY7
        YxQQQYfjnSYwObbxqCfo6pgwfIg13eaTgNgyfqfADCi5k0O5/0EvwnLZ6YwR6uebbyByDeyJ30kBW
        wE2d/kjJAUccWzusZy/CaG0hVZdoXnxHqQatwudN4k3s7vEdUVjJ3XRLC1gbrLNDxcS9VrdG5oY37
        /Yxk6vfd+slWnnzn5RPKo1a56MGFnYJeP3X+ZWZgY4GiBmonifwXBQIVekfoAjkF92xWcSjvvwutd
        mJBEdZxygP7x8UhjEGzaRqfGcb3SUqfcWC4TpA1/L0pLFNpGr53C7mhfkeaVi/QUA4nBvLhm8/m0u
        VSoGtHtw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jc-007Lrh-9D; Fri, 04 Feb 2022 19:59:08 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 73/75] mm/readahead: Switch to page_cache_ra_order
Date:   Fri,  4 Feb 2022 19:58:50 +0000
Message-Id: <20220204195852.1751729-74-willy@infradead.org>
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

do_page_cache_ra() was being exposed for the benefit of
do_sync_mmap_readahead().  Switch it over to page_cache_ra_order()
partly because it's a better interface but mostly for the benefit of
the next patch.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c   | 2 +-
 mm/internal.h  | 4 ++--
 mm/readahead.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 8f7ac3de9098..fe764225ae99 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3027,7 +3027,7 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	ra->size = ra->ra_pages;
 	ra->async_size = ra->ra_pages / 4;
 	ractl._index = ra->start;
-	do_page_cache_ra(&ractl, ra->size, ra->async_size);
+	page_cache_ra_order(&ractl, ra, 0);
 	return fpin;
 }
 
diff --git a/mm/internal.h b/mm/internal.h
index 360256e4ee06..4b401313b9f2 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -83,8 +83,8 @@ void unmap_page_range(struct mmu_gather *tlb,
 			     unsigned long addr, unsigned long end,
 			     struct zap_details *details);
 
-void do_page_cache_ra(struct readahead_control *, unsigned long nr_to_read,
-		unsigned long lookahead_size);
+void page_cache_ra_order(struct readahead_control *, struct file_ra_state *,
+		unsigned int order);
 void force_page_cache_ra(struct readahead_control *, unsigned long nr);
 static inline void force_page_cache_readahead(struct address_space *mapping,
 		struct file *file, pgoff_t index, unsigned long nr_to_read)
diff --git a/mm/readahead.c b/mm/readahead.c
index 5100eaf5b0ee..a20391d6a71b 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -247,7 +247,7 @@ EXPORT_SYMBOL_GPL(page_cache_ra_unbounded);
  * behaviour which would occur if page allocations are causing VM writeback.
  * We really don't want to intermingle reads and writes like that.
  */
-void do_page_cache_ra(struct readahead_control *ractl,
+static void do_page_cache_ra(struct readahead_control *ractl,
 		unsigned long nr_to_read, unsigned long lookahead_size)
 {
 	struct inode *inode = ractl->mapping->host;
@@ -462,7 +462,7 @@ static inline int ra_alloc_folio(struct readahead_control *ractl, pgoff_t index,
 	return err;
 }
 
-static void page_cache_ra_order(struct readahead_control *ractl,
+void page_cache_ra_order(struct readahead_control *ractl,
 		struct file_ra_state *ra, unsigned int new_order)
 {
 	struct address_space *mapping = ractl->mapping;
-- 
2.34.1

