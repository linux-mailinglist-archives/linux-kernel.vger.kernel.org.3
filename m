Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB35533A9A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 12:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242242AbiEYK0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 06:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiEYK0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 06:26:39 -0400
Received: from out199-1.us.a.mail.aliyun.com (out199-1.us.a.mail.aliyun.com [47.90.199.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B3B93463
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 03:26:37 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VENAbeB_1653474392;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VENAbeB_1653474392)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 25 May 2022 18:26:33 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        songmuchun@bytedance.com
Cc:     baolin.wang@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] mm/hugetlb: Remove unnecessary huge_ptep_set_access_flags() in hugetlb_mcopy_atomic_pte()
Date:   Wed, 25 May 2022 18:26:24 +0800
Message-Id: <7cd55152c1a00910afda570d1543a97198b3665b.1653468078.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to update the hugetlb access flags after just setting the
hugetlb page table entry by set_huge_pte_at(), since the page table entry
value has no changes. Thus remove the unnecessary huge_ptep_set_access_flags()
in hugetlb_mcopy_atomic_pte().

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
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

