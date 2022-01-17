Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6498490A0E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 15:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234993AbiAQOMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 09:12:47 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:31099 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234397AbiAQOMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 09:12:46 -0500
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Jcv0F5Gl5z1FClb;
        Mon, 17 Jan 2022 22:09:01 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 17 Jan 2022 22:12:44 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 17 Jan 2022 22:12:44 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <guillaume.tucker@collabora.com>
Subject: [PATCH] Revert "mm/page_isolation: unset migratetype directly for non Buddy page"
Date:   Mon, 17 Jan 2022 22:27:12 +0800
Message-ID: <20220117142712.3967624-1-chenwandun@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 075782149abff45ee22f27315eced44d02b96779.

commit 075782149abf ("mm/page_isolation: unset migratetype directly for
non Buddy page") will result memory that should in buddy disappear by
mistake. move_freepages_block move all pages in pageblock instead of
pages indicated by input parameter, so if input pages is not in buddy
but other pages in pageblock is in buddy, it will result in page out of
control.

Reported-by: "kernelci.org bot" <bot@kernelci.org>
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

