Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD335551EF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 19:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376498AbiFVRHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 13:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377029AbiFVRGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 13:06:42 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A033EF39
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:06:36 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LSqVf5hGkz1KC7p;
        Thu, 23 Jun 2022 01:04:26 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 23 Jun
 2022 01:06:33 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <shy828301@gmail.com>, <willy@infradead.org>, <zokeefe@google.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 14/16] mm/huge_memory: fix comment of page_deferred_list
Date:   Thu, 23 Jun 2022 01:06:25 +0800
Message-ID: <20220622170627.19786-15-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220622170627.19786-1-linmiaohe@huawei.com>
References: <20220622170627.19786-1-linmiaohe@huawei.com>
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

The current comment is confusing because if global or memcg deferred list
in the second tail page is occupied by compound_head, why we still use
page[2].deferred_list here? I think it wants to say that Global or memcg
deferred list in the first tail page is occupied by compound_mapcount and
compound_pincount so we use the second tail page's deferred_list instead.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/huge_mm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 12b297f9951d..2e8062b3417a 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -294,8 +294,8 @@ static inline bool thp_migration_supported(void)
 static inline struct list_head *page_deferred_list(struct page *page)
 {
 	/*
-	 * Global or memcg deferred list in the second tail pages is
-	 * occupied by compound_head.
+	 * Global or memcg deferred list in the first tail page is
+	 * occupied by compound_mapcount and compound_pincount.
 	 */
 	return &page[2].deferred_list;
 }
-- 
2.23.0

