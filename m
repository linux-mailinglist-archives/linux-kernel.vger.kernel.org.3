Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555CD56BB77
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 16:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238441AbiGHODn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 10:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238123AbiGHODk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 10:03:40 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9D725EA6
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 07:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=s+EQgSxpahsYAaya4GvQorTV7f/1MGWOK/61uO29yIE=; b=hPsai+AxuTgYZlDVehKcaTAQk2
        HFVsub9E1A10zLvA0c416AM6Ik8JARZjyNbbWpZd8Debivja/CIGUkIbreYZB2GuMLTI6dn3ZkJBr
        g0te6bWnOddM6PjYnJqBZVbvscki8TEcmZfIbSYnh0VXIwzJl+nnFEBjuER8yXBVm0KC/AY7rFB0s
        iJlgZ172dIETrlDg4DIiDY49u4qPtsIgAD6v2eYlLrW0joj+BzY4nNnLX5kvo4A6Rk9mT8J1IR9gD
        Dd2M+qAYBFRl5TH7y2c5VnsG/+ioMruiQM50HFnQ+qPywFVhZhBLV57T3tmb1IXEvPptPBOaxs7j7
        tlc74pbg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9oZi-001kyL-BT; Fri, 08 Jul 2022 14:03:18 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id C296198007C; Fri,  8 Jul 2022 16:03:17 +0200 (CEST)
Date:   Fri, 8 Jul 2022 16:03:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guo Ren <guoren@kernel.org>, David Miller <davem@davemloft.net>
Subject: Re: [PATCH 4/4] mmu_gather: Force tlb-flush VM_PFNMAP vmas
Message-ID: <Ysg5JSxiq21ippRl@worktop.programming.kicks-ass.net>
References: <20220708071802.751003711@infradead.org>
 <20220708071834.149930530@infradead.org>
 <20220708133605.GE5989@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708133605.GE5989@willie-the-truck>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 02:36:06PM +0100, Will Deacon wrote:
> On Fri, Jul 08, 2022 at 09:18:06AM +0200, Peter Zijlstra wrote:

> > @@ -507,16 +502,22 @@ static inline void tlb_start_vma(struct
> >  
> >  static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
> >  {
> > -	if (tlb->fullmm || IS_ENABLED(CONFIG_MMU_GATHER_MERGE_VMAS))
> > +	if (tlb->fullmm)
> >  		return;
> >  
> >  	/*
> > -	 * Do a TLB flush and reset the range at VMA boundaries; this avoids
> > -	 * the ranges growing with the unused space between consecutive VMAs,
> > -	 * but also the mmu_gather::vma_* flags from tlb_start_vma() rely on
> > -	 * this.
> > +	 * VM_PFNMAP is more fragile because the core mm will not track the
> > +	 * page mapcount -- there might not be page-frames for these PFNs after
> > +	 * all. Force flush TLBs for such ranges to avoid munmap() vs
> > +	 * unmap_mapping_range() races.
> >  	 */
> > -	tlb_flush_mmu_tlbonly(tlb);
> > +	if (tlb->vma_pfn || !IS_ENABLED(CONFIG_MMU_GATHER_MERGE_VMAS)) {
> > +		/*
> > +		 * Do a TLB flush and reset the range at VMA boundaries; this avoids
> > +		 * the ranges growing with the unused space between consecutive VMAs.
> > +		 */
> > +		tlb_flush_mmu_tlbonly(tlb);
> > +	}
> 
> We already have the vma here, so I'm not sure how much the new 'vma_pfn'
> field really buys us over checking the 'vm_flags', but perhaps that's
> cleanup for another day.

Duh, that's just me being daft again. For some raisin I was convinced
(and failed to check) that we only had the vma at start.

I can easily respin this to not need the extra variable.

How's this then?

---
Subject: mmu_gather: Force tlb-flush VM_PFNMAP vmas
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu Jul 7 11:51:16 CEST 2022

Jann reported a race between munmap() and unmap_mapping_range(), where
unmap_mapping_range() will no-op once unmap_vmas() has unlinked the
VMA; however munmap() will not yet have invalidated the TLBs.

Therefore unmap_mapping_range() will complete while there are still
(stale) TLB entries for the specified range.

Mitigate this by force flushing TLBs for VM_PFNMAP ranges.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/asm-generic/tlb.h |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -507,16 +507,22 @@ static inline void tlb_start_vma(struct
 
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
+	 * VM_PFNMAP is more fragile because the core mm will not track the
+	 * page mapcount -- there might not be page-frames for these PFNs after
+	 * all. Force flush TLBs for such ranges to avoid munmap() vs
+	 * unmap_mapping_range() races.
 	 */
-	tlb_flush_mmu_tlbonly(tlb);
+	if ((vma->vm_flags & VM_PFNMAP) || !IS_ENABLED(CONFIG_MMU_GATHER_MERGE_VMAS)) {
+		/*
+		 * Do a TLB flush and reset the range at VMA boundaries; this avoids
+		 * the ranges growing with the unused space between consecutive VMAs.
+		 */
+		tlb_flush_mmu_tlbonly(tlb);
+	}
 }
 
 /*
