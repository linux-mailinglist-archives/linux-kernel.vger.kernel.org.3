Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4279F4674FD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 11:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351532AbhLCKeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 05:34:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:59980 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230361AbhLCKeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 05:34:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638527441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RtiW06aHTebE8dAV+W6N5fHoiNQl/oXsrb5+wcdvs0o=;
        b=hItKXZffkOFQMjT2nZdkJNIbbTgYIE32OTXhzvbQSAhbNWHDondV8jtTMxpzUYoPaAfxCh
        6z9RWX1E7HEXVD35GmPMtfwpZuTbqSS9ss52mssFyrYb3uQyVJLIG83yK3uk+sc6o+Y68i
        r7cGF5f0rG303MY3t8/+NRHboPuEjdI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-163-HMcyfkCLM42setRkbLI2aA-1; Fri, 03 Dec 2021 05:30:38 -0500
X-MC-Unique: HMcyfkCLM42setRkbLI2aA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0497681CCBB;
        Fri,  3 Dec 2021 10:30:35 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.194.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0A9F060843;
        Fri,  3 Dec 2021 10:30:15 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Kate Hsuan <hpa@redhat.com>, linux-media@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v7 08/14] platform/x86: int3472: Add get_sensor_adev_and_name() helper
Date:   Fri,  3 Dec 2021 11:28:51 +0100
Message-Id: <20211203102857.44539-9-hdegoede@redhat.com>
In-Reply-To: <20211203102857.44539-1-hdegoede@redhat.com>
References: <20211203102857.44539-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The discrete.c code is not the only code which needs to lookup the
acpi_device and device-name for the sensor for which the INT3472
ACPI-device is a GPIO/clk/regulator provider.

The tps68470.c code also needs this functionality, so factor this
out into a new get_sensor_adev_and_name() helper.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/intel/int3472/common.c   | 28 +++++++++++++++++++
 drivers/platform/x86/intel/int3472/common.h   |  3 ++
 drivers/platform/x86/intel/int3472/discrete.c | 22 +++------------
 3 files changed, 35 insertions(+), 18 deletions(-)

diff --git a/drivers/platform/x86/intel/int3472/common.c b/drivers/platform/x86/intel/int3472/common.c
index 350655a9515b..77cf058e4168 100644
--- a/drivers/platform/x86/intel/int3472/common.c
+++ b/drivers/platform/x86/intel/int3472/common.c
@@ -52,3 +52,31 @@ int skl_int3472_fill_cldb(struct acpi_device *adev, struct int3472_cldb *cldb)
 	kfree(obj);
 	return ret;
 }
+
+/* sensor_adev_ret may be NULL, name_ret must not be NULL */
+int skl_int3472_get_sensor_adev_and_name(struct device *dev,
+					 struct acpi_device **sensor_adev_ret,
+					 const char **name_ret)
+{
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	struct acpi_device *sensor;
+	int ret = 0;
+
+	sensor = acpi_dev_get_first_consumer_dev(adev);
+	if (!sensor) {
+		dev_err(dev, "INT3472 seems to have no dependents.\n");
+		return -ENODEV;
+	}
+
+	*name_ret = devm_kasprintf(dev, GFP_KERNEL, I2C_DEV_NAME_FORMAT,
+				   acpi_dev_name(sensor));
+	if (!*name_ret)
+		ret = -ENOMEM;
+
+	if (ret == 0 && sensor_adev_ret)
+		*sensor_adev_ret = sensor;
+	else
+		acpi_dev_put(sensor);
+
+	return ret;
+}
diff --git a/drivers/platform/x86/intel/int3472/common.h b/drivers/platform/x86/intel/int3472/common.h
index d14944ee8586..53270d19c73a 100644
--- a/drivers/platform/x86/intel/int3472/common.h
+++ b/drivers/platform/x86/intel/int3472/common.h
@@ -108,6 +108,9 @@ struct int3472_discrete_device {
 union acpi_object *skl_int3472_get_acpi_buffer(struct acpi_device *adev,
 					       char *id);
 int skl_int3472_fill_cldb(struct acpi_device *adev, struct int3472_cldb *cldb);
+int skl_int3472_get_sensor_adev_and_name(struct device *dev,
+					 struct acpi_device **sensor_adev_ret,
+					 const char **name_ret);
 
 int skl_int3472_register_clock(struct int3472_discrete_device *int3472);
 void skl_int3472_unregister_clock(struct int3472_discrete_device *int3472);
diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/platform/x86/intel/int3472/discrete.c
index d2e8a87a077e..ff2bdbb8722c 100644
--- a/drivers/platform/x86/intel/int3472/discrete.c
+++ b/drivers/platform/x86/intel/int3472/discrete.c
@@ -363,19 +363,10 @@ static int skl_int3472_discrete_probe(struct platform_device *pdev)
 	int3472->dev = &pdev->dev;
 	platform_set_drvdata(pdev, int3472);
 
-	int3472->sensor = acpi_dev_get_first_consumer_dev(adev);
-	if (!int3472->sensor) {
-		dev_err(&pdev->dev, "INT3472 seems to have no dependents.\n");
-		return -ENODEV;
-	}
-
-	int3472->sensor_name = devm_kasprintf(int3472->dev, GFP_KERNEL,
-					      I2C_DEV_NAME_FORMAT,
-					      acpi_dev_name(int3472->sensor));
-	if (!int3472->sensor_name) {
-		ret = -ENOMEM;
-		goto err_put_sensor;
-	}
+	ret = skl_int3472_get_sensor_adev_and_name(&pdev->dev, &int3472->sensor,
+						   &int3472->sensor_name);
+	if (ret)
+		return ret;
 
 	/*
 	 * Initialising this list means we can call gpiod_remove_lookup_table()
@@ -390,11 +381,6 @@ static int skl_int3472_discrete_probe(struct platform_device *pdev)
 	}
 
 	return 0;
-
-err_put_sensor:
-	acpi_dev_put(int3472->sensor);
-
-	return ret;
 }
 
 static int skl_int3472_discrete_remove(struct platform_device *pdev)
-- 
2.33.1

