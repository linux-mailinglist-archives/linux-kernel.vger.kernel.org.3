Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0EF52F4DE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 23:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353628AbiETVQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 17:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353612AbiETVQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 17:16:16 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B9618378
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 14:16:15 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id u15so8688616pfi.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 14:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gg6tNe85KQQ/g3LzRoRENfwwXGulqQh5OTFWqrUU8No=;
        b=PgTK3glRRfd5JkX+9f6IiYFOmD9Z9dNofGK/OipD+mpgQCHsKjBPp/AQFjZRf0O3qR
         hKge+wGyWYzGvM+XyongdCHlTqQcHcJKsxqSNcz7crYk+saXUcgUuxTUw2w0bZuQj1N9
         Ajipf+rSlrmD0+qBqy5vme1F//nPQIIke6CoQSWdFlkX8NfeJlJqmN9bj5lDVLMt/kZx
         RJAn3mEOXG65s4VtYcaNT6jb+Kl6w42xRHQhZ2EpOng4nvcb026P/FE8v/RncZcKC9xv
         zV5b4U2kzG890iKByk0lsfUKoZgZ02xxnRFgP+WURkTaZdFSvAuz1kSFbiv7EZUYt79+
         auLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gg6tNe85KQQ/g3LzRoRENfwwXGulqQh5OTFWqrUU8No=;
        b=zvUXj/KOTgvYHVpl5nSGSzFG+TFuyz4nOKHTMr3CDSYkMZlENeb0qyBuTKXOh9TQVh
         WHPvIN6YRnxo/G8QYscqOd7plT9rttIHDXJ+X4I0dgsBlqTC9fjDr6DDeg6JGmG1TdNu
         HzdNvZoOR7eiblGZAwlU60/PU30krTQ5fZyTGj4L0Zu4V47TwDvE69mwaAJxdBDWsWH/
         1V+ftqlXe0bW+laWhzU752Z4BEOaxwiqBo0rYVbxr710+E99eX6c2TzRVmfpvbA5xIuN
         4oXblwi413W8S90aSP36wPYQXRc6t9pbS16rPpSC1yoTWpDjxeiPjqAUIrIO+p+nFzI3
         waqQ==
X-Gm-Message-State: AOAM531h7P8Q+KMGE5KOXgBkwBF1rmYL/qbtGmFHgnudaTrKUJU55V7s
        dPBeNugHolk2IiKHDH56oUo=
X-Google-Smtp-Source: ABdhPJzSPHAO+qKZMPiyyvZY1u0P5E9VsnEg+dfk2XO7c6Ka5FUtpo8JOyZCJt+tyv57RY71VKVndw==
X-Received: by 2002:a63:2002:0:b0:3c6:ae77:1869 with SMTP id g2-20020a632002000000b003c6ae771869mr9888206pgg.71.1653081375058;
        Fri, 20 May 2022 14:16:15 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id h1-20020a170902748100b0015e8d4eb2c2sm167620pll.268.2022.05.20.14.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 14:16:14 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] mm: thp: introduce transhuge_vma_size_ok() helper
Date:   Fri, 20 May 2022 14:16:00 -0700
Message-Id: <20220520211605.51473-3-shy828301@gmail.com>
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

There are couple of places that check whether the vma size is ok for
THP or not, they are open coded and duplicate, introduce
transhuge_vma_size_ok() helper to do the job.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 include/linux/huge_mm.h | 17 +++++++++++++++++
 mm/huge_memory.c        |  5 +----
 mm/khugepaged.c         | 12 ++++++------
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 648cb3ce7099..a8f61db47f2a 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -116,6 +116,18 @@ extern struct kobj_attribute shmem_enabled_attr;
 
 extern unsigned long transparent_hugepage_flags;
 
+/*
+ * The vma size has to be large enough to hold an aligned HPAGE_PMD_SIZE area.
+ */
+static inline bool transhuge_vma_size_ok(struct vm_area_struct *vma)
+{
+	if (round_up(vma->vm_start, HPAGE_PMD_SIZE) <
+	    (vma->vm_end & HPAGE_PMD_MASK))
+		return true;
+
+	return false;
+}
+
 static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
 		unsigned long addr)
 {
@@ -345,6 +357,11 @@ static inline bool transparent_hugepage_active(struct vm_area_struct *vma)
 	return false;
 }
 
+static inline bool transhuge_vma_size_ok(struct vm_area_struct *vma)
+{
+	return false;
+}
+
 static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
 		unsigned long addr)
 {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 80e8b58b4f39..d633f97452c1 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -71,10 +71,7 @@ unsigned long huge_zero_pfn __read_mostly = ~0UL;
 
 bool transparent_hugepage_active(struct vm_area_struct *vma)
 {
-	/* The addr is used to check if the vma size fits */
-	unsigned long addr = (vma->vm_end & HPAGE_PMD_MASK) - HPAGE_PMD_SIZE;
-
-	if (!transhuge_vma_suitable(vma, addr))
+	if (!transhuge_vma_size_ok(vma))
 		return false;
 	if (vma_is_anonymous(vma))
 		return __transparent_hugepage_enabled(vma);
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 92e91c08d96a..5bdb30a76f05 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -454,6 +454,9 @@ bool hugepage_vma_check(struct vm_area_struct *vma,
 				vma->vm_pgoff, HPAGE_PMD_NR))
 		return false;
 
+	if (!transhuge_vma_size_ok(vma))
+		return false;
+
 	/* Enabled via shmem mount options or sysfs settings. */
 	if (shmem_file(vma->vm_file))
 		return shmem_huge_enabled(vma);
@@ -512,9 +515,7 @@ void khugepaged_enter_vma(struct vm_area_struct *vma,
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
@@ -2144,10 +2145,9 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
 			progress++;
 			continue;
 		}
-		hstart = (vma->vm_start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK;
+
+		hstart = round_up(vma->vm_start, HPAGE_PMD_SIZE);
 		hend = vma->vm_end & HPAGE_PMD_MASK;
-		if (hstart >= hend)
-			goto skip;
 		if (khugepaged_scan.address > hend)
 			goto skip;
 		if (khugepaged_scan.address < hstart)
-- 
2.26.3

