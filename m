Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 742AB485C0F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 00:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245295AbiAEXHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 18:07:18 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:34650 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245289AbiAEXHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 18:07:11 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 274408AE;
        Thu,  6 Jan 2022 00:07:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1641424030;
        bh=zcEWCUHYq5Ga7VssAivavMcr+zeVyIzOyZuqRlRc+2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OIcIX2nLGSuEYJMNxH6k6/B8kDUqXibqEWI9JK5lrs4jR6zztYNhmLSpZbS4juNWn
         FpQ7ChQJdBUBL6b/aO2R9RmcfyE1NBGg/ggYuOM4LqLlg0lVVn+dtiycPDV1mkMGS+
         XOyKHNo59BK2OzWtq4P3TMhMKtgSi/0GGfvuAYsg=
Date:   Thu, 6 Jan 2022 01:07:05 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Watson Chow <watson.chow@avnet.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 2/2] regulator: Add MAX20086-MAX20089 driver
Message-ID: <YdYkmSAYriUXv71W@pendragon.ideasonboard.com>
References: <20220102211124.18435-1-laurent.pinchart+renesas@ideasonboard.com>
 <20220102211124.18435-3-laurent.pinchart+renesas@ideasonboard.com>
 <YdRWwWmoQGQuUyLz@sirena.org.uk>
 <YdRa0GoSoX8CP694@pendragon.ideasonboard.com>
 <YdRd/m3mOwcvvJ2L@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YdRd/m3mOwcvvJ2L@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Tue, Jan 04, 2022 at 02:47:26PM +0000, Mark Brown wrote:
> On Tue, Jan 04, 2022 at 04:33:52PM +0200, Laurent Pinchart wrote:
> > On Tue, Jan 04, 2022 at 02:16:33PM +0000, Mark Brown wrote:
> 
> > > > +	chip->num_outputs = num;
> 
> > > The number of regulators the device supports should be known from the
> > > compatible, I'd expect a data table for this.  It should be possible to
> > > read the state of regulators not described in the DT.
> 
> > Does this mean that the driver should register all regulators, even the
> > ones not described in DT ? Who would read the state ?
> 
> Yes, just register everything.  Someone doing system debugging or
> bringup might want to read the state, and this also goes along with the
> ability to have the core pull the constraints out of the DT based on
> data supplied by the driver - the general goal is to have routine
> drivers simply register data tables with the core and need minimal code.

OK, that should simplify the driver. I'll give it a try.

> > > > +	/* Get the chip out of low-power shutdown state. */
> > > > +	chip->gpio_en = devm_gpiod_get(chip->dev, "enable", GPIOD_OUT_HIGH);
> > > > +	if (IS_ERR(chip->gpio_en)) {
> > > > +		ret = PTR_ERR(chip->gpio_en);
> > > > +		dev_err(chip->dev, "Failed to get enable GPIO: %d\n", ret);
> > > > +		return ret;
> > > > +	}
> > >
> > > This one is more OK - it's changing the state of the outputs that's an
> > > issue.  I guess this might cause the outputs to come on though if the
> > > GPIO was left off by the bootloader which is awkward.  If there's
> > > nothing other than the outputs going on with the chip I would be tempted
> > > to map this onto the per regulator enable GPIO that the core supports,
> > > the core will then be able to manage the low power state at runtime.
> > > That's *probably* the least bad option we have with current interfaces.
> >
> > While fishing for code I can copy in the always unfashionable cargocult
> > style, I came across max8973-regulator.c that handles the enable GPIO in
> > the following way:
> >
> > 		if (ridata && (ridata->constraints.always_on ||
> > 			       ridata->constraints.boot_on))
> > 			gflags = GPIOD_OUT_HIGH;
> > 		else
> > 			gflags = GPIOD_OUT_LOW;
> > 		gflags |= GPIOD_FLAGS_BIT_NONEXCLUSIVE;
> > 		gpiod = devm_gpiod_get_optional(&client->dev,
> > 						"maxim,enable",
> > 						gflags);
> >
> > Should I try to replicate that ? It gets more difficult with multiple
> > regulators that share the same GPIO. That's why I left it as-is.
> 
> We should really factor that bit out to the core too, though at the
> minute we pass in a gpio_desc so it's too late.  Doing the above is
> probably best, though I wouldn't loose any sleep over it being missing.
> you should definitely set the _NONEXCLUSIVE flag.  If someone specifies
> an incompatible mix of settings in the machine constraints I wouldn't
> worry about it too much, there's limits on what we can sort out.

I may skip it in the next version then, to first focus on getting the
other bits right.

Note that the outputs can be controlled individually over I2C even when
the enable GPIO is high, so keeping it high unconditionally will only
incur a bit of extra power consumption, it won't have any adverse effect
on the ability to control the outputs.

-- 
Regards,

Laurent Pinchart
