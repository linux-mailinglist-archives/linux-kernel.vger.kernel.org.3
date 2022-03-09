Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092B74D27C1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbiCIC6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 21:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbiCIC6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 21:58:30 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 288EF3EAB6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 18:57:28 -0800 (PST)
Received: from localhost.localdomain (unknown [10.2.5.185])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxvxORFyhi1W0FAA--.123S2;
        Wed, 09 Mar 2022 10:57:21 +0800 (CST)
From:   Bibo Mao <maobibo@loongson.cn>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: reduce tlb flush range when changing vma protection
Date:   Tue,  8 Mar 2022 21:57:21 -0500
Message-Id: <20220309025721.3051365-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxvxORFyhi1W0FAA--.123S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZrWkZryfZr45uFWfZw17Awb_yoW7JF1UpF
        48Ka4ktF42q3yqgF9xZrW5Z343Jw17Xa1xAa9FgasYqFn8ta43XFy3GayF9r15AFykZF9I
        yayaqw1vkw47Z3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UUUUUUUUU==
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

numa worker will periodically change vma prot with PROT_NONE, by
default it will scan 256M vma memory size with pmd stepping size.
If there are fewer pages changed with PROT_NONE, tlb flush is called
with pmd size. This patch will calculate flush range for those
pages with pte prot changed, it will reduce size for tlb flush.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 mm/mprotect.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 2887644fd150..a9f51a998dc8 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -35,9 +35,23 @@
 
 #include "internal.h"
 
+typedef struct {
+	unsigned long start;
+	unsigned long end;
+} tlb_range;
+
+static inline void add_tlb_range(tlb_range *range, unsigned long start,
+		unsigned long end)
+{
+	if (start < range->start)
+		range->start = start;
+	if (end > range->end)
+		range->end = end;
+}
+
 static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 		unsigned long addr, unsigned long end, pgprot_t newprot,
-		unsigned long cp_flags)
+		unsigned long cp_flags, tlb_range *range)
 {
 	pte_t *pte, oldpte;
 	spinlock_t *ptl;
@@ -138,6 +152,7 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 				ptent = pte_mkwrite(ptent);
 			}
 			ptep_modify_prot_commit(vma, addr, pte, oldpte, ptent);
+			add_tlb_range(range, addr, addr + PAGE_SIZE);
 			pages++;
 		} else if (is_swap_pte(oldpte)) {
 			swp_entry_t entry = pte_to_swp_entry(oldpte);
@@ -184,6 +199,7 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 
 			if (!pte_same(oldpte, newpte)) {
 				set_pte_at(vma->vm_mm, addr, pte, newpte);
+				add_tlb_range(range, addr, addr + PAGE_SIZE);
 				pages++;
 			}
 		}
@@ -221,7 +237,7 @@ static inline int pmd_none_or_clear_bad_unless_trans_huge(pmd_t *pmd)
 
 static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 		pud_t *pud, unsigned long addr, unsigned long end,
-		pgprot_t newprot, unsigned long cp_flags)
+		pgprot_t newprot, unsigned long cp_flags, tlb_range *tlb)
 {
 	pmd_t *pmd;
 	unsigned long next;
@@ -267,6 +283,7 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 				if (nr_ptes) {
 					if (nr_ptes == HPAGE_PMD_NR) {
 						pages += HPAGE_PMD_NR;
+						add_tlb_range(tlb, addr, next);
 						nr_huge_updates++;
 					}
 
@@ -277,7 +294,7 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 			/* fall through, the trans huge pmd just split */
 		}
 		this_pages = change_pte_range(vma, pmd, addr, next, newprot,
-					      cp_flags);
+					      cp_flags, tlb);
 		pages += this_pages;
 next:
 		cond_resched();
@@ -293,7 +310,7 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 
 static inline unsigned long change_pud_range(struct vm_area_struct *vma,
 		p4d_t *p4d, unsigned long addr, unsigned long end,
-		pgprot_t newprot, unsigned long cp_flags)
+		pgprot_t newprot, unsigned long cp_flags, tlb_range *range)
 {
 	pud_t *pud;
 	unsigned long next;
@@ -305,7 +322,7 @@ static inline unsigned long change_pud_range(struct vm_area_struct *vma,
 		if (pud_none_or_clear_bad(pud))
 			continue;
 		pages += change_pmd_range(vma, pud, addr, next, newprot,
-					  cp_flags);
+					  cp_flags, range);
 	} while (pud++, addr = next, addr != end);
 
 	return pages;
@@ -313,7 +330,7 @@ static inline unsigned long change_pud_range(struct vm_area_struct *vma,
 
 static inline unsigned long change_p4d_range(struct vm_area_struct *vma,
 		pgd_t *pgd, unsigned long addr, unsigned long end,
-		pgprot_t newprot, unsigned long cp_flags)
+		pgprot_t newprot, unsigned long cp_flags, tlb_range *range)
 {
 	p4d_t *p4d;
 	unsigned long next;
@@ -325,7 +342,7 @@ static inline unsigned long change_p4d_range(struct vm_area_struct *vma,
 		if (p4d_none_or_clear_bad(p4d))
 			continue;
 		pages += change_pud_range(vma, p4d, addr, next, newprot,
-					  cp_flags);
+					  cp_flags, range);
 	} while (p4d++, addr = next, addr != end);
 
 	return pages;
@@ -338,24 +355,26 @@ static unsigned long change_protection_range(struct vm_area_struct *vma,
 	struct mm_struct *mm = vma->vm_mm;
 	pgd_t *pgd;
 	unsigned long next;
-	unsigned long start = addr;
 	unsigned long pages = 0;
+	tlb_range range;
 
 	BUG_ON(addr >= end);
 	pgd = pgd_offset(mm, addr);
 	flush_cache_range(vma, addr, end);
+	range.start = end;
+	range.end = addr;
 	inc_tlb_flush_pending(mm);
 	do {
 		next = pgd_addr_end(addr, end);
 		if (pgd_none_or_clear_bad(pgd))
 			continue;
 		pages += change_p4d_range(vma, pgd, addr, next, newprot,
-					  cp_flags);
+					  cp_flags, &range);
 	} while (pgd++, addr = next, addr != end);
 
 	/* Only flush the TLB if we actually modified any entries: */
 	if (pages)
-		flush_tlb_range(vma, start, end);
+		flush_tlb_range(vma, range.start, range.end);
 	dec_tlb_flush_pending(mm);
 
 	return pages;
-- 
2.31.1

