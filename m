Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863E35A4F0F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 16:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiH2OVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 10:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiH2OVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 10:21:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD078769E
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 07:21:38 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1oSfdw-0008Vp-3l; Mon, 29 Aug 2022 16:21:36 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1oSfdv-00060Y-Gz; Mon, 29 Aug 2022 16:21:35 +0200
Date:   Mon, 29 Aug 2022 16:21:35 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH 1/2] gpio: Add gpio latch driver
Message-ID: <20220829142135.GB24324@pengutronix.de>
References: <20220825094132.1268174-1-s.hauer@pengutronix.de>
 <20220825094132.1268174-2-s.hauer@pengutronix.de>
 <20220826055306.tdsmdambl6fjoiop@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826055306.tdsmdambl6fjoiop@pengutronix.de>
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

Hi Marco,

On Fri, Aug 26, 2022 at 07:53:07AM +0200, Marco Felsch wrote:
> Hi Sascha,
> 
> nice patche, please see inline.
> 
> On 22-08-25, Sascha Hauer wrote:
> > This driver implements a GPIO multiplexer based on latches connected to
> > other GPIOs. A set of data GPIOs is connected to the data input of
> > multiple latches. The clock input of each latch is driven by another
> > set of GPIOs. With two 8-bit latches 10 GPIOs can be multiplexed into
> > 16 GPIOs. GPOs might be a better term as in fact the multiplexed pins
> > are output only.
> > 

[snip]

> > +
> > +static void __gpio_latch_set(struct gpio_latch_priv *priv, unsigned int offset, int val)
> > +{
> > +	int latch = offset / priv->n_pins;
> > +	int i;
> > +
> > +	if (val)
> > +		priv->shadow[latch] |= BIT(offset % priv->n_pins);
> > +	else
> > +		priv->shadow[latch] &= ~BIT(offset % priv->n_pins);
> > +
> > +	for (i = 0; i < priv->n_pins; i++)
> > +		gpiod_set_value(priv->data_gpios->desc[i], priv->shadow[latch] & BIT(i));
> > +
> > +	gpiod_set_value(priv->clk_gpios->desc[latch], 1);
> > +	gpiod_set_value(priv->clk_gpios->desc[latch], 0);
> 
> Your have two access function for _can_sleep and "can not sleep" but
> here you don't resepect it.

I thought the gpio framework would pick the right implementation
automatically. Apparently it doesn't. Will fix in v2.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
