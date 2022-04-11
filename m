Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693AF4FC5D9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 22:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240794AbiDKUeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 16:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349882AbiDKUeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 16:34:12 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4064936142;
        Mon, 11 Apr 2022 13:31:53 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id n8so14875362plh.1;
        Mon, 11 Apr 2022 13:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Td+5xF2W6lM7nqApdBgxh2F8Fc6N+cKcoMhSCOA5VFg=;
        b=G1GXw3UPApwTJ2/wzpKAGhHm47/g1i/Fto/8j+jytX/w1M94iZzm6R31cSnzHmFIU6
         t9WwH5Ts190+HN+9NxgQuErLDBHeXzo+qQgn4SQYoV08/iHflEa3cT1fk3xF6D8jERuY
         MyRMY02POFNJcmfYIjQxBm2HB242QQelTKVPwW52VsFbXOSjSu1kf5v38MnrSTWvHFTJ
         JA8Ij3MRDZIEpfO4w/nrIcn4DRLot6Jz6oU5OFSA8J4pZK5UNK9YdyABaw/BgFxXuqj0
         emUH/SOtITtPktekLiv8UAbaNEIJJyXFX/Ok7tfrGa8dgWPeUEtP+vgSmqzayk+jkmw4
         YL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Td+5xF2W6lM7nqApdBgxh2F8Fc6N+cKcoMhSCOA5VFg=;
        b=el72UzhRpELNy4QAUsN8oYiug3IsyTb2NqJHeuQArSVrfO0AT3xNI0lfgPgbiey0+/
         H7o9UJZm1ObsKbxRQQD7Eedz8gqOtdENKbX+3yt2CyOl8l9fe5yqaghfheN55Ebzk96d
         I3a0r8G7/qTIMcR8ulSKlfR74HbA7dqAwlblkAyPk3GHZo0uOpolgUEN2MW7dQXWzFMg
         ZzpGJGxBEWR7nATUW8muHIACnh0tkbtOxENW29zNcVmYdHmTpqt0wLV4c12OA2wvxHkQ
         XoYkvJOVNGFc6wP22a3WeKBBZ8Xy88Yq2Iwm+A0Y4zroZtOm4zrtgUf8gMlubF/FluWE
         9tNw==
X-Gm-Message-State: AOAM531AnE81EeWXUSCSyKbf1Ck3wSW0/w2UpULybEBI6YwelivjDarF
        r3XlK+rDOmVD4dH/Lk4/YIU=
X-Google-Smtp-Source: ABdhPJzOVO+2Qnmg0jUXg+1t63JqijDn7fONYYDSPGczZbpUGooj1yDaZcJ8MzhYP7VNyFCfAjyZPg==
X-Received: by 2002:a17:90b:1803:b0:1c7:24c4:ab52 with SMTP id lw3-20020a17090b180300b001c724c4ab52mr1011103pjb.240.1649709112575;
        Mon, 11 Apr 2022 13:31:52 -0700 (PDT)
Received: from localhost.localdomain ([27.7.99.112])
        by smtp.gmail.com with ESMTPSA id z15-20020a056a001d8f00b004fda37855ddsm34069828pfw.168.2022.04.11.13.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 13:31:52 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     dan@dlrobertson.com, jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/9] iio: accel: bma400: Add step change event
Date:   Tue, 12 Apr 2022 02:01:30 +0530
Message-Id: <20220411203133.19929-7-jagathjog1996@gmail.com>
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

Added support for event when there is a detection of step change.
INT1 pin is used to interrupt and event is pushed to userspace.

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 drivers/iio/accel/bma400.h      |  2 +
 drivers/iio/accel/bma400_core.c | 76 +++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
index 52f9ea95de81..bc4641279be3 100644
--- a/drivers/iio/accel/bma400.h
+++ b/drivers/iio/accel/bma400.h
@@ -39,6 +39,7 @@
 #define BMA400_INT_STAT0_REG        0x0e
 #define BMA400_INT_STAT1_REG        0x0f
 #define BMA400_INT_STAT2_REG        0x10
+#define BMA400_INT12_MAP_REG	    0x23
 
 /* Temperature register */
 #define BMA400_TEMP_DATA_REG        0x11
@@ -54,6 +55,7 @@
 #define BMA400_STEP_CNT3_REG        0x17
 #define BMA400_STEP_STAT_REG        0x18
 #define BMA400_STEP_INT_MSK	    BIT(0)
+#define BMA400_STEP_STAT_MASK	    GENMASK(9, 8)
 
 /*
  * Read-write configuration registers
diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index c8f147163d3c..37f38626a9aa 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -24,6 +24,7 @@
 
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
 #include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
@@ -70,6 +71,7 @@ struct bma400_data {
 	int scale;
 	struct iio_trigger *trig;
 	int steps_enabled;
+	bool step_event_en;
 	/* Correct time stamp alignment */
 	struct {
 		__le16 buff[3];
@@ -167,6 +169,12 @@ static const struct iio_chan_spec_ext_info bma400_ext_info[] = {
 	{ }
 };
 
+static const struct iio_event_spec bma400_step_detect_event = {
+	.type = IIO_EV_TYPE_CHANGE,
+	.dir = IIO_EV_DIR_NONE,
+	.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+};
+
 #define BMA400_ACC_CHANNEL(_index, _axis) { \
 	.type = IIO_ACCEL, \
 	.modified = 1, \
@@ -209,6 +217,8 @@ static const struct iio_chan_spec bma400_channels[] = {
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
 				      BIT(IIO_CHAN_INFO_ENABLE),
 		.scan_index = -1, /* No buffer support */
+		.event_spec = &bma400_step_detect_event,
+		.num_event_specs = 1,
 	},
 	IIO_CHAN_SOFT_TIMESTAMP(4),
 };
@@ -878,6 +888,60 @@ static int bma400_write_raw_get_fmt(struct iio_dev *indio_dev,
 	}
 }
 
+static int bma400_read_event_config(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir)
+{
+	struct bma400_data *data = iio_priv(indio_dev);
+
+	switch (chan->type) {
+	case IIO_STEPS:
+		return data->step_event_en;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int bma400_write_event_config(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir, int state)
+{
+	int ret;
+	struct bma400_data *data = iio_priv(indio_dev);
+
+	switch (chan->type) {
+	case IIO_STEPS:
+		mutex_lock(&data->mutex);
+		if (!data->steps_enabled) {
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
+		}
+
+		ret = regmap_update_bits(data->regmap,
+					 BMA400_INT12_MAP_REG,
+					 BMA400_STEP_INT_MSK,
+					 FIELD_PREP(BMA400_STEP_INT_MSK,
+						    state));
+		mutex_unlock(&data->mutex);
+		if (ret)
+			return ret;
+		data->step_event_en = state;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int bma400_data_rdy_trigger_set_state(struct iio_trigger *trig,
 					     bool state)
 {
@@ -906,6 +970,8 @@ static const struct iio_info bma400_info = {
 	.read_avail        = bma400_read_avail,
 	.write_raw         = bma400_write_raw,
 	.write_raw_get_fmt = bma400_write_raw_get_fmt,
+	.read_event_config = bma400_read_event_config,
+	.write_event_config = bma400_write_event_config,
 };
 
 static const struct iio_trigger_ops bma400_trigger_ops = {
@@ -946,6 +1012,7 @@ static irqreturn_t bma400_interrupt(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
 	struct bma400_data *data = iio_priv(indio_dev);
+	s64 timestamp = iio_get_time_ns(indio_dev);
 	int ret;
 	__le16 status;
 
@@ -956,6 +1023,15 @@ static irqreturn_t bma400_interrupt(int irq, void *private)
 	if (ret)
 		return IRQ_NONE;
 
+	if (FIELD_GET(BMA400_STEP_STAT_MASK, le16_to_cpu(status))) {
+		iio_push_event(indio_dev,
+			       IIO_EVENT_CODE(IIO_STEPS, 0, IIO_NO_MOD,
+					      IIO_EV_DIR_NONE,
+					      IIO_EV_TYPE_CHANGE, 0, 0, 0),
+			       timestamp);
+		return IRQ_HANDLED;
+	}
+
 	if (FIELD_GET(BMA400_INT_DRDY_MSK, le16_to_cpu(status))) {
 		iio_trigger_poll_chained(data->trig);
 		return IRQ_HANDLED;
-- 
2.17.1

