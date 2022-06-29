Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318B5560A31
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 21:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiF2TUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 15:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiF2TUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 15:20:04 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56751EC72
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 12:20:02 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id v33-20020a4a9764000000b0035f814bb06eso3297650ooi.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 12:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4IY1+lAO4Posxki4A8hl3XkQpihB9YLZGIPFUTvwakM=;
        b=HYC4tZgofx/ozc5CMWDl+alXct7+6S+dQxMbkS7lfomOQqvqi3SXQLiewlzmyuDFi5
         ahx6zd6QAWXzcAEyFdYv66RwYSGLUvergaae5ybUbKeDqvz2CTX/Ndc2OtlXbRWc4j5d
         eeThbp/RaKvtBFN77MLPcUoSKe1H+Y6dnOd2QkkNDEZ2Rp8amwyvNtOkWJeCLdR0vYB0
         dEHtmnqS4gFz4Atb5iAdYKjUblRRjPvf9dIO4R9l/6lcxRptDU3VE5h2HomzueMyU4fO
         JIsE0TZOIHbQhl1l90yKlRQBW0qFzpa9rHVJqX2ghHY5pdpLQNdx9Ir79BVx0iBXdc7H
         zBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4IY1+lAO4Posxki4A8hl3XkQpihB9YLZGIPFUTvwakM=;
        b=RtO5/KISp3JtjNPkFTulfAWR5964ps+4QuFLnqvQTvkqkdeWV4lkcP91ktG9HVhWKH
         rOIuDwPK9gPoa0ke5gu5eUOyU/4kBXiITbIvKlZ06nGJdZG/PEcy7BZ/CgoHleJlFXoG
         yLkf695C5piYJUXTGW+9/L7awdiBmOHsor6sB5gaxENjizUhsUG8gltsKtgzhOjhZ7vK
         FCopbzukAa7rKkSSprJVXH3AI586P/915qT2gG6vICW15u5rjkHoebuehosqq/pGpn3U
         HFG1K+X6r4Xg1Pl1CELDYF/DRXmRH4NzN8ojIbvuu0F9HF6nAzW2eVwTBxUbN3CIqgPL
         85aQ==
X-Gm-Message-State: AJIora9Z9EtrX6Q52qQaAp2yE4vSSVZIf/BcPtUg7UDpK5WQ4DWIizF1
        tGyzoCQSkAnv6hz7FypplbmtJA==
X-Google-Smtp-Source: AGRyM1szB2I5u75eF35Z9NNIRvSjg69yLzAkkdRofmHhMutfeUDBCRnOFjwrl8GRyQF4pR5pXgXnRg==
X-Received: by 2002:a4a:2cc1:0:b0:425:8f67:36f5 with SMTP id o184-20020a4a2cc1000000b004258f6736f5mr2137665ooo.16.1656530402190;
        Wed, 29 Jun 2022 12:20:02 -0700 (PDT)
Received: from eze-laptop ([190.190.187.68])
        by smtp.gmail.com with ESMTPSA id y19-20020a9d7153000000b00612e4267634sm10092952otj.18.2022.06.29.12.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 12:20:01 -0700 (PDT)
Date:   Wed, 29 Jun 2022 16:19:55 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     p.zabel@pengutronix.de, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, benjamin.gaignard@collabora.com,
        nicolas.dufresne@collabora.com, gregkh@linuxfoundation.org,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 7/7] media: hantro: sunxi: Enable 10-bit decoding
Message-ID: <Yryl24uu0CMKpFgQ@eze-laptop>
References: <20220616202513.351039-1-jernej.skrabec@gmail.com>
 <20220616202513.351039-8-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616202513.351039-8-jernej.skrabec@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jernej,

On Thu, Jun 16, 2022 at 10:25:13PM +0200, Jernej Skrabec wrote:
> Now that infrastructure for 10-bit decoding exists, enable it for
> Allwinner H6.
> 

I don't have this hardware, but the patch seems OK.

Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> ---
>  drivers/staging/media/hantro/sunxi_vpu_hw.c | 27 +++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/staging/media/hantro/sunxi_vpu_hw.c b/drivers/staging/media/hantro/sunxi_vpu_hw.c
> index fbeac81e59e1..02ce8b064a8f 100644
> --- a/drivers/staging/media/hantro/sunxi_vpu_hw.c
> +++ b/drivers/staging/media/hantro/sunxi_vpu_hw.c
> @@ -23,12 +23,39 @@ static const struct hantro_fmt sunxi_vpu_postproc_fmts[] = {
>  			.step_height = 32,
>  		},
>  	},
> +	{
> +		.fourcc = V4L2_PIX_FMT_P010,
> +		.codec_mode = HANTRO_MODE_NONE,
> +		.postprocessed = true,
> +		.frmsize = {
> +			.min_width = FMT_MIN_WIDTH,
> +			.max_width = FMT_UHD_WIDTH,
> +			.step_width = 32,
> +			.min_height = FMT_MIN_HEIGHT,
> +			.max_height = FMT_UHD_HEIGHT,
> +			.step_height = 32,
> +		},
> +	},
>  };
>  
>  static const struct hantro_fmt sunxi_vpu_dec_fmts[] = {
>  	{
>  		.fourcc = V4L2_PIX_FMT_NV12_4L4,
>  		.codec_mode = HANTRO_MODE_NONE,
> +		.match_depth = true,
> +		.frmsize = {
> +			.min_width = FMT_MIN_WIDTH,
> +			.max_width = FMT_UHD_WIDTH,
> +			.step_width = 32,
> +			.min_height = FMT_MIN_HEIGHT,
> +			.max_height = FMT_UHD_HEIGHT,
> +			.step_height = 32,
> +		},
> +	},
> +	{
> +		.fourcc = V4L2_PIX_FMT_P010_4L4,
> +		.codec_mode = HANTRO_MODE_NONE,
> +		.match_depth = true,
>  		.frmsize = {
>  			.min_width = FMT_MIN_WIDTH,
>  			.max_width = FMT_UHD_WIDTH,
> -- 
> 2.36.1
> 
