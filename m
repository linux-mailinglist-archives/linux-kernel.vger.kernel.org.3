Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861D04FC5D1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 22:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349907AbiDKUe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 16:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349885AbiDKUeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 16:34:13 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4884A36151;
        Mon, 11 Apr 2022 13:31:55 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id o5-20020a17090ad20500b001ca8a1dc47aso453060pju.1;
        Mon, 11 Apr 2022 13:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nVy+PdUdt3aYbmKl1De/O0IbA9jK9d4aWpuuU9JRDr0=;
        b=I0BOtu/NTUxum3tk1mDK4B4v9Tk/DOk/HjsgtA0CG0tELAoHcWuEID0q9kXAvPjvyY
         RTmxFA1WD68lC7h2hRvB+6kCo2D/Yu1/Z1jRmUIX+aexHC9ofI1nEFToFPMG/oW3LI5q
         q/D/Df0Z9xfri8lrhUBEnPaHWtK2IeEsn20NRI/zRhSTG3ZyZ+EnUpS5ipMt9aHfB5VU
         ZAg1mQuMOkAAg4dZTVMaj5qBR+n4/6WFRtmbd8Yc8zQidgWJXeglmvmuI+aMxi6gl1NG
         zX7zblPGjKEYlNlr4zj8XVsbxTx8n3VS1Ri4cOZbo4QW9/LLRARxYsdd6yUhKpVV257P
         Tamw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nVy+PdUdt3aYbmKl1De/O0IbA9jK9d4aWpuuU9JRDr0=;
        b=F8PxvsWGL/hKIYFnfYVtWRvKesp5OhuzO+CQN9/OZQPWjysWfD/TVWPRPBSzeu758r
         rhwriQYVyB7iMpalfAe5bGfIwcPWvXSDiKvzBhX51AWcmEI6lSw5Xk1Y/n7s7VpdL+Fs
         +Qg3a0J+WX8mmvvDMkxqQUEYSJ5P1S+yHpZt29o1dU/BuXBpYZPmq45yt18JZobmpOpp
         E/aFcP6BZlLo1oFBggOFcTp/44B82AqoWOmStWv1HpqrIYgVnXq0JiJOysECs+3mnkN7
         sI+ZBJaldjNpxOx5PpkWU5l4e/ZAo4sKD0noGCwiPj3gPSX4/SQWGZ4kygpmAG48jsgf
         SgOQ==
X-Gm-Message-State: AOAM530pY2ymPkQ0u5dgfp9a435ene+E6XwoPcazUbwdLV2n4iNtmmym
        PU1cEDgImGnHoRRSpGJVTP0=
X-Google-Smtp-Source: ABdhPJyspJIGql9cAc4QJC3lhh50NSLTb/oRc3xE/Arap4dWYLja8tYgSWYEAKrReNGd3RaPGq24oQ==
X-Received: by 2002:a17:902:ef46:b0:153:81f7:7fc2 with SMTP id e6-20020a170902ef4600b0015381f77fc2mr34343014plx.26.1649709114611;
        Mon, 11 Apr 2022 13:31:54 -0700 (PDT)
Received: from localhost.localdomain ([27.7.99.112])
        by smtp.gmail.com with ESMTPSA id z15-20020a056a001d8f00b004fda37855ddsm34069828pfw.168.2022.04.11.13.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 13:31:54 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     dan@dlrobertson.com, jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/9] iio: accel: bma400: Add activity recognition support
Date:   Tue, 12 Apr 2022 02:01:31 +0530
Message-Id: <20220411203133.19929-8-jagathjog1996@gmail.com>
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

Add support for activity recognition like STILL, WALKING, RUNNING
and these events are pushed to the userspace whenever the STEP
interrupt occurs.

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 drivers/iio/accel/bma400_core.c | 104 ++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index 37f38626a9aa..69d2caa4ed18 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -59,6 +59,12 @@ struct bma400_sample_freq {
 	int uhz;
 };
 
+enum bma400_activity {
+	BMA400_STILL,
+	BMA400_WALKING,
+	BMA400_RUNNING,
+};
+
 struct bma400_data {
 	struct device *dev;
 	struct regmap *regmap;
@@ -72,6 +78,7 @@ struct bma400_data {
 	struct iio_trigger *trig;
 	int steps_enabled;
 	bool step_event_en;
+	bool activity_event_en;
 	/* Correct time stamp alignment */
 	struct {
 		__le16 buff[3];
@@ -175,6 +182,12 @@ static const struct iio_event_spec bma400_step_detect_event = {
 	.mask_separate = BIT(IIO_EV_INFO_ENABLE),
 };
 
+static const struct iio_event_spec bma400_activity_event = {
+	.type = IIO_EV_TYPE_CHANGE,
+	.dir = IIO_EV_DIR_NONE,
+	.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE),
+};
+
 #define BMA400_ACC_CHANNEL(_index, _axis) { \
 	.type = IIO_ACCEL, \
 	.modified = 1, \
@@ -196,6 +209,16 @@ static const struct iio_event_spec bma400_step_detect_event = {
 	},				\
 }
 
+#define BMA400_ACTIVITY_CHANNEL(_chan2) {	\
+	.type = IIO_ACTIVITY,			\
+	.modified = 1,				\
+	.channel2 = _chan2,			\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),	\
+	.scan_index = -1, /* No buffer support */		\
+	.event_spec = &bma400_activity_event,			\
+	.num_event_specs = 1,					\
+}
+
 static const struct iio_chan_spec bma400_channels[] = {
 	BMA400_ACC_CHANNEL(0, X),
 	BMA400_ACC_CHANNEL(1, Y),
@@ -220,6 +243,9 @@ static const struct iio_chan_spec bma400_channels[] = {
 		.event_spec = &bma400_step_detect_event,
 		.num_event_specs = 1,
 	},
+	BMA400_ACTIVITY_CHANNEL(IIO_MOD_STILL),
+	BMA400_ACTIVITY_CHANNEL(IIO_MOD_WALKING),
+	BMA400_ACTIVITY_CHANNEL(IIO_MOD_RUNNING),
 	IIO_CHAN_SOFT_TIMESTAMP(4),
 };
 
@@ -626,6 +652,20 @@ static void bma400_power_disable(void *data_ptr)
 			 ERR_PTR(ret));
 }
 
+static enum iio_modifier bma400_act_to_mod(enum bma400_activity activity)
+{
+	switch (activity) {
+	case BMA400_STILL:
+		return IIO_MOD_STILL;
+	case BMA400_WALKING:
+		return IIO_MOD_WALKING;
+	case BMA400_RUNNING:
+		return IIO_MOD_RUNNING;
+	default:
+		return IIO_NO_MOD;
+	}
+}
+
 static int bma400_init(struct bma400_data *data)
 {
 	unsigned int val;
@@ -725,6 +765,7 @@ static int bma400_read_raw(struct iio_dev *indio_dev,
 	struct bma400_data *data = iio_priv(indio_dev);
 	int ret;
 	u8 steps_raw[3];
+	unsigned int activity;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_PROCESSED:
@@ -743,6 +784,23 @@ static int bma400_read_raw(struct iio_dev *indio_dev,
 				return ret;
 			*val = get_unaligned_le24(steps_raw);
 			return IIO_VAL_INT;
+		case IIO_ACTIVITY:
+			mutex_lock(&data->mutex);
+			ret = regmap_read(data->regmap, BMA400_STEP_STAT_REG,
+					  &activity);
+			mutex_unlock(&data->mutex);
+			if (ret)
+				return ret;
+			/*
+			 * The device does not support confidence value levels,
+			 * so we will always have 100% for current activity and
+			 * 0% for the others.
+			 */
+			if (chan->channel2 == bma400_act_to_mod(activity))
+				*val = 100;
+			else
+				*val = 0;
+			return IIO_VAL_INT;
 		default:
 			return -EINVAL;
 		}
@@ -898,6 +956,8 @@ static int bma400_read_event_config(struct iio_dev *indio_dev,
 	switch (chan->type) {
 	case IIO_STEPS:
 		return data->step_event_en;
+	case IIO_ACTIVITY:
+		return data->activity_event_en;
 	default:
 		return -EINVAL;
 	}
@@ -937,6 +997,32 @@ static int bma400_write_event_config(struct iio_dev *indio_dev,
 			return ret;
 		data->step_event_en = state;
 		return 0;
+	case IIO_ACTIVITY:
+		if (!data->step_event_en) {
+			mutex_lock(&data->mutex);
+			ret = regmap_update_bits(data->regmap,
+						 BMA400_INT_CONFIG1_REG,
+						 BMA400_STEP_INT_MSK,
+						 FIELD_PREP(BMA400_STEP_INT_MSK,
+							    1));
+			if (ret) {
+				mutex_unlock(&data->mutex);
+				return ret;
+			}
+			data->steps_enabled = 1;
+
+			ret = regmap_update_bits(data->regmap,
+						 BMA400_INT12_MAP_REG,
+						 BMA400_STEP_INT_MSK,
+						 FIELD_PREP(BMA400_STEP_INT_MSK,
+							    1));
+			mutex_unlock(&data->mutex);
+			if (ret)
+				return ret;
+			data->step_event_en = 1;
+		}
+		data->activity_event_en = state;
+		return 0;
 	default:
 		return -EINVAL;
 	}
@@ -1015,6 +1101,7 @@ static irqreturn_t bma400_interrupt(int irq, void *private)
 	s64 timestamp = iio_get_time_ns(indio_dev);
 	int ret;
 	__le16 status;
+	unsigned int act;
 
 	mutex_lock(&data->mutex);
 	ret = regmap_bulk_read(data->regmap, BMA400_INT_STAT0_REG, &status,
@@ -1029,6 +1116,23 @@ static irqreturn_t bma400_interrupt(int irq, void *private)
 					      IIO_EV_DIR_NONE,
 					      IIO_EV_TYPE_CHANGE, 0, 0, 0),
 			       timestamp);
+
+		if (data->activity_event_en) {
+			mutex_lock(&data->mutex);
+			ret = regmap_read(data->regmap, BMA400_STEP_STAT_REG,
+					  &act);
+			mutex_unlock(&data->mutex);
+			if (ret)
+				return IRQ_NONE;
+
+			iio_push_event(indio_dev,
+				       IIO_EVENT_CODE(IIO_ACTIVITY, 0,
+						      bma400_act_to_mod(act),
+						      IIO_EV_DIR_NONE,
+						      IIO_EV_TYPE_CHANGE, 0,
+						      0, 0),
+				       timestamp);
+		}
 		return IRQ_HANDLED;
 	}
 
-- 
2.17.1

