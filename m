Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433CF5A4E4C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiH2NhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiH2NhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:37:19 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEAC5C9E0;
        Mon, 29 Aug 2022 06:37:18 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 69so6068098pgb.13;
        Mon, 29 Aug 2022 06:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=X3n9fRJaISOoKGJibDsyztvDNBHKFphlKvEWrr6bIeU=;
        b=JmveZP+OCtghdybFvzZuRj03k/Ivj7Z4v78rEHsMaUQflE8XEa1FSSIPA4qxIysrsX
         hRwLqoHh7RwiZWfeasksEzY1AZt4HO0w2Wh0vzOeAQvxVcjvePKk3/5NLe1P0jMzZPr0
         C3w92DFNaqCYqp+A0tkGrgn/E6Ghwg79oBXmlhs0AukPkw7AOJf6KjMgI6Yf1MtZ3umw
         kLgxEtSaK19JgXmRBT3LceBY3eeZA2rAyDaaLD/dF/Ztf83av5LsXcRwYeehHL+p35ZM
         04IGdAVcT83avsiNnjG2yVExJOwkJoBEunJCeXcWP50c9tjx4xWNpAyf/CVPEpAgE4KW
         owOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=X3n9fRJaISOoKGJibDsyztvDNBHKFphlKvEWrr6bIeU=;
        b=oWZWYylHJV1yxVhKchfyCqrLeXaEea1Tomkb1mbFO62LCF3EfU/AVc6Uqx+5MTOx6d
         0offumDnEKRGjQLlDuuvlFT9g5XGncauhEGevda8PZSTmhm87jl40e5QFj8TAlnoBZ8j
         lfw5+5lirbD0LUKtq0Op+f7smuVhl90A/vrI+UUYl4W74QEuaSel27RkL1BnvGkjIg4J
         Z5FOUL9zJRfWaOLr5Yi3XYe0URkOkK1YU6ozoZsPsM2rOKGbxDH2L6WVl36eV+K9I7sy
         P7OYvBt/X5KhH1dCGiEabKb2Rs0yeD7SJEqKZPyjy+YB/nsGHZ8xvaKO5guGErCAoOLW
         ddGg==
X-Gm-Message-State: ACgBeo3jLrCUo0KghCz7Lio0AR+LDGSdo2J/CwiWVDDEb54LNF+v9DFM
        uiVzdUnnSeCii7PJ5EKuPhK6lFTH03zvMw==
X-Google-Smtp-Source: AA6agR6npqtvrRablWh07/Vw19Q4Z94J2iztkOOWgCiPSa/C7qzH1PxhccJrg3G8KKctib1y/VU5Vw==
X-Received: by 2002:a63:fa49:0:b0:429:fd87:3171 with SMTP id g9-20020a63fa49000000b00429fd873171mr13353291pgk.504.1661780238253;
        Mon, 29 Aug 2022 06:37:18 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e2-20020a17090a630200b001fdcfe9a731sm1962628pjj.50.2022.08.29.06.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 06:37:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 29 Aug 2022 06:37:16 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH v2 1/1] hwmon: (iio_hwmon) Make use of device properties
Message-ID: <20220829133716.GA3968626@roeck-us.net>
References: <20220826173700.17395-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826173700.17395-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 08:37:00PM +0300, Andy Shevchenko wrote:
> Convert the module to be property provider agnostic and allow
> it to be used on non-OF platforms.
> 
> Include mod_devicetable.h explicitly to replace the dropped of.h
> which included mod_devicetable.h indirectly.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
> v2: amended commit message (Guenter)
>  drivers/hwmon/iio_hwmon.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
> index 580a7d125b88..3aa40893fc09 100644
> --- a/drivers/hwmon/iio_hwmon.c
> +++ b/drivers/hwmon/iio_hwmon.c
> @@ -6,11 +6,13 @@
>  
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/err.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
> +
>  #include <linux/hwmon.h>
> -#include <linux/of.h>
>  #include <linux/hwmon-sysfs.h>
>  #include <linux/iio/consumer.h>
>  #include <linux/iio/types.h>
> @@ -149,8 +151,8 @@ static int iio_hwmon_probe(struct platform_device *pdev)
>  	st->attr_group.attrs = st->attrs;
>  	st->groups[0] = &st->attr_group;
>  
> -	if (dev->of_node) {
> -		sname = devm_kasprintf(dev, GFP_KERNEL, "%pOFn", dev->of_node);
> +	if (dev_fwnode(dev)) {
> +		sname = devm_kasprintf(dev, GFP_KERNEL, "%pfwP", dev_fwnode(dev));
>  		if (!sname)
>  			return -ENOMEM;
>  		strreplace(sname, '-', '_');
