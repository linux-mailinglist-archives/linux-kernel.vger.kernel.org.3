Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11ABB4D384C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 19:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236445AbiCIRrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 12:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235893AbiCIRqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 12:46:55 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFA7E3883
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 09:45:52 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KDKNB1GtGz9sSh;
        Wed,  9 Mar 2022 18:45:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6vwzkLpL5caP; Wed,  9 Mar 2022 18:45:14 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KDKN02MCPz9sTQ;
        Wed,  9 Mar 2022 18:45:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 44AA08B787;
        Wed,  9 Mar 2022 18:45:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id RbMpmbjXIirW; Wed,  9 Mar 2022 18:45:04 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.27])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 050D48B790;
        Wed,  9 Mar 2022 18:45:02 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 229Hiwpq3619050
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 9 Mar 2022 18:44:58 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 229Hiw633619049;
        Wed, 9 Mar 2022 18:44:58 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, alex@ghiti.fr
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v8 09/14] powerpc/mm: Use generic_get_unmapped_area() and call it from arch_get_unmapped_area()
Date:   Wed,  9 Mar 2022 18:44:43 +0100
Message-Id: <93dbe0352a4d9abab08278d81792b84172ac2c42.1646847562.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1646847561.git.christophe.leroy@csgroup.eu>
References: <cover.1646847561.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1646847882; l=6626; s=20211009; h=from:subject:message-id; bh=Nx9/DlQIUm4TBQpIbVh9MnSUhL9+Xxqdji5IpKHs60o=; b=PwlZuhwD/W+GUuyb0bpCo2FRsdvTTDGwqowr4NApCOV/QtnlkVEOBKcGaH+1hbQAb0DEXsxpvD0w dUJfWe3dDRituHahSCZk8zq59nr3eGZFUiU4/1GlyrBf5Ak44k3M
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the generic version of arch_get_unmapped_area() which
is now available at all time instead of its copy
radix__arch_get_unmapped_area()

To allow that for PPC64, add arch_get_mmap_base() and
arch_get_mmap_end() macros.

Instead of setting mm->get_unmapped_area() to either
arch_get_unmapped_area() or generic_get_unmapped_area(),
always set it to arch_get_unmapped_area() and call
generic_get_unmapped_area() from there when radix is enabled.

Do the same with radix__arch_get_unmapped_area_topdown()

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/task_size_64.h |   8 ++
 arch/powerpc/mm/mmap.c                  | 127 ++----------------------
 2 files changed, 14 insertions(+), 121 deletions(-)

diff --git a/arch/powerpc/include/asm/task_size_64.h b/arch/powerpc/include/asm/task_size_64.h
index 38fdf8041d12..5a709951c901 100644
--- a/arch/powerpc/include/asm/task_size_64.h
+++ b/arch/powerpc/include/asm/task_size_64.h
@@ -72,4 +72,12 @@
 #define STACK_TOP_MAX TASK_SIZE_USER64
 #define STACK_TOP (is_32bit_task() ? STACK_TOP_USER32 : STACK_TOP_USER64)
 
+#define arch_get_mmap_base(addr, base) \
+	(((addr) > DEFAULT_MAP_WINDOW) ? (base) + TASK_SIZE - DEFAULT_MAP_WINDOW : (base))
+
+#define arch_get_mmap_end(addr, len, flags) \
+	(((addr) > DEFAULT_MAP_WINDOW) || \
+	 (((flags) & MAP_FIXED) && ((addr) + (len) > DEFAULT_MAP_WINDOW)) ? TASK_SIZE : \
+									    DEFAULT_MAP_WINDOW)
+
 #endif /* _ASM_POWERPC_TASK_SIZE_64_H */
diff --git a/arch/powerpc/mm/mmap.c b/arch/powerpc/mm/mmap.c
index 9b0d6e395bc0..46781d0103d1 100644
--- a/arch/powerpc/mm/mmap.c
+++ b/arch/powerpc/mm/mmap.c
@@ -81,115 +81,15 @@ static inline unsigned long mmap_base(unsigned long rnd,
 }
 
 #ifdef HAVE_ARCH_UNMAPPED_AREA
-#ifdef CONFIG_PPC_RADIX_MMU
-/*
- * Same function as generic code used only for radix, because we don't need to overload
- * the generic one. But we will have to duplicate, because hash select
- * HAVE_ARCH_UNMAPPED_AREA
- */
-static unsigned long
-radix__arch_get_unmapped_area(struct file *filp, unsigned long addr,
-			     unsigned long len, unsigned long pgoff,
-			     unsigned long flags)
-{
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
-	int fixed = (flags & MAP_FIXED);
-	unsigned long high_limit;
-	struct vm_unmapped_area_info info;
-
-	high_limit = DEFAULT_MAP_WINDOW;
-	if (addr >= high_limit || (fixed && (addr + len > high_limit)))
-		high_limit = TASK_SIZE;
-
-	if (len > high_limit)
-		return -ENOMEM;
-
-	if (fixed) {
-		if (addr > high_limit - len)
-			return -ENOMEM;
-		return addr;
-	}
-
-	if (addr) {
-		addr = PAGE_ALIGN(addr);
-		vma = find_vma(mm, addr);
-		if (high_limit - len >= addr && addr >= mmap_min_addr &&
-		    (!vma || addr + len <= vm_start_gap(vma)))
-			return addr;
-	}
-
-	info.flags = 0;
-	info.length = len;
-	info.low_limit = mm->mmap_base;
-	info.high_limit = high_limit;
-	info.align_mask = 0;
-
-	return vm_unmapped_area(&info);
-}
-
-static unsigned long
-radix__arch_get_unmapped_area_topdown(struct file *filp,
-				     const unsigned long addr0,
-				     const unsigned long len,
-				     const unsigned long pgoff,
-				     const unsigned long flags)
-{
-	struct vm_area_struct *vma;
-	struct mm_struct *mm = current->mm;
-	unsigned long addr = addr0;
-	int fixed = (flags & MAP_FIXED);
-	unsigned long high_limit;
-	struct vm_unmapped_area_info info;
-
-	high_limit = DEFAULT_MAP_WINDOW;
-	if (addr >= high_limit || (fixed && (addr + len > high_limit)))
-		high_limit = TASK_SIZE;
-
-	if (len > high_limit)
-		return -ENOMEM;
-
-	if (fixed) {
-		if (addr > high_limit - len)
-			return -ENOMEM;
-		return addr;
-	}
-
-	if (addr) {
-		addr = PAGE_ALIGN(addr);
-		vma = find_vma(mm, addr);
-		if (high_limit - len >= addr && addr >= mmap_min_addr &&
-		    (!vma || addr + len <= vm_start_gap(vma)))
-			return addr;
-	}
-
-	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
-	info.length = len;
-	info.low_limit = max(PAGE_SIZE, mmap_min_addr);
-	info.high_limit = mm->mmap_base + (high_limit - DEFAULT_MAP_WINDOW);
-	info.align_mask = 0;
-
-	addr = vm_unmapped_area(&info);
-	if (!(addr & ~PAGE_MASK))
-		return addr;
-	VM_BUG_ON(addr != -ENOMEM);
-
-	/*
-	 * A failed mmap() very likely causes application failure,
-	 * so fall back to the bottom-up function here. This scenario
-	 * can happen with large stack limits and large mmap()
-	 * allocations.
-	 */
-	return radix__arch_get_unmapped_area(filp, addr0, len, pgoff, flags);
-}
-#endif
-
 unsigned long arch_get_unmapped_area(struct file *filp,
 				     unsigned long addr,
 				     unsigned long len,
 				     unsigned long pgoff,
 				     unsigned long flags)
 {
+	if (radix_enabled())
+		return generic_get_unmapped_area(filp, addr, len, pgoff, flags);
+
 #ifdef CONFIG_PPC_64S_HASH_MMU
 	return slice_get_unmapped_area(addr, len, flags,
 				       mm_ctx_user_psize(&current->mm->context), 0);
@@ -204,6 +104,9 @@ unsigned long arch_get_unmapped_area_topdown(struct file *filp,
 					     const unsigned long pgoff,
 					     const unsigned long flags)
 {
+	if (radix_enabled())
+		return generic_get_unmapped_area_topdown(filp, addr0, len, pgoff, flags);
+
 #ifdef CONFIG_PPC_64S_HASH_MMU
 	return slice_get_unmapped_area(addr0, len, flags,
 				       mm_ctx_user_psize(&current->mm->context), 1);
@@ -213,21 +116,6 @@ unsigned long arch_get_unmapped_area_topdown(struct file *filp,
 }
 #endif /* HAVE_ARCH_UNMAPPED_AREA */
 
-static void radix__arch_pick_mmap_layout(struct mm_struct *mm,
-					unsigned long random_factor,
-					struct rlimit *rlim_stack)
-{
-#ifdef CONFIG_PPC_RADIX_MMU
-	if (mmap_is_legacy(rlim_stack)) {
-		mm->mmap_base = TASK_UNMAPPED_BASE;
-		mm->get_unmapped_area = radix__arch_get_unmapped_area;
-	} else {
-		mm->mmap_base = mmap_base(random_factor, rlim_stack);
-		mm->get_unmapped_area = radix__arch_get_unmapped_area_topdown;
-	}
-#endif
-}
-
 /*
  * This function, called very early during the creation of a new
  * process VM image, sets up which VM layout function to use:
@@ -239,9 +127,6 @@ void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
 	if (current->flags & PF_RANDOMIZE)
 		random_factor = arch_mmap_rnd();
 
-	if (radix_enabled())
-		return radix__arch_pick_mmap_layout(mm, random_factor,
-						    rlim_stack);
 	/*
 	 * Fall back to the standard layout if the personality
 	 * bit is set, or if the expected stack growth is unlimited:
-- 
2.34.1

