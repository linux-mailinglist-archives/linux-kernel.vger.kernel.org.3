Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3489055D0C0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240032AbiF0MC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 08:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239640AbiF0L54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 07:57:56 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D885DF64
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 04:54:11 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id o16-20020a05600c379000b003a02eaea815so4750078wmr.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 04:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=nNoaWz2DLfztpbfMaaOu9PND9CXL/stNC5CxyVcj8tw=;
        b=s0FEU6AivObD1lzT2SuxslJpVSIXyDDsuFB0W7kASRDUlSFyBNXIGpEBrYgWxxbOLr
         pADpmFpbeRHDXuUrloWKz+QrjRXV87KEleWiYHYpTRkMzZ3mbZk+pt04e5a3kVnMU6GZ
         CZj+MLN0u+Cl0VoSCJPdrZDls00sd1/daPXrU5CXskGv8kFtkeALfEiWJi5e/hkjlABy
         n4s9LX1uBbD5hvzmkV8vijcL7h5ep3jCVXzFrK9MTGQH/H+2viSJie24i/o8JhccnYUo
         /cip9/pXsctWiRyYT31HX0pRTcNqmuS7XA/ddac5oBXR8bMFreniec+taVX+53lzpAPg
         RALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nNoaWz2DLfztpbfMaaOu9PND9CXL/stNC5CxyVcj8tw=;
        b=bgdYAQpxVOIQJ3kn3cEBN2IE5ZMsyQb5NWxkXSeVCCL7fcdkBQ9bShXHK9elMn7KyI
         AUSWNtBBZ1jNO5VaXdt0iypyjzSfZo36YMiDhZGhquBfuQDE8X5VNBXgKVc3X2piKLd4
         Q2wR1eudEDIccGLSgxsgpQBKldkr0vujMYdY2ZWN9mu3gd4irzUbXVrqIN3ox+TbKcMC
         4cISmMitQyJlJvatGM+79N5nbHsyvHQnqjGqM9s69io34CFwRrmXvqYsh6EGbDG6uzCM
         hivDXLOqG0FHC8CEfvZEPQlfWKO684E+Tj166sQdWM7dXk5BqfQ9C/OYxao27nlD+W+6
         RIJQ==
X-Gm-Message-State: AJIora9av7/cHlZMh0C14Oqs1Wj56xu9mhYzSN7CALhLPwqcBeYeuhj0
        IMTfI5C1cvpRuj7Xrr6Eac/vHg==
X-Google-Smtp-Source: AGRyM1v2YCbjkUWS+vtyeJezfTvhqmE7y9nvKbHozDF85HWmhsPzgY7ui0/J/OUKoCoLxEqG21Y3Xw==
X-Received: by 2002:a05:600c:a42:b0:39c:9166:5a55 with SMTP id c2-20020a05600c0a4200b0039c91665a55mr14839526wmq.141.1656330849806;
        Mon, 27 Jun 2022 04:54:09 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id a7-20020adffb87000000b0021b89181863sm10331609wrr.41.2022.06.27.04.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 04:54:09 -0700 (PDT)
Date:   Mon, 27 Jun 2022 12:54:07 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        sre@kernel.org, broonie@kernel.org, gregkh@linuxfoundation.org,
        lgirdwood@gmail.com, lars@metafoo.de, rafael@kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/10] mfd: axp20x: Add support for AXP192
Message-ID: <YrmaX6/dbYKAFDQ4@google.com>
References: <20220603135714.12007-1-aidanmacdonald.0x0@gmail.com>
 <20220603135714.12007-7-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220603135714.12007-7-aidanmacdonald.0x0@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Jun 2022, Aidan MacDonald wrote:

> The AXP192 PMIC is similar to the AXP202/AXP209, but with different
> regulators, additional GPIOs, and a different IRQ register layout.
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  drivers/mfd/axp20x-i2c.c   |   2 +
>  drivers/mfd/axp20x.c       | 150 +++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/axp20x.h |  84 +++++++++++++++++++++
>  3 files changed, 236 insertions(+)
> 
> diff --git a/drivers/mfd/axp20x-i2c.c b/drivers/mfd/axp20x-i2c.c
> index 00ab48018d8d..9ada58fad77f 100644
> --- a/drivers/mfd/axp20x-i2c.c
> +++ b/drivers/mfd/axp20x-i2c.c
> @@ -62,6 +62,7 @@ static int axp20x_i2c_remove(struct i2c_client *i2c)
>  #ifdef CONFIG_OF
>  static const struct of_device_id axp20x_i2c_of_match[] = {
>  	{ .compatible = "x-powers,axp152", .data = (void *)AXP152_ID },
> +	{ .compatible = "x-powers,axp192", .data = (void *)AXP192_ID },
>  	{ .compatible = "x-powers,axp202", .data = (void *)AXP202_ID },
>  	{ .compatible = "x-powers,axp209", .data = (void *)AXP209_ID },
>  	{ .compatible = "x-powers,axp221", .data = (void *)AXP221_ID },
> @@ -75,6 +76,7 @@ MODULE_DEVICE_TABLE(of, axp20x_i2c_of_match);
>  
>  static const struct i2c_device_id axp20x_i2c_id[] = {
>  	{ "axp152", 0 },
> +	{ "axp192", 0 },
>  	{ "axp202", 0 },
>  	{ "axp209", 0 },
>  	{ "axp221", 0 },
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 8161a5dc68e8..7f64e5c83fe2 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -34,6 +34,7 @@
>  
>  static const char * const axp20x_model_names[] = {
>  	"AXP152",
> +	"AXP192",
>  	"AXP202",
>  	"AXP209",
>  	"AXP221",
> @@ -92,6 +93,35 @@ static const struct regmap_access_table axp20x_volatile_table = {
>  	.n_yes_ranges	= ARRAY_SIZE(axp20x_volatile_ranges),
>  };
>  
> +static const struct regmap_range axp192_writeable_ranges[] = {
> +	regmap_reg_range(AXP192_DATACACHE(0), AXP192_DATACACHE(5)),
> +	regmap_reg_range(AXP192_PWR_OUT_CTRL, AXP192_IRQ5_STATE),
> +	regmap_reg_range(AXP20X_DCDC_MODE, AXP192_N_RSTO_CTRL),
> +	regmap_reg_range(AXP20X_CC_CTRL, AXP20X_CC_CTRL),
> +};
> +
> +static const struct regmap_range axp192_volatile_ranges[] = {
> +	regmap_reg_range(AXP20X_PWR_INPUT_STATUS, AXP192_USB_OTG_STATUS),
> +	regmap_reg_range(AXP192_IRQ1_STATE, AXP192_IRQ4_STATE),
> +	regmap_reg_range(AXP192_IRQ5_STATE, AXP192_IRQ5_STATE),
> +	regmap_reg_range(AXP20X_ACIN_V_ADC_H, AXP20X_IPSOUT_V_HIGH_L),
> +	regmap_reg_range(AXP20X_TIMER_CTRL, AXP20X_TIMER_CTRL),
> +	regmap_reg_range(AXP192_GPIO2_0_STATE, AXP192_GPIO2_0_STATE),
> +	regmap_reg_range(AXP192_GPIO4_3_STATE, AXP192_GPIO4_3_STATE),
> +	regmap_reg_range(AXP192_N_RSTO_CTRL, AXP192_N_RSTO_CTRL),
> +	regmap_reg_range(AXP20X_CHRG_CC_31_24, AXP20X_CC_CTRL),
> +};
> +
> +static const struct regmap_access_table axp192_writeable_table = {
> +	.yes_ranges	= axp192_writeable_ranges,
> +	.n_yes_ranges	= ARRAY_SIZE(axp192_writeable_ranges),
> +};
> +
> +static const struct regmap_access_table axp192_volatile_table = {
> +	.yes_ranges	= axp192_volatile_ranges,
> +	.n_yes_ranges	= ARRAY_SIZE(axp192_volatile_ranges),
> +};
> +
>  /* AXP22x ranges are shared with the AXP809, as they cover the same range */
>  static const struct regmap_range axp22x_writeable_ranges[] = {
>  	regmap_reg_range(AXP20X_DATACACHE(0), AXP20X_IRQ5_STATE),
> @@ -173,6 +203,25 @@ static const struct resource axp152_pek_resources[] = {
>  	DEFINE_RES_IRQ_NAMED(AXP152_IRQ_PEK_FAL_EDGE, "PEK_DBF"),
>  };
>  
> +static const struct resource axp192_gpio_resources[] = {
> +	DEFINE_RES_IRQ_NAMED(AXP192_IRQ_GPIO0_INPUT, "GPIO0"),
> +	DEFINE_RES_IRQ_NAMED(AXP192_IRQ_GPIO1_INPUT, "GPIO1"),
> +	DEFINE_RES_IRQ_NAMED(AXP192_IRQ_GPIO2_INPUT, "GPIO2"),
> +};
> +
> +static const struct resource axp192_ac_power_supply_resources[] = {
> +	DEFINE_RES_IRQ_NAMED(AXP192_IRQ_ACIN_PLUGIN, "ACIN_PLUGIN"),
> +	DEFINE_RES_IRQ_NAMED(AXP192_IRQ_ACIN_REMOVAL, "ACIN_REMOVAL"),
> +	DEFINE_RES_IRQ_NAMED(AXP192_IRQ_ACIN_OVER_V, "ACIN_OVER_V"),
> +};
> +
> +static const struct resource axp192_usb_power_supply_resources[] = {
> +	DEFINE_RES_IRQ_NAMED(AXP192_IRQ_VBUS_PLUGIN, "VBUS_PLUGIN"),
> +	DEFINE_RES_IRQ_NAMED(AXP192_IRQ_VBUS_REMOVAL, "VBUS_REMOVAL"),
> +	DEFINE_RES_IRQ_NAMED(AXP192_IRQ_VBUS_VALID, "VBUS_VALID"),
> +	DEFINE_RES_IRQ_NAMED(AXP192_IRQ_VBUS_NOT_VALID, "VBUS_NOT_VALID"),
> +};
> +
>  static const struct resource axp20x_ac_power_supply_resources[] = {
>  	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_ACIN_PLUGIN, "ACIN_PLUGIN"),
>  	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_ACIN_REMOVAL, "ACIN_REMOVAL"),
> @@ -245,6 +294,15 @@ static const struct regmap_config axp152_regmap_config = {
>  	.cache_type	= REGCACHE_RBTREE,
>  };
>  
> +static const struct regmap_config axp192_regmap_config = {
> +	.reg_bits	= 8,
> +	.val_bits	= 8,
> +	.wr_table	= &axp192_writeable_table,
> +	.volatile_table	= &axp192_volatile_table,
> +	.max_register	= AXP20X_CC_CTRL,
> +	.cache_type	= REGCACHE_RBTREE,
> +};
> +
>  static const struct regmap_config axp20x_regmap_config = {
>  	.reg_bits	= 8,
>  	.val_bits	= 8,
> @@ -304,6 +362,55 @@ static const struct regmap_irq axp152_regmap_irqs[] = {
>  	INIT_REGMAP_IRQ(AXP152, GPIO0_INPUT,		2, 0),
>  };
>  
> +static const struct regmap_irq axp192_regmap_irqs[] = {
> +	INIT_REGMAP_IRQ(AXP192, ACIN_OVER_V,		0, 7),
> +	INIT_REGMAP_IRQ(AXP192, ACIN_PLUGIN,		0, 6),
> +	INIT_REGMAP_IRQ(AXP192, ACIN_REMOVAL,		0, 5),
> +	INIT_REGMAP_IRQ(AXP192, VBUS_OVER_V,		0, 4),
> +	INIT_REGMAP_IRQ(AXP192, VBUS_PLUGIN,		0, 3),
> +	INIT_REGMAP_IRQ(AXP192, VBUS_REMOVAL,		0, 2),
> +	INIT_REGMAP_IRQ(AXP192, VBUS_V_LOW,		0, 1),
> +	INIT_REGMAP_IRQ(AXP192, BATT_PLUGIN,		1, 7),
> +	INIT_REGMAP_IRQ(AXP192, BATT_REMOVAL,	        1, 6),
> +	INIT_REGMAP_IRQ(AXP192, BATT_ENT_ACT_MODE,	1, 5),
> +	INIT_REGMAP_IRQ(AXP192, BATT_EXIT_ACT_MODE,	1, 4),
> +	INIT_REGMAP_IRQ(AXP192, CHARG,		        1, 3),
> +	INIT_REGMAP_IRQ(AXP192, CHARG_DONE,		1, 2),
> +	INIT_REGMAP_IRQ(AXP192, BATT_TEMP_HIGH,	        1, 1),
> +	INIT_REGMAP_IRQ(AXP192, BATT_TEMP_LOW,	        1, 0),
> +	INIT_REGMAP_IRQ(AXP192, DIE_TEMP_HIGH,	        2, 7),
> +	INIT_REGMAP_IRQ(AXP192, CHARG_I_LOW,		2, 6),
> +	INIT_REGMAP_IRQ(AXP192, DCDC1_V_LONG,	        2, 5),
> +	INIT_REGMAP_IRQ(AXP192, DCDC2_V_LONG,	        2, 4),
> +	INIT_REGMAP_IRQ(AXP192, DCDC3_V_LONG,	        2, 3),
> +	INIT_REGMAP_IRQ(AXP192, PEK_SHORT,		2, 1),
> +	INIT_REGMAP_IRQ(AXP192, PEK_LONG,		2, 0),
> +	INIT_REGMAP_IRQ(AXP192, N_OE_PWR_ON,		3, 7),
> +	INIT_REGMAP_IRQ(AXP192, N_OE_PWR_OFF,	        3, 6),
> +	INIT_REGMAP_IRQ(AXP192, VBUS_VALID,		3, 5),
> +	INIT_REGMAP_IRQ(AXP192, VBUS_NOT_VALID,	        3, 4),
> +	INIT_REGMAP_IRQ(AXP192, VBUS_SESS_VALID,	3, 3),
> +	INIT_REGMAP_IRQ(AXP192, VBUS_SESS_END,	        3, 2),
> +	INIT_REGMAP_IRQ(AXP192, LOW_PWR_LVL,	        3, 0),
> +	INIT_REGMAP_IRQ(AXP192, TIMER,			4, 7),
> +	INIT_REGMAP_IRQ(AXP192, GPIO2_INPUT,		4, 2),
> +	INIT_REGMAP_IRQ(AXP192, GPIO1_INPUT,		4, 1),
> +	INIT_REGMAP_IRQ(AXP192, GPIO0_INPUT,		4, 0),
> +};
> +
> +static int axp192_get_irq_reg(unsigned int base_reg, int i)

Nit: If you have to respin this set, please rename 'i'.

Unless used as an iterator, 'i' is a terrible variable name.

> +{
> +	/* linear mapping for IRQ1 to IRQ4 */
> +	if (i < 4)
> +		return base_reg + i;
> +
> +	/* handle IRQ5 separately */
> +	if (base_reg == AXP192_IRQ1_EN)
> +		return AXP192_IRQ5_EN;
> +	else
> +		return AXP192_IRQ5_STATE;
> +}
> +
>  static const struct regmap_irq axp20x_regmap_irqs[] = {
>  	INIT_REGMAP_IRQ(AXP20X, ACIN_OVER_V,		0, 7),
>  	INIT_REGMAP_IRQ(AXP20X, ACIN_PLUGIN,		0, 6),
> @@ -514,6 +621,19 @@ static const struct regmap_irq_chip axp152_regmap_irq_chip = {
>  	.num_regs		= 3,
>  };
>  
> +static const struct regmap_irq_chip axp192_regmap_irq_chip = {
> +	.name			= "axp192_irq_chip",
> +	.status_base		= AXP192_IRQ1_STATE,
> +	.ack_base		= AXP192_IRQ1_STATE,
> +	.mask_base		= AXP192_IRQ1_EN,
> +	.mask_invert		= true,
> +	.init_ack_masked	= true,
> +	.irqs			= axp192_regmap_irqs,
> +	.num_irqs		= ARRAY_SIZE(axp192_regmap_irqs),
> +	.num_regs		= 5,
> +	.get_irq_reg		= axp192_get_irq_reg,
> +};
> +
>  static const struct regmap_irq_chip axp20x_regmap_irq_chip = {
>  	.name			= "axp20x_irq_chip",
>  	.status_base		= AXP20X_IRQ1_STATE,
> @@ -588,6 +708,30 @@ static const struct regmap_irq_chip axp809_regmap_irq_chip = {
>  	.num_regs		= 5,
>  };
>  
> +static const struct mfd_cell axp192_cells[] = {
> +	{
> +		.name		= "axp192-gpio",
> +		.of_compatible	= "x-powers,axp192-gpio",
> +		.num_resources	= ARRAY_SIZE(axp192_gpio_resources),
> +		.resources	= axp192_gpio_resources,
> +	}, {
> +		.name		= "axp20x-regulator",

Nit: Is it possible to put one line entries at the bottom?

And format like this:

    { .name = "axp20x-regulator" }

> +	}, {
> +		.name		= "axp192-adc",
> +		.of_compatible	= "x-powers,axp192-adc",
> +	}, {
> +		.name		= "axp20x-ac-power-supply",
> +		.of_compatible	= "x-powers,axp202-ac-power-supply",
> +		.num_resources	= ARRAY_SIZE(axp192_ac_power_supply_resources),
> +		.resources	= axp192_ac_power_supply_resources,
> +	}, {
> +		.name		= "axp20x-usb-power-supply",
> +		.of_compatible	= "x-powers,axp192-usb-power-supply",
> +		.num_resources	= ARRAY_SIZE(axp192_usb_power_supply_resources),
> +		.resources	= axp192_usb_power_supply_resources,
> +	}
> +};

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
