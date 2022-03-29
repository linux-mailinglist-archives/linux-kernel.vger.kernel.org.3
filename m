Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F564EAA1D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 11:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234443AbiC2JJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 05:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233938AbiC2JJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 05:09:21 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16CA22C6E2;
        Tue, 29 Mar 2022 02:07:37 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a02:3030:a:f397:f6bc:b726:2678:839f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 2CB861F43AF6;
        Tue, 29 Mar 2022 10:07:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648544856;
        bh=1BuwoOIZJ0Qlkeqtne4zNXvl3G8eIuGrjAvEo71QLKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LFMIhgzmMZVXJc5vxtg7yTsVn/G39y0BXQJOtQcxy3y6KIAwaJJZcmUmr/6+3JR1W
         GQN+uhfFd04yoNNCV3y5X92Oeix5OfKIIJQD/a+Yr4aTvzjOEOvlUuzXj8WFoUNRai
         w4K4Ybn3xxIbuqZp93svoyyH4EKp9cVI+97CXsj4ciux4pqTmBK0QbVRgYU7xK/DWj
         Ejbo6IEM0sw8aGlYt4zLE9V+BMuhMep2i0RF7UAB3Bm3MFZA/EVyNmO3TRHmhGiDEC
         oI26TGoOJhy9XXRUuWVcc8SnzRaJnFDgPUneWa/HbqyOp6R5TSvbuQqLo2Z2U5qrnc
         mV+eUg42a8oww==
Date:   Tue, 29 Mar 2022 11:07:31 +0200
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>, kernel@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 04/24] media: h264: Store current picture fields
Message-ID: <20220329090731.nzzo7ht5xgze3x4b@basti-XPS-13-9310>
References: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
 <20220328195936.82552-5-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20220328195936.82552-5-nicolas.dufresne@collabora.com>
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
>This information, also called picture structure will be needed to construct

s/picture structure/picture structure,/
(minor.. but still ;))

>reference list when decoding field.

s/will be needed to construct reference list when decoding field./
   is required in field decoding mode to construct reference lists./

>
>Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>

>---
> drivers/media/v4l2-core/v4l2-h264.c | 10 +++++++---
> include/media/v4l2-h264.h           |  4 ++++
> 2 files changed, 11 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/media/v4l2-core/v4l2-h264.c b/drivers/media/v4l2-core/v4l2-h264.c
>index aebed1cbe05a..4c6bfb057bda 100644
>--- a/drivers/media/v4l2-core/v4l2-h264.c
>+++ b/drivers/media/v4l2-core/v4l2-h264.c
>@@ -34,13 +34,17 @@ v4l2_h264_init_reflist_builder(struct v4l2_h264_reflist_builder *b,
> 	cur_frame_num = dec_params->frame_num;
>
> 	memset(b, 0, sizeof(*b));
>-	if (!(dec_params->flags & V4L2_H264_DECODE_PARAM_FLAG_FIELD_PIC))
>+	if (!(dec_params->flags & V4L2_H264_DECODE_PARAM_FLAG_FIELD_PIC)) {
> 		b->cur_pic_order_count = min(dec_params->bottom_field_order_cnt,
> 					     dec_params->top_field_order_cnt);
>-	else if (dec_params->flags & V4L2_H264_DECODE_PARAM_FLAG_BOTTOM_FIELD)
>+		b->cur_pic_fields = V4L2_H264_FRAME_REF;
>+	} else if (dec_params->flags & V4L2_H264_DECODE_PARAM_FLAG_BOTTOM_FIELD) {
> 		b->cur_pic_order_count = dec_params->bottom_field_order_cnt;
>-	else
>+		b->cur_pic_fields = V4L2_H264_BOTTOM_FIELD_REF;
>+	} else {
> 		b->cur_pic_order_count = dec_params->top_field_order_cnt;
>+		b->cur_pic_fields = V4L2_H264_TOP_FIELD_REF;
>+	}
>
> 	for (i = 0; i < V4L2_H264_NUM_DPB_ENTRIES; i++) {
> 		u32 pic_order_count;
>diff --git a/include/media/v4l2-h264.h b/include/media/v4l2-h264.h
>index e282fb16ac58..e165a54c68fa 100644
>--- a/include/media/v4l2-h264.h
>+++ b/include/media/v4l2-h264.h
>@@ -21,6 +21,7 @@
>  * @refs.longterm: set to true for a long term reference
>  * @refs: array of references
>  * @cur_pic_order_count: picture order count of the frame being decoded
>+ * @cur_pic_fields: fields present in the frame being decoded

As there are only three choices:
```
#define V4L2_H264_TOP_FIELD_REF				0x1
#define V4L2_H264_BOTTOM_FIELD_REF			0x2
#define V4L2_H264_FRAME_REF				0x3
```

Maybe it would help to say:
  * @cur_pic_fields: fields present in the frame being decoded (top/bottom/both)

Greetings,
Sebastian

>  * @unordered_reflist: unordered list of references. Will be used to generate
>  *		       ordered P/B0/B1 lists
>  * @num_valid: number of valid references in the refs array
>@@ -36,7 +37,10 @@ struct v4l2_h264_reflist_builder {
> 		u32 pic_num;
> 		u16 longterm : 1;
> 	} refs[V4L2_H264_NUM_DPB_ENTRIES];
>+
> 	s32 cur_pic_order_count;
>+	u8 cur_pic_fields;
>+
> 	struct v4l2_h264_reference unordered_reflist[V4L2_H264_REF_LIST_LEN];
> 	u8 num_valid;
> };
>-- 
>2.34.1
>
