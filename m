Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9B44CD122
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 10:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238001AbiCDJgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 04:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237246AbiCDJfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 04:35:50 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDEA7307E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 01:35:03 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4K92jM4PLQzdbB0;
        Fri,  4 Mar 2022 17:33:43 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 4 Mar
 2022 17:35:01 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <mike.kravetz@oracle.com>, <shy828301@gmail.com>,
        <willy@infradead.org>, <ying.huang@intel.com>, <ziy@nvidia.com>,
        <minchan@kernel.org>, <apopple@nvidia.com>,
        <ave.hansen@linux.intel.com>, <o451686892@gmail.com>,
        <almasrymina@google.com>, <jhubbard@nvidia.com>,
        <rcampbell@nvidia.com>, <peterx@redhat.com>,
        <naoya.horiguchi@nec.com>, <mhocko@suse.com>, <riel@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 05/16] mm/migration: fix the confusing PageTransHuge check
Date:   Fri, 4 Mar 2022 17:33:58 +0800
Message-ID: <20220304093409.25829-6-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220304093409.25829-1-linmiaohe@huawei.com>
References: <20220304093409.25829-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

prep_transhuge_page should be called when PageTransHuge(page) is true.
The newly allocated new_page is not yet PageTransHuge though it could
pass the check as PageTransHuge only checks PageHead now.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 26943bd819e8..15cac2dabc93 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1560,7 +1560,7 @@ struct page *alloc_migration_target(struct page *page, unsigned long private)
 
 	new_page = __alloc_pages(gfp_mask, order, nid, mtc->nmask);
 
-	if (new_page && PageTransHuge(new_page))
+	if (new_page && PageTransHuge(page))
 		prep_transhuge_page(new_page);
 
 	return new_page;
-- 
2.23.0

