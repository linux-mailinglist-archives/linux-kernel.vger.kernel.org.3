Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68495091DB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 23:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382454AbiDTVO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 17:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382376AbiDTVOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 17:14:22 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C514C4831B;
        Wed, 20 Apr 2022 14:11:24 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id z16so3111628pfh.3;
        Wed, 20 Apr 2022 14:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tZQUlUpggsqshIBZIEqFH3v1VH36ZYRjLjiMyZLTFwc=;
        b=bnf14GjVBIGcHhC+P3YgPJtQ1Z/pXD69S2oSQTrUnVzsdeNgHz926H932krAynjflv
         qVNTrsTWpgluDCt9c/m1cp2dGxsFb76JYH37fgnvtSoVzHnvy8v/8rADT1smUT2C8XxW
         QoI21m2psVOFxXBgTA92vAw+6FwKLj+UjwM+8J0tKjzDNs/h99gZKv2Rs+BPdMcnCRiI
         sxreCvg8Oa+YK4xU/DkEx8p7QPVgjIiIxQcNGnLtKsOdKSjuCiseUqGn8KExJODFcMhJ
         lJq9fhVB220rlQ2vMCyzj++a5w/CnjjgiiZNRLbXG51aKYGfHUEJiuNR0nCs5NN52qgK
         kLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tZQUlUpggsqshIBZIEqFH3v1VH36ZYRjLjiMyZLTFwc=;
        b=RKJWDzYfFXyOM9B6Jcbd0MohrPJyWZ+qd29u4SGvKBDYTccOqQtKQc5REefTmvAgVH
         jK+WgWjjo6/3eerIpT5PGwqotHpxpNR5SDxrRw1cr5aUamNPjHJ8T/t5pfm9m9okKiGc
         cAMws79lPpZBR+gz8ERwlJf0Qp/L6bXeTWjpxEM/O9h5uBIxfabGIUdJfqzFwKPpmrTU
         gAq+Jzzig278bOP+f2M7lzo331VVCO83fQssQaZgAnq4vso6HJtwYGvJ6t5OtQpn0ZDJ
         Yv7Oh8rVMQpPc+ysrmuIY93zaLsFeR4lg7PEs5r4Bo5gfUMFYiPQ8xhJCYMA0U6Rj7N5
         cNlQ==
X-Gm-Message-State: AOAM532fKec3NFLZUmwziZBF+I9HLY/YE2HYmrK55onktu9bsdSde2Xl
        Qm05tIhq83c9clBadm3Y08Y=
X-Google-Smtp-Source: ABdhPJy+5y/C5QWAesVuAENR/MyABQBJtQ0Wtcxo39iM2N3+7MhJ1wJmOddd5UmFwGw/cWzvRw2mKw==
X-Received: by 2002:a05:6a02:182:b0:374:5a57:cbf9 with SMTP id bj2-20020a056a02018200b003745a57cbf9mr20561451pgb.616.1650489084290;
        Wed, 20 Apr 2022 14:11:24 -0700 (PDT)
Received: from localhost.localdomain ([27.7.104.83])
        by smtp.gmail.com with ESMTPSA id v13-20020a17090a00cd00b001cd4989fee4sm106652pjd.48.2022.04.20.14.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 14:11:24 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     dan@dlrobertson.com, jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 7/9] iio: accel: bma400: Add activity recognition support
Date:   Thu, 21 Apr 2022 02:41:03 +0530
Message-Id: <20220420211105.14654-8-jagathjog1996@gmail.com>
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

Add support for activity recognition like STILL, WALKING, RUNNING
and these events are pushed to the userspace whenever the STEP
interrupt occurs.

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 drivers/iio/accel/bma400_core.c | 86 +++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index fe101df7b773..073fff7d64a3 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -60,6 +60,12 @@ struct bma400_sample_freq {
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
@@ -73,6 +79,7 @@ struct bma400_data {
 	struct iio_trigger *trig;
 	int steps_enabled;
 	bool step_event_en;
+	bool activity_event_en;
 	/* Correct time stamp alignment */
 	struct {
 		__le16 buff[3];
@@ -177,6 +184,12 @@ static const struct iio_event_spec bma400_step_detect_event = {
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
@@ -198,6 +211,16 @@ static const struct iio_event_spec bma400_step_detect_event = {
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
@@ -222,6 +245,9 @@ static const struct iio_chan_spec bma400_channels[] = {
 		.event_spec = &bma400_step_detect_event,
 		.num_event_specs = 1,
 	},
+	BMA400_ACTIVITY_CHANNEL(IIO_MOD_STILL),
+	BMA400_ACTIVITY_CHANNEL(IIO_MOD_WALKING),
+	BMA400_ACTIVITY_CHANNEL(IIO_MOD_RUNNING),
 	IIO_CHAN_SOFT_TIMESTAMP(4),
 };
 
@@ -660,6 +686,20 @@ static void bma400_power_disable(void *data_ptr)
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
@@ -758,6 +798,7 @@ static int bma400_read_raw(struct iio_dev *indio_dev,
 {
 	struct bma400_data *data = iio_priv(indio_dev);
 	int ret;
+	unsigned int activity;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_PROCESSED:
@@ -769,6 +810,21 @@ static int bma400_read_raw(struct iio_dev *indio_dev,
 			return ret;
 		case IIO_STEPS:
 			return bma400_get_steps_reg(data, val);
+		case IIO_ACTIVITY:
+			ret = regmap_read(data->regmap, BMA400_STEP_STAT_REG,
+					  &activity);
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
@@ -918,6 +974,8 @@ static int bma400_read_event_config(struct iio_dev *indio_dev,
 	switch (chan->type) {
 	case IIO_STEPS:
 		return data->step_event_en;
+	case IIO_ACTIVITY:
+		return data->activity_event_en;
 	default:
 		return -EINVAL;
 	}
@@ -955,6 +1013,18 @@ static int bma400_write_event_config(struct iio_dev *indio_dev,
 		ret = bma400_steps_event_enable(data, state);
 		mutex_unlock(&data->mutex);
 		return ret;
+	case IIO_ACTIVITY:
+		mutex_lock(&data->mutex);
+		if (!data->step_event_en) {
+			ret = bma400_steps_event_enable(data, true);
+			if (ret) {
+				mutex_unlock(&data->mutex);
+				return ret;
+			}
+		}
+		data->activity_event_en = state;
+		mutex_unlock(&data->mutex);
+		return 0;
 	default:
 		return -EINVAL;
 	}
@@ -1037,6 +1107,7 @@ static irqreturn_t bma400_interrupt(int irq, void *private)
 	struct bma400_data *data = iio_priv(indio_dev);
 	s64 timestamp = iio_get_time_ns(indio_dev);
 	int ret;
+	unsigned int act;
 
 	/* Lock to protect the data->status */
 	mutex_lock(&data->mutex);
@@ -1052,6 +1123,21 @@ static irqreturn_t bma400_interrupt(int irq, void *private)
 					      IIO_EV_DIR_NONE,
 					      IIO_EV_TYPE_CHANGE, 0, 0, 0),
 			       timestamp);
+
+		if (data->activity_event_en) {
+			ret = regmap_read(data->regmap, BMA400_STEP_STAT_REG,
+					  &act);
+			if (ret)
+				goto unlock_err;
+
+			iio_push_event(indio_dev,
+				       IIO_EVENT_CODE(IIO_ACTIVITY, 0,
+						      bma400_act_to_mod(act),
+						      IIO_EV_DIR_NONE,
+						      IIO_EV_TYPE_CHANGE, 0,
+						      0, 0),
+				       timestamp);
+		}
 		mutex_unlock(&data->mutex);
 		return IRQ_HANDLED;
 	}
-- 
2.17.1

