Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C4057E7CF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 22:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236553AbiGVUBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 16:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236615AbiGVUAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 16:00:45 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EED88F33
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 13:00:43 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v13so93597wru.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 13:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L3skzrLPntV9feVuTsato+Vtj+oVFJD2KdodKzkC6Z0=;
        b=yb5QWNrkaYPA6uPzKR/BKpI1lwgqcVnv1vSF0SlbF2nBLUNoyNwZe05GtVa9viUHXB
         eGFdkGLJRDRD9CU2ri8gR4+rhxCoZwFiwEY97BQvguCJsp2kPU1HZIgT4PkC09htcev8
         MPpLwegdpyz3P8VMMU3qznBwaV97XKxAlNMnSU2I1Fc/MjObEx4Nmvp8Pyg2jmgiA4CL
         9VcoRqFiQLKPmGDsuQoyvvGrlyrmgzXDt2lyD/DWUQXLZLkMZg8ZVMIgXHF2AeOreTh4
         rkX03LzSibm5zvujmcOjHjCpa3O+ySlhBcF7Rfs6/N603T39qYgKQ7KVvsw8uwq+ioPc
         awUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L3skzrLPntV9feVuTsato+Vtj+oVFJD2KdodKzkC6Z0=;
        b=l79kla0X6vogYdnRwWK2Sd8vZfs866ZXxFFC7JP0L6LKl41vpesG/ht9AprJ72VsY2
         hTK3tIe7zR3Un4fjj4B6luNKkN02UK0NDwkPsTFFsv7ccyVfps3l0nrJi+li6CdwWdPH
         CDSfJvKUlTkBBBqggVV4Jxvuj0+v3o3UZLEEj6mwlU5Tzy2N5YmgbeEhFwRMgudMe1qR
         83CsGbarCAzu3bZd7zok6pWq6GiR+8N4FGTl8NUjYM7zXTjI+U4TdM5urMYRtvqWf6ZL
         o0eVVhEePW6OnkAFzWnTF9REeLZL27WjbsJMfZjfWE3oVpdyP4OxgW2XQlfV//e+CGkX
         sXXQ==
X-Gm-Message-State: AJIora9zu0P8wYqWf9eF8/f8sucS1j9i2j3n9N5jcDZohcq698NYf1h9
        vWVVIMNw6y//pVV2ZKEq1CMbYQ==
X-Google-Smtp-Source: AGRyM1s/lk344eDgcyuNvIHbsRB9tsYrqqjf2ojiuJAKUSC/SSLBnVRvNZQuGY2+68mY9rmFQC5jPQ==
X-Received: by 2002:adf:eed1:0:b0:21d:7052:278a with SMTP id a17-20020adfeed1000000b0021d7052278amr1014735wrp.170.1658520042394;
        Fri, 22 Jul 2022 13:00:42 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:957f:d36d:87f9:5c17])
        by smtp.gmail.com with ESMTPSA id k23-20020a05600c1c9700b003a31b00c216sm6429008wms.0.2022.07.22.13.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 13:00:42 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com,
        Amit Kucheria <amitk@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT)
Subject: [PATCH v6 07/10] thermal/core: Rename 'trips' to 'num_trips'
Date:   Fri, 22 Jul 2022 22:00:04 +0200
Message-Id: <20220722200007.1839356-8-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220722200007.1839356-1-daniel.lezcano@linexp.org>
References: <20220722200007.1839356-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to use thermal trips defined in the thermal structure, rename
the 'trips' field to 'num_trips' to have the 'trips' field containing the
thermal trip points.

Cc: Alexandre Bailon <abailon@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/gov_fair_share.c        |  6 +++---
 drivers/thermal/gov_power_allocator.c   |  4 ++--
 drivers/thermal/tegra/tegra30-tsensor.c |  2 +-
 drivers/thermal/thermal_core.c          | 20 ++++++++++----------
 drivers/thermal/thermal_helpers.c       |  4 ++--
 drivers/thermal/thermal_netlink.c       |  2 +-
 drivers/thermal/thermal_sysfs.c         | 22 +++++++++++-----------
 include/linux/thermal.h                 |  4 ++--
 8 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/thermal/gov_fair_share.c b/drivers/thermal/gov_fair_share.c
index 1e5abf4822be..6a2abcfc648f 100644
--- a/drivers/thermal/gov_fair_share.c
+++ b/drivers/thermal/gov_fair_share.c
@@ -25,10 +25,10 @@ static int get_trip_level(struct thermal_zone_device *tz)
 	int trip_temp;
 	enum thermal_trip_type trip_type;
 
-	if (tz->trips == 0 || !tz->ops->get_trip_temp)
+	if (tz->num_trips == 0 || !tz->ops->get_trip_temp)
 		return 0;
 
-	for (count = 0; count < tz->trips; count++) {
+	for (count = 0; count < tz->num_trips; count++) {
 		tz->ops->get_trip_temp(tz, count, &trip_temp);
 		if (tz->temperature < trip_temp)
 			break;
@@ -53,7 +53,7 @@ static long get_target_state(struct thermal_zone_device *tz,
 
 	cdev->ops->get_max_state(cdev, &max_state);
 
-	return (long)(percentage * level * max_state) / (100 * tz->trips);
+	return (long)(percentage * level * max_state) / (100 * tz->num_trips);
 }
 
 /**
diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 13e375751d22..1d5052470967 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -527,7 +527,7 @@ static void get_governor_trips(struct thermal_zone_device *tz,
 	last_active = INVALID_TRIP;
 	last_passive = INVALID_TRIP;
 
-	for (i = 0; i < tz->trips; i++) {
+	for (i = 0; i < tz->num_trips; i++) {
 		enum thermal_trip_type type;
 		int ret;
 
@@ -668,7 +668,7 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
 
 	get_governor_trips(tz, params);
 
-	if (tz->trips > 0) {
+	if (tz->num_trips > 0) {
 		ret = tz->ops->get_trip_temp(tz,
 					params->trip_max_desired_temperature,
 					&control_temp);
diff --git a/drivers/thermal/tegra/tegra30-tsensor.c b/drivers/thermal/tegra/tegra30-tsensor.c
index 9b6b693cbcf8..05886684f429 100644
--- a/drivers/thermal/tegra/tegra30-tsensor.c
+++ b/drivers/thermal/tegra/tegra30-tsensor.c
@@ -316,7 +316,7 @@ static void tegra_tsensor_get_hw_channel_trips(struct thermal_zone_device *tzd,
 	*hot_trip  = 85000;
 	*crit_trip = 90000;
 
-	for (i = 0; i < tzd->trips; i++) {
+	for (i = 0; i < tzd->num_trips; i++) {
 		enum thermal_trip_type type;
 		int trip_temp;
 
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index a8b1628937c6..cb9b1bd03bd3 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -505,7 +505,7 @@ void thermal_zone_device_update(struct thermal_zone_device *tz,
 
 	tz->notify_event = event;
 
-	for (count = 0; count < tz->trips; count++)
+	for (count = 0; count < tz->num_trips; count++)
 		handle_thermal_trip(tz, count);
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_update);
@@ -630,7 +630,7 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
 	unsigned long max_state;
 	int result, ret;
 
-	if (trip >= tz->trips || trip < 0)
+	if (trip >= tz->num_trips || trip < 0)
 		return -EINVAL;
 
 	list_for_each_entry(pos1, &thermal_tz_list, node) {
@@ -811,7 +811,7 @@ static void __bind(struct thermal_zone_device *tz, int mask,
 {
 	int i, ret;
 
-	for (i = 0; i < tz->trips; i++) {
+	for (i = 0; i < tz->num_trips; i++) {
 		if (mask & (1 << i)) {
 			unsigned long upper, lower;
 
@@ -1057,7 +1057,7 @@ static void __unbind(struct thermal_zone_device *tz, int mask,
 {
 	int i;
 
-	for (i = 0; i < tz->trips; i++)
+	for (i = 0; i < tz->num_trips; i++)
 		if (mask & (1 << i))
 			thermal_zone_unbind_cooling_device(tz, i, cdev);
 }
@@ -1169,7 +1169,7 @@ static void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms
 /**
  * thermal_zone_device_register() - register a new thermal zone device
  * @type:	the thermal zone device type
- * @trips:	the number of trip points the thermal zone support
+ * @num_trips:	the number of trip points the thermal zone support
  * @mask:	a bit string indicating the writeablility of trip points
  * @devdata:	private device data
  * @ops:	standard thermal zone device callbacks
@@ -1191,7 +1191,7 @@ static void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms
  * IS_ERR*() helpers.
  */
 struct thermal_zone_device *
-thermal_zone_device_register(const char *type, int trips, int mask,
+thermal_zone_device_register(const char *type, int num_trips, int mask,
 			     void *devdata, struct thermal_zone_device_ops *ops,
 			     struct thermal_zone_params *tzp, int passive_delay,
 			     int polling_delay)
@@ -1215,7 +1215,7 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (trips > THERMAL_MAX_TRIPS || trips < 0 || mask >> trips) {
+	if (num_trips > THERMAL_MAX_TRIPS || num_trips < 0 || mask >> num_trips) {
 		pr_err("Incorrect number of thermal trips\n");
 		return ERR_PTR(-EINVAL);
 	}
@@ -1225,7 +1225,7 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (trips > 0 && (!ops->get_trip_type || !ops->get_trip_temp))
+	if (num_trips > 0 && (!ops->get_trip_type || !ops->get_trip_temp))
 		return ERR_PTR(-EINVAL);
 
 	tz = kzalloc(sizeof(*tz), GFP_KERNEL);
@@ -1255,7 +1255,7 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 	tz->tzp = tzp;
 	tz->device.class = &thermal_class;
 	tz->devdata = devdata;
-	tz->trips = trips;
+	tz->num_trips = num_trips;
 
 	thermal_set_delay_jiffies(&tz->passive_delay_jiffies, passive_delay);
 	thermal_set_delay_jiffies(&tz->polling_delay_jiffies, polling_delay);
@@ -1273,7 +1273,7 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 	if (result)
 		goto release_device;
 
-	for (count = 0; count < trips; count++) {
+	for (count = 0; count < num_trips; count++) {
 		if (tz->ops->get_trip_type(tz, count, &trip_type) ||
 		    tz->ops->get_trip_temp(tz, count, &trip_temp) ||
 		    !trip_temp)
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 60bfda1a1db7..690890f054a3 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -89,7 +89,7 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 	ret = tz->ops->get_temp(tz, temp);
 
 	if (IS_ENABLED(CONFIG_THERMAL_EMULATION) && tz->emul_temperature) {
-		for (count = 0; count < tz->trips; count++) {
+		for (count = 0; count < tz->num_trips; count++) {
 			ret = tz->ops->get_trip_type(tz, count, &type);
 			if (!ret && type == THERMAL_TRIP_CRITICAL) {
 				ret = tz->ops->get_trip_temp(tz, count,
@@ -137,7 +137,7 @@ void thermal_zone_set_trips(struct thermal_zone_device *tz)
 	if (!tz->ops->set_trips || !tz->ops->get_trip_hyst)
 		goto exit;
 
-	for (i = 0; i < tz->trips; i++) {
+	for (i = 0; i < tz->num_trips; i++) {
 		int trip_low;
 
 		tz->ops->get_trip_temp(tz, i, &trip_temp);
diff --git a/drivers/thermal/thermal_netlink.c b/drivers/thermal/thermal_netlink.c
index 32fea5174cc0..050d243a5fa1 100644
--- a/drivers/thermal/thermal_netlink.c
+++ b/drivers/thermal/thermal_netlink.c
@@ -469,7 +469,7 @@ static int thermal_genl_cmd_tz_get_trip(struct param *p)
 
 	mutex_lock(&tz->lock);
 
-	for (i = 0; i < tz->trips; i++) {
+	for (i = 0; i < tz->num_trips; i++) {
 
 		enum thermal_trip_type type;
 		int temp, hyst = 0;
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 1c4aac8464a7..5018459e8dd9 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -416,15 +416,15 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 	int indx;
 
 	/* This function works only for zones with at least one trip */
-	if (tz->trips <= 0)
+	if (tz->num_trips <= 0)
 		return -EINVAL;
 
-	tz->trip_type_attrs = kcalloc(tz->trips, sizeof(*tz->trip_type_attrs),
+	tz->trip_type_attrs = kcalloc(tz->num_trips, sizeof(*tz->trip_type_attrs),
 				      GFP_KERNEL);
 	if (!tz->trip_type_attrs)
 		return -ENOMEM;
 
-	tz->trip_temp_attrs = kcalloc(tz->trips, sizeof(*tz->trip_temp_attrs),
+	tz->trip_temp_attrs = kcalloc(tz->num_trips, sizeof(*tz->trip_temp_attrs),
 				      GFP_KERNEL);
 	if (!tz->trip_temp_attrs) {
 		kfree(tz->trip_type_attrs);
@@ -432,7 +432,7 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 	}
 
 	if (tz->ops->get_trip_hyst) {
-		tz->trip_hyst_attrs = kcalloc(tz->trips,
+		tz->trip_hyst_attrs = kcalloc(tz->num_trips,
 					      sizeof(*tz->trip_hyst_attrs),
 					      GFP_KERNEL);
 		if (!tz->trip_hyst_attrs) {
@@ -442,7 +442,7 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 		}
 	}
 
-	attrs = kcalloc(tz->trips * 3 + 1, sizeof(*attrs), GFP_KERNEL);
+	attrs = kcalloc(tz->num_trips * 3 + 1, sizeof(*attrs), GFP_KERNEL);
 	if (!attrs) {
 		kfree(tz->trip_type_attrs);
 		kfree(tz->trip_temp_attrs);
@@ -451,7 +451,7 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 		return -ENOMEM;
 	}
 
-	for (indx = 0; indx < tz->trips; indx++) {
+	for (indx = 0; indx < tz->num_trips; indx++) {
 		/* create trip type attribute */
 		snprintf(tz->trip_type_attrs[indx].name, THERMAL_NAME_LENGTH,
 			 "trip_point_%d_type", indx);
@@ -478,7 +478,7 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 			tz->trip_temp_attrs[indx].attr.store =
 							trip_point_temp_store;
 		}
-		attrs[indx + tz->trips] = &tz->trip_temp_attrs[indx].attr.attr;
+		attrs[indx + tz->num_trips] = &tz->trip_temp_attrs[indx].attr.attr;
 
 		/* create Optional trip hyst attribute */
 		if (!tz->ops->get_trip_hyst)
@@ -496,10 +496,10 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 			tz->trip_hyst_attrs[indx].attr.store =
 					trip_point_hyst_store;
 		}
-		attrs[indx + tz->trips * 2] =
+		attrs[indx + tz->num_trips * 2] =
 					&tz->trip_hyst_attrs[indx].attr.attr;
 	}
-	attrs[tz->trips * 3] = NULL;
+	attrs[tz->num_trips * 3] = NULL;
 
 	tz->trips_attribute_group.attrs = attrs;
 
@@ -540,7 +540,7 @@ int thermal_zone_create_device_groups(struct thermal_zone_device *tz,
 	for (i = 0; i < size - 2; i++)
 		groups[i] = thermal_zone_attribute_groups[i];
 
-	if (tz->trips) {
+	if (tz->num_trips) {
 		result = create_trip_attrs(tz, mask);
 		if (result) {
 			kfree(groups);
@@ -561,7 +561,7 @@ void thermal_zone_destroy_device_groups(struct thermal_zone_device *tz)
 	if (!tz)
 		return;
 
-	if (tz->trips)
+	if (tz->num_trips)
 		destroy_trip_attrs(tz);
 
 	kfree(tz->device.groups);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 6289b0bb1c97..03e968d61471 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -125,7 +125,7 @@ struct thermal_cooling_device {
  * @trip_hyst_attrs:	attributes for trip points for sysfs: trip hysteresis
  * @mode:		current mode of this thermal zone
  * @devdata:	private pointer for device private data
- * @trips:	number of trip points the thermal zone supports
+ * @num_trips:	number of trip points the thermal zone supports
  * @trips_disabled;	bitmap for disabled trips
  * @passive_delay_jiffies: number of jiffies to wait between polls when
  *			performing passive cooling.
@@ -165,7 +165,7 @@ struct thermal_zone_device {
 	struct thermal_attr *trip_hyst_attrs;
 	enum thermal_device_mode mode;
 	void *devdata;
-	int trips;
+	int num_trips;
 	unsigned long trips_disabled;	/* bitmap for disabled trips */
 	unsigned long passive_delay_jiffies;
 	unsigned long polling_delay_jiffies;
-- 
2.25.1

