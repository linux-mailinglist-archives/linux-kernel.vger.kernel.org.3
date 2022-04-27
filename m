Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B19512200
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbiD0TFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbiD0TDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:03:30 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3491113;
        Wed, 27 Apr 2022 11:50:14 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id kq17so5202263ejb.4;
        Wed, 27 Apr 2022 11:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D9r0h1m2vNnq39XzwLF8H3AjdnE9ECGsJT/LxPF6Djc=;
        b=Hr2nxqWb+dWmu2gue0be4PA5VozC92i9QKWr0B1EuHb+1byxvxk06zLICmQpncB93A
         pZiZ2qj+UYl/dj5/frfi5nznQVfb7LqlY7f0kS+jhUp72MgJVNTWjMGsOippShvP3/46
         UztM8QZBxGs0azBztCU+LZBx7lAuE+Ls5hB9LmFVZdlHzvrCQwXPeqCVUxlKB3iKo7K8
         o/QSJuMQt8xp/YXLyhCIUG0SmJKtFqAiYj+bgEfdOPhrBMK2tw86Hy+DoxGBik92tkLS
         6mCMe2wY7S0fkBnaoIhCwIZLXiDru7hmV877xGl6+t1i2dd4hwfgifgIt4P5zp6XViug
         s8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D9r0h1m2vNnq39XzwLF8H3AjdnE9ECGsJT/LxPF6Djc=;
        b=JbUblSmYd4NlAWJWA5DiDYwA59FoOPl0FGJO8VK8iWaRlWK5n6Yvph5GLPWbiSI3ek
         PniYws5o60vIcaOtued/3R+oh63aq6hBU+LjYGAr9fD3wddn5Zlc1z3OKFbBO8mUgW67
         0EZ58KzJN1oyCHdPeVDSvj7sDt1l7Hu63sRZMEPPd40QJyY82BHFyhm7SH1Linj+75t3
         GX3fba1lmJxskIvtA3FVMkhFwTwAcQn6i9OCaTtEhOmqDRrCcreYGd82wSf+5p0Uale6
         OeodSbph989/7U0xm3qGpJyBrUO9r422DhQpTYFJq3Lq+fQ+NStOCVb11Ydg9Uk82X6s
         wxCw==
X-Gm-Message-State: AOAM533/UpFeX4WIkIYwu80NgO90k+U+Aa3Z76dimDvW21Fbc5+d9gW/
        uMNkY32c9avNF+uwkfOcf0C+HTIxBPJyww==
X-Google-Smtp-Source: ABdhPJz+brgVBqm9C/gglS6f/N2+uM4+55+5HUDLgxqlAU/cS9RI56zbJCvFv5hb3txjLfdOvvaOug==
X-Received: by 2002:a17:907:6e07:b0:6f3:c01b:4890 with SMTP id sd7-20020a1709076e0700b006f3c01b4890mr5774743ejc.678.1651085412875;
        Wed, 27 Apr 2022 11:50:12 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id bl20-20020a170906c25400b006efeef97b1esm7046602ejb.206.2022.04.27.11.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 11:50:12 -0700 (PDT)
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
Subject: Re: [PATCH v4 13/45] media: sun6i-csi: Introduce and use video helper functions
Date:   Wed, 27 Apr 2022 20:50:11 +0200
Message-ID: <13001485.uLZWGnKmhe@jernej-laptop>
In-Reply-To: <20220415152811.636419-14-paul.kocialkowski@bootlin.com>
References: <20220415152811.636419-1-paul.kocialkowski@bootlin.com> <20220415152811.636419-14-paul.kocialkowski@bootlin.com>
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

Dne petek, 15. april 2022 ob 17:27:39 CEST je Paul Kocialkowski napisal(a):
> Introduce some helpers for buffer and general video configuration.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  .../platform/sunxi/sun6i-csi/sun6i_video.c    | 46 +++++++++++--------
>  1 file changed, 28 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
> b/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c index
> e6c85fcc65bb..e47eeb27dc4e 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
> @@ -92,6 +92,29 @@ static bool sun6i_video_format_check(u32 format)
>  	return false;
>  }
> 
> +/* Video */
> +
> +static void sun6i_video_buffer_configure(struct sun6i_csi_device *csi_dev,
> +					 struct sun6i_csi_buffer 
*csi_buffer)
> +{
> +	csi_buffer->queued_to_csi = true;
> +	sun6i_csi_update_buf_addr(csi_dev, csi_buffer->dma_addr);
> +}
> +
> +static void sun6i_video_configure(struct sun6i_csi_device *csi_dev)
> +{
> +	struct sun6i_video *video = &csi_dev->video;
> +	struct sun6i_csi_config config = { 0 };
> +
> +	config.pixelformat = video->format.fmt.pix.pixelformat;
> +	config.code = video->mbus_code;
> +	config.field = video->format.fmt.pix.field;
> +	config.width = video->format.fmt.pix.width;
> +	config.height = video->format.fmt.pix.height;
> +
> +	sun6i_csi_update_config(csi_dev, &config);
> +}
> +
>  /* Queue */
> 
>  static int sun6i_video_queue_setup(struct vb2_queue *queue,
> @@ -160,7 +183,6 @@ static int sun6i_video_start_streaming(struct vb2_queue
> *queue, struct video_device *video_dev = &video->video_dev;
>  	struct sun6i_csi_buffer *buf;
>  	struct sun6i_csi_buffer *next_buf;
> -	struct sun6i_csi_config config;
>  	struct v4l2_subdev *subdev;
>  	unsigned long flags;
>  	int ret;
> @@ -182,22 +204,13 @@ static int sun6i_video_start_streaming(struct
> vb2_queue *queue, goto error_media_pipeline;
>  	}
> 
> -	config.pixelformat = video->format.fmt.pix.pixelformat;
> -	config.code = video->mbus_code;
> -	config.field = video->format.fmt.pix.field;
> -	config.width = video->format.fmt.pix.width;
> -	config.height = video->format.fmt.pix.height;
> -
> -	ret = sun6i_csi_update_config(csi_dev, &config);
> -	if (ret < 0)
> -		goto error_media_pipeline;
> +	sun6i_video_configure(csi_dev);

What happened to that error handling? New helper function ignores return value 
of sun6i_csi_update_config(). Why?

Best regards,
Jernej

> 
>  	spin_lock_irqsave(&video->dma_queue_lock, flags);
> 
>  	buf = list_first_entry(&video->dma_queue,
>  			       struct sun6i_csi_buffer, list);
> -	buf->queued_to_csi = true;
> -	sun6i_csi_update_buf_addr(csi_dev, buf->dma_addr);
> +	sun6i_video_buffer_configure(csi_dev, buf);
> 
>  	sun6i_csi_set_stream(csi_dev, true);
> 
> @@ -219,8 +232,7 @@ static int sun6i_video_start_streaming(struct vb2_queue
> *queue, * would also drop frame when lacking of queued buffer.
>  	 */
>  	next_buf = list_next_entry(buf, list);
> -	next_buf->queued_to_csi = true;
> -	sun6i_csi_update_buf_addr(csi_dev, next_buf->dma_addr);
> +	sun6i_video_buffer_configure(csi_dev, next_buf);
> 
>  	spin_unlock_irqrestore(&video->dma_queue_lock, flags);
> 
> @@ -294,8 +306,7 @@ void sun6i_video_frame_done(struct sun6i_csi_device
> *csi_dev) * for next ISR call.
>  	 */
>  	if (!next_buf->queued_to_csi) {
> -		next_buf->queued_to_csi = true;
> -		sun6i_csi_update_buf_addr(csi_dev, next_buf->dma_addr);
> +		sun6i_video_buffer_configure(csi_dev, next_buf);
>  		dev_dbg(csi_dev->dev, "Frame dropped!\n");
>  		goto complete;
>  	}
> @@ -309,8 +320,7 @@ void sun6i_video_frame_done(struct sun6i_csi_device
> *csi_dev) /* Prepare buffer for next frame but one.  */
>  	if (!list_is_last(&next_buf->list, &video->dma_queue)) {
>  		next_buf = list_next_entry(next_buf, list);
> -		next_buf->queued_to_csi = true;
> -		sun6i_csi_update_buf_addr(csi_dev, next_buf->dma_addr);
> +		sun6i_video_buffer_configure(csi_dev, next_buf);
>  	} else {
>  		dev_dbg(csi_dev->dev, "Next frame will be dropped!\n");
>  	}




