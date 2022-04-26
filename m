Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2EE50F319
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344397AbiDZHzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242699AbiDZHzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:55:11 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B0063E6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:52:05 -0700 (PDT)
Received: from kwepemi500019.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KnYrM4BXWzCsLx;
        Tue, 26 Apr 2022 15:47:31 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi500019.china.huawei.com (7.221.188.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Apr 2022 15:52:03 +0800
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Apr 2022 15:52:01 +0800
From:   Tong Tiangen <tongtiangen@huawei.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Guohanjun <guohanjun@huawei.com>
Subject: [PATCH -next v6 3/6] mm: page_table_check: add hooks to public helpers
Date:   Tue, 26 Apr 2022 08:10:33 +0000
Message-ID: <20220426081036.1374452-4-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426081036.1374452-1-tongtiangen@huawei.com>
References: <20220426081036.1374452-1-tongtiangen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move ptep_clear() to the include/linux/pgtable.h and add page table check
relate hooks to some helpers, it's prepare for support page table check
feature on new architecture.

Optimize the implementation of ptep_clear(), page table hooks added page
table check stubs, the interface control should be at stubs, there is no
rationale for doing a IS_ENABLED() check here.

For architectures that do not enable CONFIG_PAGE_TABLE_CHECK, they will
call a fallback page table check stubs[1] when getting their page table
helpers[2] in include/linux/pgtable.h.

[1] page table check stubs defined in include/linux/page_table_check.h
[2] ptep_clear() ptep_get_and_clear()  pmdp_huge_get_and_clear()
pudp_huge_get_and_clear()

Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 arch/x86/include/asm/pgtable.h | 10 ----------
 include/linux/pgtable.h        | 23 +++++++++++++++--------
 2 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 46fa65d818bd..44e2d6f1dbaa 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1072,16 +1072,6 @@ static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
 	return pte;
 }
 
-#define __HAVE_ARCH_PTEP_CLEAR
-static inline void ptep_clear(struct mm_struct *mm, unsigned long addr,
-			      pte_t *ptep)
-{
-	if (IS_ENABLED(CONFIG_PAGE_TABLE_CHECK))
-		ptep_get_and_clear(mm, addr, ptep);
-	else
-		pte_clear(mm, addr, ptep);
-}
-
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
 static inline void ptep_set_wrprotect(struct mm_struct *mm,
 				      unsigned long addr, pte_t *ptep)
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 530b1817b58c..3c825162c8da 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -12,6 +12,7 @@
 #include <linux/bug.h>
 #include <linux/errno.h>
 #include <asm-generic/pgtable_uffd.h>
+#include <linux/page_table_check.h>
 
 #if 5 - defined(__PAGETABLE_P4D_FOLDED) - defined(__PAGETABLE_PUD_FOLDED) - \
 	defined(__PAGETABLE_PMD_FOLDED) != CONFIG_PGTABLE_LEVELS
@@ -259,14 +260,6 @@ static inline int pmdp_clear_flush_young(struct vm_area_struct *vma,
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 #endif
 
-#ifndef __HAVE_ARCH_PTEP_CLEAR
-static inline void ptep_clear(struct mm_struct *mm, unsigned long addr,
-			      pte_t *ptep)
-{
-	pte_clear(mm, addr, ptep);
-}
-#endif
-
 #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 				       unsigned long address,
@@ -274,10 +267,19 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 {
 	pte_t pte = *ptep;
 	pte_clear(mm, address, ptep);
+	page_table_check_pte_clear(mm, address, pte);
 	return pte;
 }
 #endif
 
+#ifndef __HAVE_ARCH_PTEP_CLEAR
+static inline void ptep_clear(struct mm_struct *mm, unsigned long addr,
+			      pte_t *ptep)
+{
+	ptep_get_and_clear(mm, addr, ptep);
+}
+#endif
+
 #ifndef __HAVE_ARCH_PTEP_GET
 static inline pte_t ptep_get(pte_t *ptep)
 {
@@ -347,7 +349,10 @@ static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
 					    pmd_t *pmdp)
 {
 	pmd_t pmd = *pmdp;
+
 	pmd_clear(pmdp);
+	page_table_check_pmd_clear(mm, address, pmd);
+
 	return pmd;
 }
 #endif /* __HAVE_ARCH_PMDP_HUGE_GET_AND_CLEAR */
@@ -359,6 +364,8 @@ static inline pud_t pudp_huge_get_and_clear(struct mm_struct *mm,
 	pud_t pud = *pudp;
 
 	pud_clear(pudp);
+	page_table_check_pud_clear(mm, address, pud);
+
 	return pud;
 }
 #endif /* __HAVE_ARCH_PUDP_HUGE_GET_AND_CLEAR */
-- 
2.25.1

