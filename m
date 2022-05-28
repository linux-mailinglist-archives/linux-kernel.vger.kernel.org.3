Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07792536D8D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 17:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237790AbiE1PkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 11:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbiE1PkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 11:40:22 -0400
Received: from m12-14.163.com (m12-14.163.com [220.181.12.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C35F17E24
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 08:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=BkvE0YAcS6ajpnfn1S
        LDj2iO+a4qJNSD4+BxpVUka5I=; b=kTppOQcerw7gfF1+7K8NAaZcKeBWvoY0Gv
        o6O3hpG+XDLjasvH7B0QwUYkY65JupKwbw95+jFCzlcb8AhJxjw1F+xlruWCNDNo
        Nrp+mviSa6KsKnoRS2QVbswnKJRKUEIuOQMFKd5yGgrNyknWeaCy0cj44Nw8pBii
        3q2XAcq88=
Received: from localhost.localdomain (unknown [171.221.147.90])
        by smtp10 (Coremail) with SMTP id DsCowABHJBZMQpJiLxowEw--.19256S2;
        Sat, 28 May 2022 23:40:00 +0800 (CST)
From:   Chen Lin <chen45464546@163.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Chen Lin <chen45464546@163.com>
Subject: [PATCH] mm: page_frag: Warn_on when frag_alloc size is bigger than PAGE_SIZE
Date:   Sat, 28 May 2022 23:39:33 +0800
Message-Id: <1653752373-3172-1-git-send-email-chen45464546@163.com>
X-Mailer: git-send-email 1.7.9.5
X-CM-TRANSID: DsCowABHJBZMQpJiLxowEw--.19256S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr17tw1fGFWkur17WF4rXwb_yoW8XFy7pF
        ZrCr15ZFs0qwnxCw4kta1vyr45J398WFWjgrWFv3s09w13Wr10kwnrKr4jvFyrAr4UKFy7
        tan8tw15ua1UZ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi5CzdUUUUU=
X-Originating-IP: [171.221.147.90]
X-CM-SenderInfo: hfkh0kqvuwkkiuw6il2tof0z/xtbCqRYPnl0DftRC8wAAsr
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

netdev_alloc_frag->page_frag_alloc may cause memory corruption in 
the following process:

1. A netdev_alloc_frag function call need alloc 200 Bytes to build a skb.

2. Insufficient memory to alloc PAGE_FRAG_CACHE_MAX_ORDER(32K) in 
__page_frag_cache_refill to fill frag cache, then one page(eg:4K) 
is allocated, now current frag cache is 4K, alloc is success, 
nc->pagecnt_bias--.

3. Then this 200 bytes skb in step 1 is freed, page->_refcount--.

4. Another netdev_alloc_frag function call need alloc 5k, page->_refcount 
is equal to nc->pagecnt_bias, reset page count bias and offset to 
start of new frag. page_frag_alloc will return the 4K memory for a 
5K memory request.

5. The caller write on the extra 1k memory which is not actual allocated 
will cause memory corruption.

page_frag_alloc is for fragmented allocation. We should warn the caller 
to avoid memory corruption.

Signed-off-by: Chen Lin <chen45464546@163.com>
---
 mm/page_alloc.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e008a3d..6c0db52 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5574,6 +5574,11 @@ void *page_frag_alloc_align(struct page_frag_cache *nc,
 	struct page *page;
 	int offset;
 
+	/* frag_alloc is not suitable for memory alloc which fragsz
+	 * is bigger than PAGE_SIZE, use kmalloc or alloc_pages instead.
+	 */
+	WARN_ON(fragsz > PAGE_SIZE);
+
 	if (unlikely(!nc->va)) {
 refill:
 		page = __page_frag_cache_refill(nc, gfp_mask);
-- 
1.7.9.5

