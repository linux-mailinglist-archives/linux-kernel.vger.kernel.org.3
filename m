Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017DF545125
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344617AbiFIPov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344616AbiFIPos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:44:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E76E12F370
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 08:44:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81596B82E53
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 15:44:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A0CC34114;
        Thu,  9 Jun 2022 15:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654789484;
        bh=X32KAVJGD/FwLau5Ef5i2Ezt7M4IokoLndTY3ECDt7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GciSWBOzy3fCiZevlR74T0Zp5Pe3pQp/56aaAN5ZTdbtF8BxCYv37C3foVv4SfjdC
         Bh48K/4IE55rmBxz1Xf1DnaHAPnVlKIUry/9mbiY0+/3qnKS+U915CxDBL/aABi9Y6
         xmOnIRtW07+CgS72vEicSxNXBuVyi1w6rZzgU7GdWZdCbMM5uJXZaUsAHS7n3Uzco5
         Ch+i7qIn44isV8kq/rCQkivL5BYUNl/43wDkHFq9IVpJ5TDcBYtfFX7OUz42UVZDpj
         F288nHIkx2pZc2xUNnDspU5STO2RwjRi8VVrQIADqOsPtPrdcdMGLBw0LGwYDtk1dx
         vG4QIfW+jQ/ew==
Date:   Thu, 9 Jun 2022 16:44:38 +0100
From:   Will Deacon <will@kernel.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     catalin.marinas@arm.com, mike.kravetz@oracle.com,
        songmuchun@bytedance.com, anshuman.khandual@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] arm64/hugetlb: Simplify the huge_ptep_set_access_flags()
Message-ID: <20220609154438.GA3444@willie-the-truck>
References: <d81f1c3215000d0f238900dbfa0a0976d8d00cd3.1653470369.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d81f1c3215000d0f238900dbfa0a0976d8d00cd3.1653470369.git.baolin.wang@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 06:31:09PM +0800, Baolin Wang wrote:
> After commit bc5dfb4fd7bd ("arm64/hugetlb: Implement arm64 specific
> huge_ptep_get()"), the arm64 specific huge_ptep_get() will always
> consider the subpages' dirty and young state for CONT-PTE/PMD hugetlb,
> so there is no need to check them again when setting the access flags
> for CONT-PTE/PMD hugetlb in huge_ptep_set_access_flags().
> 
> Meanwhile this also fixes an issue when users want to make the CONT-PTE/PMD
> hugetlb's pte entry old, which will be failed to make the pte entry old
> since the original code will always consider the subpages' young state
> if the subpages' young state is set. For example, we will make the
> CONT-PTE/PMD hugetlb pte entry old in DAMON to monitoring the accesses,
> but we'll failed to monitoring the actual accesses of the CONT-PTE/PMD
> hugetlb page, due to we can not make its pte old.
> 
> Thus remove the code considering the subpages' dirty and young state in
> huge_ptep_set_access_flags() to fix this issue and simplify the function.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  arch/arm64/mm/hugetlbpage.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index e2a5ec9..5c703aa 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -448,7 +448,6 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>  	size_t pgsize = 0;
>  	unsigned long pfn = pte_pfn(pte), dpfn;
>  	pgprot_t hugeprot;
> -	pte_t orig_pte;
>  
>  	if (!pte_cont(pte))
>  		return ptep_set_access_flags(vma, addr, ptep, pte, dirty);
> @@ -459,14 +458,7 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>  	if (!__cont_access_flags_changed(ptep, pte, ncontig))
>  		return 0;
>  
> -	orig_pte = get_clear_contig(vma->vm_mm, addr, ptep, pgsize, ncontig);
> -
> -	/* Make sure we don't lose the dirty or young state */
> -	if (pte_dirty(orig_pte))
> -		pte = pte_mkdirty(pte);
> -
> -	if (pte_young(orig_pte))
> -		pte = pte_mkyoung(pte);
> +	clear_flush(vma->vm_mm, addr, ptep, pgsize, ncontig);

I don't understand what this clear_flush() call is doing here; notably, it
includes TLB invalidation which we don't have for the non-cont case.

Why isn't huge_ptep_set_access_flags() just a loop around
ptep_set_access_flags() if huge_ptep_get() is taking care of collapsing the
dirty/young state?

Will
