Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C889485C36
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 00:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245362AbiAEXXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 18:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245348AbiAEXXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 18:23:15 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3529FC061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 15:23:15 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6F2FF8AE;
        Thu,  6 Jan 2022 00:23:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1641424992;
        bh=IoVHqe07R+79DXVKO3tIcHIexRNs7ifl3UNUDXn04/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CKXqDfCtlkYVtpk4AWgdf7/Ms7gf2hEetLi0fuJ0e8BWHC46X333efySdz6eGg+Ia
         QoZy74YgL4wnyIHDaA4UoT3WIfL8AIJjlBC5Yn2XTFhtQJV48MS4ybC4DJ/v5Nta+E
         HEjjioPPs7RskWsKI5EsjRrCIIQd27h7iCRwuZA4=
Date:   Thu, 6 Jan 2022 01:23:07 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Watson Chow <watson.chow@avnet.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 2/2] regulator: Add MAX20086-MAX20089 driver
Message-ID: <YdYoW2me4aHpJzfm@pendragon.ideasonboard.com>
References: <20220102211124.18435-1-laurent.pinchart+renesas@ideasonboard.com>
 <20220102211124.18435-3-laurent.pinchart+renesas@ideasonboard.com>
 <YdRWwWmoQGQuUyLz@sirena.org.uk>
 <YdRa0GoSoX8CP694@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YdRa0GoSoX8CP694@pendragon.ideasonboard.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Tue, Jan 04, 2022 at 04:33:54PM +0200, Laurent Pinchart wrote:
> On Tue, Jan 04, 2022 at 02:16:33PM +0000, Mark Brown wrote:
> > On Sun, Jan 02, 2022 at 11:11:24PM +0200, Laurent Pinchart wrote:
> > 
> > > ---
> > > Changes since v0:
> > > 
> > > - Remove unused regulator_config members
> > > - Drop unused header
> > 
> > This is a *very* long list relative to something that was never posted
> > :/
> 
> I've included it for reference for Watson. It's not meant for upstream,
> I'll drop it in v2.
> 
> > > @@ -1415,4 +1424,3 @@ config REGULATOR_QCOM_LABIBB
> > >  	  for LCD display panel.
> > >  
> > >  endif
> > > -
> > 
> > Unrelated whitespace change.
> 
> Oops.
> 
> > > --- /dev/null
> > > +++ b/drivers/regulator/max20086-regulator.c
> > > @@ -0,0 +1,333 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > +/*
> > > + * max20086-regulator.c - MAX20086-MAX20089 camera power protector driver
> > > + *
> > 
> > Please keep the entire comment a C++ one so things look more
> > intentional.
> 
> OK.
> 
> > > +#include <linux/regmap.h>
> > > +#include <linux/regulator/driver.h>
> > > +#include <linux/regulator/machine.h>
> > 
> > It is worrying that a regulator driver should need the interfaces for
> > machines...  the driver doesn't look like it actually does though.
> 
> I'll try to remove it.

It compiles fine, but I won't be able to check the init data to figure
out the initial enable GPIO state if I don't include machine.h, as
that's where regulator_init_data is defined. Am I missing something ?

> > > +static int max20086_parse_regulators_dt(struct max20086 *chip)
> > > +{
> > > +	struct of_regulator_match matches[MAX20086_MAX_REGULATORS] = { };
> > > +	struct device_node *node;
> > > +	unsigned int i;
> > > +	unsigned int n;
> > > +	int num;
> > 
> > You should be able to remove the stuff about looking for the regulators
> > node and just set of_match and regulators_node in the descs.
> 
> I'll give it a try. I'm not very experienced with the regulator
> framework, sorry for the rookie mistakes.
> 
> > > +	num = of_regulator_match(chip->dev, node, matches,
> > > +				 chip->info->num_outputs);
> > > +	of_node_put(node);
> > > +	if (num <= 0) {
> > > +		dev_err(chip->dev, "Failed to match regulators\n");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	chip->num_outputs = num;
> > 
> > The number of regulators the device supports should be known from the
> > compatible, I'd expect a data table for this.  It should be possible to
> > read the state of regulators not described in the DT.
> 
> Does this mean that the driver should register all regulators, even the
> ones not described in DT ? Who would read the state ?
> 
> > > +static const struct regmap_config max20086_regmap_config = {
> > > +	.reg_bits = 8,
> > > +	.val_bits = 8,
> > > +	.writeable_reg = max20086_gen_is_writeable_reg,
> > > +	.max_register = 0x9,
> > > +	.cache_type = REGCACHE_NONE,
> > > +};
> > 
> > No readback support?
> 
> I'll fix that.

Actually I'm not sure what you mean here. All registers are readable,
what's wrong with the above regmap_config ?

> > > +	/* Turn off all outputs. */
> > > +	ret = regmap_update_bits(chip->regmap, MAX20086_REG_CONFIG,
> > > +				 MAX20086_EN_MASK, 0);
> > > +	if (ret < 0) {
> > > +		dev_err(chip->dev, "Failed to disable outputs: %d\n", ret);
> > > +		return ret;
> > > +	}
> > 
> > The driver should not do not do this - the driver should only configure
> > the hardware if told to by the core which in turn will only do this if
> > there's explicit permission to do so in the machine constraints.  We
> > don't know what some system integrator might have thought to do with
> > the device.
> 
> I'll fix that too (I actually suspected the topic could get raised
> during review :-)).
> 
> > > +	/* Get the chip out of low-power shutdown state. */
> > > +	chip->gpio_en = devm_gpiod_get(chip->dev, "enable", GPIOD_OUT_HIGH);
> > > +	if (IS_ERR(chip->gpio_en)) {
> > > +		ret = PTR_ERR(chip->gpio_en);
> > > +		dev_err(chip->dev, "Failed to get enable GPIO: %d\n", ret);
> > > +		return ret;
> > > +	}
> > 
> > This one is more OK - it's changing the state of the outputs that's an
> > issue.  I guess this might cause the outputs to come on though if the
> > GPIO was left off by the bootloader which is awkward.  If there's
> > nothing other than the outputs going on with the chip I would be tempted
> > to map this onto the per regulator enable GPIO that the core supports,
> > the core will then be able to manage the low power state at runtime.
> > That's *probably* the least bad option we have with current interfaces.
> 
> While fishing for code I can copy in the always unfashionable cargocult
> style, I came across max8973-regulator.c that handles the enable GPIO in
> the following way:
> 
> 		if (ridata && (ridata->constraints.always_on ||
> 			       ridata->constraints.boot_on))
> 			gflags = GPIOD_OUT_HIGH;
> 		else
> 			gflags = GPIOD_OUT_LOW;
> 		gflags |= GPIOD_FLAGS_BIT_NONEXCLUSIVE;
> 		gpiod = devm_gpiod_get_optional(&client->dev,
> 						"maxim,enable",
> 						gflags);
> 
> Should I try to replicate that ? It gets more difficult with multiple
> regulators that share the same GPIO. That's why I left it as-is.
> 
> > It's a real shame we can't easily get the GPIO state at startup for
> > bootstrapping :/  

-- 
Regards,

Laurent Pinchart
