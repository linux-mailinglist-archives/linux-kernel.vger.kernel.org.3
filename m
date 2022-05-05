Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E75E51C0E2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 15:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379764AbiEENfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 09:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379686AbiEENer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 09:34:47 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B63657121;
        Thu,  5 May 2022 06:30:51 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d22so4382279plr.9;
        Thu, 05 May 2022 06:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jTmj4puKmdVMk0iRfeIWNKKz6zyGpK0OFgQNQS/Qxw8=;
        b=MkeU5c0JkJJ2yJEpkTC2pquTM4atEOHGxLkxWaohMILQSAfkyCSXUYMdD1Xwv2GhT9
         kpdlQ0KlRJsgAorJo+fM2rk9xAliZxvLc7tdfwJFe1JiNtl5u/f/yA1esNya2y9b4KmA
         2k5Y2qwSPfepCQYBudXIe05zquCOdKD5kb4OIKk0n7GSWuJ7JhHD2mUf8XKyMK20dYan
         Ee2e3li7xYf3oYJWz7LRTiYWzBFivgnBSBdwrknvCUaJNPcaT1maalZnFoq/jp49hwIN
         odQnaXV8//AM3eLEeXzWU3jkItuPWqQ3f1bhx1hPVuZVc6QbomCMroswD722tqDkvEAp
         buBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jTmj4puKmdVMk0iRfeIWNKKz6zyGpK0OFgQNQS/Qxw8=;
        b=IV9fiv8lPeXSN6rqr0edIPcQPZVULg3vT6+rChE+n/uh5tpBLjCEtvAkN+GP/CHP9x
         hoJpD6gtoHW8TzroaDxKht3yRw+9ASco1bWAJWa6ka/GhLqqtAONpMhZZiiLbo+YJBHB
         ZfGMG5/GuoL/fp41IgGg6MAkeFHpK0Tm1P6V3bD3ELwPgbsNoNYe6xivmzeKTzlmV6F/
         WSW1sufWqn9mBrir7OKlu62y3yhwTVJEoEp0Ekfgcr3qFl0XFqhntUymb8EN+w4P/znb
         rgdHaJVOf+tyBHcIUn4hDCVw1qlY9m52x7BY5+0VBaMju/r9bTQK7qEFp/1v9qcmL502
         QVLg==
X-Gm-Message-State: AOAM533q49N7cxUIhc4VY2GQm8EUOL1qyyb3kj4DeoGJ5UU9UGzup0Et
        ehvXiR3bY+wIzWS125CJtsk=
X-Google-Smtp-Source: ABdhPJwMxjJA+pl9gvb9Hmxl0xJS8E+QM73zjEJyRUQuVFj1ICFkFEPq4Muf5xlEL0jimm3lLBwp0w==
X-Received: by 2002:a17:902:c946:b0:15e:9c09:715a with SMTP id i6-20020a170902c94600b0015e9c09715amr22958281pla.168.1651757450941;
        Thu, 05 May 2022 06:30:50 -0700 (PDT)
Received: from localhost.localdomain ([115.99.184.228])
        by smtp.gmail.com with ESMTPSA id c64-20020a624e43000000b0050dc7628135sm1420120pfb.15.2022.05.05.06.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 06:30:50 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     dan@dlrobertson.com, jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 10/10] iio: accel: bma400: Add support for single and double tap events
Date:   Thu,  5 May 2022 19:00:21 +0530
Message-Id: <20220505133021.22362-11-jagathjog1996@gmail.com>
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

Add support for single and double tap events based on the tap threshold
value and minimum quite time value between the taps. INT1 pin is used to
interrupt and event is pushed to userspace.

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 drivers/iio/accel/bma400.h      |  11 ++
 drivers/iio/accel/bma400_core.c | 176 ++++++++++++++++++++++++++++++++
 2 files changed, 187 insertions(+)

diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
index e8f802a82300..7331474433fa 100644
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
+#define BMA400_TAP_QUITE_MSK        GENMASK(3, 2)
+
 /*
  * BMA400_SCALE_MIN macro value represents m/s^2 for 1 LSB before
  * converting to micro values for +-2g range.
diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index 8faff72625b3..9d19a0afd683 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -88,6 +88,7 @@ struct bma400_data {
 	bool step_event_en;
 	bool activity_event_en;
 	unsigned int generic_event_en;
+	unsigned int tap_event_en;
 	/* Correct time stamp alignment */
 	struct {
 		__le16 buff[3];
@@ -187,6 +188,14 @@ static const struct iio_chan_spec_ext_info bma400_ext_info[] = {
 	{ }
 };
 
+static const struct iio_event_spec bma400_tap_event = {
+	.type = IIO_EV_TYPE_CHANGE,
+	.dir = IIO_EV_DIR_NONE,
+	.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+	.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
+			       BIT(IIO_EV_INFO_PERIOD),
+};
+
 static const struct iio_event_spec bma400_step_detect_event = {
 	.type = IIO_EV_TYPE_CHANGE,
 	.dir = IIO_EV_DIR_NONE,
@@ -251,6 +260,19 @@ static const struct iio_event_spec bma400_accel_event[] = {
 	.num_event_specs = 1,					\
 }
 
+/*
+ * Single Tap and Double Tap events needs to be captured instantly, so only
+ * events are being configured.
+ */
+#define BMA400_TAP_CHANNEL(_chan2) {		\
+	.type = IIO_TAP,			\
+	.modified = 1,				\
+	.channel2 = _chan2,			\
+	.scan_index = -1, /* No buffer support */		\
+	.event_spec = &bma400_tap_event,			\
+	.num_event_specs = 1,					\
+}
+
 static const struct iio_chan_spec bma400_channels[] = {
 	BMA400_ACC_CHANNEL(0, X),
 	BMA400_ACC_CHANNEL(1, Y),
@@ -278,6 +300,8 @@ static const struct iio_chan_spec bma400_channels[] = {
 	BMA400_ACTIVITY_CHANNEL(IIO_MOD_STILL),
 	BMA400_ACTIVITY_CHANNEL(IIO_MOD_WALKING),
 	BMA400_ACTIVITY_CHANNEL(IIO_MOD_RUNNING),
+	BMA400_TAP_CHANNEL(IIO_MOD_TAP_SINGLE),
+	BMA400_TAP_CHANNEL(IIO_MOD_TAP_DOUBLE),
 	IIO_CHAN_SOFT_TIMESTAMP(4),
 };
 
@@ -407,6 +431,14 @@ static int bma400_set_accel_output_data_rate(struct bma400_data *data,
 	unsigned int val;
 	int ret;
 
+	/*
+	 * No need to change ODR when tap event is enabled because
+	 * tap interrupt is operating with the data rate of 200Hz.
+	 * See datasheet page 124.
+	 */
+	if (data->tap_event_en)
+		return -EBUSY;
+
 	if (hz >= BMA400_ACC_ODR_MIN_WHOLE_HZ) {
 		if (uhz || hz > BMA400_ACC_ODR_MAX_HZ)
 			return -EINVAL;
@@ -1019,6 +1051,15 @@ static int bma400_read_event_config(struct iio_dev *indio_dev,
 		return data->step_event_en;
 	case IIO_ACTIVITY:
 		return data->activity_event_en;
+	case IIO_TAP:
+		switch (chan->channel2) {
+		case IIO_MOD_TAP_SINGLE:
+			return FIELD_GET(BMA400_S_TAP_MSK, data->tap_event_en);
+		case IIO_MOD_TAP_DOUBLE:
+			return FIELD_GET(BMA400_D_TAP_MSK, data->tap_event_en);
+		default:
+			return -EINVAL;
+		}
 	default:
 		return -EINVAL;
 	}
@@ -1101,6 +1142,74 @@ static int bma400_activity_event_en(struct bma400_data *data,
 	return 0;
 }
 
+static int bma400_tap_event_enable(struct bma400_data *data,
+				   enum iio_modifier mod, int state)
+{
+	int ret;
+	unsigned int mask, field_value;
+
+	if (data->power_mode == POWER_MODE_SLEEP)
+		return -EBUSY;
+
+	/*
+	 * acc_filt1 is the data source for the tap interrupt and it is
+	 * operating on an input data rate of 200Hz.
+	 */
+	if (!data->tap_event_en) {
+		ret = bma400_set_accel_output_data_rate(data, 200, 0);
+		if (ret)
+			return ret;
+	}
+
+	ret = regmap_update_bits(data->regmap, BMA400_INT12_MAP_REG,
+				 BMA400_S_TAP_MSK,
+				 FIELD_PREP(BMA400_S_TAP_MSK, state));
+	if (ret)
+		return ret;
+
+	switch (mod) {
+	case IIO_MOD_TAP_SINGLE:
+		mask = BMA400_S_TAP_MSK;
+		set_mask_bits(&field_value, BMA400_S_TAP_MSK,
+			      FIELD_PREP(BMA400_S_TAP_MSK, state));
+		break;
+	case IIO_MOD_TAP_DOUBLE:
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
+	return 0;
+}
+
 static int bma400_write_event_config(struct iio_dev *indio_dev,
 				     const struct iio_chan_spec *chan,
 				     enum iio_event_type type,
@@ -1132,6 +1241,11 @@ static int bma400_write_event_config(struct iio_dev *indio_dev,
 		data->activity_event_en = state;
 		mutex_unlock(&data->mutex);
 		return 0;
+	case IIO_TAP:
+		mutex_lock(&data->mutex);
+		ret = bma400_tap_event_enable(data, chan->channel2, state);
+		mutex_unlock(&data->mutex);
+		return ret;
 	default:
 		return -EINVAL;
 	}
@@ -1196,6 +1310,23 @@ static int bma400_read_event_value(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
+	case IIO_TAP:
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			ret = regmap_read(data->regmap, BMA400_TAP_CONFIG, val);
+			if (ret)
+				return ret;
+			*val = FIELD_GET(BMA400_TAP_SEN_MSK, *val);
+			return IIO_VAL_INT;
+		case IIO_EV_INFO_PERIOD:
+			ret = regmap_read(data->regmap, BMA400_TAP_CONFIG1, val);
+			if (ret)
+				return ret;
+			*val = FIELD_GET(BMA400_TAP_QUITE_MSK, *val);
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
 	default:
 		return -EINVAL;
 	}
@@ -1248,6 +1379,29 @@ static int bma400_write_event_value(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
+	case IIO_TAP:
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
+		case IIO_EV_INFO_PERIOD:
+			if (val < 0 || val > 3)
+				return -EINVAL;
+
+			return regmap_update_bits(data->regmap,
+						  BMA400_TAP_CONFIG1,
+						  BMA400_TAP_QUITE_MSK,
+						  FIELD_PREP(BMA400_TAP_QUITE_MSK,
+							     val));
+		default:
+			return -EINVAL;
+		}
 	default:
 		return -EINVAL;
 	}
@@ -1336,6 +1490,7 @@ static irqreturn_t bma400_interrupt(int irq, void *private)
 	struct bma400_data *data = iio_priv(indio_dev);
 	s64 timestamp = iio_get_time_ns(indio_dev);
 	unsigned int act, ev_dir = IIO_EV_DIR_NONE;
+	unsigned int ev_mod = IIO_NO_MOD;
 	int ret;
 
 	/* Lock to protect the data->status */
@@ -1350,6 +1505,27 @@ static irqreturn_t bma400_interrupt(int irq, void *private)
 	if (ret || !data->status)
 		goto unlock_err;
 
+	/* Disable all advance interrupts if interrupt engine overrun occurs */
+	if (FIELD_GET(BMA400_INT_ENG_OVRUN_MSK, le16_to_cpu(data->status))) {
+		bma400_disable_adv_interrupt(data);
+		dev_err(data->dev, "Interrupt engine overrun\n");
+		goto unlock_err;
+	}
+
+	if (FIELD_GET(BMA400_INT_S_TAP_MSK, le16_to_cpu(data->status)))
+		ev_mod = IIO_MOD_TAP_SINGLE;
+
+	if (FIELD_GET(BMA400_INT_D_TAP_MSK, le16_to_cpu(data->status)))
+		ev_mod = IIO_MOD_TAP_DOUBLE;
+
+	if (ev_mod != IIO_NO_MOD) {
+		iio_push_event(indio_dev,
+			       IIO_MOD_EVENT_CODE(IIO_TAP, 0,
+						  ev_mod, IIO_EV_TYPE_CHANGE,
+						  IIO_EV_DIR_NONE),
+			       timestamp);
+	}
+
 	if (FIELD_GET(BMA400_INT_GEN1_MSK, le16_to_cpu(data->status)))
 		ev_dir = IIO_EV_DIR_RISING;
 
-- 
2.17.1

