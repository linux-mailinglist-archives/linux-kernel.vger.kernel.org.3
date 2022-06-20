Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B53550E92
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 04:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbiFTCe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 22:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiFTCe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 22:34:56 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77F5B1F2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 19:34:54 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VGpSCch_1655692491;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VGpSCch_1655692491)
          by smtp.aliyun-inc.com;
          Mon, 20 Jun 2022 10:34:52 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     sj@kernel.org, akpm@linux-foundation.org
Cc:     mike.kravetz@oracle.com, songmuchun@bytedance.com,
        baolin.wang@linux.alibaba.com, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/damon: Use set_huge_pte_at() to make huge pte old
Date:   Mon, 20 Jun 2022 10:34:42 +0800
Message-Id: <1655692482-28797-1-git-send-email-baolin.wang@linux.alibaba.com>
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

The huge_ptep_set_access_flags() can not make the huge pte old according
to the discussion [1], that means we will always mornitor the young state
of the hugetlb though we stopped accessing the hugetlb, as a result DAMON
will get inaccurate accessing statistics.

So changing to use set_huge_pte_at() to make the huge pte old to fix this
issue.

[1] https://lore.kernel.org/all/Yqy97gXI4Nqb7dYo@arm.com/

Fixes: 49f4203aae06 ("mm/damon: add access checking for hugetlb pages")
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/damon/vaddr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 5767be72c181..d24148a8149f 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -337,8 +337,7 @@ static void damon_hugetlb_mkold(pte_t *pte, struct mm_struct *mm,
 	if (pte_young(entry)) {
 		referenced = true;
 		entry = pte_mkold(entry);
-		huge_ptep_set_access_flags(vma, addr, pte, entry,
-					   vma->vm_flags & VM_WRITE);
+		set_huge_pte_at(mm, addr, pte, entry);
 	}
 
 #ifdef CONFIG_MMU_NOTIFIER
-- 
2.27.0

