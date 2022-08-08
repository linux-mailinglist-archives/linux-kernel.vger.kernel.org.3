Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2D258C818
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 14:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242340AbiHHMFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 08:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237650AbiHHMF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 08:05:28 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E3A1176
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 05:05:26 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n185so4678299wmn.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 05:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4za0UHhtOzS/+cksvATUbwHsHuuZed1iD70qbguxMDM=;
        b=PneoR3vZf4ScDSFvZfyJdeVBNlyzN26XM/BWbF45+Dt4vng2UlSUEy4+eQ6dfnfKV6
         NvSRf9qrd54r1jIWyCaXKiVI0Wo6rKEKICRvmi6x2aZUwrzrSnmB9yg8hp9FU7BtsK7F
         jhGy373jJqTg7hMxwEo0OswEzZ51eGqGAevPd7KyEpCHexrwah7BRWBXc33wsNkldZyp
         aPAqBlwC4MUoZha/MzfQ0e2nO7WLKUpoKzQ+3+1fIFTbHeFPQ8OOaQXDzqd3SqrSxsJ9
         7URY0jLN6qoYXhBpXrs/DSzbAzDp/CAoAlYro74/CTWcNgQQLlLen1/hNRTYA5oLZp7+
         oT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4za0UHhtOzS/+cksvATUbwHsHuuZed1iD70qbguxMDM=;
        b=P5UvRLbv9Z+LMHdd+BgJlIdg0E15LASEPGQEOYdxK75vmUNVbbMuwE5yOb6FukGlNd
         h9tUJ0QzJCVaayY6l2tiF5QgH7iokZuiMnKxgtxj9K+gyaaQpLjBhnHPmnUGlBozXswy
         l5ehNmy0F4T0Lsgk9KA+7R4t1s6+bUOKN1rIZtxdLeHdM+4eG6emTKpQR48FLcOavxO1
         /62p9ZP5vKGJLDXsQXLb6+/CQC3qLBwb1Yx/9/oqkf3iITrNIf+dIZNT85I6fbcMyilU
         O2NrMZJyw+yRIGfE7EOt2vIJ1L3ul3jr6ylk6IRdQFOH8m6Aho0w791uLzCMDsyC4N6z
         4HCQ==
X-Gm-Message-State: ACgBeo30+webkpADopRXOBDj9e7K49dkBqLN/kCK0XeVCVdh5qOx+MNS
        t6bzBJViGMrRPpRJNZ1kdkXYb7EMP7iKew==
X-Google-Smtp-Source: AA6agR5BLOyhCxqNHO8QEcjCixT3fG1P9ls+0kC02DYZHRzSOE9hOQbr6tEKLPufPeGYNsI47YRRjg==
X-Received: by 2002:a05:600c:5118:b0:3a5:37bf:6c21 with SMTP id o24-20020a05600c511800b003a537bf6c21mr4701418wms.135.1659960324712;
        Mon, 08 Aug 2022 05:05:24 -0700 (PDT)
Received: from localhost.localdomain (ptr-4xh0y3vuv1059rd6h4r.18120a2.ip6.access.telenet.be. [2a02:1810:a44c:8f00:cd22:c517:e143:e53b])
        by smtp.gmail.com with ESMTPSA id d1-20020a5d6441000000b0021eb309c97dsm11087303wrw.25.2022.08.08.05.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 05:05:24 -0700 (PDT)
From:   Crt Mori <cmo@melexis.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH v2 1/2] iio: temperature: mlx90632 Add supply regulator to sensor
Date:   Mon,  8 Aug 2022 14:05:18 +0200
Message-Id: <20220808120518.1543260-1-cmo@melexis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide possibility to toggle power supply to the sensor so that user
can optimize their setup and not have the sensor constantly powered.

Signed-off-by: Crt Mori <cmo@melexis.com>
---
 drivers/iio/temperature/mlx90632.c | 63 +++++++++++++++++++++++++++---
 1 file changed, 58 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
index 7ee7ff8047a4..238d639df385 100644
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
@@ -207,6 +210,15 @@ static s32 mlx90632_pwr_continuous(struct regmap *regmap)
 				  MLX90632_PWR_STATUS_CONTINUOUS);
 }
 
+/**
+ * mlx90632_reset_delay() - Give the mlx90632 some time to reset properly
+ * If this is not done, the following I2C command(s) will not be accepted.
+ */
+static void mlx90632_reset_delay(void)
+{
+	usleep_range(150, 200);
+}
+
 /**
  * mlx90632_perform_measurement() - Trigger and retrieve current measurement cycle
  * @data: pointer to mlx90632_data object containing regmap information
@@ -248,11 +260,7 @@ static int mlx90632_set_meas_type(struct regmap *regmap, u8 type)
 	if (ret < 0)
 		return ret;
 
-	/*
-	 * Give the mlx90632 some time to reset properly before sending a new I2C command
-	 * if this is not done, the following I2C command(s) will not be accepted.
-	 */
-	usleep_range(150, 200);
+	mlx90632_reset_delay();
 
 	ret = regmap_write_bits(regmap, MLX90632_REG_CONTROL,
 				 (MLX90632_CFG_MTYP_MASK | MLX90632_CFG_PWR_MASK),
@@ -841,6 +849,32 @@ static int mlx90632_wakeup(struct mlx90632_data *data)
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
+	ret = regulator_enable(data->regulator);
+	if (ret < 0) {
+		dev_err(regmap_get_device(data->regmap), "Failed to enable power regulator!\n");
+		return ret;
+	}
+
+	mlx90632_reset_delay();
+
+	return ret;
+}
+
 static int mlx90632_probe(struct i2c_client *client,
 			  const struct i2c_device_id *id)
 {
@@ -876,6 +910,25 @@ static int mlx90632_probe(struct i2c_client *client,
 	indio_dev->channels = mlx90632_channels;
 	indio_dev->num_channels = ARRAY_SIZE(mlx90632_channels);
 
+	mlx90632->regulator = devm_regulator_get(&client->dev, "vdd");
+	if (IS_ERR(mlx90632->regulator))
+		return dev_err_probe(&client->dev,
+				     PTR_ERR(mlx90632->regulator),
+				     "failed to get vdd regulator");
+
+	ret = mlx90632_enable_regulator(mlx90632);
+	if (ret < 0)
+		return ret;
+
+	ret = devm_add_action_or_reset(&client->dev,
+				       mlx90632_disable_regulator,
+				       mlx90632);
+	if (ret < 0) {
+		dev_err(&client->dev, "Failed to setup regulator cleanup action %d\n",
+			ret);
+		return ret;
+	}
+
 	ret = mlx90632_wakeup(mlx90632);
 	if (ret < 0) {
 		dev_err(&client->dev, "Wakeup failed: %d\n", ret);
-- 
2.34.1

