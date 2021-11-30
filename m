Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254AE46342D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 13:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241544AbhK3M2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 07:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241511AbhK3M2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 07:28:08 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397F0C061748
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 04:24:49 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id r15so40955759uao.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 04:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lWG+lQ/6Yyq7YVu+fKpvYuX6lXAAwVWMMq+4sXlQZDo=;
        b=dgYsyVrTZSW3QgPN0fB1QAzXx7AqXNRb+PMGyROWIBG+couZ0XM3uRyKuVLjqozJ+R
         19Z3AHKn8WMrAc8SWWbc415ZRc4Xfo0QkLlEbb7an/1IbezcIFyGZZnw50CiOfRHOrjq
         2gZQPSvIYcrXTYJtA4KTwBCJ62R6/otZD19SRxTFdMWfpQWq2kzlyI/ZjV+0sPsVgaes
         tbzMnGgGUTWoCjUurx+wXGmO/GEBTHe/qY/YuHTOfcVUnrb93fC+oeEoxT+92aNjSdfz
         R+myw3KhthPb7804AP8d0PRL3bqsNSwL0dgx8wh09D9HvEla0sPmi0dAK3kaDp9IykQW
         bxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lWG+lQ/6Yyq7YVu+fKpvYuX6lXAAwVWMMq+4sXlQZDo=;
        b=4xy5W+lyYaXgSxyLxfQ/yMNU8eW9URIMC/Vl9VJc3XMqgnj77ORKqc09N/vXIAhim8
         N+iZ6ZV2P29U12ynTNK97EA/n4lrJUzUm6ZcnrSaGX5fUzj5wYGZ+Il3Oz83GGDi4rDL
         UKWkrRD0XgA5uGwDp/alex8SXCVylGB8SL1vB/4n2zovZJ43CdtxrozewFFZflMdSCHI
         wYkyTzkm5f57r0/0VgZ3jHmC9/khG1Bpc39ca3xQJVTgeljjEvsmbWLuohe9lrT23rbY
         5YOyX1fXLEL3DDIZcGzcFuC521GLon418abUYA3v1lK295KVq0SLlKh94lyorG520J05
         S6rg==
X-Gm-Message-State: AOAM531alEQz0xKZvwbXbTvAbmG1s0g8bxdtvbVh1kdHeOh77YTLFf8O
        YOYnFCGmvMrdH1vhirnK9H5H8Q==
X-Google-Smtp-Source: ABdhPJy5WbQIWizmyO+U8N1STRX2VYDr9MI16pKd0PLQHWZZB3l5X6BUWLMIBSUlAA7ncA00FoMb8Q==
X-Received: by 2002:a05:6102:b0c:: with SMTP id b12mr40148494vst.27.1638275088172;
        Tue, 30 Nov 2021 04:24:48 -0800 (PST)
Received: from eze-laptop (host208.201-253-22.telecom.net.ar. [201.253.22.208])
        by smtp.gmail.com with ESMTPSA id v7sm10324560uaj.13.2021.11.30.04.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 04:24:47 -0800 (PST)
Date:   Tue, 30 Nov 2021 09:24:42 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     linux-media@vger.kernel.org, nicolas.dufresne@collabora.com,
        mchehab@kernel.org, robh+dt@kernel.org, mripard@kernel.org,
        wens@csie.org, p.zabel@pengutronix.de, andrzej.p@collabora.com,
        gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 8/9] media: hantro: Add support for Allwinner H6
Message-ID: <YaYYCpJWabFy9Lfq@eze-laptop>
References: <20211129182633.480021-1-jernej.skrabec@gmail.com>
 <20211129182633.480021-9-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129182633.480021-9-jernej.skrabec@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 07:26:32PM +0100, Jernej Skrabec wrote:
> Allwinner H6 has a Hantro G2 core used for VP9 decoding. It's not clear
> at this time if HEVC is also supported or not.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Thanks!

> ---
>  drivers/staging/media/hantro/Kconfig        | 10 ++-
>  drivers/staging/media/hantro/Makefile       |  3 +
>  drivers/staging/media/hantro/hantro_drv.c   |  3 +
>  drivers/staging/media/hantro/hantro_hw.h    |  1 +
>  drivers/staging/media/hantro/sunxi_vpu_hw.c | 86 +++++++++++++++++++++
>  5 files changed, 102 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/staging/media/hantro/sunxi_vpu_hw.c
> 
> diff --git a/drivers/staging/media/hantro/Kconfig b/drivers/staging/media/hantro/Kconfig
> index 00a57d88c92e..3c5d833322c8 100644
> --- a/drivers/staging/media/hantro/Kconfig
> +++ b/drivers/staging/media/hantro/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  config VIDEO_HANTRO
>  	tristate "Hantro VPU driver"
> -	depends on ARCH_MXC || ARCH_ROCKCHIP || ARCH_AT91 || COMPILE_TEST
> +	depends on ARCH_MXC || ARCH_ROCKCHIP || ARCH_AT91 || ARCH_SUNXI || COMPILE_TEST
>  	depends on VIDEO_DEV && VIDEO_V4L2
>  	select MEDIA_CONTROLLER
>  	select MEDIA_CONTROLLER_REQUEST_API
> @@ -40,3 +40,11 @@ config VIDEO_HANTRO_ROCKCHIP
>  	default y
>  	help
>  	  Enable support for RK3288, RK3328, and RK3399 SoCs.
> +
> +config VIDEO_HANTRO_SUNXI
> +	bool "Hantro VPU Allwinner support"
> +	depends on VIDEO_HANTRO
> +	depends on ARCH_SUNXI || COMPILE_TEST
> +	default y
> +	help
> +	  Enable support for H6 SoC.
> diff --git a/drivers/staging/media/hantro/Makefile b/drivers/staging/media/hantro/Makefile
> index 28af0a1ee4bf..ebd5ede7bef7 100644
> --- a/drivers/staging/media/hantro/Makefile
> +++ b/drivers/staging/media/hantro/Makefile
> @@ -33,3 +33,6 @@ hantro-vpu-$(CONFIG_VIDEO_HANTRO_SAMA5D4) += \
>  
>  hantro-vpu-$(CONFIG_VIDEO_HANTRO_ROCKCHIP) += \
>  		rockchip_vpu_hw.o
> +
> +hantro-vpu-$(CONFIG_VIDEO_HANTRO_SUNXI) += \
> +		sunxi_vpu_hw.o
> diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
> index 33bf78be145b..6a51f39dde56 100644
> --- a/drivers/staging/media/hantro/hantro_drv.c
> +++ b/drivers/staging/media/hantro/hantro_drv.c
> @@ -620,6 +620,9 @@ static const struct of_device_id of_hantro_match[] = {
>  #endif
>  #ifdef CONFIG_VIDEO_HANTRO_SAMA5D4
>  	{ .compatible = "microchip,sama5d4-vdec", .data = &sama5d4_vdec_variant, },
> +#endif
> +#ifdef CONFIG_VIDEO_HANTRO_SUNXI
> +	{ .compatible = "allwinner,sun50i-h6-vpu-g2", .data = &sunxi_vpu_variant, },
>  #endif
>  	{ /* sentinel */ }
>  };
> diff --git a/drivers/staging/media/hantro/hantro_hw.h b/drivers/staging/media/hantro/hantro_hw.h
> index c33b1f5df37b..c92a6ec4b187 100644
> --- a/drivers/staging/media/hantro/hantro_hw.h
> +++ b/drivers/staging/media/hantro/hantro_hw.h
> @@ -308,6 +308,7 @@ extern const struct hantro_variant rk3288_vpu_variant;
>  extern const struct hantro_variant rk3328_vpu_variant;
>  extern const struct hantro_variant rk3399_vpu_variant;
>  extern const struct hantro_variant sama5d4_vdec_variant;
> +extern const struct hantro_variant sunxi_vpu_variant;
>  
>  extern const struct hantro_postproc_ops hantro_g1_postproc_ops;
>  extern const struct hantro_postproc_ops hantro_g2_postproc_ops;
> diff --git a/drivers/staging/media/hantro/sunxi_vpu_hw.c b/drivers/staging/media/hantro/sunxi_vpu_hw.c
> new file mode 100644
> index 000000000000..90633406c4eb
> --- /dev/null
> +++ b/drivers/staging/media/hantro/sunxi_vpu_hw.c
> @@ -0,0 +1,86 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Allwinner Hantro G2 VPU codec driver
> + *
> + * Copyright (C) 2021 Jernej Skrabec <jernej.skrabec@gmail.com>
> + */
> +
> +#include <linux/clk.h>
> +
> +#include "hantro.h"
> +
> +static const struct hantro_fmt sunxi_vpu_postproc_fmts[] = {
> +	{
> +		.fourcc = V4L2_PIX_FMT_NV12,
> +		.codec_mode = HANTRO_MODE_NONE,
> +		.postprocessed = true,
> +	},
> +};
> +
> +static const struct hantro_fmt sunxi_vpu_dec_fmts[] = {
> +	{
> +		.fourcc = V4L2_PIX_FMT_NV12_4L4,
> +		.codec_mode = HANTRO_MODE_NONE,
> +	},
> +	{
> +		.fourcc = V4L2_PIX_FMT_VP9_FRAME,
> +		.codec_mode = HANTRO_MODE_VP9_DEC,
> +		.max_depth = 2,
> +		.frmsize = {
> +			.min_width = 48,
> +			.max_width = 3840,
> +			.step_width = MB_DIM,
> +			.min_height = 48,
> +			.max_height = 2160,
> +			.step_height = MB_DIM,
> +		},
> +	},
> +};
> +
> +static int sunxi_vpu_hw_init(struct hantro_dev *vpu)
> +{
> +	clk_set_rate(vpu->clocks[0].clk, 300000000);
> +
> +	return 0;
> +}
> +
> +static void sunxi_vpu_reset(struct hantro_ctx *ctx)
> +{
> +	struct hantro_dev *vpu = ctx->dev;
> +
> +	reset_control_reset(vpu->resets);
> +}
> +
> +static const struct hantro_codec_ops sunxi_vpu_codec_ops[] = {
> +	[HANTRO_MODE_VP9_DEC] = {
> +		.run = hantro_g2_vp9_dec_run,
> +		.done = hantro_g2_vp9_dec_done,
> +		.reset = sunxi_vpu_reset,
> +		.init = hantro_vp9_dec_init,
> +		.exit = hantro_vp9_dec_exit,
> +	},
> +};
> +
> +static const struct hantro_irq sunxi_irqs[] = {
> +	{ NULL, hantro_g2_irq },
> +};
> +
> +static const char * const sunxi_clk_names[] = { "mod", "bus" };
> +
> +const struct hantro_variant sunxi_vpu_variant = {
> +	.dec_fmts = sunxi_vpu_dec_fmts,
> +	.num_dec_fmts = ARRAY_SIZE(sunxi_vpu_dec_fmts),
> +	.postproc_fmts = sunxi_vpu_postproc_fmts,
> +	.num_postproc_fmts = ARRAY_SIZE(sunxi_vpu_postproc_fmts),
> +	.postproc_ops = &hantro_g2_postproc_ops,
> +	.codec = HANTRO_VP9_DECODER,
> +	.codec_ops = sunxi_vpu_codec_ops,
> +	.init = sunxi_vpu_hw_init,
> +	.irqs = sunxi_irqs,
> +	.num_irqs = ARRAY_SIZE(sunxi_irqs),
> +	.clk_names = sunxi_clk_names,
> +	.num_clocks = ARRAY_SIZE(sunxi_clk_names),
> +	.double_buffer = 1,
> +	.legacy_regs = 1,
> +	.late_postproc = 1,
> +};
> -- 
> 2.34.1
> 
