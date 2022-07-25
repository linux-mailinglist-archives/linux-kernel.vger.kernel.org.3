Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D1F5806B5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 23:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237382AbiGYV3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 17:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237166AbiGYV2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 17:28:21 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488F8240B8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:27:42 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d8so17621809wrp.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eVR4CSPKsg/9FjgYXPjuWPfFNd2Yr4TVj6UpwGUj8uE=;
        b=lSGPGFMkmPAlpwMQja5l9hBjP3O81WxKw62XODPcgnj8vjPYpPP90o/4ior5lPAeVi
         U45U1jdgD0+KoWva6cyR9xKmjWg3jwi8opCLROL9ffzB9cfXfnKEy4iRR6y4P8NmeBkd
         SbHNPFOp3f8Sbgfuy6meLRPhhX4nTQQ+uWv+6r8jtEYLofFpotNTjl6z52hWvZ9bC9w6
         MNvJazEAtXxcvkyCQgJLwuPbde3M9uWkhDyusd9XsOGw+RkpLI+NckkkD1bZj95RGFjx
         KUvIgnJ7LKcg2aWOBD8N+KxiAsfk0cnUZ4scJqcFtVTwn7Phu2aT/AFmsf4t84kvH0a9
         NrCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eVR4CSPKsg/9FjgYXPjuWPfFNd2Yr4TVj6UpwGUj8uE=;
        b=N1oqSP738dIpxum6b+PGjBm9C7D+rVWF807tP7lKvakITcBBq8RV9idnYgoO3BYhbp
         6OR3w+GUyuXkIDOzj7r3UjsKl7vKDZnWnbyGOuuyVQzamOGmCs9b2oNst85r5rV+gZ4X
         0Ov4HE93+tbvDdv4NV5TVDg8NjADQyySozB1D6k4OKZNRmWBn8LAx0wftyMBeUS9frb3
         dGevTRCc8UJSXJbJV1hnGr4qu6qp0bsZOOSnVCDR08mvKb8GSX0Gh/aEe6BtNcbDqfyK
         9q1fRVeiBUd3EAQS49qxTskEoSz09wrAu00TDbaTnuMwXsvV4S5V15+bXloB+x+lqCtd
         EIIg==
X-Gm-Message-State: AJIora9z3s90B2xv1AWsjr6j20/GgnX21HA1mm00VpMNWFrhMJS83kf4
        9wwp1xfVLllcd4PYogVtQdUCHQ==
X-Google-Smtp-Source: AGRyM1toJIpS6B2vwFnLOmbxdgOlSmoXmAesaTeSUvZwvhTc9mjbi4Hm8bc6bah53VhNaD0bNzAdPA==
X-Received: by 2002:adf:e405:0:b0:21d:86b6:a286 with SMTP id g5-20020adfe405000000b0021d86b6a286mr8723875wrm.29.1658784458040;
        Mon, 25 Jul 2022 14:27:38 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:1780:8e54:dd38:6668])
        by smtp.gmail.com with ESMTPSA id r17-20020a5d52d1000000b0021d68a504cbsm12668772wrv.94.2022.07.25.14.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 14:27:37 -0700 (PDT)
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
        Amit Kucheria <amitk@kernel.org>,
        linux-renesas-soc@vger.kernel.org (open list:RENESAS R-CAR THERMAL
        DRIVERS)
Subject: [PATCH v2 17/32] thermal/drivers/rcar: Switch to new of API
Date:   Mon, 25 Jul 2022 23:26:22 +0200
Message-Id: <20220725212637.2818207-18-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220725212637.2818207-1-daniel.lezcano@linexp.org>
References: <20220725212637.2818207-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
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
---
 drivers/thermal/rcar_gen3_thermal.c | 16 ++++++++--------
 drivers/thermal/rcar_thermal.c      | 13 +++----------
 2 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 43eb25b167bc..29946114a8f9 100644
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
 			dev_err(dev, "Can't register thermal zone\n");
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

