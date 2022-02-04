Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77CD4AA0B1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239673AbiBDUCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236733AbiBDT7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B55C061753
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=XL5FkBrc2ylV5KQH/3coVOI3jsRBl16W89t8vD99zAw=; b=jkYaZT3Ycuh9rDyCJLWRte1oto
        TgUTh+cdmgStfzhy5meqbDm3amqz55GHwM2UiqMAQrgbxbkBWkquOF3ur3C1sPDIDGzya70sixZi3
        MFvXzOQB7f/YHvsOgranDOokRzyWGAr7rqQYYNDy+w+S2RN75scyVYAxeyjLMbjSJ1/BBtMYfTRDk
        isPJZVumR165Ve28HFzi8frNGEwPGbv5qNqYqBjwD0rz8sJb9dTX1+0/WRxjBg0scjuMJFk49Hi5T
        lZ8hqC1ph/nK1EbCc6XH9oKJa29nrU1E/0MV7HmiMuchYPiojKdAcCx4YhG2Cx/qNxyAw+B3HmzeF
        H9Ythg+Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jV-007Llp-9T; Fri, 04 Feb 2022 19:59:01 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH 19/75] mm/hugetlb: Use try_grab_folio() instead of try_grab_compound_head()
Date:   Fri,  4 Feb 2022 19:57:56 +0000
Message-Id: <20220204195852.1751729-20-willy@infradead.org>
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

follow_hugetlb_page() only cares about success or failure, so it doesn't
need to know the type of the returned pointer, only whether it's NULL
or not.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 include/linux/mm.h | 3 ---
 mm/gup.c           | 2 +-
 mm/hugetlb.c       | 7 +++----
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 703bc2ec40a9..da565dc1029d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1162,9 +1162,6 @@ static inline void get_page(struct page *page)
 }
 
 bool __must_check try_grab_page(struct page *page, unsigned int flags);
-struct page *try_grab_compound_head(struct page *page, int refs,
-				    unsigned int flags);
-
 
 static inline __must_check bool try_get_page(struct page *page)
 {
diff --git a/mm/gup.c b/mm/gup.c
index 04a370b1580e..00227b2cb1cf 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -133,7 +133,7 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
 	return NULL;
 }
 
-struct page *try_grab_compound_head(struct page *page,
+static inline struct page *try_grab_compound_head(struct page *page,
 		int refs, unsigned int flags)
 {
 	return &try_grab_folio(page, refs, flags)->page;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 61895cc01d09..5ce3a0d891c6 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6072,7 +6072,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 
 		if (pages) {
 			/*
-			 * try_grab_compound_head() should always succeed here,
+			 * try_grab_folio() should always succeed here,
 			 * because: a) we hold the ptl lock, and b) we've just
 			 * checked that the huge page is present in the page
 			 * tables. If the huge page is present, then the tail
@@ -6081,9 +6081,8 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			 * any way. So this page must be available at this
 			 * point, unless the page refcount overflowed:
 			 */
-			if (WARN_ON_ONCE(!try_grab_compound_head(pages[i],
-								 refs,
-								 flags))) {
+			if (WARN_ON_ONCE(!try_grab_folio(pages[i], refs,
+							 flags))) {
 				spin_unlock(ptl);
 				remainder = 0;
 				err = -ENOMEM;
-- 
2.34.1

