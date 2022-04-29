Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81A3514AAF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 15:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359809AbiD2Nl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 09:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376280AbiD2NlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 09:41:02 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18DACB007
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 06:37:43 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id p8so6935831pfh.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 06:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O5cSbfL+Kws2WK1XWtshx/2qRi6Wn3xrF3ZBZvoPEF4=;
        b=k82gmWwUxLeytVIW73YEj81XzJTEAi/VIKgG1khPQ5s9ntJrhtKUiHv2z65IM6x1pP
         cHyGFHCju/c6KUsgM1fEQ0gtlsNMOaUvhzKlUmUgO8zN6rDeRYSGJyNAofMSN3w21Nek
         gSVYkIKFvK/gSV3nvq9ZsEQmDBGd8P7fkTMiDlBwEy6tOiIFycE6VmPf+oth9zRFTpRq
         xQmyrVyejNKrcVf5wn9fIwvLO8i/YUdZETKNoql2OyZvMa0w5HO+dTEIc3OZxueEv5n+
         C3QqYodUydvPO2/5EMdhE3bSPnrK80wuPiHAcYuSAuhfVECNh/kNOJxshL9h1CVpnKlE
         HNhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O5cSbfL+Kws2WK1XWtshx/2qRi6Wn3xrF3ZBZvoPEF4=;
        b=QaxuSJkCrlGeHEvPEoxEC1LulPdn5n/rBrKuX6F1plsbY+6ji2ZuwAmJR3KVrZBsEw
         4JC2XrYF+y62D+IU9RPyCfbi7cRj2U7NgfNPxiVIzxSpKYaR36P0+QFrgQAQyezcx7JI
         FF5MurWNIr9XBb+egOqqwM3tq05btnXpKnmtYBkI5y1V7gmUscCcCRhT/ZVYTZCVV47u
         OgRPrvAbhOsFenhuEufUdDu64uoyKP5Otn1tZklksnb1TT4UQj7PtBdgT42j4yTzsywT
         uRU77vUTL6JJxS8qsR6KsIQCIDvHapsAVks0Kh0XBDNpUdVzWwmxmtHWyvf7NxQb/bct
         3HZQ==
X-Gm-Message-State: AOAM533v/YYy77QAQ6INA/8PF+riTSowlgfxMC+5BwIg0p6OzID8sPUa
        z91tSoYDCnnzYNrUGBo4pSnM8Q==
X-Google-Smtp-Source: ABdhPJw5CiRd+JTZxOeaHYQjHa7B3chtYZCpnIESroFu7Xy+Zl7X7Cm8G2ZfLUtwF1UYd9U60cOnNg==
X-Received: by 2002:a63:f749:0:b0:3aa:361c:8827 with SMTP id f9-20020a63f749000000b003aa361c8827mr32583907pgk.361.1651239463216;
        Fri, 29 Apr 2022 06:37:43 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id m8-20020a17090a414800b001d81a30c437sm10681977pjg.50.2022.04.29.06.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 06:37:42 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        david@redhat.com, jgg@nvidia.com, tj@kernel.org, dennis@kernel.org,
        ming.lei@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [RFC PATCH 15/18] mm: use try_to_free_user_pte() in MADV_FREE case
Date:   Fri, 29 Apr 2022 21:35:49 +0800
Message-Id: <20220429133552.33768-16-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220429133552.33768-1-zhengqi.arch@bytedance.com>
References: <20220429133552.33768-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Different from MADV_DONTNEED case, MADV_FREE just marks the physical
page as lazyfree instead of unmapping it immediately, and the physical
page will not be unmapped until the system memory is tight. So we
convert the percpu_ref of the related user PTE page table page to
atomic mode in madvise_free_pte_range(), and then check if it is 0
in try_to_unmap_one(). If it is 0, we can safely reclaim the PTE page
table page at this time.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/rmap.h |  2 ++
 mm/madvise.c         |  7 ++++++-
 mm/page_vma_mapped.c | 46 ++++++++++++++++++++++++++++++++++++++++++--
 mm/rmap.c            |  9 +++++++++
 4 files changed, 61 insertions(+), 3 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 17230c458341..a3174d3bf118 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -204,6 +204,8 @@ int make_device_exclusive_range(struct mm_struct *mm, unsigned long start,
 #define PVMW_SYNC		(1 << 0)
 /* Look for migration entries rather than present PTEs */
 #define PVMW_MIGRATION		(1 << 1)
+/* Used for MADV_FREE page */
+#define PVMW_MADV_FREE		(1 << 2)
 
 struct page_vma_mapped_walk {
 	unsigned long pfn;
diff --git a/mm/madvise.c b/mm/madvise.c
index 8123397f14c8..bd4bcaad5a9f 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -598,7 +598,9 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 	pte_t *orig_pte, *pte, ptent;
 	struct page *page;
 	int nr_swap = 0;
+	bool have_lazyfree = false;
 	unsigned long next;
+	unsigned long start = addr;
 
 	next = pmd_addr_end(addr, end);
 	if (pmd_trans_huge(*pmd))
@@ -709,6 +711,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 			tlb_remove_tlb_entry(tlb, pte, addr);
 		}
 		mark_page_lazyfree(page);
+		have_lazyfree = true;
 	}
 out:
 	if (nr_swap) {
@@ -718,8 +721,10 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 		add_mm_counter(mm, MM_SWAPENTS, nr_swap);
 	}
 	arch_leave_lazy_mmu_mode();
-	if (orig_pte)
+	if (orig_pte) {
 		pte_unmap_unlock(orig_pte, ptl);
+		try_to_free_user_pte(mm, pmd, start, !have_lazyfree);
+	}
 	cond_resched();
 next:
 	return 0;
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 8ecf8fd7cf5e..00bc09f57f48 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -266,8 +266,30 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 next_pte:
 		do {
 			pvmw->address += PAGE_SIZE;
-			if (pvmw->address >= end)
-				return not_found(pvmw);
+			if (pvmw->address >= end) {
+				not_found(pvmw);
+
+				if (pvmw->flags & PVMW_MADV_FREE) {
+					pgtable_t pte;
+					pmd_t pmdval;
+
+					pvmw->flags &= ~PVMW_MADV_FREE;
+					rcu_read_lock();
+					pmdval = READ_ONCE(*pvmw->pmd);
+					if (pmd_none(pmdval) || pmd_leaf(pmdval)) {
+						rcu_read_unlock();
+						return false;
+					}
+					pte = pmd_pgtable(pmdval);
+					if (percpu_ref_is_zero(pte->pte_ref)) {
+						rcu_read_unlock();
+						free_user_pte(mm, pvmw->pmd, pvmw->address);
+					} else {
+						rcu_read_unlock();
+					}
+				}
+				return false;
+			}
 			/* Did we cross page table boundary? */
 			if ((pvmw->address & (PMD_SIZE - PAGE_SIZE)) == 0) {
 				if (pvmw->ptl) {
@@ -275,6 +297,26 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 					pvmw->ptl = NULL;
 				}
 				pte_unmap(pvmw->pte);
+				if (pvmw->flags & PVMW_MADV_FREE) {
+					pgtable_t pte;
+					pmd_t pmdval;
+
+					pvmw->flags &= ~PVMW_MADV_FREE;
+					rcu_read_lock();
+					pmdval = READ_ONCE(*pvmw->pmd);
+					if (pmd_none(pmdval) || pmd_leaf(pmdval)) {
+						rcu_read_unlock();
+						pvmw->pte = NULL;
+						goto restart;
+					}
+					pte = pmd_pgtable(pmdval);
+					if (percpu_ref_is_zero(pte->pte_ref)) {
+						rcu_read_unlock();
+						free_user_pte(mm, pvmw->pmd, pvmw->address);
+					} else {
+						rcu_read_unlock();
+					}
+				}
 				pvmw->pte = NULL;
 				goto restart;
 			}
diff --git a/mm/rmap.c b/mm/rmap.c
index fedb82371efe..f978d324d4f9 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1616,6 +1616,8 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 					mmu_notifier_invalidate_range(mm,
 						address, address + PAGE_SIZE);
 					dec_mm_counter(mm, MM_ANONPAGES);
+					if (IS_ENABLED(CONFIG_FREE_USER_PTE))
+						pvmw.flags |= PVMW_MADV_FREE;
 					goto discard;
 				}
 
@@ -1627,6 +1629,13 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 				folio_set_swapbacked(folio);
 				ret = false;
 				page_vma_mapped_walk_done(&pvmw);
+				if (IS_ENABLED(CONFIG_FREE_USER_PTE) &&
+				    pte_tryget(mm, pvmw.pmd, address)) {
+					pgtable_t pte_page = pmd_pgtable(*pvmw.pmd);
+
+					percpu_ref_switch_to_percpu(pte_page->pte_ref);
+					__pte_put(pte_page);
+				}
 				break;
 			}
 
-- 
2.20.1

