Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3FFB48F8A1
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 19:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbiAOSIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 13:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbiAOSIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 13:08:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A457C061574;
        Sat, 15 Jan 2022 10:08:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD85DB809E3;
        Sat, 15 Jan 2022 18:08:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D58C36AE5;
        Sat, 15 Jan 2022 18:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642270101;
        bh=ti3EFz0vjLpT5haAhw/2g1kDCJrvQ9FNEfVIwLyjAGI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ncpxx8oWYCHYt4ZiADAmRIN2UVdscboPCLrjamKcB2VnbjLASvv9zlERBmsHMBVNu
         muyWJovg3FMNhUKJVMQN/E3AMZVnGmq3NrAio+beFUY/hWPN3EhJUCKRDDHEOb3wJJ
         1tJuGEvUwTuVVWcJsX3UjimbkKwvBoYTimnXDL83I5Qzmt6C0etnnmL0brZ8+Q6+NB
         rxnskp9ukWjNJXZCYQRdPPMbMNNkTsEcaV8Yf/3w4V2CgA6TtaGD71zO50JTP1HB+J
         dLWvOrIwsqxqFztQeL/jRcUsKqeH46bOX4OKF9hDbgN09GWRFNUXYOQZbuxxn7YJKS
         j2niK1ZojC2qQ==
Date:   Sat, 15 Jan 2022 18:14:22 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Robin van der Gracht <robin@protonic.nl>,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v1 1/1] iio: adc: tsc2046: rework the trigger state
 machine
Message-ID: <20220115181422.0b622b69@jic23-huawei>
In-Reply-To: <20220110123903.GC3326@pengutronix.de>
References: <20220107074017.2762347-1-o.rempel@pengutronix.de>
        <20220109154404.75e0ed2f@jic23-huawei>
        <20220110123903.GC3326@pengutronix.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

...

> > >  
> > > -static enum hrtimer_restart tsc2046_adc_trig_more(struct hrtimer *hrtimer)
> > > +static enum hrtimer_restart tsc2046_adc_timer(struct hrtimer *hrtimer)
> > >  {
> > >  	struct tsc2046_adc_priv *priv = container_of(hrtimer,
> > >  						     struct tsc2046_adc_priv,
> > >  						     trig_timer);
> > >  	unsigned long flags;
> > >  
> > > -	spin_lock_irqsave(&priv->trig_lock, flags);
> > > -
> > > -	disable_irq_nosync(priv->spi->irq);
> > > -
> > > -	priv->trig_more_count++;
> > > -	iio_trigger_poll(priv->trig);
> > > -
> > > -	spin_unlock_irqrestore(&priv->trig_lock, flags);
> > > +	spin_lock_irqsave(&priv->state_lock, flags);
> > > +	switch (priv->state) {
> > > +	case TSC2046_STATE_ENABLE_IRQ_POLL:
> > > +		/*
> > > +		 * IRQ handler called iio_trigger_poll() to sample ADC.
> > > +		 * Here we
> > > +		 * - re-enable IRQs
> > > +		 * - start hrtimer for timeout if no IRQ will occur
> > > +		 */
> > > +		priv->state = TSC2046_STATE_POLL;
> > > +		enable_irq(priv->spi->irq);  
> > 
> > I comment on this below, but I'm not sure why you don't move the enable_irq()
> > here out of this timer function and then have the first entry of the timer
> > go directly to TSC2046_STATE_POLL after a longer initial wait.  
> 
> Hm... yes. You are right.
> 
> > It's been a long time since I looked at this, so perhaps I'm missing the
> > point.  What you have here works as far as I can see, it just seems to push
> > more than necessary into the state machine.  
> 
> The IRQ line is a level shifter connected to one of channels muxed to the core
> ADC. If we switch internal muxer to different channel, the IRQ line will
> change the state.
> 
> So, we need a trigger which:
> - do not triggers if we do ADC readings.
> - keeps triggering as long as we have some state changes on the IRQ line
> - trigger only with specific rate
> - still triggers for some amount of time after last interrupt event was
>   detected. Current implementation is doing only one extra read.
Ah.. Good explanation, I get the point now :)

Jonathan
