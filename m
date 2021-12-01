Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1195464A61
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 10:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242150AbhLAJPb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 1 Dec 2021 04:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237277AbhLAJP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 04:15:28 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D829C061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 01:12:08 -0800 (PST)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1msLeW-0003Y6-1e; Wed, 01 Dec 2021 10:11:48 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1msLeQ-0003CH-IM; Wed, 01 Dec 2021 10:11:42 +0100
Message-ID: <3b80b2a52362cbadb26052685566e2c1f75a0b68.camel@pengutronix.de>
Subject: Re: [v13 2/2] pwm: Add Aspeed ast2600 PWM support
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Billy Tsai <billy_tsai@aspeedtech.com>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Cc:     BMC-SW <BMC-SW@aspeedtech.com>
Date:   Wed, 01 Dec 2021 10:11:42 +0100
In-Reply-To: <CDB0374F-3835-4501-964E-DB771588114D@aspeedtech.com>
References: <20211129064329.27006-1-billy_tsai@aspeedtech.com>
         <20211129064329.27006-3-billy_tsai@aspeedtech.com>
         <e28a5d5de9b940717e6444f019eab63ab1bb0b75.camel@pengutronix.de>
         <CDB0374F-3835-4501-964E-DB771588114D@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Billy,

On Wed, 2021-12-01 at 03:30 +0000, Billy Tsai wrote:
> Hi Philipp,
> 
> On 2021/11/30, 5:52 PM, "Philipp Zabel" <p.zabel@pengutronix.de> wrote:
> 
>     On Mon, 2021-11-29 at 14:43 +0800, Billy Tsai wrote:
>     [...]
>     >   > +	ret = clk_prepare_enable(priv->clk);
>     >   > +	if (ret)
>     >   > +		return dev_err_probe(dev, ret, "Couldn't enable clock\n");
>     >   > +
>     >   > +	ret = reset_control_deassert(priv->reset);
>     >   > +	if (ret) {
>     >   > +		dev_err_probe(dev, ret, "Couldn't deassert reset control\n");
>     >   > +		goto err_disable_clk;
>     >   > +	}
> 
>     >   Is there any reason to keep the clocks running and the controller out of
>     >   reset while the PWM outputs are disabled?
> 
> Can you tell me about your concerns with this process?

No particular concerns, just curiosity.

> In my opinion, they are used to provide the clock and de-assert the reset of the PWM engine. If we didn't release
> them in probe stage the CPU can't and shouldn't read the register of the PWM engine when call the get_state.
> Assume that we want to adjust them dynamically, the driver needs to add more conditions to check and keep the status
> of each PWM channel, which is not a good deal for the server platform.

Thanks. I don't know the hardware, so I have no idea whether disabling
the clocks would even save a measurable (let alone appreciable) amount
of power.

I've just seen other PWM drivers use runtime PM or enable/disable clocks
dynamically, and wondered why this one doesn't.

regards
Philipp
