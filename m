Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF455520BB0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 05:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbiEJDJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 23:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234844AbiEJDJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 23:09:06 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E778D1D570B;
        Mon,  9 May 2022 20:05:08 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id e189so17210435oia.8;
        Mon, 09 May 2022 20:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7vvn06gVwkQUwV2CDJNUf8Xbe8kTMTsVrQLRrtehwfs=;
        b=Xj0XRSp6rRLNbd1lLcU0Uzc7m+Gx2gGgOiqhGwYhsnKlHeJaT92ROJVS72unOfNi/q
         LEtoqNRi659y6JOCP0kUGZ6z9nu2S7wjxVhF5Gd6coWhUXon3qO6MOJO/aJYly7HOVV3
         IK10v3c3gUV7jM6GGMRzRv+KHpP1nAEkr4ydh9rwOq13JR08HaW4sCRcTS9lDeKBb4Kg
         vXKMNH5lJKJYcVw3lU1iJOnjE1uw4w7Y03JDmighW0/Xir2grOwIQu4+azQTgFueUB7G
         iNzyfyCVm2g+9YeXHUENSB8/TTngBX4B34VjaAEZBTh7vxnUdDJbIBt1/MuU3/PfKHxj
         g4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=7vvn06gVwkQUwV2CDJNUf8Xbe8kTMTsVrQLRrtehwfs=;
        b=oW/N+Gx33UKPFZIi1Q2BE7AFmaE/4l99WNwDKwjTGdVeJdH22gsq7JxWlBC9/I03Si
         KAx7a5E28a9ffCvgEeX+OgNM755Vo92kYI92nDPOv0dNvXZ1ReVhCRFl0S49wT0xmEoc
         P6BUIf5azt07oeeNv0rUGLJiD4VzreMrbBf7lJviuOctpkT1fOb5OXyIX2u6FVKHOtdA
         xi4US5eJeQWub5Uz17kNYodpWcPYtAlyTNEiOFVKojoHbvYzbuys0R2A27nueWOCzhsX
         y4fhlYTuGUKtxFBdluhku4dvfhmlcFUes6avWy6IQfgWGG8fMkOfxUxqyRPZmWGyAXeM
         VrBQ==
X-Gm-Message-State: AOAM5305hhR/i+DCzOPchzX543SQgxH25ZpmM/33nQkgQB31p8zVCqkl
        6XT4pCuKnuAs7fZmcOs6DQQ=
X-Google-Smtp-Source: ABdhPJwjXP6OBRe50se4DQNcEOLnAbw+RcCIRgSuGPEOwJ6KRD7ZHiPZxZWtGTvVyoOzCKe0zT90wA==
X-Received: by 2002:a05:6808:e82:b0:322:4c17:2f61 with SMTP id k2-20020a0568080e8200b003224c172f61mr8940955oil.131.1652151908071;
        Mon, 09 May 2022 20:05:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l63-20020aca3e42000000b00325cda1ff9fsm5059456oia.30.2022.05.09.20.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 20:05:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 9 May 2022 20:05:04 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] hwmon: acpi_power_meter: convert to
 hwmon_device_register_with_info
Message-ID: <20220510030504.GA1577548@roeck-us.net>
References: <20220509063010.3878134-1-clabbe@baylibre.com>
 <20220509063010.3878134-3-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509063010.3878134-3-clabbe@baylibre.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 06:30:10AM +0000, Corentin Labbe wrote:
> Booting lead to a hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
> So let's convert the driver to use hwmon_device_register_with_info().
> 

This is hardly readable, and results in a checkpatch warning.
Please rephrase.

> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  drivers/hwmon/acpi_power_meter.c | 509 +++++++++++++------------------
>  1 file changed, 219 insertions(+), 290 deletions(-)
> 
> diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
> index d2545a1be9fc..03a144c884aa 100644
> --- a/drivers/hwmon/acpi_power_meter.c
> +++ b/drivers/hwmon/acpi_power_meter.c

The following include files seem unnecessary.

linux/hwmon-sysfs.h
linux/kdev_t.h
linux/sched.h

On the other side,

linux/kobject.h

should be included.

> @@ -23,7 +23,8 @@
>  #define ACPI_POWER_METER_DEVICE_NAME	"Power Meter"
>  #define ACPI_POWER_METER_CLASS		"pwr_meter_resource"
>  
> -#define NUM_SENSORS			17
> +#define TRIP_MIN 0
> +#define TRIP_MAX 1

Please use

#define<space>DEFINE<tab>value

>  
>  #define POWER_METER_CAN_MEASURE	(1 << 0)
>  #define POWER_METER_CAN_TRIP	(1 << 1)
> @@ -38,11 +39,6 @@
>  #define METER_NOTIFY_CAPPING	0x83
>  #define METER_NOTIFY_INTERVAL	0x84
>  
> -#define POWER_AVERAGE_NAME	"power1_average"
> -#define POWER_CAP_NAME		"power1_cap"
> -#define POWER_AVG_INTERVAL_NAME	"power1_average_interval"
> -#define POWER_ALARM_NAME	"power1_alarm"
> -
>  static int cap_in_hardware;
>  static bool force_cap_on;
>  
> @@ -85,8 +81,6 @@ struct acpi_power_meter_resource {
>  	u64		avg_interval;
>  	int			sensors_valid;
>  	unsigned long		sensors_last_updated;
> -	struct sensor_device_attribute	sensors[NUM_SENSORS];
> -	int			num_sensors;
>  	s64			trip[2];
>  	int			num_domain_devices;
>  	struct acpi_device	**domain_devices;

Around here is struct sensor_template which is now unused.
Please remove.

> @@ -122,47 +116,32 @@ static int update_avg_interval(struct acpi_power_meter_resource *resource)
>  	return 0;
>  }
>  
> -static ssize_t show_avg_interval(struct device *dev,
> -				 struct device_attribute *devattr,
> -				 char *buf)
> +static int acpi_power_average_interval_read(struct acpi_power_meter_resource *resource)
>  {
> -	struct acpi_device *acpi_dev = to_acpi_device(dev);
> -	struct acpi_power_meter_resource *resource = acpi_dev->driver_data;
> -
>  	mutex_lock(&resource->lock);
>  	update_avg_interval(resource);
>  	mutex_unlock(&resource->lock);
>  
> -	return sprintf(buf, "%llu\n", resource->avg_interval);
> +	return resource->avg_interval;
>  }
>  
> -static ssize_t set_avg_interval(struct device *dev,
> -				struct device_attribute *devattr,
> -				const char *buf, size_t count)
> +static int set_average_interval(struct acpi_power_meter_resource *resource, long val)
>  {
> -	struct acpi_device *acpi_dev = to_acpi_device(dev);
> -	struct acpi_power_meter_resource *resource = acpi_dev->driver_data;
>  	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
>  	struct acpi_object_list args = { 1, &arg0 };
> -	int res;
> -	unsigned long temp;
>  	unsigned long long data;
>  	acpi_status status;
>  
> -	res = kstrtoul(buf, 10, &temp);
> -	if (res)
> -		return res;
> -
> -	if (temp > resource->caps.max_avg_interval ||
> -	    temp < resource->caps.min_avg_interval)
> +	if (val > resource->caps.max_avg_interval ||
> +	    val < resource->caps.min_avg_interval)
>  		return -EINVAL;
> -	arg0.integer.value = temp;
> +	arg0.integer.value = val;
>  
>  	mutex_lock(&resource->lock);
>  	status = acpi_evaluate_integer(resource->acpi_dev->handle, "_PAI",
>  				       &args, &data);
>  	if (ACPI_SUCCESS(status))
> -		resource->avg_interval = temp;
> +		resource->avg_interval = val;
>  	mutex_unlock(&resource->lock);
>  
>  	if (ACPI_FAILURE(status)) {
> @@ -175,7 +154,7 @@ static ssize_t set_avg_interval(struct device *dev,
>  	if (data)
>  		return -EINVAL;
>  
> -	return count;
> +	return 0;
>  }
>  
>  /* Cap functions */
> @@ -196,46 +175,33 @@ static int update_cap(struct acpi_power_meter_resource *resource)
>  	return 0;
>  }
>  
> -static ssize_t show_cap(struct device *dev,
> -			struct device_attribute *devattr,
> -			char *buf)
> +static int acpi_power_cap_read(struct acpi_power_meter_resource *resource,
> +			       long *val)
>  {
> -	struct acpi_device *acpi_dev = to_acpi_device(dev);
> -	struct acpi_power_meter_resource *resource = acpi_dev->driver_data;
> -
>  	mutex_lock(&resource->lock);
>  	update_cap(resource);
>  	mutex_unlock(&resource->lock);
>  
> -	return sprintf(buf, "%llu\n", resource->cap * 1000);
> +	return resource->cap * 1000;
>  }
>  
> -static ssize_t set_cap(struct device *dev, struct device_attribute *devattr,
> -		       const char *buf, size_t count)
> +static int set_cap(struct acpi_power_meter_resource *resource, long val)
>  {
> -	struct acpi_device *acpi_dev = to_acpi_device(dev);
> -	struct acpi_power_meter_resource *resource = acpi_dev->driver_data;
>  	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
>  	struct acpi_object_list args = { 1, &arg0 };
> -	int res;
> -	unsigned long temp;
>  	unsigned long long data;
>  	acpi_status status;
>  
> -	res = kstrtoul(buf, 10, &temp);
> -	if (res)
> -		return res;
> -
> -	temp = DIV_ROUND_CLOSEST(temp, 1000);
> -	if (temp > resource->caps.max_cap || temp < resource->caps.min_cap)
> +	val = DIV_ROUND_CLOSEST(val, 1000);
> +	if (val > resource->caps.max_cap || val < resource->caps.min_cap)
>  		return -EINVAL;
> -	arg0.integer.value = temp;
> +	arg0.integer.value = val;
>  
>  	mutex_lock(&resource->lock);
>  	status = acpi_evaluate_integer(resource->acpi_dev->handle, "_SHL",
>  				       &args, &data);
>  	if (ACPI_SUCCESS(status))
> -		resource->cap = temp;
> +		resource->cap = val;
>  	mutex_unlock(&resource->lock);
>  
>  	if (ACPI_FAILURE(status)) {
> @@ -248,7 +214,7 @@ static ssize_t set_cap(struct device *dev, struct device_attribute *devattr,
>  	if (data)
>  		return -EINVAL;
>  
> -	return count;
> +	return 0;
>  }
>  
>  /* Power meter trip points */
> @@ -263,12 +229,12 @@ static int set_acpi_trip(struct acpi_power_meter_resource *resource)
>  	acpi_status status;
>  
>  	/* Both trip levels must be set */
> -	if (resource->trip[0] < 0 || resource->trip[1] < 0)
> +	if (resource->trip[TRIP_MIN] < 0 || resource->trip[TRIP_MAX] < 0)
>  		return 0;
>  
>  	/* This driver stores min, max; ACPI wants max, min. */
> -	arg_objs[0].integer.value = resource->trip[1];
> -	arg_objs[1].integer.value = resource->trip[0];
> +	arg_objs[0].integer.value = resource->trip[TRIP_MAX];
> +	arg_objs[1].integer.value = resource->trip[TRIP_MIN];
>  
>  	status = acpi_evaluate_integer(resource->acpi_dev->handle, "_PTP",
>  				       &args, &data);
> @@ -285,30 +251,18 @@ static int set_acpi_trip(struct acpi_power_meter_resource *resource)
>  	return 0;
>  }
>  
> -static ssize_t set_trip(struct device *dev, struct device_attribute *devattr,
> -			const char *buf, size_t count)
> +static int set_trip(struct acpi_power_meter_resource *resource, long val, int triptype)
>  {
> -	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -	struct acpi_device *acpi_dev = to_acpi_device(dev);
> -	struct acpi_power_meter_resource *resource = acpi_dev->driver_data;
>  	int res;
> -	unsigned long temp;
>  
> -	res = kstrtoul(buf, 10, &temp);
> -	if (res)
> -		return res;
> -
> -	temp = DIV_ROUND_CLOSEST(temp, 1000);
> +	val = DIV_ROUND_CLOSEST(val, 1000);
>  
>  	mutex_lock(&resource->lock);
> -	resource->trip[attr->index - 7] = temp;
> +	resource->trip[triptype] = val;
>  	res = set_acpi_trip(resource);
>  	mutex_unlock(&resource->lock);
>  
> -	if (res)
> -		return res;
> -
> -	return count;
> +	return res;
>  }
>  
>  /* Power meter */
> @@ -337,33 +291,26 @@ static int update_meter(struct acpi_power_meter_resource *resource)
>  	return 0;
>  }
>  
> -static ssize_t show_power(struct device *dev,
> -			  struct device_attribute *devattr,
> -			  char *buf)
> +static int acpi_power_power_read(struct acpi_power_meter_resource *resource,
> +				 long *val)
>  {
> -	struct acpi_device *acpi_dev = to_acpi_device(dev);
> -	struct acpi_power_meter_resource *resource = acpi_dev->driver_data;
> -
>  	mutex_lock(&resource->lock);
>  	update_meter(resource);
>  	mutex_unlock(&resource->lock);
>  
> -	return sprintf(buf, "%llu\n", resource->power * 1000);
> +	*val = resource->power * 1000;
> +	return 0;
>  }
>  
>  /* Miscellaneous */
> -static ssize_t show_str(struct device *dev,
> -			struct device_attribute *devattr,
> -			char *buf)
> +static ssize_t show_str(struct device *dev, int index, char *buf)
>  {
> -	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -	struct acpi_device *acpi_dev = to_acpi_device(dev);
> -	struct acpi_power_meter_resource *resource = acpi_dev->driver_data;
> +	struct acpi_power_meter_resource *resource = dev_get_drvdata(dev);
>  	acpi_string val;
>  	int ret;
>  
>  	mutex_lock(&resource->lock);
> -	switch (attr->index) {
> +	switch (index) {
>  	case 0:
>  		val = resource->model_number;
>  		break;
> @@ -375,7 +322,7 @@ static ssize_t show_str(struct device *dev,
>  		break;
>  	default:
>  		WARN(1, "Implementation error: unexpected attribute index %d\n",
> -		     attr->index);
> +		     index);
>  		val = "";
>  		break;
>  	}
> @@ -384,141 +331,138 @@ static ssize_t show_str(struct device *dev,
>  	return ret;
>  }
>  
> -static ssize_t show_val(struct device *dev,
> -			struct device_attribute *devattr,
> -			char *buf)
> +static ssize_t power1_is_battery_show(struct device *dev,
> +				      struct device_attribute *attr,
> +				      char *buf)
>  {
> -	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct acpi_device *acpi_dev = to_acpi_device(dev);
>  	struct acpi_power_meter_resource *resource = acpi_dev->driver_data;
> -	u64 val = 0;
> +	int val;
>  
> -	switch (attr->index) {
> -	case 0:
> -		val = resource->caps.min_avg_interval;
> +	if (resource->caps.flags & POWER_METER_IS_BATTERY)
> +		val = 1;
> +	else
> +		val = 0;

	val = !!(resource->caps.flags & POWER_METER_IS_BATTERY);

would avoid the if()

> +	return sprintf(buf, "%d\n", val);
> +}
> +
> +static ssize_t power1_model_number_show(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	return show_str(dev, 0, buf);
> +}
> +
> +static ssize_t power1_serial_number_show(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *buf)
> +{
> +	return show_str(dev, 1, buf);
> +}
> +
> +static ssize_t power1_oem_info_show(struct device *dev,
> +				    struct device_attribute *attr,
> +				    char *buf)
> +{
> +	return show_str(dev, 2, buf);
> +}
> +
> +static int acpi_power_read(struct device *dev, enum hwmon_sensor_types type,
> +			   u32 attr, int channel, long *val)
> +{
> +	struct acpi_power_meter_resource *resource = dev_get_drvdata(dev);
> +
> +	switch (attr) {
> +	case hwmon_power_average:
> +		return acpi_power_power_read(resource, val);
> +	case hwmon_power_average_interval_min:
> +		*val = resource->caps.min_avg_interval;
>  		break;
> -	case 1:
> -		val = resource->caps.max_avg_interval;
> +	case hwmon_power_average_interval_max:
> +		*val = resource->caps.max_avg_interval;
>  		break;
> -	case 2:
> -		val = resource->caps.min_cap * 1000;
> +	case hwmon_power_cap_min:
> +		*val = resource->caps.min_cap * 1000;
>  		break;
> -	case 3:
> -		val = resource->caps.max_cap * 1000;
> +	case hwmon_power_cap_max:
> +		*val = resource->caps.max_cap * 1000;
>  		break;
> -	case 4:
> +	case hwmon_power_cap:
> +		*val = acpi_power_cap_read(resource, val);
> +		break;
> +	case hwmon_power_cap_hyst:
>  		if (resource->caps.hysteresis == UNKNOWN_HYSTERESIS)
> -			return sprintf(buf, "unknown\n");
> +			return -EINVAL;

			return -ENODATA;

>  
> -		val = resource->caps.hysteresis * 1000;
> +		*val = resource->caps.hysteresis * 1000;
>  		break;
> -	case 5:
> -		if (resource->caps.flags & POWER_METER_IS_BATTERY)
> -			val = 1;
> -		else
> -			val = 0;
> -		break;
> -	case 6:
> +	case hwmon_power_alarm:
>  		if (resource->power > resource->cap)
> -			val = 1;
> +			*val = 1;
>  		else
> -			val = 0;
> +			*val = 0;

		*val = !!(resource->power > resource->cap);

>  		break;
> -	case 7:
> -	case 8:
> -		if (resource->trip[attr->index - 7] < 0)
> -			return sprintf(buf, "unknown\n");
> -
> -		val = resource->trip[attr->index - 7] * 1000;
> +	case hwmon_power_average_min:
> +		if (resource->trip[TRIP_MIN] < 0)
> +			return -EINVAL;

			return -ENODATA;

> +		*val = resource->trip[TRIP_MIN] * 1000;
> +		break;
> +	case hwmon_power_average_max:
> +		if (resource->trip[TRIP_MAX] < 0)
> +			return -EINVAL;

			return -ENODATA;

> +		*val = resource->trip[TRIP_MAX] * 1000;
> +		break;
> +	case hwmon_power_average_interval:
> +		*val = acpi_power_average_interval_read(resource);
> +		break;
> +	case hwmon_power_accuracy:
> +		*val = div_u64(resource->caps.accuracy, 1000);
>  		break;
>  	default:
>  		WARN(1, "Implementation error: unexpected attribute index %d\n",
> -		     attr->index);
> -		break;
> +		     attr);
> +		return -EOPNOTSUPP;
>  	}
>  
> -	return sprintf(buf, "%llu\n", val);
> -}
> -
> -static ssize_t show_accuracy(struct device *dev,
> -			     struct device_attribute *devattr,
> -			     char *buf)
> -{
> -	struct acpi_device *acpi_dev = to_acpi_device(dev);
> -	struct acpi_power_meter_resource *resource = acpi_dev->driver_data;
> -	unsigned int acc = resource->caps.accuracy;
> -
> -	return sprintf(buf, "%u.%u%%\n", acc / 1000, acc % 1000);
> +	return 0;
>  }
>  
> -static ssize_t show_name(struct device *dev,
> -			 struct device_attribute *devattr,
> -			 char *buf)
> +static int acpi_power_write(struct device *dev, enum hwmon_sensor_types type,
> +			    u32 attr, int channel, long val)
>  {
> -	return sprintf(buf, "%s\n", ACPI_POWER_METER_NAME);
> -}
> -
> -#define RO_SENSOR_TEMPLATE(_label, _show, _index)	\
> -	{						\
> -		.label = _label,			\
> -		.show  = _show,				\
> -		.index = _index,			\
> -	}
> -
> -#define RW_SENSOR_TEMPLATE(_label, _show, _set, _index)	\
> -	{						\
> -		.label = _label,			\
> -		.show  = _show,				\
> -		.set   = _set,				\
> -		.index = _index,			\
> +	struct acpi_power_meter_resource *resource = dev_get_drvdata(dev);
> +
> +	switch (attr) {
> +	case hwmon_power_average_min:
> +		return set_trip(resource, TRIP_MIN, val);
> +	case hwmon_power_average_max:
> +		return set_trip(resource, TRIP_MAX, val);
> +	case hwmon_power_cap:
> +		if (resource->caps.configurable_cap)
> +			return set_cap(resource, val);
> +		else

else after return is unnecessary.

> +			return -EINVAL;
> +	case hwmon_power_average_interval:
> +		return set_average_interval(resource, val);
> +	default:
> +		return -EOPNOTSUPP;
>  	}
> +}
>  
> -/* Sensor descriptions.  If you add a sensor, update NUM_SENSORS above! */
> -static struct sensor_template meter_attrs[] = {
> -	RO_SENSOR_TEMPLATE(POWER_AVERAGE_NAME, show_power, 0),
> -	RO_SENSOR_TEMPLATE("power1_accuracy", show_accuracy, 0),
> -	RO_SENSOR_TEMPLATE("power1_average_interval_min", show_val, 0),
> -	RO_SENSOR_TEMPLATE("power1_average_interval_max", show_val, 1),
> -	RO_SENSOR_TEMPLATE("power1_is_battery", show_val, 5),
> -	RW_SENSOR_TEMPLATE(POWER_AVG_INTERVAL_NAME, show_avg_interval,
> -			   set_avg_interval, 0),
> -	{},
> -};
> -
> -static struct sensor_template misc_cap_attrs[] = {
> -	RO_SENSOR_TEMPLATE("power1_cap_min", show_val, 2),
> -	RO_SENSOR_TEMPLATE("power1_cap_max", show_val, 3),
> -	RO_SENSOR_TEMPLATE("power1_cap_hyst", show_val, 4),
> -	RO_SENSOR_TEMPLATE(POWER_ALARM_NAME, show_val, 6),
> -	{},
> -};
> -
> -static struct sensor_template ro_cap_attrs[] = {
> -	RO_SENSOR_TEMPLATE(POWER_CAP_NAME, show_cap, 0),
> -	{},
> -};
> -
> -static struct sensor_template rw_cap_attrs[] = {
> -	RW_SENSOR_TEMPLATE(POWER_CAP_NAME, show_cap, set_cap, 0),
> -	{},
> -};
> -
> -static struct sensor_template trip_attrs[] = {
> -	RW_SENSOR_TEMPLATE("power1_average_min", show_val, set_trip, 7),
> -	RW_SENSOR_TEMPLATE("power1_average_max", show_val, set_trip, 8),
> -	{},
> -};
> -
> -static struct sensor_template misc_attrs[] = {
> -	RO_SENSOR_TEMPLATE("name", show_name, 0),
> -	RO_SENSOR_TEMPLATE("power1_model_number", show_str, 0),
> -	RO_SENSOR_TEMPLATE("power1_oem_info", show_str, 2),
> -	RO_SENSOR_TEMPLATE("power1_serial_number", show_str, 1),
> -	{},
> +static DEVICE_ATTR_RO(power1_is_battery);
> +static DEVICE_ATTR_RO(power1_model_number);
> +static DEVICE_ATTR_RO(power1_oem_info);
> +static DEVICE_ATTR_RO(power1_serial_number);
> +
> +static struct attribute *acpi_power_attrs[] = {
> +	&dev_attr_power1_is_battery.attr,
> +	&dev_attr_power1_model_number.attr,
> +	&dev_attr_power1_oem_info.attr,
> +	&dev_attr_power1_serial_number.attr,
> +	NULL
>  };
>  
> -#undef RO_SENSOR_TEMPLATE
> -#undef RW_SENSOR_TEMPLATE
> +ATTRIBUTE_GROUPS(acpi_power);
>  
>  /* Read power domain data */
>  static void remove_domain_devices(struct acpi_power_meter_resource *resource)
> @@ -621,55 +565,52 @@ static int read_domain_devices(struct acpi_power_meter_resource *resource)
>  	return res;
>  }
>  
> -/* Registration and deregistration */
> -static int register_attrs(struct acpi_power_meter_resource *resource,
> -			  struct sensor_template *attrs)
> -{
> -	struct device *dev = &resource->acpi_dev->dev;
> -	struct sensor_device_attribute *sensors =
> -		&resource->sensors[resource->num_sensors];
> -	int res = 0;
> -
> -	while (attrs->label) {
> -		sensors->dev_attr.attr.name = attrs->label;
> -		sensors->dev_attr.attr.mode = 0444;
> -		sensors->dev_attr.show = attrs->show;
> -		sensors->index = attrs->index;
> -
> -		if (attrs->set) {
> -			sensors->dev_attr.attr.mode |= 0200;
> -			sensors->dev_attr.store = attrs->set;
> -		}
> -
> -		sysfs_attr_init(&sensors->dev_attr.attr);
> -		res = device_create_file(dev, &sensors->dev_attr);
> -		if (res) {
> -			sensors->dev_attr.attr.name = NULL;
> -			goto error;
> -		}
> -		sensors++;
> -		resource->num_sensors++;
> -		attrs++;
> -	}
> -
> -error:
> -	return res;
> -}
> -
> -static void remove_attrs(struct acpi_power_meter_resource *resource)
> +static umode_t acpi_power_is_visible(const void *data,
> +				     enum hwmon_sensor_types type,
> +				     u32 attr, int channel)
>  {
> -	int i;
> +	const struct acpi_power_meter_resource *resource = data;
>  
> -	for (i = 0; i < resource->num_sensors; i++) {
> -		if (!resource->sensors[i].dev_attr.attr.name)
> -			continue;
> -		device_remove_file(&resource->acpi_dev->dev,
> -				   &resource->sensors[i].dev_attr);
> +	switch (attr) {
> +	case hwmon_power_average_min:
> +	case hwmon_power_average_max:
> +		if (resource->caps.flags & POWER_METER_CAN_TRIP)
> +			return 0644;
> +		break;
> +	case hwmon_power_average:
> +	case hwmon_power_accuracy:
> +	case hwmon_power_average_interval_min:
> +	case hwmon_power_average_interval_max:
> +		if (resource->caps.flags & POWER_METER_CAN_MEASURE)
> +			return 0444;
> +		break;
> +	case hwmon_power_average_interval:
> +		if (resource->caps.flags & POWER_METER_CAN_MEASURE)
> +			return 0644;
> +		break;
> +	case hwmon_power_cap:
> +		if (!can_cap_in_hardware())
> +			return 0;
> +		if (!(resource->caps.flags & POWER_METER_CAN_CAP))
> +			return 0;
> +		if (resource->caps.configurable_cap)
> +			return 0644;
> +		return 0444;
> +		break;

Drop "break;" after return.

> +	case hwmon_power_cap_min:
> +	case hwmon_power_cap_max:
> +	case hwmon_power_cap_hyst:
> +	case hwmon_power_cap_alarm:
> +		if (!can_cap_in_hardware())
> +			return 0;
> +		if (resource->caps.flags & POWER_METER_CAN_CAP)
> +			return 0444;

Consistency would be nice: In the above code the condition is negated.

> +		break;
> +	default:
> +		break;
>  	}
>  
> -	remove_domain_devices(resource);
> -
> -	resource->num_sensors = 0;
> +	return 0;
>  }
>  
>  static int setup_attrs(struct acpi_power_meter_resource *resource)
> @@ -680,47 +621,11 @@ static int setup_attrs(struct acpi_power_meter_resource *resource)
>  	if (res)
>  		return res;
>  
> -	if (resource->caps.flags & POWER_METER_CAN_MEASURE) {
> -		res = register_attrs(resource, meter_attrs);
> -		if (res)
> -			goto error;
> +	if (resource->caps.flags & POWER_METER_CAN_CAP && !can_cap_in_hardware()) {
> +		dev_warn(&resource->acpi_dev->dev,
> +			 "Ignoring unsafe software power cap!\n");
>  	}
> -
> -	if (resource->caps.flags & POWER_METER_CAN_CAP) {
> -		if (!can_cap_in_hardware()) {
> -			dev_warn(&resource->acpi_dev->dev,
> -				 "Ignoring unsafe software power cap!\n");
> -			goto skip_unsafe_cap;
> -		}
> -
> -		if (resource->caps.configurable_cap)
> -			res = register_attrs(resource, rw_cap_attrs);
> -		else
> -			res = register_attrs(resource, ro_cap_attrs);
> -
> -		if (res)
> -			goto error;
> -
> -		res = register_attrs(resource, misc_cap_attrs);
> -		if (res)
> -			goto error;
> -	}
> -
> -skip_unsafe_cap:
> -	if (resource->caps.flags & POWER_METER_CAN_TRIP) {
> -		res = register_attrs(resource, trip_attrs);
> -		if (res)
> -			goto error;
> -	}
> -
> -	res = register_attrs(resource, misc_attrs);
> -	if (res)
> -		goto error;
> -
> -	return res;
> -error:
> -	remove_attrs(resource);
> -	return res;
> +	return 0;
>  }
>  
>  static void free_capabilities(struct acpi_power_meter_resource *resource)
> @@ -795,7 +700,6 @@ static int read_capabilities(struct acpi_power_meter_resource *resource)
>  			res = -EINVAL;
>  			goto error;
>  		}
> -
>  		*str = kcalloc(element->string.length + 1, sizeof(u8),
>  			       GFP_KERNEL);
>  		if (!*str) {
> @@ -836,20 +740,20 @@ static void acpi_power_meter_notify(struct acpi_device *device, u32 event)
>  		if (res)
>  			break;
>  
> -		remove_attrs(resource);
> +		remove_domain_devices(resource);
>  		setup_attrs(resource);
>  		break;
>  	case METER_NOTIFY_TRIP:
> -		sysfs_notify(&device->dev.kobj, NULL, POWER_AVERAGE_NAME);
> +		hwmon_notify_event(&device->dev, hwmon_power, hwmon_power_average, 0);
>  		break;
>  	case METER_NOTIFY_CAP:
> -		sysfs_notify(&device->dev.kobj, NULL, POWER_CAP_NAME);
> +		hwmon_notify_event(&device->dev, hwmon_power, hwmon_power_cap, 0);
>  		break;
>  	case METER_NOTIFY_INTERVAL:
> -		sysfs_notify(&device->dev.kobj, NULL, POWER_AVG_INTERVAL_NAME);
> +		hwmon_notify_event(&device->dev, hwmon_power, hwmon_power_average_interval, 0);
>  		break;
>  	case METER_NOTIFY_CAPPING:
> -		sysfs_notify(&device->dev.kobj, NULL, POWER_ALARM_NAME);
> +		hwmon_notify_event(&device->dev, hwmon_power, hwmon_power_alarm, 0);
>  		dev_info(&device->dev, "Capping in progress.\n");
>  		break;
>  	default:
> @@ -861,6 +765,28 @@ static void acpi_power_meter_notify(struct acpi_device *device, u32 event)
>  					dev_name(&device->dev), event, 0);
>  }
>  
> +static const struct hwmon_channel_info *acpi_power_info[] = {
> +	HWMON_CHANNEL_INFO(power,
> +			   HWMON_P_AVERAGE | HWMON_P_AVERAGE_INTERVAL |
> +			   HWMON_P_AVERAGE_MIN | HWMON_P_AVERAGE_MAX |
> +			   HWMON_P_CAP | HWMON_P_CAP_HYST |
> +			   HWMON_P_CAP_MIN | HWMON_P_CAP_MAX |
> +			   HWMON_P_ACCURACY
> +			   ),
> +	NULL,
> +};
> +
> +static const struct hwmon_ops acpi_power_hwmon_ops = {
> +	.is_visible = acpi_power_is_visible,
> +	.read = acpi_power_read,
> +	.write = acpi_power_write,
> +};
> +
> +static const struct hwmon_chip_info acpi_power_chip_info = {
> +	.ops = &acpi_power_hwmon_ops,
> +	.info = acpi_power_info,
> +};
> +
>  static int acpi_power_meter_add(struct acpi_device *device)
>  {
>  	int res;
> @@ -891,7 +817,10 @@ static int acpi_power_meter_add(struct acpi_device *device)
>  	if (res)
>  		goto exit_free_capability;
>  
> -	resource->hwmon_dev = hwmon_device_register(&device->dev);
> +	resource->hwmon_dev = hwmon_device_register_with_info(&device->dev,
> +							      ACPI_POWER_METER_NAME,
> +							      resource, &acpi_power_chip_info,
> +							      acpi_power_groups);
>  	if (IS_ERR(resource->hwmon_dev)) {
>  		res = PTR_ERR(resource->hwmon_dev);
>  		goto exit_remove;
> @@ -901,7 +830,7 @@ static int acpi_power_meter_add(struct acpi_device *device)
>  	goto exit;
>  
>  exit_remove:
> -	remove_attrs(resource);
> +	remove_domain_devices(resource);
>  exit_free_capability:
>  	free_capabilities(resource);
>  exit_free:
> @@ -920,7 +849,7 @@ static int acpi_power_meter_remove(struct acpi_device *device)
>  	resource = acpi_driver_data(device);
>  	hwmon_device_unregister(resource->hwmon_dev);
>  
> -	remove_attrs(resource);
> +	remove_domain_devices(resource);
>  	free_capabilities(resource);
>  
>  	kfree(resource);
