Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D25759BE8E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 13:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234566AbiHVLaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 07:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234422AbiHVLaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 07:30:06 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B933335F
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 04:30:05 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id z20so13404725edb.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 04:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=Xlmus60sqK8GeXhd6q9NENg7b74le0wdQoVj4za8BkE=;
        b=W22n9DZSOQzBWhxvg9uaQDvwGdkLpDtbnuKeDZPqUgw1psI7Bh8DAmds/AcK6rHLnf
         UK85rgUvcGXYBYry65MhhQJUoQdLB/1cWhdtbv/KbbSYSTArEdTsFyNFjH2ccnovAEpk
         y9PAd9CuVI3aGPW5LKD+7J4HGaSopRqQxIN5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Xlmus60sqK8GeXhd6q9NENg7b74le0wdQoVj4za8BkE=;
        b=FqGAys4WjX8moEmeG1vLICYwZ6ATrgGgbD8dMXufAEzX2Jys8wFjO75uMRuiMtnNwA
         RaCq55tXOKzTeqpJ337orB/YVn34WKC8p1is66YP/rVAn/c+dDfj4iWXylXn+AZy2FiY
         JGE5bDaeqM9RK561F9izaYpijo1FIM2f1JPDi3cIETlKstCfMaVJiMgkmJ1qagpMIpJ0
         g1SeBrpvqkbmoF98MmOZXBOi36ZvuEDYCey1Vt1n2OAJ8kBkd411ns0r3xvGvxbBDaAx
         67Ul7iZtrM+HZRvLAmky2heCelJiapxaYUzHbnImrDoJIDXfuZAmCxBHcODKx7jSR6Ln
         N7pA==
X-Gm-Message-State: ACgBeo3NiyYQ6iz1oskhH69kHgLKRg67YGu0t0kXgxLO0VdW+nYJVaGI
        J3u55q5/mqIoXyx1cZIMqe5rbg==
X-Google-Smtp-Source: AA6agR4Dk6XIdvRO93LKvp6U+BMj/bECACWyCvfC/JBkAJHvokftn0ynCiHWPGR5yQE+8KJcyZyfaA==
X-Received: by 2002:a05:6402:c45:b0:442:c549:8e6b with SMTP id cs5-20020a0564020c4500b00442c5498e6bmr15765394edb.123.1661167804008;
        Mon, 22 Aug 2022 04:30:04 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i (net-188-217-57-252.cust.vodafonedsl.it. [188.217.57.252])
        by smtp.gmail.com with ESMTPSA id kz13-20020a17090777cd00b0073d6234ceebsm3475065ejc.160.2022.08.22.04.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 04:30:03 -0700 (PDT)
Date:   Mon, 22 Aug 2022 13:30:01 +0200
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     Ming Qian <ming.qian@nxp.com>
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl, shawnguo@kernel.org,
        robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, xiahong.bao@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 3/4] media: amphion: decoder add support for
 contiguous planes
Message-ID: <20220822113001.GB17530@tom-ThinkPad-T14s-Gen-2i>
References: <cover.1660027440.git.ming.qian@nxp.com>
 <c55f85d694cf6cd29fbd072b9246dda296ca6639.1660027440.git.ming.qian@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c55f85d694cf6cd29fbd072b9246dda296ca6639.1660027440.git.ming.qian@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming,

On Tue, Aug 09, 2022 at 02:50:40PM +0800, Ming Qian wrote:
> decoder add support for contiguous formats
> V4L2_PIX_FMT_NV12_8L128 and V4L2_PIX_FMT_NV12_10BE_8L128
> 
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> ---
>  drivers/media/platform/amphion/vdec.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/media/platform/amphion/vdec.c b/drivers/media/platform/amphion/vdec.c
> index 48ab664fa7ef..9c3324717cbc 100644
> --- a/drivers/media/platform/amphion/vdec.c
> +++ b/drivers/media/platform/amphion/vdec.c
> @@ -72,12 +72,28 @@ static const struct vpu_format vdec_formats[] = {
>  		.mem_planes = 2,
>  		.comp_planes = 2,
>  		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
> +		.sibling = V4L2_PIX_FMT_NV12_8L128,
> +	},
> +	{
> +		.pixfmt = V4L2_PIX_FMT_NV12_8L128,
> +		.mem_planes = 1,
> +		.comp_planes = 2,
> +		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
> +		.sibling = V4L2_PIX_FMT_NV12M_8L128,
>  	},
>  	{
>  		.pixfmt = V4L2_PIX_FMT_NV12M_10BE_8L128,
>  		.mem_planes = 2,
>  		.comp_planes = 2,
>  		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
> +		.sibling = V4L2_PIX_FMT_NV12_10BE_8L128,
> +	},
> +	{
> +		.pixfmt = V4L2_PIX_FMT_NV12_10BE_8L128,
> +		.mem_planes = 1,
> +		.comp_planes = 2,
> +		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
> +		.sibling = V4L2_PIX_FMT_NV12M_10BE_8L128
>  	},
>  	{
>  		.pixfmt = V4L2_PIX_FMT_H264,
> -- 
> 2.37.1
> 

Looks good to me. 

Unfortunately I don't have hw for testing more.
I tried to build and reviewed the code seems ok for me.

Reviewed-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>

Tommaso

-- 
Tommaso Merciai
Embedded Linux Engineer
tommaso.merciai@amarulasolutions.com
__________________________________

Amarula Solutions SRL
Via Le Canevare 30, 31100 Treviso, Veneto, IT
T. +39 042 243 5310
info@amarulasolutions.com
www.amarulasolutions.com
