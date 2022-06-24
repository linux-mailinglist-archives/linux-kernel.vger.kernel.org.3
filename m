Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E863559127
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 07:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbiFXEsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 00:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbiFXErg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 00:47:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 773E269FAB;
        Thu, 23 Jun 2022 21:46:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67BA71758;
        Thu, 23 Jun 2022 21:46:47 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.41.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 854F93F66F;
        Thu, 23 Jun 2022 21:46:39 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     hch@infradead.org, christophe.leroy@csgroup.eu,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        x86@kernel.org, openrisc@lists.librecores.org,
        linux-xtensa@linux-xtensa.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-um@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH V4 21/26] m68k/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Date:   Fri, 24 Jun 2022 10:13:34 +0530
Message-Id: <20220624044339.1533882-22-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220624044339.1533882-1-anshuman.khandual@arm.com>
References: <20220624044339.1533882-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables ARCH_HAS_VM_GET_PAGE_PROT on the platform and exports standard
vm_get_page_prot() implementation via DECLARE_VM_GET_PAGE_PROT, which looks
up a private and static protection_map[] array. Subsequently all __SXXX and
__PXXX macros can be dropped which are no longer needed.

Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/m68k/Kconfig                        |  1 +
 arch/m68k/include/asm/mcf_pgtable.h      | 54 -----------------------
 arch/m68k/include/asm/motorola_pgtable.h | 22 ----------
 arch/m68k/include/asm/sun3_pgtable.h     | 17 --------
 arch/m68k/mm/mcfmmu.c                    | 55 ++++++++++++++++++++++++
 arch/m68k/mm/motorola.c                  | 20 +++++++++
 arch/m68k/mm/sun3mmu.c                   | 20 +++++++++
 7 files changed, 96 insertions(+), 93 deletions(-)

diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 936cce42ae9a..49aa0cf13e96 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -7,6 +7,7 @@ config M68K
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DMA_PREP_COHERENT if HAS_DMA && MMU && !COLDFIRE
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if HAS_DMA
+	select ARCH_HAS_VM_GET_PAGE_PROT
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG if RMW_INSNS
 	select ARCH_MIGHT_HAVE_PC_PARPORT if ISA
 	select ARCH_NO_PREEMPT if !COLDFIRE
diff --git a/arch/m68k/include/asm/mcf_pgtable.h b/arch/m68k/include/asm/mcf_pgtable.h
index 94f38d76e278..0e9c1b28dcab 100644
--- a/arch/m68k/include/asm/mcf_pgtable.h
+++ b/arch/m68k/include/asm/mcf_pgtable.h
@@ -91,60 +91,6 @@
  * for use. In general, the bit positions are xwr, and P-items are
  * private, the S-items are shared.
  */
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
index 7c9b56e2a750..63aaece0722f 100644
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
index 5e4e753f0d24..9d919491765b 100644
--- a/arch/m68k/include/asm/sun3_pgtable.h
+++ b/arch/m68k/include/asm/sun3_pgtable.h
@@ -71,23 +71,6 @@
  * protection settings, valid (implying read and execute) and writeable. These
  * are as close as we can get...
  */
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
diff --git a/arch/m68k/mm/mcfmmu.c b/arch/m68k/mm/mcfmmu.c
index 6f1f25125294..45d1964301f4 100644
--- a/arch/m68k/mm/mcfmmu.c
+++ b/arch/m68k/mm/mcfmmu.c
@@ -234,3 +234,58 @@ void steal_context(void)
 	destroy_context(mm);
 }
 
+static pgprot_t protection_map[16] __ro_after_init = {
+	[VM_NONE]					= PAGE_NONE,
+	[VM_READ]					= __pgprot(CF_PAGE_VALID |
+								   CF_PAGE_ACCESSED |
+								   CF_PAGE_READABLE),
+	[VM_WRITE]					= __pgprot(CF_PAGE_VALID |
+								   CF_PAGE_ACCESSED |
+								   CF_PAGE_WRITABLE),
+	[VM_WRITE | VM_READ]				= __pgprot(CF_PAGE_VALID |
+								   CF_PAGE_ACCESSED |
+								   CF_PAGE_READABLE |
+								   CF_PAGE_WRITABLE),
+	[VM_EXEC]					= __pgprot(CF_PAGE_VALID |
+								   CF_PAGE_ACCESSED |
+								   CF_PAGE_EXEC),
+	[VM_EXEC | VM_READ]				= __pgprot(CF_PAGE_VALID |
+								   CF_PAGE_ACCESSED |
+								   CF_PAGE_READABLE |
+								   CF_PAGE_EXEC),
+	[VM_EXEC | VM_WRITE]				= __pgprot(CF_PAGE_VALID |
+								   CF_PAGE_ACCESSED |
+								   CF_PAGE_WRITABLE |
+								   CF_PAGE_EXEC),
+	[VM_EXEC | VM_WRITE | VM_READ]			=  __pgprot(CF_PAGE_VALID |
+								    CF_PAGE_ACCESSED |
+								    CF_PAGE_READABLE |
+								    CF_PAGE_WRITABLE |
+								    CF_PAGE_EXEC),
+	[VM_SHARED]					= PAGE_NONE,
+	[VM_SHARED | VM_READ]				= __pgprot(CF_PAGE_VALID |
+								   CF_PAGE_ACCESSED |
+								   CF_PAGE_READABLE),
+	[VM_SHARED | VM_WRITE]				= PAGE_SHARED,
+	[VM_SHARED | VM_WRITE | VM_READ]		= __pgprot(CF_PAGE_VALID |
+								   CF_PAGE_ACCESSED |
+								   CF_PAGE_READABLE |
+								   CF_PAGE_SHARED),
+	[VM_SHARED | VM_EXEC]				= __pgprot(CF_PAGE_VALID |
+								   CF_PAGE_ACCESSED |
+								   CF_PAGE_EXEC),
+	[VM_SHARED | VM_EXEC | VM_READ]			= __pgprot(CF_PAGE_VALID |
+								   CF_PAGE_ACCESSED |
+								   CF_PAGE_READABLE |
+								   CF_PAGE_EXEC),
+	[VM_SHARED | VM_EXEC | VM_WRITE]		= __pgprot(CF_PAGE_VALID |
+								   CF_PAGE_ACCESSED |
+								   CF_PAGE_SHARED |
+								   CF_PAGE_EXEC),
+	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= __pgprot(CF_PAGE_VALID |
+								   CF_PAGE_ACCESSED |
+								   CF_PAGE_READABLE |
+								   CF_PAGE_SHARED |
+								   CF_PAGE_EXEC)
+};
+DECLARE_VM_GET_PAGE_PROT
diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
index df7f797c908a..31fba64bc530 100644
--- a/arch/m68k/mm/motorola.c
+++ b/arch/m68k/mm/motorola.c
@@ -382,6 +382,26 @@ static void __init map_node(int node)
 #endif
 }
 
+static pgprot_t protection_map[16] __ro_after_init = {
+	[VM_NONE]					= PAGE_NONE_C,
+	[VM_READ]					= PAGE_READONLY_C,
+	[VM_WRITE]					= PAGE_COPY_C,
+	[VM_WRITE | VM_READ]				= PAGE_COPY_C,
+	[VM_EXEC]					= PAGE_READONLY_C,
+	[VM_EXEC | VM_READ]				= PAGE_READONLY_C,
+	[VM_EXEC | VM_WRITE]				= PAGE_COPY_C,
+	[VM_EXEC | VM_WRITE | VM_READ]			= PAGE_COPY_C,
+	[VM_SHARED]					= PAGE_NONE_C,
+	[VM_SHARED | VM_READ]				= PAGE_READONLY_C,
+	[VM_SHARED | VM_WRITE]				= PAGE_SHARED_C,
+	[VM_SHARED | VM_WRITE | VM_READ]		= PAGE_SHARED_C,
+	[VM_SHARED | VM_EXEC]				= PAGE_READONLY_C,
+	[VM_SHARED | VM_EXEC | VM_READ]			= PAGE_READONLY_C,
+	[VM_SHARED | VM_EXEC | VM_WRITE]		= PAGE_SHARED_C,
+	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= PAGE_SHARED_C
+};
+DECLARE_VM_GET_PAGE_PROT
+
 /*
  * paging_init() continues the virtual memory environment setup which
  * was begun by the code in arch/head.S.
diff --git a/arch/m68k/mm/sun3mmu.c b/arch/m68k/mm/sun3mmu.c
index dad494224497..ef0baea67ea2 100644
--- a/arch/m68k/mm/sun3mmu.c
+++ b/arch/m68k/mm/sun3mmu.c
@@ -95,3 +95,23 @@ void __init paging_init(void)
 
 
 }
+
+static pgprot_t protection_map[16] __ro_after_init = {
+	[VM_NONE]					= PAGE_NONE,
+	[VM_READ]					= PAGE_READONLY,
+	[VM_WRITE]					= PAGE_COPY,
+	[VM_WRITE | VM_READ]				= PAGE_COPY,
+	[VM_EXEC]					= PAGE_READONLY,
+	[VM_EXEC | VM_READ]				= PAGE_READONLY,
+	[VM_EXEC | VM_WRITE]				= PAGE_COPY,
+	[VM_EXEC | VM_WRITE | VM_READ]			= PAGE_COPY,
+	[VM_SHARED]					= PAGE_NONE,
+	[VM_SHARED | VM_READ]				= PAGE_READONLY,
+	[VM_SHARED | VM_WRITE]				= PAGE_SHARED,
+	[VM_SHARED | VM_WRITE | VM_READ]		= PAGE_SHARED,
+	[VM_SHARED | VM_EXEC]				= PAGE_READONLY,
+	[VM_SHARED | VM_EXEC | VM_READ]			= PAGE_READONLY,
+	[VM_SHARED | VM_EXEC | VM_WRITE]		= PAGE_SHARED,
+	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= PAGE_SHARED
+};
+DECLARE_VM_GET_PAGE_PROT
-- 
2.25.1

