Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315C34AB27E
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 22:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245086AbiBFVxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 16:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiBFVxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 16:53:32 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED2DC06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 13:53:31 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id b22so9516164qkk.12
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 13:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=bdXbpcKd8bEpr3aPHqwTqDw7DbzB6IrHpbHDEXtmJrw=;
        b=SSBt8V2HSh34Girfg/qRDib2a6l28XQfIOv+1FwHWDYLnbIW+mrcUblEZRmSPvGUn0
         fCQ9zCPszNmDVU1f8BaVa59Jzn1oLAq58HZ1NawQKvm4eK1d3jRD+2+1hXsGZ9PwwwSl
         0EO8THwHWzQV1T7LrNAsxs95QIJ09uLPaqpDpr0vY5dLn5irvr0mAACfhpzBEaph90dr
         VliUcdUUV7B3Ubanq+58R0QiHWXXbRO5v8X1DVN2bxYbYFTvL9REJYU70wnwg5WiQhWS
         QCk3xC9r+0dC3wbbs3vC3QjdzONZKXWJhiOZc+7zGTJ3aI5M+hvLEWtBBGXZARGj7dpi
         IzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=bdXbpcKd8bEpr3aPHqwTqDw7DbzB6IrHpbHDEXtmJrw=;
        b=YtjFOA7ZrVHevie/ArbUBjABKHuX8Ub0+8uDX+S8OTXApRZaqyKpDkCoIJbn5uA+or
         kEiVv63/7zZvEv8CdPzhC2I7Sz4OgxhjlxPhSE4Ri65fYnirnSmzTvQaOto+us/dWSBy
         srIlZH//QpArgjg9EQC6hcuaruu7FLMYOwLtAq2rZGKvI1ECgB1U1emPRQbeOwWsfeS6
         aVK9KrtgOJWkUx4IhrumJ+Og6Hckl7BND0VMXSj1azoR75ALaJEaDQaQmPGboaPDPW3b
         4abK8fnqFuvjdplvqmlTPJJrECiCU1k1noRp8Avidzm8tHdt9JBufwx7MEwmsZ2gr29G
         /34A==
X-Gm-Message-State: AOAM533f9eFXuuZPAmzpJfVBzeVl4Ng4/jR1oBsmE08SyPQYwytcuCjJ
        8patAWp3NHeUwu2JimWW4szOzA==
X-Google-Smtp-Source: ABdhPJzzaieljHjokCWJbqDmawWg6ydRcuFm5aJOT+tVvJVkNAlmiHFuPDAXww/MHC8XmIiVtnku2w==
X-Received: by 2002:ae9:c10e:: with SMTP id z14mr5029635qki.538.1644184410482;
        Sun, 06 Feb 2022 13:53:30 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id k4sm4771078qta.6.2022.02.06.13.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 13:53:30 -0800 (PST)
Date:   Sun, 6 Feb 2022 13:53:27 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 13/13] mm/thp: shrink_page_list() avoid splitting VM_LOCKED
 THP
In-Reply-To: <8e4356d-9622-a7f0-b2c-f116b5f2efea@google.com>
Message-ID: <6df82db0-0e6-ef83-6925-4fa3f834133d@google.com>
References: <8e4356d-9622-a7f0-b2c-f116b5f2efea@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.8 commit 7751b2da6be0 ("vmscan: split file huge pages before paging
them out") inserted a split_huge_page_to_list() into shrink_page_list()
without considering the mlock case: no problem if the page has already
been marked as Mlocked (the !page_evictable check much higher up will
have skipped all this), but it has always been the case that races or
omissions in setting Mlocked can rely on page reclaim to detect this
and correct it before actually reclaiming - and that remains so, but
what a shame if a hugepage is needlessly split before discovering it.

It is surprising that page_check_references() returns PAGEREF_RECLAIM
when VM_LOCKED, but there was a good reason for that: try_to_unmap_one()
is where the condition is detected and corrected; and until now it could
not be done in page_referenced_one(), because that does not always have
the page locked.  Now that mlock's requirement for page lock has gone,
copy try_to_unmap_one()'s mlock restoration into page_referenced_one(),
and let page_check_references() return PAGEREF_ACTIVATE in this case.

But page_referenced_one() may find a pte mapping one part of a hugepage:
what hold should a pte mapped in a VM_LOCKED area exert over the entire
huge page?  That's debatable.  The approach taken here is to treat that
pte mapping in page_referenced_one() as if not VM_LOCKED, and if no
VM_LOCKED pmd mapping is found later in the walk, and lack of reference
permits, then PAGEREF_RECLAIM take it to attempted splitting as before.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/rmap.c   | 7 +++++--
 mm/vmscan.c | 6 +++---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 714bfdc72c7b..c7921c102bc0 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -812,7 +812,10 @@ static bool page_referenced_one(struct page *page, struct vm_area_struct *vma,
 	while (page_vma_mapped_walk(&pvmw)) {
 		address = pvmw.address;
 
-		if (vma->vm_flags & VM_LOCKED) {
+		if ((vma->vm_flags & VM_LOCKED) &&
+		    (!PageTransCompound(page) || !pvmw.pte)) {
+			/* Restore the mlock which got missed */
+			mlock_vma_page(page, vma, !pvmw.pte);
 			page_vma_mapped_walk_done(&pvmw);
 			pra->vm_flags |= VM_LOCKED;
 			return false; /* To break the loop */
@@ -851,7 +854,7 @@ static bool page_referenced_one(struct page *page, struct vm_area_struct *vma,
 
 	if (referenced) {
 		pra->referenced++;
-		pra->vm_flags |= vma->vm_flags;
+		pra->vm_flags |= vma->vm_flags & ~VM_LOCKED;
 	}
 
 	if (!pra->mapcount)
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 090bfb605ecf..a160efba3c73 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1386,11 +1386,11 @@ static enum page_references page_check_references(struct page *page,
 	referenced_page = TestClearPageReferenced(page);
 
 	/*
-	 * Mlock lost the isolation race with us.  Let try_to_unmap()
-	 * move the page to the unevictable list.
+	 * The supposedly reclaimable page was found to be in a VM_LOCKED vma.
+	 * Let the page, now marked Mlocked, be moved to the unevictable list.
 	 */
 	if (vm_flags & VM_LOCKED)
-		return PAGEREF_RECLAIM;
+		return PAGEREF_ACTIVATE;
 
 	if (referenced_ptes) {
 		/*
-- 
2.34.1

