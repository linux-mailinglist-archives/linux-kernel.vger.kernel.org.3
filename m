Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E3E521354
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240760AbiEJLRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240723AbiEJLRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:17:10 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB2922242D
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 04:13:12 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VCr6xlO_1652181186;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VCr6xlO_1652181186)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 10 May 2022 19:13:06 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     catalin.marinas@arm.com, will@kernel.org, mike.kravetz@oracle.com,
        akpm@linux-foundation.org
Cc:     songmuchun@bytedance.com, willy@infradead.org,
        anshuman.khandual@arm.com, christophe.leroy@csgroup.eu,
        baolin.wang@linux.alibaba.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 1/2] arm64/hugetlb: Use ptep_get() to get the pte value of a huge page
Date:   Tue, 10 May 2022 19:12:52 +0800
Message-Id: <6aabddaf4cae5ae2205c3a7df9b9e15dbd61b641.1652180088.git.baolin.wang@linux.alibaba.com>
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

The original huge_ptep_get() on ARM64 is just a wrapper of ptep_get(),
which will not take into account any contig-PTEs dirty and access bits.
Meanwhile we will implement a new ARM64-specific huge_ptep_get()
interface in following patch, which will take into account any contig-PTEs
dirty and access bits and only be allowed to pass the head pte of
a contig-PTE/PMD size page.

Thus change to use ptep_get() to get the pte value of a huge page as
a preparation.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 arch/arm64/mm/hugetlbpage.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index ca8e65c..be5e2f3 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -172,7 +172,7 @@ static pte_t get_clear_flush(struct mm_struct *mm,
 			     unsigned long pgsize,
 			     unsigned long ncontig)
 {
-	pte_t orig_pte = huge_ptep_get(ptep);
+	pte_t orig_pte = ptep_get(ptep);
 	bool valid = pte_valid(orig_pte);
 	unsigned long i, saddr = addr;
 
@@ -385,7 +385,7 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 {
 	int ncontig;
 	size_t pgsize;
-	pte_t orig_pte = huge_ptep_get(ptep);
+	pte_t orig_pte = ptep_get(ptep);
 
 	if (!pte_cont(orig_pte))
 		return ptep_get_and_clear(mm, addr, ptep);
@@ -408,11 +408,11 @@ static int __cont_access_flags_changed(pte_t *ptep, pte_t pte, int ncontig)
 {
 	int i;
 
-	if (pte_write(pte) != pte_write(huge_ptep_get(ptep)))
+	if (pte_write(pte) != pte_write(ptep_get(ptep)))
 		return 1;
 
 	for (i = 0; i < ncontig; i++) {
-		pte_t orig_pte = huge_ptep_get(ptep + i);
+		pte_t orig_pte = ptep_get(ptep + i);
 
 		if (pte_dirty(pte) != pte_dirty(orig_pte))
 			return 1;
-- 
1.8.3.1

