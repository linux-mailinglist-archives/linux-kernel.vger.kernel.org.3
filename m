Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F8F498009
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 13:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242742AbiAXM5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 07:57:40 -0500
Received: from foss.arm.com ([217.140.110.172]:32930 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242240AbiAXM5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 07:57:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74692ED1;
        Mon, 24 Jan 2022 04:57:38 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.43.190])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2C56E3F774;
        Mon, 24 Jan 2022 04:57:34 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, hch@infradead.org,
        akpm@linux-foundation.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Subject: [RFC V1 07/31] mips/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Date:   Mon, 24 Jan 2022 18:26:44 +0530
Message-Id: <1643029028-12710-8-git-send-email-anshuman.khandual@arm.com>
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
Cc: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/mips/Kconfig               |  1 +
 arch/mips/include/asm/pgtable.h | 22 -----------
 arch/mips/mm/cache.c            | 65 ++++++++++++++++++++-------------
 3 files changed, 41 insertions(+), 47 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 058446f01487..fcbfc52a1567 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -13,6 +13,7 @@ config MIPS
 	select ARCH_HAS_STRNLEN_USER
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
+	select ARCH_HAS_VM_GET_PAGE_PROT
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_KEEP_MEMBLOCK
 	select ARCH_SUPPORTS_UPROBES
diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index 7b8037f25d9e..bf193ad4f195 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -41,28 +41,6 @@ struct vm_area_struct;
  * by reasonable means..
  */
 
-/*
- * Dummy values to fill the table in mmap.c
- * The real values will be generated at runtime
- */
-#define __P000 __pgprot(0)
-#define __P001 __pgprot(0)
-#define __P010 __pgprot(0)
-#define __P011 __pgprot(0)
-#define __P100 __pgprot(0)
-#define __P101 __pgprot(0)
-#define __P110 __pgprot(0)
-#define __P111 __pgprot(0)
-
-#define __S000 __pgprot(0)
-#define __S001 __pgprot(0)
-#define __S010 __pgprot(0)
-#define __S011 __pgprot(0)
-#define __S100 __pgprot(0)
-#define __S101 __pgprot(0)
-#define __S110 __pgprot(0)
-#define __S111 __pgprot(0)
-
 extern unsigned long _page_cachable_default;
 extern void __update_cache(unsigned long address, pte_t pte);
 
diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index 830ab91e574f..06e29982965a 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -159,30 +159,6 @@ EXPORT_SYMBOL(_page_cachable_default);
 
 #define PM(p)	__pgprot(_page_cachable_default | (p))
 
-static inline void setup_protection_map(void)
-{
-	protection_map[0]  = PM(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ);
-	protection_map[1]  = PM(_PAGE_PRESENT | _PAGE_NO_EXEC);
-	protection_map[2]  = PM(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ);
-	protection_map[3]  = PM(_PAGE_PRESENT | _PAGE_NO_EXEC);
-	protection_map[4]  = PM(_PAGE_PRESENT);
-	protection_map[5]  = PM(_PAGE_PRESENT);
-	protection_map[6]  = PM(_PAGE_PRESENT);
-	protection_map[7]  = PM(_PAGE_PRESENT);
-
-	protection_map[8]  = PM(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ);
-	protection_map[9]  = PM(_PAGE_PRESENT | _PAGE_NO_EXEC);
-	protection_map[10] = PM(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_WRITE |
-				_PAGE_NO_READ);
-	protection_map[11] = PM(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_WRITE);
-	protection_map[12] = PM(_PAGE_PRESENT);
-	protection_map[13] = PM(_PAGE_PRESENT);
-	protection_map[14] = PM(_PAGE_PRESENT | _PAGE_WRITE);
-	protection_map[15] = PM(_PAGE_PRESENT | _PAGE_WRITE);
-}
-
-#undef PM
-
 void cpu_cache_init(void)
 {
 	if (cpu_has_3k_cache) {
@@ -206,6 +182,45 @@ void cpu_cache_init(void)
 
 		octeon_cache_init();
 	}
+}
 
-	setup_protection_map();
+pgprot_t vm_get_page_prot(unsigned long vm_flags)
+{
+	switch (vm_flags & (VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)) {
+	case VM_NONE:
+		return PM(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ);
+	case VM_READ:
+		return PM(_PAGE_PRESENT | _PAGE_NO_EXEC);
+	case VM_WRITE:
+		return PM(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ);
+	case VM_READ | VM_WRITE:
+		return PM(_PAGE_PRESENT | _PAGE_NO_EXEC);
+	case VM_EXEC:
+		return PM(_PAGE_PRESENT);
+	case VM_EXEC | VM_READ:
+		return PM(_PAGE_PRESENT);
+	case VM_EXEC | VM_WRITE:
+		return PM(_PAGE_PRESENT);
+	case VM_EXEC | VM_READ | VM_WRITE:
+		return PM(_PAGE_PRESENT);
+	case VM_SHARED:
+		return PM(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ);
+	case VM_SHARED | VM_READ:
+		return PM(_PAGE_PRESENT | _PAGE_NO_EXEC);
+	case VM_SHARED | VM_WRITE:
+		return PM(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_WRITE | _PAGE_NO_READ);
+	case VM_SHARED | VM_READ | VM_WRITE:
+		return PM(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_WRITE);
+	case VM_SHARED | VM_EXEC:
+		return PM(_PAGE_PRESENT);
+	case VM_SHARED | VM_EXEC | VM_READ:
+		return PM(_PAGE_PRESENT);
+	case VM_SHARED | VM_EXEC | VM_WRITE:
+		return PM(_PAGE_PRESENT | _PAGE_WRITE);
+	case VM_SHARED | VM_EXEC | VM_READ | VM_WRITE:
+		return PM(_PAGE_PRESENT | _PAGE_WRITE);
+	default:
+		BUILD_BUG();
+	}
 }
+EXPORT_SYMBOL(vm_get_page_prot);
-- 
2.25.1

