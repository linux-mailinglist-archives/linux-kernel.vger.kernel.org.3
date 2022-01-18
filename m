Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6DE492AD6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 17:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244335AbiARQNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 11:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347490AbiARQLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 11:11:44 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A9FC06177E;
        Tue, 18 Jan 2022 08:11:11 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id i7-20020a9d68c7000000b0059396529af8so18143522oto.4;
        Tue, 18 Jan 2022 08:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wp6HFxmyH+W1ub29ho80GpkYopfq9hva3FLC/4l8FAI=;
        b=Y3ZbxNIsunSk1AHrzp1Mc9h6nqKhsJ4J6fsnt8ib777zelc+5dHRP++k37sepQ8wJp
         wcMn84UMvEeeFV28PCgjriUw6EUKM9RjNunjfnUhBCEF5QcYwoEGkm3s3Y6BA2+HRRl6
         xyL1BnRZHYUKduCq4THIUZrB7F1xLlikdweabk4NBkzMQ1TJW7afz1VEW1WG0IYLexkg
         kHeavdjYpdte4ZnZBWIj0gXOZAn2wKLgESfPlKBSM1iA+/F99hFH8oqjLyfHkLue+fqa
         nwcOCg5DEv6X/lH2Cfoyg6tDqmVBM6QuJ+zyBp3yxIoC5qh9OErg4qjPApfU9Ymr5yRv
         HeGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=wp6HFxmyH+W1ub29ho80GpkYopfq9hva3FLC/4l8FAI=;
        b=u80AqGi8WiXlm6lUwp6w8m4Vd4QEVLO52eDAgcGL9Cg9IdghuIKS7AcnqiaobqPds4
         nq/oYc0DvTJSk4KxY/6HsjEBsy8XTjagb+11GNAoYwH3L+t+vEqLUm5x0Ti2BkL9pY/o
         N9/cbH9aJkzXrD1J5Un/vNH3NZR7pw9FRQi6K/vJu7+TPILvImkRety3whxRIHfZJfAi
         5FFrrhMomFBPVcpeovv+4rADT+ymoXa+ekMMtMd1AnvY1ECack61JVyziy4celY4K41N
         WRmLzrQa6vU2YSmepbc5B53M+MWKhbO/CWhVKNqjAbs/1ruuxBJ9Y0p6Q0RG4jhQFrSz
         IVZg==
X-Gm-Message-State: AOAM532/X69by2XBioWiIPVvQGnIqkxPyaKf7BLFP2x49USLc8oIlm+a
        BqGMAHJbzIx3j8Wkpm/3Olw=
X-Google-Smtp-Source: ABdhPJyEgmj04xdOjN6O4U9ka462CxxomuI4/G8OQRGIvZpx9Z1YP7sW8q29W0lPsmKYCic96MtcLA==
X-Received: by 2002:a9d:37a2:: with SMTP id x31mr20698547otb.51.1642522270894;
        Tue, 18 Jan 2022 08:11:10 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s14sm2403902otd.0.2022.01.18.08.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 08:11:10 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 18 Jan 2022 08:11:08 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Marcello Sylvester Bauer <sylv@sylv.io>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Jean Delvare <jdelvare@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/4] hwmon: (max6639) Add regulator support
Message-ID: <20220118161108.GA4115171@roeck-us.net>
References: <cover.1642413668.git.sylv@sylv.io>
 <4c644f279f6e205d3c9540a4ad35825e4d5f2da1.1642413668.git.sylv@sylv.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c644f279f6e205d3c9540a4ad35825e4d5f2da1.1642413668.git.sylv@sylv.io>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 11:40:24AM +0100, Marcello Sylvester Bauer wrote:
> Add regulator support for boards where the fan-supply have to be
> powered up before it can be used.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> ---
>  drivers/hwmon/max6639.c | 64 +++++++++++++++++++++++++++++++++++------
>  1 file changed, 56 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
> index ccc0f047bd44..0b241f029229 100644
> --- a/drivers/hwmon/max6639.c
> +++ b/drivers/hwmon/max6639.c
> @@ -87,6 +87,9 @@ struct max6639_data {
>  	/* Register values initialized only once */
>  	u8 ppr;			/* Pulses per rotation 0..3 for 1..4 ppr */
>  	u8 rpm_range;		/* Index in above rpm_ranges table */
> +
> +	/* Optional regulator for FAN supply */
> +	struct regulator *reg;
>  };
>  
>  static struct max6639_data *max6639_update_device(struct device *dev)
> @@ -516,6 +519,11 @@ static int max6639_detect(struct i2c_client *client,
>  	return 0;
>  }
>  
> +static void max6639_regulator_disable(void *data)
> +{
> +	regulator_disable(data);
> +}
> +
>  static int max6639_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
> @@ -528,6 +536,30 @@ static int max6639_probe(struct i2c_client *client)
>  		return -ENOMEM;
>  
>  	data->client = client;
> +
> +	data->reg = devm_regulator_get_optional(dev, "fan");
> +	if (IS_ERR(data->reg)) {
> +		if (PTR_ERR(data->reg) != -ENODEV) {
> +			err = (int)PTR_ERR(data->reg);
> +			dev_warn(dev, "Failed looking up fan supply: %d\n", err);

This could be -EPROBE_DEFER. I do not think that warrants
an error message.

> +			return err;
> +		}
> +		data->reg = NULL;
> +	} else {
> +		/* Spin up fans */
> +		err = regulator_enable(data->reg);
> +		if (err) {
> +			dev_err(dev, "Failed to enable fan supply: %d\n", err);
> +			return err;
> +		}
> +		err = devm_add_action_or_reset(dev, max6639_regulator_disable,
> +					       data->reg);
> +		if (err) {
> +			dev_err(dev, "Failed to register action: %d\n", err);
> +			return err;
> +		}
> +	}
> +
>  	mutex_init(&data->update_lock);
>  
>  	/* Initialize the max6639 chip */
> @@ -545,23 +577,39 @@ static int max6639_probe(struct i2c_client *client)
>  static int max6639_suspend(struct device *dev)
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
> -	int data = i2c_smbus_read_byte_data(client, MAX6639_REG_GCONFIG);
> -	if (data < 0)
> -		return data;
> +	struct max6639_data *data = dev_get_drvdata(dev);
> +	int ret = i2c_smbus_read_byte_data(client, MAX6639_REG_GCONFIG);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	if (data->reg)
> +		regulator_disable(data->reg);
>  
>  	return i2c_smbus_write_byte_data(client,
> -			MAX6639_REG_GCONFIG, data | MAX6639_GCONFIG_STANDBY);
> +			MAX6639_REG_GCONFIG, ret | MAX6639_GCONFIG_STANDBY);
>  }
>  
>  static int max6639_resume(struct device *dev)
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
> -	int data = i2c_smbus_read_byte_data(client, MAX6639_REG_GCONFIG);
> -	if (data < 0)
> -		return data;
> +	struct max6639_data *data = dev_get_drvdata(dev);
> +	int ret;
> +
> +	if (data->reg) {
> +		ret = regulator_enable(data->reg);
> +		if (ret) {
> +			dev_err(dev, "Failed to enable fan supply: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	ret = i2c_smbus_read_byte_data(client, MAX6639_REG_GCONFIG);
> +	if (ret < 0)
> +		return ret;
>  
>  	return i2c_smbus_write_byte_data(client,
> -			MAX6639_REG_GCONFIG, data & ~MAX6639_GCONFIG_STANDBY);
> +			MAX6639_REG_GCONFIG, ret & ~MAX6639_GCONFIG_STANDBY);
>  }
>  #endif /* CONFIG_PM_SLEEP */
>  
