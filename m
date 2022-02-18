Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F864BB56A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 10:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbiBRJWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 04:22:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbiBRJVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 04:21:54 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD4524BC6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 01:21:36 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4K0R1x48CCz8wmw;
        Fri, 18 Feb 2022 17:18:13 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 18 Feb
 2022 17:21:34 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/hwpoison-inject: support injecting hwpoison to free page
Date:   Fri, 18 Feb 2022 17:20:52 +0800
Message-ID: <20220218092052.3853-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

memory_failure() can handle free buddy page. Support injecting hwpoison
to free page by adding is_free_buddy_page check when hwpoison filter is
disabled.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/hwpoison-inject.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/hwpoison-inject.c b/mm/hwpoison-inject.c
index aff4d27ec235..f74552977649 100644
--- a/mm/hwpoison-inject.c
+++ b/mm/hwpoison-inject.c
@@ -32,9 +32,9 @@ static int hwpoison_inject(void *data, u64 val)
 
 	shake_page(hpage);
 	/*
-	 * This implies unable to support non-LRU pages.
+	 * This implies unable to support non-LRU pages except free page.
 	 */
-	if (!PageLRU(hpage) && !PageHuge(p))
+	if (!PageLRU(hpage) && !PageHuge(p) && !is_free_buddy_page(p))
 		return 0;
 
 	/*
-- 
2.23.0

