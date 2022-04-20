Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F145091E0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 23:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382376AbiDTVOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 17:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382429AbiDTVOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 17:14:25 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5427748895;
        Wed, 20 Apr 2022 14:11:29 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id h1so3080908pfv.12;
        Wed, 20 Apr 2022 14:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KDtBCxBd42917rOqXMzoKh0kTGTy3MMplQzqh97uOrE=;
        b=leVno3F6MPxz3zgD389/T6skxK3PYaLyvgJUy1oT1/Posuzcdj5K6P7LnrKB8WrVlr
         FSF1gdIOeFqlHFXQDHU1QLI8km40OLkGoYJEbcUac/IGVSQSISX2yh5/tE5IxnEKhXvA
         vInoy3zWdYc830thx/jpIJsa0UAzclRxOhSgbP0iMwyjAJZARMRdVvXpni/aDiasuZtW
         QvwN1ka3xhQFaHXEv73EQY/5+8k0tWPvX5a/V4trd90Mm2Ofx+6LscPCWiCuSjiA8GT5
         VqVuXkhymubn5/JFOoDDUdr3/7+0Rrj5TgiskoUv9LioMCrE1o9fro9CYRuc3n1AvAFe
         Qqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KDtBCxBd42917rOqXMzoKh0kTGTy3MMplQzqh97uOrE=;
        b=d+tbEogarwb8owRbRI8AMEacb2mFT2e136E+PmuyDMX0A5Y1GgckjmR8sAOJ9NCJ+a
         7JQY7GP0MnLT9XebnfbL7KozGaTyHrIx3Zz04c9YzGyxc5fhmBuURnn6Z4nveIDv1/1X
         Ct80OQQ3b22fH7A+xCa2GQslSWyD5LlXsN+97kTZvrWLLS9avL+94U3DjHXWBA074Iq3
         Ink8rO6w9YyG3xdUscT5A15S3Fi45eUz9eDd3WgYW6KCudGn4wTHNziaUzEIsrdB9hHZ
         pH7vVDFE9QuENy7u1E10lbBUiEKtTaWouQJP9AcCksSpNSAlbwJUkLxHP2hbCqtBZ7Ys
         6LGQ==
X-Gm-Message-State: AOAM5324s7d29XOEYJq2wwbsov5H5GaOhfg90dIxFUkoN0YwpzacTKj5
        +qtip+9uMi3WqGyxNfUKTD4=
X-Google-Smtp-Source: ABdhPJx/ZihlUfA4rHRIIlAi5Giz+e3/2dkMI55BqgXciW2x8svo92/tzsdDz+qCsaLYDn3AXOzAHA==
X-Received: by 2002:a63:5007:0:b0:3aa:1670:e327 with SMTP id e7-20020a635007000000b003aa1670e327mr12742585pgb.124.1650489088522;
        Wed, 20 Apr 2022 14:11:28 -0700 (PDT)
Received: from localhost.localdomain ([27.7.104.83])
        by smtp.gmail.com with ESMTPSA id v13-20020a17090a00cd00b001cd4989fee4sm106652pjd.48.2022.04.20.14.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 14:11:28 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     dan@dlrobertson.com, jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 9/9] iio: accel: bma400: Add support for activity and inactivity events
Date:   Thu, 21 Apr 2022 02:41:05 +0530
Message-Id: <20220420211105.14654-10-jagathjog1996@gmail.com>
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

Add support for activity and inactivity events for all axis based on the
threshold, duration and hysteresis value set from the userspace. INT1 pin
is used to interrupt and event is pushed to userspace.

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 drivers/iio/accel/bma400.h      |  11 ++
 drivers/iio/accel/bma400_core.c | 217 ++++++++++++++++++++++++++++++++
 2 files changed, 228 insertions(+)

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
index 5b1b28972ef9..792336b3b9ca 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -80,6 +80,7 @@ struct bma400_data {
 	int steps_enabled;
 	bool step_event_en;
 	bool activity_event_en;
+	unsigned int generic_event_en;
 	/* Correct time stamp alignment */
 	struct {
 		__le16 buff[3];
@@ -87,6 +88,7 @@ struct bma400_data {
 		s64 ts __aligned(8);
 	} buffer ____cacheline_aligned;
 	__le16 status;
+	__be16 duration;
 };
 
 static bool bma400_is_writable_reg(struct device *dev, unsigned int reg)
@@ -190,6 +192,25 @@ static const struct iio_event_spec bma400_activity_event = {
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
@@ -209,6 +230,8 @@ static const struct iio_event_spec bma400_activity_event = {
 		.storagebits = 16,	\
 		.endianness = IIO_LE,	\
 	},				\
+	.event_spec = bma400_accel_event,			\
+	.num_event_specs = ARRAY_SIZE(bma400_accel_event)	\
 }
 
 #define BMA400_ACTIVITY_CHANNEL(_chan2) {	\
@@ -972,6 +995,17 @@ static int bma400_read_event_config(struct iio_dev *indio_dev,
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
@@ -999,6 +1033,63 @@ static int bma400_steps_event_enable(struct bma400_data *data, int state)
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
+		field_value = FIELD_PREP(msk, state);
+		break;
+	case IIO_EV_DIR_FALLING:
+		reg = BMA400_GEN2INT_CONFIG0;
+		msk = BMA400_INT_GEN2_MSK;
+		value = 0;
+		field_value = FIELD_PREP(msk, state);
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
@@ -1008,6 +1099,11 @@ static int bma400_write_event_config(struct iio_dev *indio_dev,
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
@@ -1030,6 +1126,108 @@ static int bma400_write_event_config(struct iio_dev *indio_dev,
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
+	reg = get_gen_config_reg(dir);
+	if (reg < 0)
+		return -EINVAL;
+
+	*val2 = 0;
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		ret = regmap_read(data->regmap, reg + BMA400_GEN_CONFIG2_OFF,
+				  val);
+		if (ret)
+			return ret;
+		return IIO_VAL_INT;
+	case IIO_EV_INFO_PERIOD:
+		mutex_lock(&data->mutex);
+		ret = regmap_bulk_read(data->regmap,
+				       reg + BMA400_GEN_CONFIG3_OFF,
+				       &data->duration, sizeof(data->duration));
+		if (ret) {
+			mutex_unlock(&data->mutex);
+			return ret;
+		}
+		*val = be16_to_cpu(data->duration);
+		mutex_unlock(&data->mutex);
+		return IIO_VAL_INT;
+	case IIO_EV_INFO_HYSTERESIS:
+		ret = regmap_read(data->regmap, reg, val);
+		if (ret)
+			return ret;
+		*val = FIELD_GET(BMA400_GEN_HYST_MSK, *val);
+		return IIO_VAL_INT;
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
+	reg = get_gen_config_reg(dir);
+	if (reg < 0)
+		return -EINVAL;
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		if (val < 1 || val > 255)
+			return -EINVAL;
+
+		return regmap_write(data->regmap, reg + BMA400_GEN_CONFIG2_OFF,
+				    val);
+	case IIO_EV_INFO_PERIOD:
+		if (val < 1 || val > 65535)
+			return -EINVAL;
+
+		mutex_lock(&data->mutex);
+		put_unaligned_be16(val, &data->duration);
+		ret = regmap_bulk_write(data->regmap,
+					reg + BMA400_GEN_CONFIG3_OFF,
+					&data->duration,
+					sizeof(data->duration));
+		mutex_unlock(&data->mutex);
+		return ret;
+	case IIO_EV_INFO_HYSTERESIS:
+		if (val < 0 || val > 3)
+			return -EINVAL;
+
+		return regmap_update_bits(data->regmap, reg,
+					  BMA400_GEN_HYST_MSK,
+					  FIELD_PREP(BMA400_GEN_HYST_MSK, val));
+	default:
+		return -EINVAL;
+	}
+}
+
 static int bma400_debugfs_reg_access(struct iio_dev *indio_dev,
 				     unsigned int reg,
 				     unsigned int writeval,
@@ -1074,6 +1272,8 @@ static const struct iio_info bma400_info = {
 	.read_event_config = bma400_read_event_config,
 	.write_event_config = bma400_write_event_config,
 	.debugfs_reg_access = bma400_debugfs_reg_access,
+	.write_event_value = bma400_write_event_value,
+	.read_event_value = bma400_read_event_value,
 };
 
 static const struct iio_trigger_ops bma400_trigger_ops = {
@@ -1122,6 +1322,7 @@ static irqreturn_t bma400_interrupt(int irq, void *private)
 	s64 timestamp = iio_get_time_ns(indio_dev);
 	int ret;
 	unsigned int act;
+	unsigned int ev_dir = IIO_EV_DIR_NONE;
 
 	/* Lock to protect the data->status */
 	mutex_lock(&data->mutex);
@@ -1131,6 +1332,22 @@ static irqreturn_t bma400_interrupt(int irq, void *private)
 	if (ret)
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
+		mutex_unlock(&data->mutex);
+		return IRQ_HANDLED;
+	}
+
 	if (FIELD_GET(BMA400_STEP_STAT_MASK, le16_to_cpu(data->status))) {
 		iio_push_event(indio_dev,
 			       IIO_EVENT_CODE(IIO_STEPS, 0, IIO_NO_MOD,
-- 
2.17.1

