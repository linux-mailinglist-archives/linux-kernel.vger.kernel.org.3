Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC3A4DE9F7
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 19:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243832AbiCSSMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 14:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243809AbiCSSL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 14:11:57 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089D590243;
        Sat, 19 Mar 2022 11:10:35 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id b8so9899185pjb.4;
        Sat, 19 Mar 2022 11:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EIsVtfI4oxwH1Tgw3dc0Q57CPWfQ9tcC+DLmFSdruZg=;
        b=RIu5Rv7Yi0vYiuQBc4LK/sidMrC7aUGzby9B53autqXQxjIPJo4seAY8ch3Vi883Gd
         9PIcWVriLE9IYLV8P10HabG73m+FEXPeoq/tHP7NMOY9LmGg5X8hv6tC2a4R/UtZbBPI
         KFtHZq2416vPdFQ9M9ma7Lw8mHy6KLfGSN0H1WWzfI6TaQee/a4nmNqcmLNTeT4KYzb9
         4tkev0FmYpxQ8rFfKVioPu36bBu1OWdJCYrJhvQm1CV/kBRlLB5XsSDQOjR5X1XkZDhV
         4o8krHqLTSLlLkfRyE9yc5aNC7fo98ToPRpG9oyPT5c76q1tqeAaBOET7AeIyvAWyiuD
         YFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EIsVtfI4oxwH1Tgw3dc0Q57CPWfQ9tcC+DLmFSdruZg=;
        b=00PntLjgK5Xiv8rjluLkyE4z3FsnJO3a9/JNOrSNlqk4K03OzBkD5hpvXvzpgHZ6uk
         3TQLK+LS8+6Ak5nhwZJgr2VPfAnjQ1/KyQDfx5hkfwTc1rQHpuuzFugzElbnPAT9mfv3
         8wnOmlEsLnIBttIxNaJAIRSBsjMWyIQVieBwBUPUIoT9rmXJujNwwyaUitbCMJ0qOcvC
         HSzqKloaq/UkWa2utkkGlAHOEyiPv/7mPUvXA/zQyE8ioMd7t9Jn54CP8IYdwB/pLFa5
         HUWdmQ82Dc+asv3+DymKXKFRbcFc5jOCgfQleRXlU6LdbRjXDp+4xm+qDcUONbyyFZhW
         eU4Q==
X-Gm-Message-State: AOAM5308Px+cgWbYsjNNTeHX6pMKsRM0X9Z9WsKhh9dTStOL1Q86TDcc
        TKck6XShJexsV489iY2shWs=
X-Google-Smtp-Source: ABdhPJyMdNT1ygXJW2dvdFmfNZagT1Hj53j1ktVnWwz83K3VzsFDeRH+SDO+r8CUEd/pQDH/FkvLsw==
X-Received: by 2002:a17:90b:1b51:b0:1c6:f880:166d with SMTP id nv17-20020a17090b1b5100b001c6f880166dmr557555pjb.185.1647713435312;
        Sat, 19 Mar 2022 11:10:35 -0700 (PDT)
Received: from localhost.localdomain ([115.99.145.231])
        by smtp.gmail.com with ESMTPSA id nu4-20020a17090b1b0400b001bf497a9324sm16413981pjb.31.2022.03.19.11.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 11:10:35 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     dan@dlrobertson.com, jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/5] iio: accel: bma400: Add triggered buffer support
Date:   Sat, 19 Mar 2022 23:40:21 +0530
Message-Id: <20220319181023.8090-4-jagathjog1996@gmail.com>
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

Added trigger buffer support to read continuous acceleration
data from device with data ready interrupt which is mapped
to INT1 pin.

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 drivers/iio/accel/Kconfig       |   2 +
 drivers/iio/accel/bma400.h      |  10 +-
 drivers/iio/accel/bma400_core.c | 161 +++++++++++++++++++++++++++++++-
 drivers/iio/accel/bma400_i2c.c  |   2 +-
 drivers/iio/accel/bma400_spi.c  |   2 +-
 5 files changed, 169 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 49587c992a6d..0eb379578e00 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -177,6 +177,8 @@ config BMA220
 config BMA400
 	tristate "Bosch BMA400 3-Axis Accelerometer Driver"
 	select REGMAP
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	select BMA400_I2C if I2C
 	select BMA400_SPI if SPI
 	help
diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
index cfc2c9bacec8..b306a5ad513a 100644
--- a/drivers/iio/accel/bma400.h
+++ b/drivers/iio/accel/bma400.h
@@ -62,6 +62,13 @@
 #define BMA400_ACC_CONFIG2_REG      0x1b
 #define BMA400_CMD_REG              0x7e
 
+/* Interrupt registers */
+#define BMA400_INT_CONFIG0_REG      0x1f
+#define BMA400_INT_CONFIG1_REG      0x20
+#define BMA400_INT1_MAP_REG         0x21
+#define BMA400_INT_IO_CTRL_REG      0x24
+#define BMA400_INT_DRDY_MSK         BIT(7)
+
 /* Chip ID of BMA 400 devices found in the chip ID register. */
 #define BMA400_ID_REG_VAL           0x90
 
@@ -92,6 +99,7 @@
 
 extern const struct regmap_config bma400_regmap_config;
 
-int bma400_probe(struct device *dev, struct regmap *regmap, const char *name);
+int bma400_probe(struct device *dev, struct regmap *regmap, int irq,
+		 const char *name);
 
 #endif
diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index dcc7549c7a0e..797403c7dd85 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -20,6 +20,12 @@
 #include <linux/mutex.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
 
 #include "bma400.h"
 
@@ -61,6 +67,13 @@ struct bma400_data {
 	struct bma400_sample_freq sample_freq;
 	int oversampling_ratio;
 	int scale;
+	struct iio_trigger *trig;
+	/* Correct time stamp alignment */
+	struct {
+		__be16 buff[3];
+		u8 temperature;
+		s64 ts __aligned(8);
+	} buffer;
 };
 
 static bool bma400_is_writable_reg(struct device *dev, unsigned int reg)
@@ -152,7 +165,7 @@ static const struct iio_chan_spec_ext_info bma400_ext_info[] = {
 	{ }
 };
 
-#define BMA400_ACC_CHANNEL(_axis) { \
+#define BMA400_ACC_CHANNEL(_index, _axis) { \
 	.type = IIO_ACCEL, \
 	.modified = 1, \
 	.channel2 = IIO_MOD_##_axis, \
@@ -164,17 +177,32 @@ static const struct iio_chan_spec_ext_info bma400_ext_info[] = {
 		BIT(IIO_CHAN_INFO_SCALE) | \
 		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
 	.ext_info = bma400_ext_info, \
+	.scan_index = _index,	\
+	.scan_type = {		\
+		.sign = 's',	\
+		.realbits = 12,		\
+		.storagebits = 16,	\
+		.endianness = IIO_LE,	\
+	},				\
 }
 
 static const struct iio_chan_spec bma400_channels[] = {
-	BMA400_ACC_CHANNEL(X),
-	BMA400_ACC_CHANNEL(Y),
-	BMA400_ACC_CHANNEL(Z),
+	BMA400_ACC_CHANNEL(0, X),
+	BMA400_ACC_CHANNEL(1, Y),
+	BMA400_ACC_CHANNEL(2, Z),
 	{
 		.type = IIO_TEMP,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.scan_index = 3,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 8,
+			.storagebits = 8,
+			.endianness = IIO_LE,
+		},
 	},
+	IIO_CHAN_SOFT_TIMESTAMP(4),
 };
 
 static int bma400_get_temp_reg(struct bma400_data *data, int *val, int *val2)
@@ -632,6 +660,11 @@ static int bma400_init(struct bma400_data *data)
 	if (ret)
 		goto err_reg_disable;
 
+	/* Configure INT-1 pin to push pull */
+	ret = regmap_write(data->regmap, BMA400_INT_IO_CTRL_REG, 0x02);
+	if (ret)
+		goto err_reg_disable;
+
 	/*
 	 * Once the interrupt engine is supported we might use the
 	 * data_src_reg, but for now ensure this is set to the
@@ -786,6 +819,33 @@ static int bma400_write_raw_get_fmt(struct iio_dev *indio_dev,
 	}
 }
 
+static int bma400_data_rdy_trigger_set_state(struct iio_trigger *trig,
+					     bool state)
+{
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
+	struct bma400_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = regmap_update_bits(data->regmap, BMA400_INT_CONFIG0_REG,
+				 BMA400_INT_DRDY_MSK,
+				 FIELD_PREP(BMA400_INT_DRDY_MSK, state));
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(data->regmap, BMA400_INT1_MAP_REG,
+				 BMA400_INT_DRDY_MSK,
+				 FIELD_PREP(BMA400_INT_DRDY_MSK, state));
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const unsigned long bma400_avail_scan_masks[] = {
+	GENMASK(3, 0),
+	0,
+};
+
 static const struct iio_info bma400_info = {
 	.read_raw          = bma400_read_raw,
 	.read_avail        = bma400_read_avail,
@@ -793,6 +853,63 @@ static const struct iio_info bma400_info = {
 	.write_raw_get_fmt = bma400_write_raw_get_fmt,
 };
 
+static const struct iio_trigger_ops bma400_trigger_ops = {
+	.set_trigger_state = &bma400_data_rdy_trigger_set_state,
+	.validate_device = &iio_trigger_validate_own_device,
+};
+
+static irqreturn_t bma400_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct bma400_data *data = iio_priv(indio_dev);
+	int ret, temp;
+
+	mutex_lock(&data->mutex);
+
+	/* bulk read six registers, with the base being the LSB register */
+	ret = regmap_bulk_read(data->regmap, BMA400_X_AXIS_LSB_REG,
+			       &data->buffer.buff, 3 * sizeof(__be16));
+	mutex_unlock(&data->mutex);
+	if (ret)
+		goto out;
+
+	ret = regmap_read(data->regmap, BMA400_TEMP_DATA_REG, &temp);
+	if (ret)
+		goto out;
+
+	data->buffer.temperature = temp;
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
+					   iio_get_time_ns(indio_dev));
+
+out:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t bma400_interrupt(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct bma400_data *data = iio_priv(indio_dev);
+	int ret;
+	__le16 status;
+
+	mutex_lock(&data->mutex);
+	ret = regmap_bulk_read(data->regmap, BMA400_INT_STAT0_REG, &status,
+			       sizeof(status));
+	mutex_unlock(&data->mutex);
+	if (ret)
+		goto out;
+
+	if (status & BMA400_INT_DRDY_MSK)
+		iio_trigger_poll_chained(data->trig);
+
+out:
+	return IRQ_HANDLED;
+}
+
 static void bma400_disable(void *data_ptr)
 {
 	struct bma400_data *data = data_ptr;
@@ -806,7 +923,8 @@ static void bma400_disable(void *data_ptr)
 	regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
 }
 
-int bma400_probe(struct device *dev, struct regmap *regmap, const char *name)
+int bma400_probe(struct device *dev, struct regmap *regmap, int irq,
+		 const char *name)
 {
 	struct iio_dev *indio_dev;
 	struct bma400_data *data;
@@ -833,12 +951,45 @@ int bma400_probe(struct device *dev, struct regmap *regmap, const char *name)
 	indio_dev->info = &bma400_info;
 	indio_dev->channels = bma400_channels;
 	indio_dev->num_channels = ARRAY_SIZE(bma400_channels);
+	indio_dev->available_scan_masks = bma400_avail_scan_masks;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = devm_add_action_or_reset(dev, bma400_disable, data);
 	if (ret)
 		return ret;
 
+	if (irq > 0) {
+		data->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
+						    indio_dev->name,
+						    iio_device_id(indio_dev));
+		if (!data->trig)
+			return -ENOMEM;
+
+		data->trig->ops = &bma400_trigger_ops;
+		iio_trigger_set_drvdata(data->trig, indio_dev);
+
+		ret = devm_iio_trigger_register(data->dev, data->trig);
+		if (ret) {
+			dev_err(dev, "iio trigger register failed\n");
+			return ret;
+		}
+		indio_dev->trig = iio_trigger_get(data->trig);
+		ret = devm_request_threaded_irq(dev, irq, NULL,
+						&bma400_interrupt,
+						IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+						indio_dev->name, indio_dev);
+		if (ret) {
+			dev_err(dev, "request irq %d failed\n", irq);
+			return ret;
+		}
+	}
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
+					      &bma400_trigger_handler, NULL);
+	if (ret) {
+		dev_err(dev, "iio triggered buffer setup failed\n");
+		return ret;
+	}
 	return devm_iio_device_register(dev, indio_dev);
 }
 EXPORT_SYMBOL(bma400_probe);
diff --git a/drivers/iio/accel/bma400_i2c.c b/drivers/iio/accel/bma400_i2c.c
index 56da06537562..49b0ae13fdc8 100644
--- a/drivers/iio/accel/bma400_i2c.c
+++ b/drivers/iio/accel/bma400_i2c.c
@@ -24,7 +24,7 @@ static int bma400_i2c_probe(struct i2c_client *client,
 		return PTR_ERR(regmap);
 	}
 
-	return bma400_probe(&client->dev, regmap, id->name);
+	return bma400_probe(&client->dev, regmap, client->irq, id->name);
 }
 
 static const struct i2c_device_id bma400_i2c_ids[] = {
diff --git a/drivers/iio/accel/bma400_spi.c b/drivers/iio/accel/bma400_spi.c
index 96dc9c215401..2957ebc51543 100644
--- a/drivers/iio/accel/bma400_spi.c
+++ b/drivers/iio/accel/bma400_spi.c
@@ -84,7 +84,7 @@ static int bma400_spi_probe(struct spi_device *spi)
 	if (ret)
 		dev_err(&spi->dev, "Failed to read chip id register\n");
 
-	return bma400_probe(&spi->dev, regmap, id->name);
+	return bma400_probe(&spi->dev, regmap, spi->irq, id->name);
 }
 
 static const struct spi_device_id bma400_spi_ids[] = {
-- 
2.17.1

