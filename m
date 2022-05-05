Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE6951C0D6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 15:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379731AbiEENe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 09:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379526AbiEENeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 09:34:25 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F231277A;
        Thu,  5 May 2022 06:30:46 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id w17-20020a17090a529100b001db302efed6so4107737pjh.4;
        Thu, 05 May 2022 06:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mymmciEAh6gGaYaWlOmYlAQretqP2MT5VzSw6yN9VE4=;
        b=qHVoO/0E54JfprinuqbhxVpBAA7BbE5EL3y/U0JqA3synqCvZgtWQi8mW5EtMY33+p
         bIwaXTdpMzYxIp/CKyY9e6rBXJglIf2qyS3WjTyU+Iiz+AbKxodkclBq1cOBqV/7cWpJ
         kyPY8k82NP65YbeN4OCVUNkuFGx+u9EEoi1hLHdaQTMpIkrpluSv/HdgmRnD+3nkb+gu
         ZK7ydaFcNfbAOhn6uWZjfdsmFsBbfXul9bfLlCRGDtAqT6VwLldLt0oLZSiltnJwq82L
         r0F7xCqDIC+saRyjj0+9GX8NClp11g4UpR+nz/P4cTr2i21LYiNOWnMVikVybfpwlHqq
         yGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mymmciEAh6gGaYaWlOmYlAQretqP2MT5VzSw6yN9VE4=;
        b=DVBOeO++QkqqQfN8TnWB1IQSMri7PkRrp5cC4bXnj24lzq4zb3DFMB00mTOW9uwkKi
         vNUeKC9hxHYJU9cAHRHNHSujrQCEylUE2uhth+ANh8cZi066a+4EcgWA9zJ5NrVjL5xr
         EOw0vQ/oMuQeCwPH0/BRXuvFYywUpk1SmyWIQaAY/ocKkcAaOP+A2fa5u0JiIoXg7XH0
         IbGESDQFVVSgFm7BL+wZuzvnmEQo6AD+sxMoU+BjEjLnOmz1dJScRTGz+pIGQII/HVwr
         FRdpzzHcFKRRypSvUX57Vytn4o9DP22yuGsNBwUMe1RLt48vnYr/Xzf9CqEFZU8VZqpQ
         Nxrw==
X-Gm-Message-State: AOAM530kJhugoNSCl5YR0q4sUzu9351VzQTyPvSkcaEP2QzakRniE5WG
        uyMuV+vQeJMtEvKA0A7T14DbORYdXas=
X-Google-Smtp-Source: ABdhPJxm9caMGIW0coin59QO5bewsdNO2WtZXVNh0EMHuOD0l9Un5WGYUFlVSFuFPknTKgBBQe+hNQ==
X-Received: by 2002:a17:90a:cd06:b0:1cb:8c74:2baf with SMTP id d6-20020a17090acd0600b001cb8c742bafmr6154640pju.214.1651757445577;
        Thu, 05 May 2022 06:30:45 -0700 (PDT)
Received: from localhost.localdomain ([115.99.184.228])
        by smtp.gmail.com with ESMTPSA id c64-20020a624e43000000b0050dc7628135sm1420120pfb.15.2022.05.05.06.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 06:30:45 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     dan@dlrobertson.com, jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 08/10] iio: accel: bma400: Add support for activity and inactivity events
Date:   Thu,  5 May 2022 19:00:19 +0530
Message-Id: <20220505133021.22362-9-jagathjog1996@gmail.com>
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

Add support for activity and inactivity events for all axis based on the
threshold, duration and hysteresis value set from the userspace. INT1 pin
is used to interrupt and event is pushed to userspace.

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 drivers/iio/accel/bma400.h      |  11 ++
 drivers/iio/accel/bma400_core.c | 232 +++++++++++++++++++++++++++++++-
 2 files changed, 242 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
index 0faa40fdbbf8..e8f802a82300 100644
--- a/drivers/iio/accel/bma400.h
+++ b/drivers/iio/accel/bma400.h
@@ -94,6 +94,17 @@
 #define BMA400_ACC_ODR_MIN_WHOLE_HZ 25
 #define BMA400_ACC_ODR_MIN_HZ       12
 
+/* Generic interrupts register */
+#define BMA400_GEN1INT_CONFIG0      0x3f
+#define BMA400_GEN2INT_CONFIG0      0x4A
+#define BMA400_GEN_CONFIG1_OFF      0x01
+#define BMA400_GEN_CONFIG2_OFF      0x02
+#define BMA400_GEN_CONFIG3_OFF      0x03
+#define BMA400_GEN_CONFIG31_OFF     0x04
+#define BMA400_INT_GEN1_MSK         BIT(2)
+#define BMA400_INT_GEN2_MSK         BIT(3)
+#define BMA400_GEN_HYST_MSK         GENMASK(1, 0)
+
 /*
  * BMA400_SCALE_MIN macro value represents m/s^2 for 1 LSB before
  * converting to micro values for +-2g range.
diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index 1e4923064b63..8faff72625b3 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -87,6 +87,7 @@ struct bma400_data {
 	int steps_enabled;
 	bool step_event_en;
 	bool activity_event_en;
+	unsigned int generic_event_en;
 	/* Correct time stamp alignment */
 	struct {
 		__le16 buff[3];
@@ -94,6 +95,7 @@ struct bma400_data {
 		s64 ts __aligned(8);
 	} buffer __aligned(IIO_ALIGN);
 	__le16 status;
+	__be16 duration;
 };
 
 static bool bma400_is_writable_reg(struct device *dev, unsigned int reg)
@@ -197,6 +199,25 @@ static const struct iio_event_spec bma400_activity_event = {
 	.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE),
 };
 
+static const struct iio_event_spec bma400_accel_event[] = {
+	{
+		.type = IIO_EV_TYPE_MAG,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
+				       BIT(IIO_EV_INFO_PERIOD) |
+				       BIT(IIO_EV_INFO_HYSTERESIS) |
+				       BIT(IIO_EV_INFO_ENABLE),
+	},
+	{
+		.type = IIO_EV_TYPE_MAG,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
+				       BIT(IIO_EV_INFO_PERIOD) |
+				       BIT(IIO_EV_INFO_HYSTERESIS) |
+				       BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
 #define BMA400_ACC_CHANNEL(_index, _axis) { \
 	.type = IIO_ACCEL, \
 	.modified = 1, \
@@ -216,6 +237,8 @@ static const struct iio_event_spec bma400_activity_event = {
 		.storagebits = 16,	\
 		.endianness = IIO_LE,	\
 	},				\
+	.event_spec = bma400_accel_event,			\
+	.num_event_specs = ARRAY_SIZE(bma400_accel_event)	\
 }
 
 #define BMA400_ACTIVITY_CHANNEL(_chan2) {	\
@@ -981,6 +1004,17 @@ static int bma400_read_event_config(struct iio_dev *indio_dev,
 	struct bma400_data *data = iio_priv(indio_dev);
 
 	switch (chan->type) {
+	case IIO_ACCEL:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			return FIELD_GET(BMA400_INT_GEN1_MSK,
+					 data->generic_event_en);
+		case IIO_EV_DIR_FALLING:
+			return FIELD_GET(BMA400_INT_GEN2_MSK,
+					 data->generic_event_en);
+		default:
+			return -EINVAL;
+		}
 	case IIO_STEPS:
 		return data->step_event_en;
 	case IIO_ACTIVITY:
@@ -1008,6 +1042,65 @@ static int bma400_steps_event_enable(struct bma400_data *data, int state)
 	return 0;
 }
 
+static int bma400_activity_event_en(struct bma400_data *data,
+				    enum iio_event_direction dir,
+				    int state)
+{
+	int ret, reg, msk, value, field_value;
+
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		reg = BMA400_GEN1INT_CONFIG0;
+		msk = BMA400_INT_GEN1_MSK;
+		value = 2;
+		set_mask_bits(&field_value, BMA400_INT_GEN1_MSK,
+			      FIELD_PREP(BMA400_INT_GEN1_MSK, state));
+		break;
+	case IIO_EV_DIR_FALLING:
+		reg = BMA400_GEN2INT_CONFIG0;
+		msk = BMA400_INT_GEN2_MSK;
+		value = 0;
+		set_mask_bits(&field_value, BMA400_INT_GEN2_MSK,
+			      FIELD_PREP(BMA400_INT_GEN2_MSK, state));
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Enabling all axis for interrupt evaluation */
+	ret = regmap_write(data->regmap, reg, 0xF8);
+	if (ret)
+		return ret;
+
+	/* OR combination of all axis for interrupt evaluation */
+	ret = regmap_write(data->regmap, reg + BMA400_GEN_CONFIG1_OFF, value);
+	if (ret)
+		return ret;
+
+	/* Initial value to avoid interrupts while enabling*/
+	ret = regmap_write(data->regmap, reg + BMA400_GEN_CONFIG2_OFF, 0x0A);
+	if (ret)
+		return ret;
+
+	/* Initial duration value to avoid interrupts while enabling*/
+	ret = regmap_write(data->regmap, reg + BMA400_GEN_CONFIG31_OFF, 0x0F);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(data->regmap, BMA400_INT1_MAP_REG, msk,
+				 field_value);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(data->regmap, BMA400_INT_CONFIG0_REG, msk,
+				 field_value);
+	if (ret)
+		return ret;
+
+	set_mask_bits(&data->generic_event_en, msk, field_value);
+	return 0;
+}
+
 static int bma400_write_event_config(struct iio_dev *indio_dev,
 				     const struct iio_chan_spec *chan,
 				     enum iio_event_type type,
@@ -1017,6 +1110,11 @@ static int bma400_write_event_config(struct iio_dev *indio_dev,
 	int ret;
 
 	switch (chan->type) {
+	case IIO_ACCEL:
+		mutex_lock(&data->mutex);
+		ret = bma400_activity_event_en(data, dir, state);
+		mutex_unlock(&data->mutex);
+		return ret;
 	case IIO_STEPS:
 		mutex_lock(&data->mutex);
 		ret = bma400_steps_event_enable(data, state);
@@ -1039,6 +1137,122 @@ static int bma400_write_event_config(struct iio_dev *indio_dev,
 	}
 }
 
+static int get_gen_config_reg(enum iio_event_direction dir)
+{
+	switch (dir) {
+	case IIO_EV_DIR_FALLING:
+		return BMA400_GEN2INT_CONFIG0;
+	case IIO_EV_DIR_RISING:
+		return BMA400_GEN1INT_CONFIG0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int bma400_read_event_value(struct iio_dev *indio_dev,
+				   const struct iio_chan_spec *chan,
+				   enum iio_event_type type,
+				   enum iio_event_direction dir,
+				   enum iio_event_info info,
+				   int *val, int *val2)
+{
+	struct bma400_data *data = iio_priv(indio_dev);
+	int ret, reg;
+
+	switch (chan->type) {
+	case IIO_ACCEL:
+		reg = get_gen_config_reg(dir);
+		if (reg < 0)
+			return -EINVAL;
+
+		*val2 = 0;
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			ret = regmap_read(data->regmap,
+					  reg + BMA400_GEN_CONFIG2_OFF,
+					  val);
+			if (ret)
+				return ret;
+			return IIO_VAL_INT;
+		case IIO_EV_INFO_PERIOD:
+			mutex_lock(&data->mutex);
+			ret = regmap_bulk_read(data->regmap,
+					       reg + BMA400_GEN_CONFIG3_OFF,
+					       &data->duration,
+					       sizeof(data->duration));
+			if (ret) {
+				mutex_unlock(&data->mutex);
+				return ret;
+			}
+			*val = be16_to_cpu(data->duration);
+			mutex_unlock(&data->mutex);
+			return IIO_VAL_INT;
+		case IIO_EV_INFO_HYSTERESIS:
+			ret = regmap_read(data->regmap, reg, val);
+			if (ret)
+				return ret;
+			*val = FIELD_GET(BMA400_GEN_HYST_MSK, *val);
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int bma400_write_event_value(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir,
+				    enum iio_event_info info,
+				    int val, int val2)
+{
+	struct bma400_data *data = iio_priv(indio_dev);
+	int reg, ret;
+
+	switch (chan->type) {
+	case IIO_ACCEL:
+		reg = get_gen_config_reg(dir);
+		if (reg < 0)
+			return -EINVAL;
+
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			if (val < 1 || val > 255)
+				return -EINVAL;
+
+			return regmap_write(data->regmap,
+					    reg + BMA400_GEN_CONFIG2_OFF,
+					    val);
+		case IIO_EV_INFO_PERIOD:
+			if (val < 1 || val > 65535)
+				return -EINVAL;
+
+			mutex_lock(&data->mutex);
+			put_unaligned_be16(val, &data->duration);
+			ret = regmap_bulk_write(data->regmap,
+						reg + BMA400_GEN_CONFIG3_OFF,
+						&data->duration,
+						sizeof(data->duration));
+			mutex_unlock(&data->mutex);
+			return ret;
+		case IIO_EV_INFO_HYSTERESIS:
+			if (val < 0 || val > 3)
+				return -EINVAL;
+
+			return regmap_update_bits(data->regmap, reg,
+						  BMA400_GEN_HYST_MSK,
+						  FIELD_PREP(BMA400_GEN_HYST_MSK,
+							     val));
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
 static int bma400_data_rdy_trigger_set_state(struct iio_trigger *trig,
 					     bool state)
 {
@@ -1071,6 +1285,8 @@ static const struct iio_info bma400_info = {
 	.write_raw_get_fmt = bma400_write_raw_get_fmt,
 	.read_event_config = bma400_read_event_config,
 	.write_event_config = bma400_write_event_config,
+	.write_event_value = bma400_write_event_value,
+	.read_event_value = bma400_read_event_value,
 };
 
 static const struct iio_trigger_ops bma400_trigger_ops = {
@@ -1119,7 +1335,7 @@ static irqreturn_t bma400_interrupt(int irq, void *private)
 	struct iio_dev *indio_dev = private;
 	struct bma400_data *data = iio_priv(indio_dev);
 	s64 timestamp = iio_get_time_ns(indio_dev);
-	unsigned int act;
+	unsigned int act, ev_dir = IIO_EV_DIR_NONE;
 	int ret;
 
 	/* Lock to protect the data->status */
@@ -1134,6 +1350,20 @@ static irqreturn_t bma400_interrupt(int irq, void *private)
 	if (ret || !data->status)
 		goto unlock_err;
 
+	if (FIELD_GET(BMA400_INT_GEN1_MSK, le16_to_cpu(data->status)))
+		ev_dir = IIO_EV_DIR_RISING;
+
+	if (FIELD_GET(BMA400_INT_GEN2_MSK, le16_to_cpu(data->status)))
+		ev_dir = IIO_EV_DIR_FALLING;
+
+	if (ev_dir != IIO_EV_DIR_NONE) {
+		iio_push_event(indio_dev,
+			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+						  IIO_MOD_X_OR_Y_OR_Z,
+						  IIO_EV_TYPE_MAG, ev_dir),
+			       timestamp);
+	}
+
 	if (FIELD_GET(BMA400_STEP_STAT_MASK, le16_to_cpu(data->status))) {
 		iio_push_event(indio_dev,
 			       IIO_MOD_EVENT_CODE(IIO_STEPS, 0, IIO_NO_MOD,
-- 
2.17.1

