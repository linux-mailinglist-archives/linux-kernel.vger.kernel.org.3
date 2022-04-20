Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9F85091D0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 23:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382415AbiDTVO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 17:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382389AbiDTVOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 17:14:10 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE92A3C499;
        Wed, 20 Apr 2022 14:11:22 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id c12so2936142plr.6;
        Wed, 20 Apr 2022 14:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hAEmCD6wSI6Cxq48pLmVwhxY/XUwjnD/tjbd65QD6sg=;
        b=ILBjjIg1OOmmtzchzIeUBCU7CE7d/wGl9tJCQas8qMlNrKgt4uniw2Yjfu1KbSSGOG
         Tr1/OjO/No9rAbyZK2U4a+Se8hjWTA0vjaTOoYm7QrNc+E3PdE+lIm8fiFnm8pf1SyDO
         gQ8edKRMC5jsMZtKQBwRRm21xHvXLpNzth01bK65d3E577HTITjzn2w3SmhixBm1Pksx
         D3b1B/Y2vmL25tk/QKv4Qjw4Ng3+dBDNmU+OFb0CUPlAncGFLyJwVWqrwinRG2GVtASi
         MyVyXsYfBaigYXcmjpWkvbsAyIHjqwTmc48PHCnRxISVQE/D05OwrGylVhP8Dvl+yDZ+
         tWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hAEmCD6wSI6Cxq48pLmVwhxY/XUwjnD/tjbd65QD6sg=;
        b=5aGtzqIi613kIDYSDk0HjVzuJ9worodqk+V7Uo0XwZIcXERCqE4xsRfpVlXES5qtM5
         krVEZX7qQH8hIwIRq6PzzXvL9U+NTuVTVCb3w/K9zovR7jxxLbdGL+Nki5WVNCKKRJU4
         c8aKk9BDpLJaBWb6M5QoY3f7Y3a8Oym5eNa00hSEglywDdhS4tOtkZFZ8Z4z9apfjmjS
         2r/khYHbDtrtFXbc0FqSqOW/lQFmrhP6CVEo79gu14fbFlS4rdXZQVey3/wZ/L6VPT+o
         rww/NaxjEuMrDdmG7Zyr5Z4B+J/I6X8wsDyu92t9I1lBeAVGu+F/8niEHV6BN0sYhw9i
         mOGg==
X-Gm-Message-State: AOAM531Dzh9qsm5lUWi7vtEbwEDdcBDbZzpil8JR/4Yr3I/SaTfOfudy
        FS8YOoR+V8/OqPrGoX5UN1Y=
X-Google-Smtp-Source: ABdhPJxNxEed8gWLg55uO/FAC4wXYxX5RnOWPtHDCXtxPR2R1U7XBqzhpYO9cA+84PuojFvD40i5jA==
X-Received: by 2002:a17:902:8a95:b0:156:a40a:71e5 with SMTP id p21-20020a1709028a9500b00156a40a71e5mr22148356plo.144.1650489082273;
        Wed, 20 Apr 2022 14:11:22 -0700 (PDT)
Received: from localhost.localdomain ([27.7.104.83])
        by smtp.gmail.com with ESMTPSA id v13-20020a17090a00cd00b001cd4989fee4sm106652pjd.48.2022.04.20.14.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 14:11:22 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     dan@dlrobertson.com, jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/9] iio: accel: bma400: Add step change event
Date:   Thu, 21 Apr 2022 02:41:02 +0530
Message-Id: <20220420211105.14654-7-jagathjog1996@gmail.com>
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

Added support for event when there is a detection of step change.
INT1 pin is used to interrupt and event is pushed to userspace.

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 drivers/iio/accel/bma400.h      |  2 +
 drivers/iio/accel/bma400_core.c | 75 +++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+)

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
index aafb5a40944d..fe101df7b773 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -25,6 +25,7 @@
 
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
 #include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
@@ -71,6 +72,7 @@ struct bma400_data {
 	int scale;
 	struct iio_trigger *trig;
 	int steps_enabled;
+	bool step_event_en;
 	/* Correct time stamp alignment */
 	struct {
 		__le16 buff[3];
@@ -169,6 +171,12 @@ static const struct iio_chan_spec_ext_info bma400_ext_info[] = {
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
@@ -211,6 +219,8 @@ static const struct iio_chan_spec bma400_channels[] = {
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
 				      BIT(IIO_CHAN_INFO_ENABLE),
 		.scan_index = -1, /* No buffer support */
+		.event_spec = &bma400_step_detect_event,
+		.num_event_specs = 1,
 	},
 	IIO_CHAN_SOFT_TIMESTAMP(4),
 };
@@ -898,6 +908,58 @@ static int bma400_write_raw_get_fmt(struct iio_dev *indio_dev,
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
@@ -926,6 +988,8 @@ static const struct iio_info bma400_info = {
 	.read_avail        = bma400_read_avail,
 	.write_raw         = bma400_write_raw,
 	.write_raw_get_fmt = bma400_write_raw_get_fmt,
+	.read_event_config = bma400_read_event_config,
+	.write_event_config = bma400_write_event_config,
 };
 
 static const struct iio_trigger_ops bma400_trigger_ops = {
@@ -971,6 +1035,7 @@ static irqreturn_t bma400_interrupt(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
 	struct bma400_data *data = iio_priv(indio_dev);
+	s64 timestamp = iio_get_time_ns(indio_dev);
 	int ret;
 
 	/* Lock to protect the data->status */
@@ -981,6 +1046,16 @@ static irqreturn_t bma400_interrupt(int irq, void *private)
 	if (ret)
 		goto unlock_err;
 
+	if (FIELD_GET(BMA400_STEP_STAT_MASK, le16_to_cpu(data->status))) {
+		iio_push_event(indio_dev,
+			       IIO_EVENT_CODE(IIO_STEPS, 0, IIO_NO_MOD,
+					      IIO_EV_DIR_NONE,
+					      IIO_EV_TYPE_CHANGE, 0, 0, 0),
+			       timestamp);
+		mutex_unlock(&data->mutex);
+		return IRQ_HANDLED;
+	}
+
 	if (FIELD_GET(BMA400_INT_DRDY_MSK, le16_to_cpu(data->status))) {
 		mutex_unlock(&data->mutex);
 		iio_trigger_poll_chained(data->trig);
-- 
2.17.1

