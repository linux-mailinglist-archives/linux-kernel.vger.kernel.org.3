Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6498D51232D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235033AbiD0T7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235004AbiD0T73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:59:29 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116817C241;
        Wed, 27 Apr 2022 12:56:16 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id g6so5529505ejw.1;
        Wed, 27 Apr 2022 12:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gN8k3J6+AGfSC2A7B7atA6Q9/iYE5AGZYgSUrC71usY=;
        b=qWY+3h03mBlDupRslwfWJEbNre4v4Imvr+HAsd8iu8Lz7mCdqSbRjs879rk2cKmXyG
         VHS6yMhdHjR22YTahPkcx5Cz/R5uwqbJ1j5Ay2CmaNG+QRPuzMQ1/wxsx4sTT11x0fc3
         34PR/Ko5PBHMNgkXj1el1G+vXljPQig/2GuJFyXYhSzlKJJ61nWyOuP2FrRWolOvtPjN
         FsSPZMHci/Xb0qGq53VS07oUXGf9Fa7l+ulfcZg10LI+LMZidSbEEm2YE5b3fUCwHdgj
         1QkbFuIJVmAbpb4M8UA/Pf5nxAgowDaox8AVI4mNzjThaaS7XAGbSizCBMUcG6WBOrfL
         56iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gN8k3J6+AGfSC2A7B7atA6Q9/iYE5AGZYgSUrC71usY=;
        b=CzL+2y4Mf9KQJ+sRNDnBUWSX7bK2XwdT+OCcSUpzRjcapxWmTxzPh4qbljFHAm3SM8
         0KifPSAjIffzAG4OQOS8EHT1okp/iKfg71v2Gi0MVDHPEqcd7OIC9Q6KnEgmz3zQI12N
         2VPcCBIOl0ORKe+pOpxnswEluM37Ej0sEBpBkv5Dggv+7vOMqpkU4usEvSlX/hDyatam
         Fy+jRKRp75Du4UFTYz5jNulU8gqVHvNkNYD/OwMZRabzQF2ge+cloa6TlVi9HcJoT5eN
         IAfYkGMiYSZ/Lnr6wzGEH0KujWZ5ua84ZdNrGZA1jgQs+lXFHFgN81xNc8unKRv56cUR
         Pa+g==
X-Gm-Message-State: AOAM5311YTHK+0NEqMDKh6SPY4zn+iiSMYAxwUQ2FJVwcLWpyNwkFxSy
        XQ32Yl9igvTenUqrR5gQfUH+oCDwxuS6Dg==
X-Google-Smtp-Source: ABdhPJyCPXTb5y7iPw9tQJA+FXZ2nVg/JfmRJ9zQ5u03LENIFoVSoPO7Qm9e1pfaJ0RdEW9pMcYDqA==
X-Received: by 2002:a17:907:7745:b0:6f3:674a:339 with SMTP id kx5-20020a170907774500b006f3674a0339mr24570539ejc.207.1651089375400;
        Wed, 27 Apr 2022 12:56:15 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id f5-20020a17090624c500b006cee6661b6esm7187032ejb.10.2022.04.27.12.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 12:56:14 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Yong Deng <yong.deng@magewell.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 40/45] media: sun6i-csi: Only configure capture when streaming
Date:   Wed, 27 Apr 2022 21:56:13 +0200
Message-ID: <4415490.cEBGB3zze1@jernej-laptop>
In-Reply-To: <20220415152811.636419-41-paul.kocialkowski@bootlin.com>
References: <20220415152811.636419-1-paul.kocialkowski@bootlin.com> <20220415152811.636419-41-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 15. april 2022 ob 17:28:06 CEST je Paul Kocialkowski napisal(a):
> Add a streaming element to the capture state structure to know if the
> capture device is used or not. Only configure things related to output
> when streaming, including the output format, irq, state (dma buffer)
> and window configuration registers.
> 
> After this change, it becomes possible to use the bridge without the
> capture device, which will be the case in the isp media flow.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  .../sunxi/sun6i-csi/sun6i_csi_bridge.c        | 50 ++++++++++++-------
>  .../sunxi/sun6i-csi/sun6i_csi_capture.c       | 11 +++-
>  .../sunxi/sun6i-csi/sun6i_csi_capture.h       |  1 +
>  3 files changed, 41 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
> b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c index
> 27289d904d5c..8e9eded0df28 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
> @@ -338,6 +338,7 @@ sun6i_csi_bridge_configure_mipi_csi2(struct
> sun6i_csi_device *csi_dev) static void
> sun6i_csi_bridge_configure_format(struct sun6i_csi_device *csi_dev) {
>  	struct regmap *regmap = csi_dev->regmap;
> +	bool capture_streaming = csi_dev->capture.state.streaming;
>  	const struct sun6i_csi_bridge_format *bridge_format;
>  	const struct sun6i_csi_capture_format *capture_format;
>  	u32 mbus_code, field, pixelformat;
> @@ -353,26 +354,29 @@ static void sun6i_csi_bridge_configure_format(struct
> sun6i_csi_device *csi_dev) input_format = bridge_format->input_format;
>  	input_yuv_seq = bridge_format->input_yuv_seq;
> 
> -	sun6i_csi_capture_format(csi_dev, &pixelformat, NULL);
> +	if (capture_streaming) {
> +		sun6i_csi_capture_format(csi_dev, &pixelformat, NULL);
> 
> -	capture_format = sun6i_csi_capture_format_find(pixelformat);
> -	if (WARN_ON(!capture_format))
> -		return;
> +		capture_format = 
sun6i_csi_capture_format_find(pixelformat);
> +		if (WARN_ON(!capture_format))
> +			return;
> 
> -	if (capture_format->input_format_raw)
> -		input_format = SUN6I_CSI_INPUT_FMT_RAW;
> +		if (capture_format->input_format_raw)
> +			input_format = SUN6I_CSI_INPUT_FMT_RAW;
> 
> -	if (capture_format->input_yuv_seq_invert)
> -		input_yuv_seq = bridge_format->input_yuv_seq_invert;
> +		if (capture_format->input_yuv_seq_invert)
> +			input_yuv_seq = bridge_format-
>input_yuv_seq_invert;
> 
> -	if (field == V4L2_FIELD_INTERLACED ||
> -	    field == V4L2_FIELD_INTERLACED_TB ||
> -	    field == V4L2_FIELD_INTERLACED_BT)
> -		output_format = capture_format->output_format_field;
> -	else
> -		output_format = capture_format->output_format_frame;
> +		if (field == V4L2_FIELD_INTERLACED ||
> +		    field == V4L2_FIELD_INTERLACED_TB ||
> +		    field == V4L2_FIELD_INTERLACED_BT)
> +			output_format = capture_format-
>output_format_field;
> +		else
> +			output_format = capture_format-
>output_format_frame;
> +
> +		value |= SUN6I_CSI_CH_CFG_OUTPUT_FMT(output_format);
> +	}
> 
> -	value |= SUN6I_CSI_CH_CFG_OUTPUT_FMT(output_format);
>  	value |= SUN6I_CSI_CH_CFG_INPUT_FMT(input_format);
>  	value |= SUN6I_CSI_CH_CFG_INPUT_YUV_SEQ(input_yuv_seq);
> 
> @@ -406,6 +410,7 @@ static int sun6i_csi_bridge_s_stream(struct v4l2_subdev
> *subdev, int on) struct sun6i_csi_device *csi_dev =
> v4l2_get_subdevdata(subdev);
>  	struct sun6i_csi_bridge *bridge = &csi_dev->bridge;
>  	struct media_entity *bridge_entity = &bridge->subdev.entity;
> +	bool capture_streaming = csi_dev->capture.state.streaming;
>  	struct device *dev = csi_dev->dev;
>  	struct sun6i_csi_bridge_source *source;
>  	struct v4l2_subdev *source_subdev;
> @@ -448,15 +453,20 @@ static int sun6i_csi_bridge_s_stream(struct
> v4l2_subdev *subdev, int on) /* Configure */
> 
>  	sun6i_csi_bridge_configure(csi_dev, source);
> -	sun6i_csi_capture_configure(csi_dev);
> +
> +	if (capture_streaming)
> +		sun6i_csi_capture_configure(csi_dev);
> 
>  	/* State Update */
> 
> -	sun6i_csi_capture_state_update(csi_dev);
> +	if (capture_streaming)
> +		sun6i_csi_capture_state_update(csi_dev);
> 
>  	/* Enable */
> 
> -	sun6i_csi_bridge_irq_enable(csi_dev);
> +	if (capture_streaming)
> +		sun6i_csi_bridge_irq_enable(csi_dev);
> +
>  	sun6i_csi_bridge_enable(csi_dev);
> 
>  	ret = v4l2_subdev_call(source_subdev, video, s_stream, 1);
> @@ -466,7 +476,9 @@ static int sun6i_csi_bridge_s_stream(struct v4l2_subdev
> *subdev, int on) return 0;
> 
>  disable:
> -	sun6i_csi_bridge_irq_disable(csi_dev);
> +	if (capture_streaming)
> +		sun6i_csi_bridge_irq_disable(csi_dev);
> +
>  	sun6i_csi_bridge_disable(csi_dev);
> 
>  	pm_runtime_put(dev);
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
> b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c index
> f1581b877819..17145ce53395 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
> @@ -616,13 +616,17 @@ static int sun6i_csi_capture_start_streaming(struct
> vb2_queue *queue, if (ret < 0)
>  		goto error_state;
> 
> +	state->streaming = true;
> +
>  	ret = v4l2_subdev_call(subdev, video, s_stream, 1);
>  	if (ret && ret != -ENOIOCTLCMD)
> -		goto error_media_pipeline;
> +		goto error_streaming;
> 
>  	return 0;
> 
> -error_media_pipeline:
> +error_streaming:
> +	state->streaming = false;
> +
>  	media_pipeline_stop(&video_dev->entity);
> 
>  error_state:
> @@ -634,11 +638,14 @@ static int sun6i_csi_capture_start_streaming(struct
> vb2_queue *queue, static void sun6i_csi_capture_stop_streaming(struct
> vb2_queue *queue) {
>  	struct sun6i_csi_device *csi_dev = vb2_get_drv_priv(queue);
> +	struct sun6i_csi_capture_state *state = &csi_dev->capture.state;
>  	struct video_device *video_dev = &csi_dev->capture.video_dev;
>  	struct v4l2_subdev *subdev = &csi_dev->bridge.subdev;
> 
>  	v4l2_subdev_call(subdev, video, s_stream, 0);
> 
> +	state->streaming = false;
> +
>  	media_pipeline_stop(&video_dev->entity);
> 
>  	sun6i_csi_capture_state_cleanup(csi_dev, true);
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
> b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h index
> ceceb030aef6..29893cf96f6b 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
> @@ -44,6 +44,7 @@ struct sun6i_csi_capture_state {
>  	struct sun6i_csi_buffer		*complete;
> 
>  	unsigned int			sequence;
> +	bool				streaming;
>  };
> 
>  struct sun6i_csi_capture {




