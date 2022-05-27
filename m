Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8C653576D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 04:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbiE0CBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 22:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbiE0CBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 22:01:48 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EA3C6E75
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 19:01:45 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VEV-6f9_1653616902;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VEV-6f9_1653616902)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 27 May 2022 10:01:42 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        songmuchun@bytedance.com
Cc:     anshuman.khandual@arm.com, baolin.wang@linux.alibaba.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2] mm/hugetlb: Remove unnecessary huge_ptep_set_access_flags() in hugetlb_mcopy_atomic_pte()
Date:   Fri, 27 May 2022 10:01:35 +0800
Message-Id: <f3e28b897b53a69967a8b98a6fdcda3be80c9229.1653616175.git.baolin.wang@linux.alibaba.com>
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

There is no need to update the hugetlb access flags after just setting the
hugetlb page table entry by set_huge_pte_at(), since the page table entry
value has no changes.

Thus remove the unnecessary huge_ptep_set_access_flags() in
hugetlb_mcopy_atomic_pte().

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Changes from v1:
 - Update commit message to remove checkpatch.pl complaint.
 - Collect reviewed-by tags.
---
 mm/hugetlb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 7c468ac..3ad49bf 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6032,8 +6032,6 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 
 	set_huge_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
 
-	(void)huge_ptep_set_access_flags(dst_vma, dst_addr, dst_pte, _dst_pte,
-					dst_vma->vm_flags & VM_WRITE);
 	hugetlb_count_add(pages_per_huge_page(h), dst_mm);
 
 	/* No need to invalidate - it was non-present before */
-- 
1.8.3.1

