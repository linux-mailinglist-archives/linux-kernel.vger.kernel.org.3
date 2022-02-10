Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9254B103B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 15:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242848AbiBJOV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 09:21:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242811AbiBJOVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 09:21:18 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58ABB27C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 06:21:17 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Jvf643BNwzbk7H;
        Thu, 10 Feb 2022 22:20:12 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 10 Feb
 2022 22:21:14 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 1/8] mm/memory-failure.c: minor clean up for memory_failure_dev_pagemap
Date:   Thu, 10 Feb 2022 22:17:26 +0800
Message-ID: <20220210141733.1908-2-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220210141733.1908-1-linmiaohe@huawei.com>
References: <20220210141733.1908-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

The flags always has MF_ACTION_REQUIRED and MF_MUST_KILL set. So we do
not need to check these flags again.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 55edb0cc3848..b3ff7e99a421 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1644,7 +1644,7 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 	 * SIGBUS (i.e. MF_MUST_KILL)
 	 */
 	flags |= MF_ACTION_REQUIRED | MF_MUST_KILL;
-	collect_procs(page, &tokill, flags & MF_ACTION_REQUIRED);
+	collect_procs(page, &tokill, true);
 
 	list_for_each_entry(tk, &tokill, nd)
 		if (tk->size_shift)
@@ -1659,7 +1659,7 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 		start = (page->index << PAGE_SHIFT) & ~(size - 1);
 		unmap_mapping_range(page->mapping, start, size, 0);
 	}
-	kill_procs(&tokill, flags & MF_MUST_KILL, false, pfn, flags);
+	kill_procs(&tokill, true, false, pfn, flags);
 	rc = 0;
 unlock:
 	dax_unlock_page(page, cookie);
-- 
2.23.0

