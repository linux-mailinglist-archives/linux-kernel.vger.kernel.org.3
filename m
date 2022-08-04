Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1457858A3A0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 00:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240257AbiHDWyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 18:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240104AbiHDWxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 18:53:11 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704E27392C
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 15:52:38 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id bk11so1321615wrb.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 15:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=862ebCD8XkBY+/fgfesDVhZbuj5QTeks1/6fcN22nnM=;
        b=jlDWsEd+wOoGzBZpyJ8BDcfladI9aAAtZW/e15zk8sAHVnlKD6ERBLT8tY5/g5CgCm
         b++ei1BHOYgf23U7K9lVfMY5RAqDlK+zOaiZ+vVpLbuBMp4sdwcI7hW/gGKN6T/q01XV
         sFJ597LNi0BNlqPmli3sPfUNJHton7Q9JWkleRUwZsgdI8rWIayNl+p/9RvDvSdfuXhC
         oQtK4uxTjW6hF8/U7RZQoCBMWA7L6PCjLyQDLJpXPLWSpyJC7GOCG+MK928lsZ/FuEEJ
         pwwcR48oh6UiJ/VHejaPU7XaihErE3TknDwDW9vAJE45TXJnL/4dnTVJ1HM9v2q70D0t
         WWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=862ebCD8XkBY+/fgfesDVhZbuj5QTeks1/6fcN22nnM=;
        b=uMBx03fPehy0VNyAjldc0doTfWcMzaUDcewzsQN1FP7hFp5Kqgy4/B0IQo401M0YvD
         sp6tcOTob7EPYzGjYfkgSKrzRyo8ru401rIBDZLXPGmoTLq6ivR/Ru6iuV/9g7vR9OEn
         jkqhfF0Jb4zxTWRu267n0DhecdZRlVjLFGdSOWKCoJ+pu2hR8NGmy4arZIl2IlMxUEkQ
         S2mk/wk7wQdX+EO025RLGpQfHump+Dh8rpwFMHl7UyklVT3Bcd9t/Z2GtA0906WhgMyz
         Y5e/WpWG6nqTl31+xtbZOhQjpW8X6ObumtieHRskMUdro27Ksduzd3RBG00KF5Aqe32+
         W8lw==
X-Gm-Message-State: ACgBeo1FVx2qWZKz7etirjG6iQOW48vs1q6pADSJp3QWU917ky1TTeOu
        DLUpIcKqTC6DWIwFfzB/vvR6FA==
X-Google-Smtp-Source: AA6agR644uZ11Mg+m/Ue7F6oUbIEJ6cxYuXrqDLksyGDcOFFz5vgUkBzcLT3EBvKmDlc+HUxvWl3IA==
X-Received: by 2002:a5d:4802:0:b0:21e:c78b:30b5 with SMTP id l2-20020a5d4802000000b0021ec78b30b5mr2399636wrq.203.1659653557759;
        Thu, 04 Aug 2022 15:52:37 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:31aa:ed2c:3f7:19d])
        by smtp.gmail.com with ESMTPSA id a16-20020a056000051000b0021f87e8945asm2495906wrf.12.2022.08.04.15.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 15:52:37 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com, broonie@kernel.org,
        damien.lemoal@opensource.wdc.com, heiko@sntech.de,
        hayashi.kunihiko@socionext.com, mhiramat@kernel.org,
        talel@amazon.com, thierry.reding@gmail.com, digetx@gmail.com,
        jonathanh@nvidia.com, anarsoul@gmail.com, tiny.windzz@gmail.com,
        baolin.wang7@gmail.com, f.fainelli@gmail.com,
        bjorn.andersson@linaro.org, mcoquelin.stm32@gmail.com,
        glaroque@baylibre.com, miquel.raynal@bootlin.com,
        shawnguo@kernel.org, niklas.soderlund@ragnatech.se,
        matthias.bgg@gmail.com, j-keerthy@ti.com,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Amit Kucheria <amitk@kernel.org>,
        linux-renesas-soc@vger.kernel.org (open list:RENESAS R-CAR THERMAL
        DRIVERS)
Subject: [PATCH v5 17/33] thermal/drivers/rcar: Switch to new of API
Date:   Fri,  5 Aug 2022 00:43:33 +0200
Message-Id: <20220804224349.1926752-18-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
References: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal OF code has a new API allowing to migrate the OF
initialization to a simpler approach. The ops are no longer device
tree specific and are the generic ones provided by the core code.

Convert the ops to the thermal_zone_device_ops format and use the new
API to register the thermal zone with these generic ops.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
Tested-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/thermal/rcar_gen3_thermal.c | 16 ++++++++--------
 drivers/thermal/rcar_thermal.c      | 13 +++----------
 2 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index e2020c6308cc..40ec63ad0a1b 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -164,9 +164,9 @@ static int rcar_gen3_thermal_round(int temp)
 	return result * RCAR3_THERMAL_GRAN;
 }
 
-static int rcar_gen3_thermal_get_temp(void *devdata, int *temp)
+static int rcar_gen3_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct rcar_gen3_thermal_tsc *tsc = devdata;
+	struct rcar_gen3_thermal_tsc *tsc = tz->devdata;
 	int mcelsius, val;
 	int reg;
 
@@ -203,9 +203,9 @@ static int rcar_gen3_thermal_mcelsius_to_temp(struct rcar_gen3_thermal_tsc *tsc,
 	return INT_FIXPT(val);
 }
 
-static int rcar_gen3_thermal_set_trips(void *devdata, int low, int high)
+static int rcar_gen3_thermal_set_trips(struct thermal_zone_device *tz, int low, int high)
 {
-	struct rcar_gen3_thermal_tsc *tsc = devdata;
+	struct rcar_gen3_thermal_tsc *tsc = tz->devdata;
 	u32 irqmsk = 0;
 
 	if (low != -INT_MAX) {
@@ -225,7 +225,7 @@ static int rcar_gen3_thermal_set_trips(void *devdata, int low, int high)
 	return 0;
 }
 
-static struct thermal_zone_of_device_ops rcar_gen3_tz_of_ops = {
+static struct thermal_zone_device_ops rcar_gen3_tz_of_ops = {
 	.get_temp	= rcar_gen3_thermal_get_temp,
 	.set_trips	= rcar_gen3_thermal_set_trips,
 };
@@ -504,8 +504,8 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 	for (i = 0; i < priv->num_tscs; i++) {
 		struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
 
-		zone = devm_thermal_zone_of_sensor_register(dev, i, tsc,
-							    &rcar_gen3_tz_of_ops);
+		zone = devm_thermal_of_zone_register(dev, i, tsc,
+						     &rcar_gen3_tz_of_ops);
 		if (IS_ERR(zone)) {
 			dev_err(dev, "Sensor %u: Can't register thermal zone\n", i);
 			ret = PTR_ERR(zone);
@@ -556,7 +556,7 @@ static int __maybe_unused rcar_gen3_thermal_resume(struct device *dev)
 
 		priv->thermal_init(tsc);
 		if (zone->ops->set_trips)
-			rcar_gen3_thermal_set_trips(tsc, zone->prev_low_trip,
+			rcar_gen3_thermal_set_trips(zone, zone->prev_low_trip,
 						    zone->prev_high_trip);
 	}
 
diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 1d729ed4d685..4df42d70d867 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -271,13 +271,6 @@ static int rcar_thermal_get_current_temp(struct rcar_thermal_priv *priv,
 	return 0;
 }
 
-static int rcar_thermal_of_get_temp(void *data, int *temp)
-{
-	struct rcar_thermal_priv *priv = data;
-
-	return rcar_thermal_get_current_temp(priv, temp);
-}
-
 static int rcar_thermal_get_temp(struct thermal_zone_device *zone, int *temp)
 {
 	struct rcar_thermal_priv *priv = rcar_zone_to_priv(zone);
@@ -323,8 +316,8 @@ static int rcar_thermal_get_trip_temp(struct thermal_zone_device *zone,
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops rcar_thermal_zone_of_ops = {
-	.get_temp	= rcar_thermal_of_get_temp,
+static struct thermal_zone_device_ops rcar_thermal_zone_of_ops = {
+	.get_temp	= rcar_thermal_get_temp,
 };
 
 static struct thermal_zone_device_ops rcar_thermal_zone_ops = {
@@ -534,7 +527,7 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 			goto error_unregister;
 
 		if (chip->use_of_thermal) {
-			priv->zone = devm_thermal_zone_of_sensor_register(
+			priv->zone = devm_thermal_of_zone_register(
 						dev, i, priv,
 						&rcar_thermal_zone_of_ops);
 		} else {
-- 
2.25.1

