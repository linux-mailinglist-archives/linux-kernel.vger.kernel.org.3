Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8AF4DC7F3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 14:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234718AbiCQNyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 09:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234711AbiCQNyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 09:54:43 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFEFDFFA2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 06:53:27 -0700 (PDT)
Received: from kwepemi500021.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KK7pf4XZRzCqmX;
        Thu, 17 Mar 2022 21:51:22 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi500021.china.huawei.com (7.221.188.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 17 Mar 2022 21:53:24 +0800
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 21:53:23 +0800
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
Subject: [PATCH -next 1/4] mm: page_table_check: move pxx_user_accessible_page into x86
Date:   Thu, 17 Mar 2022 14:12:00 +0000
Message-ID: <20220317141203.3646253-2-tongtiangen@huawei.com>
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

The pxx_user_accessible_page() check the PTE bit, it's
architecture-specific code, move them into x86's pgtable.h,
also add default PMD/PUD_PAGE_SIZE definition, it's prepare
for support page table check feature on new architecture.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/x86/include/asm/pgtable.h | 19 +++++++++++++++++++
 mm/page_table_check.c          | 25 ++++++++-----------------
 2 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 62ab07e24aef..8cd6514e3052 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1430,6 +1430,25 @@ static inline bool arch_faults_on_old_pte(void)
 	return false;
 }
 
+#ifdef CONFIG_PAGE_TABLE_CHECK
+static inline bool pte_user_accessible_page(pte_t pte)
+{
+	return (pte_val(pte) & _PAGE_PRESENT) && (pte_val(pte) & _PAGE_USER);
+}
+
+static inline bool pmd_user_accessible_page(pmd_t pmd)
+{
+	return pmd_leaf(pmd) && (pmd_val(pmd) & _PAGE_PRESENT) &&
+		(pmd_val(pmd) & _PAGE_USER);
+}
+
+static inline bool pud_user_accessible_page(pud_t pud)
+{
+	return pud_leaf(pud) && (pud_val(pud) & _PAGE_PRESENT) &&
+		(pud_val(pud) & _PAGE_USER);
+}
+#endif
+
 #endif	/* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_PGTABLE_H */
diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index 2458281bff89..145f059d1c4d 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -10,6 +10,14 @@
 #undef pr_fmt
 #define pr_fmt(fmt)	"page_table_check: " fmt
 
+#ifndef PMD_PAGE_SIZE
+#define PMD_PAGE_SIZE	PMD_SIZE
+#endif
+
+#ifndef PUD_PAGE_SIZE
+#define PUD_PAGE_SIZE	PUD_SIZE
+#endif
+
 struct page_table_check {
 	atomic_t anon_map_count;
 	atomic_t file_map_count;
@@ -52,23 +60,6 @@ static struct page_table_check *get_page_table_check(struct page_ext *page_ext)
 	return (void *)(page_ext) + page_table_check_ops.offset;
 }
 
-static inline bool pte_user_accessible_page(pte_t pte)
-{
-	return (pte_val(pte) & _PAGE_PRESENT) && (pte_val(pte) & _PAGE_USER);
-}
-
-static inline bool pmd_user_accessible_page(pmd_t pmd)
-{
-	return pmd_leaf(pmd) && (pmd_val(pmd) & _PAGE_PRESENT) &&
-		(pmd_val(pmd) & _PAGE_USER);
-}
-
-static inline bool pud_user_accessible_page(pud_t pud)
-{
-	return pud_leaf(pud) && (pud_val(pud) & _PAGE_PRESENT) &&
-		(pud_val(pud) & _PAGE_USER);
-}
-
 /*
  * An enty is removed from the page table, decrement the counters for that page
  * verify that it is of correct type and counters do not become negative.
-- 
2.18.0.huawei.25

