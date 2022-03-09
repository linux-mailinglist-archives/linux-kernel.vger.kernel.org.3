Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56524D2BB3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 10:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbiCIJW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 04:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbiCIJW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 04:22:26 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA381662E8
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 01:21:27 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KD65J6dCKz1GCJ4;
        Wed,  9 Mar 2022 17:16:36 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 9 Mar
 2022 17:21:25 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <cl@linux.com>, <penberg@kernel.org>,
        <rientjes@google.com>, <iamjoonsoo.kim@lge.com>, <vbabka@suse.cz>
CC:     <roman.gushchin@linux.dev>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH] mm/slub: remove forced_order parameter in calculate_sizes
Date:   Wed, 9 Mar 2022 17:20:36 +0800
Message-ID: <20220309092036.50844-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

Since commit 32a6f409b693 ("mm, slub: remove runtime allocation order
changes"), forced_order is always -1. Remove this unneeded parameter
to simplify the code.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/slub.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 180354d7e741..7f09901ae6b2 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4038,7 +4038,7 @@ static void set_cpu_partial(struct kmem_cache *s)
  * calculate_sizes() determines the order and the distribution of data within
  * a slab object.
  */
-static int calculate_sizes(struct kmem_cache *s, int forced_order)
+static int calculate_sizes(struct kmem_cache *s)
 {
 	slab_flags_t flags = s->flags;
 	unsigned int size = s->object_size;
@@ -4142,10 +4142,7 @@ static int calculate_sizes(struct kmem_cache *s, int forced_order)
 	size = ALIGN(size, s->align);
 	s->size = size;
 	s->reciprocal_size = reciprocal_value(size);
-	if (forced_order >= 0)
-		order = forced_order;
-	else
-		order = calculate_order(size);
+	order = calculate_order(size);
 
 	if ((int)order < 0)
 		return 0;
@@ -4181,7 +4178,7 @@ static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
 	s->random = get_random_long();
 #endif
 
-	if (!calculate_sizes(s, -1))
+	if (!calculate_sizes(s))
 		goto error;
 	if (disable_higher_order_debug) {
 		/*
@@ -4191,7 +4188,7 @@ static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
 		if (get_order(s->size) > get_order(s->object_size)) {
 			s->flags &= ~DEBUG_METADATA_FLAGS;
 			s->offset = 0;
-			if (!calculate_sizes(s, -1))
+			if (!calculate_sizes(s))
 				goto error;
 		}
 	}
-- 
2.23.0

