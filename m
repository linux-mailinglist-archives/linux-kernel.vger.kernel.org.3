Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB384D29A5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 08:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiCIHmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 02:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiCIHmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 02:42:13 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276F5162029
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 23:41:14 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id x3so1355999qvd.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 23:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=VZaf/MeKryF+BTlBqQ5utQRz4EsZx6ns2d5kX8BFXPo=;
        b=U2M2W3bIVB2clsqBUBRCR9wdFGV4rvtGYDycURm9Cuhq39PuXcZL1/fPKZ++lfyzry
         6DdFsLab2wMeQBq3IN1mXBZ1J6RsoNHa5DDV697Qgrjd6B0j3S0XUB/VSlDsuvB0ylG2
         vl9PzXeJVbQxZDrTogGzDaS7rmq7FeblLURsDw4dOORfQzN/IoM8/cCRTR5fvH+hSBm3
         wgwLsrh9l9lRCZKBOMcZAHWxJODwCHxmA58gPIruO4YdPXcYt79Y0aSFjOEZkU8BYYwr
         UECz+aDz9+7ToijMK0CWrihmLF5dkSXjOWNC3kzQinmWqVp1sE83Q9SHBUNuoe2cWhAA
         DqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=VZaf/MeKryF+BTlBqQ5utQRz4EsZx6ns2d5kX8BFXPo=;
        b=vlxGSDLrRCysucpjD/kyIlxH4NJLZUMaLnizOcpfXNF8Nxn/bjpW++MFXyPJI+Jvge
         3KlBgPS4+LYAM1UHNK+RlIwvGvJjGTiefpcCzcb4Xi2k+48X9DNMFULHMqqakag6k7U/
         nHD+lXyWpva3/preuq1xeWuCitUqbOdD6E1K3WmK1eyjhVcC+BYSCpMjGLzZOX6P1NTP
         /UtAJ36Wfhcx8wEfhuPyWiCsM/Uc3SQFW5VB7uGclTXqmb65lg/2Jl2q82EmmSYGAoe5
         gHvdfyLsCuXWthZlPLgwr7WOGGdPPaMjIJj9B2Xnga/KVGzxp4GZGc2jZlpoTNaCvCOy
         TBXA==
X-Gm-Message-State: AOAM532Zjmr+o6DxTFaufek5oKTsGaX4kExahDemsYRuCrATV+8fTeII
        MAAIV6WdAvaepADwceJXa0tl3i6AWufwJt2VT5Q=
X-Google-Smtp-Source: ABdhPJxaktK7n8Mm2flmeWJeF8TioMBXFaIpk3PmcBuVcYlZL0wfktInOyUyXj8+P4z9XF2b327Ocn8YneyzWHHmL6A=
X-Received: by 2002:a05:6214:14ea:b0:435:128c:61c8 with SMTP id
 k10-20020a05621414ea00b00435128c61c8mr15631468qvw.10.1646811673156; Tue, 08
 Mar 2022 23:41:13 -0800 (PST)
MIME-Version: 1.0
References: <1645174105-31224-1-git-send-email-huangzhaoyang@gmail.com>
In-Reply-To: <1645174105-31224-1-git-send-email-huangzhaoyang@gmail.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Wed, 9 Mar 2022 15:40:45 +0800
Message-ID: <CAGWkznFRps1P21Oggx0y+6B4svs2FFe7LS0W-N9EcpeToMtJ=g@mail.gmail.com>
Subject: [RFC PATCH] block: set bdi congested when no tag available
To:     Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

In previous version, block layer will set bdi to be congested when
get_request fail, which may throttle direct_reclaim. Move them back
under current blk-mq design.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 block/blk-mq-tag.c      | 18 +++++++++++++++++-
 include/linux/sbitmap.h |  1 +
 lib/sbitmap.c           | 17 +++++++++++++++++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 995336a..bd1e520 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -11,6 +11,7 @@

 #include <linux/blk-mq.h>
 #include <linux/delay.h>
+#include <linux/backing-dev.h>
 #include "blk.h"
 #include "blk-mq.h"
 #include "blk-mq-sched.h"
@@ -126,8 +127,11 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
  if (tag != BLK_MQ_NO_TAG)
  goto found_tag;

- if (data->flags & BLK_MQ_REQ_NOWAIT)
+ if (data->flags & BLK_MQ_REQ_NOWAIT) {
+ set_bdi_congested(data->q->disk->bdi,BLK_RW_SYNC);
+ set_bdi_congested(data->q->disk->bdi,BLK_RW_ASYNC);
  return BLK_MQ_NO_TAG;
+ }

  ws = bt_wait_ptr(bt, data->hctx);
  do {
@@ -193,9 +197,21 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
  return tag + tag_offset;
 }

+static bool blk_mq_has_free_tags(struct blk_mq_tags *tags)
+{
+ if (!tags)
+ return true;
+
+ return sbitmap_any_bit_clear(&tags->bitmap_tags.sb);
+}
+
 void blk_mq_put_tag(struct blk_mq_tags *tags, struct blk_mq_ctx *ctx,
      unsigned int tag)
 {
+ if (!blk_mq_has_free_tags(tags)) {
+ clear_bdi_congested(ctx->queue->disk->bdi, BLK_RW_SYNC);
+ clear_bdi_congested(ctx->queue->disk->bdi, BLK_RW_ASYNC);
+ }
  if (!blk_mq_tag_is_reserved(tags, tag)) {
  const int real_tag = tag - tags->nr_reserved_tags;

diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index 4a6ff27..30a5553 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -210,6 +210,7 @@ static inline void sbitmap_free(struct sbitmap *sb)
  * Return: true if any bit in the bitmap is set, false otherwise.
  */
 bool sbitmap_any_bit_set(const struct sbitmap *sb);
+bool sbitmap_any_bit_clear(const struct sbitmap *sb);

 #define SB_NR_TO_INDEX(sb, bitnr) ((bitnr) >> (sb)->shift)
 #define SB_NR_TO_BIT(sb, bitnr) ((bitnr) & ((1U << (sb)->shift) - 1U))
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 2709ab8..baa30d8 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -309,6 +309,23 @@ bool sbitmap_any_bit_set(const struct sbitmap *sb)
 }
 EXPORT_SYMBOL_GPL(sbitmap_any_bit_set);

+bool sbitmap_any_bit_clear(const struct sbitmap *sb)
+{
+ unsigned int i;
+
+ for (i = 0; i < sb->map_nr; i++) {
+ const struct sbitmap_word *word = &sb->map[i];
+ unsigned long mask = word->word & ~word->cleared;
+ unsigned long ret;
+
+ ret = find_first_zero_bit(&mask, word->depth);
+ if (ret < word->depth)
+ return true;
+ }
+ return false;
+}
+EXPORT_SYMBOL_GPL(sbitmap_any_bit_clear);
+
 static unsigned int __sbitmap_weight(const struct sbitmap *sb, bool set)
 {
  unsigned int i, weight = 0;
-- 
1.9.1
