Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF3251C0E0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 15:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379706AbiEENey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 09:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379637AbiEENeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 09:34:23 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99BC1277A;
        Thu,  5 May 2022 06:30:43 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id o69so4212964pjo.3;
        Thu, 05 May 2022 06:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H3CkS7Q8uU7MubL4PY7f/qf/85uW9+5JcXDuS6dbHMY=;
        b=JdYhrJb7mX4+734N1IXgMszUeEgx+WAZ2dR/lmjVqsOUxKkXoaW4Iy20gkxFEhmK8a
         Y2mTRea2gb7hXAIbVnXKYhy2ubYDAORsCIAiStuy1ctHsn/Ni2RB4nwlnqW37tphhdR3
         v6TUqoUpG/CMbJK0S7PqYfNe6Zu7+WZaxzuzUIHu1ZxW/2gjxZTdMqR0pI7Xt8IuONey
         oRhKBWejpMxipqyuZduPqYKs8ZzlKpl42w0PiT5bFY4HUWUAOCLpZEHEUv8od5DCkapa
         2EKRk5gd6zB9Tw++E9Rh0+afGFYAJPFNa2uyp+EqZYAuZYDGKrGCafFNtJBRHLSERztr
         0I/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H3CkS7Q8uU7MubL4PY7f/qf/85uW9+5JcXDuS6dbHMY=;
        b=QDSZdbADsTyFu2OBAV1ifB/Hag09nHOP5ZloAQAivflrDVYyVmAzb4bbGJg0ztncH9
         Q3XnYqw8IKbpUJ/cZHNQwTlfAD/Cxv5CCPFy76xpmv2PBJSKfZJs+eyVUjBM/zvE5SLs
         Un+nVyq6MIgnc69yD3yjTu5HZ+0CtyDTlp9DmuYAopNHC6tUka5f58diCRYTxE6VYH7k
         QB/FawL1+JZYtCpxCvUsVmVUx9UP/9AYi4EP545LR2O72QDVuCWT0FTt/Vyv4ch2bcpI
         Hx3zkaGX908AfBfryopKK+rLE11t+l8q/Rz2hSBqUeLrmZuOX0FaZEJuRYEpF0R13gp/
         KRzw==
X-Gm-Message-State: AOAM532f9bLUFmKS2YiqLfWUFXhoEXLRTFYb+qi803D8cv/XwZqEkE5h
        DTSZkfsJ49JYFNlwlhAI57M=
X-Google-Smtp-Source: ABdhPJwT2CcSIvf96nOivNSJyRdg9I1448OecKUqWeJk+vGTypo1FQfJDjUL8VIZwDuHM/qkW0y8og==
X-Received: by 2002:a17:90a:a393:b0:1d0:e448:811d with SMTP id x19-20020a17090aa39300b001d0e448811dmr6274218pjp.97.1651757443035;
        Thu, 05 May 2022 06:30:43 -0700 (PDT)
Received: from localhost.localdomain ([115.99.184.228])
        by smtp.gmail.com with ESMTPSA id c64-20020a624e43000000b0050dc7628135sm1420120pfb.15.2022.05.05.06.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 06:30:42 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     dan@dlrobertson.com, jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 07/10] iio: accel: bma400: Add activity recognition support
Date:   Thu,  5 May 2022 19:00:18 +0530
Message-Id: <20220505133021.22362-8-jagathjog1996@gmail.com>
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

Add support for activity recognition like STILL, WALKING, RUNNING
and these events are pushed to the userspace whenever the STEP
interrupt occurs.

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 drivers/iio/accel/bma400_core.c | 85 +++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index 50932fc1c854..1e4923064b63 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -67,6 +67,12 @@ struct bma400_sample_freq {
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
@@ -80,6 +86,7 @@ struct bma400_data {
 	struct iio_trigger *trig;
 	int steps_enabled;
 	bool step_event_en;
+	bool activity_event_en;
 	/* Correct time stamp alignment */
 	struct {
 		__le16 buff[3];
@@ -184,6 +191,12 @@ static const struct iio_event_spec bma400_step_detect_event = {
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
@@ -205,6 +218,16 @@ static const struct iio_event_spec bma400_step_detect_event = {
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
@@ -229,6 +252,9 @@ static const struct iio_chan_spec bma400_channels[] = {
 		.event_spec = &bma400_step_detect_event,
 		.num_event_specs = 1,
 	},
+	BMA400_ACTIVITY_CHANNEL(IIO_MOD_STILL),
+	BMA400_ACTIVITY_CHANNEL(IIO_MOD_WALKING),
+	BMA400_ACTIVITY_CHANNEL(IIO_MOD_RUNNING),
 	IIO_CHAN_SOFT_TIMESTAMP(4),
 };
 
@@ -669,6 +695,20 @@ static void bma400_power_disable(void *data_ptr)
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
@@ -766,6 +806,7 @@ static int bma400_read_raw(struct iio_dev *indio_dev,
 			   int *val2, long mask)
 {
 	struct bma400_data *data = iio_priv(indio_dev);
+	unsigned int activity;
 	int ret;
 
 	switch (mask) {
@@ -778,6 +819,21 @@ static int bma400_read_raw(struct iio_dev *indio_dev,
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
@@ -927,6 +983,8 @@ static int bma400_read_event_config(struct iio_dev *indio_dev,
 	switch (chan->type) {
 	case IIO_STEPS:
 		return data->step_event_en;
+	case IIO_ACTIVITY:
+		return data->activity_event_en;
 	default:
 		return -EINVAL;
 	}
@@ -964,6 +1022,18 @@ static int bma400_write_event_config(struct iio_dev *indio_dev,
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
@@ -1049,6 +1119,7 @@ static irqreturn_t bma400_interrupt(int irq, void *private)
 	struct iio_dev *indio_dev = private;
 	struct bma400_data *data = iio_priv(indio_dev);
 	s64 timestamp = iio_get_time_ns(indio_dev);
+	unsigned int act;
 	int ret;
 
 	/* Lock to protect the data->status */
@@ -1069,6 +1140,20 @@ static irqreturn_t bma400_interrupt(int irq, void *private)
 						  IIO_EV_TYPE_CHANGE,
 						  IIO_EV_DIR_NONE),
 			       timestamp);
+
+		if (data->activity_event_en) {
+			ret = regmap_read(data->regmap, BMA400_STEP_STAT_REG,
+					  &act);
+			if (ret)
+				goto unlock_err;
+
+			iio_push_event(indio_dev,
+				       IIO_MOD_EVENT_CODE(IIO_ACTIVITY, 0,
+							  bma400_act_to_mod(act),
+							  IIO_EV_TYPE_CHANGE,
+							  IIO_EV_DIR_NONE),
+				       timestamp);
+		}
 	}
 
 	if (FIELD_GET(BMA400_INT_DRDY_MSK, le16_to_cpu(data->status))) {
-- 
2.17.1

