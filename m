Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC38E54E8DA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 19:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237777AbiFPRtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 13:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235967AbiFPRsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 13:48:51 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E814BFCF
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 10:48:51 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id u2so2123544pfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 10:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lf1Kp53gV5xVxcPrzuVVyrzHKBnqiH74ZtDbvhyF8zw=;
        b=qHbvu3U4WI6XTL+Bb7EcWbfSgzpXVwmBwdYi5b4fTDSMY/tMFb3YRbJy105vXefOI1
         v+XLHWPz/vB0UgVN0u2mh1l+NLdiJ88GcEjUAoGZvoskG4KtWLQvWM29G0qBeynD9M9l
         ejsjQKiDU16xatYVZWK11/4EP942U/xh+kghEmAO2eS/VqNHbCd9twMGhSrNDNbfL3Fx
         8AuHMCmNpCKAfw1BDm1meeWm/ujGolhpZ8paAlpESIC987HvF+vMDiRVmzs8ryP6UOof
         4f4TUCiMMsSW1Qf6i2NxxcKj798ou3uvQlxSTGuXQ1ILAc8RKJd5hZjzKuHbjwjJ1504
         8VjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lf1Kp53gV5xVxcPrzuVVyrzHKBnqiH74ZtDbvhyF8zw=;
        b=yarRhz5uXHo5NVwEhQ7MFQ4GasG77d/ajPnLPrsdpBL9Zjr0bzmNuMBn8aZrMLjNHf
         vH6h0gGfDL99Axi2AadH8AmauDsU5R5BhQf/atFs6X34wXoaZCXwn17rr2s5yz3FRLB3
         EVvYT3bg1SUWzRA0x5E21bKr0kW36foD78mx2hE5ueqqLq+jcGWWkpcVIKovMxV8K5iv
         fnG+bkdC2sRv/9GSop+9Pun8hiewEw2lPUaWLcUc4MOvwtdWJRkP38FCeuVVTWbtnKp+
         Bg5qEVEdbBr7qE1fVHROjGfqb7AcRVHLyxkxU/N/6h4wFbyvYC6cXcmT8JeohfHP4Cpr
         Vqzw==
X-Gm-Message-State: AJIora9Ik28smitMheU61QLDuguXu7xcfW2TyEVYMTIkK55BqmOKDTl2
        w3dya5HQ0k+YDr9VZ0LA4a8=
X-Google-Smtp-Source: AGRyM1sILDxv0QZoQXrOLOSuJVQZEjJnBYzToTfeZrKnwvvpIW3ALa81CvsweBmzReuWF3hmAbqADA==
X-Received: by 2002:a63:894a:0:b0:3fc:a724:578c with SMTP id v71-20020a63894a000000b003fca724578cmr5543251pgd.499.1655401730679;
        Thu, 16 Jun 2022 10:48:50 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id z21-20020a17090a8b9500b001e8520b211bsm1818289pjn.53.2022.06.16.10.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 10:48:50 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        willy@infradead.org, zokeefe@google.com, linmiaohe@huawei.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v5 PATCH 2/7] mm: thp: consolidate vma size check to transhuge_vma_suitable
Date:   Thu, 16 Jun 2022 10:48:35 -0700
Message-Id: <20220616174840.1202070-3-shy828301@gmail.com>
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

There are couple of places that check whether the vma size is ok for
THP or whether address fits, they are open coded and duplicate, use
transhuge_vma_suitable() to do the job by passing in (vma->end -
HPAGE_PMD_SIZE).

Move vma size check into hugepage_vma_check().  This will make
khugepaged_enter() is as same as khugepaged_enter_vma().  There is just
one caller for khugepaged_enter(), replace it to khugepaged_enter_vma()
and remove khugepaged_enter().

Reviewed-by: Zach O'Keefe <zokeefe@google.com>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 include/linux/huge_mm.h    | 11 +++++++++++
 include/linux/khugepaged.h | 14 --------------
 mm/huge_memory.c           |  2 +-
 mm/khugepaged.c            | 19 ++++++-------------
 4 files changed, 18 insertions(+), 28 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 648cb3ce7099..8a5a8bfce0f5 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -116,6 +116,17 @@ extern struct kobj_attribute shmem_enabled_attr;
 
 extern unsigned long transparent_hugepage_flags;
 
+/*
+ * Do the below checks:
+ *   - For file vma, check if the linear page offset of vma is
+ *     HPAGE_PMD_NR aligned within the file.  The hugepage is
+ *     guaranteed to be hugepage-aligned within the file, but we must
+ *     check that the PMD-aligned addresses in the VMA map to
+ *     PMD-aligned offsets within the file, else the hugepage will
+ *     not be PMD-mappable.
+ *   - For all vmas, check if the haddr is in an aligned HPAGE_PMD_SIZE
+ *     area.
+ */
 static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
 		unsigned long addr)
 {
diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
index 392d34c3c59a..31ca8a7f78f4 100644
--- a/include/linux/khugepaged.h
+++ b/include/linux/khugepaged.h
@@ -51,16 +51,6 @@ static inline void khugepaged_exit(struct mm_struct *mm)
 	if (test_bit(MMF_VM_HUGEPAGE, &mm->flags))
 		__khugepaged_exit(mm);
 }
-
-static inline void khugepaged_enter(struct vm_area_struct *vma,
-				   unsigned long vm_flags)
-{
-	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
-	    khugepaged_enabled()) {
-		if (hugepage_vma_check(vma, vm_flags))
-			__khugepaged_enter(vma->vm_mm);
-	}
-}
 #else /* CONFIG_TRANSPARENT_HUGEPAGE */
 static inline void khugepaged_fork(struct mm_struct *mm, struct mm_struct *oldmm)
 {
@@ -68,10 +58,6 @@ static inline void khugepaged_fork(struct mm_struct *mm, struct mm_struct *oldmm
 static inline void khugepaged_exit(struct mm_struct *mm)
 {
 }
-static inline void khugepaged_enter(struct vm_area_struct *vma,
-				    unsigned long vm_flags)
-{
-}
 static inline void khugepaged_enter_vma(struct vm_area_struct *vma,
 					unsigned long vm_flags)
 {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 4f9bbb4eab23..b530462c4493 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -726,7 +726,7 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 		return VM_FAULT_FALLBACK;
 	if (unlikely(anon_vma_prepare(vma)))
 		return VM_FAULT_OOM;
-	khugepaged_enter(vma, vma->vm_flags);
+	khugepaged_enter_vma(vma, vma->vm_flags);
 
 	if (!(vmf->flags & FAULT_FLAG_WRITE) &&
 			!mm_forbids_zeropage(vma->vm_mm) &&
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b1dab94c0f1e..db0b334a7d1f 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -450,8 +450,8 @@ bool hugepage_vma_check(struct vm_area_struct *vma,
 	if (vma_is_dax(vma))
 		return false;
 
-	if (vma->vm_file && !IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) -
-				vma->vm_pgoff, HPAGE_PMD_NR))
+	/* Check alignment for file vma and size for both file and anon vma */
+	if (!transhuge_vma_suitable(vma, (vma->vm_end - HPAGE_PMD_SIZE)))
 		return false;
 
 	/* Enabled via shmem mount options or sysfs settings. */
@@ -512,9 +512,7 @@ void khugepaged_enter_vma(struct vm_area_struct *vma,
 			  unsigned long vm_flags)
 {
 	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
-	    khugepaged_enabled() &&
-	    (((vma->vm_start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK) <
-	     (vma->vm_end & HPAGE_PMD_MASK))) {
+	    khugepaged_enabled()) {
 		if (hugepage_vma_check(vma, vm_flags))
 			__khugepaged_enter(vma->vm_mm);
 	}
@@ -950,7 +948,6 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
 		struct vm_area_struct **vmap)
 {
 	struct vm_area_struct *vma;
-	unsigned long hstart, hend;
 
 	if (unlikely(khugepaged_test_exit(mm)))
 		return SCAN_ANY_PROCESS;
@@ -959,9 +956,7 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
 	if (!vma)
 		return SCAN_VMA_NULL;
 
-	hstart = (vma->vm_start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK;
-	hend = vma->vm_end & HPAGE_PMD_MASK;
-	if (address < hstart || address + HPAGE_PMD_SIZE > hend)
+	if (!transhuge_vma_suitable(vma, address))
 		return SCAN_ADDRESS_RANGE;
 	if (!hugepage_vma_check(vma, vma->vm_flags))
 		return SCAN_VMA_CHECK;
@@ -2147,10 +2142,8 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
 			progress++;
 			continue;
 		}
-		hstart = (vma->vm_start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK;
-		hend = vma->vm_end & HPAGE_PMD_MASK;
-		if (hstart >= hend)
-			goto skip;
+		hstart = round_up(vma->vm_start, HPAGE_PMD_SIZE);
+		hend = round_down(vma->vm_end, HPAGE_PMD_SIZE);
 		if (khugepaged_scan.address > hend)
 			goto skip;
 		if (khugepaged_scan.address < hstart)
-- 
2.26.3

