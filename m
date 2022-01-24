Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DADD4987ED
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 19:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245043AbiAXSKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 13:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245133AbiAXSJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 13:09:57 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0F2C06173B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 10:09:56 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id q145-20020a4a3397000000b002e85c7234b1so1369931ooq.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 10:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w8jEaMLPRMyJjaBqD5TxMdjhSUQ8JiEnfyk34bIQgP0=;
        b=MrjpOMe3g8JRIYbcToQd2Qu0I/b5vrX/3XGjf2EZ40WzlqwVFZSR95GOwQ9Gfumk0I
         ArgdPOpGK3Awj4Zw99kwMljilayLReiw+HH3afCWGRMsNfXAK8ZpL3elx0qx3ileBGON
         2ziL9O/d6luadbzWZFnmxRkYJohVyZxiqFsq3BSwSSHsKRhc5jHbszi0RaXvMfwnhL56
         wFIr1QoKW2yzpuzN5DJnrNsTViFEDYj/UQ1W0bw/zSzG1UPIe9m2oVxlgjAlcfbsUSdt
         hntaUGXfZwJKnwcoDtrBOa3ZE9XNGWIpXGYSKCdiTEaBycSmDy/v4s0r8aESzt24uWT4
         TAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w8jEaMLPRMyJjaBqD5TxMdjhSUQ8JiEnfyk34bIQgP0=;
        b=0OvRyWcMlzKzQWb19DaPe72YmWsNoSCpbmnFyRFENk/vwbxM2RB2ZbAbZgN4MNge4X
         xEGd2WEO5s4INhAX+Fj8p8om+wRolfM4icwSYwDBpxoiiq0aZRwpe4lpoKer272SJ5nu
         PzmBNbKu4jg7h9n/FlywYCH2H249IxSFw6OGSo7dFHbosI/oo+GUT1bVNpAaAxXH4gQ/
         wmeciXNIVKjevOL+V6vB5I3sLuxc0NMq1EVYrMsCtFNZ3lknPK3gYCkRS335XNRXL1Lt
         QNvdhZZEsiMl6gE1oFwrqPQwbDx8ach6AJURqqC9DmFufqbAtA/xmMTNd8JSgontQkOF
         eANg==
X-Gm-Message-State: AOAM531Z+XqnRsCGMX21IURzRs+QCGp1wEst0TDZKgymxh+PebU0tuT1
        +ei/IANDmv1dqJSZnRkaB7Ayuw==
X-Google-Smtp-Source: ABdhPJz4x/txLXzb74n94I/1helpFS6e1Nqmg4vkIylbZ56TsLFfUK7qbzKJzg6iX/R8pA5+uMINOA==
X-Received: by 2002:a4a:8c2d:: with SMTP id u42mr11072142ooj.7.1643047795762;
        Mon, 24 Jan 2022 10:09:55 -0800 (PST)
Received: from eze-laptop ([190.194.87.200])
        by smtp.gmail.com with ESMTPSA id z20sm5456490otm.25.2022.01.24.10.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 10:09:54 -0800 (PST)
Date:   Mon, 24 Jan 2022 15:09:48 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        shawnguo@kernel.org, aford@beaconembedded.com,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH V3 05/10] media: hantro: Allow i.MX8MQ G1 and G2 to run
 independently
Message-ID: <Ye7rbLhM7OkjeiTz@eze-laptop>
References: <20220124023125.414794-1-aford173@gmail.com>
 <20220124023125.414794-6-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124023125.414794-6-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On Sun, Jan 23, 2022 at 08:31:19PM -0600, Adam Ford wrote:
> The VPU in the i.MX8MQ is really the combination of Hantro G1 and
> Hantro G2. With the updated vpu-blk-ctrl, the power domains system
> can enable and disable them separately as well as pull them out of
> reset. This simplifies the code and lets them run independently
> while still retaining backwards compatibility with older device
> trees for those using G1.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
> index 6a51f39dde56..a670ddd29c4c 100644
> --- a/drivers/staging/media/hantro/hantro_drv.c
> +++ b/drivers/staging/media/hantro/hantro_drv.c
> @@ -616,6 +616,7 @@ static const struct of_device_id of_hantro_match[] = {
>  #endif
>  #ifdef CONFIG_VIDEO_HANTRO_IMX8M
>  	{ .compatible = "nxp,imx8mq-vpu", .data = &imx8mq_vpu_variant, },

Since you might need to resend the series anyway due to the
issue with arch/arm64/boot/dts/freescale/imx8mq-tqma8mq.dtsi,
could you add a small warning for the deprecated compatible string?

This will be a useful hint for kernel developers and system integrators
about the devicetree changes.

Something along these lines, maybe?

        match = of_match_node(of_hantro_match, pdev->dev.of_node);
        vpu->variant = match->data;

        /*
         * Support for nxp,imx8mq-vpu is kept for backwards compatibility
         * but it's deprecated. Please update your DTS file to use
         * nxp,imx8mq-vpu-g1 or nxp,imx8mq-vpu-g2 instead.
         */
        if (of_device_is_compatible(pdev->dev.of_node, "nxp,imx8mq-vpu"))
                dev_warn(&pdev->dev, "%s compatible is deprecated\n",
                         match->compatible);

In any case, the patch looks good:

Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Thanks,
Ezequiel


> +	{ .compatible = "nxp,imx8mq-vpu-g1", .data = &imx8mq_vpu_g1_variant },
>  	{ .compatible = "nxp,imx8mq-vpu-g2", .data = &imx8mq_vpu_g2_variant },
>  #endif
>  #ifdef CONFIG_VIDEO_HANTRO_SAMA5D4
> diff --git a/drivers/staging/media/hantro/hantro_hw.h b/drivers/staging/media/hantro/hantro_hw.h
> index 4a19ae8940b9..f0bd2ffe290b 100644
> --- a/drivers/staging/media/hantro/hantro_hw.h
> +++ b/drivers/staging/media/hantro/hantro_hw.h
> @@ -299,6 +299,7 @@ enum hantro_enc_fmt {
>  	ROCKCHIP_VPU_ENC_FMT_UYVY422 = 3,
>  };
>  
> +extern const struct hantro_variant imx8mq_vpu_g1_variant;
>  extern const struct hantro_variant imx8mq_vpu_g2_variant;
>  extern const struct hantro_variant imx8mq_vpu_variant;
>  extern const struct hantro_variant px30_vpu_variant;
> diff --git a/drivers/staging/media/hantro/imx8m_vpu_hw.c b/drivers/staging/media/hantro/imx8m_vpu_hw.c
> index f5991b8e553a..849ea7122d47 100644
> --- a/drivers/staging/media/hantro/imx8m_vpu_hw.c
> +++ b/drivers/staging/media/hantro/imx8m_vpu_hw.c
> @@ -205,13 +205,6 @@ static void imx8m_vpu_g1_reset(struct hantro_ctx *ctx)
>  	imx8m_soft_reset(vpu, RESET_G1);
>  }
>  
> -static void imx8m_vpu_g2_reset(struct hantro_ctx *ctx)
> -{
> -	struct hantro_dev *vpu = ctx->dev;
> -
> -	imx8m_soft_reset(vpu, RESET_G2);
> -}
> -
>  /*
>   * Supported codec ops.
>   */
> @@ -237,17 +230,33 @@ static const struct hantro_codec_ops imx8mq_vpu_codec_ops[] = {
>  	},
>  };
>  
> +static const struct hantro_codec_ops imx8mq_vpu_g1_codec_ops[] = {
> +	[HANTRO_MODE_MPEG2_DEC] = {
> +		.run = hantro_g1_mpeg2_dec_run,
> +		.init = hantro_mpeg2_dec_init,
> +		.exit = hantro_mpeg2_dec_exit,
> +	},
> +	[HANTRO_MODE_VP8_DEC] = {
> +		.run = hantro_g1_vp8_dec_run,
> +		.init = hantro_vp8_dec_init,
> +		.exit = hantro_vp8_dec_exit,
> +	},
> +	[HANTRO_MODE_H264_DEC] = {
> +		.run = hantro_g1_h264_dec_run,
> +		.init = hantro_h264_dec_init,
> +		.exit = hantro_h264_dec_exit,
> +	},
> +};
> +
>  static const struct hantro_codec_ops imx8mq_vpu_g2_codec_ops[] = {
>  	[HANTRO_MODE_HEVC_DEC] = {
>  		.run = hantro_g2_hevc_dec_run,
> -		.reset = imx8m_vpu_g2_reset,
>  		.init = hantro_hevc_dec_init,
>  		.exit = hantro_hevc_dec_exit,
>  	},
>  	[HANTRO_MODE_VP9_DEC] = {
>  		.run = hantro_g2_vp9_dec_run,
>  		.done = hantro_g2_vp9_dec_done,
> -		.reset = imx8m_vpu_g2_reset,
>  		.init = hantro_vp9_dec_init,
>  		.exit = hantro_vp9_dec_exit,
>  	},
> @@ -267,6 +276,8 @@ static const struct hantro_irq imx8mq_g2_irqs[] = {
>  
>  static const char * const imx8mq_clk_names[] = { "g1", "g2", "bus" };
>  static const char * const imx8mq_reg_names[] = { "g1", "g2", "ctrl" };
> +static const char * const imx8mq_g1_clk_names[] = { "g1" };
> +static const char * const imx8mq_g2_clk_names[] = { "g2" };
>  
>  const struct hantro_variant imx8mq_vpu_variant = {
>  	.dec_fmts = imx8m_vpu_dec_fmts,
> @@ -287,6 +298,21 @@ const struct hantro_variant imx8mq_vpu_variant = {
>  	.num_regs = ARRAY_SIZE(imx8mq_reg_names)
>  };
>  
> +const struct hantro_variant imx8mq_vpu_g1_variant = {
> +	.dec_fmts = imx8m_vpu_dec_fmts,
> +	.num_dec_fmts = ARRAY_SIZE(imx8m_vpu_dec_fmts),
> +	.postproc_fmts = imx8m_vpu_postproc_fmts,
> +	.num_postproc_fmts = ARRAY_SIZE(imx8m_vpu_postproc_fmts),
> +	.postproc_ops = &hantro_g1_postproc_ops,
> +	.codec = HANTRO_MPEG2_DECODER | HANTRO_VP8_DECODER |
> +		 HANTRO_H264_DECODER,
> +	.codec_ops = imx8mq_vpu_g1_codec_ops,
> +	.irqs = imx8mq_irqs,
> +	.num_irqs = ARRAY_SIZE(imx8mq_irqs),
> +	.clk_names = imx8mq_g1_clk_names,
> +	.num_clocks = ARRAY_SIZE(imx8mq_g1_clk_names),
> +};
> +
>  const struct hantro_variant imx8mq_vpu_g2_variant = {
>  	.dec_offset = 0x0,
>  	.dec_fmts = imx8m_vpu_g2_dec_fmts,
> @@ -296,10 +322,8 @@ const struct hantro_variant imx8mq_vpu_g2_variant = {
>  	.postproc_ops = &hantro_g2_postproc_ops,
>  	.codec = HANTRO_HEVC_DECODER | HANTRO_VP9_DECODER,
>  	.codec_ops = imx8mq_vpu_g2_codec_ops,
> -	.init = imx8mq_vpu_hw_init,
> -	.runtime_resume = imx8mq_runtime_resume,
>  	.irqs = imx8mq_g2_irqs,
>  	.num_irqs = ARRAY_SIZE(imx8mq_g2_irqs),
> -	.clk_names = imx8mq_clk_names,
> -	.num_clocks = ARRAY_SIZE(imx8mq_clk_names),
> +	.clk_names = imx8mq_g2_clk_names,
> +	.num_clocks = ARRAY_SIZE(imx8mq_g2_clk_names),
>  };
> -- 
> 2.32.0
> 
