Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC64056B35F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 09:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237235AbiGHHUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 03:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237505AbiGHHUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 03:20:12 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392107B353
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 00:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=8Qg5PlV6I5tOH468X+xadgMPbp4kBu9FI4E8wShX5Lg=; b=I3s3dj+789fDlQeStJ3jAGPxDI
        SzoLztxojDq6Q51I6LzBcB7rOt4xSq7AtOARBSwmtKbhUyxOH5CkhGfObLcV/kedd+7szZ/vw3xY9
        Msp8KKV50g9bNFw2Kiie3d1hAhR8DNXplc+6l5b/cA/Udbai53yn/AABQJYTnr4GtTuo2+5gpPIZ7
        IG0LekJsIE0kTH4hQDw94HcYiW4c1T+O4/Z7jwUt+Q6wcZO/50zlmzDB1+mmRhRe417tDt8GP08bz
        o6O6jXq7bmsAnkO8NwyMYnf28wUmWWuMY+6eG4hJ+Cxx6aigzDd7Whk7eNOKIq9zLqAu27+zz6OjC
        77HFJaPw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9iHI-001dLu-Ii; Fri, 08 Jul 2022 07:19:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B89DC301221;
        Fri,  8 Jul 2022 09:19:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5A20E20CA4D1B; Fri,  8 Jul 2022 09:19:51 +0200 (CEST)
Message-ID: <20220708071834.149930530@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 08 Jul 2022 09:18:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        peterz@infradead.org, Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guo Ren <guoren@kernel.org>, David Miller <davem@davemloft.net>
Subject: [PATCH 4/4] mmu_gather: Force tlb-flush VM_PFNMAP vmas
References: <20220708071802.751003711@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jann reported a race between munmap() and unmap_mapping_range(), where
unmap_mapping_range() will no-op once unmap_vmas() has unlinked the
VMA; however munmap() will not yet have invalidated the TLBs.

Therefore unmap_mapping_range() will complete while there are still
(stale) TLB entries for the specified range.

Mitigate this by force flushing TLBs for VM_PFNMAP ranges.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/asm-generic/tlb.h |   33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -303,6 +303,7 @@ struct mmu_gather {
 	 */
 	unsigned int		vma_exec : 1;
 	unsigned int		vma_huge : 1;
+	unsigned int		vma_pfn  : 1;
 
 	unsigned int		batch_count;
 
@@ -373,7 +374,6 @@ tlb_update_vma_flags(struct mmu_gather *
 #else /* CONFIG_MMU_GATHER_NO_RANGE */
 
 #ifndef tlb_flush
-
 /*
  * When an architecture does not provide its own tlb_flush() implementation
  * but does have a reasonably efficient flush_vma_range() implementation
@@ -393,6 +393,9 @@ static inline void tlb_flush(struct mmu_
 		flush_tlb_range(&vma, tlb->start, tlb->end);
 	}
 }
+#endif
+
+#endif /* CONFIG_MMU_GATHER_NO_RANGE */
 
 static inline void
 tlb_update_vma_flags(struct mmu_gather *tlb, struct vm_area_struct *vma)
@@ -410,17 +413,9 @@ tlb_update_vma_flags(struct mmu_gather *
 	 */
 	tlb->vma_huge = is_vm_hugetlb_page(vma);
 	tlb->vma_exec = !!(vma->vm_flags & VM_EXEC);
+	tlb->vma_pfn  = !!(vma->vm_flags & VM_PFNMAP);
 }
 
-#else
-
-static inline void
-tlb_update_vma_flags(struct mmu_gather *tlb, struct vm_area_struct *vma) { }
-
-#endif
-
-#endif /* CONFIG_MMU_GATHER_NO_RANGE */
-
 static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
 {
 	/*
@@ -507,16 +502,22 @@ static inline void tlb_start_vma(struct
 
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
+	if (tlb->vma_pfn || !IS_ENABLED(CONFIG_MMU_GATHER_MERGE_VMAS)) {
+		/*
+		 * Do a TLB flush and reset the range at VMA boundaries; this avoids
+		 * the ranges growing with the unused space between consecutive VMAs.
+		 */
+		tlb_flush_mmu_tlbonly(tlb);
+	}
 }
 
 /*


