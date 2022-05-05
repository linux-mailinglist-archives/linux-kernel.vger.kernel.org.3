Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3474951C0C2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 15:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237438AbiEENe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 09:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbiEENeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 09:34:14 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707569FFD;
        Thu,  5 May 2022 06:30:33 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id n18so4403258plg.5;
        Thu, 05 May 2022 06:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OwclT365pHO8aTYKW7BCzuAnkLe27jWDU+2YGvjkHTQ=;
        b=ppBz5j6zrLByV2ZZCsuM7HriyRUzYnCB/FcrPOsGOzkr0i1dhTE6pz9ssOQNVaBOEm
         Z4rfe7SnaKGdXbXYfr9U58lo8r0gRn1vIqEbhSwduqXYi8opG/I4Xc7MPXgu6ViWtcy+
         Z9gCtKBsLkm0SCpWI3bZEe5XxyKA7BqOWcgygCB2jUzcpJLw3Cb9oKdOVoENTylQkNEb
         /VPyDGIQ2s8PZxyCNjUEC/imQR1Xmgf/HjH6CatrPmJ2EzHiJgZUroSoCrJdvQH8nmu1
         uYT7pEEeVoKggkjumeKebAVYaXx5yz0iLkg9sdFaU8mjC141Gecy3SqyS12EO6RP+swU
         OY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OwclT365pHO8aTYKW7BCzuAnkLe27jWDU+2YGvjkHTQ=;
        b=EnB4q3yGywSxc+/x4scHcBGklSSsukmtJFNZ93esxVeEgq57lAiQjLgY4dIj77EjVv
         Po41/nJTtQhFk9p599oqx32IICr7ylHjccQ7qq6tvxaD2lh0yCTv3dBYeOkJ7TE32nXw
         Rwm0SjeoKkIbz9lg/LNuYpsHXBgyGE7I7wooyZfo1jWY4AvJsD4H6HNvvE5Ei57CpqgU
         G2EZDmjQuEVRmPwYWlJFCNgO944ko6oAVrpdelAVe9gPAiDPJesbfV/2URt7c1igNKxE
         AZNKJbDds9M7QdvdUYS42tFb4dS/fRfarBUiXAVdddI0xpO+pfKQUNFZdxnyckaZQaA6
         E2LA==
X-Gm-Message-State: AOAM533SbWywdJoZxyxSDzbAmi9laUefETjtQmfZfYFkqp+L8aFCHmPu
        MSR1h0ooRS9mT3drVHNoxkM=
X-Google-Smtp-Source: ABdhPJxQk7z8j/mRrV4Xm+laHQxUZi62wMqNu+m6JiDGg67CFE5zic8hZZzRyku61A8/VDdKz3OHNQ==
X-Received: by 2002:a17:902:8696:b0:15d:946:2f98 with SMTP id g22-20020a170902869600b0015d09462f98mr27358811plo.82.1651757432839;
        Thu, 05 May 2022 06:30:32 -0700 (PDT)
Received: from localhost.localdomain ([115.99.184.228])
        by smtp.gmail.com with ESMTPSA id c64-20020a624e43000000b0050dc7628135sm1420120pfb.15.2022.05.05.06.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 06:30:32 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     dan@dlrobertson.com, jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 03/10] iio: accel: bma400: conversion to device-managed function
Date:   Thu,  5 May 2022 19:00:14 +0530
Message-Id: <20220505133021.22362-4-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220505133021.22362-1-jagathjog1996@gmail.com>
References: <20220505133021.22362-1-jagathjog1996@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a conversion to device-managed by using devm_iio_device_register()
inside probe function. Previously the bma400 was not put into power down
mode in some error paths in probe where it now is, but that should cause
no harm.

The dev_set_drvdata() call, bma400_remove() function and hooks in the I2C
and SPI driver struct is removed as devm_iio_device_register() function is
used to automatically unregister on driver detach.

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/accel/bma400.h      |  2 -
 drivers/iio/accel/bma400_core.c | 77 ++++++++++++++++-----------------
 drivers/iio/accel/bma400_i2c.c  |  8 ----
 drivers/iio/accel/bma400_spi.c  |  6 ---
 4 files changed, 38 insertions(+), 55 deletions(-)

diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
index 80330c7ce17f..1c8c47a9a317 100644
--- a/drivers/iio/accel/bma400.h
+++ b/drivers/iio/accel/bma400.h
@@ -113,6 +113,4 @@ extern const struct regmap_config bma400_regmap_config;
 
 int bma400_probe(struct device *dev, struct regmap *regmap, const char *name);
 
-void bma400_remove(struct device *dev);
-
 #endif
diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index 25ad1f7339bc..07674d89d978 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -560,6 +560,26 @@ static void bma400_init_tables(void)
 	}
 }
 
+static void bma400_regulators_disable(void *data_ptr)
+{
+	struct bma400_data *data = data_ptr;
+
+	regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
+}
+
+static void bma400_power_disable(void *data_ptr)
+{
+	struct bma400_data *data = data_ptr;
+	int ret;
+
+	mutex_lock(&data->mutex);
+	ret = bma400_set_power_mode(data, POWER_MODE_SLEEP);
+	mutex_unlock(&data->mutex);
+	if (ret)
+		dev_warn(data->dev, "Failed to put device into sleep mode (%pe)\n",
+			 ERR_PTR(ret));
+}
+
 static int bma400_init(struct bma400_data *data)
 {
 	unsigned int val;
@@ -569,13 +589,12 @@ static int bma400_init(struct bma400_data *data)
 	ret = regmap_read(data->regmap, BMA400_CHIP_ID_REG, &val);
 	if (ret) {
 		dev_err(data->dev, "Failed to read chip id register\n");
-		goto out;
+		return ret;
 	}
 
 	if (val != BMA400_ID_REG_VAL) {
 		dev_err(data->dev, "Chip ID mismatch\n");
-		ret = -ENODEV;
-		goto out;
+		return -ENODEV;
 	}
 
 	data->regulators[BMA400_VDD_REGULATOR].supply = "vdd";
@@ -589,27 +608,31 @@ static int bma400_init(struct bma400_data *data)
 				"Failed to get regulators: %d\n",
 				ret);
 
-		goto out;
+		return ret;
 	}
 	ret = regulator_bulk_enable(ARRAY_SIZE(data->regulators),
 				    data->regulators);
 	if (ret) {
 		dev_err(data->dev, "Failed to enable regulators: %d\n",
 			ret);
-		goto out;
+		return ret;
 	}
 
+	ret = devm_add_action_or_reset(data->dev, bma400_regulators_disable, data);
+	if (ret)
+		return ret;
+
 	ret = bma400_get_power_mode(data);
 	if (ret) {
 		dev_err(data->dev, "Failed to get the initial power-mode\n");
-		goto err_reg_disable;
+		return ret;
 	}
 
 	if (data->power_mode != POWER_MODE_NORMAL) {
 		ret = bma400_set_power_mode(data, POWER_MODE_NORMAL);
 		if (ret) {
 			dev_err(data->dev, "Failed to wake up the device\n");
-			goto err_reg_disable;
+			return ret;
 		}
 		/*
 		 * TODO: The datasheet waits 1500us here in the example, but
@@ -618,19 +641,23 @@ static int bma400_init(struct bma400_data *data)
 		usleep_range(1500, 2000);
 	}
 
+	ret = devm_add_action_or_reset(data->dev, bma400_power_disable, data);
+	if (ret)
+		return ret;
+
 	bma400_init_tables();
 
 	ret = bma400_get_accel_output_data_rate(data);
 	if (ret)
-		goto err_reg_disable;
+		return ret;
 
 	ret = bma400_get_accel_oversampling_ratio(data);
 	if (ret)
-		goto err_reg_disable;
+		return ret;
 
 	ret = bma400_get_accel_scale(data);
 	if (ret)
-		goto err_reg_disable;
+		return ret;
 
 	/*
 	 * Once the interrupt engine is supported we might use the
@@ -639,12 +666,6 @@ static int bma400_init(struct bma400_data *data)
 	 * channel.
 	 */
 	return regmap_write(data->regmap, BMA400_ACC_CONFIG2_REG, 0x00);
-
-err_reg_disable:
-	regulator_bulk_disable(ARRAY_SIZE(data->regulators),
-			       data->regulators);
-out:
-	return ret;
 }
 
 static int bma400_read_raw(struct iio_dev *indio_dev,
@@ -822,32 +843,10 @@ int bma400_probe(struct device *dev, struct regmap *regmap, const char *name)
 	indio_dev->num_channels = ARRAY_SIZE(bma400_channels);
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	dev_set_drvdata(dev, indio_dev);
-
-	return iio_device_register(indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 EXPORT_SYMBOL_NS(bma400_probe, IIO_BMA400);
 
-void bma400_remove(struct device *dev)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct bma400_data *data = iio_priv(indio_dev);
-	int ret;
-
-	mutex_lock(&data->mutex);
-	ret = bma400_set_power_mode(data, POWER_MODE_SLEEP);
-	mutex_unlock(&data->mutex);
-
-	if (ret)
-		dev_warn(dev, "Failed to put device into sleep mode (%pe)\n", ERR_PTR(ret));
-
-	regulator_bulk_disable(ARRAY_SIZE(data->regulators),
-			       data->regulators);
-
-	iio_device_unregister(indio_dev);
-}
-EXPORT_SYMBOL_NS(bma400_remove, IIO_BMA400);
-
 MODULE_AUTHOR("Dan Robertson <dan@dlrobertson.com>");
 MODULE_DESCRIPTION("Bosch BMA400 triaxial acceleration sensor core");
 MODULE_LICENSE("GPL");
diff --git a/drivers/iio/accel/bma400_i2c.c b/drivers/iio/accel/bma400_i2c.c
index da104ffd3fe0..4f6e01a3b3a1 100644
--- a/drivers/iio/accel/bma400_i2c.c
+++ b/drivers/iio/accel/bma400_i2c.c
@@ -27,13 +27,6 @@ static int bma400_i2c_probe(struct i2c_client *client,
 	return bma400_probe(&client->dev, regmap, id->name);
 }
 
-static int bma400_i2c_remove(struct i2c_client *client)
-{
-	bma400_remove(&client->dev);
-
-	return 0;
-}
-
 static const struct i2c_device_id bma400_i2c_ids[] = {
 	{ "bma400", 0 },
 	{ }
@@ -52,7 +45,6 @@ static struct i2c_driver bma400_i2c_driver = {
 		.of_match_table = bma400_of_i2c_match,
 	},
 	.probe    = bma400_i2c_probe,
-	.remove   = bma400_i2c_remove,
 	.id_table = bma400_i2c_ids,
 };
 
diff --git a/drivers/iio/accel/bma400_spi.c b/drivers/iio/accel/bma400_spi.c
index 51f23bdc0ea5..28e240400a3f 100644
--- a/drivers/iio/accel/bma400_spi.c
+++ b/drivers/iio/accel/bma400_spi.c
@@ -87,11 +87,6 @@ static int bma400_spi_probe(struct spi_device *spi)
 	return bma400_probe(&spi->dev, regmap, id->name);
 }
 
-static void bma400_spi_remove(struct spi_device *spi)
-{
-	bma400_remove(&spi->dev);
-}
-
 static const struct spi_device_id bma400_spi_ids[] = {
 	{ "bma400", 0 },
 	{ }
@@ -110,7 +105,6 @@ static struct spi_driver bma400_spi_driver = {
 		.of_match_table = bma400_of_spi_match,
 	},
 	.probe    = bma400_spi_probe,
-	.remove   = bma400_spi_remove,
 	.id_table = bma400_spi_ids,
 };
 
-- 
2.17.1

