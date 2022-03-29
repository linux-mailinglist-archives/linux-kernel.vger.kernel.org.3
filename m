Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D1E4EAE94
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 15:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237370AbiC2Nga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 09:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237361AbiC2Ng1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 09:36:27 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87EC24F1C;
        Tue, 29 Mar 2022 06:34:44 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a02:3030:a:f397:f6bc:b726:2678:839f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 7287A1F43E8A;
        Tue, 29 Mar 2022 14:34:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648560883;
        bh=mw2lnNcKQgzkmIX92vMYzPG0ozHkEL7vt1dPMHbwDBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z+UVVCYaAPDIuQO43XpFCDQB5et0nfUsweNkYyuvNPr69YNOhavC9TQQS5woGC5Pe
         Cx3IWQmKyGaRsihIvWXwhxrfuN79va9vfMFIsFqzEyiQhdwbpMGmjRw5NRQ9k3zMUF
         jC0mkKkpLwaUsXp4agzcN5UD6snCplE8xSoARnCAd2bfBRsyymsmcKeOTfA/qYfkq/
         XYbiJ6l6PT3NvSbJFOz0Mj4pmlKBjOvztKOrmIQh5D2p6HucLEoPIuExSMxw2lgUX+
         gHzGDSqVUtNTC6EpT5e+pgr8JgW4flNOSUwLWrOUTRHEcQsIm4ndQ6miNE9EPPs12f
         lIe7isnLs1GXQ==
Date:   Tue, 29 Mar 2022 15:34:39 +0200
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>, kernel@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 07/24] media: h264: Sort p/b reflist using frame_num
Message-ID: <20220329133439.qt6bze35bppx3mne@basti-XPS-13-9310>
References: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
 <20220328195936.82552-8-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20220328195936.82552-8-nicolas.dufresne@collabora.com>
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
>In the reference list builder, frame_num referers to FrameNumWrap

s/referers/refers/

>in the spec, which is the same as the pic_num for frame decoding.
>The same applied for long_tern_pic_num and long_ter_frame_idx.

s/same applied/same applies/
s/long_ter_frame_idx/long_term_frame_idx/

>
>Sort all type of references by frame_num so the sort can be reused

s/frame_num so the sort/frame_num, so the order/

>for field reflist were the sorting is done using frame_num instead.

s/field/the field/
s/reflist were the sorting is done using frame_num instead/
   reflist, which is sorted by the frame_num instead/

>In short, pic_num is never actually used for building reference
>lists.
>
>Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>

>---
> drivers/media/v4l2-core/v4l2-h264.c | 22 ++++++++++++----------
> include/media/v4l2-h264.h           |  2 --
> 2 files changed, 12 insertions(+), 12 deletions(-)
>
>diff --git a/drivers/media/v4l2-core/v4l2-h264.c b/drivers/media/v4l2-core/v4l2-h264.c
>index c9e18fd51d78..c3fad382882d 100644
>--- a/drivers/media/v4l2-core/v4l2-h264.c
>+++ b/drivers/media/v4l2-core/v4l2-h264.c
>@@ -50,7 +50,6 @@ v4l2_h264_init_reflist_builder(struct v4l2_h264_reflist_builder *b,
> 		if (!(dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE))
> 			continue;
>
>-		b->refs[i].pic_num = dpb[i].pic_num;
> 		if (dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_LONG_TERM)
> 			b->refs[i].longterm = true;
>
>@@ -139,15 +138,18 @@ static int v4l2_h264_p_ref_list_cmp(const void *ptra, const void *ptrb,
> 	}
>
> 	/*
>-	 * Short term pics in descending pic num order, long term ones in
>-	 * ascending order.
>+	 * For frames, short term pics are in descending pic num order and long
>+	 * term ones in ascending order. For field this is the same direction

s/For field this is the same direction/For fields the same direction is used/

>+	 * but with frame_num (wrapped). As for frame the pic_num and frame_num
>+	 * are the same (see formula (8-28) and (8-29)) use the frame_num and share

s/As for frame the pic_num and frame_num are the same/
   The fields pic_num and frame_num are the same for frames/

>+	 * this funciton between frame and field reflist.

s/funciton/function/

Greetings,
Sebastian

> 	 */
> 	if (!builder->refs[idxa].longterm)
> 		return builder->refs[idxb].frame_num <
> 		       builder->refs[idxa].frame_num ?
> 		       -1 : 1;
>
>-	return builder->refs[idxa].pic_num < builder->refs[idxb].pic_num ?
>+	return builder->refs[idxa].frame_num < builder->refs[idxb].frame_num ?
> 	       -1 : 1;
> }
>
>@@ -173,10 +175,10 @@ static int v4l2_h264_b0_ref_list_cmp(const void *ptra, const void *ptrb,
> 			return 1;
> 	}
>
>-	/* Long term pics in ascending pic num order. */
>+	/* Long term pics in ascending frame num order. */
> 	if (builder->refs[idxa].longterm)
>-		return builder->refs[idxa].pic_num <
>-		       builder->refs[idxb].pic_num ?
>+		return builder->refs[idxa].frame_num <
>+		       builder->refs[idxb].frame_num ?
> 		       -1 : 1;
>
> 	poca = v4l2_h264_get_poc(builder, ptra);
>@@ -218,10 +220,10 @@ static int v4l2_h264_b1_ref_list_cmp(const void *ptra, const void *ptrb,
> 			return 1;
> 	}
>
>-	/* Long term pics in ascending pic num order. */
>+	/* Long term pics in ascending frame num order. */
> 	if (builder->refs[idxa].longterm)
>-		return builder->refs[idxa].pic_num <
>-		       builder->refs[idxb].pic_num ?
>+		return builder->refs[idxa].frame_num <
>+		       builder->refs[idxb].frame_num ?
> 		       -1 : 1;
>
> 	poca = v4l2_h264_get_poc(builder, ptra);
>diff --git a/include/media/v4l2-h264.h b/include/media/v4l2-h264.h
>index 4cef717b3f18..0d9eaa956123 100644
>--- a/include/media/v4l2-h264.h
>+++ b/include/media/v4l2-h264.h
>@@ -18,7 +18,6 @@
>  * @refs.top_field_order_cnt: top field order count
>  * @refs.bottom_field_order_cnt: bottom field order count
>  * @refs.frame_num: reference frame number
>- * @refs.pic_num: reference picture number
>  * @refs.longterm: set to true for a long term reference
>  * @refs: array of references
>  * @cur_pic_order_count: picture order count of the frame being decoded
>@@ -36,7 +35,6 @@ struct v4l2_h264_reflist_builder {
> 		s32 top_field_order_cnt;
> 		s32 bottom_field_order_cnt;
> 		int frame_num;
>-		u32 pic_num;
> 		u16 longterm : 1;
> 	} refs[V4L2_H264_NUM_DPB_ENTRIES];
>
>-- 
>2.34.1
>
