Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D244D4EE1D1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 21:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240886AbiCaTjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 15:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240835AbiCaTjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 15:39:40 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5E923C0E7;
        Thu, 31 Mar 2022 12:37:47 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 2FB0A1F4724F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648755465;
        bh=TG6URAwoxuOMsxmElkXZN+3kr6++zE3/TmJ6jTIeCc0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JGVnr/FtZT3zuIJdqcifkyNee2EAFLxBcAh+IS7LZnNsmfdiXWV3PlyKjTB83WI5+
         1UH7iWvOuh0Qpnv7Tqj05AehCHHAEDRGyX2VgERLv5QdIt3pGYli65+SqHXLPzl6R8
         wxWCwO5QGvy9ZWt+uCn/nrhUwd8XYh6dBy7jFjh3AHMB5GVhKpsQx2TDmWrOVCjd+t
         +wZfeujPGizeL248Q6yn/vi6HFViB56RF59I4A1vEVtZD2BihPdO+TLhLzrlHZhnPZ
         NP99ppZHKcdsTPxyPywN1cB8FLhzi9ILL5ru2xWgTy9IHb8F56fNP8t1iV8DrENQ5v
         4rgHUVr4YZMzw==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kernel@collabora.com,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/23] media: h264: Store current picture fields
Date:   Thu, 31 Mar 2022 15:37:09 -0400
Message-Id: <20220331193726.289559-8-nicolas.dufresne@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220331193726.289559-1-nicolas.dufresne@collabora.com>
References: <20220331193726.289559-1-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This information, also called picture structure, is required in field
decoding mode to construct reference lists.

Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>
---
 drivers/media/v4l2-core/v4l2-h264.c | 10 +++++++---
 include/media/v4l2-h264.h           |  4 ++++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-h264.c b/drivers/media/v4l2-core/v4l2-h264.c
index 4b46b36526c0..58f18bb0afb6 100644
--- a/drivers/media/v4l2-core/v4l2-h264.c
+++ b/drivers/media/v4l2-core/v4l2-h264.c
@@ -34,13 +34,17 @@ v4l2_h264_init_reflist_builder(struct v4l2_h264_reflist_builder *b,
 	cur_frame_num = dec_params->frame_num;
 
 	memset(b, 0, sizeof(*b));
-	if (!(dec_params->flags & V4L2_H264_DECODE_PARAM_FLAG_FIELD_PIC))
+	if (!(dec_params->flags & V4L2_H264_DECODE_PARAM_FLAG_FIELD_PIC)) {
 		b->cur_pic_order_count = min(dec_params->bottom_field_order_cnt,
 					     dec_params->top_field_order_cnt);
-	else if (dec_params->flags & V4L2_H264_DECODE_PARAM_FLAG_BOTTOM_FIELD)
+		b->cur_pic_fields = V4L2_H264_FRAME_REF;
+	} else if (dec_params->flags & V4L2_H264_DECODE_PARAM_FLAG_BOTTOM_FIELD) {
 		b->cur_pic_order_count = dec_params->bottom_field_order_cnt;
-	else
+		b->cur_pic_fields = V4L2_H264_BOTTOM_FIELD_REF;
+	} else {
 		b->cur_pic_order_count = dec_params->top_field_order_cnt;
+		b->cur_pic_fields = V4L2_H264_TOP_FIELD_REF;
+	}
 
 	for (i = 0; i < V4L2_H264_NUM_DPB_ENTRIES; i++) {
 		u32 pic_order_count;
diff --git a/include/media/v4l2-h264.h b/include/media/v4l2-h264.h
index e282fb16ac58..e165a54c68fa 100644
--- a/include/media/v4l2-h264.h
+++ b/include/media/v4l2-h264.h
@@ -21,6 +21,7 @@
  * @refs.longterm: set to true for a long term reference
  * @refs: array of references
  * @cur_pic_order_count: picture order count of the frame being decoded
+ * @cur_pic_fields: fields present in the frame being decoded
  * @unordered_reflist: unordered list of references. Will be used to generate
  *		       ordered P/B0/B1 lists
  * @num_valid: number of valid references in the refs array
@@ -36,7 +37,10 @@ struct v4l2_h264_reflist_builder {
 		u32 pic_num;
 		u16 longterm : 1;
 	} refs[V4L2_H264_NUM_DPB_ENTRIES];
+
 	s32 cur_pic_order_count;
+	u8 cur_pic_fields;
+
 	struct v4l2_h264_reference unordered_reflist[V4L2_H264_REF_LIST_LEN];
 	u8 num_valid;
 };
-- 
2.34.1

