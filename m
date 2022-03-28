Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A29A4EA0F3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344203AbiC1UB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344160AbiC1UBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:01:43 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57DE3A5CF;
        Mon, 28 Mar 2022 12:59:59 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 1D4421F4385A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648497598;
        bh=cei8NQmJ3TQDsmsIXeEFyhyT52qbmE8s5HKgYlTiliQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KYfn2tqpyXuUTYu+iBNMPH3apa1ZTg6CQYlSGTN5gC840rvAg6XvtPcNTypmcsTxE
         NQeW4/eTrrvoKkBGI/hg/Wbe41Ucv7xsss7v0chUyvj8DMC77XSY+Lb/AKE9sfklXG
         4BfeR+e7YA0l6059BP8Agpps6MHiqlhReR5HMPYbsE9kfpLSGAU/GBX3WetSdMTqhL
         zcrnXghE9nYXwW1OYorY2HUTBSy8SGDdinNmqzBj6vcrToIMehSmiJMHJVlx9HZnOd
         L4zDm7TGImyyNmI6zZ6cFp3hZNRMsQJjPB2EpFuPzDNe3StMTyXRFRbYTjjPbOlRmx
         kUxtCxRlCj+9g==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kernel@collabora.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 07/24] media: h264: Sort p/b reflist using frame_num
Date:   Mon, 28 Mar 2022 15:59:19 -0400
Message-Id: <20220328195936.82552-8-nicolas.dufresne@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
References: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
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

In the reference list builder, frame_num referers to FrameNumWrap
in the spec, which is the same as the pic_num for frame decoding.
The same applied for long_tern_pic_num and long_ter_frame_idx.

Sort all type of references by frame_num so the sort can be reused
for field reflist were the sorting is done using frame_num instead.
In short, pic_num is never actually used for building reference
lists.

Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 drivers/media/v4l2-core/v4l2-h264.c | 22 ++++++++++++----------
 include/media/v4l2-h264.h           |  2 --
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-h264.c b/drivers/media/v4l2-core/v4l2-h264.c
index c9e18fd51d78..c3fad382882d 100644
--- a/drivers/media/v4l2-core/v4l2-h264.c
+++ b/drivers/media/v4l2-core/v4l2-h264.c
@@ -50,7 +50,6 @@ v4l2_h264_init_reflist_builder(struct v4l2_h264_reflist_builder *b,
 		if (!(dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE))
 			continue;
 
-		b->refs[i].pic_num = dpb[i].pic_num;
 		if (dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_LONG_TERM)
 			b->refs[i].longterm = true;
 
@@ -139,15 +138,18 @@ static int v4l2_h264_p_ref_list_cmp(const void *ptra, const void *ptrb,
 	}
 
 	/*
-	 * Short term pics in descending pic num order, long term ones in
-	 * ascending order.
+	 * For frames, short term pics are in descending pic num order and long
+	 * term ones in ascending order. For field this is the same direction
+	 * but with frame_num (wrapped). As for frame the pic_num and frame_num
+	 * are the same (see formula (8-28) and (8-29)) use the frame_num and share
+	 * this funciton between frame and field reflist.
 	 */
 	if (!builder->refs[idxa].longterm)
 		return builder->refs[idxb].frame_num <
 		       builder->refs[idxa].frame_num ?
 		       -1 : 1;
 
-	return builder->refs[idxa].pic_num < builder->refs[idxb].pic_num ?
+	return builder->refs[idxa].frame_num < builder->refs[idxb].frame_num ?
 	       -1 : 1;
 }
 
@@ -173,10 +175,10 @@ static int v4l2_h264_b0_ref_list_cmp(const void *ptra, const void *ptrb,
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
@@ -218,10 +220,10 @@ static int v4l2_h264_b1_ref_list_cmp(const void *ptra, const void *ptrb,
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

