Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED09471C72
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 20:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbhLLTFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 14:05:00 -0500
Received: from 49-237-179-185.static.tentacle.fi ([185.179.237.49]:48332 "EHLO
        bitmer.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231902AbhLLTE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 14:04:59 -0500
Received: from jarkko by bitmer.com with local (Exim 4.89)
        (envelope-from <jarkko.nikula@bitmer.com>)
        id 1mwU9X-0000o6-Rv; Sun, 12 Dec 2021 21:04:55 +0200
Date:   Sun, 12 Dec 2021 21:04:55 +0200
From:   Jarkko Nikula <jarkko.nikula@bitmer.com>
To:     Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc:     =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] ARM: dts: Fix timer regression for beagleboard revision c
Message-ID: <20211212190455.qbggbhmr5nquw7bw@bitmer.com>
References: <20211125144834.52457-1-tony@atomide.com>
 <ef843afa-c99d-328d-853a-00ef293a47f2@bitmer.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef843afa-c99d-328d-853a-00ef293a47f2@bitmer.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 11, 2021 at 05:30:57PM +0200, Jarkko Nikula wrote:
> Hi Tony
> 
> On 11/25/21 16:48, Tony Lindgren wrote:
> > Commit e428e250fde6 ("ARM: dts: Configure system timers for omap3")
> > caused a timer regression for beagleboard revision c where the system
> > clockevent stops working if omap3isp module is unloaded.
> > 
> > Turns out we still have beagleboard revisions a-b4 capacitor c70 quirks
> > applied that limit the usable timers for no good reason. This also affects
> > the power management as we use the system clock instead of the 32k clock
> > source.
> > 
> > Let's fix the issue by adding a new omap3-beagle-ab4.dts for the old timer
> > quirks. This allows us to remove the timer quirks for later beagleboard
> > revisions. We also need to update the related timer quirk check for the
> > correct compatible property.
> > 
> > Fixes: e428e250fde6 ("ARM: dts: Configure system timers for omap3")
> > Cc: linux-kernel@vger.kernel.org
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Reported-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> 
> >  .../devicetree/bindings/arm/omap/omap.txt     |  3 ++
> >  arch/arm/boot/dts/Makefile                    |  1 +
> >  arch/arm/boot/dts/omap3-beagle-ab4.dts        | 47 +++++++++++++++++++
> >  arch/arm/boot/dts/omap3-beagle.dts            | 33 -------------
> >  drivers/clocksource/timer-ti-dm-systimer.c    |  2 +-
> >  5 files changed, 52 insertions(+), 34 deletions(-)
> >  create mode 100644 arch/arm/boot/dts/omap3-beagle-ab4.dts
> > 
> I must have some error in my methodology since I cannot see the issue
> being fixed with your patch :-(
> 
Facepalm, as I was expecting I had error in my methodology... see below

> cat arch/arm/boot/dts/omap3-beagle.dtb >>arch/arm/boot/zImage

This I used years before your patch and by some reason I confused to use
new omap3-beagle-ab4.dtb when testing your patch yesterday:

> cat arch/arm/boot/dts/omap3-beagle-ab4.dtb >>arch/arm/boot/zImage

without realizing my Beagle Board version is not between A to B4 but C2.
So when using the omap3-beagle.dtb your patch fixes the regression I
found.

Tested-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
