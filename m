Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859E44A7A95
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 22:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347673AbiBBVkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 16:40:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345641AbiBBVkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 16:40:05 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F33C06173B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 13:40:05 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id g15-20020a9d6b0f000000b005a062b0dc12so749721otp.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 13:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=tMJm7rUkBaw98tkeDjYJTHlP89IJwdWSqnzx8mCujK8=;
        b=CgWPPdoUoa+gTuGv8BwsjRnqlcCWz12gRIWvBZJvc6rvJ+tuVRMwXF1hXPTtSM6wRz
         LiH1co14vC/fBKTFJdixlesrEtnTnftmpkfTy+voAXpvTmG7oRNQFff1PcFzwcpLaTCj
         IBtJLNyORc0We2Nsq/sEAvjXmqF6vQFCfJ71+mHBketjDirnGfeh7pzZ5SMRHql5q3Pi
         fmSlX3gTpR3noouKDayh5KJTrBGSckVwvSPy/vZU5JHAKh6cwP2IMFpx1JrRRGK677P/
         oUbkpkHR11kf+cc4DdobC9WtivPKlnd7NULKYVR0x3zZlHzG8dklNTJcfPcTojCr5C2I
         ZGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tMJm7rUkBaw98tkeDjYJTHlP89IJwdWSqnzx8mCujK8=;
        b=N6LKp77rJkjhEH2Z+g/ZOkp3aQJsTS73y04mwggc5nsLDtI7/VC8SS6mX/GuXr1zx1
         ONpjoXNjakZXU71zGpCBsNfKXmYfF3tjsR4/7EO+j4e2iP0s+Uv92dTcxVKCio1vG8Hi
         AxNmNOWE7IbeVN2UiQcDqlAeprou4Z6Y1LfbleNGJK9syiBKkhUg81VoiMZPpWL0uoa7
         Cs49vMni1fm451Z6YTe68J2rlFXpIW6D/SlmW1BZfRWGDSH6wGd9AJyg/iGtSNVrMdsX
         U83MBewTzwV2df0qEKfAEpBwFvx/G0wT0o9/Sq/2xJ2Gn8f/VWewSObF2orLgDVft6il
         9xaA==
X-Gm-Message-State: AOAM531fcqZ+PNMqGC7ZPEUrcdCHi/d4XXk3FjQap/uWkVvWE3FKbx0x
        F5GmcIjrie2OyRl0AemzNgBLxg==
X-Google-Smtp-Source: ABdhPJwvUGXQQBFJHRuewTxDd+tZJ8n0xjnlmdLs40wK8QaHygFkxIL2nvV0PegNjtDMPAkg9o/Bkg==
X-Received: by 2002:a9d:58c8:: with SMTP id s8mr878984oth.294.1643838004310;
        Wed, 02 Feb 2022 13:40:04 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id ay42sm4488798oib.5.2022.02.02.13.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 13:40:03 -0800 (PST)
Date:   Wed, 2 Feb 2022 13:40:21 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Satya Priya Kakitapalli <c_skakit@qti.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Luca Weiss <luca@z3ntu.xyz>, Rob Herring <robh+dt@kernel.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v11 2/2] leds: Add driver for Qualcomm LPG
Message-ID: <Yfr6RQwJMZY5RZGr@ripper>
References: <20220129005429.754727-1-bjorn.andersson@linaro.org>
 <20220129005429.754727-2-bjorn.andersson@linaro.org>
 <20220202162930.24zcediw44t2jzqf@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220202162930.24zcediw44t2jzqf@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 02 Feb 08:29 PST 2022, Uwe Kleine-K?nig wrote:

> Hello,
> 
> did you consider my earlier feedback "It would also be good if the PWM
> code could live in drivers/pwm"?
> (https://lore.kernel.org/r/20210505051958.e5lvwfxuo2skdu2q@pengutronix.de)
> 

Yes, I did consider this. Because the downstream driver is (at least was
when I looked at it originally) split like that.


We have a number of different Qualcomm PMICs containing the LPG modules,
which consists of N PWM channels, a pattern lookup table and a set of
current sinks.

Each PWM channel can either be used as a traditional PWM, a LED or be
grouped together with other channels to form a multicolor LED. So we
need a design that allows different boards using a particular PMIC to
freely use the N channels according to one of these three operational
modes.

The pattern lookup table is a shared resource containing duty cycle
values and each of the PWM channels can be configured to have their duty
cycle modified from the lookup table on some configured cadence.

In the even that multiple PWM channels are ganged together to form a
multicolor LED, which is driven by a pattern, the pattern generator for
the relevant channels needs to be synchronized.


If we consider the PWM channel to be the basic primitive we need some
mechanism to configure the pattern properties for each of the channels
and we need some mechanism to synchronize the pattern generators for
some subset of the PWM channels.


In other words we need some custom API between the LED driver part and
the PWM driver, to configure these properties. This was the design
of the downstream driver when I started looking at this driver.


Another alternative that has been considered is to create two
independent drivers - for the same hardware. This would allow the system
integrator to pick the right driver for each of the channels.

One problem with this strategy is that the DeviceTree description of the
LPG hardware will have to be modified depending on the use case. In
particular this prevents me from writing a platform dtsi describing the
LPG hardware and then describe the LEDs and pwm channels in a board dts.

And we can't express the individual channels, because the multicolor
definition needs to span multiple channels.


So among all the options, implementing the pwm_chip in the LED driver
makes it possible for us to describe the LPG as one entity, with
board-specific LEDs and a set of PWM channels.

> At least splitting in two patches would be good IMHO.
> 

I guess I can split out the parts related to the pwmchip in a separate
patch. Seems to be a rather small portion of the code though. Is that
what you have in mind?

> On Fri, Jan 28, 2022 at 04:54:29PM -0800, Bjorn Andersson wrote:
> > The Light Pulse Generator (LPG) is a PWM-block found in a wide range of
> > PMICs from Qualcomm. These PMICs typically comes with 1-8 LPG instances,
> > with their output being routed to various other components, such as
> > current sinks or GPIOs.
> > 
> > Each LPG instance can operate on fixed parameters or based on a shared
> > lookup-table, altering the duty cycle over time. This provides the means
> > for hardware assisted transitions of LED brightness.
> > 
> > A typical use case for the fixed parameter mode is to drive a PWM
> > backlight control signal, the driver therefor allows each LPG instance
> > to be exposed to the kernel either through the LED framework or the PWM
> > framework.
> > 
> > A typical use case for the LED configuration is to drive RGB LEDs in
> > smartphones etc, for which the driver support multiple channels to be
> > ganged up to a MULTICOLOR LED. In this configuration the pattern
> > generators will be synchronized, to allow for multi-color patterns.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
[..]
> > diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
[..]
> > +static int lpg_calc_freq(struct lpg_channel *chan, uint64_t period)
> > +{
> > +	unsigned int clk, best_clk = 0;
> > +	unsigned int div, best_div = 0;
> > +	unsigned int m, best_m = 0;
> > +	unsigned int error;
> > +	unsigned int best_err = UINT_MAX;
> > +	u64 best_period = 0;
> > +
> > +	/*
> > +	 * The PWM period is determined by:
> > +	 *
> > +	 *          resolution * pre_div * 2^M
> > +	 * period = --------------------------
> > +	 *                   refclk
> > +	 *
> > +	 * With resolution fixed at 2^9 bits, pre_div = {1, 3, 5, 6} and
> > +	 * M = [0..7].
> > +	 *
> > +	 * This allows for periods between 27uS and 384s, as the PWM framework
> > +	 * wants a period of equal or lower length than requested, reject
> > +	 * anything below 27uS.
> > +	 */
> > +	if (period <= (u64)NSEC_PER_SEC * LPG_RESOLUTION / 19200000)
> 
> u64 divisions must not be done by / in the kernel. Also I wonder if the
> following would be more correct (though with the same semantic):
> 
> 	if (period < DIV64_U64_ROUND_UP((u64)NSEC_PER_SEC * LPG_RESOLUTION, 19200000))
> 

Thanks for spotting that.

> 
> > +		return -EINVAL;
> > +
> > +	/* Limit period to largest possible value, to avoid overflows */
> > +	if (period > (u64)NSEC_PER_SEC * LPG_RESOLUTION * 6 * (1 << LPG_MAX_M) / 1024)
> > +		period = (u64)NSEC_PER_SEC * LPG_RESOLUTION * 6 * (1 << LPG_MAX_M) / 2014;
> > +
> > +	/*
> > +	 * Search for the pre_div, clk and M by solving the rewritten formula
> > +	 * for each clk and pre_div value:
> > +	 *
> > +	 *                       period * clk
> > +	 * M = log2 -------------------------------------
> > +	 *           NSEC_PER_SEC * pre_div * resolution
> > +	 */
> > +	for (clk = 0; clk < ARRAY_SIZE(lpg_clk_rates); clk++) {
> > +		u64 nom = period * lpg_clk_rates[clk];
> > +
> > +		for (div = 0; div < ARRAY_SIZE(lpg_pre_divs); div++) {
> > +			u64 denom = (u64)NSEC_PER_SEC * lpg_pre_divs[div] * (1 << 9);
> > +			u64 actual;
> > +			u64 ratio;
> > +
> > +			if (nom < denom)
> > +				continue;
> > +
> > +			ratio = div64_u64(nom, denom);
> > +			m = ilog2(ratio);
> > +			if (m > LPG_MAX_M)
> > +				m = LPG_MAX_M;
> > +
> > +			actual = DIV_ROUND_UP_ULL(denom * (1 << m), lpg_clk_rates[clk]);
> > +
> > +			error = period - actual;
> 
> This looks good, though I didn't revalidate the calculation (e.g. to
> convince myself that error is always >= 0)
> 

We spent considerable time going through this last time, so I hope we're
good :)

> > +			if (error < best_err) {
> > +				best_err = error;
> > +
> > +				best_div = div;
> > +				best_m = m;
> > +				best_clk = clk;
> > +				best_period = actual;
> > +			}
> > +		}
> > +	}
> > +
> > +	chan->clk = best_clk;
> > +	chan->pre_div = best_div;
> > +	chan->pre_div_exp = best_m;
> > +	chan->period = best_period;
> > +
> > +	return 0;
> > +}
[..]
> > +static int lpg_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
> > +{
> > +	struct lpg *lpg = container_of(chip, struct lpg, pwm);
> > +	struct lpg_channel *chan = &lpg->channels[pwm->hwpwm];
> > +
> > +	return chan->in_use ? -EBUSY : 0;
> > +}
> > +
> > +/*
> > + * Limitations:
> > + * - Updating both duty and period is not done atomically, so the output signal
> > + *   will momentarily be a mix of the settings.
> 
> Is the PWM well-behaved? (i.e. does it emit the inactive level when
> disabled?)

Yes, a disabled channel outputs a logical 0.

> Does it complete a period before switching to the new
> setting?
> 

I see nothing indicating the answer to this, in either direction...

> Did you test with PWM_DEBUG enabled?
> 

For previous iterations of the patch yes, v11 didn't touch any of that
so I omitted that step... Will enable it again as I respin v12.

> > + */
> > +static int lpg_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > +			 const struct pwm_state *state)
> > +{
> > +	struct lpg *lpg = container_of(chip, struct lpg, pwm);
> > +	struct lpg_channel *chan = &lpg->channels[pwm->hwpwm];
> > +	int ret;
> > +
> > +	if (state->polarity != PWM_POLARITY_NORMAL)
> > +		return -EINVAL;
> > +
> > +	ret = lpg_calc_freq(chan, state->period);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	lpg_calc_duty(chan, state->duty_cycle);
> > +	chan->enabled = state->enabled;
> > +
> > +	lpg_apply(chan);
> > +
> > +	triled_set(lpg, chan->triled_mask, chan->enabled ? chan->triled_mask : 0);
> > +
> > +	return 0;
> 
> Would it make sense to skip the calculation if state->enabled is false?
> 

Yes.

> > +}
> > +
> > +static void lpg_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> > +			      struct pwm_state *state)
> > +{
> > +	struct lpg *lpg = container_of(chip, struct lpg, pwm);
> > +	struct lpg_channel *chan = &lpg->channels[pwm->hwpwm];
> > +	u64 duty = DIV_ROUND_UP_ULL(chan->pwm_value * chan->period, LPG_RESOLUTION - 1);
> > +
> > +	state->period = chan->period;
> > +	state->duty_cycle = duty;
> > +	state->polarity = PWM_POLARITY_NORMAL;
> > +	state->enabled = chan->enabled;
> 
> This doesn't work if .get_state() is called before .apply() was called,
> does it?
> 

You mean that I would return some bogus state and not the actual
hardware state?

> > +}
> > +
> > +static const struct pwm_ops lpg_pwm_ops = {
> > +	.request = lpg_pwm_request,
> > +	.apply = lpg_pwm_apply,
> > +	.get_state = lpg_pwm_get_state,
> > +	.owner = THIS_MODULE,
> > +};
> > +
> > +static int lpg_add_pwm(struct lpg *lpg)
> > +{
> > +	int ret;
> > +
> > +	lpg->pwm.base = -1;
> 
> I already asked in May to drop this ...
> 

Sorry about that, thought I had resolved that already.

Thanks,
Bjorn

> > +	lpg->pwm.dev = lpg->dev;
> > +	lpg->pwm.npwm = lpg->num_channels;
> > +	lpg->pwm.ops = &lpg_pwm_ops;
> > +
> 
> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |


