Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87A1510BD2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 00:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355740AbiDZWT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 18:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355721AbiDZWSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 18:18:54 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD26545041
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 15:15:45 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id o12-20020a1c4d0c000000b00393fbe2973dso1421494wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 15:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zH3Lt/m7esA/s8brWXuW3YNZ0o54R9cXMDjhBWwDDf0=;
        b=lKydNFrSUBa9fYyh9Eeuip2Zj3Va67JkokhU0Hhgo0ulArwe1sNYlb9f4Vy35jsKq5
         bJ3bvYXTPG8yQOHtotJL/HdWHMx4NmOqZ9v6rIOWopboLnWKrh2bnWJYM/2sb9nQk+f3
         yx0Ruy1wzWyc4ZxtL6OQ5+CB61XLX3iFSR5ooCOnPf9xwzhJTRI7cZ/IIVgh79PZTahR
         6XGld+5vKG3jDOc25g+ATU6hje6nwj+1fH9rB9rRqDHO8+l5iZP2a4D1kzNFdlzVgInM
         W95QS3PhAvVL0P8ZHRtwQDz4zEhiFQYizS8PyvykWEybGD4okFWgO3RqlskM/H3TBGBy
         Q5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zH3Lt/m7esA/s8brWXuW3YNZ0o54R9cXMDjhBWwDDf0=;
        b=sBbkSgMYpwtQaOJV5WT9LEv492tdICCjxubcRlQ1XaQD1RBxbxpkdUckkckPs2cFgr
         zc01oDP+cjjaI7zl645TUxuEpDqAF5aIFZP7xO35uKA0/F7Bubk+Jsk8XQyY2RHCDjTc
         Kj37eyYfQ7gbXvFZ0gjfmyjL/RIV065PgoiI1ygsp3S6OW3B04UCkq0c4ysbFOQUQemB
         46p9+aCzrMoZZAjh9zt+Fut9niesKVldYWOWZWCzfwwMf2om9VDK3Z2I8oXHGOJrT/d/
         9Z+NA1evcsDWwh/789aOKAVleadpfA/k+DabYZY+MAJJkGrMVfDnUTRlUSwtAl32WAX6
         vDYg==
X-Gm-Message-State: AOAM530PbgWM8QHn0gJuUXhwbniVPHRA9P7vM1hAieDQ4oD3cjzZDjh2
        vpsZpcZsCSlA4QUI6X41CXHjDbu5u3g5QgO0O9c=
X-Google-Smtp-Source: ABdhPJwMDYMSYGDJyAgzt0o7iV4ybOvvnic7CH8KWW2yq4koFG1PedIKlpeJuGGjRLcp4jKPJ77nvw==
X-Received: by 2002:a05:600c:4fd0:b0:393:eb2e:fb04 with SMTP id o16-20020a05600c4fd000b00393eb2efb04mr12334200wmq.167.1651011344334;
        Tue, 26 Apr 2022 15:15:44 -0700 (PDT)
Received: from localhost.localdomain (static-176-182-171-101.ncc.abo.bbox.fr. [176.182.171.101])
        by smtp.gmail.com with ESMTPSA id j19-20020adfb313000000b0020aed8ece65sm393314wrd.32.2022.04.26.15.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 15:15:43 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     khilman@baylibre.com, abailon@baylibre.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/15] thermal/core: Register with the trip points
Date:   Wed, 27 Apr 2022 00:15:20 +0200
Message-Id: <20220426221523.3056696-13-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426221523.3056696-1-daniel.lezcano@linexp.org>
References: <20220426221523.3056696-1-daniel.lezcano@linexp.org>
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

As we added the thermal trip points structure in the thermal zone,
let's extend the thermal zone register function to have the thermal
trip structures as a parameter and store it in the 'trips' field of
the thermal zone structure.

Cc: Alexandre Bailon <abailon@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc; Eduardo Valentin <eduval@amazon.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/thermal_core.c | 17 +++++++++++++++--
 include/linux/thermal.h        |  6 ++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 79cb9e0a7229..822f97bc471f 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1166,8 +1166,9 @@ static void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms
 }
 
 /**
- * thermal_zone_register() - register a new thermal zone device
+ * thermal_zone_register_with_trips() - register a new thermal zone device
  * @type:	the thermal zone device type
+ * @trips:	a pointer to an array of thermal trips
  * @ntrips:	the number of trip points the thermal zone support
  * @mask:	a bit string indicating the writeablility of trip points
  * @devdata:	private device data
@@ -1190,7 +1191,8 @@ static void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms
  * IS_ERR*() helpers.
  */
 struct thermal_zone *
-thermal_zone_register(const char *type, int ntrips, int mask,
+thermal_zone_register_with_trips(const char *type,
+				 struct thermal_trip *trips, int ntrips, int mask,
 			     void *devdata, struct thermal_sensor_ops *ops,
 			     struct thermal_zone_params *tzp, int passive_delay,
 			     int polling_delay)
@@ -1255,6 +1257,7 @@ thermal_zone_register(const char *type, int ntrips, int mask,
 	tz->device.class = &thermal_class;
 	tz->devdata = devdata;
 	tz->ntrips = ntrips;
+	tz->trips = trips;
 
 	thermal_set_delay_jiffies(&tz->passive_delay_jiffies, passive_delay);
 	thermal_set_delay_jiffies(&tz->polling_delay_jiffies, polling_delay);
@@ -1332,6 +1335,16 @@ thermal_zone_register(const char *type, int ntrips, int mask,
 }
 EXPORT_SYMBOL_GPL(thermal_zone_register);
 
+struct thermal_zone *thermal_zone_register(const char *type, int ntrips, int mask,
+					   void *devdata, struct thermal_sensor_ops *ops,
+					   struct thermal_zone_params *tzp, int passive_delay,
+					   int polling_delay)
+{
+	return thermal_zone_register_with_trips(type, NULL, ntrips, mask,
+						devdata, ops, tzp,
+						passive_delay, polling_delay);
+}
+
 /**
  * thermal_zone_unregister - removes the registered thermal zone device
  * @tz: the thermal zone device to remove
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 9c75afff517a..0c3b549601d3 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -381,6 +381,12 @@ void devm_thermal_zone_of_sensor_unregister(struct device *dev,
 struct thermal_zone *thermal_zone_register(const char *, int, int,
 		void *, struct thermal_sensor_ops *,
 		struct thermal_zone_params *, int, int);
+
+struct thermal_zone *
+thermal_zone_register_with_trips(const char *, struct thermal_trip *, int, int,
+				 void *, struct thermal_sensor_ops *,
+				 struct thermal_zone_params *, int, int);
+
 void thermal_zone_unregister(struct thermal_zone *);
 
 int thermal_zone_bind_cooling_device(struct thermal_zone *, int,
-- 
2.25.1

