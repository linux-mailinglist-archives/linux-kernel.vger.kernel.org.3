Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24DF4BB48B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 09:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbiBRIqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 03:46:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232824AbiBRIqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 03:46:30 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429872B31B6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 00:46:13 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id y6-20020a7bc186000000b0037bdc5a531eso5588175wmi.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 00:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ggmECTV/BfqNzMfA93Olu5KQ731GKcm3xs7cngFRVXM=;
        b=1ZVCmikztw06zPIO6hcTNrn5BMxlPAcLUK81uIPmAcHDyoPI4Y7WvvgLpes06T8zjp
         TA2q3Iv6rBkzunVEkj2vqV0mv8gVSNChtdMouWBkzhxC2QMbMFab3/uqNJILYNK2tKpO
         JpYDmC3HkKla3YUba401uUWKr9KXlxOCbjE1/nBz3EgiMahmgZmZE0Dfy3oT9I62ilLV
         /WthBojzq1763+58r7BY6GcT4fKt5S+/Ff4YhjP78Ym21TJIlyyk5FmiNeQigY6FNUOn
         jdg5+wL5CQQpmVyAsZIgDGo2KgN0VCDE/BZukR7plqYywqTnAN2jyvoGHLdSn6mMHPnm
         5jWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ggmECTV/BfqNzMfA93Olu5KQ731GKcm3xs7cngFRVXM=;
        b=0RFgsVxPlsVdTJG9nNeaO9unsGCODa9UKIxoWfgrNs/DdL4aCynTS3ip0Rn61or72k
         ldP40nl8HbO2OqEHnLikB7qwEDsIybyRQR9KsMhNW94r7Q/Nz/EqmMBdbgNhJiuPxqzy
         W7AwOaeHSWvahwMjZ/unboqbkW27gTa8osOjYQkARwK1gHtJaf8DSY8KBCUnJaGEluDc
         WNmqtJNSlUrnUwfgyJ7YsLq1dNGv3twI5DV5Mwdq/cpiuzxNrSNuM6XBrnyIQJMrbKpW
         aR+eRdIyexpbFZ3ipiqQiLxhW8qTsa2VWRwsYifdC5vJATvzHxgf1g4dsUaX0LZxNgQw
         xH+w==
X-Gm-Message-State: AOAM530TkLCp8y4Bs0wYfxHr4bCkSsi62AOMjFYLDWtqmbeN34jgbCXV
        AhEddBSP2goqy7g95LMNbPdabw==
X-Google-Smtp-Source: ABdhPJyJWdx/57xg1/k4UyQZWyUO3YvpOLITcMRSZBUqeVX5x+xk7TzhovuGuqPPJCqq3W19aq34sA==
X-Received: by 2002:a05:600c:3590:b0:34a:5f6:9e6 with SMTP id p16-20020a05600c359000b0034a05f609e6mr9726433wmq.182.1645173971529;
        Fri, 18 Feb 2022 00:46:11 -0800 (PST)
Received: from xps-9300.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x7sm33525478wro.21.2022.02.18.00.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 00:46:11 -0800 (PST)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.tseng@mediatek.com, khilman@baylibre.com, mka@chromium.org,
        Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH 2/2] Thermal: Add support of multiple sensors
Date:   Fri, 18 Feb 2022 09:46:04 +0100
Message-Id: <20220218084604.1669091-3-abailon@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218084604.1669091-1-abailon@baylibre.com>
References: <20220218084604.1669091-1-abailon@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This updates thermal_of to add support of multiple sensors.
By default, when several sensors are registered to a thermal zone,
the maximum temperature is returned.
This could be changed to minimum or average temparture by
adding aggretation-min or aggregation-avg to the thermal zone
devioce tree node.
In addition of get_temp, this also updates some
thermal_zone_of_device_ops callbacks to support multiple sensors.
Only get_trend callback is not implemented to support multiple sensors.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 drivers/thermal/thermal_of.c | 491 ++++++++++++++++++++++++++++++-----
 1 file changed, 432 insertions(+), 59 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 9233f7e744544..fce4332b59734 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -19,6 +19,12 @@
 
 #include "thermal_core.h"
 
+enum aggr_type {
+	VIRTUAL_THERMAL_SENSOR_MIN_VAL,
+	VIRTUAL_THERMAL_SENSOR_MAX_VAL,
+	VIRTUAL_THERMAL_SENSOR_AVG_VAL,
+};
+
 /***   Private data structures to represent thermal device tree data ***/
 
 /**
@@ -49,6 +55,20 @@ struct __thermal_bind_params {
 	unsigned int usage;
 };
 
+/**
+ * sensor interface
+ * @sensor_data: sensor private data used while reading temperature and trend
+ * @ops: set of callbacks to handle the thermal zone based on DT
+ */
+
+struct __sensor_interface {
+	void *data;
+	const struct thermal_zone_of_device_ops *ops;
+	int tzd_id;
+
+	struct list_head node;
+};
+
 /**
  * struct __thermal_zone - internal representation of a thermal zone
  * @passive_delay: polling interval while passive cooling is activated
@@ -61,6 +81,9 @@ struct __thermal_bind_params {
  * @tbps: an array of thermal bind params (0..num_tbps - 1)
  * @sensor_data: sensor private data used while reading temperature and trend
  * @ops: set of callbacks to handle the thermal zone based on DT
+ * @sensors_lock: a mutex to protect the list of sensors
+ * @sensors: a list of sensors used in multiple sensors configuration
+ * @aggr_type: define how to aggregate the temperature from multiple sensors
  */
 
 struct __thermal_zone {
@@ -78,32 +101,119 @@ struct __thermal_zone {
 	struct __thermal_bind_params *tbps;
 
 	/* sensor interface */
-	void *sensor_data;
-	const struct thermal_zone_of_device_ops *ops;
+	struct __sensor_interface *sensor;
+
+	/* multiple sensors */
+	struct mutex sensors_lock;
+	struct list_head sensors;
+	int aggr_type;
+	int count;
 };
 
 /***   DT thermal zone device callbacks   ***/
 
+static int of_thermal_get_aggr_temp(struct thermal_zone_device *tz,
+				    int *temp)
+{
+	struct __thermal_zone *data = tz->devdata;
+	struct __sensor_interface *sensor;
+	int aggr_temp = 0;
+	int remainder = 0;
+	int sum = 0;
+	int ret;
+
+	if (list_empty(&data->sensors))
+		return -EINVAL;
+
+	if (data->aggr_type == VIRTUAL_THERMAL_SENSOR_MIN_VAL)
+		aggr_temp = INT_MAX;
+
+	list_for_each_entry(sensor, &data->sensors, node) {
+		ret = sensor->ops->get_temp(sensor->data, temp);
+		if (ret)
+			return ret;
+
+		switch (data->aggr_type) {
+		case VIRTUAL_THERMAL_SENSOR_MAX_VAL:
+			aggr_temp = max(aggr_temp, *temp);
+			break;
+		case VIRTUAL_THERMAL_SENSOR_MIN_VAL:
+			aggr_temp = min(aggr_temp, *temp);
+			break;
+		case VIRTUAL_THERMAL_SENSOR_AVG_VAL:
+			sum += *temp / data->count;
+			remainder += *temp % data->count;
+			break;
+		}
+	}
+
+	if (data->aggr_type == VIRTUAL_THERMAL_SENSOR_AVG_VAL)
+		aggr_temp = sum + (remainder) / data->count;
+
+	*temp = aggr_temp;
+	return ret;
+}
+
 static int of_thermal_get_temp(struct thermal_zone_device *tz,
 			       int *temp)
 {
 	struct __thermal_zone *data = tz->devdata;
+	struct __sensor_interface *sensor = data->sensor;
+	int ret;
+
+	if (!sensor) {
+		mutex_lock(&data->sensors_lock);
+		ret = of_thermal_get_aggr_temp(tz, temp);
+		mutex_unlock(&data->sensors_lock);
+
+		return ret;
+	}
+
+	if (!sensor->ops || !sensor->ops->get_temp)
+		return -EINVAL;
+
+	return sensor->ops->get_temp(sensor->data, temp);
+}
+
+static int of_thermal_set_multi_trips(struct thermal_zone_device *tz,
+				      int low, int high)
+{
+	struct __thermal_zone *data = tz->devdata;
+	struct __sensor_interface *sensor;
+	int ret;
 
-	if (!data->ops || !data->ops->get_temp)
+	if (list_empty(&data->sensors))
 		return -EINVAL;
 
-	return data->ops->get_temp(data->sensor_data, temp);
+	list_for_each_entry(sensor, &data->sensors, node) {
+		ret = sensor->ops->set_trips(sensor->data, low, high);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 static int of_thermal_set_trips(struct thermal_zone_device *tz,
 				int low, int high)
 {
 	struct __thermal_zone *data = tz->devdata;
+	struct __sensor_interface *sensor = data->sensor;
+
+	if (!sensor) {
+		int ret;
+
+		mutex_lock(&data->sensors_lock);
+		ret = of_thermal_set_multi_trips(tz, low, high);
+		mutex_unlock(&data->sensors_lock);
+
+		return ret;
+	}
 
-	if (!data->ops || !data->ops->set_trips)
+	if (!sensor->ops || !sensor->ops->set_trips)
 		return -EINVAL;
 
-	return data->ops->set_trips(data->sensor_data, low, high);
+	return sensor->ops->set_trips(sensor->data, low, high);
 }
 
 /**
@@ -181,26 +291,61 @@ EXPORT_SYMBOL_GPL(of_thermal_get_trip_points);
  *
  * Return: zero on success, error code otherwise
  */
+static int of_thermal_set_multi_emul_temp(struct thermal_zone_device *tz,
+					  int temp)
+{
+	struct __thermal_zone *data = tz->devdata;
+	struct __sensor_interface *sensor;
+	int ret;
+
+	if (list_empty(&data->sensors))
+		return -EINVAL;
+
+	list_for_each_entry(sensor, &data->sensors, node) {
+		ret = sensor->ops->set_emul_temp(sensor->data, temp);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int of_thermal_set_emul_temp(struct thermal_zone_device *tz,
 				    int temp)
 {
 	struct __thermal_zone *data = tz->devdata;
+	struct __sensor_interface *sensor = data->sensor;
+
+	if (!sensor) {
+		int ret;
+
+		mutex_lock(&data->sensors_lock);
+		ret = of_thermal_set_multi_emul_temp(tz, temp);
+		mutex_unlock(&data->sensors_lock);
+
+		return ret;
+	}
 
-	if (!data->ops || !data->ops->set_emul_temp)
+	if (!sensor->ops || !sensor->ops->set_emul_temp)
 		return -EINVAL;
 
-	return data->ops->set_emul_temp(data->sensor_data, temp);
+	return sensor->ops->set_emul_temp(sensor->data, temp);
 }
 
 static int of_thermal_get_trend(struct thermal_zone_device *tz, int trip,
 				enum thermal_trend *trend)
 {
 	struct __thermal_zone *data = tz->devdata;
+	struct __sensor_interface *sensor = data->sensor;
 
-	if (!data->ops || !data->ops->get_trend)
+	/* Currently not supported by multiple sensors configuration */
+	if (!sensor)
 		return -EINVAL;
 
-	return data->ops->get_trend(data->sensor_data, trip, trend);
+	if (!sensor->ops || !sensor->ops->get_trend)
+		return -EINVAL;
+
+	return sensor->ops->get_trend(sensor->data, trip, trend);
 }
 
 static int of_thermal_bind(struct thermal_zone_device *thermal,
@@ -296,22 +441,49 @@ static int of_thermal_get_trip_temp(struct thermal_zone_device *tz, int trip,
 	return 0;
 }
 
+static int of_thermal_set_multi_trip_temp(struct thermal_zone_device *tz,
+					  int trip, int temp)
+{
+	struct __thermal_zone *data = tz->devdata;
+	struct __sensor_interface *sensor;
+	int ret;
+
+	if (list_empty(&data->sensors))
+		return -EINVAL;
+
+	list_for_each_entry(sensor, &data->sensors, node) {
+		if (sensor->ops->set_trip_temp) {
+			ret = sensor->ops->set_trip_temp(sensor->data,
+							 trip, temp);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
 static int of_thermal_set_trip_temp(struct thermal_zone_device *tz, int trip,
 				    int temp)
 {
 	struct __thermal_zone *data = tz->devdata;
+	struct __sensor_interface *sensor = data->sensor;
+	int ret;
 
 	if (trip >= data->ntrips || trip < 0)
 		return -EDOM;
 
-	if (data->ops && data->ops->set_trip_temp) {
-		int ret;
-
-		ret = data->ops->set_trip_temp(data->sensor_data, trip, temp);
-		if (ret)
-			return ret;
+	if (!sensor) {
+		mutex_lock(&data->sensors_lock);
+		ret = of_thermal_set_multi_trip_temp(tz, trip, temp);
+		mutex_unlock(&data->sensors_lock);
+	} else if (sensor->ops && sensor->ops->set_trip_temp) {
+		ret = sensor->ops->set_trip_temp(sensor->data, trip, temp);
 	}
 
+	if (ret)
+		return ret;
+
 	/* thermal framework should take care of data->mask & (1 << trip) */
 	data->trips[trip].temperature = temp;
 
@@ -374,13 +546,66 @@ static struct thermal_zone_device_ops of_thermal_ops = {
 
 /***   sensor API   ***/
 
+static struct __sensor_interface *alloc_sensor_interface(
+		struct __thermal_zone *tz, int tzd_id, void *data,
+		const struct thermal_zone_of_device_ops *ops)
+{
+	struct __sensor_interface *sensor_iface;
+
+	sensor_iface = kzalloc(sizeof(*sensor_iface), GFP_KERNEL);
+	if (!sensor_iface)
+		return NULL;
+
+	sensor_iface->ops = ops;
+	sensor_iface->data = data;
+	sensor_iface->tzd_id = tzd_id;
+	INIT_LIST_HEAD(&sensor_iface->node);
+
+	return sensor_iface;
+}
+
+static int check_sensors_coherency(struct thermal_zone_device *tzd)
+{
+	struct __thermal_zone *tz = tzd->devdata;
+	struct __sensor_interface *sensor;
+	int has_set_trip_temp = 0;
+	int i = 0;
+
+	list_for_each_entry(sensor, &tz->sensors, node) {
+		if (!sensor->ops->get_temp) {
+			pr_err(".get_temp function is missing\n");
+			return -EINVAL;
+		}
+
+		if (tzd->ops->set_trips && sensor->ops->set_trips) {
+			pr_err("Some sensors miss .set_trips\n");
+			return -EINVAL;
+		}
+
+		if (tzd->ops->set_emul_temp && sensor->ops->set_emul_temp) {
+			pr_err("Some sensors miss .set_emul_temp\n");
+			return -EINVAL;
+		}
+
+		if (!sensor->ops->set_trip_temp)
+			has_set_trip_temp++;
+		i++;
+	}
+
+	if (has_set_trip_temp != i)
+		pr_warn_once("Some sensors miss .set_trip_temp function\n");
+
+	return 0;
+}
+
 static struct thermal_zone_device *
 thermal_zone_of_add_sensor(struct device_node *zone,
-			   struct device_node *sensor, void *data,
+			   struct device_node *sensor, int tzd_id, void *data,
 			   const struct thermal_zone_of_device_ops *ops)
 {
 	struct thermal_zone_device *tzd;
 	struct __thermal_zone *tz;
+	struct __sensor_interface *sensor_iface;
 
 	tzd = thermal_zone_get_zone_by_name(zone->name);
 	if (IS_ERR(tzd))
@@ -391,43 +616,56 @@ thermal_zone_of_add_sensor(struct device_node *zone,
 	if (!ops)
 		return ERR_PTR(-EINVAL);
 
-	mutex_lock(&tzd->lock);
-	tz->ops = ops;
-	tz->sensor_data = data;
+	sensor_iface = alloc_sensor_interface(tz, tzd_id, data, ops);
+	if (!sensor_iface)
+		return ERR_PTR(-ENOMEM);
 
-	tzd->ops->get_temp = of_thermal_get_temp;
-	tzd->ops->get_trend = of_thermal_get_trend;
+	mutex_lock(&tz->sensors_lock);
+	mutex_lock(&tzd->lock);
 
-	/*
-	 * The thermal zone core will calculate the window if they have set the
-	 * optional set_trips pointer.
-	 */
-	if (ops->set_trips)
-		tzd->ops->set_trips = of_thermal_set_trips;
+	if (list_empty(&tz->sensors) && !tz->sensor) {
+		/* Adding the first sensor */
+		tzd->ops->get_temp = of_thermal_get_temp;
+		tzd->ops->get_trend = of_thermal_get_trend;
+
+		/*
+		 * The thermal zone core will calculate the window
+		 * if they have set the optional set_trips pointer.
+		 */
+		if (ops->set_trips)
+			tzd->ops->set_trips = of_thermal_set_trips;
+
+		if (ops->set_emul_temp)
+			tzd->ops->set_emul_temp = of_thermal_set_emul_temp;
+
+		/* Assume a mono sensor configuration */
+		tz->sensor = sensor_iface;
+	} else if (list_empty(&tz->sensors) && tz->sensor) {
+		/*
+		 * Multiple sensors configuration
+		 * Move the first sensor to the list
+		 */
+		list_add(&tz->sensor->node, &tz->sensors);
+		tz->sensor = NULL;
+		tz->count = 1;
+	}
 
-	if (ops->set_emul_temp)
-		tzd->ops->set_emul_temp = of_thermal_set_emul_temp;
+	if (!tz->sensor) {
+		list_add(&sensor_iface->node, &tz->sensors);
+		tz->count++;
+	}
 
 	mutex_unlock(&tzd->lock);
+	mutex_unlock(&tz->sensors_lock);
 
 	return tzd;
 }
 
-/**
- * thermal_zone_of_get_sensor_id - get sensor ID from a DT thermal zone
- * @tz_np: a valid thermal zone device node.
- * @sensor_np: a sensor node of a valid sensor device.
- * @id: the sensor ID returned if success.
- *
- * This function will get sensor ID from a given thermal zone node and
- * the sensor node must match the temperature provider @sensor_np.
- *
- * Return: 0 on success, proper error code otherwise.
- */
-
-int thermal_zone_of_get_sensor_id(struct device_node *tz_np,
-				  struct device_node *sensor_np,
-				  u32 *id)
+static
+int _thermal_zone_of_get_sensor_id(struct device_node *tz_np,
+				   struct device_node *sensor_np,
+				   int phandle_index,
+				   u32 *id)
 {
 	struct of_phandle_args sensor_specs;
 	int ret;
@@ -435,7 +673,7 @@ int thermal_zone_of_get_sensor_id(struct device_node *tz_np,
 	ret = of_parse_phandle_with_args(tz_np,
 					 "thermal-sensors",
 					 "#thermal-sensor-cells",
-					 0,
+					 phandle_index,
 					 &sensor_specs);
 	if (ret)
 		return ret;
@@ -455,8 +693,87 @@ int thermal_zone_of_get_sensor_id(struct device_node *tz_np,
 
 	return 0;
 }
+
+
+/**
+ * thermal_zone_of_get_sensor_id - get sensor ID from a DT thermal zone
+ * @tz_np: a valid thermal zone device node.
+ * @sensor_np: a sensor node of a valid sensor device.
+ * @id: the sensor ID returned if success.
+ *
+ * This function will get sensor ID from a given thermal zone node and
+ * the sensor node must match the temperature provider @sensor_np.
+ *
+ * Return: 0 on success, proper error code otherwise.
+ */
+
+int thermal_zone_of_get_sensor_id(struct device_node *tz_np,
+				  struct device_node *sensor_np,
+				  u32 *id)
+{
+	return _thermal_zone_of_get_sensor_id(tz_np, sensor_np, 0, id);
+}
 EXPORT_SYMBOL_GPL(thermal_zone_of_get_sensor_id);
 
+int thermal_zone_of_has_sensor_id(struct device_node *tz_np,
+				  struct device_node *sensor_np,
+				  u32 sensor_id)
+{
+	int count;
+	int i;
+
+	count = of_count_phandle_with_args(tz_np,
+					   "thermal-sensors",
+					   "#thermal-sensor-cells");
+	if (count <= 0)
+		return 0;
+
+	for (i = 0; i < count; i++) {
+		int ret;
+		u32 id;
+
+		ret = _thermal_zone_of_get_sensor_id(tz_np, sensor_np, i, &id);
+		if (ret)
+			return 0;
+
+		if (id == sensor_id)
+			return 1;
+	}
+
+	return 0;
+}
+
+static
+int thermal_zone_of_del_sensor(struct thermal_zone_device *tzd, void *data)
+{
+	int *id = data;
+	struct __thermal_zone *tz;
+	struct __sensor_interface *sensor, *tmp;
+
+	if (!tzd->devdata)
+		return -ENODEV;
+
+	tz = tzd->devdata;
+
+	mutex_lock(&tzd->lock);
+	kfree(tz->sensor);
+	tz->sensor = NULL;
+	mutex_unlock(&tzd->lock);
+
+	mutex_lock(&tz->sensors_lock);
+	list_for_each_entry_safe(sensor, tmp, &tz->sensors, node) {
+		if (sensor->tzd_id != *id)
+			continue;
+
+		list_del(&sensor->node);
+		kfree(sensor);
+		tz->count--;
+	}
+	mutex_unlock(&tz->sensors_lock);
+
+	return 0;
+}
+
 /**
  * thermal_zone_of_sensor_register - registers a sensor to a DT thermal zone
  * @dev: a valid struct device pointer of a sensor device. Must contain
@@ -493,7 +810,7 @@ struct thermal_zone_device *
 thermal_zone_of_sensor_register(struct device *dev, int sensor_id, void *data,
 				const struct thermal_zone_of_device_ops *ops)
 {
-	struct device_node *np, *child, *sensor_np;
+	struct device_node *np, *child, *tzd_child, *sensor_np;
 	struct thermal_zone_device *tzd = ERR_PTR(-ENODEV);
 
 	np = of_find_node_by_name(NULL, "thermal-zones");
@@ -506,7 +823,6 @@ thermal_zone_of_sensor_register(struct device *dev, int sensor_id, void *data,
 	}
 
 	sensor_np = of_node_get(dev->of_node);
-
 	for_each_available_child_of_node(np, child) {
 		int ret, id;
 
@@ -517,15 +833,50 @@ thermal_zone_of_sensor_register(struct device *dev, int sensor_id, void *data,
 
 		if (id == sensor_id) {
 			tzd = thermal_zone_of_add_sensor(child, sensor_np,
-							 data, ops);
-			if (!IS_ERR(tzd))
-				thermal_zone_device_enable(tzd);
+							 -1, data, ops);
+			tzd_child = child;
+			if (IS_ERR(tzd))
+				goto err;
+
+			thermal_zone_device_enable(tzd);
 
-			of_node_put(child);
-			goto exit;
+			break;
+		}
+	}
+
+	if (IS_ERR(tzd))
+		return tzd;
+
+	/* Register the sensor to all other thermal zone referencing it */
+	for_each_available_child_of_node(np, child) {
+		struct thermal_zone_device *tmp_tzd;
+
+		if (!thermal_zone_of_has_sensor_id(child, sensor_np, sensor_id))
+			continue;
+
+		if (tzd_child == child)
+			continue;
+
+		tmp_tzd = thermal_zone_of_add_sensor(child, sensor_np,
+						     tzd->id, data, ops);
+		if (IS_ERR(tmp_tzd)) {
+			thermal_zone_of_del_sensor(tzd, &tzd->id);
+			goto err;
+		}
+
+		if (check_sensors_coherency(tmp_tzd)) {
+			thermal_zone_of_del_sensor(tzd, &tzd->id);
+			thermal_zone_of_del_sensor(tmp_tzd, &tmp_tzd->id);
+			tzd = ERR_PTR(-EINVAL);
+			goto err;
 		}
+
+		thermal_zone_device_enable(tmp_tzd);
+
 	}
-exit:
+
+err:
+	of_node_put(tzd_child);
 	of_node_put(sensor_np);
 	of_node_put(np);
 
@@ -544,9 +895,6 @@ EXPORT_SYMBOL_GPL(thermal_zone_of_sensor_register);
  * API. It will also silent the zone by remove the .get_temp() and .get_trend()
  * thermal zone device callbacks.
  *
- * TODO: When the support to several sensors per zone is added, this
- * function must search the sensor list based on @dev parameter.
- *
  */
 void thermal_zone_of_sensor_unregister(struct device *dev,
 				       struct thermal_zone_device *tzd)
@@ -562,6 +910,7 @@ void thermal_zone_of_sensor_unregister(struct device *dev,
 	if (!tz)
 		return;
 
+
 	/* stop temperature polling */
 	thermal_zone_device_disable(tzd);
 
@@ -570,9 +919,16 @@ void thermal_zone_of_sensor_unregister(struct device *dev,
 	tzd->ops->get_trend = NULL;
 	tzd->ops->set_emul_temp = NULL;
 
-	tz->ops = NULL;
-	tz->sensor_data = NULL;
+	if (tz->sensor) {
+		tz->sensor->ops = NULL;
+		tz->sensor->data = NULL;
+		tz->sensor = NULL;
+	}
+
 	mutex_unlock(&tzd->lock);
+
+	for_each_thermal_zone(thermal_zone_of_del_sensor, &tzd->id);
+
 }
 EXPORT_SYMBOL_GPL(thermal_zone_of_sensor_unregister);
 
@@ -868,6 +1224,14 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
 	tz = kzalloc(sizeof(*tz), GFP_KERNEL);
 	if (!tz)
 		return ERR_PTR(-ENOMEM);
+	INIT_LIST_HEAD(&tz->sensors);
+	mutex_init(&tz->sensors_lock);
+
+	tz->aggr_type = VIRTUAL_THERMAL_SENSOR_MAX_VAL;
+	if (of_property_read_bool(np, "aggregation-min"))
+		tz->aggr_type = VIRTUAL_THERMAL_SENSOR_MIN_VAL;
+	if (of_property_read_bool(np, "aggregation-avg"))
+		tz->aggr_type = VIRTUAL_THERMAL_SENSOR_AVG_VAL;
 
 	ret = of_property_read_u32(np, "polling-delay-passive", &prop);
 	if (ret < 0) {
@@ -980,6 +1344,7 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
 static __init void of_thermal_free_zone(struct __thermal_zone *tz)
 {
 	struct __thermal_bind_params *tbp;
+	struct __sensor_interface *sensor, *tmp;
 	int i, j;
 
 	for (i = 0; i < tz->num_tbps; i++) {
@@ -995,6 +1360,14 @@ static __init void of_thermal_free_zone(struct __thermal_zone *tz)
 	for (i = 0; i < tz->ntrips; i++)
 		of_node_put(tz->trips[i].np);
 	kfree(tz->trips);
+
+	mutex_lock(&tz->sensors_lock);
+	list_for_each_entry_safe(sensor, tmp, &tz->sensors, node) {
+		list_del(&sensor->node);
+		kfree(sensor);
+	}
+	mutex_unlock(&tz->sensors_lock);
+
 	kfree(tz);
 }
 
-- 
2.34.1

