Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27DEA480F36
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 04:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238503AbhL2DVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 22:21:52 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:17310 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238492AbhL2DVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 22:21:51 -0500
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JNxW93HPSz91cp;
        Wed, 29 Dec 2021 11:20:53 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 29 Dec 2021 11:21:49 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 29 Dec 2021 11:21:48 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <akpm@linux-foundation.org>, <vbabka@suse.cz>,
        <iamjoonsoo.kim@lge.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     <wangkefeng.wang@huawei.com>
Subject: [PATCH] mm/page_isolation: unset migratetype directly for non Buddy page
Date:   Wed, 29 Dec 2021 11:36:49 +0800
Message-ID: <20211229033649.2760586-1-chenwandun@huawei.com>
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

There is no need to try to move_freepages_block for pages that is not
in buddy in function unset_migratetype_isolate, it can directly set
migrate type.

It will save a few cpu cycles for some situations such as cma and
hugetlb when allocating continue pages, in these situation function
alloc_contig_pages will be called.

alloc_contig_pages
	__alloc_contig_migrate_range
	isolate_freepages_range ==> pages has been remove from buddy
	undo_isolate_page_range
		unset_migratetype_isolate ==> can directly set migratetype

Fixes: 3c605096d315 ("mm/page_alloc: restrict max order of merging on isolated pageblock")
Signed-off-by: Chen Wandun <chenwandun@huawei.com>
---
 mm/page_isolation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index f67c4c70f17f..6a0ddda6b3c5 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -115,7 +115,7 @@ static void unset_migratetype_isolate(struct page *page, unsigned migratetype)
 	 * onlining - just onlined memory won't immediately be considered for
 	 * allocation.
 	 */
-	if (!isolated_page) {
+	if (!isolated_page && PageBuddy(page)) {
 		nr_pages = move_freepages_block(zone, page, migratetype, NULL);
 		__mod_zone_freepage_state(zone, nr_pages, migratetype);
 	}
-- 
2.18.0.huawei.25

