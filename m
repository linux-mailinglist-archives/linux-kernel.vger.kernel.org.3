Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3FF513B86
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 20:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351034AbiD1S2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 14:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348944AbiD1S2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 14:28:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABF22AE10;
        Thu, 28 Apr 2022 11:25:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB483618F3;
        Thu, 28 Apr 2022 18:25:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E28C385A0;
        Thu, 28 Apr 2022 18:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651170317;
        bh=1Uu2MgxJYfQWEwtjkRQ98VKYPYjTfjUwZcRHMMHvaRk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WGj1mmWB1iV5T6fvuyWqnKGhUXoo0yz1h6lkQSXoPHikA583j8tUOH62UHcqmDxVA
         AZryB6c8EBysgsrIoZDoUi3KyqtW1I0hXQp2etBJrT6DAGD4mJOmhoAkhGb+h7oPeU
         uj55KMY5IZGyukPhrYEkSRzETeHVpJaXYqiCztiWNyaOQv4ZOTUIca1mJrt1ULPVLh
         Itt+JzJweFK1ELITTaHuvAjjA37PnGrxeaNJWvBF1wobSD6sUvZ75OFBNfsEbwFzS0
         0k724SoBJbb0bh+T8noR5Mo+nD8KgLYIaTRisOpc3Ee1NOdtU05JwD7dYEG4hplv5j
         bBY3oKIQc+TKA==
Received: by pali.im (Postfix)
        id AA29C8A0; Thu, 28 Apr 2022 20:25:13 +0200 (CEST)
Date:   Thu, 28 Apr 2022 20:25:13 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: max63xx_wdt: Add support for specifying WDI
 logic via GPIO
Message-ID: <20220428182513.ava4ebkdclmxlf3b@pali>
References: <20220428091603.6838-1-pali@kernel.org>
 <b19ce453-1235-689b-8796-fa6cba35c1f0@roeck-us.net>
 <20220428143210.6cbvik2kmjul3qo5@pali>
 <b7a47a91-abb9-5d0a-5f1d-fc15bf582dea@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b7a47a91-abb9-5d0a-5f1d-fc15bf582dea@roeck-us.net>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 April 2022 08:29:52 Guenter Roeck wrote:
> On 4/28/22 07:32, Pali Rohár wrote:
> > On Thursday 28 April 2022 06:10:56 Guenter Roeck wrote:
> > > On 4/28/22 02:16, Pali Rohár wrote:
> > > > On some boards is WDI logic of max6370 chip connected via GPIO. So extend
> > > > max63xx_wdt driver and DTS schema to allow specifying WDI logic via GPIO.
> > > > 
> > > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > 
> > > How is that different to just using the gpio watchdog driver ?
> > 
> > GPIO watchdog driver does not support max6370 memory mapped
> > configuration.
> > 
> > With this change, max6370 can use memory mapped space for watchdog
> > configuration and GPIO WDI for pinging.
> > 
> 
> Ok, that makes sense. Comments below.
> 
> Thanks,
> Guenter
> 
> > > Guenter
> > > 
> > > > ---
> > > >    .../bindings/watchdog/maxim,max63xx.yaml      |  4 +++
> > > >    drivers/watchdog/max63xx_wdt.c                | 28 +++++++++++++++++++
> > > >    2 files changed, 32 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml b/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
> > > > index ab9641e845db..a97aa0135ef9 100644
> > > > --- a/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
> > > > +++ b/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
> > > > @@ -27,6 +27,10 @@ properties:
> > > >        description: This is a 1-byte memory-mapped address
> > > >        maxItems: 1
> > > > +  gpios:
> > > > +    description: Optional GPIO used for controlling WDI when WDI bit is not mapped to memory
> > > > +    maxItems: 1
> > > > +
> > > >    required:
> > > >      - compatible
> > > >      - reg
> 
> Devicetree patches needs to be separate.

Ok.

> > > > diff --git a/drivers/watchdog/max63xx_wdt.c b/drivers/watchdog/max63xx_wdt.c
> > > > index 9e1541cfae0d..eaf00c3f06a5 100644
> > > > --- a/drivers/watchdog/max63xx_wdt.c
> > > > +++ b/drivers/watchdog/max63xx_wdt.c
> > > > @@ -27,6 +27,7 @@
> > > >    #include <linux/io.h>
> > > >    #include <linux/slab.h>
> > > >    #include <linux/property.h>
> > > > +#include <linux/gpio/consumer.h>
> > > >    #define DEFAULT_HEARTBEAT 60
> > > >    #define MAX_HEARTBEAT     60
> > > > @@ -53,6 +54,9 @@ struct max63xx_wdt {
> > > >    	void __iomem *base;
> > > >    	spinlock_t lock;
> > > > +	/* GPIOs */
> > > > +	struct gpio_desc *gpio_wdi;
> > > > +
> > > >    	/* WDI and WSET bits write access routines */
> > > >    	void (*ping)(struct max63xx_wdt *wdt);
> > > >    	void (*set)(struct max63xx_wdt *wdt, u8 set);
> > > > @@ -158,6 +162,17 @@ static const struct watchdog_info max63xx_wdt_info = {
> > > >    	.identity = "max63xx Watchdog",
> > > >    };
> > > > +static void max63xx_gpio_ping(struct max63xx_wdt *wdt)
> > > > +{
> > > > +	spin_lock(&wdt->lock);
> > > > +
> > > > +	gpiod_set_value_cansleep(wdt->gpio_wdi, 1);
> > > > +	udelay(1);
> > > > +	gpiod_set_value_cansleep(wdt->gpio_wdi, 0);
> > > > +
> > > > +	spin_unlock(&wdt->lock);
> > > > +}
> > > > +
> > > >    static void max63xx_mmap_ping(struct max63xx_wdt *wdt)
> > > >    {
> > > >    	u8 val;
> > > > @@ -225,6 +240,19 @@ static int max63xx_wdt_probe(struct platform_device *pdev)
> > > >    		return -EINVAL;
> > > >    	}
> > > > +	wdt->gpio_wdi = devm_gpiod_get(dev, NULL, GPIOD_FLAGS_BIT_DIR_OUT);
> > > > +	if (IS_ERR(wdt->gpio_wdi) && PTR_ERR(wdt->gpio_wdi) != -ENOENT) {
> > > > +		if (PTR_ERR(wdt->gpio_wdi) != -EPROBE_DEFER)
> > > > +			dev_err(dev, "unable to request gpio: %ld\n",
> > > > +				PTR_ERR(wdt->gpio_wdi));
> 
> Please use dev_err_probe().

Ok.

> > > > +		return PTR_ERR(wdt->gpio_wdi);
> > > > +	}
> > > > +
> > > > +	if (!IS_ERR(wdt->gpio_wdi))
> > > > +		wdt->ping = max63xx_gpio_ping;
> > > > +	else
> > > > +		wdt->gpio_wdi = NULL;
> 
> Why set gpio_wdi to NULL? It isn't used if the ping function is not set.

I thought that it would be more safer to have NULL value stored in
pointer variable as opposite of some non-NULL value used for the error
reporting. But I can remove this part of the code.

> > > > +
> > > >    	err = max63xx_mmap_init(pdev, wdt);
> 
> Doesn't this override the gpio ping function set above ?

Yes, it does. I forgot to amend local change to this patch. wdt->ping
has to be changed to gpio_ping _after_ max63xx_mmap_init call.

I will fix all those issues in v2.

> > > >    	if (err)
> > > >    		return err;
> > > 
> 
