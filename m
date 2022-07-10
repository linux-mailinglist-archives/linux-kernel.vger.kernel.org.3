Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0EB56D171
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 23:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiGJVZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 17:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiGJVZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 17:25:12 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CFC15FDA
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 14:24:58 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id r14so4782190wrg.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 14:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6nqlS4HJEPRuqGXDCJhKcOM7h4FYHZtSlqnLPCfi0Dk=;
        b=ZrAOZwErE5/4X6q2IFyHuCtdYe0LUbpXz71u3/j2ONeWEKZfTyIoVIGYwAsZhnrG3Q
         IoN7BR+eGyF9dQRLKhR/py5VHYAfJtAmBtDYlDqwghZer/XXzMs9dL/eLbbd/hS2QgaT
         w/rioF7n98gh9q6X8HfgD0bEugz9KDGOhBfAVOLbKOd2ohLod1fQcOnugOjm53ZPKxxc
         mzhHGB/dqDWcVjYFTFb7sI8aGUG9MUt3o2AaamlpipS6QnvLCc4OjF7DS8YbMQ8cGRYM
         c+5KcVTgeHv2L98HktAcgnyDTLz75zxFokDlTGwrlugjPdIeaeYmzleuM7MZf9K2vlLt
         jHrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6nqlS4HJEPRuqGXDCJhKcOM7h4FYHZtSlqnLPCfi0Dk=;
        b=CYVocS/sR/+9ngzwNGLICrrLhgKnBubPKc5e+oJ5YOC7bqiR7FiUh99NranMRnTtOD
         jSoX1xmwKBSCfgorCdiH37dKu/ub5yzw93ok6SBks/3lFyXpVfEjcaLjfCtqrXmNtWqz
         I8hRdoga5VhSYhSIhiBl/tII1TY6kPNi8jcQz+i8trsk/TNuKgyNbwE+ytMXXdvPrAwn
         noHg72ASMOz7qeoYY0kW6Crpx5XztfNy88EMviuIL4rNnIw9fETcpT8VlzmwQXSSr3oH
         pxjG1BYT2KpnHY2GTl1aZYY9XFLbaKG/fT8OQlBTxNm6e+S3MiTK9vteqzBv5AwlVKNR
         QTjg==
X-Gm-Message-State: AJIora9HHCLagRwtaegi8iQI89j//BO+yAEjz/xDsov2V6oB2hdUpgAS
        +jK8MV1Ei61BC4mOUn1OuXg36g==
X-Google-Smtp-Source: AGRyM1v+9b1xcJVkyjHsDKyIMiEXCdIeWEBpxVHAXAVVYARXpuoGu5ErD/Dkeo9nxBMpRfF7q9WBlw==
X-Received: by 2002:adf:ed10:0:b0:21d:a9a1:3526 with SMTP id a16-20020adfed10000000b0021da9a13526mr191708wro.403.1657488298373;
        Sun, 10 Jul 2022 14:24:58 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:c7c0:6823:f3ce:2447])
        by smtp.gmail.com with ESMTPSA id m19-20020a05600c3b1300b003a2dd0d21f0sm7142759wms.13.2022.07.10.14.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 14:24:58 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, khilman@baylibre.com, abailon@baylibre.com,
        amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT)
Subject: [PATCH v1 11/33] thermal/drivers/qcom: Switch to new of API
Date:   Sun, 10 Jul 2022 23:24:01 +0200
Message-Id: <20220710212423.681301-12-daniel.lezcano@linexp.org>
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
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c    | 19 +++++++++----------
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 12 ++++++------
 drivers/thermal/qcom/tsens.c                | 20 ++++++++++----------
 3 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
index d9c9c975f931..dccbb66e5cd2 100644
--- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
+++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
@@ -355,9 +355,9 @@ static irqreturn_t adc_tm5_gen2_isr(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int adc_tm5_get_temp(void *data, int *temp)
+static int adc_tm5_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct adc_tm5_channel *channel = data;
+	struct adc_tm5_channel *channel = tz->devdata;
 	int ret;
 
 	if (!channel || !channel->iio)
@@ -637,9 +637,9 @@ static int adc_tm5_gen2_configure(struct adc_tm5_channel *channel, int low, int
 	return ret;
 }
 
-static int adc_tm5_set_trips(void *data, int low, int high)
+static int adc_tm5_set_trips(struct thermal_zone_device *tz, int low, int high)
 {
-	struct adc_tm5_channel *channel = data;
+	struct adc_tm5_channel *channel = tz->devdata;
 	struct adc_tm5_chip *chip;
 	int ret;
 
@@ -658,7 +658,7 @@ static int adc_tm5_set_trips(void *data, int low, int high)
 	return ret;
 }
 
-static struct thermal_zone_of_device_ops adc_tm5_thermal_ops = {
+static struct thermal_zone_device_ops adc_tm5_thermal_ops = {
 	.get_temp = adc_tm5_get_temp,
 	.set_trips = adc_tm5_set_trips,
 };
@@ -670,11 +670,10 @@ static int adc_tm5_register_tzd(struct adc_tm5_chip *adc_tm)
 
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
index 7419e196dbb0..cb1d382e833f 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -185,9 +185,9 @@ static int qpnp_tm_update_temp_no_adc(struct qpnp_tm_chip *chip)
 	return 0;
 }
 
-static int qpnp_tm_get_temp(void *data, int *temp)
+static int qpnp_tm_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct qpnp_tm_chip *chip = data;
+	struct qpnp_tm_chip *chip = tz->devdata;
 	int ret, mili_celsius;
 
 	if (!temp)
@@ -262,9 +262,9 @@ static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
 	return qpnp_tm_write(chip, QPNP_TM_REG_SHUTDOWN_CTRL1, reg);
 }
 
-static int qpnp_tm_set_trip_temp(void *data, int trip, int temp)
+static int qpnp_tm_set_trip_temp(struct thermal_zone_device *tz, int trip, int temp)
 {
-	struct qpnp_tm_chip *chip = data;
+	struct qpnp_tm_chip *chip = tz->devdata;
 	const struct thermal_trip *trip_points;
 	int ret;
 
@@ -282,7 +282,7 @@ static int qpnp_tm_set_trip_temp(void *data, int trip, int temp)
 	return ret;
 }
 
-static const struct thermal_zone_of_device_ops qpnp_tm_sensor_ops = {
+static struct thermal_zone_device_ops qpnp_tm_sensor_ops = {
 	.get_temp = qpnp_tm_get_temp,
 	.set_trip_temp = qpnp_tm_set_trip_temp,
 };
@@ -445,7 +445,7 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 	 * read the trip points. get_temp() returns the default temperature
 	 * before the hardware initialization is completed.
 	 */
-	chip->tz_dev = devm_thermal_zone_of_sensor_register(
+	chip->tz_dev = devm_thermal_of_zone_register(
 		&pdev->dev, 0, chip, &qpnp_tm_sensor_ops);
 	if (IS_ERR(chip->tz_dev)) {
 		dev_err(&pdev->dev, "failed to register sensor\n");
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 7963ee33bf75..f59ad42d94e6 100644
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
@@ -925,17 +925,17 @@ int __init init_common(struct tsens_priv *priv)
 	return ret;
 }
 
-static int tsens_get_temp(void *data, int *temp)
+static int tsens_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct tsens_sensor *s = data;
+	struct tsens_sensor *s = tz->devdata;
 	struct tsens_priv *priv = s->priv;
 
 	return priv->ops->get_temp(s, temp);
 }
 
-static int tsens_get_trend(void *data, int trip, enum thermal_trend *trend)
+static int tsens_get_trend(struct thermal_zone_device *tz, int trip, enum thermal_trend *trend)
 {
-	struct tsens_sensor *s = data;
+	struct tsens_sensor *s = tz->devdata;
 	struct tsens_priv *priv = s->priv;
 
 	if (priv->ops->get_trend)
@@ -1002,7 +1002,7 @@ static const struct of_device_id tsens_table[] = {
 };
 MODULE_DEVICE_TABLE(of, tsens_table);
 
-static const struct thermal_zone_of_device_ops tsens_of_ops = {
+static struct thermal_zone_device_ops tsens_of_ops = {
 	.get_temp = tsens_get_temp,
 	.get_trend = tsens_get_trend,
 	.set_trips = tsens_set_trips,
@@ -1056,9 +1056,9 @@ static int tsens_register(struct tsens_priv *priv)
 
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

