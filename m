Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A266587AB7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 12:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236366AbiHBKaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 06:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236570AbiHBKac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 06:30:32 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DD065D3
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 03:30:29 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z2so6630527edc.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 03:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+0qVYGdGmkDnAqj07TMHGbTEwacGQLQsY1ouzYx3iFU=;
        b=IVkRC6sayTaFbFWfFibA1j9ARFdJdDw30xobaUQQ2+aYumlAk1SHC6HBwJ4f4235Yu
         dpQ/90g9Y7hMnCnEOfviYiyZZFFlQMICVLy5mga4rHAl80htC6snRsh0WmVIHpNhanNK
         NIZq7HQtaj6W2Ffrv/UgUwK7UBXKT7M04HaFICS/veUYrfUbG5/3KaSKXD7qVyFUAPvf
         7LqyAlarN1o1gjLUyaUk6Qug1bvEg8W+WqUG128CcFjfzLaC/7w/zuw/psPj14lK1eez
         3g8Ivy6EJZBY4JrenA29ypPSISEH/V/FZP9eqzNvOpAshSKTjnjpqM2tLgMHZpAXahXv
         +kwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+0qVYGdGmkDnAqj07TMHGbTEwacGQLQsY1ouzYx3iFU=;
        b=L4uRgCet+m4/4jV5yMYY16C0YklO+b+hN0RJo0f88RQSNEOR3HnCLOe0LpyydyAo16
         SjiSZRXlZAMTuIO2mIA62O/Srtdq1xWOVzfwT0IiNkLWP4xhJjOYYNN27EXrLehifEBV
         667rvaHErcF6EoBCjETdv2qeAWHr//7fte2jsfA3pMpHFJNKUJ9mjwGys8LXNmogSWup
         joCNN/iv2xk72Hnw0v+F7FQhFCPLo2om/sO3HQbtRo4zP5A+lRju8kv/kI1jsPeC7q1k
         CulKQEv1UylETONTkxHBqvpPmPKhdNsiFlVSfBrzruCup2au43JMYIhAEbju1Sb8ReSr
         jbWQ==
X-Gm-Message-State: ACgBeo2Qc8qy2yevXrEtrFQuBjkO9Vb7WKiEBbOX+11x8GMgN0Gbyc9a
        WCb0crW+MgRYbGfSr4saj4JBTQ==
X-Google-Smtp-Source: AA6agR5DkAlJcNs4SM72SBs4RkRsSrmU0mqmkOmHi1/W/2RJyhEPCUCk6WY5HbfQttNpAT61Coms/Q==
X-Received: by 2002:aa7:d513:0:b0:43d:5c81:4f71 with SMTP id y19-20020aa7d513000000b0043d5c814f71mr13932376edq.308.1659436228236;
        Tue, 02 Aug 2022 03:30:28 -0700 (PDT)
Received: from localhost.localdomain (ptr-4xh0y3uhn87zojrdbwi.18120a2.ip6.access.telenet.be. [2a02:1810:a44c:8f00:733c:5cdf:8a1a:e482])
        by smtp.gmail.com with ESMTPSA id q21-20020a170906941500b00715a02874acsm1509750ejx.35.2022.08.02.03.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 03:30:27 -0700 (PDT)
From:   Crt Mori <cmo@melexis.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH 1/2] iio: temperature: mlx90632 Add supply regulator to sensor
Date:   Tue,  2 Aug 2022 12:30:22 +0200
Message-Id: <20220802103022.423328-1-cmo@melexis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide possibility to toggle power supply to the sensor so that user
can optimize their setup and not have the sensor constantly powered.

Signed-off-by: Crt Mori <cmo@melexis.com>
---
 drivers/iio/temperature/mlx90632.c | 52 ++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
index 7ee7ff8047a4..e6e5e649a9f9 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -18,6 +18,7 @@
 #include <linux/math64.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -128,6 +129,7 @@
  *        calculations
  * @object_ambient_temperature: Ambient temperature at object (might differ of
  *                              the ambient temperature of sensor.
+ * @regulator: Regulator of the device
  */
 struct mlx90632_data {
 	struct i2c_client *client;
@@ -136,6 +138,7 @@ struct mlx90632_data {
 	u16 emissivity;
 	u8 mtyp;
 	u32 object_ambient_temperature;
+	struct regulator *regulator;
 };
 
 static const struct regmap_range mlx90632_volatile_reg_range[] = {
@@ -841,6 +844,37 @@ static int mlx90632_wakeup(struct mlx90632_data *data)
 	return mlx90632_pwr_continuous(data->regmap);
 }
 
+static void mlx90632_disable_regulator(void *_data)
+{
+	struct mlx90632_data *data = _data;
+	int ret;
+
+	ret = regulator_disable(data->regulator);
+	if (ret < 0)
+		dev_err(regmap_get_device(data->regmap),
+			"Failed to disable power regulator: %d\n", ret);
+}
+
+static int mlx90632_enable_regulator(struct mlx90632_data *data)
+{
+	int ret;
+
+	ret = regulator_set_voltage(data->regulator, 3200000, 3600000);
+	if (ret < 0) {
+		dev_err(regmap_get_device(data->regmap), "Failed to set voltage on regulator!\n");
+		return ret;
+	}
+
+	ret = regulator_enable(data->regulator);
+	if (ret < 0) {
+		dev_err(regmap_get_device(data->regmap), "Failed to enable power regulator!\n");
+	} else {
+		/* Give the device a little bit of time to start up. */
+		msleep(MLX90632_SLEEP_DELAY_MS);
+	}
+	return ret;
+}
+
 static int mlx90632_probe(struct i2c_client *client,
 			  const struct i2c_device_id *id)
 {
@@ -876,6 +910,24 @@ static int mlx90632_probe(struct i2c_client *client,
 	indio_dev->channels = mlx90632_channels;
 	indio_dev->num_channels = ARRAY_SIZE(mlx90632_channels);
 
+	mlx90632->regulator = devm_regulator_get(&client->dev, "vdd");
+	if (!IS_ERR(mlx90632->regulator)) {
+		ret = mlx90632_enable_regulator(mlx90632);
+		if (ret < 0) {
+			dev_err(&client->dev, "Failed to enable regulator!\n");
+			return ret;
+		}
+
+		ret = devm_add_action_or_reset(&client->dev,
+					       mlx90632_disable_regulator,
+					       mlx90632);
+		if (ret < 0) {
+			dev_err(&client->dev, "Failed to setup regulator cleanup action %d\n",
+				ret);
+			return ret;
+		}
+	}
+
 	ret = mlx90632_wakeup(mlx90632);
 	if (ret < 0) {
 		dev_err(&client->dev, "Wakeup failed: %d\n", ret);
-- 
2.34.1

