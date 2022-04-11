Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0795A4FC5D2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 22:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349867AbiDKUeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 16:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349855AbiDKUeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 16:34:01 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACD135DDA;
        Mon, 11 Apr 2022 13:31:46 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id s21so10655508pgv.13;
        Mon, 11 Apr 2022 13:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l2e3KyH1RI1JashrHIJXtQZiQkoaBw0PIRPaIBjs/qY=;
        b=Zbez/N35Q2sICIdY3of136PhAlOD3Hn4P7SUXhPTxE+Fu1XJ/Mf4DGF3KiXDZ1Q0et
         i9NYfEJ4MZvZIN8aB2SeNk5FjN+nRdDuuPY20Cvc4pF5S5YX4o9AU5xBg59YxtucNDNi
         IsdYhSt1Y0heag4Jvylym57AL9aQ9mXkJBWrWyuwQ2ViW/LqcV53ZJxSjjYvVKm8xLTW
         0QB7bg1YQMlYC9mk9CTZtbfiLZcSRJV4qKQqo594s/dshqvHfru88GLpeXsWDybJKeOQ
         S+VbQ4veqikCIE5hFwk/yvjrd9Lic+ATC4wjsMJllLNocdqDjiM16mHB+9SZkqScJwhX
         tCLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l2e3KyH1RI1JashrHIJXtQZiQkoaBw0PIRPaIBjs/qY=;
        b=2Dnq+4ZC97dfD4EkBT2J4FCplkGRgT5TO+9UmnkbfTYgzFpzX2lKUgaLIgaLD92AaQ
         h2VbUTTr2pADnXHzV11tzKgAIcZr44Nq2pLQGt0o7R+v7/0OwpCRsRQLyuRxzB+9t4Uq
         uvteAwKSB61JPtnrU0+V+ExyTX7fq6zIDpYS9CNCClD1H+GzIORfuvl3N/okwy1x0Vkc
         7rOsqUKt3GRlMlJwg4ppxouQrCUffkmEJGK9dj6mMq/4LCjAhPahSC4qm9aTtlTmjzQh
         EnEqZC8Q/OZtzAo863stm9ECFtXxqoa/+nJrnjYW1ACUmgca1/LUcjsDmUOSKuGVFty7
         qeqg==
X-Gm-Message-State: AOAM532kMiAurAb4CK/j+/uS87MDxXWpq5oE826lXM3pbBxYcLNaUYDP
        o5K9L2XzzN46olOIkKILHXo=
X-Google-Smtp-Source: ABdhPJy4h2t7QgYPiP2bVWney/8dOjGWtxM9WwFF8CFNji7r7Mvo66/Okl6q+Ocsyu9+HnUUWN/jFQ==
X-Received: by 2002:a05:6a00:140f:b0:4e0:6995:9c48 with SMTP id l15-20020a056a00140f00b004e069959c48mr34432810pfu.59.1649709105745;
        Mon, 11 Apr 2022 13:31:45 -0700 (PDT)
Received: from localhost.localdomain ([27.7.99.112])
        by smtp.gmail.com with ESMTPSA id z15-20020a056a001d8f00b004fda37855ddsm34069828pfw.168.2022.04.11.13.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 13:31:45 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     dan@dlrobertson.com, jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/9] iio: accel: bma400: conversion to device-managed function
Date:   Tue, 12 Apr 2022 02:01:27 +0530
Message-Id: <20220411203133.19929-4-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220411203133.19929-1-jagathjog1996@gmail.com>
References: <20220411203133.19929-1-jagathjog1996@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a conversion to device-managed by using devm_iio_device_register
inside probe function. Previously the bma400 was not put into power down
mode in some error paths in probe where it now is, but that should cause
no harm.

The dev_set_drvdata() call, bma400_remove() function and hooks in the I2C
and SPI driver struct is removed as devm_iio_device_register function is
used to automatically unregister on driver detach.

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 drivers/iio/accel/bma400.h      |  2 -
 drivers/iio/accel/bma400_core.c | 77 ++++++++++++++++-----------------
 drivers/iio/accel/bma400_i2c.c  |  8 ----
 drivers/iio/accel/bma400_spi.c  |  6 ---
 4 files changed, 38 insertions(+), 55 deletions(-)

diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
index 5d6a1976503f..8dbf85eeb005 100644
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

