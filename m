Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC9A4D3819
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbiCIRqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 12:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiCIRqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 12:46:07 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DAB9AE4F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 09:45:05 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KDKMz5YyPz9sSh;
        Wed,  9 Mar 2022 18:45:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id a3-mfLfSI8a5; Wed,  9 Mar 2022 18:45:03 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KDKMz4TRZz9sSX;
        Wed,  9 Mar 2022 18:45:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 849C08B798;
        Wed,  9 Mar 2022 18:45:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id tU3BpB-DQgBE; Wed,  9 Mar 2022 18:45:03 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.27])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D1EA58B763;
        Wed,  9 Mar 2022 18:45:02 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 229Hixrb3619054
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 9 Mar 2022 18:44:59 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 229Hiwqi3619053;
        Wed, 9 Mar 2022 18:44:58 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, alex@ghiti.fr
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v8 10/14] powerpc/mm: Use generic_hugetlb_get_unmapped_area()
Date:   Wed,  9 Mar 2022 18:44:44 +0100
Message-Id: <e4b0d646a31963c5adb919448d414b7477de49af.1646847562.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1646847561.git.christophe.leroy@csgroup.eu>
References: <cover.1646847561.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1646847882; l=4049; s=20211009; h=from:subject:message-id; bh=eKU9QG7u/DDiri7h5HugKssxSVqsaEaadAwfVOPD5+U=; b=naaStnZbMQrkwmyV23prCaJCp9F8sCzoo82OZUExroFlZBVtJKyOMMtexZmLeuUJZRh98OFvnZSP DZPvYSG8AzUYSjx6BOkgFq67S4U64CItXJQnS5B5E1Vhke/GumDQ
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the generic version of arch_hugetlb_get_unmapped_area()
which is now available at all time.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/book3s/64/hugetlb.h |  4 --
 arch/powerpc/mm/book3s64/radix_hugetlbpage.c | 55 --------------------
 arch/powerpc/mm/hugetlbpage.c                |  4 +-
 3 files changed, 1 insertion(+), 62 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hugetlb.h b/arch/powerpc/include/asm/book3s/64/hugetlb.h
index 12e150e615b7..b37a28f62cf6 100644
--- a/arch/powerpc/include/asm/book3s/64/hugetlb.h
+++ b/arch/powerpc/include/asm/book3s/64/hugetlb.h
@@ -8,10 +8,6 @@
  */
 void radix__flush_hugetlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
 void radix__local_flush_hugetlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
-extern unsigned long
-radix__hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
-				unsigned long len, unsigned long pgoff,
-				unsigned long flags);
 
 extern void radix__huge_ptep_modify_prot_commit(struct vm_area_struct *vma,
 						unsigned long addr, pte_t *ptep,
diff --git a/arch/powerpc/mm/book3s64/radix_hugetlbpage.c b/arch/powerpc/mm/book3s64/radix_hugetlbpage.c
index 23d3e08911d3..d2fb776febb4 100644
--- a/arch/powerpc/mm/book3s64/radix_hugetlbpage.c
+++ b/arch/powerpc/mm/book3s64/radix_hugetlbpage.c
@@ -41,61 +41,6 @@ void radix__flush_hugetlb_tlb_range(struct vm_area_struct *vma, unsigned long st
 		radix__flush_tlb_range_psize(vma->vm_mm, start, end, psize);
 }
 
-/*
- * A vairant of hugetlb_get_unmapped_area doing topdown search
- * FIXME!! should we do as x86 does or non hugetlb area does ?
- * ie, use topdown or not based on mmap_is_legacy check ?
- */
-unsigned long
-radix__hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
-				unsigned long len, unsigned long pgoff,
-				unsigned long flags)
-{
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
-	struct hstate *h = hstate_file(file);
-	int fixed = (flags & MAP_FIXED);
-	unsigned long high_limit;
-	struct vm_unmapped_area_info info;
-
-	high_limit = DEFAULT_MAP_WINDOW;
-	if (addr >= high_limit || (fixed && (addr + len > high_limit)))
-		high_limit = TASK_SIZE;
-
-	if (len & ~huge_page_mask(h))
-		return -EINVAL;
-	if (len > high_limit)
-		return -ENOMEM;
-
-	if (fixed) {
-		if (addr > high_limit - len)
-			return -ENOMEM;
-		if (prepare_hugepage_range(file, addr, len))
-			return -EINVAL;
-		return addr;
-	}
-
-	if (addr) {
-		addr = ALIGN(addr, huge_page_size(h));
-		vma = find_vma(mm, addr);
-		if (high_limit - len >= addr && addr >= mmap_min_addr &&
-		    (!vma || addr + len <= vm_start_gap(vma)))
-			return addr;
-	}
-	/*
-	 * We are always doing an topdown search here. Slice code
-	 * does that too.
-	 */
-	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
-	info.length = len;
-	info.low_limit = max(PAGE_SIZE, mmap_min_addr);
-	info.high_limit = mm->mmap_base + (high_limit - DEFAULT_MAP_WINDOW);
-	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
-	info.align_offset = 0;
-
-	return vm_unmapped_area(&info);
-}
-
 void radix__huge_ptep_modify_prot_commit(struct vm_area_struct *vma,
 					 unsigned long addr, pte_t *ptep,
 					 pte_t old_pte, pte_t pte)
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index f71ac14018e2..a87c886042e9 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -553,11 +553,9 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 					unsigned long len, unsigned long pgoff,
 					unsigned long flags)
 {
-#ifdef CONFIG_PPC_RADIX_MMU
 	if (radix_enabled())
-		return radix__hugetlb_get_unmapped_area(file, addr, len,
+		return generic_hugetlb_get_unmapped_area(file, addr, len,
 						       pgoff, flags);
-#endif
 #ifdef CONFIG_PPC_64S_HASH_MMU
 	return slice_get_unmapped_area(addr, len, flags, file_to_psize(file), 1);
 #endif
-- 
2.34.1

