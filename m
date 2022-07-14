Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8535741D9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 05:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbiGNDZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 23:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiGNDZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 23:25:37 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CF4255B9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 20:25:35 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VJHNBNf_1657769100;
Received: from localhost(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0VJHNBNf_1657769100)
          by smtp.aliyun-inc.com;
          Thu, 14 Jul 2022 11:25:33 +0800
From:   Liu Song <liusong@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/dmapool.c: avoid duplicate memset within dma_pool_alloc
Date:   Thu, 14 Jul 2022 11:25:00 +0800
Message-Id: <1657769100-66142-1-git-send-email-liusong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Song <liusong@linux.alibaba.com>

In "dma_direct_alloc", the allocated memory is explicitly set to 0.
If use direct alloc, we need to avoid possible duplicate memset in
dma_pool_alloc.

Signed-off-by: Liu Song <liusong@linux.alibaba.com>
---
 mm/dmapool.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index a7eb5d0..94f4859 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -21,6 +21,7 @@
 
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
+#include <linux/dma-map-ops.h>
 #include <linux/dmapool.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
@@ -372,7 +373,7 @@ void *dma_pool_alloc(struct dma_pool *pool, gfp_t mem_flags,
 #endif
 	spin_unlock_irqrestore(&pool->lock, flags);
 
-	if (want_init_on_alloc(mem_flags))
+	if (want_init_on_alloc(mem_flags) && get_dma_ops(pool->dev))
 		memset(retval, 0, pool->size);
 
 	return retval;
-- 
1.8.3.1

