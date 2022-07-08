Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3277C56B367
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 09:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237312AbiGHHUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 03:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237513AbiGHHUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 03:20:13 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD9E7B347
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 00:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=ijzouG1bvvv3uipoWgZ8tpfpptlpbv/OWRgYCHfEMU0=; b=Q0fwaTcro7sNMPuY3vDdtyNGTl
        w+UIMp3F9gv75uS46HJc4LLkEzdlu8uk8Bv3YApuwtJXoOyfEUGDytON6y5IOhaZrUVuiyJFVCIeU
        RS5otWNwnYMLXgUNzDS4JDEyovkCC4OF65OoliTrvWJFnpaayh+d1IsR06dmelFnCbfOQA1vkOwZk
        JR88b0ixOSKkyPXXRzh1w8PANSeYCoS4vXEdlcvHzvoN0fAM3gftm9W14pqJAcXUq3MGYQIN1yaAC
        hP6YR/7DAU6nQsCCJrEO4bHC9rbRIfDCKypbqeLapBiuEG9HNJJMzZMeAo7ZaTgoDLjGa6XyaYPKl
        4e2Esh7w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9iHI-001dLv-JL; Fri, 08 Jul 2022 07:19:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B1F14300903;
        Fri,  8 Jul 2022 09:19:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 53D2D203C0628; Fri,  8 Jul 2022 09:19:51 +0200 (CEST)
Message-ID: <20220708071834.084532973@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 08 Jul 2022 09:18:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        peterz@infradead.org, Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guo Ren <guoren@kernel.org>, David Miller <davem@davemloft.net>
Subject: [PATCH 3/4] mmu_gather: Let there be one tlb_{start,end}_vma() implementation
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

Now that architectures are no longer allowed to override
tlb_{start,end}_vma() re-arrange code so that there is only one
implementation for each of these functions.

This much simplifies trying to figure out what they actually do.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/asm-generic/tlb.h |   15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -346,8 +346,8 @@ static inline void __tlb_reset_range(str
 
 #ifdef CONFIG_MMU_GATHER_NO_RANGE
 
-#if defined(tlb_flush) || defined(tlb_start_vma) || defined(tlb_end_vma)
-#error MMU_GATHER_NO_RANGE relies on default tlb_flush(), tlb_start_vma() and tlb_end_vma()
+#if defined(tlb_flush)
+#error MMU_GATHER_NO_RANGE relies on default tlb_flush()
 #endif
 
 /*
@@ -367,17 +367,10 @@ static inline void tlb_flush(struct mmu_
 static inline void
 tlb_update_vma_flags(struct mmu_gather *tlb, struct vm_area_struct *vma) { }
 
-#define tlb_end_vma tlb_end_vma
-static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vma) { }
-
 #else /* CONFIG_MMU_GATHER_NO_RANGE */
 
 #ifndef tlb_flush
 
-#if defined(tlb_start_vma) || defined(tlb_end_vma)
-#error Default tlb_flush() relies on default tlb_start_vma() and tlb_end_vma()
-#endif
-
 /*
  * When an architecture does not provide its own tlb_flush() implementation
  * but does have a reasonably efficient flush_vma_range() implementation
@@ -498,7 +491,6 @@ static inline unsigned long tlb_get_unma
  * case where we're doing a full MM flush.  When we're doing a munmap,
  * the vmas are adjusted to only cover the region to be torn down.
  */
-#ifndef tlb_start_vma
 static inline void tlb_start_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
 {
 	if (tlb->fullmm)
@@ -509,9 +501,7 @@ static inline void tlb_start_vma(struct
 	flush_cache_range(vma, vma->vm_start, vma->vm_end);
 #endif
 }
-#endif
 
-#ifndef tlb_end_vma
 static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
 {
 	if (tlb->fullmm || IS_ENABLED(CONFIG_MMU_GATHER_MERGE_VMAS))
@@ -525,7 +515,6 @@ static inline void tlb_end_vma(struct mm
 	 */
 	tlb_flush_mmu_tlbonly(tlb);
 }
-#endif
 
 /*
  * tlb_flush_{pte|pmd|pud|p4d}_range() adjust the tlb->start and tlb->end,


