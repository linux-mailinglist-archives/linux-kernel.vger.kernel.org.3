Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6882A55C8F5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbiF0IKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 04:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233398AbiF0IKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 04:10:49 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7457F6172;
        Mon, 27 Jun 2022 01:10:48 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 1883C221D4;
        Mon, 27 Jun 2022 10:10:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1656317445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I2VAxSPrHm4atr5mS01AVBWDO/CW+jJR8HyKyYrpRcc=;
        b=IQ9CJ6rL6muD5kAIpenW6vu4duRtV/uY1jpJR+9FHnUtrYXjRFqbEujuiw9KK28VMychXv
        3rMq87zA2kMSWlVcS5++exhxs7ZSSEf6CMJZwZQrq0yav+HT6BInM4kf8fFhrSIxij5rTg
        wQMmcsuRYGUet5hEW/5VwMi43GFjGNg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 27 Jun 2022 10:10:41 +0200
From:   Michael Walle <michael@walle.cc>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com, lars@metafoo.de,
        rafael@kernel.org, quic_gurus@quicinc.com,
        sebastian.reichel@collabora.com, andy.shevchenko@gmail.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 13/16] pinctrl: Add AXP192 pin control driver
In-Reply-To: <20220618214009.2178567-14-aidanmacdonald.0x0@gmail.com>
References: <20220618214009.2178567-1-aidanmacdonald.0x0@gmail.com>
 <20220618214009.2178567-14-aidanmacdonald.0x0@gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <cafd8a40ad35dcf8a35350261af6031c@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As Linus suggested you could have a look at devm_gpio_regmap_register()
with a custom xlate() callback and some improvements. But I've never
worked with pinctrl so I might be wrong. See below.

> +static int axp192_gpio_get(struct gpio_chip *chip, unsigned int 
> offset)
> +{
> +	struct axp192_pctl *pctl = gpiochip_get_data(chip);
> +	const struct axp192_pctl_reg_info *reginfo = 
> &pctl->desc->in_regs[offset];
> +	unsigned int val;
> +	int ret;
> +
> +	ret = regmap_read(pctl->regmap, reginfo->reg, &val);
> +	if (ret)
> +		return ret;
> +
> +	return !!(val & reginfo->mask);
> +}

This should work.

> +
> +static int axp192_gpio_get_direction(struct gpio_chip *chip, unsigned
> int offset)
> +{
> +	struct axp192_pctl *pctl = gpiochip_get_data(chip);
> +	const struct axp192_pctl_reg_info *reginfo = 
> &pctl->desc->ctrl_regs[offset];
> +	const u8 *input_muxvals = 
> pctl->desc->functions[AXP192_FUNC_INPUT].muxvals;
> +	unsigned int val;
> +	int ret;
> +
> +	ret = regmap_read(pctl->regmap, reginfo->reg, &val);
> +	if (ret)
> +		return ret;
> +
> +	if ((val & reginfo->mask) == (input_muxvals[offset] <<
> (ffs(reginfo->mask) - 1)))
> +		return GPIO_LINE_DIRECTION_IN;

This isn't supported (yet) in gpio-regmap...

> +
> +	return GPIO_LINE_DIRECTION_OUT;
> +}
> +
> +static void axp192_gpio_set(struct gpio_chip *chip, unsigned int
> offset, int value)
> +{
> +	struct axp192_pctl *pctl = gpiochip_get_data(chip);
> +	const struct axp192_pctl_reg_info *reginfo = 
> &pctl->desc->out_regs[offset];
> +
> +	regmap_update_bits(pctl->regmap, reginfo->reg, reginfo->mask, value
> ? reginfo->mask : 0);
> +}
> +
> +static int axp192_gpio_direction_input(struct gpio_chip *chip,
> unsigned int offset)
> +{
> +	return pinctrl_gpio_direction_input(chip->base + offset);
> +}

..as well as this.

> +
> +static int axp192_gpio_direction_output(struct gpio_chip *chip,
> unsigned int offset, int value)
> +{
> +	chip->set(chip, offset, value);

Why don't you call pinctrl_gpio_direction_output() here?


I *think* what is needed for gpio-regmap to support this is:
  - support values and masks for the direction, for now, we
    only support single bits.
  - support the pinctrl_gpio_direction_{input,output} calls

-michael
