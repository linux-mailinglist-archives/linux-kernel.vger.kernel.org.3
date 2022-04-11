Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972624FC5D4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 22:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349880AbiDKUeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 16:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349840AbiDKUeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 16:34:12 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F2F35DD4;
        Mon, 11 Apr 2022 13:31:48 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id md20-20020a17090b23d400b001cb70ef790dso417441pjb.5;
        Mon, 11 Apr 2022 13:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ddvbkMcy0CIRnqmwuQ8y2WAioenTWNXBncUhsH86xMc=;
        b=JcIGFHsZvu7pjvlRos9JQ1M5p5c9n84e14wgYGpduvunK8WTLoXuvHtxWQmVTXixoS
         EyTW/zpbMDU//Lg3/f2yln/XVJqXcYtU5JSYmTTdQzbI/6Cjb2ekaRzu8eG6QetRed8R
         9QloPGwM6Kzvmv29IZ6eBPCx9cKa2hSThi3cKtCD+C/4rw4/ymUwuRiYf+T/u5JIOqpD
         0f66teiOBmnIy+f/TC2fuarPqh2Bs0ORO6Nhzwfe22nEUMlWuPmydKPxb51+Dy7+9wd7
         d5QNLVWMHIo4kmtr8tVf5thhIRHRrsNlenSxdZqaOxGwpVZ8NAhAHkmshctkmVhWzQp0
         NpeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ddvbkMcy0CIRnqmwuQ8y2WAioenTWNXBncUhsH86xMc=;
        b=Af+vViae6kANuXulopj1lgCuJR6FYuXTJkGdP/Vhd1UkNwE6+V9XYJ201Gv1t7q+dh
         90Ji7H7vRfpnN1sto49B5jTsNzVrViCQXKwICTtiHaMyFQL5CtOCVvBKoUs2FghfRQw5
         8QgOn+NdQJg1escjl053aYVj/3yyQaAckLEbff4ROipro7Zed1UVnRNS/7FwK9jpHW3H
         NIU4TPmmjcea+lP2yS2UAvznsdaEOqWXg2q0JwSmd7mJQ3Ar6lYNrOb57hjDLgOBe9FK
         RG5wqIZ1jUWRO/zY/JEKBAfQLPS+TC0pEWkQlD67azjNH2Mz4SkNly+5zilGgqgxbaXY
         hl0g==
X-Gm-Message-State: AOAM532CjgO0KJaFW8CEscBjn0xcVkb432EtHe9N01dvTmc8tuybaj37
        QV9rLhv9cn+2tBDJpC+vRqA=
X-Google-Smtp-Source: ABdhPJyfD9YhSnJqmMPh0HSaqq0m3xoOi5pHWKRjebHfeEjvWM+nlAso68ZHr0RmHFEVRI0EU5tQvw==
X-Received: by 2002:a17:902:ba88:b0:158:5849:5a37 with SMTP id k8-20020a170902ba8800b0015858495a37mr8203447pls.133.1649709108160;
        Mon, 11 Apr 2022 13:31:48 -0700 (PDT)
Received: from localhost.localdomain ([27.7.99.112])
        by smtp.gmail.com with ESMTPSA id z15-20020a056a001d8f00b004fda37855ddsm34069828pfw.168.2022.04.11.13.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 13:31:47 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     dan@dlrobertson.com, jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/9] iio: accel: bma400: Add triggered buffer support
Date:   Tue, 12 Apr 2022 02:01:28 +0530
Message-Id: <20220411203133.19929-5-jagathjog1996@gmail.com>
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

Added trigger buffer support to read continuous acceleration
data from device with data ready interrupt which is mapped
to INT1 pin.

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 drivers/iio/accel/Kconfig       |   2 +
 drivers/iio/accel/bma400.h      |  10 ++-
 drivers/iio/accel/bma400_core.c | 153 ++++++++++++++++++++++++++++++--
 drivers/iio/accel/bma400_i2c.c  |   2 +-
 drivers/iio/accel/bma400_spi.c  |   2 +-
 5 files changed, 161 insertions(+), 8 deletions(-)

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
index 8dbf85eeb005..a7482a66b36b 100644
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
index 07674d89d978..b7b2b67aef31 100644
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
 
@@ -61,6 +66,13 @@ struct bma400_data {
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
 };
 
 static bool bma400_is_writable_reg(struct device *dev, unsigned int reg)
@@ -152,7 +164,7 @@ static const struct iio_chan_spec_ext_info bma400_ext_info[] = {
 	{ }
 };
 
-#define BMA400_ACC_CHANNEL(_axis) { \
+#define BMA400_ACC_CHANNEL(_index, _axis) { \
 	.type = IIO_ACCEL, \
 	.modified = 1, \
 	.channel2 = IIO_MOD_##_axis, \
@@ -164,17 +176,32 @@ static const struct iio_chan_spec_ext_info bma400_ext_info[] = {
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
@@ -659,6 +686,10 @@ static int bma400_init(struct bma400_data *data)
 	if (ret)
 		return ret;
 
+	/* Configure INT1 pin to open drain */
+	ret = regmap_write(data->regmap, BMA400_INT_IO_CTRL_REG, 0x06);
+	if (ret)
+		return ret;
 	/*
 	 * Once the interrupt engine is supported we might use the
 	 * data_src_reg, but for now ensure this is set to the
@@ -807,6 +838,29 @@ static int bma400_write_raw_get_fmt(struct iio_dev *indio_dev,
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
@@ -814,7 +868,64 @@ static const struct iio_info bma400_info = {
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
+	mutex_lock(&data->mutex);
+
+	/* bulk read six registers, with the base being the LSB register */
+	ret = regmap_bulk_read(data->regmap, BMA400_X_AXIS_LSB_REG,
+			       &data->buffer.buff, sizeof(data->buffer.buff));
+	mutex_unlock(&data->mutex);
+	if (ret)
+		return IRQ_NONE;
+
+	ret = regmap_read(data->regmap, BMA400_TEMP_DATA_REG, &temp);
+	if (ret)
+		return IRQ_NONE;
+
+	data->buffer.temperature = temp;
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
+					   iio_get_time_ns(indio_dev));
+
+	iio_trigger_notify_done(indio_dev->trig);
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
+		return IRQ_NONE;
+
+	if (FIELD_GET(BMA400_INT_DRDY_MSK, le16_to_cpu(status))) {
+		iio_trigger_poll_chained(data->trig);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+int bma400_probe(struct device *dev, struct regmap *regmap, int irq,
+		 const char *name)
 {
 	struct iio_dev *indio_dev;
 	struct bma400_data *data;
@@ -841,8 +952,40 @@ int bma400_probe(struct device *dev, struct regmap *regmap, const char *name)
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

