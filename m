Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D4F55E49B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346537AbiF1Nb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346149AbiF1NaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:30:09 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033D22AC73
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:28:51 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LXQNP5pndz1L8h8;
        Tue, 28 Jun 2022 21:26:29 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 28 Jun
 2022 21:28:44 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <shy828301@gmail.com>, <willy@infradead.org>, <zokeefe@google.com>,
        <songmuchun@bytedance.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2 13/16] mm/huge_memory: fix comment of page_deferred_list
Date:   Tue, 28 Jun 2022 21:28:32 +0800
Message-ID: <20220628132835.8925-14-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220628132835.8925-1-linmiaohe@huawei.com>
References: <20220628132835.8925-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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
index 12b297f9951d..37f2f11a6d7e 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -294,8 +294,8 @@ static inline bool thp_migration_supported(void)
 static inline struct list_head *page_deferred_list(struct page *page)
 {
 	/*
-	 * Global or memcg deferred list in the second tail pages is
-	 * occupied by compound_head.
+	 * See organization of tail pages of compound page in
+	 * "struct page" definition.
 	 */
 	return &page[2].deferred_list;
 }
-- 
2.23.0

