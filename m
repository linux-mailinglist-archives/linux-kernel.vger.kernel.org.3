Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7DD59AFEF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 21:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiHTTgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 15:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiHTTgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 15:36:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E9D63D1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 12:36:37 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oPUGl-00038H-Qq; Sat, 20 Aug 2022 21:36:31 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oPUGd-0006zB-Bm; Sat, 20 Aug 2022 21:36:23 +0200
Date:   Sat, 20 Aug 2022 21:36:23 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Gireesh.Hiremath@in.bosch.com, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, bcousson@baylibre.com,
        tony@atomide.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mkorpershoek@baylibre.com,
        davidgow@google.com, swboyd@chromium.org, fengping.yu@mediatek.com,
        y.oudjana@protonmail.com, rdunlap@infradead.org,
        colin.king@intel.com, sjoerd.simons@collabora.co.uk,
        VinayKumar.Shettar@in.bosch.com,
        Govindaraji.Sivanantham@in.bosch.com, anaclaudia.dias@de.bosch.com
Subject: Re: [PATCH v3 1/3] driver: input: matric-keypad: switch to gpiod
Message-ID: <20220820193623.bnjgnydu3rkbdtbo@pengutronix.de>
References: <20220819065946.9572-1-Gireesh.Hiremath@in.bosch.com>
 <20220819131231.nzi26cbrpgfrycl2@pengutronix.de>
 <YwAx38N0ICE37Vu9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwAx38N0ICE37Vu9@google.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On 22-08-19, Dmitry Torokhov wrote:
> On Fri, Aug 19, 2022 at 03:12:31PM +0200, Marco Felsch wrote:
> > Hi Gireesh,
> > 
> > On 22-08-19, Gireesh.Hiremath@in.bosch.com wrote:
> > > From: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>
> > > 
> > > Switch from gpio API to gpiod API
> > 
> > Nice change.
> > 
> > Did you checked the users of this driver? This change changes the
> > behaviour for actice_low GPIOs. A quick check showed that at least on
> > upstream board: arch/arm/mach-pxa/palmtc.c uses active low GPIOs.
> > 
> > > Signed-off-by: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>
> > > 
> > > Gbp-Pq: Topic apertis/guardian
> > > Gbp-Pq: Name driver-input-matric-keypad-switch-gpio-to-gpiod.patch
> > 
> > Please drop this internal tags.
> > 
> > > ---
> > >  drivers/input/keyboard/matrix_keypad.c | 84 ++++++++++----------------
> > >  include/linux/input/matrix_keypad.h    |  4 +-
> > >  2 files changed, 33 insertions(+), 55 deletions(-)
> > > 
> > > diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
> > > index 30924b57058f..b99574edad9c 100644
> > > --- a/drivers/input/keyboard/matrix_keypad.c
> > > +++ b/drivers/input/keyboard/matrix_keypad.c
> > > @@ -15,11 +15,10 @@
> > >  #include <linux/interrupt.h>
> > >  #include <linux/jiffies.h>
> > >  #include <linux/module.h>
> > > -#include <linux/gpio.h>
> > > +#include <linux/gpio/consumer.h>
> > >  #include <linux/input/matrix_keypad.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/of.h>
> > > -#include <linux/of_gpio.h>
> > >  #include <linux/of_platform.h>
> > >  
> > >  struct matrix_keypad {
> > > @@ -49,11 +48,11 @@ static void __activate_col(const struct matrix_keypad_platform_data *pdata,
> > >  	bool level_on = !pdata->active_low;
> > >  
> > >  	if (on) {
> > > -		gpio_direction_output(pdata->col_gpios[col], level_on);
> > > +		gpiod_direction_output(pdata->col_gpios[col], level_on);
> > 
> > Now strange things can happen, if active_low is set and you specified
> > GPIO_ACTIVE_LOW within the device-tree. We need a way to move to gpiod
> > and keep the current behaviour.
> > 
> > >  	} else {
> > > -		gpio_set_value_cansleep(pdata->col_gpios[col], !level_on);
> > > +		gpiod_set_value_cansleep(pdata->col_gpios[col], !level_on);
> > >  		if (!pdata->drive_inactive_cols)
> > > -			gpio_direction_input(pdata->col_gpios[col]);
> > > +			gpiod_direction_input(pdata->col_gpios[col]);

...

> > > @@ -429,9 +410,6 @@ matrix_keypad_parse_dt(struct device *dev)
> > >  	pdata->wakeup = of_property_read_bool(np, "wakeup-source") ||
> > >  			of_property_read_bool(np, "linux,wakeup"); /* legacy */
> > >  
> > > -	if (of_get_property(np, "gpio-activelow", NULL))
> > > -		pdata->active_low = true;
> > > -
> > 
> > This removes backward compatibility, please don't do that.
> 
> I do not think there is a reasonable way of keeping the compatibility
> while using gpiod API (sans abandoning polarity handling and using
> *_raw() versions of API).
> 
> I would adjust the DTSes in the kernel and move on, especially given
> that the DTSes in the kernel are inconsistent - they specify
> gpio-activelow attribute while specifying "action high" in gpio
> properties).

Yes, because the driver didn't respect that by not using the gpiod API.
Got your point for the DTses but what about the boards based on the
platform-data? Those boards must be changed as well.

Also I thought DTB is firmware and we should never break it, now we
doing it by this commit. Just to get your opinion on this.

Regards,
  Marco
