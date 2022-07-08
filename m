Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3789556BB0A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 15:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238231AbiGHNgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 09:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238123AbiGHNgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 09:36:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FAD15A0B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 06:36:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D84F0B827E8
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 13:36:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5914C341C6;
        Fri,  8 Jul 2022 13:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657287371;
        bh=o2KSwDFs5DfzOXVzIO7vzMubdIpBYjtEzTcmGGuDQyI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z9emsyrJrYTYbSfBVr+Ws5JU7z4eB3w2za9nZYxTI+Eul1U0YNktpPkELUusEJCts
         OFB2FU8y310puqbeI8zWMcmNqNz96CwETZ2rG6CaFctWB9UltUTMSQ4f/rvm97zCMs
         VjokYr5Ieyou51WfxzsGjpGwOtoteEaJl92G52H0hFHDetMR0e+8+6k7aOnWhm5jMr
         y4dzgmtTWZk2QPrHeZjMjuEbeWUoM3QLqcfpBq5KrnP7MDDizerTj65LBrO9J7Aopm
         dPniDSAIXpcA2kYCeHduKX+iY8hwdf++4LaWfbahVpJfJrzuj6BT6RTYHg5ZqUbQb3
         TAVEbDFS+7z5Q==
Date:   Fri, 8 Jul 2022 14:36:06 +0100
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guo Ren <guoren@kernel.org>, David Miller <davem@davemloft.net>
Subject: Re: [PATCH 4/4] mmu_gather: Force tlb-flush VM_PFNMAP vmas
Message-ID: <20220708133605.GE5989@willie-the-truck>
References: <20220708071802.751003711@infradead.org>
 <20220708071834.149930530@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708071834.149930530@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 09:18:06AM +0200, Peter Zijlstra wrote:
> Jann reported a race between munmap() and unmap_mapping_range(), where
> unmap_mapping_range() will no-op once unmap_vmas() has unlinked the
> VMA; however munmap() will not yet have invalidated the TLBs.
> 
> Therefore unmap_mapping_range() will complete while there are still
> (stale) TLB entries for the specified range.
> 
> Mitigate this by force flushing TLBs for VM_PFNMAP ranges.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/asm-generic/tlb.h |   33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
> 
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -303,6 +303,7 @@ struct mmu_gather {
>  	 */
>  	unsigned int		vma_exec : 1;
>  	unsigned int		vma_huge : 1;
> +	unsigned int		vma_pfn  : 1;
>  
>  	unsigned int		batch_count;
>  
> @@ -373,7 +374,6 @@ tlb_update_vma_flags(struct mmu_gather *
>  #else /* CONFIG_MMU_GATHER_NO_RANGE */
>  
>  #ifndef tlb_flush
> -
>  /*
>   * When an architecture does not provide its own tlb_flush() implementation
>   * but does have a reasonably efficient flush_vma_range() implementation
> @@ -393,6 +393,9 @@ static inline void tlb_flush(struct mmu_
>  		flush_tlb_range(&vma, tlb->start, tlb->end);
>  	}
>  }
> +#endif
> +
> +#endif /* CONFIG_MMU_GATHER_NO_RANGE */
>  
>  static inline void
>  tlb_update_vma_flags(struct mmu_gather *tlb, struct vm_area_struct *vma)
> @@ -410,17 +413,9 @@ tlb_update_vma_flags(struct mmu_gather *
>  	 */
>  	tlb->vma_huge = is_vm_hugetlb_page(vma);
>  	tlb->vma_exec = !!(vma->vm_flags & VM_EXEC);
> +	tlb->vma_pfn  = !!(vma->vm_flags & VM_PFNMAP);
>  }
>  
> -#else
> -
> -static inline void
> -tlb_update_vma_flags(struct mmu_gather *tlb, struct vm_area_struct *vma) { }
> -
> -#endif
> -
> -#endif /* CONFIG_MMU_GATHER_NO_RANGE */
> -
>  static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
>  {
>  	/*
> @@ -507,16 +502,22 @@ static inline void tlb_start_vma(struct
>  
>  static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
>  {
> -	if (tlb->fullmm || IS_ENABLED(CONFIG_MMU_GATHER_MERGE_VMAS))
> +	if (tlb->fullmm)
>  		return;
>  
>  	/*
> -	 * Do a TLB flush and reset the range at VMA boundaries; this avoids
> -	 * the ranges growing with the unused space between consecutive VMAs,
> -	 * but also the mmu_gather::vma_* flags from tlb_start_vma() rely on
> -	 * this.
> +	 * VM_PFNMAP is more fragile because the core mm will not track the
> +	 * page mapcount -- there might not be page-frames for these PFNs after
> +	 * all. Force flush TLBs for such ranges to avoid munmap() vs
> +	 * unmap_mapping_range() races.
>  	 */
> -	tlb_flush_mmu_tlbonly(tlb);
> +	if (tlb->vma_pfn || !IS_ENABLED(CONFIG_MMU_GATHER_MERGE_VMAS)) {
> +		/*
> +		 * Do a TLB flush and reset the range at VMA boundaries; this avoids
> +		 * the ranges growing with the unused space between consecutive VMAs.
> +		 */
> +		tlb_flush_mmu_tlbonly(tlb);
> +	}

We already have the vma here, so I'm not sure how much the new 'vma_pfn'
field really buys us over checking the 'vm_flags', but perhaps that's
cleanup for another day.

Acked-by: Will Deacon <will@kernel.org>

Will
