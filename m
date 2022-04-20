Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B065091D1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 23:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382398AbiDTVOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 17:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382368AbiDTVOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 17:14:06 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB7847AFB;
        Wed, 20 Apr 2022 14:11:18 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id t4so2839589pgc.1;
        Wed, 20 Apr 2022 14:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=358PWS7msgQ1RPNVWPekZXGpRach+SDsp5gVHY2rRwI=;
        b=ceE+lgRtVyLiaQ9adyQOj6k+kHENGxqYJC05I7mCeSsw2+KA8HDbKa5HJNng8QT5vP
         Fd2fI69jqq0fcjVCacdkMZzGGqFz2bEErjhMABgM71SBRp0/G7ylsJMrRYxUC8EFY6nt
         B+ZZDMXJnCj/NW5fnShcvpVNVbZ654ORdE2TAwjbs4xtqWz0k072hLd9yZx8W3kdfbmY
         HIwrtsRf9PLWlpo5Syd2MNCgkHAacqALwBAGgW9WHwnYCEqj2te4NAEazDcoVwzAGQeV
         tohkyuImYmxf8rlWF8tropyxcrnCr0T/lRHOEpQQR4WzwJG7pbBUlimkGQ3P6Lgl8EjF
         SNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=358PWS7msgQ1RPNVWPekZXGpRach+SDsp5gVHY2rRwI=;
        b=W1blF6EMPPH5j3wCqe7J/AvjFQ87pZ5a7VftWf+DqprLRSo5dwVT6iTGnOIhO6moJb
         ZITKJbwjvEUD3Ocd+GLIP8InNCToD/Tqwz85lxaa6tDMnYGKlPtnFtb8nuO5+xq3Osj+
         SXpDrVhbsvv4lTxB1mWRV6njk7fO2XVWND+eOtfNrAK1exlX9naKWNQGHjDZD3XWrMpt
         L+/LezXCurs/e3Qn/XC+dB465Kw9pBVaERS7YtgCSKnItwC8TwSMqthDaBP4FO71Jxzx
         wSp91oGsKK0T6l85zXCLVkvV86fthKS3txEZ9KnTiZwlRV+90ec/zAo/11pmrxPISCap
         zNmA==
X-Gm-Message-State: AOAM532lXz62g09r/KiHtAgxRSrmxTbT698Bo3WZ5e26YDbRAruQHuoH
        IsU9ourPrn9HOp58uZie+vY=
X-Google-Smtp-Source: ABdhPJzX80F6GavIO1BJR+E+bxV0QnIM+c7eWHEVB/dm4LaZKc20TwgaEAvg8GM+9BERl3ZXQw8zzg==
X-Received: by 2002:a05:6a00:170d:b0:50a:858e:2b6e with SMTP id h13-20020a056a00170d00b0050a858e2b6emr14770393pfc.48.1650489078190;
        Wed, 20 Apr 2022 14:11:18 -0700 (PDT)
Received: from localhost.localdomain ([27.7.104.83])
        by smtp.gmail.com with ESMTPSA id v13-20020a17090a00cd00b001cd4989fee4sm106652pjd.48.2022.04.20.14.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 14:11:17 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     dan@dlrobertson.com, jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/9] iio: accel: bma400: Add triggered buffer support
Date:   Thu, 21 Apr 2022 02:41:00 +0530
Message-Id: <20220420211105.14654-5-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220420211105.14654-1-jagathjog1996@gmail.com>
References: <20220420211105.14654-1-jagathjog1996@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/iio/accel/bma400_core.c | 162 +++++++++++++++++++++++++++++++-
 drivers/iio/accel/bma400_i2c.c  |   2 +-
 drivers/iio/accel/bma400_spi.c  |   2 +-
 5 files changed, 170 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index eac3f02662ae..958097814232 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -204,6 +204,8 @@ config BMA220
 config BMA400
 	tristate "Bosch BMA400 3-Axis Accelerometer Driver"
 	select REGMAP
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	select BMA400_I2C if I2C
 	select BMA400_SPI if SPI
 	help
diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
index 1c8c47a9a317..907e1a6c0a38 100644
--- a/drivers/iio/accel/bma400.h
+++ b/drivers/iio/accel/bma400.h
@@ -62,6 +62,13 @@
 #define BMA400_ACC_CONFIG2_REG      0x1b
 #define BMA400_CMD_REG              0x7e
 
+/* Interrupt registers */
+#define BMA400_INT_CONFIG0_REG	    0x1f
+#define BMA400_INT_CONFIG1_REG	    0x20
+#define BMA400_INT1_MAP_REG	    0x21
+#define BMA400_INT_IO_CTRL_REG	    0x24
+#define BMA400_INT_DRDY_MSK	    BIT(7)
+
 /* Chip ID of BMA 400 devices found in the chip ID register. */
 #define BMA400_ID_REG_VAL           0x90
 
@@ -111,6 +118,7 @@
 
 extern const struct regmap_config bma400_regmap_config;
 
-int bma400_probe(struct device *dev, struct regmap *regmap, const char *name);
+int bma400_probe(struct device *dev, struct regmap *regmap, int irq,
+		 const char *name);
 
 #endif
diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index 07674d89d978..57910ccf9180 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -11,6 +11,7 @@
  *  - Create channel for sensor time
  */
 
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
@@ -20,6 +21,10 @@
 #include <linux/regulator/consumer.h>
 
 #include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 
 #include "bma400.h"
 
@@ -61,6 +66,14 @@ struct bma400_data {
 	struct bma400_sample_freq sample_freq;
 	int oversampling_ratio;
 	int scale;
+	struct iio_trigger *trig;
+	/* Correct time stamp alignment */
+	struct {
+		__le16 buff[3];
+		u8 temperature;
+		s64 ts __aligned(8);
+	} buffer ____cacheline_aligned;
+	__le16 status;
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
@@ -659,6 +687,10 @@ static int bma400_init(struct bma400_data *data)
 	if (ret)
 		return ret;
 
+	/* Configure INT1 pin to open drain */
+	ret = regmap_write(data->regmap, BMA400_INT_IO_CTRL_REG, 0x06);
+	if (ret)
+		return ret;
 	/*
 	 * Once the interrupt engine is supported we might use the
 	 * data_src_reg, but for now ensure this is set to the
@@ -807,6 +839,29 @@ static int bma400_write_raw_get_fmt(struct iio_dev *indio_dev,
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
+	return regmap_update_bits(data->regmap, BMA400_INT1_MAP_REG,
+				  BMA400_INT_DRDY_MSK,
+				  FIELD_PREP(BMA400_INT_DRDY_MSK, state));
+}
+
+static const unsigned long bma400_avail_scan_masks[] = {
+	GENMASK(3, 0),
+	0
+};
+
 static const struct iio_info bma400_info = {
 	.read_raw          = bma400_read_raw,
 	.read_avail        = bma400_read_avail,
@@ -814,7 +869,72 @@ static const struct iio_info bma400_info = {
 	.write_raw_get_fmt = bma400_write_raw_get_fmt,
 };
 
-int bma400_probe(struct device *dev, struct regmap *regmap, const char *name)
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
+	/* Lock to protect the data->buffer */
+	mutex_lock(&data->mutex);
+
+	/* bulk read six registers, with the base being the LSB register */
+	ret = regmap_bulk_read(data->regmap, BMA400_X_AXIS_LSB_REG,
+			       &data->buffer.buff, sizeof(data->buffer.buff));
+	if (ret)
+		goto unlock_err;
+
+	ret = regmap_read(data->regmap, BMA400_TEMP_DATA_REG, &temp);
+	if (ret)
+		goto unlock_err;
+
+	data->buffer.temperature = temp;
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
+					   iio_get_time_ns(indio_dev));
+
+	mutex_unlock(&data->mutex);
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+
+unlock_err:
+	mutex_unlock(&data->mutex);
+	return IRQ_NONE;
+}
+
+static irqreturn_t bma400_interrupt(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct bma400_data *data = iio_priv(indio_dev);
+	int ret;
+
+	/* Lock to protect the data->status */
+	mutex_lock(&data->mutex);
+	ret = regmap_bulk_read(data->regmap, BMA400_INT_STAT0_REG,
+			       &data->status,
+			       sizeof(data->status));
+	if (ret)
+		goto unlock_err;
+
+	if (FIELD_GET(BMA400_INT_DRDY_MSK, le16_to_cpu(data->status))) {
+		mutex_unlock(&data->mutex);
+		iio_trigger_poll_chained(data->trig);
+		return IRQ_HANDLED;
+	}
+
+unlock_err:
+	mutex_unlock(&data->mutex);
+	return IRQ_NONE;
+}
+
+int bma400_probe(struct device *dev, struct regmap *regmap, int irq,
+		 const char *name)
 {
 	struct iio_dev *indio_dev;
 	struct bma400_data *data;
@@ -841,8 +961,40 @@ int bma400_probe(struct device *dev, struct regmap *regmap, const char *name)
 	indio_dev->info = &bma400_info;
 	indio_dev->channels = bma400_channels;
 	indio_dev->num_channels = ARRAY_SIZE(bma400_channels);
+	indio_dev->available_scan_masks = bma400_avail_scan_masks;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
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
+		if (ret)
+			return dev_err_probe(data->dev, ret,
+					     "iio trigger register fail\n");
+
+		indio_dev->trig = iio_trigger_get(data->trig);
+		ret = devm_request_threaded_irq(dev, irq, NULL,
+						&bma400_interrupt,
+						IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+						indio_dev->name, indio_dev);
+		if (ret)
+			return dev_err_probe(data->dev, ret,
+					     "request irq %d failed\n", irq);
+	}
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
+					      &bma400_trigger_handler, NULL);
+	if (ret)
+		return dev_err_probe(data->dev, ret,
+				     "iio triggered buffer setup failed\n");
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 EXPORT_SYMBOL_NS(bma400_probe, IIO_BMA400);
diff --git a/drivers/iio/accel/bma400_i2c.c b/drivers/iio/accel/bma400_i2c.c
index 4f6e01a3b3a1..1ba2a982ea73 100644
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
index 28e240400a3f..ec13c044b304 100644
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

