Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682EB5A91FB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 10:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbiIAIVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 04:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbiIAIVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:21:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680FB5F98A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 01:20:20 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1oTfQw-0000UY-BP; Thu, 01 Sep 2022 10:20:18 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1oTfQv-0001tg-Ct; Thu, 01 Sep 2022 10:20:17 +0200
Date:   Thu, 1 Sep 2022 10:20:17 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Sascha Hauer <kernel@pengutronix.de>
Subject: Re: [PATCH v2 1/2] gpio: Add gpio latch driver
Message-ID: <20220901082017.GP24324@pengutronix.de>
References: <20220831055811.1936613-1-s.hauer@pengutronix.de>
 <20220831055811.1936613-2-s.hauer@pengutronix.de>
 <CAHp75Vd6LCv1wcxV58Q3Pa=eBRdEK6XusbfeDQtm8+R0hAAyWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vd6LCv1wcxV58Q3Pa=eBRdEK6XusbfeDQtm8+R0hAAyWg@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
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

On Wed, Aug 31, 2022 at 11:50:47PM +0300, Andy Shevchenko wrote:
> On Wed, Aug 31, 2022 at 9:02 AM Sascha Hauer <s.hauer@pengutronix.de> wrote:
> >
> > This driver implements a GPIO multiplexer based on latches connected to
> > other GPIOs. A set of data GPIOs is connected to the data input of
> > multiple latches. The clock input of each latch is driven by another
> > set of GPIOs. With two 8-bit latches 10 GPIOs can be multiplexed into
> > 16 GPIOs. GPOs might be a better term as in fact the multiplexed pins
> > are output only.
> 
> I'm still unsure it shouldn't be a part of the (not yet in upstream)
> driver that I have mentioned before. But let's leave this apart right
> now.

I don't see how this could be done. The before mentioned driver depends
on a gpio-mux which is a binary decoder. This doesn't have a
correspondence in this driver.

> 
> ...
> 
> > +#include <linux/err.h>
> > +#include <linux/module.h>
> 
> > +#include <linux/of_device.h>
> 
> Why?
> It seems you misplaced it instead of mod_devicetable.h.

Ok.

> 
> > +#include <linux/gpio/driver.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/gpio/consumer.h>
> 
> Keep above sorted?
> 
> ...
> 
> > +       struct mutex mutex;
> > +       spinlock_t spinlock;
> 
> Checkpatch usually complains if locks are not commented. Looking at
> the below code, why it's not an (anonymous) union?

checkpatch only complains here when given a --subjective. Anyway,
commenting it is a good thing, and a union can be used here.

> 
> ...
> 
> > +       if (val)
> > +               priv->shadow[latch] |= BIT(offset % priv->n_pins);
> > +       else
> > +               priv->shadow[latch] &= ~BIT(offset % priv->n_pins);
> 
> I believe shadow should be defined as unsigned long * and hence normal
> bit operations can be applied. For example here is assign_bit().

Good point.

> > +static const struct of_device_id gpio_latch_ids[] = {
> > +       {
> > +               .compatible     = "gpio-latch",
> > +       }, {
> > +               /* sentinel */
> > +       }
> 
> You may compress this to the 2 LoCs.

I usually prefer not doing that as it means that we have to reformat it
once we initialize other fields as well, like here for example .data.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
