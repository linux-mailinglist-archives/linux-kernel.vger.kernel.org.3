Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A55047EF40
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 14:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352776AbhLXNrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 08:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235783AbhLXNr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 08:47:29 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149A4C061401;
        Fri, 24 Dec 2021 05:47:29 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id x7so19192341lfu.8;
        Fri, 24 Dec 2021 05:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=afCIlcjFXpeKvqs8SychKCeXq2Sds3zEsMBHblNJTN8=;
        b=JzsdVHfZYqcVTB1yGagX/EHlWkPXar/sg3v61Ep6VkhoE50ULNjB8cD+XAqmov15so
         nn4zRg7SxZCw0YD6DqjPZ0wTDDvoua/hvoK8SBmGVyDLAakxPfm1Sb1trqcDtRHzJhTJ
         ArTeSUH2NPBJbtXED7Ie41nQkpuUoWCgq1wER1+MpLfnEhA5XjXzqAlRnfBeRP8G10EQ
         DOByg2GRTxJcx6fuLMaIYnwEnE2+j4iZZA2mVEMzJpMPyAJTT6N0TK5Fg5SAiUdSOhyj
         gFm3Vrjlo3Nn5jXVtjH1X7MV2fiXyKztM5A9HnVer0uraQj81VFT+d9dQJRzXyr1Il1T
         t49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=afCIlcjFXpeKvqs8SychKCeXq2Sds3zEsMBHblNJTN8=;
        b=JOua+5Gs3dgGq0U0ezr5y3heGLWRfK7X1I02TpsX0EzBgvDdNrrGxVRX6wsIiQeS19
         yNVrGecrSWxsL3J2XASyRmFyW2jIcB38aVFvn8WI8kTfLfV9Nz8YFc2IUQe7p/slrH0l
         5vTUKu7RAg1LH6asxI+1hC0xt9yZiOXLa0xHwhYhodPLrxUPTtN1JKXgiGLZ3aZS1HSa
         R7DD6fK//NOy6CXGtjNnx7kQFEvhwFL334ZoRRFaBp72YSqYuMpeufEqWWcZlpMK7rOy
         CF6rx3nues59cZFaVg/1F3Tcf+eOLJFfeTqnIWVLUC0UcpCK9N/qeKw+a53dZNRcpK+z
         Xwsg==
X-Gm-Message-State: AOAM5329us4BtZXt26vRllHmxwFrmbBuFI7HXfJF15yfCmcz0GMltDHW
        /jExWbc1NTvDE+31y0WTsns=
X-Google-Smtp-Source: ABdhPJz9GCrC1UyzH/vLs9fb2lYqZclxDnnUK+QdggBJ5s7bsuQPmVbu4X6vIlq24u2LvduMWRgDUA==
X-Received: by 2002:a05:6512:472:: with SMTP id x18mr5187110lfd.566.1640353647407;
        Fri, 24 Dec 2021 05:47:27 -0800 (PST)
Received: from mobilestation ([95.79.218.126])
        by smtp.gmail.com with ESMTPSA id d3sm811274lfg.116.2021.12.24.05.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 05:47:26 -0800 (PST)
Date:   Fri, 24 Dec 2021 16:47:24 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Hoan Tran <hoan@os.amperecomputing.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1 2/2] gpio: dwapb: Switch to use fwnode instead of
 of_node
Message-ID: <20211224134724.klsfulobcwxojfi3@mobilestation>
References: <20211223103809.12343-1-andriy.shevchenko@linux.intel.com>
 <20211223103809.12343-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211223103809.12343-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2021 at 12:38:09PM +0200, Andy Shevchenko wrote:
> GPIO library now accepts fwnode as a firmware node, so
> switch the driver to use it and hence rectify the ACPI
> case which uses software nodes.
> 
> Note, in this case it's rather logical fix that doesn't
> affect functionality, thus no backporting required.

Thanks for the patch.
Acked-by: Serge Semin <fancer.lancer@gmail.com>

-Sergey

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpio-dwapb.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
> index ec0767d7800d..b0f3aca61974 100644
> --- a/drivers/gpio/gpio-dwapb.c
> +++ b/drivers/gpio/gpio-dwapb.c
> @@ -15,7 +15,6 @@
>  #include <linux/irq.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> -#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/property.h>
>  #include <linux/reset.h>
> @@ -515,9 +514,7 @@ static int dwapb_gpio_add_port(struct dwapb_gpio *gpio,
>  		return err;
>  	}
>  
> -#ifdef CONFIG_OF_GPIO
> -	port->gc.of_node = to_of_node(pp->fwnode);
> -#endif
> +	port->gc.fwnode = pp->fwnode;
>  	port->gc.ngpio = pp->ngpio;
>  	port->gc.base = pp->gpio_base;
>  
> -- 
> 2.34.1
> 
