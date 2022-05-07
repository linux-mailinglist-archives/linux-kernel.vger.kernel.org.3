Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07FDC51E722
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 14:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390145AbiEGNAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 09:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385099AbiEGM7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 08:59:12 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6C6398
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 05:55:21 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id e2so13428257wrh.7
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 05:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HPZ5SE9Cu1hgeYmUx81B/RyK2FJraRwiffWZMBqc/OU=;
        b=MldC2b2g/eYaYzHLzJC4/zRtnobY+d712xZYpu5A4H9zLGIduZbubJAqruaCGEtD5k
         JdFD11QvqKHbeYsw3JH+cAkyEBWi+p0lMmzKxjuIburFnIr+unWST/PPrn3JJAgW/8ib
         buKGic1pB8ueonanxIpE7llPiKQ/q7msmY9e8vhQbn3ccCA5jJTFc4MlIBKILCIkjo4K
         fvLMHUXTh1Gonjbv6FHLHCeLFDgMIDicD/Fns9pJe+BVbPA8JxFlM5PaM7iiCYLsMzTx
         Sc6pc4ec4lK5HhP6x8WB/umxSBZz1WbEhLpcCpNel8susC2p/jcn/DpcPX6x4G+RxyMe
         IQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HPZ5SE9Cu1hgeYmUx81B/RyK2FJraRwiffWZMBqc/OU=;
        b=tqwJVE4v27RiBVK5g6jh/eoYIYNJqIOG/P1DO/yC5bYxpZCWCsmXDhIzBLZDS4pRGa
         d7KAtlNvdNXMEVdD69lpuYNcdbxmqfOrcGARhYmoRlQaf3GeSKoQAsEIJ0r4BlJzVdr0
         NfbEZWXfbHZZ5DjE7DOrCVOBS5EolqBv+tfqvqdO+kz78cpoj9OXz00LkU+HMq6GGgnV
         5QzrNCxcVQFIdDKQntO7nuwmNpJ1Az8jWA/PvCu55WJYrsIvSVRXFLym8yD6lg0Jd/jx
         BYv1qCvRRVK/tvpJ/AVzgYOlfwbfH8QYCCj/gHY6QEZ/UluHsUEB7SvFF5/ZvpK6cdcE
         hZog==
X-Gm-Message-State: AOAM531srBR2QbzubuZx7xvghc9mWWwFel+Tu3Eq9gcIO+sAinmiBWnf
        lUeI2GGIskbBVrvOADIHPR8aiDE5MdPXcHrRtHs=
X-Google-Smtp-Source: ABdhPJwPFJR9YChlsgK/W07m4YL8ZHjj/5xSjnaPSYtfyCDO2wVFp+X+p8U8UyijwwSxgTVODMCMVg==
X-Received: by 2002:a05:6000:1f9d:b0:20c:87b6:e775 with SMTP id bw29-20020a0560001f9d00b0020c87b6e775mr6500353wrb.253.1651928119877;
        Sat, 07 May 2022 05:55:19 -0700 (PDT)
Received: from localhost.localdomain (static-176-182-171-101.ncc.abo.bbox.fr. [176.182.171.101])
        by smtp.gmail.com with ESMTPSA id e9-20020a05600c218900b0039453fe55a7sm10470345wme.35.2022.05.07.05.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 05:55:19 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     khilman@baylibre.com, abailon@baylibre.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v2 11/14] thermal/core: Register with the trip points
Date:   Sat,  7 May 2022 14:54:39 +0200
Message-Id: <20220507125443.2766939-12-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220507125443.2766939-1-daniel.lezcano@linexp.org>
References: <20220507125443.2766939-1-daniel.lezcano@linexp.org>
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
 drivers/thermal/thermal_core.c | 23 ++++++++++++++++++-----
 drivers/thermal/thermal_core.h |  4 ++--
 include/linux/thermal.h        |  6 ++++++
 3 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index f898032ec23a..a0317be48b0c 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1166,8 +1166,9 @@ static void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms
 }
 
 /**
- * thermal_zone_device_register() - register a new thermal zone device
+ * thermal_zone_device_register_with_trips() - register a new thermal zone device
  * @type:	the thermal zone device type
+ * @trips:	a pointer to an array of thermal trips
  * @ntrips:	the number of trip points the thermal zone support
  * @mask:	a bit string indicating the writeablility of trip points
  * @devdata:	private device data
@@ -1190,10 +1191,11 @@ static void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms
  * IS_ERR*() helpers.
  */
 struct thermal_zone_device *
-thermal_zone_device_register(const char *type, int ntrips, int mask,
-			     void *devdata, struct thermal_sensor_ops *ops,
-			     struct thermal_zone_params *tzp, int passive_delay,
-			     int polling_delay)
+thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *trips,
+					int ntrips, int mask,
+					void *devdata, struct thermal_sensor_ops *ops,
+					struct thermal_zone_params *tzp, int passive_delay,
+					int polling_delay)
 {
 	struct thermal_zone_device *tz;
 	enum thermal_trip_type trip_type;
@@ -1255,6 +1257,7 @@ thermal_zone_device_register(const char *type, int ntrips, int mask,
 	tz->device.class = &thermal_class;
 	tz->devdata = devdata;
 	tz->ntrips = ntrips;
+	tz->trips = trips;
 
 	thermal_set_delay_jiffies(&tz->passive_delay_jiffies, passive_delay);
 	thermal_set_delay_jiffies(&tz->polling_delay_jiffies, polling_delay);
@@ -1330,6 +1333,16 @@ thermal_zone_device_register(const char *type, int ntrips, int mask,
 	kfree(tz);
 	return ERR_PTR(result);
 }
+
+struct thermal_zone_device *thermal_zone_device_register(const char *type, int ntrips, int mask,
+							 void *devdata, struct thermal_sensor_ops *ops,
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
index a11c00062ef1..8c4bc6d1de97 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -381,8 +381,14 @@ void devm_thermal_zone_of_sensor_unregister(struct device *dev,
 struct thermal_zone_device *thermal_zone_device_register(const char *, int, int,
 		void *, struct thermal_sensor_ops *,
 		struct thermal_zone_params *, int, int);
+
 void thermal_zone_device_unregister(struct thermal_zone_device *);
 
+struct thermal_zone_device *
+thermal_zone_device_register_with_trips(const char *, struct thermal_trip *, int, int,
+					void *, struct thermal_sensor_ops *,
+					struct thermal_zone_params *, int, int);
+
 int thermal_zone_bind_cooling_device(struct thermal_zone_device *, int,
 				     struct thermal_cooling_device *,
 				     unsigned long, unsigned long,
-- 
2.25.1

