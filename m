Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7A458ACE1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 17:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241259AbiHEPAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 11:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241194AbiHEO7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 10:59:18 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7A26610C
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 07:58:23 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id q30so3503831wra.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 07:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=z+3sr4RoahqIagdepcyckHH4zFG4cR5LxNdbwLmB54k=;
        b=MFpiKKPkYPJj0FgsnYVOIAOjy9IT9JvfWkemJu8CDvaPaBJM4I6d3Q36vTsTtFI6ja
         R/PUffq+p6imiM+cfp2/hw1+5n6rnT7qxGtrLfXjxN+culnyV2403T/PLGI00E24yz/n
         BhSMj7fPlP3T20IyZm3z2/erPy6ZMQa6adcaQGrHm1DYcSdydUJsVCJDcIxT9iUrNu/E
         gOKx+DSq08g7/B5YGzIP5DbJj7c6r4jiZoDHc3NO62syr3XVO2nGuNGpl1Fycj2yYWFG
         IqMrQTy8Qkzr/Orcu4SnT/nyqkbwNAq3MQtMq0RYQyeP4dxUvdGYOvoduAE7Y0I1f2Zj
         0CmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=z+3sr4RoahqIagdepcyckHH4zFG4cR5LxNdbwLmB54k=;
        b=rSsnvAvym7ViQevEOrsUNVJ/YEd4z5voLscSLet/T0Ccd05amFCSW6qrj0FcEmu9X/
         l9nHqUgz4AkmUoSx6cKNfSIBapODxAmpey5yqqyRWixwC13FljKNegR3fdNkR9z+/N/D
         sls2TU3akZyZy4rMSF+0Te7qqycnYkf8OlGByDMHSMrhu0p+JPRy6cUTGPh3J4gRe6t+
         kiz50ICNewladofgjt09Yh0Nke0UMvdS74z5o0/O0WaczRx83t088sXjdCfwvLqaiHL4
         uI/NGl27/dzqjPGxERJqKojAqXbSILXRYAeOT9KyCvjeteQHwDnKoN1dN63JV08DjBZD
         Gd/g==
X-Gm-Message-State: ACgBeo3wKIT5SGojfg7kMtYYPDeiBh/hbls+R8itULLCenSqewBQoNoU
        sMHr9ppAE+sI0RfYF+X3bN4YLA==
X-Google-Smtp-Source: AA6agR5DmVTQ2ntzu1hlzAW+nFfelk11ldlqaHtiqEP2t8I5nxMLB1Uf6lJMSqbEwFig7z8aQu2/OQ==
X-Received: by 2002:a5d:64c1:0:b0:220:8590:3809 with SMTP id f1-20020a5d64c1000000b0022085903809mr4629247wri.97.1659711503027;
        Fri, 05 Aug 2022 07:58:23 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:aef0:8606:da6b:79ef])
        by smtp.gmail.com with ESMTPSA id y1-20020adfd081000000b0022159d92004sm3102448wrh.82.2022.08.05.07.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 07:58:22 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v1 26/26] thermal/drivers/intel: Use generic thermal_zone_get_trip() function
Date:   Fri,  5 Aug 2022 16:57:29 +0200
Message-Id: <20220805145729.2491611-27-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805145729.2491611-1-daniel.lezcano@linaro.org>
References: <20220805145729.2491611-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
2.25.1

