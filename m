Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B142748AB77
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 11:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349249AbiAKKeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 05:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349103AbiAKKeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 05:34:00 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4FAC06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 02:34:00 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id q8so31963860wra.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 02:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XUjj1RE5dBBUa1ZWEnoK1axgok9F759obl3L2a0UOZI=;
        b=ZEnEc1+E8TAUABuwGbc3jjjzWx8pPgMt9+6B9t1MpV3Df9stEl+uyHuM58y73KQAQP
         cwRz1NkTmDRmrIq49qyXqp2RK58WcRG16CR8QYdGWrv5VNcIzHc9/4JiL4fhUOW1IL40
         5CPT7TTjBXEytwp1ZxiEJrO5T/8kO4Wcqh6rl7jnq8Oa9uitNDT6t43qVhxFo0p2QPaQ
         +2+vS2AtKWkdwQ78+Y8MkxcLw1n9ZUmtC2awun1yDgeLe2mS+jpKfrieBq10P8dKIIzV
         xIss/xxixi62rLR3I/t1rgFmgZZ++dWeyUYp03EgPz4SwJ4Z0noGd8zZ+bFMGYyomQHT
         21ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XUjj1RE5dBBUa1ZWEnoK1axgok9F759obl3L2a0UOZI=;
        b=nWvTsvA9bKrQ1n+41UpcLHO73sJxlXRMjT4A6xOzgFvNif3LYzVBNiP7Dfw2gcDo2r
         smKzdad4HdjPioP9HPAWTN+aJsCBKaL1iFwPKeCcBwOFrAN6Ob5/6iHEHuCGZCXrIiCQ
         kkncy61Yri/zLtT8zrOhzjVfs3OqWfCR9k5Yt2DJHQj2J7+T1GtCQsHF5wCnNQZMAoKh
         mA9yt2Vkb/vtcOH90PhE+v5BytSJk4MeGImNcx/18mYvAFtoVuvSrmTWQMxv0Uo1dV5q
         VN0dYfYrpqKRLTOMlDWYZ8r3JM6IHe+Z3qXS/k3L8SZlO23gXZEzj9IwuEjfaIL7I6WC
         ld2w==
X-Gm-Message-State: AOAM530Ajik/1Hxa8C3P2jmyslD7UUhRTRL4jNjtE5/YU955NLvxGTar
        ptMcDjdEKTRgnqdBk5nkOQhjIYIdS5uRDQ==
X-Google-Smtp-Source: ABdhPJxFoXafrsFCIVbDq3SDjluLGverX8M1bZL1a2ve/AuQAfWynNpsbKozrHDoT2i/ez3gTM7kVQ==
X-Received: by 2002:a5d:6784:: with SMTP id v4mr3263819wru.275.1641897238983;
        Tue, 11 Jan 2022 02:33:58 -0800 (PST)
Received: from xps-9300.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id u16sm8803470wrn.24.2022.01.11.02.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 02:33:58 -0800 (PST)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.tseng@mediatek.com, khilman@baylibre.com, mka@chromium.org,
        Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH v4 RESEND 2/2] thermal: add a virtual sensor to aggregate temperatures
Date:   Tue, 11 Jan 2022 11:33:46 +0100
Message-Id: <20220111103346.2660639-3-abailon@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220111103346.2660639-1-abailon@baylibre.com>
References: <20220111103346.2660639-1-abailon@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a virtual thermal sensor driver that reads temperature from
multiple hardware sensors and returns an aggregated temperature.
Currently, this supports three aggregations:
the minimum, maximum and average temperature.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 drivers/thermal/Kconfig                  |   8 +
 drivers/thermal/Makefile                 |   1 +
 drivers/thermal/virtual_thermal_sensor.c | 218 +++++++++++++++++++++++
 3 files changed, 227 insertions(+)
 create mode 100644 drivers/thermal/virtual_thermal_sensor.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index d7f44deab5b1..b326fae5ad1d 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -228,6 +228,14 @@ config THERMAL_MMIO
 	  register or shared memory, is a potential candidate to work with this
 	  driver.
 
+config VIRTUAL_THERMAL
+	tristate "DT-based virtual thermal sensor driver"
+	depends on THERMAL_OF || COMPILE_TEST
+	help
+	  This option enables the generic DT-based thermal sensor aggregator.
+	  This driver creates a thermal sensor that reads multiple hardware
+	  sensors and aggregates their output.
+
 config HISI_THERMAL
 	tristate "Hisilicon thermal driver"
 	depends on ARCH_HISI || COMPILE_TEST
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 82fc3e616e54..8bf55973059c 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -60,3 +60,4 @@ obj-$(CONFIG_UNIPHIER_THERMAL)	+= uniphier_thermal.o
 obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
 obj-$(CONFIG_SPRD_THERMAL)	+= sprd_thermal.o
 obj-$(CONFIG_KHADAS_MCU_FAN_THERMAL)	+= khadas_mcu_fan.o
+obj-$(CONFIG_VIRTUAL_THERMAL) += virtual_thermal_sensor.o
diff --git a/drivers/thermal/virtual_thermal_sensor.c b/drivers/thermal/virtual_thermal_sensor.c
new file mode 100644
index 000000000000..9f38af925fd1
--- /dev/null
+++ b/drivers/thermal/virtual_thermal_sensor.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * virtual_thermal_sensor.c - DT-based virtual thermal sensor driver.
+ *
+ * Copyright (c) 2021 BayLibre
+ */
+
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/slab.h>
+#include <linux/thermal.h>
+#include <linux/types.h>
+#include <linux/string.h>
+
+#include <dt-bindings/thermal/virtual-sensor.h>
+
+struct virtual_thermal_zone_device {
+	struct thermal_zone_device *zone;
+	struct module *owner;
+};
+
+struct virtual_thermal_sensor {
+	int count;
+	struct virtual_thermal_zone_device *zones;
+	struct thermal_zone_device *tzd;
+	int (*aggr_temp)(int temp1, int temp2);
+
+	struct list_head node;
+};
+
+static int max_temp(int temp1, int temp2)
+{
+	return max(temp1, temp2);
+}
+
+static int min_temp(int temp1, int temp2)
+{
+	return min(temp1, temp2);
+}
+
+static int avg_temp(int temp1, int temp2)
+{
+	return (temp1 + temp2) / 2;
+}
+
+static int virtual_thermal_sensor_get_temp(void *data, int *temperature)
+{
+	struct virtual_thermal_sensor *sensor = data;
+	int max_temp = INT_MIN;
+	int temp;
+	int i;
+
+	for (i = 0; i < sensor->count; i++) {
+		struct thermal_zone_device *zone;
+
+		zone = sensor->zones[i].zone;
+		zone->ops->get_temp(zone, &temp);
+		max_temp = sensor->aggr_temp(max_temp, temp);
+	}
+
+	*temperature = max_temp;
+
+	return 0;
+}
+
+static const struct thermal_zone_of_device_ops virtual_thermal_sensor_ops = {
+	.get_temp = virtual_thermal_sensor_get_temp,
+};
+
+static int virtual_thermal_sensor_get_module(struct virtual_thermal_zone_device *zone,
+					     const char *name)
+{
+		struct platform_device *sensor_pdev;
+		struct device_node *node;
+
+		node = of_find_node_by_name(NULL, name);
+		if (!node)
+			return -ENODEV;
+
+		node = of_parse_phandle(node, "thermal-sensors", 0);
+		if (!node)
+			return -ENODEV;
+
+		sensor_pdev = of_find_device_by_node(node);
+		if (!sensor_pdev)
+			return -ENODEV;
+
+		if (!sensor_pdev->dev.driver)
+			return -EPROBE_DEFER;
+
+		if (!try_module_get(sensor_pdev->dev.driver->owner))
+			return -ENODEV;
+
+		zone->owner = sensor_pdev->dev.driver->owner;
+
+		return 0;
+}
+
+static void virtual_thermal_sensor_put_modules(struct virtual_thermal_sensor *sensor)
+{
+	int i;
+
+	for (i = 0; i < sensor->count; i++) {
+		if (sensor->zones[i].zone)
+			module_put(sensor->zones[i].owner);
+	}
+}
+
+static int virtual_thermal_sensor_probe(struct platform_device *pdev)
+{
+	struct virtual_thermal_sensor *sensor;
+	struct device *dev = &pdev->dev;
+	struct property *prop;
+	const char *name;
+	u32 type;
+	int ret;
+	int i = 0;
+
+	sensor = devm_kzalloc(dev, sizeof(*sensor), GFP_KERNEL);
+	if (!sensor)
+		return -ENOMEM;
+	sensor->count = of_property_count_strings(dev->of_node, "thermal-sensors");
+	if (sensor->count <= 0)
+		return -EINVAL;
+
+	sensor->zones = devm_kmalloc_array(dev, sensor->count,
+					     sizeof(*sensor->zones),
+					     GFP_KERNEL);
+	if (!sensor->zones)
+		return -ENOMEM;
+
+	of_property_for_each_string(dev->of_node, "thermal-sensors", prop, name) {
+		struct virtual_thermal_zone_device *virtual_zone;
+		struct thermal_zone_device *zone;
+
+		virtual_zone = &sensor->zones[i++];
+
+		zone = thermal_zone_get_zone_by_name(name);
+		if (IS_ERR(zone))
+			return PTR_ERR(zone);
+
+		ret = virtual_thermal_sensor_get_module(virtual_zone, name);
+		if (ret)
+			goto err;
+
+		virtual_zone->zone = zone;
+	}
+
+	ret = of_property_read_u32(dev->of_node, "aggregation-function", &type);
+	if (ret)
+		return ret;
+
+	switch (type) {
+	case VIRTUAL_THERMAL_SENSOR_MAX_VAL:
+		sensor->aggr_temp = max_temp;
+		break;
+	case VIRTUAL_THERMAL_SENSOR_MIN_VAL:
+		sensor->aggr_temp = min_temp;
+		break;
+	case VIRTUAL_THERMAL_SENSOR_AVG_VAL:
+		sensor->aggr_temp = avg_temp;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	sensor->tzd = devm_thermal_zone_of_sensor_register(dev, 0, sensor,
+							   &virtual_thermal_sensor_ops);
+	if (IS_ERR(sensor->tzd))
+		return PTR_ERR(sensor->tzd);
+
+	platform_set_drvdata(pdev, sensor);
+
+	return 0;
+
+err:
+	virtual_thermal_sensor_put_modules(sensor);
+
+	return ret;
+}
+
+static int virtual_thermal_sensor_remove(struct platform_device *pdev)
+{
+	struct virtual_thermal_sensor *sensor;
+
+	sensor = platform_get_drvdata(pdev);
+	list_del(&sensor->node);
+
+	virtual_thermal_sensor_put_modules(sensor);
+
+	return 0;
+}
+
+static const struct of_device_id virtual_thermal_sensor_of_match[] = {
+	{
+		.compatible = "virtual,thermal-sensor",
+	},
+	{
+	},
+};
+MODULE_DEVICE_TABLE(of, virtual_thermal_sensor_of_match);
+
+static struct platform_driver virtual_thermal_sensor = {
+	.probe = virtual_thermal_sensor_probe,
+	.remove = virtual_thermal_sensor_remove,
+	.driver = {
+		.name = "virtual-thermal-sensor",
+		.of_match_table = virtual_thermal_sensor_of_match,
+	},
+};
+
+module_platform_driver(virtual_thermal_sensor);
+MODULE_AUTHOR("Alexandre Bailon <abailon@baylibre.com>");
+MODULE_DESCRIPTION("Virtual thermal sensor");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

