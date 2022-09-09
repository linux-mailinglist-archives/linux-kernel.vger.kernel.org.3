Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9F65B2BC5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 03:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiIIBnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 21:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiIIBm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 21:42:59 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637A411EA7C
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 18:42:53 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MNzDN54cRzlVqy;
        Fri,  9 Sep 2022 09:39:00 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 09:42:51 +0800
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 9 Sep
 2022 09:42:51 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3] mm/huge_memory: prevent THP_ZERO_PAGE_ALLOC increased twice
Date:   Fri, 9 Sep 2022 10:16:53 +0800
Message-ID: <20220909021653.3371879-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since user who read THP_ZERO_PAGE_ALLOC may be more concerned about the
huge zero pages that are really allocated using for thp and can indicated
the times of calling huge_zero_page_shrinker. It is misleading to increase
twice if two threads call get_huge_zero_page concurrently. Don't increase
the value if the huge page is not really used.

Update Documentation/admin-guide/mm/transhuge.rst together.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
v2->v3: Update the commit message.
v1->v2: Update documnet.

 Documentation/admin-guide/mm/transhuge.rst | 7 +++----
 mm/huge_memory.c                           | 2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index c9c37f16eef8..8e3418ec4503 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -366,10 +366,9 @@ thp_split_pmd
 	page table entry.
 
 thp_zero_page_alloc
-	is incremented every time a huge zero page is
-	successfully allocated. It includes allocations which where
-	dropped due race with other allocation. Note, it doesn't count
-	every map of the huge zero page, only its allocation.
+	is incremented every time a huge zero page used for thp is
+	successfully allocated. Note, it doesn't count every map of
+	the huge zero page, only its allocation.
 
 thp_zero_page_alloc_failed
 	is incremented if kernel fails to allocate
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 88d98241a635..5c83a424803a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -163,7 +163,6 @@ static bool get_huge_zero_page(void)
 		count_vm_event(THP_ZERO_PAGE_ALLOC_FAILED);
 		return false;
 	}
-	count_vm_event(THP_ZERO_PAGE_ALLOC);
 	preempt_disable();
 	if (cmpxchg(&huge_zero_page, NULL, zero_page)) {
 		preempt_enable();
@@ -175,6 +174,7 @@ static bool get_huge_zero_page(void)
 	/* We take additional reference here. It will be put back by shrinker */
 	atomic_set(&huge_zero_refcount, 2);
 	preempt_enable();
+	count_vm_event(THP_ZERO_PAGE_ALLOC);
 	return true;
 }
 
-- 
2.25.1

