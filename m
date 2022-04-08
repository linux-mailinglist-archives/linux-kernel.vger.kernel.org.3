Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93754F8C0B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 05:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbiDHC0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 22:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbiDHC0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 22:26:42 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945902D9A02
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 19:24:40 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KZMWY6BnvzdZR6;
        Fri,  8 Apr 2022 10:24:09 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 8 Apr
 2022 10:24:38 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <akpm@linux-foundation.org>, <sfr@canb.auug.org.au>,
        <osalvador@suse.de>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] mm/memory_hotplug: Fix build warning without CONFIG_MEMORY_HOTREMOVE
Date:   Fri, 8 Apr 2022 10:24:02 +0800
Message-ID: <20220408022402.29668-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mm/memory_hotplug.c:1148:13: warning: ‘reset_node_present_pages’ defined but not used [-Wunused-function]
 1148 | static void reset_node_present_pages(pg_data_t *pgdat)
      |             ^~~~~~~~~~~~~~~~~~~~~~~~

reset_node_present_pages() now only used in node_reset_state(),move it
inside the ifdef block to fix this warning.

Fixes: 0d540af7befe ("mm/memory_hotplug: reset node's state when empty during offline")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 mm/memory_hotplug.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 74430f88853d..925359655f4d 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1145,16 +1145,6 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 	return ret;
 }
 
-static void reset_node_present_pages(pg_data_t *pgdat)
-{
-	struct zone *z;
-
-	for (z = pgdat->node_zones; z < pgdat->node_zones + MAX_NR_ZONES; z++)
-		z->present_pages = 0;
-
-	pgdat->node_present_pages = 0;
-}
-
 static void hotadd_init_pgdat(int nid)
 {
 	struct pglist_data *pgdat = NODE_DATA(nid);
@@ -1748,6 +1738,16 @@ static void node_states_clear_node(int node, struct memory_notify *arg)
 		node_clear_state(node, N_MEMORY);
 }
 
+static void reset_node_present_pages(pg_data_t *pgdat)
+{
+	struct zone *z;
+
+	for (z = pgdat->node_zones; z < pgdat->node_zones + MAX_NR_ZONES; z++)
+		z->present_pages = 0;
+
+	pgdat->node_present_pages = 0;
+}
+
 static void node_reset_state(int node)
 {
 	pg_data_t *pgdat = NODE_DATA(node);
-- 
2.17.1

