Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931995035FC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 12:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbiDPKmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 06:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiDPKmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 06:42:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268F014002;
        Sat, 16 Apr 2022 03:40:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D41E5B81D17;
        Sat, 16 Apr 2022 10:40:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBA6C385A3;
        Sat, 16 Apr 2022 10:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650105604;
        bh=Oos9yoNwh3SAMIWdcwpd3Xw5BoBg+r+ad8P3SM2AUEc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Wu8fNiou8nfeGGtUNnSnv4UUdrbM4GFT123skfFr+xm4M7digTpwJTZrL9325fKil
         hB/xTx9yvDQgYjSHv7l3bQYup3RsbXyqeostsyGNYKZpIfoVRxuOJJuPyW4gvysNM2
         uWm7j8PNyDUrhU6XHdqK7OWR7ICq1sRkY1BjO4ihP8KKbWETplnIhikxPH/pnmkpFb
         GL/e/qx/CtcIUu5j+O6x5wYw6azRsjVCa9s2csisqZb3X1LusRcfXP+KPoaenAQDP8
         nczplE/l0J7dQgcJ/o8ZS5u4MTgCUse2EFEMCc908LF1dw+j4FIb8va5b4OZLj87oW
         /8Au3mIdpZ1iw==
Date:   Sat, 16 Apr 2022 11:48:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Navin Sankar Velliangiri <navin@linumiz.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: temperature: max31865: Make use of device
 properties
Message-ID: <20220416114801.0865fcba@jic23-huawei>
In-Reply-To: <20220413185335.21743-1-andriy.shevchenko@linux.intel.com>
References: <20220413185335.21743-1-andriy.shevchenko@linux.intel.com>
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

On Wed, 13 Apr 2022 21:53:35 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Convert the module to be property provider agnostic and allow
> it to be used on non-OF platforms.

This one should call out the addition of missing mod_devicetable.h
If nothing else comes up I can add that whilst applying.
Looks fine to me but I'd like to give a little time for
Navin to comment if they wish.

Jonathan

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/iio/temperature/max31865.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/temperature/max31865.c b/drivers/iio/temperature/max31865.c
> index 86c3f3509a26..e3bb78184c6e 100644
> --- a/drivers/iio/temperature/max31865.c
> +++ b/drivers/iio/temperature/max31865.c
> @@ -12,9 +12,11 @@
>  #include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/init.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> +#include <linux/property.h>
>  #include <linux/spi/spi.h>
>  #include <asm/unaligned.h>
>  
> @@ -305,7 +307,7 @@ static int max31865_probe(struct spi_device *spi)
>  	indio_dev->channels = max31865_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(max31865_channels);
>  
> -	if (of_property_read_bool(spi->dev.of_node, "maxim,3-wire")) {
> +	if (device_property_read_bool(&spi->dev, "maxim,3-wire")) {
>  		/* select 3 wire */
>  		data->three_wire = 1;
>  	} else {

