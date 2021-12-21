Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2818E47BFD8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 13:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237707AbhLUMj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 07:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237669AbhLUMj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:39:56 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432B8C061574;
        Tue, 21 Dec 2021 04:39:56 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id m21so24311080edc.0;
        Tue, 21 Dec 2021 04:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PGHTomnoudSBnMwZzQI7q9ra+4K/DkR0i4tdpCjGhhU=;
        b=TL9redEFE4M3KTGl7z0gfGeJ3GuHGGY48qXquQmTXZz+6UPccpyo2PhTmFyQvs74Ae
         bssz1Yyds6Wc8vf+j9YwThVpfSrr+M/CsNOx8w6uUNTcipLfKJZ5fhQcj5CyGuAouLns
         MKz19EmVZQu0Mkk7o7dtoRR22TXBRNRKyCy0iiLecMY3S5KuqmMT78d8K0a7aRPXee51
         ILQeGDb3Q8l6oKiOxcwzv/TYlXopoLoRSr0k8Zomhvzh/dWtBS4ZSIK4NxlWkmDk13DM
         Z+YCnWGPQOlRBDZbORloEo77j+LdJPJ7uSs8qY8IxMhu6bZiI9S1hBVvJ2mPrtYk23Dk
         wNcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PGHTomnoudSBnMwZzQI7q9ra+4K/DkR0i4tdpCjGhhU=;
        b=o37mq/NHUObL63i+7o2leVZj+n15mFEGa78FS3/74CGI3R/6X5m9JPMp0RmcPtzRjL
         R3U9xcVWnPKXqyeh9DMuopt1rM0jSsBqJxEwBrjlwRD6soHtAL5bD7xrtPnVWNTnsxhr
         fD9pa31TV40cCZQhGd7lJ3TC2FIHa/snekAdQqhyYu6NW12C4OB6O8fHH8MyeO1JHRWt
         55/h8vC72zi5YnxTOgsVLRmqPQBUaih5DjnOzAdrHF5UI4t2XQVDUFWeDupB+a6VhfF5
         N/J9r4F0TsA8JXjABugxZ9sBhMWvs34eWloZ2z1VDYJxjnZSWVzOqECLHUJ7YwZkiYIH
         ovIg==
X-Gm-Message-State: AOAM531Rwp6ymoZ2HH8ModYfODj7HvqAsHlNH1yIBXqeTTxWx6qOPVoT
        qWnxBo/34of0q3LMqQTPgkwPYPwIzck=
X-Google-Smtp-Source: ABdhPJyZlf5MKekK91WHsEQH+gMTu7ZvoXySteKyWTeXR3Iis/zvJRFEo6ZqgJM9pUH5ksGspRfo5A==
X-Received: by 2002:a17:906:c111:: with SMTP id do17mr2441150ejc.284.1640090394843;
        Tue, 21 Dec 2021 04:39:54 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.42.157])
        by smtp.gmail.com with ESMTPSA id bx6sm2849438edb.78.2021.12.21.04.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 04:39:54 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 02/10] hwmon: adt7x10: do not create name attr
Date:   Tue, 21 Dec 2021 14:39:36 +0200
Message-Id: <20211221123944.2683245-2-demonsingur@gmail.com>
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

It will later be created automatically by hwmon.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 drivers/hwmon/adt7x10.c | 29 +----------------------------
 1 file changed, 1 insertion(+), 28 deletions(-)

diff --git a/drivers/hwmon/adt7x10.c b/drivers/hwmon/adt7x10.c
index 2439da9b64e6..dbe9f1ad7db0 100644
--- a/drivers/hwmon/adt7x10.c
+++ b/drivers/hwmon/adt7x10.c
@@ -54,7 +54,6 @@
 /* Each client has this additional data */
 struct adt7x10_data {
 	const struct adt7x10_ops *ops;
-	const char		*name;
 	struct device		*hwmon_dev;
 	struct device		*bus_dev;
 	struct mutex		update_lock;
@@ -316,14 +315,6 @@ static ssize_t adt7x10_alarm_show(struct device *dev,
 	return sprintf(buf, "%d\n", !!(ret & attr->index));
 }
 
-static ssize_t name_show(struct device *dev, struct device_attribute *da,
-			 char *buf)
-{
-	struct adt7x10_data *data = dev_get_drvdata(dev);
-
-	return sprintf(buf, "%s\n", data->name);
-}
-
 static SENSOR_DEVICE_ATTR_RO(temp1_input, adt7x10_temp, 0);
 static SENSOR_DEVICE_ATTR_RW(temp1_max, adt7x10_temp, 1);
 static SENSOR_DEVICE_ATTR_RW(temp1_min, adt7x10_temp, 2);
@@ -337,7 +328,6 @@ static SENSOR_DEVICE_ATTR_RO(temp1_max_alarm, adt7x10_alarm,
 			     ADT7X10_STAT_T_HIGH);
 static SENSOR_DEVICE_ATTR_RO(temp1_crit_alarm, adt7x10_alarm,
 			     ADT7X10_STAT_T_CRIT);
-static DEVICE_ATTR_RO(name);
 
 static struct attribute *adt7x10_attributes[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
@@ -368,7 +358,6 @@ int adt7x10_probe(struct device *dev, const char *name, int irq,
 		return -ENOMEM;
 
 	data->ops = ops;
-	data->name = name;
 	data->bus_dev = dev;
 
 	dev_set_drvdata(dev, data);
@@ -406,21 +395,10 @@ int adt7x10_probe(struct device *dev, const char *name, int irq,
 	if (ret)
 		goto exit_restore;
 
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
 	data->hwmon_dev = hwmon_device_register(dev);
 	if (IS_ERR(data->hwmon_dev)) {
 		ret = PTR_ERR(data->hwmon_dev);
-		goto exit_remove_name;
+		goto exit_remove;
 	}
 
 	if (irq > 0) {
@@ -435,9 +413,6 @@ int adt7x10_probe(struct device *dev, const char *name, int irq,
 
 exit_hwmon_device_unregister:
 	hwmon_device_unregister(data->hwmon_dev);
-exit_remove_name:
-	if (name)
-		device_remove_file(dev, &dev_attr_name);
 exit_remove:
 	sysfs_remove_group(&dev->kobj, &adt7x10_group);
 exit_restore:
@@ -454,8 +429,6 @@ void adt7x10_remove(struct device *dev, int irq)
 		free_irq(irq, dev);
 
 	hwmon_device_unregister(data->hwmon_dev);
-	if (data->name)
-		device_remove_file(dev, &dev_attr_name);
 	sysfs_remove_group(&dev->kobj, &adt7x10_group);
 	if (data->oldconfig != data->config)
 		adt7x10_write_byte(dev, ADT7X10_CONFIG, data->oldconfig);
-- 
2.34.1

