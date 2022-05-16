Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C77527B3C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 02:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239104AbiEPA40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 20:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238979AbiEPA4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 20:56:16 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE88D2AC2
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 17:56:13 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VDC5iVF_1652662567;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VDC5iVF_1652662567)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 16 May 2022 08:56:08 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        songmuchun@bytedance.com, willy@infradead.org,
        anshuman.khandual@arm.com, christophe.leroy@csgroup.eu,
        baolin.wang@linux.alibaba.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v3 2/2] arm64/hugetlb: Implement arm64 specific huge_ptep_get()
Date:   Mon, 16 May 2022 08:55:58 +0800
Message-Id: <624109a80ac4bbdf1e462dfa0b49e9f7c31a7c0d.1652496622.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1652496622.git.baolin.wang@linux.alibaba.com>
References: <cover.1652496622.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1652496622.git.baolin.wang@linux.alibaba.com>
References: <cover.1652496622.git.baolin.wang@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now we use huge_ptep_get() to get the pte value of a hugetlb page,
however it will only return one specific pte value for the CONT-PTE
or CONT-PMD size hugetlb on ARM64 system, which can contain several
continuous pte or pmd entries with same page table attributes. And it
will not take into account the subpages' dirty or young bits of a
CONT-PTE/PMD size hugetlb page.

So the huge_ptep_get() is inconsistent with huge_ptep_get_and_clear(),
which already takes account the dirty or young bits for any subpages
in this CONT-PTE/PMD size hugetlb [1]. Meanwhile we can miss dirty or
young flags statistics for hugetlb pages with current huge_ptep_get(),
such as the gather_hugetlb_stats() function, and CONT-PTE/PMD hugetlb
monitoring with DAMON.

Thus define an ARM64 specific huge_ptep_get() implementation as well as
enabling __HAVE_ARCH_HUGE_PTEP_GET, that will take into account any
subpages' dirty or young bits for CONT-PTE/PMD size hugetlb page, for
those functions that want to check the dirty and young flags of a hugetlb
page.

[1] https://lore.kernel.org/linux-mm/85bd80b4-b4fd-0d3f-a2e5-149559f2f387@oracle.com/

Suggested-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/hugetlb.h |  2 ++
 arch/arm64/mm/hugetlbpage.c      | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
index 616b2ca..1fd2846 100644
--- a/arch/arm64/include/asm/hugetlb.h
+++ b/arch/arm64/include/asm/hugetlb.h
@@ -44,6 +44,8 @@ extern pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 #define __HAVE_ARCH_HUGE_PTE_CLEAR
 extern void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
 			   pte_t *ptep, unsigned long sz);
+#define __HAVE_ARCH_HUGE_PTEP_GET
+extern pte_t huge_ptep_get(pte_t *ptep);
 extern void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr,
 				 pte_t *ptep, pte_t pte, unsigned long sz);
 #define set_huge_swap_pte_at set_huge_swap_pte_at
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 9553851..2a7e143 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -158,6 +158,28 @@ static inline int num_contig_ptes(unsigned long size, size_t *pgsize)
 	return contig_ptes;
 }
 
+pte_t huge_ptep_get(pte_t *ptep)
+{
+	int ncontig, i;
+	size_t pgsize;
+	pte_t orig_pte = ptep_get(ptep);
+
+	if (!pte_present(orig_pte) || !pte_cont(orig_pte))
+		return orig_pte;
+
+	ncontig = num_contig_ptes(page_size(pte_page(orig_pte)), &pgsize);
+	for (i = 0; i < ncontig; i++, ptep++) {
+		pte_t pte = ptep_get(ptep);
+
+		if (pte_dirty(pte))
+			orig_pte = pte_mkdirty(orig_pte);
+
+		if (pte_young(pte))
+			orig_pte = pte_mkyoung(orig_pte);
+	}
+	return orig_pte;
+}
+
 /*
  * Changing some bits of contiguous entries requires us to follow a
  * Break-Before-Make approach, breaking the whole contiguous set
-- 
1.8.3.1

