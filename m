Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413454DE9F6
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 19:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243860AbiCSSMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 14:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243839AbiCSSMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 14:12:01 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FE891370;
        Sat, 19 Mar 2022 11:10:40 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id q5so284402plg.3;
        Sat, 19 Mar 2022 11:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JwC7vhtQbQObnQh1/kjr7PyY5SjPha1pc6pp5W08Wzc=;
        b=f8X9UI5vPpI5KvEnKtInL9ihdzjDL/TKiV+XaaUynfbej3n+Ep9wvdwkAZp9r80B6d
         NBYI+MGJ9nfNlCEe+xK2yhKn0x8zaEnlsDWRzT9pHClrVXHV359KC3U99HGA1G5QacVb
         qyAdT+t6f43tO/+bCChrO/3h3VS5GQPr9pYMj4wqTMZw/z9H4E1Uy0yVc2f/YxarcdtB
         r/Z69wrQLySRmyX53rtMRc1E+klIZL3VrPkYLH1zNj4tLTPEBLLIldL/bNICMxzCm+dH
         G+BM+NXk9YnOCRbl+WbompKhGHDAXxj17mYo9llhQYdL6yyotqufQJCb647v6UZCjPLu
         ic4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JwC7vhtQbQObnQh1/kjr7PyY5SjPha1pc6pp5W08Wzc=;
        b=1uhc3kXsdBs9v3w7c5VwWkDQKDKWundpyeW8PzysXNdKWH7J6/lQF6eht+l6tIzziu
         0wrl+p32nivFEZf5HtFuqFwnnQiR/qMkglcQYg07Mp8yr01DaRNMu4Fnxq95CuAWehrS
         FWUzQ9mTHT7yQ2GNJ3Xc6r0u4dm+TkSq2nIPCZc8cuWRsAs5s16b1Lu5DdDrUtoxjhVM
         TgzWHxCB8ZHyq7MZXNfoYB1qrt91zPLimuKGq1TX2RrK/URaq8lP7XcW/zLf3ucs6p8n
         Ucy5kFVkfyMzUWZrfkt5j8BDBR1En+CdjApu78QwCKppLH9rEKkYBDRZNlSGytOD8R2z
         Yc4w==
X-Gm-Message-State: AOAM5300D/WPH7sWgfwPicB9Cgb5Ko4IynNNJx8KoZQsbzbB4ZtFhy5O
        r+GMlmjrfTeLaMTqTZmRgf8=
X-Google-Smtp-Source: ABdhPJz6dHl3t4bQ8bYv8ZaZRf9mtLo7QrIeDaZ/MxGeuGi1Q5Lnb4Aikd04XGALFuQoZR7Hl4CjtA==
X-Received: by 2002:a17:902:c745:b0:151:e8fa:629b with SMTP id q5-20020a170902c74500b00151e8fa629bmr5443495plq.90.1647713440059;
        Sat, 19 Mar 2022 11:10:40 -0700 (PDT)
Received: from localhost.localdomain ([115.99.145.231])
        by smtp.gmail.com with ESMTPSA id nu4-20020a17090b1b0400b001bf497a9324sm16413981pjb.31.2022.03.19.11.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 11:10:39 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     dan@dlrobertson.com, jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/5] iio: accel: bma400: Add step change event
Date:   Sat, 19 Mar 2022 23:40:23 +0530
Message-Id: <20220319181023.8090-6-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220319181023.8090-1-jagathjog1996@gmail.com>
References: <20220319181023.8090-1-jagathjog1996@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added support for event when there is a detection of single step
or double step change. INT1 pin is used to interrupt and event
is pushed to userspace.

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 drivers/iio/accel/bma400.h      |  2 +
 drivers/iio/accel/bma400_core.c | 72 +++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
index 65bbc80cbb7f..c833119bb42e 100644
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
 #define BMA400_STEP_INT_MSK         BIT(0)
+#define BMA400_STEP_STAT_MASK	    GENMASK(1, 0)
 
 /*
  * Read-write configuration registers
diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index 305643e99eb5..79321e41df51 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -26,6 +26,7 @@
 #include <linux/iio/trigger.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
+#include <linux/iio/events.h>
 
 #include "bma400.h"
 
@@ -69,6 +70,7 @@ struct bma400_data {
 	int scale;
 	struct iio_trigger *trig;
 	int steps_enabled;
+	bool step_event_en;
 	/* Correct time stamp alignment */
 	struct {
 		__be16 buff[3];
@@ -166,6 +168,12 @@ static const struct iio_chan_spec_ext_info bma400_ext_info[] = {
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
@@ -208,6 +216,8 @@ static const struct iio_chan_spec bma400_channels[] = {
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
 				      BIT(IIO_CHAN_INFO_ENABLE),
 		.scan_index = -1, /* No buffer support */
+		.event_spec = &bma400_step_detect_event,
+		.num_event_specs = 1,
 	},
 
 	IIO_CHAN_SOFT_TIMESTAMP(4),
@@ -858,6 +868,59 @@ static int bma400_write_raw_get_fmt(struct iio_dev *indio_dev,
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
+		switch (type) {
+		case IIO_EV_TYPE_CHANGE:
+			return data->steps_enabled;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+	return 0;
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
+		switch (type) {
+		case IIO_EV_TYPE_CHANGE:
+			mutex_lock(&data->mutex);
+			ret = regmap_update_bits(data->regmap,
+						 BMA400_INT12_MAP_REG,
+						 BMA400_STEP_INT_MSK,
+						 FIELD_PREP(BMA400_STEP_INT_MSK,
+							    state));
+			mutex_unlock(&data->mutex);
+			if (ret)
+				return ret;
+			data->steps_enabled = state;
+			return 0;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static int bma400_data_rdy_trigger_set_state(struct iio_trigger *trig,
 					     bool state)
 {
@@ -890,6 +953,8 @@ static const struct iio_info bma400_info = {
 	.read_avail        = bma400_read_avail,
 	.write_raw         = bma400_write_raw,
 	.write_raw_get_fmt = bma400_write_raw_get_fmt,
+	.read_event_config = bma400_read_event_config,
+	.write_event_config = bma400_write_event_config,
 };
 
 static const struct iio_trigger_ops bma400_trigger_ops = {
@@ -945,6 +1010,13 @@ static irqreturn_t bma400_interrupt(int irq, void *private)
 	if (status & BMA400_INT_DRDY_MSK)
 		iio_trigger_poll_chained(data->trig);
 
+	if (status & (BMA400_STEP_STAT_MASK << 8)) {
+		iio_push_event(indio_dev,
+			       IIO_EVENT_CODE(IIO_STEPS, 0, IIO_NO_MOD,
+					      IIO_EV_DIR_NONE,
+					      IIO_EV_TYPE_CHANGE, 0, 0, 0),
+			       iio_get_time_ns(indio_dev));
+		}
 out:
 	return IRQ_HANDLED;
 }
-- 
2.17.1

