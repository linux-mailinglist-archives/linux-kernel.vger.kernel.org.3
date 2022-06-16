Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F2554D91F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 06:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358623AbiFPEJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 00:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358571AbiFPEJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 00:09:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E713256F9E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 21:09:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6542152B;
        Wed, 15 Jun 2022 21:09:41 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.42.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5FE0D3F7F5;
        Wed, 15 Jun 2022 21:09:38 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     hch@infradead.org, Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH V3 2/2] mm/mmap: Drop generic protection_map[] array
Date:   Thu, 16 Jun 2022 09:39:24 +0530
Message-Id: <20220616040924.1022607-3-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220616040924.1022607-1-anshuman.khandual@arm.com>
References: <20220616040924.1022607-1-anshuman.khandual@arm.com>
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

Move the protection_array[] array inside the arch for those platforms which
do not enable ARCH_HAS_VM_GET_PAGE_PROT. Afterwards __SXXX/__PXX macros can
be dropped completely which are now redundant.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Acked-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/alpha/include/asm/pgtable.h          | 17 -------
 arch/alpha/mm/init.c                      | 21 +++++++++
 arch/arc/include/asm/pgtable-bits-arcv2.h | 18 --------
 arch/arc/mm/mmap.c                        | 19 ++++++++
 arch/arm/include/asm/pgtable.h            | 17 -------
 arch/arm/lib/uaccess_with_memcpy.c        |  2 +-
 arch/arm/mm/mmu.c                         | 19 ++++++++
 arch/csky/include/asm/pgtable.h           | 18 --------
 arch/csky/mm/init.c                       | 19 ++++++++
 arch/hexagon/include/asm/pgtable.h        | 27 ------------
 arch/hexagon/mm/init.c                    | 41 +++++++++++++++++
 arch/ia64/include/asm/pgtable.h           | 18 --------
 arch/ia64/mm/init.c                       | 27 +++++++++++-
 arch/loongarch/include/asm/pgtable-bits.h | 19 --------
 arch/loongarch/mm/cache.c                 | 45 +++++++++++++++++++
 arch/m68k/include/asm/mcf_pgtable.h       | 54 -----------------------
 arch/m68k/include/asm/motorola_pgtable.h  | 22 ---------
 arch/m68k/include/asm/sun3_pgtable.h      | 17 -------
 arch/m68k/mm/mcfmmu.c                     | 54 +++++++++++++++++++++++
 arch/m68k/mm/motorola.c                   | 19 ++++++++
 arch/m68k/mm/sun3mmu.c                    | 19 ++++++++
 arch/microblaze/include/asm/pgtable.h     | 17 -------
 arch/microblaze/mm/init.c                 | 19 ++++++++
 arch/mips/include/asm/pgtable.h           | 22 ---------
 arch/mips/mm/cache.c                      |  2 +
 arch/nios2/include/asm/pgtable.h          | 16 -------
 arch/nios2/mm/init.c                      | 19 ++++++++
 arch/openrisc/include/asm/pgtable.h       | 18 --------
 arch/openrisc/mm/init.c                   | 19 ++++++++
 arch/parisc/include/asm/pgtable.h         | 18 --------
 arch/parisc/mm/init.c                     | 19 ++++++++
 arch/powerpc/include/asm/pgtable.h        | 20 ---------
 arch/powerpc/mm/book3s64/pgtable.c        | 24 +++-------
 arch/powerpc/mm/pgtable.c                 | 20 +++++++++
 arch/riscv/include/asm/pgtable.h          | 20 ---------
 arch/riscv/mm/init.c                      | 19 ++++++++
 arch/s390/include/asm/pgtable.h           | 17 -------
 arch/s390/mm/mmap.c                       | 19 ++++++++
 arch/sh/include/asm/pgtable.h             | 17 -------
 arch/sh/mm/mmap.c                         | 19 ++++++++
 arch/sparc/include/asm/pgtable_32.h       | 19 --------
 arch/sparc/mm/init_32.c                   | 19 ++++++++
 arch/sparc/mm/init_64.c                   |  2 +-
 arch/um/include/asm/pgtable.h             | 17 -------
 arch/um/kernel/mem.c                      | 19 ++++++++
 arch/x86/um/mem_32.c                      |  2 +-
 arch/xtensa/include/asm/pgtable.h         | 18 --------
 arch/xtensa/mm/init.c                     | 19 ++++++++
 include/linux/mm.h                        |  2 +-
 mm/mmap.c                                 | 19 --------
 50 files changed, 503 insertions(+), 489 deletions(-)

diff --git a/arch/alpha/include/asm/pgtable.h b/arch/alpha/include/asm/pgtable.h
index 170451fde043..3ea9661c09ff 100644
--- a/arch/alpha/include/asm/pgtable.h
+++ b/arch/alpha/include/asm/pgtable.h
@@ -116,23 +116,6 @@ struct vm_area_struct;
  * arch/alpha/mm/fault.c)
  */
 	/* xwr */
-#define __P000	_PAGE_P(_PAGE_FOE | _PAGE_FOW | _PAGE_FOR)
-#define __P001	_PAGE_P(_PAGE_FOE | _PAGE_FOW)
-#define __P010	_PAGE_P(_PAGE_FOE)
-#define __P011	_PAGE_P(_PAGE_FOE)
-#define __P100	_PAGE_P(_PAGE_FOW | _PAGE_FOR)
-#define __P101	_PAGE_P(_PAGE_FOW)
-#define __P110	_PAGE_P(0)
-#define __P111	_PAGE_P(0)
-
-#define __S000	_PAGE_S(_PAGE_FOE | _PAGE_FOW | _PAGE_FOR)
-#define __S001	_PAGE_S(_PAGE_FOE | _PAGE_FOW)
-#define __S010	_PAGE_S(_PAGE_FOE)
-#define __S011	_PAGE_S(_PAGE_FOE)
-#define __S100	_PAGE_S(_PAGE_FOW | _PAGE_FOR)
-#define __S101	_PAGE_S(_PAGE_FOW)
-#define __S110	_PAGE_S(0)
-#define __S111	_PAGE_S(0)
 
 /*
  * pgprot_noncached() is only for infiniband pci support, and a real
diff --git a/arch/alpha/mm/init.c b/arch/alpha/mm/init.c
index 7511723b7669..3f86cff0937b 100644
--- a/arch/alpha/mm/init.c
+++ b/arch/alpha/mm/init.c
@@ -280,3 +280,24 @@ mem_init(void)
 	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
 	memblock_free_all();
 }
+
+pgprot_t protection_map[16] __ro_after_init = {
+	[VM_NONE]					= _PAGE_P(_PAGE_FOE | _PAGE_FOW |
+								  _PAGE_FOR),
+	[VM_READ]					= _PAGE_P(_PAGE_FOE | _PAGE_FOW),
+	[VM_WRITE]					= _PAGE_P(_PAGE_FOE),
+	[VM_WRITE | VM_READ]				= _PAGE_P(_PAGE_FOE),
+	[VM_EXEC]					= _PAGE_P(_PAGE_FOW | _PAGE_FOR),
+	[VM_EXEC | VM_READ]				= _PAGE_P(_PAGE_FOW),
+	[VM_EXEC | VM_WRITE]				= _PAGE_P(0),
+	[VM_EXEC | VM_WRITE | VM_READ]			= _PAGE_P(0),
+	[VM_SHARED]					= _PAGE_S(_PAGE_FOE | _PAGE_FOW |
+								  _PAGE_FOR),
+	[VM_SHARED | VM_READ]				= _PAGE_S(_PAGE_FOE | _PAGE_FOW),
+	[VM_SHARED | VM_WRITE]				= _PAGE_S(_PAGE_FOE),
+	[VM_SHARED | VM_WRITE | VM_READ]		= _PAGE_S(_PAGE_FOE),
+	[VM_SHARED | VM_EXEC]				= _PAGE_S(_PAGE_FOW | _PAGE_FOR),
+	[VM_SHARED | VM_EXEC | VM_READ]			= _PAGE_S(_PAGE_FOW),
+	[VM_SHARED | VM_EXEC | VM_WRITE]		= _PAGE_S(0),
+	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= _PAGE_S(0)
+};
diff --git a/arch/arc/include/asm/pgtable-bits-arcv2.h b/arch/arc/include/asm/pgtable-bits-arcv2.h
index 183d23bc1e00..b23be557403e 100644
--- a/arch/arc/include/asm/pgtable-bits-arcv2.h
+++ b/arch/arc/include/asm/pgtable-bits-arcv2.h
@@ -72,24 +72,6 @@
  *     This is to enable COW mechanism
  */
 	/* xwr */
-#define __P000  PAGE_U_NONE
-#define __P001  PAGE_U_R
-#define __P010  PAGE_U_R	/* Pvt-W => !W */
-#define __P011  PAGE_U_R	/* Pvt-W => !W */
-#define __P100  PAGE_U_X_R	/* X => R */
-#define __P101  PAGE_U_X_R
-#define __P110  PAGE_U_X_R	/* Pvt-W => !W and X => R */
-#define __P111  PAGE_U_X_R	/* Pvt-W => !W */
-
-#define __S000  PAGE_U_NONE
-#define __S001  PAGE_U_R
-#define __S010  PAGE_U_W_R	/* W => R */
-#define __S011  PAGE_U_W_R
-#define __S100  PAGE_U_X_R	/* X => R */
-#define __S101  PAGE_U_X_R
-#define __S110  PAGE_U_X_W_R	/* X => R */
-#define __S111  PAGE_U_X_W_R
-
 #ifndef __ASSEMBLY__
 
 #define pte_write(pte)		(pte_val(pte) & _PAGE_WRITE)
diff --git a/arch/arc/mm/mmap.c b/arch/arc/mm/mmap.c
index 722d26b94307..114e6ac6613f 100644
--- a/arch/arc/mm/mmap.c
+++ b/arch/arc/mm/mmap.c
@@ -74,3 +74,22 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	info.align_offset = pgoff << PAGE_SHIFT;
 	return vm_unmapped_area(&info);
 }
+
+pgprot_t protection_map[16] __ro_after_init = {
+	[VM_NONE]					= PAGE_U_NONE,
+	[VM_READ]					= PAGE_U_R,
+	[VM_WRITE]					= PAGE_U_R,
+	[VM_WRITE | VM_READ]				= PAGE_U_R,
+	[VM_EXEC]					= PAGE_U_X_R,
+	[VM_EXEC | VM_READ]				= PAGE_U_X_R,
+	[VM_EXEC | VM_WRITE]				= PAGE_U_X_R,
+	[VM_EXEC | VM_WRITE | VM_READ]			= PAGE_U_X_R,
+	[VM_SHARED]					= PAGE_U_NONE,
+	[VM_SHARED | VM_READ]				= PAGE_U_R,
+	[VM_SHARED | VM_WRITE]				= PAGE_U_W_R,
+	[VM_SHARED | VM_WRITE | VM_READ]		= PAGE_U_W_R,
+	[VM_SHARED | VM_EXEC]				= PAGE_U_X_R,
+	[VM_SHARED | VM_EXEC | VM_READ]			= PAGE_U_X_R,
+	[VM_SHARED | VM_EXEC | VM_WRITE]		= PAGE_U_X_W_R,
+	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= PAGE_U_X_W_R
+};
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index cd1f84bb40ae..78a532068fec 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -137,23 +137,6 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
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
 
 #ifndef __ASSEMBLY__
 /*
diff --git a/arch/arm/lib/uaccess_with_memcpy.c b/arch/arm/lib/uaccess_with_memcpy.c
index c30b689bec2e..14eecaaf295f 100644
--- a/arch/arm/lib/uaccess_with_memcpy.c
+++ b/arch/arm/lib/uaccess_with_memcpy.c
@@ -237,7 +237,7 @@ static int __init test_size_treshold(void)
 	if (!dst_page)
 		goto no_dst;
 	kernel_ptr = page_address(src_page);
-	user_ptr = vmap(&dst_page, 1, VM_IOREMAP, __pgprot(__P010));
+	user_ptr = vmap(&dst_page, 1, VM_IOREMAP, __pgprot(__PAGE_COPY));
 	if (!user_ptr)
 		goto no_vmap;
 
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 5e2be37a198e..3d1174e9960c 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1773,3 +1773,22 @@ void set_pte_at(struct mm_struct *mm, unsigned long addr,
 
 	set_pte_ext(ptep, pteval, ext);
 }
+
+pgprot_t protection_map[16] __ro_after_init = {
+	[VM_NONE]					= __PAGE_NONE,
+	[VM_READ]					= __PAGE_READONLY,
+	[VM_WRITE]					= __PAGE_COPY,
+	[VM_WRITE | VM_READ]				= __PAGE_COPY,
+	[VM_EXEC]					= __PAGE_READONLY_EXEC,
+	[VM_EXEC | VM_READ]				= __PAGE_READONLY_EXEC,
+	[VM_EXEC | VM_WRITE]				= __PAGE_COPY_EXEC,
+	[VM_EXEC | VM_WRITE | VM_READ]			= __PAGE_COPY_EXEC,
+	[VM_SHARED]					= __PAGE_NONE,
+	[VM_SHARED | VM_READ]				= __PAGE_READONLY,
+	[VM_SHARED | VM_WRITE]				= __PAGE_SHARED,
+	[VM_SHARED | VM_WRITE | VM_READ]		= __PAGE_SHARED,
+	[VM_SHARED | VM_EXEC]				= __PAGE_READONLY_EXEC,
+	[VM_SHARED | VM_EXEC | VM_READ]			= __PAGE_READONLY_EXEC,
+	[VM_SHARED | VM_EXEC | VM_WRITE]		= __PAGE_SHARED_EXEC,
+	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= __PAGE_SHARED_EXEC
+};
diff --git a/arch/csky/include/asm/pgtable.h b/arch/csky/include/asm/pgtable.h
index bbe245117777..229a5f4ad7fc 100644
--- a/arch/csky/include/asm/pgtable.h
+++ b/arch/csky/include/asm/pgtable.h
@@ -77,24 +77,6 @@
 #define MAX_SWAPFILES_CHECK() \
 		BUILD_BUG_ON(MAX_SWAPFILES_SHIFT != 5)
 
-#define __P000	PAGE_NONE
-#define __P001	PAGE_READ
-#define __P010	PAGE_READ
-#define __P011	PAGE_READ
-#define __P100	PAGE_READ
-#define __P101	PAGE_READ
-#define __P110	PAGE_READ
-#define __P111	PAGE_READ
-
-#define __S000	PAGE_NONE
-#define __S001	PAGE_READ
-#define __S010	PAGE_WRITE
-#define __S011	PAGE_WRITE
-#define __S100	PAGE_READ
-#define __S101	PAGE_READ
-#define __S110	PAGE_WRITE
-#define __S111	PAGE_WRITE
-
 extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
 #define ZERO_PAGE(vaddr)	(virt_to_page(empty_zero_page))
 
diff --git a/arch/csky/mm/init.c b/arch/csky/mm/init.c
index bf2004aa811a..cd9b8001b021 100644
--- a/arch/csky/mm/init.c
+++ b/arch/csky/mm/init.c
@@ -197,3 +197,22 @@ void __init fixaddr_init(void)
 	vaddr = __fix_to_virt(__end_of_fixed_addresses - 1) & PMD_MASK;
 	fixrange_init(vaddr, vaddr + PMD_SIZE, swapper_pg_dir);
 }
+
+pgprot_t protection_map[16] __ro_after_init = {
+	[VM_NONE]					= PAGE_NONE,
+	[VM_READ]					= PAGE_READ,
+	[VM_WRITE]					= PAGE_READ,
+	[VM_WRITE | VM_READ]				= PAGE_READ,
+	[VM_EXEC]					= PAGE_READ,
+	[VM_EXEC | VM_READ]				= PAGE_READ,
+	[VM_EXEC | VM_WRITE]				= PAGE_READ,
+	[VM_EXEC | VM_WRITE | VM_READ]			= PAGE_READ,
+	[VM_SHARED]					= PAGE_NONE,
+	[VM_SHARED | VM_READ]				= PAGE_READ,
+	[VM_SHARED | VM_WRITE]				= PAGE_WRITE,
+	[VM_SHARED | VM_WRITE | VM_READ]		= PAGE_WRITE,
+	[VM_SHARED | VM_EXEC]				= PAGE_READ,
+	[VM_SHARED | VM_EXEC | VM_READ]			= PAGE_READ,
+	[VM_SHARED | VM_EXEC | VM_WRITE]		= PAGE_WRITE,
+	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= PAGE_WRITE
+};
diff --git a/arch/hexagon/include/asm/pgtable.h b/arch/hexagon/include/asm/pgtable.h
index 0610724d6a28..f7048c18b6f9 100644
--- a/arch/hexagon/include/asm/pgtable.h
+++ b/arch/hexagon/include/asm/pgtable.h
@@ -126,33 +126,6 @@ extern unsigned long _dflt_cache_att;
  */
 #define CACHEDEF	(CACHE_DEFAULT << 6)
 
-/* Private (copy-on-write) page protections. */
-#define __P000 __pgprot(_PAGE_PRESENT | _PAGE_USER | CACHEDEF)
-#define __P001 __pgprot(_PAGE_PRESENT | _PAGE_USER | _PAGE_READ | CACHEDEF)
-#define __P010 __P000	/* Write-only copy-on-write */
-#define __P011 __P001	/* Read/Write copy-on-write */
-#define __P100 __pgprot(_PAGE_PRESENT | _PAGE_USER | \
-			_PAGE_EXECUTE | CACHEDEF)
-#define __P101 __pgprot(_PAGE_PRESENT | _PAGE_USER | _PAGE_EXECUTE | \
-			_PAGE_READ | CACHEDEF)
-#define __P110 __P100	/* Write/execute copy-on-write */
-#define __P111 __P101	/* Read/Write/Execute, copy-on-write */
-
-/* Shared page protections. */
-#define __S000 __P000
-#define __S001 __P001
-#define __S010 __pgprot(_PAGE_PRESENT | _PAGE_USER | \
-			_PAGE_WRITE | CACHEDEF)
-#define __S011 __pgprot(_PAGE_PRESENT | _PAGE_USER | _PAGE_READ | \
-			_PAGE_WRITE | CACHEDEF)
-#define __S100 __pgprot(_PAGE_PRESENT | _PAGE_USER | \
-			_PAGE_EXECUTE | CACHEDEF)
-#define __S101 __P101
-#define __S110 __pgprot(_PAGE_PRESENT | _PAGE_USER | \
-			_PAGE_EXECUTE | _PAGE_WRITE | CACHEDEF)
-#define __S111 __pgprot(_PAGE_PRESENT | _PAGE_USER | _PAGE_READ | \
-			_PAGE_EXECUTE | _PAGE_WRITE | CACHEDEF)
-
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];  /* located in head.S */
 
 /*  HUGETLB not working currently  */
diff --git a/arch/hexagon/mm/init.c b/arch/hexagon/mm/init.c
index 3167a3b5c97b..319952b2dabf 100644
--- a/arch/hexagon/mm/init.c
+++ b/arch/hexagon/mm/init.c
@@ -234,3 +234,44 @@ void __init setup_arch_memory(void)
 	 *  which is called by start_kernel() later on in the process
 	 */
 }
+
+pgprot_t protection_map[16] __ro_after_init = {
+	[VM_NONE]					= __pgprot(_PAGE_PRESENT | _PAGE_USER |
+								   CACHEDEF),
+	[VM_READ]					= __pgprot(_PAGE_PRESENT | _PAGE_USER |
+								   _PAGE_READ | CACHEDEF),
+	[VM_WRITE]					= __pgprot(_PAGE_PRESENT | _PAGE_USER |
+								   CACHEDEF),
+	[VM_WRITE | VM_READ]				= __pgprot(_PAGE_PRESENT | _PAGE_USER |
+								   _PAGE_READ | CACHEDEF),
+	[VM_EXEC]					= __pgprot(_PAGE_PRESENT | _PAGE_USER |
+								   _PAGE_EXECUTE | CACHEDEF),
+	[VM_EXEC | VM_READ]				= __pgprot(_PAGE_PRESENT | _PAGE_USER |
+								   _PAGE_EXECUTE | _PAGE_READ |
+								   CACHEDEF),
+	[VM_EXEC | VM_WRITE]				= __pgprot(_PAGE_PRESENT | _PAGE_USER |
+								   _PAGE_EXECUTE | CACHEDEF),
+	[VM_EXEC | VM_WRITE | VM_READ]			= __pgprot(_PAGE_PRESENT | _PAGE_USER |
+								   _PAGE_EXECUTE | _PAGE_READ |
+								   CACHEDEF),
+	[VM_SHARED]                                     = __pgprot(_PAGE_PRESENT | _PAGE_USER |
+								   CACHEDEF),
+	[VM_SHARED | VM_READ]				= __pgprot(_PAGE_PRESENT | _PAGE_USER |
+								   _PAGE_READ | CACHEDEF),
+	[VM_SHARED | VM_WRITE]				= __pgprot(_PAGE_PRESENT | _PAGE_USER |
+								   _PAGE_WRITE | CACHEDEF),
+	[VM_SHARED | VM_WRITE | VM_READ]		= __pgprot(_PAGE_PRESENT | _PAGE_USER |
+								   _PAGE_READ | _PAGE_WRITE |
+								   CACHEDEF),
+	[VM_SHARED | VM_EXEC]				= __pgprot(_PAGE_PRESENT | _PAGE_USER |
+								   _PAGE_EXECUTE | CACHEDEF),
+	[VM_SHARED | VM_EXEC | VM_READ]			= __pgprot(_PAGE_PRESENT | _PAGE_USER |
+								   _PAGE_EXECUTE | _PAGE_READ |
+								   CACHEDEF),
+	[VM_SHARED | VM_EXEC | VM_WRITE]		= __pgprot(_PAGE_PRESENT | _PAGE_USER |
+								   _PAGE_EXECUTE | _PAGE_WRITE |
+								   CACHEDEF),
+	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= __pgprot(_PAGE_PRESENT | _PAGE_USER |
+								   _PAGE_READ | _PAGE_EXECUTE |
+								   _PAGE_WRITE | CACHEDEF)
+};
diff --git a/arch/ia64/include/asm/pgtable.h b/arch/ia64/include/asm/pgtable.h
index 7aa8f2330fb1..6925e28ae61d 100644
--- a/arch/ia64/include/asm/pgtable.h
+++ b/arch/ia64/include/asm/pgtable.h
@@ -161,24 +161,6 @@
  * attempts to write to the page.
  */
 	/* xwr */
-#define __P000	PAGE_NONE
-#define __P001	PAGE_READONLY
-#define __P010	PAGE_READONLY	/* write to priv pg -> copy & make writable */
-#define __P011	PAGE_READONLY	/* ditto */
-#define __P100	__pgprot(__ACCESS_BITS | _PAGE_PL_3 | _PAGE_AR_X_RX)
-#define __P101	__pgprot(__ACCESS_BITS | _PAGE_PL_3 | _PAGE_AR_RX)
-#define __P110	PAGE_COPY_EXEC
-#define __P111	PAGE_COPY_EXEC
-
-#define __S000	PAGE_NONE
-#define __S001	PAGE_READONLY
-#define __S010	PAGE_SHARED	/* we don't have (and don't need) write-only */
-#define __S011	PAGE_SHARED
-#define __S100	__pgprot(__ACCESS_BITS | _PAGE_PL_3 | _PAGE_AR_X_RX)
-#define __S101	__pgprot(__ACCESS_BITS | _PAGE_PL_3 | _PAGE_AR_RX)
-#define __S110	__pgprot(__ACCESS_BITS | _PAGE_PL_3 | _PAGE_AR_RWX)
-#define __S111	__pgprot(__ACCESS_BITS | _PAGE_PL_3 | _PAGE_AR_RWX)
-
 #define pgd_ERROR(e)	printk("%s:%d: bad pgd %016lx.\n", __FILE__, __LINE__, pgd_val(e))
 #if CONFIG_PGTABLE_LEVELS == 4
 #define pud_ERROR(e)	printk("%s:%d: bad pud %016lx.\n", __FILE__, __LINE__, pud_val(e))
diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
index 855d949d81df..1a86188c738c 100644
--- a/arch/ia64/mm/init.c
+++ b/arch/ia64/mm/init.c
@@ -273,7 +273,7 @@ static int __init gate_vma_init(void)
 	gate_vma.vm_start = FIXADDR_USER_START;
 	gate_vma.vm_end = FIXADDR_USER_END;
 	gate_vma.vm_flags = VM_READ | VM_MAYREAD | VM_EXEC | VM_MAYEXEC;
-	gate_vma.vm_page_prot = __P101;
+	gate_vma.vm_page_prot = __pgprot(__ACCESS_BITS | _PAGE_PL_3 | _PAGE_AR_RX);
 
 	return 0;
 }
@@ -490,3 +490,28 @@ void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
 	__remove_pages(start_pfn, nr_pages, altmap);
 }
 #endif
+
+pgprot_t protection_map[16] __ro_after_init = {
+	[VM_NONE]					= PAGE_NONE,
+	[VM_READ]					= PAGE_READONLY,
+	[VM_WRITE]					= PAGE_READONLY,
+	[VM_WRITE | VM_READ]				= PAGE_READONLY,
+	[VM_EXEC]					= __pgprot(__ACCESS_BITS | _PAGE_PL_3 |
+								   _PAGE_AR_X_RX),
+	[VM_EXEC | VM_READ]				= __pgprot(__ACCESS_BITS | _PAGE_PL_3 |
+								   _PAGE_AR_RX),
+	[VM_EXEC | VM_WRITE]				= PAGE_COPY_EXEC,
+	[VM_EXEC | VM_WRITE | VM_READ]			= PAGE_COPY_EXEC,
+	[VM_SHARED]					= PAGE_NONE,
+	[VM_SHARED | VM_READ]				= PAGE_READONLY,
+	[VM_SHARED | VM_WRITE]				= PAGE_SHARED,
+	[VM_SHARED | VM_WRITE | VM_READ]		= PAGE_SHARED,
+	[VM_SHARED | VM_EXEC]				= __pgprot(__ACCESS_BITS | _PAGE_PL_3 |
+								   _PAGE_AR_X_RX),
+	[VM_SHARED | VM_EXEC | VM_READ]			= __pgprot(__ACCESS_BITS | _PAGE_PL_3 |
+								   _PAGE_AR_RX),
+	[VM_SHARED | VM_EXEC | VM_WRITE]		= __pgprot(__ACCESS_BITS | _PAGE_PL_3 |
+								   _PAGE_AR_RWX),
+	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= __pgprot(__ACCESS_BITS | _PAGE_PL_3 |
+								   _PAGE_AR_RWX)
+};
diff --git a/arch/loongarch/include/asm/pgtable-bits.h b/arch/loongarch/include/asm/pgtable-bits.h
index 3badd112d9ab..9ca147a29bab 100644
--- a/arch/loongarch/include/asm/pgtable-bits.h
+++ b/arch/loongarch/include/asm/pgtable-bits.h
@@ -83,25 +83,6 @@
 				 _PAGE_GLOBAL | _PAGE_KERN |  _CACHE_SUC)
 #define PAGE_KERNEL_WUC __pgprot(_PAGE_PRESENT | __READABLE | __WRITEABLE | \
 				 _PAGE_GLOBAL | _PAGE_KERN |  _CACHE_WUC)
-
-#define __P000 __pgprot(_CACHE_CC | _PAGE_USER | _PAGE_PROTNONE | _PAGE_NO_EXEC | _PAGE_NO_READ)
-#define __P001 __pgprot(_CACHE_CC | _PAGE_VALID | _PAGE_USER | _PAGE_PRESENT | _PAGE_NO_EXEC)
-#define __P010 __pgprot(_CACHE_CC | _PAGE_VALID | _PAGE_USER | _PAGE_PRESENT | _PAGE_NO_EXEC)
-#define __P011 __pgprot(_CACHE_CC | _PAGE_VALID | _PAGE_USER | _PAGE_PRESENT | _PAGE_NO_EXEC)
-#define __P100 __pgprot(_CACHE_CC | _PAGE_VALID | _PAGE_USER | _PAGE_PRESENT)
-#define __P101 __pgprot(_CACHE_CC | _PAGE_VALID | _PAGE_USER | _PAGE_PRESENT)
-#define __P110 __pgprot(_CACHE_CC | _PAGE_VALID | _PAGE_USER | _PAGE_PRESENT)
-#define __P111 __pgprot(_CACHE_CC | _PAGE_VALID | _PAGE_USER | _PAGE_PRESENT)
-
-#define __S000 __pgprot(_CACHE_CC | _PAGE_USER | _PAGE_PROTNONE | _PAGE_NO_EXEC | _PAGE_NO_READ)
-#define __S001 __pgprot(_CACHE_CC | _PAGE_VALID | _PAGE_USER | _PAGE_PRESENT | _PAGE_NO_EXEC)
-#define __S010 __pgprot(_CACHE_CC | _PAGE_VALID | _PAGE_USER | _PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_WRITE)
-#define __S011 __pgprot(_CACHE_CC | _PAGE_VALID | _PAGE_USER | _PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_WRITE)
-#define __S100 __pgprot(_CACHE_CC | _PAGE_VALID | _PAGE_USER | _PAGE_PRESENT)
-#define __S101 __pgprot(_CACHE_CC | _PAGE_VALID | _PAGE_USER | _PAGE_PRESENT)
-#define __S110 __pgprot(_CACHE_CC | _PAGE_VALID | _PAGE_USER | _PAGE_PRESENT | _PAGE_WRITE)
-#define __S111 __pgprot(_CACHE_CC | _PAGE_VALID | _PAGE_USER | _PAGE_PRESENT | _PAGE_WRITE)
-
 #ifndef __ASSEMBLY__
 
 #define pgprot_noncached pgprot_noncached
diff --git a/arch/loongarch/mm/cache.c b/arch/loongarch/mm/cache.c
index 9e5ce5aa73f7..fd7053c07c71 100644
--- a/arch/loongarch/mm/cache.c
+++ b/arch/loongarch/mm/cache.c
@@ -139,3 +139,48 @@ void cpu_cache_init(void)
 
 	shm_align_mask = PAGE_SIZE - 1;
 }
+
+pgprot_t protection_map[16] __ro_after_init = {
+	[VM_NONE]					= __pgprot(_CACHE_CC | _PAGE_USER |
+								   _PAGE_PROTNONE | _PAGE_NO_EXEC |
+								   _PAGE_NO_READ),
+	[VM_READ]					= __pgprot(_CACHE_CC | _PAGE_VALID |
+								   _PAGE_USER | _PAGE_PRESENT |
+								   _PAGE_NO_EXEC),
+	[VM_WRITE]					= __pgprot(_CACHE_CC | _PAGE_VALID |
+								   _PAGE_USER | _PAGE_PRESENT |
+								   _PAGE_NO_EXEC),
+	[VM_WRITE | VM_READ]				= __pgprot(_CACHE_CC | _PAGE_VALID |
+								   _PAGE_USER | _PAGE_PRESENT |
+								   _PAGE_NO_EXEC),
+	[VM_EXEC]					= __pgprot(_CACHE_CC | _PAGE_VALID |
+								   _PAGE_USER | _PAGE_PRESENT),
+	[VM_EXEC | VM_READ]				= __pgprot(_CACHE_CC | _PAGE_VALID |
+								   _PAGE_USER | _PAGE_PRESENT),
+	[VM_EXEC | VM_WRITE]				= __pgprot(_CACHE_CC | _PAGE_VALID |
+								   _PAGE_USER | _PAGE_PRESENT),
+	[VM_EXEC | VM_WRITE | VM_READ]			= __pgprot(_CACHE_CC | _PAGE_VALID |
+								   _PAGE_USER | _PAGE_PRESENT),
+	[VM_SHARED]					= __pgprot(_CACHE_CC | _PAGE_USER |
+								   _PAGE_PROTNONE | _PAGE_NO_EXEC |
+								   _PAGE_NO_READ),
+	[VM_SHARED | VM_READ]				= __pgprot(_CACHE_CC | _PAGE_VALID |
+								   _PAGE_USER | _PAGE_PRESENT |
+								   _PAGE_NO_EXEC),
+	[VM_SHARED | VM_WRITE]				= __pgprot(_CACHE_CC | _PAGE_VALID |
+								   _PAGE_USER | _PAGE_PRESENT |
+								   _PAGE_NO_EXEC | _PAGE_WRITE),
+	[VM_SHARED | VM_WRITE | VM_READ]		= __pgprot(_CACHE_CC | _PAGE_VALID |
+								   _PAGE_USER | _PAGE_PRESENT |
+								   _PAGE_NO_EXEC | _PAGE_WRITE),
+	[VM_SHARED | VM_EXEC]				= __pgprot(_CACHE_CC | _PAGE_VALID |
+								   _PAGE_USER | _PAGE_PRESENT),
+	[VM_SHARED | VM_EXEC | VM_READ]			= __pgprot(_CACHE_CC | _PAGE_VALID |
+								   _PAGE_USER | _PAGE_PRESENT),
+	[VM_SHARED | VM_EXEC | VM_WRITE]		= __pgprot(_CACHE_CC | _PAGE_VALID |
+								   _PAGE_USER | _PAGE_PRESENT |
+								   _PAGE_WRITE),
+	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= __pgprot(_CACHE_CC | _PAGE_VALID |
+								   _PAGE_USER | _PAGE_PRESENT |
+								   _PAGE_WRITE)
+};
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
index 6f1f25125294..5502f26d39f7 100644
--- a/arch/m68k/mm/mcfmmu.c
+++ b/arch/m68k/mm/mcfmmu.c
@@ -234,3 +234,57 @@ void steal_context(void)
 	destroy_context(mm);
 }
 
+pgprot_t protection_map[16] __ro_after_init = {
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
diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
index df7f797c908a..2a633feffb60 100644
--- a/arch/m68k/mm/motorola.c
+++ b/arch/m68k/mm/motorola.c
@@ -482,3 +482,22 @@ void __init paging_init(void)
 	max_zone_pfn[ZONE_DMA] = memblock_end_of_DRAM();
 	free_area_init(max_zone_pfn);
 }
+
+pgprot_t protection_map[16] __ro_after_init = {
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
diff --git a/arch/m68k/mm/sun3mmu.c b/arch/m68k/mm/sun3mmu.c
index dad494224497..b2e6220e3d20 100644
--- a/arch/m68k/mm/sun3mmu.c
+++ b/arch/m68k/mm/sun3mmu.c
@@ -95,3 +95,22 @@ void __init paging_init(void)
 
 
 }
+
+pgprot_t protection_map[16] __ro_after_init = {
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
diff --git a/arch/microblaze/include/asm/pgtable.h b/arch/microblaze/include/asm/pgtable.h
index 0c72646370e1..ba348e997dbb 100644
--- a/arch/microblaze/include/asm/pgtable.h
+++ b/arch/microblaze/include/asm/pgtable.h
@@ -204,23 +204,6 @@ extern pte_t *va_to_pte(unsigned long address);
  * We consider execute permission the same as read.
  * Also, write permissions imply read permissions.
  */
-#define __P000	PAGE_NONE
-#define __P001	PAGE_READONLY_X
-#define __P010	PAGE_COPY
-#define __P011	PAGE_COPY_X
-#define __P100	PAGE_READONLY
-#define __P101	PAGE_READONLY_X
-#define __P110	PAGE_COPY
-#define __P111	PAGE_COPY_X
-
-#define __S000	PAGE_NONE
-#define __S001	PAGE_READONLY_X
-#define __S010	PAGE_SHARED
-#define __S011	PAGE_SHARED_X
-#define __S100	PAGE_READONLY
-#define __S101	PAGE_READONLY_X
-#define __S110	PAGE_SHARED
-#define __S111	PAGE_SHARED_X
 
 #ifndef __ASSEMBLY__
 /*
diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
index f4e503461d24..4bf4ee8344ea 100644
--- a/arch/microblaze/mm/init.c
+++ b/arch/microblaze/mm/init.c
@@ -285,3 +285,22 @@ void * __ref zalloc_maybe_bootmem(size_t size, gfp_t mask)
 
 	return p;
 }
+
+pgprot_t protection_map[16] __ro_after_init = {
+	[VM_NONE]					= PAGE_NONE,
+	[VM_READ]					= PAGE_READONLY_X,
+	[VM_WRITE]					= PAGE_COPY,
+	[VM_WRITE | VM_READ]				= PAGE_COPY_X,
+	[VM_EXEC]					= PAGE_READONLY,
+	[VM_EXEC | VM_READ]				= PAGE_READONLY_X,
+	[VM_EXEC | VM_WRITE]				= PAGE_COPY,
+	[VM_EXEC | VM_WRITE | VM_READ]			= PAGE_COPY_X,
+	[VM_SHARED]					= PAGE_NONE,
+	[VM_SHARED | VM_READ]				= PAGE_READONLY_X,
+	[VM_SHARED | VM_WRITE]				= PAGE_SHARED,
+	[VM_SHARED | VM_WRITE | VM_READ]		= PAGE_SHARED_X,
+	[VM_SHARED | VM_EXEC]				= PAGE_READONLY,
+	[VM_SHARED | VM_EXEC | VM_READ]			= PAGE_READONLY_X,
+	[VM_SHARED | VM_EXEC | VM_WRITE]		= PAGE_SHARED,
+	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= PAGE_SHARED_X
+};
diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index 374c6322775d..6caec386ad2f 100644
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
index 7be7240f7703..d2fe64a0a31c 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -159,6 +159,8 @@ EXPORT_SYMBOL(_page_cachable_default);
 
 #define PM(p)	__pgprot(_page_cachable_default | (p))
 
+pgprot_t protection_map[16];
+
 static inline void setup_protection_map(void)
 {
 	protection_map[0]  = PM(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ);
diff --git a/arch/nios2/include/asm/pgtable.h b/arch/nios2/include/asm/pgtable.h
index 262d0609268c..470516d4555e 100644
--- a/arch/nios2/include/asm/pgtable.h
+++ b/arch/nios2/include/asm/pgtable.h
@@ -40,24 +40,8 @@ struct mm_struct;
  */
 
 /* Remove W bit on private pages for COW support */
-#define __P000	MKP(0, 0, 0)
-#define __P001	MKP(0, 0, 1)
-#define __P010	MKP(0, 0, 0)	/* COW */
-#define __P011	MKP(0, 0, 1)	/* COW */
-#define __P100	MKP(1, 0, 0)
-#define __P101	MKP(1, 0, 1)
-#define __P110	MKP(1, 0, 0)	/* COW */
-#define __P111	MKP(1, 0, 1)	/* COW */
 
 /* Shared pages can have exact HW mapping */
-#define __S000	MKP(0, 0, 0)
-#define __S001	MKP(0, 0, 1)
-#define __S010	MKP(0, 1, 0)
-#define __S011	MKP(0, 1, 1)
-#define __S100	MKP(1, 0, 0)
-#define __S101	MKP(1, 0, 1)
-#define __S110	MKP(1, 1, 0)
-#define __S111	MKP(1, 1, 1)
 
 /* Used all over the kernel */
 #define PAGE_KERNEL __pgprot(_PAGE_PRESENT | _PAGE_CACHED | _PAGE_READ | \
diff --git a/arch/nios2/mm/init.c b/arch/nios2/mm/init.c
index 613fcaa5988a..fa1bc9c7da9a 100644
--- a/arch/nios2/mm/init.c
+++ b/arch/nios2/mm/init.c
@@ -124,3 +124,22 @@ const char *arch_vma_name(struct vm_area_struct *vma)
 {
 	return (vma->vm_start == KUSER_BASE) ? "[kuser]" : NULL;
 }
+
+pgprot_t protection_map[16] __ro_after_init = {
+	[VM_NONE]					= MKP(0, 0, 0),
+	[VM_READ]					= MKP(0, 0, 1),
+	[VM_WRITE]					= MKP(0, 0, 0),
+	[VM_WRITE | VM_READ]				= MKP(0, 0, 1),
+	[VM_EXEC]					= MKP(1, 0, 0),
+	[VM_EXEC | VM_READ]				= MKP(1, 0, 1),
+	[VM_EXEC | VM_WRITE]				= MKP(1, 0, 0),
+	[VM_EXEC | VM_WRITE | VM_READ]			= MKP(1, 0, 1),
+	[VM_SHARED]					= MKP(0, 0, 0),
+	[VM_SHARED | VM_READ]				= MKP(0, 0, 1),
+	[VM_SHARED | VM_WRITE]				= MKP(0, 1, 0),
+	[VM_SHARED | VM_WRITE | VM_READ]		= MKP(0, 1, 1),
+	[VM_SHARED | VM_EXEC]				= MKP(1, 0, 0),
+	[VM_SHARED | VM_EXEC | VM_READ]			= MKP(1, 0, 1),
+	[VM_SHARED | VM_EXEC | VM_WRITE]		= MKP(1, 1, 0),
+	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= MKP(1, 1, 1)
+};
diff --git a/arch/openrisc/include/asm/pgtable.h b/arch/openrisc/include/asm/pgtable.h
index c3abbf71e09f..dcae8aea132f 100644
--- a/arch/openrisc/include/asm/pgtable.h
+++ b/arch/openrisc/include/asm/pgtable.h
@@ -176,24 +176,6 @@ extern void paging_init(void);
 	__pgprot(_PAGE_ALL | _PAGE_SRE | _PAGE_SWE \
 		 | _PAGE_SHARED | _PAGE_DIRTY | _PAGE_EXEC | _PAGE_CI)
 
-#define __P000	PAGE_NONE
-#define __P001	PAGE_READONLY_X
-#define __P010	PAGE_COPY
-#define __P011	PAGE_COPY_X
-#define __P100	PAGE_READONLY
-#define __P101	PAGE_READONLY_X
-#define __P110	PAGE_COPY
-#define __P111	PAGE_COPY_X
-
-#define __S000	PAGE_NONE
-#define __S001	PAGE_READONLY_X
-#define __S010	PAGE_SHARED
-#define __S011	PAGE_SHARED_X
-#define __S100	PAGE_READONLY
-#define __S101	PAGE_READONLY_X
-#define __S110	PAGE_SHARED
-#define __S111	PAGE_SHARED_X
-
 /* zero page used for uninitialized stuff */
 extern unsigned long empty_zero_page[2048];
 #define ZERO_PAGE(vaddr) (virt_to_page(empty_zero_page))
diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
index 3a021ab6f1ae..5bebd8380e31 100644
--- a/arch/openrisc/mm/init.c
+++ b/arch/openrisc/mm/init.c
@@ -208,3 +208,22 @@ void __init mem_init(void)
 	mem_init_done = 1;
 	return;
 }
+
+pgprot_t protection_map[16] __ro_after_init = {
+	[VM_NONE]					= PAGE_NONE,
+	[VM_READ]					= PAGE_READONLY_X,
+	[VM_WRITE]					= PAGE_COPY,
+	[VM_WRITE | VM_READ]				= PAGE_COPY_X,
+	[VM_EXEC]					= PAGE_READONLY,
+	[VM_EXEC | VM_READ]				= PAGE_READONLY_X,
+	[VM_EXEC | VM_WRITE]				= PAGE_COPY,
+	[VM_EXEC | VM_WRITE | VM_READ]			= PAGE_COPY_X,
+	[VM_SHARED]					= PAGE_NONE,
+	[VM_SHARED | VM_READ]				= PAGE_READONLY_X,
+	[VM_SHARED | VM_WRITE]				= PAGE_SHARED,
+	[VM_SHARED | VM_WRITE | VM_READ]		= PAGE_SHARED_X,
+	[VM_SHARED | VM_EXEC]				= PAGE_READONLY,
+	[VM_SHARED | VM_EXEC | VM_READ]			= PAGE_READONLY_X,
+	[VM_SHARED | VM_EXEC | VM_WRITE]		= PAGE_SHARED,
+	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= PAGE_SHARED_X
+};
diff --git a/arch/parisc/include/asm/pgtable.h b/arch/parisc/include/asm/pgtable.h
index 69765a6dbe89..6a1899a9b420 100644
--- a/arch/parisc/include/asm/pgtable.h
+++ b/arch/parisc/include/asm/pgtable.h
@@ -271,24 +271,6 @@ extern void __update_cache(pte_t pte);
  */
 
 	 /*xwr*/
-#define __P000  PAGE_NONE
-#define __P001  PAGE_READONLY
-#define __P010  __P000 /* copy on write */
-#define __P011  __P001 /* copy on write */
-#define __P100  PAGE_EXECREAD
-#define __P101  PAGE_EXECREAD
-#define __P110  __P100 /* copy on write */
-#define __P111  __P101 /* copy on write */
-
-#define __S000  PAGE_NONE
-#define __S001  PAGE_READONLY
-#define __S010  PAGE_WRITEONLY
-#define __S011  PAGE_SHARED
-#define __S100  PAGE_EXECREAD
-#define __S101  PAGE_EXECREAD
-#define __S110  PAGE_RWX
-#define __S111  PAGE_RWX
-
 
 extern pgd_t swapper_pg_dir[]; /* declared in init_task.c */
 
diff --git a/arch/parisc/mm/init.c b/arch/parisc/mm/init.c
index 0a81499dd35e..77f5d2a9073e 100644
--- a/arch/parisc/mm/init.c
+++ b/arch/parisc/mm/init.c
@@ -871,3 +871,22 @@ void flush_tlb_all(void)
 	spin_unlock(&sid_lock);
 }
 #endif
+
+pgprot_t protection_map[16] __ro_after_init = {
+	[VM_NONE]					= PAGE_NONE,
+	[VM_READ]					= PAGE_READONLY,
+	[VM_WRITE]					= PAGE_NONE,
+	[VM_WRITE | VM_READ]				= PAGE_READONLY,
+	[VM_EXEC]					= PAGE_EXECREAD,
+	[VM_EXEC | VM_READ]				= PAGE_EXECREAD,
+	[VM_EXEC | VM_WRITE]				= PAGE_EXECREAD,
+	[VM_EXEC | VM_WRITE | VM_READ]			= PAGE_EXECREAD,
+	[VM_SHARED]					= PAGE_NONE,
+	[VM_SHARED | VM_READ]				= PAGE_READONLY,
+	[VM_SHARED | VM_WRITE]				= PAGE_WRITEONLY,
+	[VM_SHARED | VM_WRITE | VM_READ]		= PAGE_SHARED,
+	[VM_SHARED | VM_EXEC]				= PAGE_EXECREAD,
+	[VM_SHARED | VM_EXEC | VM_READ]			= PAGE_EXECREAD,
+	[VM_SHARED | VM_EXEC | VM_WRITE]		= PAGE_RWX,
+	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= PAGE_RWX
+};
diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 8ed2a80c896e..bd636295a794 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -21,26 +21,6 @@ struct mm_struct;
 #endif /* !CONFIG_PPC_BOOK3S */
 
 /* Note due to the way vm flags are laid out, the bits are XWR */
-#ifndef CONFIG_ARCH_HAS_VM_GET_PAGE_PROT
-#define __P000	PAGE_NONE
-#define __P001	PAGE_READONLY
-#define __P010	PAGE_COPY
-#define __P011	PAGE_COPY
-#define __P100	PAGE_READONLY_X
-#define __P101	PAGE_READONLY_X
-#define __P110	PAGE_COPY_X
-#define __P111	PAGE_COPY_X
-
-#define __S000	PAGE_NONE
-#define __S001	PAGE_READONLY
-#define __S010	PAGE_SHARED
-#define __S011	PAGE_SHARED
-#define __S100	PAGE_READONLY_X
-#define __S101	PAGE_READONLY_X
-#define __S110	PAGE_SHARED_X
-#define __S111	PAGE_SHARED_X
-#endif
-
 #ifndef __ASSEMBLY__
 
 #ifndef MAX_PTRS_PER_PGD
diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index d3b019b95c1d..de76dd4d447c 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -551,25 +551,11 @@ unsigned long memremap_compat_align(void)
 EXPORT_SYMBOL_GPL(memremap_compat_align);
 #endif
 
-/* Note due to the way vm flags are laid out, the bits are XWR */
-static const pgprot_t protection_map[16] = {
-	[VM_NONE]					= PAGE_NONE,
-	[VM_READ]					= PAGE_READONLY,
-	[VM_WRITE]					= PAGE_COPY,
-	[VM_WRITE | VM_READ]				= PAGE_COPY,
-	[VM_EXEC]					= PAGE_READONLY_X,
-	[VM_EXEC | VM_READ]				= PAGE_READONLY_X,
-	[VM_EXEC | VM_WRITE]				= PAGE_COPY_X,
-	[VM_EXEC | VM_WRITE | VM_READ]			= PAGE_COPY_X,
-	[VM_SHARED]					= PAGE_NONE,
-	[VM_SHARED | VM_READ]				= PAGE_READONLY,
-	[VM_SHARED | VM_WRITE]				= PAGE_SHARED,
-	[VM_SHARED | VM_WRITE | VM_READ]		= PAGE_SHARED,
-	[VM_SHARED | VM_EXEC]				= PAGE_READONLY_X,
-	[VM_SHARED | VM_EXEC | VM_READ]			= PAGE_READONLY_X,
-	[VM_SHARED | VM_EXEC | VM_WRITE]		= PAGE_SHARED_X,
-	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= PAGE_SHARED_X
-};
+/*
+ * Generic declaration in (include/linux/mm.h) is not available
+ * here as the platform enables ARCH_HAS_VM_GET_PAGE_PROT.
+ */
+extern pgprot_t protection_map[16];
 
 pgprot_t vm_get_page_prot(unsigned long vm_flags)
 {
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index e6166b71d36d..780fbecd7bf6 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -472,3 +472,23 @@ pte_t *__find_linux_pte(pgd_t *pgdir, unsigned long ea,
 	return ret_pte;
 }
 EXPORT_SYMBOL_GPL(__find_linux_pte);
+
+/* Note due to the way vm flags are laid out, the bits are XWR */
+pgprot_t protection_map[16] = {
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
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 1d1be9d9419c..23e643db6575 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -186,26 +186,6 @@ extern struct pt_alloc_ops pt_ops __initdata;
 
 extern pgd_t swapper_pg_dir[];
 
-/* MAP_PRIVATE permissions: xwr (copy-on-write) */
-#define __P000	PAGE_NONE
-#define __P001	PAGE_READ
-#define __P010	PAGE_COPY
-#define __P011	PAGE_COPY
-#define __P100	PAGE_EXEC
-#define __P101	PAGE_READ_EXEC
-#define __P110	PAGE_COPY_EXEC
-#define __P111	PAGE_COPY_READ_EXEC
-
-/* MAP_SHARED permissions: xwr */
-#define __S000	PAGE_NONE
-#define __S001	PAGE_READ
-#define __S010	PAGE_SHARED
-#define __S011	PAGE_SHARED
-#define __S100	PAGE_EXEC
-#define __S101	PAGE_READ_EXEC
-#define __S110	PAGE_SHARED_EXEC
-#define __S111	PAGE_SHARED_EXEC
-
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static inline int pmd_present(pmd_t pmd)
 {
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index d466ec670e1f..84ee476ba4a4 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -288,6 +288,25 @@ static pmd_t __maybe_unused early_dtb_pmd[PTRS_PER_PMD] __initdata __aligned(PAG
 #define early_pg_dir           ((pgd_t *)XIP_FIXUP(early_pg_dir))
 #endif /* CONFIG_XIP_KERNEL */
 
+pgprot_t protection_map[16] __ro_after_init = {
+	[VM_NONE]					= PAGE_NONE,
+	[VM_READ]					= PAGE_READ,
+	[VM_WRITE]					= PAGE_COPY,
+	[VM_WRITE | VM_READ]				= PAGE_COPY,
+	[VM_EXEC]					= PAGE_EXEC,
+	[VM_EXEC | VM_READ]				= PAGE_READ_EXEC,
+	[VM_EXEC | VM_WRITE]				= PAGE_COPY_EXEC,
+	[VM_EXEC | VM_WRITE | VM_READ]			= PAGE_COPY_READ_EXEC,
+	[VM_SHARED]					= PAGE_NONE,
+	[VM_SHARED | VM_READ]				= PAGE_READ,
+	[VM_SHARED | VM_WRITE]				= PAGE_SHARED,
+	[VM_SHARED | VM_WRITE | VM_READ]		= PAGE_SHARED,
+	[VM_SHARED | VM_EXEC]				= PAGE_EXEC,
+	[VM_SHARED | VM_EXEC | VM_READ]			= PAGE_READ_EXEC,
+	[VM_SHARED | VM_EXEC | VM_WRITE]		= PAGE_SHARED_EXEC,
+	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= PAGE_SHARED_EXEC
+};
+
 void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot)
 {
 	unsigned long addr = __fix_to_virt(idx);
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index a397b072a580..c63a05b5368a 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -424,23 +424,6 @@ static inline int is_module_addr(void *addr)
  * implies read permission.
  */
          /*xwr*/
-#define __P000	PAGE_NONE
-#define __P001	PAGE_RO
-#define __P010	PAGE_RO
-#define __P011	PAGE_RO
-#define __P100	PAGE_RX
-#define __P101	PAGE_RX
-#define __P110	PAGE_RX
-#define __P111	PAGE_RX
-
-#define __S000	PAGE_NONE
-#define __S001	PAGE_RO
-#define __S010	PAGE_RW
-#define __S011	PAGE_RW
-#define __S100	PAGE_RX
-#define __S101	PAGE_RX
-#define __S110	PAGE_RWX
-#define __S111	PAGE_RWX
 
 /*
  * Segment entry (large page) protection definitions.
diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
index d545f5c39f7e..25e6249d44ab 100644
--- a/arch/s390/mm/mmap.c
+++ b/arch/s390/mm/mmap.c
@@ -188,3 +188,22 @@ void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
 		mm->get_unmapped_area = arch_get_unmapped_area_topdown;
 	}
 }
+
+pgprot_t protection_map[16] = {
+	[VM_NONE]					= PAGE_NONE,
+	[VM_READ]					= PAGE_RO,
+	[VM_WRITE]					= PAGE_RO,
+	[VM_WRITE | VM_READ]				= PAGE_RO,
+	[VM_EXEC]					= PAGE_RX,
+	[VM_EXEC | VM_READ]				= PAGE_RX,
+	[VM_EXEC | VM_WRITE]				= PAGE_RX,
+	[VM_EXEC | VM_WRITE | VM_READ]			= PAGE_RX,
+	[VM_SHARED]					= PAGE_NONE,
+	[VM_SHARED | VM_READ]				= PAGE_RO,
+	[VM_SHARED | VM_WRITE]				= PAGE_RW,
+	[VM_SHARED | VM_WRITE | VM_READ]		= PAGE_RW,
+	[VM_SHARED | VM_EXEC]				= PAGE_RX,
+	[VM_SHARED | VM_EXEC | VM_READ]			= PAGE_RX,
+	[VM_SHARED | VM_EXEC | VM_WRITE]		= PAGE_RWX,
+	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= PAGE_RWX
+};
diff --git a/arch/sh/include/asm/pgtable.h b/arch/sh/include/asm/pgtable.h
index d7ddb1ec86a0..6fb9ec54cf9b 100644
--- a/arch/sh/include/asm/pgtable.h
+++ b/arch/sh/include/asm/pgtable.h
@@ -89,23 +89,6 @@ static inline unsigned long phys_addr_mask(void)
  * completely separate permission bits for user and kernel space.
  */
 	 /*xwr*/
-#define __P000	PAGE_NONE
-#define __P001	PAGE_READONLY
-#define __P010	PAGE_COPY
-#define __P011	PAGE_COPY
-#define __P100	PAGE_EXECREAD
-#define __P101	PAGE_EXECREAD
-#define __P110	PAGE_COPY
-#define __P111	PAGE_COPY
-
-#define __S000	PAGE_NONE
-#define __S001	PAGE_READONLY
-#define __S010	PAGE_WRITEONLY
-#define __S011	PAGE_SHARED
-#define __S100	PAGE_EXECREAD
-#define __S101	PAGE_EXECREAD
-#define __S110	PAGE_RWX
-#define __S111	PAGE_RWX
 
 typedef pte_t *pte_addr_t;
 
diff --git a/arch/sh/mm/mmap.c b/arch/sh/mm/mmap.c
index 6a1a1297baae..81fc312f9e97 100644
--- a/arch/sh/mm/mmap.c
+++ b/arch/sh/mm/mmap.c
@@ -162,3 +162,22 @@ int valid_mmap_phys_addr_range(unsigned long pfn, size_t size)
 {
 	return 1;
 }
+
+pgprot_t protection_map[16] __ro_after_init = {
+	[VM_NONE]					= PAGE_NONE,
+	[VM_READ]					= PAGE_READONLY,
+	[VM_WRITE]					= PAGE_COPY,
+	[VM_WRITE | VM_READ]				= PAGE_COPY,
+	[VM_EXEC]					= PAGE_EXECREAD,
+	[VM_EXEC | VM_READ]				= PAGE_EXECREAD,
+	[VM_EXEC | VM_WRITE]				= PAGE_COPY,
+	[VM_EXEC | VM_WRITE | VM_READ]			= PAGE_COPY,
+	[VM_SHARED]					= PAGE_NONE,
+	[VM_SHARED | VM_READ]				= PAGE_READONLY,
+	[VM_SHARED | VM_WRITE]				= PAGE_WRITEONLY,
+	[VM_SHARED | VM_WRITE | VM_READ]		= PAGE_SHARED,
+	[VM_SHARED | VM_EXEC]				= PAGE_EXECREAD,
+	[VM_SHARED | VM_EXEC | VM_READ]			= PAGE_EXECREAD,
+	[VM_SHARED | VM_EXEC | VM_WRITE]		= PAGE_RWX,
+	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= PAGE_RWX
+};
diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index 4866625da314..8ff549004fac 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -64,25 +64,6 @@ void paging_init(void);
 
 extern unsigned long ptr_in_current_pgd;
 
-/*         xwr */
-#define __P000  PAGE_NONE
-#define __P001  PAGE_READONLY
-#define __P010  PAGE_COPY
-#define __P011  PAGE_COPY
-#define __P100  PAGE_READONLY
-#define __P101  PAGE_READONLY
-#define __P110  PAGE_COPY
-#define __P111  PAGE_COPY
-
-#define __S000	PAGE_NONE
-#define __S001	PAGE_READONLY
-#define __S010	PAGE_SHARED
-#define __S011	PAGE_SHARED
-#define __S100	PAGE_READONLY
-#define __S101	PAGE_READONLY
-#define __S110	PAGE_SHARED
-#define __S111	PAGE_SHARED
-
 /* First physical page can be anywhere, the following is needed so that
  * va-->pa and vice versa conversions work properly without performance
  * hit for all __pa()/__va() operations.
diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index 1e9f577f084d..98d100982d7c 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -302,3 +302,22 @@ void sparc_flush_page_to_ram(struct page *page)
 		__flush_page_to_ram(vaddr);
 }
 EXPORT_SYMBOL(sparc_flush_page_to_ram);
+
+pgprot_t protection_map[16] __ro_after_init = {
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
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index d6faee23c77d..0e76c355c563 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2635,7 +2635,7 @@ void vmemmap_free(unsigned long start, unsigned long end,
 #endif /* CONFIG_SPARSEMEM_VMEMMAP */
 
 /* These are actually filled in at boot time by sun4{u,v}_pgprot_init() */
-static pgprot_t protection_map[16] __ro_after_init;
+pgprot_t protection_map[16] __ro_after_init;
 
 static void prot_init_common(unsigned long page_none,
 			     unsigned long page_shared,
diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
index 167e236d9bb8..66bc3f99d9be 100644
--- a/arch/um/include/asm/pgtable.h
+++ b/arch/um/include/asm/pgtable.h
@@ -68,23 +68,6 @@ extern unsigned long end_iomem;
  * Also, write permissions imply read permissions. This is the closest we can
  * get..
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
 
 /*
  * ZERO_PAGE is a global shared page that is always zero: used
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 15295c3237a0..78809967e843 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -197,3 +197,22 @@ void *uml_kmalloc(int size, int flags)
 {
 	return kmalloc(size, flags);
 }
+
+pgprot_t protection_map[16] __ro_after_init = {
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
diff --git a/arch/x86/um/mem_32.c b/arch/x86/um/mem_32.c
index 19c5dbd46770..cafd01f730da 100644
--- a/arch/x86/um/mem_32.c
+++ b/arch/x86/um/mem_32.c
@@ -17,7 +17,7 @@ static int __init gate_vma_init(void)
 	gate_vma.vm_start = FIXADDR_USER_START;
 	gate_vma.vm_end = FIXADDR_USER_END;
 	gate_vma.vm_flags = VM_READ | VM_MAYREAD | VM_EXEC | VM_MAYEXEC;
-	gate_vma.vm_page_prot = __P101;
+	gate_vma.vm_page_prot = PAGE_READONLY;
 
 	return 0;
 }
diff --git a/arch/xtensa/include/asm/pgtable.h b/arch/xtensa/include/asm/pgtable.h
index 0a91376131c5..e0d5531ae00d 100644
--- a/arch/xtensa/include/asm/pgtable.h
+++ b/arch/xtensa/include/asm/pgtable.h
@@ -200,24 +200,6 @@
  * What follows is the closest we can get by reasonable means..
  * See linux/mm/mmap.c for protection_map[] array that uses these definitions.
  */
-#define __P000	PAGE_NONE		/* private --- */
-#define __P001	PAGE_READONLY		/* private --r */
-#define __P010	PAGE_COPY		/* private -w- */
-#define __P011	PAGE_COPY		/* private -wr */
-#define __P100	PAGE_READONLY_EXEC	/* private x-- */
-#define __P101	PAGE_READONLY_EXEC	/* private x-r */
-#define __P110	PAGE_COPY_EXEC		/* private xw- */
-#define __P111	PAGE_COPY_EXEC		/* private xwr */
-
-#define __S000	PAGE_NONE		/* shared  --- */
-#define __S001	PAGE_READONLY		/* shared  --r */
-#define __S010	PAGE_SHARED		/* shared  -w- */
-#define __S011	PAGE_SHARED		/* shared  -wr */
-#define __S100	PAGE_READONLY_EXEC	/* shared  x-- */
-#define __S101	PAGE_READONLY_EXEC	/* shared  x-r */
-#define __S110	PAGE_SHARED_EXEC	/* shared  xw- */
-#define __S111	PAGE_SHARED_EXEC	/* shared  xwr */
-
 #ifndef __ASSEMBLY__
 
 #define pte_ERROR(e) \
diff --git a/arch/xtensa/mm/init.c b/arch/xtensa/mm/init.c
index 6a32b2cf2718..5b9ac0c69c32 100644
--- a/arch/xtensa/mm/init.c
+++ b/arch/xtensa/mm/init.c
@@ -216,3 +216,22 @@ static int __init parse_memmap_opt(char *str)
 	return 0;
 }
 early_param("memmap", parse_memmap_opt);
+
+pgprot_t protection_map[16] __ro_after_init = {
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
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2254c1980c8e..65b7f3d9ff87 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -420,11 +420,11 @@ extern unsigned int kobjsize(const void *objp);
 #endif
 #define VM_FLAGS_CLEAR	(ARCH_VM_PKEY_FLAGS | VM_ARCH_CLEAR)
 
-#ifndef CONFIG_ARCH_HAS_VM_GET_PAGE_PROT
 /*
  * mapping from the currently active vm_flags protection bits (the
  * low four bits) to a page protection mask..
  */
+#ifndef CONFIG_ARCH_HAS_VM_GET_PAGE_PROT
 extern pgprot_t protection_map[16];
 #endif
 
diff --git a/mm/mmap.c b/mm/mmap.c
index e66920414945..012261c8efb8 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -102,25 +102,6 @@ static void unmap_region(struct mm_struct *mm,
  *								x: (yes) yes
  */
 #ifndef CONFIG_ARCH_HAS_VM_GET_PAGE_PROT
-pgprot_t protection_map[16] __ro_after_init = {
-	[VM_NONE]					= __P000,
-	[VM_READ]					= __P001,
-	[VM_WRITE]					= __P010,
-	[VM_WRITE | VM_READ]				= __P011,
-	[VM_EXEC]					= __P100,
-	[VM_EXEC | VM_READ]				= __P101,
-	[VM_EXEC | VM_WRITE]				= __P110,
-	[VM_EXEC | VM_WRITE | VM_READ]			= __P111,
-	[VM_SHARED]					= __S000,
-	[VM_SHARED | VM_READ]				= __S001,
-	[VM_SHARED | VM_WRITE]				= __S010,
-	[VM_SHARED | VM_WRITE | VM_READ]		= __S011,
-	[VM_SHARED | VM_EXEC]				= __S100,
-	[VM_SHARED | VM_EXEC | VM_READ]			= __S101,
-	[VM_SHARED | VM_EXEC | VM_WRITE]		= __S110,
-	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= __S111
-};
-
 pgprot_t vm_get_page_prot(unsigned long vm_flags)
 {
 	return protection_map[vm_flags & (VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)];
-- 
2.25.1

