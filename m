Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B80A5AC540
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 18:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbiIDQFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 12:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233704AbiIDQFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 12:05:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4484C23BC8;
        Sun,  4 Sep 2022 09:05:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF372B80D8B;
        Sun,  4 Sep 2022 16:04:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB93C433C1;
        Sun,  4 Sep 2022 16:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662307498;
        bh=eWedaFx7f3zdDiTGwJz6gVLQxBalM9NLV1LNJ3xn+Ok=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sj3XQhFaOAiK0Cvtjsa4X/e07mrE5iyvqGsSTv8JljSXbbiDCyqcNs8kIpQrIxPqU
         JtpgA0EhfbvbGk3SHeAJk8df3jdaytlmXLu+5R23r7sRu/w/cfS/HNyXG/VGHm7xnH
         LN6Y8ESqNpSYnLu7RXGNfP0N8uH9Uzbskm2tRS9NnGpYjRa+Fz0tOX9rfNzc9dnaLz
         d1KToWzUKGwy/sgVoCxvMbpRT0mbkJGRKgUyRqSH6EHy8qDNZkjE/s8mM4XFaXQT8a
         WfOis3PI/L+zgBUQQ/DXBcy7LSytjna19b0cv0DZizhgqoBp1ncEB6LvSwAJXG2jHI
         VxsUslp42iYnA==
Date:   Sun, 4 Sep 2022 16:30:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jakob Hauser <jahau@rocketmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 1/3] iio: magnetometer: yamaha-yas530: Use pointers
 as driver data
Message-ID: <20220904163050.7cc52153@jic23-huawei>
In-Reply-To: <20220831141530.80572-1-andriy.shevchenko@linux.intel.com>
References: <20220831141530.80572-1-andriy.shevchenko@linux.intel.com>
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

On Wed, 31 Aug 2022 17:15:28 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Unify ID tables to use pointers for driver data. It will allow
> to simplify the driver later on.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Series applied to the togreg branch of iio.git and pushed out as testing
for 0-day to see if it can find things we missed.

Still time for feedback from others before I push this out as the
more or less non-rebasing, togreg branch.

Thanks,

Jonathan

> ---
> v2: left ID fallback in place (Jonathan)
>  drivers/iio/magnetometer/yamaha-yas530.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
> index 026f71e524f3..58f527cfde07 100644
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
> @@ -1437,8 +1438,10 @@ static int yas5xx_probe(struct i2c_client *i2c,
>  		goto assert_reset;
>  	}
>  
> -	yas5xx->chip_info = &yas5xx_chip_info_tbl[id->driver_data];
> -	ci = yas5xx->chip_info;
> +	ci = device_get_match_data(dev);
> +	if (!ci)
> +		ci = (const struct yas5xx_chip_info *)id->driver_data;
> +	yas5xx->chip_info = ci;
>  
>  	ret = regmap_read(yas5xx->map, YAS5XX_DEVICE_ID, &id_check);
>  	if (ret)
> @@ -1583,19 +1586,19 @@ static DEFINE_RUNTIME_DEV_PM_OPS(yas5xx_dev_pm_ops, yas5xx_runtime_suspend,
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

