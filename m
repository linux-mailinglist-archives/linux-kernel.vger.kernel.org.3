Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E78953FF12
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243973AbiFGMlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243917AbiFGMky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:40:54 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680BEDBE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 05:40:53 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LHVKw64XnzjZmL;
        Tue,  7 Jun 2022 20:39:32 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 7 Jun 2022 20:40:51 +0800
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
Subject: [PATCH v5 5/6] arm64: mm: Convert to GENERIC_IOREMAP
Date:   Tue, 7 Jun 2022 20:50:26 +0800
Message-ID: <20220607125027.44946-6-wangkefeng.wang@huawei.com>
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

Add hook for arm64's special operation when ioremap(), then
ioremap_wc/np/cache is converted to use ioremap_prot() from
GENERIC_IOREMAP, update the Copyright and kill the unused
inclusions.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/Kconfig          |  1 +
 arch/arm64/include/asm/io.h | 24 +++++++---
 arch/arm64/kernel/acpi.c    |  2 +-
 arch/arm64/mm/ioremap.c     | 90 ++++---------------------------------
 4 files changed, 28 insertions(+), 89 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1652a9800ebe..ac160aa26126 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -126,6 +126,7 @@ config ARM64
 	select GENERIC_CPU_VULNERABILITIES
 	select GENERIC_EARLY_IOREMAP
 	select GENERIC_IDLE_POLL_SETUP
+	select GENERIC_IOREMAP
 	select GENERIC_IRQ_IPI
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 3995652daf81..87dd42d74afe 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -163,13 +163,16 @@ extern void __memset_io(volatile void __iomem *, int, size_t);
 /*
  * I/O memory mapping functions.
  */
-extern void __iomem *__ioremap(phys_addr_t phys_addr, size_t size, pgprot_t prot);
-extern void iounmap(volatile void __iomem *addr);
-extern void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size);
 
-#define ioremap(addr, size)		__ioremap((addr), (size), __pgprot(PROT_DEVICE_nGnRE))
-#define ioremap_wc(addr, size)		__ioremap((addr), (size), __pgprot(PROT_NORMAL_NC))
-#define ioremap_np(addr, size)		__ioremap((addr), (size), __pgprot(PROT_DEVICE_nGnRnE))
+bool ioremap_allowed(phys_addr_t phys_addr, size_t size, unsigned long prot);
+#define ioremap_allowed ioremap_allowed
+
+#define _PAGE_IOREMAP PROT_DEVICE_nGnRE
+
+#define ioremap_wc(addr, size)	\
+	ioremap_prot((addr), (size), PROT_NORMAL_NC)
+#define ioremap_np(addr, size)	\
+	ioremap_prot((addr), (size), PROT_DEVICE_nGnRnE)
 
 /*
  * io{read,write}{16,32,64}be() macros
@@ -184,6 +187,15 @@ extern void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size);
 
 #include <asm-generic/io.h>
 
+#define ioremap_cache ioremap_cache
+static inline void __iomem *ioremap_cache(phys_addr_t addr, size_t size)
+{
+	if (pfn_is_map_memory(__phys_to_pfn(addr)))
+		return (void __iomem *)__phys_to_virt(addr);
+
+	return ioremap_prot(addr, size, PROT_NORMAL);
+}
+
 /*
  * More restrictive address range checking than the default implementation
  * (PHYS_OFFSET and PHYS_MASK taken into account).
diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index e4dea8db6924..a5a256e3f9fe 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -351,7 +351,7 @@ void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
 				prot = __acpi_get_writethrough_mem_attribute();
 		}
 	}
-	return __ioremap(phys, size, prot);
+	return ioremap_prot(phys, size, pgprot_val(prot));
 }
 
 /*
diff --git a/arch/arm64/mm/ioremap.c b/arch/arm64/mm/ioremap.c
index b21f91cd830d..c5af103d4ad4 100644
--- a/arch/arm64/mm/ioremap.c
+++ b/arch/arm64/mm/ioremap.c
@@ -1,96 +1,22 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/*
- * Based on arch/arm/mm/ioremap.c
- *
- * (C) Copyright 1995 1996 Linus Torvalds
- * Hacked for ARM by Phil Blundell <philb@gnu.org>
- * Hacked to allow all architectures to build, and various cleanups
- * by Russell King
- * Copyright (C) 2012 ARM Ltd.
- */
 
-#include <linux/export.h>
 #include <linux/mm.h>
-#include <linux/vmalloc.h>
 #include <linux/io.h>
 
-#include <asm/fixmap.h>
-#include <asm/tlbflush.h>
-
-static void __iomem *__ioremap_caller(phys_addr_t phys_addr, size_t size,
-				      pgprot_t prot, void *caller)
+bool ioremap_allowed(phys_addr_t phys_addr, size_t size, unsigned long prot)
 {
-	unsigned long last_addr;
-	unsigned long offset = phys_addr & ~PAGE_MASK;
-	int err;
-	unsigned long addr;
-	struct vm_struct *area;
+	unsigned long last_addr = phys_addr + size - 1;
 
-	/*
-	 * Page align the mapping address and size, taking account of any
-	 * offset.
-	 */
-	phys_addr &= PAGE_MASK;
-	size = PAGE_ALIGN(size + offset);
+	/* Don't allow outside PHYS_MASK */
+	if (last_addr & ~PHYS_MASK)
+		return false;
 
-	/*
-	 * Don't allow wraparound, zero size or outside PHYS_MASK.
-	 */
-	last_addr = phys_addr + size - 1;
-	if (!size || last_addr < phys_addr || (last_addr & ~PHYS_MASK))
-		return NULL;
-
-	/*
-	 * Don't allow RAM to be mapped.
-	 */
+	/* Don't allow RAM to be mapped. */
 	if (WARN_ON(pfn_is_map_memory(__phys_to_pfn(phys_addr))))
-		return NULL;
-
-	area = get_vm_area_caller(size, VM_IOREMAP, caller);
-	if (!area)
-		return NULL;
-	addr = (unsigned long)area->addr;
-	area->phys_addr = phys_addr;
-
-	err = ioremap_page_range(addr, addr + size, phys_addr, prot);
-	if (err) {
-		vunmap((void *)addr);
-		return NULL;
-	}
-
-	return (void __iomem *)(offset + addr);
-}
-
-void __iomem *__ioremap(phys_addr_t phys_addr, size_t size, pgprot_t prot)
-{
-	return __ioremap_caller(phys_addr, size, prot,
-				__builtin_return_address(0));
-}
-EXPORT_SYMBOL(__ioremap);
-
-void iounmap(volatile void __iomem *io_addr)
-{
-	unsigned long addr = (unsigned long)io_addr & PAGE_MASK;
-
-	/*
-	 * We could get an address outside vmalloc range in case
-	 * of ioremap_cache() reusing a RAM mapping.
-	 */
-	if (is_vmalloc_addr((void *)addr))
-		vunmap((void *)addr);
-}
-EXPORT_SYMBOL(iounmap);
-
-void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size)
-{
-	/* For normal memory we already have a cacheable mapping. */
-	if (pfn_is_map_memory(__phys_to_pfn(phys_addr)))
-		return (void __iomem *)__phys_to_virt(phys_addr);
+		return false;
 
-	return __ioremap_caller(phys_addr, size, __pgprot(PROT_NORMAL),
-				__builtin_return_address(0));
+	return true;
 }
-EXPORT_SYMBOL(ioremap_cache);
 
 /*
  * Must be called after early_fixmap_init
-- 
2.35.3

