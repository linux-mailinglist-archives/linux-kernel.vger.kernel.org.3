Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDFBF536F43
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 06:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiE2ECI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 00:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiE2ECE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 00:02:04 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4A56CF65;
        Sat, 28 May 2022 21:02:02 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id n18so7526244plg.5;
        Sat, 28 May 2022 21:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kMXAc34hEBnjIs80cOhwT7dVsueCAXO4vm2iEmhxDiY=;
        b=K2vB2Dviq1hFElAVknQ5hY2X2LMFgSopCxt2mKNS5RQwGCTDm8tZgLbqEgUKPLKYZJ
         qFie7mxVPhd/nZD2jA9hRp+bJxEyTcpeh63GFGi66JnLbyzsRkrfbcL4PR18Tg2nFPQf
         zmmCRplc+ejxdSQPlifwch2O9hp15z6UGz37/E2bBVAC0ZVPu1RQ9yGLohkIt13UKqGs
         7JuTk94r0wCjkzEtov8ibVP6bLXWzwu89cB+YJW7lFygAH4iafkXyqVM4vOiVxaZRS13
         iGsLo1Xf6WgS09400Ls0KCvchPD8u1sAHtEff+n1ZRpCLSsUDSsEOOcmG1t/no5tyxpH
         QPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kMXAc34hEBnjIs80cOhwT7dVsueCAXO4vm2iEmhxDiY=;
        b=2uqwgoRqwCwUpX6BBHyWRbXFSvdftvnAaoXr3pQW1ZnuNc/dfb0NogKiT1aBOkiO9e
         Z6OB9txuL4PRUzPf+2t1KKbP62DxRYeM1SEokKf7IACSd/jO9JtEZTLzjbHimRSSQnFs
         l6GoCmzVBBIlcmu04WDvLVdNnhpCpL5PaqMV12kYO5qrm0xeYj3ZXvCUBam7MSelAMRJ
         YgqaGpMU9txesq4aZ2TWGh8MgsRja88ICek+B/YJzhMby2Z4Qo4Ok20Byl4H7I6qXdHl
         Q1pPzFFF8KrRbZ4Khwp7fD6h3MSnwrfBOnhYQ36uCkg34cqkrBFjkr36INTOSpJVPesu
         4ELQ==
X-Gm-Message-State: AOAM533DX3Bbxza/sQ+2j7QjvAHDGnbYIB+2wDCJitshb1dXwvYOpMCv
        GgHApsMoRNquDVPJ7ljEMDw=
X-Google-Smtp-Source: ABdhPJyDhNqFPGe11DEW0rFryMXlWtr1fPGiuCGeDVWTQC0BRkF66dp+3SLHpMj4RryT9Wg7/Bd+Qg==
X-Received: by 2002:a17:902:dad1:b0:161:a747:f962 with SMTP id q17-20020a170902dad100b00161a747f962mr50929394plx.32.1653796921671;
        Sat, 28 May 2022 21:02:01 -0700 (PDT)
Received: from localhost.localdomain ([115.99.139.145])
        by smtp.gmail.com with ESMTPSA id z7-20020a634c07000000b003fbfe88be17sm377581pga.24.2022.05.28.21.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 May 2022 21:02:01 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC 2/2] iio: accel: bma400: Add support for single and double tap events
Date:   Sun, 29 May 2022 09:31:53 +0530
Message-Id: <20220529040153.4878-3-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220529040153.4878-1-jagathjog1996@gmail.com>
References: <20220529040153.4878-1-jagathjog1996@gmail.com>
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
 drivers/iio/accel/bma400_core.c | 186 ++++++++++++++++++++++++++++++--
 2 files changed, 188 insertions(+), 9 deletions(-)

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
index 517920400df1..2385883707f2 100644
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
@@ -216,6 +217,19 @@ static const struct iio_event_spec bma400_accel_event[] = {
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
 };
 
 #define BMA400_ACC_CHANNEL(_index, _axis) { \
@@ -407,6 +421,14 @@ static int bma400_set_accel_output_data_rate(struct bma400_data *data,
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
@@ -1012,6 +1034,10 @@ static int bma400_read_event_config(struct iio_dev *indio_dev,
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
@@ -1101,6 +1127,74 @@ static int bma400_activity_event_en(struct bma400_data *data,
 	return 0;
 }
 
+static int bma400_tap_event_enable(struct bma400_data *data,
+				   enum iio_event_direction dir, int state)
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
@@ -1111,10 +1205,20 @@ static int bma400_write_event_config(struct iio_dev *indio_dev,
 
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
+			ret = bma400_tap_event_enable(data, dir, state);
+			mutex_unlock(&data->mutex);
+			return ret;
+		default:
+			return -EINVAL;
+		}
 	case IIO_STEPS:
 		mutex_lock(&data->mutex);
 		ret = bma400_steps_event_enable(data, state);
@@ -1159,8 +1263,8 @@ static int bma400_read_event_value(struct iio_dev *indio_dev,
 	struct bma400_data *data = iio_priv(indio_dev);
 	int ret, reg;
 
-	switch (chan->type) {
-	case IIO_ACCEL:
+	switch (type) {
+	case IIO_EV_TYPE_MAG:
 		reg = get_gen_config_reg(dir);
 		if (reg < 0)
 			return -EINVAL;
@@ -1196,6 +1300,25 @@ static int bma400_read_event_value(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
+	case IIO_EV_TYPE_GESTURE:
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			ret = regmap_read(data->regmap,
+					  BMA400_TAP_CONFIG, val);
+			if (ret)
+				return ret;
+			*val = FIELD_GET(BMA400_TAP_SEN_MSK, *val);
+			return IIO_VAL_INT;
+		case IIO_EV_INFO_PERIOD:
+			ret = regmap_read(data->regmap,
+					  BMA400_TAP_CONFIG1, val);
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
@@ -1211,8 +1334,8 @@ static int bma400_write_event_value(struct iio_dev *indio_dev,
 	struct bma400_data *data = iio_priv(indio_dev);
 	int reg, ret;
 
-	switch (chan->type) {
-	case IIO_ACCEL:
+	switch (type) {
+	case IIO_EV_TYPE_MAG:
 		reg = get_gen_config_reg(dir);
 		if (reg < 0)
 			return -EINVAL;
@@ -1228,7 +1351,6 @@ static int bma400_write_event_value(struct iio_dev *indio_dev,
 		case IIO_EV_INFO_PERIOD:
 			if (val < 1 || val > 65535)
 				return -EINVAL;
-
 			mutex_lock(&data->mutex);
 			put_unaligned_be16(val, &data->duration);
 			ret = regmap_bulk_write(data->regmap,
@@ -1248,6 +1370,30 @@ static int bma400_write_event_value(struct iio_dev *indio_dev,
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
@@ -1350,6 +1496,28 @@ static irqreturn_t bma400_interrupt(int irq, void *private)
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
+		ev_dir = IIO_EV_DIR_SINGLETAP;
+
+	if (FIELD_GET(BMA400_INT_D_TAP_MSK, le16_to_cpu(data->status)))
+		ev_dir = IIO_EV_DIR_DOUBLETAP;
+
+	if (ev_dir != IIO_EV_DIR_NONE) {
+		iio_push_event(indio_dev,
+			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+						  IIO_MOD_X_OR_Y_OR_Z,
+						  IIO_EV_TYPE_GESTURE, ev_dir),
+			       timestamp);
+	}
+
+	ev_dir = IIO_EV_DIR_NONE;
 	if (FIELD_GET(BMA400_INT_GEN1_MSK, le16_to_cpu(data->status)))
 		ev_dir = IIO_EV_DIR_RISING;
 
-- 
2.17.1

