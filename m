Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6FA84FA9DE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 19:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242884AbiDIRWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 13:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242956AbiDIRVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 13:21:24 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7286262D41
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 10:19:14 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KbMJy0vxgz9sTb;
        Sat,  9 Apr 2022 19:18:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DzwLir_ExBtG; Sat,  9 Apr 2022 19:18:26 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KbMJl6SYtz9sTd;
        Sat,  9 Apr 2022 19:18:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C32708B76D;
        Sat,  9 Apr 2022 19:18:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id f77owpt-aNHH; Sat,  9 Apr 2022 19:18:15 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.203.53])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C21A58B7AF;
        Sat,  9 Apr 2022 19:18:14 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 239HI74m833206
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 9 Apr 2022 19:18:07 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 239HI7np833205;
        Sat, 9 Apr 2022 19:18:07 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        akpm@linux-foundation.org
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v10 03/13] mm, hugetlbfs: Allow an arch to always use generic versions of get_unmapped_area functions
Date:   Sat,  9 Apr 2022 19:17:27 +0200
Message-Id: <77f9d3e592f1c8511df9381aa1c4e754651da4d1.1649523076.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1649523076.git.christophe.leroy@csgroup.eu>
References: <cover.1649523076.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1649524639; l=6136; s=20211009; h=from:subject:message-id; bh=NZaDVf4M0k6hDw8GUmFYuvnFfio9E36LntDi58Rldps=; b=BLFIZTCd4vKNyZt24Ihd7MQsnHXd/K0p3tX06opWkS8Zu6ti/d0sxwkfzOq+QsQXaBDbQBMUrx1K R1nm+NQBAvTCVDjjqX8SeN3FsPYSOKa7okrCzW6drSZ/iUALlJhr
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
Acked-by: Andrew Morton <akpm@linux-foundation.org>
---
 fs/hugetlbfs/inode.c     | 17 +++++++++++++----
 include/linux/hugetlb.h  |  5 +++++
 include/linux/sched/mm.h |  9 +++++++++
 mm/mmap.c                | 31 ++++++++++++++++++++++++-------
 4 files changed, 51 insertions(+), 11 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index dd3a088db11d..ec611c7de9e3 100644
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
@@ -283,6 +283,15 @@ hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
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
index 53c1b6082a4c..10895adc7635 100644
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
index 1ad1f4bfa025..da3a32d05b34 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -153,6 +153,15 @@ extern unsigned long
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
index 313b57d55a63..d2b6c3fbfb8c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2128,10 +2128,10 @@ unsigned long vm_unmapped_area(struct vm_unmapped_area_info *info)
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
@@ -2161,17 +2161,25 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
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
@@ -2219,6 +2227,15 @@ arch_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
 
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
2.35.1

