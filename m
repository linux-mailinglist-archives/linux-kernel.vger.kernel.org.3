Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942DC56D161
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 23:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiGJVYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 17:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiGJVYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 17:24:39 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208C3EE1C
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 14:24:38 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id f2so4761130wrr.6
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 14:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pt+F4UPJfX76BAar3Kq5kOUJASYi8LQ2o9UqHnwVMWk=;
        b=3Ipcvq1ziRYv0MzuHoPTbkXA/b72kz/ZPIDIKL9d8nZzLcM3B3ax4GOYnYWDonmThF
         oaskfqdr83X5Ni/bFLUHVk5JdHnVQWLFf3Iha+/2V1woNdpxm48PO64/WBc/GTiACS4j
         0NrJfp+rcplqXlAWdh1vY0UEZSIfMpkY2GpTe5DMshvxcU1ElGzu5ASzNmbQ0acnns50
         gJg2XK38RttM0viGCwjL1aVv7a6kz62Fz4qa+aPPyU7yB3QiwlB7hKzTehJiaEG+KPGw
         7isJPqV4ZcRCNUO5s2wATihWKm2wrvD0k+7j472IByASALDgxbfUlvm1fsRKGzwFiVv/
         INFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pt+F4UPJfX76BAar3Kq5kOUJASYi8LQ2o9UqHnwVMWk=;
        b=5x4VZXhmUwGZ+kt7TAsHSChHsIlGtlfHC+NJ7AgSnl2qpiJOqCiRr5oPs05oykbHQE
         cVxmaCsWT0Afttnum3EEKBeW/Q5sOIZXYBe5hqZSMig7k+5s/uga7NXM+ohMLkTOokRs
         m/l9ghcvNdOco3NUwt4bGb785OVldE9RVytFdoUKA3j0Fq0sKqhUPjB1pNAhnOk5p7V8
         ZdvhsKVBe5+8kLmxw26dWt5DPKxxvHJHqQJVeqibI3euFwzBmGOhjAn7s5VUwHTdGpws
         abiuUYzXX2+a+X/4rLx+Ta2MLwqtAxUkjL09PykUXqtbGOwS+1jp9QIgt8rnU1/8kG30
         VTfw==
X-Gm-Message-State: AJIora9kU/7cYDO31D6hz9E4rCzM7r7nF0E2J+h7LmlBitoVTTYtZ5Y2
        RYun1GDnXDRl8E/jzHOYyhGXrA==
X-Google-Smtp-Source: AGRyM1uMQbRo8e92o4VNM0NNWEmVhWFPU5ARLUAsfE8uL+cGP6Q+b/uHzXvsXJSm9nTVbxgT/htR4Q==
X-Received: by 2002:a05:6000:702:b0:21d:7f65:f1b5 with SMTP id bs2-20020a056000070200b0021d7f65f1b5mr14008191wrb.555.1657488276621;
        Sun, 10 Jul 2022 14:24:36 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:c7c0:6823:f3ce:2447])
        by smtp.gmail.com with ESMTPSA id m19-20020a05600c3b1300b003a2dd0d21f0sm7142759wms.13.2022.07.10.14.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 14:24:36 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, khilman@baylibre.com, abailon@baylibre.com,
        amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v1 01/33] thermal/of: Rework the thermal device tree initialization
Date:   Sun, 10 Jul 2022 23:23:51 +0200
Message-Id: <20220710212423.681301-2-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220710212423.681301-1-daniel.lezcano@linexp.org>
References: <20220710212423.681301-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes are reworking entirely the thermal device tree
initialization. The old version is kept until the different drivers
using it are converted to the new API.

The old approach creates the different actors independently. This
approach is the source of the code duplication in the thermal OF
because a thermal zone is created but a sensor is registered
after. The thermal zones are created unconditionnaly with a fake
sensor at init time, thus forcing to provide fake ops and store all
the thermal zone related information in duplicated structures. Then
the sensor is initialized and the code looks up the thermal zone name
using the device tree. Then the sensor is associated to the thermal
zone, and the sensor specific ops are called with a second level of
indirection from the thermal zone ops.

When a sensor is removed (with a module unload), the thermal zone
stays there with the fake sensor.

The cooling device associated with a thermal zone and a trip point is
stored in a list, again duplicating information, using the node name
of the device tree to match afterwards the cooling devices.

The new approach is simpler, it creates a thermal zone when the sensor
is registered and destroys it when the sensor is removed. All the
matching between the cooling device, trip points and thermal zones are
done using the device tree, as well as bindings. The ops are no longer
specific but uses the generic ones provided by the thermal framework.

When the old code won't have any users, it can be removed and the
remaining thermal OF code will be much simpler.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/thermal_of.c | 452 ++++++++++++++++++++++++++++++++++-
 include/linux/thermal.h      |  18 ++
 2 files changed, 460 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 0693edc00f60..59e6411fcc23 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -811,16 +811,6 @@ static int thermal_of_get_trip_type(struct device_node *np,
 	return -ENODEV;
 }
 
-/**
- * thermal_of_populate_trip - parse and fill one trip point data
- * @np: DT node containing a trip point node
- * @trip: trip point data structure to be filled up
- *
- * This function parses a trip point type of node represented by
- * @np parameter and fills the read data into @trip data structure.
- *
- * Return: 0 on success, proper error code otherwise
- */
 static int thermal_of_populate_trip(struct device_node *np,
 				    struct thermal_trip *trip)
 {
@@ -1065,6 +1055,448 @@ static __init void of_thermal_destroy_zones(void)
 	of_node_put(np);
 }
 
+static struct device_node *of_thermal_zone_find(struct device_node *sensor, int id)
+{
+	struct device_node *np, *tz;
+	struct of_phandle_args sensor_specs;
+
+	np = of_find_node_by_name(NULL, "thermal-zones");
+	if (!np) {
+		pr_err("Unable to find thermal zones description\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	/*
+	 * Search for each thermal zone, a defined sensor
+	 * corresponding to the one passed as parameter
+	 */
+	for_each_available_child_of_node(np, tz) {
+
+		int count, i;
+		
+		count = of_count_phandle_with_args(tz, "thermal-sensors",
+						   "#thermal-sensor-cells");
+		if (count <= 0) {
+			pr_err("%pOFn: missing thermal sensor\n", tz);
+			tz = ERR_PTR(-EINVAL);
+			goto out;
+		}
+
+		for (i = 0; i < count; i++) {
+
+			int ret;
+
+			ret = of_parse_phandle_with_args(tz, "thermal-sensors",
+							 "#thermal-sensor-cells",
+							 i, &sensor_specs);
+			if (ret < 0) {
+				pr_err("%pOFn: Failed to read thermal-sensors cells: %d\n", tz, ret);
+				tz = ERR_PTR(ret);
+				goto out;
+			}
+
+			if ((sensor == sensor_specs.np) && id == (sensor_specs.args_count ?
+								  sensor_specs.args[0] : 0)) {
+				pr_info("sensor %pOFn id=%d belongs to %pOFn\n", sensor, id, tz);
+				goto out;
+			}
+		}
+	}
+out:
+	of_node_put(np);
+	return tz;
+}
+
+static int thermal_of_monitor_init(struct device_node *np, int *delay, int *pdelay)
+{
+	int ret;
+
+	ret = of_property_read_u32(np, "polling-delay-passive", pdelay);
+	if (ret < 0) {
+		pr_err("%pOFn: missing polling-delay-passive property\n", np);
+		return ret;
+	}
+
+	ret = of_property_read_u32(np, "polling-delay", delay);
+	if (ret < 0) {
+		pr_err("%pOFn: missing polling-delay property\n", np);
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct thermal_zone_params *thermal_of_parameters_init(struct device_node *np)
+{
+	struct thermal_zone_params *tzp;
+	int coef[2];
+	int ncoef = ARRAY_SIZE(coef);
+	int prop, ret;
+
+	tzp = kzalloc(sizeof(*tzp), GFP_KERNEL);
+	if (!tzp)
+		return ERR_PTR(-ENOMEM);
+
+	tzp->no_hwmon = true;
+
+	if (!of_property_read_u32(np, "sustainable-power", &prop))
+		tzp->sustainable_power = prop;
+
+	/*
+	 * For now, the thermal framework supports only one sensor per
+	 * thermal zone. Thus, we are considering only the first two
+	 * values as slope and offset.
+	 */
+	ret = of_property_read_u32_array(np, "coefficients", coef, ncoef);
+	if (ret) {
+		coef[0] = 1;
+		coef[1] = 0;
+	}
+
+	tzp->slope = coef[0];
+	tzp->offset = coef[1];
+	
+	return tzp;
+}
+
+static struct device_node *thermal_of_zone_get_by_name(struct thermal_zone_device *tz)
+{
+	struct device_node *np, *tz_np;
+
+	np = of_find_node_by_name(NULL, "thermal-zones");
+	if (!np)
+		return ERR_PTR(-ENODEV);
+
+	tz_np = of_get_child_by_name(np, tz->type);
+
+	of_node_put(np);
+
+	if (!tz_np)
+		return ERR_PTR(-ENODEV);
+
+	return tz_np;
+}
+
+static int __thermal_of_unbind(struct device_node *map_np, int index, int trip_id,
+			       struct thermal_zone_device *tz, struct thermal_cooling_device *cdev)
+{
+	struct of_phandle_args cooling_spec;
+	int ret;
+
+	ret = of_parse_phandle_with_args(map_np, "cooling-device", "#cooling-cells",
+					 index, &cooling_spec);
+
+	of_node_put(cooling_spec.np);
+
+	if (ret < 0) {
+		pr_err("Invalid cooling-device entry\n");
+		return ret;
+	}
+
+	if (cooling_spec.args_count < 2) {
+		pr_err("wrong reference to cooling device, missing limits\n");
+		return -EINVAL;
+	}
+
+	if (cooling_spec.np != cdev->np)
+		return 0;
+
+	ret = thermal_zone_unbind_cooling_device(tz, trip_id, cdev);
+	if (ret)
+		pr_err("Failed to unbind '%s' with '%s': %d\n", tz->type, cdev->type, ret);
+
+	return ret;
+}
+
+static int __thermal_of_bind(struct device_node *map_np, int index, int trip_id,
+			     struct thermal_zone_device *tz, struct thermal_cooling_device *cdev)
+{
+	struct of_phandle_args cooling_spec;
+	int ret, weight = THERMAL_WEIGHT_DEFAULT;
+
+	of_property_read_u32(map_np, "contribution", &weight);
+
+	ret = of_parse_phandle_with_args(map_np, "cooling-device", "#cooling-cells",
+					 index, &cooling_spec);
+
+	of_node_put(cooling_spec.np);
+
+	if (ret < 0) {
+		pr_err("Invalid cooling-device entry\n");
+		return ret;
+	}
+
+	if (cooling_spec.args_count < 2) {
+		pr_err("wrong reference to cooling device, missing limits\n");
+		return -EINVAL;
+	}
+
+	if (cooling_spec.np != cdev->np)
+		return 0;
+
+	ret = thermal_zone_bind_cooling_device(tz, trip_id, cdev, cooling_spec.args[1],
+					       cooling_spec.args[0],
+					       weight);
+	if (ret)
+		pr_err("Failed to bind '%s' with '%s': %d\n", tz->type, cdev->type, ret);
+
+	return ret;
+}
+
+static int thermal_of_for_each_cooling_device(struct device_node *tz_np, struct device_node *map_np,
+					      struct thermal_zone_device *tz, struct thermal_cooling_device *cdev,
+					      int (*action)(struct device_node *, int, int,
+							    struct thermal_zone_device *, struct thermal_cooling_device *))
+{
+	struct device_node *tr_np;
+	int count, i, trip_id;
+
+	tr_np = of_parse_phandle(map_np, "trip", 0);
+	if (!tr_np)
+		return -ENODEV;
+
+	trip_id = of_find_trip_id(tz_np, tr_np);
+	if (trip_id < 0)
+		return trip_id;
+
+	count = of_count_phandle_with_args(map_np, "cooling-device", "#cooling-cells");
+	if (count <= 0) {
+		pr_err("Add a cooling_device property with at least one device\n");
+		return -ENOENT;
+	}
+	
+	/*
+	 * At this point, we don't want to bail out when there is an
+	 * error, we will try to bind/unbind as many as possible
+	 * cooling devices
+	 */
+	for (i = 0; i < count; i++)
+		action(map_np, i, trip_id, tz, cdev);
+
+	return 0;
+}
+
+static int thermal_of_for_each_cooling_maps(struct thermal_zone_device *tz,
+					    struct thermal_cooling_device *cdev,
+					    int (*action)(struct device_node *, int, int,
+							  struct thermal_zone_device *, struct thermal_cooling_device *))
+{
+	struct device_node *tz_np, *cm_np, *child;
+	int ret = 0;
+
+	tz_np = thermal_of_zone_get_by_name(tz);
+	if (IS_ERR(tz_np)) {
+		pr_err("Failed to get node tz by name\n");
+		return PTR_ERR(tz_np);
+	}
+
+	cm_np = of_get_child_by_name(tz_np, "cooling-maps");
+	if (!cm_np)
+		goto out;
+
+	for_each_child_of_node(cm_np, child) {
+		ret = thermal_of_for_each_cooling_device(tz_np, child, tz, cdev, action);
+		if (ret)
+			break;
+	}
+	
+	of_node_put(cm_np);
+out:
+	of_node_put(tz_np);
+	
+	return ret;
+}
+
+static int thermal_of_bind(struct thermal_zone_device *tz,
+			   struct thermal_cooling_device *cdev)
+{
+	return thermal_of_for_each_cooling_maps(tz, cdev, __thermal_of_bind);
+}
+
+static int thermal_of_unbind(struct thermal_zone_device *tz,
+			     struct thermal_cooling_device *cdev)
+{
+	return thermal_of_for_each_cooling_maps(tz, cdev, __thermal_of_unbind);
+}
+
+/**
+ * thermal_of_zone_unregister - Cleanup the specific allocated ressources
+ *
+ * This function disables the thermal zone and frees the different
+ * ressources allocated specific to the thermal OF.
+ *
+ * @tz: a pointer to the thermal zone structure
+ */
+void thermal_of_zone_unregister(struct thermal_zone_device *tz)
+{
+	thermal_zone_device_disable(tz);
+
+	mutex_lock(&tz->lock);
+	kfree(tz->trips);
+	kfree(tz->tzp);
+	tz->trips = NULL;
+	tz->tzp = NULL;
+	mutex_unlock(&tz->lock);
+
+	thermal_zone_device_unregister(tz);
+}
+EXPORT_SYMBOL_GPL(thermal_of_zone_unregister);
+
+/**
+ * thermal_of_zone_register - Register a thermal zone with device node
+ * sensor
+ *
+ * The thermal_of_zone_register() parses a device tree given a device
+ * node sensor and identifier. It searches for the thermal zone
+ * associated to the couple sensor/id and retrieves all the thermal
+ * zone properties and registers new thermal zone with those
+ * properties.
+ *
+ * @sensor: A device node pointer corresponding to the sensor in the device tree
+ * @id: An integer as sensor identifier
+ * @data: A private data to be stored in the thermal zone dedicated private area
+ * @ops: A set of thermal sensor ops
+ *
+ * Return: a valid thermal zone structure pointer on success.
+ * 	- EINVAL: if the device tree thermal description is malformed
+ *	- ENOMEM: if one structure can not be allocated
+ *	- Other negative errors are returned by the underlying called functions
+ */
+struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor, int id, void *data,
+						     struct thermal_zone_device_ops *ops)
+{
+	struct thermal_zone_device *tz;
+	struct thermal_trip *trips;
+	struct thermal_zone_params *tzp;
+	struct device_node *np;
+	int delay, pdelay;
+	int ntrips, mask;
+	int ret;
+
+	np = of_thermal_zone_find(sensor, id);
+	if (IS_ERR(np)) {
+		pr_err("Failed to find thermal zone for %pOFn id=%d\n", sensor, id);
+		return ERR_CAST(np);
+	}
+	
+	trips = thermal_of_trips_init(np, &ntrips);
+	if (IS_ERR(trips)) {
+		pr_err("Failed to find trip points for %pOFn id=%d\n", sensor, id);
+		return ERR_CAST(trips);
+	}
+
+	ret = thermal_of_monitor_init(np, &delay, &pdelay);
+	if (ret) {
+		pr_err("Failed to initialize monitoring delays from %pOFn\n", np);
+		goto out_kfree_trips;
+	}
+
+	tzp = thermal_of_parameters_init(np);
+	if (IS_ERR(tzp)) {
+		ret = PTR_ERR(tzp);
+		pr_err("Failed to initialize parameter from %pOFn: %d\n", np, ret);
+		goto out_kfree_trips;
+	}
+
+	ops->get_trip_type = ops->get_trip_type ? : of_thermal_get_trip_type;
+	ops->get_trip_temp = ops->get_trip_temp ? : of_thermal_get_trip_temp;
+	ops->get_trip_hyst = ops->get_trip_hyst ? : of_thermal_get_trip_hyst;
+	ops->set_trip_hyst = ops->set_trip_hyst ? : of_thermal_set_trip_hyst;
+	ops->get_crit_temp = ops->get_crit_temp ? : of_thermal_get_crit_temp;
+	ops->bind = thermal_of_bind;
+	ops->unbind = thermal_of_unbind;
+
+	mask = GENMASK_ULL((ntrips) - 1, 0);
+	
+	tz = thermal_zone_device_register_with_trips(np->name, trips, ntrips,
+						     mask, data, ops, tzp,
+						     pdelay, delay);
+	if (IS_ERR(tz)) {
+		ret = PTR_ERR(tz);
+		pr_err("Failed to register thermal zone %pOFn: %d\n", np, ret);
+		goto out_kfree_tzp;
+	}
+
+	return tz;
+
+out_kfree_tzp:
+	kfree(tzp);
+out_kfree_trips:
+	kfree(trips);
+
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(thermal_of_zone_register);
+
+static void devm_thermal_of_zone_release(struct device *dev, void *res)
+{
+	thermal_of_zone_unregister(*(struct thermal_zone_device **)res);
+}
+
+static int devm_thermal_of_zone_match(struct device *dev, void *res,
+				      void *data)
+{
+	struct thermal_zone_device **r = res;
+
+	if (WARN_ON(!r || !*r))
+		return 0;
+
+	return *r == data;
+}
+
+/**
+ * devm_thermal_of_zone_register - register a thermal tied with the sensor life cycle
+ *
+ * This function is the device version of the thermal_of_zone_register() function.
+ *
+ * @dev: a device structure pointer to sensor to be tied with the thermal zone OF life cycle
+ * @sensor_id: the sensor identifier
+ * @data: a pointer to a private data to be stored in the thermal zone 'devdata' field
+ * @ops: a pointer to the ops structure associated with the sensor
+ */
+struct thermal_zone_device *devm_thermal_of_zone_register(struct device *dev, int sensor_id, void *data,
+							  struct thermal_zone_device_ops *ops)
+{
+	struct thermal_zone_device **ptr, *tzd;
+
+	ptr = devres_alloc(devm_thermal_of_zone_release, sizeof(*ptr),
+			   GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	tzd = thermal_of_zone_register(dev->of_node, sensor_id, data, ops);
+	if (IS_ERR(tzd)) {
+		devres_free(ptr);
+		return tzd;
+	}
+
+	*ptr = tzd;
+	devres_add(dev, ptr);
+
+	return tzd;
+}
+EXPORT_SYMBOL_GPL(devm_thermal_of_zone_register);
+
+/**
+ * devm_thermal_of_zone_unregister - Resource managed version of
+ *				thermal_of_zone_unregister().
+ * @dev: Device for which which resource was allocated.
+ * @tz: a pointer to struct thermal_zone where the sensor is registered.
+ *
+ * This function removes the sensor callbacks and private data from the
+ * thermal zone device registered with devm_thermal_zone_of_sensor_register()
+ * API. It will also silent the zone by remove the .get_temp() and .get_trend()
+ * thermal zone device callbacks.
+ * Normally this function will not need to be called and the resource
+ * management code will ensure that the resource is freed.
+ */
+void devm_thermal_of_zone_unregister(struct device *dev, struct thermal_zone_device *tz)
+{
+	WARN_ON(devres_release(dev, devm_thermal_zone_of_sensor_release,
+			       devm_thermal_of_zone_match, tz));
+}
+EXPORT_SYMBOL_GPL(devm_thermal_of_zone_unregister);
+
 /**
  * of_parse_thermal_zones - parse device tree thermal data
  *
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index fde4689a1755..0335aeec56ce 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -327,6 +327,16 @@ struct thermal_zone_of_device_ops {
 
 /* Function declarations */
 #ifdef CONFIG_THERMAL_OF
+struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor, int id, void *data,
+						     struct thermal_zone_device_ops *ops);
+
+struct thermal_zone_device *devm_thermal_of_zone_register(struct device *dev, int id, void *data,
+							  struct thermal_zone_device_ops *ops);
+
+void thermal_of_zone_unregister(struct thermal_zone_device *tz);
+	
+void devm_thermal_of_zone_unregister(struct device *dev, struct thermal_zone_device *tz);
+
 int thermal_zone_of_get_sensor_id(struct device_node *tz_np,
 				  struct device_node *sensor_np,
 				  u32 *id);
@@ -368,6 +378,14 @@ static inline struct thermal_zone_device *devm_thermal_zone_of_sensor_register(
 	return ERR_PTR(-ENODEV);
 }
 
+static inline void thermal_of_zone_unregister(struct thermal_zone_device *tz)
+{
+}
+
+static inline void devm_thermal_of_zone_unregister(struct device *dev, struct thermal_zone_device *tz)
+{
+}
+
 static inline
 void devm_thermal_zone_of_sensor_unregister(struct device *dev,
 					    struct thermal_zone_device *tz)
-- 
2.25.1

