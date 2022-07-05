Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0AD8567397
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 17:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbiGEPzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 11:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiGEPzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 11:55:43 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CFB9C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 08:55:42 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id u12so1860836uap.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 08:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=58VGZFdcpimZozGUTVpY64Huy5XkBaMl9karQosi69Y=;
        b=3vRIc5Yhr4AArAzDArcRyTl6ST1JcE4FtPyQ2ESDJY3v8Jqa9u5nwVI/mthSvKEFou
         rKb3ksOc9/ICKe8GPr/QpamGkD0P/2MG6bypw0lRQY7CTEQuIV1NS8ofKWJlqGtNwUA5
         hK/LKvEznMQxbICwcyTn2ygMwMTIPYOMxhE7mmTnCRLiL2eb1CfX+V1zpkwRCOex4AI2
         RvvttSRp14puJut+Mf7zYGyBKoWDRP14vNT12MgSOlJSTfI72k2rBMv86xVqChqs/1zk
         Oqp+OoKFN2T39TZoZya736iooFaSJrUoWUmn/kjG3fS5Y1PmslvhvKIeUk61FtO/qZi6
         1kSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=58VGZFdcpimZozGUTVpY64Huy5XkBaMl9karQosi69Y=;
        b=t9YYbPtbBuQI0raL9PVuuUHbxd7YWAuar79+brjr4DHYPZY+ZlKfX4eNF2aiBbTFoe
         5SgDvWAWivkQGCDQa8OaZQ3OsW6a4XOYUKBdapbM2Z3dLdsD2PBy5BCYW/SqIQrriv5V
         ZOBH/AS0GUYB9YkRmD4MOwUuGJMHSYDqhAFFhNOeLXfNN9Gz0ujH0pNO5VIJp1Ub1+6K
         r4UMyWqrZoJQOecE2hgn7elD/YSlKxQ4SKIpuoT2EJH9A5iR/HSWxjRxkk9f1BcuEIOc
         MpYrEOWJdF4wq/sbaImrN5agLlth/X8jJdD4QxiIavHajwXT7PKNZ50QWeaAQvHrp0E/
         3Djg==
X-Gm-Message-State: AJIora8pn7cReN6OlppBb09G4RFZ8yXGXOIQuvfnFBdiHnOXN0LK4Jqm
        PSCLSgGc1cuc02AGLvtfNZ6M6g==
X-Google-Smtp-Source: AGRyM1uHvRbeZx4Thd0P6CLnFDBPplYRp3rrmZohmfNLH75f0WaD8G0zJQSRzBnBZjsUX92U4yUpag==
X-Received: by 2002:ab0:5969:0:b0:381:c2ef:79f8 with SMTP id o38-20020ab05969000000b00381c2ef79f8mr16700312uad.46.1657036541713;
        Tue, 05 Jul 2022 08:55:41 -0700 (PDT)
Received: from eze-laptop ([190.190.187.68])
        by smtp.gmail.com with ESMTPSA id h21-20020a1f9e15000000b003740bbd4882sm1489137vke.18.2022.07.05.08.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 08:55:41 -0700 (PDT)
Date:   Tue, 5 Jul 2022 12:55:35 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     mchehab@kernel.org, hverkuil@xs4all.nl, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, mripard@kernel.org,
        paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        nicolas.dufresne@collabora.com, andrzej.p@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com
Subject: Re: [PATCH v10 14/17] media: hantro: Stop using Hantro dedicated
 control
Message-ID: <YsRe9xTakSu3EPiV@eze-laptop>
References: <20220705085420.272912-1-benjamin.gaignard@collabora.com>
 <20220705085420.272912-15-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705085420.272912-15-benjamin.gaignard@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 10:54:17AM +0200, Benjamin Gaignard wrote:
> The number of bits to skip in the slice header can be computed
> in the driver by using sps, pps and decode_params information.
> This makes it possible to remove Hantro dedicated control.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Acked-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> Tested-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

I'm really glad we are getting rid of this control. Good job!

> ---
> version 10:
> - Fix lenght typo
> 
> version 9:
> - Reword commit message
> - Use fls()
> 
>  drivers/staging/media/hantro/hantro_drv.c     | 36 ------------------
>  .../staging/media/hantro/hantro_g2_hevc_dec.c | 37 ++++++++++++++++++-
>  include/media/hevc-ctrls.h                    | 13 -------
>  3 files changed, 36 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
> index 536c8c374952..5aac3a090480 100644
> --- a/drivers/staging/media/hantro/hantro_drv.c
> +++ b/drivers/staging/media/hantro/hantro_drv.c
> @@ -304,26 +304,6 @@ static int hantro_jpeg_s_ctrl(struct v4l2_ctrl *ctrl)
>  	return 0;
>  }
>  
> -static int hantro_hevc_s_ctrl(struct v4l2_ctrl *ctrl)

We'll need to add hantro_hevc_s_ctrl() back for 10-bit,
but I guess we still want to remove until needed.

Thanks,
Ezequiel

> -{
> -	struct hantro_ctx *ctx;
> -
> -	ctx = container_of(ctrl->handler,
> -			   struct hantro_ctx, ctrl_handler);
> -
> -	vpu_debug(1, "s_ctrl: id = %d, val = %d\n", ctrl->id, ctrl->val);
> -
> -	switch (ctrl->id) {
> -	case V4L2_CID_HANTRO_HEVC_SLICE_HEADER_SKIP:
> -		ctx->hevc_dec.ctrls.hevc_hdr_skip_length = ctrl->val;
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
>  static const struct v4l2_ctrl_ops hantro_ctrl_ops = {
>  	.try_ctrl = hantro_try_ctrl,
>  };
> @@ -332,10 +312,6 @@ static const struct v4l2_ctrl_ops hantro_jpeg_ctrl_ops = {
>  	.s_ctrl = hantro_jpeg_s_ctrl,
>  };
>  
> -static const struct v4l2_ctrl_ops hantro_hevc_ctrl_ops = {
> -	.s_ctrl = hantro_hevc_s_ctrl,
> -};
> -
>  #define HANTRO_JPEG_ACTIVE_MARKERS	(V4L2_JPEG_ACTIVE_MARKER_APP0 | \
>  					 V4L2_JPEG_ACTIVE_MARKER_COM | \
>  					 V4L2_JPEG_ACTIVE_MARKER_DQT | \
> @@ -487,18 +463,6 @@ static const struct hantro_ctrl controls[] = {
>  		.cfg = {
>  			.id = V4L2_CID_STATELESS_HEVC_SCALING_MATRIX,
>  		},
> -	}, {
> -		.codec = HANTRO_HEVC_DECODER,
> -		.cfg = {
> -			.id = V4L2_CID_HANTRO_HEVC_SLICE_HEADER_SKIP,
> -			.name = "Hantro HEVC slice header skip bytes",
> -			.type = V4L2_CTRL_TYPE_INTEGER,
> -			.min = 0,
> -			.def = 0,
> -			.max = 0x100,
> -			.step = 1,
> -			.ops = &hantro_hevc_ctrl_ops,
> -		},
>  	}, {
>  		.codec = HANTRO_VP9_DECODER,
>  		.cfg = {
> diff --git a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
> index d28653d04d20..233ecd863d5f 100644
> --- a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
> +++ b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
> @@ -117,6 +117,41 @@ static void prepare_tile_info_buffer(struct hantro_ctx *ctx)
>  		vpu_debug(1, "%s: no chroma!\n", __func__);
>  }
>  
> +static int compute_header_skip_length(struct hantro_ctx *ctx)
> +{
> +	const struct hantro_hevc_dec_ctrls *ctrls = &ctx->hevc_dec.ctrls;
> +	const struct v4l2_ctrl_hevc_decode_params *decode_params = ctrls->decode_params;
> +	const struct v4l2_ctrl_hevc_sps *sps = ctrls->sps;
> +	const struct v4l2_ctrl_hevc_pps *pps = ctrls->pps;
> +	int skip = 0;
> +
> +	if (pps->flags & V4L2_HEVC_PPS_FLAG_OUTPUT_FLAG_PRESENT)
> +		/* size of pic_output_flag */
> +		skip++;
> +
> +	if (sps->flags & V4L2_HEVC_SPS_FLAG_SEPARATE_COLOUR_PLANE)
> +		/* size of pic_order_cnt_lsb */
> +		skip += 2;
> +
> +	if (!(decode_params->flags & V4L2_HEVC_DECODE_PARAM_FLAG_IDR_PIC)) {
> +		/* size of pic_order_cnt_lsb */
> +		skip += sps->log2_max_pic_order_cnt_lsb_minus4 + 4;
> +
> +		/* size of short_term_ref_pic_set_sps_flag */
> +		skip++;
> +
> +		if (decode_params->short_term_ref_pic_set_size)
> +			/* size of st_ref_pic_set( num_short_term_ref_pic_sets ) */
> +			skip += decode_params->short_term_ref_pic_set_size;
> +		else if (sps->num_short_term_ref_pic_sets > 1)
> +			skip += fls(sps->num_short_term_ref_pic_sets - 1);
> +
> +		skip += decode_params->long_term_ref_pic_set_size;
> +	}
> +
> +	return skip;
> +}
> +
>  static void set_params(struct hantro_ctx *ctx)
>  {
>  	const struct hantro_hevc_dec_ctrls *ctrls = &ctx->hevc_dec.ctrls;
> @@ -134,7 +169,7 @@ static void set_params(struct hantro_ctx *ctx)
>  
>  	hantro_reg_write(vpu, &g2_output_8_bits, 0);
>  
> -	hantro_reg_write(vpu, &g2_hdr_skip_length, ctrls->hevc_hdr_skip_length);
> +	hantro_reg_write(vpu, &g2_hdr_skip_length, compute_header_skip_length(ctx));
>  
>  	min_log2_cb_size = sps->log2_min_luma_coding_block_size_minus3 + 3;
>  	max_log2_ctb_size = min_log2_cb_size + sps->log2_diff_max_min_luma_coding_block_size;
> diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
> index 42d16e8a1050..9239e8b649e0 100644
> --- a/include/media/hevc-ctrls.h
> +++ b/include/media/hevc-ctrls.h
> @@ -465,17 +465,4 @@ struct v4l2_ctrl_hevc_scaling_matrix {
>  	__u8	scaling_list_dc_coef_32x32[2];
>  };
>  
> -/*  MPEG-class control IDs specific to the Hantro driver as defined by V4L2 */
> -#define V4L2_CID_CODEC_HANTRO_BASE				(V4L2_CTRL_CLASS_CODEC | 0x1200)
> -/*
> - * V4L2_CID_HANTRO_HEVC_SLICE_HEADER_SKIP -
> - * the number of data (in bits) to skip in the
> - * slice segment header.
> - * If non-IDR, the bits to be skipped go from syntax element "pic_output_flag"
> - * to before syntax element "slice_temporal_mvp_enabled_flag".
> - * If IDR, the skipped bits are just "pic_output_flag"
> - * (separate_colour_plane_flag is not supported).
> - */
> -#define V4L2_CID_HANTRO_HEVC_SLICE_HEADER_SKIP	(V4L2_CID_CODEC_HANTRO_BASE + 0)
> -
>  #endif
> -- 
> 2.32.0
> 
