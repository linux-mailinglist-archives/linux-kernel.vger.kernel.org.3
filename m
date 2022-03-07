Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C2B4D07D5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 20:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245124AbiCGTlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 14:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbiCGTlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 14:41:44 -0500
Received: from smtp-out3.electric.net (smtp-out3.electric.net [208.70.128.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5347324F0D;
        Mon,  7 Mar 2022 11:40:49 -0800 (PST)
Received: from 1nRJDr-0004sP-UY by out3d.electric.net with emc1-ok (Exim 4.94.2)
        (envelope-from <kris@embeddedTS.com>)
        id 1nRJDs-0004vZ-V8; Mon, 07 Mar 2022 11:40:48 -0800
Received: by emcmailer; Mon, 07 Mar 2022 11:40:48 -0800
Received: from [66.210.251.27] (helo=mail.embeddedts.com)
        by out3d.electric.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <kris@embeddedTS.com>)
        id 1nRJDr-0004sP-UY; Mon, 07 Mar 2022 11:40:47 -0800
Received: from tsdebian (_gateway [192.168.0.64])
        by mail.embeddedts.com (Postfix) with ESMTPSA id B5B713D392;
        Mon,  7 Mar 2022 12:40:46 -0700 (MST)
Message-ID: <1646682026.7444.2.camel@embeddedTS.com>
Subject: Re: [PATCH] gpio: ts4900: Do not set DAT and OE together
From:   Kris Bahnsen <kris@embeddedTS.com>
Reply-To: kris@embeddedTS.com
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Featherston <mark@embeddedts.com>
Date:   Mon, 07 Mar 2022 11:40:26 -0800
In-Reply-To: <CAMRc=MeHT4pX1ZRbOz0owDDec5rv+FE84rp464ugffbH5PuS5w@mail.gmail.com>
References: <20220304221517.30213-1-kris@embeddedTS.com>
         <CAMRc=MeHT4pX1ZRbOz0owDDec5rv+FE84rp464ugffbH5PuS5w@mail.gmail.com>
Organization: embeddedTS
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Outbound-IP: 66.210.251.27
X-Env-From: kris@embeddedTS.com
X-Proto: esmtps
X-Revdns: wsip-66-210-251-27.ph.ph.cox.net
X-HELO: mail.embeddedts.com
X-TLS:  TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256
X-Authenticated_ID: 
X-Virus-Status: Scanned by VirusSMART (c)
X-Virus-Status: Scanned by VirusSMART (b)
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=embeddedTS.com; s=mailanyone20220121;h=Mime-Version:References:In-Reply-To:Date:To:From:Message-ID; bh=zG3JQ1AtPaZKEqLY1Uf3Ei4t09ru1Q8ncGgjkOed1xA=;b=a5Nry+bDgsbHj8ZkLQ13zOHYJy9PlkqOyK3VzKPvp9GvbxkGqkF9M5XJochGRVa0POQuQsMm+g1i82Igi3c8XviHa04a/fwtTrfj4aNG0v8qX80fgarJGJ6IvXQJobGGmd+Syfh6j3dWUQsekOPthkpP9K5mgiO1anagP57VCpPPFsTTjhrLXWDDeur0cILn8gGtr3L6jpAHEkQ13p1CO/huVthOK1/G0UmM9QbhNfniiGHCUSBWJH/m0WS/uPZotODG8quSX6k1cbB6iG+kFflkTrRTN+1QyxLIRQ6UyiSgScxEFWFHGZolsXuvJqFr80ABuJ2E45MON7W9o9bLrg==;
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-03-07 at 10:13 +0100, Bartosz Golaszewski wrote:
> On Fri, Mar 4, 2022 at 11:15 PM Kris Bahnsen <kris@embeddedts.com> wrote:
> > 
> > From: Mark Featherston <mark@embeddedTS.com>
> > 
> > This works around an issue with the hardware where both OE and
> > DAT are exposed in the same register. If both are updated
> > simultaneously, the harware makes no guarantees that OE or DAT
> > will actually change in any given order and may result in a
> > glitch of a few ns on a GPIO pin when changing direction and value
> > in a single write.
> > 
> > Setting direction to input now only affects OE bit. Setting
> > direction to output updates DAT first, then OE.
> > 
> > Signed-off-by: Mark Featherston <mark@embeddedTS.com>
> > Signed-off-by: Kris Bahnsen <kris@embeddedTS.com>
> > ---
> >  drivers/gpio/gpio-ts4900.c | 25 ++++++++++++++++++++-----
> >  1 file changed, 20 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/gpio/gpio-ts4900.c b/drivers/gpio/gpio-ts4900.c
> > index d885032cf814..fbabfca030c0 100644
> > --- a/drivers/gpio/gpio-ts4900.c
> > +++ b/drivers/gpio/gpio-ts4900.c
> > @@ -1,7 +1,8 @@
> > +// SPDX-License-Identifier: GPL-2.0
> >  /*
> >   * Digital I/O driver for Technologic Systems I2C FPGA Core
> >   *
> > - * Copyright (C) 2015 Technologic Systems
> > + * Copyright (C) 2015-2018 Technologic Systems
> >   * Copyright (C) 2016 Savoir-Faire Linux
> >   *
> >   * This program is free software; you can redistribute it and/or
> > @@ -55,19 +56,33 @@ static int ts4900_gpio_direction_input(struct gpio_chip *chip,
> >  {
> >         struct ts4900_gpio_priv *priv = gpiochip_get_data(chip);
> > 
> > -       /*
> > -        * This will clear the output enable bit, the other bits are
> > -        * dontcare when this is cleared
> > +       /* Only clear the OE bit here, requires a RMW. Prevents potential issue
> > +        * with OE and data getting to the physical pin at different times.
> >          */
> > -       return regmap_write(priv->regmap, offset, 0);
> > +       return regmap_update_bits(priv->regmap, offset, TS4900_GPIO_OE, 0);
> >  }
> > 
> >  static int ts4900_gpio_direction_output(struct gpio_chip *chip,
> >                                         unsigned int offset, int value)
> >  {
> >         struct ts4900_gpio_priv *priv = gpiochip_get_data(chip);
> > +       unsigned int reg;
> >         int ret;
> > 
> > +       /* If changing from an input to an output, we need to first set the
> > +        * proper data bit to what is requested and then set OE bit. This
> > +        * prevents a glitch that can occur on the IO line
> > +        */
> > +       regmap_read(priv->regmap, offset, &reg);
> > +       if (!(reg & TS4900_GPIO_OE)) {
> > +               if (value)
> > +                       reg = TS4900_GPIO_OUT;
> > +               else
> > +                       reg &= ~TS4900_GPIO_OUT;
> > +
> > +               regmap_write(priv->regmap, offset, reg);
> > +       }
> > +
> >         if (value)
> >                 ret = regmap_write(priv->regmap, offset, TS4900_GPIO_OE |
> >                                                          TS4900_GPIO_OUT);
> > --
> > 2.11.0
> > 
> 
> This looks like a fix, can you add a Fixes tag?
> 
> Bart
> 

Please excuse my ignorance (and email client issues) I am still learning the
submission process. I'm not sure what kind of Fixes tag to add in this scenario.

This GPIO issue has existed since the driver's inception. It is a quirk of
hardware that has always existed on this platform. The driver was originally
implemented by Savoir-faire Linux. We discovered the issue and have had it
patched in our trees for years and wanted to push it upstream.

There is no public discussion on it, it was found and patched. And, aside from
the first commit of this driver, there is no commit that introduced any issue.

Can you please advise what kind of Fixes tag is appropriate in this situation?

Additionally, if I do add a Fixes tag, would that warrant a v2 patch? Or would
it just need to be an email response that includes it?

Kris
