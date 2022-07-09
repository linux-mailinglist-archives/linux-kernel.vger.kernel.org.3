Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF6B56C820
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 10:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiGIIjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 04:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiGIIjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 04:39:01 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E9513DCE
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 01:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ulu52rkxTDKU/YZctiQRuz8ETdfkVDNqGiBbDOYs+DY=; b=lhxo2nNad/aAovgNggflw6ECMn
        GRURjbeFDBFrs2TwgDHJpKUap51ZjhjwX0MKuajepc/XlhKED1NqwyR+4mB/7Ba3TmF1W1jwS6rrA
        HjiSUOnrJF4e57ENYzGM5DJCjt4LGsCKRIN/BMavbBy/ZprIutKXTNKM/JQDx1b1bgHTOn13eSaY4
        +F0IO+SXG0wBuGiL78uhBD6zV/sNP3lM2aYE24O9Evxydhb4wcXrRrHh0bG5D4jKfNOtxqsXY5c0b
        pApcyGG8MsqySv9nQ0CHcIUzp9gUFLrNFoHbCiocNUymmnCNqqsLvfRhkKb8Q6oY4vcgPFeB+Cyvq
        y1OO6RDA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oA5yW-0027tS-Ve; Sat, 09 Jul 2022 08:38:24 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0538998007F; Sat,  9 Jul 2022 10:38:02 +0200 (CEST)
Date:   Sat, 9 Jul 2022 10:38:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jann Horn <jannh@google.com>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guo Ren <guoren@kernel.org>, David Miller <davem@davemloft.net>
Subject: Re: [PATCH 4/4] mmu_gather: Force tlb-flush VM_PFNMAP vmas
Message-ID: <Ysk+aUdA+3olVRtT@worktop.programming.kicks-ass.net>
References: <20220708071802.751003711@infradead.org>
 <20220708071834.149930530@infradead.org>
 <CAG48ez1eFwoDYnuyqp3FSDCaEOFsQEbBzsT4pGS7Xw0eLVf+nQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1eFwoDYnuyqp3FSDCaEOFsQEbBzsT4pGS7Xw0eLVf+nQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 04:04:38PM +0200, Jann Horn wrote:
> On Fri, Jul 8, 2022 at 9:19 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > Jann reported a race between munmap() and unmap_mapping_range(), where
> > unmap_mapping_range() will no-op once unmap_vmas() has unlinked the
> > VMA; however munmap() will not yet have invalidated the TLBs.
> >
> > Therefore unmap_mapping_range() will complete while there are still
> > (stale) TLB entries for the specified range.
> >
> > Mitigate this by force flushing TLBs for VM_PFNMAP ranges.
> >
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  include/asm-generic/tlb.h |   33 +++++++++++++++++----------------
> >  1 file changed, 17 insertions(+), 16 deletions(-)
> >
> > --- a/include/asm-generic/tlb.h
> > +++ b/include/asm-generic/tlb.h
> > @@ -303,6 +303,7 @@ struct mmu_gather {
> >          */
> >         unsigned int            vma_exec : 1;
> >         unsigned int            vma_huge : 1;
> > +       unsigned int            vma_pfn  : 1;
> >
> >         unsigned int            batch_count;
> >
> > @@ -373,7 +374,6 @@ tlb_update_vma_flags(struct mmu_gather *
> >  #else /* CONFIG_MMU_GATHER_NO_RANGE */
> >
> >  #ifndef tlb_flush
> > -
> >  /*
> >   * When an architecture does not provide its own tlb_flush() implementation
> >   * but does have a reasonably efficient flush_vma_range() implementation
> > @@ -393,6 +393,9 @@ static inline void tlb_flush(struct mmu_
> >                 flush_tlb_range(&vma, tlb->start, tlb->end);
> >         }
> >  }
> > +#endif
> > +
> > +#endif /* CONFIG_MMU_GATHER_NO_RANGE */
> >
> >  static inline void
> >  tlb_update_vma_flags(struct mmu_gather *tlb, struct vm_area_struct *vma)
> > @@ -410,17 +413,9 @@ tlb_update_vma_flags(struct mmu_gather *
> >          */
> >         tlb->vma_huge = is_vm_hugetlb_page(vma);
> >         tlb->vma_exec = !!(vma->vm_flags & VM_EXEC);
> > +       tlb->vma_pfn  = !!(vma->vm_flags & VM_PFNMAP);
> 
> We should probably handle VM_MIXEDMAP the same way as VM_PFNMAP here,
> I think? Conceptually I think the same issue can happen with
> device-owned pages that aren't managed by the kernel's page allocator,
> and for those, VM_MIXEDMAP is the same as VM_PFNMAP.

Hmm, yeah, that seems to make sense.

> >  }
> >
> > -#else
> > -
> > -static inline void
> > -tlb_update_vma_flags(struct mmu_gather *tlb, struct vm_area_struct *vma) { }
> > -
> > -#endif
> > -
> > -#endif /* CONFIG_MMU_GATHER_NO_RANGE */
> > -
> >  static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
> >  {
> >         /*
> > @@ -507,16 +502,22 @@ static inline void tlb_start_vma(struct
> >
> >  static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
> >  {
> > -       if (tlb->fullmm || IS_ENABLED(CONFIG_MMU_GATHER_MERGE_VMAS))
> > +       if (tlb->fullmm)
> >                 return;
> 
> Is this correct, or would there still be a race between MM teardown
> (which sets ->fullmm, see exit_mmap()->tlb_gather_mmu_fullmm()) and
> unmap_mapping_range()? My understanding is that ->fullmm only
> guarantees a flush at tlb_finish_mmu(), but here we're trying to
> ensure a flush before unlink_file_vma().

fullmm is when the last user of the mm goes away, there should not be
any races on the address space at that time. Also see the comment with
tlb_gather_mmu_fullmm() and its users.

> >         /*
> > -        * Do a TLB flush and reset the range at VMA boundaries; this avoids
> > -        * the ranges growing with the unused space between consecutive VMAs,
> > -        * but also the mmu_gather::vma_* flags from tlb_start_vma() rely on
> > -        * this.
> > +        * VM_PFNMAP is more fragile because the core mm will not track the
> > +        * page mapcount -- there might not be page-frames for these PFNs after
> > +        * all. Force flush TLBs for such ranges to avoid munmap() vs
> > +        * unmap_mapping_range() races.
> 
> Maybe add: "We do *not* guarantee that after munmap() has passed
                         ^ otherwise?
> through tlb_end_vma(), there are no more stale TLB entries for this
> VMA; there could be a parallel PTE-zapping operation that has zapped
> PTEs before we looked at them but hasn't done the corresponding TLB
> flush yet. However, such a parallel zap can't be done through the
> mm_struct (we've unlinked the VMA), so it would have to be done under
> the ->i_mmap_sem in read mode, which we synchronize against in
> unlink_file_vma()."

Done.

> I'm not convinced it's particularly nice to do a flush in
> tlb_end_vma() when we can't make guarantees about the TLB state wrt
> parallel invalidations, and when we only really care about having a
> flush between unmap_vmas() and free_pgtables(), but I guess it works?

Yeah, none of this is pretty. I despise this whole parallel invalidation
stuff with a passion, we've had ever so many bugs because of that :-(

We could add another mmu_gather callback and place it between
unmap_vmas() and free_pgtables(), but it's a much larger patch and I'm
not entirely sure it's worth the complexity.

OTOH having a callback between freeing pages and freeing page-tables
might not be the worst idea. Let me ponder that for a bit.

Meanwhile; updated patch below.

---
Subject: mmu_gather: Force TLB-flush VM_PFNMAP|VM_MIXEDMAP vmas
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu Jul 7 11:51:16 CEST 2022

Jann reported a race between munmap() and unmap_mapping_range(), where
unmap_mapping_range() will no-op once unmap_vmas() has unlinked the
VMA; however munmap() will not yet have invalidated the TLBs.

Therefore unmap_mapping_range() will complete while there are still
(stale) TLB entries for the specified range.

Mitigate this by force flushing TLBs for VM_PFNMAP ranges.

Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/asm-generic/tlb.h |   28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -507,16 +507,32 @@ static inline void tlb_start_vma(struct
 
 static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
 {
-	if (tlb->fullmm || IS_ENABLED(CONFIG_MMU_GATHER_MERGE_VMAS))
+	if (tlb->fullmm)
 		return;
 
 	/*
-	 * Do a TLB flush and reset the range at VMA boundaries; this avoids
-	 * the ranges growing with the unused space between consecutive VMAs,
-	 * but also the mmu_gather::vma_* flags from tlb_start_vma() rely on
-	 * this.
+	 * VM_PFNMAP|VM_MIXEDMAP is more fragile because the core mm will not
+	 * track the page mapcount -- there might not be page-frames for these
+	 * PFNs after all. Force flush TLBs for such ranges to avoid munmap()
+	 * vs unmap_mapping_range() races.
+	 *
+	 * We do *NOT* guarantee that after munmap() has passed through
+	 * tlb_end_vma(), there are no more stale TLB entries for this VMA;
+	 * there could be a parallel PTE-zapping operation that has zapped PTEs
+	 * before we looked at them but hasn't done the corresponding TLB flush
+	 * yet. However, such a parallel zap can't be done through the
+	 * mm_struct (we've unliked the VMA), so it would have to be done under
+	 * the ->i_mmap_sem in read move, which we synchronize against in
+	 * unlink_file_vma().
 	 */
-	tlb_flush_mmu_tlbonly(tlb);
+	if ((vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) ||
+	    !IS_ENABLED(CONFIG_MMU_GATHER_MERGE_VMAS)) {
+		/*
+		 * Do a TLB flush and reset the range at VMA boundaries; this avoids
+		 * the ranges growing with the unused space between consecutive VMAs.
+		 */
+		tlb_flush_mmu_tlbonly(tlb);
+	}
 }
 
 /*
