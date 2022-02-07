Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5C54AC035
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 14:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389217AbiBGNvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 08:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387669AbiBGNiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 08:38:02 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C562C0401D4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 05:37:24 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JsnCD2jbDzZfPd;
        Mon,  7 Feb 2022 21:33:12 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 7 Feb
 2022 21:37:22 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 2/4] mm/memory_hotplug: avoid calling zone_intersects() for ZONE_NORMAL
Date:   Mon, 7 Feb 2022 21:36:41 +0800
Message-ID: <20220207133643.23427-3-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220207133643.23427-1-linmiaohe@huawei.com>
References: <20220207133643.23427-1-linmiaohe@huawei.com>
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

If zid reaches ZONE_NORMAL, the caller will always get the NORMAL zone no
matter what zone_intersects() returns. So we can save some possible cpu
cycles by avoid calling zone_intersects() for ZONE_NORMAL.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory_hotplug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index cbc67c27e0dd..140809e60e9a 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -826,7 +826,7 @@ static struct zone *default_kernel_zone_for_pfn(int nid, unsigned long start_pfn
 	struct pglist_data *pgdat = NODE_DATA(nid);
 	int zid;
 
-	for (zid = 0; zid <= ZONE_NORMAL; zid++) {
+	for (zid = 0; zid < ZONE_NORMAL; zid++) {
 		struct zone *zone = &pgdat->node_zones[zid];
 
 		if (zone_intersects(zone, start_pfn, nr_pages))
-- 
2.23.0

