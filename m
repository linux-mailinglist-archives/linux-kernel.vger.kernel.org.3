Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F012251E7C9
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 16:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383666AbiEGO2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 10:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234096AbiEGO22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 10:28:28 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4522343EE7;
        Sat,  7 May 2022 07:24:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 84E8CCE0176;
        Sat,  7 May 2022 14:24:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 362E8C385A5;
        Sat,  7 May 2022 14:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651933478;
        bh=sSXLpYu1t8UtQ4m0tCJJKWk/8Qphs0XLvUjn7yKWF80=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J8ufkF6+pzihvNA5oZVEqSIsHo9HyWdlylM6eC23ALm28O9NWza/OdWtwDaRHIk5+
         AW8aCvkizjtrRe4jBfDjexDkjRNRsgK+oya40rrygnPvqpM7TU4Z6gAihS2ebLZraN
         fDGHnNpZBv2CI9GSR3VUmih/hekiuZNEh7qekfkcOUWABRdM0+AHErR0UTBaakVv8u
         8VkPR9cKmHXvYkN2zpLiGDCTVWk2kvI2utODl4WUx9lbqJWc12xy0E1cmCVRlj4Ken
         Z28BlrUt6Fz1kpnG3xIBaiZyAPonml58FPTyHKXRH3Kux+PZCWPLC6apvSqZYcDv7S
         DbMRXdjVZpomA==
Date:   Sat, 7 May 2022 15:33:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Klinger <ak@it-klinger.de>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: proximity: srf04: Make use of device
 properties
Message-ID: <20220507153306.51d5409f@jic23-huawei>
In-Reply-To: <20220504113557.59048-1-andriy.shevchenko@linux.intel.com>
References: <20220504113557.59048-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  4 May 2022 14:35:57 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Convert the module to be property provider agnostic and allow
> it to be used on non-OF platforms.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/proximity/srf04.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/proximity/srf04.c b/drivers/iio/proximity/srf04.c
> index 4e6286765f01..05015351a34a 100644
> --- a/drivers/iio/proximity/srf04.c
> +++ b/drivers/iio/proximity/srf04.c
> @@ -37,9 +37,8 @@
>  #include <linux/err.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> -#include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/property.h>
>  #include <linux/sched.h>
> @@ -261,7 +260,7 @@ static int srf04_probe(struct platform_device *pdev)
>  
>  	data = iio_priv(indio_dev);
>  	data->dev = dev;
> -	data->cfg = of_match_device(of_srf04_match, dev)->data;
> +	data->cfg = device_get_match_data(dev);
>  
>  	mutex_init(&data->lock);
>  	init_completion(&data->rising);
> @@ -289,10 +288,8 @@ static int srf04_probe(struct platform_device *pdev)
>  		return PTR_ERR(data->gpiod_power);
>  	}
>  	if (data->gpiod_power) {
> -
> -		if (of_property_read_u32(dev->of_node, "startup-time-ms",
> -						&data->startup_time_ms))
> -			data->startup_time_ms = 100;
> +		data->startup_time_ms = 100;
> +		device_property_read_u32(dev, "startup-time-ms", &data->startup_time_ms);
>  		dev_dbg(dev, "using power gpio: startup-time-ms=%d\n",
>  							data->startup_time_ms);
>  	}

