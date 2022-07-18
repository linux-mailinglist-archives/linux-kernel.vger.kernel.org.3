Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E0F578B0E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 21:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236257AbiGRTh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 15:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236222AbiGRTh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 15:37:26 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E57A31201
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:37:25 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id u7-20020a17090a3fc700b001f1efc76be2so474500pjm.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vrKPjJvEMBTDr1mCiDbgd+KWQ8nvzpXNXEsnVSmuvO0=;
        b=eYUZpQJpHryXrfyw7d48dRMqIWNv2+baxNAcAVwwnO0fjHTTRD50J1bwh/PG8hjhyo
         RFIxBYYQfj5C9aZGvM+1u1GlB88xW+kndwLcOf6g2YEW+59i/GnfGPV2S9WxiHUwpSKX
         x08be9IZJ+YBx/qdBlDRbTMoOz/KXj85/cPSJxz55YfQzzX3Jpf+kiiIG4NAlj1yOMjc
         BjlyIgdaoYZ3WQ5j2mm/bj4G39v948AmRF31dtKwb52uX06Lm82D+vYO7r8Ancx0fHXp
         /xQCRujNj3hHmv8itzoQcsbS0vCIUj1i2sOEK0ErYyuRJHrObKtzScHJD8DsT83a0u+y
         G2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vrKPjJvEMBTDr1mCiDbgd+KWQ8nvzpXNXEsnVSmuvO0=;
        b=2CdXM3jze6djMDc2m5UOJaAW+Dau99ycI7jbHsx0gjdzsgxFcHDaVORnpCGNB/5u2M
         lrc+5Eq3+htdt2Y4vu2KcSyFuV3AvbnNobg+9Hx0j25TAKeXyI7eFp32tMOEdjLLRPKE
         3dmjaqq2MhfncC2n8FHepdx9Q5+Ymdg2RL1Qz1IFccMWShz6r8rVYLdiuPJinI6VTPyS
         UxuRv8xuDmLba/+VLhSlzC8MBSZuCpLQYXJttTSASmcPthTz1Vw+KYB8gXq//1zAavPo
         mOagMVVoE2f4SSWrozoNYQ4zBWuuyY14fQCoQKVfMC+klxmm6M38WuNKv4fYc5G8meLT
         6b2A==
X-Gm-Message-State: AJIora90k34nv+MNli4nDt9R1cqMq/QMZPqBlBqskRM/8siLVA+KdJYu
        /IcGAQjVfHWLN1F+wXrWLck=
X-Google-Smtp-Source: AGRyM1uYMSGTx4GyYdBLjJpMepu7xtMk4UhhFdK1EgIxLwbQTenVoVfEyUI9bNANKUd9XUVG9W4PUA==
X-Received: by 2002:a17:903:1111:b0:16a:acf4:e951 with SMTP id n17-20020a170903111100b0016aacf4e951mr29606165plh.72.1658173044426;
        Mon, 18 Jul 2022 12:37:24 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902a3c600b0016bc4a6ce28sm9907887plb.98.2022.07.18.12.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 12:37:24 -0700 (PDT)
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
Subject: [RFC PATCH 14/14] mm: conditional check of pfn in pte_flush_type
Date:   Mon, 18 Jul 2022 05:02:12 -0700
Message-Id: <20220718120212.3180-15-namit@vmware.com>
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

Checking whether PFNs in two PTEs are the same takes surprisingly large
number of instructions. Yet in fact, in most cases the caller to
pte_flush_type() already knows if the PFN was changed. For instance,
mprotect() does not change the PFN, but only modifies the protection
flags.

Add argument to pte_flush_type() to indicate whether the PFN should be
checked. Keep checking it in mm-debug to see if some caller was wrong to
assume the PFN is the same.

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
 arch/x86/include/asm/tlbflush.h | 14 ++++++++++----
 include/asm-generic/tlb.h       |  6 ++++--
 mm/huge_memory.c                |  2 +-
 mm/mprotect.c                   |  2 +-
 mm/rmap.c                       |  2 +-
 5 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 58c95e36b098..50349861fdc9 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -340,14 +340,17 @@ static inline enum pte_flush_type pte_flags_flush_type(unsigned long oldflags,
  * whether a strict or relaxed TLB flush is need. It should only be used on
  * userspace PTEs.
  */
-static inline enum pte_flush_type pte_flush_type(pte_t oldpte, pte_t newpte)
+static inline enum pte_flush_type pte_flush_type(pte_t oldpte, pte_t newpte,
+						   bool check_pfn)
 {
 	/* !PRESENT -> * ; no need for flush */
 	if (!(pte_flags(oldpte) & _PAGE_PRESENT))
 		return PTE_FLUSH_NONE;
 
 	/* PFN changed ; needs flush */
-	if (pte_pfn(oldpte) != pte_pfn(newpte))
+	if (!check_pfn)
+		VM_BUG_ON(pte_pfn(oldpte) != pte_pfn(newpte));
+	else if (pte_pfn(oldpte) != pte_pfn(newpte))
 		return PTE_FLUSH_STRICT;
 
 	/*
@@ -363,14 +366,17 @@ static inline enum pte_flush_type pte_flush_type(pte_t oldpte, pte_t newpte)
  * huge_pmd_flush_type() checks whether permissions were demoted and require a
  * flush. It should only be used for userspace huge PMDs.
  */
-static inline enum pte_flush_type huge_pmd_flush_type(pmd_t oldpmd, pmd_t newpmd)
+static inline enum pte_flush_type huge_pmd_flush_type(pmd_t oldpmd, pmd_t newpmd,
+						      bool check_pfn)
 {
 	/* !PRESENT -> * ; no need for flush */
 	if (!(pmd_flags(oldpmd) & _PAGE_PRESENT))
 		return PTE_FLUSH_NONE;
 
 	/* PFN changed ; needs flush */
-	if (pmd_pfn(oldpmd) != pmd_pfn(newpmd))
+	if (!check_pfn)
+		VM_BUG_ON(pmd_pfn(oldpmd) != pmd_pfn(newpmd));
+	else if (pmd_pfn(oldpmd) != pmd_pfn(newpmd))
 		return PTE_FLUSH_STRICT;
 
 	/*
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 07b3eb8caf63..aee9da6cc5d5 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -677,14 +677,16 @@ static inline void tlb_flush_p4d_range(struct mmu_gather *tlb,
 #endif
 
 #ifndef pte_flush_type
-static inline struct pte_flush_type pte_flush_type(pte_t oldpte, pte_t newpte)
+static inline struct pte_flush_type pte_flush_type(pte_t oldpte, pte_t newpte,
+						   bool check_pfn)
 {
 	return PTE_FLUSH_STRICT;
 }
 #endif
 
 #ifndef huge_pmd_flush_type
-static inline bool huge_pmd_flush_type(pmd_t oldpmd, pmd_t newpmd)
+static inline bool huge_pmd_flush_type(pmd_t oldpmd, pmd_t newpmd,
+				       bool check_pfn)
 {
 	return PTE_FLUSH_STRICT;
 }
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b32b7da0f6f7..92a7b3ca317f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1818,7 +1818,7 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 
 	flush_type = PTE_FLUSH_STRICT;
 	if (!tlb->strict)
-		flush_type = huge_pmd_flush_type(oldpmd, entry);
+		flush_type = huge_pmd_flush_type(oldpmd, entry, false);
 	if (flush_type != PTE_FLUSH_NONE)
 		tlb_flush_pmd_range(tlb, addr, HPAGE_PMD_SIZE,
 				    flush_type == PTE_FLUSH_STRICT);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index cf775f6c8c08..78081d7f4edf 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -204,7 +204,7 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
 
 			flush_type = PTE_FLUSH_STRICT;
 			if (!tlb->strict)
-				flush_type = pte_flush_type(oldpte, ptent);
+				flush_type = pte_flush_type(oldpte, ptent, false);
 			if (flush_type != PTE_FLUSH_NONE)
 				tlb_flush_pte_range(tlb, addr, PAGE_SIZE,
 						flush_type == PTE_FLUSH_STRICT);
diff --git a/mm/rmap.c b/mm/rmap.c
index 62f4b2a4f067..63261619b607 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -974,7 +974,7 @@ static int page_vma_mkclean_one(struct page_vma_mapped_walk *pvmw)
 			entry = pte_wrprotect(oldpte);
 			entry = pte_mkclean(entry);
 
-			if (pte_flush_type(oldpte, entry) != PTE_FLUSH_NONE ||
+			if (pte_flush_type(oldpte, entry, false) != PTE_FLUSH_NONE ||
 			    mm_tlb_flush_pending(vma->vm_mm))
 				flush_tlb_page(vma, address);
 
-- 
2.25.1

