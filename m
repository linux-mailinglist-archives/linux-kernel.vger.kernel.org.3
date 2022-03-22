Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD274E413E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 15:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237461AbiCVO2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 10:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbiCVO1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:27:32 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A882344F1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 07:26:02 -0700 (PDT)
Received: from kwepemi500023.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KNDFn2M8rzBrc4;
        Tue, 22 Mar 2022 22:22:05 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi500023.china.huawei.com (7.221.188.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 22 Mar 2022 22:26:00 +0800
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Mar 2022 22:25:59 +0800
From:   Tong Tiangen <tongtiangen@huawei.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>,
        Tong Tiangen <tongtiangen@huawei.com>
Subject: [PATCH -next v2 4/4] riscv: mm: add support for page table check
Date:   Tue, 22 Mar 2022 14:44:47 +0000
Message-ID: <20220322144447.3563146-5-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
In-Reply-To: <20220322144447.3563146-1-tongtiangen@huawei.com>
References: <20220322144447.3563146-1-tongtiangen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As commit d283d422c6c4 ("x86: mm: add x86_64 support for page table
check"), add some necessary page table check hooks into routines that
modify user page tables.

Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
---
 arch/riscv/Kconfig               |  1 +
 arch/riscv/include/asm/pgtable.h | 77 +++++++++++++++++++++++++++++---
 2 files changed, 72 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d140e066f758..710d591fb272 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -37,6 +37,7 @@ config RISCV
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_DEBUG_PAGEALLOC if MMU
 	select ARCH_SUPPORTS_HUGETLBFS if MMU
+	select ARCH_SUPPORTS_PAGE_TABLE_CHECK
 	select ARCH_USE_MEMTEST
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
 	select ARCH_WANT_FRAME_POINTERS
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 046b44225623..6f22d9580658 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -114,6 +114,8 @@
 #include <asm/pgtable-32.h>
 #endif /* CONFIG_64BIT */
 
+#include <linux/page_table_check.h>
+
 #ifdef CONFIG_XIP_KERNEL
 #define XIP_FIXUP(addr) ({							\
 	uintptr_t __a = (uintptr_t)(addr);					\
@@ -315,6 +317,11 @@ static inline int pte_exec(pte_t pte)
 	return pte_val(pte) & _PAGE_EXEC;
 }
 
+static inline int pte_user(pte_t pte)
+{
+	return pte_val(pte) & _PAGE_USER;
+}
+
 static inline int pte_huge(pte_t pte)
 {
 	return pte_present(pte) && (pte_val(pte) & _PAGE_LEAF);
@@ -446,7 +453,7 @@ static inline void set_pte(pte_t *ptep, pte_t pteval)
 
 void flush_icache_pte(pte_t pte);
 
-static inline void set_pte_at(struct mm_struct *mm,
+static inline void __set_pte_at(struct mm_struct *mm,
 	unsigned long addr, pte_t *ptep, pte_t pteval)
 {
 	if (pte_present(pteval) && pte_exec(pteval))
@@ -455,10 +462,17 @@ static inline void set_pte_at(struct mm_struct *mm,
 	set_pte(ptep, pteval);
 }
 
+static inline void set_pte_at(struct mm_struct *mm,
+	unsigned long addr, pte_t *ptep, pte_t pteval)
+{
+	page_table_check_pte_set(mm, addr, ptep, pteval);
+	__set_pte_at(mm, addr, ptep, pteval);
+}
+
 static inline void pte_clear(struct mm_struct *mm,
 	unsigned long addr, pte_t *ptep)
 {
-	set_pte_at(mm, addr, ptep, __pte(0));
+	__set_pte_at(mm, addr, ptep, __pte(0));
 }
 
 #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
@@ -475,11 +489,21 @@ static inline int ptep_set_access_flags(struct vm_area_struct *vma,
 	return true;
 }
 
+static inline pte_t __ptep_get_and_clear(struct mm_struct *mm,
+				       unsigned long address, pte_t *ptep)
+{
+	return __pte(atomic_long_xchg((atomic_long_t *)ptep, 0));
+}
+
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 				       unsigned long address, pte_t *ptep)
 {
-	return __pte(atomic_long_xchg((atomic_long_t *)ptep, 0));
+	pte_t pte = __ptep_get_and_clear(mm, address, ptep);
+
+	page_table_check_pte_clear(mm, address, pte);
+
+	return pte;
 }
 
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
@@ -546,6 +570,13 @@ static inline unsigned long pmd_pfn(pmd_t pmd)
 	return ((__pmd_to_phys(pmd) & PMD_MASK) >> PAGE_SHIFT);
 }
 
+#define __pud_to_phys(pud)  (pud_val(pud) >> _PAGE_PFN_SHIFT << PAGE_SHIFT)
+
+static inline unsigned long pud_pfn(pud_t pud)
+{
+	return ((__pud_to_phys(pud) & PUD_MASK) >> PAGE_SHIFT);
+}
+
 static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
 {
 	return pte_pmd(pte_modify(pmd_pte(pmd), newprot));
@@ -567,6 +598,11 @@ static inline int pmd_young(pmd_t pmd)
 	return pte_young(pmd_pte(pmd));
 }
 
+static inline int pmd_user(pmd_t pmd)
+{
+	return pte_user(pmd_pte(pmd));
+}
+
 static inline pmd_t pmd_mkold(pmd_t pmd)
 {
 	return pte_pmd(pte_mkold(pmd_pte(pmd)));
@@ -600,15 +636,39 @@ static inline pmd_t pmd_mkdirty(pmd_t pmd)
 static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 				pmd_t *pmdp, pmd_t pmd)
 {
-	return set_pte_at(mm, addr, (pte_t *)pmdp, pmd_pte(pmd));
+	page_table_check_pmd_set(mm, addr, pmdp, pmd);
+	return __set_pte_at(mm, addr, (pte_t *)pmdp, pmd_pte(pmd));
+}
+
+static inline int pud_user(pud_t pud)
+{
+	return pte_user(pud_pte(pud));
 }
 
 static inline void set_pud_at(struct mm_struct *mm, unsigned long addr,
 				pud_t *pudp, pud_t pud)
 {
-	return set_pte_at(mm, addr, (pte_t *)pudp, pud_pte(pud));
+	page_table_check_pud_set(mm, addr, pudp, pud);
+	return __set_pte_at(mm, addr, (pte_t *)pudp, pud_pte(pud));
+}
+
+#ifdef CONFIG_PAGE_TABLE_CHECK
+static inline bool pte_user_accessible_page(pte_t pte)
+{
+	return pte_present(pte) && pte_user(pte);
 }
 
+static inline bool pmd_user_accessible_page(pmd_t pmd)
+{
+	return pmd_leaf(pmd) && pmd_user(pmd);
+}
+
+static inline bool pud_user_accessible_page(pud_t pud)
+{
+	return pud_leaf(pud) && pud_user(pud);
+}
+#endif
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static inline int pmd_trans_huge(pmd_t pmd)
 {
@@ -634,7 +694,11 @@ static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
 static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
 					unsigned long address, pmd_t *pmdp)
 {
-	return pte_pmd(ptep_get_and_clear(mm, address, (pte_t *)pmdp));
+	pmd_t pmd = pte_pmd(__ptep_get_and_clear(mm, address, (pte_t *)pmdp));
+
+	page_table_check_pmd_clear(mm, address, pmd);
+
+	return pmd;
 }
 
 #define __HAVE_ARCH_PMDP_SET_WRPROTECT
@@ -648,6 +712,7 @@ static inline void pmdp_set_wrprotect(struct mm_struct *mm,
 static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 				unsigned long address, pmd_t *pmdp, pmd_t pmd)
 {
+	page_table_check_pmd_set(vma->vm_mm, address, pmdp, pmd);
 	return __pmd(atomic_long_xchg((atomic_long_t *)pmdp, pmd_val(pmd)));
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
-- 
2.18.0.huawei.25

