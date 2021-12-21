Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2958C47C901
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 22:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237578AbhLUV73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 16:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237338AbhLUV72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 16:59:28 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6577BC061574;
        Tue, 21 Dec 2021 13:59:28 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id x19-20020a9d7053000000b0055c8b39420bso259105otj.1;
        Tue, 21 Dec 2021 13:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+s9gN9a3cS8GIHuHot1HzHGsPrkfm1XzcE/CGcEUDAM=;
        b=UpcPvGQRBpiTugx9py96Gr+e39jzddhvQU5oZpTonYoWMTzpIsZF7GpmBChRMw/LTq
         5dy7nqUJmuPX7kgozt+allXwpFP9moTNVMWfpXkI0lsYk2l6+lC64kon/xic5gEBGYMJ
         VRPVLl5ju6WMQed0/3+oRzotRua1oyElLJwUXzF/8DcUuDJJdHIL37sN/qk9c32E1duY
         wQcN7hOB1wlVhYD/I5OBOPUyLZg7//z8eO7XkUGQ4lq5Qv5sy4lyx9zsUWVkuOW4hy1A
         ROWBK7WwJ/A7qocDikHzMMAbwuwk1ROfd3k5sCjUwGoyXIvQSgfOlnPfRb3gX4SrUE0x
         WatQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+s9gN9a3cS8GIHuHot1HzHGsPrkfm1XzcE/CGcEUDAM=;
        b=NDt2YMk0iD90egfxGOK5eFuW4xrBSr0EFOPyFxm7EtYSyOqXse9W9pD8OnMv9AdoEq
         ZKX/DerBHZiZXyUtRuUn9weuWhuq1KEMHT8Ed0JCeocZ0cYISK77DJOnuIu56g/I9qFW
         BLCP0aObVVD4cQBqwHzxXTLV+qrqZHyrAGjY21Op9XvsWXVYjHm1O7/06MMixEeq2CuY
         wPG50sSqb1T1zETNfcr2CH362pCPRH3fqsp7tVuXtCoAuwrcfJipVKcweikdD5P1Zq4Q
         LHBno+b9pYLTyjPZ1I4kB7hUpKK3Tf9cpDUH/LTSWRrrM0v4TmKuXxHoMXur31AGj3AI
         9Q6g==
X-Gm-Message-State: AOAM533svQZpGsslrw0+L76jr4xtU3Gq3qFal2UbUY6X89eiGtwhv9Op
        eUgQNj6DOBYGakA0FkCkZlQ+vTFKg+4=
X-Google-Smtp-Source: ABdhPJwWFB/rhNOHMYzZ+wQq7eXJ8PzdQc7pgPOMVKrAX+j05IsetrhWEIo6CKk0ymJk1G3SwP7mVA==
X-Received: by 2002:a9d:2648:: with SMTP id a66mr209168otb.65.1640123967423;
        Tue, 21 Dec 2021 13:59:27 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q14sm46109ood.28.2021.12.21.13.59.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 13:59:26 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211221210438.2637430-1-demonsingur@gmail.com>
 <20211221210438.2637430-5-demonsingur@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 4/8] hwmon: (adt7x10) Use
 devm_hwmon_device_register_with_info
Message-ID: <22eda521-1a53-44c9-18de-90de5ebb6492@roeck-us.net>
Date:   Tue, 21 Dec 2021 13:59:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211221210438.2637430-5-demonsingur@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/21 1:04 PM, Cosmin Tanislav wrote:
> From: Cosmin Tanislav <cosmin.tanislav@analog.com>
> 
> Describe the only available channel, implement read, write
> and is_visible callbacks.
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> ---
>   drivers/hwmon/adt7x10.c | 233 ++++++++++++++++++++--------------------
>   1 file changed, 114 insertions(+), 119 deletions(-)
> 
> diff --git a/drivers/hwmon/adt7x10.c b/drivers/hwmon/adt7x10.c
> index e8a6c541a590..2e6e54bf1d15 100644
> --- a/drivers/hwmon/adt7x10.c
> +++ b/drivers/hwmon/adt7x10.c
> @@ -54,8 +54,6 @@
>   /* Each client has this additional data */
>   struct adt7x10_data {
>   	const struct adt7x10_ops *ops;
> -	const char		*name;
> -	struct device		*hwmon_dev;
>   	struct device		*bus_dev;
>   	struct mutex		update_lock;
>   	u8			config;
> @@ -218,14 +216,11 @@ static int ADT7X10_REG_TO_TEMP(struct adt7x10_data *data, s16 reg)
>   
>   /* sysfs attributes for hwmon */
>   
> -static ssize_t adt7x10_temp_show(struct device *dev,
> -				 struct device_attribute *da, char *buf)
> +static int adt7x10_temp_read(struct adt7x10_data *data, int index, long *val)
>   {
> -	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
> -	struct adt7x10_data *data = dev_get_drvdata(dev);
> -
> +	struct device *dev = data->bus_dev;
>   
> -	if (attr->index == 0) {
> +	if (index == 0) {

Using "index" here is just confusing and has little value. The calling code
can just assign values directly instead, ie

	case hwmon_input:
		ret = adt7x10_update_temp(dev);
		if (ret)
			return ret;
		*val = ADT7X10_REG_TO_TEMP(data, data->temp[0]);
		return 0;
	case hwmon_temp_max:
		*val = ADT7X10_REG_TO_TEMP(data, data->temp[1]);
		return 0;
	...


If you really want to keep using index values, please define constants.
Code such as "index == 0" or, below "nr == 2" is error prone.


>   		int ret;
>   
>   		ret = adt7x10_update_temp(dev);
> @@ -233,39 +228,28 @@ static ssize_t adt7x10_temp_show(struct device *dev,
>   			return ret;
>   	}
>   
> -	return sprintf(buf, "%d\n", ADT7X10_REG_TO_TEMP(data,
> -		       data->temp[attr->index]));
> +	*val = ADT7X10_REG_TO_TEMP(data, data->temp[index]);
> +
> +	return 0;
>   }
>   
> -static ssize_t adt7x10_temp_store(struct device *dev,
> -				  struct device_attribute *da,
> -				  const char *buf, size_t count)
> +static int adt7x10_temp_write(struct adt7x10_data *data, unsigned int nr,
> +			      long temp)
>   {
> -	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
> -	struct adt7x10_data *data = dev_get_drvdata(dev);
> -	int nr = attr->index;
> -	long temp;
> +	struct device *dev = data->bus_dev;
>   	int ret;
>   
> -	ret = kstrtol(buf, 10, &temp);
> -	if (ret)
> -		return ret;
> -
>   	mutex_lock(&data->update_lock);
>   	data->temp[nr] = ADT7X10_TEMP_TO_REG(temp);
>   	ret = adt7x10_write_word(dev, ADT7X10_REG_TEMP[nr], data->temp[nr]);
> -	if (ret)
> -		count = ret;
>   	mutex_unlock(&data->update_lock);
> -	return count;
> +
> +	return ret;
>   }
>   
> -static ssize_t adt7x10_t_hyst_show(struct device *dev,
> -				   struct device_attribute *da, char *buf)
> +static int adt7x10_hyst_read(struct adt7x10_data *data, unsigned int nr,
> +			     long *val)
>   {
> -	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
> -	struct adt7x10_data *data = dev_get_drvdata(dev);
> -	int nr = attr->index;
>   	int hyst;
>   
>   	hyst = (data->hyst & ADT7X10_T_HYST_MASK) * 1000;
> @@ -276,85 +260,127 @@ static ssize_t adt7x10_t_hyst_show(struct device *dev,
>   	 */
>   	if (nr == 2)	/* min has positive offset, others have negative */
>   		hyst = -hyst;
> -	return sprintf(buf, "%d\n",
> -		       ADT7X10_REG_TO_TEMP(data, data->temp[nr]) - hyst);
> +
> +	*val = ADT7X10_REG_TO_TEMP(data, data->temp[nr]) - hyst;
> +
> +	return 0;
>   }
>   
> -static ssize_t adt7x10_t_hyst_store(struct device *dev,
> -				    struct device_attribute *da,
> -				    const char *buf, size_t count)
> +static int adt7x10_hyst_write(struct adt7x10_data *data, long hyst)
>   {
> -	struct adt7x10_data *data = dev_get_drvdata(dev);
> -	int limit, ret;
> -	long hyst;
> +	struct device *dev = data->bus_dev;
> +	int limit;
>   
> -	ret = kstrtol(buf, 10, &hyst);
> -	if (ret)
> -		return ret;
>   	/* convert absolute hysteresis value to a 4 bit delta value */
>   	limit = ADT7X10_REG_TO_TEMP(data, data->temp[1]);
>   	hyst = clamp_val(hyst, ADT7X10_TEMP_MIN, ADT7X10_TEMP_MAX);
>   	data->hyst = clamp_val(DIV_ROUND_CLOSEST(limit - hyst, 1000),
> -				   0, ADT7X10_T_HYST_MASK);
> -	ret = adt7x10_write_byte(dev, ADT7X10_T_HYST, data->hyst);
> -	if (ret)
> -		return ret;
> -
> -	return count;
> +			       0, ADT7X10_T_HYST_MASK);
> +	return adt7x10_write_byte(dev, ADT7X10_T_HYST, data->hyst);
>   }
>   
> -static ssize_t adt7x10_alarm_show(struct device *dev,
> -				  struct device_attribute *da, char *buf)
> +static int adt7x10_alarm_read(struct adt7x10_data *data, unsigned int index,
> +			      long *val)
>   {
> -	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
> +	struct device *dev = data->bus_dev;
>   	int ret;
>   
>   	ret = adt7x10_read_byte(dev, ADT7X10_STATUS);
>   	if (ret < 0)
>   		return ret;
>   
> -	return sprintf(buf, "%d\n", !!(ret & attr->index));
> +	*val = !!(ret & index);
> +
> +	return 0;
> +}
> +
> +static umode_t adt7x10_is_visible(const void *data,
> +				  enum hwmon_sensor_types type,
> +				  u32 attr, int channel)
> +{
> +	umode_t mode = 0444;
> +
> +	switch (attr) {
> +	case hwmon_temp_max:
> +	case hwmon_temp_min:
> +	case hwmon_temp_crit:
> +	case hwmon_temp_max_hyst:
> +		mode |= 0200;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return mode;
> +}
> +
> +static int adt7x10_read(struct device *dev, enum hwmon_sensor_types type,
> +			u32 attr, int channel, long *val)
> +{
> +	struct adt7x10_data *data = dev_get_drvdata(dev);
> +
> +	switch (attr) {
> +	case hwmon_temp_input:
> +		return adt7x10_temp_read(data, 0, val);
> +	case hwmon_temp_max:
> +		return adt7x10_temp_read(data, 1, val);
> +	case hwmon_temp_min:
> +		return adt7x10_temp_read(data, 2, val);
> +	case hwmon_temp_crit:
> +		return adt7x10_temp_read(data, 3, val);
> +	case hwmon_temp_max_hyst:
> +		return adt7x10_hyst_read(data, 1, val);
> +	case hwmon_temp_min_hyst:
> +		return adt7x10_hyst_read(data, 2, val);
> +	case hwmon_temp_crit_hyst:
> +		return adt7x10_hyst_read(data, 3, val);
> +	case hwmon_temp_min_alarm:
> +		return adt7x10_alarm_read(data, ADT7X10_STAT_T_LOW, val);
> +	case hwmon_temp_max_alarm:
> +		return adt7x10_alarm_read(data, ADT7X10_STAT_T_HIGH, val);
> +	case hwmon_temp_crit_alarm:
> +		return adt7x10_alarm_read(data, ADT7X10_STAT_T_CRIT, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
>   }
>   
> -static ssize_t name_show(struct device *dev, struct device_attribute *da,
> -			 char *buf)
> +static int adt7x10_write(struct device *dev, enum hwmon_sensor_types type,
> +			 u32 attr, int channel, long val)
>   {
>   	struct adt7x10_data *data = dev_get_drvdata(dev);
>   
> -	return sprintf(buf, "%s\n", data->name);
> +	switch (attr) {
> +	case hwmon_temp_max:
> +		return adt7x10_temp_write(data, 1, val);
> +	case hwmon_temp_min:
> +		return adt7x10_temp_write(data, 2, val);
> +	case hwmon_temp_crit:
> +		return adt7x10_temp_write(data, 3, val);
> +	case hwmon_temp_max_hyst:
> +		return adt7x10_hyst_write(data, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
>   }
>   
> -static SENSOR_DEVICE_ATTR_RO(temp1_input, adt7x10_temp, 0);
> -static SENSOR_DEVICE_ATTR_RW(temp1_max, adt7x10_temp, 1);
> -static SENSOR_DEVICE_ATTR_RW(temp1_min, adt7x10_temp, 2);
> -static SENSOR_DEVICE_ATTR_RW(temp1_crit, adt7x10_temp, 3);
> -static SENSOR_DEVICE_ATTR_RW(temp1_max_hyst, adt7x10_t_hyst, 1);
> -static SENSOR_DEVICE_ATTR_RO(temp1_min_hyst, adt7x10_t_hyst, 2);
> -static SENSOR_DEVICE_ATTR_RO(temp1_crit_hyst, adt7x10_t_hyst, 3);
> -static SENSOR_DEVICE_ATTR_RO(temp1_min_alarm, adt7x10_alarm,
> -			     ADT7X10_STAT_T_LOW);
> -static SENSOR_DEVICE_ATTR_RO(temp1_max_alarm, adt7x10_alarm,
> -			     ADT7X10_STAT_T_HIGH);
> -static SENSOR_DEVICE_ATTR_RO(temp1_crit_alarm, adt7x10_alarm,
> -			     ADT7X10_STAT_T_CRIT);
> -static DEVICE_ATTR_RO(name);
> -
> -static struct attribute *adt7x10_attributes[] = {
> -	&sensor_dev_attr_temp1_input.dev_attr.attr,
> -	&sensor_dev_attr_temp1_max.dev_attr.attr,
> -	&sensor_dev_attr_temp1_min.dev_attr.attr,
> -	&sensor_dev_attr_temp1_crit.dev_attr.attr,
> -	&sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
> -	&sensor_dev_attr_temp1_min_hyst.dev_attr.attr,
> -	&sensor_dev_attr_temp1_crit_hyst.dev_attr.attr,
> -	&sensor_dev_attr_temp1_min_alarm.dev_attr.attr,
> -	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
> -	&sensor_dev_attr_temp1_crit_alarm.dev_attr.attr,
> -	NULL
> +static const struct hwmon_channel_info *adt7x10_info[] = {
> +	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MIN |
> +			   HWMON_T_CRIT | HWMON_T_MAX_HYST | HWMON_T_MIN_HYST |
> +			   HWMON_T_CRIT_HYST | HWMON_T_MIN_ALARM |
> +			   HWMON_T_MAX_ALARM | HWMON_T_CRIT_ALARM),
> +	NULL,
> +};
> +
> +static const struct hwmon_ops adt7x10_hwmon_ops = {
> +	.is_visible = adt7x10_is_visible,
> +	.read = adt7x10_read,
> +	.write = adt7x10_write,
>   };
>   
> -static const struct attribute_group adt7x10_group = {
> -	.attrs = adt7x10_attributes,
> +static const struct hwmon_chip_info adt7x10_chip_info = {
> +	.ops = &adt7x10_hwmon_ops,
> +	.info = adt7x10_info,
>   };
>   
>   static void adt7x10_restore_config(void *private)
> @@ -372,6 +398,7 @@ int adt7x10_probe(struct device *dev, const char *name, int irq,
>   		  const struct adt7x10_ops *ops)
>   {
>   	struct adt7x10_data *data;
> +	struct device *hdev;
>   	int ret;
>   
>   	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> @@ -379,7 +406,6 @@ int adt7x10_probe(struct device *dev, const char *name, int irq,
>   		return -ENOMEM;
>   
>   	data->ops = ops;
> -	data->name = name;
>   	data->bus_dev = dev;
>   
>   	dev_set_drvdata(dev, data);
> @@ -416,26 +442,11 @@ int adt7x10_probe(struct device *dev, const char *name, int irq,
>   	if (ret)
>   		return ret;
>   
> -	/* Register sysfs hooks */
> -	ret = sysfs_create_group(&dev->kobj, &adt7x10_group);
> -	if (ret)
> +	hdev = devm_hwmon_device_register_with_info(dev, name, data,
> +						    &adt7x10_chip_info, NULL);
> +	if (IS_ERR(hdev)) {
> +		ret = PTR_ERR(hdev);
>   		return ret;
> -
> -	/*
> -	 * The I2C device will already have it's own 'name' attribute, but for
> -	 * the SPI device we need to register it. name will only be non NULL if
> -	 * the device doesn't register the 'name' attribute on its own.
> -	 */
> -	if (name) {
> -		ret = device_create_file(dev, &dev_attr_name);
> -		if (ret)
> -			goto exit_remove;
> -	}
> -
> -	data->hwmon_dev = hwmon_device_register(dev);
> -	if (IS_ERR(data->hwmon_dev)) {
> -		ret = PTR_ERR(data->hwmon_dev);
> -		goto exit_remove_name;
>   	}
>   
>   	if (irq > 0) {
> @@ -443,33 +454,17 @@ int adt7x10_probe(struct device *dev, const char *name, int irq,
>   				IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>   				dev_name(dev), dev);
>   		if (ret)
> -			goto exit_hwmon_device_unregister;
> +			return ret;
>   	}
>   
>   	return 0;
> -
> -exit_hwmon_device_unregister:
> -	hwmon_device_unregister(data->hwmon_dev);
> -exit_remove_name:
> -	if (name)
> -		device_remove_file(dev, &dev_attr_name);
> -exit_remove:
> -	sysfs_remove_group(&dev->kobj, &adt7x10_group);
> -	return ret;
>   }
>   EXPORT_SYMBOL_GPL(adt7x10_probe);
>   
>   void adt7x10_remove(struct device *dev, int irq)
>   {
> -	struct adt7x10_data *data = dev_get_drvdata(dev);
> -
>   	if (irq > 0)
>   		free_irq(irq, dev);
> -
> -	hwmon_device_unregister(data->hwmon_dev);
> -	if (data->name)
> -		device_remove_file(dev, &dev_attr_name);
> -	sysfs_remove_group(&dev->kobj, &adt7x10_group);
>   }
>   EXPORT_SYMBOL_GPL(adt7x10_remove);
>   
> 

