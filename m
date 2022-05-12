Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B32A524AF3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 13:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352930AbiELLH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 07:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240084AbiELLHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 07:07:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262CB52E63;
        Thu, 12 May 2022 04:07:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA76BB82792;
        Thu, 12 May 2022 11:07:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07451C385B8;
        Thu, 12 May 2022 11:07:44 +0000 (UTC)
Date:   Thu, 12 May 2022 12:07:41 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mm tree
Message-ID: <YnzqffV7STYS24Yn@arm.com>
References: <20220512193855.4f6ce32f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512193855.4f6ce32f@canb.auug.org.au>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 07:38:55PM +1000, Stephen Rothwell wrote:
> After merging the mm tree, today's linux-next build (arm64 defconfig)
> failed like this:
> 
> arch/arm64/mm/hugetlbpage.c: In function 'huge_ptep_clear_flush':
> arch/arm64/mm/hugetlbpage.c:493:16: error: implicit declaration of function 'get_clear_flush'; did you mean 'ptep_clear_flush'? [-Werror=implicit-function-declaration]
>   493 |         return get_clear_flush(vma->vm_mm, addr, ptep, pgsize, ncontig);
>       |                ^~~~~~~~~~~~~~~
>       |                ptep_clear_flush
> arch/arm64/mm/hugetlbpage.c:493:16: error: incompatible types when returning type 'int' but 'pte_t' was expected
>   493 |         return get_clear_flush(vma->vm_mm, addr, ptep, pgsize, ncontig);
>       |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> arch/arm64/mm/hugetlbpage.c:494:1: error: control reaches end of non-void function [-Werror=return-type]
>   494 | }
>       | ^
> 
> Caused by commit
> 
>   00df1f1a133b ("mm: change huge_ptep_clear_flush() to return the original pte")
> 
> interacting with commit
> 
>   fb396bb459c1 ("arm64/hugetlb: Drop TLB flush from get_clear_flush()")
> 
> I have applied the following merg fix patch for today.
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Thu, 12 May 2022 19:33:11 +1000
> Subject: [PATCH] fixup for "mm: change huge_ptep_clear_flush() to return the original pte"
> 
> It interacts with commit
> 
>   fb396bb459c1 ("arm64/hugetlb: Drop TLB flush from get_clear_flush()")
> 
> from the arm64 tree
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  arch/arm64/mm/hugetlbpage.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index 5bdf913dedc7..30f5b76aabe9 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -490,7 +490,7 @@ pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
>  		return ptep_clear_flush(vma, addr, ptep);
>  
>  	ncontig = find_num_contig(vma->vm_mm, addr, ptep, &pgsize);
> -	return get_clear_flush(vma->vm_mm, addr, ptep, pgsize, ncontig);
> +	return get_clear_contig(vma->vm_mm, addr, ptep, pgsize, ncontig);
>  }

Note that after the arm64 commit, get_clear_contig() no longer flushes
the TLB. So maybe something like:

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 30f5b76aabe9..9a999550df8e 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -485,12 +485,15 @@ pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 {
 	size_t pgsize;
 	int ncontig;
+	pte_t orig_pte;

 	if (!pte_cont(READ_ONCE(*ptep)))
 		return ptep_clear_flush(vma, addr, ptep);

 	ncontig = find_num_contig(vma->vm_mm, addr, ptep, &pgsize);
-	return get_clear_contig(vma->vm_mm, addr, ptep, pgsize, ncontig);
+	orig_pte = get_clear_contig(vma->vm_mm, addr, ptep, pgsize, ncontig);
+	flush_tlb_range(vma, addr, addr + pgsize * ncontig);
+	return orig_pte;
 }

 static int __init hugetlbpage_init(void)

-- 
Catalin
