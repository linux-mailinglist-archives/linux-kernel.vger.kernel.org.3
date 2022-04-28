Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2995136F3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 16:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348437AbiD1Ofc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 10:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348250AbiD1Ofb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 10:35:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4950FAAE0C;
        Thu, 28 Apr 2022 07:32:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CAADCB82DA9;
        Thu, 28 Apr 2022 14:32:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD6AC385A0;
        Thu, 28 Apr 2022 14:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651156333;
        bh=UWru8GZaZ3MvEmpIc/sqRP2thhFeKXYUEpRuYeCOnKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fMYKYIde7l8Qib9ryMtpNnHzGhmLdDZAmQAWeAB65QaYxS7MyzIS/KiZ9+0+2BgZT
         DRJA6c2p3bXj5Mg4GiAE/SRcV4r2Yb3043XYaoB+3A1Qds4p7sKdV1ke7fUkl+tYXZ
         zJVhTv7rtGi1I42ufJc4kBRU5RLJi0JW/D4HdwNFQZ1hUuGC7EJzOYpHc/h/qGYpDI
         Vplp69SeJjxEL8bMj5YIpKiQ7Dm/PmqKRYNXw5/ULUwDP41+CdalqxB6h0kUML/OJm
         Smpx8vCwUJ7pjJC7MXFssTDpD7hk7jp4Q0y4bGKcEbRVuZQuJczBJAqsMS1gkNLDWs
         dd5cHZUCwI+QQ==
Received: by pali.im (Postfix)
        id 4FCB28A0; Thu, 28 Apr 2022 16:32:10 +0200 (CEST)
Date:   Thu, 28 Apr 2022 16:32:10 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: max63xx_wdt: Add support for specifying WDI
 logic via GPIO
Message-ID: <20220428143210.6cbvik2kmjul3qo5@pali>
References: <20220428091603.6838-1-pali@kernel.org>
 <b19ce453-1235-689b-8796-fa6cba35c1f0@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b19ce453-1235-689b-8796-fa6cba35c1f0@roeck-us.net>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 April 2022 06:10:56 Guenter Roeck wrote:
> On 4/28/22 02:16, Pali Rohár wrote:
> > On some boards is WDI logic of max6370 chip connected via GPIO. So extend
> > max63xx_wdt driver and DTS schema to allow specifying WDI logic via GPIO.
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> 
> How is that different to just using the gpio watchdog driver ?

GPIO watchdog driver does not support max6370 memory mapped
configuration.

With this change, max6370 can use memory mapped space for watchdog
configuration and GPIO WDI for pinging.

> Guenter
> 
> > ---
> >   .../bindings/watchdog/maxim,max63xx.yaml      |  4 +++
> >   drivers/watchdog/max63xx_wdt.c                | 28 +++++++++++++++++++
> >   2 files changed, 32 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml b/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
> > index ab9641e845db..a97aa0135ef9 100644
> > --- a/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
> > +++ b/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
> > @@ -27,6 +27,10 @@ properties:
> >       description: This is a 1-byte memory-mapped address
> >       maxItems: 1
> > +  gpios:
> > +    description: Optional GPIO used for controlling WDI when WDI bit is not mapped to memory
> > +    maxItems: 1
> > +
> >   required:
> >     - compatible
> >     - reg
> > diff --git a/drivers/watchdog/max63xx_wdt.c b/drivers/watchdog/max63xx_wdt.c
> > index 9e1541cfae0d..eaf00c3f06a5 100644
> > --- a/drivers/watchdog/max63xx_wdt.c
> > +++ b/drivers/watchdog/max63xx_wdt.c
> > @@ -27,6 +27,7 @@
> >   #include <linux/io.h>
> >   #include <linux/slab.h>
> >   #include <linux/property.h>
> > +#include <linux/gpio/consumer.h>
> >   #define DEFAULT_HEARTBEAT 60
> >   #define MAX_HEARTBEAT     60
> > @@ -53,6 +54,9 @@ struct max63xx_wdt {
> >   	void __iomem *base;
> >   	spinlock_t lock;
> > +	/* GPIOs */
> > +	struct gpio_desc *gpio_wdi;
> > +
> >   	/* WDI and WSET bits write access routines */
> >   	void (*ping)(struct max63xx_wdt *wdt);
> >   	void (*set)(struct max63xx_wdt *wdt, u8 set);
> > @@ -158,6 +162,17 @@ static const struct watchdog_info max63xx_wdt_info = {
> >   	.identity = "max63xx Watchdog",
> >   };
> > +static void max63xx_gpio_ping(struct max63xx_wdt *wdt)
> > +{
> > +	spin_lock(&wdt->lock);
> > +
> > +	gpiod_set_value_cansleep(wdt->gpio_wdi, 1);
> > +	udelay(1);
> > +	gpiod_set_value_cansleep(wdt->gpio_wdi, 0);
> > +
> > +	spin_unlock(&wdt->lock);
> > +}
> > +
> >   static void max63xx_mmap_ping(struct max63xx_wdt *wdt)
> >   {
> >   	u8 val;
> > @@ -225,6 +240,19 @@ static int max63xx_wdt_probe(struct platform_device *pdev)
> >   		return -EINVAL;
> >   	}
> > +	wdt->gpio_wdi = devm_gpiod_get(dev, NULL, GPIOD_FLAGS_BIT_DIR_OUT);
> > +	if (IS_ERR(wdt->gpio_wdi) && PTR_ERR(wdt->gpio_wdi) != -ENOENT) {
> > +		if (PTR_ERR(wdt->gpio_wdi) != -EPROBE_DEFER)
> > +			dev_err(dev, "unable to request gpio: %ld\n",
> > +				PTR_ERR(wdt->gpio_wdi));
> > +		return PTR_ERR(wdt->gpio_wdi);
> > +	}
> > +
> > +	if (!IS_ERR(wdt->gpio_wdi))
> > +		wdt->ping = max63xx_gpio_ping;
> > +	else
> > +		wdt->gpio_wdi = NULL;
> > +
> >   	err = max63xx_mmap_init(pdev, wdt);
> >   	if (err)
> >   		return err;
> 
