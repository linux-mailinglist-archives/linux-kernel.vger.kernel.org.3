Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872454A8F83
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 22:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244965AbiBCVFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 16:05:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236700AbiBCVFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 16:05:12 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E06C06173B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 13:05:11 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id e21-20020a9d0195000000b005a3cd7c1e09so3643221ote.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 13:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JIQab/pEjY3vFOs5pXgNHPVknEkSvqZGfjjhX/hLUOo=;
        b=xSCdzm5EnuKl3ZoM3+c87lnVtUIOgZ7c+ovyU9zAFV6WqW3tBUvExNw0NLRZ+DBquX
         c/RNFy2ry0bUoTf6xVUiEDn6JzdWR0o+ScVdYUDq0bJwWVJDoZm3KQ8ih01nyUFl5Uky
         myrPF3O5ztAiWsVT74JEO/8JKXYSqSbwSdi5KDcBOzoya9LhRv/LRdF8tinq6a59A2/f
         4bxywJaUvIV4mcQzl+DVQ/cFgsNnCn7GfrefKqQ6ULLVBCCVKT4ogaLGSpO+Odne0J3T
         m2M2X7SOjl6mHzWORxS3GBZZWpueTjJIFniPkwK2niTNb9ecnZMRLrTHxGoQXvqfQx7/
         uQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JIQab/pEjY3vFOs5pXgNHPVknEkSvqZGfjjhX/hLUOo=;
        b=FZxIWbk3R6wfD9+X5ZJGjPMC55mKCe5ZGdcAxI24mwhJ1c+Ow98sH71wEKPdbLuz9t
         Gdfr8W6LNL3hWM05u178Xoqu76hO0zFy3hAXMLvvQN0jpzolBm0nBxEAANPvgU7IW0ge
         2BPuez3X5dlvNT24GDQnYE2ZsuINR4MA3j0OXpfLDrqQ1fMVxOEDJNB0HJzNGdXCtjcs
         HsiO9dp1i3hATAmZ3kqcFzDH94I4fjQ3cAfPS6vGe/Ubqe2yINhMI1HVp6SDICEywyk8
         YQoU+pS8vQW7gEgnUdfYmryJGhD6QZbIhiDbQDBg44bbsw3Pp0tpNBGoHW/51B3+5uxy
         3XLg==
X-Gm-Message-State: AOAM531JhfxQ2i0DMX5XGr/LOO8gZGMaNRO6Ag3skoiLx7dw/s4mbeEd
        PnbwvlD6gjcjtR55mziVEp27cg==
X-Google-Smtp-Source: ABdhPJxp79xScEgykiDP0CxkSHeSRrntqdGoY37VUMEoTQ1Em4KDKgfzrkEoN0Lbi1cuK4egRfspXw==
X-Received: by 2002:a9d:2781:: with SMTP id c1mr16656514otb.267.1643922311223;
        Thu, 03 Feb 2022 13:05:11 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id t16sm4031otc.29.2022.02.03.13.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 13:05:10 -0800 (PST)
Date:   Thu, 3 Feb 2022 13:05:27 -0800
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
Message-ID: <YfxDlxvuMt2jXd6z@ripper>
References: <20220129005429.754727-1-bjorn.andersson@linaro.org>
 <20220129005429.754727-2-bjorn.andersson@linaro.org>
 <20220202162930.24zcediw44t2jzqf@pengutronix.de>
 <Yfr6RQwJMZY5RZGr@ripper>
 <20220203083103.mqwkjxkgy22jaies@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220203083103.mqwkjxkgy22jaies@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03 Feb 00:31 PST 2022, Uwe Kleine-K?nig wrote:

> Hello Bjorn,
> 
> On Wed, Feb 02, 2022 at 01:40:21PM -0800, Bjorn Andersson wrote:
> > On Wed 02 Feb 08:29 PST 2022, Uwe Kleine-K?nig wrote:
> > > did you consider my earlier feedback "It would also be good if the PWM
> > > code could live in drivers/pwm"?
> > > (https://lore.kernel.org/r/20210505051958.e5lvwfxuo2skdu2q@pengutronix.de)
> > 
> > Yes, I did consider this. Because the downstream driver is (at least was
> > when I looked at it originally) split like that.
> > 
> > We have a number of different Qualcomm PMICs containing the LPG modules,
> > which consists of N PWM channels, a pattern lookup table and a set of
> > current sinks.
> > 
> > Each PWM channel can either be used as a traditional PWM, a LED or be
> > grouped together with other channels to form a multicolor LED. So we
> > need a design that allows different boards using a particular PMIC to
> > freely use the N channels according to one of these three operational
> > modes.
> > 
> > The pattern lookup table is a shared resource containing duty cycle
> > values and each of the PWM channels can be configured to have their duty
> > cycle modified from the lookup table on some configured cadence.
> > 
> > In the even that multiple PWM channels are ganged together to form a
> > multicolor LED, which is driven by a pattern, the pattern generator for
> > the relevant channels needs to be synchronized.
> 
> Is this some material for the commit log to motivate the design
> decision?
> 

Sounds reasonable. I'll try to capture some of this background in the
commit message, for future reference.

> > If we consider the PWM channel to be the basic primitive we need some
> > mechanism to configure the pattern properties for each of the channels
> > and we need some mechanism to synchronize the pattern generators for
> > some subset of the PWM channels.
> > 
> > 
> > In other words we need some custom API between the LED driver part and
> > the PWM driver, to configure these properties. This was the design
> > of the downstream driver when I started looking at this driver.
> > 
> > 
> > Another alternative that has been considered is to create two
> > independent drivers - for the same hardware. This would allow the system
> > integrator to pick the right driver for each of the channels.
> > 
> > One problem with this strategy is that the DeviceTree description of the
> > LPG hardware will have to be modified depending on the use case. In
> > particular this prevents me from writing a platform dtsi describing the
> > LPG hardware and then describe the LEDs and pwm channels in a board dts.
> > 
> > And we can't express the individual channels, because the multicolor
> > definition needs to span multiple channels.
> > 
> > 
> > So among all the options, implementing the pwm_chip in the LED driver
> > makes it possible for us to describe the LPG as one entity, with
> > board-specific LEDs and a set of PWM channels.
> 
> ok.
> 
> > > At least splitting in two patches would be good IMHO.
> > 
> > I guess I can split out the parts related to the pwmchip in a separate
> > patch. Seems to be a rather small portion of the code though. Is that
> > what you have in mind?
> 
> I didn't try to understand the pattern part. I know that for PWMs there
> is no pattern support, wasn't aware it's a thing for LEDs.
> 

It allow you to have the hardware adjust the duty cycle over time, to
implement things such as fading or pulsing light effects - without
having to use the CPU.

> Anyhow, not a hard requirement to split from my side.
> 

Okay, cool.

> > > > +/*
> > > > + * Limitations:
> > > > + * - Updating both duty and period is not done atomically, so the output signal
> > > > + *   will momentarily be a mix of the settings.
> > > 
> > > Is the PWM well-behaved? (i.e. does it emit the inactive level when
> > > disabled?)
> > 
> > Yes, a disabled channel outputs a logical 0.
> 
> Please add this to the Limitations section. It's not actually a
> limitation, but still this is a good place to put this information.
> 
> > > Does it complete a period before switching to the new
> > > setting?
> > 
> > I see nothing indicating the answer to this, in either direction...
> 
> Can you test that? It's as easy as configuring a long period with 0%
> relative duty cycle and then immediately a 100% relative duty cycle.
> 

I will give it a try and see what I can deduce, and update the comment
accordingly.

> > > > +static void lpg_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> > > > +			      struct pwm_state *state)
> > > > +{
> > > > +	struct lpg *lpg = container_of(chip, struct lpg, pwm);
> > > > +	struct lpg_channel *chan = &lpg->channels[pwm->hwpwm];
> > > > +	u64 duty = DIV_ROUND_UP_ULL(chan->pwm_value * chan->period, LPG_RESOLUTION - 1);
> > > > +
> > > > +	state->period = chan->period;
> > > > +	state->duty_cycle = duty;
> > > > +	state->polarity = PWM_POLARITY_NORMAL;
> > > > +	state->enabled = chan->enabled;
> > > 
> > > This doesn't work if .get_state() is called before .apply() was called,
> > > does it?
> > > 
> > 
> > You mean that I would return some bogus state and not the actual
> > hardware state?
> 
> Yes. At least I only found lpg_calc_freq() assigning chan->period and
> chan->enabled. And unless I missed something this isn't called before
> the pwm core calls .get_state().
> 

Right, with a freshly probed driver I would return period = 0,
duty_cycle = 0/511 and enabled = 0.

Am I expected to instead return the hardware state, e.g. to recover
hardware initialization provided by the bootloader?

Thanks,
Bjorn

> > > > +}
> 
> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |


