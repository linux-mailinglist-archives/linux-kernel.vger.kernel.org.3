Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADC051E72B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 14:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446377AbiEGNAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 09:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442603AbiEGM7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 08:59:16 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E844BB5E
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 05:55:21 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id b19so13424776wrh.11
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 05:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mNMbbnz7btHxGc8GohDuK10koCp0Ix4y578fYXBQdgs=;
        b=AmQ+2vPBw3hSjH5ZV0IP9Xp4FdgvOVjp+TJO4FYw6s35tzC4ew1VuRqTT2nH9zfHSK
         +lO8py9PsnTR3kKvcDhi9dKp4/hPqSCNFfDJkV4PPl5X1IWJtNcoa/wXIqk2gg9TAa9y
         O9uwpHIkWtWvSe7aW3HoiOYZcUgezt7ya2pe5gHLAlwn9o0byq5Z2D3T3NYPWlvCJR+t
         Yw26swMKL1nYGdbkI5ANAktm/pEAIAukCfvlBMo3fWPvZ0WDECNaJ+MWzixe6H3TTlBO
         PqK/TeptOM6S4oSghMx/ATVGQX40F9oZnm88Rafjz2zQFFWmb7brRzF4KM0xCJOYjUVZ
         /lSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mNMbbnz7btHxGc8GohDuK10koCp0Ix4y578fYXBQdgs=;
        b=M9Azzy4vmJFPK47YDMyXYDTcPLRFu3SC4c21f25K+HBzGrkrBbAWl4wg9Ta6+0Qtw5
         rxLFS195EC2EpcodAtfVPadb9L7sxSUNb/kyqzsceyQ+KlM1HAiOihS7uXe18n8elL8O
         Sk1c6pVSzL67Nwq1KXU1PohZnKemcWUb6OTZmbWe/Hz4MVr1N79aSuEkKE1smEQfEfag
         UkGSrsLpl1KQ/jTuvYuikjGy1M6os9wKzi+9Y7jcimIDRsERAAI72o3rAr9y2NJCBgi6
         VaZ8q7y6ju3xY47OWQEx7mcTyeAbNmdPp8CxqRchNV5qAaNIoSa2kixeJxHY1cD7YqvF
         S92g==
X-Gm-Message-State: AOAM532DEZ8BsT0UV9FFS3v4LMG6Kvd1fkAb/ocDiy7OGAoqSKGCKqWK
        ikLbT21v3W5OPiDxNP2HgmmKOQ==
X-Google-Smtp-Source: ABdhPJzV7QWoO76/KfhYOj7t6cwenAPOphaYTAO3t0HvYEB1yeBwNDWiAxd/Uz1y0HDHlGRO23nvOA==
X-Received: by 2002:a05:6000:1449:b0:20c:59b4:e9b9 with SMTP id v9-20020a056000144900b0020c59b4e9b9mr6605879wrx.698.1651928121515;
        Sat, 07 May 2022 05:55:21 -0700 (PDT)
Received: from localhost.localdomain (static-176-182-171-101.ncc.abo.bbox.fr. [176.182.171.101])
        by smtp.gmail.com with ESMTPSA id e9-20020a05600c218900b0039453fe55a7sm10470345wme.35.2022.05.07.05.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 05:55:21 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     khilman@baylibre.com, abailon@baylibre.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v2 13/14] thermal/of: Use thermal trips stored in the thermal zone
Date:   Sat,  7 May 2022 14:54:41 +0200
Message-Id: <20220507125443.2766939-14-daniel.lezcano@linexp.org>
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

Now that we have the thermal trip stored in the thermal zone in a
generic way, we can rely on them and remove one indirection we found
in the thermal_of code and do one more step forward the removal of the
duplicated structures.

Cc: Alexandre Bailon <abailon@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc; Eduardo Valentin <eduval@amazon.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/thermal_of.c | 53 +++++++++++-------------------------
 1 file changed, 16 insertions(+), 37 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 200d1d784211..64e5b9e92cb1 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -118,12 +118,7 @@ static int of_thermal_set_trips(struct thermal_zone_device *tz,
  */
 int of_thermal_get_ntrips(struct thermal_zone_device *tz)
 {
-	struct __thermal_zone *data = tz->devdata;
-
-	if (!data || IS_ERR(data))
-		return -ENODEV;
-
-	return data->ntrips;
+	return tz->ntrips;
 }
 EXPORT_SYMBOL_GPL(of_thermal_get_ntrips);
 
@@ -139,9 +134,7 @@ EXPORT_SYMBOL_GPL(of_thermal_get_ntrips);
  */
 bool of_thermal_is_trip_valid(struct thermal_zone_device *tz, int trip)
 {
-	struct __thermal_zone *data = tz->devdata;
-
-	if (!data || trip >= data->ntrips || trip < 0)
+	if (trip >= tz->ntrips || trip < 0)
 		return false;
 
 	return true;
@@ -161,12 +154,7 @@ EXPORT_SYMBOL_GPL(of_thermal_is_trip_valid);
 const struct thermal_trip *
 of_thermal_get_trip_points(struct thermal_zone_device *tz)
 {
-	struct __thermal_zone *data = tz->devdata;
-
-	if (!data)
-		return NULL;
-
-	return data->trips;
+	return tz->trips;
 }
 EXPORT_SYMBOL_GPL(of_thermal_get_trip_points);
 
@@ -273,12 +261,10 @@ static int of_thermal_unbind(struct thermal_zone_device *thermal,
 static int of_thermal_get_trip_type(struct thermal_zone_device *tz, int trip,
 				    enum thermal_trip_type *type)
 {
-	struct __thermal_zone *data = tz->devdata;
-
-	if (trip >= data->ntrips || trip < 0)
+	if (trip >= tz->ntrips || trip < 0)
 		return -EDOM;
 
-	*type = data->trips[trip].type;
+	*type = tz->trips[trip].type;
 
 	return 0;
 }
@@ -286,12 +272,10 @@ static int of_thermal_get_trip_type(struct thermal_zone_device *tz, int trip,
 static int of_thermal_get_trip_temp(struct thermal_zone_device *tz, int trip,
 				    int *temp)
 {
-	struct __thermal_zone *data = tz->devdata;
-
-	if (trip >= data->ntrips || trip < 0)
+	if (trip >= tz->ntrips || trip < 0)
 		return -EDOM;
 
-	*temp = data->trips[trip].temperature;
+	*temp = tz->trips[trip].temperature;
 
 	return 0;
 }
@@ -301,7 +285,7 @@ static int of_thermal_set_trip_temp(struct thermal_zone_device *tz, int trip,
 {
 	struct __thermal_zone *data = tz->devdata;
 
-	if (trip >= data->ntrips || trip < 0)
+	if (trip >= tz->ntrips || trip < 0)
 		return -EDOM;
 
 	if (data->ops && data->ops->set_trip_temp) {
@@ -313,7 +297,7 @@ static int of_thermal_set_trip_temp(struct thermal_zone_device *tz, int trip,
 	}
 
 	/* thermal framework should take care of data->mask & (1 << trip) */
-	data->trips[trip].temperature = temp;
+	tz->trips[trip].temperature = temp;
 
 	return 0;
 }
@@ -321,12 +305,10 @@ static int of_thermal_set_trip_temp(struct thermal_zone_device *tz, int trip,
 static int of_thermal_get_trip_hyst(struct thermal_zone_device *tz, int trip,
 				    int *hyst)
 {
-	struct __thermal_zone *data = tz->devdata;
-
-	if (trip >= data->ntrips || trip < 0)
+	if (trip >= tz->ntrips || trip < 0)
 		return -EDOM;
 
-	*hyst = data->trips[trip].hysteresis;
+	*hyst = tz->trips[trip].hysteresis;
 
 	return 0;
 }
@@ -334,13 +316,11 @@ static int of_thermal_get_trip_hyst(struct thermal_zone_device *tz, int trip,
 static int of_thermal_set_trip_hyst(struct thermal_zone_device *tz, int trip,
 				    int hyst)
 {
-	struct __thermal_zone *data = tz->devdata;
-
-	if (trip >= data->ntrips || trip < 0)
+	if (trip >= tz->ntrips || trip < 0)
 		return -EDOM;
 
 	/* thermal framework should take care of data->mask & (1 << trip) */
-	data->trips[trip].hysteresis = hyst;
+	tz->trips[trip].hysteresis = hyst;
 
 	return 0;
 }
@@ -348,12 +328,11 @@ static int of_thermal_set_trip_hyst(struct thermal_zone_device *tz, int trip,
 static int of_thermal_get_crit_temp(struct thermal_zone_device *tz,
 				    int *temp)
 {
-	struct __thermal_zone *data = tz->devdata;
 	int i;
 
-	for (i = 0; i < data->ntrips; i++)
-		if (data->trips[i].type == THERMAL_TRIP_CRITICAL) {
-			*temp = data->trips[i].temperature;
+	for (i = 0; i < tz->ntrips; i++)
+		if (tz->trips[i].type == THERMAL_TRIP_CRITICAL) {
+			*temp = tz->trips[i].temperature;
 			return 0;
 		}
 
-- 
2.25.1

