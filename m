Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0937C4DE717
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 09:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242520AbiCSIji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 04:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbiCSIjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 04:39:36 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A452BE2D0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 01:38:14 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KLDmK5VnlzcZyB;
        Sat, 19 Mar 2022 16:38:09 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Sat, 19 Mar
 2022 16:38:12 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>,
        <shy828301@gmail.com>, <mike.kravetz@oracle.com>,
        <david@redhat.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v4 1/2] mm/memory-failure.c: avoid calling invalidate_inode_page() with unexpected pages
Date:   Sun, 20 Mar 2022 13:13:33 +0800
Message-ID: <20220320051334.44502-2-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220320051334.44502-1-linmiaohe@huawei.com>
References: <20220320051334.44502-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

invalidate_inode_page() can invalidate the pages in the swap cache because
the check of page->mapping != mapping is removed via Matthew's patch titled
"mm/truncate: Inline invalidate_complete_page() into its one caller". But
invalidate_inode_page() is not expected to deal with the pages in the swap
cache. Also non-lru movable page can reach here too. They're not page cache
pages. Skip these pages by checking PageSwapCache and PageLRU to fix this
unexpected issue.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 5444a8ef4867..ecf45961f3b6 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2178,7 +2178,7 @@ static int __soft_offline_page(struct page *page)
 		return 0;
 	}
 
-	if (!PageHuge(page))
+	if (!PageHuge(page) && PageLRU(page) && !PageSwapCache(page))
 		/*
 		 * Try to invalidate first. This should work for
 		 * non dirty unmapped page cache pages.
-- 
2.23.0

