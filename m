Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3578B578B09
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 21:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236260AbiGRThj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 15:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236190AbiGRThT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 15:37:19 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7400E2D1E3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:37:18 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id g4-20020a17090a290400b001f1f2b7379dso357374pjd.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Oo4Pz1r5XHW7nwxpGgJZANPDnH94I0NGToeI6/zKa1I=;
        b=Yta4aSxqKdJJamMX5Ka9KLD4dubuyf5nvRkNeJsovDB9Ytj1BQ5qWdRgLzIHHHERB6
         5sXf3niGo/72wXP0jlBMi/vVkFJX8hLRvbMlrw7tatNFrNNgmNMB9HbzNICkzbNcXs3w
         6cu7pwr4AsBJZ3fn8/KYDPZk8nX+6Rg3Ljpt2/TGFqbUZ7cKL97bfzfYsiBq4vhT+Kw9
         MVxwsvKLWzOIIRIJm9ZWmpzyPYTX/gBlEmxcuQU3TzAh1tBYia4QkzmOzqCE6j5LO15n
         QaXqO0JTJLp//5mmCRV7FullleEzXsADDRB6uSgI3/pl3o0omrcymnmvGc3DAicOGAQh
         YnEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Oo4Pz1r5XHW7nwxpGgJZANPDnH94I0NGToeI6/zKa1I=;
        b=VowYbvd3LpdyHdziQkX4zPe46BeX0WuZW92HDaAs4Q5kDNWYwcYBnTIZeQBsoIYM1Y
         s844MAUbeAwWIKMfVYGTQU1B5gMdfWlGNVPdkuzsFAwle7twvVXHCckzA7aYhr3JuOLp
         ss39W0t6+vldjdGcsgDlzl+/ygGgyWIXPagXIEL/WEFgebOhIRE57XFdlxIqW8yU7Hnq
         dNa5F+2tWk33KveVxxcmwL+9fiNVjKuyGuU4FvjDWndnImyvQ6J+BjiEeJJgWDwhenB2
         IRxQUZmcTaBVi6eFMuApSBvH7t/e9LSgMM+ciL8mhpCzAxZkAE8O6HJpaDPxGoMQe8wu
         aNXg==
X-Gm-Message-State: AJIora9CRh4aUOSPQaZHozUglbIZCf3AH1M9X0kBIOebUrV5LQ3AVaDT
        DBwsbVInaYwpzR/8D2mJEOQ=
X-Google-Smtp-Source: AGRyM1v14qCZwBb3XJU5MS/ZzWDs+xXqoaSfao3rsct5ND+6jaOGoGucVBBiblDjUX+cd9G34nsdiw==
X-Received: by 2002:a17:902:7106:b0:16c:6c95:6153 with SMTP id a6-20020a170902710600b0016c6c956153mr29356100pll.166.1658173037752;
        Mon, 18 Jul 2022 12:37:17 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902a3c600b0016bc4a6ce28sm9907887plb.98.2022.07.18.12.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 12:37:17 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 10/14] x86/mm: introduce relaxed TLB flushes
Date:   Mon, 18 Jul 2022 05:02:08 -0700
Message-Id: <20220718120212.3180-11-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220718120212.3180-1-namit@vmware.com>
References: <20220718120212.3180-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Introduce relaxed TLB flushes in x86. When protection is removed from
PTEs (i.e., PTEs become writeable or executable), relaxed TLB flushes
would be used. Relaxed TLB flushes do flush the local TLB, but do not
flush remote TLBs.

If later a spurious page-fault is encountered, and the local TLB
generation is found to be out of sync with the mm's TLB generation, a
full TLB flush takes place to prevent further spurious page-faults from
occurring.

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Nick Piggin <npiggin@gmail.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/tlb.h      | 3 ++-
 arch/x86/include/asm/tlbflush.h | 9 +++++----
 arch/x86/kernel/alternative.c   | 2 +-
 arch/x86/kernel/ldt.c           | 3 ++-
 arch/x86/mm/tlb.c               | 4 ++--
 5 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index 1bfe979bb9bc..51c85136f9a8 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -20,7 +20,8 @@ static inline void tlb_flush(struct mmu_gather *tlb)
 		end = tlb->end;
 	}
 
-	flush_tlb_mm_range(tlb->mm, start, end, stride_shift, tlb->freed_tables);
+	flush_tlb_mm_range(tlb->mm, start, end, stride_shift, tlb->freed_tables,
+			   tlb->strict);
 }
 
 /*
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 77d4810e5a5d..230cd1d24fe6 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -220,23 +220,24 @@ void flush_tlb_multi(const struct cpumask *cpumask,
 #endif
 
 #define flush_tlb_mm(mm)						\
-		flush_tlb_mm_range(mm, 0UL, TLB_FLUSH_ALL, 0UL, true)
+		flush_tlb_mm_range(mm, 0UL, TLB_FLUSH_ALL, 0UL, true, true)
 
 #define flush_tlb_range(vma, start, end)				\
 	flush_tlb_mm_range((vma)->vm_mm, start, end,			\
 			   ((vma)->vm_flags & VM_HUGETLB)		\
 				? huge_page_shift(hstate_vma(vma))	\
-				: PAGE_SHIFT, false)
+				: PAGE_SHIFT, false, true)
 
 extern void flush_tlb_all(void);
 extern void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 				unsigned long end, unsigned int stride_shift,
-				bool freed_tables);
+				bool freed_tables, bool strict);
 extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
 
 static inline void flush_tlb_page(struct vm_area_struct *vma, unsigned long a)
 {
-	flush_tlb_mm_range(vma->vm_mm, a, a + PAGE_SIZE, PAGE_SHIFT, false);
+	flush_tlb_mm_range(vma->vm_mm, a, a + PAGE_SIZE, PAGE_SHIFT, false,
+			   true);
 }
 
 static inline u64 inc_mm_tlb_gen(struct mm_struct *mm)
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index e257f6c80372..48945a47fd76 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1099,7 +1099,7 @@ static void *__text_poke(text_poke_f func, void *addr, const void *src, size_t l
 	 */
 	flush_tlb_mm_range(poking_mm, poking_addr, poking_addr +
 			   (cross_page_boundary ? 2 : 1) * PAGE_SIZE,
-			   PAGE_SHIFT, false);
+			   PAGE_SHIFT, false, true);
 
 	if (func == text_poke_memcpy) {
 		/*
diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index 525876e7b9f4..7c7bc97324bc 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -372,7 +372,8 @@ static void unmap_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt)
 	}
 
 	va = (unsigned long)ldt_slot_va(ldt->slot);
-	flush_tlb_mm_range(mm, va, va + nr_pages * PAGE_SIZE, PAGE_SHIFT, false);
+	flush_tlb_mm_range(mm, va, va + nr_pages * PAGE_SIZE, PAGE_SHIFT, false,
+			   true);
 }
 
 #else /* !CONFIG_PAGE_TABLE_ISOLATION */
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index ff3bcc55435e..ec5033d28a97 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -974,7 +974,7 @@ void flush_tlb_fix_spurious_fault(struct vm_area_struct *vma,
 
 void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 				unsigned long end, unsigned int stride_shift,
-				bool freed_tables)
+				bool freed_tables, bool strict)
 {
 	struct flush_tlb_info *info;
 	u64 new_tlb_gen;
@@ -1000,7 +1000,7 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 	 * a local TLB flush is needed. Optimize this use-case by calling
 	 * flush_tlb_func_local() directly in this case.
 	 */
-	if (cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids) {
+	if (strict && cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids) {
 		flush_tlb_multi(mm_cpumask(mm), info);
 	} else if (mm == this_cpu_read(cpu_tlbstate.loaded_mm)) {
 		lockdep_assert_irqs_enabled();
-- 
2.25.1

