Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D404D3824
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235484AbiCIRqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 12:46:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234624AbiCIRqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 12:46:45 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7420BE0A3A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 09:45:45 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KDKN82p0Rz9sTN;
        Wed,  9 Mar 2022 18:45:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XZwzUNObVliR; Wed,  9 Mar 2022 18:45:12 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KDKN01j0jz9sTK;
        Wed,  9 Mar 2022 18:45:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 210918B78F;
        Wed,  9 Mar 2022 18:45:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Mes7MUy_4VDf; Wed,  9 Mar 2022 18:45:04 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.27])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EDA788B78D;
        Wed,  9 Mar 2022 18:45:02 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 229Hixj63619059
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 9 Mar 2022 18:44:59 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 229HixX13619058;
        Wed, 9 Mar 2022 18:44:59 +0100
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
Subject: [PATCH v8 11/14] powerpc/mm: Move get_unmapped_area functions to slice.c
Date:   Wed,  9 Mar 2022 18:44:45 +0100
Message-Id: <b535b6ba8df9a662f447e4c99245d1c5654709c6.1646847562.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1646847561.git.christophe.leroy@csgroup.eu>
References: <cover.1646847561.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1646847882; l=6292; s=20211009; h=from:subject:message-id; bh=GOyG/qMpUqSd5iEj5rG9eNuCmHPmjaUZAaa/WKmIMyc=; b=lzbAK7eiJX6hlsikjxohcMD9ufWntGnzhFqgIM6pBNja6m0SuEjgCvatTGDma/IDLbYBAxTngZR4 cr1NNqvGAPin19xHrE+Wgu1rQS7EEQJx7nqbYKrx4I2MECZa3V7Z
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

hugetlb_get_unmapped_area() is now identical to the
generic version if only RADIX is enabled, so move it
to slice.c and let it fallback on the generic one
when HASH MMU is not compiled in.

Do the same with arch_get_unmapped_area() and
arch_get_unmapped_area_topdown().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/book3s/64/mmu.h   |  6 ----
 arch/powerpc/include/asm/book3s/64/slice.h |  6 ++++
 arch/powerpc/mm/book3s64/slice.c           | 42 ++++++++++++++++++++++
 arch/powerpc/mm/hugetlbpage.c              | 21 -----------
 arch/powerpc/mm/mmap.c                     | 36 -------------------
 5 files changed, 48 insertions(+), 63 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index 006cbec70ffe..570a4960cf17 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -4,12 +4,6 @@
 
 #include <asm/page.h>
 
-#ifdef CONFIG_HUGETLB_PAGE
-#define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
-#endif
-#define HAVE_ARCH_UNMAPPED_AREA
-#define HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
-
 #ifndef __ASSEMBLY__
 /*
  * Page size definition
diff --git a/arch/powerpc/include/asm/book3s/64/slice.h b/arch/powerpc/include/asm/book3s/64/slice.h
index 5b0f7105bc8b..b8eb4ad271b9 100644
--- a/arch/powerpc/include/asm/book3s/64/slice.h
+++ b/arch/powerpc/include/asm/book3s/64/slice.h
@@ -4,6 +4,12 @@
 
 #ifndef __ASSEMBLY__
 
+#ifdef CONFIG_HUGETLB_PAGE
+#define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
+#endif
+#define HAVE_ARCH_UNMAPPED_AREA
+#define HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
+
 #define SLICE_LOW_SHIFT		28
 #define SLICE_LOW_TOP		(0x100000000ul)
 #define SLICE_NUM_LOW		(SLICE_LOW_TOP >> SLICE_LOW_SHIFT)
diff --git a/arch/powerpc/mm/book3s64/slice.c b/arch/powerpc/mm/book3s64/slice.c
index e4382713746d..03681042b807 100644
--- a/arch/powerpc/mm/book3s64/slice.c
+++ b/arch/powerpc/mm/book3s64/slice.c
@@ -639,6 +639,32 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 }
 EXPORT_SYMBOL_GPL(slice_get_unmapped_area);
 
+unsigned long arch_get_unmapped_area(struct file *filp,
+				     unsigned long addr,
+				     unsigned long len,
+				     unsigned long pgoff,
+				     unsigned long flags)
+{
+	if (radix_enabled())
+		return generic_get_unmapped_area(filp, addr, len, pgoff, flags);
+
+	return slice_get_unmapped_area(addr, len, flags,
+				       mm_ctx_user_psize(&current->mm->context), 0);
+}
+
+unsigned long arch_get_unmapped_area_topdown(struct file *filp,
+					     const unsigned long addr0,
+					     const unsigned long len,
+					     const unsigned long pgoff,
+					     const unsigned long flags)
+{
+	if (radix_enabled())
+		return generic_get_unmapped_area_topdown(filp, addr0, len, pgoff, flags);
+
+	return slice_get_unmapped_area(addr0, len, flags,
+				       mm_ctx_user_psize(&current->mm->context), 1);
+}
+
 unsigned int notrace get_slice_psize(struct mm_struct *mm, unsigned long addr)
 {
 	unsigned char *psizes;
@@ -766,4 +792,20 @@ unsigned long vma_mmu_pagesize(struct vm_area_struct *vma)
 
 	return 1UL << mmu_psize_to_shift(get_slice_psize(vma->vm_mm, vma->vm_start));
 }
+
+static int file_to_psize(struct file *file)
+{
+	struct hstate *hstate = hstate_file(file);
+	return shift_to_mmu_psize(huge_page_shift(hstate));
+}
+
+unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
+					unsigned long len, unsigned long pgoff,
+					unsigned long flags)
+{
+	if (radix_enabled())
+		return generic_hugetlb_get_unmapped_area(file, addr, len, pgoff, flags);
+
+	return slice_get_unmapped_area(addr, len, flags, file_to_psize(file), 1);
+}
 #endif
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index a87c886042e9..b282af39fcf6 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -542,27 +542,6 @@ struct page *follow_huge_pd(struct vm_area_struct *vma,
 	return page;
 }
 
-#ifdef HAVE_ARCH_HUGETLB_UNMAPPED_AREA
-static inline int file_to_psize(struct file *file)
-{
-	struct hstate *hstate = hstate_file(file);
-	return shift_to_mmu_psize(huge_page_shift(hstate));
-}
-
-unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
-					unsigned long len, unsigned long pgoff,
-					unsigned long flags)
-{
-	if (radix_enabled())
-		return generic_hugetlb_get_unmapped_area(file, addr, len,
-						       pgoff, flags);
-#ifdef CONFIG_PPC_64S_HASH_MMU
-	return slice_get_unmapped_area(addr, len, flags, file_to_psize(file), 1);
-#endif
-	BUG();
-}
-#endif
-
 bool __init arch_hugetlb_valid_size(unsigned long size)
 {
 	int shift = __ffs(size);
diff --git a/arch/powerpc/mm/mmap.c b/arch/powerpc/mm/mmap.c
index 46781d0103d1..5972d619d274 100644
--- a/arch/powerpc/mm/mmap.c
+++ b/arch/powerpc/mm/mmap.c
@@ -80,42 +80,6 @@ static inline unsigned long mmap_base(unsigned long rnd,
 	return PAGE_ALIGN(DEFAULT_MAP_WINDOW - gap - rnd);
 }
 
-#ifdef HAVE_ARCH_UNMAPPED_AREA
-unsigned long arch_get_unmapped_area(struct file *filp,
-				     unsigned long addr,
-				     unsigned long len,
-				     unsigned long pgoff,
-				     unsigned long flags)
-{
-	if (radix_enabled())
-		return generic_get_unmapped_area(filp, addr, len, pgoff, flags);
-
-#ifdef CONFIG_PPC_64S_HASH_MMU
-	return slice_get_unmapped_area(addr, len, flags,
-				       mm_ctx_user_psize(&current->mm->context), 0);
-#else
-	BUG();
-#endif
-}
-
-unsigned long arch_get_unmapped_area_topdown(struct file *filp,
-					     const unsigned long addr0,
-					     const unsigned long len,
-					     const unsigned long pgoff,
-					     const unsigned long flags)
-{
-	if (radix_enabled())
-		return generic_get_unmapped_area_topdown(filp, addr0, len, pgoff, flags);
-
-#ifdef CONFIG_PPC_64S_HASH_MMU
-	return slice_get_unmapped_area(addr0, len, flags,
-				       mm_ctx_user_psize(&current->mm->context), 1);
-#else
-	BUG();
-#endif
-}
-#endif /* HAVE_ARCH_UNMAPPED_AREA */
-
 /*
  * This function, called very early during the creation of a new
  * process VM image, sets up which VM layout function to use:
-- 
2.34.1

