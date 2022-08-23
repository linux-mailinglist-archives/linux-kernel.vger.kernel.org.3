Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E6659CF74
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 05:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239595AbiHWDY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 23:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbiHWDYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 23:24:22 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A1252092
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 20:24:21 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MBZHl13FYzgYpg;
        Tue, 23 Aug 2022 11:20:51 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 23 Aug
 2022 11:24:19 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2 1/6] mm, hwpoison: fix page refcnt leaking in try_memory_failure_hugetlb()
Date:   Tue, 23 Aug 2022 11:23:41 +0800
Message-ID: <20220823032346.4260-2-linmiaohe@huawei.com>
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

When hwpoison_filter() refuses to hwpoison a hugetlb page, the refcnt of
the page would have been incremented if res == 1. Using put_page() to fix
the refcnt leaking in this case.

Fixes: 405ce051236c ("mm/hwpoison: fix race between hugetlb free/demotion and memory_failure_hugetlb()")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 mm/memory-failure.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 5b368124956d..9d1ebfef04ee 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1860,8 +1860,10 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 
 	if (hwpoison_filter(p)) {
 		hugetlb_clear_page_hwpoison(head);
-		res = -EOPNOTSUPP;
-		goto out;
+		unlock_page(head);
+		if (res == 1)
+			put_page(head);
+		return -EOPNOTSUPP;
 	}
 
 	/*
-- 
2.23.0

