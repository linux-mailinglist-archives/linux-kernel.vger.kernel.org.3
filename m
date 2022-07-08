Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4EDB56BF79
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238567AbiGHR0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 13:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238416AbiGHRZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 13:25:58 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F18564DB
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 10:25:57 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id t21so8395121uaq.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 10:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LOtwgN5wfPmZzYIw0Tlyqvkp9Ve1x2H9JUuVegr7ZSQ=;
        b=yzZgbP7McDtAqwstq36PYiHbvJeGkx2Qiw9pxIaitlI8T1j7i1MGFPYMT9/8FvjI+s
         5Xikx5aO9HebE9iI50qdiSONNEaQ8ppm6USn3FpoGDLgVsiWFdouVs7VXNAwfZrmROWx
         Occg/C4yaQDinMWgWK337atLIytOm5fw0BUf8id6plKjZ8jQv5D0CDeBO89l5GNYzxbc
         yeUrU+Iw5ZSZMTRGHYSXPZ5qetUWnpmJ3Lo9lkgkOt4qa6rKnV482EFGilijZRmsIN7A
         JTkktrQ3WwbXLc1a/wp3ZJ1NqEc4FntJHMt3MWnAbU1i6tgOChOjDLR/Dg0r/Jv+5UWO
         L4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LOtwgN5wfPmZzYIw0Tlyqvkp9Ve1x2H9JUuVegr7ZSQ=;
        b=TJxXTg1VUsJmW/QCA13XCXVO+Zc+5z/XFLIC5npXDgC2ekr1KYqulnTck9wCmq8zTf
         NNQGIxD9kd0PMH7HlZxpBw5W2emkrrneGJvymt3hZvKgtz4OQpVtzt5ntbJccE3vgg1M
         VcRHxwC81PRrKu88SdUKobYfUp1ieH2v/TEeSLSafmPNphnfUET+Shx7evcrgNsggoXk
         9u1M54FsKx7okRgj5M6jnWOlHe5voka0V5xpLy3Am3Mgrq4udIpo7Sh3Os2J9deMByUu
         lCoY3kXl/9rs2TdiniltrZdBjMY+NM1TZ0+NR7Zg0y6V4afW961k9PFt+qW6hEE9OHvi
         gpJg==
X-Gm-Message-State: AJIora82iotvMuKobz1Z+6CLLTFkFBC7lTIRUdvw6LztEjj0DM3vPzUF
        dQ/cEtqRaqcbkgCKohWNJm8atg==
X-Google-Smtp-Source: AGRyM1upmaMJbd45XOLfgkaVrGND1BM38x3w4DVtZSkLTkm5yvEt/soB8HFT/X7s4kiOuP6NNF68MQ==
X-Received: by 2002:ab0:28d6:0:b0:382:e35f:eca1 with SMTP id g22-20020ab028d6000000b00382e35feca1mr2079496uaq.22.1657301156509;
        Fri, 08 Jul 2022 10:25:56 -0700 (PDT)
Received: from eze-laptop ([190.190.187.68])
        by smtp.gmail.com with ESMTPSA id g80-20020a1f9d53000000b003651e2fb90asm12674801vke.26.2022.07.08.10.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 10:25:56 -0700 (PDT)
Date:   Fri, 8 Jul 2022 14:25:50 -0300
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
Subject: Re: [PATCH v13 09/17] media: uapi: HEVC: Define
 V4L2_CID_STATELESS_HEVC_SLICE_PARAMS as a dynamic array
Message-ID: <Yshonnx0l3OMooV0@eze-laptop>
References: <20220708162156.815772-1-benjamin.gaignard@collabora.com>
 <20220708162156.815772-10-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708162156.815772-10-benjamin.gaignard@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 06:21:48PM +0200, Benjamin Gaignard wrote:
> Make explicit that V4L2_CID_STATELESS_HEVC_SLICE_PARAMS control is
> a dynamic array control type.
> Some drivers may be able to receive multiple slices in one control
> to improve decoding performance.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

> ---
>  Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst | 2 ++
>  drivers/media/v4l2-core/v4l2-ctrls-defs.c                 | 1 +
>  drivers/staging/media/sunxi/cedrus/cedrus.c               | 2 ++
>  include/media/hevc-ctrls.h                                | 3 +++
>  4 files changed, 8 insertions(+)
> 
> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> index e88b5e6944a6..c2e0adece613 100644
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
