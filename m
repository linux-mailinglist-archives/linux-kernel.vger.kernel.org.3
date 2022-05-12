Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A353D524E44
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 15:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354417AbiELN2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 09:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354384AbiELN20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 09:28:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158395FF1B;
        Thu, 12 May 2022 06:28:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 993EA60F47;
        Thu, 12 May 2022 13:28:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7451DC34114;
        Thu, 12 May 2022 13:28:22 +0000 (UTC)
Date:   Thu, 12 May 2022 14:28:18 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mm tree
Message-ID: <Yn0LctZl8dTsezFu@arm.com>
References: <20220512193855.4f6ce32f@canb.auug.org.au>
 <YnzqffV7STYS24Yn@arm.com>
 <188f7cb2-ba21-a53a-828d-7242b17b0c72@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <188f7cb2-ba21-a53a-828d-7242b17b0c72@linux.alibaba.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 07:13:18PM +0800, Baolin Wang wrote:
> On 5/12/2022 7:07 PM, Catalin Marinas wrote:
> > On Thu, May 12, 2022 at 07:38:55PM +1000, Stephen Rothwell wrote:
> > > After merging the mm tree, today's linux-next build (arm64 defconfig)
> > > failed like this:
> > > 
> > > arch/arm64/mm/hugetlbpage.c: In function 'huge_ptep_clear_flush':
> > > arch/arm64/mm/hugetlbpage.c:493:16: error: implicit declaration of function 'get_clear_flush'; did you mean 'ptep_clear_flush'? [-Werror=implicit-function-declaration]
> > >    493 |         return get_clear_flush(vma->vm_mm, addr, ptep, pgsize, ncontig);
> > >        |                ^~~~~~~~~~~~~~~
> > >        |                ptep_clear_flush
> > > arch/arm64/mm/hugetlbpage.c:493:16: error: incompatible types when returning type 'int' but 'pte_t' was expected
> > >    493 |         return get_clear_flush(vma->vm_mm, addr, ptep, pgsize, ncontig);
> > >        |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > arch/arm64/mm/hugetlbpage.c:494:1: error: control reaches end of non-void function [-Werror=return-type]
> > >    494 | }
> > >        | ^
> > > 
> > > Caused by commit
> > > 
> > >    00df1f1a133b ("mm: change huge_ptep_clear_flush() to return the original pte")
> > > 
> > > interacting with commit
> > > 
> > >    fb396bb459c1 ("arm64/hugetlb: Drop TLB flush from get_clear_flush()")
> > > 
> > > I have applied the following merg fix patch for today.
> > > 
> > > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > > Date: Thu, 12 May 2022 19:33:11 +1000
> > > Subject: [PATCH] fixup for "mm: change huge_ptep_clear_flush() to return the original pte"
> > > 
> > > It interacts with commit
> > > 
> > >    fb396bb459c1 ("arm64/hugetlb: Drop TLB flush from get_clear_flush()")
> > > 
> > > from the arm64 tree
> > > 
> > > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > ---
> > >   arch/arm64/mm/hugetlbpage.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> > > index 5bdf913dedc7..30f5b76aabe9 100644
> > > --- a/arch/arm64/mm/hugetlbpage.c
> > > +++ b/arch/arm64/mm/hugetlbpage.c
> > > @@ -490,7 +490,7 @@ pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
> > >   		return ptep_clear_flush(vma, addr, ptep);
> > >   	ncontig = find_num_contig(vma->vm_mm, addr, ptep, &pgsize);
> > > -	return get_clear_flush(vma->vm_mm, addr, ptep, pgsize, ncontig);
> > > +	return get_clear_contig(vma->vm_mm, addr, ptep, pgsize, ncontig);
> > >   }
> > 
> > Note that after the arm64 commit, get_clear_contig() no longer flushes
> > the TLB. So maybe something like:
> > 
> > diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> > index 30f5b76aabe9..9a999550df8e 100644
> > --- a/arch/arm64/mm/hugetlbpage.c
> > +++ b/arch/arm64/mm/hugetlbpage.c
> > @@ -485,12 +485,15 @@ pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
> >   {
> >   	size_t pgsize;
> >   	int ncontig;
> > +	pte_t orig_pte;
> > 
> >   	if (!pte_cont(READ_ONCE(*ptep)))
> >   		return ptep_clear_flush(vma, addr, ptep);
> > 
> >   	ncontig = find_num_contig(vma->vm_mm, addr, ptep, &pgsize);
> > -	return get_clear_contig(vma->vm_mm, addr, ptep, pgsize, ncontig);
> > +	orig_pte = get_clear_contig(vma->vm_mm, addr, ptep, pgsize, ncontig);
> > +	flush_tlb_range(vma, addr, addr + pgsize * ncontig);
> > +	return orig_pte;
> >   }
> 
> Yes, after checking this fb396bb459c1 ("arm64/hugetlb: Drop TLB flush from
> get_clear_flush()"), I also realized it will miss TLB flush.
> 
> So I am not sure I need send a incremental patch to fix this issue? Or
> resend my patch set [1] with rebasing on the arm64 changes?
> 
> Catalin and Andrew, how do you think? Thanks.

Andrew folding the diff in is fine by me. I presume the mm patches are
applied on top of the rest of linux-next (and the arm64 commits).

-- 
Catalin
