Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D722C5035FE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 12:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbiDPKrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 06:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiDPKrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 06:47:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984AF63AE;
        Sat, 16 Apr 2022 03:44:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4FFBEB802BD;
        Sat, 16 Apr 2022 10:44:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63FE5C385A1;
        Sat, 16 Apr 2022 10:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650105875;
        bh=qIAW/kz5RXpt4kuFn2wabmw/IGiDdl65BVext0CaIPI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t/SToZjBEeDXZ9XYKnDywXZWRzqnqj3E0GofbRF6XHsPzpmrJY0v5pfcfhgShufZe
         EOgkqfsSVT46NGVBJ1XvCX+d1yhYmj++OAVbMUNilpokjOQeifSZMG24FM3rt0QPbn
         diR3YZIrfAKhOpwER6G3LapIFyOcJnzd+4XHKAa8Eb4Vz8QCKqINODuH0nEZxKLj4o
         fFGUZbWfplFsZ7oijZdARzMmrU5h7ef2S9E7eQpJAKDIzh6KkQt7XE48XFb8Smrjv4
         y6zV7Cmurs3vGvaK+9sIcJ5jmrc2k7pO4aES+dprV4VHM6BHqHTEOG2yAtbCO/2yMt
         whUpv7eu2v3kw==
Date:   Sat, 16 Apr 2022 11:52:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andrea Merello <andrea.merello@gmail.com>,
        Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
Subject: Re: [PATCH v1 1/1] iio: temperature: max31856: Make use of device
 properties
Message-ID: <20220416115233.23625624@jic23-huawei>
In-Reply-To: <20220413185044.21588-1-andriy.shevchenko@linux.intel.com>
References: <20220413185044.21588-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
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

On Wed, 13 Apr 2022 21:50:44 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Convert the module to be property provider agnostic and allow
> it to be used on non-OF platforms.
> 
Added note on addition of mod_devicetable.h include.

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
+CC Andrea and Paresh

Seems straight forward so I've applied it but there is still time for
others to take a look.

Thanks,

Jonathan

> ---
>  drivers/iio/temperature/max31856.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/temperature/max31856.c b/drivers/iio/temperature/max31856.c
> index 54840881259a..8307aae2cb45 100644
> --- a/drivers/iio/temperature/max31856.c
> +++ b/drivers/iio/temperature/max31856.c
> @@ -7,9 +7,11 @@
>   */
>  
>  #include <linux/ctype.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/err.h>
> +#include <linux/property.h>
>  #include <linux/spi/spi.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -422,9 +424,7 @@ static int max31856_probe(struct spi_device *spi)
>  	indio_dev->channels = max31856_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(max31856_channels);
>  
> -	ret = of_property_read_u32(spi->dev.of_node, "thermocouple-type",
> -				   &data->thermocouple_type);
> -
> +	ret = device_property_read_u32(&spi->dev, "thermocouple-type", &data->thermocouple_type);
>  	if (ret) {
>  		dev_info(&spi->dev,
>  			 "Could not read thermocouple type DT property, configuring as a K-Type\n");

