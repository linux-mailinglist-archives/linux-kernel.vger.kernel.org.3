Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C6C5271F7
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 16:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbiENO14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 10:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbiENO1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 10:27:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C366B2BA;
        Sat, 14 May 2022 07:27:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A6B660F02;
        Sat, 14 May 2022 14:27:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE01C340EE;
        Sat, 14 May 2022 14:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652538469;
        bh=PyuhuQtevyldQ5YwVAm3vJo7rj0yjNlAxJbFhH2D4C4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eVAwtu8PXM9fahwFSHqkHOj5ZFBQ+9liG8tanBNARTgdq+iJWR7qyOt+0fI/JeFaK
         5MPZ2jUb7hFhtdtBtkkmpEg8i9vXBxzEeReWBJJzD6/JT9671kbBejiZntgB9tMTeS
         /PgUfaDzSyV8jE3aQWPo3oVBem0QZkScIF6fNZSoJ60QrXKotJegzm95zSPb3rBbJl
         vGyP58iZYx1MtWwgiu025yLX+Dct4fRXtfFjXVG3j2v/fDmbfwBqv6Bg4/iKCoII4u
         +mVCcjCihgYvyvg8whmSDMV4B4vqrwdu6omqYjde6ZTT29CW0tx2F6ABnml+Wp8NtK
         pPsLYahlvaYXA==
Date:   Sat, 14 May 2022 15:36:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     lars@metafoo.de, andriy.shevchenko@linux.intel.com,
        sean@geanix.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: bmi160: Fix the error handling at
 bmi160_chip_init()
Message-ID: <20220514153625.18c4d9f8@jic23-huawei>
In-Reply-To: <20220513143513.2284425-1-zheyuma97@gmail.com>
References: <20220513143513.2284425-1-zheyuma97@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-pc-linux-gnu)
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

On Fri, 13 May 2022 22:35:13 +0800
Zheyu Ma <zheyuma97@gmail.com> wrote:

> When the driver fails in bmi160_chip_init(), it should disable the
> regulator.
> 
> The following log shows it:
> 
> [   18.709662] WARNING: CPU: 0 PID: 294 at drivers/regulator/core.c:2257 _regulator_put+0x3ec/0x4e0
> [   18.712069] RIP: 0010:_regulator_put+0x3ec/0x4e0
> [   18.716395] Call Trace:
> [   18.716522]  <TASK>
> [   18.716636]  regulator_bulk_free+0x82/0xe0
> [   18.717077]  i2c_device_probe+0x6f0/0x800
> 
> Fixes: 5dea3fb066f0 ("iio: imu: bmi160: added regulator support")
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>

Hi,

Good find, but Tong Zhang got their first and the resulting patch
fixes an additional issue missed in this fix. See below.

Jonathan

> ---
>  drivers/iio/imu/bmi160/bmi160_core.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
> index 824b5124a5f5..33abfc2bbd7c 100644
> --- a/drivers/iio/imu/bmi160/bmi160_core.c
> +++ b/drivers/iio/imu/bmi160/bmi160_core.c
> @@ -730,7 +730,7 @@ static int bmi160_chip_init(struct bmi160_data *data, bool use_spi)
>  
>  	ret = regmap_write(data->regmap, BMI160_REG_CMD, BMI160_CMD_SOFTRESET);
>  	if (ret)
> -		return ret;
> +		goto err_regulator_disable;
>  
>  	usleep_range(BMI160_SOFTRESET_USLEEP, BMI160_SOFTRESET_USLEEP + 1);
>  
> @@ -741,29 +741,34 @@ static int bmi160_chip_init(struct bmi160_data *data, bool use_spi)
>  	if (use_spi) {
>  		ret = regmap_read(data->regmap, BMI160_REG_DUMMY, &val);
>  		if (ret)
> -			return ret;
> +			goto err_regulator_disable;
>  	}
>  
>  	ret = regmap_read(data->regmap, BMI160_REG_CHIP_ID, &val);
>  	if (ret) {
>  		dev_err(dev, "Error reading chip id\n");
> -		return ret;
> +		goto err_regulator_disable;
>  	}
>  	if (val != BMI160_CHIP_ID_VAL) {
>  		dev_err(dev, "Wrong chip id, got %x expected %x\n",
>  			val, BMI160_CHIP_ID_VAL);
> -		return -ENODEV;
> +		ret = -ENODEV;
> +		goto err_regulator_disable;
>  	}
>  
>  	ret = bmi160_set_mode(data, BMI160_ACCEL, true);
>  	if (ret)
> -		return ret;
> +		goto err_regulator_disable;
>  
>  	ret = bmi160_set_mode(data, BMI160_GYRO, true);
>  	if (ret)

A failure here does not disable the accelerometer (which is done
in the uninit() function which we we never end
up running.


> -		return ret;
> +		goto err_regulator_disable;
>  
>  	return 0;
> +
> +err_regulator_disable:
> +	regulator_bulk_disable(ARRAY_SIZE(data->supplies), data->supplies);
> +	return ret;
>  }
>  
>  static int bmi160_data_rdy_trigger_set_state(struct iio_trigger *trig,

