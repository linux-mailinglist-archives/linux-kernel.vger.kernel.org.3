Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6655F4659B0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 00:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245754AbhLAXVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 18:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244913AbhLAXVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 18:21:36 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97465C061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 15:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=vqhS0MxjHa7zDztzVECBYpbamPlzuJiCatylnQYjPSU=; b=OnSlE2BEqB02YzZY+TLzBhC/14
        4oIiN3UTavcfthBa+g5yJ/DzBsWdRLYXdoqwBxRLzsWO4lc1jwPQr5x+bUG8FAc7+I+bSmwLVvYoq
        KaQPn+fDVIYbpbr6UWqePzWVGRfLidr+fJ0Iev1sdcl8Od0/7oVyyqmvzu99WZ9DfD4wsOb5QIqir
        HKNcoJA1FTIdcd68Dpo7amgxWCFaC6P+v/N+rAPIocKVtGSXiCpipwRud0v4xDnHdON1UN8bFa4Lm
        4zLIIQTJ8fq4+bQ8wS2k41RhhtGlGXcKC5/ynX9XVYllD+Wz6kS0ApzLF/as7Z/127D5Fpjw3SbNW
        lRwcKNxQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1msYrS-001PG4-CE; Wed, 01 Dec 2021 23:18:02 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [5.4 PATCH] mm/gup: Do not force a COW break on file-backed memory
Date:   Wed,  1 Dec 2021 23:17:57 +0000
Message-Id: <20211201231757.332199-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 17839856fd58 ("gup: document and work around "COW can break either
way" issue") forces a COW break, even for read-only GUP.  This interacts
badly with CONFIG_READ_ONLY_THP_FOR_FS as it tries to write to a read-only
PMD and follow_trans_huge_pmd() returns NULL which induces an endless
loop as __get_user_pages() interprets that as page-not-present, tries
to fault it in and retries the follow_page_mask().

The issues fixed by 17839856fd58 don't apply to files.  We know which way
the COW breaks; the page cache keeps the original and any modifications
are private to that process.  There's no optimisation that allows a
process to reuse a file-backed MAP_PRIVATE page.  So we can skip the
breaking of the COW for file-backed mappings.

This problem only exists in v5.4.y; other stable kernels either predate
CONFIG_READ_ONLY_THP_FOR_FS or they include commit a308c71bf1e6 ("mm/gup:
Remove enfornced COW mechanism").

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/gup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index 3ef769529548..d55e02411010 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -176,7 +176,8 @@ static inline bool can_follow_write_pte(pte_t pte, unsigned int flags)
  */
 static inline bool should_force_cow_break(struct vm_area_struct *vma, unsigned int flags)
 {
-	return is_cow_mapping(vma->vm_flags) && (flags & FOLL_GET);
+	return is_cow_mapping(vma->vm_flags) && vma_is_anonymous(vma) &&
+		(flags & FOLL_GET);
 }
 
 static struct page *follow_page_pte(struct vm_area_struct *vma,
-- 
2.33.0

