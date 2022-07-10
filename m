Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8429556D169
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 23:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiGJVZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 17:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiGJVZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 17:25:01 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2D413E38
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 14:24:50 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id bk26so4740376wrb.11
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 14:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SyxSecaxyfXq67qrGJ11K0Y7p/mmLBDlC9uSFmHhUoU=;
        b=qiIGEGFDy9aVU7pT3HL3df9gb2BMR/O6+I0Hah7kXPmN2zCL5LMjVP1MdyUjRgtfTW
         +z2Drc6Iyyukl4YtezkIzoGzgIuGDS/aCh/HJc8vflrq8Qlni0u1GMxR8Z7KRfgBnJPz
         7i1uWMFtA+OWR8IwwQUyFGJzSBM+5o7QAefem17GgGffu/Q/zCidXvMeUKwnr0zyt4hG
         m75u8kelrd3/Fy4vF43DaWxeE+aVO/dVwqX+bLazcbCbnS9akrQDWVTbR6xfayQzxoJq
         gHmlQvr5umn+ZPh4QCE5daEgJRpk7Vzu+kIolrXiJ+/1l7032owCdV4TEIPdT++/GfmU
         YwzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SyxSecaxyfXq67qrGJ11K0Y7p/mmLBDlC9uSFmHhUoU=;
        b=yz/xT6Hzoaqh3HpIp6Zde1Iw835Cx1FcBK+jMisPMTAPyE9TX3yqiHuWqRrXuj7zfS
         pFk7va5muUcx9NwiFbvtojML2yxWfe91lm/s8BVN/u0OELGQGTYygKU4N5egmNAm2qaW
         rxuu3TsxRJS6zQyyURfzpVlyQ+GrVb+juw2M+X7pU2zULI0PPRER2YldF2g0LmIomGl5
         xRXHL/3IOETARPnyqhoh/0Zdeg4NsToUJyPWSitjfQlO1mOXDYsPkiI6t0G7A5d5Kifz
         m3xt8CAAe/trrShnIgXTkv7Yn4we+uNM/oeBpNrJrEI5FE7xAno11AzkrdYN498NhKoR
         B4lQ==
X-Gm-Message-State: AJIora8FeKOo5RUX8JkoSxu5CmzArcxH3q2KEW4IArkacBP4tE2Jj7ZH
        sX5Q9a421NKYAbcRg5A7hBBqfdwFWivz3w==
X-Google-Smtp-Source: AGRyM1vhe7RfcxS8aO85F2LLfcWjkn1lLG61No+kHWIvhrtj2bwrow/v9AyZ18K4n7RWPttGImWAQw==
X-Received: by 2002:a05:6000:1d1:b0:21d:6673:9894 with SMTP id t17-20020a05600001d100b0021d66739894mr13925586wrx.640.1657488290010;
        Sun, 10 Jul 2022 14:24:50 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:c7c0:6823:f3ce:2447])
        by smtp.gmail.com with ESMTPSA id m19-20020a05600c3b1300b003a2dd0d21f0sm7142759wms.13.2022.07.10.14.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 14:24:49 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, khilman@baylibre.com, abailon@baylibre.com,
        amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT)
Subject: [PATCH v1 07/33] thermal/drivers/tegra: Switch to new of API
Date:   Sun, 10 Jul 2022 23:23:57 +0200
Message-Id: <20220710212423.681301-8-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220710212423.681301-1-daniel.lezcano@linexp.org>
References: <20220710212423.681301-1-daniel.lezcano@linexp.org>
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

The thermal OF code has a new API allowing to migrate the OF
initialization to a simpler approach.

Use this new API.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/tegra/soctherm.c           | 27 ++++++++++------------
 drivers/thermal/tegra/tegra-bpmp-thermal.c | 19 +++++++++------
 drivers/thermal/tegra/tegra30-tsensor.c    | 12 +++++-----
 3 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 210325f92559..ae53bfc9e50b 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -421,9 +421,9 @@ static int translate_temp(u16 val)
 	return t;
 }
 
-static int tegra_thermctl_get_temp(void *data, int *out_temp)
+static int tegra_thermctl_get_temp(struct thermal_zone_device *tz, int *out_temp)
 {
-	struct tegra_thermctl_zone *zone = data;
+	struct tegra_thermctl_zone *zone = tz->devdata;
 	u32 val;
 
 	val = readl(zone->reg);
@@ -582,10 +582,9 @@ static int tsensor_group_thermtrip_get(struct tegra_soctherm *ts, int id)
 	return temp;
 }
 
-static int tegra_thermctl_set_trip_temp(void *data, int trip, int temp)
+static int tegra_thermctl_set_trip_temp(struct thermal_zone_device *tz, int trip, int temp)
 {
-	struct tegra_thermctl_zone *zone = data;
-	struct thermal_zone_device *tz = zone->tz;
+	struct tegra_thermctl_zone *zone = tz->devdata;
 	struct tegra_soctherm *ts = zone->ts;
 	const struct tegra_tsensor_group *sg = zone->sg;
 	struct device *dev = zone->dev;
@@ -633,17 +632,15 @@ static int tegra_thermctl_set_trip_temp(void *data, int trip, int temp)
 	return 0;
 }
 
-static int tegra_thermctl_get_trend(void *data, int trip,
+static int tegra_thermctl_get_trend(struct thermal_zone_device *tz, int trip,
 				    enum thermal_trend *trend)
 {
-	struct tegra_thermctl_zone *zone = data;
-	struct thermal_zone_device *tz = zone->tz;
 	int trip_temp, temp, last_temp, ret;
 
 	if (!tz)
 		return -EINVAL;
 
-	ret = tz->ops->get_trip_temp(zone->tz, trip, &trip_temp);
+	ret = tz->ops->get_trip_temp(tz, trip, &trip_temp);
 	if (ret)
 		return ret;
 
@@ -688,9 +685,9 @@ static void thermal_irq_disable(struct tegra_thermctl_zone *zn)
 	mutex_unlock(&zn->ts->thermctl_lock);
 }
 
-static int tegra_thermctl_set_trips(void *data, int lo, int hi)
+static int tegra_thermctl_set_trips(struct thermal_zone_device *tz, int lo, int hi)
 {
-	struct tegra_thermctl_zone *zone = data;
+	struct tegra_thermctl_zone *zone = tz->devdata;
 	u32 r;
 
 	thermal_irq_disable(zone);
@@ -713,7 +710,7 @@ static int tegra_thermctl_set_trips(void *data, int lo, int hi)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops tegra_of_thermal_ops = {
+static struct thermal_zone_device_ops tegra_of_thermal_ops = {
 	.get_temp = tegra_thermctl_get_temp,
 	.set_trip_temp = tegra_thermctl_set_trip_temp,
 	.get_trend = tegra_thermctl_get_trend,
@@ -2226,9 +2223,9 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 		zone->sg = soc->ttgs[i];
 		zone->ts = tegra;
 
-		z = devm_thermal_zone_of_sensor_register(&pdev->dev,
-							 soc->ttgs[i]->id, zone,
-							 &tegra_of_thermal_ops);
+		z = devm_thermal_of_zone_register(&pdev->dev,
+						  soc->ttgs[i]->id, zone,
+						  &tegra_of_thermal_ops);
 		if (IS_ERR(z)) {
 			err = PTR_ERR(z);
 			dev_err(&pdev->dev, "failed to register sensor: %d\n",
diff --git a/drivers/thermal/tegra/tegra-bpmp-thermal.c b/drivers/thermal/tegra/tegra-bpmp-thermal.c
index 5affc3d196be..a88d292a063a 100644
--- a/drivers/thermal/tegra/tegra-bpmp-thermal.c
+++ b/drivers/thermal/tegra/tegra-bpmp-thermal.c
@@ -30,9 +30,9 @@ struct tegra_bpmp_thermal {
 	struct tegra_bpmp_thermal_zone **zones;
 };
 
-static int tegra_bpmp_thermal_get_temp(void *data, int *out_temp)
+static int __tegra_bpmp_thermal_get_temp(struct tegra_bpmp_thermal_zone *zone,
+					 int *out_temp)
 {
-	struct tegra_bpmp_thermal_zone *zone = data;
 	struct mrq_thermal_host_to_bpmp_request req;
 	union mrq_thermal_bpmp_to_host_response reply;
 	struct tegra_bpmp_message msg;
@@ -59,10 +59,15 @@ static int tegra_bpmp_thermal_get_temp(void *data, int *out_temp)
 
 	return 0;
 }
+	
+static int tegra_bpmp_thermal_get_temp(struct thermal_zone_device *tz, int *out_temp)
+{
+	return __tegra_bpmp_thermal_get_temp(tz->devdata, out_temp);
+}
 
-static int tegra_bpmp_thermal_set_trips(void *data, int low, int high)
+static int tegra_bpmp_thermal_set_trips(struct thermal_zone_device *tz, int low, int high)
 {
-	struct tegra_bpmp_thermal_zone *zone = data;
+	struct tegra_bpmp_thermal_zone *zone = tz->devdata;
 	struct mrq_thermal_host_to_bpmp_request req;
 	struct tegra_bpmp_message msg;
 	int err;
@@ -157,7 +162,7 @@ static int tegra_bpmp_thermal_get_num_zones(struct tegra_bpmp *bpmp,
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops tegra_bpmp_of_thermal_ops = {
+static struct thermal_zone_device_ops tegra_bpmp_of_thermal_ops = {
 	.get_temp = tegra_bpmp_thermal_get_temp,
 	.set_trips = tegra_bpmp_thermal_set_trips,
 };
@@ -200,13 +205,13 @@ static int tegra_bpmp_thermal_probe(struct platform_device *pdev)
 		zone->idx = i;
 		zone->tegra = tegra;
 
-		err = tegra_bpmp_thermal_get_temp(zone, &temp);
+		err = __tegra_bpmp_thermal_get_temp(zone, &temp);
 		if (err < 0) {
 			devm_kfree(&pdev->dev, zone);
 			continue;
 		}
 
-		tzd = devm_thermal_zone_of_sensor_register(
+		tzd = devm_thermal_of_zone_register(
 			&pdev->dev, i, zone, &tegra_bpmp_of_thermal_ops);
 		if (IS_ERR(tzd)) {
 			if (PTR_ERR(tzd) == -EPROBE_DEFER)
diff --git a/drivers/thermal/tegra/tegra30-tsensor.c b/drivers/thermal/tegra/tegra30-tsensor.c
index 05886684f429..8384980be9e3 100644
--- a/drivers/thermal/tegra/tegra30-tsensor.c
+++ b/drivers/thermal/tegra/tegra30-tsensor.c
@@ -159,9 +159,9 @@ static void devm_tegra_tsensor_hw_disable(void *data)
 	tegra_tsensor_hw_disable(ts);
 }
 
-static int tegra_tsensor_get_temp(void *data, int *temp)
+static int tegra_tsensor_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	const struct tegra_tsensor_channel *tsc = data;
+	const struct tegra_tsensor_channel *tsc = tz->devdata;
 	const struct tegra_tsensor *ts = tsc->ts;
 	int err, c1, c2, c3, c4, counter;
 	u32 val;
@@ -217,9 +217,9 @@ static int tegra_tsensor_temp_to_counter(const struct tegra_tsensor *ts, int tem
 	return DIV_ROUND_CLOSEST(c2 * 1000000 - ts->calib.b, ts->calib.a);
 }
 
-static int tegra_tsensor_set_trips(void *data, int low, int high)
+static int tegra_tsensor_set_trips(struct thermal_zone_device *tz, int low, int high)
 {
-	const struct tegra_tsensor_channel *tsc = data;
+	const struct tegra_tsensor_channel *tsc = tz->devdata;
 	const struct tegra_tsensor *ts = tsc->ts;
 	u32 val;
 
@@ -240,7 +240,7 @@ static int tegra_tsensor_set_trips(void *data, int low, int high)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops ops = {
+static struct thermal_zone_device_ops ops = {
 	.get_temp = tegra_tsensor_get_temp,
 	.set_trips = tegra_tsensor_set_trips,
 };
@@ -516,7 +516,7 @@ static int tegra_tsensor_register_channel(struct tegra_tsensor *ts,
 	tsc->id = id;
 	tsc->regs = ts->regs + 0x40 * (hw_id + 1);
 
-	tsc->tzd = devm_thermal_zone_of_sensor_register(ts->dev, id, tsc, &ops);
+	tsc->tzd = devm_thermal_of_zone_register(ts->dev, id, tsc, &ops);
 	if (IS_ERR(tsc->tzd)) {
 		if (PTR_ERR(tsc->tzd) != -ENODEV)
 			return dev_err_probe(ts->dev, PTR_ERR(tsc->tzd),
-- 
2.25.1

