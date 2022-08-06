Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42DD58B6F2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 18:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbiHFQfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 12:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbiHFQfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 12:35:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C260B11451;
        Sat,  6 Aug 2022 09:35:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5619FB80022;
        Sat,  6 Aug 2022 16:35:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB396C433C1;
        Sat,  6 Aug 2022 16:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659803700;
        bh=o8ku1LqIPLZoCVCueo/vZQPcVuxTpLrbLUtyhua2psY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dDvgefIh3DrPi/2OYdCMYrIc1MOnrOKDVvKOauR0rkF2KjcYF00UK7eDd0Xr2Tta+
         he0PoK8PZvIBlsJu3b3IS5ds3rahVgPaP6oOXs7r4ucGv4CghJ6sKxSGQ2Unbq6V/D
         bh9tXgl8fVX7P1Lf00ak85FAlNoTkSRUAJgf43DMjikkX7LFnCKGbZj8kcOMxuggzC
         GyIhIRdtBnqhG7Y62Hi8bKjiWSxHBGDHWarqJ8QGuropwEV3b6wYlKzODeY0TtXm6W
         QYXIjUNy7KK/495Kn3J8ylYO6JRwzHw3fhcs7p4JMX2xtcYbwO3NbNHAHJ95LhiI9U
         rh2igynmiAenw==
Date:   Sat, 6 Aug 2022 17:45:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Julien Panis <jpanis@baylibre.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mranostay@ti.com, William Breathitt Gray <william.gray@linaro.org>
Subject: Re: [PATCH v3 2/2] iio: time: capture-tiecap: capture driver
 support for ECAP
Message-ID: <20220806174520.0d27476e@jic23-huawei>
In-Reply-To: <11b7436b-5c31-671e-ba77-435fe8e3b767@baylibre.com>
References: <20220728175124.468461-1-jpanis@baylibre.com>
        <20220728175124.468461-3-jpanis@baylibre.com>
        <20220731164116.30e91f34@jic23-huawei>
        <11b7436b-5c31-671e-ba77-435fe8e3b767@baylibre.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Aug 2022 16:08:02 +0200
Julien Panis <jpanis@baylibre.com> wrote:

> On 31/07/2022 17:41, Jonathan Cameron wrote:
> > On Thu, 28 Jul 2022 19:51:24 +0200
> > Julien Panis <jpanis@baylibre.com> wrote:
> >  
> >> ECAP hardware on AM62x SoC supports capture feature. It can be used
> >> to timestamp events (falling/rising edges) detected on signal input pin.
> >>
> >> This commit adds capture driver support for ECAP hardware on AM62x SoC.
> >>
> >> In the ECAP hardware, capture pin can also be configured to be in
> >> PWM mode. Current implementation only supports capture operating mode.
> >> Hardware also supports timebase sync between multiple instances, but
> >> this driver supports simple independent capture functionality.
> >>
> >> Signed-off-by: Julien Panis <jpanis@baylibre.com>  
> > Hi Julien,
> >
> > So this isn't the first ecap driver we've had proposed, but the previous
> > one was a few years ago and never reached v2.
> > https://lore.kernel.org/all/20200818153614.6438-1-dts86@cornell.edu/
> >
> > Honestly I can't remember much about it, but maybe the discussion around
> > that will be worth a reread.  
> 
> Hi Jonathan, thank you for your review.
> 
> I read the discussion about previous attempt, before submitting this 
> patch. There were
> interesting comments indeed.
> 
> But in this previous attempt, only one-shot pulses were handled 
> (moreover, global IRQ flag
> was not cleared, so I'm not sure that IRQ could be raised more than once).

:)

> 
> However, ECAP can be used to make time measurements for any type of 
> "square waveform".
> That's why I tried to make this event mode configurable. Besides, using 
> a continuous mode allows
> handling much more signal types (not only single pulses).

Makes sense.

> 
> >
> > The use of ABI here is unusual. So I'd definitely like to see some documentation
> > probably as a file in the main kernel documentation to explain what the interface
> > is an how that relates to what is being captured.  
> 
> OK, I will add some userspace documentation.
> 
> >
> > First thing to note here is the channel type of IIO_INDEX is now not actually
> > used any more because we moved all the relevant drivers over to the counter
> > subsystem (and we failed to mark it deprecated).  
> 
> I evaluated this counter subsystem before starting development. Counting 
> events is not "a priori"
> the goal when using ECAP.
> 
> Nevertheless, maybe "counter_push_event" function could do the job. If I 
> use counter API :
> # Option 1 : CAP1/2/3/4 registers could be seen as 4 channels of the 
> same counter...
> but there are not channels, there are just sequential timestamps 
> actually. So I'm afraid this leads
> to misunderstanding for the user.
> Moreover, the user will have to read several entries (counts 1/2/3/4) to 
> gather timestamps from
> the same input signal, which is not very convenient.
> # Option 2 : Either CAP 1/2/3/4 events could be gathered in a single 
> channel...but then it will not
> be possible to configure their polarity (rising/falling edge) 
> individually (unless I did
> not understand well counter framework documentation).
> 
> So, even with counter framework, it will lead to some diverted use of 
> the framwork, since ECAP
> is a very specific hardware that do not fit 100% counter philosophy.
> 
> I admit that ECAP do not fit 100% IIO philosophy either.

Understood.  +CC William to see if we can form a consensus on how
at least which subsystem to hammer this into :)

> 
> Maybe misc API would be more relevant actually. Any opinion about it 
> will be welcome. :-)

It's possible we'll fall back to misc, but if at all possible it would
be better to make whatever extensions are necessary to a subsystem so that
other similar devices end up with a home in the long run.

Key here is definitely documentation!

> 
> >
> > Anyhow, I've reviewed below, but need docs to discuss this in depth.  In particular
> > the mix of buffers and events interfaces is unlikely to be an acceptable path
> > forwards.  
> 
> OK, I will consider alternatives.
> 
> >
> > Jonathan
A quick process comment.  If you agree with something in a review
no need to say that. Just delete the relevant code block from your reply.
Only need to discuss the other stuff!   Reviewers read a lot of email
so cutting down the volume makes them less grumpy :)

> >  
> >> + * struct ecap_iio_data - IIO device data
> >> + * @ev_idx:  event index (0 to 3 for CAP1 to CAP4)  
> > That's a long way from standard ABI.  
> 
> OK, I will consider alternatives.

We might to make new ABI though.   Need to discuss that against
a description rather than finding it buried deep in code.
One possibility is that we have an events only IIO device
as perhaps this fits better int he events interface (the
timestamp part is problematic though).
> 
> >  
> >> + * @ev_time: falling/rising edge timestamp
> >> + *

...

...

> >> +static irqreturn_t ecap_iio_isr(int irq, void *dev_id)
> >> +{
> >> +	struct iio_dev *indio_dev = dev_id;
> >> +	struct ecap_iio_dev *ecap_dev = iio_priv(indio_dev);
> >> +	struct ecap_iio_data *ecap_data = &ecap_dev->data;
> >> +	unsigned int clr = 0;
> >> +	unsigned int flg;
> >> +	unsigned int cap_time;
> >> +	int i;
> >> +
> >> +	regmap_read(ecap_dev->regmap, ECAP_ECINT_EN_FLG_REG, &flg);
> >> +
> >> +	for (i = 0 ; i < ECAP_NB_CEVT ; i++) {
> >> +		if (flg & ECAP_CEVT_FLG_BIT(i)) {
> >> +			if (i < ECAP_NB_CAP) {
> >> +				/*
> >> +				 * Input signal edge detected
> >> +				 * time_ns = 10^9 * time_cycles / clk_rate
> >> +				 */
> >> +				ecap_data->ev_idx = i;
> >> +				regmap_read(ecap_dev->regmap, ECAP_CAP_REG(i), &cap_time);
> >> +				ecap_data->ev_time = cap_time * NSEC_PER_SEC;
> >> +				do_div(ecap_data->ev_time, ecap_dev->clk_rate);  
> > Is there any attempt to align that timestamp with the iio clock used for software timestamps?  
> 
> No, this is not my goal. I just need to log hardware timestamp.
> But I am not sure that I fully understand what you mean (?).

IIO timestamps are meant to be useful for aligning multiple data sources. As such, where
we have hardware timestamps we normally attempt to apply a calibration to them so that they
map into the time base of the clocks used for IIO software timestamps.

If that's not possible then we need to think how to indicate to userspace that these
particular timestamps have a different meaning.

> 
> >> +			} else {
> >> +				/* Counter overflow */
> >> +				ecap_data->ev_idx = ECAP_OVF_VAL;
> >> +				ecap_data->ev_time = 0;  
> > Don't push it if you've lost data.  
> 
> This is not a lost data.

> That was intentional (equivalent in counter subsystem would be 
> COUNTER_EVENT_OVERFLOW).
> For a long duration signal, user will be aware that counter overflow 
> occurred (this can avoid misleading
> consecutive timestamp interpretations).
Handle that in software.  I assume the hardware is sensible enough to provide
a mechanism to notify you about a single overflow? (so that you don't get a
double overflow without knowing about it?)

If so, use a software counter of larger size and have that not overflow.
Typically a 64 bit counter will do fine for this for much longer than the
device is likely to be running (unless this thing has very high clock rates).

> Do you confirm that I should not push it ? Or maybe just explaining this 
> overflow better ?

It's not something userspace should ever need to know about.  We have
he equivalent for Performance Monitoring Units (drivers/perf)
There devices generally provide an overflow interrupt to allow us to
keep track of how many overflows have occurred and hence out a timestamp
that doesn't overflow often enough to matter.

> 
> >  
> >> +			}
> >> +			iio_push_to_buffers(indio_dev, ecap_data);
> >> +
> >> +			clr |= ECAP_CEVT_CLR_BIT(i);
> >> +		}
> >> +	}
> >> +
> >> +	clr |= ECAP_INT_CLR_BIT;
> >> +	regmap_update_bits(ecap_dev->regmap, ECAP_ECINT_CLR_FRC_REG, ECAP_CEVT_CLR_MASK, clr);
> >> +
> >> +	return IRQ_HANDLED;
> >> +}


Thanks,

Jonathan


