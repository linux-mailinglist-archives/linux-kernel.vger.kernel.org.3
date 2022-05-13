Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFBE526B77
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 22:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384155AbiEMUa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 16:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384339AbiEMUaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 16:30:00 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D2378FE3;
        Fri, 13 May 2022 13:29:42 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 87DCB1F46483
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652473779;
        bh=klo+1mnjtIffOlX4qRd4PUUXiirFqeO06vggz4DyHow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dqHtnL82tfwPBe2S4t+YexEQPyjDQpjNExg5SwRCFZlJ90oQsE1Uhcj9BLKN91MO2
         jUgG54pRowhTWJnDk3w9Dn/yoI/9Ron2yeS389lUf7FDs9aXT5ZGlek/anCyfX2jhF
         z2nmQbcjzL228Hdw3DYaEc1rICZTURyENbPcfI91xy0an0hMoC/Kb3DObZcJEjnf1q
         wgYklu39loZb9ZKWsmaAlLEqAbRrNLh6q0RDKnPvdZReWikGSXI8cHfwzp6QDA1ywQ
         Mfy/hXIHl/W1p1oNYaEvVNBUqoarwN9mfu6zUNYTzeetpqcLTAJHQYR8MLjf/va9e7
         lTEHgM2MTQkig==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     nicolas@ndufresne.ca, linux-media@vger.kernel.org,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 04/20] media: h264: Store all fields into the unordered list
Date:   Fri, 13 May 2022 16:29:06 -0400
Message-Id: <20220513202922.13846-5-nicolas.dufresne@collabora.com>
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

When the current picture is a field, store each field into the
unordered_list and preserve both top and bottom picture order
count.

Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 .../media/platform/nvidia/tegra-vde/h264.c    |  2 +-
 drivers/media/v4l2-core/v4l2-h264.c           | 65 ++++++++++++++-----
 include/media/v4l2-h264.h                     |  6 +-
 3 files changed, 52 insertions(+), 21 deletions(-)

diff --git a/drivers/media/platform/nvidia/tegra-vde/h264.c b/drivers/media/platform/nvidia/tegra-vde/h264.c
index 4fb0aaad16d6..88f81a134ba0 100644
--- a/drivers/media/platform/nvidia/tegra-vde/h264.c
+++ b/drivers/media/platform/nvidia/tegra-vde/h264.c
@@ -820,7 +820,7 @@ static int tegra_vde_h264_setup_frames(struct tegra_ctx *ctx,
 		if (err)
 			return err;
 
-		if (b.refs[dpb_idx].pic_order_count < b.cur_pic_order_count)
+		if (b.refs[dpb_idx].top_field_order_cnt < b.cur_pic_order_count)
 			h264->dpb_ref_frames_with_earlier_poc_nb++;
 	}
 
diff --git a/drivers/media/v4l2-core/v4l2-h264.c b/drivers/media/v4l2-core/v4l2-h264.c
index 58f18bb0afb6..38d8dbda0045 100644
--- a/drivers/media/v4l2-core/v4l2-h264.c
+++ b/drivers/media/v4l2-core/v4l2-h264.c
@@ -47,8 +47,6 @@ v4l2_h264_init_reflist_builder(struct v4l2_h264_reflist_builder *b,
 	}
 
 	for (i = 0; i < V4L2_H264_NUM_DPB_ENTRIES; i++) {
-		u32 pic_order_count;
-
 		if (!(dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE))
 			continue;
 
@@ -59,8 +57,6 @@ v4l2_h264_init_reflist_builder(struct v4l2_h264_reflist_builder *b,
 		/*
 		 * Handle frame_num wraparound as described in section
 		 * '8.2.4.1 Decoding process for picture numbers' of the spec.
-		 * TODO: This logic will have to be adjusted when we start
-		 * supporting interlaced content.
 		 * For long term references, frame_num is set to
 		 * long_term_frame_idx which requires no wrapping.
 		 */
@@ -70,17 +66,33 @@ v4l2_h264_init_reflist_builder(struct v4l2_h264_reflist_builder *b,
 		else
 			b->refs[i].frame_num = dpb[i].frame_num;
 
-		if (dpb[i].fields == V4L2_H264_FRAME_REF)
-			pic_order_count = min(dpb[i].top_field_order_cnt,
-					      dpb[i].bottom_field_order_cnt);
-		else if (dpb[i].fields & V4L2_H264_BOTTOM_FIELD_REF)
-			pic_order_count = dpb[i].bottom_field_order_cnt;
-		else
-			pic_order_count = dpb[i].top_field_order_cnt;
+		b->refs[i].top_field_order_cnt = dpb[i].top_field_order_cnt;
+		b->refs[i].bottom_field_order_cnt = dpb[i].bottom_field_order_cnt;
+
+		if (b->cur_pic_fields == V4L2_H264_FRAME_REF) {
+			u8 fields = V4L2_H264_FRAME_REF;
+
+			b->unordered_reflist[b->num_valid].index = i;
+			b->unordered_reflist[b->num_valid].fields = fields;
+			b->num_valid++;
+			continue;
+		}
+
+		if (dpb[i].fields & V4L2_H264_TOP_FIELD_REF) {
+			u8 fields = V4L2_H264_TOP_FIELD_REF;
+
+			b->unordered_reflist[b->num_valid].index = i;
+			b->unordered_reflist[b->num_valid].fields = fields;
+			b->num_valid++;
+		}
 
-		b->refs[i].pic_order_count = pic_order_count;
-		b->unordered_reflist[b->num_valid].index = i;
-		b->num_valid++;
+		if (dpb[i].fields & V4L2_H264_BOTTOM_FIELD_REF) {
+			u8 fields = V4L2_H264_BOTTOM_FIELD_REF;
+
+			b->unordered_reflist[b->num_valid].index = i;
+			b->unordered_reflist[b->num_valid].fields = fields;
+			b->num_valid++;
+		}
 	}
 
 	for (i = b->num_valid; i < ARRAY_SIZE(b->unordered_reflist); i++)
@@ -88,6 +100,23 @@ v4l2_h264_init_reflist_builder(struct v4l2_h264_reflist_builder *b,
 }
 EXPORT_SYMBOL_GPL(v4l2_h264_init_reflist_builder);
 
+static s32 v4l2_h264_get_poc(const struct v4l2_h264_reflist_builder *b,
+			     const struct v4l2_h264_reference *ref)
+{
+	switch (ref->fields) {
+	case V4L2_H264_FRAME_REF:
+		return min(b->refs[ref->index].top_field_order_cnt,
+				b->refs[ref->index].bottom_field_order_cnt);
+	case V4L2_H264_TOP_FIELD_REF:
+		return b->refs[ref->index].top_field_order_cnt;
+	case V4L2_H264_BOTTOM_FIELD_REF:
+		return b->refs[ref->index].bottom_field_order_cnt;
+	}
+
+	/* not reached */
+	return 0;
+}
+
 static int v4l2_h264_p_ref_list_cmp(const void *ptra, const void *ptrb,
 				    const void *data)
 {
@@ -150,8 +179,8 @@ static int v4l2_h264_b0_ref_list_cmp(const void *ptra, const void *ptrb,
 		       builder->refs[idxb].pic_num ?
 		       -1 : 1;
 
-	poca = builder->refs[idxa].pic_order_count;
-	pocb = builder->refs[idxb].pic_order_count;
+	poca = v4l2_h264_get_poc(builder, ptra);
+	pocb = v4l2_h264_get_poc(builder, ptrb);
 
 	/*
 	 * Short term pics with POC < cur POC first in POC descending order
@@ -195,8 +224,8 @@ static int v4l2_h264_b1_ref_list_cmp(const void *ptra, const void *ptrb,
 		       builder->refs[idxb].pic_num ?
 		       -1 : 1;
 
-	poca = builder->refs[idxa].pic_order_count;
-	pocb = builder->refs[idxb].pic_order_count;
+	poca = v4l2_h264_get_poc(builder, ptra);
+	pocb = v4l2_h264_get_poc(builder, ptrb);
 
 	/*
 	 * Short term pics with POC > cur POC first in POC ascending order
diff --git a/include/media/v4l2-h264.h b/include/media/v4l2-h264.h
index e165a54c68fa..4cef717b3f18 100644
--- a/include/media/v4l2-h264.h
+++ b/include/media/v4l2-h264.h
@@ -15,7 +15,8 @@
 /**
  * struct v4l2_h264_reflist_builder - Reference list builder object
  *
- * @refs.pic_order_count: reference picture order count
+ * @refs.top_field_order_cnt: top field order count
+ * @refs.bottom_field_order_cnt: bottom field order count
  * @refs.frame_num: reference frame number
  * @refs.pic_num: reference picture number
  * @refs.longterm: set to true for a long term reference
@@ -32,7 +33,8 @@
  */
 struct v4l2_h264_reflist_builder {
 	struct {
-		s32 pic_order_count;
+		s32 top_field_order_cnt;
+		s32 bottom_field_order_cnt;
 		int frame_num;
 		u32 pic_num;
 		u16 longterm : 1;
-- 
2.34.3

