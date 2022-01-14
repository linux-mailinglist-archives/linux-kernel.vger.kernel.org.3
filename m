Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6944D48E81E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 11:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239784AbiANKQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 05:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233821AbiANKQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 05:16:08 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78921C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 02:16:08 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id c2so133492wml.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 02:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C+I9vsvv4jxUQBjyNFF7b6H2OVu+EdkKpp/nAiazxwM=;
        b=LZRGVtg1odeFV0DA1Uy+BXAM6n2s30F4/eOiaAejVqiEHtLyeZuBNArxRIy0ZBULvV
         VYKFImGFbF+r2vZyzQ0ZtBpd1gw3ghZ4lcoCzmZ4H6FTS8BC915va7X28GERiu7jAoxK
         vzJXia6iKxkMOdfOCdOlmmcqmCFHW4lA1O6iqlX5BxD3L2G2XJv1yhZhIrCj0nU3TNqN
         Rc2GSV+fEOWp4XpfAbIoL8JlJoUp4xZJhXxrvZ7aEd/XXZJCVowiK6oQcLc/eFY49fhu
         6bCr6O4E3uFFs2Ql3rNY4qvNEg0t9di+W84RU1mgsuBCQsnzcWpiTTod8DOB1othjfqE
         SkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=C+I9vsvv4jxUQBjyNFF7b6H2OVu+EdkKpp/nAiazxwM=;
        b=f+r91eBpc9M2eOxTxXKnziQEnLghYLfbsKm4ewISowuO9ExkGyBid0ekCuC2GgX9xp
         BWM0U+E52uT4aEn0cNgnpWkuH9nuoCui2QKDb3wumtCy0s6qh8c0mvWkPyPFPwbRQ44E
         aC3klYU8V/+nhENEmwmc2umP0FbK6Hgb750x9yt/BquaKWHFhSIo2D6/Mcwgquds+hdv
         u4YyB577SFqqXNk9fpBvIeErDHvBRT8vGYbJcvbDlBxLGzNlABvIsgH0085GECfEH3/o
         oh8TZzlOG343YsrquuLnDAWW3kUIO2+xjJMfvNcod/WEeGyk65UQpCvTdo0vtsOlsF5a
         W4pA==
X-Gm-Message-State: AOAM530lr95iljtPjgny52ietsoPS7oiOm2R4/zdfvTana89YZ8HaLTv
        3b9atGRaN2y4YfNVHDWtA0uKiyx+wGxEng==
X-Google-Smtp-Source: ABdhPJxzEGiwsBcLaGV4JJUUf5a4Imbr/mzTpNoSB9QDGkSXETH5e4o9CGo13wgtKGTNF13ZKoodUg==
X-Received: by 2002:a1c:f613:: with SMTP id w19mr14731377wmc.58.1642155366517;
        Fri, 14 Jan 2022 02:16:06 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:a3fc:c40b:5afc:88ee? ([2001:861:44c0:66c0:a3fc:c40b:5afc:88ee])
        by smtp.gmail.com with ESMTPSA id e12sm1439643wrg.33.2022.01.14.02.16.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jan 2022 02:16:05 -0800 (PST)
Subject: Re: [PATCH v2] pwm: meson: external clock configuration for s4
To:     Jiayi.Zhou@amlogic.com, jbrunet@baylibre.com,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220114090753.34873-1-Jiayi.Zhou@amlogic.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <07581fb8-0cd9-5b76-6fa3-1d1a7353d944@baylibre.com>
Date:   Fri, 14 Jan 2022 11:16:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220114090753.34873-1-Jiayi.Zhou@amlogic.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 14/01/2022 10:07, Jiayi.Zhou@amlogic.com wrote:
> From: "Jiayi.zhou" <jiayi.zhou@amlogic.com>
> 
> For PWM controller in the Meson-S4 SoC,
> PWM needs to obtain an external clock source.
> This patch tries to describe them in the DT compatible data.

Can you be more explicit here ? On which SoC ? Why ?

As I understand while reading the S805X2 datasheet, now the PWM clock input is
done in independent CLKCTRL registers and no more in the PWM registers, right ?

So with S4, instead of passing the mux input clock of clkin0 & clkin1, now you pass
the PWM mux output clock.

> 
> Signed-off-by: Jiayi.zhou <jiayi.zhou@amlogic.com>
> ---
>  drivers/pwm/pwm-meson.c | 145 ++++++++++++++++++++++++++++++----------
>  1 file changed, 110 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index 3cf3bcf5ddfc..54db56c95be2 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -51,6 +51,7 @@
>  #define REG_MISC_AB		0x8
>  #define MISC_B_CLK_EN		BIT(23)
>  #define MISC_A_CLK_EN		BIT(15)
> +
>  #define MISC_CLK_DIV_MASK	0x7f
>  #define MISC_B_CLK_DIV_SHIFT	16
>  #define MISC_A_CLK_DIV_SHIFT	8
> @@ -93,11 +94,13 @@ struct meson_pwm_channel {
>  	struct clk *clk_parent;
>  	struct clk_mux mux;
>  	struct clk *clk;
> +	struct clk *clk_mux;

Why do you add a mux ?

>  };
>  
>  struct meson_pwm_data {
>  	const char * const *parent_names;
>  	unsigned int num_parents;
> +	unsigned int extern_clk;
>  };
>  
>  struct meson_pwm {
> @@ -105,6 +108,7 @@ struct meson_pwm {
>  	const struct meson_pwm_data *data;
>  	struct meson_pwm_channel channels[MESON_NUM_PWMS];
>  	void __iomem *base;
> +
>  	/*
>  	 * Protects register (write) access to the REG_MISC_AB register
>  	 * that is shared between the two PWMs.
> @@ -130,13 +134,15 @@ static int meson_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
>  
>  	channel = &meson->channels[pwm->hwpwm];
>  
> -	if (channel->clk_parent) {
> -		err = clk_set_parent(channel->clk, channel->clk_parent);
> -		if (err < 0) {
> -			dev_err(dev, "failed to set parent %s for %s: %d\n",
> -				__clk_get_name(channel->clk_parent),
> -				__clk_get_name(channel->clk), err);
> -			return err;
> +	if (!meson->data->extern_clk) {
> +		if (channel->clk_parent) {
> +			err = clk_set_parent(channel->clk, channel->clk_parent);
> +			if (err < 0) {
> +				dev_err(dev, "failed to set parent %s for %s: %d\n",
> +					__clk_get_name(channel->clk_parent),
> +					__clk_get_name(channel->clk), err);
> +					return err;
> +			}
>  		}
>  	}
>  
> @@ -171,7 +177,11 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
>  	if (state->polarity == PWM_POLARITY_INVERSED)
>  		duty = period - duty;
>  
> -	fin_freq = clk_get_rate(channel->clk);
> +	if (meson->data->extern_clk) {
> +		fin_freq = clk_get_rate(channel->clk_mux);> +	} else {
> +		fin_freq = clk_get_rate(channel->clk);
> +	}
>  	if (fin_freq == 0) {
>  		dev_err(meson->chip.dev, "invalid source clock frequency\n");
>  		return -EINVAL;
> @@ -228,17 +238,32 @@ static void meson_pwm_enable(struct meson_pwm *meson, struct pwm_device *pwm)
>  	struct meson_pwm_channel_data *channel_data;
>  	unsigned long flags;
>  	u32 value;
> +	unsigned long set_clk;
> +	u32 err;
>  
>  	channel_data = &meson_pwm_per_channel_data[pwm->hwpwm];
>  
> -	spin_lock_irqsave(&meson->lock, flags);
> -
>  	value = readl(meson->base + REG_MISC_AB);
> -	value &= ~(MISC_CLK_DIV_MASK << channel_data->clk_div_shift);
> -	value |= channel->pre_div << channel_data->clk_div_shift;
> -	value |= channel_data->clk_en_mask;
> -	writel(value, meson->base + REG_MISC_AB);
> +	if (meson->data->extern_clk) {
> +		set_clk = clk_get_rate(channel->clk_mux);
> +
> +		if (set_clk == 0)
> +			dev_err(meson->chip.dev, "invalid source clock frequency\n");
> +		set_clk /= channel->pre_div + 1;
> +		err = clk_set_rate(channel->clk, set_clk);
> +		if (err)
> +			dev_err(meson->chip.dev, "%s: error in setting pwm rate!\n", __func__);
> +	} else {
> +		spin_lock_irqsave(&meson->lock, flags);
> +
> +		value &= ~(MISC_CLK_DIV_MASK << channel_data->clk_div_shift);
> +		value |= channel->pre_div << channel_data->clk_div_shift;
> +		value |= channel_data->clk_en_mask;
> +		writel(value, meson->base + REG_MISC_AB);
>  
> +		spin_unlock_irqrestore(&meson->lock, flags);
> +	}
> +	spin_lock_irqsave(&meson->lock, flags);
>  	value = FIELD_PREP(PWM_HIGH_MASK, channel->hi) |
>  		FIELD_PREP(PWM_LOW_MASK, channel->lo);
>  	writel(value, meson->base + channel_data->reg_offset);
> @@ -246,7 +271,6 @@ static void meson_pwm_enable(struct meson_pwm *meson, struct pwm_device *pwm)
>  	value = readl(meson->base + REG_MISC_AB);
>  	value |= channel_data->pwm_en_mask;
>  	writel(value, meson->base + REG_MISC_AB);
> -
>  	spin_unlock_irqrestore(&meson->lock, flags);
>  }
>  
> @@ -333,7 +357,8 @@ static void meson_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>  	struct meson_pwm *meson = to_meson_pwm(chip);
>  	struct meson_pwm_channel_data *channel_data;
>  	struct meson_pwm_channel *channel;
> -	u32 value, tmp;
> +	u32 value_pwm, value, tmp;
> +	unsigned long gate_clk, fre;
>  
>  	if (!state)
>  		return;
> @@ -341,30 +366,42 @@ static void meson_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>  	channel = &meson->channels[pwm->hwpwm];
>  	channel_data = &meson_pwm_per_channel_data[pwm->hwpwm];
>  
> -	value = readl(meson->base + REG_MISC_AB);
> -
> -	tmp = channel_data->pwm_en_mask | channel_data->clk_en_mask;
> -	state->enabled = (value & tmp) == tmp;
> -
> -	tmp = value >> channel_data->clk_div_shift;
> -	channel->pre_div = FIELD_GET(MISC_CLK_DIV_MASK, tmp);
> -
> +	value_pwm = readl(meson->base + REG_MISC_AB);
>  	value = readl(meson->base + channel_data->reg_offset);
>  
>  	channel->lo = FIELD_GET(PWM_LOW_MASK, value);
>  	channel->hi = FIELD_GET(PWM_HIGH_MASK, value);
>  
> -	if (channel->lo == 0) {
> -		state->period = meson_pwm_cnt_to_ns(chip, pwm, channel->hi);
> -		state->duty_cycle = state->period;
> -	} else if (channel->lo >= channel->hi) {
> -		state->period = meson_pwm_cnt_to_ns(chip, pwm,
> -						    channel->lo + channel->hi);
> -		state->duty_cycle = meson_pwm_cnt_to_ns(chip, pwm,
> -							channel->hi);
> +	if (meson->data->extern_clk) {
> +		gate_clk = clk_get_rate(channel->clk);
> +		fre = gate_clk / (channel->lo + channel->hi);
> +		state->period = div_u64(NSEC_PER_SEC, fre);
> +		state->duty_cycle = div_u64(state->period * channel->hi, channel->lo + channel->hi);
> +		tmp = channel_data->pwm_en_mask;
> +
> +		if (((value_pwm & tmp) == tmp) && __clk_is_enabled(channel->clk))
> +			state->enabled = true;
> +		else
> +			state->enabled = false;
>  	} else {
> -		state->period = 0;
> -		state->duty_cycle = 0;
> +		tmp = channel_data->pwm_en_mask | channel_data->clk_en_mask;
> +
> +		state->enabled = (value_pwm & tmp) == tmp;
> +
> +		tmp = value_pwm >> channel_data->clk_div_shift;
> +		channel->pre_div = FIELD_GET(MISC_CLK_DIV_MASK, tmp);
> +
> +		if (channel->lo == 0) {
> +			state->period = meson_pwm_cnt_to_ns(chip, pwm, channel->hi);
> +			state->duty_cycle = state->period;
> +		} else if (channel->lo >= channel->hi) {
> +			state->period = meson_pwm_cnt_to_ns(chip, pwm, channel->lo
> +							    + channel->hi);
> +			state->duty_cycle = meson_pwm_cnt_to_ns(chip, pwm, channel->hi);
> +		} else {
> +			state->period = 0;
> +			state->duty_cycle = 0;
> +		}
>  	}
>  }

You need to rewrite the clock calculation entirely, instead of relying on a fin_freq, you need
to set_rate() the needed rate to the input clock, then calculate the periods on the rate
set by CCF.

One way is to forget trying to set a rate of the input clock, simply get_rate() of the input clock
and try to calculate periods on it.

Instead rely on assignes-clock-parent & assigned-clock-rate in DT to set the right parent of the mux
and rate of the mux post divider to feed to correct rate to the PWM controller.

>  
> @@ -452,6 +489,10 @@ static const struct meson_pwm_data pwm_g12a_ee_data = {
>  	.num_parents = ARRAY_SIZE(pwm_g12a_ee_parent_names),
>  };
>  
> +static const struct meson_pwm_data pwm_meson_data = {
> +	.extern_clk = true,
> +};
> +
>  static const struct of_device_id meson_pwm_matches[] = {
>  	{
>  		.compatible = "amlogic,meson8b-pwm",
> @@ -485,6 +526,10 @@ static const struct of_device_id meson_pwm_matches[] = {
>  		.compatible = "amlogic,meson-g12a-ao-pwm-cd",
>  		.data = &pwm_g12a_ao_cd_data
>  	},
> +	{
> +		.compatible = "amlogic,meson-s4-pwm",
> +		.data = &pwm_meson_data
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, meson_pwm_matches);
> @@ -534,6 +579,33 @@ static int meson_pwm_init_channels(struct meson_pwm *meson)
>  	return 0;
>  }
>  
> +static int meson_pwm_extern_init_channels(struct meson_pwm *meson)
> +{
> +	struct meson_pwm_channel *channels = meson->channels;
> +	struct device *dev = meson->chip.dev;
> +	unsigned int i;
> +	char name[255];
> +
> +	for (i = 0; i < meson->chip.npwm; i++) {
> +		snprintf(name, sizeof(name), "clkin%u", i);
> +		(channels + i)->clk = devm_clk_get(dev, name);
> +		if (IS_ERR((channels + i)->clk)) {
> +			dev_err_probe(meson->chip.dev, PTR_ERR((channels + i)->clk),
> +				      "can't get device clock\n");
> +			return PTR_ERR((channels + i)->clk);
> +		}
> +		snprintf(name, sizeof(name), "mux%u", i);
> +		(channels + i)->clk_mux = devm_clk_get(dev, name);
> +		if (IS_ERR((channels + i)->clk_mux)) {
> +			dev_err_probe(meson->chip.dev, PTR_ERR((channels + i)->clk_mux),
> +				      "can't get device clock\n");
> +			return PTR_ERR((channels + i)->clk_mux);

If you add mux you'll need to changes the bindings.

> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int meson_pwm_probe(struct platform_device *pdev)
>  {
>  	struct meson_pwm *meson;
> @@ -553,8 +625,11 @@ static int meson_pwm_probe(struct platform_device *pdev)
>  	meson->chip.npwm = MESON_NUM_PWMS;
>  
>  	meson->data = of_device_get_match_data(&pdev->dev);
> +	if (meson->data->extern_clk)
> +		err = meson_pwm_extern_init_channels(meson);
> +	else
> +		err = meson_pwm_init_channels(meson);
>  
> -	err = meson_pwm_init_channels(meson);
>  	if (err < 0)
>  		return err;
>  
> 

