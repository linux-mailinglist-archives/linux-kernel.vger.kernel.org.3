Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDA156BB7C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 16:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234643AbiGHOFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 10:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbiGHOFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 10:05:18 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058A52FFC9
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 07:05:17 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id w2so9710071ljj.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 07:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aVTg2EfXoOZ9XnqujjRV0ij3i1Nj1NxQHoIMerWnwe8=;
        b=lgQvQnNGWjFCROQU/kiWQi5k0UhXTi37XTUY7d6h1QDsC/QQnOmyeMJwtf7J1ojI8q
         /q21CHdvbxLtiW0HUyUpEzIZS+2Zs/IRnNgPFasj3Jb8S2YoT//h7zUZTOj1ut074AzV
         mqE7LnYme3lOZs2fBH1HR9GoXUJBpVCDiMIDieeP8M3oMYnVLalBzooEQlSX5gVCG1/Y
         VRvaiIRXgFePqxvtQgjWm1KbtK0k/7BevtCT7H/mr1NOoxRkeeXLUkyU7FmzgSjavfIo
         chmSknvjXZB49IbDyIB8gCaYwPPkvuMKp+gm7b9Nu7FAaC/tV5ZaxjeIc2hZ5HfqUapN
         7MOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aVTg2EfXoOZ9XnqujjRV0ij3i1Nj1NxQHoIMerWnwe8=;
        b=nhO9zIIiBy+dkoovaxqpuBISsSzr52w2fZrOq/zjORTON4O0Q0gs48Hhlxad0T8aEW
         Mm4T0v6c1eablW7lOzYsU6sR709k1EPBhH8d+F/ihXymLdgtRbJsM9vIPxGuHsMXiNhK
         pwzfcc2x5dJcsCtwFw1iVAzX44xqxd1dBB+k6kDrpNqms5djte4gujO+qEgZ16DcerKZ
         EWcCXbHsAAYt+ycW9FNy12XguRdH7M/QqNTOrwB8t0h4Mt3qTXF6DIzUGp6H8q2x8iNE
         uNNtU30JHwrEZp8Rn8xcMwU/PGdn/5ogeBthuVJxhmDrFh+Q5wowpe1WWXaJVh7EiZLf
         eBWA==
X-Gm-Message-State: AJIora9Tl7yB4aBK4d4iyqsTGzjiUjCcyKMGhSDdFqP9JsaPuhgOw8Cg
        LX6ud6yVd1jeyqSSYlzfcADSaKcFvjzoIwRzOOes9mdS7+4tEA==
X-Google-Smtp-Source: AGRyM1tmGrnZQtA2Cboc1CQNgT3n9CwH9z2FbssFjlcKIQ1HIzsuu0ZixwkFtEDPNh1Z/l+47lS8iXuoc854j0libmA=
X-Received: by 2002:a2e:9f56:0:b0:25a:7381:6929 with SMTP id
 v22-20020a2e9f56000000b0025a73816929mr1995165ljk.93.1657289115126; Fri, 08
 Jul 2022 07:05:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220708071802.751003711@infradead.org> <20220708071834.149930530@infradead.org>
In-Reply-To: <20220708071834.149930530@infradead.org>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 8 Jul 2022 16:04:38 +0200
Message-ID: <CAG48ez1eFwoDYnuyqp3FSDCaEOFsQEbBzsT4pGS7Xw0eLVf+nQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] mmu_gather: Force tlb-flush VM_PFNMAP vmas
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guo Ren <guoren@kernel.org>, David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
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

On Fri, Jul 8, 2022 at 9:19 AM Peter Zijlstra <peterz@infradead.org> wrote:
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
>          */
>         unsigned int            vma_exec : 1;
>         unsigned int            vma_huge : 1;
> +       unsigned int            vma_pfn  : 1;
>
>         unsigned int            batch_count;
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
>                 flush_tlb_range(&vma, tlb->start, tlb->end);
>         }
>  }
> +#endif
> +
> +#endif /* CONFIG_MMU_GATHER_NO_RANGE */
>
>  static inline void
>  tlb_update_vma_flags(struct mmu_gather *tlb, struct vm_area_struct *vma)
> @@ -410,17 +413,9 @@ tlb_update_vma_flags(struct mmu_gather *
>          */
>         tlb->vma_huge = is_vm_hugetlb_page(vma);
>         tlb->vma_exec = !!(vma->vm_flags & VM_EXEC);
> +       tlb->vma_pfn  = !!(vma->vm_flags & VM_PFNMAP);

We should probably handle VM_MIXEDMAP the same way as VM_PFNMAP here,
I think? Conceptually I think the same issue can happen with
device-owned pages that aren't managed by the kernel's page allocator,
and for those, VM_MIXEDMAP is the same as VM_PFNMAP.

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
>         /*
> @@ -507,16 +502,22 @@ static inline void tlb_start_vma(struct
>
>  static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
>  {
> -       if (tlb->fullmm || IS_ENABLED(CONFIG_MMU_GATHER_MERGE_VMAS))
> +       if (tlb->fullmm)
>                 return;

Is this correct, or would there still be a race between MM teardown
(which sets ->fullmm, see exit_mmap()->tlb_gather_mmu_fullmm()) and
unmap_mapping_range()? My understanding is that ->fullmm only
guarantees a flush at tlb_finish_mmu(), but here we're trying to
ensure a flush before unlink_file_vma().

>         /*
> -        * Do a TLB flush and reset the range at VMA boundaries; this avoids
> -        * the ranges growing with the unused space between consecutive VMAs,
> -        * but also the mmu_gather::vma_* flags from tlb_start_vma() rely on
> -        * this.
> +        * VM_PFNMAP is more fragile because the core mm will not track the
> +        * page mapcount -- there might not be page-frames for these PFNs after
> +        * all. Force flush TLBs for such ranges to avoid munmap() vs
> +        * unmap_mapping_range() races.

Maybe add: "We do *not* guarantee that after munmap() has passed
through tlb_end_vma(), there are no more stale TLB entries for this
VMA; there could be a parallel PTE-zapping operation that has zapped
PTEs before we looked at them but hasn't done the corresponding TLB
flush yet. However, such a parallel zap can't be done through the
mm_struct (we've unlinked the VMA), so it would have to be done under
the ->i_mmap_sem in read mode, which we synchronize against in
unlink_file_vma()."

I'm not convinced it's particularly nice to do a flush in
tlb_end_vma() when we can't make guarantees about the TLB state wrt
parallel invalidations, and when we only really care about having a
flush between unmap_vmas() and free_pgtables(), but I guess it works?

>          */
> -       tlb_flush_mmu_tlbonly(tlb);
> +       if (tlb->vma_pfn || !IS_ENABLED(CONFIG_MMU_GATHER_MERGE_VMAS)) {
> +               /*
> +                * Do a TLB flush and reset the range at VMA boundaries; this avoids
> +                * the ranges growing with the unused space between consecutive VMAs.
> +                */
> +               tlb_flush_mmu_tlbonly(tlb);
> +       }
>  }
>
>  /*
>
>
