Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196C550FE05
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 14:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345796AbiDZNBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350340AbiDZNBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:01:20 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9190617E21D;
        Tue, 26 Apr 2022 05:58:13 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 7DA501F4398F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650977892;
        bh=TG6URAwoxuOMsxmElkXZN+3kr6++zE3/TmJ6jTIeCc0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LclxaSjPDfOpC1UByITD5g0TcRn93XHlXMEJxfu6eBw6NAIFotmhiFn865sKV37A2
         BylfSgeLLOjvU7FE4GgWjZI4fw1BVHHEYqQE+Q9pQf4IxXdbe29xsHmNUZ0CIYG73W
         uaSH7XY7FZycGmEv2UScGuDjLhF5e40uFrm/lGBYsvC9Q+9sPUUogaMTT7fkdL2DQ7
         gD0qR6bUJvCLxpDzLwXR0mo0Xid1GU/b4JM7nGbuaGnVxJD6gpQQBYjsp7tNRw8Wdb
         8AZKC0WQmiCfyjTX/rjOS9PKUp1IKg4/btz4G5XS6279dHAIJj9qttd6rJ/Hi8Q2x1
         koC8n4xkKSpGQ==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     nicolas@ndufresne.ca, linux-media@vger.kernel.org,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/24] media: h264: Store current picture fields
Date:   Tue, 26 Apr 2022 08:57:33 -0400
Message-Id: <20220426125751.108293-8-nicolas.dufresne@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220426125751.108293-1-nicolas.dufresne@collabora.com>
References: <20220426125751.108293-1-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
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

