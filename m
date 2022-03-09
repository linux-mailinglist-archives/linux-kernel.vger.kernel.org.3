Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9024D383F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 19:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235584AbiCIRrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 12:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236591AbiCIRrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 12:47:10 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1B411E3D9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 09:46:06 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KDKNF0fN3z9sTS;
        Wed,  9 Mar 2022 18:45:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bw4yrIEQ2HL5; Wed,  9 Mar 2022 18:45:17 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KDKN10vz1z9sTV;
        Wed,  9 Mar 2022 18:45:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0A5388B763;
        Wed,  9 Mar 2022 18:45:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id RunPUUwNT2DJ; Wed,  9 Mar 2022 18:45:04 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.27])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E7B6F8B78B;
        Wed,  9 Mar 2022 18:45:02 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 229HiuXO3619026
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 9 Mar 2022 18:44:56 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 229Hit9h3619025;
        Wed, 9 Mar 2022 18:44:55 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, alex@ghiti.fr
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v8 03/14] mm, hugetlbfs: Allow an arch to always use generic versions of get_unmapped_area functions
Date:   Wed,  9 Mar 2022 18:44:37 +0100
Message-Id: <82ebdfa2f2244d286a2f97a16549ff334438261b.1646847561.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1646847561.git.christophe.leroy@csgroup.eu>
References: <cover.1646847561.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1646847882; l=6083; s=20211009; h=from:subject:message-id; bh=thpAysBeMixL/GwjpD3NdHaQCVCGsiEZQtTYyQo5FGA=; b=ZJQoobZAfE0OgcobH4551vlxvjOSA/UDrvkLYVLZY5o3CuyKIArtP/7CQu5EwD/j8V3CsJYmbT5o xs6hdFEEB8SAt5qJUh2aHzmLPt/6KoieZL8Vw3efATPOAebAWGoP
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

Unlike most architectures, powerpc can only define at runtime
if it is going to use the generic arch_get_unmapped_area() or not.

Today, powerpc has a copy of the generic arch_get_unmapped_area()
because when selection HAVE_ARCH_UNMAPPED_AREA the generic
arch_get_unmapped_area() is not available.

Rename it generic_get_unmapped_area() and make it independent of
HAVE_ARCH_UNMAPPED_AREA.

Do the same for arch_get_unmapped_area_topdown() versus
HAVE_ARCH_UNMAPPED_AREA_TOPDOWN.

Do the same for hugetlb_get_unmapped_area() versus
HAVE_ARCH_HUGETLB_UNMAPPED_AREA.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 fs/hugetlbfs/inode.c     | 17 +++++++++++++----
 include/linux/hugetlb.h  |  5 +++++
 include/linux/sched/mm.h |  9 +++++++++
 mm/mmap.c                | 31 ++++++++++++++++++++++++-------
 4 files changed, 51 insertions(+), 11 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index a7c6c7498be0..ba15a85c7dfb 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -195,7 +195,6 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
  * Called under mmap_write_lock(mm).
  */
 
-#ifndef HAVE_ARCH_HUGETLB_UNMAPPED_AREA
 static unsigned long
 hugetlb_get_unmapped_area_bottomup(struct file *file, unsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags)
@@ -244,9 +243,10 @@ hugetlb_get_unmapped_area_topdown(struct file *file, unsigned long addr,
 	return addr;
 }
 
-static unsigned long
-hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
-		unsigned long len, unsigned long pgoff, unsigned long flags)
+unsigned long
+generic_hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
+				  unsigned long len, unsigned long pgoff,
+				  unsigned long flags)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
@@ -282,6 +282,15 @@ hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 	return hugetlb_get_unmapped_area_bottomup(file, addr, len,
 			pgoff, flags);
 }
+
+#ifndef HAVE_ARCH_HUGETLB_UNMAPPED_AREA
+static unsigned long
+hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
+			  unsigned long len, unsigned long pgoff,
+			  unsigned long flags)
+{
+	return generic_hugetlb_get_unmapped_area(file, addr, len, pgoff, flags);
+}
 #endif
 
 static size_t
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index d1897a69c540..d9ce1fe3a403 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -513,6 +513,11 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 					unsigned long flags);
 #endif /* HAVE_ARCH_HUGETLB_UNMAPPED_AREA */
 
+unsigned long
+generic_hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
+				  unsigned long len, unsigned long pgoff,
+				  unsigned long flags);
+
 /*
  * huegtlb page specific state flags.  These flags are located in page.private
  * of the hugetlb head page.  Functions created via the below macros should be
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index aa5f09ca5bcf..1dcf54360aea 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -144,6 +144,15 @@ extern unsigned long
 arch_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
 			  unsigned long len, unsigned long pgoff,
 			  unsigned long flags);
+
+unsigned long
+generic_get_unmapped_area(struct file *filp, unsigned long addr,
+			  unsigned long len, unsigned long pgoff,
+			  unsigned long flags);
+unsigned long
+generic_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
+				  unsigned long len, unsigned long pgoff,
+				  unsigned long flags);
 #else
 static inline void arch_pick_mmap_layout(struct mm_struct *mm,
 					 struct rlimit *rlim_stack) {}
diff --git a/mm/mmap.c b/mm/mmap.c
index d445c1b9d606..e062a4462db5 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2138,10 +2138,10 @@ unsigned long vm_unmapped_area(struct vm_unmapped_area_info *info)
  *
  * This function "knows" that -ENOMEM has the bits set.
  */
-#ifndef HAVE_ARCH_UNMAPPED_AREA
 unsigned long
-arch_get_unmapped_area(struct file *filp, unsigned long addr,
-		unsigned long len, unsigned long pgoff, unsigned long flags)
+generic_get_unmapped_area(struct file *filp, unsigned long addr,
+			  unsigned long len, unsigned long pgoff,
+			  unsigned long flags)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma, *prev;
@@ -2171,17 +2171,25 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	info.align_offset = 0;
 	return vm_unmapped_area(&info);
 }
+
+#ifndef HAVE_ARCH_UNMAPPED_AREA
+unsigned long
+arch_get_unmapped_area(struct file *filp, unsigned long addr,
+		       unsigned long len, unsigned long pgoff,
+		       unsigned long flags)
+{
+	return generic_get_unmapped_area(filp, addr, len, pgoff, flags);
+}
 #endif
 
 /*
  * This mmap-allocator allocates new areas top-down from below the
  * stack's low limit (the base):
  */
-#ifndef HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
 unsigned long
-arch_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
-			  unsigned long len, unsigned long pgoff,
-			  unsigned long flags)
+generic_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
+				  unsigned long len, unsigned long pgoff,
+				  unsigned long flags)
 {
 	struct vm_area_struct *vma, *prev;
 	struct mm_struct *mm = current->mm;
@@ -2229,6 +2237,15 @@ arch_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
 
 	return addr;
 }
+
+#ifndef HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
+unsigned long
+arch_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
+			       unsigned long len, unsigned long pgoff,
+			       unsigned long flags)
+{
+	return generic_get_unmapped_area_topdown(filp, addr, len, pgoff, flags);
+}
 #endif
 
 unsigned long
-- 
2.34.1

