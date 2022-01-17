Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 224FD491004
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 19:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242104AbiAQSEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 13:04:44 -0500
Received: from box.trvn.ru ([194.87.146.52]:39163 "EHLO box.trvn.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242087AbiAQSEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 13:04:38 -0500
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 101FF45EDC;
        Mon, 17 Jan 2022 23:04:32 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1642442673; bh=QMgn3883Vj40c51WcOItePF7ohpCGTVuIipsCzLqM7g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wtVeNSEeIPaHY+S9qblTmzcduywjvYSp6tL8V9i5ry/6iPw1gttRVN1llxLUNGvDH
         MA6PXA/WfvE5I6df9kF836jUmqfkBGH12D30Fi3aFty+Mr0uYX1uya2SynO3ce7MVs
         dAEekic/SonJxmNGGZXPtt5dvD8/KE84LLjQy6lv8hjibiRb5yU6VaH4/tsLtq22XM
         O4XHw6/++o9h2v5UCZTE6nS43xAi8GUCBGioRdiTzvydOCwXdI5XuCL2miCfhFUhm5
         MXHWttrdA1NWCLj9sS0Xq/hFMvQNUQaR1S/0adiwmACKy9RKBjCRREf+3y8GcEG34s
         oneqhpvyZcYaw==
MIME-Version: 1.0
Date:   Mon, 17 Jan 2022 23:04:31 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org,
        sboyd@kernel.org, linus.walleij@linaro.org, masneyb@onstation.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 2/2] pwm: Add clock based PWM output driver
In-Reply-To: <20220117155817.4bu2zwpjijtwlfvi@pengutronix.de>
References: <20211213150335.51888-1-nikita@trvn.ru>
 <20211213150335.51888-3-nikita@trvn.ru>
 <20220117155817.4bu2zwpjijtwlfvi@pengutronix.de>
Message-ID: <b3add53c417506044a8e13c4bbf84ced@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Uwe Kleine-König писал(а) 17.01.2022 20:58:
> Hello,
> 
> On Mon, Dec 13, 2021 at 08:03:35PM +0500, Nikita Travkin wrote:
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
>> ---
>>  drivers/pwm/Kconfig   |  10 +++
>>  drivers/pwm/Makefile  |   1 +
>>  drivers/pwm/pwm-clk.c | 143 ++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 154 insertions(+)
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
>> index 000000000000..55fd320b9c19
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-clk.c
>> @@ -0,0 +1,143 @@
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
>> + * - There is no way to atomically set both clock rate and
>> + *   duty-cycle so glitches are possible when new pwm state
>> + *   is applied.
>> + * - Period depends on the underlying clock driver and,
>> + *   in general, not guaranteed.
>> + * - Underlying clock may not be able to give 100%
>> + *   duty cycle (constant on) and only set the closest
>> + *   possible duty cycle. (e.g. 99.9%)
> 
> What about 0%?

You're right, this is also a problematic case that I should've
mentioned here. In fact I *did* have problems with zero written
into the duty cycle register of my clock. I decided that it
should be solved by the hardware driver so I sent a patch
with a zero check there. (As otherwise there might be a clock
that would properly support 0% and 100% cycles so making the
write like this impossible is not a job of this driver I think)

> 
>  - Periods are not completed on changes in general.

I suppose I should reword the limitation, dropping
the reference to impossible atomic operations and
just state that glitches are inevitable.

>  - Behaviour on disable depends on the underlaying clk, don't assume it
>    to provide the inactive level.
> 

Hm, now thinking of it, I'm not sure if the clock line
was set to logic 0 or was left floating (which is what I assume
you mean by the undefined behavior here) on the clock I was
debugging this on with an oscilloscope. (nor am I sure
if I even can make such a conclusion by looking at that...)

Do you think that this should be just documented in the
limitations? Like:

  - Underlying clock may not be able to give 0% or 100%
    duty cycle (constant off or on) and only set the
    closest possible duty cycle. (e.g. 0.1% or 99.9%)
  - When the PWM is disabled, the clock will be disabled
    as well. User should take care of properly pulling 
    the line down in case the disabled clock leaves it
    floating.

(I guess here I'm making an assumption that there is
no clock that will be set to logic 1 upon being disabled
without the way to change that behavior...)

>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/err.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
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
>> +		chip->clk_enabled = true;
>> +		if (ret)
>> +			return ret;
> 
> if clk_enable() failed better don't set chip->clk_enabled = true;
> 

Will move it after the check.

>> +	}
>> +
>> +	rate = DIV_ROUND_UP(NSEC_PER_SEC, period);
>> +	ret = clk_set_rate(chip->clk, rate);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (state->polarity == PWM_POLARITY_INVERSED)
>> +		duty_cycle = period - duty_cycle;
>> +
>> +	ret = clk_set_duty_cycle(chip->clk, duty_cycle, period);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return ret;
> 
> This can be simplified to
> 
> 	return clk_set_duty_cycle(chip->clk, duty_cycle, period);
> 

Will do.

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
>> +		return dev_err_probe(&pdev->dev, PTR_ERR(chip->clk), "Failed to get clock\n");
>> +
>> +	chip->chip.dev = &pdev->dev;
>> +	chip->chip.ops = &pwm_clk_ops;
>> +	chip->chip.of_xlate = of_pwm_xlate_with_flags;
>> +	chip->chip.of_pwm_n_cells = 2;
> 
> I'd just skip those two assignments. These are the default, anyhow.
> (Assuming you have #pwm-cells = <2> in the device tree.)
> 

Right, now I see that the core sets those and I force the
#pwm-cells = <2> via the dt bindings. Will drop.

Thanks for the comments! I will send a v3 with the changes
slightly later

Nikita

>> +	chip->chip.npwm = 1;
>> +
>> +	ret = clk_prepare(chip->clk);
>> +	if (ret < 0)
>> +		dev_err_probe(&pdev->dev, ret, "Failed to prepare clock\n");
>> +
>> +	ret = pwmchip_add(&chip->chip);
>> +	if (ret < 0)
>> +		dev_err_probe(&pdev->dev, ret, "Failed to add pwm chip\n");
>> +
>> +	platform_set_drvdata(pdev, chip);
>> +	return 0;
>> +}
> 
> Best regards
> Uwe
