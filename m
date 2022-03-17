Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466414DC7F9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 14:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234727AbiCQNzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 09:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234710AbiCQNzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 09:55:07 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4257EF7A3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 06:53:36 -0700 (PDT)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KK7pr2lctzCqmy;
        Thu, 17 Mar 2022 21:51:32 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi500024.china.huawei.com (7.221.188.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 17 Mar 2022 21:53:34 +0800
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 21:53:33 +0800
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
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>,
        Tong Tiangen <tongtiangen@huawei.com>
Subject: [PATCH -next 3/4] arm64: mm: add support for page table check
Date:   Thu, 17 Mar 2022 14:12:02 +0000
Message-ID: <20220317141203.3646253-4-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
In-Reply-To: <20220317141203.3646253-1-tongtiangen@huawei.com>
References: <20220317141203.3646253-1-tongtiangen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

From: Kefeng Wang <wangkefeng.wang@huawei.com>

As commit d283d422c6c4 ("x86: mm: add x86_64 support for page table
check"), add some necessary page table check hooks into routines that
modify user page tables.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/Kconfig               |  1 +
 arch/arm64/include/asm/pgtable.h | 63 +++++++++++++++++++++++++++++---
 2 files changed, 59 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 962c84952c98..1880dd0a8a11 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -91,6 +91,7 @@ config ARM64
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
 	select ARCH_SUPPORTS_NUMA_BALANCING
+	select ARCH_SUPPORTS_PAGE_TABLE_CHECK
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION if COMPAT
 	select ARCH_WANT_DEFAULT_BPF_JIT
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 94e147e5456c..2ea6b5e268d0 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -33,6 +33,7 @@
 #include <linux/mmdebug.h>
 #include <linux/mm_types.h>
 #include <linux/sched.h>
+#include <linux/page_table_check.h>
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #define __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
@@ -312,7 +313,7 @@ static inline void __check_racy_pte_update(struct mm_struct *mm, pte_t *ptep,
 		     __func__, pte_val(old_pte), pte_val(pte));
 }
 
-static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
+static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
 			      pte_t *ptep, pte_t pte)
 {
 	if (pte_present(pte) && pte_user_exec(pte) && !pte_special(pte))
@@ -343,6 +344,13 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 	set_pte(ptep, pte);
 }
 
+static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
+			      pte_t *ptep, pte_t pte)
+{
+	page_table_check_pte_set(mm, addr, ptep, pte);
+	return __set_pte_at(mm, addr, ptep, pte);
+}
+
 /*
  * Huge pte definitions.
  */
@@ -485,8 +493,19 @@ static inline pmd_t pmd_mkdevmap(pmd_t pmd)
 #define pud_pfn(pud)		((__pud_to_phys(pud) & PUD_MASK) >> PAGE_SHIFT)
 #define pfn_pud(pfn,prot)	__pud(__phys_to_pud_val((phys_addr_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot))
 
-#define set_pmd_at(mm, addr, pmdp, pmd)	set_pte_at(mm, addr, (pte_t *)pmdp, pmd_pte(pmd))
-#define set_pud_at(mm, addr, pudp, pud)	set_pte_at(mm, addr, (pte_t *)pudp, pud_pte(pud))
+static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
+			      pmd_t *pmdp, pmd_t pmd)
+{
+	page_table_check_pmd_set(mm, addr, pmdp, pmd);
+	return __set_pte_at(mm, addr, (pte_t *)pmdp, pmd_pte(pmd));
+}
+
+static inline void set_pud_at(struct mm_struct *mm, unsigned long addr,
+			      pud_t *pudp, pud_t pud)
+{
+	page_table_check_pud_set(mm, addr, pudp, pud);
+	return __set_pte_at(mm, addr, (pte_t *)pudp, pud_pte(pud));
+}
 
 #define __p4d_to_phys(p4d)	__pte_to_phys(p4d_pte(p4d))
 #define __phys_to_p4d_val(phys)	__phys_to_pte_val(phys)
@@ -628,6 +647,25 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 #define pud_leaf(pud)		pud_sect(pud)
 #define pud_valid(pud)		pte_valid(pud_pte(pud))
 
+#ifdef CONFIG_PAGE_TABLE_CHECK
+static inline bool pte_user_accessible_page(pte_t pte)
+{
+	return (pte_val(pte) & PTE_VALID) && (pte_val(pte) & PTE_USER);
+}
+
+static inline bool pmd_user_accessible_page(pmd_t pmd)
+{
+	return pmd_leaf(pmd) && (pmd_val(pmd) & PTE_VALID) &&
+		(pmd_val(pmd) & PTE_USER);
+}
+
+static inline bool pud_user_accessible_page(pud_t pud)
+{
+	return pud_leaf(pud) && (pud_val(pud) & PTE_VALID) &&
+		(pud_val(pud) & PTE_USER);
+}
+#endif
+
 static inline void set_pud(pud_t *pudp, pud_t pud)
 {
 #ifdef __PAGETABLE_PUD_FOLDED
@@ -856,11 +894,21 @@ static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
+static inline pte_t __ptep_get_and_clear(struct mm_struct *mm,
+				       unsigned long address, pte_t *ptep)
+{
+	return __pte(xchg_relaxed(&pte_val(*ptep), 0));
+}
+
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 				       unsigned long address, pte_t *ptep)
 {
-	return __pte(xchg_relaxed(&pte_val(*ptep), 0));
+	pte_t pte = __ptep_get_and_clear(mm, address, ptep);
+
+	page_table_check_pte_clear(mm, address, pte);
+
+	return pte;
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -868,7 +916,11 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
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
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
@@ -902,6 +954,7 @@ static inline void pmdp_set_wrprotect(struct mm_struct *mm,
 static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 		unsigned long address, pmd_t *pmdp, pmd_t pmd)
 {
+	page_table_check_pmd_set(vma->vm_mm, address, pmdp, pmd);
 	return __pmd(xchg_relaxed(&pmd_val(*pmdp), pmd_val(pmd)));
 }
 #endif
-- 
2.18.0.huawei.25

