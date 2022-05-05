Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7C051C0BB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 15:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379666AbiEENel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 09:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379606AbiEENeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 09:34:20 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE25256FA3;
        Thu,  5 May 2022 06:30:40 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id cx11-20020a17090afd8b00b001d9fe5965b3so8023084pjb.3;
        Thu, 05 May 2022 06:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CB2rfd2EilPcnlni3o0odhm3eEkQ0tXTMQ0Te1eD2zg=;
        b=dLdj14wEcu4x/F10bBlWfvLmo/KMgqk+O3dLQnSUjl403SQPQoVpo4RrlcG4sIXlVz
         6K+NF+LuuZhkUVfnQIcvlZCP3hvKv+kLt7CroGnjRQU2e//OVDMYGYMBbf4SqzvlIw7M
         lnzc2ZiqcfEYCo8Len5fRLV4hzc+8f/I0cOYPucl9+sBbH+YRz7bZw9BF8GOB4oLxhAS
         rUnvDuMwafBJtD5nSNvAyf51phWnIaQaF/B2WgoP9F7BSfZ5tthYihxhrIJPRiwWKNk9
         DkOxW+lVHMbwNpC/RAbLiV9+f6CVU1l06AEtovqqtPgB4rDoDJ6FMnGDQkCaN40KvDET
         g+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CB2rfd2EilPcnlni3o0odhm3eEkQ0tXTMQ0Te1eD2zg=;
        b=WWflGN1tnn7qLAKU114b/38Q8+XNgoEyUftiOJlZWyRCE9dTw9T2mp8dsjTUR37e9l
         OEYcCS8mjbqw5Skjo7z7wPn+AlI7zJvZHuPh2+fRbffJYXi2bTi9kYHs7fqv8RtWD7Ma
         Qe8lM0wsbPla/RtU2bMbOw/7N8WnO5CKT91U98S1DLBkTRGconGaLrpXXfLBsf92z59A
         OTpKxHeiyxqHGCOrIEdWii4YpSeSBBYoiICmljb20+k67m6arA265QckuqtWw1clF8YA
         wumCDrdcRGZGjssKUAcG/c7pHTAvXmiMUWP63KaHGuROOmNNA+sxiDSbdgI5/vaxELni
         chxw==
X-Gm-Message-State: AOAM532g46rMt1Bs8DmeBAPCWEFPPHNsaHFdVquKqStJDuz9iV9snxTh
        i+eCvxRPwpjS95owEKwfyTU=
X-Google-Smtp-Source: ABdhPJwXM21cQ241FYJlZ9WYPY6dIUckLfnLrshuo2JkBS30Z0BkhEdhP8w55X5xkivXoAMcg4Zowg==
X-Received: by 2002:a17:903:2310:b0:15e:a944:aa52 with SMTP id d16-20020a170903231000b0015ea944aa52mr19724023plh.49.1651757440276;
        Thu, 05 May 2022 06:30:40 -0700 (PDT)
Received: from localhost.localdomain ([115.99.184.228])
        by smtp.gmail.com with ESMTPSA id c64-20020a624e43000000b0050dc7628135sm1420120pfb.15.2022.05.05.06.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 06:30:39 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     dan@dlrobertson.com, jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 06/10] iio: accel: bma400: Add step change event
Date:   Thu,  5 May 2022 19:00:17 +0530
Message-Id: <20220505133021.22362-7-jagathjog1996@gmail.com>
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

Added support for event when there is a detection of step change.
INT1 pin is used to interrupt and event is pushed to userspace.

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 drivers/iio/accel/bma400.h      |  2 +
 drivers/iio/accel/bma400_core.c | 76 +++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
index 32c08f8b0b98..0faa40fdbbf8 100644
--- a/drivers/iio/accel/bma400.h
+++ b/drivers/iio/accel/bma400.h
@@ -39,6 +39,7 @@
 #define BMA400_INT_STAT0_REG        0x0e
 #define BMA400_INT_STAT1_REG        0x0f
 #define BMA400_INT_STAT2_REG        0x10
+#define BMA400_INT12_MAP_REG        0x23
 
 /* Temperature register */
 #define BMA400_TEMP_DATA_REG        0x11
@@ -55,6 +56,7 @@
 #define BMA400_STEP_STAT_REG        0x18
 #define BMA400_STEP_INT_MSK         BIT(0)
 #define BMA400_STEP_RAW_LEN         0x03
+#define BMA400_STEP_STAT_MASK       GENMASK(9, 8)
 
 /*
  * Read-write configuration registers
diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index fdb7e8bd7b27..50932fc1c854 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -25,6 +25,7 @@
 
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
 #include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
@@ -78,6 +79,7 @@ struct bma400_data {
 	int scale;
 	struct iio_trigger *trig;
 	int steps_enabled;
+	bool step_event_en;
 	/* Correct time stamp alignment */
 	struct {
 		__le16 buff[3];
@@ -176,6 +178,12 @@ static const struct iio_chan_spec_ext_info bma400_ext_info[] = {
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
@@ -218,6 +226,8 @@ static const struct iio_chan_spec bma400_channels[] = {
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
 				      BIT(IIO_CHAN_INFO_ENABLE),
 		.scan_index = -1, /* No buffer support */
+		.event_spec = &bma400_step_detect_event,
+		.num_event_specs = 1,
 	},
 	IIO_CHAN_SOFT_TIMESTAMP(4),
 };
@@ -907,6 +917,58 @@ static int bma400_write_raw_get_fmt(struct iio_dev *indio_dev,
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
+static int bma400_steps_event_enable(struct bma400_data *data, int state)
+{
+	int ret;
+
+	ret = bma400_enable_steps(data, 1);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(data->regmap, BMA400_INT12_MAP_REG,
+				 BMA400_STEP_INT_MSK,
+				 FIELD_PREP(BMA400_STEP_INT_MSK,
+					    state));
+	if (ret)
+		return ret;
+	data->step_event_en = state;
+	return 0;
+}
+
+static int bma400_write_event_config(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir, int state)
+{
+	struct bma400_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (chan->type) {
+	case IIO_STEPS:
+		mutex_lock(&data->mutex);
+		ret = bma400_steps_event_enable(data, state);
+		mutex_unlock(&data->mutex);
+		return ret;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int bma400_data_rdy_trigger_set_state(struct iio_trigger *trig,
 					     bool state)
 {
@@ -937,6 +999,8 @@ static const struct iio_info bma400_info = {
 	.read_avail        = bma400_read_avail,
 	.write_raw         = bma400_write_raw,
 	.write_raw_get_fmt = bma400_write_raw_get_fmt,
+	.read_event_config = bma400_read_event_config,
+	.write_event_config = bma400_write_event_config,
 };
 
 static const struct iio_trigger_ops bma400_trigger_ops = {
@@ -984,6 +1048,7 @@ static irqreturn_t bma400_interrupt(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
 	struct bma400_data *data = iio_priv(indio_dev);
+	s64 timestamp = iio_get_time_ns(indio_dev);
 	int ret;
 
 	/* Lock to protect the data->status */
@@ -998,12 +1063,23 @@ static irqreturn_t bma400_interrupt(int irq, void *private)
 	if (ret || !data->status)
 		goto unlock_err;
 
+	if (FIELD_GET(BMA400_STEP_STAT_MASK, le16_to_cpu(data->status))) {
+		iio_push_event(indio_dev,
+			       IIO_MOD_EVENT_CODE(IIO_STEPS, 0, IIO_NO_MOD,
+						  IIO_EV_TYPE_CHANGE,
+						  IIO_EV_DIR_NONE),
+			       timestamp);
+	}
+
 	if (FIELD_GET(BMA400_INT_DRDY_MSK, le16_to_cpu(data->status))) {
 		mutex_unlock(&data->mutex);
 		iio_trigger_poll_chained(data->trig);
 		return IRQ_HANDLED;
 	}
 
+	mutex_unlock(&data->mutex);
+	return IRQ_HANDLED;
+
 unlock_err:
 	mutex_unlock(&data->mutex);
 	return IRQ_NONE;
-- 
2.17.1

