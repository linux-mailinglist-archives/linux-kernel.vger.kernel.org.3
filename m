Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6AB853F1D9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 23:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235200AbiFFVo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 17:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbiFFVob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 17:44:31 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801E57A817
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 14:44:30 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id u18so13200793plb.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 14:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yPXZCZEMUQaqYwKbEzwy4HUgqvcP6p/dfhKRtiPq7Hw=;
        b=JhXbAthDaDChPe0CIE4lyCWV2sCMXUskpdnFfr0MSsPjrEj6BkRL0mh0lH3+QrxtSK
         EenH1GV5UxsPW8wRBeB676I26nUwYNyy94grGsy5diUQYVvPnd44oNlg7fZdm7x4uOG6
         GIb46aOwj5teb0/tSJ0XYsOqw+loQfIs6+8RldDC9kP/ogs6bRtwqDrtRVN3G2f8jzIL
         oJbi95NWG0ZA1uTgB5GJxIstWMhDTTzkDHR1Mi7qJ9MVQGLULQyLixJbiyhWH630r56+
         zV+o2dt6Pr/AV5Sh+k3eIMVFA4SjiiZros8bZtNrYeNBlcZ/VwZEx/OIXCs/JU61QD7p
         FzKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yPXZCZEMUQaqYwKbEzwy4HUgqvcP6p/dfhKRtiPq7Hw=;
        b=7iSNjM/uR+bCV+6Cyv08gQPZZShRDMeBFiWHVrrrhZkWDgv4CaN1AgoC9XLV6QpHaX
         OiV65rK4Jp+gyGGuVSH/6FYYgrRHvaqHnrA4vrIKhBJuxOqXAvF6pjTMFstlB0pJjSKx
         GNmYvZTt2xAz4mPs7ZAA0HdR5OPhD9zyRNyiw8w28HRB2A+Kavc1Afc7JBvNg2xWII4q
         HJyCa1Lo5+vPN6yOJO6xdlEaBQsJbUiIep5nDgMQaIZiDtwIEXCvNh25W83N/1UQoAaz
         QlwE6EClg48lT4YtBqrnSwrWrptJz7u/cfC8aNIwWj6M0bwploAJoxd3LGDSAaS30x8f
         7Qww==
X-Gm-Message-State: AOAM532xs1nIWGzIGOSf9dw4WjdlWufhEiWPqNp+sZ1XfaX82Rk6B8gc
        t39PM4K2CUN5UeJcPkNu+eA=
X-Google-Smtp-Source: ABdhPJyDZQtvOLvDSpVY2YEfud++1wRn/OaNDsUtVpZmzEHtUgNOTteY+F+x1j6onYQEtMIS01ebLQ==
X-Received: by 2002:a17:902:c2c1:b0:161:c6af:278e with SMTP id c1-20020a170902c2c100b00161c6af278emr26163480pla.151.1654551870055;
        Mon, 06 Jun 2022 14:44:30 -0700 (PDT)
Received: from localhost.biz ([8.25.197.27])
        by smtp.gmail.com with ESMTPSA id a4-20020a170903100400b0016397da033csm10881675plb.62.2022.06.06.14.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 14:44:29 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        willy@infradead.org, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v3 PATCH 7/7] mm: khugepaged: reorg some khugepaged helpers
Date:   Mon,  6 Jun 2022 14:44:14 -0700
Message-Id: <20220606214414.736109-8-shy828301@gmail.com>
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
index d478e8875023..ce2d05ee4816 100644
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

