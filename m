Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4F956B366
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 09:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237200AbiGHHU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 03:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237298AbiGHHUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 03:20:13 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7057B345
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 00:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=9N3hbdGruB5h4fAjWjsEU0b1fdr629wCnSILI1aJFXM=; b=k99tIQRm2czJTmGUD/JGTD6mJI
        YQFQZJe0a7TlvMFKFZX8CdfuE9PBgqqFF0zQp+j2oFFErRoyr2LRk5yjxYDjT3KW2lnFr0+IrHRJA
        TzpoVJGfJhwDQFadPTQv3yAXmVT47K2Qo9zIhRqxM1laaTJThO4BSy0XWPxRsOuspjGKII1uVCzlQ
        /nUdURcoMTbMZrqvvNKUQG/vN6VN7d6Osix1PnmEu09C5Jqx+h94qWa0aDMT4OH9xRZqdlmigZUQY
        tpDZrx+kpOEZXAr5cIDwQjyIh2/oD3eVj0ryDtY4V0h1LvIzgqGxaJCft8pmQXoM7q+xipoHt21IQ
        g+Pifa+g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9iHI-001dLw-Jr; Fri, 08 Jul 2022 07:19:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B5691300E6E;
        Fri,  8 Jul 2022 09:19:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4B9FF203C016F; Fri,  8 Jul 2022 09:19:51 +0200 (CEST)
Message-ID: <20220708071833.955178793@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 08 Jul 2022 09:18:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        peterz@infradead.org, Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guo Ren <guoren@kernel.org>, David Miller <davem@davemloft.net>
Subject: [PATCH 1/4] mmu_gather: Remove per arch tlb_{start,end}_vma()
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

Scattered across the archs are 3 basic forms of tlb_{start,end}_vma().
Provide two new MMU_GATHER_knobs to enumerate them and remove the per
arch tlb_{start,end}_vma() implementations.

 - MMU_GATHER_NO_FLUSH_CACHE indicates the arch has flush_cache_range()
   but does *NOT* want to call it for each VMA.

 - MMU_GATHER_MERGE_VMAS indicates the arch wants to merge the
   invalidate across multiple VMAs if possible.

With these it is possible to capture the three forms:

  1) empty stubs;
     select MMU_GATHER_NO_FLUSH_CACHE and MMU_GATHER_MERGE_VMAS

  2) start: flush_cache_range(), end: empty;
     select MMU_GATHER_MERGE_VMAS

  3) start: flush_cache_range(), end: flush_tlb_range();
     default

Obviously, if the architecture does not have flush_cache_range() then
it also doesn't need to select MMU_GATHER_NO_FLUSH_CACHE.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/Kconfig                     |    7 +++++++
 arch/csky/include/asm/tlb.h      |   13 -------------
 arch/loongarch/Kconfig           |    1 +
 arch/loongarch/include/asm/tlb.h |   10 ----------
 arch/powerpc/Kconfig             |    1 +
 arch/powerpc/include/asm/tlb.h   |    2 --
 arch/s390/Kconfig                |    1 +
 arch/s390/include/asm/tlb.h      |    3 ---
 arch/sparc/Kconfig               |    2 ++
 arch/sparc/include/asm/tlb_64.h  |    2 --
 arch/x86/Kconfig                 |    1 +
 arch/x86/include/asm/tlb.h       |    3 ---
 include/asm-generic/tlb.h        |   21 +++++++++++++++++++--
 13 files changed, 32 insertions(+), 35 deletions(-)

--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -438,6 +438,13 @@ config MMU_GATHER_PAGE_SIZE
 
 config MMU_GATHER_NO_RANGE
 	bool
+	select MMU_GATHER_MERGE_VMAS
+
+config MMU_GATHER_NO_FLUSH_CACHE
+	bool
+
+config MMU_GATHER_MERGE_VMAS
+	bool
 
 config MMU_GATHER_NO_GATHER
 	bool
--- a/arch/csky/include/asm/tlb.h
+++ b/arch/csky/include/asm/tlb.h
@@ -4,19 +4,6 @@
 #define __ASM_CSKY_TLB_H
 
 #include <asm/cacheflush.h>
-
-#define tlb_start_vma(tlb, vma) \
-	do { \
-		if (!(tlb)->fullmm) \
-			flush_cache_range(vma, (vma)->vm_start, (vma)->vm_end); \
-	}  while (0)
-
-#define tlb_end_vma(tlb, vma) \
-	do { \
-		if (!(tlb)->fullmm) \
-			flush_tlb_range(vma, (vma)->vm_start, (vma)->vm_end); \
-	}  while (0)
-
 #define tlb_flush(tlb) flush_tlb_mm((tlb)->mm)
 
 #include <asm-generic/tlb.h>
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -112,6 +112,7 @@ config LOONGARCH
 	select TRACE_IRQFLAGS_SUPPORT
 	select USE_PERCPU_NUMA_NODE_ID
 	select ZONE_DMA32
+	select MMU_GATHER_MERGE_VMAS if MMU
 
 config 32BIT
 	bool
--- a/arch/loongarch/include/asm/tlb.h
+++ b/arch/loongarch/include/asm/tlb.h
@@ -137,16 +137,6 @@ static inline void invtlb_all(u32 op, u3
 		);
 }
 
-/*
- * LoongArch doesn't need any special per-pte or per-vma handling, except
- * we need to flush cache for area to be unmapped.
- */
-#define tlb_start_vma(tlb, vma)					\
-	do {							\
-		if (!(tlb)->fullmm)				\
-			flush_cache_range(vma, vma->vm_start, vma->vm_end); \
-	}  while (0)
-#define tlb_end_vma(tlb, vma) do { } while (0)
 #define __tlb_remove_tlb_entry(tlb, ptep, address) do { } while (0)
 
 static void tlb_flush(struct mmu_gather *tlb);
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -256,6 +256,7 @@ config PPC
 	select IRQ_FORCED_THREADING
 	select MMU_GATHER_PAGE_SIZE
 	select MMU_GATHER_RCU_TABLE_FREE
+	select MMU_GATHER_MERGE_VMAS
 	select MODULES_USE_ELF_RELA
 	select NEED_DMA_MAP_STATE		if PPC64 || NOT_COHERENT_CACHE
 	select NEED_PER_CPU_EMBED_FIRST_CHUNK	if PPC64
--- a/arch/powerpc/include/asm/tlb.h
+++ b/arch/powerpc/include/asm/tlb.h
@@ -19,8 +19,6 @@
 
 #include <linux/pagemap.h>
 
-#define tlb_start_vma(tlb, vma)	do { } while (0)
-#define tlb_end_vma(tlb, vma)	do { } while (0)
 #define __tlb_remove_tlb_entry	__tlb_remove_tlb_entry
 
 #define tlb_flush tlb_flush
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -204,6 +204,7 @@ config S390
 	select IOMMU_SUPPORT		if PCI
 	select MMU_GATHER_NO_GATHER
 	select MMU_GATHER_RCU_TABLE_FREE
+	select MMU_GATHER_MERGE_VMAS
 	select MODULES_USE_ELF_RELA
 	select NEED_DMA_MAP_STATE	if PCI
 	select NEED_SG_DMA_LENGTH	if PCI
--- a/arch/s390/include/asm/tlb.h
+++ b/arch/s390/include/asm/tlb.h
@@ -27,9 +27,6 @@ static inline void tlb_flush(struct mmu_
 static inline bool __tlb_remove_page_size(struct mmu_gather *tlb,
 					  struct page *page, int page_size);
 
-#define tlb_start_vma(tlb, vma)			do { } while (0)
-#define tlb_end_vma(tlb, vma)			do { } while (0)
-
 #define tlb_flush tlb_flush
 #define pte_free_tlb pte_free_tlb
 #define pmd_free_tlb pmd_free_tlb
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -67,6 +67,8 @@ config SPARC64
 	select HAVE_KRETPROBES
 	select HAVE_KPROBES
 	select MMU_GATHER_RCU_TABLE_FREE if SMP
+	select MMU_GATHER_MERGE_VMAS
+	select MMU_GATHER_NO_FLUSH_CACHE
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_FTRACE_MCOUNT_RECORD
--- a/arch/sparc/include/asm/tlb_64.h
+++ b/arch/sparc/include/asm/tlb_64.h
@@ -22,8 +22,6 @@ void smp_flush_tlb_mm(struct mm_struct *
 void __flush_tlb_pending(unsigned long, unsigned long, unsigned long *);
 void flush_tlb_pending(void);
 
-#define tlb_start_vma(tlb, vma) do { } while (0)
-#define tlb_end_vma(tlb, vma)	do { } while (0)
 #define tlb_flush(tlb)	flush_tlb_pending()
 
 /*
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -245,6 +245,7 @@ config X86
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select MMU_GATHER_RCU_TABLE_FREE	if PARAVIRT
+	select MMU_GATHER_MERGE_VMAS
 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE		if UNWINDER_ORC || STACK_VALIDATION
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -2,9 +2,6 @@
 #ifndef _ASM_X86_TLB_H
 #define _ASM_X86_TLB_H
 
-#define tlb_start_vma(tlb, vma) do { } while (0)
-#define tlb_end_vma(tlb, vma) do { } while (0)
-
 #define tlb_flush tlb_flush
 static inline void tlb_flush(struct mmu_gather *tlb);
 
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -158,9 +158,24 @@
  *  Useful if your architecture doesn't use IPIs for remote TLB invalidates
  *  and therefore doesn't naturally serialize with software page-table walkers.
  *
+ *  MMU_GATHER_NO_FLUSH_CACHE
+ *
+ *  Indicates the architecture has flush_cache_range() but it needs *NOT* be called
+ *  before unmapping a VMA.
+ *
+ *  NOTE: strictly speaking we shouldn't have this knob and instead rely on
+ *	  flush_cache_range() being a NOP, except Sparc64 seems to be
+ *	  different here.
+ *
+ *  MMU_GATHER_MERGE_VMAS
+ *
+ *  Indicates the architecture wants to merge ranges over VMAs; typical when
+ *  multiple range invalidates are more expensive than a full invalidate.
+ *
  *  MMU_GATHER_NO_RANGE
  *
- *  Use this if your architecture lacks an efficient flush_tlb_range().
+ *  Use this if your architecture lacks an efficient flush_tlb_range(). This
+ *  option implies MMU_GATHER_MERGE_VMAS above.
  *
  *  MMU_GATHER_NO_GATHER
  *
@@ -493,14 +508,16 @@ static inline void tlb_start_vma(struct
 		return;
 
 	tlb_update_vma_flags(tlb, vma);
+#ifndef CONFIG_MMU_GATHER_NO_FLUSH_CACHE
 	flush_cache_range(vma, vma->vm_start, vma->vm_end);
+#endif
 }
 #endif
 
 #ifndef tlb_end_vma
 static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
 {
-	if (tlb->fullmm)
+	if (tlb->fullmm || IS_ENABLED(CONFIG_MMU_GATHER_MERGE_VMAS))
 		return;
 
 	/*


