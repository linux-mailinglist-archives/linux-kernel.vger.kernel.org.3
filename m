Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFB553F1D8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 23:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbiFFVor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 17:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbiFFVoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 17:44:30 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBC29B189
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 14:44:27 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id u18so13200793plb.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 14:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hc3IsUtoDZHlbZz0pKu30HageYNlh4gUZJ0bt5eOoac=;
        b=ovR/IKgd3FrhNSybEgHRSha6sg3pcMQaSjwDNFQAK9l4/69jfwfcwuFOhND3KawDGB
         F9I5DSIpK/DYLjEZuokouhEM4T4Amtt3pIH0CZw0Q2a2WhUlbSlv+PAJlR4dmKxKnOSG
         q53HRkahqgfn267VBDNMdXolYjMgrX9UHO6tUqU4lBCoWACO9n50B3209hpS0n6CcarA
         nrtdfNFeIlF+1FuQbeU1mcDKx1suwgs212M6Zdl4yhgciSxs2HODGHD5msdQRIbdgBOq
         J2GumkWaEf52nfTEcQNI9D8h5BfHETV86Ol0dL2u1IX300bbvqB/J76X1Gr09WvSbTeA
         p12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hc3IsUtoDZHlbZz0pKu30HageYNlh4gUZJ0bt5eOoac=;
        b=dqrV75fFfaIp8pJp7jiDlcdp5hC8DC/KrYgPHQ7WyswpwAlAjr84w9yf+aKcpwhLZy
         hVFoYgVorOMbjSJ/WLYg2WNZCdkif7FbSmKo0RtZHIVzBe/IFmyULhlC6/j3INSiZf1H
         +cGg6tuGHqpwFjO8iJvRebFkDED8hdWczTo1SD/PSesaZgYxH2vucecSclEHLBtYVaCl
         VFgs4mxkNMkffxxQbVkQqnWFnvFx7Xo3a/NsJQDyFrHeFIk8OrcG9o3BmjktkPBjPAlJ
         nvavNePn4ya91HmfVriXIWIyNV1Fs2RZyAuCkgBetPzsgSpZHORh9Li6q5iGhxMQlFOx
         HhiA==
X-Gm-Message-State: AOAM530f7a6shwyop2oY1BGWK97gTDfwDUhJ4XcEYz2r44QhmaSTgrcQ
        5Up3tIYD1rAnUMNmjo4vIc4=
X-Google-Smtp-Source: ABdhPJw1vCIJ1tEESyDDFocIeFBC1uMymoEmS7+PYZF4AcUzt+PLNG4KF514jqx5+ae8P8M3ji4Ulw==
X-Received: by 2002:a17:90a:ce84:b0:1e4:d803:fad with SMTP id g4-20020a17090ace8400b001e4d8030fadmr34335734pju.99.1654551866768;
        Mon, 06 Jun 2022 14:44:26 -0700 (PDT)
Received: from localhost.biz ([8.25.197.27])
        by smtp.gmail.com with ESMTPSA id a4-20020a170903100400b0016397da033csm10881675plb.62.2022.06.06.14.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 14:44:26 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        willy@infradead.org, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v3 PATCH 5/7] mm: thp: kill transparent_hugepage_active()
Date:   Mon,  6 Jun 2022 14:44:12 -0700
Message-Id: <20220606214414.736109-6-shy828301@gmail.com>
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
index 79d5919beb83..f561c3e16def 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -209,7 +209,9 @@ static inline bool file_thp_enabled(struct vm_area_struct *vma)
 	       !inode_is_open_for_write(inode) && S_ISREG(inode->i_mode);
 }
 
-bool transparent_hugepage_active(struct vm_area_struct *vma);
+bool hugepage_vma_check(struct vm_area_struct *vma,
+			unsigned long vm_flags,
+			bool smaps);
 
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

