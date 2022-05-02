Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B88516EC5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 13:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384708AbiEBLXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 07:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbiEBLXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 07:23:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6193BDF83;
        Mon,  2 May 2022 04:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DLbJQdcGrIYcdm+8eTzaKhsmKSH6TuaJtWYlI2Cqnfs=; b=szzNpkA0tJ5cZI3xlW/BrjYYrS
        ZPPx987er5WtGJu0cso3tUYBqOevT9Sov98zLEAYaJfgRKJFJ47o2dIe++qGNjkWxQX1mgIVCtsie
        opE/vQ4wqigz+3cpV9Yw+obhfQUReycLvJt5NjEv9fXR0NuLd2VpRvhoM0llVkb49qxadYvITyYgt
        K6KUOWoqNB6FMSt1nB3w7LSH2bvZjF+AthjyZqvTEklIY5jCPHkOHMxWwVKZO0QUu1TXj3fRF+ofP
        +emgFljLsjZOrRykhI5O2pb3MQsMicAvbV9BWu9SBUDXCvh74d8RUg4aPzLRArWJCtZyj3zXI8ujp
        o6ieN3AA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlU5Y-00ElXe-Bx; Mon, 02 May 2022 11:19:36 +0000
Date:   Mon, 2 May 2022 12:19:36 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mm tree
Message-ID: <Ym++SI1ftbRg+9zK@casper.infradead.org>
References: <20220502204903.64e94442@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502204903.64e94442@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 08:49:03PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the mm tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
[... i wish our BUILD_BUGs produced nicer output from the compiler ...]
> Reverting the following commits makes the problem go away:
> 
>   2b58b3f33ba2 ("mm/shmem: convert shmem_swapin_page() to shmem_swapin_folio()")
>   94cdf3e8c0bf ("mm/shmem: convert shmem_getpage_gfp to use a folio")
>   3674fd6cadf5 ("mm/shmem: convert shmem_alloc_and_acct_page to use a folio")
>   b0bb08b2d5f3 ("mm/shmem: turn shmem_alloc_page() into shmem_alloc_folio()")
>   8d657a77c6fe ("mm/shmem: turn shmem_should_replace_page into shmem_should_replace_folio")
>   9a44f3462edc ("mm/shmem: convert shmem_add_to_page_cache to take a folio")
>   561fd8bee1dc ("mm/swap: add folio_throttle_swaprate")
>   cb4e56ee240d ("mm/shmem: use a folio in shmem_unused_huge_shrink")
>   22bf1b68e572 ("vmscan: remove remaining uses of page in shrink_page_list")
>   7d15d41b7c4a ("vmscan: convert the activate_locked portion of shrink_page_list to folios")
>   8a6aff9c51c7 ("vmscan: move initialisation of mapping down")
>   b79338b3d217 ("vmscan: convert lazy freeing to folios")
>   719426e40146 ("vmscan: convert page buffer handling to use folios")
>   339ba7502e13 ("vmscan: convert dirty page handling to folios")

Oops.  allnoconfig on x86 reproduces the problem.  This fixes it;
happy to go back and produce a new set of patches for Andrew to
preserve bisectability.

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 2999190adc22..e9e0d591061d 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -347,7 +347,6 @@ static inline void prep_transhuge_page(struct page *page) {}
 static inline bool
 can_split_folio(struct folio *folio, int *pextra_pins)
 {
-	BUILD_BUG();
 	return false;
 }
 static inline int
diff --git a/mm/shmem.c b/mm/shmem.c
index 673a0e783496..d62936ffe74d 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -738,7 +738,7 @@ static int shmem_add_to_page_cache(struct folio *folio,
 		xas_store(&xas, folio);
 		if (xas_error(&xas))
 			goto unlock;
-		if (folio_test_large(folio)) {
+		if (folio_test_pmd_mappable(folio)) {
 			count_vm_event(THP_FILE_ALLOC);
 			__lruvec_stat_mod_folio(folio, NR_SHMEM_THPS, nr);
 		}
@@ -1887,10 +1887,7 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 		goto unlock;
 	}
 
-	if (folio_test_large(folio))
-		hindex = round_down(index, HPAGE_PMD_NR);
-	else
-		hindex = index;
+	hindex = round_down(index, folio_nr_pages(folio));
 
 	if (sgp == SGP_WRITE)
 		__folio_set_referenced(folio);
@@ -1909,7 +1906,7 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 	spin_unlock_irq(&info->lock);
 	alloced = true;
 
-	if (folio_test_large(folio) &&
+	if (folio_test_pmd_mappable(folio) &&
 	    DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE) <
 			hindex + HPAGE_PMD_NR - 1) {
 		/*

