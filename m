Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FED64FA688
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 11:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240756AbiDIJg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 05:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241153AbiDIJgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 05:36:38 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA927AFAD1
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 02:34:32 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Kb9145pSrz1HBTl;
        Sat,  9 Apr 2022 17:34:00 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 9 Apr
 2022 17:34:30 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <ying.huang@intel.com>, <songmuchun@bytedance.com>,
        <hch@infradead.org>, <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2 4/9] mm/vmscan: save a bit of stack space in shrink_lruvec
Date:   Sat, 9 Apr 2022 17:34:55 +0800
Message-ID: <20220409093500.10329-5-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220409093500.10329-1-linmiaohe@huawei.com>
References: <20220409093500.10329-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

LRU_UNEVICTABLE is not taken into account when shrink lruvec. So we can
save a bit of stack space by shrinking the array size of nr and targets
to NR_LRU_LISTS - 1. No functional change intended.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/vmscan.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 59b96320f481..0e5818970998 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2881,8 +2881,9 @@ static bool can_age_anon_pages(struct pglist_data *pgdat,
 
 static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 {
-	unsigned long nr[NR_LRU_LISTS];
-	unsigned long targets[NR_LRU_LISTS];
+	/* LRU_UNEVICTABLE is not taken into account. */
+	unsigned long nr[NR_LRU_LISTS - 1];
+	unsigned long targets[NR_LRU_LISTS - 1];
 	unsigned long nr_to_scan;
 	enum lru_list lru;
 	unsigned long nr_reclaimed = 0;
-- 
2.23.0

