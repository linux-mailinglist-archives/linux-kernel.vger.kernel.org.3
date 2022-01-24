Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE1849800B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 13:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242755AbiAXM5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 07:57:55 -0500
Received: from foss.arm.com ([217.140.110.172]:32962 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242732AbiAXM5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 07:57:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D56E3ED1;
        Mon, 24 Jan 2022 04:57:46 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.43.190])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 29C653F774;
        Mon, 24 Jan 2022 04:57:42 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, hch@infradead.org,
        akpm@linux-foundation.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC V1 09/31] arm/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Date:   Mon, 24 Jan 2022 18:26:46 +0530
Message-Id: <1643029028-12710-10-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643029028-12710-1-git-send-email-anshuman.khandual@arm.com>
References: <1643029028-12710-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This defines and exports a platform specific custom vm_get_page_prot() via
subscribing ARCH_HAS_VM_GET_PAGE_PROT. Subsequently all __SXXX and __PXXX
macros can be dropped which are no longer needed.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm/Kconfig               |  1 +
 arch/arm/include/asm/pgtable.h | 18 ------------
 arch/arm/mm/mmu.c              | 50 ++++++++++++++++++++++++++++++----
 3 files changed, 45 insertions(+), 24 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fabe39169b12..c12362d20c44 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -23,6 +23,7 @@ config ARM
 	select ARCH_HAS_SYNC_DMA_FOR_CPU if SWIOTLB || !MMU
 	select ARCH_HAS_TEARDOWN_DMA_OPS if MMU
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
+	select ARCH_HAS_VM_GET_PAGE_PROT
 	select ARCH_HAVE_CUSTOM_GPIO_H
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG if CPU_V7 || CPU_V7M || CPU_V6K
 	select ARCH_HAS_GCOV_PROFILE_ALL
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index cd1f84bb40ae..ec062dd6082a 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -137,24 +137,6 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
  *  2) If we could do execute protection, then read is implied
  *  3) write implies read permissions
  */
-#define __P000  __PAGE_NONE
-#define __P001  __PAGE_READONLY
-#define __P010  __PAGE_COPY
-#define __P011  __PAGE_COPY
-#define __P100  __PAGE_READONLY_EXEC
-#define __P101  __PAGE_READONLY_EXEC
-#define __P110  __PAGE_COPY_EXEC
-#define __P111  __PAGE_COPY_EXEC
-
-#define __S000  __PAGE_NONE
-#define __S001  __PAGE_READONLY
-#define __S010  __PAGE_SHARED
-#define __S011  __PAGE_SHARED
-#define __S100  __PAGE_READONLY_EXEC
-#define __S101  __PAGE_READONLY_EXEC
-#define __S110  __PAGE_SHARED_EXEC
-#define __S111  __PAGE_SHARED_EXEC
-
 #ifndef __ASSEMBLY__
 /*
  * ZERO_PAGE is a global shared page that is always zero: used
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 274e4f73fd33..3007d07bc0e7 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -403,6 +403,8 @@ void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot)
 	local_flush_tlb_kernel_range(vaddr, vaddr + PAGE_SIZE);
 }
 
+static pteval_t user_pgprot;
+
 /*
  * Adjust the PMD section entries according to the CPU in use.
  */
@@ -410,7 +412,7 @@ static void __init build_mem_type_table(void)
 {
 	struct cachepolicy *cp;
 	unsigned int cr = get_cr();
-	pteval_t user_pgprot, kern_pgprot, vecs_pgprot;
+	pteval_t kern_pgprot, vecs_pgprot;
 	int cpu_arch = cpu_architecture();
 	int i;
 
@@ -627,11 +629,6 @@ static void __init build_mem_type_table(void)
 	user_pgprot |= PTE_EXT_PXN;
 #endif
 
-	for (i = 0; i < 16; i++) {
-		pteval_t v = pgprot_val(protection_map[i]);
-		protection_map[i] = __pgprot(v | user_pgprot);
-	}
-
 	mem_types[MT_LOW_VECTORS].prot_pte |= vecs_pgprot;
 	mem_types[MT_HIGH_VECTORS].prot_pte |= vecs_pgprot;
 
@@ -670,6 +667,47 @@ static void __init build_mem_type_table(void)
 	}
 }
 
+pgprot_t vm_get_page_prot(unsigned long vm_flags)
+{
+	switch (vm_flags & (VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)) {
+	case VM_NONE:
+		return __pgprot(pgprot_val(__PAGE_NONE) | user_pgprot);
+	case VM_READ:
+		return __pgprot(pgprot_val(__PAGE_READONLY) | user_pgprot);
+	case VM_WRITE:
+		return __pgprot(pgprot_val(__PAGE_COPY) | user_pgprot);
+	case VM_READ | VM_WRITE:
+		return __pgprot(pgprot_val(__PAGE_COPY) | user_pgprot);
+	case VM_EXEC:
+		return __pgprot(pgprot_val(__PAGE_READONLY_EXEC) | user_pgprot);
+	case VM_EXEC | VM_READ:
+		return __pgprot(pgprot_val(__PAGE_READONLY_EXEC) | user_pgprot);
+	case VM_EXEC | VM_WRITE:
+		return __pgprot(pgprot_val(__PAGE_COPY_EXEC) | user_pgprot);
+	case VM_EXEC | VM_READ | VM_WRITE:
+		return __pgprot(pgprot_val(__PAGE_COPY_EXEC) | user_pgprot);
+	case VM_SHARED:
+		return __pgprot(pgprot_val(__PAGE_NONE) | user_pgprot);
+	case VM_SHARED | VM_READ:
+		return __pgprot(pgprot_val(__PAGE_READONLY) | user_pgprot);
+	case VM_SHARED | VM_WRITE:
+		return __pgprot(pgprot_val(__PAGE_SHARED) | user_pgprot);
+	case VM_SHARED | VM_READ | VM_WRITE:
+		return __pgprot(pgprot_val(__PAGE_SHARED) | user_pgprot);
+	case VM_SHARED | VM_EXEC:
+		return __pgprot(pgprot_val(__PAGE_READONLY_EXEC) | user_pgprot);
+	case VM_SHARED | VM_EXEC | VM_READ:
+		return __pgprot(pgprot_val(__PAGE_READONLY_EXEC) | user_pgprot);
+	case VM_SHARED | VM_EXEC | VM_WRITE:
+		return __pgprot(pgprot_val(__PAGE_SHARED_EXEC) | user_pgprot);
+	case VM_SHARED | VM_EXEC | VM_READ | VM_WRITE:
+		return __pgprot(pgprot_val(__PAGE_SHARED_EXEC) | user_pgprot);
+	default:
+		BUILD_BUG();
+	}
+}
+EXPORT_SYMBOL(vm_get_page_prot);
+
 #ifdef CONFIG_ARM_DMA_MEM_BUFFERABLE
 pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 			      unsigned long size, pgprot_t vma_prot)
-- 
2.25.1

