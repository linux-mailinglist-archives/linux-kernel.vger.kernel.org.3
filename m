Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7514E83D9
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 20:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbiCZTns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 15:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234791AbiCZTnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 15:43:39 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3941D173F6E;
        Sat, 26 Mar 2022 12:42:02 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id e5so11456596pls.4;
        Sat, 26 Mar 2022 12:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=llFGG5Ln4GVOwfUYH1k+vdT3vwWNdoegXKZ4vtGyn6w=;
        b=fzzCsS/pr1ErTf+UmtXWcKGuM7JjCovPVf3AI3L19HoMtAfYfsSvgGqbMejQFbn/4e
         XuuQEkR5ia1bjCQYGJeDMmkwnaG4dq6O4jySw8xxGXB1EhNkYD4OwovlxTZW50BBYQhW
         dSISrgeDWJnGtP1XBLWPrR53nipTR2Pw45VSiWzmD27wv6rFv66+6MG/NP2LbjzSRlpL
         Zf34xgWaAlyeXTUHtCxiuEoQsEUiWTM8t5ZDz6psWVLgDGOvntLpDXP9VGVd8kNXgMs3
         MXDVgrPVcF9t9UGnmgjRBIRUSqV3sndfDN30YVxwR4e2i2HasbmndbgaOGiR+d/a/7Kp
         DCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=llFGG5Ln4GVOwfUYH1k+vdT3vwWNdoegXKZ4vtGyn6w=;
        b=D5ILTXFyLU3pu49XziLtZ4xHDfDJUF0mrjbySCr8t1Q/NVVNfOUVoOegnDoxvrbpKS
         qE7BKdz5WOre0RLC6RrDslOEaM8UsUtmjQlyxsHoviazgbN8jkD8Ub7FkcFdM3/C1E55
         JflImBZGdX8i9MmdaH4eFzgqwJcFJ+U/nuerIIyP/lT584DvXdkCZM8o/7uBxvVAw9Fu
         FpJsKhjay/QBTavz4Ldxd7buUHKRRQQUFOxCNQt/xKWedMHAP2mhdrEOkVvt60BTJMnI
         NElcrTEjYUYRgystC57pPgJhyTycWZ7NRYVHKmtA2XrxCTZ6FPqaXlrWus6pC4PN7T81
         +Ajg==
X-Gm-Message-State: AOAM532TW+5R6YC7VuaaQd1WtGodNxfpFQFYKfFxOlivPwGQ5hK5/OJ4
        0vuyvvXwrrdJpHkTqV3KDKM=
X-Google-Smtp-Source: ABdhPJxSSj3KRzh+Cczwjgvy6iW74+dHes/vn6ViGSr7LL639XjTIyxHg8AvRoIGSjk9pgOSCXiaow==
X-Received: by 2002:a17:902:7109:b0:153:2ed8:b140 with SMTP id a9-20020a170902710900b001532ed8b140mr18735814pll.52.1648323721535;
        Sat, 26 Mar 2022 12:42:01 -0700 (PDT)
Received: from localhost.localdomain ([116.75.119.161])
        by smtp.gmail.com with ESMTPSA id k185-20020a6384c2000000b003821dcd9020sm8778784pgd.27.2022.03.26.12.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 12:42:01 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     dan@dlrobertson.com, jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] iio: accel: bma400: Add step change event
Date:   Sun, 27 Mar 2022 01:11:46 +0530
Message-Id: <20220326194146.15549-6-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220326194146.15549-1-jagathjog1996@gmail.com>
References: <20220326194146.15549-1-jagathjog1996@gmail.com>
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
 drivers/iio/accel/bma400_core.c | 73 +++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
index c9b856b37021..c4ec0cf6dc00 100644
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
index ec2f9c380bda..aaa104a2698b 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -24,6 +24,7 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
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
@@ -878,6 +888,58 @@ static int bma400_write_raw_get_fmt(struct iio_dev *indio_dev,
 	}
 }
 
+static int bma400_read_event_config(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir)
+{
+	struct bma400_data *data = iio_priv(indio_dev);
+
+	switch (type) {
+	case IIO_EV_TYPE_CHANGE:
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
+	switch (type) {
+	case IIO_EV_TYPE_CHANGE:
+		mutex_lock(&data->mutex);
+		if (!data->steps_enabled) {
+			ret = regmap_update_bits(data->regmap,
+						 BMA400_INT_CONFIG1_REG,
+						 BMA400_STEP_INT_MSK,
+						 FIELD_PREP(BMA400_STEP_INT_MSK,
+							    1));
+			if (ret)
+				return ret;
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
@@ -910,6 +972,8 @@ static const struct iio_info bma400_info = {
 	.read_avail        = bma400_read_avail,
 	.write_raw         = bma400_write_raw,
 	.write_raw_get_fmt = bma400_write_raw_get_fmt,
+	.read_event_config = bma400_read_event_config,
+	.write_event_config = bma400_write_event_config,
 };
 
 static const struct iio_trigger_ops bma400_trigger_ops = {
@@ -965,6 +1029,15 @@ static irqreturn_t bma400_interrupt(int irq, void *private)
 		ret = IRQ_HANDLED;
 	}
 
+	if (FIELD_GET(BMA400_STEP_STAT_MASK, le16_to_cpu(status))) {
+		iio_push_event(indio_dev,
+			       IIO_EVENT_CODE(IIO_STEPS, 0, IIO_NO_MOD,
+					      IIO_EV_DIR_NONE,
+					      IIO_EV_TYPE_CHANGE, 0, 0, 0),
+			       iio_get_time_ns(indio_dev));
+		ret = IRQ_HANDLED;
+	}
+
 	return ret;
 }
 
-- 
2.17.1

