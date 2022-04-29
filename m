Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25DAD514AB3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 15:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376318AbiD2NlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 09:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376289AbiD2Nk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 09:40:57 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2593FCC50A
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 06:37:38 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id x52so5378492pfu.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 06:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rYeLNg+oS2y3akdD0dEeA3yQLeG8PhzEVgB+CG0F5x8=;
        b=r0oSktHd6lJh1xiGDkOseB1CwEKbnU5ADwHmNxjoz0rF9tVkTla0cHmYCIjX9kad48
         HXeS+/YDOH1RsqM0QaLq3bkmUHA4i6Jbi5iXnJXClUtQW4MWr3dTM217XBF44U478R6b
         Shvq73K4KVjlhzE/n7vZ2+kDth8ZTt+DfZSh4jXPMr/dgaiOTUv7UitxA5wBpQeUxLT3
         /SrfjXz8WTr03+JamLKfd/O6NmDHtxE1rvUHfP30jXpZwF3OrnSi1H2YikZmmdZh3Lk1
         XhF0EkwMAPk7F1PJU3e9O2p9K6frj/vvPrSN47R2YW4XK31joU4z9lay8VQ6QPegDiSH
         W1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rYeLNg+oS2y3akdD0dEeA3yQLeG8PhzEVgB+CG0F5x8=;
        b=hgdvW5c2TeSOaVPY7bmI7j95U+Psaqvetcc4CvsYUjyiK6WgeE53d+LkL4X9SmoT3s
         vwzoghAfr8NmAuGt44xNE2yb9XaW6Me+agXkAZBMBcxu2yGORqrrjAPoXZ1RtHBsuXfY
         PvVUtLdH/krooZCpJvkU+RfbY9dy4v0HUrPsjhOOGUwjP02Tcdp3qoJGKkpf+rlDKURT
         bU8dDLYFWQPg4SI44hsvgdjkmM68BcSGSL1KlV1wPibG90rrYAbTWebyDnO2H/luhBs3
         eEhnh2wkpA25oC5tQvpxP3aEh9+cdcdBcb/Ss2zoY8ONzM1sVpr01yArk2gPe4v3Jl5q
         mRXA==
X-Gm-Message-State: AOAM531/72bkwWOan136MUJpktCe7pT1OUEzlR6fbm1a4DszFk5EcPGW
        EqpfuoEERYsZsNfYsapKaFrrKA==
X-Google-Smtp-Source: ABdhPJwqz/7MfX5i1uHVza5qIKuW50STzQue9UefcrOGDN8WPmjUeneAZB8Gavo9bb4peYnwNe/Qfg==
X-Received: by 2002:a05:6a00:238f:b0:4f7:78b1:2f6b with SMTP id f15-20020a056a00238f00b004f778b12f6bmr40178261pfc.17.1651239457603;
        Fri, 29 Apr 2022 06:37:37 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id m8-20020a17090a414800b001d81a30c437sm10681977pjg.50.2022.04.29.06.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 06:37:37 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        david@redhat.com, jgg@nvidia.com, tj@kernel.org, dennis@kernel.org,
        ming.lei@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [RFC PATCH 14/18] mm: use try_to_free_user_pte() in MADV_DONTNEED case
Date:   Fri, 29 Apr 2022 21:35:48 +0800
Message-Id: <20220429133552.33768-15-zhengqi.arch@bytedance.com>
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

Immediately after a successful MADV_DONTNEED operation, the
physical page is unmapped from the PTE page table entry. This
is a good time to call try_to_free_user_pte() to try to free
the PTE page table page.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/internal.h |  3 ++-
 mm/memory.c   | 43 +++++++++++++++++++++++++++++--------------
 mm/oom_kill.c |  3 ++-
 3 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index cf16280ce132..f93a9170d2e3 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -77,7 +77,8 @@ struct zap_details;
 void unmap_page_range(struct mmu_gather *tlb,
 			     struct vm_area_struct *vma,
 			     unsigned long addr, unsigned long end,
-			     struct zap_details *details);
+			     struct zap_details *details,
+			     bool free_pte);
 
 void page_cache_ra_order(struct readahead_control *, struct file_ra_state *,
 		unsigned int order);
diff --git a/mm/memory.c b/mm/memory.c
index aa2bac561d5e..75a0e16a095a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1339,7 +1339,8 @@ static inline bool should_zap_page(struct zap_details *details, struct page *pag
 static unsigned long zap_pte_range(struct mmu_gather *tlb,
 				struct vm_area_struct *vma, pmd_t *pmd,
 				unsigned long addr, unsigned long end,
-				struct zap_details *details)
+				struct zap_details *details,
+				bool free_pte)
 {
 	struct mm_struct *mm = tlb->mm;
 	int force_flush = 0;
@@ -1348,6 +1349,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	pte_t *start_pte;
 	pte_t *pte;
 	swp_entry_t entry;
+	unsigned long start = addr;
 
 	tlb_change_page_size(tlb, PAGE_SIZE);
 again:
@@ -1455,13 +1457,17 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 		goto again;
 	}
 
+	if (free_pte)
+		try_to_free_user_pte(mm, pmd, start, true);
+
 	return addr;
 }
 
 static inline unsigned long zap_pmd_range(struct mmu_gather *tlb,
 				struct vm_area_struct *vma, pud_t *pud,
 				unsigned long addr, unsigned long end,
-				struct zap_details *details)
+				struct zap_details *details,
+				bool free_pte)
 {
 	pmd_t *pmd;
 	unsigned long next;
@@ -1496,7 +1502,8 @@ static inline unsigned long zap_pmd_range(struct mmu_gather *tlb,
 		 */
 		if (pmd_none_or_trans_huge_or_clear_bad(pmd))
 			goto next;
-		next = zap_pte_range(tlb, vma, pmd, addr, next, details);
+		next = zap_pte_range(tlb, vma, pmd, addr, next, details,
+				     free_pte);
 next:
 		cond_resched();
 	} while (pmd++, addr = next, addr != end);
@@ -1507,7 +1514,8 @@ static inline unsigned long zap_pmd_range(struct mmu_gather *tlb,
 static inline unsigned long zap_pud_range(struct mmu_gather *tlb,
 				struct vm_area_struct *vma, p4d_t *p4d,
 				unsigned long addr, unsigned long end,
-				struct zap_details *details)
+				struct zap_details *details,
+				bool free_pte)
 {
 	pud_t *pud;
 	unsigned long next;
@@ -1525,7 +1533,8 @@ static inline unsigned long zap_pud_range(struct mmu_gather *tlb,
 		}
 		if (pud_none_or_clear_bad(pud))
 			continue;
-		next = zap_pmd_range(tlb, vma, pud, addr, next, details);
+		next = zap_pmd_range(tlb, vma, pud, addr, next, details,
+				     free_pte);
 next:
 		cond_resched();
 	} while (pud++, addr = next, addr != end);
@@ -1536,7 +1545,8 @@ static inline unsigned long zap_pud_range(struct mmu_gather *tlb,
 static inline unsigned long zap_p4d_range(struct mmu_gather *tlb,
 				struct vm_area_struct *vma, pgd_t *pgd,
 				unsigned long addr, unsigned long end,
-				struct zap_details *details)
+				struct zap_details *details,
+				bool free_pte)
 {
 	p4d_t *p4d;
 	unsigned long next;
@@ -1546,7 +1556,8 @@ static inline unsigned long zap_p4d_range(struct mmu_gather *tlb,
 		next = p4d_addr_end(addr, end);
 		if (p4d_none_or_clear_bad(p4d))
 			continue;
-		next = zap_pud_range(tlb, vma, p4d, addr, next, details);
+		next = zap_pud_range(tlb, vma, p4d, addr, next, details,
+				     free_pte);
 	} while (p4d++, addr = next, addr != end);
 
 	return addr;
@@ -1555,7 +1566,8 @@ static inline unsigned long zap_p4d_range(struct mmu_gather *tlb,
 void unmap_page_range(struct mmu_gather *tlb,
 			     struct vm_area_struct *vma,
 			     unsigned long addr, unsigned long end,
-			     struct zap_details *details)
+			     struct zap_details *details,
+			     bool free_pte)
 {
 	pgd_t *pgd;
 	unsigned long next;
@@ -1567,7 +1579,8 @@ void unmap_page_range(struct mmu_gather *tlb,
 		next = pgd_addr_end(addr, end);
 		if (pgd_none_or_clear_bad(pgd))
 			continue;
-		next = zap_p4d_range(tlb, vma, pgd, addr, next, details);
+		next = zap_p4d_range(tlb, vma, pgd, addr, next, details,
+				     free_pte);
 	} while (pgd++, addr = next, addr != end);
 	tlb_end_vma(tlb, vma);
 }
@@ -1576,7 +1589,8 @@ void unmap_page_range(struct mmu_gather *tlb,
 static void unmap_single_vma(struct mmu_gather *tlb,
 		struct vm_area_struct *vma, unsigned long start_addr,
 		unsigned long end_addr,
-		struct zap_details *details)
+		struct zap_details *details,
+		bool free_pte)
 {
 	unsigned long start = max(vma->vm_start, start_addr);
 	unsigned long end;
@@ -1612,7 +1626,8 @@ static void unmap_single_vma(struct mmu_gather *tlb,
 				i_mmap_unlock_write(vma->vm_file->f_mapping);
 			}
 		} else
-			unmap_page_range(tlb, vma, start, end, details);
+			unmap_page_range(tlb, vma, start, end, details,
+					 free_pte);
 	}
 }
 
@@ -1644,7 +1659,7 @@ void unmap_vmas(struct mmu_gather *tlb,
 				start_addr, end_addr);
 	mmu_notifier_invalidate_range_start(&range);
 	for ( ; vma && vma->vm_start < end_addr; vma = vma->vm_next)
-		unmap_single_vma(tlb, vma, start_addr, end_addr, NULL);
+		unmap_single_vma(tlb, vma, start_addr, end_addr, NULL, false);
 	mmu_notifier_invalidate_range_end(&range);
 }
 
@@ -1669,7 +1684,7 @@ void zap_page_range(struct vm_area_struct *vma, unsigned long start,
 	update_hiwater_rss(vma->vm_mm);
 	mmu_notifier_invalidate_range_start(&range);
 	for ( ; vma && vma->vm_start < range.end; vma = vma->vm_next)
-		unmap_single_vma(&tlb, vma, start, range.end, NULL);
+		unmap_single_vma(&tlb, vma, start, range.end, NULL, true);
 	mmu_notifier_invalidate_range_end(&range);
 	tlb_finish_mmu(&tlb);
 }
@@ -1695,7 +1710,7 @@ static void zap_page_range_single(struct vm_area_struct *vma, unsigned long addr
 	tlb_gather_mmu(&tlb, vma->vm_mm);
 	update_hiwater_rss(vma->vm_mm);
 	mmu_notifier_invalidate_range_start(&range);
-	unmap_single_vma(&tlb, vma, address, range.end, details);
+	unmap_single_vma(&tlb, vma, address, range.end, details, true);
 	mmu_notifier_invalidate_range_end(&range);
 	tlb_finish_mmu(&tlb);
 }
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 7ec38194f8e1..c4c25a7add7b 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -549,7 +549,8 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
 				ret = false;
 				continue;
 			}
-			unmap_page_range(&tlb, vma, range.start, range.end, NULL);
+			unmap_page_range(&tlb, vma, range.start, range.end,
+					 NULL, false);
 			mmu_notifier_invalidate_range_end(&range);
 			tlb_finish_mmu(&tlb);
 		}
-- 
2.20.1

