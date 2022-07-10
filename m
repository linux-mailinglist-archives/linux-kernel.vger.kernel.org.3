Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1BA56CF21
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 14:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiGJMgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 08:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiGJMfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 08:35:48 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A9913F08
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 05:35:36 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n185so1644229wmn.4
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 05:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=burLk/fepKB3+kx0gOsH0ETHWrtJk7gcAQVl65eRfYw=;
        b=ZHITaPM2U5eltBWgrJlc+uIVRp+NQyPHoIPszR/bSkjshmzbo+1hY8uDY0zjgw7wpO
         48hxCkL1WDkIkOhT4X7xf9ACw84xG5pSHU+Hq2KlZoZfJO+HIwQ/1VGPcVLuYD/16mGW
         Xna9HYKGi7pmBxj9jM30w8TYq2lzpfDs7TF6XP7myVrrGFaXqTNjHA6qqlNU+8vDARR0
         6VwZKtqQOWmLgHZaAsfaudeSjlcGdbxhzBH0YY3MAK26qijvQGXyWB/MOz8q4djTSQve
         bf74z/SEcitKLyOY0LApHP5tVU//nXRmMKhIZ5QBbgjO66jC/I8bEktyhQhEvvK0ZqKb
         ncCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=burLk/fepKB3+kx0gOsH0ETHWrtJk7gcAQVl65eRfYw=;
        b=VBsSN831r4BnW03eqqKh++mnA0DHzOC3b8xwjv9uOiiaSfmK42jkAnXwDWYOGFG5zg
         APTGLv4e87jOY4LgydtGOE5hgwBW2oga0lEfqL7haZf2g9FMy8V9VC7/Yb3JwvPQ8gPG
         BAYgJSSxomr0bKGOFS/ovfiR5pmgL5vARjdIHwktpQRsCcmjkIwR0RcAWqN6MU+8lVmy
         EPUiwb6EnaNMJuV5rnpLKpBDXAulP532nJYu7GbOxcQt8Lc5FCsafqONoxp/dDkNvq5q
         uxUZJcKCrp2r9W44C1uq76RZJM9kdDU8e+fPGxiFD+7nrkelompUvYNRMAUJSxEXx39z
         XDOg==
X-Gm-Message-State: AJIora8nHWulEzjvlJdboegYJJ6GTTpR5SbrFKqEU8ovKTuwQ7X54vor
        m25uDYdhky7EJDh/WMLqNcr9CA==
X-Google-Smtp-Source: AGRyM1u7ZlkCzRREUWKXHrn56yx/cIE01INx7QX+NsYupIIw1cZa4r3/aWzlwj4lViv8LHi/Gq19mw==
X-Received: by 2002:a05:600c:3b95:b0:3a2:e579:d196 with SMTP id n21-20020a05600c3b9500b003a2e579d196mr2521504wms.185.1657456534208;
        Sun, 10 Jul 2022 05:35:34 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 24-20020a05600c22d800b003a0375c4f73sm3775144wmg.44.2022.07.10.05.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 05:35:33 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v5 09/12] thermal/core: Register with the trip points
Date:   Sun, 10 Jul 2022 14:35:09 +0200
Message-Id: <20220710123512.1714714-11-daniel.lezcano@linexp.org>
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

As we added the thermal trip points structure in the thermal zone,
let's extend the thermal zone register function to have the thermal
trip structures as a parameter and store it in the 'trips' field of
the thermal zone structure.

Cc: Alexandre Bailon <abailon@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/thermal_core.c | 22 +++++++++++++++++-----
 include/linux/thermal.h        |  6 ++++++
 2 files changed, 23 insertions(+), 5 deletions(-)

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
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index c7fcb9e2a4fc..fde4689a1755 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -380,8 +380,14 @@ void devm_thermal_zone_of_sensor_unregister(struct device *dev,
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

