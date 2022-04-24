Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEC850D3D6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 19:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236205AbiDXRSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 13:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236144AbiDXRSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 13:18:13 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9197D2DD9;
        Sun, 24 Apr 2022 10:15:12 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id e4so14768308oif.2;
        Sun, 24 Apr 2022 10:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JfJ0HfGimDKl5hpR+oluxggQqpBfRFEunRNvW/TZgiA=;
        b=LEncwMvWMitePVfWjrIBm1Lu6RIl9iSdjcmonn20+ZVxgDt8O+A+6Ukuh3VatsPDZu
         N9NJQf42VdT914zXAlcJ1zaYe8f2MjKglO4WhWffl5GU6mzEY17gKR1MHLrmIJBzwqdU
         Vth1rVC27ARprqHXFhR7lDnGW/9t/0J/RfJGm97g5Bpf5ul5JGOZZ3xy36qal2qR+P/s
         cCA+18l5LPe/gYkhh23dUbp6DzZwRxRE/6dCI0i6FHTiLsMi74LEAlK8j/up4tijnHfB
         jzlRsZDFWn6RSjUyGPJayibkJGMwI0v6khgJZIeyiL+B8gW7/aOcDoFsyE9Y3zBzz4dI
         NBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=JfJ0HfGimDKl5hpR+oluxggQqpBfRFEunRNvW/TZgiA=;
        b=es/U9sOamhCL1Hi4Zm+tm2kH671nmnbAvjR+xmcUs6G3mh3SzoPkZleJaNQnye988e
         1VogR+4H0O6ORWuURsZbqDcZBTeF5ndPafMjW6e4OqIHFit/Ot5MFayaCva63D5phq9U
         DGagA+wWsnMpNMDF6bnxPy5ToMZ8TG7xBUMPP4o7P7hBvPbmFp4fHdIhm+4LXySYUrEI
         UNxOJ34TP6uDY0usSdIxQtRVPRP6TFA4SFO6Z2bveksf2yJRdkb987pzlyx3LkfbF2xI
         9Cn2Vl/AQ9QxHM8iVFkbxZnl6/O3aeAoY6lrXNpq4Jn87HTq3kGGv8a/eNp0bk1cGOIT
         Bzdg==
X-Gm-Message-State: AOAM531ZJT6R417i60NPFWqwobP3/TOHPpS0yyyKgX9GdC6N0BQSV5vZ
        UOhFn99Zwv49W+xFYUrk8gU=
X-Google-Smtp-Source: ABdhPJxurq3UaxQ7hMjnuo7hDsVmYUr+2PvUhLxtB+3U+NJn+KbHphqozBxFw52vUHdjov9pFXWk6A==
X-Received: by 2002:a05:6808:ecc:b0:2fa:7d95:8dec with SMTP id q12-20020a0568080ecc00b002fa7d958decmr10541594oiv.34.1650820511904;
        Sun, 24 Apr 2022 10:15:11 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w36-20020a05687033a400b000d75f1d9b82sm2455684oae.47.2022.04.24.10.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 10:15:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 24 Apr 2022 10:15:08 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eduardo Valentin <eduval@amazon.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Eduardo Valentin <evalenti@kernel.org>
Subject: Re: [PATCH 1/1] drivers: hwmon: pmbus: register with thermal for
 PSC_TEMPERATURE
Message-ID: <20220424171508.GA748830@roeck-us.net>
References: <20220322014650.14956-1-eduval@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322014650.14956-1-eduval@amazon.com>
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

On Mon, Mar 21, 2022 at 06:46:50PM -0700, Eduardo Valentin wrote:
> Some pmbus device drivers have device tree support and
> may want to use of-thermal to register a thermal zone
> OF sensor for those device drivers.
> 
> This way we allow describing device tree thermal zones
> for pmbus device drivers with device tree support.
> 
> This patch achieves this by registering pmbus sensors
> with thermal subsystem if they are PSC_TEMPERATURE
> and are providing _input hwmon interface.
> 
> Cc: Guenter Roeck <linux@roeck-us.net> (maintainer:PMBUS HARDWARE MONITORING DRIVERS)
> Cc: Jean Delvare <jdelvare@suse.com> (maintainer:HARDWARE MONITORING)
> Cc: linux-hwmon@vger.kernel.org (open list:PMBUS HARDWARE MONITORING DRIVERS)
> Cc: linux-kernel@vger.kernel.org (open list)
> Signed-off-by: Eduardo Valentin <eduval@amazon.com>
> Signed-off-by: Eduardo Valentin <evalenti@kernel.org>
> ---
>  drivers/hwmon/pmbus/pmbus_core.c | 88 +++++++++++++++++++++++++++++---
>  1 file changed, 80 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 776ee2237be2..a51cdfab1c3e 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -19,6 +19,8 @@
>  #include <linux/pmbus.h>
>  #include <linux/regulator/driver.h>
>  #include <linux/regulator/machine.h>
> +#include <linux/of.h>
> +#include <linux/thermal.h>
>  #include "pmbus.h"
>  
>  /*
> @@ -1078,7 +1080,71 @@ static int pmbus_add_boolean(struct pmbus_data *data,
>  	return pmbus_add_attribute(data, &a->dev_attr.attr);
>  }
>  
> -static struct pmbus_sensor *pmbus_add_sensor(struct pmbus_data *data,
> +/* of thermal for pmbus temperature sensors */
> +struct pmbus_thermal_data {
> +	struct i2c_client *client;
> +	struct pmbus_sensor *sensor;
> +};
> +
> +static int pmbus_thermal_get_temp(void *data, int *temp)
> +{
> +	struct pmbus_thermal_data *tdata = data;
> +	struct i2c_client *client = tdata->client;
> +	struct pmbus_sensor *sensor = tdata->sensor;
> +	struct pmbus_data *pmbus_data = i2c_get_clientdata(client);
> +	struct device *dev = pmbus_data->hwmon_dev;

The i2c client is also in to_i2c_client(pmbus_data->dev);
Since pmbus_data is needed anyway, I would suggest to store it
instead of struct i2c_client * in pmbus_thermal_data.
That avoids having to change the parameters of pmbus_add_sensor().

> +	int ret = 0;
> +
> +	if (!dev) {
> +		/* May not even get to hwmon yet */
> +		*temp = 0;
> +		return 0;
> +	}
> +
> +	mutex_lock(&pmbus_data->update_lock);
> +	pmbus_update_sensor_data(client, sensor);
> +	if (sensor->data < 0)
> +		ret = sensor->data;
> +	else
> +		*temp = (int)pmbus_reg2data(pmbus_data, sensor);
> +	mutex_unlock(&pmbus_data->update_lock);
> +
> +	return ret;
> +}
> +
> +static const struct thermal_zone_of_device_ops pmbus_thermal_ops = {
> +	.get_temp = pmbus_thermal_get_temp,
> +};
> +
> +static int pmbus_thermal_add_sensor(struct i2c_client *client,
> +				    struct pmbus_data *pmbus_data,
> +				    struct pmbus_sensor *sensor, int index)
> +{
> +	struct device *dev = pmbus_data->dev;
> +	struct pmbus_thermal_data *tdata;
> +	struct thermal_zone_device *tzd;
> +
> +	tdata = devm_kzalloc(dev, sizeof(*tdata), GFP_KERNEL);
> +	if (!tdata)
> +		return -ENOMEM;
> +
> +	tdata->sensor = sensor;
> +	tdata->client = client;
> +
> +	tzd = devm_thermal_zone_of_sensor_register(dev, index, tdata,
> +						   &pmbus_thermal_ops);
> +	/*
> +	 * If CONFIG_THERMAL_OF is disabled, this returns -ENODEV,
> +	 * so ignore that error but forward any other error.
> +	 */
> +	if (IS_ERR(tzd) && (PTR_ERR(tzd) != -ENODEV))
> +		return PTR_ERR(tzd);
> +
> +	return 0;
> +}
> +
> +static struct pmbus_sensor *pmbus_add_sensor(struct i2c_client *client,
> +					     struct pmbus_data *data,
>  					     const char *name, const char *type,
>  					     int seq, int page, int phase,
>  					     int reg,
> @@ -1121,6 +1187,10 @@ static struct pmbus_sensor *pmbus_add_sensor(struct pmbus_data *data,
>  	sensor->next = data->sensors;
>  	data->sensors = sensor;
>  
> +	/* temperature sensors with _input values are registered with thermal */
> +	if (class == PSC_TEMPERATURE && strcmp(type, "input") == 0)

type can be NULL. While that is not currently the case if the class
is PSC_TEMPERATURE, we should not rely on it.

> +		pmbus_thermal_add_sensor(client, data, sensor, seq);
> +
>  	return sensor;
>  }
>  
> @@ -1216,8 +1286,9 @@ static int pmbus_add_limit_attrs(struct i2c_client *client,
>  
>  	for (i = 0; i < nlimit; i++) {
>  		if (pmbus_check_word_register(client, page, l->reg)) {
> -			curr = pmbus_add_sensor(data, name, l->attr, index,
> -						page, 0xff, l->reg, attr->class,
> +			curr = pmbus_add_sensor(client, data, name, l->attr,
> +						index, page, 0xff, l->reg,
> +						attr->class,
>  						attr->update || l->update,
>  						false, true);
>  			if (!curr)
> @@ -1258,7 +1329,7 @@ static int pmbus_add_sensor_attrs_one(struct i2c_client *client,
>  		if (ret)
>  			return ret;
>  	}
> -	base = pmbus_add_sensor(data, name, "input", index, page, phase,
> +	base = pmbus_add_sensor(client, data, name, "input", index, page, phase,
>  				attr->reg, attr->class, true, true, true);
>  	if (!base)
>  		return -ENOMEM;
> @@ -1887,7 +1958,7 @@ static int pmbus_add_fan_ctrl(struct i2c_client *client,
>  {
>  	struct pmbus_sensor *sensor;
>  
> -	sensor = pmbus_add_sensor(data, "fan", "target", index, page,
> +	sensor = pmbus_add_sensor(client, data, "fan", "target", index, page,
>  				  0xff, PMBUS_VIRT_FAN_TARGET_1 + id, PSC_FAN,
>  				  false, false, true);
>  
> @@ -1898,14 +1969,14 @@ static int pmbus_add_fan_ctrl(struct i2c_client *client,
>  			(data->info->func[page] & PMBUS_HAVE_PWM34)))
>  		return 0;
>  
> -	sensor = pmbus_add_sensor(data, "pwm", NULL, index, page,
> +	sensor = pmbus_add_sensor(client, data, "pwm", NULL, index, page,
>  				  0xff, PMBUS_VIRT_PWM_1 + id, PSC_PWM,
>  				  false, false, true);
>  
>  	if (!sensor)
>  		return -ENOMEM;
>  
> -	sensor = pmbus_add_sensor(data, "pwm", "enable", index, page,
> +	sensor = pmbus_add_sensor(client, data, "pwm", "enable", index, page,
>  				  0xff, PMBUS_VIRT_PWM_ENABLE_1 + id, PSC_PWM,
>  				  true, false, false);
>  
> @@ -1947,7 +2018,8 @@ static int pmbus_add_fan_attributes(struct i2c_client *client,
>  			    (!(regval & (PB_FAN_1_INSTALLED >> ((f & 1) * 4)))))
>  				continue;
>  
> -			if (pmbus_add_sensor(data, "fan", "input", index,
> +			if (pmbus_add_sensor(client, data, "fan",
> +					     "input", index,
>  					     page, 0xff, pmbus_fan_registers[f],
>  					     PSC_FAN, true, true, true) == NULL)
>  				return -ENOMEM;
