Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E221E50DE8D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 13:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241700AbiDYLPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 07:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241705AbiDYLPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 07:15:42 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C222A279
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 04:12:11 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Kn2Kk5yjbzCsKn;
        Mon, 25 Apr 2022 19:07:38 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 19:12:09 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <ying.huang@intel.com>, <iamjoonsoo.kim@lge.com>, <hch@lst.de>,
        <osalvador@suse.de>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v3 1/6] mm/vmscan: add a comment about MADV_FREE pages check in folio_check_dirty_writeback
Date:   Mon, 25 Apr 2022 19:12:27 +0800
Message-ID: <20220425111232.23182-2-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220425111232.23182-1-linmiaohe@huawei.com>
References: <20220425111232.23182-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MADV_FREE pages check in folio_check_dirty_writeback is a bit hard to
follow. Add a comment to make the code clear.

Suggested-by: Huang, Ying <ying.huang@intel.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
---
 mm/vmscan.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 99a572f01cb4..913eb565140c 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1438,7 +1438,10 @@ static void folio_check_dirty_writeback(struct folio *folio,
 
 	/*
 	 * Anonymous pages are not handled by flushers and must be written
-	 * from reclaim context. Do not stall reclaim based on them
+	 * from reclaim context. Do not stall reclaim based on them.
+	 * MADV_FREE anonymous pages are put into inactive file list too.
+	 * They could be mistakenly treated as file lru. So further anon
+	 * test is needed.
 	 */
 	if (!folio_is_file_lru(folio) ||
 	    (folio_test_anon(folio) && !folio_test_swapbacked(folio))) {
-- 
2.23.0

