Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5EF49638C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 18:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349649AbiAURGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 12:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbiAURGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 12:06:33 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78440C06173B;
        Fri, 21 Jan 2022 09:06:32 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A92FA20005;
        Fri, 21 Jan 2022 17:06:29 +0000 (UTC)
Date:   Fri, 21 Jan 2022 18:06:29 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: pcf2127: add error message if writing to CLKOUT
 register fails
Message-ID: <YeroFQVgqrvlczrR@piout.net>
References: <20220119172740.1856302-1-hugo@hugovil.com>
 <YehMZC4vduvSH5HA@piout.net>
 <20220119130845.6de245b8b217e659cd319328@hugovil.com>
 <YehiHJXP23TSREbE@piout.net>
 <20220120183548.e6a8f46ede2a636a8eaf11c1@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120183548.e6a8f46ede2a636a8eaf11c1@hugovil.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/2022 18:35:48-0500, Hugo Villeneuve wrote:
> On Wed, 19 Jan 2022 20:10:20 +0100
> Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:
> 
> > On 19/01/2022 13:08:45-0500, Hugo Villeneuve wrote:
> > > On Wed, 19 Jan 2022 18:37:40 +0100
> > > Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:
> > > 
> > > > On 19/01/2022 12:27:39-0500, Hugo Villeneuve wrote:
> > > > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > > > 
> > > > > If writing to CLKOUT register fails, the probe operation will be aborted
> > > > > without a meaningful error message.
> > > > > 
> > > > 
> > > > The current trend is to remove debug messages, please do not add more :)
> > > 
> > > Hi,
> > > If the read operation fails, the probe function will exit silently, and our RTC chip will not work. In that case, if we parse the dmesg logs, I think we  should have an indication that something went wrong.
> > > 
> > 
> > This is not true, it doesn't fail silently, you'd get:
> > rtc-pcf2127: probe of 1-0051 failed with error -121
> 
> Well this is certainly true for me because I am not seing the same error message as you :)
> 
> Just for context, I have defined a dummy pcf2127 on I2C bus 0 in my device tree (no actual hardware is present). I also added some debug messages to investigate (rtc-pcf2127.c and dd.c files), and here is the dmesg log after issuing "modprobe rtc-pcf2127":
> 
> [Thu Jan 20 23:22:20 2022] rtc-pcf2127-i2c 0-0051: pcf2127_i2c_probe
> [Thu Jan 20 23:22:20 2022] rtc-pcf2127-i2c 0-0051: pcf2127_probe
> [Thu Jan 20 23:22:20 2022] rtc-pcf2127-i2c 0-0051: PORO disabling failed with error -6
> [Thu Jan 20 23:22:20 2022] rtc-pcf2127-i2c 0-0051: call_driver_probe probe error: -6
> 
> Error code -6 is -ENXIO, and looking at the call_driver_probe() function in dd.c, I now understand why I didn't see the error message (line 531):
> 
> 	case -ENXIO:
> 		pr_debug("%s: probe of %s rejects match %d\n",
> 			 drv->name, dev_name(dev), ret);
> 
> So it seems that the return code is different than what you got?
> 

Probably because we don't have the same i2c controller and the driver
for mine is returning -EREMOTEIO when the device is not present.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
