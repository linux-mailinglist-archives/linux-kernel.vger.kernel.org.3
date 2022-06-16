Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1E754D8F1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 05:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349016AbiFPDfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 23:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346612AbiFPDfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 23:35:20 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E191742493
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 20:35:18 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VGVdsvf_1655350515;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VGVdsvf_1655350515)
          by smtp.aliyun-inc.com;
          Thu, 16 Jun 2022 11:35:16 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     mike.kravetz@oracle.com
Cc:     songmuchun@bytedance.com, akpm@linux-foundation.org,
        catalin.marinas@arm.com, will@kernel.org,
        anshuman.khandual@arm.com, baolin.wang@linux.alibaba.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] arm64/hugetlb: Implement arm64 specific hugetlb_mask_last_hp
Date:   Thu, 16 Jun 2022 11:34:58 +0800
Message-Id: <7256dbe078d7231f45b0f47c2c52a3bd3aa10da7.1655350193.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HugeTLB address ranges are linearly scanned during fork, unmap and
remap operations, and the linear scan can skip to the end of range mapped
by the page table page if hitting a non-present entry, which can help
to speed linear scanning of the HugeTLB address ranges.

So hugetlb_mask_last_hp() is introduced to help to update the address in
the loop of HugeTLB linear scanning with getting the last huge page mapped
by the associated page table page[1], when a non-present entry is encountered.

Considering ARM64 specific cont-pte/pmd size HugeTLB, this patch implemented
an ARM64 specific hugetlb_mask_last_hp() to help this case.

[1] https://lore.kernel.org/linux-mm/20220527225849.284839-1-mike.kravetz@oracle.com/

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
Note: this patch is based on the series: "hugetlb: speed up linear
address scanning" from Mike. Mike, please fold it into your series.
Thanks.
---
 arch/arm64/mm/hugetlbpage.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index e2a5ec9..958935c 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -368,6 +368,26 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
 	return NULL;
 }
 
+unsigned long hugetlb_mask_last_hp(struct hstate *h)
+{
+	unsigned long hp_size = huge_page_size(h);
+
+	switch (hp_size) {
+	case PUD_SIZE:
+		return PGDIR_SIZE - PUD_SIZE;
+	case CONT_PMD_SIZE:
+		return PUD_SIZE - CONT_PMD_SIZE;
+	case PMD_SIZE:
+		return PUD_SIZE - PMD_SIZE;
+	case CONT_PTE_SIZE:
+		return PMD_SIZE - CONT_PTE_SIZE;
+	default:
+		break;
+	}
+
+	return ~0UL;
+}
+
 pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags)
 {
 	size_t pagesize = 1UL << shift;
-- 
1.8.3.1

