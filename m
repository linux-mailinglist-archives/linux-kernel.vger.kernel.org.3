Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D6E4BB493
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 09:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbiBRItK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 03:49:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbiBRItJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 03:49:09 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4AE2B3542
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 00:48:52 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id u12so6620459plf.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 00:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=UBoCfCt3Y6PWGhQUApUNw771uw0a8IEHtaftJDZ7myg=;
        b=I0aAUBIweoBxJ1jI4FL7cCZKt3zwfVBBL6vD2KVaxliEyqa7RYjpSS7IGOb0Z7rWrM
         iaeGGGG39yev7rkjtpdm7G11Dyiqn8SGMxl/P+WgAq3ZUEwYLojMAlv435ybTqsRyZA7
         dShgT7TVRrIC0DY1Qeh4iqY9bXqURoPdZg4ZfMzIKzC36qJejCU/SuzG2MdqLFOQKyB1
         5U3ZyX06eY2PtOMVs4VpkJrpsclNVfFVqrnT5roXlY9fjZf1NrzZLrp4N3jhBEoJm4Ds
         3hES+Vi7JQt/0+k+OboRy+OQZwKVa/5xCzLGAtcItp00iRFw6vbth+0UE4f4r9vY3OwH
         1NXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=UBoCfCt3Y6PWGhQUApUNw771uw0a8IEHtaftJDZ7myg=;
        b=D1Dgu+KfJ2mDWtCI3d1k2twxw/P/02IrSqpt8FGwcPSQqQhWlyR+tESx8KujR3hxCn
         JSoNAue/HE4twb1YZukI7kd/mLwNh3arY/6SDiokxq/OciYFH73F3BCEasnXa+qZNG5B
         PnzUqmt20ZAVx7u14ZT5ahy9nKnIv1HBgGBcTYdw68ULX6PeTyyWMyIK6Tl7B/mY73CE
         58Qn6Hvb30RbjLSyIplhbvX3QZL79NtebT3uZUrW12ZNtNnNEEHVmMVbL+p6tu+r/ltr
         LLIlGTbL26TNZxhYv7e9WUTJnUHmoRek/3LPzP7Er6qQyD6wgeQs9kvCYPYyfhlI++rv
         ZXbQ==
X-Gm-Message-State: AOAM530xTB1jNfWI6rQ4KPMO/8sNwJpOAKU1XgnqYWb60Ylvb2BKBHIy
        PREmQjmn/t3LSGYCFVX0WS0=
X-Google-Smtp-Source: ABdhPJy4al8z6M1b8hySqSRd1n9l/F41nqACMIgx+J5bk6fSVGb9nmlzjNKJStngmv965T4meAakJQ==
X-Received: by 2002:a17:902:dac1:b0:14d:c0f7:3227 with SMTP id q1-20020a170902dac100b0014dc0f73227mr6434800plx.70.1645174132010;
        Fri, 18 Feb 2022 00:48:52 -0800 (PST)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id l16sm2139155pjy.14.2022.02.18.00.48.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Feb 2022 00:48:51 -0800 (PST)
From:   Huangzhaoyang <huangzhaoyang@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] block: set bdi congested when no tag available
Date:   Fri, 18 Feb 2022 16:48:25 +0800
Message-Id: <1645174105-31224-1-git-send-email-huangzhaoyang@gmail.com>
X-Mailer: git-send-email 1.7.9.5
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
under current design.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 block/blk-mq-tag.c      | 18 +++++++++++++++++-
 include/linux/sbitmap.h |  1 +
 lib/sbitmap.c           | 17 +++++++++++++++++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 995336a..abb0685 100644
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
 
-	if (data->flags & BLK_MQ_REQ_NOWAIT)
+	if (data->flags & BLK_MQ_REQ_NOWAIT) {
+		set_bdi_congested(data->q->disk->bdi,BLK_RW_SYNC);
+		set_bdi_congested(data->q->disk->bdi,BLK_RW_ASYNC);
 		return BLK_MQ_NO_TAG;
+	}
 
 	ws = bt_wait_ptr(bt, data->hctx);
 	do {
@@ -193,9 +197,21 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 	return tag + tag_offset;
 }
 
+static bool blk_mq_has_free_tags(struct blk_mq_tags *tags)
+{
+	if (!tags)
+		return true;
+
+	return sbitmap_any_bit_set(&tags->bitmap_tags.sb);
+}
+
 void blk_mq_put_tag(struct blk_mq_tags *tags, struct blk_mq_ctx *ctx,
 		    unsigned int tag)
 {
+	if (!blk_mq_has_free_tags(tags)) {
+		clear_bdi_congested(ctx->queue->disk->bdi, BLK_RW_SYNC);
+		clear_bdi_congested(ctx->queue->disk->bdi, BLK_RW_ASYNC);
+	}
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
+	unsigned int i;
+
+	for (i = 0; i < sb->map_nr; i++) {
+		const struct sbitmap_word *word = &sb->map[i];
+		unsigned long mask = word->word & ~word->cleared;
+		unsigned long ret;
+
+		ret = find_first_zero_bit(&mask, word->depth);
+		if (ret < word->depth)
+			return true;
+	}
+	return false;
+}
+EXPORT_SYMBOL_GPL(sbitmap_any_bit_clear);
+
 static unsigned int __sbitmap_weight(const struct sbitmap *sb, bool set)
 {
 	unsigned int i, weight = 0;
-- 
1.9.1

