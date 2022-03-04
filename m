Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84874CD123
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 10:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237541AbiCDJgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 04:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237368AbiCDJfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 04:35:47 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCAE18886B
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 01:35:00 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4K92jH597Xzdb9v;
        Fri,  4 Mar 2022 17:33:39 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 4 Mar
 2022 17:34:57 +0800
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
Subject: [PATCH 01/16] mm/migration: remove unneeded local variable mapping_locked
Date:   Fri, 4 Mar 2022 17:33:54 +0800
Message-ID: <20220304093409.25829-2-linmiaohe@huawei.com>
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

When mapping_locked is true, TTU_RMAP_LOCKED is always set to ttu. We can
check ttu instead so mapping_locked can be removed. And ttu is either 0
or TTU_RMAP_LOCKED now. Change '|=' to '=' to reflect this.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/migrate.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 42e3a944f35c..50bc62d85eaf 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1230,7 +1230,6 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 		goto put_anon;
 
 	if (page_mapped(hpage)) {
-		bool mapping_locked = false;
 		enum ttu_flags ttu = 0;
 
 		if (!PageAnon(hpage)) {
@@ -1244,14 +1243,13 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 			if (unlikely(!mapping))
 				goto unlock_put_anon;
 
-			mapping_locked = true;
-			ttu |= TTU_RMAP_LOCKED;
+			ttu = TTU_RMAP_LOCKED;
 		}
 
 		try_to_migrate(src, ttu);
 		page_was_mapped = 1;
 
-		if (mapping_locked)
+		if (ttu & TTU_RMAP_LOCKED)
 			i_mmap_unlock_write(mapping);
 	}
 
-- 
2.23.0

