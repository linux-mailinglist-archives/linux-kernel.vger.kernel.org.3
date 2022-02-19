Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE904BC610
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 07:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241372AbiBSGrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 01:47:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbiBSGq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 01:46:58 -0500
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF4A51E52;
        Fri, 18 Feb 2022 22:46:35 -0800 (PST)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 25D8D41905;
        Sat, 19 Feb 2022 11:46:31 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1645253192; bh=lnldBt2/lTX1IYFuV+p84jRTjimuSd8iLwXPT/3fEp4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GO0SppYvdaTnx+df9OVivsd1qnxCjBO76hePIM7CkOPGyspGViWDAtiW+yODjiuRp
         N/B2YrUuR48gyxyLGmXypyJWWCWafEdFkYmry5AqwyYPePlvcUUXfg+kIVHjhM57BU
         j0vVSqT6EXCTRl/VvkM4oDOy5xk31TvFHsKNuvN/i2pmejKJMZFIsRatpU6YTLrTYw
         0NegAasMVnYroc2Fm1c6Zf0Wd5kkCTsqhpPYDbmPg2D12jfTqVORKiOLqKi+KFF81n
         HUTWo8fiWVLITy6CFtjhwzNMVdkXOqipCzphhFIs65VmR2cmXdfciKoKV9Nnoh6hmk
         XYGs1F6k88u1g==
MIME-Version: 1.0
Date:   Sat, 19 Feb 2022 11:46:31 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org,
        sboyd@kernel.org, krzk@kernel.org, linus.walleij@linaro.org,
        masneyb@onstation.org, sean.anderson@seco.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v5 2/2] pwm: Add clock based PWM output driver
In-Reply-To: <20220214184320.ym36pfvozwdp5nbb@pengutronix.de>
References: <20220212162342.72646-1-nikita@trvn.ru>
 <20220212162342.72646-3-nikita@trvn.ru>
 <20220214184320.ym36pfvozwdp5nbb@pengutronix.de>
Message-ID: <425691dbe49115f04dbe89c158bf6d1c@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Uwe Kleine-König писал(а) 14.02.2022 23:43:
> On Sat, Feb 12, 2022 at 09:23:42PM +0500, Nikita Travkin wrote:
>> Some systems have clocks exposed to external devices. If the clock
>> controller supports duty-cycle configuration, such clocks can be used as
>> pwm outputs. In fact PWM and CLK subsystems are interfaced with in a
>> similar way and an "opposite" driver already exists (clk-pwm). Add a
>> driver that would enable pwm devices to be used via clk subsystem.
>>
>> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
>> --
>>
>> Changes in v2:
>>  - Address Uwe's review comments:
>>    - Round set clk rate up
>>    - Add a description with limitations of the driver
>>    - Disable and unprepare clock before removing pwmchip
>> Changes in v3:
>>  - Use 64bit version of div round up
>>  - Address Uwe's review comments:
>>    - Reword the limitations to avoid incorrect claims
>>    - Move the clk_enabled flag assignment
>>    - Drop unnecessary statements
>> Changes in v5:
>>  - add missed returns
>> ---
>>  drivers/pwm/Kconfig   |  10 +++
>>  drivers/pwm/Makefile  |   1 +
>>  drivers/pwm/pwm-clk.c | 139 ++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 150 insertions(+)
>>  create mode 100644 drivers/pwm/pwm-clk.c
>>
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index 21e3b05a5153..daa2491a4054 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -140,6 +140,16 @@ config PWM_BRCMSTB
>>  	  To compile this driver as a module, choose M Here: the module
>>  	  will be called pwm-brcmstb.c.
>>
>> +config PWM_CLK
>> +	tristate "Clock based PWM support"
>> +	depends on HAVE_CLK || COMPILE_TEST
>> +	help
>> +	  Generic PWM framework driver for outputs that can be
>> +	  muxed to clocks.
>> +
>> +	  To compile this driver as a module, choose M here: the module
>> +	  will be called pwm-clk.
>> +
>>  config PWM_CLPS711X
>>  	tristate "CLPS711X PWM support"
>>  	depends on ARCH_CLPS711X || COMPILE_TEST
>> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
>> index 708840b7fba8..4a860103c470 100644
>> --- a/drivers/pwm/Makefile
>> +++ b/drivers/pwm/Makefile
>> @@ -10,6 +10,7 @@ obj-$(CONFIG_PWM_BCM_KONA)	+= pwm-bcm-kona.o
>>  obj-$(CONFIG_PWM_BCM2835)	+= pwm-bcm2835.o
>>  obj-$(CONFIG_PWM_BERLIN)	+= pwm-berlin.o
>>  obj-$(CONFIG_PWM_BRCMSTB)	+= pwm-brcmstb.o
>> +obj-$(CONFIG_PWM_CLK)		+= pwm-clk.o
>>  obj-$(CONFIG_PWM_CLPS711X)	+= pwm-clps711x.o
>>  obj-$(CONFIG_PWM_CRC)		+= pwm-crc.o
>>  obj-$(CONFIG_PWM_CROS_EC)	+= pwm-cros-ec.o
>> diff --git a/drivers/pwm/pwm-clk.c b/drivers/pwm/pwm-clk.c
>> new file mode 100644
>> index 000000000000..e503337ad055
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-clk.c
>> @@ -0,0 +1,139 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Clock based PWM controller
>> + *
>> + * Copyright (c) 2021 Nikita Travkin <nikita@trvn.ru>
>> + *
>> + * This is an "adapter" driver that allows PWM consumers to use
>> + * system clocks with duty cycle control as PWM outputs.
>> + *
>> + * Limitations:
>> + * - Glitches are possible when new pwm state is applied.
>> + * - Due to the fact that exact behavior depends on the underlying
>> + *   clock driver, various limitations are possible.
>> + * - Period depends on the clock and, in general, not guaranteed.
> 
> This sentence is broken.
> 

Here what I mean is that the clock driver might e.g. have a lookup table
for some rates and will only set one close to the requested ones.
(Extreme scenario is that only one rate is allowed in the lookup table,
which is a real possibility for some platforms that I think this driver
will be used with, the lookup may need to be changed for those clocks)

I will reword this like:

  Some clock drivers may only pick the closest available rate
  and not the exact requested one. Because of this, exact period
  is not guaranteed.

Thanks,
Nikita

>> + * - Underlying clock may not be able to give 0% or 100% duty cycle
>> + *   (constant off or on), exact behavior will depend on the clock.
>> + * - When the PWM is disabled, the clock will be disabled as well,
>> + *   line state will depend on the clock.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/math64.h>
>> +#include <linux/err.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/clk.h>
>> +#include <linux/pwm.h>
>> +
>> +struct pwm_clk_chip {
>> +	struct pwm_chip chip;
>> +	struct clk *clk;
>> +	bool clk_enabled;
>> +};
>> +
>> +#define to_pwm_clk_chip(_chip) container_of(_chip, struct pwm_clk_chip, chip)
>> +
>> +static int pwm_clk_apply(struct pwm_chip *pwm_chip, struct pwm_device *pwm,
>> +			 const struct pwm_state *state)
>> +{
>> +	struct pwm_clk_chip *chip = to_pwm_clk_chip(pwm_chip);
>> +	int ret;
>> +	u32 rate;
>> +	u64 period = state->period;
>> +	u64 duty_cycle = state->duty_cycle;
>> +
>> +	if (!state->enabled) {
>> +		if (pwm->state.enabled) {
>> +			clk_disable(chip->clk);
>> +			chip->clk_enabled = false;
>> +		}
>> +		return 0;
>> +	} else if (!pwm->state.enabled) {
>> +		ret = clk_enable(chip->clk);
>> +		if (ret)
>> +			return ret;
>> +		chip->clk_enabled = true;
>> +	}
>> +
>> +	rate = DIV64_U64_ROUND_UP(NSEC_PER_SEC, period);
>> +	ret = clk_set_rate(chip->clk, rate);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (state->polarity == PWM_POLARITY_INVERSED)
>> +		duty_cycle = period - duty_cycle;
>> +
>> +	return clk_set_duty_cycle(chip->clk, duty_cycle, period);
>> +}
>> +
>> +static const struct pwm_ops pwm_clk_ops = {
>> +	.apply = pwm_clk_apply,
>> +	.owner = THIS_MODULE,
>> +};
>> +
>> +static int pwm_clk_probe(struct platform_device *pdev)
>> +{
>> +	struct pwm_clk_chip *chip;
>> +	int ret;
>> +
>> +	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
>> +	if (!chip)
>> +		return -ENOMEM;
>> +
>> +	chip->clk = devm_clk_get(&pdev->dev, NULL);
>> +	if (IS_ERR(chip->clk))
>> +		return dev_err_probe(&pdev->dev, PTR_ERR(chip->clk),
>> +				     "Failed to get clock\n");
>> +
>> +	chip->chip.dev = &pdev->dev;
>> +	chip->chip.ops = &pwm_clk_ops;
>> +	chip->chip.npwm = 1;
>> +
>> +	ret = clk_prepare(chip->clk);
>> +	if (ret < 0)
>> +		return dev_err_probe(&pdev->dev, ret, "Failed to prepare clock\n");
>> +
>> +	ret = pwmchip_add(&chip->chip);
>> +	if (ret < 0)
>> +		return dev_err_probe(&pdev->dev, ret, "Failed to add pwm chip\n");
> 
> As was already pointed out, here is some error cleanup necessary.
> 
>> +	platform_set_drvdata(pdev, chip);
>> +	return 0;
>> +}
> 
> Otherwise looks good.
> 
> Best regards
> Uwe
