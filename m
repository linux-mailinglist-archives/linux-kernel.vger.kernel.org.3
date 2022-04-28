Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2FD513B89
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 20:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351048AbiD1S3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 14:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350909AbiD1S3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 14:29:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F062BB929;
        Thu, 28 Apr 2022 11:26:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A37CB82F55;
        Thu, 28 Apr 2022 18:26:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63FDFC385A0;
        Thu, 28 Apr 2022 18:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651170395;
        bh=U5e77tVFeyTjyJTtfLg3A2UHgDfPEx8DxgdENmDZGN0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Aqw8MDUL6VZ/h0YClBkPr941jAJq2LGXh86qupZiAc4MyLDrYNbbyRyGjRBHVWaTR
         5sqqupgMCaeHaTr5866Tl6MyoQDjpEN3qOVvcRBeDQPUi1SEPPTx1Y/zG2jBEOjE6U
         qCY9kvKuSZEjjJjle+hxaqc1MjkmiIlUXjbDSamphBmaoKk4JDDPTVgl3n0SaKoi6V
         g+djUZivHtZBDCce//7nHlDnvj5mzrLSV+o64EA3Ik8kuBrRTc4QsfB0g/YDUhoJFI
         /nRo5VgdjsmZH6AEtuow7ONLhuKWZabcyN0sCCKXG1YcW3SDHxyZ2n2xfuoA6ovosp
         g8M8nSRb1dUvQ==
Date:   Thu, 28 Apr 2022 19:34:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: dac: ltc2632: Make use of device properties
Message-ID: <20220428193447.33b2d4a7@jic23-huawei>
In-Reply-To: <20220413192203.46704-1-andriy.shevchenko@linux.intel.com>
References: <20220413192203.46704-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2022 22:22:03 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Convert the module to be property provider agnostic and allow
> it to be used on non-OF platforms.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Hi Andy,

Not sure why I was sitting on this one.

Anyhow, now applied to the togreg branch of iio.git and pushed out
as testing for all the normal reasons.

Thanks,

Jonathan

> ---
>  drivers/iio/dac/ltc2632.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/dac/ltc2632.c b/drivers/iio/dac/ltc2632.c
> index aed46c80757e..c0255f402056 100644
> --- a/drivers/iio/dac/ltc2632.c
> +++ b/drivers/iio/dac/ltc2632.c
> @@ -10,6 +10,7 @@
>  #include <linux/spi/spi.h>
>  #include <linux/module.h>
>  #include <linux/iio/iio.h>
> +#include <linux/property.h>
>  #include <linux/regulator/consumer.h>
>  
>  #include <asm/unaligned.h>
> @@ -362,8 +363,7 @@ static int ltc2632_probe(struct spi_device *spi)
>  		}
>  	}
>  
> -	indio_dev->name = dev_of_node(&spi->dev) ? dev_of_node(&spi->dev)->name
> -						 : spi_get_device_id(spi)->name;
> +	indio_dev->name = fwnode_get_name(dev_fwnode(&spi->dev)) ?: spi_get_device_id(spi)->name;
>  	indio_dev->info = &ltc2632_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = chip_info->channels;
> @@ -469,7 +469,7 @@ MODULE_DEVICE_TABLE(of, ltc2632_of_match);
>  static struct spi_driver ltc2632_driver = {
>  	.driver		= {
>  		.name	= "ltc2632",
> -		.of_match_table = of_match_ptr(ltc2632_of_match),
> +		.of_match_table = ltc2632_of_match,
>  	},
>  	.probe		= ltc2632_probe,
>  	.remove		= ltc2632_remove,

