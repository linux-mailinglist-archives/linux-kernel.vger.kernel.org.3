Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233E158CABC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 16:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243514AbiHHOtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 10:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242800AbiHHOtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 10:49:17 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DD312610
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 07:49:15 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id m4so17061779ejr.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 07:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qoTGqM7Fzap1A/3mR7Zh11Jo7hDAayrC6RTU0ql5RN4=;
        b=DHMZabs8QgxBl0q+9zRPaWwjdlgFXmleWRrBj22XEMTYhgBQt8t5TkHiFR9KQTmoQc
         TJoRVKxbyaV9Ysiztpis7uaWPkA5EhT6aKpiRL7Td8a0n1H5zBBOni9XE7hpRXOOGSbP
         m6geRtIxszqDJ3T4A5rKW7jWTaX1g4J0QfUBXoj8JbYgUwloWlE809FrMRbvxIPof9DG
         V4XYH8IKeWYeLNWv3RdYC8jhLWtXGnaXoX5ffe9bpnwMN3+jpkrBJMIfUMhjQK7Ad+Sr
         Td64LNcojF95pT5LHk96eBdu4PKh5DIGLkySmlMBv7jLGapxZd09fSE/IMqtTtqLOJ1X
         k/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qoTGqM7Fzap1A/3mR7Zh11Jo7hDAayrC6RTU0ql5RN4=;
        b=47pZg9QNduk9G+t3U9+wnwzrMu05Uzxx5FjD/PoXHPoGGPkJjOmHtpKwDj8e1WWLze
         PHtqhGCjEPQGMvhhjzuz3c7tuI5NV7vBmd3pg05MrK55/j8DFkA+SOnaQf5msnx+w/88
         BgHdRyi+8I9jAGYDkn5gb8Gljf8bZ0GfChCItvJOfNR9gugJFRk9xEQnkbhVjMf2nHfJ
         2j8jPi3rEMRv+vOQOJ/oLfIcs2hx4/qKw2rMs8YvnU/iqMItIe6Kptsuy55kSCHChSMG
         CLhQFYgO9PBjFpWQcX4evnmSdEgyo+uWpf6BtViF+Jsav4a42GIEjPEwBj+1WKbpPYGO
         HgCA==
X-Gm-Message-State: ACgBeo1tlJL0O9co9716dO12Zw9l6An5aHwL4RFpdIC9vloHpOpLJT5a
        xvZVg7cZYbDF69OqfjCG+AxOpA==
X-Google-Smtp-Source: AA6agR5JOUkVEaichO/xCqDpFq7SeuFckBUQQDRZcnn19jUDoNREZHvW6UBv9udRYwrEoX9pYxAzaQ==
X-Received: by 2002:a17:907:3e91:b0:730:ba28:28d2 with SMTP id hs17-20020a1709073e9100b00730ba2828d2mr14514177ejc.10.1659970153573;
        Mon, 08 Aug 2022 07:49:13 -0700 (PDT)
Received: from localhost.localdomain (ptr-4xh0y3vuv1059rd6h4r.18120a2.ip6.access.telenet.be. [2a02:1810:a44c:8f00:cd22:c517:e143:e53b])
        by smtp.gmail.com with ESMTPSA id dm13-20020a05640222cd00b0043cb1a83c9fsm4731350edb.71.2022.08.08.07.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 07:49:13 -0700 (PDT)
From:   Crt Mori <cmo@melexis.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH v3 1/2] iio: temperature: mlx90632 Add supply regulator to sensor
Date:   Mon,  8 Aug 2022 16:49:08 +0200
Message-Id: <20220808144908.1559069-1-cmo@melexis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
 drivers/iio/temperature/mlx90632.c | 61 +++++++++++++++++++++++++++---
 1 file changed, 56 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
index 7ee7ff8047a4..549c0ab5c2be 100644
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
@@ -876,6 +910,23 @@ static int mlx90632_probe(struct i2c_client *client,
 	indio_dev->channels = mlx90632_channels;
 	indio_dev->num_channels = ARRAY_SIZE(mlx90632_channels);
 
+	mlx90632->regulator = devm_regulator_get(&client->dev, "vdd");
+	if (IS_ERR(mlx90632->regulator))
+		return dev_err_probe(&client->dev, PTR_ERR(mlx90632->regulator),
+				     "failed to get vdd regulator");
+
+	ret = mlx90632_enable_regulator(mlx90632);
+	if (ret < 0)
+		return ret;
+
+	ret = devm_add_action_or_reset(&client->dev, mlx90632_disable_regulator,
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

