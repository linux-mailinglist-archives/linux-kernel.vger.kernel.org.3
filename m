Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9675C53BE08
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 20:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238109AbiFBSWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 14:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237434AbiFBSWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 14:22:07 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6227271F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 11:22:06 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id v5-20020a17090a7c0500b001df84fa82f8so5480200pjf.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 11:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D/C1dubPl+rj/RbGuMLBKXaMg54FT3nuKqdm5O29Xsg=;
        b=FRrND4uki4knPZ0gSWutNMQKlOfS5LJi4uIMfHYUiv+1a8lr0Xem3mWuTw7DfDlSY3
         9tRImdO5zSIr4nPyQ8HcKICzyQCFdpFFWdXtHalaE6GGfEw4F98wdnuF73lw2uk6p0xH
         nr9CoqMB8CGi9J52LmD84U6h8P08cVzicro/KUR77FT60PiVBDVCTuWBX4zI70ktKx+N
         R6wDi3C47n7AWxDnJ1DtU604BHF7nH8hFZsXeJ9ieLzroSjoD+x/6sG7zHK5ArGZulnD
         axyJD0uVhxDY1agFrwfOHh8N38BgADp3plNxnDatVLAmFHHdJ0no0cbEE1Sw7JXJcci9
         Ap/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D/C1dubPl+rj/RbGuMLBKXaMg54FT3nuKqdm5O29Xsg=;
        b=xN5zo0EItYTQIan3nu1We8A1hB81nHJk+5YkEvujxzfhU3xxx6iAi6TmIGRoYcpL5K
         Tr7HBmOiS9eeIgN/rgr+4X5bY7sXz+UHM1piqdyJqHZdJPqgvZz8F8yWEEYHoaSN0Wyy
         jF7mppXSR2/K7yj2EpdBU2+h0TKgNUY5vym6dA9sttSOkUQCS1IQ/9dqh/0ExYLlg/Rb
         bG0SOQAU6rPl2N9wi1z/VDxA+aFDVSvV60NoNkF69YOoIQ2bvxAFfuGH3uxYxQ9yQLrp
         qSQQ2s1pyZm+hirZZ9M11Jx0UzhDndjbrS7fhcCa/Ny0rTCufrfHnz5KDiwLM2/vrUDi
         7kUw==
X-Gm-Message-State: AOAM532+5HV+AusQxpNUrODV0ZuCND4XpHHHqBlIZoXSR0uM0ZwFLXfZ
        6KllHYUOOtb/nmNmhOzYSIg=
X-Google-Smtp-Source: ABdhPJzy/X13hVsWfZKyg71A7q6Qroq+HiX2lAOxkS2DH/C0df1y1IyvvBp0ImlM7TMfCrMNVybNWw==
X-Received: by 2002:a17:902:7597:b0:15e:b5d3:267d with SMTP id j23-20020a170902759700b0015eb5d3267dmr6206049pll.55.1654194126432;
        Thu, 02 Jun 2022 11:22:06 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id t10-20020a1709027fca00b0015f2d549b46sm3866779plb.237.2022.06.02.11.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 11:22:05 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v2 PATCH 2/7] mm: thp: introduce transhuge_vma_size_ok() helper
Date:   Thu,  2 Jun 2022 11:21:54 -0700
Message-Id: <20220602182159.248387-3-shy828301@gmail.com>
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

