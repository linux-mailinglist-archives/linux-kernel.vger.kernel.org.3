Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F79C53F1D6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 23:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbiFFVoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 17:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbiFFVoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 17:44:30 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C172A91565
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 14:44:22 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id q18so13154041pln.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 14:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D/C1dubPl+rj/RbGuMLBKXaMg54FT3nuKqdm5O29Xsg=;
        b=YRS9DKv1jCdO/JdsfD2Zdx2c6vo3ureR7Qm46tf+wcDQKy1FeN7iCjcyusFTyim11S
         d0j0ZZpoAaKyN+IaCjtJMSz9RrTX8Q3XcRUCrbEwBT8IazrwYVwuLwUQZAPvljDjYQFO
         ldHcD5wfIiPmSXhaTPA9LHw9ZUhMTbUSlZ40NzcPhON+Pr3zxvPwDSODHzYSHcjjhK9g
         Z38Uhow01G4f8nz97ErvS2BY6kUS+gFldseEqN0iI1/pBd1K9x5LG5XvmW3+WTctCrdR
         mr/60PMYJyB7y+cU2eD3G2ZfqOZ9jzYJM4+mZZ6eRiqmevTRTU534YjwsFgh0MJpVknB
         Gprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D/C1dubPl+rj/RbGuMLBKXaMg54FT3nuKqdm5O29Xsg=;
        b=NednS/Ov/kzwePIfsn6B3O0oAc5WZ86JcoHl8UlWIwXwtYZ8cRimIhO+x3miz9XvqM
         fTSHkpYZLU8TOqAGdYZU3rB8ERjQDp1i6GBmYCblD0HOfQ+7hxO9f0BMFge9rVTP9B6G
         n8BWHUd900C+kB/a9cdSIfQgkX8pg3ANqHTm9hN08b07E7ypkxjmOkRRO2JGvR1Zgg+b
         YBKnQyauvZyrn+mtLlmAERTDd13RgKq/9dL2qhIZcqoozC6Ah/y3JxePncdzeIKGXC1e
         4L7Y5v2HuFsuEh+3Ri8fGR0Dha2dkwo+sOaYi6QCgukiOJ5Z8RmqwGZh2KOF1dEnyBvT
         M5fg==
X-Gm-Message-State: AOAM533S1M18EXizG4+9QVf+uj6TQAhvOUxu8yZZ6DFu55P5krZyCVSG
        aQLe/TQNXmLZadv0yMkIEzA=
X-Google-Smtp-Source: ABdhPJzikW8LtgDjXM0E0yc+iosNsTNVfvkgGIPBuUaO7oCFPC7sJOjOY3z/ay2XBf6L9aDLJBVqBA==
X-Received: by 2002:a17:90a:1f4c:b0:1e6:6f77:c573 with SMTP id y12-20020a17090a1f4c00b001e66f77c573mr30435048pjy.17.1654551862332;
        Mon, 06 Jun 2022 14:44:22 -0700 (PDT)
Received: from localhost.biz ([8.25.197.27])
        by smtp.gmail.com with ESMTPSA id a4-20020a170903100400b0016397da033csm10881675plb.62.2022.06.06.14.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 14:44:21 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        willy@infradead.org, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v3 PATCH 2/7] mm: thp: introduce transhuge_vma_size_ok() helper
Date:   Mon,  6 Jun 2022 14:44:09 -0700
Message-Id: <20220606214414.736109-3-shy828301@gmail.com>
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
index 48182c8fe151..36ada544e494 100644
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
index 84b9cf4b9be9..d0f8020164fc 100644
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
@@ -2142,10 +2143,9 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
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

