Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89435A7369
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 03:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbiHaBfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 21:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbiHaBfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 21:35:32 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDDD4621F
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 18:35:17 -0700 (PDT)
Received: from kwepemi500002.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MHRTS3HsXz1N7RW;
        Wed, 31 Aug 2022 09:31:08 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemi500002.china.huawei.com (7.221.188.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 31 Aug 2022 09:34:46 +0800
From:   Ze Zuo <zuoze1@huawei.com>
To:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     <wangkefeng.wang@huawei.com>, zezuo <zuoze1@huawei.com>
Subject: [PATCH-next] mm:delete a redundant parameter of rmqueue_pcplist
Date:   Wed, 31 Aug 2022 01:34:04 +0000
Message-ID: <20220831013404.3360714-1-zuoze1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500002.china.huawei.com (7.221.188.171)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zezuo <zuoze1@huawei.com>

The gfp_flags parameter is not used in rmqueue_pcplist, so
directly delete this parameter.

Signed-off-by: zezuo <zuoze1@huawei.com>
---
 mm/page_alloc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 40bfc6b29014..7333cd75bdd5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3779,8 +3779,7 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 /* Lock and remove page from the per-cpu list */
 static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 			struct zone *zone, unsigned int order,
-			gfp_t gfp_flags, int migratetype,
-			unsigned int alloc_flags)
+			int migratetype, unsigned int alloc_flags)
 {
 	struct per_cpu_pages *pcp;
 	struct list_head *list;
@@ -3841,7 +3840,7 @@ struct page *rmqueue(struct zone *preferred_zone,
 		if (!IS_ENABLED(CONFIG_CMA) || alloc_flags & ALLOC_CMA ||
 				migratetype != MIGRATE_MOVABLE) {
 			page = rmqueue_pcplist(preferred_zone, zone, order,
-					gfp_flags, migratetype, alloc_flags);
+					migratetype, alloc_flags);
 			if (likely(page))
 				goto out;
 		}
-- 
2.25.1

