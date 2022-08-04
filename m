Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5540B58A3AB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 00:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240284AbiHDWya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 18:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240020AbiHDWxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 18:53:31 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834566FA2D
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 15:52:46 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id b6so595950wmq.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 15:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=yKzLkry3f0ucVVy+WiLh8Z5rguSF04AWiaZnad/6qXc=;
        b=5XbbUHk6pZHx7L1UObi97tRtcLQbugm+p60O7OD16K8G29ipTKm6zNk1yCHtHK405/
         mtS+jyOjwOrp/Th75e3PcKk92TJD5jQdAQiG55eEBdx4o1xwcWLcDFtoe0kibf6ZerCA
         8SDNWWjyEUAfezqYJkIaAEaxwZARUvtqYjnmua0IAwSReuGvRdVCwjFk6uEw2alactHp
         3ScRY13O8wCb6aE//IMzjqFLoVo3A8bPTHKjd5v6ap1u8vj6N1uEgPm+bA3H3EWFGENt
         B5Teb24V1zctslz14TmPYWgI6+3fGErZWU0BBBnvyahMfZZXiUOySyJchuQOe5rLg7ty
         BHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=yKzLkry3f0ucVVy+WiLh8Z5rguSF04AWiaZnad/6qXc=;
        b=SxsA3uwMauzNiJHY1DuqpZM4JPjbnQXdl1mG0vakiCFwosh76wOopmagdpNaVpN8Xr
         yjgu2jS0QDO4TxjUwXd93Jw0VEqh7G155SVKmWgkq2Kal02vfwT/kwkm+c+f+JLl+FKq
         Bh12yrX1uqox0+6v7yU2xysqHSmUihDK+2lZizjygY/zXls0xs819CkTJg9E2XGVlZx3
         jj4LUBg6ns6eJrrWwInjtFy1WPl67L/HLGiO5paQfj/aZrSmoopqrKTg6TIByC4mQyJQ
         wxnxImYRAEdoHoTrwNX3Qe1WB//U4flRZi/Y+jpa2yreS72GCxbfYagRO7uwxwDT91CW
         CttQ==
X-Gm-Message-State: ACgBeo0Fc5Imn8nMWINFNwUjm0bIih6uAa/ialVELqa3kQNPKX4Eg9c4
        MR/GLwyu1C5Lr/YB+hVEaWuxXw==
X-Google-Smtp-Source: AA6agR5e+U9L1aPO1rNsa78rgW4IKb7eu6MYHFIV4BZGL3TuiZfNWy/THrM349VMVJFVAgJU7B+tlg==
X-Received: by 2002:a05:600c:4113:b0:3a3:4b67:d086 with SMTP id j19-20020a05600c411300b003a34b67d086mr7418689wmi.20.1659653566045;
        Thu, 04 Aug 2022 15:52:46 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:31aa:ed2c:3f7:19d])
        by smtp.gmail.com with ESMTPSA id a16-20020a056000051000b0021f87e8945asm2495906wrf.12.2022.08.04.15.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 15:52:45 -0700 (PDT)
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
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v5 21/33] thermal/drivers/banggap: Switch to new of API
Date:   Fri,  5 Aug 2022 00:43:37 +0200
Message-Id: <20220804224349.1926752-22-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
References: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
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

The thermal OF code has a new API allowing to migrate the OF
initialization to a simpler approach. The ops are no longer device
tree specific and are the generic ones provided by the core code.

Convert the ops to the thermal_zone_device_ops format and use the new
API to register the thermal zone with these generic ops.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/k3_bandgap.c       | 12 ++++++------
 drivers/thermal/k3_j72xx_bandgap.c | 12 +++++-------
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/k3_bandgap.c b/drivers/thermal/k3_bandgap.c
index 5d0b3ffc6f46..22c9bcb899c3 100644
--- a/drivers/thermal/k3_bandgap.c
+++ b/drivers/thermal/k3_bandgap.c
@@ -139,9 +139,9 @@ static int k3_bgp_read_temp(struct k3_thermal_data *devdata,
 	return 0;
 }
 
-static int k3_thermal_get_temp(void *devdata, int *temp)
+static int k3_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct k3_thermal_data *data = devdata;
+	struct k3_thermal_data *data = tz->devdata;
 	int ret = 0;
 
 	ret = k3_bgp_read_temp(data, temp);
@@ -151,7 +151,7 @@ static int k3_thermal_get_temp(void *devdata, int *temp)
 	return ret;
 }
 
-static const struct thermal_zone_of_device_ops k3_of_thermal_ops = {
+static const struct thermal_zone_device_ops k3_of_thermal_ops = {
 	.get_temp = k3_thermal_get_temp,
 };
 
@@ -213,9 +213,9 @@ static int k3_bandgap_probe(struct platform_device *pdev)
 		writel(val, data[id].bgp->base + data[id].ctrl_offset);
 
 		data[id].tzd =
-		devm_thermal_zone_of_sensor_register(dev, id,
-						     &data[id],
-						     &k3_of_thermal_ops);
+		devm_thermal_of_zone_register(dev, id,
+					      &data[id],
+					      &k3_of_thermal_ops);
 		if (IS_ERR(data[id].tzd)) {
 			dev_err(dev, "thermal zone device is NULL\n");
 			ret = PTR_ERR(data[id].tzd);
diff --git a/drivers/thermal/k3_j72xx_bandgap.c b/drivers/thermal/k3_j72xx_bandgap.c
index 115a44eb4fbf..16b6bcf1bf4f 100644
--- a/drivers/thermal/k3_j72xx_bandgap.c
+++ b/drivers/thermal/k3_j72xx_bandgap.c
@@ -247,9 +247,9 @@ static inline int k3_bgp_read_temp(struct k3_thermal_data *devdata,
 }
 
 /* Get temperature callback function for thermal zone */
-static int k3_thermal_get_temp(void *devdata, int *temp)
+static int k3_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct k3_thermal_data *data = devdata;
+	struct k3_thermal_data *data = tz->devdata;
 	int ret = 0;
 
 	ret = k3_bgp_read_temp(data, temp);
@@ -259,7 +259,7 @@ static int k3_thermal_get_temp(void *devdata, int *temp)
 	return ret;
 }
 
-static const struct thermal_zone_of_device_ops k3_of_thermal_ops = {
+static const struct thermal_zone_device_ops k3_of_thermal_ops = {
 	.get_temp = k3_thermal_get_temp,
 };
 
@@ -474,10 +474,8 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 		writel(val, data[id].bgp->cfg2_base + data[id].ctrl_offset);
 
 		bgp->ts_data[id] = &data[id];
-		ti_thermal =
-		devm_thermal_zone_of_sensor_register(bgp->dev, id,
-						     &data[id],
-						     &k3_of_thermal_ops);
+		ti_thermal = devm_thermal_of_zone_register(bgp->dev, id, &data[id],
+							   &k3_of_thermal_ops);
 		if (IS_ERR(ti_thermal)) {
 			dev_err(bgp->dev, "thermal zone device is NULL\n");
 			ret = PTR_ERR(ti_thermal);
-- 
2.25.1

