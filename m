Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211BF4E83D6
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 20:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbiCZTnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 15:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbiCZTnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 15:43:32 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16C917336E;
        Sat, 26 Mar 2022 12:41:55 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id p8so9223955pfh.8;
        Sat, 26 Mar 2022 12:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lOz/k81bGL8Tczu8yB5iox7Yf6MP1h89omrWGCtVvX8=;
        b=Oi63NIjN2kqyrrzFBZgWhZ+B2GhbEDum0QFZSBxysfKII2ofJpUxSgTf7WWgHKbQOC
         uXu3dAf6jXu6dhptb+2st2eCqGnvEzCcm2zEuP94tTCzVJKdtM/aa7eCfLx8oCqVeGQX
         5QiAgnO/c3aXyG1boHCszhY9Va9zpIBxPjKLdT0ecj6AGYywRe9zulIjBUzjNDqEtcvK
         z5bz595mtkUCh2c4Z+pSdG/kgP93lO1CYC+gb1TMmuPFXTNZJCb1beuytCTqN0DB4k0D
         GTs2UVfULvWhvFrjV8MjsFX5YMMQEoPoRn4B4C8DOLakrwBfuPcigllOuo5fIqaDKj16
         5vgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lOz/k81bGL8Tczu8yB5iox7Yf6MP1h89omrWGCtVvX8=;
        b=EC2N6RATKnSRTLLIVBfb5X2bTPDgzvNqJoe5jPxJotozY4KTuHIwxLz6g5JxiF/ZlK
         bvNfZR46w3XOnAk1JTrthVMBYBXbxxmZ+JDxnbYm3ugLRAxDxzirqcqP0sT2R27muOpS
         5Q19VTTPLuOAk66QC7EbYhPqtyV67SCOCEspjbSBQmMwCai4I/7Ykt4eCEzy6mGmpS1/
         IzwqVVBRLL9Cj2+Bc70tg9iMNDnJ7FpCVHhXMXGRhbbm8lCZZ1zsJOmYtKvzcuIAEt5p
         B3hNUFy0xfn58A9Tuegula9vyORPLPlxOE5MkSAaLgK3+69dR1mGLOarSS79CfoBOwNS
         GkdA==
X-Gm-Message-State: AOAM531gvcg2/FLsrofFFu0k6IPPZmL5cNKigsDlSS/PCGjl3gCWcoEf
        YxB6z+DF1djSh0JhZpQ6/S8=
X-Google-Smtp-Source: ABdhPJwOeshXqQ7cuoSzObMGcI8OCgz/z4eqOo9kYNCsv+95c4aVb2ignwez+i2TXzgUkXAD4NoOsA==
X-Received: by 2002:a63:924e:0:b0:382:4fa8:e36d with SMTP id s14-20020a63924e000000b003824fa8e36dmr4416052pgn.426.1648323715040;
        Sat, 26 Mar 2022 12:41:55 -0700 (PDT)
Received: from localhost.localdomain ([116.75.119.161])
        by smtp.gmail.com with ESMTPSA id k185-20020a6384c2000000b003821dcd9020sm8778784pgd.27.2022.03.26.12.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 12:41:54 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     dan@dlrobertson.com, jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] iio: accel: bma400: conversion to device-managed function
Date:   Sun, 27 Mar 2022 01:11:43 +0530
Message-Id: <20220326194146.15549-3-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220326194146.15549-1-jagathjog1996@gmail.com>
References: <20220326194146.15549-1-jagathjog1996@gmail.com>
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
inside probe function, now disabling the regulator and putting bma400 to
power down via a devm_add_action_or_reset() hook.

The dev_set_drvdata() call, bma400_remove() function and hooks in the I2C
and SPI driver struct is removed as devm_iio_device_register function is
used to automatically unregister on driver detach.

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 drivers/iio/accel/bma400.h      |  2 -
 drivers/iio/accel/bma400_core.c | 77 ++++++++++++++++-----------------
 drivers/iio/accel/bma400_i2c.c  |  8 ----
 drivers/iio/accel/bma400_spi.c  |  8 ----
 4 files changed, 38 insertions(+), 57 deletions(-)

diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
index 190366debdb3..c1b3dbfbd98f 100644
--- a/drivers/iio/accel/bma400.h
+++ b/drivers/iio/accel/bma400.h
@@ -112,6 +112,4 @@ extern const struct regmap_config bma400_regmap_config;
 
 int bma400_probe(struct device *dev, struct regmap *regmap, const char *name);
 
-void bma400_remove(struct device *dev);
-
 #endif
diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index fd2647b728d3..dc273381a0a2 100644
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
+	if (ret)
+		dev_warn(data->dev, "Failed to put device into sleep mode (%pe)\n",
+			 ERR_PTR(ret));
+	mutex_unlock(&data->mutex);
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
 EXPORT_SYMBOL(bma400_probe);
 
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
-EXPORT_SYMBOL(bma400_remove);
-
 MODULE_AUTHOR("Dan Robertson <dan@dlrobertson.com>");
 MODULE_DESCRIPTION("Bosch BMA400 triaxial acceleration sensor core");
 MODULE_LICENSE("GPL");
diff --git a/drivers/iio/accel/bma400_i2c.c b/drivers/iio/accel/bma400_i2c.c
index f50df5310beb..56da06537562 100644
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
index 9f622e37477b..96dc9c215401 100644
--- a/drivers/iio/accel/bma400_spi.c
+++ b/drivers/iio/accel/bma400_spi.c
@@ -87,13 +87,6 @@ static int bma400_spi_probe(struct spi_device *spi)
 	return bma400_probe(&spi->dev, regmap, id->name);
 }
 
-static int bma400_spi_remove(struct spi_device *spi)
-{
-	bma400_remove(&spi->dev);
-
-	return 0;
-}
-
 static const struct spi_device_id bma400_spi_ids[] = {
 	{ "bma400", 0 },
 	{ }
@@ -112,7 +105,6 @@ static struct spi_driver bma400_spi_driver = {
 		.of_match_table = bma400_of_spi_match,
 	},
 	.probe    = bma400_spi_probe,
-	.remove   = bma400_spi_remove,
 	.id_table = bma400_spi_ids,
 };
 
-- 
2.17.1

