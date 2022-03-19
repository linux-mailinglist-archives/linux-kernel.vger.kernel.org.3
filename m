Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F2A4DE9F3
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 19:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243762AbiCSSLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 14:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbiCSSLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 14:11:52 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609DE8FE5F;
        Sat, 19 Mar 2022 11:10:31 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d18so9508436plr.6;
        Sat, 19 Mar 2022 11:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tuna39nHlj/vJbNH47sbVQP5PReNvCKKw5S8gfoddFQ=;
        b=CXBwCDALT/4bOPF2ycOxpMaoA+ppe7kuzXRrYGD9Cg+/F8Vl/Z7aKCFxg97202Igxs
         guDoBAVL7qA8hT2ExSsWHtbgfxUHF6SJpseXy//XBV3/FLLV3N9tZwhBMHu81y4SOqRi
         z1LsOz1cX+iyuAWEAq4v8PDgPxFxpk70hsYNkO95V0FmzeXhy/wJ693Id5pURjkLtfcU
         KukLZrXthvRcRqgBxrCtoG19foXxSgPZPCDJu4b+OL8AKPVNO/zMhfqIB53lf1dxHWf/
         AKRekOzRDudw6650Ytx6LHuKFHUqvcRT2mxeNASonzQ/ft3bnfc3jJqHrLkcka6nqO3F
         5O/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tuna39nHlj/vJbNH47sbVQP5PReNvCKKw5S8gfoddFQ=;
        b=I/3iO/9sehzojuNDH39daOph2oF7z5QJPWD1KzzpyAeTPKUlNhdXoBIZEatImVOBcK
         X5rgl3ZVTmEbdMYD7DPmTOrCCv3k1Zrpj6/7pP2KpVjxQ5HDkJoBDQUpSJ+fkF+SvD1P
         qHE+/pDieDc4jcU0383VBIhAOYvnsb8nN4vqjzLgzl1BIKz0w/6BKbLjSeq/GKJtfZ2r
         uUV1LpF+qH8gouBWyoM6KAQNbjFvOaqaw8dvei/1FkW4BajIawKBbZZz3gvSd+3xlimn
         h50pJRQ86Oqed+qBp5I72Ciexi45H2ZHxfvGDoWlKF5QV7ku3muLlzFV4ZzZ90116oG4
         ie+g==
X-Gm-Message-State: AOAM5300KzLnc/3T05BqVOHlw/3JvFYh64xJ1KPScJUrV2AyVSMqIWGX
        vykWQbGFaQciX+kQij18uFeyra/O+tlcmg==
X-Google-Smtp-Source: ABdhPJxjpOMPrMpN5FtjjYqgRINehth2c6JNWOGrZb2VQgv4To35+dtG4NT0yjvwWjTB9nTkWTJudw==
X-Received: by 2002:a17:90a:4604:b0:1bc:8bdd:4a63 with SMTP id w4-20020a17090a460400b001bc8bdd4a63mr28315285pjg.147.1647713430840;
        Sat, 19 Mar 2022 11:10:30 -0700 (PDT)
Received: from localhost.localdomain ([115.99.145.231])
        by smtp.gmail.com with ESMTPSA id nu4-20020a17090b1b0400b001bf497a9324sm16413981pjb.31.2022.03.19.11.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 11:10:30 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     dan@dlrobertson.com, jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/5] iio: accel: bma400: conversion to device-managed function
Date:   Sat, 19 Mar 2022 23:40:19 +0530
Message-Id: <20220319181023.8090-2-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220319181023.8090-1-jagathjog1996@gmail.com>
References: <20220319181023.8090-1-jagathjog1996@gmail.com>
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
 drivers/iio/accel/bma400.h      |  2 --
 drivers/iio/accel/bma400_core.c | 39 ++++++++++++++-------------------
 drivers/iio/accel/bma400_i2c.c  |  8 -------
 drivers/iio/accel/bma400_spi.c  |  8 -------
 4 files changed, 17 insertions(+), 40 deletions(-)

diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
index c4c8d74155c2..e938da5a57b4 100644
--- a/drivers/iio/accel/bma400.h
+++ b/drivers/iio/accel/bma400.h
@@ -94,6 +94,4 @@ extern const struct regmap_config bma400_regmap_config;
 
 int bma400_probe(struct device *dev, struct regmap *regmap, const char *name);
 
-void bma400_remove(struct device *dev);
-
 #endif
diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index fd2647b728d3..dcc7549c7a0e 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -793,6 +793,19 @@ static const struct iio_info bma400_info = {
 	.write_raw_get_fmt = bma400_write_raw_get_fmt,
 };
 
+static void bma400_disable(void *data_ptr)
+{
+	struct bma400_data *data = data_ptr;
+	int ret;
+
+	ret = bma400_set_power_mode(data, POWER_MODE_SLEEP);
+	if (ret)
+		dev_warn(data->dev, "Failed to put device into sleep mode (%pe)\n",
+			 ERR_PTR(ret));
+
+	regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
+}
+
 int bma400_probe(struct device *dev, struct regmap *regmap, const char *name)
 {
 	struct iio_dev *indio_dev;
@@ -822,31 +835,13 @@ int bma400_probe(struct device *dev, struct regmap *regmap, const char *name)
 	indio_dev->num_channels = ARRAY_SIZE(bma400_channels);
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	dev_set_drvdata(dev, indio_dev);
-
-	return iio_device_register(indio_dev);
-}
-EXPORT_SYMBOL(bma400_probe);
-
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
+	ret = devm_add_action_or_reset(dev, bma400_disable, data);
 	if (ret)
-		dev_warn(dev, "Failed to put device into sleep mode (%pe)\n", ERR_PTR(ret));
-
-	regulator_bulk_disable(ARRAY_SIZE(data->regulators),
-			       data->regulators);
+		return ret;
 
-	iio_device_unregister(indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
-EXPORT_SYMBOL(bma400_remove);
+EXPORT_SYMBOL(bma400_probe);
 
 MODULE_AUTHOR("Dan Robertson <dan@dlrobertson.com>");
 MODULE_DESCRIPTION("Bosch BMA400 triaxial acceleration sensor core");
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

