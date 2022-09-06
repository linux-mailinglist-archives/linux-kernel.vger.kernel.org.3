Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82205AF163
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239183AbiIFRAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238989AbiIFQ77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:59:59 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8F380492
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 09:47:42 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id bp20so15868582wrb.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 09:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Ot6aPvSiYXAp0Hkm+zPI98RcgU3lQfSUO9dLDinpKfk=;
        b=R9LKx1uTzEaYApU3EXTyHatqRhMBCHBwziqyhSZSAwX4hmbIZQAzfKf0RwSiHUtsi4
         haMiGCiGnIc2WyS8oVn0QkiWCeMNWLSk0YyLbAx4ZEcjIjVF30GXHrEcNT6+yUhlRqHF
         tGxsx4SmXmtiQGY2lvVHhBuAYuvczUgI3YcUwCnYV4vjQIMLUchLSME38qQLGOZtGT3+
         AJyq/E0JDLCoZFMWieXRj/QJNrC6sQc2y1igYDzUjPfy33LiYJKUNkhpGxXpDLCgujub
         jd18lzUZ4ziwVrClO8+SktoA+pOBPuZRgzFImTTV/gibSJ7997aaZDlYTrdRIetKV2q/
         RGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Ot6aPvSiYXAp0Hkm+zPI98RcgU3lQfSUO9dLDinpKfk=;
        b=x273qr+/Uf5UeMeVZ9+DXFfhCgdP3Hd7xlXj6oHf9I6hnW7dPlK5BcItu3hnuFQTjo
         As6xFdGWx6YT4lEKV76DZZaWVFBbUEp4N7tUqd5PmrMw56W5Y4cfNP4pdVU+M414f/3F
         Hx+PYQtgs/QE7Ot7GNmHaD8vJF5k5T6cwF3o1USk5auIXNFtLK/5FkX6cHtLWiYNv/E+
         eNKLDV8ZK6ll6LZOYhBfhAPWWbikYdanLitH/Xv+FjEe56X8FM08he2NDZ6cZpOpwnmP
         c0dj5bcNr5qdX30LaepfqS8v1Ft3DPn1EK4o+AmzbRBjkKLJKghxfNTbpYdhUcqJcw0N
         00sg==
X-Gm-Message-State: ACgBeo3/zWTTtkKi0Gqljd3lqWxo0Cdr3od7VKb9Od3+zvRkAbqUMkB+
        b7mBSPpR/1NUj87cJkpn6HUn8KJVBjmMKg==
X-Google-Smtp-Source: AA6agR58hF/EPIE5pyJMbSrXNtT73b2qqm7uOYKunTKqhahhIjGCiIQolZm3CYpiKzgStA3nAKStqg==
X-Received: by 2002:adf:f051:0:b0:228:830a:4963 with SMTP id t17-20020adff051000000b00228830a4963mr6304620wro.586.1662482861365;
        Tue, 06 Sep 2022 09:47:41 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id e27-20020adf9bdb000000b0021f0ff1bc6csm7426600wrc.41.2022.09.06.09.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 09:47:40 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v3 03/30] thermal/core: Add a generic thermal_zone_set_trip() function
Date:   Tue,  6 Sep 2022 18:46:53 +0200
Message-Id: <20220906164720.330701-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220906164720.330701-1-daniel.lezcano@linaro.org>
References: <20220906164720.330701-1-daniel.lezcano@linaro.org>
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

The thermal zone ops defines a set_trip callback where we can invoke
the backend driver to set an interrupt for the next trip point
temperature being crossed the way up or down, or setting the low level
with the hysteresis.

The ops is only called from the thermal sysfs code where the userspace
has the ability to modify a trip point characteristic.

With the effort of encapsulating the thermal framework core code,
let's create a thermal_zone_set_trip() which is the writable side of
the thermal_zone_get_trip() and put there all the ops encapsulation.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c  | 44 ++++++++++++++++++++++++++++++
 drivers/thermal/thermal_sysfs.c | 48 +++++++++++----------------------
 include/linux/thermal.h         |  3 +++
 3 files changed, 63 insertions(+), 32 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 381d85ec74a0..fa0f89a24b68 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1183,6 +1183,50 @@ int thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
 }
 EXPORT_SYMBOL_GPL(thermal_zone_get_trip);
 
+int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id,
+			  const struct thermal_trip *trip)
+{
+	struct thermal_trip t;
+	int ret = -EINVAL;
+
+	mutex_lock(&tz->lock);
+
+	if (!tz->ops->set_trip_temp && !tz->ops->set_trip_hyst && !tz->trips)
+		goto out;
+
+	ret = __thermal_zone_get_trip(tz, trip_id, &t);
+	if (ret)
+		goto out;
+
+	if ((t.temperature != trip->temperature) && tz->ops->set_trip_temp) {
+
+		ret = tz->ops->set_trip_temp(tz, trip_id, trip->temperature);
+		if (ret)
+			goto out;
+	}
+
+	if ((t.hysteresis != trip->hysteresis) && tz->ops->set_trip_hyst) {
+
+		ret = tz->ops->set_trip_hyst(tz, trip_id, trip->hysteresis);
+		if (ret)
+			goto out;
+	}
+
+	if (((t.temperature != trip->temperature) ||
+	     (t.hysteresis != trip->hysteresis)) && tz->trips)
+		tz->trips[trip_id] = *trip;
+
+out:
+	mutex_unlock(&tz->lock);
+
+	if (!ret) {
+		thermal_notify_tz_trip_change(tz->id, trip_id, trip->type,
+					      trip->temperature, trip->hysteresis);
+		thermal_zone_device_update(tz, THERMAL_TRIP_CHANGED);
+	}
+	
+	return ret;
+}
 
 /**
  * thermal_zone_device_register_with_trips() - register a new thermal zone device
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 18cdd7cd0008..8d7b25ab67c2 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -115,31 +115,20 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
 	struct thermal_trip trip;
 	int trip_id, ret;
 
-	if (!tz->ops->set_trip_temp && !tz->trips)
-		return -EPERM;
-
 	if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip_id) != 1)
 		return -EINVAL;
 
-	if (kstrtoint(buf, 10, &trip.temperature))
-		return -EINVAL;
-
-	ret = tz->ops->set_trip_temp(tz, trip_id, trip.temperature);
+	ret = thermal_zone_get_trip(tz, trip_id, &trip);
 	if (ret)
 		return ret;
 
-	if (tz->trips)
-		tz->trips[trip_id].temperature = trip.temperature;
+	if (kstrtoint(buf, 10, &trip.temperature))
+		return -EINVAL;
 
-	ret = thermal_zone_get_trip(tz, trip_id, &trip);
+	ret = thermal_zone_set_trip(tz, trip_id, &trip);
 	if (ret)
 		return ret;
 
-	thermal_notify_tz_trip_change(tz->id, trip_id, trip.type,
-				      trip.temperature, trip.hysteresis);
-
-	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
-
 	return count;
 }
 
@@ -166,29 +155,24 @@ trip_point_hyst_store(struct device *dev, struct device_attribute *attr,
 		      const char *buf, size_t count)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
-	int trip, ret;
-	int temperature;
-
-	if (!tz->ops->set_trip_hyst)
-		return -EPERM;
+	struct thermal_trip trip;
+	int trip_id, ret;
 
-	if (sscanf(attr->attr.name, "trip_point_%d_hyst", &trip) != 1)
+	if (sscanf(attr->attr.name, "trip_point_%d_hyst", &trip_id) != 1)
 		return -EINVAL;
 
-	if (kstrtoint(buf, 10, &temperature))
-		return -EINVAL;
+	ret = thermal_zone_get_trip(tz, trip_id, &trip);
+	if (ret)
+		return ret;
 
-	/*
-	 * We are not doing any check on the 'temperature' value
-	 * here. The driver implementing 'set_trip_hyst' has to
-	 * take care of this.
-	 */
-	ret = tz->ops->set_trip_hyst(tz, trip, temperature);
+	if (kstrtoint(buf, 10, &trip.hysteresis))
+		return -EINVAL;
 
-	if (!ret)
-		thermal_zone_set_trips(tz);
+	ret = thermal_zone_set_trip(tz, trip_id, &trip);
+	if (ret)
+		return ret;
 
-	return ret ? ret : count;
+	return count;
 }
 
 static ssize_t
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 09dc09228717..5350a437f245 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -338,6 +338,9 @@ static inline void devm_thermal_of_zone_unregister(struct device *dev,
 int thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
 			  struct thermal_trip *trip);
 
+int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id,
+			  const struct thermal_trip *trip);
+
 int thermal_zone_get_num_trips(struct thermal_zone_device *tz);
 
 #ifdef CONFIG_THERMAL
-- 
2.34.1

