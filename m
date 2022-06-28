Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F33455F025
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 23:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiF1VG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 17:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiF1VGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 17:06:22 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA26C3A707
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 14:06:19 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1048b8a38bbso18673419fac.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 14:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=STiH3iHegpDpulyFQR+v1Cyk/1DLN8ULnvsLF3GIIV0=;
        b=Y9HzhG4fGXuQ58JNTmAFjTjRBHNGrWPz+HrW0HyptCDkEDLxl24x+Fxg8apWji3mJQ
         oaHOEEJJMUOnI7cD9j4TldOud0k8owYfERJ6tRP4ajtj6mFEQ1nvagBSs67J2hw4dyGv
         iuKP5ochqtmRHEtnERn9Nwy2h4aWw9bWAFY6iBMTQ9UCPNhBWZVYpUSAtQRZaEgCMQ8d
         l6FhdQyib5yidn20uLINQ4wzcgrVXauqZ/ApbSi2FT8AaRwscP4P6gmMuRIV+ErEo/vG
         axoPhyCHSjyotQ5RNQIh2yMPy6XLbBueSLIvvFeqBZXo+XPrAtIti8vexxRRMx5xFiJT
         1/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=STiH3iHegpDpulyFQR+v1Cyk/1DLN8ULnvsLF3GIIV0=;
        b=k4BAk2+pXYAgBQyaFM8Ur5L7J9YjTVncKzK3nd2UJhnn863280R1qmmTyOvtbYVM6G
         zFjF1WNZ7QjVgX0+iCDpKrVzI3ixaugdIPwKsBv3aVJAzYK9dz6RoOa4Bj3/KUTbXDTT
         HrKrcNDMI1hgEJelXBUhzn9Q/2Rg1A+vpI5zrdumjn4pfAi5HOuR5UAmmFdr1l10OBRI
         PkqYZiwhXS6Yo2QyP0L4ISGPJZ0Oqd0+IHHzX6nTKCn1qwT7Ybg8pNuIfIWZKB0AgU7v
         cdV9gKdtW5vavKgjjYQAFDcAEteBaIhsU+gwnJtJf3CDfsgtPcylXH8makeYkm5nJOqQ
         nJyQ==
X-Gm-Message-State: AJIora9ezyISrXWkhoorsaoJyNeYkc7LK/7SARuc05jVtc7oQZPOLONo
        AvOnZjrlAJfEOiyIARJ+73AaBQ==
X-Google-Smtp-Source: AGRyM1v2ljwfJu4Ftr09DXtpIBJE4LLFvqlHANGlLO3yn9V0hbctPbQFQ7bioOM1VtDqk+iXViSjkA==
X-Received: by 2002:a05:6870:2189:b0:101:cdf6:e0bd with SMTP id l9-20020a056870218900b00101cdf6e0bdmr1005126oae.194.1656450378975;
        Tue, 28 Jun 2022 14:06:18 -0700 (PDT)
Received: from eze-laptop ([190.190.187.68])
        by smtp.gmail.com with ESMTPSA id bf9-20020a056808190900b0032f0e611cc0sm7823129oib.19.2022.06.28.14.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 14:06:18 -0700 (PDT)
Date:   Tue, 28 Jun 2022 18:06:12 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     p.zabel@pengutronix.de, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, benjamin.gaignard@collabora.com,
        nicolas.dufresne@collabora.com, gregkh@linuxfoundation.org,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 6/7] media: hantro: Store VP9 bit depth in context
Message-ID: <YrttRJrgmDji5tVc@eze-laptop>
References: <20220616202513.351039-1-jernej.skrabec@gmail.com>
 <20220616202513.351039-7-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616202513.351039-7-jernej.skrabec@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jernej,

On Thu, Jun 16, 2022 at 10:25:12PM +0200, Jernej Skrabec wrote:
> Now that we have proper infrastructure for postprocessing 10-bit
> formats, store VP9 bit depth in context.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> ---
>  drivers/staging/media/hantro/hantro_drv.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
> index 01d33dcb0467..afddf7ac0731 100644
> --- a/drivers/staging/media/hantro/hantro_drv.c
> +++ b/drivers/staging/media/hantro/hantro_drv.c
> @@ -324,6 +324,24 @@ static int hantro_hevc_s_ctrl(struct v4l2_ctrl *ctrl)
>  	return 0;
>  }
>  
> +static int hantro_vp9_s_ctrl(struct v4l2_ctrl *ctrl)
> +{
> +	struct hantro_ctx *ctx;
> +
> +	ctx = container_of(ctrl->handler,
> +			   struct hantro_ctx, ctrl_handler);
> +
> +	switch (ctrl->id) {
> +	case V4L2_CID_STATELESS_VP9_FRAME:
> +		ctx->bit_depth = ctrl->p_new.p_vp9_frame->bit_depth;

Since this affects the possible formats, shouldn't it reset
the decoded format?

In other words, it would mean calling hantro_reset_raw_fmt().

Hopefully, that would be OK and not cause any weird issues?

Nicolas, any feedback?

Thanks,
Ezequiel

> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct v4l2_ctrl_ops hantro_ctrl_ops = {
>  	.try_ctrl = hantro_try_ctrl,
>  };
> @@ -336,6 +354,10 @@ static const struct v4l2_ctrl_ops hantro_hevc_ctrl_ops = {
>  	.s_ctrl = hantro_hevc_s_ctrl,
>  };
>  
> +static const struct v4l2_ctrl_ops hantro_vp9_ctrl_ops = {
> +	.s_ctrl = hantro_vp9_s_ctrl,
> +};
> +
>  #define HANTRO_JPEG_ACTIVE_MARKERS	(V4L2_JPEG_ACTIVE_MARKER_APP0 | \
>  					 V4L2_JPEG_ACTIVE_MARKER_COM | \
>  					 V4L2_JPEG_ACTIVE_MARKER_DQT | \
> @@ -503,6 +525,7 @@ static const struct hantro_ctrl controls[] = {
>  		.codec = HANTRO_VP9_DECODER,
>  		.cfg = {
>  			.id = V4L2_CID_STATELESS_VP9_FRAME,
> +			.ops = &hantro_vp9_ctrl_ops,
>  		},
>  	}, {
>  		.codec = HANTRO_VP9_DECODER,
> -- 
> 2.36.1
> 
