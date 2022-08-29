Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0CD5A533E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 19:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbiH2Rey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 13:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbiH2Rev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 13:34:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868CA9C;
        Mon, 29 Aug 2022 10:34:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3EC04B8119D;
        Mon, 29 Aug 2022 17:34:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B5A4C433D7;
        Mon, 29 Aug 2022 17:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661794481;
        bh=gnf4Jlo1A0o7rUsp7O03aHFQN2TyPZez03WfQkmxHSs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ST3Da3EZaNBmtKV8anrXbMqMPWZjEhZf1rZXsTPeI6Ol6HCzQafhNJxg3yFfbBLWl
         YWgpHzfWe7VrIkLPKrTXWmKHu8lxZJhx1GklCLlF2NOw1hY9XxOrP+qtd0hXugy4+C
         uUqIl65z8IF6D630q/xhrxw4OMl4QI69HU7+opSDUXkefoWYqKefeAVFEiia6vuF2R
         Y10aLyPS/ehmBFeatikwW4qCSJdatrWnLEhZ+XB6b8YMxWQCRiS8+Fip+3PqACYy/7
         3PWSt3YlFnlaxDspvzGwFw6SmF8Fx5bRLDhvWyBp6d0yM4RrfbyguzE4+fm5ol/yaU
         AOMIIG3wbLUvA==
Date:   Mon, 29 Aug 2022 18:00:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jakob Hauser <jahau@rocketmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/4] iio: magnetometer: yamaha-yas530: Use pointers
 as driver data
Message-ID: <20220829180022.18dac46a@jic23-huawei>
In-Reply-To: <20220829112407.74917-1-andriy.shevchenko@linux.intel.com>
References: <20220829112407.74917-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Aug 2022 14:24:04 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Unify ID tables to use pointers for driver data. It will allow
> to simplify the driver later on.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/iio/magnetometer/yamaha-yas530.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
> index 026f71e524f3..03e0525e6364 100644
> --- a/drivers/iio/magnetometer/yamaha-yas530.c
> +++ b/drivers/iio/magnetometer/yamaha-yas530.c
> @@ -32,6 +32,7 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/mutex.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/random.h>
> @@ -1437,8 +1438,8 @@ static int yas5xx_probe(struct i2c_client *i2c,
>  		goto assert_reset;
>  	}
>  
> -	yas5xx->chip_info = &yas5xx_chip_info_tbl[id->driver_data];
> -	ci = yas5xx->chip_info;
> +	ci = device_get_match_data(dev);
> +	yas5xx->chip_info = ci;

Am I missing a path by which device_get_match_data() can use the i2c_device_id values?
I'd expect to see a fallback to that if ci == NULL to cover the non firmware causes
of probe().  I've seen a few patches without that fallback path recently so wondering
if some magic has gotten hooked up and I've missed it (something to push that via
a swnode perhaps?)


>  
>  	ret = regmap_read(yas5xx->map, YAS5XX_DEVICE_ID, &id_check);
>  	if (ret)
> @@ -1583,19 +1584,19 @@ static DEFINE_RUNTIME_DEV_PM_OPS(yas5xx_dev_pm_ops, yas5xx_runtime_suspend,
>  				 yas5xx_runtime_resume, NULL);
>  
>  static const struct i2c_device_id yas5xx_id[] = {
> -	{"yas530", yas530 },
> -	{"yas532", yas532 },
> -	{"yas533", yas533 },
> -	{"yas537", yas537 },
> +	{"yas530", (kernel_ulong_t)&yas5xx_chip_info_tbl[yas530] },
> +	{"yas532", (kernel_ulong_t)&yas5xx_chip_info_tbl[yas532] },
> +	{"yas533", (kernel_ulong_t)&yas5xx_chip_info_tbl[yas533] },
> +	{"yas537", (kernel_ulong_t)&yas5xx_chip_info_tbl[yas537] },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(i2c, yas5xx_id);
>  
>  static const struct of_device_id yas5xx_of_match[] = {
> -	{ .compatible = "yamaha,yas530", },
> -	{ .compatible = "yamaha,yas532", },
> -	{ .compatible = "yamaha,yas533", },
> -	{ .compatible = "yamaha,yas537", },
> +	{ .compatible = "yamaha,yas530", &yas5xx_chip_info_tbl[yas530] },
> +	{ .compatible = "yamaha,yas532", &yas5xx_chip_info_tbl[yas532] },
> +	{ .compatible = "yamaha,yas533", &yas5xx_chip_info_tbl[yas533] },
> +	{ .compatible = "yamaha,yas537", &yas5xx_chip_info_tbl[yas537] },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, yas5xx_of_match);

