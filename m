Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B1C55B288
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 17:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbiFZO64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 10:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiFZO6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 10:58:55 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290BEF5BB
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 07:58:54 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id v126so2652812pgv.11
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 07:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aSgmFPU2PbXyrsfftZiuDM7gnGYtkDpCXxwg3/TzLH8=;
        b=TTDIRLcxvFmLZKrVig1T+9G+LX1nJKKzMk1LR8mjecD+lcPDfiPWNTZq1l7T8qlQ6X
         DnIuYUDKrlxq3iLUGqbVdY9SLfRxdSps8cSGdc/XHP2QuGK/hnKLZQC4qHQGYEiTzzGI
         2mtavyA9sDXtLzU59g0xS7GMifFsGQAv2wvb2iBQf4M7S//sxJEo28lt6uQc+PbHOo60
         46mSFR+rNfiLBotKpTAjRaUKbEGi//42UFYVHQ3OfZtatB/iM8OiGMDUGrAjDxGyXV/a
         EtntT9h6sxfipYmL0OV2FUNjM8K1YLxXQt0Y0A9woz2/rgLABw2aTFvU5RnQl29VGBAQ
         L6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aSgmFPU2PbXyrsfftZiuDM7gnGYtkDpCXxwg3/TzLH8=;
        b=ye3OuEAnWaINO2a3wFVXX6qf6rMy0Ss0n/sY7hm85CVxFEYf3Qga5aczBwxTx0DbWj
         0aML2NGytVOddMjd2cXw4L7zFwmZllSzFIlEo+Eb4Db6mnHQw10I36pCvdeQ2bCTbRoj
         X/Gj5z696ArIhf7exS0O4uZk3tVHvIcNBGbEg+C0BDFmwG2nqMRSCMha8PrCCtU/WL0L
         r+94KqbK3hcSk7olovDDgWUp9PSLo8DUo7gR5g45e0QbRHj56OB/RKe1WREj6889io8V
         iSeyARKuCVu8KetSke3ef4bIqgHUjUVQ4/tD6F3z1ZqKENf36+89i4evojl9W2n9EEUT
         2m3A==
X-Gm-Message-State: AJIora9rlPnoXUdqAOV5E4F0jXbVBXSgE8TBwHEw+OICiaCoECkdQC7C
        w5o6jlsKmrJwM5BERfN9jSrJ+A==
X-Google-Smtp-Source: AGRyM1sd0KrMtcmFwOtIQyywtbFax1BHrYuBDPtxgwG3sUBV0AWXvyxUFxo0JMJEEhSM014ObIzfTw==
X-Received: by 2002:a63:9d02:0:b0:40d:434:79a7 with SMTP id i2-20020a639d02000000b0040d043479a7mr8529864pgd.31.1656255533643;
        Sun, 26 Jun 2022 07:58:53 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id f8-20020a170902ab8800b0016a0bf0ce2esm5327163plr.92.2022.06.26.07.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 07:58:52 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     mike.kravetz@oracle.com, songmuchun@bytedance.com,
        akpm@linux-foundation.org, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH] mm: hugetlb: kill set_huge_swap_pte_at()
Date:   Sun, 26 Jun 2022 22:57:17 +0800
Message-Id: <20220626145717.53572-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit e5251fd43007 ("mm/hugetlb: introduce set_huge_swap_pte_at()
helper") add set_huge_swap_pte_at() to handle swap entries on
architectures that support hugepages consisting of contiguous ptes.
And currently the set_huge_swap_pte_at() is only overridden by arm64.

The set_huge_swap_pte_at() provide a sz parameter to help determine
the number of entries to be updated. But in fact, all hugetlb swap
entries contain pfn information, so we can find the corresponding
folio through the pfn recorded in the swap entry, then the folio_size()
is the number of entries that need to be updated.

And considering that users will easily cause bugs by ignoring the
difference between set_huge_swap_pte_at() and set_huge_pte_at().
Let's handle swap entries in set_huge_pte_at() and remove the
set_huge_swap_pte_at(), then we can call set_huge_pte_at()
anywhere, which simplifies our coding.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 arch/arm64/include/asm/hugetlb.h |  3 ---
 arch/arm64/mm/hugetlbpage.c      | 34 ++++++++++++++++----------------
 include/linux/hugetlb.h          | 13 ------------
 mm/hugetlb.c                     |  8 +++-----
 mm/rmap.c                        | 11 +++--------
 5 files changed, 23 insertions(+), 46 deletions(-)

diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
index 1fd2846dbefe..d20f5da2d76f 100644
--- a/arch/arm64/include/asm/hugetlb.h
+++ b/arch/arm64/include/asm/hugetlb.h
@@ -46,9 +46,6 @@ extern void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
 			   pte_t *ptep, unsigned long sz);
 #define __HAVE_ARCH_HUGE_PTEP_GET
 extern pte_t huge_ptep_get(pte_t *ptep);
-extern void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr,
-				 pte_t *ptep, pte_t pte, unsigned long sz);
-#define set_huge_swap_pte_at set_huge_swap_pte_at
 
 void __init arm64_hugetlb_cma_reserve(void);
 
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index c9e076683e5d..58b89b9d13e0 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -238,6 +238,13 @@ static void clear_flush(struct mm_struct *mm,
 	flush_tlb_range(&vma, saddr, addr);
 }
 
+static inline struct folio *hugetlb_swap_entry_to_folio(swp_entry_t entry)
+{
+	VM_BUG_ON(!is_migration_entry(entry) && !is_hwpoison_entry(entry));
+
+	return page_folio(pfn_to_page(swp_offset(entry)));
+}
+
 void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 			    pte_t *ptep, pte_t pte)
 {
@@ -247,11 +254,16 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 	unsigned long pfn, dpfn;
 	pgprot_t hugeprot;
 
-	/*
-	 * Code needs to be expanded to handle huge swap and migration
-	 * entries. Needed for HUGETLB and MEMORY_FAILURE.
-	 */
-	WARN_ON(!pte_present(pte));
+	if (!pte_present(pte)) {
+		struct folio *folio;
+
+		folio = hugetlb_swap_entry_to_folio(pte_to_swp_entry(pte));
+		ncontig = num_contig_ptes(folio_size(folio), &pgsize);
+
+		for (i = 0; i < ncontig; i++, ptep++)
+			set_pte_at(mm, addr, ptep, pte);
+		return;
+	}
 
 	if (!pte_cont(pte)) {
 		set_pte_at(mm, addr, ptep, pte);
@@ -269,18 +281,6 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 		set_pte_at(mm, addr, ptep, pfn_pte(pfn, hugeprot));
 }
 
-void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr,
-			  pte_t *ptep, pte_t pte, unsigned long sz)
-{
-	int i, ncontig;
-	size_t pgsize;
-
-	ncontig = num_contig_ptes(sz, &pgsize);
-
-	for (i = 0; i < ncontig; i++, ptep++)
-		set_pte(ptep, pte);
-}
-
 pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 		      unsigned long addr, unsigned long sz)
 {
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index ee9a28ef26ee..3bb98434550a 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -928,14 +928,6 @@ static inline void hugetlb_count_sub(long l, struct mm_struct *mm)
 	atomic_long_sub(l, &mm->hugetlb_usage);
 }
 
-#ifndef set_huge_swap_pte_at
-static inline void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr,
-					pte_t *ptep, pte_t pte, unsigned long sz)
-{
-	set_huge_pte_at(mm, addr, ptep, pte);
-}
-#endif
-
 #ifndef huge_ptep_modify_prot_start
 #define huge_ptep_modify_prot_start huge_ptep_modify_prot_start
 static inline pte_t huge_ptep_modify_prot_start(struct vm_area_struct *vma,
@@ -1119,11 +1111,6 @@ static inline void hugetlb_count_sub(long l, struct mm_struct *mm)
 {
 }
 
-static inline void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr,
-					pte_t *ptep, pte_t pte, unsigned long sz)
-{
-}
-
 static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 					  unsigned long addr, pte_t *ptep)
 {
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f338640fbe4a..559084d96082 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4813,12 +4813,11 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				entry = swp_entry_to_pte(swp_entry);
 				if (userfaultfd_wp(src_vma) && uffd_wp)
 					entry = huge_pte_mkuffd_wp(entry);
-				set_huge_swap_pte_at(src, addr, src_pte,
-						     entry, sz);
+				set_huge_pte_at(src, addr, src_pte, entry);
 			}
 			if (!userfaultfd_wp(dst_vma) && uffd_wp)
 				entry = huge_pte_clear_uffd_wp(entry);
-			set_huge_swap_pte_at(dst, addr, dst_pte, entry, sz);
+			set_huge_pte_at(dst, addr, dst_pte, entry);
 		} else if (unlikely(is_pte_marker(entry))) {
 			/*
 			 * We copy the pte marker only if the dst vma has
@@ -6375,8 +6374,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 					newpte = pte_swp_mkuffd_wp(newpte);
 				else if (uffd_wp_resolve)
 					newpte = pte_swp_clear_uffd_wp(newpte);
-				set_huge_swap_pte_at(mm, address, ptep,
-						     newpte, psize);
+				set_huge_pte_at(mm, address, ptep, newpte);
 				pages++;
 			}
 			spin_unlock(ptl);
diff --git a/mm/rmap.c b/mm/rmap.c
index 062e8655f337..338fbb24c602 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1618,9 +1618,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
 			if (folio_test_hugetlb(folio)) {
 				hugetlb_count_sub(folio_nr_pages(folio), mm);
-				set_huge_swap_pte_at(mm, address,
-						     pvmw.pte, pteval,
-						     vma_mmu_pagesize(vma));
+				set_huge_pte_at(mm, address, pvmw.pte, pteval);
 			} else {
 				dec_mm_counter(mm, mm_counter(&folio->page));
 				set_pte_at(mm, address, pvmw.pte, pteval);
@@ -2004,9 +2002,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
 			if (folio_test_hugetlb(folio)) {
 				hugetlb_count_sub(folio_nr_pages(folio), mm);
-				set_huge_swap_pte_at(mm, address,
-						     pvmw.pte, pteval,
-						     vma_mmu_pagesize(vma));
+				set_huge_pte_at(mm, address, pvmw.pte, pteval);
 			} else {
 				dec_mm_counter(mm, mm_counter(&folio->page));
 				set_pte_at(mm, address, pvmw.pte, pteval);
@@ -2074,8 +2070,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			if (pte_uffd_wp(pteval))
 				swp_pte = pte_swp_mkuffd_wp(swp_pte);
 			if (folio_test_hugetlb(folio))
-				set_huge_swap_pte_at(mm, address, pvmw.pte,
-						     swp_pte, vma_mmu_pagesize(vma));
+				set_huge_pte_at(mm, address, pvmw.pte, swp_pte);
 			else
 				set_pte_at(mm, address, pvmw.pte, swp_pte);
 			trace_set_migration_pte(address, pte_val(swp_pte),
-- 
2.20.1

