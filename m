Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54BD53BE03
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 20:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238174AbiFBSWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 14:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238117AbiFBSWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 14:22:15 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5499D109
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 11:22:14 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id h1so5146736plf.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 11:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hSlU6Lbj1xiMbj9OJuSwVIYBVljgpyUnPXL4SbncscE=;
        b=lGZfQS2dawbRWYfKai5mohgnC6yt8NU/fBuHreLbnhxS97F65F2IH6yIfmwsgNBetc
         uFdybSvcBfa+1M9DRHLj17ljNMUCHlZ6Xk7AG7WWycs4dAoYD5s/K4rdpgBIL3UCUB9G
         HH4CoA17dtS6p+Vd8cfKk30Eu9iclYqbz1S0R41UohcGIvBsQi5lMbCZQmpA8hdUW5IG
         aVQoazoRZZpG8c1P2qx8COdlJb8mN/ADUEM21hHpay14hLGhve2iRFQO0hr5NggEsvut
         /PF6h+6XgH8ZsPuvCKZvUvacDbVy4LqiyBF5x7hoX0X4zq2qaCroPWD88S79nZKNrc9O
         ujWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hSlU6Lbj1xiMbj9OJuSwVIYBVljgpyUnPXL4SbncscE=;
        b=JXxL62aD5GGbOXAi+/BC+Vpdtg00UW+MGWzkjbOf697Kps3c9GaSNOuLzl1cP6ptcW
         k2B6RvgFQ9+Thvz/GbapEKGYLBFY/Gbz/QAX9JPe9tr29ralskT0F20Xm3zSAUVHs5UL
         7NAKHBD1eKijwqoS6B+MY3+3URtZtZTzwkjw8XkecpElyIaTAtfRVuC07s9ifOQqMKbL
         mdyZROG109aHaaG9B2vvCRWUIBBHtjVR0yeAIx/Kimfb+vPt+YVfSRnLD+mxT7EN5qSC
         1ZRTifWhC/cvb96IOqBZhfxXq+8MYfu7zcP/VG0kFPWCk6k6TguyystrDOBnCY+CZesq
         UwVQ==
X-Gm-Message-State: AOAM532nVDqtuQ771Rkb0KGSkAtKFiTW79VCrkOCJfQ8wiXyFw9FkHAT
        9t9gJYDVvMSqPFSkApjblxszD1Csbos=
X-Google-Smtp-Source: ABdhPJxLT/aEEZENsrdalshxpkuYcAThzVkBKsWYUCQpfppCvGax4dxmv0zOoGgMtYqcV1ArZ2nVxA==
X-Received: by 2002:a17:90b:4d0a:b0:1e2:c0b4:8bb8 with SMTP id mw10-20020a17090b4d0a00b001e2c0b48bb8mr6724889pjb.94.1654194134287;
        Thu, 02 Jun 2022 11:22:14 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id t10-20020a1709027fca00b0015f2d549b46sm3866779plb.237.2022.06.02.11.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 11:22:13 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v2 PATCH 7/7] mm: khugepaged: reorg some khugepaged helpers
Date:   Thu,  2 Jun 2022 11:21:59 -0700
Message-Id: <20220602182159.248387-8-shy828301@gmail.com>
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

The khugepaged_{enabled|always|req_madv} are not khugepaged only
anymore, move them to huge_mm.h and rename to hugepage_flags_xxx, and
remove khugepaged_req_madv due to no users.

Also move khugepaged_defrag to khugepaged.c since its only caller is in
that file, it doesn't have to be in a header file.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 include/linux/huge_mm.h    |  8 ++++++++
 include/linux/khugepaged.h | 17 +----------------
 mm/huge_memory.c           |  4 ++--
 mm/khugepaged.c            | 18 +++++++++++-------
 4 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index bbbaf3eba30a..452eaef24948 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -116,6 +116,14 @@ extern struct kobj_attribute shmem_enabled_attr;
 
 extern unsigned long transparent_hugepage_flags;
 
+#define hugepage_flags_enabled()					       \
+	(transparent_hugepage_flags &				       \
+	 ((1<<TRANSPARENT_HUGEPAGE_FLAG) |		       \
+	  (1<<TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG)))
+#define hugepage_flags_always()				\
+	(transparent_hugepage_flags &			\
+	 (1<<TRANSPARENT_HUGEPAGE_FLAG))
+
 /*
  * The vma size has to be large enough to hold an aligned HPAGE_PMD_SIZE area.
  */
diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
index e047be601268..9c3b56132eba 100644
--- a/include/linux/khugepaged.h
+++ b/include/linux/khugepaged.h
@@ -24,20 +24,6 @@ static inline void collapse_pte_mapped_thp(struct mm_struct *mm,
 }
 #endif
 
-#define khugepaged_enabled()					       \
-	(transparent_hugepage_flags &				       \
-	 ((1<<TRANSPARENT_HUGEPAGE_FLAG) |		       \
-	  (1<<TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG)))
-#define khugepaged_always()				\
-	(transparent_hugepage_flags &			\
-	 (1<<TRANSPARENT_HUGEPAGE_FLAG))
-#define khugepaged_req_madv()					\
-	(transparent_hugepage_flags &				\
-	 (1<<TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG))
-#define khugepaged_defrag()					\
-	(transparent_hugepage_flags &				\
-	 (1<<TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG))
-
 static inline void khugepaged_fork(struct mm_struct *mm, struct mm_struct *oldmm)
 {
 	if (test_bit(MMF_VM_HUGEPAGE, &oldmm->flags))
@@ -53,8 +39,7 @@ static inline void khugepaged_exit(struct mm_struct *mm)
 static inline void khugepaged_enter(struct vm_area_struct *vma,
 				   unsigned long vm_flags)
 {
-	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
-	    khugepaged_enabled()) {
+	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags)) {
 		if (hugepage_vma_check(vma, vm_flags, false, false))
 			__khugepaged_enter(vma->vm_mm);
 	}
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b95786ada466..866b98a39496 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -102,11 +102,11 @@ bool hugepage_vma_check(struct vm_area_struct *vma,
 	if (!in_pf && shmem_file(vma->vm_file))
 		return shmem_huge_enabled(vma);
 
-	if (!khugepaged_enabled())
+	if (!hugepage_flags_enabled())
 		return false;
 
 	/* THP settings require madvise. */
-	if (!(vm_flags & VM_HUGEPAGE) && !khugepaged_always())
+	if (!(vm_flags & VM_HUGEPAGE) && !hugepage_flags_always())
 		return false;
 
 	/* Only regular file is valid */
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index ab6183c5489f..2523c085625a 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -472,7 +472,7 @@ void khugepaged_enter_vma(struct vm_area_struct *vma,
 			  unsigned long vm_flags)
 {
 	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
-	    khugepaged_enabled()) {
+	    hugepage_flags_enabled()) {
 		if (hugepage_vma_check(vma, vm_flags, false, false))
 			__khugepaged_enter(vma->vm_mm);
 	}
@@ -763,6 +763,10 @@ static bool khugepaged_scan_abort(int nid)
 	return false;
 }
 
+#define khugepaged_defrag()					\
+	(transparent_hugepage_flags &				\
+	 (1<<TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG))
+
 /* Defrag for khugepaged will enter direct reclaim/compaction if necessary */
 static inline gfp_t alloc_hugepage_khugepaged_gfpmask(void)
 {
@@ -860,7 +864,7 @@ static struct page *khugepaged_alloc_hugepage(bool *wait)
 			khugepaged_alloc_sleep();
 		} else
 			count_vm_event(THP_COLLAPSE_ALLOC);
-	} while (unlikely(!hpage) && likely(khugepaged_enabled()));
+	} while (unlikely(!hpage) && likely(hugepage_flags_enabled()));
 
 	return hpage;
 }
@@ -2173,7 +2177,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
 static int khugepaged_has_work(void)
 {
 	return !list_empty(&khugepaged_scan.mm_head) &&
-		khugepaged_enabled();
+		hugepage_flags_enabled();
 }
 
 static int khugepaged_wait_event(void)
@@ -2238,7 +2242,7 @@ static void khugepaged_wait_work(void)
 		return;
 	}
 
-	if (khugepaged_enabled())
+	if (hugepage_flags_enabled())
 		wait_event_freezable(khugepaged_wait, khugepaged_wait_event());
 }
 
@@ -2269,7 +2273,7 @@ static void set_recommended_min_free_kbytes(void)
 	int nr_zones = 0;
 	unsigned long recommended_min;
 
-	if (!khugepaged_enabled()) {
+	if (!hugepage_flags_enabled()) {
 		calculate_min_free_kbytes();
 		goto update_wmarks;
 	}
@@ -2319,7 +2323,7 @@ int start_stop_khugepaged(void)
 	int err = 0;
 
 	mutex_lock(&khugepaged_mutex);
-	if (khugepaged_enabled()) {
+	if (hugepage_flags_enabled()) {
 		if (!khugepaged_thread)
 			khugepaged_thread = kthread_run(khugepaged, NULL,
 							"khugepaged");
@@ -2345,7 +2349,7 @@ int start_stop_khugepaged(void)
 void khugepaged_min_free_kbytes_update(void)
 {
 	mutex_lock(&khugepaged_mutex);
-	if (khugepaged_enabled() && khugepaged_thread)
+	if (hugepage_flags_enabled() && khugepaged_thread)
 		set_recommended_min_free_kbytes();
 	mutex_unlock(&khugepaged_mutex);
 }
-- 
2.26.3

