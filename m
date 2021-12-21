Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2317047BFE2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 13:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237773AbhLUMkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 07:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237735AbhLUMkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:40:00 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F44C061574;
        Tue, 21 Dec 2021 04:40:00 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id o6so5331990edc.4;
        Tue, 21 Dec 2021 04:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yLI7yyMCR/wZwwErBiG14/ZfDoLMNfHa8Yt+CsPWzTc=;
        b=S1BtZp8Pen+EHSXCAVWQ3WL5JxPyGtEL/tT+DwJPR5tKdiB4G2+xP2Uj69mImKTaFz
         epCeKJUDNuSV7bURwDSoy/u978p7PPd2tRU3LShWLNEcVe2daMLSxcdEZH4lc5hstin2
         PdINhW/N4bKxoMMy+1rqnB4B6NSSSg0VA3dSGjXciw7PUxc1FJ6O33HqBvZDAlwvtebG
         wcxLpuu2VkP81MuC2jmzrkWrv695ICVlJQqqVslaLzC+SwwiqYYPzTxC2MrRy27fvcAz
         XHZYj4LOMc+wWx2KvReL8brXkyErKXB5R9IKAbk/OHoKIqzheRKpPlZI26NIywN5lsH2
         6HGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yLI7yyMCR/wZwwErBiG14/ZfDoLMNfHa8Yt+CsPWzTc=;
        b=N6b3TnEOwdwdqcsXiNTqdt4zD3W0v62R4wRJW2EbhtGxj+0U85JHMlYwn0u/QX3er8
         A0Ldol0ktFoI0yLUtpSMlz6aJwSf8m05Q+ncMpMiBCs3U7Tp/VuSR3Bjn0BPdI2Kof1v
         tgwsDczGpzitnQtRUO47DC6EwAGGWfyR1G4m/vgCeu/0NziUuYItPG1OHzIEv23AbqNb
         jhWNhWN2jOQypwiMt3v67PbGMDk8lj6lr8I1GtRpcVQkXVkkkB2BAPaAw7fxMHYdjomo
         cHWqbeBpOqxpCx7w09XHm+8Ow4L1Hpmpum2J0Kvih+6nko5WX+La0W44tqBq9TYgSHBJ
         19VQ==
X-Gm-Message-State: AOAM532D/xJbKrmoV+m4kARNe2Vme6+WSKJOfoDthwzD/pNEE7Kw2+ot
        qDFKZtXPAg1ioVQaycyMz4E=
X-Google-Smtp-Source: ABdhPJyIazNCi4XVKYVsjXsFeoIBARZIknQOnQALt0b9ZGvgcGnNWay3m5U7/KMhUSOufJk2dpS3iQ==
X-Received: by 2002:a05:6402:3512:: with SMTP id b18mr1969514edd.315.1640090398611;
        Tue, 21 Dec 2021 04:39:58 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.42.157])
        by smtp.gmail.com with ESMTPSA id bx6sm2849438edb.78.2021.12.21.04.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 04:39:58 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 06/10] hwmon: adt7x10: extract read/write methods from show/store
Date:   Tue, 21 Dec 2021 14:39:40 +0200
Message-Id: <20211221123944.2683245-6-demonsingur@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211221123944.2683245-1-demonsingur@gmail.com>
References: <20211221123944.2683245-1-demonsingur@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cosmin Tanislav <cosmin.tanislav@analog.com>

These will later be used by hwmon read and write callbacks.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 drivers/hwmon/adt7x10.c | 128 +++++++++++++++++++++++++++++-----------
 1 file changed, 95 insertions(+), 33 deletions(-)

diff --git a/drivers/hwmon/adt7x10.c b/drivers/hwmon/adt7x10.c
index ec7e526b3441..32ea9438ad64 100644
--- a/drivers/hwmon/adt7x10.c
+++ b/drivers/hwmon/adt7x10.c
@@ -219,14 +219,11 @@ static int ADT7X10_REG_TO_TEMP(struct adt7x10_data *data, s16 reg)
 
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
@@ -234,39 +231,62 @@ static ssize_t adt7x10_temp_show(struct device *dev,
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
+static ssize_t adt7x10_temp_show(struct device *dev,
+				 struct device_attribute *da, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct adt7x10_data *data = dev_get_drvdata(dev);
-	int nr = attr->index;
-	long temp;
+	long val;
 	int ret;
 
-	ret = kstrtol(buf, 10, &temp);
+	ret = adt7x10_temp_read(data, attr->index, &val);
 	if (ret)
 		return ret;
 
+	return sprintf(buf, "%ld\n", val);
+}
+
+static int adt7x10_temp_write(struct adt7x10_data *data, unsigned int nr,
+			      long temp)
+{
+	struct device *dev = data->bus_dev;
+	int ret;
+
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
+static ssize_t adt7x10_temp_store(struct device *dev,
+				  struct device_attribute *da,
+				  const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct adt7x10_data *data = dev_get_drvdata(dev);
 	int nr = attr->index;
+	long temp;
+	int ret;
+
+	ret = kstrtol(buf, 10, &temp);
+	if (ret)
+		return ret;
+
+	ret = adt7x10_temp_write(data, nr, temp);
+
+	return ret ?: count;
+}
+
+static int adt7x10_hyst_read(struct adt7x10_data *data, unsigned int nr,
+			     long *val)
+{
 	int hyst;
 
 	hyst = (data->hyst & ADT7X10_T_HYST_MASK) * 1000;
@@ -277,44 +297,86 @@ static ssize_t adt7x10_t_hyst_show(struct device *dev,
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
+static ssize_t adt7x10_t_hyst_show(struct device *dev,
+				   struct device_attribute *da, char *buf)
 {
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct adt7x10_data *data = dev_get_drvdata(dev);
-	int limit, ret;
-	long hyst;
+	int nr = attr->index;
+	long val;
+	int ret;
 
-	ret = kstrtol(buf, 10, &hyst);
+	ret = adt7x10_hyst_read(data, nr, &val);
 	if (ret)
 		return ret;
+
+	return sprintf(buf, "%ld\n", val);
+}
+
+static int adt7x10_hyst_write(struct adt7x10_data *data, long hyst)
+{
+	struct device *dev = data->bus_dev;
+	int limit;
+
 	/* convert absolute hysteresis value to a 4 bit delta value */
 	limit = ADT7X10_REG_TO_TEMP(data, data->temp[1]);
 	hyst = clamp_val(hyst, ADT7X10_TEMP_MIN, ADT7X10_TEMP_MAX);
 	data->hyst = clamp_val(DIV_ROUND_CLOSEST(limit - hyst, 1000),
-				   0, ADT7X10_T_HYST_MASK);
-	ret = adt7x10_write_byte(dev, ADT7X10_T_HYST, data->hyst);
+			       0, ADT7X10_T_HYST_MASK);
+	return adt7x10_write_byte(dev, ADT7X10_T_HYST, data->hyst);
+}
+
+static ssize_t adt7x10_t_hyst_store(struct device *dev,
+				    struct device_attribute *da,
+				    const char *buf, size_t count)
+{
+	struct adt7x10_data *data = dev_get_drvdata(dev);
+	int ret;
+	long hyst;
+
+	ret = kstrtol(buf, 10, &hyst);
 	if (ret)
 		return ret;
 
-	return count;
+	ret = adt7x10_hyst_write(data, hyst);
+
+	return ret ?: count;
+}
+
+static int adt7x10_alarm_read(struct adt7x10_data *data, unsigned int index,
+			      long *val)
+{
+	struct device *dev = data->bus_dev;
+	int ret;
+
+	ret = adt7x10_read_byte(dev, ADT7X10_STATUS);
+	if (ret < 0)
+		return ret;
+
+	*val = !!(ret & index);
+
+	return 0;
 }
 
 static ssize_t adt7x10_alarm_show(struct device *dev,
 				  struct device_attribute *da, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct adt7x10_data *data = dev_get_drvdata(dev);
+	long val;
 	int ret;
 
-	ret = adt7x10_read_byte(dev, ADT7X10_STATUS);
-	if (ret < 0)
+	ret = adt7x10_alarm_read(data, attr->index, &val);
+	if (ret)
 		return ret;
 
-	return sprintf(buf, "%d\n", !!(ret & attr->index));
+	return sprintf(buf, "%ld\n", val);
 }
 
 static SENSOR_DEVICE_ATTR_RO(temp1_input, adt7x10_temp, 0);
-- 
2.34.1

