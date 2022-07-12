Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFCA571032
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 04:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbiGLC22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 22:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiGLC2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 22:28:17 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13AC8AB26
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 19:28:15 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VJ6Ep2o_1657592891;
Received: from localhost.localdomain(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0VJ6Ep2o_1657592891)
          by smtp.aliyun-inc.com;
          Tue, 12 Jul 2022 10:28:12 +0800
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org, vbabka@suse.cz, 42.hyeyoo@gmail.com,
        roman.gushchin@linux.dev, iamjoonsoo.kim@lge.com,
        rientjes@google.com, penberg@kernel.org, cl@gentwo.de
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] mm/slub: delete confusing pr_err when debugging slub
Date:   Tue, 12 Jul 2022 10:28:07 +0800
Message-Id: <20220712022807.44113-3-rongwei.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220712022807.44113-1-rongwei.wang@linux.alibaba.com>
References: <20220712022807.44113-1-rongwei.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The n->nr_slabs will be updated when really to allocate or
free a slab, but this slab is unnecessarily in full list
or partial list of one node. That means the total count of
slab in node's full and partial list is unnecessarily equal
to n->nr_slabs, even though flush_all() has been called.

An example here, an error message likes below will be
printed when 'slabinfo -v' is executed:

SLUB: kmemleak_object 4157 slabs counted but counter=4161
SLUB: kmemleak_object 4072 slabs counted but counter=4077
SLUB: kmalloc-2k 19 slabs counted but counter=20
SLUB: kmalloc-2k 12 slabs counted but counter=13
SLUB: kmemleak_object 4205 slabs counted but counter=4209

Here, deleting this pr_err() directly.

Signed-off-by: Rongwei Wang <rongwei.wang@linux.alibaba.com>
---
 mm/slub.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 587416e39292..cdac004f232f 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5059,11 +5059,6 @@ static int validate_slab_node(struct kmem_cache *s,
 		validate_slab(s, slab, obj_map);
 		count++;
 	}
-	if (count != atomic_long_read(&n->nr_slabs)) {
-		pr_err("SLUB: %s %ld slabs counted but counter=%ld\n",
-		       s->name, count, atomic_long_read(&n->nr_slabs));
-		slab_add_kunit_errors();
-	}
 
 out:
 	spin_unlock_irqrestore(&n->list_lock, flags);
-- 
2.27.0

