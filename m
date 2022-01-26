Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6896449C14C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 03:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236369AbiAZC0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 21:26:36 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:16738 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236358AbiAZC0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 21:26:34 -0500
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Jk6v31SbWzZfM2;
        Wed, 26 Jan 2022 10:22:39 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 26 Jan 2022 10:26:33 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 26 Jan 2022 10:26:32 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <david@redhat.com>,
        <aisheng.dong@nxp.com>, <francesco.dolcini@toradex.com>,
        <vbabka@suse.cz>
CC:     <chenwandun@huawei.com>
Subject: [PATCH v2] Revert "mm/page_isolation: unset migratetype directly for non Buddy page"
Date:   Wed, 26 Jan 2022 10:44:36 +0800
Message-ID: <20220126024436.13921-1-chenwandun@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 721fb891ad0b3956d5c168b2931e3e5e4fb7ca40.

commit 721fb891ad0b ("mm/page_isolation: unset migratetype directly for
non Buddy page") will result memory that should in buddy disappear by
mistake. move_freepages_block move all pages in pageblock instead of
pages indicated by input parameter, so if input pages is not in buddy
but other pages in pageblock is in buddy, it will result in page out of
control.

Reported-by: "kernelci.org bot" <bot@kernelci.org>
Acked-by: David Hildenbrand <david@redhat.com>
Tested-by: Dong Aisheng <aisheng.dong@nxp.com>
Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Fixes: 721fb891ad0b ("mm/page_isolation: unset migratetype directly for non Buddy page")
Signed-off-by: Chen Wandun <chenwandun@huawei.com>
---
 mm/page_isolation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 6a0ddda6b3c5..f67c4c70f17f 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -115,7 +115,7 @@ static void unset_migratetype_isolate(struct page *page, unsigned migratetype)
 	 * onlining - just onlined memory won't immediately be considered for
 	 * allocation.
 	 */
-	if (!isolated_page && PageBuddy(page)) {
+	if (!isolated_page) {
 		nr_pages = move_freepages_block(zone, page, migratetype, NULL);
 		__mod_zone_freepage_state(zone, nr_pages, migratetype);
 	}
-- 
2.18.0.huawei.25

