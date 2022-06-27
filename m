Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CB355C131
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234319AbiF0NSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234978AbiF0NS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:18:29 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD67CF0;
        Mon, 27 Jun 2022 06:18:26 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z19so12935149edb.11;
        Mon, 27 Jun 2022 06:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:from:to:cc:subject:date:in-reply-to:message-id
         :mime-version;
        bh=bYTHdHMf3jC1jHl9DPaG8LW+XxhPJYraR1ILnGyaWRE=;
        b=f7txa/JvespsDWBSVg8Ll3tCX6K3cgmKj2lHck8JsGumPgcNxcfqJbch+A/UMBa4Sn
         mUWOW5Rpz/SqzZaGRqMUi05ujw2jA3MImbffJFCiSIQdl+50++0mfL4sh5okGmDJ7Bx/
         oCfMm9fKe+6lJt4PMnhjSB4VuJ5D8y5ApzQT1zVxl30i1jOMykW017Dw9qoux3qPQJVF
         3juShRUsDYWYYKWBJzOWmMJ+jrRhF3lk9h6eEd0W7xcZLDK+9V1Bbq09XFETPfC2UGpP
         J8MAl41OEORRjiElAHKikKzOjbCxPizi5JSBNYfxCtycR6gt7OJjJkRfJcNeQyF7ZoAh
         fNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=bYTHdHMf3jC1jHl9DPaG8LW+XxhPJYraR1ILnGyaWRE=;
        b=IhPlyBoxTZ8nrVWUYm2xJ21GvbR0vrtmuPWNEGrHINu8OEmJDUoxzyk+DbtbbAPBRq
         uaDi3d9dxtncBiHj1KJU8bxFxfvCfghPdbh8Bs0Na3uRiad24ocvFlOTGKcapUMLse+R
         5OdUXd+We5Ogxg3ZuBFLKsERbOn1RBJgJ2L1N+PCXdFwE3/nPFenHfFPuhPfWbScZ38Z
         b0LNaR/Rv0SDrV3YS/Zj7O7gJ/rg5ikuXOlMJJHHYBWmTwtS/hiLEtbu9OxDYO4KPUxT
         2P7YT7nOzZ0P4Dn1U5bwssyMRf8CJuaKq/Hq2IsS6rShLYd2LAGu9Tf4wzcA7Ol/eKlD
         WWXA==
X-Gm-Message-State: AJIora9SOzTFWGf8WJI1BwOla1rB6cpDS47qLbRQCRMUwOC7HUXvqpfs
        TOSrrjUK+Rr4uNs4av46iiw=
X-Google-Smtp-Source: AGRyM1sOiuU691m9UNqKILrcF++Me1UMVhCLagzUfxoYS+ZZ9h9DjZQudKSBeU5wzuC1B2KMFg4l+A==
X-Received: by 2002:a05:6402:84a:b0:426:262d:967e with SMTP id b10-20020a056402084a00b00426262d967emr16126132edz.286.1656335905115;
        Mon, 27 Jun 2022 06:18:25 -0700 (PDT)
Received: from localhost (92.40.170.45.threembb.co.uk. [92.40.170.45])
        by smtp.gmail.com with ESMTPSA id g3-20020a170906594300b006f3ef214daesm5014147ejr.20.2022.06.27.06.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 06:18:24 -0700 (PDT)
References: <20220618214009.2178567-1-aidanmacdonald.0x0@gmail.com>
 <20220618214009.2178567-14-aidanmacdonald.0x0@gmail.com>
 <cafd8a40ad35dcf8a35350261af6031c@walle.cc>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Michael Walle <michael@walle.cc>
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
Date:   Mon, 27 Jun 2022 14:12:58 +0100
In-reply-to: <cafd8a40ad35dcf8a35350261af6031c@walle.cc>
Message-ID: <me4ummrWKIPseIG4ay7yCfrumN8sIdvc@localhost>
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


Michael Walle <michael@walle.cc> writes:

> Hi,
>
> As Linus suggested you could have a look at devm_gpio_regmap_register()
> with a custom xlate() callback and some improvements. But I've never
> worked with pinctrl so I might be wrong. See below.
>
>> +static int axp192_gpio_get(struct gpio_chip *chip, unsigned int offset)
>> +{
>> +	struct axp192_pctl *pctl = gpiochip_get_data(chip);
>> +	const struct axp192_pctl_reg_info *reginfo = &pctl->desc->in_regs[offset];
>> +	unsigned int val;
>> +	int ret;
>> +
>> +	ret = regmap_read(pctl->regmap, reginfo->reg, &val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return !!(val & reginfo->mask);
>> +}
>
> This should work.
>
>> +
>> +static int axp192_gpio_get_direction(struct gpio_chip *chip, unsigned
>> int offset)
>> +{
>> +	struct axp192_pctl *pctl = gpiochip_get_data(chip);
>> +	const struct axp192_pctl_reg_info *reginfo =
>> &pctl->desc->ctrl_regs[offset];
>> +	const u8 *input_muxvals = pctl->desc->functions[AXP192_FUNC_INPUT].muxvals;
>> +	unsigned int val;
>> +	int ret;
>> +
>> +	ret = regmap_read(pctl->regmap, reginfo->reg, &val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if ((val & reginfo->mask) == (input_muxvals[offset] <<
>> (ffs(reginfo->mask) - 1)))
>> +		return GPIO_LINE_DIRECTION_IN;
>
> This isn't supported (yet) in gpio-regmap...
>
>> +
>> +	return GPIO_LINE_DIRECTION_OUT;
>> +}
>> +
>> +static void axp192_gpio_set(struct gpio_chip *chip, unsigned int
>> offset, int value)
>> +{
>> +	struct axp192_pctl *pctl = gpiochip_get_data(chip);
>> +	const struct axp192_pctl_reg_info *reginfo = &pctl->desc->out_regs[offset];
>> +
>> +	regmap_update_bits(pctl->regmap, reginfo->reg, reginfo->mask, value
>> ? reginfo->mask : 0);
>> +}
>> +
>> +static int axp192_gpio_direction_input(struct gpio_chip *chip,
>> unsigned int offset)
>> +{
>> +	return pinctrl_gpio_direction_input(chip->base + offset);
>> +}
>
> ..as well as this.
>
>> +
>> +static int axp192_gpio_direction_output(struct gpio_chip *chip,
>> unsigned int offset, int value)
>> +{
>> +	chip->set(chip, offset, value);
>
> Why don't you call pinctrl_gpio_direction_output() here?

Probably because I copied this from pinctrl-axp209. I'll fix it in
the next version.

>
>
> I *think* what is needed for gpio-regmap to support this is:
>  - support values and masks for the direction, for now, we
>    only support single bits.
>  - support the pinctrl_gpio_direction_{input,output} calls
>
> -michael

That sounds about right, thanks for taking a look.
