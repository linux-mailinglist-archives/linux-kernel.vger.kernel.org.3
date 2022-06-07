Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D65A53FF15
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243998AbiFGMlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243913AbiFGMky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:40:54 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1583C336
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 05:40:54 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LHVLM4l4XzjXS5;
        Tue,  7 Jun 2022 20:39:55 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 7 Jun 2022 20:40:52 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 7 Jun 2022 20:40:51 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <akpm@linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, <hch@infradead.org>, <arnd@arndb.de>,
        <anshuman.khandual@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v5 6/6] arm64: Add HAVE_IOREMAP_PROT support
Date:   Tue, 7 Jun 2022 20:50:27 +0800
Message-ID: <20220607125027.44946-7-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220607125027.44946-1-wangkefeng.wang@huawei.com>
References: <20220607125027.44946-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With ioremap_prot() definition from generic ioremap, also move
pte_pgprot() from hugetlbpage.c into pgtable.h, then arm64 could
have HAVE_IOREMAP_PROT, which will enable generic_access_phys()
code, it is useful for debug, eg, gdb.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 .../features/vm/ioremap_prot/arch-support.txt          |  2 +-
 arch/arm64/Kconfig                                     |  1 +
 arch/arm64/include/asm/pgtable.h                       | 10 ++++++++++
 arch/arm64/mm/hugetlbpage.c                            | 10 ----------
 4 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/Documentation/features/vm/ioremap_prot/arch-support.txt b/Documentation/features/vm/ioremap_prot/arch-support.txt
index 205a90e82050..a710bd99c32e 100644
--- a/Documentation/features/vm/ioremap_prot/arch-support.txt
+++ b/Documentation/features/vm/ioremap_prot/arch-support.txt
@@ -9,7 +9,7 @@
     |       alpha: | TODO |
     |         arc: |  ok  |
     |         arm: | TODO |
-    |       arm64: | TODO |
+    |       arm64: |  ok  |
     |        csky: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index ac160aa26126..1267f325d32b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -189,6 +189,7 @@ config ARM64
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_GCC_PLUGINS
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS
+	select HAVE_IOREMAP_PROT
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select HAVE_KVM
 	select HAVE_NMI
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 0b6632f18364..5a2eb6232e69 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -427,6 +427,16 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
 	return clear_pte_bit(pte, __pgprot(PTE_SWP_EXCLUSIVE));
 }
 
+/*
+ * Select all bits except the pfn
+ */
+static inline pgprot_t pte_pgprot(pte_t pte)
+{
+	unsigned long pfn = pte_pfn(pte);
+
+	return __pgprot(pte_val(pfn_pte(pfn, __pgprot(0))) ^ pte_val(pte));
+}
+
 #ifdef CONFIG_NUMA_BALANCING
 /*
  * See the comment in include/linux/pgtable.h
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index e2a5ec9fdc0d..8eab05367549 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -100,16 +100,6 @@ int pud_huge(pud_t pud)
 #endif
 }
 
-/*
- * Select all bits except the pfn
- */
-static inline pgprot_t pte_pgprot(pte_t pte)
-{
-	unsigned long pfn = pte_pfn(pte);
-
-	return __pgprot(pte_val(pfn_pte(pfn, __pgprot(0))) ^ pte_val(pte));
-}
-
 static int find_num_contig(struct mm_struct *mm, unsigned long addr,
 			   pte_t *ptep, size_t *pgsize)
 {
-- 
2.35.3

