Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDFE512277
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbiD0TVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234000AbiD0TVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:21:36 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604EF9AE6D;
        Wed, 27 Apr 2022 12:16:20 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id p18so3061056edr.7;
        Wed, 27 Apr 2022 12:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hLJNnGvrtFAOmeWj5ZA0YmApkwdPTHpKx7WHp64IaXc=;
        b=BoaCeMQf2eJz88iZi8aPpusPSKfMdOwUxqV+E7OG7lHaoEa8LCQRN73oHJYeY4aSB2
         VGeJHCUzQVNLlNLTt+8QM9NlL4GOlzEZP8HH265LD/MVHCmGrcZNii5fb+RWwVKeJZG9
         CxyfyJZLMZ92m2h7eTIYr2aJBqp0X3RR+b95kGQks5dIQaFw3ClbFFUbQcJBcxPDJkgK
         0MFA2S2N3hNwUK0wqQfIFowWTMZL+aJ0qMonkt5RFCrywZASeZ5WEAVLZpAYBlAGg/c8
         Kmiy4YI211AbCaRxK6fx1V4vP9MqC+Z8sz0RFHfoilS0JWq58Nv5IubOlF53A9cTT2dD
         ccDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hLJNnGvrtFAOmeWj5ZA0YmApkwdPTHpKx7WHp64IaXc=;
        b=TkiFdNnlP9Iag4pr7ENVdssCGHZkf93GHIjftEGdt9D1aA91SNPvYhBmPUChFtjvsC
         f/eLs3cz5Ary/tW3oDoLC2Ht/3QTQVrkKWsZFPiR+q3+HUjEopgEGNhWnZH/kkocMYJm
         jdZROCL46chdo5o5h1G+NE19r5jXj03maYqtdVFl0/wHi15ydH7tDzHCQFJpsKNWJKDt
         jbnQWKWj7KYB2K4G5Pb7Z+qiC3/DJOFiDDXALsGEIdlLifKrYEL76qvY9Z0oNTf9rieI
         3yT2tmKrraMFRq4uW4AoF7N8CIvRFiXgeiREjGuf2jTQrBQ741+wIP2XwJpzGAJXGUGc
         u/MA==
X-Gm-Message-State: AOAM531M3+j3Yg0FlgcQmIdVGWxUxgig5Kw75zFb4/r8vQWRpvhq25JP
        hfMpDvLZU/fJawfJbWKFqlY3dk0TsKJRIA==
X-Google-Smtp-Source: ABdhPJxqRqhCCImvZlg7ccRWir1+Asr7VdaNmzUyAraKohzOQR2qiTN2ZHRF78lYLEWMpStyZQGOPQ==
X-Received: by 2002:aa7:c70f:0:b0:425:f70d:b34 with SMTP id i15-20020aa7c70f000000b00425f70d0b34mr13637098edq.306.1651086978704;
        Wed, 27 Apr 2022 12:16:18 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id r2-20020aa7c142000000b0042617ba63c5sm58674edp.79.2022.04.27.12.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 12:16:18 -0700 (PDT)
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
Subject: Re: [PATCH v4 21/45] media: sun6i-csi: Implement address configuration without indirection
Date:   Wed, 27 Apr 2022 21:16:17 +0200
Message-ID: <21443501.EfDdHjke4D@jernej-laptop>
In-Reply-To: <20220415152811.636419-22-paul.kocialkowski@bootlin.com>
References: <20220415152811.636419-1-paul.kocialkowski@bootlin.com> <20220415152811.636419-22-paul.kocialkowski@bootlin.com>
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

Dne petek, 15. april 2022 ob 17:27:47 CEST je Paul Kocialkowski napisal(a):
> Instead of calculating the planar_offset at one point and using it
> later in a dedicated function, reimplement address configuration
> with v4l2 format info in the buffer_configure function.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 27 ----------------
>  .../platform/sunxi/sun6i-csi/sun6i_csi.h      | 10 ------
>  .../sunxi/sun6i-csi/sun6i_csi_capture.c       | 32 ++++++++++++++++++-
>  3 files changed, 31 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c index
> c7b53e8099d3..98133c1dbf68 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> @@ -463,7 +463,6 @@ static void sun6i_csi_set_window(struct sun6i_csi_device
> *csi_dev) struct sun6i_csi_config *config = &csi_dev->config;
>  	u32 bytesperline_y;
>  	u32 bytesperline_c;
> -	int *planar_offset = csi_dev->planar_offset;
>  	u32 width = config->width;
>  	u32 height = config->height;
>  	u32 hor_len = width;
> @@ -488,7 +487,6 @@ static void sun6i_csi_set_window(struct sun6i_csi_device
> *csi_dev) SUN6I_CSI_CH_VSIZE_LEN(height) |
>  		     SUN6I_CSI_CH_VSIZE_START(0));
> 
> -	planar_offset[0] = 0;
>  	switch (config->pixelformat) {
>  	case V4L2_PIX_FMT_NV12_16L16:
>  	case V4L2_PIX_FMT_NV12:
> @@ -497,23 +495,15 @@ static void sun6i_csi_set_window(struct
> sun6i_csi_device *csi_dev) case V4L2_PIX_FMT_NV61:
>  		bytesperline_y = width;
>  		bytesperline_c = width;
> -		planar_offset[1] = bytesperline_y * height;
> -		planar_offset[2] = -1;
>  		break;
>  	case V4L2_PIX_FMT_YUV420:
>  	case V4L2_PIX_FMT_YVU420:
>  		bytesperline_y = width;
>  		bytesperline_c = width / 2;
> -		planar_offset[1] = bytesperline_y * height;
> -		planar_offset[2] = planar_offset[1] +
> -				bytesperline_c * height / 2;
>  		break;
>  	case V4L2_PIX_FMT_YUV422P:
>  		bytesperline_y = width;
>  		bytesperline_c = width / 2;
> -		planar_offset[1] = bytesperline_y * height;
> -		planar_offset[2] = planar_offset[1] +
> -				bytesperline_c * height;
>  		break;
>  	default: /* raw */
>  		dev_dbg(csi_dev->dev,
> @@ -522,8 +512,6 @@ static void sun6i_csi_set_window(struct sun6i_csi_device
> *csi_dev) bytesperline_y = (sun6i_csi_get_bpp(config->pixelformat) *
>  				  config->width) / 8;
>  		bytesperline_c = 0;
> -		planar_offset[1] = -1;
> -		planar_offset[2] = -1;
>  		break;
>  	}
> 
> @@ -547,21 +535,6 @@ int sun6i_csi_update_config(struct sun6i_csi_device
> *csi_dev, return 0;
>  }
> 
> -void sun6i_csi_update_buf_addr(struct sun6i_csi_device *csi_dev,
> -			       dma_addr_t addr)
> -{
> -	regmap_write(csi_dev->regmap, SUN6I_CSI_CH_FIFO0_ADDR_REG,
> -		     SUN6I_CSI_ADDR_VALUE(addr + csi_dev-
>planar_offset[0]));
> -	if (csi_dev->planar_offset[1] != -1)
> -		regmap_write(csi_dev->regmap, 
SUN6I_CSI_CH_FIFO1_ADDR_REG,
> -			     SUN6I_CSI_ADDR_VALUE(addr +
> -						  csi_dev-
>planar_offset[1]));
> -	if (csi_dev->planar_offset[2] != -1)
> -		regmap_write(csi_dev->regmap, 
SUN6I_CSI_CH_FIFO2_ADDR_REG,
> -			     SUN6I_CSI_ADDR_VALUE(addr +
> -						  csi_dev-
>planar_offset[2]));
> -}
> -
>  void sun6i_csi_set_stream(struct sun6i_csi_device *csi_dev, bool enable)
>  {
>  	struct regmap *regmap = csi_dev->regmap;
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
> b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h index
> f02656dbfd84..44fc4d486877 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
> @@ -62,8 +62,6 @@ struct sun6i_csi_device {
>  	struct clk			*clock_mod;
>  	struct clk			*clock_ram;
>  	struct reset_control		*reset;
> -
> -	int				planar_offset[3];
>  };
> 
>  struct sun6i_csi_variant {
> @@ -94,14 +92,6 @@ int sun6i_csi_set_power(struct sun6i_csi_device *csi_dev,
> bool enable); int sun6i_csi_update_config(struct sun6i_csi_device *csi_dev,
>  			    struct sun6i_csi_config *config);
> 
> -/**
> - * sun6i_csi_update_buf_addr() - update the csi frame buffer address
> - * @csi:	pointer to the csi
> - * @addr:	frame buffer's physical address
> - */
> -void sun6i_csi_update_buf_addr(struct sun6i_csi_device *csi_dev,
> -			       dma_addr_t addr);
> -
>  /**
>   * sun6i_csi_set_stream() - start/stop csi streaming
>   * @csi:	pointer to the csi
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
> b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c index
> acbd0ea62fd5..7788cbab7810 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
> @@ -6,6 +6,7 @@
>   */
> 
>  #include <linux/of.h>
> +#include <linux/regmap.h>
> 
>  #include <media/v4l2-device.h>
>  #include <media/v4l2-event.h>
> @@ -16,6 +17,7 @@
> 
>  #include "sun6i_csi.h"
>  #include "sun6i_csi_capture.h"
> +#include "sun6i_csi_reg.h"
> 
>  /* This is got from BSP sources. */
>  #define MIN_WIDTH	(32)
> @@ -109,13 +111,41 @@ static void
>  sun6i_csi_capture_buffer_configure(struct sun6i_csi_device *csi_dev,
>  				   struct sun6i_csi_buffer 
*csi_buffer)
>  {
> +	struct regmap *regmap = csi_dev->regmap;
> +	const struct v4l2_format_info *info;
>  	struct vb2_buffer *vb2_buffer;
> +	unsigned int width, height;
>  	dma_addr_t address;
> +	u32 pixelformat;
> 
>  	vb2_buffer = &csi_buffer->v4l2_buffer.vb2_buf;
>  	address = vb2_dma_contig_plane_dma_addr(vb2_buffer, 0);
> 
> -	sun6i_csi_update_buf_addr(csi_dev, address);
> +	regmap_write(regmap, SUN6I_CSI_CH_FIFO0_ADDR_REG,
> +		     SUN6I_CSI_ADDR_VALUE(address));
> +
> +	sun6i_csi_capture_dimensions(csi_dev, &width, &height);
> +	sun6i_csi_capture_format(csi_dev, &pixelformat, NULL);
> +
> +	info = v4l2_format_info(pixelformat);
> +	/* Unsupported formats are single-plane, so we can stop here. */
> +	if (!info)
> +		return;
> +
> +	if (info->comp_planes > 1) {
> +		address += info->bpp[0] * width * height;
> +
> +		regmap_write(regmap, SUN6I_CSI_CH_FIFO1_ADDR_REG,
> +			     SUN6I_CSI_ADDR_VALUE(address));
> +	}
> +
> +	if (info->comp_planes > 2) {
> +		address += info->bpp[1] * DIV_ROUND_UP(width, info-
>hdiv) *
> +			   DIV_ROUND_UP(height, info->vdiv);
> +
> +		regmap_write(regmap, SUN6I_CSI_CH_FIFO2_ADDR_REG,
> +			     SUN6I_CSI_ADDR_VALUE(address));
> +	}
>  }
> 
>  static void sun6i_csi_capture_configure(struct sun6i_csi_device *csi_dev)




