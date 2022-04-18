Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9066C505AC1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243227AbiDRPRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243332AbiDRPPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:15:42 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A256B918D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 07:12:31 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KhplQ1Dpwz1GCSG;
        Mon, 18 Apr 2022 22:11:46 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 18 Apr
 2022 22:12:28 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <vbabka@suse.cz>, <pintu@codeaurora.org>,
        <charante@codeaurora.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 03/12] mm: compaction: remove unneeded assignment to isolate_start_pfn
Date:   Mon, 18 Apr 2022 22:12:44 +0800
Message-ID: <20220418141253.24298-4-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220418141253.24298-1-linmiaohe@huawei.com>
References: <20220418141253.24298-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

isolate_start_pfn is unused when cc->nr_freepages ! = 0. Otherwise
cc->free_pfn will overwrite it unconditionally. So we should remove
this unneeded and somewhat misleading assignment.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/compaction.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index f9e628a5306a..ee2ddf77191f 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1586,7 +1586,7 @@ static void isolate_freepages(struct compact_control *cc)
 	unsigned int stride;
 
 	/* Try a small search of the free lists for a candidate */
-	isolate_start_pfn = fast_isolate_freepages(cc);
+	fast_isolate_freepages(cc);
 	if (cc->nr_freepages)
 		goto splitmap;
 
-- 
2.23.0

