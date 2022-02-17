Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA814BA299
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 15:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241168AbiBQOIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 09:08:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiBQOIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 09:08:52 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4421BBF42
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 06:08:38 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JzxV913MBzbnbd;
        Thu, 17 Feb 2022 22:07:29 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 17 Feb
 2022 22:08:35 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <rppt@kernel.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] memblock: remove unneeded local variable nid
Date:   Thu, 17 Feb 2022 22:07:54 +0800
Message-ID: <20220217140754.1026-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

The nid is only used to act as output parameter of __next_mem_range.
Since NULL can be passed to __next_mem_range as out_nid, we can thus
remove nid by passing NULL here.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memblock.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 1018e50566f3..11561bbff8f5 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1278,11 +1278,10 @@ __next_mem_pfn_range_in_zone(u64 *idx, struct zone *zone,
 {
 	int zone_nid = zone_to_nid(zone);
 	phys_addr_t spa, epa;
-	int nid;
 
 	__next_mem_range(idx, zone_nid, MEMBLOCK_NONE,
 			 &memblock.memory, &memblock.reserved,
-			 &spa, &epa, &nid);
+			 &spa, &epa, NULL);
 
 	while (*idx != U64_MAX) {
 		unsigned long epfn = PFN_DOWN(epa);
@@ -1309,7 +1308,7 @@ __next_mem_pfn_range_in_zone(u64 *idx, struct zone *zone,
 
 		__next_mem_range(idx, zone_nid, MEMBLOCK_NONE,
 				 &memblock.memory, &memblock.reserved,
-				 &spa, &epa, &nid);
+				 &spa, &epa, NULL);
 	}
 
 	/* signal end of iteration */
-- 
2.23.0

