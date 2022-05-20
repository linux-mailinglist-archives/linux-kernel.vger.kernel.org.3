Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F3C52F4E0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 23:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353663AbiETVQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 17:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353626AbiETVQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 17:16:22 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3885818B34
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 14:16:20 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id x143so8709296pfc.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 14:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uZ2MKo3NmwofqEpjSOVwGsJSdmq+ezPANYKqYBOCivQ=;
        b=GlUHTdvFzA+MiS/hUNdv6efIELq4i8AG5YNwOF3pCD/x8eHQ3mO/nO9rzy2mnR7XH1
         ValbE4N4DtXGnshp8xRyTVvJzq2qACTDgi0ajm9hyH7DMsj5u4C2Jg8reA4QlehsVHbR
         be5ed75Yfa6fp38jcJq+/yfWqPbe2ETtPdPr+IVTBft67Os6XqydSX+tMIGtCeZUUOtp
         KiuB1bGfYS8zV6EUxtSrDxCoMRTFSmk3fUy67kQv2L/Eti7oN2DIRQTTx8mc0mLSl5Wg
         2ppQD4KDMrosfKKb8KfPX1P4BH2GMZ9hcmKAcs2McyocWqVKB4rdSI04zdLEy3XJpuIN
         76Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uZ2MKo3NmwofqEpjSOVwGsJSdmq+ezPANYKqYBOCivQ=;
        b=LSgBCPn+ubTTK8VRE6HAeQfGw6taEF/9FmNh3Ys8hTkD6bCkVdtwDP+QxDDfYQHhpo
         INsYnAOMBX/uEX4B+7PUa5EJ7zvaqernqriEc0BRG2sIxj1eAdhdbhUG85+jy3JwC0YD
         Uv2KHFMloY2itVQPptYz0z+3asKtoOzOX1bm6WX8K+afDwKiBuD3zl3OK83svZrSi2d/
         0AoqKMFV8Qq2j8j6V5uGYLl/Mffe1uVfyDR4BHX4/AJsssOKup1CWSbF4y7SV2338mme
         yNkFwKlOn0OFjJLR7yfXDPqu7s0clgkqFB0esz29bjY1DbmBVCbGREjSjDOXH8Em96p3
         dbmg==
X-Gm-Message-State: AOAM533XfdN2jkf+NnWZkgHJXbZOfJdMv2IRzgiRdn7rkV8BlS7sIYwr
        dJBsPPJRpVHKjEMkozgq4ZA=
X-Google-Smtp-Source: ABdhPJxHWgmmuDTl0VVnULJFQSbEJPMKkPtl2dOD6vFWj6vfs9p9296+xsaK0tTFIq3fQZmISbfDAQ==
X-Received: by 2002:a62:b515:0:b0:50a:3d51:671e with SMTP id y21-20020a62b515000000b0050a3d51671emr11785398pfe.48.1653081379866;
        Fri, 20 May 2022 14:16:19 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id h1-20020a170902748100b0015e8d4eb2c2sm167620pll.268.2022.05.20.14.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 14:16:19 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] mm: thp: kill transparent_hugepage_active()
Date:   Fri, 20 May 2022 14:16:03 -0700
Message-Id: <20220520211605.51473-6-shy828301@gmail.com>
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
 include/linux/huge_mm.h    | 14 +++++++------
 include/linux/khugepaged.h |  2 --
 mm/huge_memory.c           | 41 ++++++++++++++++++++++++++++++------
 mm/khugepaged.c            | 43 --------------------------------------
 5 files changed, 44 insertions(+), 58 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index f9c9abb50bb7..ab4849d07a1f 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -863,7 +863,7 @@ static int show_smap(struct seq_file *m, void *v)
 	__show_smap(m, &mss, false);
 
 	seq_printf(m, "THPeligible:    %d\n",
-		   transparent_hugepage_active(vma));
+		   hugepage_vma_check(vma, vma->vm_flags));
 
 	if (arch_pkeys_enabled())
 		seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 79d5919beb83..2da52ca8fd52 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -209,7 +209,8 @@ static inline bool file_thp_enabled(struct vm_area_struct *vma)
 	       !inode_is_open_for_write(inode) && S_ISREG(inode->i_mode);
 }
 
-bool transparent_hugepage_active(struct vm_area_struct *vma);
+extern bool hugepage_vma_check(struct vm_area_struct *vma,
+			       unsigned long vm_flags);
 
 #define transparent_hugepage_use_zero_page()				\
 	(transparent_hugepage_flags &					\
@@ -358,11 +359,6 @@ static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
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
@@ -380,6 +376,12 @@ static inline bool transhuge_vma_enabled(struct vm_area_struct *vma,
 	return false;
 }
 
+static inline bool hugepage_vma_check(struct vm_area_struct *vma,
+				       unsigned long vm_flags)
+{
+	return false;
+}
+
 static inline void prep_transhuge_page(struct page *page) {}
 
 #define transparent_hugepage_flags 0UL
diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
index 392d34c3c59a..795c8d2170b0 100644
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
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d633f97452c1..d9ec82892b05 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -69,18 +69,47 @@ static atomic_t huge_zero_refcount;
 struct page *huge_zero_page __read_mostly;
 unsigned long huge_zero_pfn __read_mostly = ~0UL;
 
-bool transparent_hugepage_active(struct vm_area_struct *vma)
+bool hugepage_vma_check(struct vm_area_struct *vma,
+			unsigned long vm_flags)
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
+	if (!vma->anon_vma || !vma_is_anonymous(vma))
+		return false;
+	if (vma_is_temporary_stack(vma))
+		return false;
+
+	return true;
 }
 
 static bool get_huge_zero_page(void)
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 51f0e6ea3977..a7ac1ae418f8 100644
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
-- 
2.26.3

