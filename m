Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 730AC498738
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 18:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244319AbiAXRtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 12:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244237AbiAXRtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 12:49:05 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBCFC061744
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 09:49:04 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id u129so596151oib.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 09:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+NLX3R1cE70RQfveZRD6FH9WgGQntlpSO5v8UvTcWFc=;
        b=pBM5BTKeJF5ayuNLJyfZOfHiGDI1ZsCzdpCy2ANcmLXxEy30QSBbe8P3oEj7usFApd
         LuwaT+lEJxm1+Cek9HZKcZ2Ax8mx7CgScbcC1pIIe9KX15W/2Le3EDwBgVXSKlQR84EY
         XfzSpvWqVjrIMgMR0q1x+uYCxZlx1s77eSuJSOsd1Hct6cG/5Nvfn61ThsFmAgJDSgHz
         fG7/WDYyzDW4yT72wqgXp8V8aH7mbyi5BM8/B6RkELX7tKp4qk2NrSmVWtFooTYZ4g4+
         chZLJ4j5BYtZofzPDmcsdCOc6D8TrLyMVZdXdD+oSIaqhRAOoDvm9YWTrd2oIyEzUucR
         OgBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+NLX3R1cE70RQfveZRD6FH9WgGQntlpSO5v8UvTcWFc=;
        b=0ToEuJp5AzXUaVvC43Ock/idJGUXiukM3vJs9Cb72Bxw790HFe/X+wf0RsSxgUwgAL
         al2HDo2NvqnQey4C028t3D5vuVZ9wBEIKaiMtIwbGu+0Snksih1En2qYP+zq7HwU3wKo
         ssv5tynO2IWoSY2zkvJoX5jFN5YPyEIpybhdAzs4OXMsIZpAg5RlrYYnUqNPWIwcjal5
         WAUorC0g+2v/vns7vVbnVS5NfKeVHsncX/mycWYX99xF4c44KzIAN85ZKBVvrg9B2Weu
         Mm/N0KwzA9dfS6N1Pdqv8plMCIhhQX8Xr5cpxf5TsWpAyA168bnaWixP0BmugSumBmPS
         JanQ==
X-Gm-Message-State: AOAM530kD4msov+QOC7WVoUFuWB523QffkWcwLjbdPA8TLXBtN6yR4tH
        UNtzJCCv0KySe9t3TdelABsrkg==
X-Google-Smtp-Source: ABdhPJzj7F2gOyTNGb+hp2IschcMiHIeJMXg5e0x4my2DCxicYn20Rr+QiuG8pgtjjBJZjNj7uusnA==
X-Received: by 2002:a54:4004:: with SMTP id x4mr2448324oie.18.1643046544089;
        Mon, 24 Jan 2022 09:49:04 -0800 (PST)
Received: from eze-laptop ([190.194.87.200])
        by smtp.gmail.com with ESMTPSA id j19sm3642063oih.3.2022.01.24.09.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 09:49:02 -0800 (PST)
Date:   Mon, 24 Jan 2022 14:48:56 -0300
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
Subject: Re: [PATCH V3 09/10] media: hantro: Add support for i.MX8MM Hantro-G1
Message-ID: <Ye7miOjf0LUruuEk@eze-laptop>
References: <20220124023125.414794-1-aford173@gmail.com>
 <20220124023125.414794-10-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124023125.414794-10-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On Sun, Jan 23, 2022 at 08:31:23PM -0600, Adam Ford wrote:
> The i.MX8MM has a Hantro G1 video decoder similar to the
> imx8mq but lacks the post-processor present in the imx8mq.
> Add support in the driver for it with the post-processing
> removed.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 

Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Thanks a lot,
Ezequiel

> diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
> index a670ddd29c4c..b281ac4fb79c 100644
> --- a/drivers/staging/media/hantro/hantro_drv.c
> +++ b/drivers/staging/media/hantro/hantro_drv.c
> @@ -615,6 +615,7 @@ static const struct of_device_id of_hantro_match[] = {
>  	{ .compatible = "rockchip,rk3399-vpu", .data = &rk3399_vpu_variant, },
>  #endif
>  #ifdef CONFIG_VIDEO_HANTRO_IMX8M
> +	{ .compatible = "nxp,imx8mm-vpu-g1", .data = &imx8mm_vpu_g1_variant, },
>  	{ .compatible = "nxp,imx8mq-vpu", .data = &imx8mq_vpu_variant, },
>  	{ .compatible = "nxp,imx8mq-vpu-g1", .data = &imx8mq_vpu_g1_variant },
>  	{ .compatible = "nxp,imx8mq-vpu-g2", .data = &imx8mq_vpu_g2_variant },
> diff --git a/drivers/staging/media/hantro/hantro_hw.h b/drivers/staging/media/hantro/hantro_hw.h
> index f0bd2ffe290b..c00b46e06055 100644
> --- a/drivers/staging/media/hantro/hantro_hw.h
> +++ b/drivers/staging/media/hantro/hantro_hw.h
> @@ -299,6 +299,7 @@ enum hantro_enc_fmt {
>  	ROCKCHIP_VPU_ENC_FMT_UYVY422 = 3,
>  };
>  
> +extern const struct hantro_variant imx8mm_vpu_g1_variant;
>  extern const struct hantro_variant imx8mq_vpu_g1_variant;
>  extern const struct hantro_variant imx8mq_vpu_g2_variant;
>  extern const struct hantro_variant imx8mq_vpu_variant;
> diff --git a/drivers/staging/media/hantro/imx8m_vpu_hw.c b/drivers/staging/media/hantro/imx8m_vpu_hw.c
> index 849ea7122d47..9802508bade2 100644
> --- a/drivers/staging/media/hantro/imx8m_vpu_hw.c
> +++ b/drivers/staging/media/hantro/imx8m_vpu_hw.c
> @@ -327,3 +327,15 @@ const struct hantro_variant imx8mq_vpu_g2_variant = {
>  	.clk_names = imx8mq_g2_clk_names,
>  	.num_clocks = ARRAY_SIZE(imx8mq_g2_clk_names),
>  };
> +
> +const struct hantro_variant imx8mm_vpu_g1_variant = {
> +	.dec_fmts = imx8m_vpu_dec_fmts,
> +	.num_dec_fmts = ARRAY_SIZE(imx8m_vpu_dec_fmts),
> +	.codec = HANTRO_MPEG2_DECODER | HANTRO_VP8_DECODER |
> +		 HANTRO_H264_DECODER,
> +	.codec_ops = imx8mq_vpu_g1_codec_ops,
> +	.irqs = imx8mq_irqs,
> +	.num_irqs = ARRAY_SIZE(imx8mq_irqs),
> +	.clk_names = imx8mq_g1_clk_names,
> +	.num_clocks = ARRAY_SIZE(imx8mq_g1_clk_names),
> +};
> -- 
> 2.32.0
> 
