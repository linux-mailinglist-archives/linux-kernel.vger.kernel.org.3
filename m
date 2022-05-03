Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD771517C4F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 06:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiECEBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 00:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiECEBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 00:01:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFE636B77;
        Mon,  2 May 2022 20:58:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 253EBB81BE4;
        Tue,  3 May 2022 03:57:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589D6C385A9;
        Tue,  3 May 2022 03:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651550277;
        bh=Cl5mLzkG+TTdpfzZTrXfX/qXJHGfkfoAd8qQBoaXi2o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YcJ69Mxs/0egoH/KoOxPB3yexeKFIvfqicqjGmBmRqA1j0B0WFCNgHAopqYY+yRQy
         mzbbT/hsRO8kK+0jXsHqc+Golxqn2efytgtN6PsVYY3FodNNrGRhMd3CxxkuPqTqJL
         m0KcR1SWkduqZlmLQ8yT5r2X93ZuAvjHcdT7XUs6lKdOGMx38ZRrn7K/JLTY4xH/Id
         asLXU4pqHu6fV5WS2uf/SipLHO6i8LWMomfFKzTGRWpvazPmiZzCsFcOIuWEt1Vop9
         DtVgViFpNQ9E9kMYMaHPdzmlvehvI1YqBf4fOAIuXM3aasfbiz0coNItX3TcB+BWWK
         Cfs51zkdijRGw==
Date:   Tue, 3 May 2022 11:57:53 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] watchdog: max63xx_wdt: Add support for specifying
 WDI logic via GPIO
Message-ID: <YnCoQUGQsXIfbowQ@google.com>
References: <20220429131349.21229-1-pali@kernel.org>
 <20220429131349.21229-2-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220429131349.21229-2-pali@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 03:13:49PM +0200, Pali Rohár wrote:
> @@ -27,6 +27,7 @@
>  #include <linux/io.h>
>  #include <linux/slab.h>
>  #include <linux/property.h>
> +#include <linux/gpio/consumer.h>

It would be better to keep them alphabetically.  Anyway, they aren't sorted
originally...

> +static void max63xx_gpio_ping(struct max63xx_wdt *wdt)
> +{
> +	spin_lock(&wdt->lock);

Does it really need to acquire the lock?  It looks like the lock is to prevent
concurrent accesses to the mmap in max63xx_mmap_ping() and max63xx_mmap_set().

> +	gpiod_set_value_cansleep(wdt->gpio_wdi, 1);
> +	udelay(1);

Doesn't it need to include <linux/delay.h> for udelay()?

> @@ -225,10 +240,19 @@ static int max63xx_wdt_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> +	wdt->gpio_wdi = devm_gpiod_get(dev, NULL, GPIOD_FLAGS_BIT_DIR_OUT);
> +	if (IS_ERR(wdt->gpio_wdi) && PTR_ERR(wdt->gpio_wdi) != -ENOENT)

Use devm_gpiod_get_optional() to make the intent clear.  Also, it gets rid of
the check for -ENOENT.

> +		return dev_err_probe(dev, PTR_ERR(wdt->gpio_wdi),
> +				     "unable to request gpio: %ld\n",
> +				     PTR_ERR(wdt->gpio_wdi));

It doesn't need to again print for PTR_ERR(wdt->gpio_wdi).  dev_err_probe()
prints the error.

>  	err = max63xx_mmap_init(pdev, wdt);
>  	if (err)
>  		return err;
>  
> +	if (!IS_ERR(wdt->gpio_wdi))
> +		wdt->ping = max63xx_gpio_ping;

Thus, the max63xx_gpio_ping() overrides max63xx_mmap_ping() if the GPIO was
provided?  It would be better to mention the behavior in the commit message.

Also, could both the assignments of `wdt->gpio_wdi` and `wdt->ping` happen
after max63xx_mmap_init()?
