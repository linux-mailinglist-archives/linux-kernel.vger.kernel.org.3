Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8EF54E8D6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 19:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238485AbiFPRtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 13:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237406AbiFPRs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 13:48:57 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309854D60F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 10:48:56 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id h192so1898934pgc.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 10:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9rMZNhDmVhFfYI3dZDinmpFWJ+654cXj29ZWajToGJQ=;
        b=k54UC37gpxXu1HC6M7ieaY9VAO7o/YPUOu3hXBYkVkv9C9ybJ7kPZYEOP8IFLnqa/K
         b7SIBpXhgLFueHs3dPgXuUiOOqsWOJml11FXjJAmxamtSAesoQTB/a6eYS0IOrmmlW3e
         baHSJK3GJFK4JfnGIsv3RSKvHe4rsDTJkVQQNJb2ag7cv7IfjK4EtZiTm8uCh9tK/t1R
         hPTvYNDOs8R4yWRNcO9HttLDz1hx57EdefHssGDrstlaCNpwL44FwCRn5in6w/PrA+3V
         6T/kd19emhBUlP+XHDsb2pnQCRpRfCDXfhv9VXTz+/fHjJJsirE5df6xjGI9jd5nA5UQ
         nIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9rMZNhDmVhFfYI3dZDinmpFWJ+654cXj29ZWajToGJQ=;
        b=VZajzeYdrC5EWS40+HFiOvr3fHzbzz9VpPaSDh9Wd/2EM+XodzF5OiovvKDaRIeCW3
         KqPmwA6jASyPiLUJasy8c4/aqevTzPLVrJkkdoSTcdz+6iOuH35OesKFjkWZeej/KqKe
         MyV1uwX8Mn6DdK0/x60R2+ve6EuZnAUa8QUX7zlmrT2QfeG4KA9ICd4EAS5fsSf8QnXb
         thWiOfKeBToe8lRz2ox1dL/aLvWRF5p1YocF98ZIy8J03ZseySZkHgS5Ybwt/xc4DbPh
         kDKlD5GnxYIiaB0WwA0SBAojjpEyxIcHtyPK8yi6XfWSKWOWEBKiGPnjuP/n0IxODWYb
         dlaA==
X-Gm-Message-State: AJIora/qAeatectW2vF6HA2VQMbx/fkjVzhg7IlrDlJYaJ2Q5sZgGqwY
        v9/O2O4WHRmn5ZKqj3fDHA9KIuMa3sQ=
X-Google-Smtp-Source: AGRyM1vl4tOydvP7hK0KqRHMn/OYMwWHFtGqeiwYKuHJr2LotWCPXbJStaJQm1Mior+02JTeRp6U3w==
X-Received: by 2002:a05:6a00:98b:b0:51b:d730:c58 with SMTP id u11-20020a056a00098b00b0051bd7300c58mr6008432pfg.23.1655401735644;
        Thu, 16 Jun 2022 10:48:55 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id z21-20020a17090a8b9500b001e8520b211bsm1818289pjn.53.2022.06.16.10.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 10:48:54 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        willy@infradead.org, zokeefe@google.com, linmiaohe@huawei.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v5 PATCH 5/7] mm: thp: kill __transhuge_page_enabled()
Date:   Thu, 16 Jun 2022 10:48:38 -0700
Message-Id: <20220616174840.1202070-6-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220616174840.1202070-1-shy828301@gmail.com>
References: <20220616174840.1202070-1-shy828301@gmail.com>
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

Reviewed-by: Zach O'Keefe <zokeefe@google.com>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 fs/proc/task_mmu.c      |  2 +-
 include/linux/huge_mm.h | 57 ++---------------------------------------
 mm/huge_memory.c        | 51 ++++++++++++++++++++++++++++--------
 mm/khugepaged.c         |  8 +++---
 mm/memory.c             |  7 +++--
 5 files changed, 52 insertions(+), 73 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 39a40ec181e7..cef72e49acc5 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -863,7 +863,7 @@ static int show_smap(struct seq_file *m, void *v)
 	__show_smap(m, &mss, false);
 
 	seq_printf(m, "THPeligible:    %d\n",
-		   hugepage_vma_check(vma, vma->vm_flags, true));
+		   hugepage_vma_check(vma, vma->vm_flags, true, false));
 
 	if (arch_pkeys_enabled())
 		seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 64487bcd0c7b..cd8a6c5d9fe5 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -146,48 +146,6 @@ static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
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
@@ -204,7 +162,7 @@ static inline bool file_thp_enabled(struct vm_area_struct *vma)
 
 bool hugepage_vma_check(struct vm_area_struct *vma,
 			unsigned long vm_flags,
-			bool smaps);
+			bool smaps, bool in_pf);
 
 #define transparent_hugepage_use_zero_page()				\
 	(transparent_hugepage_flags &					\
@@ -348,26 +306,15 @@ static inline bool folio_test_pmd_mappable(struct folio *folio)
 	return false;
 }
 
-static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
-{
-	return false;
-}
-
 static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
 		unsigned long addr)
 {
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
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index a28c6100b491..d0c37d99917b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -71,24 +71,50 @@ unsigned long huge_zero_pfn __read_mostly = ~0UL;
 
 bool hugepage_vma_check(struct vm_area_struct *vma,
 			unsigned long vm_flags,
-			bool smaps)
+			bool smaps, bool in_pf)
 {
-	if (!transhuge_vma_enabled(vma, vm_flags))
+	/*
+	 * Explicitly disabled through madvise or prctl, or some
+	 * architectures may disable THP for some mappings, for
+	 * example, s390 kvm.
+	 * */
+	if ((vm_flags & VM_NOHUGEPAGE) ||
+	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
 		return false;
-
-	if (vm_flags & VM_NO_KHUGEPAGED)
+	/*
+	 * If the hardware/firmware marked hugepage support disabled.
+	 */
+	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_NEVER_DAX))
 		return false;
 
-	/* Don't run khugepaged against DAX vma */
+	/* khugepaged doesn't collapse DAX vma, but page fault is fine. */
 	if (vma_is_dax(vma))
+		return in_pf;
+
+	/*
+	 * Special VMA and hugetlb VMA.
+	 * Must be checked after dax since some dax mappings may have
+	 * VM_MIXEDMAP set.
+	 */
+	if (vm_flags & VM_NO_KHUGEPAGED)
 		return false;
 
-	/* Check alignment for file vma and size for both file and anon vma */
-	if (!transhuge_vma_suitable(vma, (vma->vm_end - HPAGE_PMD_SIZE)))
+	/*
+	 * Check alignment for file vma and size for both file and anon vma.
+	 *
+	 * Skip the check for page fault. Huge fault does the check in fault
+	 * handlers. And this check is not suitable for huge PUD fault.
+	 */
+	if (!in_pf &&
+	    !transhuge_vma_suitable(vma, (vma->vm_end - HPAGE_PMD_SIZE)))
 		return false;
 
-	/* Enabled via shmem mount options or sysfs settings. */
-	if (shmem_file(vma->vm_file))
+	/*
+	 * Enabled via shmem mount options or sysfs settings.
+	 * Must be done before hugepage flags check since shmem has its
+	 * own flags.
+	 */
+	if (!in_pf && shmem_file(vma->vm_file))
 		return shmem_huge_enabled(vma);
 
 	if (!khugepaged_enabled())
@@ -99,7 +125,7 @@ bool hugepage_vma_check(struct vm_area_struct *vma,
 		return false;
 
 	/* Only regular file is valid */
-	if (file_thp_enabled(vma))
+	if (!in_pf && file_thp_enabled(vma))
 		return true;
 
 	if (!vma_is_anonymous(vma))
@@ -111,9 +137,12 @@ bool hugepage_vma_check(struct vm_area_struct *vma,
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
index 3afd87f8c0b1..2a676f37c921 100644
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
 	/*
 	 * Anon VMA expected, the address may be unmapped then
@@ -1408,7 +1408,7 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
 	 * the valid THP. Add extra VM_HUGEPAGE so hugepage_vma_check()
 	 * will not fail the vma for missing VM_HUGEPAGE
 	 */
-	if (!hugepage_vma_check(vma, vma->vm_flags | VM_HUGEPAGE, false))
+	if (!hugepage_vma_check(vma, vma->vm_flags | VM_HUGEPAGE, false, false))
 		return;
 
 	/* Keep pmd pgtable for uffd-wp; see comment in retract_page_tables() */
@@ -2103,7 +2103,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
 			progress++;
 			break;
 		}
-		if (!hugepage_vma_check(vma, vma->vm_flags, false)) {
+		if (!hugepage_vma_check(vma, vma->vm_flags, false, false)) {
 skip:
 			progress++;
 			continue;
diff --git a/mm/memory.c b/mm/memory.c
index be724238a9d3..fee2884481f2 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4985,6 +4985,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 		.gfp_mask = __get_fault_gfp_mask(vma),
 	};
 	struct mm_struct *mm = vma->vm_mm;
+	unsigned long vm_flags = vma->vm_flags;
 	pgd_t *pgd;
 	p4d_t *p4d;
 	vm_fault_t ret;
@@ -4998,7 +4999,8 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 	if (!vmf.pud)
 		return VM_FAULT_OOM;
 retry_pud:
-	if (pud_none(*vmf.pud) && __transparent_hugepage_enabled(vma)) {
+	if (pud_none(*vmf.pud) &&
+	    hugepage_vma_check(vma, vm_flags, false, true)) {
 		ret = create_huge_pud(&vmf);
 		if (!(ret & VM_FAULT_FALLBACK))
 			return ret;
@@ -5031,7 +5033,8 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
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

