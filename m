Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE506521355
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240750AbiEJLRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240719AbiEJLRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:17:09 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BEA21F1E4
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 04:13:11 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VCr6xmA_1652181187;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VCr6xmA_1652181187)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 10 May 2022 19:13:08 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     catalin.marinas@arm.com, will@kernel.org, mike.kravetz@oracle.com,
        akpm@linux-foundation.org
Cc:     songmuchun@bytedance.com, willy@infradead.org,
        anshuman.khandual@arm.com, christophe.leroy@csgroup.eu,
        baolin.wang@linux.alibaba.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 2/2] arm64/hugetlb: Implement arm64 specific huge_ptep_get()
Date:   Tue, 10 May 2022 19:12:53 +0800
Message-Id: <de94fc10e396668537909b71939aff6fd2579dfb.1652180088.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1652180088.git.baolin.wang@linux.alibaba.com>
References: <cover.1652180088.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1652180088.git.baolin.wang@linux.alibaba.com>
References: <cover.1652180088.git.baolin.wang@linux.alibaba.com>
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
or CONT-PMD size hugetlb on ARM64 system, which can contain seravel
continuous pte or pmd entries with same page table attributes. And it
will not take into account the subpages' dirty or young bits of a
CONT-PTE/PMD size hugetlb page.

So the huge_ptep_get() is inconsistent with huge_ptep_get_and_clear(),
which already takes account the dirty or young bits for any subpages
in this CONT-PTE/PMD size hugetlb [1]. Meanwhile we can miss dirty or
young flags statistics for hugetlb pages with current huge_ptep_get(),
such as the gather_hugetlb_stats() function, and CONT-PTE/PMD hugetlb
monitoring with DAMON.

Thus define an ARM64 specific  huge_ptep_get() implementation, that will
take into account any subpages' dirty or young bits for CONT-PTE/PMD size
hugetlb page, for those functions that want to check the dirty and young
flags of a hugetlb page.

[1] https://lore.kernel.org/linux-mm/85bd80b4-b4fd-0d3f-a2e5-149559f2f387@oracle.com/

Suggested-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 arch/arm64/include/asm/hugetlb.h |  2 ++
 arch/arm64/mm/hugetlbpage.c      | 24 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

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
index be5e2f3..8fb0198 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -158,6 +158,30 @@ static inline int num_contig_ptes(unsigned long size, size_t *pgsize)
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
+
+	for (i = 0; i < ncontig; i++, ptep++) {
+		pte_t pte = ptep_get(ptep);
+
+		if (pte_dirty(pte))
+			orig_pte = pte_mkdirty(orig_pte);
+
+		if (pte_young(pte))
+			orig_pte = pte_mkyoung(orig_pte);
+	}
+
+	return orig_pte;
+}
+
 /*
  * Changing some bits of contiguous entries requires us to follow a
  * Break-Before-Make approach, breaking the whole contiguous set
-- 
1.8.3.1

