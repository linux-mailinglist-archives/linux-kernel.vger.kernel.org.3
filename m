Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78645672C4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 17:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbiGEPgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 11:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbiGEPgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 11:36:01 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137ED17078
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 08:36:00 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id d187so12238577vsd.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 08:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aBsQ/FqzMQX8oz4i9xIq1hsZFN6R3v8LL4whKtQ9DcQ=;
        b=2LO57y5cBoufIsVy5DZC97R15Htw3dkqeBBo3/uAEHulLpQVqo+gaAgm3X+SYfCJ1A
         i70TNmBzdyaUlahCfEsUjfAnm0Xfa6dOO4K173zAlPzzXRxhdBjPYdTwjr4GR229eA9z
         ZqU48AncYBjYbyMvAW+bT5PHkXrpcmf6ju3dKy84IaSpP/RfQD2JXqqfKlHkyP4gTbLZ
         X6D0Sk0XHTmf/Ht4detKKDypL9zcdnTuK7WAXkoHEfI82BxoobIyxaBDVKlxEPEVjHOY
         vxWS4XAP8xHjAI1ESXsq2rhl8i5UwbC62p25jTYdrfwueV0SbpHHPQscuw/HC2KO/vrl
         wuhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aBsQ/FqzMQX8oz4i9xIq1hsZFN6R3v8LL4whKtQ9DcQ=;
        b=fG16Q4xYGhs3GmD8BD43sTcUT02ynDpcmijNloE3JLITpweFLaG6X40xbGpr78jRui
         yFOFc4OCPLLtQ+UVTjru7Y1tdSsK5cZ+rEc4rMh4Pz8EriaqdUTmfQZ28ygogiyZncoK
         vf5tzJzs6bzH+gAkOK4a/rXV25r88b0dvY6Ci30V9+MDuCIhMk7C3FnEKKt86FfWB8CE
         6LsO6PqXNdXI6dyFx3wozgLxILLmYS9rXNh6SvmTS42C1Lmu0qxvS90M40wCsMKeJyBk
         HrJ/wJEHe5hzEXfFQF1bJBZX8ATIlRHiW7bHTpOVr2vAG8vZge8YV+sfSJA6L09OrBzI
         U19A==
X-Gm-Message-State: AJIora/XtZR0FFUAx+BK3D6wQlLla1gPrtgIZ5NpFk2FzmlhhL+rQKnB
        csp87HtIm6ifr5PczVj1HFnDbw==
X-Google-Smtp-Source: AGRyM1uuuaI3iiwiSQTbd5nuoRILw2C4fjLapUvr6uaXVbv9wRjXrC654OtbXCEwWI/1nI9vnkpqWw==
X-Received: by 2002:a05:6102:3548:b0:354:34a1:e8f1 with SMTP id e8-20020a056102354800b0035434a1e8f1mr19773426vss.53.1657035359158;
        Tue, 05 Jul 2022 08:35:59 -0700 (PDT)
Received: from eze-laptop ([190.190.187.68])
        by smtp.gmail.com with ESMTPSA id g39-20020a05610215a700b003544e1b52cbsm3956388vsv.10.2022.07.05.08.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 08:35:58 -0700 (PDT)
Date:   Tue, 5 Jul 2022 12:35:53 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     mchehab@kernel.org, hverkuil@xs4all.nl, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, mripard@kernel.org,
        paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        nicolas.dufresne@collabora.com, andrzej.p@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com
Subject: Re: [PATCH v10 09/17] media: uapi: HEVC: Define
 V4L2_CID_STATELESS_HEVC_SLICE_PARAMS as a dynamic array
Message-ID: <YsRaWY2lM2270w9g@eze-laptop>
References: <20220705085420.272912-1-benjamin.gaignard@collabora.com>
 <20220705085420.272912-10-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705085420.272912-10-benjamin.gaignard@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 10:54:12AM +0200, Benjamin Gaignard wrote:
> Make explicit that V4L2_CID_STATELESS_HEVC_SLICE_PARAMS control is
> a dynamic array control type.
> Some drivers may be able to receive multiple slices in one control
> to improve decoding performance.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Acked-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> Tested-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

> ---
> version 9:
> - Add comment about current driver dynamic limitation to 1
> - Remove unused define
> 
>  Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst | 2 ++
>  drivers/media/v4l2-core/v4l2-ctrls-defs.c                 | 1 +
>  drivers/staging/media/sunxi/cedrus/cedrus.c               | 2 ++
>  include/media/hevc-ctrls.h                                | 3 +++
>  4 files changed, 8 insertions(+)
> 
> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> index eeb60c9a1af4..db0df7d9f27c 100644
> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> @@ -2986,6 +2986,8 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>      These bitstream parameters are defined according to :ref:`hevc`.
>      They are described in section 7.4.7 "General slice segment header
>      semantics" of the specification.
> +    This control is a dynamically sized 1-dimensional array,
> +    V4L2_CTRL_FLAG_DYNAMIC_ARRAY flag must be set when using it.
>  
>  .. c:type:: v4l2_ctrl_hevc_slice_params
>  
> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> index 9f55503cd3d6..d594efbcbb93 100644
> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> @@ -1510,6 +1510,7 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
>  		break;
>  	case V4L2_CID_STATELESS_HEVC_SLICE_PARAMS:
>  		*type = V4L2_CTRL_TYPE_HEVC_SLICE_PARAMS;
> +		*flags |= V4L2_CTRL_FLAG_DYNAMIC_ARRAY;
>  		break;
>  	case V4L2_CID_STATELESS_HEVC_SCALING_MATRIX:
>  		*type = V4L2_CTRL_TYPE_HEVC_SCALING_MATRIX;
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/staging/media/sunxi/cedrus/cedrus.c
> index 87be975a72b6..b12219123a6b 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
> @@ -178,6 +178,8 @@ static const struct cedrus_control cedrus_controls[] = {
>  	{
>  		.cfg = {
>  			.id	= V4L2_CID_STATELESS_HEVC_SLICE_PARAMS,
> +			/* The driver can only handle 1 entry per slice for now */
> +			.dims   = { 1 },
>  		},
>  		.codec		= CEDRUS_CODEC_H265,
>  	},
> diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
> index 57053cfa099b..341fc795d550 100644
> --- a/include/media/hevc-ctrls.h
> +++ b/include/media/hevc-ctrls.h
> @@ -314,6 +314,9 @@ struct v4l2_hevc_pred_weight_table {
>  /**
>   * struct v4l2_ctrl_hevc_slice_params - HEVC slice parameters
>   *
> + * This control is a dynamically sized 1-dimensional array,
> + * V4L2_CTRL_FLAG_DYNAMIC_ARRAY flag must be set when using it.
> + *
>   * @bit_size: size (in bits) of the current slice data
>   * @data_bit_offset: offset (in bits) to the video data in the current slice data
>   * @nal_unit_type: specifies the coding type of the slice (B, P or I)
> -- 
> 2.32.0
> 
