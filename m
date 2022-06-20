Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25CF25524DC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 21:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237145AbiFTTyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 15:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiFTTyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 15:54:18 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7C81C134;
        Mon, 20 Jun 2022 12:54:16 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id g27so9395014wrb.10;
        Mon, 20 Jun 2022 12:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s2WOQUH0wXSdYV78PK0Csxc8qJyHls+YdgLQRT9Q8rg=;
        b=miAYxyNOGr4WuC7CQuRPsnYVVf7RSPCkPV9973meC08nyP9OtGJ6RXFsa8d7m45Fm+
         hoS1clWlitq5K43xX0bZUaWF0Dpwy+BB1yHppd4dmbQRIvz3a0Klzia1wZ3WUt7CPj4I
         tY2KxPiN6tI1/B6WoZNcQZJ+R7B0bxRgq5JfIJC+dlDddOJs58m9zBGaPvscJIir6NZm
         8n17gbnSTCQ0Yy55MYqVbGOx8wz5CZvWaJBPIfmh3ZXSWODq+C6LQlsaLo/P/q8630Y7
         W8u5OaI4n+LMk6/XoJSOT+OGFX/TA1nA1OCG7BQu0wJFM8uTy4Db8TIFDw7fjOBq8aHv
         v8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s2WOQUH0wXSdYV78PK0Csxc8qJyHls+YdgLQRT9Q8rg=;
        b=P7WbcDoeDPy6bi8Q2h6jviD9Yy0qdLlEO57YlxtK5q0TLYot4M5erLYGn6Ti6DD5wb
         sJ0BOAfBN+cxibrDF/8OqToCxOvUL5wwgTJgg177hQDozdMFPeZSBzdkAfsc3PmM5eZl
         R6e70GTSBQK7k8aHj1yTscKyQ2FtBWFsMjKcvERMyW67S93sze0pqyL2ohrNEGJU+Yvb
         4/t1mVrgvqsrVx3I9Ld/vMiAitoA2LmfEcOogtdeAcx9aZzCLa+WDhq6cQul8VWdWWbn
         mM9CVRWk6GKEuxtVB0QcRXv3lAiUlZ+mEY1Oo566cEOG/+dzzZ+kJQ4gEThfKLpnlKBK
         +UgQ==
X-Gm-Message-State: AJIora+CzzCe2au4StoMhKJ+oRSR0VzB5LXCaRZQCHX3CQrWJiKqC5Gw
        t1hGBZALj68xEY5grmU0a30=
X-Google-Smtp-Source: AGRyM1swaMVmkvG35QSSlyaKvF4+h/fJGbr8Dk32vCzFNayDWA3Oms7SncdE5PLQv7zzWK7tV6Sspw==
X-Received: by 2002:a5d:5941:0:b0:21a:342d:510f with SMTP id e1-20020a5d5941000000b0021a342d510fmr22671176wri.700.1655754855039;
        Mon, 20 Jun 2022 12:54:15 -0700 (PDT)
Received: from jernej-laptop.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id t5-20020a05600001c500b0020d106c0386sm5806017wrx.89.2022.06.20.12.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 12:54:14 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     mchehab@kernel.org, hverkuil@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, mripard@kernel.org,
        paul.kocialkowski@bootlin.com, wens@csie.org, samuel@sholland.org,
        nicolas.dufresne@collabora.com, andrzej.p@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: Re: [PATCH v9 14/17] media: hantro: Stop using Hantro dedicated control
Date:   Mon, 20 Jun 2022 21:54:12 +0200
Message-ID: <11999002.O9o76ZdvQC@jernej-laptop>
In-Reply-To: <20220617083545.133920-15-benjamin.gaignard@collabora.com>
References: <20220617083545.133920-1-benjamin.gaignard@collabora.com> <20220617083545.133920-15-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 17. junij 2022 ob 10:35:42 CEST je Benjamin Gaignard napisal(a):
> The number of bits to skip in the slice header can be computed
> in the driver by using sps, pps and decode_params information.
> This makes it possible to remove Hantro dedicated control.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
> version 9:
> - Reword commit message
> - Use fls()
> 
>  drivers/staging/media/hantro/hantro_drv.c     | 36 ------------------
>  .../staging/media/hantro/hantro_g2_hevc_dec.c | 37 ++++++++++++++++++-
>  include/media/hevc-ctrls.h                    | 13 -------
>  3 files changed, 36 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/staging/media/hantro/hantro_drv.c
> b/drivers/staging/media/hantro/hantro_drv.c index
> 536c8c374952..5aac3a090480 100644
> --- a/drivers/staging/media/hantro/hantro_drv.c
> +++ b/drivers/staging/media/hantro/hantro_drv.c
> @@ -304,26 +304,6 @@ static int hantro_jpeg_s_ctrl(struct v4l2_ctrl *ctrl)
>  	return 0;
>  }
> 
> -static int hantro_hevc_s_ctrl(struct v4l2_ctrl *ctrl)
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
> @@ -332,10 +312,6 @@ static const struct v4l2_ctrl_ops hantro_jpeg_ctrl_ops
> = { .s_ctrl = hantro_jpeg_s_ctrl,
>  };
> 
> -static const struct v4l2_ctrl_ops hantro_hevc_ctrl_ops = {
> -	.s_ctrl = hantro_hevc_s_ctrl,
> -};
> -
>  #define HANTRO_JPEG_ACTIVE_MARKERS	(V4L2_JPEG_ACTIVE_MARKER_APP0 | 
\
>  					 
V4L2_JPEG_ACTIVE_MARKER_COM | \
>  					 
V4L2_JPEG_ACTIVE_MARKER_DQT | \
> @@ -487,18 +463,6 @@ static const struct hantro_ctrl controls[] = {
>  		.cfg = {
>  			.id = 
V4L2_CID_STATELESS_HEVC_SCALING_MATRIX,
>  		},
> -	}, {
> -		.codec = HANTRO_HEVC_DECODER,
> -		.cfg = {
> -			.id = 
V4L2_CID_HANTRO_HEVC_SLICE_HEADER_SKIP,
> -			.name = "Hantro HEVC slice header skip 
bytes",
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
> diff --git a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
> b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c index
> d28653d04d20..9eac133bda68 100644
> --- a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
> +++ b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
> @@ -117,6 +117,41 @@ static void prepare_tile_info_buffer(struct hantro_ctx
> *ctx) vpu_debug(1, "%s: no chroma!\n", __func__);
>  }
> 
> +static int compute_header_skip_lenght(struct hantro_ctx *ctx)

lenght -> length

Best regards,
Jernej

> +{
> +	const struct hantro_hevc_dec_ctrls *ctrls = &ctx->hevc_dec.ctrls;
> +	const struct v4l2_ctrl_hevc_decode_params *decode_params =
> ctrls->decode_params; +	const struct v4l2_ctrl_hevc_sps *sps = ctrls->sps;
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
> +	if (!(decode_params->flags & V4L2_HEVC_DECODE_PARAM_FLAG_IDR_PIC)) 
{
> +		/* size of pic_order_cnt_lsb */
> +		skip += sps->log2_max_pic_order_cnt_lsb_minus4 + 4;
> +
> +		/* size of short_term_ref_pic_set_sps_flag */
> +		skip++;
> +
> +		if (decode_params->short_term_ref_pic_set_size)
> +			/* size of st_ref_pic_set( 
num_short_term_ref_pic_sets ) */
> +			skip += decode_params-
>short_term_ref_pic_set_size;
> +		else if (sps->num_short_term_ref_pic_sets > 1)
> +			skip += fls(sps->num_short_term_ref_pic_sets 
- 1);
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
> -	hantro_reg_write(vpu, &g2_hdr_skip_length, ctrls-
>hevc_hdr_skip_length);
> +	hantro_reg_write(vpu, &g2_hdr_skip_length,
> compute_header_skip_lenght(ctx));
> 
>  	min_log2_cb_size = sps->log2_min_luma_coding_block_size_minus3 + 
3;
>  	max_log2_ctb_size = min_log2_cb_size +
> sps->log2_diff_max_min_luma_coding_block_size; diff --git
> a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h index
> 42d16e8a1050..9239e8b649e0 100644
> --- a/include/media/hevc-ctrls.h
> +++ b/include/media/hevc-ctrls.h
> @@ -465,17 +465,4 @@ struct v4l2_ctrl_hevc_scaling_matrix {
>  	__u8	scaling_list_dc_coef_32x32[2];
>  };
> 
> -/*  MPEG-class control IDs specific to the Hantro driver as defined by V4L2
> */ -#define V4L2_CID_CODEC_HANTRO_BASE				
(V4L2_CTRL_CLASS_CODEC | 0x1200)
> -/*
> - * V4L2_CID_HANTRO_HEVC_SLICE_HEADER_SKIP -
> - * the number of data (in bits) to skip in the
> - * slice segment header.
> - * If non-IDR, the bits to be skipped go from syntax element
> "pic_output_flag" - * to before syntax element
> "slice_temporal_mvp_enabled_flag".
> - * If IDR, the skipped bits are just "pic_output_flag"
> - * (separate_colour_plane_flag is not supported).
> - */
> -#define V4L2_CID_HANTRO_HEVC_SLICE_HEADER_SKIP	
(V4L2_CID_CODEC_HANTRO_BASE
> + 0) -
>  #endif




