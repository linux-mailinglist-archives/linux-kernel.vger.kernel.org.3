Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6648546877
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 16:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349519AbiFJOf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 10:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343951AbiFJOfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 10:35:36 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAED2C1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 07:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654871735; x=1686407735;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SLeKdC6y/U4fh0m2jEjZ1c9srr58qmePqYiQtZ1ypvU=;
  b=I2nNPAJRNPEkYBJGYI9N5b5ZczMgwNVwD/DZrDerVmoK6ZkGzvYJ0NYD
   A8SxJiJ5eSFGImbrGEtcWpuwJdogf81RIvJwjnH9cma+NIsrOoYZSzQ94
   qbkcSUSMx9LnHyH3JYZLSicOU3D9A6FakAhlUh8sf0Ncks9K4Kwo5y+su
   oddLftZn+AGe4Z3x0d5Qm0+BrdQkrMdsUrNbrkGg4uDGxFEBBnaKql5il
   gZqWbIUL1Eu02oLoKgCo3yhCUCgQnccE+6TYiUeLxVxT1mhMfWLYkxa/I
   Hwhk+MzCm+jw2OyljomDN9TxogaB6jHP+D6S/sZdUvVS6CESBS2Q18UNV
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="339397518"
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="339397518"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 07:35:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="586237208"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 10 Jun 2022 07:35:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 6D52C710; Fri, 10 Jun 2022 17:35:30 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv3 OPTIONAL 8/8] x86/mm: Extend LAM to support to LAM_U48
Date:   Fri, 10 Jun 2022 17:35:27 +0300
Message-Id: <20220610143527.22974-9-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LAM_U48 allows to encode 15 bits of tags into address.

LAM_U48 steals bits above 47-bit for tags and makes it impossible for
userspace to use full address space on 5-level paging machine.

Make these features mutually exclusive: whichever gets enabled first
blocks the other one.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/elf.h         |  3 ++-
 arch/x86/include/asm/mmu_context.h | 13 +++++++++++++
 arch/x86/kernel/process_64.c       | 22 ++++++++++++++++++++++
 arch/x86/kernel/sys_x86_64.c       |  5 +++--
 arch/x86/mm/hugetlbpage.c          |  6 ++++--
 arch/x86/mm/mmap.c                 |  9 ++++++++-
 6 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index cb0ff1055ab1..4df13497a770 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -317,7 +317,8 @@ static inline int mmap_is_ia32(void)
 extern unsigned long task_size_32bit(void);
 extern unsigned long task_size_64bit(int full_addr_space);
 extern unsigned long get_mmap_base(int is_legacy);
-extern bool mmap_address_hint_valid(unsigned long addr, unsigned long len);
+extern bool mmap_address_hint_valid(struct mm_struct *mm,
+				    unsigned long addr, unsigned long len);
 extern unsigned long get_sigframe_size(void);
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index a6cded0f5e64..17d31988edd6 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -263,6 +263,19 @@ static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
 
 unsigned long __get_current_cr3_fast(void);
 
+#ifdef CONFIG_X86_5LEVEL
+static inline bool full_va_allowed(struct mm_struct *mm)
+{
+	/* LAM_U48 steals VA bits above 47-bit for tags */
+	return mm->context.lam_cr3_mask != X86_CR3_LAM_U48;
+}
+#else
+static inline bool full_va_allowed(struct mm_struct *mm)
+{
+	return false;
+}
+#endif
+
 #include <asm-generic/mmu_context.h>
 
 #endif /* _ASM_X86_MMU_CONTEXT_H */
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 93c8eba1a66d..56822d313b96 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -742,6 +742,16 @@ static long prctl_map_vdso(const struct vdso_image *image, unsigned long addr)
 }
 #endif
 
+static bool lam_u48_allowed(void)
+{
+	struct mm_struct *mm = current->mm;
+
+	if (!full_va_allowed(mm))
+		return true;
+
+	return find_vma(mm, DEFAULT_MAP_WINDOW) == NULL;
+}
+
 static int prctl_enable_tagged_addr(unsigned long nr_bits)
 {
 	struct mm_struct *mm = current->mm;
@@ -759,6 +769,18 @@ static int prctl_enable_tagged_addr(unsigned long nr_bits)
 	} else if (nr_bits <= 6) {
 		mm->context.lam_cr3_mask = X86_CR3_LAM_U57;
 		mm->context.untag_mask =  ~GENMASK(62, 57);
+	} else if (nr_bits <= 15) {
+		if (mmap_write_lock_killable(mm))
+			return -EINTR;
+
+		if (!lam_u48_allowed()) {
+			mmap_write_unlock(mm);
+			return -EBUSY;
+		}
+
+		mm->context.lam_cr3_mask = X86_CR3_LAM_U48;
+		mm->context.untag_mask =  ~GENMASK(62, 48);
+		mmap_write_unlock(mm);
 	} else {
 		return -EINVAL;
 	}
diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.c
index 8cc653ffdccd..5ea6aaed89ba 100644
--- a/arch/x86/kernel/sys_x86_64.c
+++ b/arch/x86/kernel/sys_x86_64.c
@@ -21,6 +21,7 @@
 
 #include <asm/elf.h>
 #include <asm/ia32.h>
+#include <asm/mmu_context.h>
 
 /*
  * Align a virtual address to avoid aliasing in the I$ on AMD F15h.
@@ -182,7 +183,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	/* requesting a specific address */
 	if (addr) {
 		addr &= PAGE_MASK;
-		if (!mmap_address_hint_valid(addr, len))
+		if (!mmap_address_hint_valid(mm, addr, len))
 			goto get_unmapped_area;
 
 		vma = find_vma(mm, addr);
@@ -203,7 +204,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	 * !in_32bit_syscall() check to avoid high addresses for x32
 	 * (and make it no op on native i386).
 	 */
-	if (addr > DEFAULT_MAP_WINDOW && !in_32bit_syscall())
+	if (addr > DEFAULT_MAP_WINDOW && !in_32bit_syscall() && full_va_allowed(mm))
 		info.high_limit += TASK_SIZE_MAX - DEFAULT_MAP_WINDOW;
 
 	info.align_mask = 0;
diff --git a/arch/x86/mm/hugetlbpage.c b/arch/x86/mm/hugetlbpage.c
index a0d023cb4292..9fdc8db42365 100644
--- a/arch/x86/mm/hugetlbpage.c
+++ b/arch/x86/mm/hugetlbpage.c
@@ -18,6 +18,7 @@
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
 #include <asm/elf.h>
+#include <asm/mmu_context.h>
 
 #if 0	/* This is just for testing */
 struct page *
@@ -103,6 +104,7 @@ static unsigned long hugetlb_get_unmapped_area_topdown(struct file *file,
 		unsigned long pgoff, unsigned long flags)
 {
 	struct hstate *h = hstate_file(file);
+	struct mm_struct *mm = current->mm;
 	struct vm_unmapped_area_info info;
 
 	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
@@ -114,7 +116,7 @@ static unsigned long hugetlb_get_unmapped_area_topdown(struct file *file,
 	 * If hint address is above DEFAULT_MAP_WINDOW, look for unmapped area
 	 * in the full address space.
 	 */
-	if (addr > DEFAULT_MAP_WINDOW && !in_32bit_syscall())
+	if (addr > DEFAULT_MAP_WINDOW && !in_32bit_syscall() && full_va_allowed(mm))
 		info.high_limit += TASK_SIZE_MAX - DEFAULT_MAP_WINDOW;
 
 	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
@@ -161,7 +163,7 @@ hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 
 	if (addr) {
 		addr &= huge_page_mask(h);
-		if (!mmap_address_hint_valid(addr, len))
+		if (!mmap_address_hint_valid(mm, addr, len))
 			goto get_unmapped_area;
 
 		vma = find_vma(mm, addr);
diff --git a/arch/x86/mm/mmap.c b/arch/x86/mm/mmap.c
index c90c20904a60..f9ca824729de 100644
--- a/arch/x86/mm/mmap.c
+++ b/arch/x86/mm/mmap.c
@@ -21,6 +21,7 @@
 #include <linux/elf-randomize.h>
 #include <asm/elf.h>
 #include <asm/io.h>
+#include <asm/mmu_context.h>
 
 #include "physaddr.h"
 
@@ -35,6 +36,8 @@ unsigned long task_size_32bit(void)
 
 unsigned long task_size_64bit(int full_addr_space)
 {
+	if (!full_va_allowed(current->mm))
+		return DEFAULT_MAP_WINDOW;
 	return full_addr_space ? TASK_SIZE_MAX : DEFAULT_MAP_WINDOW;
 }
 
@@ -206,11 +209,15 @@ const char *arch_vma_name(struct vm_area_struct *vma)
  * the failure of such a fixed mapping request, so the restriction is not
  * applied.
  */
-bool mmap_address_hint_valid(unsigned long addr, unsigned long len)
+bool mmap_address_hint_valid(struct mm_struct *mm,
+			     unsigned long addr, unsigned long len)
 {
 	if (TASK_SIZE - len < addr)
 		return false;
 
+	if (addr + len > DEFAULT_MAP_WINDOW && !full_va_allowed(mm))
+		return false;
+
 	return (addr > DEFAULT_MAP_WINDOW) == (addr + len > DEFAULT_MAP_WINDOW);
 }
 
-- 
2.35.1

