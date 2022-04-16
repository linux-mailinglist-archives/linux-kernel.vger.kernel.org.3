Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A76F503642
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 13:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbiDPLNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 07:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbiDPLNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 07:13:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD75D64FE;
        Sat, 16 Apr 2022 04:10:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84CA2B81CF5;
        Sat, 16 Apr 2022 11:10:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE44AC385A1;
        Sat, 16 Apr 2022 11:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650107444;
        bh=0Rv4QmjdRNCJUGYqIcNP5TFGkDquZlubml/v5/1K/aQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DecOErG/pn5KG1p8tA3NqPJya+gFPT27dHqv4ByT+KyrA7ZttKykMtAth/MblAYVX
         0MzX2VQdOmlSkjFmBYVzbnkcUlpbvaC8P02lCT2YVtVU4sVZYGHQVtI+1+PuwvXHPW
         4Na8kzIj2u0y0knj6jubRt8B8m7Jw1KtrdnZoDXJXGEQrBfPcft34z7fU/rUqTy4C5
         RY/AXvEqlp6VoxI1RaeCLESwlAqvhTANLCCfAtvZ9hwzDV/P1hHFQJhbs/hH8t7IoM
         OhLo7htFbx0usPwNCFSc4k/xlxwKFrxgO5npI31dOoD0X9Bxs9mz2dMTiAirvvwQm+
         CIfJuelBMYfJQ==
Date:   Sat, 16 Apr 2022 12:18:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: gyro: mpu3050: Make use of device
 properties
Message-ID: <20220416121840.0a75d721@jic23-huawei>
In-Reply-To: <20220413163004.84789-1-andriy.shevchenko@linux.intel.com>
References: <20220413163004.84789-1-andriy.shevchenko@linux.intel.com>
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

On Wed, 13 Apr 2022 19:30:04 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Convert the module to be property provider agnostic and allow
> it to be used on non-OF platforms.
> 
> While at it, reuse temporary device pointer in the same function.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied. Thanks,

Jonathan

> ---
>  drivers/iio/gyro/mpu3050-core.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
> index ea387efab62d..a2dafdb64692 100644
> --- a/drivers/iio/gyro/mpu3050-core.c
> +++ b/drivers/iio/gyro/mpu3050-core.c
> @@ -26,6 +26,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/property.h>
>  #include <linux/random.h>
>  #include <linux/slab.h>
>  
> @@ -1050,6 +1051,7 @@ static const struct iio_trigger_ops mpu3050_trigger_ops = {
>  static int mpu3050_trigger_probe(struct iio_dev *indio_dev, int irq)
>  {
>  	struct mpu3050 *mpu3050 = iio_priv(indio_dev);
> +	struct device *dev = mpu3050->dev;
>  	unsigned long irq_trig;
>  	int ret;
>  
> @@ -1061,8 +1063,7 @@ static int mpu3050_trigger_probe(struct iio_dev *indio_dev, int irq)
>  		return -ENOMEM;
>  
>  	/* Check if IRQ is open drain */
> -	if (of_property_read_bool(mpu3050->dev->of_node, "drive-open-drain"))
> -		mpu3050->irq_opendrain = true;
> +	mpu3050->irq_opendrain = device_property_read_bool(dev, "drive-open-drain");
>  
>  	irq_trig = irqd_get_trigger_type(irq_get_irq_data(irq));
>  	/*
> @@ -1118,13 +1119,12 @@ static int mpu3050_trigger_probe(struct iio_dev *indio_dev, int irq)
>  				   mpu3050->trig->name,
>  				   mpu3050->trig);
>  	if (ret) {
> -		dev_err(mpu3050->dev,
> -			"can't get IRQ %d, error %d\n", irq, ret);
> +		dev_err(dev, "can't get IRQ %d, error %d\n", irq, ret);
>  		return ret;
>  	}
>  
>  	mpu3050->irq = irq;
> -	mpu3050->trig->dev.parent = mpu3050->dev;
> +	mpu3050->trig->dev.parent = dev;
>  	mpu3050->trig->ops = &mpu3050_trigger_ops;
>  	iio_trigger_set_drvdata(mpu3050->trig, indio_dev);
>  

