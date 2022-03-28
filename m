Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3E64E8BA3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 03:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237301AbiC1Bfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 21:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237289AbiC1Bfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 21:35:46 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EB9220E7
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 18:34:06 -0700 (PDT)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KRZr84wvGzBrX2;
        Mon, 28 Mar 2022 09:30:00 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi500024.china.huawei.com (7.221.188.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 28 Mar 2022 09:34:01 +0800
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Mar 2022 09:34:00 +0800
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
Subject: [PATCH -next v3 2/4] mm: page_table_check: add hooks to public helpers
Date:   Mon, 28 Mar 2022 01:52:40 +0000
Message-ID: <20220328015242.1136836-3-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
In-Reply-To: <20220328015242.1136836-1-tongtiangen@huawei.com>
References: <20220328015242.1136836-1-tongtiangen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move ptep_clear() to the include/linux/pgtable.h and add page table check
relate hooks to some helpers, it's prepare for support page table check
feature on new architecture.

Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
---
 arch/x86/include/asm/pgtable.h | 10 ----------
 include/linux/pgtable.h        | 26 ++++++++++++++++++--------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 8cd6514e3052..8c85f2eabbaa 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1077,16 +1077,6 @@ static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
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
index f4f4077b97aa..c7556fa53986 100644
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
@@ -274,10 +267,22 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
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
+	if (IS_ENABLED(CONFIG_PAGE_TABLE_CHECK))
+		ptep_get_and_clear(mm, addr, ptep);
+	else
+		pte_clear(mm, addr, ptep);
+}
+#endif
+
 #ifndef __HAVE_ARCH_PTEP_GET
 static inline pte_t ptep_get(pte_t *ptep)
 {
@@ -347,7 +352,10 @@ static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
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
@@ -359,6 +367,8 @@ static inline pud_t pudp_huge_get_and_clear(struct mm_struct *mm,
 	pud_t pud = *pudp;
 
 	pud_clear(pudp);
+	page_table_check_pud_clear(mm, address, pud);
+
 	return pud;
 }
 #endif /* __HAVE_ARCH_PUDP_HUGE_GET_AND_CLEAR */
-- 
2.18.0.huawei.25

