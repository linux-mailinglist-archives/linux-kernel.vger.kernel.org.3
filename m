Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC5E5229DB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 04:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241564AbiEKCa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 22:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241287AbiEKC3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 22:29:50 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38A121A961
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 19:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652236188; x=1683772188;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yh4/dFHOtWSE9iF+GUg2XMGu0/7JiKaWrQ/zWPdOw6Y=;
  b=EBDK8770Tn3fCw36mY697BFKERR1p3uKyqvE89dKNAnCawo+6pnvgLI3
   shgKwcNAPP1Cr1OS//0ZrB/SPpJSZpz02lyNLUdAmQUJSj6byvptkq6yM
   Q8c1dIWbzEzgxL14754Hy4iwzau4FlpivtQqz+O1XHcQAdsE+e8B9GuUq
   BVPVb3ly37l05/1qlsdS6mjfFcwqzGhBAAB4MBOj7flhpexmm08ww34Fd
   +AuyFQ1iOy5FjqM4yWznYTLfBeCRibL1YJo2hRBppu/KgX0ZTI0Z7Zggw
   KIlJ6A6AnmpCxyELuP88WYUFNHRvFfbXW1nlNTVGeiof9QcluG5XjznqM
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="330158673"
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="330158673"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 19:29:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="711294411"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 10 May 2022 19:29:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 5EA78630; Wed, 11 May 2022 05:28:01 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [RFCv2 08/10] x86/mm: Make LAM_U48 and mappings above 47-bits mutually exclusive
Date:   Wed, 11 May 2022 05:27:49 +0300
Message-Id: <20220511022751.65540-10-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LAM_U48 steals bits above 47-bit for tags and makes it impossible for
userspace to use full address space on 5-level paging machine.

Make these features mutually exclusive: whichever gets enabled first
blocks the othe one.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/elf.h         |  3 ++-
 arch/x86/include/asm/mmu_context.h | 13 +++++++++++++
 arch/x86/kernel/sys_x86_64.c       |  5 +++--
 arch/x86/mm/hugetlbpage.c          |  6 ++++--
 arch/x86/mm/mmap.c                 |  9 ++++++++-
 5 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 29fea180a665..53b96b0c8cc3 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -328,7 +328,8 @@ static inline int mmap_is_ia32(void)
 extern unsigned long task_size_32bit(void);
 extern unsigned long task_size_64bit(int full_addr_space);
 extern unsigned long get_mmap_base(int is_legacy);
-extern bool mmap_address_hint_valid(unsigned long addr, unsigned long len);
+extern bool mmap_address_hint_valid(struct mm_struct *mm,
+				    unsigned long addr, unsigned long len);
 extern unsigned long get_sigframe_size(void);
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 27516046117a..c8a6d80dfec3 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -218,6 +218,19 @@ static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
 
 unsigned long __get_current_cr3_fast(void);
 
+#ifdef CONFIG_X86_5LEVEL
+static inline bool full_va_allowed(struct mm_struct *mm)
+{
+	/* LAM_U48 steals VA bits abouve 47-bit for tags */
+	return mm->context.lam != LAM_U48;
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
diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.c
index 660b78827638..4526e8fadfd2 100644
--- a/arch/x86/kernel/sys_x86_64.c
+++ b/arch/x86/kernel/sys_x86_64.c
@@ -21,6 +21,7 @@
 
 #include <asm/elf.h>
 #include <asm/ia32.h>
+#include <asm/mmu_context.h>
 
 /*
  * Align a virtual address to avoid aliasing in the I$ on AMD F15h.
@@ -185,7 +186,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	/* requesting a specific address */
 	if (addr) {
 		addr &= PAGE_MASK;
-		if (!mmap_address_hint_valid(addr, len))
+		if (!mmap_address_hint_valid(mm, addr, len))
 			goto get_unmapped_area;
 
 		vma = find_vma(mm, addr);
@@ -206,7 +207,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
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

