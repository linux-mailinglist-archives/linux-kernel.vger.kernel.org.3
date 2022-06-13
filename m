Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC57549F23
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbiFMUbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351431AbiFMU3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:29:01 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8F2344EA;
        Mon, 13 Jun 2022 12:17:17 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id gc3-20020a17090b310300b001e33092c737so6886389pjb.3;
        Mon, 13 Jun 2022 12:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U0nu/Lbz3jIPv5ubLcBGfGJo1SZcv+Q5JQfZcLaxt+U=;
        b=TfZsSIzvJvH48aZCLDJRUWMQiJGIn/n4ZGyrF6gEflbQI427Y3kYXzCln2aGbWT/k2
         xjLUiM/EKq8oKehUkzeIJzzyuX+T4rH1YHFBO/fsg9aslHCjfQhKvQKKtoFyX1Xprymi
         vYVKrVKazu1sqq3T9snA4H42GLb3oYNhN7R8yU/6quLE4krPkN5cQ4/Obggfta/xOPNp
         6mTUCdHBHYC2YyhDLJ7AS9NC2f+8FJ7jtooV6qKTqqzyLJ9CyYhwNMjnmAkn0LuBIveL
         OgSMFNBczR7THCYp6blzd2aTeUUNY8LuU+PV7MvyE3/K30YCG4FKpxoGSWzWwjC0FEhk
         NfOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U0nu/Lbz3jIPv5ubLcBGfGJo1SZcv+Q5JQfZcLaxt+U=;
        b=zV4onZiTRsSoCGWr7dwL1bN8/4KjijkR8PzmC2VPHfr/UF1kfNQJKyaMvYhuXNz982
         qZ2ihorCmWbd624ANjAHiPGg0+A4i6Qfqol29xKh7Xlxo/1o0b74TQVo8/DyR0cmM6nH
         h9ax2ua2GJz9u0MDWVy+bm6rfxZIJHeLvdfFEMkjohU0rxjIVL+CdqmxwlELAEzYF7n3
         Ivw74Drnbds0Q4lZ0AAnSOcDngMne20uyBtR0bSCdr3i8Uk7yD1oiUcMC2RMTnpx8MQb
         pMbYrLkm+uvZubvTfrCXgyQJXoHiqsEhDcHlq008ByTWlgEuWjllg0t/5Oafd4/6QKwy
         70QA==
X-Gm-Message-State: AJIora9oujFm0/UjvTHQgzXG17TqH1aYIg8jVV1pp/apHI7p8g44YyAO
        5n5EYcuwvJTyES2+q/9OgIhND9QmtG0=
X-Google-Smtp-Source: AGRyM1vwr/AZKlmqe7GSETQ6Rf4cDJiQZUDSqMeQXtEWJVwKwEdwtBPPWn5CxfGOdy8Ms4+WKI1Wxw==
X-Received: by 2002:a17:902:e88e:b0:163:ee82:ffb with SMTP id w14-20020a170902e88e00b00163ee820ffbmr819112plg.142.1655147837070;
        Mon, 13 Jun 2022 12:17:17 -0700 (PDT)
Received: from localhost.localdomain ([60.243.255.226])
        by smtp.gmail.com with ESMTPSA id x15-20020a17090abc8f00b001e310303275sm5567202pjr.54.2022.06.13.12.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 12:17:16 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] iio: accel: bma400: Add support for single and double tap events
Date:   Tue, 14 Jun 2022 00:47:06 +0530
Message-Id: <20220613191706.31239-3-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220613191706.31239-1-jagathjog1996@gmail.com>
References: <20220613191706.31239-1-jagathjog1996@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for single and double tap events based on the tap threshold
value and minimum quiet time value between the taps. The INT1 pin is used
to interrupt and event is pushed to userspace.

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 drivers/iio/accel/bma400.h      |  11 ++
 drivers/iio/accel/bma400_core.c | 210 ++++++++++++++++++++++++++++++--
 2 files changed, 211 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
index e8f802a82300..d05edd9b009a 100644
--- a/drivers/iio/accel/bma400.h
+++ b/drivers/iio/accel/bma400.h
@@ -40,6 +40,7 @@
 #define BMA400_INT_STAT1_REG        0x0f
 #define BMA400_INT_STAT2_REG        0x10
 #define BMA400_INT12_MAP_REG        0x23
+#define BMA400_INT_ENG_OVRUN_MSK    BIT(4)
 
 /* Temperature register */
 #define BMA400_TEMP_DATA_REG        0x11
@@ -105,6 +106,16 @@
 #define BMA400_INT_GEN2_MSK         BIT(3)
 #define BMA400_GEN_HYST_MSK         GENMASK(1, 0)
 
+/* TAP config registers */
+#define BMA400_TAP_CONFIG           0x57
+#define BMA400_TAP_CONFIG1          0x58
+#define BMA400_S_TAP_MSK            BIT(2)
+#define BMA400_D_TAP_MSK            BIT(3)
+#define BMA400_INT_S_TAP_MSK        BIT(10)
+#define BMA400_INT_D_TAP_MSK        BIT(11)
+#define BMA400_TAP_SEN_MSK          GENMASK(2, 0)
+#define BMA400_TAP_QUIET_MSK        GENMASK(3, 2)
+
 /*
  * BMA400_SCALE_MIN macro value represents m/s^2 for 1 LSB before
  * converting to micro values for +-2g range.
diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index c31bdd9b168e..f8945dc0de04 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -29,6 +29,7 @@
 #include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
+#include <linux/iio/sysfs.h>
 
 #include "bma400.h"
 
@@ -88,6 +89,7 @@ struct bma400_data {
 	bool step_event_en;
 	bool activity_event_en;
 	unsigned int generic_event_en;
+	unsigned int tap_event_en;
 	/* Correct time stamp alignment */
 	struct {
 		__le16 buff[3];
@@ -216,6 +218,36 @@ static const struct iio_event_spec bma400_accel_event[] = {
 				       BIT(IIO_EV_INFO_HYSTERESIS) |
 				       BIT(IIO_EV_INFO_ENABLE),
 	},
+	{
+		.type = IIO_EV_TYPE_GESTURE,
+		.dir = IIO_EV_DIR_SINGLETAP,
+		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
+				       BIT(IIO_EV_INFO_ENABLE),
+	},
+	{
+		.type = IIO_EV_TYPE_GESTURE,
+		.dir = IIO_EV_DIR_DOUBLETAP,
+		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
+				       BIT(IIO_EV_INFO_PERIOD) |
+				       BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
+/* List of sensitivity values available to configure tap interrupts */
+static IIO_CONST_ATTR(in_accel_gesture_value_available, "0 1 2 3 4 5 6 7");
+
+/* List of minimum quiet time before and after double tap, in data samples. */
+static IIO_CONST_ATTR(in_accel_gesture_doubletap_period_available,
+		      "60 80 100 120");
+
+static struct attribute *bma400_event_attributes[] = {
+	&iio_const_attr_in_accel_gesture_value_available.dev_attr.attr,
+	&iio_const_attr_in_accel_gesture_doubletap_period_available.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group bma400_event_attribute_group = {
+	.attrs = bma400_event_attributes,
 };
 
 #define BMA400_ACC_CHANNEL(_index, _axis) { \
@@ -1012,6 +1044,10 @@ static int bma400_read_event_config(struct iio_dev *indio_dev,
 		case IIO_EV_DIR_FALLING:
 			return FIELD_GET(BMA400_INT_GEN2_MSK,
 					 data->generic_event_en);
+		case IIO_EV_DIR_SINGLETAP:
+			return FIELD_GET(BMA400_S_TAP_MSK, data->tap_event_en);
+		case IIO_EV_DIR_DOUBLETAP:
+			return FIELD_GET(BMA400_D_TAP_MSK, data->tap_event_en);
 		default:
 			return -EINVAL;
 		}
@@ -1101,6 +1137,80 @@ static int bma400_activity_event_en(struct bma400_data *data,
 	return 0;
 }
 
+static int bma400_tap_event_en(struct bma400_data *data,
+			       enum iio_event_direction dir, int state)
+{
+	int ret;
+	unsigned int mask, field_value;
+
+	/*
+	 * Tap interrupts can be configured only in normal mode.
+	 * See table in section 4.3 "Power modes - performance modes" of
+	 * datasheet v1.2.
+	 */
+	if (data->power_mode != POWER_MODE_NORMAL)
+		return -EINVAL;
+
+	/*
+	 * Tap interrupts are operating with the data rate of 200Hz.
+	 * See section 4.7 "Tap sensing interrupt" in datasheet v1.2.
+	 */
+	if (data->sample_freq.hz != 200) {
+		dev_err(data->dev, "Invalid data rate for tap interrupts.\n");
+		return -EINVAL;
+	}
+
+	ret = regmap_update_bits(data->regmap, BMA400_INT12_MAP_REG,
+				 BMA400_S_TAP_MSK,
+				 FIELD_PREP(BMA400_S_TAP_MSK, state));
+	if (ret)
+		return ret;
+
+	switch (dir) {
+	case IIO_EV_DIR_SINGLETAP:
+		mask = BMA400_S_TAP_MSK;
+		set_mask_bits(&field_value, BMA400_S_TAP_MSK,
+			      FIELD_PREP(BMA400_S_TAP_MSK, state));
+		break;
+	case IIO_EV_DIR_DOUBLETAP:
+		mask = BMA400_D_TAP_MSK;
+		set_mask_bits(&field_value, BMA400_D_TAP_MSK,
+			      FIELD_PREP(BMA400_D_TAP_MSK, state));
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = regmap_update_bits(data->regmap, BMA400_INT_CONFIG1_REG, mask,
+				 field_value);
+	if (ret)
+		return ret;
+
+	set_mask_bits(&data->tap_event_en, mask, field_value);
+
+	return 0;
+}
+
+static int bma400_disable_adv_interrupt(struct bma400_data *data)
+{
+	int ret;
+
+	ret = regmap_write(data->regmap, BMA400_INT_CONFIG0_REG, 0);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(data->regmap, BMA400_INT_CONFIG1_REG, 0);
+	if (ret)
+		return ret;
+
+	data->tap_event_en = 0;
+	data->generic_event_en = 0;
+	data->step_event_en = 0;
+	data->activity_event_en = 0;
+
+	return 0;
+}
+
 static int bma400_write_event_config(struct iio_dev *indio_dev,
 				     const struct iio_chan_spec *chan,
 				     enum iio_event_type type,
@@ -1111,10 +1221,20 @@ static int bma400_write_event_config(struct iio_dev *indio_dev,
 
 	switch (chan->type) {
 	case IIO_ACCEL:
-		mutex_lock(&data->mutex);
-		ret = bma400_activity_event_en(data, dir, state);
-		mutex_unlock(&data->mutex);
-		return ret;
+		switch (type) {
+		case IIO_EV_TYPE_MAG:
+			mutex_lock(&data->mutex);
+			ret = bma400_activity_event_en(data, dir, state);
+			mutex_unlock(&data->mutex);
+			return ret;
+		case IIO_EV_TYPE_GESTURE:
+			mutex_lock(&data->mutex);
+			ret = bma400_tap_event_en(data, dir, state);
+			mutex_unlock(&data->mutex);
+			return ret;
+		default:
+			return -EINVAL;
+		}
 	case IIO_STEPS:
 		mutex_lock(&data->mutex);
 		ret = bma400_steps_event_enable(data, state);
@@ -1159,8 +1279,8 @@ static int bma400_read_event_value(struct iio_dev *indio_dev,
 	struct bma400_data *data = iio_priv(indio_dev);
 	int ret, reg;
 
-	switch (chan->type) {
-	case IIO_ACCEL:
+	switch (type) {
+	case IIO_EV_TYPE_MAG:
 		reg = get_gen_config_reg(dir);
 		if (reg < 0)
 			return -EINVAL;
@@ -1196,6 +1316,25 @@ static int bma400_read_event_value(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
+	case IIO_EV_TYPE_GESTURE:
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			ret = regmap_read(data->regmap, BMA400_TAP_CONFIG,
+					  val);
+			if (ret)
+				return ret;
+			*val = FIELD_GET(BMA400_TAP_SEN_MSK, *val);
+			return IIO_VAL_INT;
+		case IIO_EV_INFO_PERIOD:
+			ret = regmap_read(data->regmap, BMA400_TAP_CONFIG1,
+					  val);
+			if (ret)
+				return ret;
+			*val = FIELD_GET(BMA400_TAP_QUIET_MSK, *val);
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
 	default:
 		return -EINVAL;
 	}
@@ -1209,10 +1348,10 @@ static int bma400_write_event_value(struct iio_dev *indio_dev,
 				    int val, int val2)
 {
 	struct bma400_data *data = iio_priv(indio_dev);
-	int reg, ret;
+	int reg, ret, quiet_period;
 
-	switch (chan->type) {
-	case IIO_ACCEL:
+	switch (type) {
+	case IIO_EV_TYPE_MAG:
 		reg = get_gen_config_reg(dir);
 		if (reg < 0)
 			return -EINVAL;
@@ -1228,7 +1367,6 @@ static int bma400_write_event_value(struct iio_dev *indio_dev,
 		case IIO_EV_INFO_PERIOD:
 			if (val < 1 || val > 65535)
 				return -EINVAL;
-
 			mutex_lock(&data->mutex);
 			put_unaligned_be16(val, &data->duration);
 			ret = regmap_bulk_write(data->regmap,
@@ -1248,6 +1386,31 @@ static int bma400_write_event_value(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
+	case IIO_EV_TYPE_GESTURE:
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			if (val < 0 || val > 7)
+				return -EINVAL;
+
+			return regmap_update_bits(data->regmap,
+						  BMA400_TAP_CONFIG,
+						  BMA400_TAP_SEN_MSK,
+						  FIELD_PREP(BMA400_TAP_SEN_MSK,
+							     val));
+
+		case IIO_EV_INFO_PERIOD:
+			quiet_period = (val / 20) - 3;
+			if (quiet_period < 0 || quiet_period > 3)
+				return -EINVAL;
+
+			return regmap_update_bits(data->regmap,
+						  BMA400_TAP_CONFIG1,
+						  BMA400_TAP_QUIET_MSK,
+						  FIELD_PREP(BMA400_TAP_QUIET_MSK,
+							     quiet_period));
+		default:
+			return -EINVAL;
+		}
 	default:
 		return -EINVAL;
 	}
@@ -1287,6 +1450,7 @@ static const struct iio_info bma400_info = {
 	.write_event_config = bma400_write_event_config,
 	.write_event_value = bma400_write_event_value,
 	.read_event_value = bma400_read_event_value,
+	.event_attrs = &bma400_event_attribute_group,
 };
 
 static const struct iio_trigger_ops bma400_trigger_ops = {
@@ -1350,6 +1514,32 @@ static irqreturn_t bma400_interrupt(int irq, void *private)
 	if (ret || !data->status)
 		goto unlock_err;
 
+	/*
+	 * Disable all advance interrupts if interrupt engine overrun occurs.
+	 * See section 4.7 "Interrupt engine overrun" in datasheet v1.2.
+	 */
+	if (FIELD_GET(BMA400_INT_ENG_OVRUN_MSK, le16_to_cpu(data->status))) {
+		bma400_disable_adv_interrupt(data);
+		dev_err(data->dev, "Interrupt engine overrun\n");
+		goto unlock_err;
+	}
+
+	if (FIELD_GET(BMA400_INT_S_TAP_MSK, le16_to_cpu(data->status)))
+		iio_push_event(indio_dev,
+			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+						  IIO_MOD_X_OR_Y_OR_Z,
+						  IIO_EV_TYPE_GESTURE,
+						  IIO_EV_DIR_SINGLETAP),
+			       timestamp);
+
+	if (FIELD_GET(BMA400_INT_D_TAP_MSK, le16_to_cpu(data->status)))
+		iio_push_event(indio_dev,
+			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+						  IIO_MOD_X_OR_Y_OR_Z,
+						  IIO_EV_TYPE_GESTURE,
+						  IIO_EV_DIR_DOUBLETAP),
+			       timestamp);
+
 	if (FIELD_GET(BMA400_INT_GEN1_MSK, le16_to_cpu(data->status)))
 		ev_dir = IIO_EV_DIR_RISING;
 
-- 
2.17.1

