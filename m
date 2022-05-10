Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07AB7520D04
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 06:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236371AbiEJEmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 00:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbiEJEmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 00:42:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D37E575214
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 21:38:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A28512FC;
        Mon,  9 May 2022 21:38:43 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.34.190])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 921D33F66F;
        Mon,  9 May 2022 21:38:33 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     steve.capper@arm.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/hugetlb: Drop TLB flush from get_clear_flush()
Date:   Tue, 10 May 2022 10:09:30 +0530
Message-Id: <20220510043930.2410985-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This drops now redundant TLB flush in get_clear_flush() which is no longer
required after recent commit 697a1d44af8b ("tlb: hugetlb: Add more sizes to
tlb_remove_huge_tlb_entry"). It also renames this function i.e dropping off
'_flush' and replacing it with '__contig' as appropriate.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v5.18-rc6

 arch/arm64/mm/hugetlbpage.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index cbace1c9e137..749435b01a89 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -166,15 +166,14 @@ static inline int num_contig_ptes(unsigned long size, size_t *pgsize)
  *
  * This helper performs the break step.
  */
-static pte_t get_clear_flush(struct mm_struct *mm,
+static pte_t get_clear_contig(struct mm_struct *mm,
 			     unsigned long addr,
 			     pte_t *ptep,
 			     unsigned long pgsize,
 			     unsigned long ncontig)
 {
 	pte_t orig_pte = huge_ptep_get(ptep);
-	bool valid = pte_valid(orig_pte);
-	unsigned long i, saddr = addr;
+	unsigned long i;
 
 	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++) {
 		pte_t pte = ptep_get_and_clear(mm, addr, ptep);
@@ -190,11 +189,6 @@ static pte_t get_clear_flush(struct mm_struct *mm,
 		if (pte_young(pte))
 			orig_pte = pte_mkyoung(orig_pte);
 	}
-
-	if (valid) {
-		struct vm_area_struct vma = TLB_FLUSH_VMA(mm, 0);
-		flush_tlb_range(&vma, saddr, addr);
-	}
 	return orig_pte;
 }
 
@@ -392,7 +386,7 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 
 	ncontig = find_num_contig(mm, addr, ptep, &pgsize);
 
-	return get_clear_flush(mm, addr, ptep, pgsize, ncontig);
+	return get_clear_contig(mm, addr, ptep, pgsize, ncontig);
 }
 
 /*
@@ -443,7 +437,7 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 	if (!__cont_access_flags_changed(ptep, pte, ncontig))
 		return 0;
 
-	orig_pte = get_clear_flush(vma->vm_mm, addr, ptep, pgsize, ncontig);
+	orig_pte = get_clear_contig(vma->vm_mm, addr, ptep, pgsize, ncontig);
 
 	/* Make sure we don't lose the dirty or young state */
 	if (pte_dirty(orig_pte))
@@ -476,7 +470,7 @@ void huge_ptep_set_wrprotect(struct mm_struct *mm,
 	ncontig = find_num_contig(mm, addr, ptep, &pgsize);
 	dpfn = pgsize >> PAGE_SHIFT;
 
-	pte = get_clear_flush(mm, addr, ptep, pgsize, ncontig);
+	pte = get_clear_contig(mm, addr, ptep, pgsize, ncontig);
 	pte = pte_wrprotect(pte);
 
 	hugeprot = pte_pgprot(pte);
-- 
2.20.1

