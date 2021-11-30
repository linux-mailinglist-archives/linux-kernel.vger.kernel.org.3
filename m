Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1BA4631D3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 12:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237149AbhK3LME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 06:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235837AbhK3LMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 06:12:03 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D920C061574;
        Tue, 30 Nov 2021 03:08:44 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id 8DB091F44CF3
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638270523; bh=HrLhCveQinpxrwY4Wl9JvG2Ea7FMibGJNgBheRVK2TM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fIbsxb+0mtjzF6hOWuEWb96zQED+MkaVrIWUaj6dSeFACsrqb4n3r67mokQJ12fK2
         d2e33C8KdAZ9VthPQK+CBJCA7gdHziRF8R1SL4/AbEcE/bw1I+1/RkYMzbThfyGbVS
         qewZmq/coeccst68SsjHt0vBWEA1XMG4DlZcEsBJMZIeg25RCgWn6cbLjWeEhkBafV
         eYtIqjTnsevJ24U0Fcs7nrkEvWnoPeO41QCPJ17ZZd0YdlxLK6eGH73NnsZav+pNOx
         zRoxRiVFXayXqYpgFUSocoXrja3ELNpk9/gBAeYMK0XTYnC2bIxNAnh0moIN9WWbrg
         YbH2Em8TjmHOQ==
Subject: Re: [PATCH v2 8/9] media: hantro: Add support for Allwinner H6
To:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-media@vger.kernel.org
Cc:     ezequiel@vanguardiasur.com.ar, nicolas.dufresne@collabora.com,
        mchehab@kernel.org, robh+dt@kernel.org, mripard@kernel.org,
        wens@csie.org, p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
References: <20211129182633.480021-1-jernej.skrabec@gmail.com>
 <20211129182633.480021-9-jernej.skrabec@gmail.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Message-ID: <5c0d0b69-a077-0d8a-3dc5-3862e26e5b80@collabora.com>
Date:   Tue, 30 Nov 2021 12:08:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211129182633.480021-9-jernej.skrabec@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jernej,

W dniu 29.11.2021 o 19:26, Jernej Skrabec pisze:
> Allwinner H6 has a Hantro G2 core used for VP9 decoding. It's not clear
> at this time if HEVC is also supported or not.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Acked-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>

> ---
>   drivers/staging/media/hantro/Kconfig        | 10 ++-
>   drivers/staging/media/hantro/Makefile       |  3 +
>   drivers/staging/media/hantro/hantro_drv.c   |  3 +
>   drivers/staging/media/hantro/hantro_hw.h    |  1 +
>   drivers/staging/media/hantro/sunxi_vpu_hw.c | 86 +++++++++++++++++++++
>   5 files changed, 102 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/staging/media/hantro/sunxi_vpu_hw.c
> 
> diff --git a/drivers/staging/media/hantro/Kconfig b/drivers/staging/media/hantro/Kconfig
> index 00a57d88c92e..3c5d833322c8 100644
> --- a/drivers/staging/media/hantro/Kconfig
> +++ b/drivers/staging/media/hantro/Kconfig
> @@ -1,7 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0
>   config VIDEO_HANTRO
>   	tristate "Hantro VPU driver"
> -	depends on ARCH_MXC || ARCH_ROCKCHIP || ARCH_AT91 || COMPILE_TEST
> +	depends on ARCH_MXC || ARCH_ROCKCHIP || ARCH_AT91 || ARCH_SUNXI || COMPILE_TEST
>   	depends on VIDEO_DEV && VIDEO_V4L2
>   	select MEDIA_CONTROLLER
>   	select MEDIA_CONTROLLER_REQUEST_API
> @@ -40,3 +40,11 @@ config VIDEO_HANTRO_ROCKCHIP
>   	default y
>   	help
>   	  Enable support for RK3288, RK3328, and RK3399 SoCs.
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
>   hantro-vpu-$(CONFIG_VIDEO_HANTRO_ROCKCHIP) += \
>   		rockchip_vpu_hw.o
> +
> +hantro-vpu-$(CONFIG_VIDEO_HANTRO_SUNXI) += \
> +		sunxi_vpu_hw.o
> diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
> index 33bf78be145b..6a51f39dde56 100644
> --- a/drivers/staging/media/hantro/hantro_drv.c
> +++ b/drivers/staging/media/hantro/hantro_drv.c
> @@ -620,6 +620,9 @@ static const struct of_device_id of_hantro_match[] = {
>   #endif
>   #ifdef CONFIG_VIDEO_HANTRO_SAMA5D4
>   	{ .compatible = "microchip,sama5d4-vdec", .data = &sama5d4_vdec_variant, },
> +#endif
> +#ifdef CONFIG_VIDEO_HANTRO_SUNXI
> +	{ .compatible = "allwinner,sun50i-h6-vpu-g2", .data = &sunxi_vpu_variant, },
>   #endif
>   	{ /* sentinel */ }
>   };
> diff --git a/drivers/staging/media/hantro/hantro_hw.h b/drivers/staging/media/hantro/hantro_hw.h
> index c33b1f5df37b..c92a6ec4b187 100644
> --- a/drivers/staging/media/hantro/hantro_hw.h
> +++ b/drivers/staging/media/hantro/hantro_hw.h
> @@ -308,6 +308,7 @@ extern const struct hantro_variant rk3288_vpu_variant;
>   extern const struct hantro_variant rk3328_vpu_variant;
>   extern const struct hantro_variant rk3399_vpu_variant;
>   extern const struct hantro_variant sama5d4_vdec_variant;
> +extern const struct hantro_variant sunxi_vpu_variant;
>   
>   extern const struct hantro_postproc_ops hantro_g1_postproc_ops;
>   extern const struct hantro_postproc_ops hantro_g2_postproc_ops;
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
> 

