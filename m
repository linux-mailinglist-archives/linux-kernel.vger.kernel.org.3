Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E8A4EED94
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 14:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346039AbiDAM7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 08:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244229AbiDAM7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 08:59:13 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85649276817;
        Fri,  1 Apr 2022 05:57:23 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id A73BA22175;
        Fri,  1 Apr 2022 14:57:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1648817842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ii8bJFrSBBTNQOn9Hd5ysSOcsf0u0Vom9C20hgPfKt4=;
        b=l6Mc9TWypMsLH1SihE67EFm9g8ACmcZNyFsXurSEXmAVyaT+usNuAn1nZ7YrbnXyRENzIl
        8AVcrXDtdghjVNXA3XOgKQT7vvr8fPaFXXR2uuZ3hMTPM1McRl7mXHn8zB4aufoxpm1nEa
        t3HjoBnw2kG9WeQWQqME3BL8ZYDvPIM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 01 Apr 2022 14:57:21 +0200
From:   Michael Walle <michael@walle.cc>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] hwmon: add driver for the Microchip LAN966x SoC
In-Reply-To: <06ff3ca0-9d2b-205f-064d-24bcb86e5362@roeck-us.net>
References: <20220331162431.3648535-1-michael@walle.cc>
 <20220331162431.3648535-5-michael@walle.cc>
 <06ff3ca0-9d2b-205f-064d-24bcb86e5362@roeck-us.net>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <415334e3278a610bc603b316d4af6502@walle.cc>
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

Am 2022-03-31 19:28, schrieb Guenter Roeck:

>> +static int lan966x_hwmon_write_pwm_freq(struct device *dev, long val)
>> +{
>> +	struct lan966x_hwmon *hwmon = dev_get_drvdata(dev);
>> +
>> +	val = DIV_ROUND_CLOSEST(hwmon->clk_rate, val);
> 
> I must have looked at this for an hour, but I didn't see the problem.
> Sorry for that. Try writing "0" as new pwm frequency.

Ohh, and negative values..

I'll add a

if (val <= 0)
     return -EINVAL;

>> +static int lan966x_hwmon_enable(struct lan966x_hwmon *hwmon)
>> +{
>> +	unsigned int mask = SENSOR_CFG_SAMPLE_ENA |
>> +			    SENSOR_CFG_START_CAPTURE |
>> +			    SENSOR_CFG_CONTINIOUS_MODE |
>> +			    SENSOR_CFG_PSAMPLE_ENA;
>> +	unsigned int val;
>> +
>> +	/* enable continuous mode */
>> +	val = SENSOR_CFG_SAMPLE_ENA | SENSOR_CFG_CONTINIOUS_MODE;
>> +
> 
> I am curious: Why not as part of the assignment, similar to 'mask' ?

There was code to set the clock divider, but I've removed
it as the hardware has a sane default. That left just that one
line, but moving the comment above the declaration looked
weird.

Now thinking about it again, it might make sense to bring
back the code to set the clock divider in case someone
will fiddle around with it before the driver is probed.

#define LAN966X_PVT_CLK 1200000 /* 1.2 MHz */

/* set PVT clock to be between 1.15 and 1.25 MHz */
div = DIV_ROUND_CLOSEST(hwmon->clk_rate, LAN966X_PVT_CLK);
val |= FIELD_PREP(SENSOR_CFG_CLK_CFG, div);

>> +static int lan966x_hwmon_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct lan966x_hwmon *hwmon;
>> +	struct device *hwmon_dev;
>> +	int ret;
>> +
>> +	hwmon = devm_kzalloc(dev, sizeof(*hwmon), GFP_KERNEL);
>> +	if (!hwmon)
>> +		return -ENOMEM;
>> +
>> +	hwmon->clk = devm_clk_get(dev, NULL);
>> +	if (IS_ERR(hwmon->clk))
>> +		return dev_err_probe(dev, PTR_ERR(hwmon->clk),
>> +				     "failed to get clock\n");
>> +
>> +	ret = lan966x_clk_enable(dev, hwmon);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "failed to enable clock\n");
>> +
>> +	hwmon->clk_rate = clk_get_rate(hwmon->clk);
>> +
>> +	hwmon->regmap_pvt = lan966x_init_regmap(pdev, "pvt");
>> +	if (IS_ERR(hwmon->regmap_pvt))
>> +		return dev_err_probe(dev, PTR_ERR(hwmon->regmap_pvt),
>> +				     "failed to get regmap for PVT registers\n");
>> +
>> +	hwmon->regmap_fan = lan966x_init_regmap(pdev, "fan");
>> +	if (IS_ERR(hwmon->regmap_fan))
>> +		return dev_err_probe(dev, PTR_ERR(hwmon->regmap_fan),
>> +				     "failed to get regmap for fan registers\n");
>> +
>> +	hwmon_dev = devm_hwmon_device_register_with_info(&pdev->dev,
>> +				"lan966x_hwmon", hwmon,
>> +				&lan966x_hwmon_chip_info, NULL);
>> +	if (IS_ERR(hwmon_dev))
>> +		return dev_err_probe(dev, PTR_ERR(hwmon_dev),
>> +				     "failed to register hwmon device\n");
>> +
>> +	return lan966x_hwmon_enable(hwmon);
> 
> Since I am nitpicking: It may make sense to call this function before
> registering the hwmon device, and it may make sense to disable sampling
> when unloading the driver (you could trigger that by calling
> devm_add_action_or_reset() from lan966x_hwmon_enable).

sure

-michael
