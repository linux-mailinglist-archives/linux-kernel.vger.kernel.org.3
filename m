Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C16358A376
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 00:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240365AbiHDWxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 18:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239986AbiHDWwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 18:52:43 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9D972ECD
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 15:52:25 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id v3so1427990wrp.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 15:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=vL3GxmFU1PfAZ2z+EriRN+gI33Lgd51OZIsIx0JbBgQ=;
        b=yM44Wh6z3wJTBMnHfb3b1dfUay/HasrI8/FPqDYipy7laYSv8NBJjoiujkVFmaNbWf
         knliAe/emTNw8WpEGJLMoF8BsHjT4vFMPWkB3SIsFPTlX+YuizukuUsMXnfBY0U3k5kS
         M8m0JI+mbMtXAZaLLIGK+jaeUQMGxe8R+bEMzOeeEJkMByJsYihMjgZu/L2B6cW1VN02
         Fmexa+z/yVq0Fl0ug0IpRm9rXqHCluUsygqxJ0lrzJGy8e3j3O7ZeewJScNNl6QJfZBX
         XAONeDF2jTlOBaTzCLKGY5LPIuESKIY7u44+YnAc1W2bb6Q3kLC3Bfz2gVV7n91K7dlo
         9mgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=vL3GxmFU1PfAZ2z+EriRN+gI33Lgd51OZIsIx0JbBgQ=;
        b=C2lKqZp0UtXiXAVrGsziIJfrJOnthjQIAvgVf/gLxX/hH9WOQdIhqf8x5eGdHm4WFp
         iTuCT/VE1CUfhIteheIfdgPlEmshxS07H+S5cKGk/LoQ+zTMhmI8QKiGx0xK1rTFGkSR
         /1NF4n5KoXw9nFiZwzhGT3hKqN+yLRxMgbiN55zx1h1hYmpNMtunporfBOj0UE5xuw5I
         dkCWytaQ7hXw7wyUJlJBI5KTpqkxA+9gSUcVzgMuqHrZjpOWrB5t7MAmw/tKAt+1mP06
         VSH3uFUA/CRHrNlKOZrSJQUgMr3Dd3Y1CnbB76RDJgzLp6b+xhAZR7hD1wUxyC8j70Uu
         Sqvw==
X-Gm-Message-State: ACgBeo0LOEL1dGO8Arg0SzMGvQwrudcnm1xYPUwAsONcNbLLN4fjIN9y
        qS11M8n73MlRsDH6HuYJ/2fCpA==
X-Google-Smtp-Source: AA6agR7GtRRrwnORSwHv9+/lG71h9IqM8KPR+qQP8MisIhY2vs7sXJ3Mv8MiOtY6l6s2gE9uVzoqoQ==
X-Received: by 2002:a5d:638b:0:b0:220:6f3e:9186 with SMTP id p11-20020a5d638b000000b002206f3e9186mr2444214wru.49.1659653543594;
        Thu, 04 Aug 2022 15:52:23 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:31aa:ed2c:3f7:19d])
        by smtp.gmail.com with ESMTPSA id a16-20020a056000051000b0021f87e8945asm2495906wrf.12.2022.08.04.15.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 15:52:23 -0700 (PDT)
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
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT)
Subject: [PATCH v5 11/33] thermal/drivers/qcom: Switch to new of API
Date:   Fri,  5 Aug 2022 00:43:27 +0200
Message-Id: <20220804224349.1926752-12-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
References: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
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
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c    | 19 +++++++++----------
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 12 ++++++------
 drivers/thermal/qcom/tsens.c                | 16 ++++++++--------
 3 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
index 073943cbcc2b..add6f40e5e2a 100644
--- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
+++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
@@ -357,9 +357,9 @@ static irqreturn_t adc_tm5_gen2_isr(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int adc_tm5_get_temp(void *data, int *temp)
+static int adc_tm5_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct adc_tm5_channel *channel = data;
+	struct adc_tm5_channel *channel = tz->devdata;
 	int ret;
 
 	if (!channel || !channel->iio)
@@ -639,9 +639,9 @@ static int adc_tm5_gen2_configure(struct adc_tm5_channel *channel, int low, int
 	return ret;
 }
 
-static int adc_tm5_set_trips(void *data, int low, int high)
+static int adc_tm5_set_trips(struct thermal_zone_device *tz, int low, int high)
 {
-	struct adc_tm5_channel *channel = data;
+	struct adc_tm5_channel *channel = tz->devdata;
 	struct adc_tm5_chip *chip;
 	int ret;
 
@@ -660,7 +660,7 @@ static int adc_tm5_set_trips(void *data, int low, int high)
 	return ret;
 }
 
-static struct thermal_zone_of_device_ops adc_tm5_thermal_ops = {
+static const struct thermal_zone_device_ops adc_tm5_thermal_ops = {
 	.get_temp = adc_tm5_get_temp,
 	.set_trips = adc_tm5_set_trips,
 };
@@ -672,11 +672,10 @@ static int adc_tm5_register_tzd(struct adc_tm5_chip *adc_tm)
 
 	for (i = 0; i < adc_tm->nchannels; i++) {
 		adc_tm->channels[i].chip = adc_tm;
-
-		tzd = devm_thermal_zone_of_sensor_register(adc_tm->dev,
-							   adc_tm->channels[i].channel,
-							   &adc_tm->channels[i],
-							   &adc_tm5_thermal_ops);
+		tzd = devm_thermal_of_zone_register(adc_tm->dev,
+						    adc_tm->channels[i].channel,
+						    &adc_tm->channels[i],
+						    &adc_tm5_thermal_ops);
 		if (IS_ERR(tzd)) {
 			if (PTR_ERR(tzd) == -ENODEV) {
 				dev_warn(adc_tm->dev, "thermal sensor on channel %d is not used\n",
diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index 770f82cc9bca..be785ab37e53 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -186,9 +186,9 @@ static int qpnp_tm_update_temp_no_adc(struct qpnp_tm_chip *chip)
 	return 0;
 }
 
-static int qpnp_tm_get_temp(void *data, int *temp)
+static int qpnp_tm_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct qpnp_tm_chip *chip = data;
+	struct qpnp_tm_chip *chip = tz->devdata;
 	int ret, mili_celsius;
 
 	if (!temp)
@@ -263,9 +263,9 @@ static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
 	return qpnp_tm_write(chip, QPNP_TM_REG_SHUTDOWN_CTRL1, reg);
 }
 
-static int qpnp_tm_set_trip_temp(void *data, int trip, int temp)
+static int qpnp_tm_set_trip_temp(struct thermal_zone_device *tz, int trip, int temp)
 {
-	struct qpnp_tm_chip *chip = data;
+	struct qpnp_tm_chip *chip = tz->devdata;
 	const struct thermal_trip *trip_points;
 	int ret;
 
@@ -283,7 +283,7 @@ static int qpnp_tm_set_trip_temp(void *data, int trip, int temp)
 	return ret;
 }
 
-static const struct thermal_zone_of_device_ops qpnp_tm_sensor_ops = {
+static const struct thermal_zone_device_ops qpnp_tm_sensor_ops = {
 	.get_temp = qpnp_tm_get_temp,
 	.set_trip_temp = qpnp_tm_set_trip_temp,
 };
@@ -446,7 +446,7 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 	 * read the trip points. get_temp() returns the default temperature
 	 * before the hardware initialization is completed.
 	 */
-	chip->tz_dev = devm_thermal_zone_of_sensor_register(
+	chip->tz_dev = devm_thermal_of_zone_register(
 		&pdev->dev, 0, chip, &qpnp_tm_sensor_ops);
 	if (IS_ERR(chip->tz_dev)) {
 		dev_err(&pdev->dev, "failed to register sensor\n");
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index e49f58e83513..b1b10005fb28 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -532,9 +532,9 @@ static irqreturn_t tsens_irq_thread(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int tsens_set_trips(void *_sensor, int low, int high)
+static int tsens_set_trips(struct thermal_zone_device *tz, int low, int high)
 {
-	struct tsens_sensor *s = _sensor;
+	struct tsens_sensor *s = tz->devdata;
 	struct tsens_priv *priv = s->priv;
 	struct device *dev = priv->dev;
 	struct tsens_irq_data d;
@@ -925,9 +925,9 @@ int __init init_common(struct tsens_priv *priv)
 	return ret;
 }
 
-static int tsens_get_temp(void *data, int *temp)
+static int tsens_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct tsens_sensor *s = data;
+	struct tsens_sensor *s = tz->devdata;
 	struct tsens_priv *priv = s->priv;
 
 	return priv->ops->get_temp(s, temp);
@@ -991,7 +991,7 @@ static const struct of_device_id tsens_table[] = {
 };
 MODULE_DEVICE_TABLE(of, tsens_table);
 
-static const struct thermal_zone_of_device_ops tsens_of_ops = {
+static const struct thermal_zone_device_ops tsens_of_ops = {
 	.get_temp = tsens_get_temp,
 	.set_trips = tsens_set_trips,
 };
@@ -1044,9 +1044,9 @@ static int tsens_register(struct tsens_priv *priv)
 
 	for (i = 0;  i < priv->num_sensors; i++) {
 		priv->sensor[i].priv = priv;
-		tzd = devm_thermal_zone_of_sensor_register(priv->dev, priv->sensor[i].hw_id,
-							   &priv->sensor[i],
-							   &tsens_of_ops);
+		tzd = devm_thermal_of_zone_register(priv->dev, priv->sensor[i].hw_id,
+						    &priv->sensor[i],
+						    &tsens_of_ops);
 		if (IS_ERR(tzd))
 			continue;
 		priv->sensor[i].tzd = tzd;
-- 
2.25.1

