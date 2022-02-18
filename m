Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F4C4BB4DC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 10:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbiBRJDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 04:03:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbiBRJCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 04:02:30 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE68F55BF6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 01:02:10 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4K0Qf50lqlzbkTD;
        Fri, 18 Feb 2022 17:01:01 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 18 Feb
 2022 17:02:08 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v3 4/8] mm/memory-failure.c: fix race with changing page more robustly
Date:   Fri, 18 Feb 2022 17:01:14 +0800
Message-ID: <20220218090118.1105-5-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220218090118.1105-1-linmiaohe@huawei.com>
References: <20220218090118.1105-1-linmiaohe@huawei.com>
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

We're only intended to deal with the non-Compound page after we split thp
in memory_failure. However, the page could have changed compound pages due
to race window. If this happens, we could retry once to hopefully handle
the page next round. Also remove unneeded orig_head. It's always equal to
the hpage. So we can use hpage directly and remove this redundant one.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 7e205d91b2d7..2ca50cfa601f 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1690,7 +1690,6 @@ int memory_failure(unsigned long pfn, int flags)
 {
 	struct page *p;
 	struct page *hpage;
-	struct page *orig_head;
 	struct dev_pagemap *pgmap;
 	int res = 0;
 	unsigned long page_flags;
@@ -1736,7 +1735,7 @@ int memory_failure(unsigned long pfn, int flags)
 		goto unlock_mutex;
 	}
 
-	orig_head = hpage = compound_head(p);
+	hpage = compound_head(p);
 	num_poisoned_pages_inc();
 
 	/*
@@ -1817,10 +1816,21 @@ int memory_failure(unsigned long pfn, int flags)
 	lock_page(p);
 
 	/*
-	 * The page could have changed compound pages during the locking.
-	 * If this happens just bail out.
+	 * We're only intended to deal with the non-Compound page here.
+	 * However, the page could have changed compound pages due to
+	 * race window. If this happens, we could try again to hopefully
+	 * handle the page next round.
 	 */
-	if (PageCompound(p) && compound_head(p) != orig_head) {
+	if (PageCompound(p)) {
+		if (retry) {
+			if (TestClearPageHWPoison(p))
+				num_poisoned_pages_dec();
+			unlock_page(p);
+			put_page(p);
+			flags &= ~MF_COUNT_INCREASED;
+			retry = false;
+			goto try_again;
+		}
 		action_result(pfn, MF_MSG_DIFFERENT_COMPOUND, MF_IGNORED);
 		res = -EBUSY;
 		goto unlock_page;
-- 
2.23.0

