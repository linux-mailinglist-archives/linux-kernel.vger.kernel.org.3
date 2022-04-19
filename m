Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83659506BDC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 14:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352166AbiDSMKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 08:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349915AbiDSMIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 08:08:17 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58943632E
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 05:03:27 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KjMrm66CHzhXXG;
        Tue, 19 Apr 2022 20:03:20 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 19 Apr
 2022 20:03:25 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <cl@linux.com>, <penberg@kernel.org>, <rientjes@google.com>,
        <iamjoonsoo.kim@lge.com>, <akpm@linux-foundation.org>,
        <vbabka@suse.cz>
CC:     <roman.gushchin@linux.dev>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH] mm/slub: remove unneeded return value of slab_pad_check
Date:   Tue, 19 Apr 2022 20:03:52 +0800
Message-ID: <20220419120352.37825-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

The return value of slab_pad_check is never used. So we can make it return
void now.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/slub.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 6dc703488d30..1f699ddfff7f 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1017,7 +1017,7 @@ static int check_pad_bytes(struct kmem_cache *s, struct slab *slab, u8 *p)
 }
 
 /* Check the pad bytes at the end of a slab page */
-static int slab_pad_check(struct kmem_cache *s, struct slab *slab)
+static void slab_pad_check(struct kmem_cache *s, struct slab *slab)
 {
 	u8 *start;
 	u8 *fault;
@@ -1027,21 +1027,21 @@ static int slab_pad_check(struct kmem_cache *s, struct slab *slab)
 	int remainder;
 
 	if (!(s->flags & SLAB_POISON))
-		return 1;
+		return;
 
 	start = slab_address(slab);
 	length = slab_size(slab);
 	end = start + length;
 	remainder = length % s->size;
 	if (!remainder)
-		return 1;
+		return;
 
 	pad = end - remainder;
 	metadata_access_enable();
 	fault = memchr_inv(kasan_reset_tag(pad), POISON_INUSE, remainder);
 	metadata_access_disable();
 	if (!fault)
-		return 1;
+		return;
 	while (end > fault && end[-1] == POISON_INUSE)
 		end--;
 
@@ -1050,7 +1050,6 @@ static int slab_pad_check(struct kmem_cache *s, struct slab *slab)
 	print_section(KERN_ERR, "Padding ", pad, remainder);
 
 	restore_bytes(s, "slab padding", POISON_INUSE, fault, end);
-	return 0;
 }
 
 static int check_object(struct kmem_cache *s, struct slab *slab,
@@ -1642,8 +1641,7 @@ static inline int free_debug_processing(
 	void *head, void *tail, int bulk_cnt,
 	unsigned long addr) { return 0; }
 
-static inline int slab_pad_check(struct kmem_cache *s, struct slab *slab)
-			{ return 1; }
+static inline void slab_pad_check(struct kmem_cache *s, struct slab *slab) {}
 static inline int check_object(struct kmem_cache *s, struct slab *slab,
 			void *object, u8 val) { return 1; }
 static inline void add_full(struct kmem_cache *s, struct kmem_cache_node *n,
-- 
2.23.0

