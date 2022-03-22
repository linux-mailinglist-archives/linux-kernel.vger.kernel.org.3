Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077914E26B8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 13:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347503AbiCUMk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 08:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234493AbiCUMk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:40:27 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B862B27F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 05:39:01 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KMZ1B1SBTz1GCmk;
        Mon, 21 Mar 2022 20:38:54 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 21 Mar
 2022 20:38:59 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <cl@linux.com>, <penberg@kernel.org>, <rientjes@google.com>,
        <iamjoonsoo.kim@lge.com>, <akpm@linux-foundation.org>,
        <vbabka@suse.cz>
CC:     <roman.gushchin@linux.dev>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH] mm/slab: remove some unused functions
Date:   Tue, 22 Mar 2022 17:14:21 +0800
Message-ID: <20220322091421.25285-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alternate_node_alloc and ____cache_alloc_node are always called when
CONFIG_NUMA. So we can remove the unused !CONFIG_NUMA variant. Also
forward declaration for alternate_node_alloc is unnecessary. Remove
it too.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/slab.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index d9dec7a8fd79..81301df47057 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -619,18 +619,6 @@ static inline int cache_free_alien(struct kmem_cache *cachep, void *objp)
 	return 0;
 }
 
-static inline void *alternate_node_alloc(struct kmem_cache *cachep,
-		gfp_t flags)
-{
-	return NULL;
-}
-
-static inline void *____cache_alloc_node(struct kmem_cache *cachep,
-		 gfp_t flags, int nodeid)
-{
-	return NULL;
-}
-
 static inline gfp_t gfp_exact_node(gfp_t flags)
 {
 	return flags & ~__GFP_NOFAIL;
@@ -639,7 +627,6 @@ static inline gfp_t gfp_exact_node(gfp_t flags)
 #else	/* CONFIG_NUMA */
 
 static void *____cache_alloc_node(struct kmem_cache *, gfp_t, int);
-static void *alternate_node_alloc(struct kmem_cache *, gfp_t);
 
 static struct alien_cache *__alloc_alien_cache(int node, int entries,
 						int batch, gfp_t gfp)
-- 
2.23.0

