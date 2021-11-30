Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4BD463416
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 13:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241492AbhK3MXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 07:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbhK3MX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 07:23:28 -0500
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D64EC061748
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 04:20:09 -0800 (PST)
Received: by mail-vk1-xa30.google.com with SMTP id e27so13449815vkd.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 04:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VVEC9MyOR43khg1i5T22QR4aHRP9iObZnCLCzY2Cxbo=;
        b=n7rjdnb4XjbplJU1heJ9DsQqw/9v+Bl1JBdtfkTzF3oDmsQ27HI/vyc2NQRy4fuiEb
         rKf4Hge+6zsOxTPw0OkMp7tpBk3rOEqu7e5H2rRBp6OXCCkXOG9w7BxC3PvALQE79RkQ
         jgqpCvO3dhBxm+kvVr9XSjUoTdNL0q2bGCTOgivz/mjehawZflh8GwnSHv9h3YuPXaKO
         anmNsOsadNEm4HP2X69ZqxD2VisZTkQX67RHH3gaK8QVGbEn7uMdIWopa8VmvLE5HoAv
         2qsMqiX2V2lLvxtuzubAQtYA4QQN2yYF1GGtWQ8hAdGZ62ask7X/ZNpxkSWsldExO92h
         9krg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VVEC9MyOR43khg1i5T22QR4aHRP9iObZnCLCzY2Cxbo=;
        b=o0cdfcZTuAsVRYf/aF/dNYz8XFZrDjl092f1pt/hPUNcgNGsjxDb+NC9FxlWsU+AXJ
         cwrhvSi15E3k65nPQ5b+oC4pBAkBtbJLQLc6QINjsGG4vlbtgdvRcmcTmkCFLaZRMEXT
         lSc1kUumVRcRkYTWH/Yx/HA4R3PTjwxSdU8Mnzrs5pFT4RPZoEJIiOa05Jx9CydOfBwx
         5aA5vM3WDZ7e3Gu7FwOu3T+60evb3pE3oEmWcUaSr293jULUHhpX22KLeR4mcAOUh1Td
         Bwjmx0IfArhQZvFcHVibSfyYXPXwtAQ+4saLuQT6h6M7AzlK61X2iRAIMSoZpbuQ2B4w
         AQJw==
X-Gm-Message-State: AOAM531yzNawiYliK+jV4P9PVvfHbgHVCiI11U6Z38lbO6UuBYDbooyF
        DoMgsa1Fz/PVJSuZ5Dstck72cw==
X-Google-Smtp-Source: ABdhPJx4pjcG+r16tI53s5Kfp7uWbm31oMJatWgIFBrtQICorJtMeQMcOZOMxsNpcGFmaeirrwxXLg==
X-Received: by 2002:a05:6122:1788:: with SMTP id o8mr43886681vkf.8.1638274808616;
        Tue, 30 Nov 2021 04:20:08 -0800 (PST)
Received: from eze-laptop (host208.201-253-22.telecom.net.ar. [201.253.22.208])
        by smtp.gmail.com with ESMTPSA id h10sm10097739vsl.34.2021.11.30.04.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 04:20:07 -0800 (PST)
Date:   Tue, 30 Nov 2021 09:20:03 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     linux-media@vger.kernel.org, nicolas.dufresne@collabora.com,
        mchehab@kernel.org, robh+dt@kernel.org, mripard@kernel.org,
        wens@csie.org, p.zabel@pengutronix.de, andrzej.p@collabora.com,
        gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 5/9] media: hantro: move postproc enablement for old
 cores
Message-ID: <YaYW8yLNrXvWkopx@eze-laptop>
References: <20211129182633.480021-1-jernej.skrabec@gmail.com>
 <20211129182633.480021-6-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129182633.480021-6-jernej.skrabec@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 07:26:29PM +0100, Jernej Skrabec wrote:
> Older G2 cores, like that in Allwinner H6, seem to have issue with
> latching postproc register values if this is first thing done in job.
> Moving that to the end solves the issue.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Thanks!

> ---
>  drivers/staging/media/hantro/hantro.h     | 2 ++
>  drivers/staging/media/hantro/hantro_drv.c | 9 ++++++++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/hantro/hantro.h b/drivers/staging/media/hantro/hantro.h
> index 83ed25d9657b..06d0f3597694 100644
> --- a/drivers/staging/media/hantro/hantro.h
> +++ b/drivers/staging/media/hantro/hantro.h
> @@ -75,6 +75,7 @@ struct hantro_irq {
>   * @num_regs:			number of register range names in the array
>   * @double_buffer:		core needs double buffering
>   * @legacy_regs:		core uses legacy register set
> + * @late_postproc:		postproc must be set up at the end of the job
>   */
>  struct hantro_variant {
>  	unsigned int enc_offset;
> @@ -98,6 +99,7 @@ struct hantro_variant {
>  	int num_regs;
>  	unsigned int double_buffer : 1;
>  	unsigned int legacy_regs : 1;
> +	unsigned int late_postproc : 1;
>  };
>  
>  /**
> diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
> index 770f4ce71d29..33bf78be145b 100644
> --- a/drivers/staging/media/hantro/hantro_drv.c
> +++ b/drivers/staging/media/hantro/hantro_drv.c
> @@ -130,7 +130,7 @@ void hantro_start_prepare_run(struct hantro_ctx *ctx)
>  	v4l2_ctrl_request_setup(src_buf->vb2_buf.req_obj.req,
>  				&ctx->ctrl_handler);
>  
> -	if (!ctx->is_encoder) {
> +	if (!ctx->is_encoder && !ctx->dev->variant->late_postproc) {
>  		if (hantro_needs_postproc(ctx, ctx->vpu_dst_fmt))
>  			hantro_postproc_enable(ctx);
>  		else
> @@ -142,6 +142,13 @@ void hantro_end_prepare_run(struct hantro_ctx *ctx)
>  {
>  	struct vb2_v4l2_buffer *src_buf;
>  
> +	if (!ctx->is_encoder && ctx->dev->variant->late_postproc) {
> +		if (hantro_needs_postproc(ctx, ctx->vpu_dst_fmt))
> +			hantro_postproc_enable(ctx);
> +		else
> +			hantro_postproc_disable(ctx);
> +	}
> +
>  	src_buf = hantro_get_src_buf(ctx);
>  	v4l2_ctrl_request_complete(src_buf->vb2_buf.req_obj.req,
>  				   &ctx->ctrl_handler);
> -- 
> 2.34.1
> 
