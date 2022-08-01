Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C5958731A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 23:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235048AbiHAVX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 17:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235022AbiHAVXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 17:23:36 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F37459A1
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 14:23:20 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v3so14694237wrp.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 14:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=vJqB3DsidiN9nPhS4su/6uSlvLZimTeb9ZrCY8jA13M=;
        b=5aEbX/TT+Te0P+CqQQHLv8B4zadVUfeQTCYvYlPmDe4M1b5ShVtGfTmeDQoxDgsdhz
         0OJt6GGXbrrgTJPk4wqxUBI0lA54GnD7gMr6N6LfuBfOBN9jnuQTXVLaLZUfPFfrfb+i
         b3ZXJe6EA1oAT6KdrRObiklwsETGiM9P3aPamlZz2/e6IMwUT63AUoNKDu19i6tisn/m
         EYeVEyCao9KdRAeL1OQhDSBjMrtJthIrg7dGk+U2NsaYP0ajhXXXcV+KJ0dTlLEJzdry
         fIGuaenokeBdQ8/W0k/loJcWI2GIUGsZzr8/e7p3oDbUsmNfAuyz6F37ejAC5Iu9b/q2
         UJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=vJqB3DsidiN9nPhS4su/6uSlvLZimTeb9ZrCY8jA13M=;
        b=c+7lzHhBFv9Z3GzUXNZVVlE631l4i686kH1iyTU/S2ihvjxqsHt9Tj6aOeb4bu8EOp
         hx7D4feitrLJgY52oCKj57yhaoBN62D66fBkFH9bwuHqtdPNTzIs7qmeNgImdJYmwzOS
         SS9mKaRC+RfDO4zN7ltFh5fnROQNlWFpPVA/PC40Q2H+RyfPnMQe/yaGedVjg2VqhhkT
         oB2GDpgFtpI/938bS+xWVP8rB5HBbgDDJLV3yAZk4Dhl32HSA/WaEVU0+rRrx5m/GRXw
         /ILerjz6NLZGxgI22MB0kRCvVE17fGAmrBjI88mpdGXzr1bl5e+UbmvWonx7WZujqmR9
         QNYA==
X-Gm-Message-State: ACgBeo0QlXijk64XFZQrQvQM0MtxKC7AmIvsvm7Y8gT4gENeBG+UWoWz
        oqrFjKv9WsAfaaBlLQDRgg7f+A==
X-Google-Smtp-Source: AA6agR7JVJB6GT17vvJqVNVEjbmER9jrquRqPOJ8SRwz0E6BM569YRtxc6sDoxS+58jVuXWHbpNhRw==
X-Received: by 2002:a05:6000:1849:b0:21d:9ad7:f27f with SMTP id c9-20020a056000184900b0021d9ad7f27fmr10881260wri.445.1659388999689;
        Mon, 01 Aug 2022 14:23:19 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:d00:ceb8:9c09:1302])
        by smtp.gmail.com with ESMTPSA id c7-20020adffb07000000b0021e501519d3sm12995285wrr.67.2022.08.01.14.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 14:23:19 -0700 (PDT)
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
        Mikko Perttunen <mperttunen@nvidia.com>,
        linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT)
Subject: [PATCH v4 07/32] thermal/drivers/tegra: Switch to new of API
Date:   Mon,  1 Aug 2022 23:22:19 +0200
Message-Id: <20220801212244.1124867-8-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220801212244.1124867-1-daniel.lezcano@linexp.org>
References: <20220801212244.1124867-1-daniel.lezcano@linexp.org>
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
 drivers/thermal/tegra/soctherm.c           | 21 ++++++++++-----------
 drivers/thermal/tegra/tegra-bpmp-thermal.c | 19 ++++++++++++-------
 drivers/thermal/tegra/tegra30-tsensor.c    | 12 ++++++------
 3 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 825eab526619..1efe470f31e9 100644
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
@@ -657,9 +656,9 @@ static void thermal_irq_disable(struct tegra_thermctl_zone *zn)
 	mutex_unlock(&zn->ts->thermctl_lock);
 }
 
-static int tegra_thermctl_set_trips(void *data, int lo, int hi)
+static int tegra_thermctl_set_trips(struct thermal_zone_device *tz, int lo, int hi)
 {
-	struct tegra_thermctl_zone *zone = data;
+	struct tegra_thermctl_zone *zone = tz->devdata;
 	u32 r;
 
 	thermal_irq_disable(zone);
@@ -682,7 +681,7 @@ static int tegra_thermctl_set_trips(void *data, int lo, int hi)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops tegra_of_thermal_ops = {
+static const struct thermal_zone_device_ops tegra_of_thermal_ops = {
 	.get_temp = tegra_thermctl_get_temp,
 	.set_trip_temp = tegra_thermctl_set_trip_temp,
 	.set_trips = tegra_thermctl_set_trips,
@@ -2194,9 +2193,9 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
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
index 5affc3d196be..eb84f0b9dc7c 100644
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
@@ -60,9 +60,14 @@ static int tegra_bpmp_thermal_get_temp(void *data, int *out_temp)
 	return 0;
 }
 
-static int tegra_bpmp_thermal_set_trips(void *data, int low, int high)
+static int tegra_bpmp_thermal_get_temp(struct thermal_zone_device *tz, int *out_temp)
 {
-	struct tegra_bpmp_thermal_zone *zone = data;
+	return __tegra_bpmp_thermal_get_temp(tz->devdata, out_temp);
+}
+
+static int tegra_bpmp_thermal_set_trips(struct thermal_zone_device *tz, int low, int high)
+{
+	struct tegra_bpmp_thermal_zone *zone = tz->devdata;
 	struct mrq_thermal_host_to_bpmp_request req;
 	struct tegra_bpmp_message msg;
 	int err;
@@ -157,7 +162,7 @@ static int tegra_bpmp_thermal_get_num_zones(struct tegra_bpmp *bpmp,
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops tegra_bpmp_of_thermal_ops = {
+static const struct thermal_zone_device_ops tegra_bpmp_of_thermal_ops = {
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
index 05886684f429..c34501287e96 100644
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
+static const struct thermal_zone_device_ops ops = {
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

