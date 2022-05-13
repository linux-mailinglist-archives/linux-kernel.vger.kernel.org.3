Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066A2526B8F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 22:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384459AbiEMUa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 16:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384421AbiEMUab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 16:30:31 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BCED90;
        Fri, 13 May 2022 13:29:50 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id CFA201F46480
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652473782;
        bh=tXo3Paam8CGdkIwbogEikERx9TE3LC/tz67H0npGqGM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TaPp+REA2++CtiLsq7gpfbs2LtRDeSV4+/jRSV6ELKHsB1TmsE/8u88f9262bEPvZ
         mJblGCQr45p3P2Vb0kQ0/q+3tuHwo7QfscquSVaRTxDIedZb4BQvK0b1dQYAp8DQiA
         JSTcTzhF5r5EVPro1KZG3DiRFV0iQioMxiJwRkArFHhgMbpA6oW4FhWcXBS9o1fNAn
         FtOdKv+TkIL5vNBf7mRK4mc/MVCJWPb2n2+BNiUCptTNV/mYH/C78VZoHWoa23Nkwm
         83Ks3T/ZaT0wD//eH2kje/rO04r6vPXAlP+m8ktKT66eTw3ktTYviOkjmoGrjABdzk
         bcwq2D28rAdPQ==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     nicolas@ndufresne.ca, linux-media@vger.kernel.org,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 06/20] media: h264: Sort p/b reflist using frame_num
Date:   Fri, 13 May 2022 16:29:08 -0400
Message-Id: <20220513202922.13846-7-nicolas.dufresne@collabora.com>
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

In the reference list builder, frame_num refers to FrameNumWrap
in the spec, which is the same as the pic_num for frame decoding.
The same applies for long_term_pic_num and long_term_frame_idx.

Sort all type of references by frame_num so the sort can be reused
for fields reflist were the sorting is done using frame_num instead.
In short, pic_num is never actually used for building reference
lists.

Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
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
2.34.3

