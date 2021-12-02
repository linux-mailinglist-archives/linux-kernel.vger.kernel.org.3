Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF8D5465C03
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 03:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351470AbhLBCJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 21:09:54 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:40950 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240747AbhLBCJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 21:09:51 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=cuibixuan@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Uz7z7hl_1638410784;
Received: from VM20210331-25.tbsite.net(mailfrom:cuibixuan@linux.alibaba.com fp:SMTPD_---0Uz7z7hl_1638410784)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 02 Dec 2021 10:06:28 +0800
From:   Bixuan Cui <cuibixuan@linux.alibaba.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org
Cc:     leon@kernel.org, cuibixuan@linux.alibaba.com,
        akpm@linux-foundation.org, w@1wt.eu, keescook@chromium.org
Subject: [PATCH -next] mm: delete oversized WARN_ON() in kvmalloc() calls
Date:   Thu,  2 Dec 2021 10:06:24 +0800
Message-Id: <1638410784-48646-1-git-send-email-cuibixuan@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the WARN_ON() and return NULL directly for oversized parameter
in kvmalloc() calls.
Also add unlikely().

Fixes: 7661809d493b ("mm: don't allow oversized kvmalloc() calls")
Signed-off-by: Bixuan Cui <cuibixuan@linux.alibaba.com>
---
There are a lot of oversize warnings and patches about kvmalloc() calls
recently. Maybe these warnings are not very necessary.

https://lore.kernel.org/all/YadOjJXMTjP85MQx@unreal

The example of size check in __do_kmalloc_node():
__do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller)
{
        struct kmem_cache *cachep;
        void *ret;

        if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
                return NULL;
        cachep = kmalloc_slab(size, flags);

 mm/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/util.c b/mm/util.c
index 7e433690..d26f19c 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -587,7 +587,7 @@ void *kvmalloc_node(size_t size, gfp_t flags, int node)
 		return ret;
 
 	/* Don't even allow crazy sizes */
-	if (WARN_ON_ONCE(size > INT_MAX))
+	if (unlikely(size > INT_MAX))
 		return NULL;
 
 	return __vmalloc_node(size, 1, flags, node,
-- 
1.8.3.1

