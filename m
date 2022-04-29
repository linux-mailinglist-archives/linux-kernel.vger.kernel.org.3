Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A4251450E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 11:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356250AbiD2JJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 05:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349144AbiD2JJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 05:09:06 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519D04DF79
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 02:05:48 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KqRQR6mG0zhYtW;
        Fri, 29 Apr 2022 17:05:03 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 17:05:24 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <cl@linux.com>, <penberg@kernel.org>, <rientjes@google.com>,
        <iamjoonsoo.kim@lge.com>, <akpm@linux-foundation.org>,
        <vbabka@suse.cz>
CC:     <roman.gushchin@linux.dev>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH] mm/slub: remove unused kmem_cache_order_objects max
Date:   Fri, 29 Apr 2022 17:05:45 +0800
Message-ID: <20220429090545.33413-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

max field holds the largest slab order that was ever used for a slab cache.
But it's unused now. Remove it.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/slub_def.h | 1 -
 mm/slub.c                | 2 --
 2 files changed, 3 deletions(-)

diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
index 33c5c0e3bd8d..f9c68a9dac04 100644
--- a/include/linux/slub_def.h
+++ b/include/linux/slub_def.h
@@ -105,7 +105,6 @@ struct kmem_cache {
 	struct kmem_cache_order_objects oo;
 
 	/* Allocation and freeing of slabs */
-	struct kmem_cache_order_objects max;
 	struct kmem_cache_order_objects min;
 	gfp_t allocflags;	/* gfp flags to use on each alloc */
 	int refcount;		/* Refcount for slab cache destroy */
diff --git a/mm/slub.c b/mm/slub.c
index 1f699ddfff7f..e5535020e0fd 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4162,8 +4162,6 @@ static int calculate_sizes(struct kmem_cache *s)
 	 */
 	s->oo = oo_make(order, size);
 	s->min = oo_make(get_order(size), size);
-	if (oo_objects(s->oo) > oo_objects(s->max))
-		s->max = s->oo;
 
 	return !!oo_objects(s->oo);
 }
-- 
2.23.0

