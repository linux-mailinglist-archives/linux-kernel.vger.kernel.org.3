Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7F4512281
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbiD0TZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234417AbiD0TZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:25:43 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D3112AC5;
        Wed, 27 Apr 2022 12:21:37 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bv19so5338183ejb.6;
        Wed, 27 Apr 2022 12:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1pzX66OsBnNRuIBQz0pI37xgHgmuvAdxapWLaoZpVz4=;
        b=mgI9NDd1ieXNF7QNWidr4aWzwJOOgDmiS6oC+dq25mEOwPWmmZfMbfbUaVEgrqDNJN
         BhUOGjj82d4P4XgLSxaj6zUuNnCsUMsyySl2TcsSPp7CL3MPoPDzS8zgeMhLjwL4H5r9
         xXrwoZVGE0EehHDynM903T+NnNhhly8qvlFtU5HPC2Le8F3v0sr424xNeqYldFuv/lx+
         Wr/DHZnIQlYPDY5eHbnBSaaadyF0D/k2z3Z3erWbvfroUXuHwVlvL5HR/QFDovcBaudN
         CoR7QUSt+xwG/BMK3Hr4kXTGJofkMkQa2UsifqaXddCuUBkLxnSi8oE8zPuQ32aTxhSi
         mJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1pzX66OsBnNRuIBQz0pI37xgHgmuvAdxapWLaoZpVz4=;
        b=UBnqfDiw1Mc4NBt8ejmxMP+0jK0ynnHjCRJ4MP7xG1KlzAJLcA1mYbpj5QU3UfULBU
         v19T4Wx74ejX/aITLIPF8pX+VuxSyjAebphGxStU0SZwF2O0u3MEHdDDb2adlg/+cxgw
         aERncuqExKfwnCAUBIPnPXuqd+0ngGeklGvf7XZtbblh7LGxr8pa0r+qtQLaBQyF/ykJ
         r8Ea2Idirl4pPveeHfUpFyr7FEOYY3Wiclhus72QEFenqegykbv0co17dvfCypmxOJJF
         70kyz7nOc3aUsBv50KN2vCcAEInUsi60/xsROt9z3TqeIla1TDCy/V4yYPCuTtRY0iVF
         pixw==
X-Gm-Message-State: AOAM533cTLyslulw/PZUEgI99GKAkXSvThjYSgTuPulV1ef0+krtV95k
        CH8ariNgjnV68Fa33zTceB/OvE0z9auxUA==
X-Google-Smtp-Source: ABdhPJzXuvdaKSn1F0VRSzYT8LkBKGAMTiCWNvGj1LRVVyZfUiXEcy605iJSgEc+AlBZ5+UGN7zxuQ==
X-Received: by 2002:a17:906:d20c:b0:6f3:9901:bc08 with SMTP id w12-20020a170906d20c00b006f39901bc08mr15875211ejz.351.1651087296332;
        Wed, 27 Apr 2022 12:21:36 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id y5-20020a056402170500b0042617ba63d3sm65241edu.93.2022.04.27.12.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 12:21:35 -0700 (PDT)
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
Subject: Re: [PATCH v4 23/45] media: sun6i-csi: Move power management to runtime pm in capture
Date:   Wed, 27 Apr 2022 21:21:34 +0200
Message-ID: <8925609.CDJkKcVGEf@jernej-laptop>
In-Reply-To: <20220415152811.636419-24-paul.kocialkowski@bootlin.com>
References: <20220415152811.636419-1-paul.kocialkowski@bootlin.com> <20220415152811.636419-24-paul.kocialkowski@bootlin.com>
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

Dne petek, 15. april 2022 ob 17:27:49 CEST je Paul Kocialkowski napisal(a):
> Let's just enable the module when we start using it (at stream on)
> and benefit from runtime pm instead of enabling it at first open.
> 
> Also reorder the call to v4l2_pipeline_pm_get.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 24 -----------
>  .../platform/sunxi/sun6i-csi/sun6i_csi.h      |  7 ----
>  .../sunxi/sun6i-csi/sun6i_csi_capture.c       | 41 ++++++++++---------
>  3 files changed, 22 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c index
> 29892e8c2b9d..7801f5abe47e 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> @@ -148,30 +148,6 @@ bool sun6i_csi_is_format_supported(struct
> sun6i_csi_device *csi_dev, return false;
>  }
> 
> -int sun6i_csi_set_power(struct sun6i_csi_device *csi_dev, bool enable)
> -{
> -	struct device *dev = csi_dev->dev;
> -	struct regmap *regmap = csi_dev->regmap;
> -	int ret;
> -
> -	if (!enable) {
> -		regmap_update_bits(regmap, SUN6I_CSI_EN_REG,
> -				   SUN6I_CSI_EN_CSI_EN, 0);
> -		pm_runtime_put(dev);
> -
> -		return 0;
> -	}
> -
> -	ret = pm_runtime_resume_and_get(dev);
> -	if (ret < 0)
> -		return ret;
> -
> -	regmap_update_bits(regmap, SUN6I_CSI_EN_REG, SUN6I_CSI_EN_CSI_EN,
> -			   SUN6I_CSI_EN_CSI_EN);
> -
> -	return 0;
> -}
> -
>  static enum csi_input_fmt get_csi_input_format(struct sun6i_csi_device
> *csi_dev, u32 mbus_code, u32 pixformat)
>  {
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
> b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h index
> 155527961280..3a4f2b45d267 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
> @@ -77,13 +77,6 @@ struct sun6i_csi_variant {
>  bool sun6i_csi_is_format_supported(struct sun6i_csi_device *csi_dev,
>  				   u32 pixformat, u32 mbus_code);
> 
> -/**
> - * sun6i_csi_set_power() - power on/off the csi
> - * @csi:	pointer to the csi
> - * @enable:	on/off
> - */
> -int sun6i_csi_set_power(struct sun6i_csi_device *csi_dev, bool enable);
> -
>  /**
>   * sun6i_csi_update_config() - update the csi register settings
>   * @csi:	pointer to the csi
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
> b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c index
> 72fcc60d2695..3e5c4f7df48d 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
> @@ -6,6 +6,7 @@
>   */
> 
>  #include <linux/of.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
> 
>  #include <media/v4l2-device.h>
> @@ -141,6 +142,9 @@ static void sun6i_csi_capture_enable(struct
> sun6i_csi_device *csi_dev) {
>  	struct regmap *regmap = csi_dev->regmap;
> 
> +	regmap_update_bits(regmap, SUN6I_CSI_EN_REG, SUN6I_CSI_EN_CSI_EN,
> +			   SUN6I_CSI_EN_CSI_EN);
> +
>  	regmap_update_bits(regmap, SUN6I_CSI_CAP_REG, 
SUN6I_CSI_CAP_VCAP_ON,
>  			   SUN6I_CSI_CAP_VCAP_ON);
>  }
> @@ -150,6 +154,7 @@ static void sun6i_csi_capture_disable(struct
> sun6i_csi_device *csi_dev) struct regmap *regmap = csi_dev->regmap;
> 
>  	regmap_update_bits(regmap, SUN6I_CSI_CAP_REG, 
SUN6I_CSI_CAP_VCAP_ON, 0);
> +	regmap_update_bits(regmap, SUN6I_CSI_EN_REG, SUN6I_CSI_EN_CSI_EN, 
0);
>  }
> 
>  static void
> @@ -382,6 +387,7 @@ static int sun6i_csi_capture_start_streaming(struct
> vb2_queue *queue, struct sun6i_csi_capture *capture = &csi_dev->capture;
>  	struct sun6i_csi_capture_state *state = &capture->state;
>  	struct video_device *video_dev = &capture->video_dev;
> +	struct device *dev = csi_dev->dev;
>  	struct v4l2_subdev *subdev;
>  	int ret;
> 
> @@ -402,6 +408,12 @@ static int sun6i_csi_capture_start_streaming(struct
> vb2_queue *queue, goto error_media_pipeline;
>  	}
> 
> +	/* PM */
> +
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret < 0)
> +		goto error_media_pipeline;
> +
>  	/* Clear */
> 
>  	sun6i_csi_capture_irq_clear(csi_dev);
> @@ -429,6 +441,8 @@ static int sun6i_csi_capture_start_streaming(struct
> vb2_queue *queue, sun6i_csi_capture_disable(csi_dev);
>  	sun6i_csi_capture_irq_disable(csi_dev);
> 
> +	pm_runtime_put(dev);
> +
>  error_media_pipeline:
>  	media_pipeline_stop(&video_dev->entity);
> 
> @@ -442,6 +456,7 @@ static void sun6i_csi_capture_stop_streaming(struct
> vb2_queue *queue) {
>  	struct sun6i_csi_device *csi_dev = vb2_get_drv_priv(queue);
>  	struct sun6i_csi_capture *capture = &csi_dev->capture;
> +	struct device *dev = csi_dev->dev;
>  	struct v4l2_subdev *subdev;
> 
>  	subdev = sun6i_csi_capture_remote_subdev(capture, NULL);
> @@ -451,6 +466,8 @@ static void sun6i_csi_capture_stop_streaming(struct
> vb2_queue *queue) sun6i_csi_capture_disable(csi_dev);
>  	sun6i_csi_capture_irq_disable(csi_dev);
> 
> +	pm_runtime_put(dev);
> +
>  	media_pipeline_stop(&capture->video_dev.entity);
> 
>  	sun6i_csi_capture_state_cleanup(csi_dev, true);
> @@ -639,27 +656,20 @@ static int sun6i_csi_capture_open(struct file *file)
>  	if (mutex_lock_interruptible(&capture->lock))
>  		return -ERESTARTSYS;
> 
> -	ret = v4l2_fh_open(file);
> +	ret = v4l2_pipeline_pm_get(&capture->video_dev.entity);
>  	if (ret < 0)
>  		goto error_lock;
> 
> -	ret = v4l2_pipeline_pm_get(&capture->video_dev.entity);
> +	ret = v4l2_fh_open(file);
>  	if (ret < 0)
> -		goto error_v4l2_fh;
> -
> -	/* Power on at first open. */
> -	if (v4l2_fh_is_singular_file(file)) {
> -		ret = sun6i_csi_set_power(csi_dev, true);
> -		if (ret < 0)
> -			goto error_v4l2_fh;
> -	}
> +		goto error_pipeline;
> 
>  	mutex_unlock(&capture->lock);
> 
>  	return 0;
> 
> -error_v4l2_fh:
> -	v4l2_fh_release(file);
> +error_pipeline:
> +	v4l2_pipeline_pm_put(&capture->video_dev.entity);
> 
>  error_lock:
>  	mutex_unlock(&capture->lock);
> @@ -671,19 +681,12 @@ static int sun6i_csi_capture_close(struct file *file)
>  {
>  	struct sun6i_csi_device *csi_dev = video_drvdata(file);
>  	struct sun6i_csi_capture *capture = &csi_dev->capture;
> -	bool last_close;
> 
>  	mutex_lock(&capture->lock);
> 
> -	last_close = v4l2_fh_is_singular_file(file);
> -
>  	_vb2_fop_release(file, NULL);
>  	v4l2_pipeline_pm_put(&capture->video_dev.entity);
> 
> -	/* Power off at last close. */
> -	if (last_close)
> -		sun6i_csi_set_power(csi_dev, false);
> -
>  	mutex_unlock(&capture->lock);
> 
>  	return 0;




