Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3D4C488F3D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 05:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238669AbiAJEY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 23:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238493AbiAJEYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 23:24:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E97C061759
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 20:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=gfxLedy5iy4I1tA8ZKlC8DvCnDAEDbxXKKrSeENY8cY=; b=JYCKGH1t+KQP7QX9HjamnWk5W2
        mF/7x01TlcS93WH/d+/4Muv2r6t8WSpkVek6GeJL4C4uinGkDtDqksIAv98QraviByTXyG1hUmFcC
        o9Ah5t5TYuDzWB0c7fPsRId9euRKMDY6m29n97X+/Kfxm8Ubq1iYjHPa4LvvPx2ezmlzSKWhe2tfF
        wSdnBxdJqdbIBrJhavYNKpwOkVpafajUtsBR68f9Q7FE8GIGJgvjSrSSfFte8Nx/OOGDb1ZuuyAIv
        YqudSeZxTK7Z0UjRKtKUnhH0/BNlPrA0Kndwv0mV85kAjM4UkjSa3al2haF7Z15986OEdpXKtGmXA
        mMZp5low==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6mE9-0025x0-8q; Mon, 10 Jan 2022 04:24:13 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH v2 18/28] hugetlb: Use try_grab_folio() instead of try_grab_compound_head()
Date:   Mon, 10 Jan 2022 04:23:56 +0000
Message-Id: <20220110042406.499429-19-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220110042406.499429-1-willy@infradead.org>
References: <20220110042406.499429-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

follow_hugetlb_page() only cares about success or failure, so it doesn't
need to know the type of the returned pointer, only whether it's NULL
or not.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h | 3 ---
 mm/gup.c           | 2 +-
 mm/hugetlb.c       | 7 +++----
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index b249156f7cf1..c103c6401ecd 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1195,9 +1195,6 @@ static inline void get_page(struct page *page)
 }
 
 bool __must_check try_grab_page(struct page *page, unsigned int flags);
-struct page *try_grab_compound_head(struct page *page, int refs,
-				    unsigned int flags);
-
 
 static inline __must_check bool try_get_page(struct page *page)
 {
diff --git a/mm/gup.c b/mm/gup.c
index 719252fa0402..20703de2f107 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -146,7 +146,7 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
 	return NULL;
 }
 
-struct page *try_grab_compound_head(struct page *page,
+static inline struct page *try_grab_compound_head(struct page *page,
 		int refs, unsigned int flags)
 {
 	return &try_grab_folio(page, refs, flags)->page;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index abcd1785c629..ab67b13c4a71 100644
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
2.33.0

