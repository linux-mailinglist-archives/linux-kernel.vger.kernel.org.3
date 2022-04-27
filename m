Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D18E5123B2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 22:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235999AbiD0UOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 16:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236962AbiD0UOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 16:14:00 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93EB8595E;
        Wed, 27 Apr 2022 13:07:52 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id e23so3195301eda.11;
        Wed, 27 Apr 2022 13:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zThgqL3mT8hxiS3UiF6CFV5UO8qR1fAU3lOSx4ZRa4U=;
        b=VzQPtjPP6w9IcioQK5qHyL21ZDt/OYHqXeYEGBfOcParwj3oZvXHU0JiusvMj244Fl
         upkYSFaQWuqtoHqfYsWBDYkDaDS8R+ctQ1eMQKJcQRQPJRML0Sjfg1SnNXjqT9Tl+LkB
         zD/irUC/mGb8zZ9C8xwaL8VAyTJcOQyAH9DMJoBMeVZmoFfhJvGH6SkRglOsztBAKDsn
         gMscJsEVSP47otuIcxkYShs11xo8r4g1KpP5FXckVHyWY49NIep+oushWvok9YJLv1r5
         wKApvBrV9oeQOGBI6k6eNHh9OYgHlKBqe367yp89BuA5qUQtd78Wh10bVYqQTu7seKrU
         LUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zThgqL3mT8hxiS3UiF6CFV5UO8qR1fAU3lOSx4ZRa4U=;
        b=7vawqaHO25HJfKz4vq9zsgcug9c4o39bVLUvPbbM7oyYKz/QQHriJldpKMHnnD/mcq
         pzB06i7PRkAC6sJHjLMByvAj4XBkbo/wCEqFey8jienKgAhNV9id/sw8RHloutTKpjHM
         KLFJbg+DdsQaOhSO2pOZn8dT9r844GFjOqEOggHH35RVw2hcqMVcnGRWVgPJgd7kq8w2
         E3E2s5ioDZTZtnXJZwTSpEofBRUk6fRXkGzVH0UiOyb2ohBjws4Hm9kwEdmukyLguAUY
         WUdKOeqSdEphZ9E0DUUX1sObw5azyBkZzlbh7EiaFfIPQzxYSzv8WMJ+259gmBd7e870
         XkXA==
X-Gm-Message-State: AOAM5306rWp+nOQtwdMCbI/yoJ95E/kLxA70dYsmIHTtZpKIGJpfojkg
        9+wyvYi5MGMgUrjoQmSSuczXHk+rJNux1w==
X-Google-Smtp-Source: ABdhPJwasJfbMDLCq0WwkpHW1Zc9qH+2UmE2nB9BqPAJImgDHBOfLB6sXDGWLWb1kuuH4WmAVOX1hg==
X-Received: by 2002:a50:d79a:0:b0:425:e577:c71a with SMTP id w26-20020a50d79a000000b00425e577c71amr18937203edi.188.1651090071555;
        Wed, 27 Apr 2022 13:07:51 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id h6-20020a17090634c600b006f3a3bcb69dsm3967986ejb.29.2022.04.27.13.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 13:07:51 -0700 (PDT)
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
Subject: Re: [PATCH v4 43/45] media: sun6i-csi: Detect the availability of the ISP
Date:   Wed, 27 Apr 2022 22:07:49 +0200
Message-ID: <2029179.KlZ2vcFHjT@jernej-laptop>
In-Reply-To: <20220415152811.636419-44-paul.kocialkowski@bootlin.com>
References: <20220415152811.636419-1-paul.kocialkowski@bootlin.com> <20220415152811.636419-44-paul.kocialkowski@bootlin.com>
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

Dne petek, 15. april 2022 ob 17:28:09 CEST je Paul Kocialkowski napisal(a):
> Add a helper to detect whether the ISP is available and connected
> and store the indication in a driver-wide variable.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 33 +++++++++++++++++++
>  .../platform/sunxi/sun6i-csi/sun6i_csi.h      |  3 ++
>  2 files changed, 36 insertions(+)
> 
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c index
> a88deb8ba1e7..f185cbd113c7 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> @@ -25,6 +25,35 @@
>  #include "sun6i_csi_capture.h"
>  #include "sun6i_csi_reg.h"
> 
> +/* ISP */
> +
> +static bool sun6i_csi_isp_detect(struct sun6i_csi_device *csi_dev)
> +{
> +	struct device *dev = csi_dev->dev;
> +	struct fwnode_handle *handle = NULL;
> +
> +	/* ISP is not available if disabled in kernel config. */
> +	if (!IS_ENABLED(CONFIG_VIDEO_SUN6I_ISP))

Where is this symbol defined?

Best regards,
Jernej

> +		return 0;
> +
> +	/*
> +	 * ISP is not available if not connected via fwnode graph.
> +	 * This weill also check that the remote parent node is available.
> +	 */
> +	handle = fwnode_graph_get_endpoint_by_id(dev_fwnode(dev),
> +						 
SUN6I_CSI_PORT_ISP, 0,
> +						 
FWNODE_GRAPH_ENDPOINT_NEXT);
> +	if (!handle)
> +		return 0;
> +
> +	fwnode_handle_put(handle);
> +
> +	dev_info(dev, "ISP link is available\n");
> +	csi_dev->isp_available = true;
> +
> +	return 0;
> +}
> +
>  /* Media */
> 
>  static const struct media_device_ops sun6i_csi_media_ops = {
> @@ -306,6 +335,10 @@ static int sun6i_csi_probe(struct platform_device
> *platform_dev) if (ret)
>  		return ret;
> 
> +	ret = sun6i_csi_isp_detect(csi_dev);
> +	if (ret)
> +		goto error_resources;
> +
>  	ret = sun6i_csi_v4l2_setup(csi_dev);
>  	if (ret)
>  		goto error_resources;
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
> b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h index
> 6aa83dd11684..9b105c341047 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
> @@ -22,6 +22,7 @@
>  enum sun6i_csi_port {
>  	SUN6I_CSI_PORT_PARALLEL		= 0,
>  	SUN6I_CSI_PORT_MIPI_CSI2	= 1,
> +	SUN6I_CSI_PORT_ISP		= 2,
>  };
> 
>  struct sun6i_csi_buffer {
> @@ -46,6 +47,8 @@ struct sun6i_csi_device {
>  	struct clk			*clock_mod;
>  	struct clk			*clock_ram;
>  	struct reset_control		*reset;
> +
> +	bool				isp_available;
>  };
> 
>  struct sun6i_csi_variant {




