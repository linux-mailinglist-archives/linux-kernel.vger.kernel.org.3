Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D099552F4E1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 23:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353688AbiETVQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 17:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353636AbiETVQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 17:16:24 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E0819025
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 14:16:22 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id ob14-20020a17090b390e00b001dff2a43f8cso2259599pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 14:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TZGbrX4QM92lpEadFI2/iSQf+FDJdRaQWbUBPCSmje8=;
        b=UDHxs7Tka/6dGhK1B10RCJNyooHkQLV2mOuI+Tnf9llsxd5DSAeIb0RfTrKjghW7Wu
         /K1eGBERoI3QiWpcVu0Aj1n5DQvxi6qIoY825v+wpc1gGXTm0U/gZmQzAlTPjbPvdZ89
         31sD4OtYTOVJXwEd1rJNyhQxmTqAgYvsL9+JAfsEf0ICkwVrvrBqf0125qAobUEl3f6w
         //F/ZalYdnOKXF/H8KP5tDveq2wW7joL27gehvWZOoZ4IRGP5kq1/LWqMwR7ZfDsMIqL
         /vOhfTPWXb9vfWKC5MMIaskT0tyMDMy30YStSBxt9sJaBQKF8bFMPIMAQLCDM3kPy6kG
         yrEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TZGbrX4QM92lpEadFI2/iSQf+FDJdRaQWbUBPCSmje8=;
        b=PqDCQId+LDU3QgG9rt7U3FAazJ9mMXxkhfC3nxxKPBEMBoMOPZtl8tNSLaDhnZiX64
         +WAtH26lNUtIwtlSFMVbqUO8/tnOMVTF1+dWMT8nKExVh3XHYhD06idQCjP0zElvGBm0
         zQRtDP6SLuvIwDXzYRmwhloIYaWmq+jOVGtHhjpM+lmES/k7vJ7I3z2mmE6PI50uHPrC
         XwTUyJreeVhvt6ieRjfqGy19VpCs+/SDQJKJRQRrUtl4ExTg+ncoJ/ta+d/rVwduPc/E
         OSKkubCM2ENK3Hfl+bE8NswsCNbnDaZFzyjgQDKeEGnbRN5tLaSEu/mmO+nWYNqeZ0K6
         9wWA==
X-Gm-Message-State: AOAM531HzODDxzGgH6zZ23acMBTu7hLJaXdf3K6QaPgA8paI8s9SKv1o
        vxdnie5TBp4ACHh9Ofxg8WY=
X-Google-Smtp-Source: ABdhPJxu9xr7EW6hkAt6iaVTmS4PakGrCNCaum6wmHT0fFwAs3shwvx4OWMk38pErjAtuqxeDTpfbQ==
X-Received: by 2002:a17:90b:4b8a:b0:1df:75f2:d2f4 with SMTP id lr10-20020a17090b4b8a00b001df75f2d2f4mr13096306pjb.109.1653081381644;
        Fri, 20 May 2022 14:16:21 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id h1-20020a170902748100b0015e8d4eb2c2sm167620pll.268.2022.05.20.14.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 14:16:20 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] mm: thp: kill __transhuge_page_enabled()
Date:   Fri, 20 May 2022 14:16:04 -0700
Message-Id: <20220520211605.51473-7-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220520211605.51473-1-shy828301@gmail.com>
References: <20220520211605.51473-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The page fault path checks THP eligibility with
__transhuge_page_enabled() which does the similar thing as
hugepage_vma_check(), so use hugepage_vma_check() instead.

However page fault allows DAX and !anon_vma cases, so added a new flag,
in_pf, to hugepage_vma_check() to make page fault work correctly.

The in_pf flag is also used to skip shmem and file THP for page fault
since shmem handles THP in its own shmem_fault() and file THP allocation
on fault is not supported yet.

Also remove hugepage_vma_enabled() since hugepage_vma_check() is the
only caller now, it is not necessary to have a helper function.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 fs/proc/task_mmu.c         |  2 +-
 include/linux/huge_mm.h    | 57 ++------------------------------------
 include/linux/khugepaged.h |  2 +-
 mm/huge_memory.c           | 24 +++++++++++-----
 mm/khugepaged.c            |  8 +++---
 mm/memory.c                |  6 ++--
 6 files changed, 29 insertions(+), 70 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index ab4849d07a1f..28f472a2eb51 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -863,7 +863,7 @@ static int show_smap(struct seq_file *m, void *v)
 	__show_smap(m, &mss, false);
 
 	seq_printf(m, "THPeligible:    %d\n",
-		   hugepage_vma_check(vma, vma->vm_flags));
+		   hugepage_vma_check(vma, vma->vm_flags, false));
 
 	if (arch_pkeys_enabled())
 		seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 2da52ca8fd52..67c913e66e60 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -153,48 +153,6 @@ static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
 	return true;
 }
 
-static inline bool transhuge_vma_enabled(struct vm_area_struct *vma,
-					  unsigned long vm_flags)
-{
-	/* Explicitly disabled through madvise. */
-	if ((vm_flags & VM_NOHUGEPAGE) ||
-	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
-		return false;
-	return true;
-}
-
-/*
- * to be used on vmas which are known to support THP.
- * Use transparent_hugepage_active otherwise
- */
-static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
-{
-
-	/*
-	 * If the hardware/firmware marked hugepage support disabled.
-	 */
-	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_NEVER_DAX))
-		return false;
-
-	if (!transhuge_vma_enabled(vma, vma->vm_flags))
-		return false;
-
-	if (vma_is_temporary_stack(vma))
-		return false;
-
-	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_FLAG))
-		return true;
-
-	if (vma_is_dax(vma))
-		return true;
-
-	if (transparent_hugepage_flags &
-				(1 << TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG))
-		return !!(vma->vm_flags & VM_HUGEPAGE);
-
-	return false;
-}
-
 static inline bool file_thp_enabled(struct vm_area_struct *vma)
 {
 	struct inode *inode;
@@ -210,7 +168,7 @@ static inline bool file_thp_enabled(struct vm_area_struct *vma)
 }
 
 extern bool hugepage_vma_check(struct vm_area_struct *vma,
-			       unsigned long vm_flags);
+			       unsigned long vm_flags, bool in_pf);
 
 #define transparent_hugepage_use_zero_page()				\
 	(transparent_hugepage_flags &					\
@@ -354,11 +312,6 @@ static inline bool folio_test_pmd_mappable(struct folio *folio)
 	return false;
 }
 
-static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
-{
-	return false;
-}
-
 static inline bool transhuge_vma_size_ok(struct vm_area_struct *vma)
 {
 	return false;
@@ -370,14 +323,8 @@ static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
 	return false;
 }
 
-static inline bool transhuge_vma_enabled(struct vm_area_struct *vma,
-					  unsigned long vm_flags)
-{
-	return false;
-}
-
 static inline bool hugepage_vma_check(struct vm_area_struct *vma,
-				       unsigned long vm_flags)
+				       unsigned long vm_flags, bool in_pf)
 {
 	return false;
 }
diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
index 795c8d2170b0..8a6452e089ca 100644
--- a/include/linux/khugepaged.h
+++ b/include/linux/khugepaged.h
@@ -55,7 +55,7 @@ static inline void khugepaged_enter(struct vm_area_struct *vma,
 {
 	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
 	    khugepaged_enabled()) {
-		if (hugepage_vma_check(vma, vm_flags))
+		if (hugepage_vma_check(vma, vm_flags, false))
 			__khugepaged_enter(vma->vm_mm);
 	}
 }
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d9ec82892b05..b4cab3aa2534 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -70,17 +70,26 @@ struct page *huge_zero_page __read_mostly;
 unsigned long huge_zero_pfn __read_mostly = ~0UL;
 
 bool hugepage_vma_check(struct vm_area_struct *vma,
-			unsigned long vm_flags)
+			unsigned long vm_flags, bool in_pf)
 {
-	if (!transhuge_vma_enabled(vma, vm_flags))
+	/* Explicitly disabled through madvise or prctl. */
+	if ((vm_flags & VM_NOHUGEPAGE) ||
+	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
 		return false;
 
+	/*
+	 * If the hardware/firmware marked hugepage support disabled.
+	 */
+	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_NEVER_DAX))
+		return false;
+
+	/* Special VMA and hugetlb VMA */
 	if (vm_flags & VM_NO_KHUGEPAGED)
 		return false;
 
-	/* Don't run khugepaged against DAX vma */
+	/* khugepaged doesn't collapse DAX vma, but page fault is fine. */
 	if (vma_is_dax(vma))
-		return false;
+		return in_pf;
 
 	if (vma->vm_file && !IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) -
 				vma->vm_pgoff, HPAGE_PMD_NR))
@@ -90,7 +99,7 @@ bool hugepage_vma_check(struct vm_area_struct *vma,
 		return false;
 
 	/* Enabled via shmem mount options or sysfs settings. */
-	if (shmem_file(vma->vm_file))
+	if (!in_pf && shmem_file(vma->vm_file))
 		return shmem_huge_enabled(vma);
 
 	if (!khugepaged_enabled())
@@ -101,10 +110,11 @@ bool hugepage_vma_check(struct vm_area_struct *vma,
 		return false;
 
 	/* Only regular file is valid */
-	if (file_thp_enabled(vma))
+	if (!in_pf && file_thp_enabled(vma))
 		return true;
 
-	if (!vma->anon_vma || !vma_is_anonymous(vma))
+	/* anon_vma may be not prepared before the first page fault */
+	if ((!in_pf && !vma->anon_vma) || !vma_is_anonymous(vma))
 		return false;
 	if (vma_is_temporary_stack(vma))
 		return false;
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index a7ac1ae418f8..292ed9c0db1e 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -473,7 +473,7 @@ void khugepaged_enter_vma(struct vm_area_struct *vma,
 {
 	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
 	    khugepaged_enabled()) {
-		if (hugepage_vma_check(vma, vm_flags))
+		if (hugepage_vma_check(vma, vm_flags, false))
 			__khugepaged_enter(vma->vm_mm);
 	}
 }
@@ -918,7 +918,7 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
 
 	if (!transhuge_vma_suitable(vma, address))
 		return SCAN_ADDRESS_RANGE;
-	if (!hugepage_vma_check(vma, vma->vm_flags))
+	if (!hugepage_vma_check(vma, vma->vm_flags, false))
 		return SCAN_VMA_CHECK;
 	return 0;
 }
@@ -1399,7 +1399,7 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
 	 * the valid THP. Add extra VM_HUGEPAGE so hugepage_vma_check()
 	 * will not fail the vma for missing VM_HUGEPAGE
 	 */
-	if (!hugepage_vma_check(vma, vma->vm_flags | VM_HUGEPAGE))
+	if (!hugepage_vma_check(vma, vma->vm_flags | VM_HUGEPAGE, false))
 		return;
 
 	/* Keep pmd pgtable for uffd-wp; see comment in retract_page_tables() */
@@ -2091,7 +2091,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
 			progress++;
 			break;
 		}
-		if (!hugepage_vma_check(vma, vma->vm_flags)) {
+		if (!hugepage_vma_check(vma, vma->vm_flags, false)) {
 skip:
 			progress++;
 			continue;
diff --git a/mm/memory.c b/mm/memory.c
index 95735bee3876..0850b3e38dbf 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4979,7 +4979,8 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 	if (!vmf.pud)
 		return VM_FAULT_OOM;
 retry_pud:
-	if (pud_none(*vmf.pud) && __transparent_hugepage_enabled(vma)) {
+	if (pud_none(*vmf.pud) &&
+	    hugepage_vma_check(vma, vma->vm_flags, true)) {
 		ret = create_huge_pud(&vmf);
 		if (!(ret & VM_FAULT_FALLBACK))
 			return ret;
@@ -5012,7 +5013,8 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 	if (pud_trans_unstable(vmf.pud))
 		goto retry_pud;
 
-	if (pmd_none(*vmf.pmd) && __transparent_hugepage_enabled(vma)) {
+	if (pmd_none(*vmf.pmd) &&
+	    hugepage_vma_check(vma, vma->vm_flags, true)) {
 		ret = create_huge_pmd(&vmf);
 		if (!(ret & VM_FAULT_FALLBACK))
 			return ret;
-- 
2.26.3

