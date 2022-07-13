Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74DD15737BE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 15:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbiGMNnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 09:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiGMNnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 09:43:05 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1407B8D;
        Wed, 13 Jul 2022 06:43:03 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so3694889pjl.5;
        Wed, 13 Jul 2022 06:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=chL/7eABLRjiJpnsmXXb4Y+aoKPBpp6nnBo71sEmir4=;
        b=KoZr59vM4m2geDg1zKapoo7kcM6DqsjSNP2KOBrbgxMN50s7bE3xhfyJ+w/55c55u7
         5PKxuhLljA9eakjfxHW5PWJ0SbzhS/Hd/oVPI25EO+fEjS+FWZFdCE8S+9ZCaE4nhb/s
         6oTiW3BTEE7bSv7jJctkZnravBJtzf4fZNjjC4mOJ0Qk+uii4kzsz7AeXKxuB6UThOMA
         ncftlFwj6sznn8SILve6M9BwjoUK6AUi4B6XN1EP2GFkaBXkLTWBd61+xZDIzGtvlJZ5
         OQW3uXtk9f/xA8ICMbez1KjpcP2P7FPooVOPksCBqOQO0+MjFgXvQnx9IEs9X/k8FtN0
         v/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=chL/7eABLRjiJpnsmXXb4Y+aoKPBpp6nnBo71sEmir4=;
        b=YmxYit3B+gkBt2zOKStpUQFbnCAXKees2kuk0Fjl815wMf0cF8+HLpTJLPr/qXbG2S
         YhAVlkH1fdjQWLajivdv9eOWhBEB1BwdXsq0Ko9nZjHp3KZBspb9whcnp6OXTLXcqB+/
         mMLGsM5NFHye1WEBrJKAgpL5tk+9OnG8RQJu1W++/aC6m+23vmDJah5J5ipl73bPj/1E
         aYo2AiaymlXeKCvr/aHYE0hc9RBfnjPGSeqa7hl8cMvF1Sdq4D75r/rPEoCgO7vH4m/O
         uhldA9f8SuXYmdyx5z406UgBWT/TYn90eFfZgP9L0IlNWVo2KKX7h7I6v76cOPheL8M0
         6Mtw==
X-Gm-Message-State: AJIora+yCkf1LcDB7cJLyPOgjO8sRdf/+74D5MYyysKHvDJZ2mmExQLl
        YnaYJByqWGg+2tTl2qAc0Jk=
X-Google-Smtp-Source: AGRyM1sOCr2NCMR2knEBQu6KxZvsz331IgBRTFQAHd6MlzT+uL0KSNuOMOcmszgciPRfBPie7oVXLw==
X-Received: by 2002:a17:902:ea0a:b0:168:d8ce:4a63 with SMTP id s10-20020a170902ea0a00b00168d8ce4a63mr3243442plg.57.1657719783382;
        Wed, 13 Jul 2022 06:43:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f4-20020a655904000000b0041229183c8esm8104572pgu.8.2022.07.13.06.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 06:43:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 13 Jul 2022 06:43:01 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Daniel Lezcano <daniel.lezcano@linexp.org>
Cc:     daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com,
        khilman@baylibre.com, abailon@baylibre.com, amitk@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        "open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH v1 26/33] hwmon/drivers: Switch to new of thermal API
Message-ID: <20220713134301.GA3798984@roeck-us.net>
References: <20220710212423.681301-1-daniel.lezcano@linexp.org>
 <20220710212423.681301-27-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220710212423.681301-27-daniel.lezcano@linexp.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 10, 2022 at 11:24:16PM +0200, Daniel Lezcano wrote:
> The thermal OF code has a new API allowing to migrate the OF
> initialization to a simpler approach.
> 
> Use this new API.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/hwmon/hwmon.c      | 14 +++++++-------
>  drivers/hwmon/scpi-hwmon.c | 14 +++++++-------
>  2 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> index 2e2cd79d89eb..a98c35fbce87 100644
> --- a/drivers/hwmon/hwmon.c
> +++ b/drivers/hwmon/hwmon.c
> @@ -151,9 +151,9 @@ static DEFINE_IDA(hwmon_ida);
>   * between hwmon and thermal_sys modules.
>   */
>  #ifdef CONFIG_THERMAL_OF
> -static int hwmon_thermal_get_temp(void *data, int *temp)
> +static int hwmon_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
>  {
> -	struct hwmon_thermal_data *tdata = data;
> +	struct hwmon_thermal_data *tdata = tz->devdata;
>  	struct hwmon_device *hwdev = to_hwmon_device(tdata->dev);
>  	int ret;
>  	long t;
> @@ -168,9 +168,9 @@ static int hwmon_thermal_get_temp(void *data, int *temp)
>  	return 0;
>  }
>  
> -static int hwmon_thermal_set_trips(void *data, int low, int high)
> +static int hwmon_thermal_set_trips(struct thermal_zone_device *tz, int low, int high)
>  {
> -	struct hwmon_thermal_data *tdata = data;
> +	struct hwmon_thermal_data *tdata = tz->devdata;
>  	struct hwmon_device *hwdev = to_hwmon_device(tdata->dev);
>  	const struct hwmon_chip_info *chip = hwdev->chip;
>  	const struct hwmon_channel_info **info = chip->info;
> @@ -203,7 +203,7 @@ static int hwmon_thermal_set_trips(void *data, int low, int high)
>  	return 0;
>  }
>  
> -static const struct thermal_zone_of_device_ops hwmon_thermal_ops = {
> +static struct thermal_zone_device_ops hwmon_thermal_ops = {
>  	.get_temp = hwmon_thermal_get_temp,
>  	.set_trips = hwmon_thermal_set_trips,
>  };
> @@ -227,8 +227,8 @@ static int hwmon_thermal_add_sensor(struct device *dev, int index)
>  	tdata->dev = dev;
>  	tdata->index = index;
>  
> -	tzd = devm_thermal_zone_of_sensor_register(dev, index, tdata,
> -						   &hwmon_thermal_ops);
> +	tzd = devm_thermal_of_zone_register(dev, index, tdata,
> +					    &hwmon_thermal_ops);
>  	if (IS_ERR(tzd)) {
>  		if (PTR_ERR(tzd) != -ENODEV)
>  			return PTR_ERR(tzd);
> diff --git a/drivers/hwmon/scpi-hwmon.c b/drivers/hwmon/scpi-hwmon.c
> index 5187c6dd5a4f..9c89db8e56a7 100644
> --- a/drivers/hwmon/scpi-hwmon.c
> +++ b/drivers/hwmon/scpi-hwmon.c
> @@ -62,9 +62,9 @@ static void scpi_scale_reading(u64 *value, struct sensor_data *sensor)
>  	}
>  }
>  
> -static int scpi_read_temp(void *dev, int *temp)
> +static int scpi_read_temp(struct thermal_zone_device *tz, int *temp)
>  {
> -	struct scpi_thermal_zone *zone = dev;
> +	struct scpi_thermal_zone *zone = tz->devdata;
>  	struct scpi_sensors *scpi_sensors = zone->scpi_sensors;
>  	struct scpi_ops *scpi_ops = scpi_sensors->scpi_ops;
>  	struct sensor_data *sensor = &scpi_sensors->data[zone->sensor_id];
> @@ -121,7 +121,7 @@ scpi_show_label(struct device *dev, struct device_attribute *attr, char *buf)
>  	return sprintf(buf, "%s\n", sensor->info.name);
>  }
>  
> -static const struct thermal_zone_of_device_ops scpi_sensor_ops = {
> +static struct thermal_zone_device_ops scpi_sensor_ops = {
>  	.get_temp = scpi_read_temp,
>  };
>  
> @@ -275,10 +275,10 @@ static int scpi_hwmon_probe(struct platform_device *pdev)
>  
>  		zone->sensor_id = i;
>  		zone->scpi_sensors = scpi_sensors;
> -		z = devm_thermal_zone_of_sensor_register(dev,
> -							 sensor->info.sensor_id,
> -							 zone,
> -							 &scpi_sensor_ops);
> +		z = devm_thermal_of_zone_register(dev,
> +						  sensor->info.sensor_id,
> +						  zone,
> +						  &scpi_sensor_ops);
>  		/*
>  		 * The call to thermal_zone_of_sensor_register returns
>  		 * an error for sensors that are not associated with
