Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6B850FE10
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 14:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350516AbiDZNCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350320AbiDZNBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:01:25 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8504517B399;
        Tue, 26 Apr 2022 05:58:17 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id AE6D01F4398F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650977896;
        bh=952H20dFKMDGDG2AyTcdBsEiBoEPkmvH/b/LrPIdq6E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ivwEH58V6mC1MYYJ4WS3Fo3nzVJjOsapx5RN+72kpIWPAA/9mJYTv9AvPV9SoCU7t
         vbomIyuebGGZ7qsih9ITtUvNwe2/rUDE/BOeGdjS+pJfehE7S/ALAOB8bJUK0Gv7xo
         9C6kenOhkDskpU48m3KexD7pQji4KmqfsOIPpmHe5BTJK40h1c4r8irPIQOwN30SAQ
         b9/mJSD6FW73vkcPvfy+AhkzcdY28j43lVhlDIYmQM13LDyBvpeuJBN+lIsbPuF/JR
         QW7jhCWN5Pe+sNbPaLDcfY/YILrMSWKP9HN5+1CJSC98Zxfj/MyuYWDrovf+ACb09c
         AtvB0I6M706bw==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     nicolas@ndufresne.ca, linux-media@vger.kernel.org,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/24] media: h264: Sort p/b reflist using frame_num
Date:   Tue, 26 Apr 2022 08:57:36 -0400
Message-Id: <20220426125751.108293-11-nicolas.dufresne@collabora.com>
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

In the reference list builder, frame_num refers to FrameNumWrap
in the spec, which is the same as the pic_num for frame decoding.
The same applies for long_term_pic_num and long_term_frame_idx.

Sort all type of references by frame_num so the sort can be reused
for fields reflist were the sorting is done using frame_num instead.
In short, pic_num is never actually used for building reference
lists.

Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>
---
 drivers/media/v4l2-core/v4l2-h264.c | 23 +++++++++++++----------
 include/media/v4l2-h264.h           |  2 --
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-h264.c b/drivers/media/v4l2-core/v4l2-h264.c
index 853f54e0fe67..fe215035d9e8 100644
--- a/drivers/media/v4l2-core/v4l2-h264.c
+++ b/drivers/media/v4l2-core/v4l2-h264.c
@@ -56,7 +56,6 @@ v4l2_h264_init_reflist_builder(struct v4l2_h264_reflist_builder *b,
 		if (!(dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE))
 			continue;
 
-		b->refs[i].pic_num = dpb[i].pic_num;
 		if (dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_LONG_TERM)
 			b->refs[i].longterm = true;
 
@@ -145,15 +144,19 @@ static int v4l2_h264_p_ref_list_cmp(const void *ptra, const void *ptrb,
 	}
 
 	/*
-	 * Short term pics in descending pic num order, long term ones in
-	 * ascending order.
+	 * For frames, short term pics are in descending pic num order and long
+	 * term ones in ascending order. For fields, the same direction is used
+	 * but with frame_num (wrapped). For frames, the value of pic_num and
+	 * frame_num are the same (see formula (8-28) and (8-29)). For this
+	 * reason we can use frame_num only and share this function between
+	 * frames and fields reflist.
 	 */
 	if (!builder->refs[idxa].longterm)
 		return builder->refs[idxb].frame_num <
 		       builder->refs[idxa].frame_num ?
 		       -1 : 1;
 
-	return builder->refs[idxa].pic_num < builder->refs[idxb].pic_num ?
+	return builder->refs[idxa].frame_num < builder->refs[idxb].frame_num ?
 	       -1 : 1;
 }
 
@@ -179,10 +182,10 @@ static int v4l2_h264_b0_ref_list_cmp(const void *ptra, const void *ptrb,
 			return 1;
 	}
 
-	/* Long term pics in ascending pic num order. */
+	/* Long term pics in ascending frame num order. */
 	if (builder->refs[idxa].longterm)
-		return builder->refs[idxa].pic_num <
-		       builder->refs[idxb].pic_num ?
+		return builder->refs[idxa].frame_num <
+		       builder->refs[idxb].frame_num ?
 		       -1 : 1;
 
 	poca = v4l2_h264_get_poc(builder, ptra);
@@ -224,10 +227,10 @@ static int v4l2_h264_b1_ref_list_cmp(const void *ptra, const void *ptrb,
 			return 1;
 	}
 
-	/* Long term pics in ascending pic num order. */
+	/* Long term pics in ascending frame num order. */
 	if (builder->refs[idxa].longterm)
-		return builder->refs[idxa].pic_num <
-		       builder->refs[idxb].pic_num ?
+		return builder->refs[idxa].frame_num <
+		       builder->refs[idxb].frame_num ?
 		       -1 : 1;
 
 	poca = v4l2_h264_get_poc(builder, ptra);
diff --git a/include/media/v4l2-h264.h b/include/media/v4l2-h264.h
index 4cef717b3f18..0d9eaa956123 100644
--- a/include/media/v4l2-h264.h
+++ b/include/media/v4l2-h264.h
@@ -18,7 +18,6 @@
  * @refs.top_field_order_cnt: top field order count
  * @refs.bottom_field_order_cnt: bottom field order count
  * @refs.frame_num: reference frame number
- * @refs.pic_num: reference picture number
  * @refs.longterm: set to true for a long term reference
  * @refs: array of references
  * @cur_pic_order_count: picture order count of the frame being decoded
@@ -36,7 +35,6 @@ struct v4l2_h264_reflist_builder {
 		s32 top_field_order_cnt;
 		s32 bottom_field_order_cnt;
 		int frame_num;
-		u32 pic_num;
 		u16 longterm : 1;
 	} refs[V4L2_H264_NUM_DPB_ENTRIES];
 
-- 
2.34.1

