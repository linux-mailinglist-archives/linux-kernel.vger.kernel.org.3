Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D6852F4E2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 23:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353652AbiETVQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 17:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353650AbiETVQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 17:16:27 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4931B79D
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 14:16:24 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id fw21-20020a17090b129500b001df9f62edd6so7111856pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 14:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j4XmJAWPYD2D8xrDs4B9doFxdeAqtS3ydjsiwVqFNQE=;
        b=Ptl/vJ+4tr0wo8YH9eqwLAvaSJxi7Oycnq92HxfoZk+QdfTfA9ENKktv7+IZjg4dQA
         Tnji/iUJmJpcFvSWDbCv4VN85SuKnLwbT0huZV6bIyCoRD/7bhs0irQMtF8Lnc7ZY5Q7
         wOe9j+hlD+5P7UxV/dOtjIyR381ynQL1SqKIiUsdjoTXtM7kP+Wyw+cZdIglDsx1pDeK
         9+HigMz9haP+HCDkKNneVDaB0D2N0tyMbU+HA5dEbgRdmoCqplw1qxf0V8I6+wunGFDl
         5lfbF7srBIkNk8zjstYMnHqPez+C1RfCdxiUC3Izu8Owg3I4cjReT4lCRDb/or6V4+zu
         +/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j4XmJAWPYD2D8xrDs4B9doFxdeAqtS3ydjsiwVqFNQE=;
        b=y1kL9eaAId/aNNp1fAKHhd/8ecSDnWt/hDG6gg3PL477CXmEO+eDTQsy6qejxiLR5H
         EFiQ6FqziMxaLRMUHycwGBktAFG/AfRs690kxiCpjX025QODmKNBYc2Nbmh8ZiuadTe2
         HQ3P+fGx6CX9WtAKn0oL84KJ+p/pghEbJZekjYTVtzBkRD6vIhMZ41ONNTdVkC9vxLIL
         JvhDP22gjLiCMT5o8822x9vlGbY281Vj7YN0l7GEs4FOfD7Qt9cG7tjrdMAvr0W6An7q
         v/W+2U9nKheYjyeTpsC6di2J3kR5fIkj54SWj7autB1/qMbiiKfZC3cIIb0EluINGnwg
         hlXg==
X-Gm-Message-State: AOAM530Inkys0K4TQQDDOgQL/t7+nMMgx2HJ7yY0V0Rc4aXGHHYaMus5
        e3jH8GDSI3sfy15NHKjUZ3U=
X-Google-Smtp-Source: ABdhPJy9LubXKnw2CwDr67vvJdDrVydqGO6/z63N55tXZRS8KRReOt/HeiFZIFFyfXfdOhEcnhSYdQ==
X-Received: by 2002:a17:902:f551:b0:15e:999a:2425 with SMTP id h17-20020a170902f55100b0015e999a2425mr11172213plf.3.1653081383403;
        Fri, 20 May 2022 14:16:23 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id h1-20020a170902748100b0015e8d4eb2c2sm167620pll.268.2022.05.20.14.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 14:16:22 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] mm: khugepaged: reorg some khugepaged helpers
Date:   Fri, 20 May 2022 14:16:05 -0700
Message-Id: <20220520211605.51473-8-shy828301@gmail.com>
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
index 67c913e66e60..e6f89d8ad5f8 100644
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
index 8a6452e089ca..ca54e5c42ed0 100644
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
 		if (hugepage_vma_check(vma, vm_flags, false))
 			__khugepaged_enter(vma->vm_mm);
 	}
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b4cab3aa2534..f4d7b6378b83 100644
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
index 292ed9c0db1e..37ea5a5396cd 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -472,7 +472,7 @@ void khugepaged_enter_vma(struct vm_area_struct *vma,
 			  unsigned long vm_flags)
 {
 	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
-	    khugepaged_enabled()) {
+	    hugepage_flags_enabled()) {
 		if (hugepage_vma_check(vma, vm_flags, false))
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
@@ -2175,7 +2179,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
 static int khugepaged_has_work(void)
 {
 	return !list_empty(&khugepaged_scan.mm_head) &&
-		khugepaged_enabled();
+		hugepage_flags_enabled();
 }
 
 static int khugepaged_wait_event(void)
@@ -2240,7 +2244,7 @@ static void khugepaged_wait_work(void)
 		return;
 	}
 
-	if (khugepaged_enabled())
+	if (hugepage_flags_enabled())
 		wait_event_freezable(khugepaged_wait, khugepaged_wait_event());
 }
 
@@ -2271,7 +2275,7 @@ static void set_recommended_min_free_kbytes(void)
 	int nr_zones = 0;
 	unsigned long recommended_min;
 
-	if (!khugepaged_enabled()) {
+	if (!hugepage_flags_enabled()) {
 		calculate_min_free_kbytes();
 		goto update_wmarks;
 	}
@@ -2321,7 +2325,7 @@ int start_stop_khugepaged(void)
 	int err = 0;
 
 	mutex_lock(&khugepaged_mutex);
-	if (khugepaged_enabled()) {
+	if (hugepage_flags_enabled()) {
 		if (!khugepaged_thread)
 			khugepaged_thread = kthread_run(khugepaged, NULL,
 							"khugepaged");
@@ -2347,7 +2351,7 @@ int start_stop_khugepaged(void)
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

