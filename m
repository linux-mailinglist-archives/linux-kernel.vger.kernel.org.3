Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6535390AE
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 14:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344242AbiEaM0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 08:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbiEaM0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 08:26:35 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1543165406
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 05:26:35 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LCBMz0BLCzDqWB;
        Tue, 31 May 2022 20:26:23 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 31 May
 2022 20:26:32 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <anshuman.khandual@arm.com>, <david@redhat.com>,
        <osalvador@suse.de>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH] mm/memremap: fix missing call to untrack_pfn() in pagemap_range()
Date:   Tue, 31 May 2022 20:26:43 +0800
Message-ID: <20220531122643.25249-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

We forget to call untrack_pfn() to pair with track_pfn_remap() when range
is not allowed to hotplug. Fix it by jump err_kasan.

Fixes: bca3feaa0764 ("mm/memory_hotplug: prevalidate the address range being added with platform")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memremap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memremap.c b/mm/memremap.c
index 2b92e97cb25b..b870a659eee6 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -214,7 +214,7 @@ static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
 
 	if (!mhp_range_allowed(range->start, range_len(range), !is_private)) {
 		error = -EINVAL;
-		goto err_pfn_remap;
+		goto err_kasan;
 	}
 
 	mem_hotplug_begin();
-- 
2.23.0

