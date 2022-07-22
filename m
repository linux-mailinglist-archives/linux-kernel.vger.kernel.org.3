Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D325457E7CE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 22:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236649AbiGVUBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 16:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236457AbiGVUAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 16:00:45 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCA789A41
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 13:00:44 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id u5so7890082wrm.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 13:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ygELt+w2niDufxqg+IYClbCGoWLEzDI4biE+DTmo/4U=;
        b=RNASHCLkxOYDWKlTL4APl6rJr7Di7k+aKh7QB4MLeQbj8koZOb8gwbldKNH1jOb2I1
         TMjAIls0xpg6rFiEANAw5B56Zc426soBCQB3rdT262JfY9JO3ehFA7tpONLgCVKdWBiV
         1vQ/MpW77cqS+nsrtQ8R4culkbM0Sds4D1YblzXWmOT/hO8VybokZNZ165zRSTaYW2TB
         QlhdTi3h2dKNFVXFQxcepH93JvTUkXiuITwRzlMBNaLxLxA0JhlpULRtnm0Rq9MNFJZN
         jnSNyjNNi1JZr210ZNcUeyA7/Mp2kjQvnAejugFWZfqIuVfu5y6pvsIvNhq9DOt1jS/3
         iYhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ygELt+w2niDufxqg+IYClbCGoWLEzDI4biE+DTmo/4U=;
        b=ykrGjE4+IBTZBHWagrvj+WODMju1Yr342rzwCcgi+62VdshYlp7w/GfE+pPgt1MUS0
         jJO2s6WkKk4VQUlkF+8eTvSFlpzmRN+2EMq0rMxfQW2Bx/Tm82Sf2H07lUVrY60x+lN3
         Zf8ddfAlVq6i/3+VruEa+qALxxsNQkYdMatRuIliw2FOAur7rlsT5W2nt6L0pPVBz2ru
         +NZeUbdykuuMX9iYvHZ2DGFx0ULRNywmEiOT9FR/ePGgjn3uIy97Bb6UWUCjibvdvzH9
         LcFH2iyo8lGxBhxQoPJ0UKm735uJWdfob+7L3MYccsn1465r4+1G4c4zFvaAL2sNc+Ft
         Tdtg==
X-Gm-Message-State: AJIora/oKX0wWAeuLPSn+0Vo72QA3KGJ0sIPCqAqeM0z+rDDITsvDMTK
        m85ToIC3pX/pB4TCmR/2qyqJKw==
X-Google-Smtp-Source: AGRyM1vlFkQyiF/YclfF60LhXmvuuE8FrGDDL0jm/ooKehytFiUmRQpct35zTomGZokoDdDHjA7VEQ==
X-Received: by 2002:a05:6000:15c1:b0:21d:b72c:a9ad with SMTP id y1-20020a05600015c100b0021db72ca9admr988666wry.94.1658520043564;
        Fri, 22 Jul 2022 13:00:43 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:957f:d36d:87f9:5c17])
        by smtp.gmail.com with ESMTPSA id k23-20020a05600c1c9700b003a31b00c216sm6429008wms.0.2022.07.22.13.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 13:00:43 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v6 08/10] thermal/core: Add thermal_trip in thermal_zone
Date:   Fri, 22 Jul 2022 22:00:05 +0200
Message-Id: <20220722200007.1839356-9-daniel.lezcano@linexp.org>
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

The thermal trip points are properties of a thermal zone and the
different sub systems should be able to save them in the thermal zone
structure instead of having their own definition.

Give the opportunity to the drivers to create a thermal zone with
thermal trips which will be accessible directly from the thermal core
framework.

As we added the thermal trip points structure in the thermal zone,
let's extend the thermal zone register function to have the thermal
trip structures as a parameter and store it in the 'trips' field of
the thermal zone structure.

The thermal zone contains the trip point, we can store them directly
when registering the thermal zone. That will allow another step
forward to remove the duplicate thermal zone structure we find in the
thermal_of code.

Cc: Alexandre Bailon <abailon@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/thermal_core.c | 22 +++++++++++++++++-----
 drivers/thermal/thermal_of.c   |  8 +++-----
 include/linux/thermal.h        |  8 ++++++++
 3 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index cb9b1bd03bd3..0d9e9b175f93 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1167,8 +1167,9 @@ static void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms
 }
 
 /**
- * thermal_zone_device_register() - register a new thermal zone device
+ * thermal_zone_device_register_with_trips() - register a new thermal zone device
  * @type:	the thermal zone device type
+ * @trips:	a pointer to an array of thermal trips
  * @num_trips:	the number of trip points the thermal zone support
  * @mask:	a bit string indicating the writeablility of trip points
  * @devdata:	private device data
@@ -1191,10 +1192,10 @@ static void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms
  * IS_ERR*() helpers.
  */
 struct thermal_zone_device *
-thermal_zone_device_register(const char *type, int num_trips, int mask,
-			     void *devdata, struct thermal_zone_device_ops *ops,
-			     struct thermal_zone_params *tzp, int passive_delay,
-			     int polling_delay)
+thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *trips, int num_trips, int mask,
+					void *devdata, struct thermal_zone_device_ops *ops,
+					struct thermal_zone_params *tzp, int passive_delay,
+					int polling_delay)
 {
 	struct thermal_zone_device *tz;
 	enum thermal_trip_type trip_type;
@@ -1255,6 +1256,7 @@ thermal_zone_device_register(const char *type, int num_trips, int mask,
 	tz->tzp = tzp;
 	tz->device.class = &thermal_class;
 	tz->devdata = devdata;
+	tz->trips = trips;
 	tz->num_trips = num_trips;
 
 	thermal_set_delay_jiffies(&tz->passive_delay_jiffies, passive_delay);
@@ -1331,6 +1333,16 @@ thermal_zone_device_register(const char *type, int num_trips, int mask,
 	kfree(tz);
 	return ERR_PTR(result);
 }
+
+struct thermal_zone_device *thermal_zone_device_register(const char *type, int ntrips, int mask,
+							 void *devdata, struct thermal_zone_device_ops *ops,
+							 struct thermal_zone_params *tzp, int passive_delay,
+							 int polling_delay)
+{
+	return thermal_zone_device_register_with_trips(type, NULL, ntrips, mask,
+						       devdata, ops, tzp,
+						       passive_delay, polling_delay);
+}
 EXPORT_SYMBOL_GPL(thermal_zone_device_register);
 
 /**
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 19243c57b3f4..e187461dd396 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -1119,11 +1119,9 @@ int __init of_parse_thermal_zones(void)
 		tzp->slope = tz->slope;
 		tzp->offset = tz->offset;
 
-		zone = thermal_zone_device_register(child->name, tz->ntrips,
-						    mask, tz,
-						    ops, tzp,
-						    tz->passive_delay,
-						    tz->polling_delay);
+		zone = thermal_zone_device_register_with_trips(child->name, tz->trips, tz->ntrips,
+							       mask, tz, ops, tzp, tz->passive_delay,
+							       tz->polling_delay);
 		if (IS_ERR(zone)) {
 			pr_err("Failed to build %pOFn zone %ld\n", child,
 			       PTR_ERR(zone));
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 03e968d61471..fde4689a1755 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -125,6 +125,7 @@ struct thermal_cooling_device {
  * @trip_hyst_attrs:	attributes for trip points for sysfs: trip hysteresis
  * @mode:		current mode of this thermal zone
  * @devdata:	private pointer for device private data
+ * @trips:	an array of struct thermal_trip
  * @num_trips:	number of trip points the thermal zone supports
  * @trips_disabled;	bitmap for disabled trips
  * @passive_delay_jiffies: number of jiffies to wait between polls when
@@ -165,6 +166,7 @@ struct thermal_zone_device {
 	struct thermal_attr *trip_hyst_attrs;
 	enum thermal_device_mode mode;
 	void *devdata;
+	struct thermal_trip *trips;
 	int num_trips;
 	unsigned long trips_disabled;	/* bitmap for disabled trips */
 	unsigned long passive_delay_jiffies;
@@ -378,8 +380,14 @@ void devm_thermal_zone_of_sensor_unregister(struct device *dev,
 struct thermal_zone_device *thermal_zone_device_register(const char *, int, int,
 		void *, struct thermal_zone_device_ops *,
 		struct thermal_zone_params *, int, int);
+
 void thermal_zone_device_unregister(struct thermal_zone_device *);
 
+struct thermal_zone_device *
+thermal_zone_device_register_with_trips(const char *, struct thermal_trip *, int, int,
+					void *, struct thermal_zone_device_ops *,
+					struct thermal_zone_params *, int, int);
+
 int thermal_zone_bind_cooling_device(struct thermal_zone_device *, int,
 				     struct thermal_cooling_device *,
 				     unsigned long, unsigned long,
-- 
2.25.1

