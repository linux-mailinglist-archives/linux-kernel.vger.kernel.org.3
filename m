Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1EF51217F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiD0StW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 14:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiD0Ssg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 14:48:36 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E629943388;
        Wed, 27 Apr 2022 11:31:35 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id y3so5061229ejo.12;
        Wed, 27 Apr 2022 11:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6weLRPbBPe57uX8mMeORt7L2XcJU22sNULRsCXuuqBw=;
        b=PiczsENkZ+IGeiQ7DFmSWw8yPWNNVyv2Z6WiZwRZquvk+RNiNnBvL3HcWk7WAGiIrs
         F3A8AYKJCF8lLs1iNkRC5k+LP1pXir/b4IS/vb0HbmlOEKAKjJb2Y+l/WL0G8QpCM/3z
         eVJIXKZOtRSTPMOLXRDanzlayXynDkDdtu5fmwDe3RuTfqvBu7mWAgqeFCj0cDf67mvY
         NrydXtrfBCy6oG8N2F22EyOWbQNfVuKQ3Z+cilquh38PgWy0DaAh85N7w7D/TmAhz+bI
         drM/mRjxwyhYXCbnyDa4i1/GKREAjzUQUrofzA4ZR8gNnReMwGAxEFKiNmdLrztXwgEd
         rowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6weLRPbBPe57uX8mMeORt7L2XcJU22sNULRsCXuuqBw=;
        b=PlRAJBsx9IH1pv1D26VLHLht/S79TdX7z46l6W8aOCW49WIuzPn0RRndMmFRlEokr8
         MXDzOr1WTFzRhn5P8Ae9pweLnQbsv+mq4x5QUNXBf1l6tztNxKYpbJvMdXprtoHruU9f
         e0U6B8QEkE6rBB0aN4Eb5JnyxJF8tw7jrs+fTFYS+GBsqxekCSuo/iQWvDutILtkxgeu
         JQ5c6g3VqWDR6dXNzNaNlnYYnGIhL27A8x9pOoJuF7HMYnp4Rb3hhrOB3OCMtOeYrheg
         cxDPs3DSqFi3NwZz5TBjnrJgUDHB6n6wCsA1QrAbFQ2iaT34wXVBMLIBBpEbJJvZoCzg
         2KXA==
X-Gm-Message-State: AOAM533btItGjjYGfnYDMkBuBNcsWTSFDQoUdKOma65Decwk7ygSnHDf
        iEuDnDLC9HXQwnC0xf/X6NnsoYfr8ecFPg==
X-Google-Smtp-Source: ABdhPJzOCctqhaZ1rAdSx0HEdgoTqOncuYDpDoFARLqN9WUF0CuaH4PfNeKCKcg+QQnLuF6Fb9lzdg==
X-Received: by 2002:a17:907:7215:b0:6f3:98da:a823 with SMTP id dr21-20020a170907721500b006f398daa823mr15354929ejc.284.1651084294402;
        Wed, 27 Apr 2022 11:31:34 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id s11-20020a170906284b00b006e108693850sm6989840ejc.28.2022.04.27.11.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 11:31:33 -0700 (PDT)
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
Subject: Re: [PATCH v4 06/45] media: sun6i-csi: Use runtime pm for clocks and reset
Date:   Wed, 27 Apr 2022 20:31:32 +0200
Message-ID: <2625748.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <20220415152811.636419-7-paul.kocialkowski@bootlin.com>
References: <20220415152811.636419-1-paul.kocialkowski@bootlin.com> <20220415152811.636419-7-paul.kocialkowski@bootlin.com>
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

Hi!

Dne petek, 15. april 2022 ob 17:27:32 CEST je Paul Kocialkowski napisal(a):
> Wrap the clock and reset preparation into runtime pm functions
> for better organization of the code. Also fix the clock and
> reset enable order to first deassert reset, as recommended in
> Allwinner litterature.

s/litterature/literature/

Otherwise,
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> 
> Make the driver depend on PM while at it since runtime pm is
> mandatory for the driver to work.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  .../media/platform/sunxi/sun6i-csi/Kconfig    |  2 +-
>  .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 84 +++++++++++++------
>  2 files changed, 60 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/Kconfig
> b/drivers/media/platform/sunxi/sun6i-csi/Kconfig index
> 0345901617d4..965fbd937841 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/Kconfig
> +++ b/drivers/media/platform/sunxi/sun6i-csi/Kconfig
> @@ -2,7 +2,7 @@
>  config VIDEO_SUN6I_CSI
>  	tristate "Allwinner V3s Camera Sensor Interface driver"
>  	depends on V4L_PLATFORM_DRIVERS
> -	depends on VIDEO_DEV && COMMON_CLK  && HAS_DMA
> +	depends on VIDEO_DEV && COMMON_CLK  && HAS_DMA && PM
>  	depends on ARCH_SUNXI || COMPILE_TEST
>  	select MEDIA_CONTROLLER
>  	select VIDEO_V4L2_SUBDEV_API
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c index
> 46d92b925cc8..dcc9e7a125e2 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> @@ -152,40 +152,18 @@ int sun6i_csi_set_power(struct sun6i_csi_device
> *csi_dev, bool enable)
> 
>  	if (!enable) {
>  		regmap_update_bits(regmap, CSI_EN_REG, CSI_EN_CSI_EN, 
0);
> +		pm_runtime_put(dev);
> 
> -		clk_disable_unprepare(csi_dev->clock_ram);
> -		clk_disable_unprepare(csi_dev->clock_mod);
> -		reset_control_assert(csi_dev->reset);
>  		return 0;
>  	}
> 
> -	ret = clk_prepare_enable(csi_dev->clock_mod);
> -	if (ret) {
> -		dev_err(csi_dev->dev, "Enable csi clk err %d\n", ret);
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret < 0)
>  		return ret;
> -	}
> -
> -	ret = clk_prepare_enable(csi_dev->clock_ram);
> -	if (ret) {
> -		dev_err(csi_dev->dev, "Enable clk_dram_csi clk err 
%d\n", ret);
> -		goto clk_mod_disable;
> -	}
> -
> -	ret = reset_control_deassert(csi_dev->reset);
> -	if (ret) {
> -		dev_err(csi_dev->dev, "reset err %d\n", ret);
> -		goto clk_ram_disable;
> -	}
> 
>  	regmap_update_bits(regmap, CSI_EN_REG, CSI_EN_CSI_EN, 
CSI_EN_CSI_EN);
> 
>  	return 0;
> -
> -clk_ram_disable:
> -	clk_disable_unprepare(csi_dev->clock_ram);
> -clk_mod_disable:
> -	clk_disable_unprepare(csi_dev->clock_mod);
> -	return ret;
>  }
> 
>  static enum csi_input_fmt get_csi_input_format(struct sun6i_csi_device
> *csi_dev, @@ -800,6 +778,56 @@ static irqreturn_t sun6i_csi_interrupt(int
> irq, void *private) return IRQ_HANDLED;
>  }
> 
> +static int sun6i_csi_suspend(struct device *dev)
> +{
> +	struct sun6i_csi_device *csi_dev = dev_get_drvdata(dev);
> +
> +	reset_control_assert(csi_dev->reset);
> +	clk_disable_unprepare(csi_dev->clock_ram);
> +	clk_disable_unprepare(csi_dev->clock_mod);
> +
> +	return 0;
> +}
> +
> +static int sun6i_csi_resume(struct device *dev)
> +{
> +	struct sun6i_csi_device *csi_dev = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = reset_control_deassert(csi_dev->reset);
> +	if (ret) {
> +		dev_err(dev, "failed to deassert reset\n");
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(csi_dev->clock_mod);
> +	if (ret) {
> +		dev_err(dev, "failed to enable module clock\n");
> +		goto error_reset;
> +	}
> +
> +	ret = clk_prepare_enable(csi_dev->clock_ram);
> +	if (ret) {
> +		dev_err(dev, "failed to enable ram clock\n");
> +		goto error_clock_mod;
> +	}
> +
> +	return 0;
> +
> +error_clock_mod:
> +	clk_disable_unprepare(csi_dev->clock_mod);
> +
> +error_reset:
> +	reset_control_assert(csi_dev->reset);
> +
> +	return ret;
> +}
> +
> +static const struct dev_pm_ops sun6i_csi_pm_ops = {
> +	.runtime_suspend	= sun6i_csi_suspend,
> +	.runtime_resume		= sun6i_csi_resume,
> +};
> +
>  static const struct regmap_config sun6i_csi_regmap_config = {
>  	.reg_bits       = 32,
>  	.reg_stride     = 4,
> @@ -879,6 +907,10 @@ static int sun6i_csi_resources_setup(struct
> sun6i_csi_device *csi_dev, goto error_clock_rate_exclusive;
>  	}
> 
> +	/* Runtime PM */
> +
> +	pm_runtime_enable(dev);
> +
>  	return 0;
> 
>  error_clock_rate_exclusive:
> @@ -889,6 +921,7 @@ static int sun6i_csi_resources_setup(struct
> sun6i_csi_device *csi_dev,
> 
>  static void sun6i_csi_resources_cleanup(struct sun6i_csi_device *csi_dev)
>  {
> +	pm_runtime_disable(csi_dev->dev);
>  	clk_rate_exclusive_put(csi_dev->clock_mod);
>  }
> 
> @@ -971,6 +1004,7 @@ static struct platform_driver sun6i_csi_platform_driver
> = { .driver	= {
>  		.name		= SUN6I_CSI_NAME,
>  		.of_match_table	= 
of_match_ptr(sun6i_csi_of_match),
> +		.pm		= &sun6i_csi_pm_ops,
>  	},
>  };




