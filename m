Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A55557915
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 13:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbiFWLxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 07:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiFWLxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 07:53:52 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12F24D247
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 04:53:51 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-101ec2d6087so15849210fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 04:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XSwofcGG+SuHZWjrcw4RCNPkMyXc7hvkKah+C3xh1WY=;
        b=vpoPxNjXWrU9nkPNyRtHurU6kHESQTp+i6RaSWdF1/oI2TiHgWSaRUOwwSyWlGs7Rg
         MWfR/45XHtMSk2oR1KvVuPu7dkFqOkAv7XtznKxA8hpRQEYfCCPwi9CwSehF1qvj9JT9
         0drhGVMjzBbEdiNg+TE0urW03QT7hmqYAg/CpR4hBJ4jf5B4dp45OfknorHeBRBhddjK
         FQTfEL8UkKkyn9+LT3a7S7YVZu08e5pJqu31bTSDHW3InYof+zowTqQgAYhjGwrA6PvI
         4g6ZfQx9Z4hDF0Uf470iS14506I9h0/5pQx3Rj++3ip/D3ZLVIMlB/QIQe4hrjizhMl9
         Pw0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XSwofcGG+SuHZWjrcw4RCNPkMyXc7hvkKah+C3xh1WY=;
        b=Ub+ZVUJdk3/KHLHTcItqeVWHurjUW+ZbbKxYdU+Iv5KLycxm162R/KGKcLet9GLysy
         lQSROcyTtbH+gCkpfuCEdxlIJ9MQa4Mj3sunp4vE3JnrSWD9SVCfwIafiRqx+3pRz4Wp
         mcXAW4DB9qAeV5blUmtrNi7D5RffMFMtldMR82GvsMwEh3t6Cueu4ZK2gisoTxpBSiy7
         DSfl7tHc6FFrrUrW7Pl5NGomF8xWEiX0J34vOQNuCiEmQAP6WlhspMoV1O9Zb/Pgt3Qh
         AR4Ncn/6tEr4iHhuHiNfVBgioAjIDGk3OLhaw0+r0XT0Om5No7AUSQKSF6L50SiwA4CG
         7RHA==
X-Gm-Message-State: AJIora/1Vn1ghACvvwjlrKCWpsoFZl7Y7KrZuPlfxxifCoWJNwH8sE9d
        PWDO99nRMPBCQFLTki/x0Lt68A==
X-Google-Smtp-Source: AGRyM1uUfHwTgGd1byknrOoPAeDPrqoAhY+P3IumHMsnT2THZTV0C6LIrL7B2BG/Fu7TllSLOQ+6TQ==
X-Received: by 2002:a05:6870:b48d:b0:101:c750:a4b0 with SMTP id y13-20020a056870b48d00b00101c750a4b0mr2200530oap.204.1655985230967;
        Thu, 23 Jun 2022 04:53:50 -0700 (PDT)
Received: from eze-laptop ([186.13.97.222])
        by smtp.gmail.com with ESMTPSA id eb10-20020a056870a88a00b000f5f4ad194bsm12189484oab.25.2022.06.23.04.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 04:53:31 -0700 (PDT)
Date:   Thu, 23 Jun 2022 08:53:12 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 2/3] media: hantro: Add support for RK356x encoder
Message-ID: <YrRUKD17Wtf5ik0r@eze-laptop>
References: <20220612155346.16288-1-frattaroli.nicolas@gmail.com>
 <20220612155346.16288-3-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220612155346.16288-3-frattaroli.nicolas@gmail.com>
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

On Sun, Jun 12, 2022 at 05:53:45PM +0200, Nicolas Frattaroli wrote:
> The RK3566 and RK3568 SoCs come with a small Hantro instance which is
> solely dedicated to encoding. This patch adds the necessary structs to
> the Hantro driver to allow the JPEG encoder of it to function.
> 
> Through some sleuthing through the vendor's MPP source code and after
> closer inspection of the TRM, it was determined that the hardware likely
> supports VP8 and H.264 as well.
> 
> Tested with the following GStreamer command:
> 
> gst-launch-1.0 videotestsrc ! v4l2jpegenc ! matroskamux ! \
>                filesink location=foo.mkv
> 
> Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>

Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Thanks,
Ezequiel

> ---
>  drivers/staging/media/hantro/hantro_drv.c     |  1 +
>  drivers/staging/media/hantro/hantro_hw.h      |  1 +
>  .../staging/media/hantro/rockchip_vpu_hw.c    | 25 +++++++++++++++++++
>  3 files changed, 27 insertions(+)
> 
> diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
> index ac232b5f7825..1112e8d0c821 100644
> --- a/drivers/staging/media/hantro/hantro_drv.c
> +++ b/drivers/staging/media/hantro/hantro_drv.c
> @@ -638,6 +638,7 @@ static const struct of_device_id of_hantro_match[] = {
>  	{ .compatible = "rockchip,rk3288-vpu", .data = &rk3288_vpu_variant, },
>  	{ .compatible = "rockchip,rk3328-vpu", .data = &rk3328_vpu_variant, },
>  	{ .compatible = "rockchip,rk3399-vpu", .data = &rk3399_vpu_variant, },
> +	{ .compatible = "rockchip,rk3568-vepu", .data = &rk3568_vepu_variant, },
>  	{ .compatible = "rockchip,rk3568-vpu", .data = &rk3568_vpu_variant, },
>  #endif
>  #ifdef CONFIG_VIDEO_HANTRO_IMX8M
> diff --git a/drivers/staging/media/hantro/hantro_hw.h b/drivers/staging/media/hantro/hantro_hw.h
> index 52a960f6fa4a..8c7eb5591446 100644
> --- a/drivers/staging/media/hantro/hantro_hw.h
> +++ b/drivers/staging/media/hantro/hantro_hw.h
> @@ -306,6 +306,7 @@ extern const struct hantro_variant rk3066_vpu_variant;
>  extern const struct hantro_variant rk3288_vpu_variant;
>  extern const struct hantro_variant rk3328_vpu_variant;
>  extern const struct hantro_variant rk3399_vpu_variant;
> +extern const struct hantro_variant rk3568_vepu_variant;
>  extern const struct hantro_variant rk3568_vpu_variant;
>  extern const struct hantro_variant sama5d4_vdec_variant;
>  extern const struct hantro_variant sunxi_vpu_variant;
> diff --git a/drivers/staging/media/hantro/rockchip_vpu_hw.c b/drivers/staging/media/hantro/rockchip_vpu_hw.c
> index fc96501f3bc8..b39813d53e57 100644
> --- a/drivers/staging/media/hantro/rockchip_vpu_hw.c
> +++ b/drivers/staging/media/hantro/rockchip_vpu_hw.c
> @@ -417,6 +417,14 @@ static const struct hantro_codec_ops rk3399_vpu_codec_ops[] = {
>  	},
>  };
>  
> +static const struct hantro_codec_ops rk3568_vepu_codec_ops[] = {
> +	[HANTRO_MODE_JPEG_ENC] = {
> +		.run = rockchip_vpu2_jpeg_enc_run,
> +		.reset = rockchip_vpu2_enc_reset,
> +		.done = rockchip_vpu2_jpeg_enc_done,
> +	},
> +};
> +
>  /*
>   * VPU variant.
>   */
> @@ -439,6 +447,10 @@ static const struct hantro_irq rockchip_vpu2_irqs[] = {
>  	{ "vdpu", rockchip_vpu2_vdpu_irq },
>  };
>  
> +static const struct hantro_irq rk3568_vepu_irqs[] = {
> +	{ "vepu", rockchip_vpu2_vepu_irq },
> +};
> +
>  static const char * const rk3066_vpu_clk_names[] = {
>  	"aclk_vdpu", "hclk_vdpu",
>  	"aclk_vepu", "hclk_vepu"
> @@ -545,6 +557,19 @@ const struct hantro_variant rk3399_vpu_variant = {
>  	.num_clocks = ARRAY_SIZE(rockchip_vpu_clk_names)
>  };
>  
> +const struct hantro_variant rk3568_vepu_variant = {
> +	.enc_offset = 0x0,
> +	.enc_fmts = rockchip_vpu_enc_fmts,
> +	.num_enc_fmts = ARRAY_SIZE(rockchip_vpu_enc_fmts),
> +	.codec = HANTRO_JPEG_ENCODER,
> +	.codec_ops = rk3568_vepu_codec_ops,
> +	.irqs = rk3568_vepu_irqs,
> +	.num_irqs = ARRAY_SIZE(rk3568_vepu_irqs),
> +	.init = rockchip_vpu_hw_init,
> +	.clk_names = rockchip_vpu_clk_names,
> +	.num_clocks = ARRAY_SIZE(rockchip_vpu_clk_names)
> +};
> +
>  const struct hantro_variant rk3568_vpu_variant = {
>  	.dec_offset = 0x400,
>  	.dec_fmts = rk3399_vpu_dec_fmts,
> -- 
> 2.36.1
> 
