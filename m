Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4429B512224
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbiD0TJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbiD0TJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:09:05 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EAAB7F8;
        Wed, 27 Apr 2022 11:57:44 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z99so3016698ede.5;
        Wed, 27 Apr 2022 11:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lS8C6RafnPFCNmRPaomCz+ezzn4yOYEkgm2SdaKAMZI=;
        b=ZDu7GDl464M/0nwcaEtfEEZs5Fxg1kNlagzEHgnRotBKlFvj+00B5hR/pf/bjcjuZS
         q1zScpcN7dFJxVFDMKmX+tmpRSn7in8dC+R8lciLPrM1lexEE8awrKImCmC7EIS5fHMi
         VzaOs8XTnATEvT4ZL7DH/O2vH4PjyD0t8dqYOEFQsBgPZ8sLXTIeeFm4+OKFnv18HpxC
         KXsSAJY5j+7e5vsBGaDmv+Vk14oMoUCesWeky1KwjMkzg5iLEERO7C4smH49GU44jiYb
         9EoVM+RL/K7XHB6JGJpC0TzPDTqyj2lgdsjTrntZWT9XU1cAtV9SLmysM6GG2/rDpkuB
         kMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lS8C6RafnPFCNmRPaomCz+ezzn4yOYEkgm2SdaKAMZI=;
        b=M1dkJnBlqjxAm1lSIaMx/3skVxsMsnkDdnb8HjRfcLxDxNmZhu1khQEeoP15oCxXiQ
         kHK/78ZSeJRQOWGh9Yjqv1wufh/GrJdrNt1yRTnFEEJRpZx4iKBoQGmkfa6hS+GLXCMc
         QcgGodppz8EG9tgx3Qlgkl18i2CMWHyU97ll54N7x1uOjsRTzVLpT/rye+wZELxOMuwq
         AQEwQZcMDvIaW7Puv6eL61UGYpkzCffY17nyxPqFbgq+kVozDAXWhYx92uzj7+sbyIG1
         7tNMIVrTNnO1977+u/c+dwbDWBgbiB8xBlTNDUPzi7hi9HqPpoRFQL/3ThH9vWK+KOAE
         KHNA==
X-Gm-Message-State: AOAM530eupVKKrZ8xEUOATLrcumRkk0rFDA4v+tMGWx8+pcfcdAfL3/n
        uzGJ0iClrxsU+zcphT5k2hTCrZn5t6sVLQ==
X-Google-Smtp-Source: ABdhPJxu/WwF4HrtuesVWTzeoHXa/tN782vJ4UvpmeYZHn3AjkOL/EKC8t2nbV85B9C2iugS5khM+A==
X-Received: by 2002:a05:6402:27d0:b0:41a:68bf:ff26 with SMTP id c16-20020a05640227d000b0041a68bfff26mr32100632ede.102.1651085862897;
        Wed, 27 Apr 2022 11:57:42 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id e26-20020aa7d7da000000b0042617ba63ccsm29217eds.86.2022.04.27.11.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 11:57:42 -0700 (PDT)
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
Subject: Re: [PATCH v4 20/45] media: sun6i-csi: Add dimensions and format helpers to capture
Date:   Wed, 27 Apr 2022 20:57:41 +0200
Message-ID: <8054890.T7Z3S40VBb@jernej-laptop>
In-Reply-To: <20220415152811.636419-21-paul.kocialkowski@bootlin.com>
References: <20220415152811.636419-1-paul.kocialkowski@bootlin.com> <20220415152811.636419-21-paul.kocialkowski@bootlin.com>
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

Dne petek, 15. april 2022 ob 17:27:46 CEST je Paul Kocialkowski napisal(a):
> Define and export useful helpers to access dimensions and pixel format.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  .../sunxi/sun6i-csi/sun6i_csi_capture.c       | 19 +++++++++++++++++++
>  .../sunxi/sun6i-csi/sun6i_csi_capture.h       |  5 +++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
> b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c index
> e227940cb66e..acbd0ea62fd5 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
> @@ -25,6 +25,25 @@
> 
>  /* Helpers */
> 
> +void sun6i_csi_capture_dimensions(struct sun6i_csi_device *csi_dev,
> +				  unsigned int *width, unsigned 
int *height)
> +{
> +	if (width)
> +		*width = csi_dev->capture.format.fmt.pix.width;
> +	if (height)
> +		*height = csi_dev->capture.format.fmt.pix.height;
> +}
> +
> +void sun6i_csi_capture_format(struct sun6i_csi_device *csi_dev,
> +			      u32 *pixelformat, u32 *field)
> +{
> +	if (pixelformat)
> +		*pixelformat = csi_dev-
>capture.format.fmt.pix.pixelformat;
> +
> +	if (field)
> +		*field = csi_dev->capture.format.fmt.pix.field;
> +}
> +
>  static struct v4l2_subdev *
>  sun6i_csi_capture_remote_subdev(struct sun6i_csi_capture *capture, u32
> *pad) {
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
> b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h index
> 7fa66a2af5ec..935f35b7049a 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
> @@ -37,6 +37,11 @@ struct sun6i_csi_capture {
>  	u32				mbus_code;
>  };
> 
> +void sun6i_csi_capture_dimensions(struct sun6i_csi_device *csi_dev,
> +				  unsigned int *width, unsigned 
int *height);
> +void sun6i_csi_capture_format(struct sun6i_csi_device *csi_dev,
> +			      u32 *pixelformat, u32 *field);
> +
>  void sun6i_csi_capture_sync(struct sun6i_csi_device *csi_dev);
>  void sun6i_csi_capture_frame_done(struct sun6i_csi_device *csi_dev);




