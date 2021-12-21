Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5B547C8F9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 22:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237696AbhLUV6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 16:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237509AbhLUV6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 16:58:47 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67083C061574;
        Tue, 21 Dec 2021 13:58:47 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id y22so691001edq.2;
        Tue, 21 Dec 2021 13:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XcqzRM8RDwerLbl1thBtWhW0C+OwpLmUtiB7M+iJjpc=;
        b=lCgL/d+zgS0WG1vCYmBGarUvHd9UhP6jPVURiAnIW0hwGrr85B+XKbfy8FbD3ePeNm
         V1/vpwQdYZKCttktHwxcEDCWyq7RqHlgd9u6g1fpjrptGeAm5+W+sma1vDMYG7gg5qqm
         3Q6WUaocIGrWHuel18TjJWUMWWn2GeDTZbKmPkBZVYKrD7g2u8fd7+POP23U+dRCx0Ma
         LB4uOXdcBY4IXZRZV70LFfeb+cqbsr73fvETk7HcDJLxrEcrBBvDqtd9ulxUXEEHlbMk
         F/kOMH7bbABPDcEA5XGYpgcYuHkrinCHMzMSnWyAz9t6yclrkYpfbEQTa/JUrh7Wzdwg
         CWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XcqzRM8RDwerLbl1thBtWhW0C+OwpLmUtiB7M+iJjpc=;
        b=wVBXGFJ2FRyvCbBbt+j2exljs8Ldx6zQx23vYcJxYJwfl6OKcIy0CJwxBgiKWVYspu
         gbwoQYE0QDomHNuLUjvDyjKIHpUn78EWRK317YFeQz1gNw6y2x0l45A3N8jvHdO/3YTq
         2cvIHi6vblIU+pQkQx7Nsmtskc4OZrojjDzTq/hHFSPfcRYSpmPGgH+z3l0QAUixq5jB
         cY9OC4BD4JPiwijLDqr6IYo8132QypROHqzvonTkRlDXnX5w1pNIsdGzDBz4/j8HfI7g
         uLqupxOCt3zlPriSKam2EZWoQ1EIv7e8Phrypaa18b2OoNFYWeRc2KgPxwSstggwGhYB
         JIqQ==
X-Gm-Message-State: AOAM532feeI0SDno5kKP6wmLAYMT3gpMN40Tv+9URsjVz++koj4Ikc6Z
        yDoCGOO2D8R/nU7FTKgO6s0=
X-Google-Smtp-Source: ABdhPJwPWKxQBE+1oWwuDd+XMOaB9n2YY8RlXX2AqPOpLu4gqoc7j1gG/JEdf9FKLpJnHta0fqAPGQ==
X-Received: by 2002:a17:907:d89:: with SMTP id go9mr205828ejc.417.1640123925987;
        Tue, 21 Dec 2021 13:58:45 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.42.157])
        by smtp.gmail.com with ESMTPSA id nc29sm41640ejc.3.2021.12.21.13.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 13:58:45 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/7] hwmon: (adt7x10) Use devm_hwmon_device_register_with_info
Date:   Tue, 21 Dec 2021 23:58:37 +0200
Message-Id: <20211221215841.2641417-4-demonsingur@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211221215841.2641417-1-demonsingur@gmail.com>
References: <20211221215841.2641417-1-demonsingur@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cosmin Tanislav <cosmin.tanislav@analog.com>

Describe the only available channel, implement read, write
and is_visible callbacks.
Also, pass name to core driver for the i2c device so that
it can be used to register hwmon device.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 drivers/hwmon/adt7410.c |   2 +-
 drivers/hwmon/adt7x10.c | 233 ++++++++++++++++++++--------------------
 2 files changed, 115 insertions(+), 120 deletions(-)

diff --git a/drivers/hwmon/adt7410.c b/drivers/hwmon/adt7410.c
index 973db057427b..ef4b5af865e9 100644
--- a/drivers/hwmon/adt7410.c
+++ b/drivers/hwmon/adt7410.c
@@ -45,7 +45,7 @@ static int adt7410_i2c_probe(struct i2c_client *client)
 			I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA))
 		return -ENODEV;
 
-	return adt7x10_probe(&client->dev, NULL, client->irq, &adt7410_i2c_ops);
+	return adt7x10_probe(&client->dev, client->name, client->irq, &adt7410_i2c_ops);
 }
 
 static int adt7410_i2c_remove(struct i2c_client *client)
diff --git a/drivers/hwmon/adt7x10.c b/drivers/hwmon/adt7x10.c
index e8a6c541a590..2e6e54bf1d15 100644
--- a/drivers/hwmon/adt7x10.c
+++ b/drivers/hwmon/adt7x10.c
@@ -54,8 +54,6 @@
 /* Each client has this additional data */
 struct adt7x10_data {
 	const struct adt7x10_ops *ops;
-	const char		*name;
-	struct device		*hwmon_dev;
 	struct device		*bus_dev;
 	struct mutex		update_lock;
 	u8			config;
@@ -218,14 +216,11 @@ static int ADT7X10_REG_TO_TEMP(struct adt7x10_data *data, s16 reg)
 
 /* sysfs attributes for hwmon */
 
-static ssize_t adt7x10_temp_show(struct device *dev,
-				 struct device_attribute *da, char *buf)
+static int adt7x10_temp_read(struct adt7x10_data *data, int index, long *val)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
-	struct adt7x10_data *data = dev_get_drvdata(dev);
-
+	struct device *dev = data->bus_dev;
 
-	if (attr->index == 0) {
+	if (index == 0) {
 		int ret;
 
 		ret = adt7x10_update_temp(dev);
@@ -233,39 +228,28 @@ static ssize_t adt7x10_temp_show(struct device *dev,
 			return ret;
 	}
 
-	return sprintf(buf, "%d\n", ADT7X10_REG_TO_TEMP(data,
-		       data->temp[attr->index]));
+	*val = ADT7X10_REG_TO_TEMP(data, data->temp[index]);
+
+	return 0;
 }
 
-static ssize_t adt7x10_temp_store(struct device *dev,
-				  struct device_attribute *da,
-				  const char *buf, size_t count)
+static int adt7x10_temp_write(struct adt7x10_data *data, unsigned int nr,
+			      long temp)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
-	struct adt7x10_data *data = dev_get_drvdata(dev);
-	int nr = attr->index;
-	long temp;
+	struct device *dev = data->bus_dev;
 	int ret;
 
-	ret = kstrtol(buf, 10, &temp);
-	if (ret)
-		return ret;
-
 	mutex_lock(&data->update_lock);
 	data->temp[nr] = ADT7X10_TEMP_TO_REG(temp);
 	ret = adt7x10_write_word(dev, ADT7X10_REG_TEMP[nr], data->temp[nr]);
-	if (ret)
-		count = ret;
 	mutex_unlock(&data->update_lock);
-	return count;
+
+	return ret;
 }
 
-static ssize_t adt7x10_t_hyst_show(struct device *dev,
-				   struct device_attribute *da, char *buf)
+static int adt7x10_hyst_read(struct adt7x10_data *data, unsigned int nr,
+			     long *val)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
-	struct adt7x10_data *data = dev_get_drvdata(dev);
-	int nr = attr->index;
 	int hyst;
 
 	hyst = (data->hyst & ADT7X10_T_HYST_MASK) * 1000;
@@ -276,85 +260,127 @@ static ssize_t adt7x10_t_hyst_show(struct device *dev,
 	 */
 	if (nr == 2)	/* min has positive offset, others have negative */
 		hyst = -hyst;
-	return sprintf(buf, "%d\n",
-		       ADT7X10_REG_TO_TEMP(data, data->temp[nr]) - hyst);
+
+	*val = ADT7X10_REG_TO_TEMP(data, data->temp[nr]) - hyst;
+
+	return 0;
 }
 
-static ssize_t adt7x10_t_hyst_store(struct device *dev,
-				    struct device_attribute *da,
-				    const char *buf, size_t count)
+static int adt7x10_hyst_write(struct adt7x10_data *data, long hyst)
 {
-	struct adt7x10_data *data = dev_get_drvdata(dev);
-	int limit, ret;
-	long hyst;
+	struct device *dev = data->bus_dev;
+	int limit;
 
-	ret = kstrtol(buf, 10, &hyst);
-	if (ret)
-		return ret;
 	/* convert absolute hysteresis value to a 4 bit delta value */
 	limit = ADT7X10_REG_TO_TEMP(data, data->temp[1]);
 	hyst = clamp_val(hyst, ADT7X10_TEMP_MIN, ADT7X10_TEMP_MAX);
 	data->hyst = clamp_val(DIV_ROUND_CLOSEST(limit - hyst, 1000),
-				   0, ADT7X10_T_HYST_MASK);
-	ret = adt7x10_write_byte(dev, ADT7X10_T_HYST, data->hyst);
-	if (ret)
-		return ret;
-
-	return count;
+			       0, ADT7X10_T_HYST_MASK);
+	return adt7x10_write_byte(dev, ADT7X10_T_HYST, data->hyst);
 }
 
-static ssize_t adt7x10_alarm_show(struct device *dev,
-				  struct device_attribute *da, char *buf)
+static int adt7x10_alarm_read(struct adt7x10_data *data, unsigned int index,
+			      long *val)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct device *dev = data->bus_dev;
 	int ret;
 
 	ret = adt7x10_read_byte(dev, ADT7X10_STATUS);
 	if (ret < 0)
 		return ret;
 
-	return sprintf(buf, "%d\n", !!(ret & attr->index));
+	*val = !!(ret & index);
+
+	return 0;
+}
+
+static umode_t adt7x10_is_visible(const void *data,
+				  enum hwmon_sensor_types type,
+				  u32 attr, int channel)
+{
+	umode_t mode = 0444;
+
+	switch (attr) {
+	case hwmon_temp_max:
+	case hwmon_temp_min:
+	case hwmon_temp_crit:
+	case hwmon_temp_max_hyst:
+		mode |= 0200;
+		break;
+	default:
+		break;
+	}
+
+	return mode;
+}
+
+static int adt7x10_read(struct device *dev, enum hwmon_sensor_types type,
+			u32 attr, int channel, long *val)
+{
+	struct adt7x10_data *data = dev_get_drvdata(dev);
+
+	switch (attr) {
+	case hwmon_temp_input:
+		return adt7x10_temp_read(data, 0, val);
+	case hwmon_temp_max:
+		return adt7x10_temp_read(data, 1, val);
+	case hwmon_temp_min:
+		return adt7x10_temp_read(data, 2, val);
+	case hwmon_temp_crit:
+		return adt7x10_temp_read(data, 3, val);
+	case hwmon_temp_max_hyst:
+		return adt7x10_hyst_read(data, 1, val);
+	case hwmon_temp_min_hyst:
+		return adt7x10_hyst_read(data, 2, val);
+	case hwmon_temp_crit_hyst:
+		return adt7x10_hyst_read(data, 3, val);
+	case hwmon_temp_min_alarm:
+		return adt7x10_alarm_read(data, ADT7X10_STAT_T_LOW, val);
+	case hwmon_temp_max_alarm:
+		return adt7x10_alarm_read(data, ADT7X10_STAT_T_HIGH, val);
+	case hwmon_temp_crit_alarm:
+		return adt7x10_alarm_read(data, ADT7X10_STAT_T_CRIT, val);
+	default:
+		return -EOPNOTSUPP;
+	}
 }
 
-static ssize_t name_show(struct device *dev, struct device_attribute *da,
-			 char *buf)
+static int adt7x10_write(struct device *dev, enum hwmon_sensor_types type,
+			 u32 attr, int channel, long val)
 {
 	struct adt7x10_data *data = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%s\n", data->name);
+	switch (attr) {
+	case hwmon_temp_max:
+		return adt7x10_temp_write(data, 1, val);
+	case hwmon_temp_min:
+		return adt7x10_temp_write(data, 2, val);
+	case hwmon_temp_crit:
+		return adt7x10_temp_write(data, 3, val);
+	case hwmon_temp_max_hyst:
+		return adt7x10_hyst_write(data, val);
+	default:
+		return -EOPNOTSUPP;
+	}
 }
 
-static SENSOR_DEVICE_ATTR_RO(temp1_input, adt7x10_temp, 0);
-static SENSOR_DEVICE_ATTR_RW(temp1_max, adt7x10_temp, 1);
-static SENSOR_DEVICE_ATTR_RW(temp1_min, adt7x10_temp, 2);
-static SENSOR_DEVICE_ATTR_RW(temp1_crit, adt7x10_temp, 3);
-static SENSOR_DEVICE_ATTR_RW(temp1_max_hyst, adt7x10_t_hyst, 1);
-static SENSOR_DEVICE_ATTR_RO(temp1_min_hyst, adt7x10_t_hyst, 2);
-static SENSOR_DEVICE_ATTR_RO(temp1_crit_hyst, adt7x10_t_hyst, 3);
-static SENSOR_DEVICE_ATTR_RO(temp1_min_alarm, adt7x10_alarm,
-			     ADT7X10_STAT_T_LOW);
-static SENSOR_DEVICE_ATTR_RO(temp1_max_alarm, adt7x10_alarm,
-			     ADT7X10_STAT_T_HIGH);
-static SENSOR_DEVICE_ATTR_RO(temp1_crit_alarm, adt7x10_alarm,
-			     ADT7X10_STAT_T_CRIT);
-static DEVICE_ATTR_RO(name);
-
-static struct attribute *adt7x10_attributes[] = {
-	&sensor_dev_attr_temp1_input.dev_attr.attr,
-	&sensor_dev_attr_temp1_max.dev_attr.attr,
-	&sensor_dev_attr_temp1_min.dev_attr.attr,
-	&sensor_dev_attr_temp1_crit.dev_attr.attr,
-	&sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
-	&sensor_dev_attr_temp1_min_hyst.dev_attr.attr,
-	&sensor_dev_attr_temp1_crit_hyst.dev_attr.attr,
-	&sensor_dev_attr_temp1_min_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp1_crit_alarm.dev_attr.attr,
-	NULL
+static const struct hwmon_channel_info *adt7x10_info[] = {
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MIN |
+			   HWMON_T_CRIT | HWMON_T_MAX_HYST | HWMON_T_MIN_HYST |
+			   HWMON_T_CRIT_HYST | HWMON_T_MIN_ALARM |
+			   HWMON_T_MAX_ALARM | HWMON_T_CRIT_ALARM),
+	NULL,
+};
+
+static const struct hwmon_ops adt7x10_hwmon_ops = {
+	.is_visible = adt7x10_is_visible,
+	.read = adt7x10_read,
+	.write = adt7x10_write,
 };
 
-static const struct attribute_group adt7x10_group = {
-	.attrs = adt7x10_attributes,
+static const struct hwmon_chip_info adt7x10_chip_info = {
+	.ops = &adt7x10_hwmon_ops,
+	.info = adt7x10_info,
 };
 
 static void adt7x10_restore_config(void *private)
@@ -372,6 +398,7 @@ int adt7x10_probe(struct device *dev, const char *name, int irq,
 		  const struct adt7x10_ops *ops)
 {
 	struct adt7x10_data *data;
+	struct device *hdev;
 	int ret;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
@@ -379,7 +406,6 @@ int adt7x10_probe(struct device *dev, const char *name, int irq,
 		return -ENOMEM;
 
 	data->ops = ops;
-	data->name = name;
 	data->bus_dev = dev;
 
 	dev_set_drvdata(dev, data);
@@ -416,26 +442,11 @@ int adt7x10_probe(struct device *dev, const char *name, int irq,
 	if (ret)
 		return ret;
 
-	/* Register sysfs hooks */
-	ret = sysfs_create_group(&dev->kobj, &adt7x10_group);
-	if (ret)
+	hdev = devm_hwmon_device_register_with_info(dev, name, data,
+						    &adt7x10_chip_info, NULL);
+	if (IS_ERR(hdev)) {
+		ret = PTR_ERR(hdev);
 		return ret;
-
-	/*
-	 * The I2C device will already have it's own 'name' attribute, but for
-	 * the SPI device we need to register it. name will only be non NULL if
-	 * the device doesn't register the 'name' attribute on its own.
-	 */
-	if (name) {
-		ret = device_create_file(dev, &dev_attr_name);
-		if (ret)
-			goto exit_remove;
-	}
-
-	data->hwmon_dev = hwmon_device_register(dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		ret = PTR_ERR(data->hwmon_dev);
-		goto exit_remove_name;
 	}
 
 	if (irq > 0) {
@@ -443,33 +454,17 @@ int adt7x10_probe(struct device *dev, const char *name, int irq,
 				IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 				dev_name(dev), dev);
 		if (ret)
-			goto exit_hwmon_device_unregister;
+			return ret;
 	}
 
 	return 0;
-
-exit_hwmon_device_unregister:
-	hwmon_device_unregister(data->hwmon_dev);
-exit_remove_name:
-	if (name)
-		device_remove_file(dev, &dev_attr_name);
-exit_remove:
-	sysfs_remove_group(&dev->kobj, &adt7x10_group);
-	return ret;
 }
 EXPORT_SYMBOL_GPL(adt7x10_probe);
 
 void adt7x10_remove(struct device *dev, int irq)
 {
-	struct adt7x10_data *data = dev_get_drvdata(dev);
-
 	if (irq > 0)
 		free_irq(irq, dev);
-
-	hwmon_device_unregister(data->hwmon_dev);
-	if (data->name)
-		device_remove_file(dev, &dev_attr_name);
-	sysfs_remove_group(&dev->kobj, &adt7x10_group);
 }
 EXPORT_SYMBOL_GPL(adt7x10_remove);
 
-- 
2.34.1

