Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75394E3DB8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 12:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbiCVLjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 07:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbiCVLi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 07:38:58 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D11B83007
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 04:37:31 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KN8Z50YpqzfYqb;
        Tue, 22 Mar 2022 19:35:57 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Mar 2022 19:37:29 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Mar 2022 19:37:29 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>
Subject: [PATCH] mm/page_alloc: simplify update of pgdat in wake_all_kswapds
Date:   Tue, 22 Mar 2022 19:56:35 +0800
Message-ID: <20220322115635.2708989-1-chenwandun@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to update last_pgdat for each zone,
only update last_pgdat when iterating the first zone
of a node.

Signed-off-by: Chen Wandun <chenwandun@huawei.com>
---
 mm/page_alloc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f648decfe39d..ea282630aedc 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4674,9 +4674,10 @@ static void wake_all_kswapds(unsigned int order, gfp_t gfp_mask,
 
 	for_each_zone_zonelist_nodemask(zone, z, ac->zonelist, highest_zoneidx,
 					ac->nodemask) {
-		if (last_pgdat != zone->zone_pgdat)
+		if (last_pgdat != zone->zone_pgdat) {
 			wakeup_kswapd(zone, gfp_mask, order, highest_zoneidx);
-		last_pgdat = zone->zone_pgdat;
+			last_pgdat = zone->zone_pgdat;
+		}
 	}
 }
 
-- 
2.18.0.huawei.25

