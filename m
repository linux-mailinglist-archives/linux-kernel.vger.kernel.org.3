Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21956576679
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 19:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiGOR55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 13:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGOR5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 13:57:54 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B5A3AE65;
        Fri, 15 Jul 2022 10:57:53 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id g126so5275384pfb.3;
        Fri, 15 Jul 2022 10:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EoKJEUoROG+pGaJZ2cUV5lHsnkjMrfqT2r9Oqb+YBgQ=;
        b=f0tsJ84xVkhlVrpywKZtWete0WL/donUw+wU1NThdo4voAh3W9HFfs39gT9uhnAwe6
         PARsYRrv/Kp6s0hYUYYrBhwZflkqZBb7eX7jsrJNBgyXIUON0IqeBb0GJ+nH5dwdkkS1
         8PPuKeK6CR59Yb3yceMGBQNITa+rQTJ0usz/5t898v89KftpdCZndJ4rU0LOPocLEmsV
         ykHJ7qmcz2gCLj9uNkb4OITjO41IWORnmEHyWE7fpqvwxOJ2dui2mA3o1CZXK09txoeW
         J0e/FIOUqj3W0NjZdU6c8IF0ZVR8+bdLlz3GNxFe4O+Aa2sVlkqHIxuMeMxYiQZJ9A2i
         LgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=EoKJEUoROG+pGaJZ2cUV5lHsnkjMrfqT2r9Oqb+YBgQ=;
        b=CGBIsfNVbiIqkguGPJncmJ/21Mc3x6QfWo6uH10dv2q7GMu+zeizLlYet5O9rati62
         XEiEYnMlDU24CZDEx+iGonMRAsurLSLf1QRRhAPVl4VUP4100p1LiiUn8TePNShusr2J
         1gLZLbyPg7XheuaEMTLwMl/cJf9gAs446bSLP5+JPe3d0rjKDjG5K4a+OKnE5g5ZodpW
         so7I4YRbIWJpa4bmFFMdBU3I9bilkzQ8krEqUQU4O3Z9K6sbGcr16UgY6BXqmr9YlKgv
         3KjzLHFrI/wSh9Zxb3JrV4g4oyCR6dlJe2kwpQvSD5up2eRqAfjgXxBm23Sm6BJCMpIE
         h6fA==
X-Gm-Message-State: AJIora/7Tb1+jWfTMr7CFtx4vJlxL4yW/ejY2csIx0LhdNWRHQV67He5
        /Hdr2OZhhSWr6eQGRoLwoLkO7qa3OVafjA==
X-Google-Smtp-Source: AGRyM1sno8Sx4Cyj8bTE2Gqjil9rsi8kLnLqpX1yZCxokEvx2HlWvtiZL/a9bDeyRsk0agZe6+f71g==
X-Received: by 2002:a63:e044:0:b0:419:be58:463b with SMTP id n4-20020a63e044000000b00419be58463bmr7119519pgj.504.1657907873043;
        Fri, 15 Jul 2022 10:57:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a11-20020a170902900b00b0016bf1e8f1besm3832601plp.28.2022.07.15.10.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 10:57:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 15 Jul 2022 10:57:50 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     ferlandm@amotus.ca
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (mcp3021) improve driver support for newer hwmon
 interface
Message-ID: <20220715175750.GA3733098@roeck-us.net>
References: <20220712193504.1374656-1-ferlandm@amotus.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712193504.1374656-1-ferlandm@amotus.ca>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 03:35:04PM -0400, ferlandm@amotus.ca wrote:
> From: Marc Ferland <ferlandm@amotus.ca>
> 
> This driver is currently broken, it does not show the in0_input sysfs
> file and also returns the following message on startup:
> 
> hwmon_device_register() is deprecated. Please convert the driver to
> use hwmon_device_register_with_info().
> 
> This patch converts the driver and also cleans up the 'read' function.
> 
> Signed-off-by: Marc Ferland <ferlandm@amotus.ca>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/mcp3021.c | 99 ++++++++++++++++++++---------------------
>  1 file changed, 49 insertions(+), 50 deletions(-)
> 
> 
> base-commit: 9f6ca00b5be47e471e9703e6b017e1e2cfa7f604
> 
> diff --git a/drivers/hwmon/mcp3021.c b/drivers/hwmon/mcp3021.c
> index ce2780768074..e093b1998296 100644
> --- a/drivers/hwmon/mcp3021.c
> +++ b/drivers/hwmon/mcp3021.c
> @@ -7,7 +7,7 @@
>   * Reworked by Sven Schuchmann <schuchmann@schleissheimer.de>
>   * DT support added by Clemens Gruber <clemens.gruber@pqgruber.com>
>   *
> - * This driver export the value of analog input voltage to sysfs, the
> + * This driver exports the value of analog input voltage to sysfs, the
>   * voltage unit is mV. Through the sysfs interface, lm-sensors tool
>   * can also display the input voltage.
>   */
> @@ -45,19 +45,29 @@ enum chips {
>   * Client data (each client gets its own)
>   */
>  struct mcp3021_data {
> -	struct device *hwmon_dev;
> +	struct i2c_client *client;
>  	u32 vdd;        /* supply and reference voltage in millivolt */
>  	u16 sar_shift;
>  	u16 sar_mask;
>  	u8 output_res;
>  };
>  
> -static int mcp3021_read16(struct i2c_client *client)
> +static inline u16 volts_from_reg(struct mcp3021_data *data, u16 val)
>  {
> -	struct mcp3021_data *data = i2c_get_clientdata(client);
> -	int ret;
> -	u16 reg;
> +	return DIV_ROUND_CLOSEST(data->vdd * val, 1 << data->output_res);
> +}
> +
> +static int mcp3021_read(struct device *dev, enum hwmon_sensor_types type,
> +			u32 attr, int channel, long *val)
> +{
> +	struct mcp3021_data *data = dev_get_drvdata(dev);
> +	struct i2c_client *client = data->client;
>  	__be16 buf;
> +	u16 reg;
> +	int ret;
> +
> +	if (type != hwmon_in)
> +		return -EOPNOTSUPP;
>  
>  	ret = i2c_master_recv(client, (char *)&buf, 2);
>  	if (ret < 0)
> @@ -74,39 +84,46 @@ static int mcp3021_read16(struct i2c_client *client)
>  	 */
>  	reg = (reg >> data->sar_shift) & data->sar_mask;
>  
> -	return reg;
> -}
> +	*val = volts_from_reg(data, reg);
>  
> -static inline u16 volts_from_reg(struct mcp3021_data *data, u16 val)
> -{
> -	return DIV_ROUND_CLOSEST(data->vdd * val, 1 << data->output_res);
> +	return 0;
>  }
>  
> -static ssize_t in0_input_show(struct device *dev,
> -			      struct device_attribute *attr, char *buf)
> +static umode_t mcp3021_is_visible(const void *_data,
> +				  enum hwmon_sensor_types type,
> +				  u32 attr, int channel)
>  {
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct mcp3021_data *data = i2c_get_clientdata(client);
> -	int reg, in_input;
> +	if (type != hwmon_in)
> +		return 0;
>  
> -	reg = mcp3021_read16(client);
> -	if (reg < 0)
> -		return reg;
> +	if (attr != hwmon_in_input)
> +		return 0;
>  
> -	in_input = volts_from_reg(data, reg);
> -
> -	return sprintf(buf, "%d\n", in_input);
> +	return 0444;
>  }
>  
> -static DEVICE_ATTR_RO(in0_input);
> +static const struct hwmon_channel_info *mcp3021_info[] = {
> +	HWMON_CHANNEL_INFO(in, HWMON_I_INPUT),
> +	NULL
> +};
> +
> +static const struct hwmon_ops mcp3021_hwmon_ops = {
> +	.is_visible = mcp3021_is_visible,
> +	.read = mcp3021_read,
> +};
> +
> +static const struct hwmon_chip_info mcp3021_chip_info = {
> +	.ops = &mcp3021_hwmon_ops,
> +	.info = mcp3021_info,
> +};
>  
>  static const struct i2c_device_id mcp3021_id[];
>  
>  static int mcp3021_probe(struct i2c_client *client)
>  {
> -	int err;
>  	struct mcp3021_data *data = NULL;
>  	struct device_node *np = client->dev.of_node;
> +	struct device *hwmon_dev;
>  
>  	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
>  		return -ENODEV;
> @@ -147,34 +164,17 @@ static int mcp3021_probe(struct i2c_client *client)
>  		break;
>  	}
>  
> +	data->client = client;
> +
>  	if (data->vdd > MCP3021_VDD_REF_MAX || data->vdd < MCP3021_VDD_REF_MIN)
>  		return -EINVAL;
>  
> -	err = sysfs_create_file(&client->dev.kobj, &dev_attr_in0_input.attr);
> -	if (err)
> -		return err;
> -
> -	data->hwmon_dev = hwmon_device_register(&client->dev);
> -	if (IS_ERR(data->hwmon_dev)) {
> -		err = PTR_ERR(data->hwmon_dev);
> -		goto exit_remove;
> -	}
> -
> -	return 0;
> -
> -exit_remove:
> -	sysfs_remove_file(&client->dev.kobj, &dev_attr_in0_input.attr);
> -	return err;
> -}
> -
> -static int mcp3021_remove(struct i2c_client *client)
> -{
> -	struct mcp3021_data *data = i2c_get_clientdata(client);
> -
> -	hwmon_device_unregister(data->hwmon_dev);
> -	sysfs_remove_file(&client->dev.kobj, &dev_attr_in0_input.attr);
> -
> -	return 0;
> +	hwmon_dev = devm_hwmon_device_register_with_info(&client->dev,
> +							 client->name,
> +							 data,
> +							 &mcp3021_chip_info,
> +							 NULL);
> +	return PTR_ERR_OR_ZERO(hwmon_dev);
>  }
>  
>  static const struct i2c_device_id mcp3021_id[] = {
> @@ -199,7 +199,6 @@ static struct i2c_driver mcp3021_driver = {
>  		.of_match_table = of_match_ptr(of_mcp3021_match),
>  	},
>  	.probe_new = mcp3021_probe,
> -	.remove = mcp3021_remove,
>  	.id_table = mcp3021_id,
>  };
>  
