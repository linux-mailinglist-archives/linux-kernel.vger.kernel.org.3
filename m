Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECB354B6A8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 18:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344626AbiFNQre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 12:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244118AbiFNQq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 12:46:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E81728987;
        Tue, 14 Jun 2022 09:46:56 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:9c07:3892:84e3:aba8] (unknown [IPv6:2a01:e0a:120:3210:9c07:3892:84e3:aba8])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3C2BA66016B0;
        Tue, 14 Jun 2022 17:46:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655225214;
        bh=T1oqS49XxbOgOShLZkSdFGRKIJ5qzYm6xIThOciGkN8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TAQ4xSf55b3J0A8YfpvBcCTbditlXBn+TqcVxPn6hetbnViwS5fRvqEfRVmpRvL7+
         ny8OQByTGN94hw/JlA77p+n+T+kZLzuHjjuan1tSge+5dEUDlbLhvXwXfU3TTBibPS
         9jD3yxjCoTwuK4qJUhRTfLIuLG1P9Xx63+ZL4rqFQmgO2+qHYgNoHxYyMgH0+LGFsq
         0NMBTvBLAmzEc+4WZcFhfOv044pawdNLHEl0JV8zVvgGQQmpjcb4ctPvgR3FK/3IIf
         vCaLF2XA7cwYtnqHX2UnP5pj8i6wwvyMja1gxfrg0RtytyVMe5vbqlARPmjBtUxuyZ
         jJykt4gYsF/nQ==
Message-ID: <f6c636b6-f379-650a-cc7c-6f1e8b014455@collabora.com>
Date:   Tue, 14 Jun 2022 18:46:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v8 14/17] media: hantro: Stop using Hantro dedicated
 control
Content-Language: en-US
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil@xs4all.nl>, mchehab@kernel.org,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, mripard@kernel.org,
        paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        andrzej.p@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com
References: <20220614083614.240641-1-benjamin.gaignard@collabora.com>
 <20220614083614.240641-15-benjamin.gaignard@collabora.com>
 <b244e86d-06de-7423-d0df-e77485ce4c87@xs4all.nl>
 <958ab30f9cfbb14e4a7ea55826064e6a20d5ffd2.camel@collabora.com>
 <c5c6903d-ec7d-6218-35d3-2ac6caa9d2c5@xs4all.nl>
 <ac31307f9186fc851f76889a66ffb007de88fa15.camel@collabora.com>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <ac31307f9186fc851f76889a66ffb007de88fa15.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URI_DOTEDU autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 14/06/2022 à 18:23, Nicolas Dufresne a écrit :
> Le mardi 14 juin 2022 à 17:47 +0200, Hans Verkuil a écrit :
>> On 6/14/22 17:43, Nicolas Dufresne wrote:
>>> Le mardi 14 juin 2022 à 15:58 +0200, Hans Verkuil a écrit :
>>>> On 6/14/22 10:36, Benjamin Gaignard wrote:
>>>>> The number of bits to skip in the slice header can be computed
>>>>> in the driver by using sps, pps and decode_params information.
>>>>> This allow to remove Hantro dedicated control.
>>>> allow -> makes it possible
>>>>
>>>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>>>>> ---
>>>>>   drivers/staging/media/hantro/hantro_drv.c     | 36 -----------
>>>>>   .../staging/media/hantro/hantro_g2_hevc_dec.c | 62 ++++++++++++++++++-
>>>>>   include/media/hevc-ctrls.h                    | 13 ----
>>>>>   3 files changed, 61 insertions(+), 50 deletions(-)
>>>>>
>>>>> diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
>>>>> index 536c8c374952..5aac3a090480 100644
>>>>> --- a/drivers/staging/media/hantro/hantro_drv.c
>>>>> +++ b/drivers/staging/media/hantro/hantro_drv.c
>>>>> @@ -304,26 +304,6 @@ static int hantro_jpeg_s_ctrl(struct v4l2_ctrl *ctrl)
>>>>>   	return 0;
>>>>>   }
>>>>>   
>>>>> -static int hantro_hevc_s_ctrl(struct v4l2_ctrl *ctrl)
>>>>> -{
>>>>> -	struct hantro_ctx *ctx;
>>>>> -
>>>>> -	ctx = container_of(ctrl->handler,
>>>>> -			   struct hantro_ctx, ctrl_handler);
>>>>> -
>>>>> -	vpu_debug(1, "s_ctrl: id = %d, val = %d\n", ctrl->id, ctrl->val);
>>>>> -
>>>>> -	switch (ctrl->id) {
>>>>> -	case V4L2_CID_HANTRO_HEVC_SLICE_HEADER_SKIP:
>>>>> -		ctx->hevc_dec.ctrls.hevc_hdr_skip_length = ctrl->val;
>>>>> -		break;
>>>>> -	default:
>>>>> -		return -EINVAL;
>>>>> -	}
>>>>> -
>>>>> -	return 0;
>>>>> -}
>>>>> -
>>>>>   static const struct v4l2_ctrl_ops hantro_ctrl_ops = {
>>>>>   	.try_ctrl = hantro_try_ctrl,
>>>>>   };
>>>>> @@ -332,10 +312,6 @@ static const struct v4l2_ctrl_ops hantro_jpeg_ctrl_ops = {
>>>>>   	.s_ctrl = hantro_jpeg_s_ctrl,
>>>>>   };
>>>>>   
>>>>> -static const struct v4l2_ctrl_ops hantro_hevc_ctrl_ops = {
>>>>> -	.s_ctrl = hantro_hevc_s_ctrl,
>>>>> -};
>>>>> -
>>>>>   #define HANTRO_JPEG_ACTIVE_MARKERS	(V4L2_JPEG_ACTIVE_MARKER_APP0 | \
>>>>>   					 V4L2_JPEG_ACTIVE_MARKER_COM | \
>>>>>   					 V4L2_JPEG_ACTIVE_MARKER_DQT | \
>>>>> @@ -487,18 +463,6 @@ static const struct hantro_ctrl controls[] = {
>>>>>   		.cfg = {
>>>>>   			.id = V4L2_CID_STATELESS_HEVC_SCALING_MATRIX,
>>>>>   		},
>>>>> -	}, {
>>>>> -		.codec = HANTRO_HEVC_DECODER,
>>>>> -		.cfg = {
>>>>> -			.id = V4L2_CID_HANTRO_HEVC_SLICE_HEADER_SKIP,
>>>>> -			.name = "Hantro HEVC slice header skip bytes",
>>>>> -			.type = V4L2_CTRL_TYPE_INTEGER,
>>>>> -			.min = 0,
>>>>> -			.def = 0,
>>>>> -			.max = 0x100,
>>>>> -			.step = 1,
>>>>> -			.ops = &hantro_hevc_ctrl_ops,
>>>>> -		},
>>>>>   	}, {
>>>>>   		.codec = HANTRO_VP9_DECODER,
>>>>>   		.cfg = {
>>>>> diff --git a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
>>>>> index d28653d04d20..3be8d6e60bf0 100644
>>>>> --- a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
>>>>> +++ b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
>>>>> @@ -117,6 +117,66 @@ static void prepare_tile_info_buffer(struct hantro_ctx *ctx)
>>>>>   		vpu_debug(1, "%s: no chroma!\n", __func__);
>>>>>   }
>>>>>   
>>>>> +static unsigned int ceil_log2(unsigned int v)
>>>>> +{
>>>>> +	/* Compute Ceil(Log2(v))
>>>>> +	 * Derived from branchless code for integer log2(v) from:
>>>>> +	 * <http://graphics.stanford.edu/~seander/bithacks.html#IntegerLog>
>>>>> +	 */
>>>>> +	unsigned int r, shift;
>>>>> +
>>>>> +	v--;
>>>>> +	r = (v > 0xFFFF) << 4;
>>>>> +	v >>= r;
>>>>> +	shift = (v > 0xFF) << 3;
>>>>> +	v >>= shift;
>>>>> +	r |= shift;
>>>>> +	shift = (v > 0xF) << 2;
>>>>> +	v >>= shift;
>>>>> +	r |= shift;
>>>>> +	shift = (v > 0x3) << 1;
>>>>> +	v >>= shift;
>>>>> +	r |= shift;
>>>>> +	r |= (v >> 1);
>>>>> +
>>>>> +	return r + 1;
>>>>> +}
>>>> Isn't this identical to fls(v - 1)? See also lib/math/reciprocal_div.c
>>>> where this is used.
>>> Thanks for pointing this out, I was wondering if there was an equivalent, and
>>> never knew there was a relation between log2() and the "last set bit". Not sure
>>> about the -1 here though, can you extend ?
>> Based on how lib/math/reciprocal_div.c did it. Also, the ceil_log2 function
>> starts with v--, while fls doesn't. That said, it's wise to verify that that
>> is correct.
> Just for the reference, from lib/math/reciprocal_div.c:
>
> 	/* ceil(log2(d)) */
> 	l = fls(d - 1);
>
> Perhaps fls() return position starting from 1 rather then 0 ?

I have compare the results of ceil_log2(d) vs fls(d-1)
for values between 2 (because sps->num_short_term_ref_pic_sets > 1) and 16 (the maximum number of frames)
they are always the same so I will remove ceil_log2() and use fls().

Regards,
Benjamin

>
> Nicolas
>
>> Regards,
>>
>> 	Hans
>>
>>>> Regards,
>>>>
>>>> 	Hans
>>>>
>>>>> +
>>>>> +static int compute_header_skip_lenght(struct hantro_ctx *ctx)
>>>>> +{
>>>>> +	const struct hantro_hevc_dec_ctrls *ctrls = &ctx->hevc_dec.ctrls;
>>>>> +	const struct v4l2_ctrl_hevc_decode_params *decode_params = ctrls->decode_params;
>>>>> +	const struct v4l2_ctrl_hevc_sps *sps = ctrls->sps;
>>>>> +	const struct v4l2_ctrl_hevc_pps *pps = ctrls->pps;
>>>>> +	int skip = 0;
>>>>> +
>>>>> +	if (pps->flags & V4L2_HEVC_PPS_FLAG_OUTPUT_FLAG_PRESENT)
>>>>> +		/* size of pic_output_flag */
>>>>> +		skip++;
>>>>> +
>>>>> +	if (sps->flags & V4L2_HEVC_SPS_FLAG_SEPARATE_COLOUR_PLANE)
>>>>> +		/* size of pic_order_cnt_lsb */
>>>>> +		skip += 2;
>>>>> +
>>>>> +	if (!(decode_params->flags & V4L2_HEVC_DECODE_PARAM_FLAG_IDR_PIC)) {
>>>>> +		/* size of pic_order_cnt_lsb */
>>>>> +		skip += sps->log2_max_pic_order_cnt_lsb_minus4 + 4;
>>>>> +
>>>>> +		/* size of short_term_ref_pic_set_sps_flag */
>>>>> +		skip++;
>>>>> +
>>>>> +		if (decode_params->short_term_ref_pic_set_size)
>>>>> +			/* size of st_ref_pic_set( num_short_term_ref_pic_sets ) */
>>>>> +			skip += decode_params->short_term_ref_pic_set_size;
>>>>> +		else if (sps->num_short_term_ref_pic_sets > 1)
>>>>> +			skip += ceil_log2(sps->num_short_term_ref_pic_sets);
>>>>> +
>>>>> +		skip += decode_params->long_term_ref_pic_set_size;
>>>>> +	}
>>>>> +
>>>>> +	return skip;
>>>>> +}
>>>>> +
>>>>>   static void set_params(struct hantro_ctx *ctx)
>>>>>   {
>>>>>   	const struct hantro_hevc_dec_ctrls *ctrls = &ctx->hevc_dec.ctrls;
>>>>> @@ -134,7 +194,7 @@ static void set_params(struct hantro_ctx *ctx)
>>>>>   
>>>>>   	hantro_reg_write(vpu, &g2_output_8_bits, 0);
>>>>>   
>>>>> -	hantro_reg_write(vpu, &g2_hdr_skip_length, ctrls->hevc_hdr_skip_length);
>>>>> +	hantro_reg_write(vpu, &g2_hdr_skip_length, compute_header_skip_lenght(ctx));
>>>>>   
>>>>>   	min_log2_cb_size = sps->log2_min_luma_coding_block_size_minus3 + 3;
>>>>>   	max_log2_ctb_size = min_log2_cb_size + sps->log2_diff_max_min_luma_coding_block_size;
>>>>> diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
>>>>> index d6cb3779d190..efc0412ac41e 100644
>>>>> --- a/include/media/hevc-ctrls.h
>>>>> +++ b/include/media/hevc-ctrls.h
>>>>> @@ -467,17 +467,4 @@ struct v4l2_ctrl_hevc_scaling_matrix {
>>>>>   	__u8	scaling_list_dc_coef_32x32[2];
>>>>>   };
>>>>>   
>>>>> -/*  MPEG-class control IDs specific to the Hantro driver as defined by V4L2 */
>>>>> -#define V4L2_CID_CODEC_HANTRO_BASE				(V4L2_CTRL_CLASS_CODEC | 0x1200)
>>>>> -/*
>>>>> - * V4L2_CID_HANTRO_HEVC_SLICE_HEADER_SKIP -
>>>>> - * the number of data (in bits) to skip in the
>>>>> - * slice segment header.
>>>>> - * If non-IDR, the bits to be skipped go from syntax element "pic_output_flag"
>>>>> - * to before syntax element "slice_temporal_mvp_enabled_flag".
>>>>> - * If IDR, the skipped bits are just "pic_output_flag"
>>>>> - * (separate_colour_plane_flag is not supported).
>>>>> - */
>>>>> -#define V4L2_CID_HANTRO_HEVC_SLICE_HEADER_SKIP	(V4L2_CID_CODEC_HANTRO_BASE + 0)
>>>>> -
>>>>>   #endif
