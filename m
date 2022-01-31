Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C164A502D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 21:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379184AbiAaUdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 15:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiAaUc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 15:32:59 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B10C06173B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 12:32:59 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id e20so13979951qvu.7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 12:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=fF5QFjKZhDTZd5B31TRW94GY69vdDJby6v3gBBayCwY=;
        b=HMakM+xY1YLPhqv6PfRXrYF6lEKAz8ldAQlsUVG77GLVRPT4XgfUdXYBbDqjbHerrt
         xlAlPDccJTu54jM1IX3IhH9eY7bHfcLScHm8cpZdvEAtBUEe0OwdWTmm3OpsgrHQOxKc
         p9fJbv6S+USh2jyF9NwYK2PuMR4blz+hZQUSoTJxMiyTUL+opiBq+wcMSSz/d0GmBIHw
         F8lNPaRz+Uaj2G743xUJPbnHO5FCBhIIRR5PK9Mt7vGZv7uHbvALBbVPi2mD/ESWMX4Q
         9JSwCrXHiq/NqgjmRJ945HfsESAs/4CAd03ax9ZYClBPRTsNg5k7euUEIDikB6zCMR8T
         Za3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fF5QFjKZhDTZd5B31TRW94GY69vdDJby6v3gBBayCwY=;
        b=lC8yYzyc2gaGesqU0z1OtDY1z/sIacFuoWkxXBpIC48rFz5ugXjodDp7NKu4eaEq1C
         v+5m4JeqT4PdHoX7ZSIws/78+OO77Cz2Wg74eReoHvCSmGeZzBOzOrn/9bwpc3HV5StK
         gVU6JcmHupoLUI+Cqe8C2ixxOLn98xzqasxIitoBUPGW1MtTK1xwfDsBnMxNnGrNAwE1
         GWpIfa7OVqBswDJfbx7DYQ3UkcN0+X8e02UofKRURJjHGQCYEiMWQ9yb3n4phYo0uts7
         gWVlg5uL3/GBxartJJxZZj78hJJufVpCXl9Z/8FPgI5nCToTY7jQ/+42zrLJT51+6G2t
         oc9A==
X-Gm-Message-State: AOAM531hDO8qGXn4w0YlFwPNMZzkQuzUn3yyYthsY9dzD4MAL/Efv81D
        CN/Ab1TMtE4kF/h+Rgz2xzta6w==
X-Google-Smtp-Source: ABdhPJx9Y6qc+SG5iROabTkXGy2K2xhjBhgrJadrpqmMWIheHQtwTINxgKfqF3vSMeC0FLwOvq+rfw==
X-Received: by 2002:a05:6214:5014:: with SMTP id jo20mr19417458qvb.28.1643661178443;
        Mon, 31 Jan 2022 12:32:58 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id j14sm5349661qko.10.2022.01.31.12.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 12:32:57 -0800 (PST)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, rientjes@google.com,
        pjt@google.com, weixugc@google.com, gthelen@google.com,
        mingo@redhat.com, will@kernel.org, rppt@kernel.org,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        aneesh.kumar@linux.ibm.com, jirislaby@kernel.org,
        songmuchun@bytedance.com, qydwhotmail@gmail.com, hughd@google.com,
        ziy@nvidia.com, anshuman.khandual@arm.com
Subject: [PATCH v5 3/4] mm/khugepaged: unify collapse pmd clear, flush and free
Date:   Mon, 31 Jan 2022 20:32:48 +0000
Message-Id: <20220131203249.2832273-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
In-Reply-To: <20220131203249.2832273-1-pasha.tatashin@soleen.com>
References: <20220131203249.2832273-1-pasha.tatashin@soleen.com>
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
2.35.0.rc2.247.g8bbb082509-goog

