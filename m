Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A39574653
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 10:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiGNIIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 04:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiGNIIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 04:08:36 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688DC29833;
        Thu, 14 Jul 2022 01:08:30 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=teawaterz@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VJIAcaG_1657786099;
Received: from localhost(mailfrom:teawaterz@linux.alibaba.com fp:SMTPD_---0VJIAcaG_1657786099)
          by smtp.aliyun-inc.com;
          Thu, 14 Jul 2022 16:08:26 +0800
From:   Hui Zhu <teawater@gmail.com>
To:     minchan@kernel.org, ngupta@vflare.org, senozhatsky@chromium.org,
        axboe@kernel.dk, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org
Cc:     teawater@gmail.com, Hui Zhu <teawater@antgroup.com>
Subject: [PATCH] zsmalloc: zs_malloc: Return ERR_PTR if fail
Date:   Thu, 14 Jul 2022 16:07:57 +0800
Message-Id: <20220714080757.12161-1-teawater@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hui Zhu <teawater@antgroup.com>

zs_malloc return 0 if it fail.  zs_zpool_malloc will return -1 when
zs_malloc return 0.
But -1 make the return value unclear.
For example:
when zswap_frontswap_store call zs_malloc through zs_zpool_malloc, it
will return -1 to its caller.
The other return value is -EINVAL, -ENODEV or something else.

This commit change zs_malloc to return ERR_PTR if fail.
It didn't just let zs_zpool_malloc -ENOMEM becaue zs_malloc has two
types of failures.
size is not OK return -EINVAL and memory alloc fail return -ENOMEM.

Signed-off-by: Hui Zhu <teawater@antgroup.com>
---
 drivers/block/zram/zram_drv.c |  4 ++--
 mm/zsmalloc.c                 | 13 ++++++++-----
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index b8549c6..e1f10b5 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1387,9 +1387,9 @@ static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 			__GFP_HIGHMEM |
 			__GFP_MOVABLE);
 
-	if (unlikely(!handle)) {
+	if (IS_ERR((void *)handle)) {
 		zcomp_stream_put(zram->comp);
-		return -ENOMEM;
+		return PTR_ERR((void *)handle);
 	}
 
 	alloced_pages = zs_get_total_pages(zram->mem_pool);
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 5d5fc043..e70952f 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -399,7 +399,10 @@ static int zs_zpool_malloc(void *pool, size_t size, gfp_t gfp,
 			unsigned long *handle)
 {
 	*handle = zs_malloc(pool, size, gfp);
-	return *handle ? 0 : -1;
+
+	if (IS_ERR((void *)(*handle)))
+		return PTR_ERR((void *)*handle);
+	return 0;
 }
 static void zs_zpool_free(void *pool, unsigned long handle)
 {
@@ -1400,7 +1403,7 @@ static unsigned long obj_malloc(struct zs_pool *pool,
  * @gfp: gfp flags when allocating object
  *
  * On success, handle to the allocated object is returned,
- * otherwise 0.
+ * otherwise an ERR_PTR().
  * Allocation requests with size > ZS_MAX_ALLOC_SIZE will fail.
  */
 unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
@@ -1411,11 +1414,11 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 	struct zspage *zspage;
 
 	if (unlikely(!size || size > ZS_MAX_ALLOC_SIZE))
-		return 0;
+		return (unsigned long)ERR_PTR(-EINVAL);
 
 	handle = cache_alloc_handle(pool, gfp);
 	if (!handle)
-		return 0;
+		return (unsigned long)ERR_PTR(-ENOMEM);
 
 	/* extra space in chunk to keep the handle */
 	size += ZS_HANDLE_SIZE;
@@ -1440,7 +1443,7 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 	zspage = alloc_zspage(pool, class, gfp);
 	if (!zspage) {
 		cache_free_handle(pool, handle);
-		return 0;
+		return (unsigned long)ERR_PTR(-ENOMEM);
 	}
 
 	spin_lock(&class->lock);
-- 
1.8.3.1

