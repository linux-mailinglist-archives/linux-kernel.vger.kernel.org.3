Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C3D4DA373
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 20:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351473AbiCOTsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 15:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351466AbiCOTrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 15:47:51 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8670355236;
        Tue, 15 Mar 2022 12:46:38 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id b15so187392edn.4;
        Tue, 15 Mar 2022 12:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uMKzKZw1W1nvQbMWjZMoxygwki6kU5a3M6LAZ2CWVok=;
        b=B1UoLY0vVogWD4fb4W22HeuOs7R/KQw5omeg1KwRNogjLPZA2mN5XqYorwGqS7RDNM
         hMnWTxp9he2F7yNEARsfJ0YbCx8LnQT9KDz88TVMLp0KJz/cWvlJMf2KivKdO5+nLRZG
         T3tY6drmkFiJA/50D2FY4rJV4nD3Yr9zWy8IXJmTJ4jXnHLk5mdh8Ov2ZU0o+zsnhJOY
         i1XVS2/l98A0Axk8yWoSoZpx8ilFyxJu30TS4CzOvF/pO1sKZXIcdaSU61n0Wj49atGd
         loxsNT3GOWIaUM0TU8eJGIM/w/D4wFJbLzl5iwNR3llbe0+I157UEuWgw2P8goZYgcCG
         /JqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uMKzKZw1W1nvQbMWjZMoxygwki6kU5a3M6LAZ2CWVok=;
        b=ULaZXWfN9iHagumI3U38L014y68gL7/BKpbcYdg9B+QheRrKrogUFKw6HBkqJNVPgV
         L/pHNmBUaxwtyRaAam54K5iTUkwV2xTeNGodtu+sTY1wMpLrs/xCEmgW18CUeq5uvZIK
         +x3RcW1YcL1uzch1Er82Qahu5ijsXIVWPDx3++zw29QHfr7k3FR3exwOR+8hdWpz9f3M
         7lIj/zRDsTifRTpRHgI41t4fYLmGvSahZre9OdXAl5AampjnnzbxmP9vM9Tz3R7I4WhQ
         3n3AuC57hJ7jx4MW8RchZu8ExPF9KcHSRnfA5panO1MSEJb0MzT+JA3vjM5QZ+aiGvgb
         GpmQ==
X-Gm-Message-State: AOAM532psk4Jg4manwFzdQz8GJ+/MzVA1cEFqXBqfSlcQzgxC7H0z6TS
        2fEAVLi3XBrRxvY5tn7ZFv7dyIIOMFEpBA==
X-Google-Smtp-Source: ABdhPJw3GTNmdkdldnehvdpFpXejlkPv3KZUnLL9VN/I7qYqwiMUqmXgZ5Q5III7WEkwnkswbyeUqg==
X-Received: by 2002:a05:6402:1e88:b0:416:9c06:9818 with SMTP id f8-20020a0564021e8800b004169c069818mr27167059edf.290.1647373597045;
        Tue, 15 Mar 2022 12:46:37 -0700 (PDT)
Received: from kista.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id n19-20020a170906165300b006a625c583b9sm8601286ejd.155.2022.03.15.12.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 12:46:36 -0700 (PDT)
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
Subject: Re: [PATCH v3 07/46] media: sun6i-csi: Use runtime pm for clocks and reset
Date:   Tue, 15 Mar 2022 20:46:35 +0100
Message-ID: <14579642.tv2OnDr8pf@kista>
In-Reply-To: <20220311143532.265091-8-paul.kocialkowski@bootlin.com>
References: <20220311143532.265091-1-paul.kocialkowski@bootlin.com> <20220311143532.265091-8-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 11. marec 2022 ob 15:34:53 CET je Paul Kocialkowski napisal(a):
> Wrap the clock and reset preparation into runtime pm functions
> for better organization of the code. Also fix the clock and
> reset enable order to first deassert reset, as recommended in
> Allwinner litterature.
> 
> Make the driver depend on PM while at it since runtime pm is
> mandatory for the driver to work.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  .../media/platform/sunxi/sun6i-csi/Kconfig    |  2 +-
>  .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 94 ++++++++++++++-----
>  2 files changed, 70 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/Kconfig b/drivers/media/
platform/sunxi/sun6i-csi/Kconfig
> index 586e3fb3a80d..fd03e48f0c8a 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/Kconfig
> +++ b/drivers/media/platform/sunxi/sun6i-csi/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config VIDEO_SUN6I_CSI
>  	tristate "Allwinner V3s Camera Sensor Interface driver"
> -	depends on VIDEO_V4L2 && COMMON_CLK  && HAS_DMA
> +	depends on PM && VIDEO_V4L2 && COMMON_CLK  && HAS_DMA
>  	depends on ARCH_SUNXI || COMPILE_TEST
>  	select MEDIA_CONTROLLER
>  	select VIDEO_V4L2_SUBDEV_API
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/
media/platform/sunxi/sun6i-csi/sun6i_csi.c
> index 4a0d08e0ac25..7f045a9551a7 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> @@ -152,40 +152,18 @@ int sun6i_csi_set_power(struct sun6i_csi_device 
*csi_dev, bool enable)
>  
>  	if (!enable) {
>  		regmap_update_bits(regmap, CSI_EN_REG, CSI_EN_CSI_EN, 
0);
> +		pm_runtime_put(dev);
>  
> -		clk_disable_unprepare(csi_dev->clk_ram);
> -		clk_disable_unprepare(csi_dev->clk_mod);
> -		reset_control_assert(csi_dev->reset);
>  		return 0;
>  	}
>  
> -	ret = clk_prepare_enable(csi_dev->clk_mod);
> -	if (ret) {
> -		dev_err(csi_dev->dev, "Enable csi clk err %d\n", ret);
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret < 0)
>  		return ret;
> -	}
> -
> -	ret = clk_prepare_enable(csi_dev->clk_ram);
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
> -	clk_disable_unprepare(csi_dev->clk_ram);
> -clk_mod_disable:
> -	clk_disable_unprepare(csi_dev->clk_mod);
> -	return ret;
>  }
>  
>  static enum csi_input_fmt get_csi_input_format(struct sun6i_csi_device 
*csi_dev,
> @@ -800,6 +778,65 @@ static irqreturn_t sun6i_csi_isr(int irq, void 
*private)
>  	return IRQ_HANDLED;
>  }
>  
> +static int sun6i_csi_suspend(struct device *dev)
> +{
> +	struct sun6i_csi_device *csi_dev = dev_get_drvdata(dev);
> +
> +	reset_control_assert(csi_dev->reset);
> +	clk_disable_unprepare(csi_dev->clk_ram);
> +	clk_disable_unprepare(csi_dev->clk_mod);
> +	clk_disable_unprepare(csi_dev->clk_bus);
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
> +	ret = clk_prepare_enable(csi_dev->clk_bus);
> +	if (ret) {
> +		dev_err(dev, "failed to enable bus clock\n");
> +		goto error_reset;
> +	}
> +
> +	ret = clk_prepare_enable(csi_dev->clk_mod);
> +	if (ret) {
> +		dev_err(dev, "failed to enable module clock\n");
> +		goto error_clk_bus;
> +	}
> +
> +	ret = clk_prepare_enable(csi_dev->clk_ram);
> +	if (ret) {
> +		dev_err(dev, "failed to enable ram clock\n");
> +		goto error_clk_mod;
> +	}
> +
> +	return 0;
> +
> +error_clk_mod:
> +	clk_disable_unprepare(csi_dev->clk_mod);
> +
> +error_clk_bus:
> +	clk_disable_unprepare(csi_dev->clk_bus);
> +
> +error_reset:
> +	reset_control_assert(csi_dev->reset);
> +
> +	return ret;
> +}
> +
> +static const struct dev_pm_ops sun6i_csi_pm_ops = {
> +	SET_RUNTIME_PM_OPS(sun6i_csi_suspend, sun6i_csi_resume, NULL)

Since driver depends on PM, using SET_RUNTIME_PM_OPS macro doesn't make sense.

> +};
> +
>  static const struct regmap_config sun6i_csi_regmap_config = {
>  	.reg_bits       = 32,
>  	.reg_stride     = 4,
> @@ -886,6 +923,11 @@ static int sun6i_csi_resources_setup(struct 
sun6i_csi_device *csi_dev,
>  		goto error_clk_rate_exclusive;
>  	}
>  
> +	/* Runtime PM */
> +
> +	pm_runtime_enable(dev);
> +	pm_runtime_set_suspended(dev);

pm_runtime_set_suspended() description says: "It is not valid to call this 
function for devices with runtime PM enabled."

Best regards,
Jernej

> +
>  	return 0;
>  
>  error_clk_rate_exclusive:
> @@ -896,6 +938,7 @@ static int sun6i_csi_resources_setup(struct 
sun6i_csi_device *csi_dev,
>  
>  static void sun6i_csi_resources_cleanup(struct sun6i_csi_device *csi_dev)
>  {
> +	pm_runtime_disable(csi_dev->dev);
>  	clk_rate_exclusive_put(csi_dev->clk_mod);
>  }
>  
> @@ -978,6 +1021,7 @@ static struct platform_driver sun6i_csi_platform_driver 
= {
>  	.driver	= {
>  		.name		= SUN6I_CSI_NAME,
>  		.of_match_table	= 
of_match_ptr(sun6i_csi_of_match),
> +		.pm		= &sun6i_csi_pm_ops,
>  	},
>  };
>  
> -- 
> 2.35.1
> 
> 


