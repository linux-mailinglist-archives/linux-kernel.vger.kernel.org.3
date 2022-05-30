Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E005379E8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 13:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235813AbiE3LaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 07:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235792AbiE3LaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 07:30:10 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE05C7E1FA
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:30:09 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LBY5z2Jh3zRhSd;
        Mon, 30 May 2022 19:27:03 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 30 May
 2022 19:30:07 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <peterx@redhat.com>, <apopple@nvidia.com>, <ying.huang@intel.com>,
        <osalvador@suse.de>, <mike.kravetz@oracle.com>,
        <songmuchun@bytedance.com>, <hch@lst.de>, <dhowells@redhat.com>,
        <cl@linux.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v4 2/4] mm/migration: remove unneeded lock page and PageMovable check
Date:   Mon, 30 May 2022 19:30:14 +0800
Message-ID: <20220530113016.16663-3-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220530113016.16663-1-linmiaohe@huawei.com>
References: <20220530113016.16663-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When non-lru movable page was freed from under us, __ClearPageMovable must
have been done.  So we can remove unneeded lock page and PageMovable check
here. Also free_pages_prepare() will clear PG_isolated for us, so we can
further remove ClearPageIsolated as suggested by David.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
---
 mm/migrate.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index e88ebb88fa6f..337336115e43 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1090,15 +1090,10 @@ static int unmap_and_move(new_page_t get_new_page,
 		return -ENOSYS;
 
 	if (page_count(page) == 1) {
-		/* page was freed from under us. So we are done. */
+		/* Page was freed from under us. So we are done. */
 		ClearPageActive(page);
 		ClearPageUnevictable(page);
-		if (unlikely(__PageMovable(page))) {
-			lock_page(page);
-			if (!PageMovable(page))
-				ClearPageIsolated(page);
-			unlock_page(page);
-		}
+		/* free_pages_prepare() will clear PG_isolated. */
 		goto out;
 	}
 
-- 
2.23.0

