Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A0D56CBBA
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 00:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiGIWdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 18:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiGIWdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 18:33:01 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501842A426
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 15:32:56 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id z12so2596543wrq.7
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 15:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=burLk/fepKB3+kx0gOsH0ETHWrtJk7gcAQVl65eRfYw=;
        b=bH6742FDglY2kU6jXlKKPKjXNlX27zB8iJgh2WYv37KH6V3zlecXMNzRmHHf8CRJ5+
         WkhAquzDcIYswqKFEsAiGZo2M0Yqy3Lz1wWKmUPcXa1GXnUaVO88tyvssS65rW9pv/3d
         RgkGNehTel76Qh4uvCYvWWy8jqEvJYXTXBzrefaiLQpVVYFWIKcDl50arC0HFjNmQgmA
         7EZt8MAK1Fp2mt+oFNxYMbaFKTz47h6cKX4XzLGybmsufC3mZz8zs7wXK7XhHJ1tydF0
         wbtXvy7XwJq35v/zxJ41wfsM454TmQpjb/a0qFzQ0+yGfVwPwJpy6lX/C058WftEJQou
         XnfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=burLk/fepKB3+kx0gOsH0ETHWrtJk7gcAQVl65eRfYw=;
        b=jmN4qJ1mm0VVRWybmf0/iiXbXyWD0aediqj6ijdNVdK+HVNkWrRqi1epbUURT6YjYu
         jSqAN3qwikbOx38h8r3RnQv0r/XfUexv8R5JnWSiQ1cleHEjzPK+fbRBtI06kvC7L2ag
         +geLnYGB3hnlE922LSwLyL/LjhD/MztLF8GpPPRbL1rJjlEVNgx57iuAj/RMrt/cJdY7
         Rzk/DO5a/Nbzi4BK4+PBIZVUC1YZBjDJ+i6n7OSBOGib1B5pz5nJ4AT8eTNqWmW/IL2T
         u/RRTpfjXelZ5NSvylEI6vSnOga3+OVmDwDmbaBlwDg/E0UWNfLBaWrdvzj+3x7zpR9o
         Z4OA==
X-Gm-Message-State: AJIora9SeFtL2b5I9IeqAcQGsJbjZWTlfrA0QCplFcKgxFhcPiZG8jT+
        AYPLQShaLQz8ayBX9czxURiI5w==
X-Google-Smtp-Source: AGRyM1uwDEiaAzaNxfIhzSyUGX04kVAWlULP559SIBrxeGce/wKUTX6zhdOrhl9uHB9lsmKEtV6T2w==
X-Received: by 2002:a5d:60c1:0:b0:21d:7469:9687 with SMTP id x1-20020a5d60c1000000b0021d74699687mr9714013wrt.361.1657405976370;
        Sat, 09 Jul 2022 15:32:56 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id w15-20020a1cf60f000000b003a2c7bf0497sm2525342wmc.16.2022.07.09.15.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 15:32:56 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v4 09/12] thermal/core: Register with the trip points
Date:   Sun, 10 Jul 2022 00:32:26 +0200
Message-Id: <20220709223229.1619339-10-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220709223229.1619339-1-daniel.lezcano@linexp.org>
References: <20220709223229.1619339-1-daniel.lezcano@linexp.org>
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

