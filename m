Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8018B544245
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 06:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbiFIEBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 00:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237507AbiFIEBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 00:01:45 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAB021F9C2
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 21:01:43 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VFqMZZr_1654747293;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VFqMZZr_1654747293)
          by smtp.aliyun-inc.com;
          Thu, 09 Jun 2022 12:01:39 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     cl@linux.com
Cc:     penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] mm, slab: fix bad alignments
Date:   Thu,  9 Jun 2022 12:01:32 +0800
Message-Id: <20220609040132.89192-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
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

As reported by coccicheck:

./mm/slab.c:3253:2-59: code aligned with following code on line 3255.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 mm/slab.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 47151fb2b2d2..c359c0f2c897 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3223,7 +3223,7 @@ slab_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid, size_t orig_
 	}
 	/* ___cache_alloc_node can fall back to other nodes */
 	ptr = ____cache_alloc_node(cachep, flags, nodeid);
-  out:
+out:
 	local_irq_restore(save_flags);
 	ptr = cache_alloc_debugcheck_after(cachep, flags, ptr, caller);
 	init = slab_want_init_on_alloc(flags, cachep);
@@ -3252,7 +3252,7 @@ __do_cache_alloc(struct kmem_cache *cache, gfp_t flags)
 	if (!objp)
 		objp = ____cache_alloc_node(cache, flags, numa_mem_id());
 
-  out:
+out:
 	return objp;
 }
 #else
-- 
2.20.1.7.g153144c

