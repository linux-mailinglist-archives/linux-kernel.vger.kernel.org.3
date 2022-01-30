Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A354A330E
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 02:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353586AbiA3Bax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 20:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238167AbiA3Bav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 20:30:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAF1C061714
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 17:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=sNo+q8NP0g/grRrgvaQU0GQNcAFAxbTtuvdhfsfCaOo=; b=Ixgofnqh7NphtJFc6w+tKbAawE
        HIqukir/pirZwWe/M9f/Ovzyy2mlYlw9/5vCsQkP1pOFC8ctVhRembbgaD4D4XbBQdxOxcDv7PZHq
        d/R8J/UOxj06DjP1EUsWr+s3ckzSyvP9PJj8IfKh7lrr49rupS6hDxEUnky3vLfMVraSm83A+QFeZ
        mmnRrEWuwBk3g3EJaATT9UZXc/mZxqE71HvL6f3jsNeL4y0wM2DpDBS/qF/MRjvnV3iYgGkU9G/nl
        1TAnmj9wSSG2cp95VduIacm6PQ3Ex5jnlFp3rXfMpqJodJIXmOmV4I8RtlbrR1R1nm/qN+hNGky6e
        rv03D58Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nDz3E-0080Ep-Oe; Sun, 30 Jan 2022 01:30:44 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH] mm/hwpoison: Check the subpage, not the head page
Date:   Sun, 30 Jan 2022 01:30:42 +0000
Message-Id: <20220130013042.1906881-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware poison is tracked on a per-page basis, not on the head page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/rmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 6a1e8c7f6213..09b08888120e 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1553,7 +1553,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 		/* Update high watermark before we lower rss */
 		update_hiwater_rss(mm);
 
-		if (PageHWPoison(page) && !(flags & TTU_IGNORE_HWPOISON)) {
+		if (PageHWPoison(subpage) && !(flags & TTU_IGNORE_HWPOISON)) {
 			pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
 			if (PageHuge(page)) {
 				hugetlb_count_sub(compound_nr(page), mm);
@@ -1873,7 +1873,7 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
 			 * memory are supported.
 			 */
 			subpage = page;
-		} else if (PageHWPoison(page)) {
+		} else if (PageHWPoison(subpage)) {
 			pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
 			if (PageHuge(page)) {
 				hugetlb_count_sub(compound_nr(page), mm);
-- 
2.34.1

