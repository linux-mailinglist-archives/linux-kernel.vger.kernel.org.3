Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2592F5505B2
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 17:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234968AbiFRPYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 11:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbiFRPYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 11:24:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2040860C7;
        Sat, 18 Jun 2022 08:24:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9BE64B801B8;
        Sat, 18 Jun 2022 15:24:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FBC7C3411A;
        Sat, 18 Jun 2022 15:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655565884;
        bh=Z+Twh7SwZ6hXrHT+LtD17vA7anfjZRx7HRgnzaj2hcc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W10YYF/j5Fblb6/DQIT2vu2EzpS+MIBRDckLUPsmILaMIKfjSiqrg6gpAIFYJs+1L
         4VDrcKi85+UoNs7tbx3sJYXxxpaaIy+fQlAW3rzwFtMV152PRQrh/YnpJwF/KFJVYA
         0yVQDbeWzD3MH/7cN1wsGojhTyJOGW6Slyt0cEnLnRr4fwzhXErdaLq1dX3VgqZmGI
         DVpw+jY4YKV8kSn7sWGv4hQXqLxyOrTrAMIFHTuo38hOY/xGsaR9OVCSmKvzHzeDAL
         3vNxUB1bpJrmi73dLJTkBc9G1HSLDKKrE0A0R1THX3VRGBVIV1TbyQe/Sb4/qEU+Gv
         EZnCemqWDdJBA==
Date:   Sat, 18 Jun 2022 16:34:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: accel: mma7660: Drop wrong use of
 ACPI_PTR()
Message-ID: <20220618163401.0c603cc5@jic23-huawei>
In-Reply-To: <20220616142451.10322-1-andriy.shevchenko@linux.intel.com>
References: <20220616142451.10322-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Thu, 16 Jun 2022 17:24:51 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> ACPI_PTR() is more harmful than helpful. For example, in this case
> if CONFIG_ACPI=n, the ID table left unused which is not what we want.
> 
> Instead of making linker to drop a section, drop ACPI_PTR().
> 
> As a side effect this makes driver ACPI and OF clean.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/mma7660.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma7660.c b/drivers/iio/accel/mma7660.c
> index 112a5a33c29f..794f2f383303 100644
> --- a/drivers/iio/accel/mma7660.c
> +++ b/drivers/iio/accel/mma7660.c
> @@ -7,8 +7,8 @@
>   * IIO driver for Freescale MMA7660FC; 7-bit I2C address: 0x4c.
>   */
>  
> -#include <linux/acpi.h>
>  #include <linux/i2c.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -255,7 +255,7 @@ static const struct of_device_id mma7660_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, mma7660_of_match);
>  
> -static const struct acpi_device_id __maybe_unused mma7660_acpi_id[] = {
> +static const struct acpi_device_id mma7660_acpi_id[] = {
>  	{"MMA7660", 0},
>  	{}
>  };
> @@ -267,7 +267,7 @@ static struct i2c_driver mma7660_driver = {
>  		.name = "mma7660",
>  		.pm = pm_sleep_ptr(&mma7660_pm_ops),
>  		.of_match_table = mma7660_of_match,
> -		.acpi_match_table = ACPI_PTR(mma7660_acpi_id),
> +		.acpi_match_table = mma7660_acpi_id,
>  	},
>  	.probe		= mma7660_probe,
>  	.remove		= mma7660_remove,

