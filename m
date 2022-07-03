Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE1F564937
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 20:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbiGCScE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 14:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbiGCSbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 14:31:53 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DC962D7
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 11:31:40 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r14so4636736wrg.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 11:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i9mswFSfgMMM6ctVTcRkTgkPmngepr2InY7YT4YdepQ=;
        b=yoQeAMMTd8L47frAw4UAzn/FQT7aw8xf/eMgJ/708OBhtdQYEB4Rrj+E1aCUTl7wMb
         6lSJrTiOZEGR1W3e1vkdHIqz1TX+xqDHjdqWnyweTKZBqRcyrw48sRSEPd6OKGXQoXPG
         EYgJvfIiyATP/eiOQSC5tWRzCDevFEHPfr4L+CTE+Pn88SzFxjsbcFy4+EK1Neq8iQH6
         wRMtSz7+T5gkI3cXYDCoAlTI6mWJTckwZoF6L1DJVU/xY8r9XxrGyS7Je3m+gh5ek1yv
         I5X3Fuc3fjH6PvQZVTLBCoHdJ5OmQteTdov/vDk5aFV3sN89bk+6iTyEwURZkmYv8z4b
         a1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i9mswFSfgMMM6ctVTcRkTgkPmngepr2InY7YT4YdepQ=;
        b=MUF74PvgU3JIMxMT3yEO2hwOkvR8kC2KIRWtDI4P0ZiMYl5L2onIQfTvw9XDNtM9F2
         Vmqe6v5Sp31ViSRNqImA8msgArd0PoCEneHOZI2HaytIJ18vvB7l5awemKzknWXRseHz
         YAR/gGXtLAMEVzjXyQYRCIBhZHDqL1MJRAbkxvHs0+5jz8Puqk7Ji+rqIoSh1+ZmUcKd
         R7rocIP3h9esSOyBvXnQ8f8V+CPAFfTKE3Bj2RWDvpP3VmcOlHfTPt77NSRbtDWmx5oK
         Ak1J7gdjJcv6I0oFinTD8xGod8ZsI90H/xz+YCLeMMZWL8KmJuhGN3kFdceN0zfZKCZw
         26TQ==
X-Gm-Message-State: AJIora9j7a+fxV2Rdcf6m9FmkqU/jzdAjGAOGwFnMFzVmKHXfn0u1jFf
        DKOQZtWbn+/Uz8ZH5dAHtefCucJaG3rsuw==
X-Google-Smtp-Source: AGRyM1uWq03QG4qLCjV81TKgYhFJCWXNcBZMBTYUY/AyPFu3UpZhMH/AeiJFTNnRfuvnZfQSKKjdKw==
X-Received: by 2002:adf:f047:0:b0:21d:64cb:b34f with SMTP id t7-20020adff047000000b0021d64cbb34fmr4737918wro.506.1656873100103;
        Sun, 03 Jul 2022 11:31:40 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id x10-20020a5d54ca000000b0021b85664636sm27504258wrv.16.2022.07.03.11.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 11:31:39 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, abailon@baylibre.com,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v3 09/12] thermal/core: Register with the trip points
Date:   Sun,  3 Jul 2022 20:30:56 +0200
Message-Id: <20220703183059.4133659-10-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220703183059.4133659-1-daniel.lezcano@linexp.org>
References: <20220703183059.4133659-1-daniel.lezcano@linexp.org>
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

As we added the thermal trip points structure in the thermal zone,
let's extend the thermal zone register function to have the thermal
trip structures as a parameter and store it in the 'trips' field of
the thermal zone structure.

Cc: Alexandre Bailon <abailon@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc; Eduardo Valentin <eduval@amazon.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/thermal_core.c | 22 +++++++++++++++++-----
 drivers/thermal/thermal_core.h |  4 ++--
 include/linux/thermal.h        |  6 ++++++
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 434a675da245..e865c41d2320 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1167,8 +1167,9 @@ static void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms
 }
 
 /**
- * thermal_zone_device_register() - register a new thermal zone device
+ * thermal_zone_device_register_with_trips() - register a new thermal zone device
  * @type:	the thermal zone device type
+ * @trips:	a pointer to an array of thermal trips
  * @ntrips:	the number of trip points the thermal zone support
  * @mask:	a bit string indicating the writeablility of trip points
  * @devdata:	private device data
@@ -1191,10 +1192,10 @@ static void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms
  * IS_ERR*() helpers.
  */
 struct thermal_zone_device *
-thermal_zone_device_register(const char *type, int ntrips, int mask,
-			     void *devdata, struct thermal_zone_device_ops *ops,
-			     struct thermal_zone_params *tzp, int passive_delay,
-			     int polling_delay)
+thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *trips, int ntrips, int mask,
+					void *devdata, struct thermal_zone_device_ops *ops,
+					struct thermal_zone_params *tzp, int passive_delay,
+					int polling_delay)
 {
 	struct thermal_zone_device *tz;
 	enum thermal_trip_type trip_type;
@@ -1256,6 +1257,7 @@ thermal_zone_device_register(const char *type, int ntrips, int mask,
 	tz->device.class = &thermal_class;
 	tz->devdata = devdata;
 	tz->ntrips = ntrips;
+	tz->trips = trips;
 
 	thermal_set_delay_jiffies(&tz->passive_delay_jiffies, passive_delay);
 	thermal_set_delay_jiffies(&tz->polling_delay_jiffies, polling_delay);
@@ -1331,6 +1333,16 @@ thermal_zone_device_register(const char *type, int ntrips, int mask,
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
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 84e341c1e0fc..bbe3ec26d12e 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -113,12 +113,12 @@ int thermal_build_list_of_policies(char *buf);
 /* Helpers */
 void thermal_zone_set_trips(struct thermal_zone_device *tz);
 
-static inline struct thermal_trip *thermal_zone_get_trips(struct thermal_zone *tz)
+static inline struct thermal_trip *thermal_zone_get_trips(struct thermal_zone_device *tz)
 {
 	return tz->trips;
 }
 
-static inline int thermal_zone_get_ntrips(struct thermal_zone *tz)
+static inline int thermal_zone_get_ntrips(struct thermal_zone_device *tz)
 {
 	return tz->ntrips;
 }
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 3733e23b6359..8cbe237a92d0 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -379,8 +379,14 @@ void devm_thermal_zone_of_sensor_unregister(struct device *dev,
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

