Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0292B5A76AC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 08:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiHaGbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 02:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbiHaGbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 02:31:31 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07026BD4D8;
        Tue, 30 Aug 2022 23:31:29 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso20168796pjk.0;
        Tue, 30 Aug 2022 23:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=IDCtzbR97uTK3LY3ntNXdIOjcjUqcprHwcQoADqpOWg=;
        b=jQkrqaVjPHJDKs0jwnDprfJQ6vDLfYfdAfTzgj/yamUL9znb6GsDtteYtYbyIUSk6u
         5Xc58aMqKREPzmxi/u5vFGGg2cQNz9y7A7RosrsdFUqinibzv4ZKuzE8fNGtEHxySn43
         euKai0hdOTeMku2KgRQ7otm30qfpWi/P/tEEfHSl0Lj6B+mSdV+trbrlSsN3UwJbUm7+
         xEyTDiIMQ4nyw2vVgubR2TcQffUflqY4jMx1iAB4KXjgL1+TRqbmVB+amGr8M/WsEUAY
         wWL12od2MM19sPbo76Qly2nFd9orxwubrTuRw6LEL3gbokmYxIbwbEXs0V7qkTll+Kdu
         Jw7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=IDCtzbR97uTK3LY3ntNXdIOjcjUqcprHwcQoADqpOWg=;
        b=0PSWdZyRiSNa63k8emOqOUDw86bPl1Le/+EUOx5tPZ3oukXgOXh9tRKFoDSYaCLON6
         BMxvHt3TYVjzJRAi4VBb2YIlFo+cGXQO6sFIQXcytP8J8pDIJdXHpxJ9ogoeKpWEMzI2
         MoVAGWaJBmSByZSEysf3RuQU2Vv7hZfSp3dxD1FiAGK458MQSAVhNUx3QnuvUPYbbzX0
         4JDf5PIyyD2eX+ms2gp8T4wVyVnYy56QwgP8HK8ePXtTOz0sK4jG/94t5VUMTCR8YhgX
         M+S/UL6Wrk6/r4ZlzbcQdSYfoNKRzTb2QHATK9qKTljD/+yFpxSTpaWr1hKX0z+MHJcO
         dCRA==
X-Gm-Message-State: ACgBeo2VOxBNyI+2qNKDNYfcpsrB/MSq+AuoyrRnvHMLznvsKY0bNZn/
        HYEFr9Dc/FHn2DKZgD94HyI=
X-Google-Smtp-Source: AA6agR6Cj+9+Yn6xAjzHOfaX1fXVQyoBxyMDwehB5RXtM0xYwN0ZO7Hid2445abTbZLehd1SmswLeQ==
X-Received: by 2002:a17:902:ce12:b0:172:9512:595d with SMTP id k18-20020a170902ce1200b001729512595dmr24997508plg.101.1661927488321;
        Tue, 30 Aug 2022 23:31:28 -0700 (PDT)
Received: from localhost.localdomain ([115.99.190.245])
        by smtp.gmail.com with ESMTPSA id z30-20020a62d11e000000b0052d24402e52sm10362220pfg.79.2022.08.30.23.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 23:31:27 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     jic23@kernel.org, andy.shevchenko@gmail.com, hadess@hadess.net,
        hdegoede@redhat.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] iio: accel: bma400: Add support for single and double tap events
Date:   Wed, 31 Aug 2022 12:01:17 +0530
Message-Id: <20220831063117.4141-3-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220831063117.4141-1-jagathjog1996@gmail.com>
References: <20220831063117.4141-1-jagathjog1996@gmail.com>
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
value, minimum quiet time before and after the tap and minimum time
between the taps in the double tap. The INT1 pin is used to interrupt
and the event is pushed to userspace.

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 drivers/iio/accel/bma400.h      |  14 ++
 drivers/iio/accel/bma400_core.c | 343 +++++++++++++++++++++++++++++++-
 2 files changed, 347 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
index e8f802a82300..36edbaff4f7f 100644
--- a/drivers/iio/accel/bma400.h
+++ b/drivers/iio/accel/bma400.h
@@ -40,6 +40,7 @@
 #define BMA400_INT_STAT1_REG        0x0f
 #define BMA400_INT_STAT2_REG        0x10
 #define BMA400_INT12_MAP_REG        0x23
+#define BMA400_INT_ENG_OVRUN_MSK    BIT(4)
 
 /* Temperature register */
 #define BMA400_TEMP_DATA_REG        0x11
@@ -105,6 +106,19 @@
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
+#define BMA400_TAP_TICSTH_MSK       GENMASK(1, 0)
+#define BMA400_TAP_QUIET_MSK        GENMASK(3, 2)
+#define BMA400_TAP_QUIETDT_MSK      GENMASK(5, 4)
+#define BMA400_TAP_TIM_LIST_LEN     4
+
 /*
  * BMA400_SCALE_MIN macro value represents m/s^2 for 1 LSB before
  * converting to micro values for +-2g range.
diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index c31bdd9b168e..eceb1f8d338d 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -26,6 +26,7 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/events.h>
+#include <linux/iio/sysfs.h>
 #include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
@@ -47,6 +48,27 @@ static int bma400_sample_freqs[14];
 
 static const int bma400_osr_range[] = { 0, 1, 3 };
 
+static int tap_reset_timeout[BMA400_TAP_TIM_LIST_LEN] = {
+	300000,
+	400000,
+	500000,
+	600000
+};
+
+static int tap_max2min_time[BMA400_TAP_TIM_LIST_LEN] = {
+	30000,
+	45000,
+	60000,
+	90000
+};
+
+static int double_tap2_min_delay[BMA400_TAP_TIM_LIST_LEN] = {
+	20000,
+	40000,
+	60000,
+	80000
+};
+
 /* See the ACC_CONFIG0 section of the datasheet */
 enum bma400_power_mode {
 	POWER_MODE_SLEEP   = 0x00,
@@ -88,6 +110,7 @@ struct bma400_data {
 	bool step_event_en;
 	bool activity_event_en;
 	unsigned int generic_event_en;
+	unsigned int tap_event_en_bitmask;
 	/* Correct time stamp alignment */
 	struct {
 		__le16 buff[3];
@@ -216,6 +239,115 @@ static const struct iio_event_spec bma400_accel_event[] = {
 				       BIT(IIO_EV_INFO_HYSTERESIS) |
 				       BIT(IIO_EV_INFO_ENABLE),
 	},
+	{
+		.type = IIO_EV_TYPE_GESTURE,
+		.dir = IIO_EV_DIR_SINGLETAP,
+		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
+				       BIT(IIO_EV_INFO_ENABLE) |
+				       BIT(IIO_EV_INFO_RESET_TIMEOUT),
+	},
+	{
+		.type = IIO_EV_TYPE_GESTURE,
+		.dir = IIO_EV_DIR_DOUBLETAP,
+		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
+				       BIT(IIO_EV_INFO_ENABLE) |
+				       BIT(IIO_EV_INFO_RESET_TIMEOUT) |
+				       BIT(IIO_EV_INFO_TAP2_MIN_DELAY),
+	},
+};
+
+static int usec_to_tapreg_raw(int usec, const int *time_list)
+{
+	int index;
+
+	for (index = 0; index < BMA400_TAP_TIM_LIST_LEN; index++) {
+		if (usec == time_list[index])
+			return index;
+	}
+	return -EINVAL;
+}
+
+static ssize_t in_accel_gesture_tap_maxtomin_time_show(struct device *dev,
+						       struct device_attribute *attr,
+						       char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct bma400_data *data = iio_priv(indio_dev);
+	int ret, reg_val, raw, vals[2];
+
+	ret = regmap_read(data->regmap, BMA400_TAP_CONFIG1, &reg_val);
+	if (ret)
+		return ret;
+
+	raw = FIELD_GET(BMA400_TAP_TICSTH_MSK, reg_val);
+	vals[0] = 0;
+	vals[1] = tap_max2min_time[raw];
+
+	return iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO, 2, vals);
+}
+
+static ssize_t in_accel_gesture_tap_maxtomin_time_store(struct device *dev,
+							struct device_attribute *attr,
+							const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct bma400_data *data = iio_priv(indio_dev);
+	int ret, val_int, val_fract, raw;
+
+	ret = iio_str_to_fixpoint(buf, 100000, &val_int, &val_fract);
+	if (ret)
+		return ret;
+
+	raw = usec_to_tapreg_raw(val_fract, tap_max2min_time);
+	if (raw < 0)
+		return -EINVAL;
+
+	ret = regmap_update_bits(data->regmap, BMA400_TAP_CONFIG1,
+				 BMA400_TAP_TICSTH_MSK,
+				 FIELD_PREP(BMA400_TAP_TICSTH_MSK, raw));
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static IIO_DEVICE_ATTR_RW(in_accel_gesture_tap_maxtomin_time, 0);
+
+/*
+ * Tap interrupts works with 200 Hz input data rate and the time based tap
+ * controls are in the terms of data samples so the below calculation is
+ * used to convert the configuration values into seconds.
+ * e.g.:
+ * 60 data samples * 0.005 ms = 0.3 seconds.
+ * 80 data samples * 0.005 ms = 0.4 seconds.
+ */
+
+/* quiet configuration values in seconds */
+static IIO_CONST_ATTR(in_accel_gesture_tap_reset_timeout_available,
+		      "0.3 0.4 0.5 0.6");
+
+/* tics_th configuration values in seconds */
+static IIO_CONST_ATTR(in_accel_gesture_tap_maxtomin_time_available,
+		      "0.03 0.045 0.06 0.09");
+
+/* quiet_dt configuration values in seconds */
+static IIO_CONST_ATTR(in_accel_gesture_doubletap_tap2_min_delay_available,
+		      "0.02 0.04 0.06 0.08");
+
+/* List of sensitivity values available to configure tap interrupts */
+static IIO_CONST_ATTR(in_accel_gesture_tap_value_available, "0 1 2 3 4 5 6 7");
+
+static struct attribute *bma400_event_attributes[] = {
+	&iio_const_attr_in_accel_gesture_tap_value_available.dev_attr.attr,
+	&iio_const_attr_in_accel_gesture_tap_reset_timeout_available.dev_attr.attr,
+	&iio_const_attr_in_accel_gesture_tap_maxtomin_time_available.dev_attr.attr,
+	&iio_const_attr_in_accel_gesture_doubletap_tap2_min_delay_available.dev_attr.attr,
+	&iio_dev_attr_in_accel_gesture_tap_maxtomin_time.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group bma400_event_attribute_group = {
+	.attrs = bma400_event_attributes,
 };
 
 #define BMA400_ACC_CHANNEL(_index, _axis) { \
@@ -1012,6 +1144,12 @@ static int bma400_read_event_config(struct iio_dev *indio_dev,
 		case IIO_EV_DIR_FALLING:
 			return FIELD_GET(BMA400_INT_GEN2_MSK,
 					 data->generic_event_en);
+		case IIO_EV_DIR_SINGLETAP:
+			return FIELD_GET(BMA400_S_TAP_MSK,
+					 data->tap_event_en_bitmask);
+		case IIO_EV_DIR_DOUBLETAP:
+			return FIELD_GET(BMA400_D_TAP_MSK,
+					 data->tap_event_en_bitmask);
 		default:
 			return -EINVAL;
 		}
@@ -1101,6 +1239,80 @@ static int bma400_activity_event_en(struct bma400_data *data,
 	return 0;
 }
 
+static int bma400_tap_event_en(struct bma400_data *data,
+			       enum iio_event_direction dir, int state)
+{
+	unsigned int mask, field_value;
+	int ret;
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
+	 * Tap interrupts are operating with a data rate of 200Hz.
+	 * See section 4.7 "Tap sensing interrupt" in datasheet v1.2.
+	 */
+	if (data->sample_freq.hz != 200 && state) {
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
+	set_mask_bits(&data->tap_event_en_bitmask, mask, field_value);
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
+	data->tap_event_en_bitmask = 0;
+	data->generic_event_en = 0;
+	data->step_event_en = false;
+	data->activity_event_en = false;
+
+	return 0;
+}
+
 static int bma400_write_event_config(struct iio_dev *indio_dev,
 				     const struct iio_chan_spec *chan,
 				     enum iio_event_type type,
@@ -1111,10 +1323,20 @@ static int bma400_write_event_config(struct iio_dev *indio_dev,
 
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
@@ -1157,10 +1379,13 @@ static int bma400_read_event_value(struct iio_dev *indio_dev,
 				   int *val, int *val2)
 {
 	struct bma400_data *data = iio_priv(indio_dev);
-	int ret, reg;
+	int ret, reg, reg_val, raw;
 
-	switch (chan->type) {
-	case IIO_ACCEL:
+	if (chan->type != IIO_ACCEL)
+		return -EINVAL;
+
+	switch (type) {
+	case IIO_EV_TYPE_MAG:
 		reg = get_gen_config_reg(dir);
 		if (reg < 0)
 			return -EINVAL;
@@ -1196,6 +1421,39 @@ static int bma400_read_event_value(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
+	case IIO_EV_TYPE_GESTURE:
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			ret = regmap_read(data->regmap, BMA400_TAP_CONFIG,
+					  &reg_val);
+			if (ret)
+				return ret;
+
+			*val = FIELD_GET(BMA400_TAP_SEN_MSK, reg_val);
+			return IIO_VAL_INT;
+		case IIO_EV_INFO_RESET_TIMEOUT:
+			ret = regmap_read(data->regmap, BMA400_TAP_CONFIG1,
+					  &reg_val);
+			if (ret)
+				return ret;
+
+			raw = FIELD_GET(BMA400_TAP_QUIET_MSK, reg_val);
+			*val = 0;
+			*val2 = tap_reset_timeout[raw];
+			return IIO_VAL_INT_PLUS_MICRO;
+		case IIO_EV_INFO_TAP2_MIN_DELAY:
+			ret = regmap_read(data->regmap, BMA400_TAP_CONFIG1,
+					  &reg_val);
+			if (ret)
+				return ret;
+
+			raw = FIELD_GET(BMA400_TAP_QUIETDT_MSK, reg_val);
+			*val = 0;
+			*val2 = double_tap2_min_delay[raw];
+			return IIO_VAL_INT_PLUS_MICRO;
+		default:
+			return -EINVAL;
+		}
 	default:
 		return -EINVAL;
 	}
@@ -1209,10 +1467,13 @@ static int bma400_write_event_value(struct iio_dev *indio_dev,
 				    int val, int val2)
 {
 	struct bma400_data *data = iio_priv(indio_dev);
-	int reg, ret;
+	int reg, ret, raw;
 
-	switch (chan->type) {
-	case IIO_ACCEL:
+	if (chan->type != IIO_ACCEL)
+		return -EINVAL;
+
+	switch (type) {
+	case IIO_EV_TYPE_MAG:
 		reg = get_gen_config_reg(dir);
 		if (reg < 0)
 			return -EINVAL;
@@ -1248,6 +1509,40 @@ static int bma400_write_event_value(struct iio_dev *indio_dev,
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
+		case IIO_EV_INFO_RESET_TIMEOUT:
+			raw = usec_to_tapreg_raw(val2, tap_reset_timeout);
+			if (raw < 0)
+				return -EINVAL;
+
+			return regmap_update_bits(data->regmap,
+						  BMA400_TAP_CONFIG1,
+						  BMA400_TAP_QUIET_MSK,
+						  FIELD_PREP(BMA400_TAP_QUIET_MSK,
+							     raw));
+		case IIO_EV_INFO_TAP2_MIN_DELAY:
+			raw = usec_to_tapreg_raw(val2, double_tap2_min_delay);
+			if (raw < 0)
+				return -EINVAL;
+
+			return regmap_update_bits(data->regmap,
+						  BMA400_TAP_CONFIG1,
+						  BMA400_TAP_QUIETDT_MSK,
+						  FIELD_PREP(BMA400_TAP_QUIETDT_MSK,
+							     raw));
+		default:
+			return -EINVAL;
+		}
 	default:
 		return -EINVAL;
 	}
@@ -1287,6 +1582,7 @@ static const struct iio_info bma400_info = {
 	.write_event_config = bma400_write_event_config,
 	.write_event_value = bma400_write_event_value,
 	.read_event_value = bma400_read_event_value,
+	.event_attrs = &bma400_event_attribute_group,
 };
 
 static const struct iio_trigger_ops bma400_trigger_ops = {
@@ -1350,6 +1646,32 @@ static irqreturn_t bma400_interrupt(int irq, void *private)
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
 
@@ -1467,5 +1789,6 @@ int bma400_probe(struct device *dev, struct regmap *regmap, int irq,
 EXPORT_SYMBOL_NS(bma400_probe, IIO_BMA400);
 
 MODULE_AUTHOR("Dan Robertson <dan@dlrobertson.com>");
+MODULE_AUTHOR("Jagath Jog J <jagathjog1996@gmail.com>");
 MODULE_DESCRIPTION("Bosch BMA400 triaxial acceleration sensor core");
 MODULE_LICENSE("GPL");
-- 
2.17.1

