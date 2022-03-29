Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B549D4EAE01
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 14:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236972AbiC2M7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 08:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237006AbiC2M7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 08:59:05 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DB05FE8;
        Tue, 29 Mar 2022 05:57:21 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a02:3030:a:f397:f6bc:b726:2678:839f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id F171B1F43E4E;
        Tue, 29 Mar 2022 13:57:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648558640;
        bh=0/eM8y7CC28hyL7CRIcXsWD2R4OYiUOL/fNRodhqJEQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AcqzpMWSs7g/OISZ/TKhj/P2VsZkUeTelNjdt1JT7rWcJVLP8Blkwf7FzRBNtzmsE
         5fGvbAnj0CdVbCMWQHMhtmh0NF0VYpzPCoSsc+NsBSePcYsaEpE0L8JtE59cT3iyuX
         bLILpVJ45lMgU0s+SJSBLFhlPOAJ7UZFRB1JSYoSUfQjDGfNEu0/FvZxqBEDbNWa0K
         X8eDKgAdNZcF5YNCGMmCgH3NauLPlf37jLRT8atqouJkiFGfTIuGOsdQ6UeeAWGfns
         drej2dwKonaUE+rOUEtPSdJY8m0vrZ+NDzpBJyrJL3mq75Bhy9FMh+aaTigoTMofpT
         ltnFtXXogvIAw==
Date:   Tue, 29 Mar 2022 14:57:16 +0200
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>, kernel@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 05/24] media: h264: Store all fields into the
 unordered list
Message-ID: <20220329125716.qsuu24x5y4ezk2ob@basti-XPS-13-9310>
References: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
 <20220328195936.82552-6-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20220328195936.82552-6-nicolas.dufresne@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Nicolas,

On 28.03.2022 15:59, Nicolas Dufresne wrote:
>When the current picture is a field, store each field into the
>unordered_list. Doing this required preserving the top and bottom field
>poc.

I would slightly reword this to highlight that we talk about the
reference list and to improve the grammatic of the second sentence:

"""
If the current image is a field, each field is stored in the unordered
reference list, preserving the original picture order count of the
top and bottom fields.
"""

>
>Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>

>---
> drivers/media/v4l2-core/v4l2-h264.c | 65 +++++++++++++++++++++--------
> include/media/v4l2-h264.h           |  6 ++-
> 2 files changed, 51 insertions(+), 20 deletions(-)
>
>diff --git a/drivers/media/v4l2-core/v4l2-h264.c b/drivers/media/v4l2-core/v4l2-h264.c
>index 4c6bfb057bda..d5698c981973 100644
>--- a/drivers/media/v4l2-core/v4l2-h264.c
>+++ b/drivers/media/v4l2-core/v4l2-h264.c
>@@ -47,8 +47,6 @@ v4l2_h264_init_reflist_builder(struct v4l2_h264_reflist_builder *b,
> 	}
>
> 	for (i = 0; i < V4L2_H264_NUM_DPB_ENTRIES; i++) {
>-		u32 pic_order_count;
>-
> 		if (!(dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE))
> 			continue;
>
>@@ -59,8 +57,6 @@ v4l2_h264_init_reflist_builder(struct v4l2_h264_reflist_builder *b,
> 		/*
> 		 * Handle frame_num wraparound as described in section
> 		 * '8.2.4.1 Decoding process for picture numbers' of the spec.
>-		 * TODO: This logic will have to be adjusted when we start
>-		 * supporting interlaced content.

Ah, I see here you remove the TODO comment disregard my comment from
patch 3 please.

Greetings,
Sebastian

> 		 * For long term reference, frame_num is set to
> 		 * long_term_frame_idx which requires no wrapping.
> 		 */
>@@ -70,17 +66,33 @@ v4l2_h264_init_reflist_builder(struct v4l2_h264_reflist_builder *b,
> 		else
> 			b->refs[i].frame_num = dpb[i].frame_num;
>
>-		if (dpb[i].fields == V4L2_H264_FRAME_REF)
>-			pic_order_count = min(dpb[i].top_field_order_cnt,
>-					      dpb[i].bottom_field_order_cnt);
>-		else if (dpb[i].fields & V4L2_H264_BOTTOM_FIELD_REF)
>-			pic_order_count = dpb[i].bottom_field_order_cnt;
>-		else
>-			pic_order_count = dpb[i].top_field_order_cnt;
>+		b->refs[i].top_field_order_cnt = dpb[i].top_field_order_cnt;
>+		b->refs[i].bottom_field_order_cnt = dpb[i].bottom_field_order_cnt;
>+
>+		if (b->cur_pic_fields == V4L2_H264_FRAME_REF) {
>+			u8 fields = V4L2_H264_FRAME_REF;
>+
>+			b->unordered_reflist[b->num_valid].index = i;
>+			b->unordered_reflist[b->num_valid].fields = fields;

>+			b->num_valid++;
>+			continue;
>+		}
>+
>+		if (dpb[i].fields & V4L2_H264_TOP_FIELD_REF) {
>+			u8 fields = V4L2_H264_TOP_FIELD_REF;
>+
>+			b->unordered_reflist[b->num_valid].index = i;
>+			b->unordered_reflist[b->num_valid].fields = fields;
>+			b->num_valid++;
>+		}
>
>-		b->refs[i].pic_order_count = pic_order_count;
>-		b->unordered_reflist[b->num_valid].index = i;
>-		b->num_valid++;
>+		if (dpb[i].fields & V4L2_H264_BOTTOM_FIELD_REF) {
>+			u8 fields = V4L2_H264_BOTTOM_FIELD_REF;
>+
>+			b->unordered_reflist[b->num_valid].index = i;
>+			b->unordered_reflist[b->num_valid].fields = fields;
>+			b->num_valid++;
>+		}
> 	}
>
> 	for (i = b->num_valid; i < ARRAY_SIZE(b->unordered_reflist); i++)
>@@ -88,6 +100,23 @@ v4l2_h264_init_reflist_builder(struct v4l2_h264_reflist_builder *b,
> }
> EXPORT_SYMBOL_GPL(v4l2_h264_init_reflist_builder);
>
>+static s32 v4l2_h264_get_poc(const struct v4l2_h264_reflist_builder *b,
>+			     const struct v4l2_h264_reference *ref)
>+{
>+	switch (ref->fields) {
>+	case V4L2_H264_FRAME_REF:
>+		return min(b->refs[ref->index].top_field_order_cnt,
>+				b->refs[ref->index].bottom_field_order_cnt);
>+	case V4L2_H264_TOP_FIELD_REF:
>+		return b->refs[ref->index].top_field_order_cnt;
>+	case V4L2_H264_BOTTOM_FIELD_REF:
>+		return b->refs[ref->index].bottom_field_order_cnt;
>+	}
>+
>+	/* not reached */
>+	return 0;
>+}
>+
> static int v4l2_h264_p_ref_list_cmp(const void *ptra, const void *ptrb,
> 				    const void *data)
> {
>@@ -150,8 +179,8 @@ static int v4l2_h264_b0_ref_list_cmp(const void *ptra, const void *ptrb,
> 		       builder->refs[idxb].pic_num ?
> 		       -1 : 1;
>
>-	poca = builder->refs[idxa].pic_order_count;
>-	pocb = builder->refs[idxb].pic_order_count;
>+	poca = v4l2_h264_get_poc(builder, ptra);
>+	pocb = v4l2_h264_get_poc(builder, ptrb);
>
> 	/*
> 	 * Short term pics with POC < cur POC first in POC descending order
>@@ -195,8 +224,8 @@ static int v4l2_h264_b1_ref_list_cmp(const void *ptra, const void *ptrb,
> 		       builder->refs[idxb].pic_num ?
> 		       -1 : 1;
>
>-	poca = builder->refs[idxa].pic_order_count;
>-	pocb = builder->refs[idxb].pic_order_count;
>+	poca = v4l2_h264_get_poc(builder, ptra);
>+	pocb = v4l2_h264_get_poc(builder, ptrb);
>
> 	/*
> 	 * Short term pics with POC > cur POC first in POC ascending order
>diff --git a/include/media/v4l2-h264.h b/include/media/v4l2-h264.h
>index e165a54c68fa..4cef717b3f18 100644
>--- a/include/media/v4l2-h264.h
>+++ b/include/media/v4l2-h264.h
>@@ -15,7 +15,8 @@
> /**
>  * struct v4l2_h264_reflist_builder - Reference list builder object
>  *
>- * @refs.pic_order_count: reference picture order count
>+ * @refs.top_field_order_cnt: top field order count
>+ * @refs.bottom_field_order_cnt: bottom field order count
>  * @refs.frame_num: reference frame number
>  * @refs.pic_num: reference picture number
>  * @refs.longterm: set to true for a long term reference
>@@ -32,7 +33,8 @@
>  */
> struct v4l2_h264_reflist_builder {
> 	struct {
>-		s32 pic_order_count;
>+		s32 top_field_order_cnt;
>+		s32 bottom_field_order_cnt;
> 		int frame_num;
> 		u32 pic_num;
> 		u16 longterm : 1;
>-- 
>2.34.1
>
