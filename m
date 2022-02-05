Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA474AAA31
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 17:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345738AbiBEQjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 11:39:06 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:53776 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiBEQjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 11:39:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 026486102E;
        Sat,  5 Feb 2022 16:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A510C340EF;
        Sat,  5 Feb 2022 16:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644079143;
        bh=eyUzCj9Im/JJzJ/b7lRZbLEXnEmp7CpYdiYbFMtcsQQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=F3Dgq1e7oPMaa0gOvWSIPORHe4THC5j5+9RcDXJR4ug89pvh52dEJhWx5VpWZ5ZXN
         L30IkYkEql0cxl3LAUFODqtuFMzM9S2Y4Ifokr9o8e01mKvyAyazwlV2aEJsMnNGAf
         TENqxvAkSL0dweFJNQopYGKVhFOTyiATvcHpdjsMVHk9KDg92telp+L+KLSIWJ8tWB
         bmoqeWa7BttZSNjjLQ8YdborwZv48+q4sXxMC84PIKr9ixhu2UE8rMuomU+8hnOJHR
         41czcCVe5iJjAd0+dcaZrxmre3rnOlYXz1bpnpfFhI/2N6e/5yYfYsZSa0I5Ek0ws6
         V1Bz2q1HQ/vYQ==
Date:   Sat, 5 Feb 2022 16:45:35 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/3] iio: imu: inv_mpu6050: Drop wrong use of
 ACPI_PTR()
Message-ID: <20220205164535.763feeea@jic23-huawei>
In-Reply-To: <20220203155920.18586-1-andriy.shevchenko@linux.intel.com>
References: <20220203155920.18586-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  3 Feb 2022 17:59:18 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> ACPI_PTR() is more harmful than helpful. For example, in this case
> if CONFIG_ACPI=n, the ID table left unused which is not what we want.
> 
> Instead of adding ifdeffery or attribute here and there, drop ACPI_PTR().
> 
> Fixes: 3b3870646642 ("iio: imu: inv_mpu6050: Mark acpi match table as maybe unused")
> Fixes: fd64df16f40e ("iio: imu: inv_mpu6050: Add SPI support for MPU6000")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Hi Andy,

Whilst I fully support tidying this up, what is 'fixing' as such?
Will get rid of an unused warning for the spi case but that sort
of things doesn't always get fixes tags.  They tend to result
in backports and I wouldn't think it was worth backporting this
unless I'm missing something...

Jonathan


> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c | 7 +++----
>  drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c | 4 ++--
>  2 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> index fe03707ec2d3..ccb06d9af760 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> @@ -3,11 +3,11 @@
>  * Copyright (C) 2012 Invensense, Inc.
>  */
>  
> -#include <linux/acpi.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/i2c.h>
>  #include <linux/iio/iio.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
>  #include <linux/property.h>
> @@ -249,11 +249,10 @@ static const struct of_device_id inv_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, inv_of_match);
>  
> -static const struct acpi_device_id __maybe_unused inv_acpi_match[] = {
> +static const struct acpi_device_id inv_acpi_match[] = {
>  	{"INVN6500", INV_MPU6500},
>  	{ },
>  };
> -
>  MODULE_DEVICE_TABLE(acpi, inv_acpi_match);
>  
>  static struct i2c_driver inv_mpu_driver = {
> @@ -262,7 +261,7 @@ static struct i2c_driver inv_mpu_driver = {
>  	.id_table	=	inv_mpu_id,
>  	.driver = {
>  		.of_match_table = inv_of_match,
> -		.acpi_match_table = ACPI_PTR(inv_acpi_match),
> +		.acpi_match_table = inv_acpi_match,
>  		.name	=	"inv-mpu6050-i2c",
>  		.pm     =       &inv_mpu_pmops,
>  	},
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> index 6800356b25fb..44b4f74b9256 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> @@ -2,8 +2,8 @@
>  /*
>  * Copyright (C) 2015 Intel Corporation Inc.
>  */
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> -#include <linux/acpi.h>
>  #include <linux/of.h>
>  #include <linux/property.h>
>  #include <linux/spi/spi.h>
> @@ -148,7 +148,7 @@ static struct spi_driver inv_mpu_driver = {
>  	.id_table	=	inv_mpu_id,
>  	.driver = {
>  		.of_match_table = inv_of_match,
> -		.acpi_match_table = ACPI_PTR(inv_acpi_match),
> +		.acpi_match_table = inv_acpi_match,
>  		.name	=	"inv-mpu6000-spi",
>  		.pm     =       &inv_mpu_pmops,
>  	},

