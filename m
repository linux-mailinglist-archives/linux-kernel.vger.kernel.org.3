Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE39533AA4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 12:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237769AbiEYKb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 06:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbiEYKbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 06:31:23 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C710F6EC4C
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 03:31:22 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VEN9UHQ_1653474679;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VEN9UHQ_1653474679)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 25 May 2022 18:31:20 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     mike.kravetz@oracle.com, songmuchun@bytedance.com,
        anshuman.khandual@arm.com, baolin.wang@linux.alibaba.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] arm64/hugetlb: Simplify the huge_ptep_set_access_flags()
Date:   Wed, 25 May 2022 18:31:09 +0800
Message-Id: <d81f1c3215000d0f238900dbfa0a0976d8d00cd3.1653470369.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit bc5dfb4fd7bd ("arm64/hugetlb: Implement arm64 specific
huge_ptep_get()"), the arm64 specific huge_ptep_get() will always
consider the subpages' dirty and young state for CONT-PTE/PMD hugetlb,
so there is no need to check them again when setting the access flags
for CONT-PTE/PMD hugetlb in huge_ptep_set_access_flags().

Meanwhile this also fixes an issue when users want to make the CONT-PTE/PMD
hugetlb's pte entry old, which will be failed to make the pte entry old
since the original code will always consider the subpages' young state
if the subpages' young state is set. For example, we will make the
CONT-PTE/PMD hugetlb pte entry old in DAMON to monitoring the accesses,
but we'll failed to monitoring the actual accesses of the CONT-PTE/PMD
hugetlb page, due to we can not make its pte old.

Thus remove the code considering the subpages' dirty and young state in
huge_ptep_set_access_flags() to fix this issue and simplify the function.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 arch/arm64/mm/hugetlbpage.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index e2a5ec9..5c703aa 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -448,7 +448,6 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 	size_t pgsize = 0;
 	unsigned long pfn = pte_pfn(pte), dpfn;
 	pgprot_t hugeprot;
-	pte_t orig_pte;
 
 	if (!pte_cont(pte))
 		return ptep_set_access_flags(vma, addr, ptep, pte, dirty);
@@ -459,14 +458,7 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 	if (!__cont_access_flags_changed(ptep, pte, ncontig))
 		return 0;
 
-	orig_pte = get_clear_contig(vma->vm_mm, addr, ptep, pgsize, ncontig);
-
-	/* Make sure we don't lose the dirty or young state */
-	if (pte_dirty(orig_pte))
-		pte = pte_mkdirty(pte);
-
-	if (pte_young(orig_pte))
-		pte = pte_mkyoung(pte);
+	clear_flush(vma->vm_mm, addr, ptep, pgsize, ncontig);
 
 	hugeprot = pte_pgprot(pte);
 	for (i = 0; i < ncontig; i++, ptep++, addr += pgsize, pfn += dpfn)
-- 
1.8.3.1

