Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC96B53F1D7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 23:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbiFFVom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 17:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233335AbiFFVoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 17:44:30 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281A09B1BC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 14:44:29 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id h192so7234876pgc.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 14:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g/7Ab+lUqbHBKquM7X74tLL7I91M9MvXubqbYkGPOVk=;
        b=Zl67+u/eyQ1S32sx6Hq1gU3wy6Jj/gEwFrHwfDLfj5kXKbGTga32otHuWaVSHP/BTG
         8FV8IFVMzeLwVIZPfohvtCHeQCORqyrMg6C5n5DKyzUkGHywc1SKe9OhZwKnjugA25Ut
         oQmqgR79kf6dZDTuSd/cGXe1DdZvA87Cy0Z4FGorlcY51sotwt6s2SdxKwzuhX7Wab7h
         xJLyf6bAEAOAic6jUhaoLF1K6RopUJ03duy3BiMOQL+oMllO4wJU88Rau/eyArAdDaG9
         08JtmscsPZLvfVuxDVuX46pUVLpQILO8k86SvuapQ2t6NPh5WDVDdchZrZOa1dSVfyym
         q/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g/7Ab+lUqbHBKquM7X74tLL7I91M9MvXubqbYkGPOVk=;
        b=JpBn7EkSG3OaAwnEjcFP3Ol0EV+/BaGZ0ZidTSEPbXkgkCB2WaGdRwitWdMUV6H9xZ
         CJMgLXqq3TcF8MQHN8vsbOfOZDZg3j5yvt955mP6gwjlxfp2NVrFe+PVtD8dclSoFoxi
         NxzFzQ0XifbDD79xCJpN059ZiWcw4uF4Ouhp8SBbsEYyyvi8iqGZ5JFgNps6IMv8pPDo
         JOV0hAGNDlyhtX9HJFLmkaMLpEZ7Zh+jNkQH+bxKPb3/vwOq3P56FZugEuji4Jo/waC4
         gFA2ILl1kb4JiB40JUmmgJCXgvRk37+ruF4J9PyjE1ij4IqC3nVHhY+noRY6fums/jW+
         U3MQ==
X-Gm-Message-State: AOAM5301qnvLU9At7o03FH7b7TVGbJTQ8O6lGWxEB+KNIkktf5Ov0FDO
        hwZxcXqzadametmXeyaQndc=
X-Google-Smtp-Source: ABdhPJx6iX/VMjSijaMzPoK9DuQWOtvamU7nFGhMGyi89Cl/lcGM4rONgFuIrgrd2gOAWSyeHWMSnw==
X-Received: by 2002:a65:6d0f:0:b0:3fd:8437:c35b with SMTP id bf15-20020a656d0f000000b003fd8437c35bmr9804463pgb.24.1654551868662;
        Mon, 06 Jun 2022 14:44:28 -0700 (PDT)
Received: from localhost.biz ([8.25.197.27])
        by smtp.gmail.com with ESMTPSA id a4-20020a170903100400b0016397da033csm10881675plb.62.2022.06.06.14.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 14:44:27 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        willy@infradead.org, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v3 PATCH 6/7] mm: thp: kill __transhuge_page_enabled()
Date:   Mon,  6 Jun 2022 14:44:13 -0700
Message-Id: <20220606214414.736109-7-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220606214414.736109-1-shy828301@gmail.com>
References: <20220606214414.736109-1-shy828301@gmail.com>
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
 mm/huge_memory.c           | 25 ++++++++++++-----
 mm/khugepaged.c            |  8 +++---
 mm/memory.c                |  7 +++--
 6 files changed, 31 insertions(+), 70 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index fd79566e204c..a0850303baec 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -860,7 +860,7 @@ static int show_smap(struct seq_file *m, void *v)
 	__show_smap(m, &mss, false);
 
 	seq_printf(m, "THPeligible:    %d\n",
-		   hugepage_vma_check(vma, vma->vm_flags, true));
+		   hugepage_vma_check(vma, vma->vm_flags, true, false));
 
 	if (arch_pkeys_enabled())
 		seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index f561c3e16def..d478e8875023 100644
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
@@ -211,7 +169,7 @@ static inline bool file_thp_enabled(struct vm_area_struct *vma)
 
 bool hugepage_vma_check(struct vm_area_struct *vma,
 			unsigned long vm_flags,
-			bool smaps);
+			bool smaps, bool in_pf);
 
 #define transparent_hugepage_use_zero_page()				\
 	(transparent_hugepage_flags &					\
@@ -355,11 +313,6 @@ static inline bool folio_test_pmd_mappable(struct folio *folio)
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
@@ -371,15 +324,9 @@ static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
 	return false;
 }
 
-static inline bool transhuge_vma_enabled(struct vm_area_struct *vma,
-					  unsigned long vm_flags)
-{
-	return false;
-}
-
 static inline bool hugepage_vma_check(struct vm_area_struct *vma,
 				       unsigned long vm_flags,
-				       bool smaps)
+				       bool smaps, bool in_pf)
 {
 	return false;
 }
diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
index 8a6452e089ca..e047be601268 100644
--- a/include/linux/khugepaged.h
+++ b/include/linux/khugepaged.h
@@ -55,7 +55,7 @@ static inline void khugepaged_enter(struct vm_area_struct *vma,
 {
 	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
 	    khugepaged_enabled()) {
-		if (hugepage_vma_check(vma, vm_flags, false))
+		if (hugepage_vma_check(vma, vm_flags, false, false))
 			__khugepaged_enter(vma->vm_mm);
 	}
 }
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index bc8370856e85..b95786ada466 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -71,17 +71,25 @@ unsigned long huge_zero_pfn __read_mostly = ~0UL;
 
 bool hugepage_vma_check(struct vm_area_struct *vma,
 			unsigned long vm_flags,
-			bool smaps)
+			bool smaps, bool in_pf)
 {
-	if (!transhuge_vma_enabled(vma, vm_flags))
+	/* Explicitly disabled through madvise or prctl. */
+	if ((vm_flags & VM_NOHUGEPAGE) ||
+	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
+		return false;
+	/*
+	 * If the hardware/firmware marked hugepage support disabled.
+	 */
+	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_NEVER_DAX))
 		return false;
 
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
@@ -91,7 +99,7 @@ bool hugepage_vma_check(struct vm_area_struct *vma,
 		return false;
 
 	/* Enabled via shmem mount options or sysfs settings. */
-	if (shmem_file(vma->vm_file))
+	if (!in_pf && shmem_file(vma->vm_file))
 		return shmem_huge_enabled(vma);
 
 	if (!khugepaged_enabled())
@@ -102,7 +110,7 @@ bool hugepage_vma_check(struct vm_area_struct *vma,
 		return false;
 
 	/* Only regular file is valid */
-	if (file_thp_enabled(vma))
+	if (!in_pf && file_thp_enabled(vma))
 		return true;
 
 	if (!vma_is_anonymous(vma))
@@ -114,9 +122,12 @@ bool hugepage_vma_check(struct vm_area_struct *vma,
 	/*
 	 * THPeligible bit of smaps should show 1 for proper VMAs even
 	 * though anon_vma is not initialized yet.
+	 *
+	 * Allow page fault since anon_vma may be not initialized until
+	 * the first page fault.
 	 */
 	if (!vma->anon_vma)
-		return smaps;
+		return (smaps || in_pf);
 
 	return true;
 }
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index aa0769e3b0d9..ab6183c5489f 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -473,7 +473,7 @@ void khugepaged_enter_vma(struct vm_area_struct *vma,
 {
 	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
 	    khugepaged_enabled()) {
-		if (hugepage_vma_check(vma, vm_flags, false))
+		if (hugepage_vma_check(vma, vm_flags, false, false))
 			__khugepaged_enter(vma->vm_mm);
 	}
 }
@@ -918,7 +918,7 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
 
 	if (!transhuge_vma_suitable(vma, address))
 		return SCAN_ADDRESS_RANGE;
-	if (!hugepage_vma_check(vma, vma->vm_flags, false))
+	if (!hugepage_vma_check(vma, vma->vm_flags, false, false))
 		return SCAN_VMA_CHECK;
 	return 0;
 }
@@ -1399,7 +1399,7 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
 	 * the valid THP. Add extra VM_HUGEPAGE so hugepage_vma_check()
 	 * will not fail the vma for missing VM_HUGEPAGE
 	 */
-	if (!hugepage_vma_check(vma, vma->vm_flags | VM_HUGEPAGE, false))
+	if (!hugepage_vma_check(vma, vma->vm_flags | VM_HUGEPAGE, false, false))
 		return;
 
 	/* Keep pmd pgtable for uffd-wp; see comment in retract_page_tables() */
@@ -2089,7 +2089,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
 			progress++;
 			break;
 		}
-		if (!hugepage_vma_check(vma, vma->vm_flags, false)) {
+		if (!hugepage_vma_check(vma, vma->vm_flags, false, false)) {
 skip:
 			progress++;
 			continue;
diff --git a/mm/memory.c b/mm/memory.c
index bc5d40eec5d5..673f7561a30a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4962,6 +4962,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 		.gfp_mask = __get_fault_gfp_mask(vma),
 	};
 	struct mm_struct *mm = vma->vm_mm;
+	unsigned long vm_flags = vma->vm_flags;
 	pgd_t *pgd;
 	p4d_t *p4d;
 	vm_fault_t ret;
@@ -4975,7 +4976,8 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 	if (!vmf.pud)
 		return VM_FAULT_OOM;
 retry_pud:
-	if (pud_none(*vmf.pud) && __transparent_hugepage_enabled(vma)) {
+	if (pud_none(*vmf.pud) &&
+	    hugepage_vma_check(vma, vm_flags, false, true)) {
 		ret = create_huge_pud(&vmf);
 		if (!(ret & VM_FAULT_FALLBACK))
 			return ret;
@@ -5008,7 +5010,8 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 	if (pud_trans_unstable(vmf.pud))
 		goto retry_pud;
 
-	if (pmd_none(*vmf.pmd) && __transparent_hugepage_enabled(vma)) {
+	if (pmd_none(*vmf.pmd) &&
+	    hugepage_vma_check(vma, vm_flags, false, true)) {
 		ret = create_huge_pmd(&vmf);
 		if (!(ret & VM_FAULT_FALLBACK))
 			return ret;
-- 
2.26.3

