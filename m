Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7993D56BAE6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 15:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238193AbiGHNdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 09:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237622AbiGHNc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 09:32:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B95932EC1
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 06:32:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 458D9B824C0
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 13:32:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14690C341C0;
        Fri,  8 Jul 2022 13:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657287175;
        bh=Ql4CWUsQY3uyAyViakp7n8C9XLj6sQivCxWpOs75cSs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DhHMPYrsbk0PaeLfqUeyAs6Lg8qKaDVciIXIqWuirB+/lV8kZwHlrxqFmFcRpp2hd
         0OW+x9xDjlAbXhB4Clx+jFvyfoykLrLYvIKohLUNsD+BnXPyB28vk3Pm03nhud5URG
         M0Xbj4lAKo/y8Uo7D0uLHiHYosb6+V7+Cfb2bGmy4oRGPf0ZS7uT0vFinFgq71jYhV
         8jiWW9VmH32nwkPJFcLGZj7cEOWZR/Y9uzh0kJmGNKD+W6BzZIy0nb20kT3vBbeDbs
         OCxSBz3OFLI3UH9hunh+UeUDkqRBsht9fJhpAZUMfFjHRALcmVJqk2eNowy6Fcsaz7
         uKFT0IWGzyM7A==
Date:   Fri, 8 Jul 2022 14:32:49 +0100
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guo Ren <guoren@kernel.org>, David Miller <davem@davemloft.net>
Subject: Re: [PATCH 3/4] mmu_gather: Let there be one tlb_{start,end}_vma()
 implementation
Message-ID: <20220708133248.GD5989@willie-the-truck>
References: <20220708071802.751003711@infradead.org>
 <20220708071834.084532973@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708071834.084532973@infradead.org>
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

On Fri, Jul 08, 2022 at 09:18:05AM +0200, Peter Zijlstra wrote:
> Now that architectures are no longer allowed to override
> tlb_{start,end}_vma() re-arrange code so that there is only one
> implementation for each of these functions.
> 
> This much simplifies trying to figure out what they actually do.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/asm-generic/tlb.h |   15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
> 
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -346,8 +346,8 @@ static inline void __tlb_reset_range(str
>  
>  #ifdef CONFIG_MMU_GATHER_NO_RANGE
>  
> -#if defined(tlb_flush) || defined(tlb_start_vma) || defined(tlb_end_vma)
> -#error MMU_GATHER_NO_RANGE relies on default tlb_flush(), tlb_start_vma() and tlb_end_vma()
> +#if defined(tlb_flush)
> +#error MMU_GATHER_NO_RANGE relies on default tlb_flush()
>  #endif
>  
>  /*
> @@ -367,17 +367,10 @@ static inline void tlb_flush(struct mmu_
>  static inline void
>  tlb_update_vma_flags(struct mmu_gather *tlb, struct vm_area_struct *vma) { }
>  
> -#define tlb_end_vma tlb_end_vma
> -static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vma) { }
> -
>  #else /* CONFIG_MMU_GATHER_NO_RANGE */
>  
>  #ifndef tlb_flush
>  
> -#if defined(tlb_start_vma) || defined(tlb_end_vma)
> -#error Default tlb_flush() relies on default tlb_start_vma() and tlb_end_vma()
> -#endif
> -
>  /*
>   * When an architecture does not provide its own tlb_flush() implementation
>   * but does have a reasonably efficient flush_vma_range() implementation
> @@ -498,7 +491,6 @@ static inline unsigned long tlb_get_unma
>   * case where we're doing a full MM flush.  When we're doing a munmap,
>   * the vmas are adjusted to only cover the region to be torn down.
>   */
> -#ifndef tlb_start_vma
>  static inline void tlb_start_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
>  {
>  	if (tlb->fullmm)
> @@ -509,9 +501,7 @@ static inline void tlb_start_vma(struct
>  	flush_cache_range(vma, vma->vm_start, vma->vm_end);
>  #endif
>  }
> -#endif
>  
> -#ifndef tlb_end_vma
>  static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
>  {
>  	if (tlb->fullmm || IS_ENABLED(CONFIG_MMU_GATHER_MERGE_VMAS))
> @@ -525,7 +515,6 @@ static inline void tlb_end_vma(struct mm
>  	 */
>  	tlb_flush_mmu_tlbonly(tlb);
>  }
> -#endif

Much nicer:

Acked-by: Will Deacon <will@kernel.org>

Will
