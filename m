Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E66E58A3B4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 00:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240373AbiHDW4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 18:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240408AbiHDWze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 18:55:34 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7A574DD1
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 15:53:15 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso3172969wma.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 15:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=SaWI06cWFQKgmERnibE1OWNcLwwTzmBHUDxX+/AClv8=;
        b=EwGY4yYAMgcyrhodebPiLYA95LucgFex9xQyyi/NHpZKCFdX89Oz+NM5mqVf8FIpr6
         F53WlgDUPQXreM68613Ge9n0fAwavJkw9+tPeDG51fFSQUUvzB/+6GhaO+nxfx8DDX92
         bbenr1LY7e2e2KYIANWYvOVGOpCV4ZyN5FsAc5mVFR+brBdhk0NyQEq6xm67+0XmKR/y
         lEedbTAbYVa8ZWwgyuXwAqAmGXN67pvYKcsaNmmClt+lWMqIX/ZHiTti0P6ekjqWxkGw
         AYg04hVxsSaCam925PCbOu9/KNdux1ZeUKQAlXS727Cvcy1S4UhkxCSdaAMvL28GbYGT
         IMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=SaWI06cWFQKgmERnibE1OWNcLwwTzmBHUDxX+/AClv8=;
        b=rPtYx4Shjg1BXS2LpcYuRGLWYkI77wnS71YAtFQsME7qLTKBn8iQsmRqxlZO6yawe7
         8j0M0855i+lSh7iHZMcn3BiFfgh1VwKFXYu7TJqhncQqlcA+HLhy6biXwvqhvjH8dEaf
         rCaa13A1whGgFopIGdCz3jcDZHvQ4lS8p56X99+GdgHDsJj87OoohYvSUTzSfgVB/R3o
         E6f4Ljwl8L4Zfo5hm7wJSN5m74Q7YljADB+157837HlrbWHHBGo6ZPIrCOVMHDoxPsIp
         +KhxEiMFakTEJTz6Ok7x0qGDPef2erHCj1W5REFBur/XC5EmITxnSwJOoLeeXUmfy94P
         91Ow==
X-Gm-Message-State: ACgBeo29Y5dHiZPCPoM+MbfKUwXzj3G26GbiG+QBKnQrSkTPJsl52qV9
        a2Ux+c9mtmR/e2GDA7yyxbOe1A==
X-Google-Smtp-Source: AA6agR62IMIgIGGGAdHSXEDOd69LuvukfCPJeLYvzYmvMTjmeGx8PXE51CdIV+ayFcbE9wOfWgN/qg==
X-Received: by 2002:a05:600c:3553:b0:3a3:2b65:299e with SMTP id i19-20020a05600c355300b003a32b65299emr7297769wmq.145.1659653593881;
        Thu, 04 Aug 2022 15:53:13 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:31aa:ed2c:3f7:19d])
        by smtp.gmail.com with ESMTPSA id a16-20020a056000051000b0021f87e8945asm2495906wrf.12.2022.08.04.15.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 15:53:13 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com, broonie@kernel.org,
        damien.lemoal@opensource.wdc.com, heiko@sntech.de,
        hayashi.kunihiko@socionext.com, mhiramat@kernel.org,
        talel@amazon.com, thierry.reding@gmail.com, digetx@gmail.com,
        jonathanh@nvidia.com, anarsoul@gmail.com, tiny.windzz@gmail.com,
        baolin.wang7@gmail.com, f.fainelli@gmail.com,
        bjorn.andersson@linaro.org, mcoquelin.stm32@gmail.com,
        glaroque@baylibre.com, miquel.raynal@bootlin.com,
        shawnguo@kernel.org, niklas.soderlund@ragnatech.se,
        matthias.bgg@gmail.com, j-keerthy@ti.com,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v5 33/33] thermal/of: Remove old OF code
Date:   Fri,  5 Aug 2022 00:43:49 +0200
Message-Id: <20220804224349.1926752-34-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
References: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the drivers are converted to the new OF API, remove the old OF code.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/thermal_core.h |   2 -
 drivers/thermal/thermal_of.c   | 810 +--------------------------------
 include/linux/thermal.h        |  77 +---
 3 files changed, 16 insertions(+), 873 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index c991bb290512..2241d2dce017 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -135,13 +135,11 @@ thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
 
 /* device tree support */
 #ifdef CONFIG_THERMAL_OF
-int of_parse_thermal_zones(void);
 int of_thermal_get_ntrips(struct thermal_zone_device *);
 bool of_thermal_is_trip_valid(struct thermal_zone_device *, int);
 const struct thermal_trip *
 of_thermal_get_trip_points(struct thermal_zone_device *);
 #else
-static inline int of_parse_thermal_zones(void) { return 0; }
 static inline int of_thermal_get_ntrips(struct thermal_zone_device *tz)
 {
 	return 0;
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 403064fed438..4a036129ae5e 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -19,93 +19,6 @@
 
 #include "thermal_core.h"
 
-/***   Private data structures to represent thermal device tree data ***/
-
-/**
- * struct __thermal_cooling_bind_param - a cooling device for a trip point
- * @cooling_device: a pointer to identify the referred cooling device
- * @min: minimum cooling state used at this trip point
- * @max: maximum cooling state used at this trip point
- */
-
-struct __thermal_cooling_bind_param {
-	struct device_node *cooling_device;
-	unsigned long min;
-	unsigned long max;
-};
-
-/**
- * struct __thermal_bind_params - a match between trip and cooling device
- * @tcbp: a pointer to an array of cooling devices
- * @count: number of elements in array
- * @trip_id: the trip point index
- * @usage: the percentage (from 0 to 100) of cooling contribution
- */
-
-struct __thermal_bind_params {
-	struct __thermal_cooling_bind_param *tcbp;
-	unsigned int count;
-	unsigned int trip_id;
-	unsigned int usage;
-};
-
-/**
- * struct __thermal_zone - internal representation of a thermal zone
- * @passive_delay: polling interval while passive cooling is activated
- * @polling_delay: zone polling interval
- * @slope: slope of the temperature adjustment curve
- * @offset: offset of the temperature adjustment curve
- * @ntrips: number of trip points
- * @trips: an array of trip points (0..ntrips - 1)
- * @num_tbps: number of thermal bind params
- * @tbps: an array of thermal bind params (0..num_tbps - 1)
- * @sensor_data: sensor private data used while reading temperature and trend
- * @ops: set of callbacks to handle the thermal zone based on DT
- */
-
-struct __thermal_zone {
-	int passive_delay;
-	int polling_delay;
-	int slope;
-	int offset;
-
-	/* trip data */
-	int ntrips;
-	struct thermal_trip *trips;
-
-	/* cooling binding data */
-	int num_tbps;
-	struct __thermal_bind_params *tbps;
-
-	/* sensor interface */
-	void *sensor_data;
-	const struct thermal_zone_of_device_ops *ops;
-};
-
-/***   DT thermal zone device callbacks   ***/
-
-static int of_thermal_get_temp(struct thermal_zone_device *tz,
-			       int *temp)
-{
-	struct __thermal_zone *data = tz->devdata;
-
-	if (!data->ops || !data->ops->get_temp)
-		return -EINVAL;
-
-	return data->ops->get_temp(data->sensor_data, temp);
-}
-
-static int of_thermal_set_trips(struct thermal_zone_device *tz,
-				int low, int high)
-{
-	struct __thermal_zone *data = tz->devdata;
-
-	if (!data->ops || !data->ops->set_trips)
-		return -EINVAL;
-
-	return data->ops->set_trips(data->sensor_data, low, high);
-}
-
 /**
  * of_thermal_get_ntrips - function to export number of available trip
  *			   points.
@@ -158,114 +71,6 @@ of_thermal_get_trip_points(struct thermal_zone_device *tz)
 }
 EXPORT_SYMBOL_GPL(of_thermal_get_trip_points);
 
-/**
- * of_thermal_set_emul_temp - function to set emulated temperature
- *
- * @tz:	pointer to a thermal zone
- * @temp:	temperature to set
- *
- * This function gives the ability to set emulated value of temperature,
- * which is handy for debugging
- *
- * Return: zero on success, error code otherwise
- */
-static int of_thermal_set_emul_temp(struct thermal_zone_device *tz,
-				    int temp)
-{
-	struct __thermal_zone *data = tz->devdata;
-
-	if (!data->ops || !data->ops->set_emul_temp)
-		return -EINVAL;
-
-	return data->ops->set_emul_temp(data->sensor_data, temp);
-}
-
-static int of_thermal_get_trend(struct thermal_zone_device *tz, int trip,
-				enum thermal_trend *trend)
-{
-	struct __thermal_zone *data = tz->devdata;
-
-	if (!data->ops || !data->ops->get_trend)
-		return -EINVAL;
-
-	return data->ops->get_trend(data->sensor_data, trip, trend);
-}
-
-static int of_thermal_change_mode(struct thermal_zone_device *tz,
-				enum thermal_device_mode mode)
-{
-	struct __thermal_zone *data = tz->devdata;
-
-	return data->ops->change_mode(data->sensor_data, mode);
-}
-
-static int of_thermal_bind(struct thermal_zone_device *thermal,
-			   struct thermal_cooling_device *cdev)
-{
-	struct __thermal_zone *data = thermal->devdata;
-	struct __thermal_bind_params *tbp;
-	struct __thermal_cooling_bind_param *tcbp;
-	int i, j;
-
-	if (!data || IS_ERR(data))
-		return -ENODEV;
-
-	/* find where to bind */
-	for (i = 0; i < data->num_tbps; i++) {
-		tbp = data->tbps + i;
-
-		for (j = 0; j < tbp->count; j++) {
-			tcbp = tbp->tcbp + j;
-
-			if (tcbp->cooling_device == cdev->np) {
-				int ret;
-
-				ret = thermal_zone_bind_cooling_device(thermal,
-						tbp->trip_id, cdev,
-						tcbp->max,
-						tcbp->min,
-						tbp->usage);
-				if (ret)
-					return ret;
-			}
-		}
-	}
-
-	return 0;
-}
-
-static int of_thermal_unbind(struct thermal_zone_device *thermal,
-			     struct thermal_cooling_device *cdev)
-{
-	struct __thermal_zone *data = thermal->devdata;
-	struct __thermal_bind_params *tbp;
-	struct __thermal_cooling_bind_param *tcbp;
-	int i, j;
-
-	if (!data || IS_ERR(data))
-		return -ENODEV;
-
-	/* find where to unbind */
-	for (i = 0; i < data->num_tbps; i++) {
-		tbp = data->tbps + i;
-
-		for (j = 0; j < tbp->count; j++) {
-			tcbp = tbp->tcbp + j;
-
-			if (tcbp->cooling_device == cdev->np) {
-				int ret;
-
-				ret = thermal_zone_unbind_cooling_device(thermal,
-							tbp->trip_id, cdev);
-				if (ret)
-					return ret;
-			}
-		}
-	}
-
-	return 0;
-}
-
 static int of_thermal_get_trip_type(struct thermal_zone_device *tz, int trip,
 				    enum thermal_trip_type *type)
 {
@@ -325,61 +130,6 @@ static int of_thermal_get_crit_temp(struct thermal_zone_device *tz,
 	return -EINVAL;
 }
 
-static struct thermal_zone_device_ops of_thermal_ops = {
-	.get_trip_type = of_thermal_get_trip_type,
-	.get_trip_temp = of_thermal_get_trip_temp,
-	.get_trip_hyst = of_thermal_get_trip_hyst,
-	.set_trip_hyst = of_thermal_set_trip_hyst,
-	.get_crit_temp = of_thermal_get_crit_temp,
-
-	.bind = of_thermal_bind,
-	.unbind = of_thermal_unbind,
-};
-
-/***   sensor API   ***/
-
-static struct thermal_zone_device *
-thermal_zone_of_add_sensor(struct device_node *zone,
-			   struct device_node *sensor, void *data,
-			   const struct thermal_zone_of_device_ops *ops)
-{
-	struct thermal_zone_device *tzd;
-	struct __thermal_zone *tz;
-
-	tzd = thermal_zone_get_zone_by_name(zone->name);
-	if (IS_ERR(tzd))
-		return ERR_PTR(-EPROBE_DEFER);
-
-	tz = tzd->devdata;
-
-	if (!ops)
-		return ERR_PTR(-EINVAL);
-
-	mutex_lock(&tzd->lock);
-	tz->ops = ops;
-	tz->sensor_data = data;
-
-	tzd->ops->get_temp = of_thermal_get_temp;
-	tzd->ops->get_trend = of_thermal_get_trend;
-
-	/*
-	 * The thermal zone core will calculate the window if they have set the
-	 * optional set_trips pointer.
-	 */
-	if (ops->set_trips)
-		tzd->ops->set_trips = of_thermal_set_trips;
-
-	if (ops->set_emul_temp)
-		tzd->ops->set_emul_temp = of_thermal_set_emul_temp;
-
-	if (ops->change_mode)
-		tzd->ops->change_mode = of_thermal_change_mode;
-
-	mutex_unlock(&tzd->lock);
-
-	return tzd;
-}
-
 /**
  * thermal_zone_of_get_sensor_id - get sensor ID from a DT thermal zone
  * @tz_np: a valid thermal zone device node.
@@ -424,216 +174,6 @@ int thermal_zone_of_get_sensor_id(struct device_node *tz_np,
 }
 EXPORT_SYMBOL_GPL(thermal_zone_of_get_sensor_id);
 
-/**
- * thermal_zone_of_sensor_register - registers a sensor to a DT thermal zone
- * @dev: a valid struct device pointer of a sensor device. Must contain
- *       a valid .of_node, for the sensor node.
- * @sensor_id: a sensor identifier, in case the sensor IP has more
- *             than one sensors
- * @data: a private pointer (owned by the caller) that will be passed
- *        back, when a temperature reading is needed.
- * @ops: struct thermal_zone_of_device_ops *. Must contain at least .get_temp.
- *
- * This function will search the list of thermal zones described in device
- * tree and look for the zone that refer to the sensor device pointed by
- * @dev->of_node as temperature providers. For the zone pointing to the
- * sensor node, the sensor will be added to the DT thermal zone device.
- *
- * The thermal zone temperature is provided by the @get_temp function
- * pointer. When called, it will have the private pointer @data back.
- *
- * The thermal zone temperature trend is provided by the @get_trend function
- * pointer. When called, it will have the private pointer @data back.
- *
- * TODO:
- * 01 - This function must enqueue the new sensor instead of using
- * it as the only source of temperature values.
- *
- * 02 - There must be a way to match the sensor with all thermal zones
- * that refer to it.
- *
- * Return: On success returns a valid struct thermal_zone_device,
- * otherwise, it returns a corresponding ERR_PTR(). Caller must
- * check the return value with help of IS_ERR() helper.
- */
-struct thermal_zone_device *
-thermal_zone_of_sensor_register(struct device *dev, int sensor_id, void *data,
-				const struct thermal_zone_of_device_ops *ops)
-{
-	struct device_node *np, *child, *sensor_np;
-	struct thermal_zone_device *tzd = ERR_PTR(-ENODEV);
-	static int old_tz_initialized;
-	int ret;
-
-	if (!old_tz_initialized) {
-		ret = of_parse_thermal_zones();
-		if (ret)
-			return ERR_PTR(ret);
-		old_tz_initialized = 1;
-	}
-
-	np = of_find_node_by_name(NULL, "thermal-zones");
-	if (!np)
-		return ERR_PTR(-ENODEV);
-
-	if (!dev || !dev->of_node) {
-		of_node_put(np);
-		return ERR_PTR(-ENODEV);
-	}
-
-	sensor_np = of_node_get(dev->of_node);
-
-	for_each_available_child_of_node(np, child) {
-		int ret, id;
-
-		/* For now, thermal framework supports only 1 sensor per zone */
-		ret = thermal_zone_of_get_sensor_id(child, sensor_np, &id);
-		if (ret)
-			continue;
-
-		if (id == sensor_id) {
-			tzd = thermal_zone_of_add_sensor(child, sensor_np,
-							 data, ops);
-			if (!IS_ERR(tzd))
-				thermal_zone_device_enable(tzd);
-
-			of_node_put(child);
-			goto exit;
-		}
-	}
-exit:
-	of_node_put(sensor_np);
-	of_node_put(np);
-
-	return tzd;
-}
-EXPORT_SYMBOL_GPL(thermal_zone_of_sensor_register);
-
-/**
- * thermal_zone_of_sensor_unregister - unregisters a sensor from a DT thermal zone
- * @dev: a valid struct device pointer of a sensor device. Must contain
- *       a valid .of_node, for the sensor node.
- * @tzd: a pointer to struct thermal_zone_device where the sensor is registered.
- *
- * This function removes the sensor callbacks and private data from the
- * thermal zone device registered with thermal_zone_of_sensor_register()
- * API. It will also silent the zone by remove the .get_temp() and .get_trend()
- * thermal zone device callbacks.
- *
- * TODO: When the support to several sensors per zone is added, this
- * function must search the sensor list based on @dev parameter.
- *
- */
-void thermal_zone_of_sensor_unregister(struct device *dev,
-				       struct thermal_zone_device *tzd)
-{
-	struct __thermal_zone *tz;
-
-	if (!dev || !tzd || !tzd->devdata)
-		return;
-
-	tz = tzd->devdata;
-
-	/* no __thermal_zone, nothing to be done */
-	if (!tz)
-		return;
-
-	/* stop temperature polling */
-	thermal_zone_device_disable(tzd);
-
-	mutex_lock(&tzd->lock);
-	tzd->ops->get_temp = NULL;
-	tzd->ops->get_trend = NULL;
-	tzd->ops->set_emul_temp = NULL;
-	tzd->ops->change_mode = NULL;
-
-	tz->ops = NULL;
-	tz->sensor_data = NULL;
-	mutex_unlock(&tzd->lock);
-}
-EXPORT_SYMBOL_GPL(thermal_zone_of_sensor_unregister);
-
-static void devm_thermal_zone_of_sensor_release(struct device *dev, void *res)
-{
-	thermal_zone_of_sensor_unregister(dev,
-					  *(struct thermal_zone_device **)res);
-}
-
-static int devm_thermal_zone_of_sensor_match(struct device *dev, void *res,
-					     void *data)
-{
-	struct thermal_zone_device **r = res;
-
-	if (WARN_ON(!r || !*r))
-		return 0;
-
-	return *r == data;
-}
-
-/**
- * devm_thermal_zone_of_sensor_register - Resource managed version of
- *				thermal_zone_of_sensor_register()
- * @dev: a valid struct device pointer of a sensor device. Must contain
- *       a valid .of_node, for the sensor node.
- * @sensor_id: a sensor identifier, in case the sensor IP has more
- *	       than one sensors
- * @data: a private pointer (owned by the caller) that will be passed
- *	  back, when a temperature reading is needed.
- * @ops: struct thermal_zone_of_device_ops *. Must contain at least .get_temp.
- *
- * Refer thermal_zone_of_sensor_register() for more details.
- *
- * Return: On success returns a valid struct thermal_zone_device,
- * otherwise, it returns a corresponding ERR_PTR(). Caller must
- * check the return value with help of IS_ERR() helper.
- * Registered thermal_zone_device device will automatically be
- * released when device is unbounded.
- */
-struct thermal_zone_device *devm_thermal_zone_of_sensor_register(
-	struct device *dev, int sensor_id,
-	void *data, const struct thermal_zone_of_device_ops *ops)
-{
-	struct thermal_zone_device **ptr, *tzd;
-
-	ptr = devres_alloc(devm_thermal_zone_of_sensor_release, sizeof(*ptr),
-			   GFP_KERNEL);
-	if (!ptr)
-		return ERR_PTR(-ENOMEM);
-
-	tzd = thermal_zone_of_sensor_register(dev, sensor_id, data, ops);
-	if (IS_ERR(tzd)) {
-		devres_free(ptr);
-		return tzd;
-	}
-
-	*ptr = tzd;
-	devres_add(dev, ptr);
-
-	return tzd;
-}
-EXPORT_SYMBOL_GPL(devm_thermal_zone_of_sensor_register);
-
-/**
- * devm_thermal_zone_of_sensor_unregister - Resource managed version of
- *				thermal_zone_of_sensor_unregister().
- * @dev: Device for which which resource was allocated.
- * @tzd: a pointer to struct thermal_zone_device where the sensor is registered.
- *
- * This function removes the sensor callbacks and private data from the
- * thermal zone device registered with devm_thermal_zone_of_sensor_register()
- * API. It will also silent the zone by remove the .get_temp() and .get_trend()
- * thermal zone device callbacks.
- * Normally this function will not need to be called and the resource
- * management code will ensure that the resource is freed.
- */
-void devm_thermal_zone_of_sensor_unregister(struct device *dev,
-					    struct thermal_zone_device *tzd)
-{
-	WARN_ON(devres_release(dev, devm_thermal_zone_of_sensor_release,
-			       devm_thermal_zone_of_sensor_match, tzd));
-}
-EXPORT_SYMBOL_GPL(devm_thermal_zone_of_sensor_unregister);
-
 /***   functions parsing device tree nodes   ***/
 
 static int of_find_trip_id(struct device_node *np, struct device_node *trip)
@@ -665,98 +205,6 @@ static int of_find_trip_id(struct device_node *np, struct device_node *trip)
 	return i;
 }
 
-/**
- * thermal_of_populate_bind_params - parse and fill cooling map data
- * @np: DT node containing a cooling-map node
- * @__tbp: data structure to be filled with cooling map info
- * @trips: array of thermal zone trip points
- * @ntrips: number of trip points inside trips.
- *
- * This function parses a cooling-map type of node represented by
- * @np parameter and fills the read data into @__tbp data structure.
- * It needs the already parsed array of trip points of the thermal zone
- * in consideration.
- *
- * Return: 0 on success, proper error code otherwise
- */
-static int thermal_of_populate_bind_params(struct device_node *tz_np,
-					   struct device_node *np,
-					   struct __thermal_bind_params *__tbp)
-{
-	struct of_phandle_args cooling_spec;
-	struct __thermal_cooling_bind_param *__tcbp;
-	struct device_node *trip;
-	int ret, i, count;
-	int trip_id;
-	u32 prop;
-
-	/* Default weight. Usage is optional */
-	__tbp->usage = THERMAL_WEIGHT_DEFAULT;
-	ret = of_property_read_u32(np, "contribution", &prop);
-	if (ret == 0)
-		__tbp->usage = prop;
-
-	trip = of_parse_phandle(np, "trip", 0);
-	if (!trip) {
-		pr_err("missing trip property\n");
-		return -ENODEV;
-	}
-
-	trip_id = of_find_trip_id(tz_np, trip);
-	if (trip_id < 0) {
-		ret = trip_id;
-		goto end;
-	}
-
-	__tbp->trip_id = trip_id;
-
-	count = of_count_phandle_with_args(np, "cooling-device",
-					   "#cooling-cells");
-	if (count <= 0) {
-		pr_err("Add a cooling_device property with at least one device\n");
-		ret = -ENOENT;
-		goto end;
-	}
-
-	__tcbp = kcalloc(count, sizeof(*__tcbp), GFP_KERNEL);
-	if (!__tcbp) {
-		ret = -ENOMEM;
-		goto end;
-	}
-
-	for (i = 0; i < count; i++) {
-		ret = of_parse_phandle_with_args(np, "cooling-device",
-				"#cooling-cells", i, &cooling_spec);
-		if (ret < 0) {
-			pr_err("Invalid cooling-device entry\n");
-			goto free_tcbp;
-		}
-
-		__tcbp[i].cooling_device = cooling_spec.np;
-
-		if (cooling_spec.args_count >= 2) { /* at least min and max */
-			__tcbp[i].min = cooling_spec.args[0];
-			__tcbp[i].max = cooling_spec.args[1];
-		} else {
-			pr_err("wrong reference to cooling device, missing limits\n");
-		}
-	}
-
-	__tbp->tcbp = __tcbp;
-	__tbp->count = count;
-
-	goto end;
-
-free_tcbp:
-	for (i = i - 1; i >= 0; i--)
-		of_node_put(__tcbp[i].cooling_device);
-	kfree(__tcbp);
-end:
-	of_node_put(trip);
-
-	return ret;
-}
-
 /*
  * It maps 'enum thermal_trip_type' found in include/linux/thermal.h
  * into the device tree binding of 'trip', property type.
@@ -873,174 +321,6 @@ static struct thermal_trip *thermal_of_trips_init(struct device_node *np, int *n
 	return ERR_PTR(ret);
 }
 
-/**
- * thermal_of_build_thermal_zone - parse and fill one thermal zone data
- * @np: DT node containing a thermal zone node
- *
- * This function parses a thermal zone type of node represented by
- * @np parameter and fills the read data into a __thermal_zone data structure
- * and return this pointer.
- *
- * TODO: Missing properties to parse: thermal-sensor-names
- *
- * Return: On success returns a valid struct __thermal_zone,
- * otherwise, it returns a corresponding ERR_PTR(). Caller must
- * check the return value with help of IS_ERR() helper.
- */
-static struct __thermal_zone
-__init *thermal_of_build_thermal_zone(struct device_node *np)
-{
-	struct device_node *child = NULL, *gchild;
-	struct __thermal_zone *tz;
-	int ret, i;
-	u32 prop, coef[2];
-
-	if (!np) {
-		pr_err("no thermal zone np\n");
-		return ERR_PTR(-EINVAL);
-	}
-
-	tz = kzalloc(sizeof(*tz), GFP_KERNEL);
-	if (!tz)
-		return ERR_PTR(-ENOMEM);
-
-	ret = of_property_read_u32(np, "polling-delay-passive", &prop);
-	if (ret < 0) {
-		pr_err("%pOFn: missing polling-delay-passive property\n", np);
-		goto free_tz;
-	}
-	tz->passive_delay = prop;
-
-	ret = of_property_read_u32(np, "polling-delay", &prop);
-	if (ret < 0) {
-		pr_err("%pOFn: missing polling-delay property\n", np);
-		goto free_tz;
-	}
-	tz->polling_delay = prop;
-
-	/*
-	 * REVIST: for now, the thermal framework supports only
-	 * one sensor per thermal zone. Thus, we are considering
-	 * only the first two values as slope and offset.
-	 */
-	ret = of_property_read_u32_array(np, "coefficients", coef, 2);
-	if (ret == 0) {
-		tz->slope = coef[0];
-		tz->offset = coef[1];
-	} else {
-		tz->slope = 1;
-		tz->offset = 0;
-	}
-
-	tz->trips = thermal_of_trips_init(np, &tz->ntrips);
-	if (IS_ERR(tz->trips)) {
-		ret = PTR_ERR(tz->trips);
-		goto finish;
-	}
-
-	/* cooling-maps */
-	child = of_get_child_by_name(np, "cooling-maps");
-
-	/* cooling-maps not provided */
-	if (!child)
-		goto finish;
-
-	tz->num_tbps = of_get_child_count(child);
-	if (tz->num_tbps == 0)
-		goto finish;
-
-	tz->tbps = kcalloc(tz->num_tbps, sizeof(*tz->tbps), GFP_KERNEL);
-	if (!tz->tbps) {
-		ret = -ENOMEM;
-		goto free_trips;
-	}
-
-	i = 0;
-	for_each_child_of_node(child, gchild) {
-		ret = thermal_of_populate_bind_params(np, gchild, &tz->tbps[i++]);
-		if (ret) {
-			of_node_put(gchild);
-			goto free_tbps;
-		}
-	}
-
-finish:
-	of_node_put(child);
-
-	return tz;
-
-free_tbps:
-	for (i = i - 1; i >= 0; i--) {
-		struct __thermal_bind_params *tbp = tz->tbps + i;
-		int j;
-
-		for (j = 0; j < tbp->count; j++)
-			of_node_put(tbp->tcbp[j].cooling_device);
-
-		kfree(tbp->tcbp);
-	}
-
-	kfree(tz->tbps);
-free_trips:
-	kfree(tz->trips);
-free_tz:
-	kfree(tz);
-	of_node_put(child);
-
-	return ERR_PTR(ret);
-}
-
-static void of_thermal_free_zone(struct __thermal_zone *tz)
-{
-	struct __thermal_bind_params *tbp;
-	int i, j;
-
-	for (i = 0; i < tz->num_tbps; i++) {
-		tbp = tz->tbps + i;
-
-		for (j = 0; j < tbp->count; j++)
-			of_node_put(tbp->tcbp[j].cooling_device);
-
-		kfree(tbp->tcbp);
-	}
-
-	kfree(tz->tbps);
-	kfree(tz->trips);
-	kfree(tz);
-}
-
-/**
- * of_thermal_destroy_zones - remove all zones parsed and allocated resources
- *
- * Finds all zones parsed and added to the thermal framework and remove them
- * from the system, together with their resources.
- *
- */
-static __init void of_thermal_destroy_zones(void)
-{
-	struct device_node *np, *child;
-
-	np = of_find_node_by_name(NULL, "thermal-zones");
-	if (!np) {
-		pr_debug("unable to find thermal zones\n");
-		return;
-	}
-
-	for_each_available_child_of_node(np, child) {
-		struct thermal_zone_device *zone;
-
-		zone = thermal_zone_get_zone_by_name(child->name);
-		if (IS_ERR(zone))
-			continue;
-
-		thermal_zone_device_unregister(zone);
-		kfree(zone->tzp);
-		kfree(zone->ops);
-		of_thermal_free_zone(zone->devdata);
-	}
-	of_node_put(np);
-}
-
 static struct device_node *of_thermal_zone_find(struct device_node *sensor, int id)
 {
 	struct device_node *np, *tz;
@@ -1486,95 +766,7 @@ EXPORT_SYMBOL_GPL(devm_thermal_of_zone_register);
  */
 void devm_thermal_of_zone_unregister(struct device *dev, struct thermal_zone_device *tz)
 {
-	WARN_ON(devres_release(dev, devm_thermal_zone_of_sensor_release,
+	WARN_ON(devres_release(dev, devm_thermal_of_zone_release,
 			       devm_thermal_of_zone_match, tz));
 }
 EXPORT_SYMBOL_GPL(devm_thermal_of_zone_unregister);
-
-/**
- * of_parse_thermal_zones - parse device tree thermal data
- *
- * Initialization function that can be called by machine initialization
- * code to parse thermal data and populate the thermal framework
- * with hardware thermal zones info. This function only parses thermal zones.
- * Cooling devices and sensor devices nodes are supposed to be parsed
- * by their respective drivers.
- *
- * Return: 0 on success, proper error code otherwise
- *
- */
-int of_parse_thermal_zones(void)
-{
-	struct device_node *np, *child;
-	struct __thermal_zone *tz;
-	struct thermal_zone_device_ops *ops;
-
-	np = of_find_node_by_name(NULL, "thermal-zones");
-	if (!np) {
-		pr_debug("unable to find thermal zones\n");
-		return 0; /* Run successfully on systems without thermal DT */
-	}
-
-	for_each_available_child_of_node(np, child) {
-		struct thermal_zone_device *zone;
-		struct thermal_zone_params *tzp;
-		int i, mask = 0;
-		u32 prop;
-
-		tz = thermal_of_build_thermal_zone(child);
-		if (IS_ERR(tz)) {
-			pr_err("failed to build thermal zone %pOFn: %ld\n",
-			       child,
-			       PTR_ERR(tz));
-			continue;
-		}
-
-		ops = kmemdup(&of_thermal_ops, sizeof(*ops), GFP_KERNEL);
-		if (!ops)
-			goto exit_free;
-
-		tzp = kzalloc(sizeof(*tzp), GFP_KERNEL);
-		if (!tzp) {
-			kfree(ops);
-			goto exit_free;
-		}
-
-		/* No hwmon because there might be hwmon drivers registering */
-		tzp->no_hwmon = true;
-
-		if (!of_property_read_u32(child, "sustainable-power", &prop))
-			tzp->sustainable_power = prop;
-
-		for (i = 0; i < tz->ntrips; i++)
-			mask |= 1 << i;
-
-		/* these two are left for temperature drivers to use */
-		tzp->slope = tz->slope;
-		tzp->offset = tz->offset;
-
-		zone = thermal_zone_device_register_with_trips(child->name, tz->trips, tz->ntrips,
-							       mask, tz, ops, tzp, tz->passive_delay,
-							       tz->polling_delay);
-		if (IS_ERR(zone)) {
-			pr_err("Failed to build %pOFn zone %ld\n", child,
-			       PTR_ERR(zone));
-			kfree(tzp);
-			kfree(ops);
-			of_thermal_free_zone(tz);
-			/* attempting to build remaining zones still */
-		}
-	}
-	of_node_put(np);
-
-	return 0;
-
-exit_free:
-	of_node_put(child);
-	of_node_put(np);
-	of_thermal_free_zone(tz);
-
-	/* no memory available, so free what we have built */
-	of_thermal_destroy_zones();
-
-	return -ENOMEM;
-}
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index e2ac9d473bd6..86c24ddd5985 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -296,33 +296,6 @@ struct thermal_zone_params {
 	int offset;
 };
 
-/**
- * struct thermal_zone_of_device_ops - callbacks for handling DT based zones
- *
- * Mandatory:
- * @get_temp: a pointer to a function that reads the sensor temperature.
- *
- * Optional:
- * @get_trend: a pointer to a function that reads the sensor temperature trend.
- * @set_trips: a pointer to a function that sets a temperature window. When
- *	       this window is left the driver must inform the thermal core via
- *	       thermal_zone_device_update.
- * @set_emul_temp: a pointer to a function that sets sensor emulated
- *		   temperature.
- * @set_trip_temp: a pointer to a function that sets the trip temperature on
- *		   hardware.
- * @change_mode: a pointer to a function that notifies the thermal zone
- *		   mode change.
- */
-struct thermal_zone_of_device_ops {
-	int (*get_temp)(void *, int *);
-	int (*get_trend)(void *, int, enum thermal_trend *);
-	int (*set_trips)(void *, int, int);
-	int (*set_emul_temp)(void *, int);
-	int (*set_trip_temp)(void *, int, int);
-	int (*change_mode) (void *, enum thermal_device_mode);
-};
-
 /* Function declarations */
 #ifdef CONFIG_THERMAL_OF
 struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor, int id, void *data,
@@ -335,61 +308,41 @@ void thermal_of_zone_unregister(struct thermal_zone_device *tz);
 
 void devm_thermal_of_zone_unregister(struct device *dev, struct thermal_zone_device *tz);
 
+void thermal_of_zone_unregister(struct thermal_zone_device *tz);
+
 int thermal_zone_of_get_sensor_id(struct device_node *tz_np,
 				  struct device_node *sensor_np,
 				  u32 *id);
-struct thermal_zone_device *
-thermal_zone_of_sensor_register(struct device *dev, int id, void *data,
-				const struct thermal_zone_of_device_ops *ops);
-void thermal_zone_of_sensor_unregister(struct device *dev,
-				       struct thermal_zone_device *tz);
-struct thermal_zone_device *devm_thermal_zone_of_sensor_register(
-		struct device *dev, int id, void *data,
-		const struct thermal_zone_of_device_ops *ops);
-void devm_thermal_zone_of_sensor_unregister(struct device *dev,
-					    struct thermal_zone_device *tz);
 #else
-
-static inline int thermal_zone_of_get_sensor_id(struct device_node *tz_np,
-					 struct device_node *sensor_np,
-					 u32 *id)
-{
-	return -ENOENT;
-}
-static inline struct thermal_zone_device *
-thermal_zone_of_sensor_register(struct device *dev, int id, void *data,
-				const struct thermal_zone_of_device_ops *ops)
-{
-	return ERR_PTR(-ENODEV);
-}
-
 static inline
-void thermal_zone_of_sensor_unregister(struct device *dev,
-				       struct thermal_zone_device *tz)
+struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor, int id, void *data,
+						     const struct thermal_zone_device_ops *ops)
 {
+	return ERR_PTR(-ENOTSUPP);
 }
 
-static inline struct thermal_zone_device *devm_thermal_zone_of_sensor_register(
-		struct device *dev, int id, void *data,
-		const struct thermal_zone_of_device_ops *ops)
+static inline
+struct thermal_zone_device *devm_thermal_of_zone_register(struct device *dev, int id, void *data,
+							  const struct thermal_zone_device_ops *ops)
 {
-	return ERR_PTR(-ENODEV);
+	return ERR_PTR(-ENOTSUPP);
 }
 
 static inline void thermal_of_zone_unregister(struct thermal_zone_device *tz)
 {
 }
 
-static inline void devm_thermal_of_zone_unregister(struct device *dev, struct thermal_zone_device *tz)
+static inline void devm_thermal_of_zone_unregister(struct device *dev,
+						   struct thermal_zone_device *tz)
 {
 }
 
-static inline
-void devm_thermal_zone_of_sensor_unregister(struct device *dev,
-					    struct thermal_zone_device *tz)
+static inline int thermal_zone_of_get_sensor_id(struct device_node *tz_np,
+						struct device_node *sensor_np,
+						u32 *id)
 {
+	return -ENOENT;
 }
-
 #endif
 
 #ifdef CONFIG_THERMAL
-- 
2.25.1

