Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9954AAA42
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 17:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380500AbiBEQpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 11:45:54 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57968 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380489AbiBEQpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 11:45:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 121ED61124;
        Sat,  5 Feb 2022 16:45:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F70DC340EF;
        Sat,  5 Feb 2022 16:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644079551;
        bh=LVYAwLMpX5b9btZJtcd/Mf+M2yp14JwEBL18CINAams=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nIMwawSlaZHLM5p6+XHltIXXt+1ftBNpa8g9snAJTfI7iI8BdagW8frlRmLMq2DHl
         knV79sioHJnsgfSiKECykUAZkczL1Gzk7cUeKSeMrDbJht1jozWf59RMYVHQLPLly4
         8UGXTLu1x0tZ8+GqlzyimX4ldLvp196k7Imw3MhBvYxU22DAkV4XyWoTt88uxPXk5e
         id3Ur5rHQJa+Msj9KgrKdwJy/u705/JsyReW6fo+KvR0yYogNDPsIu3lqrrLoHREt1
         ydB4xI9bLgBdweXv8LG25AtDPH9ojkj9pKhUpUded58Clly2IA9FgXXd9hiVFt7FgO
         iVabTGWn2sDGA==
Date:   Sat, 5 Feb 2022 16:52:21 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v1 1/1] iio: amplifiers: hmc425a: Make use of device
 properties
Message-ID: <20220205165221.0e82373a@jic23-huawei>
In-Reply-To: <20220203121624.75515-1-andriy.shevchenko@linux.intel.com>
References: <20220203121624.75515-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  3 Feb 2022 14:16:24 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Convert the module to be property provider agnostic and allow
> it to be used on non-OF platforms.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Given how simple this one is, I'll apply it now.
Of course, if anyone notices problems I can back it out again
as won't be doing any pull requests for at least a week or two.

Applied,

Thanks,

Jonathan

> ---
>  drivers/iio/amplifiers/hmc425a.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/amplifiers/hmc425a.c b/drivers/iio/amplifiers/hmc425a.c
> index 16c0a77f6a1c..ce80e0c916f4 100644
> --- a/drivers/iio/amplifiers/hmc425a.c
> +++ b/drivers/iio/amplifiers/hmc425a.c
> @@ -11,10 +11,10 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> -#include <linux/of_platform.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/slab.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/sysfs.h>
> @@ -192,7 +192,7 @@ static int hmc425a_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	st = iio_priv(indio_dev);
> -	st->type = (uintptr_t)of_device_get_match_data(&pdev->dev);
> +	st->type = (uintptr_t)device_get_match_data(&pdev->dev);
>  
>  	st->chip_info = &hmc425a_chip_info_tbl[st->type];
>  	indio_dev->num_channels = st->chip_info->num_channels;

