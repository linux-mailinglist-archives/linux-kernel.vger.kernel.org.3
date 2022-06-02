Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B486C53BE0B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 20:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238132AbiFBSW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 14:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237988AbiFBSWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 14:22:12 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650389586
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 11:22:11 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id nn3-20020a17090b38c300b001e0e091cf03so6373174pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 11:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3YLj2fl29PQ2nWLBeslxp0V88dJtNL8lfA8pD6oU8q8=;
        b=Rf/b23jKN1mypu5L/BY5+gkApgLOkO60VjFloJqDSSOi3Zp7C9ySYekBmK9b+UhJN5
         3wP3DcExFTbzWgAPhJ6F5nMjsgYO1nGOIqU4X/r6K4WYiPi55lHjxU5j2eZopyZ5pYT4
         tluPHDRvLNEzwN3PvPDeTqp58jkBh6aQfHVphPNX5Dtt1C6JC5ZQyOyRzfPQjzD3GTug
         5TvTWnw0L6/M4dx3JmMLOgRIvNWbJgzWE4tPhp1aGVGl2boPcGIYYRoIfwf6uLA19nvb
         bGEgYAdJyApHIoBPJWMwj/4MvL7hZPg1WhL6q2S8NGzXd0p0RpgA5wow27UJkPtcz3Hy
         3YSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3YLj2fl29PQ2nWLBeslxp0V88dJtNL8lfA8pD6oU8q8=;
        b=h5xQZ/oC3Zxo+t4qAMucGTQu2rj0TBacJOL1QbmYfuXhMUMmNNuP7uGcrOTQ2vhmQp
         Sz7KJHfe5cc/GN/9le8slIW+OHvD6JzZ07I6jTwmhavYYdWWwBiok3GnyY+AhKdKnQOA
         Eka34xaKNy5m9k6QAEuDErJxCkxLsTp3a9Ly1oA/i9KzM47Pb+MUE/EL5/Smvd0AX7cH
         v1S7r/wWtwT6ypt/ikfl9qagPd2EY7/33+N/0EEqQ83zXGXcPYdo3lzvlquc1b/Pc4g8
         ycspz7ZCgVGSyL5VjrQTRo9XYIMgWAdFeeHV9MccLvXh0uc2Pp9iajaQLTjvu/dilId6
         q4Dg==
X-Gm-Message-State: AOAM531DuguNatbJNuofmOV/O7AleUYgrBT1ecElq6uPbBDDmba8XxbI
        sh8I4r/L8LdMbRK2YZg5t+Q=
X-Google-Smtp-Source: ABdhPJyclp/ibM+hVcPzkUg9jkHC7l2XJyrVQn117jPC5u/X7fUVVnVA5aK3MtI5vqtPAMF4aWzcsw==
X-Received: by 2002:a17:90b:3841:b0:1e2:f16a:a117 with SMTP id nl1-20020a17090b384100b001e2f16aa117mr25691608pjb.130.1654194130914;
        Thu, 02 Jun 2022 11:22:10 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id t10-20020a1709027fca00b0015f2d549b46sm3866779plb.237.2022.06.02.11.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 11:22:10 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v2 PATCH 5/7] mm: thp: kill transparent_hugepage_active()
Date:   Thu,  2 Jun 2022 11:21:57 -0700
Message-Id: <20220602182159.248387-6-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220602182159.248387-1-shy828301@gmail.com>
References: <20220602182159.248387-1-shy828301@gmail.com>
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

The transparent_hugepage_active() was introduced to show THP eligibility
bit in smaps in proc, smaps is the only user.  But it actually does the
similar check as hugepage_vma_check() which is used by khugepaged.  We
definitely don't have to maintain two similar checks, so kill
transparent_hugepage_active().

Also move hugepage_vma_check() to huge_memory.c and huge_mm.h since it
is not only for khugepaged anymore.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 fs/proc/task_mmu.c         |  2 +-
 include/linux/huge_mm.h    | 16 +++++++-----
 include/linux/khugepaged.h |  4 +--
 mm/huge_memory.c           | 50 ++++++++++++++++++++++++++++++++-----
 mm/khugepaged.c            | 51 +++-----------------------------------
 5 files changed, 60 insertions(+), 63 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 2dd8c8a66924..fd79566e204c 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -860,7 +860,7 @@ static int show_smap(struct seq_file *m, void *v)
 	__show_smap(m, &mss, false);
 
 	seq_printf(m, "THPeligible:    %d\n",
-		   transparent_hugepage_active(vma));
+		   hugepage_vma_check(vma, vma->vm_flags, true));
 
 	if (arch_pkeys_enabled())
 		seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 79d5919beb83..f315c70d5256 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -209,7 +209,9 @@ static inline bool file_thp_enabled(struct vm_area_struct *vma)
 	       !inode_is_open_for_write(inode) && S_ISREG(inode->i_mode);
 }
 
-bool transparent_hugepage_active(struct vm_area_struct *vma);
+extern bool hugepage_vma_check(struct vm_area_struct *vma,
+			       unsigned long vm_flags,
+			       bool smaps);
 
 #define transparent_hugepage_use_zero_page()				\
 	(transparent_hugepage_flags &					\
@@ -358,11 +360,6 @@ static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
 	return false;
 }
 
-static inline bool transparent_hugepage_active(struct vm_area_struct *vma)
-{
-	return false;
-}
-
 static inline bool transhuge_vma_size_ok(struct vm_area_struct *vma)
 {
 	return false;
@@ -380,6 +377,13 @@ static inline bool transhuge_vma_enabled(struct vm_area_struct *vma,
 	return false;
 }
 
+static inline bool hugepage_vma_check(struct vm_area_struct *vma,
+				       unsigned long vm_flags,
+				       bool smaps)
+{
+	return false;
+}
+
 static inline void prep_transhuge_page(struct page *page) {}
 
 #define transparent_hugepage_flags 0UL
diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
index 392d34c3c59a..8a6452e089ca 100644
--- a/include/linux/khugepaged.h
+++ b/include/linux/khugepaged.h
@@ -10,8 +10,6 @@ extern struct attribute_group khugepaged_attr_group;
 extern int khugepaged_init(void);
 extern void khugepaged_destroy(void);
 extern int start_stop_khugepaged(void);
-extern bool hugepage_vma_check(struct vm_area_struct *vma,
-			       unsigned long vm_flags);
 extern void __khugepaged_enter(struct mm_struct *mm);
 extern void __khugepaged_exit(struct mm_struct *mm);
 extern void khugepaged_enter_vma(struct vm_area_struct *vma,
@@ -57,7 +55,7 @@ static inline void khugepaged_enter(struct vm_area_struct *vma,
 {
 	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
 	    khugepaged_enabled()) {
-		if (hugepage_vma_check(vma, vm_flags))
+		if (hugepage_vma_check(vma, vm_flags, false))
 			__khugepaged_enter(vma->vm_mm);
 	}
 }
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 36ada544e494..bc8370856e85 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -69,18 +69,56 @@ static atomic_t huge_zero_refcount;
 struct page *huge_zero_page __read_mostly;
 unsigned long huge_zero_pfn __read_mostly = ~0UL;
 
-bool transparent_hugepage_active(struct vm_area_struct *vma)
+bool hugepage_vma_check(struct vm_area_struct *vma,
+			unsigned long vm_flags,
+			bool smaps)
 {
+	if (!transhuge_vma_enabled(vma, vm_flags))
+		return false;
+
+	if (vm_flags & VM_NO_KHUGEPAGED)
+		return false;
+
+	/* Don't run khugepaged against DAX vma */
+	if (vma_is_dax(vma))
+		return false;
+
+	if (vma->vm_file && !IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) -
+				vma->vm_pgoff, HPAGE_PMD_NR))
+		return false;
+
 	if (!transhuge_vma_size_ok(vma))
 		return false;
-	if (vma_is_anonymous(vma))
-		return __transparent_hugepage_enabled(vma);
-	if (vma_is_shmem(vma))
+
+	/* Enabled via shmem mount options or sysfs settings. */
+	if (shmem_file(vma->vm_file))
 		return shmem_huge_enabled(vma);
-	if (transhuge_vma_enabled(vma, vma->vm_flags) && file_thp_enabled(vma))
+
+	if (!khugepaged_enabled())
+		return false;
+
+	/* THP settings require madvise. */
+	if (!(vm_flags & VM_HUGEPAGE) && !khugepaged_always())
+		return false;
+
+	/* Only regular file is valid */
+	if (file_thp_enabled(vma))
 		return true;
 
-	return false;
+	if (!vma_is_anonymous(vma))
+		return false;
+
+	if (vma_is_temporary_stack(vma))
+		return false;
+
+	/*
+	 * THPeligible bit of smaps should show 1 for proper VMAs even
+	 * though anon_vma is not initialized yet.
+	 */
+	if (!vma->anon_vma)
+		return smaps;
+
+	return true;
 }
 
 static bool get_huge_zero_page(void)
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index ca1754d3a827..aa0769e3b0d9 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -437,49 +437,6 @@ static inline int khugepaged_test_exit(struct mm_struct *mm)
 	return atomic_read(&mm->mm_users) == 0;
 }
 
-bool hugepage_vma_check(struct vm_area_struct *vma,
-			unsigned long vm_flags)
-{
-	if (!transhuge_vma_enabled(vma, vm_flags))
-		return false;
-
-	if (vm_flags & VM_NO_KHUGEPAGED)
-		return false;
-
-	/* Don't run khugepaged against DAX vma */
-	if (vma_is_dax(vma))
-		return false;
-
-	if (vma->vm_file && !IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) -
-				vma->vm_pgoff, HPAGE_PMD_NR))
-		return false;
-
-	if (!transhuge_vma_size_ok(vma))
-		return false;
-
-	/* Enabled via shmem mount options or sysfs settings. */
-	if (shmem_file(vma->vm_file))
-		return shmem_huge_enabled(vma);
-
-	if (!khugepaged_enabled())
-		return false;
-
-	/* THP settings require madvise. */
-	if (!(vm_flags & VM_HUGEPAGE) && !khugepaged_always())
-		return false;
-
-	/* Only regular file is valid */
-	if (file_thp_enabled(vma))
-		return true;
-
-	if (!vma->anon_vma || !vma_is_anonymous(vma))
-		return false;
-	if (vma_is_temporary_stack(vma))
-		return false;
-
-	return true;
-}
-
 void __khugepaged_enter(struct mm_struct *mm)
 {
 	struct mm_slot *mm_slot;
@@ -516,7 +473,7 @@ void khugepaged_enter_vma(struct vm_area_struct *vma,
 {
 	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
 	    khugepaged_enabled()) {
-		if (hugepage_vma_check(vma, vm_flags))
+		if (hugepage_vma_check(vma, vm_flags, false))
 			__khugepaged_enter(vma->vm_mm);
 	}
 }
@@ -961,7 +918,7 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
 
 	if (!transhuge_vma_suitable(vma, address))
 		return SCAN_ADDRESS_RANGE;
-	if (!hugepage_vma_check(vma, vma->vm_flags))
+	if (!hugepage_vma_check(vma, vma->vm_flags, false))
 		return SCAN_VMA_CHECK;
 	return 0;
 }
@@ -1442,7 +1399,7 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
 	 * the valid THP. Add extra VM_HUGEPAGE so hugepage_vma_check()
 	 * will not fail the vma for missing VM_HUGEPAGE
 	 */
-	if (!hugepage_vma_check(vma, vma->vm_flags | VM_HUGEPAGE))
+	if (!hugepage_vma_check(vma, vma->vm_flags | VM_HUGEPAGE, false))
 		return;
 
 	/* Keep pmd pgtable for uffd-wp; see comment in retract_page_tables() */
@@ -2132,7 +2089,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
 			progress++;
 			break;
 		}
-		if (!hugepage_vma_check(vma, vma->vm_flags)) {
+		if (!hugepage_vma_check(vma, vma->vm_flags, false)) {
 skip:
 			progress++;
 			continue;
-- 
2.26.3

