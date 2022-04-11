Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514384FC5CA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 22:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349912AbiDKUei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 16:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349919AbiDKUeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 16:34:22 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDE535DF3;
        Mon, 11 Apr 2022 13:31:59 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id c23so14910560plo.0;
        Mon, 11 Apr 2022 13:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TNR6m2F5BA/dkBi52W/20O0Hx4jKoOJlRkDptGmhUvM=;
        b=NIZObOZzcgdc5Sz2SVnkSusjvAjS/KQpT+CQsBfpemxwOKldl0+WhuXX1OOuc2XCOG
         r5ns5VGGt80MdeWs4I5GpbyYSjHJh3Fydbhb556BK6WSlY2phfuVZoWO3xEbgPZkXTcV
         OdTuXjOZjq9aeAGAYTn1SQ77kAhSJC1vul3xu1j4xJlsrXY3ncecnUy62BvT9FYyrOV9
         V13CB58zxF3rEzJK67K6ifBnEOjaA7pStvwGB5xJlzb2QS+d3pcbvfGOCpZ3P3bDRa7n
         IclM9o1HqJ0Z0/yeVzjUyOc0OUx40Rp5HbsD2PjbDcfEF4eyqUrf9QzJ09hql470lz4/
         AKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TNR6m2F5BA/dkBi52W/20O0Hx4jKoOJlRkDptGmhUvM=;
        b=kC8ApzIc/eHXQ7SA/7oAjQ8VfbMfosYay8YMbH6vJLHtCIyjNP/Lyng0WHAIPv6cxc
         WBcgxMyAgTTs5mSRbiW2t1g+8bVNJpcAqvE0LeTOIs8qZrN8KgwRj8OBmD4E1YeEtEaf
         Qw1A4nPPW+RqdCoNulXK5CyA66ilaswE1lKXO/hFbPQdmOM+khOPGYh252d4MCf6qp/w
         JmRcuXgTZU+WVNWf+ogeAXvDDkmub9KlYPySuvVhsr2HLApDPeqpik/YQiYec73k9Vby
         0K28oSZP8XkPCh66l4693ILwaD0VS6jRYaXj08Fo3xGCVuPLe0KR0ax7hCnQgOtWQliD
         TVyg==
X-Gm-Message-State: AOAM533zvlYls3M+RyYPqQkvLYvMs8XNKLs4o3sSjJKn5eOJ6mKN/ASv
        yyrRCXL6KHaSwIn8iltXIkwoCLH+ZHo=
X-Google-Smtp-Source: ABdhPJyWwZMa6oNsQKkhJPysfDUiaKpCsh8QqxbGdOoN6U3QXGjQxdWaqSdtZWTyY4HoLYeigsWXLw==
X-Received: by 2002:a17:90b:1b4e:b0:1c6:fff4:34dc with SMTP id nv14-20020a17090b1b4e00b001c6fff434dcmr1052267pjb.76.1649709119253;
        Mon, 11 Apr 2022 13:31:59 -0700 (PDT)
Received: from localhost.localdomain ([27.7.99.112])
        by smtp.gmail.com with ESMTPSA id z15-20020a056a001d8f00b004fda37855ddsm34069828pfw.168.2022.04.11.13.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 13:31:58 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     dan@dlrobertson.com, jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 9/9] iio: accel: bma400: Add support for activity and inactivity events
Date:   Tue, 12 Apr 2022 02:01:33 +0530
Message-Id: <20220411203133.19929-10-jagathjog1996@gmail.com>
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

Add support for activity and inactivity events for all axis based on the
threshold, duration and hysteresis value set from the userspace. INT1 pin
is used to interrupt and event is pushed to userspace.

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 drivers/iio/accel/bma400.h      |  11 ++
 drivers/iio/accel/bma400_core.c | 229 ++++++++++++++++++++++++++++++++
 2 files changed, 240 insertions(+)

diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
index bc4641279be3..cbf8035c817e 100644
--- a/drivers/iio/accel/bma400.h
+++ b/drivers/iio/accel/bma400.h
@@ -93,6 +93,17 @@
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
index b6c79cfabaa4..226a5f63d1a6 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -79,6 +79,7 @@ struct bma400_data {
 	int steps_enabled;
 	bool step_event_en;
 	bool activity_event_en;
+	u8 generic_event_en;
 	/* Correct time stamp alignment */
 	struct {
 		__le16 buff[3];
@@ -188,6 +189,25 @@ static const struct iio_event_spec bma400_activity_event = {
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
@@ -207,6 +227,8 @@ static const struct iio_event_spec bma400_activity_event = {
 		.storagebits = 16,	\
 		.endianness = IIO_LE,	\
 	},				\
+	.event_spec = bma400_accel_event,			\
+	.num_event_specs = ARRAY_SIZE(bma400_accel_event)	\
 }
 
 #define BMA400_ACTIVITY_CHANNEL(_chan2) {	\
@@ -954,6 +976,17 @@ static int bma400_read_event_config(struct iio_dev *indio_dev,
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
@@ -970,8 +1003,74 @@ static int bma400_write_event_config(struct iio_dev *indio_dev,
 {
 	int ret;
 	struct bma400_data *data = iio_priv(indio_dev);
+	int reg, msk, value, field_value;
 
 	switch (chan->type) {
+	case IIO_ACCEL:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			reg = BMA400_GEN1INT_CONFIG0;
+			msk = BMA400_INT_GEN1_MSK;
+			value = 2;
+			field_value = FIELD_PREP(BMA400_INT_GEN1_MSK, state);
+			break;
+		case IIO_EV_DIR_FALLING:
+			reg = BMA400_GEN2INT_CONFIG0;
+			msk = BMA400_INT_GEN2_MSK;
+			value = 0;
+			field_value = FIELD_PREP(BMA400_INT_GEN2_MSK, state);
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		mutex_lock(&data->mutex);
+		/* Enabling all axis for interrupt evaluation */
+		ret = regmap_write(data->regmap, reg, 0xF8);
+		if (ret) {
+			mutex_unlock(&data->mutex);
+			return ret;
+		}
+
+		/* OR combination of all axis for interrupt evaluation */
+		ret = regmap_write(data->regmap, reg + BMA400_GEN_CONFIG1_OFF,
+				   value);
+		if (ret) {
+			mutex_unlock(&data->mutex);
+			return ret;
+		}
+
+		/* Initial value to avoid interrupts while enabling*/
+		ret = regmap_write(data->regmap, reg + BMA400_GEN_CONFIG2_OFF,
+				   0x0A);
+		if (ret) {
+			mutex_unlock(&data->mutex);
+			return ret;
+		}
+
+		/* Initial duration value to avoid interrupts while enabling*/
+		ret = regmap_write(data->regmap, reg + BMA400_GEN_CONFIG31_OFF,
+				   0x0F);
+		if (ret) {
+			mutex_unlock(&data->mutex);
+			return ret;
+		}
+
+		ret = regmap_update_bits(data->regmap, BMA400_INT1_MAP_REG,
+					 msk, field_value);
+		if (ret) {
+			mutex_unlock(&data->mutex);
+			return ret;
+		}
+
+		ret = regmap_update_bits(data->regmap, BMA400_INT_CONFIG0_REG,
+					 msk, field_value);
+		mutex_unlock(&data->mutex);
+		if (ret)
+			return ret;
+
+		set_mask_bits(&data->generic_event_en, msk, field_value);
+		return 0;
 	case IIO_STEPS:
 		mutex_lock(&data->mutex);
 		if (!data->steps_enabled) {
@@ -1028,6 +1127,118 @@ static int bma400_write_event_config(struct iio_dev *indio_dev,
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
+	int ret;
+	u8 reg, duration[2];
+
+	reg = get_gen_config_reg(dir);
+	if (reg < 0)
+		return -EINVAL;
+
+	*val2 = 0;
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		mutex_lock(&data->mutex);
+		ret = regmap_read(data->regmap, reg + BMA400_GEN_CONFIG2_OFF,
+				  val);
+		mutex_unlock(&data->mutex);
+		if (ret)
+			return ret;
+		return IIO_VAL_INT;
+	case IIO_EV_INFO_PERIOD:
+		mutex_lock(&data->mutex);
+		ret = regmap_bulk_read(data->regmap,
+				       reg + BMA400_GEN_CONFIG3_OFF,
+				       duration, sizeof(duration));
+		mutex_unlock(&data->mutex);
+		if (ret)
+			return ret;
+		*val = get_unaligned_be16(duration);
+		return IIO_VAL_INT;
+	case IIO_EV_INFO_HYSTERESIS:
+		mutex_lock(&data->mutex);
+		ret = regmap_read(data->regmap, reg, val);
+		mutex_unlock(&data->mutex);
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
+	int ret;
+	u8 reg, duration[2];
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
+		mutex_lock(&data->mutex);
+		ret = regmap_write(data->regmap, reg + BMA400_GEN_CONFIG2_OFF,
+				   val);
+		mutex_unlock(&data->mutex);
+		return ret;
+	case IIO_EV_INFO_PERIOD:
+		if (val < 1 || val > 65535)
+			return -EINVAL;
+
+		put_unaligned_be16(val, duration);
+
+		mutex_lock(&data->mutex);
+		ret = regmap_bulk_write(data->regmap,
+					reg + BMA400_GEN_CONFIG3_OFF,
+					duration, sizeof(duration));
+		mutex_unlock(&data->mutex);
+		return ret;
+	case IIO_EV_INFO_HYSTERESIS:
+		if (val < 0 || val > 3)
+			return -EINVAL;
+
+		mutex_lock(&data->mutex);
+		ret = regmap_update_bits(data->regmap, reg,
+					 BMA400_GEN_HYST_MSK,
+					 FIELD_PREP(BMA400_GEN_HYST_MSK, val));
+		mutex_unlock(&data->mutex);
+		return ret;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int bma400_debugfs_reg_access(struct iio_dev *indio_dev,
 				     unsigned int reg,
 				     unsigned int writeval,
@@ -1076,6 +1287,8 @@ static const struct iio_info bma400_info = {
 	.read_event_config = bma400_read_event_config,
 	.write_event_config = bma400_write_event_config,
 	.debugfs_reg_access = bma400_debugfs_reg_access,
+	.write_event_value = bma400_write_event_value,
+	.read_event_value = bma400_read_event_value,
 };
 
 static const struct iio_trigger_ops bma400_trigger_ops = {
@@ -1120,6 +1333,7 @@ static irqreturn_t bma400_interrupt(int irq, void *private)
 	int ret;
 	__le16 status;
 	unsigned int act;
+	unsigned int ev_dir = IIO_EV_DIR_NONE;
 
 	mutex_lock(&data->mutex);
 	ret = regmap_bulk_read(data->regmap, BMA400_INT_STAT0_REG, &status,
@@ -1128,6 +1342,21 @@ static irqreturn_t bma400_interrupt(int irq, void *private)
 	if (ret)
 		return IRQ_NONE;
 
+	if (FIELD_GET(BMA400_INT_GEN1_MSK, le16_to_cpu(status)))
+		ev_dir = IIO_EV_DIR_RISING;
+
+	if (FIELD_GET(BMA400_INT_GEN2_MSK, le16_to_cpu(status)))
+		ev_dir = IIO_EV_DIR_FALLING;
+
+	if (ev_dir != IIO_EV_DIR_NONE) {
+		iio_push_event(indio_dev,
+			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+						  IIO_MOD_X_OR_Y_OR_Z,
+						  IIO_EV_TYPE_MAG, ev_dir),
+			       timestamp);
+		return IRQ_HANDLED;
+	}
+
 	if (FIELD_GET(BMA400_STEP_STAT_MASK, le16_to_cpu(status))) {
 		iio_push_event(indio_dev,
 			       IIO_EVENT_CODE(IIO_STEPS, 0, IIO_NO_MOD,
-- 
2.17.1

