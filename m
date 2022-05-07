Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA8751E727
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 14:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446411AbiEGNAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 09:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385082AbiEGM7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 08:59:11 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994F341FA8
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 05:55:19 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id k2so13427024wrd.5
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 05:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WqbegEmN/3MMIh2FzQitK1Mjou+MS3mTIl/jHPLE9Hs=;
        b=FjJ6YRX6I9ycv0vXmv5vkjK3o1acDF+bjIY+9GRFL/w6IYyFqf4J1yGdOK6Vl7SO+p
         Y9x4k2NPJJxwx11nmbs5XvUURmg+knpxvGv69AK1L8GI0aCCaXO9QVwWdBB8+0u1v/c1
         beHb7UCH3XwfKyRYThZyJWWz1hqcuONa5wFfLX1UpTUvwTVLju5T4BvCPwW8+aBhUon6
         oC37jh0UPH2gfTf4Kl7Pnsfy+AHcdEmFjEbZuo0Tu7fsolXlIytqVh2V+NeDFu6mSmJ3
         DTwwxM+7/0bpt4XY7ztz25Asu4WHr/QYtmLStzlEYsO7lalnL6tVT+2ZhVf3P3gLFy6s
         stcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WqbegEmN/3MMIh2FzQitK1Mjou+MS3mTIl/jHPLE9Hs=;
        b=3BXWpM6FoaEkzOWwa9duqFXN2xcPLFiiLt3qsAkx6tx9pFrtE5k+gmozb65jxXrYdO
         Z+lPSwmtwVJnmXqT3ZnNdvthgHMDuMmHCJWCCVWOvO/1+HuqYP2l9Y/7ZdXSmy5yUTy5
         0koQDLPRF6xzu0geJf0bqsEhWCFxdVjcIAN3iqgeBVtyZ7Akgm+W5iUEDc7rTZxwN9e7
         n6nDYLVeU+mFtHB0aU4nEv1fsydaztqDT1xrTeOpCfvpl2TxjJ78FaCYWgl4FxB7Ww5p
         07iaEoWPgQy51E3/VU81IzfV81cnWVGXAmrKIIQSJbHqlEEXwQB0RSkFkVg0H2BysxL5
         n2BA==
X-Gm-Message-State: AOAM533mj/qLOmUZBHZ8O0ivZSG+mMdQAzmpI1sbmG+fg95xn1U1e2Xk
        FoY4kZ7aBXZVVbzJ+XC6t3hkXA==
X-Google-Smtp-Source: ABdhPJwpzsXPFfHpZKgUnXF6eHT+Otd6ftM4yJAPRkWcy+4RUfbKR597R8cjXN2b/S9kEpe/ZoTFIw==
X-Received: by 2002:adf:b1db:0:b0:20a:bcb5:6526 with SMTP id r27-20020adfb1db000000b0020abcb56526mr6872945wra.305.1651928118177;
        Sat, 07 May 2022 05:55:18 -0700 (PDT)
Received: from localhost.localdomain (static-176-182-171-101.ncc.abo.bbox.fr. [176.182.171.101])
        by smtp.gmail.com with ESMTPSA id e9-20020a05600c218900b0039453fe55a7sm10470345wme.35.2022.05.07.05.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 05:55:17 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     khilman@baylibre.com, abailon@baylibre.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT)
Subject: [PATCH v2 09/14] thermal/core: Rename trips to ntrips
Date:   Sat,  7 May 2022 14:54:37 +0200
Message-Id: <20220507125443.2766939-10-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220507125443.2766939-1-daniel.lezcano@linexp.org>
References: <20220507125443.2766939-1-daniel.lezcano@linexp.org>
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
the 'trips' field to 'ntrips' to have the 'trips' field containing the
thermal trip points.

Cc: Alexandre Bailon <abailon@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc; Eduardo Valentin <eduval@amazon.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/gov_fair_share.c        |  6 +++---
 drivers/thermal/gov_power_allocator.c   |  4 ++--
 drivers/thermal/tegra/tegra30-tsensor.c |  2 +-
 drivers/thermal/thermal_core.c          | 20 ++++++++++----------
 drivers/thermal/thermal_helpers.c       |  4 ++--
 drivers/thermal/thermal_netlink.c       |  2 +-
 drivers/thermal/thermal_sysfs.c         | 22 +++++++++++-----------
 include/linux/thermal.h                 |  2 +-
 8 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/thermal/gov_fair_share.c b/drivers/thermal/gov_fair_share.c
index a157c621da59..a5d95a69b033 100644
--- a/drivers/thermal/gov_fair_share.c
+++ b/drivers/thermal/gov_fair_share.c
@@ -25,10 +25,10 @@ static int get_trip_level(struct thermal_zone_device *tz)
 	int trip_temp;
 	enum thermal_trip_type trip_type;
 
-	if (tz->trips == 0 || !tz->sensor.ops->get_trip_temp)
+	if (tz->ntrips == 0 || !tz->sensor.ops->get_trip_temp)
 		return 0;
 
-	for (count = 0; count < tz->trips; count++) {
+	for (count = 0; count < tz->ntrips; count++) {
 		tz->sensor.ops->get_trip_temp(tz, count, &trip_temp);
 		if (tz->temperature < trip_temp)
 			break;
@@ -53,7 +53,7 @@ static long get_target_state(struct thermal_zone_device *tz,
 
 	cdev->ops->get_max_state(cdev, &max_state);
 
-	return (long)(percentage * level * max_state) / (100 * tz->trips);
+	return (long)(percentage * level * max_state) / (100 * tz->ntrips);
 }
 
 /**
diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index bcd146175f84..86d0e6cc4b6a 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -527,7 +527,7 @@ static void get_governor_trips(struct thermal_zone_device *tz,
 	last_active = INVALID_TRIP;
 	last_passive = INVALID_TRIP;
 
-	for (i = 0; i < tz->trips; i++) {
+	for (i = 0; i < tz->ntrips; i++) {
 		enum thermal_trip_type type;
 		int ret;
 
@@ -668,7 +668,7 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
 
 	get_governor_trips(tz, params);
 
-	if (tz->trips > 0) {
+	if (tz->ntrips > 0) {
 		ret = tz->sensor.ops->get_trip_temp(tz,
 						    params->trip_max_desired_temperature,
 						    &control_temp);
diff --git a/drivers/thermal/tegra/tegra30-tsensor.c b/drivers/thermal/tegra/tegra30-tsensor.c
index fab2709569c1..308646e0d8be 100644
--- a/drivers/thermal/tegra/tegra30-tsensor.c
+++ b/drivers/thermal/tegra/tegra30-tsensor.c
@@ -316,7 +316,7 @@ static void tegra_tsensor_get_hw_channel_trips(struct thermal_zone_device *tzd,
 	*hot_trip  = 85000;
 	*crit_trip = 90000;
 
-	for (i = 0; i < tzd->trips; i++) {
+	for (i = 0; i < tzd->ntrips; i++) {
 		enum thermal_trip_type type;
 		int trip_temp;
 
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 386453d46e94..f898032ec23a 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -505,7 +505,7 @@ void thermal_zone_device_update(struct thermal_zone_device *tz,
 
 	tz->notify_event = event;
 
-	for (count = 0; count < tz->trips; count++)
+	for (count = 0; count < tz->ntrips; count++)
 		handle_thermal_trip(tz, count);
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_update);
@@ -630,7 +630,7 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
 	unsigned long max_state;
 	int result, ret;
 
-	if (trip >= tz->trips || trip < 0)
+	if (trip >= tz->ntrips || trip < 0)
 		return -EINVAL;
 
 	list_for_each_entry(pos1, &thermal_tz_list, node) {
@@ -811,7 +811,7 @@ static void __bind(struct thermal_zone_device *tz, int mask,
 {
 	int i, ret;
 
-	for (i = 0; i < tz->trips; i++) {
+	for (i = 0; i < tz->ntrips; i++) {
 		if (mask & (1 << i)) {
 			unsigned long upper, lower;
 
@@ -1056,7 +1056,7 @@ static void __unbind(struct thermal_zone_device *tz, int mask,
 {
 	int i;
 
-	for (i = 0; i < tz->trips; i++)
+	for (i = 0; i < tz->ntrips; i++)
 		if (mask & (1 << i))
 			thermal_zone_unbind_cooling_device(tz, i, cdev);
 }
@@ -1168,7 +1168,7 @@ static void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms
 /**
  * thermal_zone_device_register() - register a new thermal zone device
  * @type:	the thermal zone device type
- * @trips:	the number of trip points the thermal zone support
+ * @ntrips:	the number of trip points the thermal zone support
  * @mask:	a bit string indicating the writeablility of trip points
  * @devdata:	private device data
  * @ops:	standard thermal zone device callbacks
@@ -1190,7 +1190,7 @@ static void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms
  * IS_ERR*() helpers.
  */
 struct thermal_zone_device *
-thermal_zone_device_register(const char *type, int trips, int mask,
+thermal_zone_device_register(const char *type, int ntrips, int mask,
 			     void *devdata, struct thermal_sensor_ops *ops,
 			     struct thermal_zone_params *tzp, int passive_delay,
 			     int polling_delay)
@@ -1214,7 +1214,7 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (trips > THERMAL_MAX_TRIPS || trips < 0 || mask >> trips) {
+	if (ntrips > THERMAL_MAX_TRIPS || ntrips < 0 || mask >> ntrips) {
 		pr_err("Incorrect number of thermal trips\n");
 		return ERR_PTR(-EINVAL);
 	}
@@ -1224,7 +1224,7 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (trips > 0 && (!ops->get_trip_type || !ops->get_trip_temp))
+	if (ntrips > 0 && (!ops->get_trip_type || !ops->get_trip_temp))
 		return ERR_PTR(-EINVAL);
 
 	tz = kzalloc(sizeof(*tz), GFP_KERNEL);
@@ -1254,7 +1254,7 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 	tz->tzp = tzp;
 	tz->device.class = &thermal_class;
 	tz->devdata = devdata;
-	tz->trips = trips;
+	tz->ntrips = ntrips;
 
 	thermal_set_delay_jiffies(&tz->passive_delay_jiffies, passive_delay);
 	thermal_set_delay_jiffies(&tz->polling_delay_jiffies, polling_delay);
@@ -1272,7 +1272,7 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 	if (result)
 		goto release_device;
 
-	for (count = 0; count < trips; count++) {
+	for (count = 0; count < ntrips; count++) {
 		if (tz->sensor.ops->get_trip_type(tz, count, &trip_type) ||
 		    tz->sensor.ops->get_trip_temp(tz, count, &trip_temp) ||
 		    !trip_temp)
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 3c7aa31686ad..50ca221367f7 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -89,7 +89,7 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 	ret = tz->sensor.ops->get_temp(tz, temp);
 
 	if (IS_ENABLED(CONFIG_THERMAL_EMULATION) && tz->emul_temperature) {
-		for (count = 0; count < tz->trips; count++) {
+		for (count = 0; count < tz->ntrips; count++) {
 			ret = tz->sensor.ops->get_trip_type(tz, count, &type);
 			if (!ret && type == THERMAL_TRIP_CRITICAL) {
 				ret = tz->sensor.ops->get_trip_temp(tz, count,
@@ -137,7 +137,7 @@ void thermal_zone_set_trips(struct thermal_zone_device *tz)
 	if (!tz->sensor.ops->set_trips || !tz->sensor.ops->get_trip_hyst)
 		goto exit;
 
-	for (i = 0; i < tz->trips; i++) {
+	for (i = 0; i < tz->ntrips; i++) {
 		int trip_low;
 
 		tz->sensor.ops->get_trip_temp(tz, i, &trip_temp);
diff --git a/drivers/thermal/thermal_netlink.c b/drivers/thermal/thermal_netlink.c
index b309b2412500..1639fa5c92bb 100644
--- a/drivers/thermal/thermal_netlink.c
+++ b/drivers/thermal/thermal_netlink.c
@@ -469,7 +469,7 @@ static int thermal_genl_cmd_tz_get_trip(struct param *p)
 
 	mutex_lock(&tz->lock);
 
-	for (i = 0; i < tz->trips; i++) {
+	for (i = 0; i < tz->ntrips; i++) {
 
 		enum thermal_trip_type type;
 		int temp, hyst = 0;
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 44212fa00c78..fd1207201c48 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -416,15 +416,15 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 	int indx;
 
 	/* This function works only for zones with at least one trip */
-	if (tz->trips <= 0)
+	if (tz->ntrips <= 0)
 		return -EINVAL;
 
-	tz->trip_type_attrs = kcalloc(tz->trips, sizeof(*tz->trip_type_attrs),
+	tz->trip_type_attrs = kcalloc(tz->ntrips, sizeof(*tz->trip_type_attrs),
 				      GFP_KERNEL);
 	if (!tz->trip_type_attrs)
 		return -ENOMEM;
 
-	tz->trip_temp_attrs = kcalloc(tz->trips, sizeof(*tz->trip_temp_attrs),
+	tz->trip_temp_attrs = kcalloc(tz->ntrips, sizeof(*tz->trip_temp_attrs),
 				      GFP_KERNEL);
 	if (!tz->trip_temp_attrs) {
 		kfree(tz->trip_type_attrs);
@@ -432,7 +432,7 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 	}
 
 	if (tz->sensor.ops->get_trip_hyst) {
-		tz->trip_hyst_attrs = kcalloc(tz->trips,
+		tz->trip_hyst_attrs = kcalloc(tz->ntrips,
 					      sizeof(*tz->trip_hyst_attrs),
 					      GFP_KERNEL);
 		if (!tz->trip_hyst_attrs) {
@@ -442,7 +442,7 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 		}
 	}
 
-	attrs = kcalloc(tz->trips * 3 + 1, sizeof(*attrs), GFP_KERNEL);
+	attrs = kcalloc(tz->ntrips * 3 + 1, sizeof(*attrs), GFP_KERNEL);
 	if (!attrs) {
 		kfree(tz->trip_type_attrs);
 		kfree(tz->trip_temp_attrs);
@@ -451,7 +451,7 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 		return -ENOMEM;
 	}
 
-	for (indx = 0; indx < tz->trips; indx++) {
+	for (indx = 0; indx < tz->ntrips; indx++) {
 		/* create trip type attribute */
 		snprintf(tz->trip_type_attrs[indx].name, THERMAL_NAME_LENGTH,
 			 "trip_point_%d_type", indx);
@@ -478,7 +478,7 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 			tz->trip_temp_attrs[indx].attr.store =
 							trip_point_temp_store;
 		}
-		attrs[indx + tz->trips] = &tz->trip_temp_attrs[indx].attr.attr;
+		attrs[indx + tz->ntrips] = &tz->trip_temp_attrs[indx].attr.attr;
 
 		/* create Optional trip hyst attribute */
 		if (!tz->sensor.ops->get_trip_hyst)
@@ -496,10 +496,10 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 			tz->trip_hyst_attrs[indx].attr.store =
 					trip_point_hyst_store;
 		}
-		attrs[indx + tz->trips * 2] =
+		attrs[indx + tz->ntrips * 2] =
 					&tz->trip_hyst_attrs[indx].attr.attr;
 	}
-	attrs[tz->trips * 3] = NULL;
+	attrs[tz->ntrips * 3] = NULL;
 
 	tz->trips_attribute_group.attrs = attrs;
 
@@ -540,7 +540,7 @@ int thermal_zone_create_device_groups(struct thermal_zone_device *tz,
 	for (i = 0; i < size - 2; i++)
 		groups[i] = thermal_zone_attribute_groups[i];
 
-	if (tz->trips) {
+	if (tz->ntrips) {
 		result = create_trip_attrs(tz, mask);
 		if (result) {
 			kfree(groups);
@@ -561,7 +561,7 @@ void thermal_zone_destroy_device_groups(struct thermal_zone_device *tz)
 	if (!tz)
 		return;
 
-	if (tz->trips)
+	if (tz->ntrips)
 		destroy_trip_attrs(tz);
 
 	kfree(tz->device.groups);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 0b99b7707928..e11c3d922c18 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -170,7 +170,7 @@ struct thermal_zone_device {
 	struct thermal_attr *trip_hyst_attrs;
 	enum thermal_device_mode mode;
 	void *devdata;
-	int trips;
+	int ntrips;
 	unsigned long trips_disabled;	/* bitmap for disabled trips */
 	unsigned long passive_delay_jiffies;
 	unsigned long polling_delay_jiffies;
-- 
2.25.1

