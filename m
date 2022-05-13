Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C154526B75
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 22:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384409AbiEMUaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 16:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384354AbiEMU3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 16:29:51 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E3278903;
        Fri, 13 May 2022 13:29:39 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id DC8831F46484
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652473777;
        bh=adZKiN21Vm0IHRnapqoM4ZvUwsizssWjlD3d+MYjhsI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fsSfqD6Y2pEHGTn3yWbjjCVgnXquuXZvouLEfzuDdvAMwywTGLeosT9QtGbhI9dfz
         opOYt5o6fiQBN2f5UL0p7SFYtHaf9AzRmlNGfHvLowZe4pK5vmRKE12XOon6w+7MnC
         dZuEUwnXeNmE1Xs3xXnYgXfVcmu0Bdxe7fFX55yKoK6IUaQfD97R/6zzgvYuH4bKo5
         VE9NpUp2JS8/FSHWG41Nhft5NwBUj3qQE/tt/6N8qlg3qqGTkse8XB5Xv9MhR9QYAW
         1SYG4q8RNhv9Yi1sHkwOikit6BbO1v+qhk4qusr/8o7NsE1sa4x2tELkxeT/tsY+9c
         pNxnBSQzEh+kQ==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     nicolas@ndufresne.ca, linux-media@vger.kernel.org,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 03/20] media: h264: Store current picture fields
Date:   Fri, 13 May 2022 16:29:05 -0400
Message-Id: <20220513202922.13846-4-nicolas.dufresne@collabora.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220513202922.13846-1-nicolas.dufresne@collabora.com>
References: <20220513202922.13846-1-nicolas.dufresne@collabora.com>
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
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
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
2.34.3

