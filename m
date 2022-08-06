Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B570058B6AE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 18:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbiHFQEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 12:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiHFQEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 12:04:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7489EF59E;
        Sat,  6 Aug 2022 09:04:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 128386115C;
        Sat,  6 Aug 2022 16:04:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A07C433C1;
        Sat,  6 Aug 2022 16:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659801887;
        bh=gh/wto7k0KYY3RxC8t3r7Xa7/H2Kcun9NVfjBNu5CvY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LcvXYrVn+F8me33MNW1vSbXISQvcsPBbQaysL/e0uQ6Dlw3BIhZYi3wfXvUjXbsdF
         6Gx97kQ5LsBdb9pT3J35offIS3wWNZnx6AFZ7rBWy8gbmNVaU8AGyWwWQqTzRbQe20
         f+97Wcfv1C89kgCzLUizgJayHHu9xyOn7isSJx1JMpIJmWXP5p+6Sfv+d54TrWNTvu
         3M5uU3r+W76U1+0paU+EJ4LuV19jCc1wCxt12E2TqGKLUqq59ZXAN7Ety3VNMbfNN2
         qqo43na1u63Z/GDgawSqn0hhz7FZRmQW3SAPVcpFhGvsDO8+PksNv47q2LREihEOdz
         M/ELZ1XuKG+dg==
Date:   Sat, 6 Aug 2022 17:15:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Crt Mori <cmo@melexis.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/2] iio: temperature: mlx90632 Add supply regulator to
 sensor
Message-ID: <20220806171345.45cf1228@jic23-huawei>
In-Reply-To: <20220802103022.423328-1-cmo@melexis.com>
References: <20220802103022.423328-1-cmo@melexis.com>
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

On Tue,  2 Aug 2022 12:30:22 +0200
Crt Mori <cmo@melexis.com> wrote:

> Provide possibility to toggle power supply to the sensor so that user
> can optimize their setup and not have the sensor constantly powered.
> 
> Signed-off-by: Crt Mori <cmo@melexis.com>
> ---
>  drivers/iio/temperature/mlx90632.c | 52 ++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
> index 7ee7ff8047a4..e6e5e649a9f9 100644
> --- a/drivers/iio/temperature/mlx90632.c
> +++ b/drivers/iio/temperature/mlx90632.c
> @@ -18,6 +18,7 @@
>  #include <linux/math64.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -128,6 +129,7 @@
>   *        calculations
>   * @object_ambient_temperature: Ambient temperature at object (might differ of
>   *                              the ambient temperature of sensor.
> + * @regulator: Regulator of the device
>   */
>  struct mlx90632_data {
>  	struct i2c_client *client;
> @@ -136,6 +138,7 @@ struct mlx90632_data {
>  	u16 emissivity;
>  	u8 mtyp;
>  	u32 object_ambient_temperature;
> +	struct regulator *regulator;
>  };
>  
>  static const struct regmap_range mlx90632_volatile_reg_range[] = {
> @@ -841,6 +844,37 @@ static int mlx90632_wakeup(struct mlx90632_data *data)
>  	return mlx90632_pwr_continuous(data->regmap);
>  }
>  
> +static void mlx90632_disable_regulator(void *_data)
> +{
> +	struct mlx90632_data *data = _data;
> +	int ret;
> +
> +	ret = regulator_disable(data->regulator);
> +	if (ret < 0)
> +		dev_err(regmap_get_device(data->regmap),
> +			"Failed to disable power regulator: %d\n", ret);
> +}
> +
> +static int mlx90632_enable_regulator(struct mlx90632_data *data)
> +{
> +	int ret;
> +
> +	ret = regulator_set_voltage(data->regulator, 3200000, 3600000);
> +	if (ret < 0) {

Hmm. This can be problematic, as a valid option is for the a stub regulator to
have been returned.  Mostly for device where it is common for them to be wired
to fixed regulators, we just assume the firmware set the voltage correctly.
Ideally it provides a fixed (or controllable) regulator to make that clear.

> +		dev_err(regmap_get_device(data->regmap), "Failed to set voltage on regulator!\n");
> +		return ret;
> +	}
> +
> +	ret = regulator_enable(data->regulator);
> +	if (ret < 0) {
> +		dev_err(regmap_get_device(data->regmap), "Failed to enable power regulator!\n");

Trivial style thing.  Obviously makes no difference functionally but it makes all error blocks look
similar whether they are at the end of a function or not which saves a few brain cells when reviewing
lots of code.

	if (ret < 0) {
		dev_err(); 
		return ret;
	}

	/* Give the device ... */
	msleep();

	return 0;
}
	
> +	} else {
> +		/* Give the device a little bit of time to start up. */
> +		msleep(MLX90632_SLEEP_DELAY_MS);
> +	}
> +	return ret;
> +}
> +
>  static int mlx90632_probe(struct i2c_client *client,
>  			  const struct i2c_device_id *id)
>  {
> @@ -876,6 +910,24 @@ static int mlx90632_probe(struct i2c_client *client,
>  	indio_dev->channels = mlx90632_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(mlx90632_channels);
>  
> +	mlx90632->regulator = devm_regulator_get(&client->dev, "vdd");

An error here is a real error and should report it rather than carrying on.
May well be a case of deferring probe for example (use dev_err_probe() for the
reporting to handle that case nicely.

Note that if firmware doesn't provide a regulator we will get a dummy regulator
to represent the fact that we assume it just means no one bothered to specify
a fixed regulator in the firmware.  See drivers/regulator/dummy.c

> +	if (!IS_ERR(mlx90632->regulator)) {
> +		ret = mlx90632_enable_regulator(mlx90632);
> +		if (ret < 0) {
> +			dev_err(&client->dev, "Failed to enable regulator!\n");
> +			return ret;
> +		}
> +
> +		ret = devm_add_action_or_reset(&client->dev,
> +					       mlx90632_disable_regulator,
> +					       mlx90632);
> +		if (ret < 0) {
> +			dev_err(&client->dev, "Failed to setup regulator cleanup action %d\n",
> +				ret);
> +			return ret;
> +		}
> +	}
> +
>  	ret = mlx90632_wakeup(mlx90632);
>  	if (ret < 0) {
>  		dev_err(&client->dev, "Wakeup failed: %d\n", ret);

