Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC65E59CF7D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 05:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240084AbiHWDYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 23:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239502AbiHWDYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 23:24:24 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807AE51A2F
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 20:24:23 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MBZHn2SrszgYpq;
        Tue, 23 Aug 2022 11:20:53 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 23 Aug
 2022 11:24:21 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2 6/6] mm, hwpoison: avoid trying to unpoison reserved page
Date:   Tue, 23 Aug 2022 11:23:46 +0800
Message-ID: <20220823032346.4260-7-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220823032346.4260-1-linmiaohe@huawei.com>
References: <20220823032346.4260-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

For reserved pages, HWPoison flag will be set without increasing the page
refcnt. So we shouldn't even try to unpoison these pages and thus decrease
the page refcnt unexpectly. Add a PageReserved() check to filter this case
out and remove the below unneeded zero page (zero page is reserved) check.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 mm/memory-failure.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index c2910f9af1d4..f3ff2515ccc6 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2351,7 +2351,7 @@ int unpoison_memory(unsigned long pfn)
 		goto unlock_mutex;
 	}
 
-	if (PageSlab(page) || PageTable(page))
+	if (PageSlab(page) || PageTable(page) || PageReserved(page))
 		goto unlock_mutex;
 
 	ret = get_hwpoison_page(p, MF_UNPOISON);
@@ -2382,7 +2382,7 @@ int unpoison_memory(unsigned long pfn)
 		freeit = !!TestClearPageHWPoison(p);
 
 		put_page(page);
-		if (freeit && !(pfn == my_zero_pfn(0) && page_count(p) == 1)) {
+		if (freeit) {
 			put_page(page);
 			ret = 0;
 		}
-- 
2.23.0

