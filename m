Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD9B56600A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 02:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbiGEAM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 20:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiGEAM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 20:12:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D90B4A6;
        Mon,  4 Jul 2022 17:12:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B408DB815D5;
        Tue,  5 Jul 2022 00:12:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2160FC341C7;
        Tue,  5 Jul 2022 00:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656979973;
        bh=yqliNiCUKo7uqi6LYKqvM7rpzqhyuqPZ1aVCxRrSk9Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aqXPqrKWCYCvsMnkZ25um7Kp9aK1Bf3OxFBtJRICuOQP/C42gjbUpVpmlYrUTlWmz
         BG1bxuyd5l5X8NDUt8h79XLkNDSNXRuK2RL4BRLdmY0H6T+qeUTmRK3+7B/4Ndb1S3
         ZY+AfFUxjCzaddhniW9XYz64v8OiUj84uugvAsvgjxe3tDOpIDAmZPslupemaigH6v
         iEeChM8nMEER9hQXqVeUVyIes6VQR8sl9Nl7A+wA1nJbCpggV9GJCoj37VBNHYyPTM
         bzalkQQCMdVJnLy7Pn5J/mKTX0J+1Fw7AU6baZWKHMOvJTyxFaETuG6QzATELGfBiq
         /rXQGsux25tPg==
Received: by pali.im (Postfix)
        id 62D7279F; Tue,  5 Jul 2022 02:12:49 +0200 (CEST)
Date:   Tue, 5 Jul 2022 02:12:49 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Tzung-Bi Shih <tzungbi@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] watchdog: max63xx_wdt: Add support for specifying
 WDI logic via GPIO
Message-ID: <20220705001249.3art3nadx7iyfg67@pali>
References: <20220429131349.21229-1-pali@kernel.org>
 <20220429131349.21229-2-pali@kernel.org>
 <YnCoQUGQsXIfbowQ@google.com>
 <6f69677c-18d9-abd9-93d7-cf1f29603ed6@roeck-us.net>
 <20220503220550.3jczn2hzc5me34qj@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220503220550.3jczn2hzc5me34qj@pali>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 May 2022 00:05:50 Pali Rohár wrote:
> On Monday 02 May 2022 21:37:16 Guenter Roeck wrote:
> > On 5/2/22 20:57, Tzung-Bi Shih wrote:
> > > On Fri, Apr 29, 2022 at 03:13:49PM +0200, Pali Rohár wrote:
> > > > @@ -27,6 +27,7 @@
> > > >   #include <linux/io.h>
> > > >   #include <linux/slab.h>
> > > >   #include <linux/property.h>
> > > > +#include <linux/gpio/consumer.h>
> > > 
> > > It would be better to keep them alphabetically.  Anyway, they aren't sorted
> > > originally...
> > > 
> > > > +static void max63xx_gpio_ping(struct max63xx_wdt *wdt)
> > > > +{
> > > > +	spin_lock(&wdt->lock);
> > > 
> > > Does it really need to acquire the lock?  It looks like the lock is to prevent
> > > concurrent accesses to the mmap in max63xx_mmap_ping() and max63xx_mmap_set().
> > > 
> > 
> > Actually, that doesn't work at all. spin_lock() directly contradicts
> > with gpiod_set_value_cansleep().
> > 
> > > > +	gpiod_set_value_cansleep(wdt->gpio_wdi, 1);
> > > > +	udelay(1);
> > > 
> > > Doesn't it need to include <linux/delay.h> for udelay()?
> > > 
> > > > @@ -225,10 +240,19 @@ static int max63xx_wdt_probe(struct platform_device *pdev)
> > > >   		return -EINVAL;
> > > >   	}
> > > > +	wdt->gpio_wdi = devm_gpiod_get(dev, NULL, GPIOD_FLAGS_BIT_DIR_OUT);
> > > > +	if (IS_ERR(wdt->gpio_wdi) && PTR_ERR(wdt->gpio_wdi) != -ENOENT)
> > > 
> > > Use devm_gpiod_get_optional() to make the intent clear.  Also, it gets rid of
> > > the check for -ENOENT.
> > > 
> > > > +		return dev_err_probe(dev, PTR_ERR(wdt->gpio_wdi),
> > > > +				     "unable to request gpio: %ld\n",
> > > > +				     PTR_ERR(wdt->gpio_wdi));
> > > 
> > > It doesn't need to again print for PTR_ERR(wdt->gpio_wdi).  dev_err_probe()
> > > prints the error.
> > > 
> > > >   	err = max63xx_mmap_init(pdev, wdt);
> > > >   	if (err)
> > > >   		return err;
> > > > +	if (!IS_ERR(wdt->gpio_wdi))
> > > > +		wdt->ping = max63xx_gpio_ping;
> > > 
> > > Thus, the max63xx_gpio_ping() overrides max63xx_mmap_ping() if the GPIO was
> > > provided?  It would be better to mention the behavior in the commit message.
> > > 
> > > Also, could both the assignments of `wdt->gpio_wdi` and `wdt->ping` happen
> > > after max63xx_mmap_init()?
> > 
> 
> Hello! I'm going to look at all these issues. Recently I sent max63
> watchdog driver also into U-Boot and seems that I mixed DTS and driver
> code between U-Boot and Kernel... and tested something mixed.
> 
> I will do new testing again, and will check that I'm testing correct
> code.

Hello! Now I sent a new version V3. I have tested it on PowerPC P2020
based board where watchdog registers are exported via CPLD and new V3
version is working fine.
