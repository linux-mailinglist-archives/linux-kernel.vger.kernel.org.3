Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1204E5E4C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 06:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241545AbiCXFqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 01:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbiCXFqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 01:46:17 -0400
X-Greylist: delayed 902 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Mar 2022 22:44:45 PDT
Received: from mail-sz.amlogic.com (mail-sz.amlogic.com [211.162.65.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F41C427D9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 22:44:44 -0700 (PDT)
Received: from [10.28.39.96] (10.28.39.96) by mail-sz.amlogic.com (10.28.11.5)
 with Microsoft SMTP Server id 15.1.2176.2; Thu, 24 Mar 2022 13:29:40 +0800
Message-ID: <236493d1-10e6-a10d-e39f-32dcb7533e50@amlogic.com>
Date:   Thu, 24 Mar 2022 13:29:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] pwm: meson: external clock configuration for s4
To:     Neil Armstrong <narmstrong@baylibre.com>, <jbrunet@baylibre.com>,
        <thierry.reding@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <lee.jones@linaro.org>, <khilman@baylibre.com>,
        <martin.blumenstingl@googlemail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20220114090753.34873-1-Jiayi.Zhou@amlogic.com>
 <07581fb8-0cd9-5b76-6fa3-1d1a7353d944@baylibre.com>
From:   Jiayi Zhou <Jiayi.Zhou@amlogic.com>
In-Reply-To: <07581fb8-0cd9-5b76-6fa3-1d1a7353d944@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.28.39.96]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/1/14 18:16, Neil Armstrong 写道:
> [ EXTERNAL EMAIL ]
>
> Hi,
>
> On 14/01/2022 10:07, Jiayi.Zhou@amlogic.com wrote:
>> From: "Jiayi.zhou" <jiayi.zhou@amlogic.com>
>>
>> For PWM controller in the Meson-S4 SoC,
>> PWM needs to obtain an external clock source.
>> This patch tries to describe them in the DT compatible data.
> Can you be more explicit here ? On which SoC ? Why ?
>
> As I understand while reading the S805X2 datasheet, now the PWM clock input is
> done in independent CLKCTRL registers and no more in the PWM registers, right ?
>
> So with S4, instead of passing the mux input clock of clkin0 & clkin1, now you pass
> the PWM mux output clock.

For PWM controller in the Meson-S4 SoC，PWM needs to obtain an external clock source.
The configuration for the external clock source will be placed in the dtsi

>> Signed-off-by: Jiayi.zhou <jiayi.zhou@amlogic.com>
>> ---
>>   drivers/pwm/pwm-meson.c | 145 ++++++++++++++++++++++++++++++----------
>>   1 file changed, 110 insertions(+), 35 deletions(-)
>>
>> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
>> index 3cf3bcf5ddfc..54db56c95be2 100644
>> --- a/drivers/pwm/pwm-meson.c
>> +++ b/drivers/pwm/pwm-meson.c
>> @@ -51,6 +51,7 @@
>>   #define REG_MISC_AB		0x8
>>   #define MISC_B_CLK_EN		BIT(23)
>>   #define MISC_A_CLK_EN		BIT(15)
>> +
>>   #define MISC_CLK_DIV_MASK	0x7f
>>   #define MISC_B_CLK_DIV_SHIFT	16
>>   #define MISC_A_CLK_DIV_SHIFT	8
>> @@ -93,11 +94,13 @@ struct meson_pwm_channel {
>>   	struct clk *clk_parent;
>>   	struct clk_mux mux;
>>   	struct clk *clk;
>> +	struct clk *clk_mux;
> Why do you add a mux ?

The purpose of adding a mux is to increase the selection of clock sources.

Before, amlogic only set the GATE attribute of the clock source. This 
time, the SEL attribute was added.

>
>>   };
>>   
>>   struct meson_pwm_data {
>>   	const char * const *parent_names;
>>   	unsigned int num_parents;
>> +	unsigned int extern_clk;
>>   };
>>   
>>   struct meson_pwm {
>> @@ -105,6 +108,7 @@ struct meson_pwm {
>>   	const struct meson_pwm_data *data;
>>   	struct meson_pwm_channel channels[MESON_NUM_PWMS];
>>   	void __iomem *base;
>> +
>>   	/*
>>   	 * Protects register (write) access to the REG_MISC_AB register
>>   	 * that is shared between the two PWMs.
>> @@ -130,13 +134,15 @@ static int meson_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
>>   
>>   	channel = &meson->channels[pwm->hwpwm];
>>   
>> -	if (channel->clk_parent) {
>> -		err = clk_set_parent(channel->clk, channel->clk_parent);
>> -		if (err < 0) {
>> -			dev_err(dev, "failed to set parent %s for %s: %d\n",
>> -				__clk_get_name(channel->clk_parent),
>> -				__clk_get_name(channel->clk), err);
>> -			return err;
>> +	if (!meson->data->extern_clk) {
>> +		if (channel->clk_parent) {
>> +			err = clk_set_parent(channel->clk, channel->clk_parent);
>> +			if (err < 0) {
>> +				dev_err(dev, "failed to set parent %s for %s: %d\n",
>> +					__clk_get_name(channel->clk_parent),
>> +					__clk_get_name(channel->clk), err);
>> +					return err;
>> +			}
>>   		}
>>   	}
>>   
>> @@ -171,7 +177,11 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
>>   	if (state->polarity == PWM_POLARITY_INVERSED)
>>   		duty = period - duty;
>>   
>> -	fin_freq = clk_get_rate(channel->clk);
>> +	if (meson->data->extern_clk) {
>> +		fin_freq = clk_get_rate(channel->clk_mux);> +	} else {
>> +		fin_freq = clk_get_rate(channel->clk);
>> +	}
>>   	if (fin_freq == 0) {
>>   		dev_err(meson->chip.dev, "invalid source clock frequency\n");
>>   		return -EINVAL;
>> @@ -228,17 +238,32 @@ static void meson_pwm_enable(struct meson_pwm *meson, struct pwm_device *pwm)
>>   	struct meson_pwm_channel_data *channel_data;
>>   	unsigned long flags;
>>   	u32 value;
>> +	unsigned long set_clk;
>> +	u32 err;
>>   
>>   	channel_data = &meson_pwm_per_channel_data[pwm->hwpwm];
>>   
>> -	spin_lock_irqsave(&meson->lock, flags);
>> -
>>   	value = readl(meson->base + REG_MISC_AB);
>> -	value &= ~(MISC_CLK_DIV_MASK << channel_data->clk_div_shift);
>> -	value |= channel->pre_div << channel_data->clk_div_shift;
>> -	value |= channel_data->clk_en_mask;
>> -	writel(value, meson->base + REG_MISC_AB);
>> +	if (meson->data->extern_clk) {
>> +		set_clk = clk_get_rate(channel->clk_mux);
>> +
>> +		if (set_clk == 0)
>> +			dev_err(meson->chip.dev, "invalid source clock frequency\n");
>> +		set_clk /= channel->pre_div + 1;
>> +		err = clk_set_rate(channel->clk, set_clk);
>> +		if (err)
>> +			dev_err(meson->chip.dev, "%s: error in setting pwm rate!\n", __func__);
>> +	} else {
>> +		spin_lock_irqsave(&meson->lock, flags);
>> +
>> +		value &= ~(MISC_CLK_DIV_MASK << channel_data->clk_div_shift);
>> +		value |= channel->pre_div << channel_data->clk_div_shift;
>> +		value |= channel_data->clk_en_mask;
>> +		writel(value, meson->base + REG_MISC_AB);
>>   
>> +		spin_unlock_irqrestore(&meson->lock, flags);
>> +	}
>> +	spin_lock_irqsave(&meson->lock, flags);
>>   	value = FIELD_PREP(PWM_HIGH_MASK, channel->hi) |
>>   		FIELD_PREP(PWM_LOW_MASK, channel->lo);
>>   	writel(value, meson->base + channel_data->reg_offset);
>> @@ -246,7 +271,6 @@ static void meson_pwm_enable(struct meson_pwm *meson, struct pwm_device *pwm)
>>   	value = readl(meson->base + REG_MISC_AB);
>>   	value |= channel_data->pwm_en_mask;
>>   	writel(value, meson->base + REG_MISC_AB);
>> -
>>   	spin_unlock_irqrestore(&meson->lock, flags);
>>   }
>>   
>> @@ -333,7 +357,8 @@ static void meson_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>>   	struct meson_pwm *meson = to_meson_pwm(chip);
>>   	struct meson_pwm_channel_data *channel_data;
>>   	struct meson_pwm_channel *channel;
>> -	u32 value, tmp;
>> +	u32 value_pwm, value, tmp;
>> +	unsigned long gate_clk, fre;
>>   
>>   	if (!state)
>>   		return;
>> @@ -341,30 +366,42 @@ static void meson_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>>   	channel = &meson->channels[pwm->hwpwm];
>>   	channel_data = &meson_pwm_per_channel_data[pwm->hwpwm];
>>   
>> -	value = readl(meson->base + REG_MISC_AB);
>> -
>> -	tmp = channel_data->pwm_en_mask | channel_data->clk_en_mask;
>> -	state->enabled = (value & tmp) == tmp;
>> -
>> -	tmp = value >> channel_data->clk_div_shift;
>> -	channel->pre_div = FIELD_GET(MISC_CLK_DIV_MASK, tmp);
>> -
>> +	value_pwm = readl(meson->base + REG_MISC_AB);
>>   	value = readl(meson->base + channel_data->reg_offset);
>>   
>>   	channel->lo = FIELD_GET(PWM_LOW_MASK, value);
>>   	channel->hi = FIELD_GET(PWM_HIGH_MASK, value);
>>   
>> -	if (channel->lo == 0) {
>> -		state->period = meson_pwm_cnt_to_ns(chip, pwm, channel->hi);
>> -		state->duty_cycle = state->period;
>> -	} else if (channel->lo >= channel->hi) {
>> -		state->period = meson_pwm_cnt_to_ns(chip, pwm,
>> -						    channel->lo + channel->hi);
>> -		state->duty_cycle = meson_pwm_cnt_to_ns(chip, pwm,
>> -							channel->hi);
>> +	if (meson->data->extern_clk) {
>> +		gate_clk = clk_get_rate(channel->clk);
>> +		fre = gate_clk / (channel->lo + channel->hi);
>> +		state->period = div_u64(NSEC_PER_SEC, fre);
>> +		state->duty_cycle = div_u64(state->period * channel->hi, channel->lo + channel->hi);
>> +		tmp = channel_data->pwm_en_mask;
>> +
>> +		if (((value_pwm & tmp) == tmp) && __clk_is_enabled(channel->clk))
>> +			state->enabled = true;
>> +		else
>> +			state->enabled = false;
>>   	} else {
>> -		state->period = 0;
>> -		state->duty_cycle = 0;
>> +		tmp = channel_data->pwm_en_mask | channel_data->clk_en_mask;
>> +
>> +		state->enabled = (value_pwm & tmp) == tmp;
>> +
>> +		tmp = value_pwm >> channel_data->clk_div_shift;
>> +		channel->pre_div = FIELD_GET(MISC_CLK_DIV_MASK, tmp);
>> +
>> +		if (channel->lo == 0) {
>> +			state->period = meson_pwm_cnt_to_ns(chip, pwm, channel->hi);
>> +			state->duty_cycle = state->period;
>> +		} else if (channel->lo >= channel->hi) {
>> +			state->period = meson_pwm_cnt_to_ns(chip, pwm, channel->lo
>> +							    + channel->hi);
>> +			state->duty_cycle = meson_pwm_cnt_to_ns(chip, pwm, channel->hi);
>> +		} else {
>> +			state->period = 0;
>> +			state->duty_cycle = 0;
>> +		}
>>   	}
>>   }
> You need to rewrite the clock calculation entirely, instead of relying on a fin_freq, you need
> to set_rate() the needed rate to the input clock, then calculate the periods on the rate
> set by CCF.
>
> One way is to forget trying to set a rate of the input clock, simply get_rate() of the input clock
> and try to calculate periods on it.
>
> Instead rely on assignes-clock-parent & assigned-clock-rate in DT to set the right parent of the mux
> and rate of the mux post divider to feed to correct rate to the PWM controller.
assignes-clock-parent and assignment-clock-rate I will set in dtsi.
>>   
>> @@ -452,6 +489,10 @@ static const struct meson_pwm_data pwm_g12a_ee_data = {
>>   	.num_parents = ARRAY_SIZE(pwm_g12a_ee_parent_names),
>>   };
>>   
>> +static const struct meson_pwm_data pwm_meson_data = {
>> +	.extern_clk = true,
>> +};
>> +
>>   static const struct of_device_id meson_pwm_matches[] = {
>>   	{
>>   		.compatible = "amlogic,meson8b-pwm",
>> @@ -485,6 +526,10 @@ static const struct of_device_id meson_pwm_matches[] = {
>>   		.compatible = "amlogic,meson-g12a-ao-pwm-cd",
>>   		.data = &pwm_g12a_ao_cd_data
>>   	},
>> +	{
>> +		.compatible = "amlogic,meson-s4-pwm",
>> +		.data = &pwm_meson_data
>> +	},
>>   	{},
>>   };
>>   MODULE_DEVICE_TABLE(of, meson_pwm_matches);
>> @@ -534,6 +579,33 @@ static int meson_pwm_init_channels(struct meson_pwm *meson)
>>   	return 0;
>>   }
>>   
>> +static int meson_pwm_extern_init_channels(struct meson_pwm *meson)
>> +{
>> +	struct meson_pwm_channel *channels = meson->channels;
>> +	struct device *dev = meson->chip.dev;
>> +	unsigned int i;
>> +	char name[255];
>> +
>> +	for (i = 0; i < meson->chip.npwm; i++) {
>> +		snprintf(name, sizeof(name), "clkin%u", i);
>> +		(channels + i)->clk = devm_clk_get(dev, name);
>> +		if (IS_ERR((channels + i)->clk)) {
>> +			dev_err_probe(meson->chip.dev, PTR_ERR((channels + i)->clk),
>> +				      "can't get device clock\n");
>> +			return PTR_ERR((channels + i)->clk);
>> +		}
>> +		snprintf(name, sizeof(name), "mux%u", i);
>> +		(channels + i)->clk_mux = devm_clk_get(dev, name);
>> +		if (IS_ERR((channels + i)->clk_mux)) {
>> +			dev_err_probe(meson->chip.dev, PTR_ERR((channels + i)->clk_mux),
>> +				      "can't get device clock\n");
>> +			return PTR_ERR((channels + i)->clk_mux);
> If you add mux you'll need to changes the bindings.
>
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   static int meson_pwm_probe(struct platform_device *pdev)
>>   {
>>   	struct meson_pwm *meson;
>> @@ -553,8 +625,11 @@ static int meson_pwm_probe(struct platform_device *pdev)
>>   	meson->chip.npwm = MESON_NUM_PWMS;
>>   
>>   	meson->data = of_device_get_match_data(&pdev->dev);
>> +	if (meson->data->extern_clk)
>> +		err = meson_pwm_extern_init_channels(meson);
>> +	else
>> +		err = meson_pwm_init_channels(meson);
>>   
>> -	err = meson_pwm_init_channels(meson);
>>   	if (err < 0)
>>   		return err;
>>   
>>
> .
