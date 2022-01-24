Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB66049800A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 13:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242754AbiAXM5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 07:57:44 -0500
Received: from foss.arm.com ([217.140.110.172]:32946 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242764AbiAXM5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 07:57:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DCF8ED1;
        Mon, 24 Jan 2022 04:57:42 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.43.190])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2B35A3F774;
        Mon, 24 Jan 2022 04:57:38 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, hch@infradead.org,
        akpm@linux-foundation.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-m68k@lists.linux-m68k.org
Subject: [RFC V1 08/31] m68k/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Date:   Mon, 24 Jan 2022 18:26:45 +0530
Message-Id: <1643029028-12710-9-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643029028-12710-1-git-send-email-anshuman.khandual@arm.com>
References: <1643029028-12710-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This defines and exports a platform specific custom vm_get_page_prot() via
subscribing ARCH_HAS_VM_GET_PAGE_PROT. Subsequently all __SXXX and __PXXX
macros can be dropped which are no longer needed.

Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/m68k/Kconfig                        |  1 +
 arch/m68k/include/asm/mcf_pgtable.h      | 59 ----------------
 arch/m68k/include/asm/motorola_pgtable.h | 22 ------
 arch/m68k/include/asm/sun3_pgtable.h     | 22 ------
 arch/m68k/mm/init.c                      | 87 ++++++++++++++++++++++++
 arch/m68k/mm/motorola.c                  | 44 +++++++++++-
 6 files changed, 129 insertions(+), 106 deletions(-)

diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 936e1803c7c7..114e65164692 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -11,6 +11,7 @@ config M68K
 	select ARCH_NO_PREEMPT if !COLDFIRE
 	select ARCH_USE_MEMTEST if MMU_MOTOROLA
 	select ARCH_WANT_IPC_PARSE_VERSION
+	select ARCH_HAS_VM_GET_PAGE_PROT
 	select BINFMT_FLAT_ARGVP_ENVP_ON_STACK
 	select DMA_DIRECT_REMAP if HAS_DMA && MMU && !COLDFIRE
 	select GENERIC_ATOMIC64
diff --git a/arch/m68k/include/asm/mcf_pgtable.h b/arch/m68k/include/asm/mcf_pgtable.h
index 6f2b87d7a50d..dc5c8ab6aa57 100644
--- a/arch/m68k/include/asm/mcf_pgtable.h
+++ b/arch/m68k/include/asm/mcf_pgtable.h
@@ -86,65 +86,6 @@
 				 | CF_PAGE_READABLE \
 				 | CF_PAGE_DIRTY)
 
-/*
- * Page protections for initialising protection_map. See mm/mmap.c
- * for use. In general, the bit positions are xwr, and P-items are
- * private, the S-items are shared.
- */
-#define __P000		PAGE_NONE
-#define __P001		__pgprot(CF_PAGE_VALID \
-				 | CF_PAGE_ACCESSED \
-				 | CF_PAGE_READABLE)
-#define __P010		__pgprot(CF_PAGE_VALID \
-				 | CF_PAGE_ACCESSED \
-				 | CF_PAGE_WRITABLE)
-#define __P011		__pgprot(CF_PAGE_VALID \
-				 | CF_PAGE_ACCESSED \
-				 | CF_PAGE_READABLE \
-				 | CF_PAGE_WRITABLE)
-#define __P100		__pgprot(CF_PAGE_VALID \
-				 | CF_PAGE_ACCESSED \
-				 | CF_PAGE_EXEC)
-#define __P101		__pgprot(CF_PAGE_VALID \
-				 | CF_PAGE_ACCESSED \
-				 | CF_PAGE_READABLE \
-				 | CF_PAGE_EXEC)
-#define __P110		__pgprot(CF_PAGE_VALID \
-				 | CF_PAGE_ACCESSED \
-				 | CF_PAGE_WRITABLE \
-				 | CF_PAGE_EXEC)
-#define __P111		__pgprot(CF_PAGE_VALID \
-				 | CF_PAGE_ACCESSED \
-				 | CF_PAGE_READABLE \
-				 | CF_PAGE_WRITABLE \
-				 | CF_PAGE_EXEC)
-
-#define __S000		PAGE_NONE
-#define __S001		__pgprot(CF_PAGE_VALID \
-				 | CF_PAGE_ACCESSED \
-				 | CF_PAGE_READABLE)
-#define __S010		PAGE_SHARED
-#define __S011		__pgprot(CF_PAGE_VALID \
-				 | CF_PAGE_ACCESSED \
-				 | CF_PAGE_SHARED \
-				 | CF_PAGE_READABLE)
-#define __S100		__pgprot(CF_PAGE_VALID \
-				 | CF_PAGE_ACCESSED \
-				 | CF_PAGE_EXEC)
-#define __S101		__pgprot(CF_PAGE_VALID \
-				 | CF_PAGE_ACCESSED \
-				 | CF_PAGE_READABLE \
-				 | CF_PAGE_EXEC)
-#define __S110		__pgprot(CF_PAGE_VALID \
-				 | CF_PAGE_ACCESSED \
-				 | CF_PAGE_SHARED \
-				 | CF_PAGE_EXEC)
-#define __S111		__pgprot(CF_PAGE_VALID \
-				 | CF_PAGE_ACCESSED \
-				 | CF_PAGE_SHARED \
-				 | CF_PAGE_READABLE \
-				 | CF_PAGE_EXEC)
-
 #define PTE_MASK	PAGE_MASK
 #define CF_PAGE_CHG_MASK (PTE_MASK | CF_PAGE_ACCESSED | CF_PAGE_DIRTY)
 
diff --git a/arch/m68k/include/asm/motorola_pgtable.h b/arch/m68k/include/asm/motorola_pgtable.h
index 022c3abc280d..4ea1bb57deee 100644
--- a/arch/m68k/include/asm/motorola_pgtable.h
+++ b/arch/m68k/include/asm/motorola_pgtable.h
@@ -83,28 +83,6 @@ extern unsigned long mm_cachebits;
 #define PAGE_COPY_C	__pgprot(_PAGE_PRESENT | _PAGE_RONLY | _PAGE_ACCESSED)
 #define PAGE_READONLY_C	__pgprot(_PAGE_PRESENT | _PAGE_RONLY | _PAGE_ACCESSED)
 
-/*
- * The m68k can't do page protection for execute, and considers that the same are read.
- * Also, write permissions imply read permissions. This is the closest we can get..
- */
-#define __P000	PAGE_NONE_C
-#define __P001	PAGE_READONLY_C
-#define __P010	PAGE_COPY_C
-#define __P011	PAGE_COPY_C
-#define __P100	PAGE_READONLY_C
-#define __P101	PAGE_READONLY_C
-#define __P110	PAGE_COPY_C
-#define __P111	PAGE_COPY_C
-
-#define __S000	PAGE_NONE_C
-#define __S001	PAGE_READONLY_C
-#define __S010	PAGE_SHARED_C
-#define __S011	PAGE_SHARED_C
-#define __S100	PAGE_READONLY_C
-#define __S101	PAGE_READONLY_C
-#define __S110	PAGE_SHARED_C
-#define __S111	PAGE_SHARED_C
-
 #define pmd_pgtable(pmd) ((pgtable_t)pmd_page_vaddr(pmd))
 
 /*
diff --git a/arch/m68k/include/asm/sun3_pgtable.h b/arch/m68k/include/asm/sun3_pgtable.h
index 5b24283a0a42..086fabdd8d4c 100644
--- a/arch/m68k/include/asm/sun3_pgtable.h
+++ b/arch/m68k/include/asm/sun3_pgtable.h
@@ -66,28 +66,6 @@
 				 | SUN3_PAGE_SYSTEM \
 				 | SUN3_PAGE_NOCACHE)
 
-/*
- * Page protections for initialising protection_map. The sun3 has only two
- * protection settings, valid (implying read and execute) and writeable. These
- * are as close as we can get...
- */
-#define __P000	PAGE_NONE
-#define __P001	PAGE_READONLY
-#define __P010	PAGE_COPY
-#define __P011	PAGE_COPY
-#define __P100	PAGE_READONLY
-#define __P101	PAGE_READONLY
-#define __P110	PAGE_COPY
-#define __P111	PAGE_COPY
-
-#define __S000	PAGE_NONE
-#define __S001	PAGE_READONLY
-#define __S010	PAGE_SHARED
-#define __S011	PAGE_SHARED
-#define __S100	PAGE_READONLY
-#define __S101	PAGE_READONLY
-#define __S110	PAGE_SHARED
-#define __S111	PAGE_SHARED
 
 /* Use these fake page-protections on PMDs. */
 #define SUN3_PMD_VALID	(0x00000001)
diff --git a/arch/m68k/mm/init.c b/arch/m68k/mm/init.c
index 1b47bec15832..6fcb35616189 100644
--- a/arch/m68k/mm/init.c
+++ b/arch/m68k/mm/init.c
@@ -128,3 +128,90 @@ void __init mem_init(void)
 	memblock_free_all();
 	init_pointer_tables();
 }
+
+#ifdef CONFIG_COLDFIRE
+pgprot_t vm_get_page_prot(unsigned long vm_flags)
+{
+	switch (vm_flags & (VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)) {
+	case VM_NONE:
+		return PAGE_NONE;
+	case VM_READ:
+		return __pgprot(CF_PAGE_VALID|CF_PAGE_ACCESSED|CF_PAGE_READABLE);
+	case VM_WRITE:
+		return __pgprot(CF_PAGE_VALID|CF_PAGE_ACCESSED|CF_PAGE_WRITABLE);
+	case VM_READ | VM_WRITE:
+		return __pgprot(CF_PAGE_VALID|CF_PAGE_ACCESSED|CF_PAGE_READABLE|CF_PAGE_WRITABLE);
+	case VM_EXEC:
+		return __pgprot(CF_PAGE_VALID|CF_PAGE_ACCESSED|CF_PAGE_EXEC);
+	case VM_EXEC | VM_READ:
+		return __pgprot(CF_PAGE_VALID|CF_PAGE_ACCESSED|CF_PAGE_READABLE|CF_PAGE_EXEC);
+	case VM_EXEC | VM_WRITE:
+		return __pgprot(CF_PAGE_VALID|CF_PAGE_ACCESSED|CF_PAGE_WRITABLE|CF_PAGE_EXEC);
+	case VM_EXEC | VM_READ | VM_WRITE:
+		return __pgprot(CF_PAGE_VALID|CF_PAGE_ACCESSED|CF_PAGE_READABLE|CF_PAGE_WRITABLE|
+				CF_PAGE_EXEC);
+	case VM_SHARED:
+		return PAGE_NONE;
+	case VM_SHARED | VM_READ:
+		return __pgprot(CF_PAGE_VALID|CF_PAGE_ACCESSED|CF_PAGE_READABLE);
+	case VM_SHARED | VM_WRITE:
+		return PAGE_SHARED;
+	case VM_SHARED | VM_READ | VM_WRITE:
+		return __pgprot(CF_PAGE_VALID|CF_PAGE_ACCESSED|CF_PAGE_READABLE|CF_PAGE_SHARED);
+	case VM_SHARED | VM_EXEC:
+		return __pgprot(CF_PAGE_VALID|CF_PAGE_ACCESSED|CF_PAGE_EXEC);
+	case VM_SHARED | VM_EXEC | VM_READ:
+		return __pgprot(CF_PAGE_VALID|CF_PAGE_ACCESSED|CF_PAGE_READABLE|CF_PAGE_EXEC);
+	case VM_SHARED | VM_EXEC | VM_WRITE:
+		return __pgprot(CF_PAGE_VALID|CF_PAGE_ACCESSED|CF_PAGE_SHARED|CF_PAGE_EXEC);
+	case VM_SHARED | VM_EXEC | VM_READ | VM_WRITE:
+		return __pgprot(CF_PAGE_VALID|CF_PAGE_ACCESSED|CF_PAGE_READABLE|CF_PAGE_SHARED|
+				CF_PAGE_EXEC);
+	default:
+		BUILD_BUG();
+	}
+}
+#endif
+
+#ifdef CONFIG_SUN3
+pgprot_t vm_get_page_prot(unsigned long vm_flags)
+{
+	switch (vm_flags & (VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)) {
+	case VM_NONE:
+		return PAGE_NONE;
+	case VM_READ:
+		return PAGE_READONLY;
+	case VM_WRITE:
+		return PAGE_COPY;
+	case VM_READ | VM_WRITE:
+		return PAGE_COPY;
+	case VM_EXEC:
+		return PAGE_READONLY;
+	case VM_EXEC | VM_READ:
+		return PAGE_READONLY;
+	case VM_EXEC | VM_WRITE:
+		return PAGE_COPY;
+	case VM_EXEC | VM_READ | VM_WRITE:
+		return PAGE_COPY;
+	case VM_SHARED:
+		return PAGE_NONE;
+	case VM_SHARED | VM_READ:
+		return PAGE_READONLY;
+	case VM_SHARED | VM_WRITE:
+		return PAGE_SHARED;
+	case VM_SHARED | VM_READ | VM_WRITE:
+		return PAGE_SHARED;
+	case VM_SHARED | VM_EXEC:
+		return PAGE_READONLY;
+	case VM_SHARED | VM_EXEC | VM_READ:
+		return PAGE_READONLY;
+	case VM_SHARED | VM_EXEC | VM_WRITE:
+		return PAGE_SHARED;
+	case VM_SHARED | VM_EXEC | VM_READ | VM_WRITE:
+		return PAGE_SHARED;
+	default:
+		BUILD_BUG();
+	}
+}
+#endif
+EXPORT_SYMBOL(vm_get_page_prot);
diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
index ecbe948f4c1a..72fbe5e38045 100644
--- a/arch/m68k/mm/motorola.c
+++ b/arch/m68k/mm/motorola.c
@@ -400,12 +400,9 @@ void __init paging_init(void)
 
 	/* Fix the cache mode in the page descriptors for the 680[46]0.  */
 	if (CPU_IS_040_OR_060) {
-		int i;
 #ifndef mm_cachebits
 		mm_cachebits = _PAGE_CACHE040;
 #endif
-		for (i = 0; i < 16; i++)
-			pgprot_val(protection_map[i]) |= _PAGE_CACHE040;
 	}
 
 	min_addr = m68k_memory[0].addr;
@@ -483,3 +480,44 @@ void __init paging_init(void)
 	max_zone_pfn[ZONE_DMA] = memblock_end_of_DRAM();
 	free_area_init(max_zone_pfn);
 }
+
+pgprot_t vm_get_page_prot(unsigned long vm_flags)
+{
+	switch (vm_flags & (VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)) {
+	case VM_NONE:
+		return __pgprot(pgprot_val(PAGE_NONE_C)|_PAGE_CACHE040);
+	case VM_READ:
+		return __pgprot(pgprot_val(PAGE_READONLY_C)|_PAGE_CACHE040);
+	case VM_WRITE:
+		return __pgprot(pgprot_val(PAGE_COPY_C)|_PAGE_CACHE040);
+	case VM_READ | VM_WRITE:
+		return __pgprot(pgprot_val(PAGE_COPY_C)|_PAGE_CACHE040);
+	case VM_EXEC:
+		return __pgprot(pgprot_val(PAGE_READONLY_C)|_PAGE_CACHE040);
+	case VM_EXEC | VM_READ:
+		return __pgprot(pgprot_val(PAGE_READONLY_C)|_PAGE_CACHE040);
+	case VM_EXEC | VM_WRITE:
+		return __pgprot(pgprot_val(PAGE_COPY_C)|_PAGE_CACHE040);
+	case VM_EXEC | VM_READ | VM_WRITE:
+		return __pgprot(pgprot_val(PAGE_COPY_C)|_PAGE_CACHE040);
+	case VM_SHARED:
+		return __pgprot(pgprot_val(PAGE_NONE_C)|_PAGE_CACHE040);
+	case VM_SHARED | VM_READ:
+		return __pgprot(pgprot_val(PAGE_READONLY_C)|_PAGE_CACHE040);
+	case VM_SHARED | VM_WRITE:
+		return __pgprot(pgprot_val(PAGE_SHARED_C)|_PAGE_CACHE040);
+	case VM_SHARED | VM_READ | VM_WRITE:
+		return __pgprot(pgprot_val(PAGE_SHARED_C)|_PAGE_CACHE040);
+	case VM_SHARED | VM_EXEC:
+		return __pgprot(pgprot_val(PAGE_READONLY_C)|_PAGE_CACHE040);
+	case VM_SHARED | VM_EXEC | VM_READ:
+		return __pgprot(pgprot_val(PAGE_READONLY_C)|_PAGE_CACHE040);
+	case VM_SHARED | VM_EXEC | VM_WRITE:
+		return __pgprot(pgprot_val(PAGE_SHARED_C)|_PAGE_CACHE040);
+	case VM_SHARED | VM_EXEC | VM_READ | VM_WRITE:
+		return __pgprot(pgprot_val(PAGE_SHARED_C)|_PAGE_CACHE040);
+	default:
+		BUILD_BUG();
+	}
+}
+EXPORT_SYMBOL(vm_get_page_prot);
-- 
2.25.1

