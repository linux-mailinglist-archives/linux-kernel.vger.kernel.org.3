Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA5054CFE4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357517AbiFORaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356183AbiFOR35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:29:57 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05EB49F34
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:29:42 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id t3-20020a17090a510300b001ea87ef9a3dso2671389pjh.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BxodM/enWfpl7ZA6N5naFXFtK7edc51Vh1QDre/mU/Q=;
        b=mkhCdkIJNqb0v6VU4lByixweHMSmazQOcfv8y2ewFiVeKtD8M+w7to2fu1BHM9jFdW
         FnkzXfY6+FrSC06EzCmia1Hfqwj1UVUHQBir/i6VaPcvgTdyxFi/D0bk0ChP45wRaEP7
         i0x+6MMSNGr6PWLhRBI/MFVrSihpDL13tYcEA5WFGBI73Ue+rR1ygElAlQtRw2JOk8mv
         lrCeuu2Rhb9PYkgS4A0u3VW2Sok5anSb27z8+p8NuL0bW/OEUtFQkKXGTRPY9nAjsuWR
         BU1bLwPC0owvKLfTqg4S7y1AcndfGkSb6Q6aDEtdQYxtLn1MEzxy/KNL8S+tIYR50lXG
         VKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BxodM/enWfpl7ZA6N5naFXFtK7edc51Vh1QDre/mU/Q=;
        b=V+AJ5tad1VOlxso26twWxFKz4l2NMR1sOQtqbtinu2c9oMdDlAebhaDEsrup5WfCk9
         sNgukMxw5VDl9UWubLgSusOqD/V+mdqnBYMDCtQaN04v/qk1LLMyKkL9wzVJNy1UsRUv
         yfe/C9D1maOxZEcGoUCqdUbsncFkVofaSQzBaREYMAAHWDkmwt7MuVfJeV0qvlK2bkrl
         0B0NKkjznl42UUNoGeVf+WVFguohoZ/ebASKJNdvYXw4yPT+4glKq2as7ZaF1ww+voky
         p64w/3ndRs6+ZkjqphEqH4MJUNnV1TT93HDBMwc5pClOcAVgLig86e70jkOe/+MbCNWF
         cw1A==
X-Gm-Message-State: AJIora+teTOnQSs/B7n49D+ahipkL3riWaIfBeBxABrfylfsCRDhsk9b
        8k8jkT0fxPmcOwFC89Fgfcw=
X-Google-Smtp-Source: AGRyM1txU2kmgua+NX3rp4duO3aRrjlN4ZOjkSUAr8RCRc2/lLC+ogmCrebuBsavl/ElraFx4uynEA==
X-Received: by 2002:a17:903:186:b0:167:6d8c:68c4 with SMTP id z6-20020a170903018600b001676d8c68c4mr789311plg.91.1655314182347;
        Wed, 15 Jun 2022 10:29:42 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id w14-20020a1709029a8e00b001676f87473fsm9552244plp.302.2022.06.15.10.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 10:29:41 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        willy@infradead.org, zokeefe@google.com, linmiaohe@huawei.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v4 PATCH 6/7] mm: khugepaged: reorg some khugepaged helpers
Date:   Wed, 15 Jun 2022 10:29:25 -0700
Message-Id: <20220615172926.546974-7-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220615172926.546974-1-shy828301@gmail.com>
References: <20220615172926.546974-1-shy828301@gmail.com>
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
 include/linux/khugepaged.h | 14 --------------
 mm/huge_memory.c           |  4 ++--
 mm/khugepaged.c            | 18 +++++++++++-------
 4 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 9d97d7ee6234..4cf546af7d97 100644
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
  * Do the below checks:
  *   - For file vma, check if the linear page offset of vma is
diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
index ea5fd4c398f7..384f034ae947 100644
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
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d0c37d99917b..0f2cce2d7041 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -117,11 +117,11 @@ bool hugepage_vma_check(struct vm_area_struct *vma,
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
index 2a676f37c921..d8ebb60aae36 100644
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
@@ -2186,7 +2190,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
 static int khugepaged_has_work(void)
 {
 	return !list_empty(&khugepaged_scan.mm_head) &&
-		khugepaged_enabled();
+		hugepage_flags_enabled();
 }
 
 static int khugepaged_wait_event(void)
@@ -2251,7 +2255,7 @@ static void khugepaged_wait_work(void)
 		return;
 	}
 
-	if (khugepaged_enabled())
+	if (hugepage_flags_enabled())
 		wait_event_freezable(khugepaged_wait, khugepaged_wait_event());
 }
 
@@ -2282,7 +2286,7 @@ static void set_recommended_min_free_kbytes(void)
 	int nr_zones = 0;
 	unsigned long recommended_min;
 
-	if (!khugepaged_enabled()) {
+	if (!hugepage_flags_enabled()) {
 		calculate_min_free_kbytes();
 		goto update_wmarks;
 	}
@@ -2332,7 +2336,7 @@ int start_stop_khugepaged(void)
 	int err = 0;
 
 	mutex_lock(&khugepaged_mutex);
-	if (khugepaged_enabled()) {
+	if (hugepage_flags_enabled()) {
 		if (!khugepaged_thread)
 			khugepaged_thread = kthread_run(khugepaged, NULL,
 							"khugepaged");
@@ -2358,7 +2362,7 @@ int start_stop_khugepaged(void)
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

