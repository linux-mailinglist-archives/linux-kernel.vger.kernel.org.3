Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF765AC516
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 17:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbiIDPoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 11:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiIDPoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 11:44:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117B2357DD;
        Sun,  4 Sep 2022 08:43:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5222460C01;
        Sun,  4 Sep 2022 15:43:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A5DFC433D6;
        Sun,  4 Sep 2022 15:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662306238;
        bh=CSx9D8U7zeLdj+S2jR8ebHyZgl/+lsPzYuJJygOC9Dk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ntvXgUAynAgToZ5zloMz/8fSdopBqHKe9bllfCGSkwrONgQSW63aVtrVAMA1L3qqN
         8FW3uaTP9x6VpgJjro1SR1P0UBxeularKr05KruHPyFDmInFKRtc10IHnpVB02fi0h
         fgGEv5tytEAr69uzXtIjR6vgQVYEyhxJlO4xXvtW7iLsq5LmMS5fxYrWpQGfEXdI6o
         9EXDF+RL3inckXqis8UzkiayHN+gmg0QxEEWMay7bKFFeaTt/KSzewlu88wcoP+BeO
         iJHmlNqLJbaKXpuWn2CKrmi9eUM8b2AzT8oeLRxEfSQvF3LyP6NCN060wCbwZ9TLi9
         yHS7t+pu35Nxw==
Date:   Sun, 4 Sep 2022 16:09:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ciprian Regus <ciprian.regus@analog.com>
Cc:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] drivers: iio: adc: Rename the LTC2499 iio device
Message-ID: <20220904160951.7de30240@jic23-huawei>
In-Reply-To: <20220901121700.1325733-5-ciprian.regus@analog.com>
References: <20220901121700.1325733-1-ciprian.regus@analog.com>
        <20220901121700.1325733-5-ciprian.regus@analog.com>
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

On Thu, 1 Sep 2022 15:17:00 +0300
Ciprian Regus <ciprian.regus@analog.com> wrote:

> Set the iio device's name based on the chip used for the
> LTC2499 only. The most common way for IIO clients to interact
> with a device is to address it based on it's name. By using
> the dev_name() function, the name will be set based on a
> i2c_client's kobj name, which has the format i2c_instance-i2c_address
> (1-0076 for example). This is not ideal, since it makes a
> requirement for userspace to have knowledge about the hardware
> connections of the device.
> 
> The name field is set to NULL for the LTC2497 and LTC2496, so
> that the old name can kept as it is, since changing it will
> result in an ABI breakage.
> 
> Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
Other than the issue with the split between patches 4 and 5 that
the robot found this looks good to me.

Jonathan

> ---
> changes in v2:
>  - updated the patch title (LTC249x -> LTC2499), since the name change only
>    affects the LTC2499.
>  - updated the commit description to better explain what is being done.
>  - only changed the iio_dev's name for the LTC2499.
>  - added a comment to explain difference in naming.
>  - added the const qualifier to the name field.
>  drivers/iio/adc/ltc2496.c      |  1 +
>  drivers/iio/adc/ltc2497-core.c | 10 +++++++++-
>  drivers/iio/adc/ltc2497.h      |  1 +
>  3 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ltc2496.c b/drivers/iio/adc/ltc2496.c
> index bf89d5ae19af..2593fa4322eb 100644
> --- a/drivers/iio/adc/ltc2496.c
> +++ b/drivers/iio/adc/ltc2496.c
> @@ -89,6 +89,7 @@ static void ltc2496_remove(struct spi_device *spi)
>  
>  static const struct ltc2497_chip_info ltc2496_info = {
>  	.resolution = 16,
> +	.name = NULL,
>  };
>  
>  static const struct of_device_id ltc2496_of_match[] = {
> diff --git a/drivers/iio/adc/ltc2497-core.c b/drivers/iio/adc/ltc2497-core.c
> index b2752399402c..f52d37af4d1f 100644
> --- a/drivers/iio/adc/ltc2497-core.c
> +++ b/drivers/iio/adc/ltc2497-core.c
> @@ -169,7 +169,15 @@ int ltc2497core_probe(struct device *dev, struct iio_dev *indio_dev)
>  	struct ltc2497core_driverdata *ddata = iio_priv(indio_dev);
>  	int ret;
>  
> -	indio_dev->name = dev_name(dev);
> +	/*
> +	 * Keep using dev_name() for the iio_dev's name on some of the parts,
> +	 * since updating it would result in a ABI breakage.
> +	 */
> +	if (ddata->chip_info->name)
> +		indio_dev->name = ddata->chip_info->name;
> +	else
> +		indio_dev->name = dev_name(dev);
> +
>  	indio_dev->info = &ltc2497core_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = ltc2497core_channel;
> diff --git a/drivers/iio/adc/ltc2497.h b/drivers/iio/adc/ltc2497.h
> index 95f6a5f4d4a6..fd3dfd491060 100644
> --- a/drivers/iio/adc/ltc2497.h
> +++ b/drivers/iio/adc/ltc2497.h
> @@ -12,6 +12,7 @@ enum ltc2497_chip_type {
>  
>  struct ltc2497_chip_info {
>  	u32 resolution;
> +	const char *name;
>  };
>  
>  struct ltc2497core_driverdata {

