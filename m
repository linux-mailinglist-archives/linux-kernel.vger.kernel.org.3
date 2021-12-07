Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB35746BB7B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 13:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236537AbhLGMms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 07:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236398AbhLGMmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 07:42:47 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00707C061748
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 04:39:16 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id p37so26178660uae.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 04:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f5zNiGp1JSRMA3ASHOmUNvDb/V2yjKGJt7/64a/2WPc=;
        b=gx8+94KVsuJqe1HwL87XV9zl/HbVJp5NymZXXh4xMOByJ9y3MEhjy19i/FXs3tMYpn
         zrUkflXzCLCrXlfsD6l/pX67U1MCrGgLDJN8oiIQwouIOx76JxY5QR/Qo1SLU2JOYxGt
         z9Fam7x/pYxZiH4UUqdvS7PKe5+iYlAmfnx+n2bjCq+CddGylOfU7sRICNRsoeyJ5n/l
         DjH/Iv2Qpx5V/Nl/NVJsN++HHjy7trhelHzBkozk4Z4FWPyeLq/UakPE+IlEvBCBihoq
         qIlPefZy2yGP4kfuUGe9PgBLIMBHQ+tAVt+fTdZtoJaFWTtghbkuXS08dPxecYBbhRq1
         9uaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f5zNiGp1JSRMA3ASHOmUNvDb/V2yjKGJt7/64a/2WPc=;
        b=SCPV2QNJQhR2JPVcUM1b9ir/q+JRp5uL4tVwhGsij6CddcJbDij4NsLeIn4kiKChhJ
         EL+QXcyRb01mIUCjQFjbXL/QlmjS5SMmrEba4S58Zs0cSNn/259+IKSnD9/Kn0rbhXQo
         VskLj44qFfQsjIwMXdjzBu4UsnfGtkamw934NZykudIxuc3y1tnKP+vuQVmhEUXd+Hbr
         HtQuCtlmDoEkrZblqchYXgKYquSyiFcLCnOwlDkjH0XOtMRZtv5zrDAhYnDWBCKGVKdN
         NehnkpbhHY2RaWOlPnRB3DjAXLKKYPyyCP+QMjw5hoV8FOvbHMc3Hj+QEP7jVfjcJtab
         js7g==
X-Gm-Message-State: AOAM531upK+uWZbdiLZUjBcS46CJfRP2FhS6XlV+V5Yo2qkYQCbH2Wwg
        p5ki6y7xRVl7L8iAGHdOCGhgZg==
X-Google-Smtp-Source: ABdhPJwgSwCNzy5HjbSEOmWA5It2C47YIiajCxqyi27+tXazPDhvr0kGSvN8zGoCTdGVRhKlVhcRpA==
X-Received: by 2002:a9f:3086:: with SMTP id j6mr50620326uab.83.1638880755986;
        Tue, 07 Dec 2021 04:39:15 -0800 (PST)
Received: from eze-laptop (host208.201-253-22.telecom.net.ar. [201.253.22.208])
        by smtp.gmail.com with ESMTPSA id w17sm6302166uar.18.2021.12.07.04.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 04:39:14 -0800 (PST)
Date:   Tue, 7 Dec 2021 09:39:08 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-media@vger.kernel.org, cphealy@gmail.com,
        benjamin.gaignard@collabora.com, hverkuil@xs4all.nl,
        Philipp Zabel <p.zabel@pengutronix.de>,
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
Subject: Re: [RFC V2 5/6] media: hantro: split i.MX8MQ G1 and G2 code
Message-ID: <Ya9V7Kwa8MICeS34@eze-laptop>
References: <20211207015446.1250854-1-aford173@gmail.com>
 <20211207015446.1250854-6-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207015446.1250854-6-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

Thanks for the good work! This is looking quite promising.

On Mon, Dec 06, 2021 at 07:54:44PM -0600, Adam Ford wrote:
> The VPU in the i.MX8MQ is really the combination of Hantro G1 and
> Hantro G2. With the updated vpu-blk-ctrl, the power domains system
> can enable and disable them separately as well as pull them out of
> reset. This simplifies the code and lets them run independently.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
> index ab2467998d29..d803252a5aba 100644
> --- a/drivers/staging/media/hantro/hantro_drv.c
> +++ b/drivers/staging/media/hantro/hantro_drv.c
> @@ -608,8 +608,8 @@ static const struct of_device_id of_hantro_match[] = {
>  	{ .compatible = "rockchip,rk3399-vpu", .data = &rk3399_vpu_variant, },
>  #endif
>  #ifdef CONFIG_VIDEO_HANTRO_IMX8M
> -	{ .compatible = "nxp,imx8mq-vpu", .data = &imx8mq_vpu_variant, },
> -	{ .compatible = "nxp,imx8mq-vpu-g2", .data = &imx8mq_vpu_g2_variant },
> +	{ .compatible = "nxp,imx8mq-vpu-g1", .data = &imx8mq_vpu_g1_variant, },

I think it's important to clarify that you are breaking support
for the previous device-tree binding. Not only because of the compatible
string change, but because the binding is now quite different.

Note that in the past Benjamin tried to avoid this.
IIRC, his proposal was backwards compatible.

If this is unavoidable, due to how the blk-ctrl is handled, then that's
fine. Given it's a staging driver, we can still play these games.

Having said that, let's please make this very clear in the commit
description, to it's clear for developers forward-porting their kernels.
This applies not only to this commit, but to all commits that affect
the binding.

Thanks!
Ezequiel

> +	{ .compatible = "nxp,imx8mq-vpu-g2", .data = &imx8mq_vpu_g2_variant, },
>  #endif
>  #ifdef CONFIG_VIDEO_HANTRO_SAMA5D4
>  	{ .compatible = "microchip,sama5d4-vdec", .data = &sama5d4_vdec_variant, },
> diff --git a/drivers/staging/media/hantro/hantro_hw.h b/drivers/staging/media/hantro/hantro_hw.h
> index cff817ca8d22..122b83a16663 100644
> --- a/drivers/staging/media/hantro/hantro_hw.h
> +++ b/drivers/staging/media/hantro/hantro_hw.h
> @@ -299,8 +299,8 @@ enum hantro_enc_fmt {
>  	ROCKCHIP_VPU_ENC_FMT_UYVY422 = 3,
>  };
>  
> +extern const struct hantro_variant imx8mq_vpu_g1_variant;
>  extern const struct hantro_variant imx8mq_vpu_g2_variant;
> -extern const struct hantro_variant imx8mq_vpu_variant;
>  extern const struct hantro_variant px30_vpu_variant;
>  extern const struct hantro_variant rk3036_vpu_variant;
>  extern const struct hantro_variant rk3066_vpu_variant;
> diff --git a/drivers/staging/media/hantro/imx8m_vpu_hw.c b/drivers/staging/media/hantro/imx8m_vpu_hw.c
> index 1a43f6fceef9..c9f6e8472258 100644
> --- a/drivers/staging/media/hantro/imx8m_vpu_hw.c
> +++ b/drivers/staging/media/hantro/imx8m_vpu_hw.c
> @@ -13,67 +13,6 @@
>  #include "hantro_g1_regs.h"
>  #include "hantro_g2_regs.h"
>  
> -#define CTRL_SOFT_RESET		0x00
> -#define RESET_G1		BIT(1)
> -#define RESET_G2		BIT(0)
> -
> -#define CTRL_CLOCK_ENABLE	0x04
> -#define CLOCK_G1		BIT(1)
> -#define CLOCK_G2		BIT(0)
> -
> -#define CTRL_G1_DEC_FUSE	0x08
> -#define CTRL_G1_PP_FUSE		0x0c
> -#define CTRL_G2_DEC_FUSE	0x10
> -
> -static void imx8m_soft_reset(struct hantro_dev *vpu, u32 reset_bits)
> -{
> -	u32 val;
> -
> -	/* Assert */
> -	val = readl(vpu->ctrl_base + CTRL_SOFT_RESET);
> -	val &= ~reset_bits;
> -	writel(val, vpu->ctrl_base + CTRL_SOFT_RESET);
> -
> -	udelay(2);
> -
> -	/* Release */
> -	val = readl(vpu->ctrl_base + CTRL_SOFT_RESET);
> -	val |= reset_bits;
> -	writel(val, vpu->ctrl_base + CTRL_SOFT_RESET);
> -}
> -
> -static void imx8m_clk_enable(struct hantro_dev *vpu, u32 clock_bits)
> -{
> -	u32 val;
> -
> -	val = readl(vpu->ctrl_base + CTRL_CLOCK_ENABLE);
> -	val |= clock_bits;
> -	writel(val, vpu->ctrl_base + CTRL_CLOCK_ENABLE);
> -}
> -
> -static int imx8mq_runtime_resume(struct hantro_dev *vpu)
> -{
> -	int ret;
> -
> -	ret = clk_bulk_prepare_enable(vpu->variant->num_clocks, vpu->clocks);
> -	if (ret) {
> -		dev_err(vpu->dev, "Failed to enable clocks\n");
> -		return ret;
> -	}
> -
> -	imx8m_soft_reset(vpu, RESET_G1 | RESET_G2);
> -	imx8m_clk_enable(vpu, CLOCK_G1 | CLOCK_G2);
> -
> -	/* Set values of the fuse registers */
> -	writel(0xffffffff, vpu->ctrl_base + CTRL_G1_DEC_FUSE);
> -	writel(0xffffffff, vpu->ctrl_base + CTRL_G1_PP_FUSE);
> -	writel(0xffffffff, vpu->ctrl_base + CTRL_G2_DEC_FUSE);
> -
> -	clk_bulk_disable_unprepare(vpu->variant->num_clocks, vpu->clocks);
> -
> -	return 0;
> -}
> -
>  /*
>   * Supported formats.
>   */
> @@ -209,27 +148,6 @@ static irqreturn_t imx8m_vpu_g2_irq(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> -static int imx8mq_vpu_hw_init(struct hantro_dev *vpu)
> -{
> -	vpu->ctrl_base = vpu->reg_bases[vpu->variant->num_regs - 1];
> -
> -	return 0;
> -}
> -
> -static void imx8m_vpu_g1_reset(struct hantro_ctx *ctx)
> -{
> -	struct hantro_dev *vpu = ctx->dev;
> -
> -	imx8m_soft_reset(vpu, RESET_G1);
> -}
> -
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
> @@ -237,19 +155,16 @@ static void imx8m_vpu_g2_reset(struct hantro_ctx *ctx)
>  static const struct hantro_codec_ops imx8mq_vpu_codec_ops[] = {
>  	[HANTRO_MODE_MPEG2_DEC] = {
>  		.run = hantro_g1_mpeg2_dec_run,
> -		.reset = imx8m_vpu_g1_reset,
>  		.init = hantro_mpeg2_dec_init,
>  		.exit = hantro_mpeg2_dec_exit,
>  	},
>  	[HANTRO_MODE_VP8_DEC] = {
>  		.run = hantro_g1_vp8_dec_run,
> -		.reset = imx8m_vpu_g1_reset,
>  		.init = hantro_vp8_dec_init,
>  		.exit = hantro_vp8_dec_exit,
>  	},
>  	[HANTRO_MODE_H264_DEC] = {
>  		.run = hantro_g1_h264_dec_run,
> -		.reset = imx8m_vpu_g1_reset,
>  		.init = hantro_h264_dec_init,
>  		.exit = hantro_h264_dec_exit,
>  	},
> @@ -258,14 +173,12 @@ static const struct hantro_codec_ops imx8mq_vpu_codec_ops[] = {
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
> @@ -275,7 +188,7 @@ static const struct hantro_codec_ops imx8mq_vpu_g2_codec_ops[] = {
>   * VPU variants.
>   */
>  
> -static const struct hantro_irq imx8mq_irqs[] = {
> +static const struct hantro_irq imx8mq_g1_irqs[] = {
>  	{ "g1", imx8m_vpu_g1_irq },
>  };
>  
> @@ -283,10 +196,12 @@ static const struct hantro_irq imx8mq_g2_irqs[] = {
>  	{ "g2", imx8m_vpu_g2_irq },
>  };
>  
> -static const char * const imx8mq_clk_names[] = { "g1", "g2", "bus" };
> -static const char * const imx8mq_reg_names[] = { "g1", "g2", "ctrl" };
> +static const char * const imx8mq_g1_clk_names[] = { "g1" };
> +static const char * const imx8mq_g1_reg_names[] = { "g1" };
> +static const char * const imx8mq_g2_clk_names[] = { "g2" };
> +static const char * const imx8mq_g2_reg_names[] = { "g2" };
>  
> -const struct hantro_variant imx8mq_vpu_variant = {
> +const struct hantro_variant imx8mq_vpu_g1_variant = {
>  	.dec_fmts = imx8m_vpu_dec_fmts,
>  	.num_dec_fmts = ARRAY_SIZE(imx8m_vpu_dec_fmts),
>  	.postproc_fmts = imx8m_vpu_postproc_fmts,
> @@ -295,14 +210,12 @@ const struct hantro_variant imx8mq_vpu_variant = {
>  	.codec = HANTRO_MPEG2_DECODER | HANTRO_VP8_DECODER |
>  		 HANTRO_H264_DECODER,
>  	.codec_ops = imx8mq_vpu_codec_ops,
> -	.init = imx8mq_vpu_hw_init,
> -	.runtime_resume = imx8mq_runtime_resume,
> -	.irqs = imx8mq_irqs,
> -	.num_irqs = ARRAY_SIZE(imx8mq_irqs),
> -	.clk_names = imx8mq_clk_names,
> -	.num_clocks = ARRAY_SIZE(imx8mq_clk_names),
> -	.reg_names = imx8mq_reg_names,
> -	.num_regs = ARRAY_SIZE(imx8mq_reg_names)
> +	.irqs = imx8mq_g1_irqs,
> +	.num_irqs = ARRAY_SIZE(imx8mq_g1_irqs),
> +	.clk_names = imx8mq_g1_clk_names,
> +	.num_clocks = ARRAY_SIZE(imx8mq_g1_clk_names),
> +	.reg_names = imx8mq_g1_reg_names,
> +	.num_regs = ARRAY_SIZE(imx8mq_g1_reg_names),
>  };
>  
>  const struct hantro_variant imx8mq_vpu_g2_variant = {
> @@ -314,10 +227,10 @@ const struct hantro_variant imx8mq_vpu_g2_variant = {
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
> +	.reg_names = imx8mq_g2_reg_names,
> +	.num_regs = ARRAY_SIZE(imx8mq_g2_reg_names),
>  };
> -- 
> 2.32.0
> 
