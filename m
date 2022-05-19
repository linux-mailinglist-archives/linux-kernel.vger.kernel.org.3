Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52FE52CE25
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 10:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235394AbiESISn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 04:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235321AbiESIRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 04:17:13 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7C265D13
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 01:17:09 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L3jLX12yJzQkGG;
        Thu, 19 May 2022 16:14:12 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 19 May 2022 16:17:07 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 19 May 2022 16:17:06 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <akpm@linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, <hch@infradead.org>, <arnd@arndb.de>,
        <anshuman.khandual@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3 6/6] arm64: Add HAVE_IOREMAP_PROT support
Date:   Thu, 19 May 2022 16:25:52 +0800
Message-ID: <20220519082552.117736-7-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220519082552.117736-1-wangkefeng.wang@huawei.com>
References: <20220519082552.117736-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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
index a6dcbe5f47b6..b39ad5d61216 100644
--- a/Documentation/features/vm/ioremap_prot/arch-support.txt
+++ b/Documentation/features/vm/ioremap_prot/arch-support.txt
@@ -9,7 +9,7 @@
     |       alpha: | TODO |
     |         arc: |  ok  |
     |         arm: | TODO |
-    |       arm64: | TODO |
+    |       arm64: |  ok  |
     |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 56673209fdb9..5e5889049af0 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -186,6 +186,7 @@ config ARM64
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_GCC_PLUGINS
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS
+	select HAVE_IOREMAP_PROT
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select HAVE_KVM
 	select HAVE_NMI
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index dff2b483ea50..1402a2739024 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -402,6 +402,16 @@ static inline pgprot_t mk_pmd_sect_prot(pgprot_t prot)
 	return __pgprot((pgprot_val(prot) & ~PMD_TABLE_BIT) | PMD_TYPE_SECT);
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
index cbace1c9e137..38d03406f6aa 100644
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

