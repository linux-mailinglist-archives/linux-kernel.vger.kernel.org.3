Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF1E9477163
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 13:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbhLPMJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 07:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235005AbhLPMJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 07:09:36 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDFFC06173E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 04:09:36 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id z9so25147237qtj.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 04:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=27iVM0aKdAv+JiQsBY26McdFr1qGDMbXj62yl//SmdI=;
        b=EjgfyGJxxUe0zKPwlPZuWE1t0SOucWDWFeCaHtd9CtTjvYD8KEvoSGADHu9gyNPb0w
         JWQPYcVpFoMLCKxKe917EAK3rQhm9rqbvanX8/9tJipQjxDtiQrgd9Cyi+m8psvEwL07
         PriJRFI5nVCSe2OHRbYWLOhhpLhYbXN1zyMtuHe9ubzsaCm6FuB5gxGs1deiCaaqsuIS
         7SNZge5tLLcsnLVmrsCRRGJLbd0V8yjk0WMx3srgHenZpyaQN39xjSVUVhEL9GRNyEiG
         C/FPjhJYYMzHEq3sI8Gnz+D8pqXEECyYqYbePLztZIJ0168ItbNPW6z/qUz4JZ9EcVMP
         xe9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=27iVM0aKdAv+JiQsBY26McdFr1qGDMbXj62yl//SmdI=;
        b=lFitTxK9N9P5EiH5DXDeCw8fwasGq8zyYuenJt/882/m5XkOwfyQspg8Bsq9bNu//M
         tp13gJ3gF/cXkje0KOlOx3cXw0j6Ciw5ZEteBUxSbNBR2X4ESoI6+URodMv0hkI5Id1c
         hia5f0V1rZ4pc0jJymi9DqIghQPmZ2AIB+5D0HvQJ/T0nDfq1k+AkfNBHf56c6WzJfqG
         kSXrcZ8MTDosSXN2kh/N6DKGjwIwj5PNcn/5DFb3NkE3SHYHYpUPO8A+jdOaYPO3veYJ
         LiC+sP5dBt6GYuMWeF+ExctIiCYCbEZPP2FA+gfTQgpaAdQXFXpvVEYSGzw0k2V6OHlH
         jN4w==
X-Gm-Message-State: AOAM532h3HIS3zTEbOjulqBtLCXah2BzbknET3kEy8cAf7Z1HSscpyF/
        KZwdB6Y70148tPw6Uboa8XSGdw==
X-Google-Smtp-Source: ABdhPJzK5axWJi3teF0QGvKpI/4LKnG7d8mowHvrhT9SMBZNmCvwXv/NOOVc4korY3W6ostQo3hcsw==
X-Received: by 2002:a05:622a:1902:: with SMTP id w2mr16510679qtc.93.1639656575105;
        Thu, 16 Dec 2021 04:09:35 -0800 (PST)
Received: from eze-laptop ([2803:9800:98c2:8470:9f4:8e2a:88e5:ec01])
        by smtp.gmail.com with ESMTPSA id k9sm4220397qta.48.2021.12.16.04.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 04:09:33 -0800 (PST)
Date:   Thu, 16 Dec 2021 09:09:26 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-media@vger.kernel.org, abel.vesa@nxp.com,
        aford@beaconembedded.com, benjamin.gaignard@collabora.com,
        hverkuil-cisco@xs4all.nl, Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH V2 05/10] media: hantro: Allow i.MX8MQ G1 and G2 to run
 independently
Message-ID: <YbssdkOvCR3UMtKQ@eze-laptop>
References: <20211216111256.2362683-1-aford173@gmail.com>
 <20211216111256.2362683-6-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216111256.2362683-6-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On Thu, Dec 16, 2021 at 05:12:50AM -0600, Adam Ford wrote:
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
> index ab2467998d29..e7afda388ee5 100644
> --- a/drivers/staging/media/hantro/hantro_drv.c
> +++ b/drivers/staging/media/hantro/hantro_drv.c
> @@ -609,6 +609,7 @@ static const struct of_device_id of_hantro_match[] = {
>  #endif
>  #ifdef CONFIG_VIDEO_HANTRO_IMX8M
>  	{ .compatible = "nxp,imx8mq-vpu", .data = &imx8mq_vpu_variant, },
> +	{ .compatible = "nxp,imx8mq-vpu-g1", .data = &imx8mq_vpu_g1_variant },
>  	{ .compatible = "nxp,imx8mq-vpu-g2", .data = &imx8mq_vpu_g2_variant },
>  #endif
>  #ifdef CONFIG_VIDEO_HANTRO_SAMA5D4
> diff --git a/drivers/staging/media/hantro/hantro_hw.h b/drivers/staging/media/hantro/hantro_hw.h
> index cff817ca8d22..96b14b43a4af 100644
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
> index 1a43f6fceef9..4925f2a07d4c 100644
> --- a/drivers/staging/media/hantro/imx8m_vpu_hw.c
> +++ b/drivers/staging/media/hantro/imx8m_vpu_hw.c
> @@ -223,13 +223,6 @@ static void imx8m_vpu_g1_reset(struct hantro_ctx *ctx)
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
> @@ -255,17 +248,33 @@ static const struct hantro_codec_ops imx8mq_vpu_codec_ops[] = {
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
> @@ -285,6 +294,10 @@ static const struct hantro_irq imx8mq_g2_irqs[] = {
>  
>  static const char * const imx8mq_clk_names[] = { "g1", "g2", "bus" };
>  static const char * const imx8mq_reg_names[] = { "g1", "g2", "ctrl" };
> +static const char * const imx8mq_g1_clk_names[] = { "g1" };
> +static const char * const imx8mq_g1_reg_names[] = { "g1" };
> +static const char * const imx8mq_g2_clk_names[] = { "g2" };
> +static const char * const imx8mq_g2_reg_names[] = { "g2" };
>  

I believe the g1 and g2 _reg_names are now unused?

Thanks,
Ezequiel

>  const struct hantro_variant imx8mq_vpu_variant = {
>  	.dec_fmts = imx8m_vpu_dec_fmts,
> @@ -305,6 +318,21 @@ const struct hantro_variant imx8mq_vpu_variant = {
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
> @@ -314,10 +342,8 @@ const struct hantro_variant imx8mq_vpu_g2_variant = {
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
