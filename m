Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E8A4F0122
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 13:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354679AbiDBLeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 07:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239238AbiDBLeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 07:34:18 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED3EE729A
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 04:32:26 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-df22f50e0cso5434773fac.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 04:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=96WWzGX1QlTdIs8fpY2JF8+JRT0XNwmjxbPhRBdEIc0=;
        b=ERAtDfAKGKIIovbquS2nNopqUl72XF1JBlIGtZseWZO1QPTuhHU10O6lEUF6QuUPQ6
         P2oPqeJL+8t7kkSSOLwpU2bfUUSCvz1GqEGICvc6+fNcs0kqQq0vfwk+iQYjdeYVmPaM
         Vy241epC7zQRTY/X6r8K2OsaT2kcc0EGv/SSQiDWOvFRd//22wWg9ASwNb9LmZntG6nH
         zTSW1BWhoB034is5QS8FmffsXOi7SrvfoNpteJnETXH4cx6qhe/g6PzjdrAJSO7hYELM
         ts8QQhwvwFXHy0dsemNqLCwguQO0ksg7vAMt+pfk98Lo3DwPKdehIwS9EKZqLUBOgdKj
         Bj4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=96WWzGX1QlTdIs8fpY2JF8+JRT0XNwmjxbPhRBdEIc0=;
        b=gpOEMZoFcydDebLYN0ULfp5CKVcx+IwY/AU84NIiGtRrxG/PPO9tNWg/7CVpVXgOZY
         CTQKMRTl3p4CvkbaWSh7RmjFfK5uPz9ERzcBl+9oh0vEmEPna1mG2DvAudMhqIsIxCY1
         ElD1vVQWXzYJiCRR3N5m+u5HsnTwhCtezC0ZW7j4FYCxBQW20aBaCbsrtcXRiLW0qUJ2
         HXxCb/wvVKHdV5Y9Rp4K1bugI+tA5Wvs27z+UVX2zqRTK9KAHinldlflcVyIXvUET1Gj
         MJ9ENqsg/Tj3P4S9+vyD54rBaiACtZ2tEs0jKRfDppg4h7pVDQWIWnY+x2j+H4ofxliO
         fAnA==
X-Gm-Message-State: AOAM5337gPYza20z1DGX1Dr5UF0GAeidkzMCJXfViDotzL7t7h5sm49P
        DnjlwUo8f6ivgGOtqjl89SmG2A==
X-Google-Smtp-Source: ABdhPJwDqf1/vu0mXQ/9kj4+h/eGfG7Eay8+8AdlhYL1ehJJGnfvQl/Iq9fBv1/MaFLTnYrAIGY3tg==
X-Received: by 2002:a05:6870:d0c4:b0:dd:c7f6:2d62 with SMTP id k4-20020a056870d0c400b000ddc7f62d62mr7021239oaa.99.1648899145085;
        Sat, 02 Apr 2022 04:32:25 -0700 (PDT)
Received: from eze-laptop ([2803:9800:98c2:8470:9f4:8e2a:88e5:ec01])
        by smtp.gmail.com with ESMTPSA id f79-20020a4a5852000000b003291b52dc7csm1584506oob.15.2022.04.02.04.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 04:32:24 -0700 (PDT)
Date:   Sat, 2 Apr 2022 08:32:19 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 15/23] media: rkvdec: h264: Validate and use pic width
 and height in mbs
Message-ID: <Ykg0Qw24PuGCnbLT@eze-laptop>
References: <20220331193726.289559-1-nicolas.dufresne@collabora.com>
 <20220331193726.289559-16-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331193726.289559-16-nicolas.dufresne@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

On Thu, Mar 31, 2022 at 03:37:17PM -0400, Nicolas Dufresne wrote:
> From: Jonas Karlman <jonas@kwiboo.se>
> 
> The width and height in macroblocks is currently configured based on OUTPUT
> buffer resolution, this works for frame pictures but can cause issues for
> field pictures.
> 
> When frame_mbs_only_flag is 0 the height in mbs should be height of
> the field instead of height of frame.
> 
> Validate pic_width_in_mbs_minus1 and pic_height_in_map_units_minus1
> against OUTPUT buffer resolution and use these values to configure HW.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>
> ---
>  drivers/staging/media/rkvdec/rkvdec-h264.c |  4 ++--
>  drivers/staging/media/rkvdec/rkvdec.c      | 10 ++++++++++
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/staging/media/rkvdec/rkvdec-h264.c
> index 8d44a884a52e..a42cf19bcc6d 100644
> --- a/drivers/staging/media/rkvdec/rkvdec-h264.c
> +++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
> @@ -672,8 +672,8 @@ static void assemble_hw_pps(struct rkvdec_ctx *ctx,
>  		  LOG2_MAX_PIC_ORDER_CNT_LSB_MINUS4);
>  	WRITE_PPS(!!(sps->flags & V4L2_H264_SPS_FLAG_DELTA_PIC_ORDER_ALWAYS_ZERO),
>  		  DELTA_PIC_ORDER_ALWAYS_ZERO_FLAG);
> -	WRITE_PPS(DIV_ROUND_UP(ctx->coded_fmt.fmt.pix_mp.width, 16), PIC_WIDTH_IN_MBS);
> -	WRITE_PPS(DIV_ROUND_UP(ctx->coded_fmt.fmt.pix_mp.height, 16), PIC_HEIGHT_IN_MBS);

Please add a comment so we don't forget why we use the bitstream
fields here.

> +	WRITE_PPS(sps->pic_width_in_mbs_minus1 + 1, PIC_WIDTH_IN_MBS);
> +	WRITE_PPS(sps->pic_height_in_map_units_minus1 + 1, PIC_HEIGHT_IN_MBS);
>  	WRITE_PPS(!!(sps->flags & V4L2_H264_SPS_FLAG_FRAME_MBS_ONLY),
>  		  FRAME_MBS_ONLY_FLAG);
>  	WRITE_PPS(!!(sps->flags & V4L2_H264_SPS_FLAG_MB_ADAPTIVE_FRAME_FIELD),
> diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
> index 2df8cf4883e2..1b805710e195 100644
> --- a/drivers/staging/media/rkvdec/rkvdec.c
> +++ b/drivers/staging/media/rkvdec/rkvdec.c
> @@ -29,8 +29,11 @@
>  
>  static int rkvdec_try_ctrl(struct v4l2_ctrl *ctrl)
>  {
> +	struct rkvdec_ctx *ctx = container_of(ctrl->handler, struct rkvdec_ctx, ctrl_hdl);
> +
>  	if (ctrl->id == V4L2_CID_STATELESS_H264_SPS) {
>  		const struct v4l2_ctrl_h264_sps *sps = ctrl->p_new.p_h264_sps;
> +		unsigned int width, height;
>  		/*
>  		 * TODO: The hardware supports 10-bit and 4:2:2 profiles,
>  		 * but it's currently broken in the driver.
> @@ -45,6 +48,13 @@ static int rkvdec_try_ctrl(struct v4l2_ctrl *ctrl)
>  		if (sps->bit_depth_luma_minus8 != 0)
>  			/* Only 8-bit is supported */
>  			return -EINVAL;
> +
> +		width = (sps->pic_width_in_mbs_minus1 + 1) * 16;
> +		height = (sps->pic_height_in_map_units_minus1 + 1) * 16;
> +

Let's please add a comment here, clarifying it's legal to check
the coded format (OUTPUT queue format) at .try_ctrl time,
because the stateless decoder specification [1] mandates
S_FMT on the OUTPUT queue, before passing the SPS/PPS controls.

[1] https://www.kernel.org/doc/html/latest/userspace-api/media/v4l/dev-stateless-decoder.html

> +		if (width > ctx->coded_fmt.fmt.pix_mp.width ||
> +		    height > ctx->coded_fmt.fmt.pix_mp.height)

Can you add a debug message or error message?
These silent errors tend to get super hard to track.

With these changes:

Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Thanks,
Ezequiel
