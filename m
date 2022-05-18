Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1BF752AEF3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 02:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbiERAFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 20:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbiERAFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 20:05:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B1B4F9D6
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 17:05:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B210E6144A
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 00:05:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9DD7C385B8;
        Wed, 18 May 2022 00:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652832303;
        bh=002uA/OhCvgSuCBXwvu+tXYkgZTTOLcnGkvUEQBf7LI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AutC+nYSX1aPAKJulnJ4OmrJOn8VnWdcmA+sOROdyQgX/TybUILLrdH3kxIaGCHX5
         Ak+dBVPuBTzcWumqSUQgIsKtQt+6p2NaOD2ar62iQN9xTsjSdtgjyYar6UR9z1ps8T
         PTr1NHeSSdrRzbHwWFKHRW6bvGb0b2xzsjS/jWeA=
Date:   Tue, 17 May 2022 17:05:02 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     willy@infradead.org, songmuchun@bytedance.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] mm: pvmw: check possible huge PMD map by
 transhuge_vma_suitable()
Message-Id: <20220517170502.cf4433f5cd1e69f27305cf19@linux-foundation.org>
In-Reply-To: <20220513191705.457775-1-shy828301@gmail.com>
References: <20220513191705.457775-1-shy828301@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 May 2022 12:17:05 -0700 Yang Shi <shy828301@gmail.com> wrote:

> IIUC PVMW checks if the vma is possibly huge PMD mapped by
> transparent_hugepage_active() and "pvmw->nr_pages >= HPAGE_PMD_NR".
> 
> Actually pvmw->nr_pages is returned by compound_nr() or
> folio_nr_pages(), so the page should be THP as long as "pvmw->nr_pages
> >= HPAGE_PMD_NR".  And it is guaranteed THP is allocated for valid VMA
> in the first place.  But it may be not PMD mapped if the VMA is file
> VMA and it is not properly aligned.  The transhuge_vma_suitable()
> is used to do such check, so replace transparent_hugepage_active() to
> it, which is too heavy and overkilling.

I messed with the changelog a bit.  The function is called
page_vma_mapped_walk(), so let's call it that.

This patch has been in the trees since May 12, which isn't terribly
long.  Does anyone feel up to a reviewed-by?

Thanks.

From: Yang Shi <shy828301@gmail.com>
Subject: mm/page_vma_mapped.c: check possible huge PMD map with transhuge_vma_suitable()
Date: Fri, 13 May 2022 12:17:05 -0700

IIUC page_vma_mapped_walk() checks if the vma is possibly huge PMD mapped
with transparent_hugepage_active() and "pvmw->nr_pages >= HPAGE_PMD_NR".

Actually pvmw->nr_pages is returned by compound_nr() or folio_nr_pages(),
so the page should be THP as long as "pvmw->nr_pages >= HPAGE_PMD_NR". 
And it is guaranteed THP is allocated for valid VMA in the first place. 
But it may be not PMD mapped if the VMA is file VMA and it is not properly
aligned.  The transhuge_vma_suitable() is used to do such check, so
replace transparent_hugepage_active() to it, which is too heavy and
overkilling.

Link: https://lkml.kernel.org/r/20220513191705.457775-1-shy828301@gmail.com
Signed-off-by: Yang Shi <shy828301@gmail.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/huge_mm.h |    8 ++++++--
 mm/page_vma_mapped.c    |    2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

--- a/include/linux/huge_mm.h~mm-pvmw-check-possible-huge-pmd-map-by-transhuge_vma_suitable
+++ a/include/linux/huge_mm.h
@@ -117,8 +117,10 @@ extern struct kobj_attribute shmem_enabl
 extern unsigned long transparent_hugepage_flags;
 
 static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
-		unsigned long haddr)
+		unsigned long addr)
 {
+	unsigned long haddr;
+
 	/* Don't have to check pgoff for anonymous vma */
 	if (!vma_is_anonymous(vma)) {
 		if (!IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) - vma->vm_pgoff,
@@ -126,6 +128,8 @@ static inline bool transhuge_vma_suitabl
 			return false;
 	}
 
+	haddr = addr & HPAGE_PMD_MASK;
+
 	if (haddr < vma->vm_start || haddr + HPAGE_PMD_SIZE > vma->vm_end)
 		return false;
 	return true;
@@ -342,7 +346,7 @@ static inline bool transparent_hugepage_
 }
 
 static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
-		unsigned long haddr)
+		unsigned long addr)
 {
 	return false;
 }
--- a/mm/page_vma_mapped.c~mm-pvmw-check-possible-huge-pmd-map-by-transhuge_vma_suitable
+++ a/mm/page_vma_mapped.c
@@ -243,7 +243,7 @@ restart:
 			 * cleared *pmd but not decremented compound_mapcount().
 			 */
 			if ((pvmw->flags & PVMW_SYNC) &&
-			    transparent_hugepage_active(vma) &&
+			    transhuge_vma_suitable(vma, pvmw->address) &&
 			    (pvmw->nr_pages >= HPAGE_PMD_NR)) {
 				spinlock_t *ptl = pmd_lock(mm, pvmw->pmd);
 
_

