Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC1249C373
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 07:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235036AbiAZGFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 01:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234569AbiAZGFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 01:05:20 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDF6C061748
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 22:05:20 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id c19so26335477qtx.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 22:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HOl6dnjRSlkzFWIwAEZQBaaOxfPRDLrxvpvmNPVil3I=;
        b=jwFuMnHWqoNk8uXeaYsGmMgbTXTo5euHb6/esSzRi8Hx0i9wGtS6JDG3u8LGq6AmU4
         eFdQHw+wFC2IAD7gAkutikIJJdEwF7jOdPz3HURvZDFMbhCd/ezSO9xcpJINsMjiXzM/
         ux3ThHF0mwzLaaRsxHG+POu362xUihatB6ZiznsjtQ4fvhmMxxbd8YAbcJLjLQXGr+jW
         KGJA/EIVl7kOjJRSIaFq3sieVyL0O4O64ErJ4CMN2OkScAJfguQeZMBZ0kmND05wNMNY
         hqv9KmXfIvyrrebEnHTN4PTse2Py7UlyFStajrNbvPv+9NnRYJab498z0qxxx6Ztv/bY
         Sltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HOl6dnjRSlkzFWIwAEZQBaaOxfPRDLrxvpvmNPVil3I=;
        b=McniQ7QGRGCreQwOOZ+35kc3DNb5u/vyCm2VUeJsre+R0yr9dorexnkNClRq+YQc/0
         KvEdRuwQnq8LF6NpOrQuOjkRQlchIfyeO7dvX2xw3HQE/XPtL4q/80awl8X05bAN9bAP
         dgQkLM3AL2WFh5MeG07XEW3083DL/0Rot6lJLJ5cQoFbplvNR74yLldgmRC5fJlRYoRo
         pIod7SPWcysYXUNP7b6ApBoGYN2QJ9J3x9rxD1uPJEmlKm0DcC42rZfUxyP8A8nsxH7p
         p/XLF4IHUVYRloDutZjxvqLoKafH3xlVodT/iHw7/urPlUFudRTBYpdB56Vi7nLJ7TPn
         WLYQ==
X-Gm-Message-State: AOAM530qfWiaLWWwJyflqYvgyxqejuSmHmRe+/uf9embAcbNnWhL/ep8
        jQkEK3W4p/eYEpFW9zxRvKFtHA==
X-Google-Smtp-Source: ABdhPJxawlYifreSuisEPDkI9IQt+vr1qpvjrerAOfVLQ1Jx0TsXCwSpoyobPIpCZnLAgMF70g7lVg==
X-Received: by 2002:ac8:5b01:: with SMTP id m1mr19121273qtw.360.1643177119921;
        Tue, 25 Jan 2022 22:05:19 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id o19sm9856699qta.40.2022.01.25.22.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 22:05:19 -0800 (PST)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, rientjes@google.com,
        pjt@google.com, weixugc@google.com, gthelen@google.com,
        mingo@redhat.com, will@kernel.org, rppt@kernel.org,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        aneesh.kumar@linux.ibm.com, jirislaby@kernel.org,
        songmuchun@bytedance.com, qydwhotmail@gmail.com, hughd@google.com,
        ziy@nvidia.com, anshuman.khandual@arm.com
Subject: [PATCH v3 3/4] mm/khugepaged: unify collapse pmd clear, flush and free
Date:   Wed, 26 Jan 2022 06:05:13 +0000
Message-Id: <20220126060514.1574935-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220126060514.1574935-1-pasha.tatashin@soleen.com>
References: <20220126060514.1574935-1-pasha.tatashin@soleen.com>
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
---
 mm/khugepaged.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 35f14d0a00a6..440112355ffe 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1416,6 +1416,17 @@ static int khugepaged_add_pte_mapped_thp(struct mm_struct *mm,
 	return 0;
 }
 
+static void collapse_and_free_pmd(struct mm_struct *mm, struct vm_area_struct *vma,
+				  unsigned long addr, pmd_t *pmdp)
+{
+	spinlock_t *ptl = pmd_lock(vma->vm_mm, pmdp);
+	pmd_t pmd = pmdp_collapse_flush(vma, addr, pmdp);
+
+	spin_unlock(ptl);
+	mm_dec_nr_ptes(mm);
+	pte_free(mm, pmd_pgtable(pmd));
+}
+
 /**
  * collapse_pte_mapped_thp - Try to collapse a pte-mapped THP for mm at
  * address haddr.
@@ -1433,7 +1444,7 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
 	struct vm_area_struct *vma = find_vma(mm, haddr);
 	struct page *hpage;
 	pte_t *start_pte, *pte;
-	pmd_t *pmd, _pmd;
+	pmd_t *pmd;
 	spinlock_t *ptl;
 	int count = 0;
 	int i;
@@ -1509,12 +1520,7 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
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
@@ -1552,7 +1558,7 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 	struct vm_area_struct *vma;
 	struct mm_struct *mm;
 	unsigned long addr;
-	pmd_t *pmd, _pmd;
+	pmd_t *pmd;
 
 	i_mmap_lock_write(mapping);
 	vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff, pgoff) {
@@ -1591,14 +1597,8 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
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

