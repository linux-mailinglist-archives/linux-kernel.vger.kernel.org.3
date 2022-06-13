Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B399D547F00
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 07:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbiFMFek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 01:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbiFMFeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 01:34:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E29D311C24
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 22:34:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C55F51042;
        Sun, 12 Jun 2022 22:34:06 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.38.134])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D48093F66F;
        Sun, 12 Jun 2022 22:34:04 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/2] mm/mmap: Restrict generic protection_map[] array visibility
Date:   Mon, 13 Jun 2022 11:03:53 +0530
Message-Id: <20220613053354.553579-2-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220613053354.553579-1-anshuman.khandual@arm.com>
References: <20220613053354.553579-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Restrict generic protection_map[] array visibility only for platforms which
do not enable ARCH_HAS_VM_GET_PAGE_PROT. For other platforms that do define
their own vm_get_page_prot() enabling ARCH_HAS_VM_GET_PAGE_PROT, could have
their private static protection_map[] still implementing an array look up.
These private protection_map[] array could do without __PXXX/__SXXX macros,
making them redundant and dropping them off as well.

But platforms which do not define their custom vm_get_page_prot() enabling
ARCH_HAS_VM_GET_PAGE_PROT, will still have to provide __PXXX/__SXXX macros.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/pgtable-prot.h | 18 ------------------
 arch/arm64/mm/mmap.c                  | 21 +++++++++++++++++++++
 arch/powerpc/include/asm/pgtable.h    |  2 ++
 arch/powerpc/mm/book3s64/pgtable.c    | 20 ++++++++++++++++++++
 arch/sparc/include/asm/pgtable_64.h   | 19 -------------------
 arch/sparc/mm/init_64.c               |  3 +++
 arch/x86/include/asm/pgtable_types.h  | 19 -------------------
 arch/x86/mm/pgprot.c                  | 19 +++++++++++++++++++
 include/linux/mm.h                    |  2 ++
 mm/mmap.c                             |  2 +-
 10 files changed, 68 insertions(+), 57 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index 62e0ebeed720..9b165117a454 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -89,24 +89,6 @@ extern bool arm64_use_ng_mappings;
 #define PAGE_READONLY_EXEC	__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_RDONLY | PTE_NG | PTE_PXN)
 #define PAGE_EXECONLY		__pgprot(_PAGE_DEFAULT | PTE_RDONLY | PTE_NG | PTE_PXN)
 
-#define __P000  PAGE_NONE
-#define __P001  PAGE_READONLY
-#define __P010  PAGE_READONLY
-#define __P011  PAGE_READONLY
-#define __P100  PAGE_READONLY_EXEC	/* PAGE_EXECONLY if Enhanced PAN */
-#define __P101  PAGE_READONLY_EXEC
-#define __P110  PAGE_READONLY_EXEC
-#define __P111  PAGE_READONLY_EXEC
-
-#define __S000  PAGE_NONE
-#define __S001  PAGE_READONLY
-#define __S010  PAGE_SHARED
-#define __S011  PAGE_SHARED
-#define __S100  PAGE_READONLY_EXEC	/* PAGE_EXECONLY if Enhanced PAN */
-#define __S101  PAGE_READONLY_EXEC
-#define __S110  PAGE_SHARED_EXEC
-#define __S111  PAGE_SHARED_EXEC
-
 #endif /* __ASSEMBLY__ */
 
 #endif /* __ASM_PGTABLE_PROT_H */
diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
index 78e9490f748d..8f5b7ce857ed 100644
--- a/arch/arm64/mm/mmap.c
+++ b/arch/arm64/mm/mmap.c
@@ -13,6 +13,27 @@
 #include <asm/cpufeature.h>
 #include <asm/page.h>
 
+static pgprot_t protection_map[16] __ro_after_init = {
+	[VM_NONE]					= PAGE_NONE,
+	[VM_READ]					= PAGE_READONLY,
+	[VM_WRITE]					= PAGE_READONLY,
+	[VM_WRITE | VM_READ]				= PAGE_READONLY,
+	/* PAGE_EXECONLY if Enhanced PAN */
+	[VM_EXEC]					= PAGE_READONLY_EXEC,
+	[VM_EXEC | VM_READ]				= PAGE_READONLY_EXEC,
+	[VM_EXEC | VM_WRITE]				= PAGE_READONLY_EXEC,
+	[VM_EXEC | VM_WRITE | VM_READ]			= PAGE_READONLY_EXEC,
+	[VM_SHARED]					= PAGE_NONE,
+	[VM_SHARED | VM_READ]				= PAGE_READONLY,
+	[VM_SHARED | VM_WRITE]				= PAGE_SHARED,
+	[VM_SHARED | VM_WRITE | VM_READ]		= PAGE_SHARED,
+	/* PAGE_EXECONLY if Enhanced PAN */
+	[VM_SHARED | VM_EXEC]				= PAGE_READONLY_EXEC,
+	[VM_SHARED | VM_EXEC | VM_READ]			= PAGE_READONLY_EXEC,
+	[VM_SHARED | VM_EXEC | VM_WRITE]		= PAGE_SHARED_EXEC,
+	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= PAGE_SHARED_EXEC
+};
+
 /*
  * You really shouldn't be using read() or write() on /dev/mem.  This might go
  * away in the future.
diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index d564d0ecd4cd..8ed2a80c896e 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -21,6 +21,7 @@ struct mm_struct;
 #endif /* !CONFIG_PPC_BOOK3S */
 
 /* Note due to the way vm flags are laid out, the bits are XWR */
+#ifndef CONFIG_ARCH_HAS_VM_GET_PAGE_PROT
 #define __P000	PAGE_NONE
 #define __P001	PAGE_READONLY
 #define __P010	PAGE_COPY
@@ -38,6 +39,7 @@ struct mm_struct;
 #define __S101	PAGE_READONLY_X
 #define __S110	PAGE_SHARED_X
 #define __S111	PAGE_SHARED_X
+#endif
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index 7b9966402b25..d3b019b95c1d 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -551,6 +551,26 @@ unsigned long memremap_compat_align(void)
 EXPORT_SYMBOL_GPL(memremap_compat_align);
 #endif
 
+/* Note due to the way vm flags are laid out, the bits are XWR */
+static const pgprot_t protection_map[16] = {
+	[VM_NONE]					= PAGE_NONE,
+	[VM_READ]					= PAGE_READONLY,
+	[VM_WRITE]					= PAGE_COPY,
+	[VM_WRITE | VM_READ]				= PAGE_COPY,
+	[VM_EXEC]					= PAGE_READONLY_X,
+	[VM_EXEC | VM_READ]				= PAGE_READONLY_X,
+	[VM_EXEC | VM_WRITE]				= PAGE_COPY_X,
+	[VM_EXEC | VM_WRITE | VM_READ]			= PAGE_COPY_X,
+	[VM_SHARED]					= PAGE_NONE,
+	[VM_SHARED | VM_READ]				= PAGE_READONLY,
+	[VM_SHARED | VM_WRITE]				= PAGE_SHARED,
+	[VM_SHARED | VM_WRITE | VM_READ]		= PAGE_SHARED,
+	[VM_SHARED | VM_EXEC]				= PAGE_READONLY_X,
+	[VM_SHARED | VM_EXEC | VM_READ]			= PAGE_READONLY_X,
+	[VM_SHARED | VM_EXEC | VM_WRITE]		= PAGE_SHARED_X,
+	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= PAGE_SHARED_X
+};
+
 pgprot_t vm_get_page_prot(unsigned long vm_flags)
 {
 	unsigned long prot = pgprot_val(protection_map[vm_flags &
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 4679e45c8348..a779418ceba9 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -187,25 +187,6 @@ bool kern_addr_valid(unsigned long addr);
 #define _PAGE_SZHUGE_4U	_PAGE_SZ4MB_4U
 #define _PAGE_SZHUGE_4V	_PAGE_SZ4MB_4V
 
-/* These are actually filled in at boot time by sun4{u,v}_pgprot_init() */
-#define __P000	__pgprot(0)
-#define __P001	__pgprot(0)
-#define __P010	__pgprot(0)
-#define __P011	__pgprot(0)
-#define __P100	__pgprot(0)
-#define __P101	__pgprot(0)
-#define __P110	__pgprot(0)
-#define __P111	__pgprot(0)
-
-#define __S000	__pgprot(0)
-#define __S001	__pgprot(0)
-#define __S010	__pgprot(0)
-#define __S011	__pgprot(0)
-#define __S100	__pgprot(0)
-#define __S101	__pgprot(0)
-#define __S110	__pgprot(0)
-#define __S111	__pgprot(0)
-
 #ifndef __ASSEMBLY__
 
 pte_t mk_pte_io(unsigned long, pgprot_t, int, unsigned long);
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index f6174df2d5af..d6faee23c77d 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2634,6 +2634,9 @@ void vmemmap_free(unsigned long start, unsigned long end,
 }
 #endif /* CONFIG_SPARSEMEM_VMEMMAP */
 
+/* These are actually filled in at boot time by sun4{u,v}_pgprot_init() */
+static pgprot_t protection_map[16] __ro_after_init;
+
 static void prot_init_common(unsigned long page_none,
 			     unsigned long page_shared,
 			     unsigned long page_copy,
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index bdaf8391e2e0..aa174fed3a71 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -230,25 +230,6 @@ enum page_cache_mode {
 
 #endif	/* __ASSEMBLY__ */
 
-/*         xwr */
-#define __P000	PAGE_NONE
-#define __P001	PAGE_READONLY
-#define __P010	PAGE_COPY
-#define __P011	PAGE_COPY
-#define __P100	PAGE_READONLY_EXEC
-#define __P101	PAGE_READONLY_EXEC
-#define __P110	PAGE_COPY_EXEC
-#define __P111	PAGE_COPY_EXEC
-
-#define __S000	PAGE_NONE
-#define __S001	PAGE_READONLY
-#define __S010	PAGE_SHARED
-#define __S011	PAGE_SHARED
-#define __S100	PAGE_READONLY_EXEC
-#define __S101	PAGE_READONLY_EXEC
-#define __S110	PAGE_SHARED_EXEC
-#define __S111	PAGE_SHARED_EXEC
-
 /*
  * early identity mapping  pte attrib macros.
  */
diff --git a/arch/x86/mm/pgprot.c b/arch/x86/mm/pgprot.c
index 763742782286..7eca1b009af6 100644
--- a/arch/x86/mm/pgprot.c
+++ b/arch/x86/mm/pgprot.c
@@ -4,6 +4,25 @@
 #include <linux/mm.h>
 #include <asm/pgtable.h>
 
+static pgprot_t protection_map[16] __ro_after_init = {
+	[VM_NONE]					= PAGE_NONE,
+	[VM_READ]					= PAGE_READONLY,
+	[VM_WRITE]					= PAGE_COPY,
+	[VM_WRITE | VM_READ]				= PAGE_COPY,
+	[VM_EXEC]					= PAGE_READONLY_EXEC,
+	[VM_EXEC | VM_READ]				= PAGE_READONLY_EXEC,
+	[VM_EXEC | VM_WRITE]				= PAGE_COPY_EXEC,
+	[VM_EXEC | VM_WRITE | VM_READ]			= PAGE_COPY_EXEC,
+	[VM_SHARED]					= PAGE_NONE,
+	[VM_SHARED | VM_READ]				= PAGE_READONLY,
+	[VM_SHARED | VM_WRITE]				= PAGE_SHARED,
+	[VM_SHARED | VM_WRITE | VM_READ]		= PAGE_SHARED,
+	[VM_SHARED | VM_EXEC]				= PAGE_READONLY_EXEC,
+	[VM_SHARED | VM_EXEC | VM_READ]			= PAGE_READONLY_EXEC,
+	[VM_SHARED | VM_EXEC | VM_WRITE]		= PAGE_SHARED_EXEC,
+	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= PAGE_SHARED_EXEC
+};
+
 pgprot_t vm_get_page_prot(unsigned long vm_flags)
 {
 	unsigned long val = pgprot_val(protection_map[vm_flags &
diff --git a/include/linux/mm.h b/include/linux/mm.h
index bc8f326be0ce..2254c1980c8e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -420,11 +420,13 @@ extern unsigned int kobjsize(const void *objp);
 #endif
 #define VM_FLAGS_CLEAR	(ARCH_VM_PKEY_FLAGS | VM_ARCH_CLEAR)
 
+#ifndef CONFIG_ARCH_HAS_VM_GET_PAGE_PROT
 /*
  * mapping from the currently active vm_flags protection bits (the
  * low four bits) to a page protection mask..
  */
 extern pgprot_t protection_map[16];
+#endif
 
 /*
  * The default fault flags that should be used by most of the
diff --git a/mm/mmap.c b/mm/mmap.c
index 61e6135c54ef..e66920414945 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -101,6 +101,7 @@ static void unmap_region(struct mm_struct *mm,
  *								w: (no) no
  *								x: (yes) yes
  */
+#ifndef CONFIG_ARCH_HAS_VM_GET_PAGE_PROT
 pgprot_t protection_map[16] __ro_after_init = {
 	[VM_NONE]					= __P000,
 	[VM_READ]					= __P001,
@@ -120,7 +121,6 @@ pgprot_t protection_map[16] __ro_after_init = {
 	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= __S111
 };
 
-#ifndef CONFIG_ARCH_HAS_VM_GET_PAGE_PROT
 pgprot_t vm_get_page_prot(unsigned long vm_flags)
 {
 	return protection_map[vm_flags & (VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)];
-- 
2.25.1

