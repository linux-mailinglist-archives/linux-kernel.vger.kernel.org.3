Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE1049D1D8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 19:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244232AbiAZSgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 13:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244198AbiAZSgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 13:36:43 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24987C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 10:36:43 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id o25so386187qkj.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 10:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=a93X1YuUUYjeQ1DmHZzgEs8n16C54TBZM8wi1s2vhvo=;
        b=N1Vt6B9Sta1FwZczZQvEpySLcRnZhDydeiS6pntiC+WThA+3ZreI3+60RQfO5kdCVX
         PYbT9ygJ+RpShOQSUmBUF4LeD0OMOmi4BVXaeieVPEDI7qjBopBvxedBObpiCvVEXM19
         vIaReulPyOxwwY/oUq54wlge34q8x/ppQVF/brbp0pf/bFE+mP23rJDsUoy6LY1nNdvs
         h56xvgdY/V+epLYxhiPz25bNyIF3I1Jo2UFm/dTmOhdMEIvwyXt9q4boHCTlKTfyDPb/
         FQBTIf+mHIo+LKv2ZXUV+XiQw9lfKjQr1nPDLZz4qcagM/2eqA8M54EazwRtE/p3p7qW
         J1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a93X1YuUUYjeQ1DmHZzgEs8n16C54TBZM8wi1s2vhvo=;
        b=V4j3QF/XX8ysvtEFg+Z07+M4VBYTKG70dFIpx7ywzOWNX4z1X41vdFGpTNcj+TeotV
         BBLy95pupxCgRH5agtejog0wU/4iO39KuLGnJS70T//dHjfi788fKHSp47vNyi181vqm
         JyAcnhCpHkC35p9BXWjbfiARygrBaF+5whhzvQKHDoBh4YnPVoYGKi6p7ldKGLHpsOFJ
         V92DWrAtLyeOsElQ143/iv9YsN9CM5ygLuP+SIbd7xCXIEgYXQ2XvSJh3N6ZI7yGHKUc
         CpzOLDsnYh+hEUJOm9smMs9U5ecl2aaJO4gBejIVMJ71yeSwImC9zyEezGi1l5ok1HLv
         c+GQ==
X-Gm-Message-State: AOAM532+2IClRjknEljjMYUqne+E+YXBtsERVbUgeHTkKN7l5phOcxe2
        r9i5KyskqWxWQRIqP4DdXzsvgA==
X-Google-Smtp-Source: ABdhPJw0PTloyF5Qbm9D+I2W7WmpXBIhuugeFvsdlL3/szCTDEds6C8kR7dEnSFl+43JC4D5IJPKGg==
X-Received: by 2002:a05:620a:31a3:: with SMTP id bi35mr100511qkb.198.1643222202238;
        Wed, 26 Jan 2022 10:36:42 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id h9sm26226qkp.75.2022.01.26.10.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 10:36:41 -0800 (PST)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, rientjes@google.com,
        pjt@google.com, weixugc@google.com, gthelen@google.com,
        mingo@redhat.com, will@kernel.org, rppt@kernel.org,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        aneesh.kumar@linux.ibm.com, jirislaby@kernel.org,
        songmuchun@bytedance.com, qydwhotmail@gmail.com, hughd@google.com,
        ziy@nvidia.com, anshuman.khandual@arm.com
Subject: [PATCH v4 3/4] mm/khugepaged: unify collapse pmd clear, flush and free
Date:   Wed, 26 Jan 2022 18:36:36 +0000
Message-Id: <20220126183637.1840960-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220126183637.1840960-1-pasha.tatashin@soleen.com>
References: <20220126183637.1840960-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unify the code that flushes, clears pmd entry, and frees the PTE table
level into a new function collapse_and_free_pmd().

This clean-up is useful as in the next patch we will add another call to
this function to iterate through PTE prior to freeing the level for page
table check.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Acked-by: David Rientjes <rientjes@google.com>
---
 mm/khugepaged.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 35f14d0a00a6..30e59e4af272 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1416,6 +1416,19 @@ static int khugepaged_add_pte_mapped_thp(struct mm_struct *mm,
 	return 0;
 }
 
+static void collapse_and_free_pmd(struct mm_struct *mm, struct vm_area_struct *vma,
+				  unsigned long addr, pmd_t *pmdp)
+{
+	spinlock_t *ptl;
+	pmd_t pmd;
+
+	ptl = pmd_lock(vma->vm_mm, pmdp);
+	pmd = pmdp_collapse_flush(vma, addr, pmdp);
+	spin_unlock(ptl);
+	mm_dec_nr_ptes(mm);
+	pte_free(mm, pmd_pgtable(pmd));
+}
+
 /**
  * collapse_pte_mapped_thp - Try to collapse a pte-mapped THP for mm at
  * address haddr.
@@ -1433,7 +1446,7 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
 	struct vm_area_struct *vma = find_vma(mm, haddr);
 	struct page *hpage;
 	pte_t *start_pte, *pte;
-	pmd_t *pmd, _pmd;
+	pmd_t *pmd;
 	spinlock_t *ptl;
 	int count = 0;
 	int i;
@@ -1509,12 +1522,7 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
 	}
 
 	/* step 4: collapse pmd */
-	ptl = pmd_lock(vma->vm_mm, pmd);
-	_pmd = pmdp_collapse_flush(vma, haddr, pmd);
-	spin_unlock(ptl);
-	mm_dec_nr_ptes(mm);
-	pte_free(mm, pmd_pgtable(_pmd));
-
+	collapse_and_free_pmd(mm, vma, haddr, pmd);
 drop_hpage:
 	unlock_page(hpage);
 	put_page(hpage);
@@ -1552,7 +1560,7 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 	struct vm_area_struct *vma;
 	struct mm_struct *mm;
 	unsigned long addr;
-	pmd_t *pmd, _pmd;
+	pmd_t *pmd;
 
 	i_mmap_lock_write(mapping);
 	vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff, pgoff) {
@@ -1591,14 +1599,8 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 		 * reverse order. Trylock is a way to avoid deadlock.
 		 */
 		if (mmap_write_trylock(mm)) {
-			if (!khugepaged_test_exit(mm)) {
-				spinlock_t *ptl = pmd_lock(mm, pmd);
-				/* assume page table is clear */
-				_pmd = pmdp_collapse_flush(vma, addr, pmd);
-				spin_unlock(ptl);
-				mm_dec_nr_ptes(mm);
-				pte_free(mm, pmd_pgtable(_pmd));
-			}
+			if (!khugepaged_test_exit(mm))
+				collapse_and_free_pmd(mm, vma, addr, pmd);
 			mmap_write_unlock(mm);
 		} else {
 			/* Try again later */
-- 
2.35.0.rc0.227.g00780c9af4-goog

