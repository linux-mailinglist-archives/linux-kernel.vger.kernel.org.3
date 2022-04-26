Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E2950F1AC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343613AbiDZHGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241674AbiDZHGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:06:34 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4986D383
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:03:26 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VBK82ax_1650956603;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VBK82ax_1650956603)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 26 Apr 2022 15:03:24 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org, mike.kravetz@oracle.com
Cc:     peterx@redhat.com, songmuchun@bytedance.com,
        baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm: hugetlb: Add missing cache flushing in hugetlb_unshare_all_pmds()
Date:   Tue, 26 Apr 2022 15:03:15 +0800
Message-Id: <47441086affcabb6ecbe403173e9283b0d904b38.1650956489.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Missed calling flush_cache_range() before removing the sharing PMD entrires,
otherwise data consistence issue may be occurred on some architectures whose
caches are strict and require a virtual–>physical translation to exist for
a virtual address. Thus add it.

Now no architectures enabling PMD sharing will be affected, since they do
not have a VIVT cache. That means this issue can not be happened in practice
so far.

Fixes: 6dfeaff93be1 ("hugetlb/userfaultfd: unshare all pmds for hugetlbfs when register wp")
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
Changes from v1:
 - Add more comments in commit message suggested by Muchun.
 - Add reviewed-by tag from Muchun.
---
 mm/hugetlb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 74c9964..1945dfb 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7058,6 +7058,7 @@ void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
 	if (start >= end)
 		return;
 
+	flush_cache_range(vma, start, end);
 	/*
 	 * No need to call adjust_range_if_pmd_sharing_possible(), because
 	 * we have already done the PUD_SIZE alignment.
-- 
1.8.3.1

