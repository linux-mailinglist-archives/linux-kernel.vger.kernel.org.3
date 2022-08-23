Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5105159CECB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 04:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239784AbiHWCuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 22:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239777AbiHWCu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 22:50:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF8B5A3C7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 19:50:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3BEB7B81A5C
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 02:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C31C433D6;
        Tue, 23 Aug 2022 02:50:23 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Cleanup headers to avoid circular dependency
Date:   Tue, 23 Aug 2022 10:50:10 +0800
Message-Id: <20220823025010.3826452-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When enable GENERIC_IOREMAP, there will be circular dependency to cause
build errors. The root cause is that pgtable.h shouldn't include io.h
but pgtable.h need some macros defined in io.h. So cleanup those macros
and remove the unnecessary inclusions, as other architectures do.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/addrspace.h | 16 ++++++++++++++++
 arch/loongarch/include/asm/io.h        | 19 -------------------
 arch/loongarch/include/asm/page.h      |  2 +-
 arch/loongarch/include/asm/pgtable.h   |  7 +++----
 arch/loongarch/mm/mmap.c               | 11 ++---------
 5 files changed, 22 insertions(+), 33 deletions(-)

diff --git a/arch/loongarch/include/asm/addrspace.h b/arch/loongarch/include/asm/addrspace.h
index b91e0733b2e5..d342935e5a72 100644
--- a/arch/loongarch/include/asm/addrspace.h
+++ b/arch/loongarch/include/asm/addrspace.h
@@ -109,4 +109,20 @@ extern unsigned long vm_map_base;
  */
 #define PHYSADDR(a)		((_ACAST64_(a)) & TO_PHYS_MASK)
 
+/*
+ * On LoongArch, I/O ports mappring is following:
+ *
+ *              |         ....          |
+ *              |-----------------------|
+ *              | pci io ports(16K~32M) |
+ *              |-----------------------|
+ *              | isa io ports(0  ~16K) |
+ * PCI_IOBASE ->|-----------------------|
+ *              |         ....          |
+ */
+#define PCI_IOBASE	((void __iomem *)(vm_map_base + (2 * PAGE_SIZE)))
+#define PCI_IOSIZE	SZ_32M
+#define ISA_IOSIZE	SZ_16K
+#define IO_SPACE_LIMIT	(PCI_IOSIZE - 1)
+
 #endif /* _ASM_ADDRSPACE_H */
diff --git a/arch/loongarch/include/asm/io.h b/arch/loongarch/include/asm/io.h
index 884599739b36..999944ea1cea 100644
--- a/arch/loongarch/include/asm/io.h
+++ b/arch/loongarch/include/asm/io.h
@@ -7,34 +7,15 @@
 
 #define ARCH_HAS_IOREMAP_WC
 
-#include <linux/compiler.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 
 #include <asm/addrspace.h>
-#include <asm/bug.h>
-#include <asm/byteorder.h>
 #include <asm/cpu.h>
 #include <asm/page.h>
 #include <asm/pgtable-bits.h>
 #include <asm/string.h>
 
-/*
- * On LoongArch, I/O ports mappring is following:
- *
- *              |         ....          |
- *              |-----------------------|
- *              | pci io ports(64K~32M) |
- *              |-----------------------|
- *              | isa io ports(0  ~16K) |
- * PCI_IOBASE ->|-----------------------|
- *              |         ....          |
- */
-#define PCI_IOBASE	((void __iomem *)(vm_map_base + (2 * PAGE_SIZE)))
-#define PCI_IOSIZE	SZ_32M
-#define ISA_IOSIZE	SZ_16K
-#define IO_SPACE_LIMIT	(PCI_IOSIZE - 1)
-
 /*
  * Change "struct page" to physical address.
  */
diff --git a/arch/loongarch/include/asm/page.h b/arch/loongarch/include/asm/page.h
index a37324ac460b..53f284a96182 100644
--- a/arch/loongarch/include/asm/page.h
+++ b/arch/loongarch/include/asm/page.h
@@ -95,7 +95,7 @@ static inline int pfn_valid(unsigned long pfn)
 
 #endif
 
-#define virt_to_pfn(kaddr)	PFN_DOWN(virt_to_phys((void *)(kaddr)))
+#define virt_to_pfn(kaddr)	PFN_DOWN(PHYSADDR(kaddr))
 #define virt_to_page(kaddr)	pfn_to_page(virt_to_pfn(kaddr))
 
 extern int __virt_addr_valid(volatile void *kaddr);
diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
index e03443abaf7d..8ea57e2f0e04 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -59,7 +59,6 @@
 #include <linux/mm_types.h>
 #include <linux/mmzone.h>
 #include <asm/fixmap.h>
-#include <asm/io.h>
 
 struct mm_struct;
 struct vm_area_struct;
@@ -145,7 +144,7 @@ static inline void set_p4d(p4d_t *p4d, p4d_t p4dval)
 	*p4d = p4dval;
 }
 
-#define p4d_phys(p4d)		virt_to_phys((void *)p4d_val(p4d))
+#define p4d_phys(p4d)		PHYSADDR(p4d_val(p4d))
 #define p4d_page(p4d)		(pfn_to_page(p4d_phys(p4d) >> PAGE_SHIFT))
 
 #endif
@@ -188,7 +187,7 @@ static inline pmd_t *pud_pgtable(pud_t pud)
 
 #define set_pud(pudptr, pudval) do { *(pudptr) = (pudval); } while (0)
 
-#define pud_phys(pud)		virt_to_phys((void *)pud_val(pud))
+#define pud_phys(pud)		PHYSADDR(pud_val(pud))
 #define pud_page(pud)		(pfn_to_page(pud_phys(pud) >> PAGE_SHIFT))
 
 #endif
@@ -221,7 +220,7 @@ static inline void pmd_clear(pmd_t *pmdp)
 
 #define set_pmd(pmdptr, pmdval) do { *(pmdptr) = (pmdval); } while (0)
 
-#define pmd_phys(pmd)		virt_to_phys((void *)pmd_val(pmd))
+#define pmd_phys(pmd)		PHYSADDR(pmd_val(pmd))
 
 #ifndef CONFIG_TRANSPARENT_HUGEPAGE
 #define pmd_page(pmd)		(pfn_to_page(pmd_phys(pmd) >> PAGE_SHIFT))
diff --git a/arch/loongarch/mm/mmap.c b/arch/loongarch/mm/mmap.c
index 52e40f0ba732..381a569635a9 100644
--- a/arch/loongarch/mm/mmap.c
+++ b/arch/loongarch/mm/mmap.c
@@ -2,16 +2,9 @@
 /*
  * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
  */
-#include <linux/compiler.h>
-#include <linux/elf-randomize.h>
-#include <linux/errno.h>
+#include <linux/export.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
-#include <linux/export.h>
-#include <linux/personality.h>
-#include <linux/random.h>
-#include <linux/sched/signal.h>
-#include <linux/sched/mm.h>
 
 unsigned long shm_align_mask = PAGE_SIZE - 1;	/* Sane caches */
 EXPORT_SYMBOL(shm_align_mask);
@@ -120,6 +113,6 @@ int __virt_addr_valid(volatile void *kaddr)
 	if ((vaddr < PAGE_OFFSET) || (vaddr >= vm_map_base))
 		return 0;
 
-	return pfn_valid(PFN_DOWN(virt_to_phys(kaddr)));
+	return pfn_valid(PFN_DOWN(PHYSADDR(kaddr)));
 }
 EXPORT_SYMBOL_GPL(__virt_addr_valid);
-- 
2.31.1

