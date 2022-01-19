Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06410494067
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 20:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiASTKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 14:10:23 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:47513 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiASTKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 14:10:22 -0500
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 95BDE40004;
        Wed, 19 Jan 2022 19:10:20 +0000 (UTC)
Date:   Wed, 19 Jan 2022 20:10:20 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: pcf2127: add error message if writing to CLKOUT
 register fails
Message-ID: <YehiHJXP23TSREbE@piout.net>
References: <20220119172740.1856302-1-hugo@hugovil.com>
 <YehMZC4vduvSH5HA@piout.net>
 <20220119130845.6de245b8b217e659cd319328@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119130845.6de245b8b217e659cd319328@hugovil.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/2022 13:08:45-0500, Hugo Villeneuve wrote:
> On Wed, 19 Jan 2022 18:37:40 +0100
> Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:
> 
> > On 19/01/2022 12:27:39-0500, Hugo Villeneuve wrote:
> > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > 
> > > If writing to CLKOUT register fails, the probe operation will be aborted
> > > without a meaningful error message.
> > > 
> > 
> > The current trend is to remove debug messages, please do not add more :)
> 
> Hi,
> If the read operation fails, the probe function will exit silently, and our RTC chip will not work. In that case, if we parse the dmesg logs, I think we  should have an indication that something went wrong.
> 

This is not true, it doesn't fail silently, you'd get:
rtc-pcf2127: probe of 1-0051 failed with error -121

> I had a case where my dev board was not properly plugged-in, and before this patch, I didn't notice it because of the silent abort of the probe function.
> 

Again, not silent.

> > 
> > > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > ---
> > >  drivers/rtc/rtc-pcf2127.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
> > > index 3d1f57e54372..823abe2a7147 100644
> > > --- a/drivers/rtc/rtc-pcf2127.c
> > > +++ b/drivers/rtc/rtc-pcf2127.c
> > > @@ -717,8 +717,10 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
> > >  	if (!(val & PCF2127_BIT_CLKOUT_OTPR)) {
> > >  		ret = regmap_set_bits(pcf2127->regmap, PCF2127_REG_CLKOUT,
> > >  				      PCF2127_BIT_CLKOUT_OTPR);
> > > -		if (ret < 0)
> > > +		if (ret < 0) {
> > > +			dev_err(dev, "writing to CLKOUT register failed\n");
> > >  			return ret;
> > > +		}
> > >  
> > >  		msleep(100);
> > >  	}
> > > -- 
> > > 2.30.2
> > > 
> > 
> > -- 
> > Alexandre Belloni, co-owner and COO, Bootlin
> > Embedded Linux and Kernel engineering
> > https://bootlin.com
> > 
> 
> 
> -- 
> Hugo Villeneuve <hugo@hugovil.com>

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
