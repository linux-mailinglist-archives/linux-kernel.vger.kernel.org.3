Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B27D58E2AB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 00:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbiHIWHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 18:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiHIWFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 18:05:42 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F36513F73
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 15:05:34 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso127071wma.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 15:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=89E/CxlN8Tp3lczCV5jVp3NK0Ss9lUiOGh8dJwP7JXg=;
        b=tQaWHRdToEGk9WyjVRDEXaOnmacVEHhEh9WTJBVy4a9+NSpbr3U00Bqsd3yAkmoj4V
         irOjiq2E8FpsIhKj0MpKRSzda70bUfDcYjfnKWq6k4UIlpZ5jgBboSIPRdR5RVgQFen+
         /iUjSrK6LSWDrbL/dYy562SG7MQYDt/k9+qUnOyOC6E3xvZ4DQZamws1IdA7FF8sOktK
         TBjZlXQUnW4iefsiY8VMKEeHWk3pX5XttoYNvn6LO5w5u6sxWATq0vM7X78x0qPdt5+Z
         9uiqfoN+R3LC6al9mZ+IbecJ5ooYK3Fa+9nciGy/4RjcrUIpLjccuzJtSX/5+EfiElAP
         dHnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=89E/CxlN8Tp3lczCV5jVp3NK0Ss9lUiOGh8dJwP7JXg=;
        b=ifTbBq15jmCb71vA+6sWqR161olfolkitDomAp6RHghjp5nPsTI2a5F8ezIZr9jDWc
         0KB9XLsw0h4kwvVSETn3XO5AC31Jf7Hgxkad/IFNypsK5TGIXA0SpmdZMbr8ZElWZsBm
         QZPD7fYlt0xFN/UfuejG5gHQLkHgkHbngyG/E/PJUIKxIQzUw1XqBOwKdAgON+LEupxf
         tEYWuBFjhPc8sybNt805uqHiIc48ByvBykLTQ8XF9LLlDjXfS+X6Ev6MxyztddqvQ+Qp
         WmFO83umT79y2z4q7l8GIfIJyGdBDj5QIkgssVlr2nER0uB15kuhM3BMaj7zPuNvdYAS
         WjZw==
X-Gm-Message-State: ACgBeo1jA0nY/bE5jnzatdDmkJsxCzKPZwnCv1/PMdQ+e1++aO7z0xBG
        wrE3RIF9kIPGsdxCoC5uoSFfDw==
X-Google-Smtp-Source: AA6agR5H3wiH8mgnBiSDgOR3YUyQt9nGqs0bbssfxeVDisk8h603TP07ShOGbwrr1Fh33JtOTXe7Lg==
X-Received: by 2002:a05:600c:3d93:b0:3a3:3a93:fb16 with SMTP id bi19-20020a05600c3d9300b003a33a93fb16mr290789wmb.190.1660082733455;
        Tue, 09 Aug 2022 15:05:33 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c3b1500b003a317ee3036sm293583wms.2.2022.08.09.15.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 15:05:32 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v2 26/26] thermal/drivers/intel: Use generic thermal_zone_get_trip() function
Date:   Wed, 10 Aug 2022 00:04:36 +0200
Message-Id: <20220809220436.711020-27-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220809220436.711020-1-daniel.lezcano@linaro.org>
References: <20220809220436.711020-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal framework gives the possibility to register the trip
points with the thermal zone. When that is done, no get_trip_* ops are
needed and they can be removed.

Convert ops content logic into generic trip points and register them with the
thermal zone.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/intel/x86_pkg_temp_thermal.c | 120 ++++++++++---------
 1 file changed, 66 insertions(+), 54 deletions(-)

diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/thermal/intel/x86_pkg_temp_thermal.c
index 4d8edc61a78b..c28a98c82f97 100644
--- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
@@ -53,6 +53,7 @@ struct zone_device {
 	u32				msr_pkg_therm_high;
 	struct delayed_work		work;
 	struct thermal_zone_device	*tzone;
+	struct thermal_trip		*trips;
 	struct cpumask			cpumask;
 };
 
@@ -138,40 +139,6 @@ static int sys_get_curr_temp(struct thermal_zone_device *tzd, int *temp)
 	return -EINVAL;
 }
 
-static int sys_get_trip_temp(struct thermal_zone_device *tzd,
-			     int trip, int *temp)
-{
-	struct zone_device *zonedev = tzd->devdata;
-	unsigned long thres_reg_value;
-	u32 mask, shift, eax, edx;
-	int ret;
-
-	if (trip >= MAX_NUMBER_OF_TRIPS)
-		return -EINVAL;
-
-	if (trip) {
-		mask = THERM_MASK_THRESHOLD1;
-		shift = THERM_SHIFT_THRESHOLD1;
-	} else {
-		mask = THERM_MASK_THRESHOLD0;
-		shift = THERM_SHIFT_THRESHOLD0;
-	}
-
-	ret = rdmsr_on_cpu(zonedev->cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
-			   &eax, &edx);
-	if (ret < 0)
-		return ret;
-
-	thres_reg_value = (eax & mask) >> shift;
-	if (thres_reg_value)
-		*temp = zonedev->tj_max - thres_reg_value * 1000;
-	else
-		*temp = THERMAL_TEMP_INVALID;
-	pr_debug("sys_get_trip_temp %d\n", *temp);
-
-	return 0;
-}
-
 static int
 sys_set_trip_temp(struct thermal_zone_device *tzd, int trip, int temp)
 {
@@ -212,18 +179,9 @@ sys_set_trip_temp(struct thermal_zone_device *tzd, int trip, int temp)
 			l, h);
 }
 
-static int sys_get_trip_type(struct thermal_zone_device *thermal, int trip,
-			     enum thermal_trip_type *type)
-{
-	*type = THERMAL_TRIP_PASSIVE;
-	return 0;
-}
-
 /* Thermal zone callback registry */
 static struct thermal_zone_device_ops tzone_ops = {
 	.get_temp = sys_get_curr_temp,
-	.get_trip_temp = sys_get_trip_temp,
-	.get_trip_type = sys_get_trip_type,
 	.set_trip_temp = sys_set_trip_temp,
 };
 
@@ -328,6 +286,48 @@ static int pkg_thermal_notify(u64 msr_val)
 	return 0;
 }
 
+static struct thermal_trip *pkg_temp_thermal_trips_init(int cpu, int tj_max, int num_trips)
+{
+	struct thermal_trip *trips;
+	unsigned long thres_reg_value;
+	u32 mask, shift, eax, edx;
+	int ret, i;
+
+	trips = kzalloc(sizeof(*trips) * num_trips, GFP_KERNEL);
+	if (!trips)
+		return ERR_PTR(-ENOMEM);
+	
+	for (i = 0; i < num_trips; i++) {
+
+		if (i) {
+			mask = THERM_MASK_THRESHOLD1;
+			shift = THERM_SHIFT_THRESHOLD1;
+		} else {
+			mask = THERM_MASK_THRESHOLD0;
+			shift = THERM_SHIFT_THRESHOLD0;
+		}
+
+		ret = rdmsr_on_cpu(cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
+				   &eax, &edx);
+		if (ret < 0) {
+			kfree(trips);
+			return ERR_PTR(ret);
+		}
+
+		thres_reg_value = (eax & mask) >> shift;
+
+		trips[i].temperature = thres_reg_value ?
+			tj_max - thres_reg_value * 1000 : THERMAL_TEMP_INVALID;
+
+		trips[i].type = THERMAL_TRIP_PASSIVE;
+		
+		pr_debug("%s: cpu=%d, trip=%d, temp=%d\n",
+			 __func__, cpu, i, trips[i].temperature);
+	}
+
+	return trips;
+}
+
 static int pkg_temp_thermal_device_add(unsigned int cpu)
 {
 	int id = topology_logical_die_id(cpu);
@@ -353,24 +353,27 @@ static int pkg_temp_thermal_device_add(unsigned int cpu)
 	if (!zonedev)
 		return -ENOMEM;
 
+	zonedev->trips = pkg_temp_thermal_trips_init(cpu, tj_max, thres_count);
+	if (IS_ERR(zonedev->trips)) {
+		err = PTR_ERR(zonedev->trips);
+		goto out_kfree_zonedev;
+	}
+	
 	INIT_DELAYED_WORK(&zonedev->work, pkg_temp_thermal_threshold_work_fn);
 	zonedev->cpu = cpu;
 	zonedev->tj_max = tj_max;
-	zonedev->tzone = thermal_zone_device_register("x86_pkg_temp",
-			thres_count,
+	zonedev->tzone = thermal_zone_device_register_with_trips("x86_pkg_temp",
+			zonedev->trips, thres_count,
 			(thres_count == MAX_NUMBER_OF_TRIPS) ? 0x03 : 0x01,
 			zonedev, &tzone_ops, &pkg_temp_tz_params, 0, 0);
 	if (IS_ERR(zonedev->tzone)) {
 		err = PTR_ERR(zonedev->tzone);
-		kfree(zonedev);
-		return err;
+		goto out_kfree_trips;
 	}
 	err = thermal_zone_device_enable(zonedev->tzone);
-	if (err) {
-		thermal_zone_device_unregister(zonedev->tzone);
-		kfree(zonedev);
-		return err;
-	}
+	if (err)
+		goto out_unregister_tz;
+
 	/* Store MSR value for package thermal interrupt, to restore at exit */
 	rdmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT, zonedev->msr_pkg_therm_low,
 	      zonedev->msr_pkg_therm_high);
@@ -379,7 +382,14 @@ static int pkg_temp_thermal_device_add(unsigned int cpu)
 	raw_spin_lock_irq(&pkg_temp_lock);
 	zones[id] = zonedev;
 	raw_spin_unlock_irq(&pkg_temp_lock);
-	return 0;
+
+out_unregister_tz:	
+	thermal_zone_device_unregister(zonedev->tzone);
+out_kfree_trips:
+	kfree(zonedev->trips);
+out_kfree_zonedev:
+	kfree(zonedev);
+	return err;
 }
 
 static int pkg_thermal_cpu_offline(unsigned int cpu)
@@ -463,8 +473,10 @@ static int pkg_thermal_cpu_offline(unsigned int cpu)
 	raw_spin_unlock_irq(&pkg_temp_lock);
 
 	/* Final cleanup if this is the last cpu */
-	if (lastcpu)
+	if (lastcpu) {
+		kfree(zonedev->trips);
 		kfree(zonedev);
+	}
 	return 0;
 }
 
-- 
2.34.1

