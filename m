Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F0056CF24
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 14:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiGJMgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 08:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiGJMfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 08:35:41 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB95B13DD9
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 05:35:33 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id y22-20020a7bcd96000000b003a2e2725e89so1295715wmj.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 05:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L3skzrLPntV9feVuTsato+Vtj+oVFJD2KdodKzkC6Z0=;
        b=sAEw6cqMT71U33e7SfvrJcyAd2gE6AbB0vJgY7xd/u/Wf5P7Hgv4HIFH8Mt4pPTBY0
         H9UwhD872eu7I05zlTmOX9jsuLJsZDjjJ1LRqKrn1NDYfKMmkU56VKQUJUjL5M7WBnkT
         1QaAyYFnQVv5YPzkOky3WVzZyA6XSwuSRhqV06xWzJtUnnBYjRsJoiQNLPM8ndVaihE5
         Wr1J6d4itq6U7yWXS3Dm+BJa8bCiy5a4ZUzkPLXZoaJcW4nkZnlPJ/z/LeY8HSZnOT1N
         rXLj1WPcg3HCbMFRxoU7L6z8Dp5trADaQG3vOi7apEGkXPR5E5tTYGd0lCfH6A9uHe6a
         EI7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L3skzrLPntV9feVuTsato+Vtj+oVFJD2KdodKzkC6Z0=;
        b=wM6Xk9+rzOVU55Rm6RsH707MRb/OmJd12ZWkeVqOnO1nJh/JIkEGIBL5vsxGXJbDGT
         WVkw51VKKAiYMirwV7ZJNIQIt1SJtw13bvODtv8BeKGPsnN0Ww3myHj5sJklMdxHy9+z
         b0s1Im1rWdxrKuEB7lRJ9dwL4zOYvl5EGfuJWFVOdbUu2S+o//yqB8RL7tJhhaOWw1Rx
         xHXhHUO0iK8B/4zqC03KRD1DeGVLr8iZs+CViNcuXSG/lLDBFBcRAoySeuw/CwEb46LJ
         Ps61qcl2cROXawmp2H999lnBGU0ajQKTihYrqfq42MmWq0v5yXV/rL/AaBysNNz4cgkp
         TcTg==
X-Gm-Message-State: AJIora+/EJGFmGO6gbmNVL0dWSpCj3GlXiVqrVFodL+V9QqhomC+OV6A
        lGnRodTZ0CXfy08/8KL4FmheFw==
X-Google-Smtp-Source: AGRyM1vyUbaeoRaMhBmtCkfSXCX5V+7e9GTFAynDXwVIc5gIYTc+2A6USfeykIpaXMES3eiUTmijkw==
X-Received: by 2002:a05:600c:4f08:b0:3a1:99ed:4f1f with SMTP id l8-20020a05600c4f0800b003a199ed4f1fmr10121049wmq.199.1657456532071;
        Sun, 10 Jul 2022 05:35:32 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 24-20020a05600c22d800b003a0375c4f73sm3775144wmg.44.2022.07.10.05.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 05:35:31 -0700 (PDT)
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
Subject: [PATCH v5 07/12] thermal/core: Rename 'trips' to 'num_trips'
Date:   Sun, 10 Jul 2022 14:35:07 +0200
Message-Id: <20220710123512.1714714-9-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220710123512.1714714-1-daniel.lezcano@linexp.org>
References: <20220710123512.1714714-1-daniel.lezcano@linexp.org>
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

