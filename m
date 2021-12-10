Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1479A470156
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 14:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241559AbhLJNRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 08:17:16 -0500
Received: from box.trvn.ru ([194.87.146.52]:43523 "EHLO box.trvn.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233989AbhLJNRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 08:17:15 -0500
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 4B51A4053A;
        Fri, 10 Dec 2021 18:13:36 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1639142016; bh=pK1M/t/sY4fla6jXwDiVKaRFOO2LDAUt0L7rffYAKgs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=obhckQIEHMz66HQ++4ollDHyhf93JhGulMEb5v/dWdw+t6xKn6Xzppmt32WRKASdx
         0OUcWLLaGr3PGoA1fWA4fBGFnUV/Ziae9WQvQy2WblGDwIDnWSND4zWbkJ1y/VCEBb
         WKCaTv3PiQc0b8h3hROsPIdS0MHWG1dHEILQKxAQgnVALRwVWzKhmKg6OfwbMtg21D
         5PhkHjvkeAmaeDaAKvrsWuwELc3qCKYaQcP1VxWIghxnIvQOnBBF8SfFpJ35CN5yZ3
         5z2yo+PyRym0KoE111st7tl+Tswa6/zuXtTWQMMO13X2LlInFro/WOB8EKyGBVUt2a
         WGvEyHnJ4LegQ==
MIME-Version: 1.0
Date:   Fri, 10 Dec 2021 18:13:34 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org,
        sboyd@kernel.org, linus.walleij@linaro.org, masneyb@onstation.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, kernel@pengutronix.de,
        pza@pengutronix.de
Subject: Re: [PATCH 2/2] pwm: Add clock based PWM output driver
In-Reply-To: <20211209220521.ho54edpxedzffdl4@pengutronix.de>
References: <20211209162020.105255-1-nikita@trvn.ru>
 <20211209162020.105255-3-nikita@trvn.ru>
 <20211209220521.ho54edpxedzffdl4@pengutronix.de>
Message-ID: <2d88f192dfbf1fdc1c5bbb23cf85857e@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the review!

Uwe Kleine-König писал(а) 10.12.2021 03:05:
> Hello,
> 
> On Thu, Dec 09, 2021 at 09:20:20PM +0500, Nikita Travkin wrote:
>> +#define to_pwm_clk_chip(_chip) container_of(_chip, struct pwm_clk_chip, chip)
>> +
>> +static int pwm_clk_apply(struct pwm_chip *pwm_chip, struct pwm_device *pwm,
>> +			 const struct pwm_state *state)
>> +{
>> +	struct pwm_clk_chip *chip = to_pwm_clk_chip(pwm_chip);
>> +	int ret;
>> +	u32 rate;
>> +
>> +	if (!state->enabled && !pwm->state.enabled)
>> +		return 0;
>> +
>> +	if (state->enabled && !pwm->state.enabled) {
>> +		ret = clk_enable(chip->clk);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	if (!state->enabled && pwm->state.enabled) {
>> +		clk_disable(chip->clk);
>> +		return 0;
>> +	}
> 
> This can be written a bit more compact as:
> 
> 	if (!state->enabled) {
> 		if (pwm->state.enabled)
> 			clk_disable(chip->clk);
> 		return 0;
> 	} else if (!pwm->state.enabled) {
> 		ret = clk_enable(chip->clk);
> 		if (ret)
> 			return ret;
> 	}
> 
> personally I find my version also easier to read, but that might be
> subjective.
> 

Having three discrete checks for three possible outcomes is a bit
easier for me to understand, but I have no preference and can change
it to your version. 

> Missing handling for polarity. Either refuse inverted polarity, or set
> the duty_cycle to state->period - state->duty_cycle in the inverted
> case.

Will add the latter.

> 
>> +	rate = div64_u64(NSEC_PER_SEC, state->period);
> 
> Please round up here, as .apply() should never implement a period bigger
> than requested. This also automatically improves the behaviour if
> state->period > NSEC_PER_SEC.

Will do. I'm not sure if the underlying clock drivers guarantee the
chosen rate to be rounded in line with that however, e.g. qcom SoC
clocks that I target use lookup tables to find the closest rate
with known M/N config values and set that. (So unless one makes sure
the table has all the required rates, period is not guaranteed.)

This is not an issue for my use cases though: Don't think any
of the led or haptic motor controllers I've seen in my devices
need a perfect rate.

I think this is another line into the "Limitations" description
that was suggested later.

> 
>> +	ret = clk_set_rate(chip->clk, rate);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return clk_set_duty_cycle(chip->clk, state->duty_cycle, state->period);
> 
> Is it possible to enable only after the duty cycle is set? This way we
> could prevent in some cases that a wrong setting makes it to the output.
> 

Will move clk_enable() as the last action. After that it makes more
sense to "squash" two leftover checks for disabled state so will do
that as well.

... Except moving it caused a nice big WARNING from my clock controller...

[   76.353557] gcc_camss_gp1_clk status stuck at 'off'
[   76.353593] WARNING: CPU: 2 PID: 97 at drivers/clk/qcom/clk-branch.c:91 clk_branch_wait+0x144/0x160
(...)
[   76.571531] Call trace:
[   76.578644]  clk_branch_wait+0x144/0x160
[   76.580903]  clk_branch2_enable+0x34/0x44
[   76.585069]  clk_core_enable+0x6c/0xc0
[   76.588974]  clk_enable+0x30/0x50
[   76.592620]  pwm_clk_apply+0xb0/0xe4
[   76.596007]  pwm_apply_state+0x6c/0x1ec
[   76.599651]  sgm3140_brightness_set+0xb4/0x190 [leds_sgm3140]

(Which doesn't stop it from working afaict, but very much undesirable
for me.)
Unsure if this is something common or just a quirk of this specific
driver but I'd rather take a little glitch on the output than
make clock driver unhappy knowing how picky this hardware sometimes is...

> As there is not a single function to set rate (i.e. period) and
> duty_cycle it's not possible to prevent all glitches.
> 
> Can you please note that in a paragraph at the beginning of the driver
> as does e.g. drivers/pwm/pwm-sl28cpld.c. (Please stick to the format,
> i.e.  "Limitations:" and then all items without an empty line, to make
> this greppable.)
> 

Will add the description with limitations.

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
>> +	if (IS_ERR(chip->clk)) {
>> +		dev_err(&pdev->dev, "Failed to get clock: %ld\n", PTR_ERR(chip->clk));
>> +		return PTR_ERR(chip->clk);
> 
> Please use dev_err_probe() here and in the other error paths below.
> 

Will do.

>> +	}
>> +
>> +	chip->chip.dev = &pdev->dev;
>> +	chip->chip.ops = &pwm_clk_ops;
>> +	chip->chip.of_xlate = of_pwm_xlate_with_flags;
>> +	chip->chip.of_pwm_n_cells = 2;
>> +	chip->chip.base = 0;
> 
> Please drop this line (see commit f9a8ee8c8bcd)

Will drop.

> 
>> +	chip->chip.npwm = 1;
>> +
>> +	ret = clk_prepare(chip->clk);
>> +	if (ret < 0) {
>> +		dev_err(&pdev->dev, "Failed to prepare clock: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = pwmchip_add(&chip->chip);
>> +	if (ret < 0) {
>> +		dev_err(&pdev->dev, "Failed to add pwm chip: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	platform_set_drvdata(pdev, chip);
>> +	return 0;
>> +}
>> +
>> +static int pwm_clk_remove(struct platform_device *pdev)
>> +{
>> +	struct pwm_clk_chip *chip = platform_get_drvdata(pdev);
>> +
>> +	clk_unprepare(chip->clk);
>> +
>> +	pwmchip_remove(&chip->chip);
> 
> This is bad. clk_unprepare() stops the output which must not happen
> before pwmchip_remove() returns. What happens if the PWM (and so the
> clk) is still on and you call clk_unprepare? Is this allowed at all if
> the enable count might be > 0?
> 

Will change the order. Also adding an clk_disable() there for cases
when it's still enabled.

>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id pwm_clk_dt_ids[] = {
>> +	{ .compatible = "clk-pwm", },
>> +	{ /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, pwm_clk_dt_ids);
>> +
>> +static struct platform_driver pwm_clk_driver = {
>> +	.driver = {
>> +		.name = "clk-pwm",
> 
> Hmm, is this name sane? I would have expected that a driver called
> "clk-pwm" exposes a clk using a PWM. OTOH there is a "pwm-clock" driver
> that does exactly that. To complete the confusion the function prefix of
> said driver is clk_pwm_ and this one used pwm_clk_ ...

Oops, existence of "pwm-clock" (clk-pwm.c) and my attempts to not
collide with it's naming causes quite a bit of weird mix-up's like this.
.name should be "pwm-clk" in line with the driver filename and
all the method prefixes there but compatible should still be "clk-pwm"
so it's not as similar with an opposite "pwm-clock" compatible.

> 
>> +		.of_match_table = pwm_clk_dt_ids,
>> +	},
>> +	.probe = pwm_clk_probe,
>> +	.remove = pwm_clk_remove,
>> +};
>> +module_platform_driver(pwm_clk_driver);
>> +
>> +MODULE_ALIAS("platform:clk-pwm");
>> +MODULE_AUTHOR("Nikita Travkin <nikita@trvn.ru>");
>> +MODULE_DESCRIPTION("Clock based PWM driver");
>> +MODULE_LICENSE("GPL v2");
> 
> MODULE_LICENSE("GPL");
> 
> is the more usual today (and has the same meaning).

Will use the more common one then.

I will send a v2 with those changes (as well as with a filename fix
for the DT bindings) a bit later.

Thanks,
Nikita

> 
> Best regards
> Uwe
