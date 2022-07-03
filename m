Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB65F564723
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 13:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbiGCL0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 07:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbiGCL0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 07:26:39 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9E295B8;
        Sun,  3 Jul 2022 04:26:38 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id m184so3835799wme.1;
        Sun, 03 Jul 2022 04:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:from:to:cc:subject:in-reply-to:date:message-id
         :mime-version;
        bh=y8JsYVvjrg3nX9Y9fVIfnji/DXIDBrBrl79jkU1TvKU=;
        b=IGuIFHB+7c7eCSBqB3HdiS16/ssQSIiRjeDQkRGLTFQinjaZhsaCrxLLLgJtTmxVCB
         wHvVqrLQWUYSHpLIvA2fyDG/7DDhz78XqMjSDbw0+kKI7NsT/b5gCmqxjopREAi81kK8
         2ZRG048rWue8DT28p2NbXPdsCN1aNwK66XM+lwHoEew4w5WP24lFcAGLw4zbsiO7XmU1
         Z/CgCIX0oD31/KiE+6j7fB6NkJZDDPnjxg4WZDdBru+ZcytfPb2jYy1R56hlMYlGQYfP
         KI6KPvRsN1+qPY0EnfOpsCGlx4PduvLdUon3okM8HldTwGT4fKpEcYYt3DSfWgraZrLr
         u05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=y8JsYVvjrg3nX9Y9fVIfnji/DXIDBrBrl79jkU1TvKU=;
        b=4XU/j6qVAYOli80P6VdB9YO6O68hElClq1kW116QXgt5cPfpTarW+3JfbtZsuxPBUt
         xrr1PDeSwpk5jjiYm9a1wYasiZCYOuneISV0u2vz3wEWnKnPpdXvlRX/00AZu8ZvODUk
         g7f+1KQnLgtPbe+bcI1NVhLAbaoa5eul7dKDI8ceIOpZ600Mi0cknlEieEsNot4FEfVU
         3sT664iuMMhaZKtyl3j1oN/0bWhgF+oaJ44uBTk/GxU3NhjDdJHaq0U9GzeO34CQG8eL
         tKqH+OD+liSd+wIW7I5qyaF8d/RujoL0D49OFin11Ac9O7uSgMnBLuH4e+iVbMYq1yWX
         eL/A==
X-Gm-Message-State: AJIora+IG8gXwAWvFKFLYARHhv1ObHmOqJP1nuGolgUeWjQ7oT0wYiLo
        zf6LakZnTGE9UFQpMoyneD8=
X-Google-Smtp-Source: AGRyM1v6QL7OjuVE6xLHx03p+2vy4QZhGP+nZtS496B+gM5MOIGkydAO/Cfqk6NlDuuk8F8/xC7uew==
X-Received: by 2002:a05:600c:154c:b0:3a1:884e:72ac with SMTP id f12-20020a05600c154c00b003a1884e72acmr16618750wmg.23.1656847597004;
        Sun, 03 Jul 2022 04:26:37 -0700 (PDT)
Received: from localhost (92.40.202.1.threembb.co.uk. [92.40.202.1])
        by smtp.gmail.com with ESMTPSA id n15-20020a05600c4f8f00b003a1980d55c4sm4354395wmq.47.2022.07.03.04.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 04:26:36 -0700 (PDT)
References: <20220629143046.213584-1-aidanmacdonald.0x0@gmail.com>
 <20220629143046.213584-13-aidanmacdonald.0x0@gmail.com>
 <37d40cf2-4512-754f-2e44-ee1449bc2e9f@sholland.org>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     wens@csie.org, linus.walleij@linaro.org, brgl@bgdev.pl,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jic23@kernel.org, sre@kernel.org, lee.jones@linaro.org,
        lgirdwood@gmail.com, broonie@kernel.org, lars@metafoo.de,
        quic_gurus@quicinc.com, sebastian.reichel@collabora.com,
        andy.shevchenko@gmail.com, michael@walle.cc, rdunlap@infradead.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 12/15] pinctrl: Add AXP192 pin control driver
In-reply-to: <37d40cf2-4512-754f-2e44-ee1449bc2e9f@sholland.org>
Date:   Sun, 03 Jul 2022 12:27:44 +0100
Message-ID: <CeGWHuCl1EmopK1ddAnah2VepohGrPTq@localhost>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Samuel Holland <samuel@sholland.org> writes:

> On 6/29/22 9:30 AM, Aidan MacDonald wrote:
>> The AXP192 PMIC's GPIO registers are much different from the GPIO
>> registers of the AXP20x and AXP813 PMICs supported by the existing
>> pinctrl-axp209 driver. It makes more sense to add a new driver for
>> the AXP192, rather than add support in the existing axp20x driver.
>> 
>> The pinctrl-axp192 driver is considerably more flexible in terms of
>> register layout and should be able to support other X-Powers PMICs.
>> Interrupts and pull down resistor configuration are supported too.
>
> I am planning to implement gpio/pinctrl support for AXP152[1], which is
> somewhere between AXP20x and AXP192 in terms of GPIO capability.
>
> Which driver should I add it to? How much work would it be to convert AXP20x
> variants to the new driver? And if supporting other X-Powers PMICs is the plan,
> would it make sense to convert the existing driver in-place to avoid dealing
> with Kconfig migrations?
>
> [1]: https://linux-sunxi.org/AXP152
>

I'd assume variants getting new GPIO support would be better off using
this driver. The existing one supports only AXP209 and AXP803/813, and
it hardcodes far too many details.

I'll let the maintainers decide whether converting the existing driver
is better than dealing with possible future migrations. If conversion
is the way to go then I'll drop this patch and revisit GPIO support at
a later date.

>> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
>> ---
>>  drivers/pinctrl/Kconfig          |  13 +
>>  drivers/pinctrl/Makefile         |   1 +
>>  drivers/pinctrl/pinctrl-axp192.c | 598 +++++++++++++++++++++++++++++++
>>  3 files changed, 612 insertions(+)
>>  create mode 100644 drivers/pinctrl/pinctrl-axp192.c
>> [...]
>> +static int axp192_pinconf_get(struct pinctrl_dev *pctldev, unsigned int pin, unsigned long *config)
>> +{
>> +	enum pin_config_param param = pinconf_to_config_param(*config);
>> +	unsigned int arg = 1;
>> +	bool pull_down;
>> +	int ret;
>> +
>> +	switch (param) {
>> +	case PIN_CONFIG_BIAS_DISABLE:
>> +		ret = axp192_pinconf_get_pull_down(pctldev, pin, &pull_down);
>> +		if (ret)
>> +			return ret;
>> +		if (pull_down)
>> +			return -EINVAL;
>> +		break;
>> +
>> +	case PIN_CONFIG_BIAS_PULL_DOWN:
>> +		ret = axp192_pinconf_get_pull_down(pctldev, pin, &pull_down);
>> +		if (ret)
>> +			return ret;
>> +		if (!pull_down)
>> +			return -EINVAL;
>> +		break;
>> +
>> +	default:
>> +		return -ENOTSUPP;
>> +	}
>> +
>> +	*config = pinconf_to_config_packed(param, arg);
>> +	return 0;
>> +}
>> +
>> +static int axp192_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
>> +			      unsigned long *configs, unsigned int num_configs)
>> +{
>> +	int ret;
>> +	unsigned int cfg;
>> +
>> +	for (cfg = 0; cfg < num_configs; cfg++) {
>> +		switch (pinconf_to_config_param(configs[cfg])) {
>> +		case PIN_CONFIG_BIAS_DISABLE:
>> +			ret = axp192_pinconf_set_pull_down(pctldev, pin, 0);
>> +			if (ret)
>> +				return ret;
>> +			break;
>> +
>> +		case PIN_CONFIG_BIAS_PULL_DOWN:
>> +			ret = axp192_pinconf_set_pull_down(pctldev, pin, 1);
>> +			if (ret)
>> +				return ret;
>> +			break;
>> +
>> +		default:
>> +			return -ENOTSUPP;
>
> The GPIO outputs are always open-drain. It looks like this needs to handle
> PIN_CONFIG_DRIVE_OPEN_DRAIN, or gpiolib will try to emulate it.
>
> And I would suggest returning -EINVAL for PIN_CONFIG_DRIVE_PUSH_PULL, but
> gpiolib does not check the return value when setting that.
>

You're right, thanks for pointing that out... guess I should actually
read the documentation sometimes!

>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> [...]
>> +
>> +static int axp192_pctl_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct axp20x_dev *axp20x = dev_get_drvdata(dev->parent);
>> +	struct axp192_pctl *pctl;
>> +	struct pinctrl_desc *pctrl_desc;
>> +	int ret, i;
>> +
>> +	pctl = devm_kzalloc(dev, sizeof(*pctl), GFP_KERNEL);
>> +	if (!pctl)
>> +		return -ENOMEM;
>> +
>> +	pctl->desc = device_get_match_data(dev);
>> +	pctl->regmap = axp20x->regmap;
>> +	pctl->regmap_irqc = axp20x->regmap_irqc;
>> +	pctl->dev = dev;
>> +
>> +	pctl->chip.base			= -1;
>> +	pctl->chip.can_sleep		= true;
>> +	pctl->chip.request		= gpiochip_generic_request;
>> +	pctl->chip.free			= gpiochip_generic_free;
>> +	pctl->chip.parent		= dev;
>> +	pctl->chip.label		= dev_name(dev);
>> +	pctl->chip.owner		= THIS_MODULE;
>> +	pctl->chip.get			= axp192_gpio_get;
>> +	pctl->chip.get_direction	= axp192_gpio_get_direction;
>> +	pctl->chip.set			= axp192_gpio_set;
>> +	pctl->chip.direction_input	= axp192_gpio_direction_input;
>> +	pctl->chip.direction_output	= axp192_gpio_direction_output;
>> +	pctl->chip.to_irq		= axp192_gpio_to_irq;
>> +	pctl->chip.ngpio		= pctl->desc->npins;
>> +
>> +	pctl->irqs = devm_kcalloc(dev, pctl->desc->npins, sizeof(int), GFP_KERNEL);
>> +	if (!pctl->irqs)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < pctl->desc->npins; i++) {
>> +		ret = platform_get_irq_byname_optional(pdev, pctl->desc->pins[i].name);
>> +		if (ret > 0)
>> +			pctl->irqs[i] = ret;
>> +	}
>> +
>> +	platform_set_drvdata(pdev, pctl);
>> +
>> +	pctrl_desc = devm_kzalloc(dev, sizeof(*pctrl_desc), GFP_KERNEL);
>> +	if (!pctrl_desc)
>> +		return -ENOMEM;
>
> This can go inside struct axp192_pctl. It does not need a separate allocation.
>
> Regards,
> Samuel

