Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2196D51C0CD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 15:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379717AbiEENep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 09:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379561AbiEENeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 09:34:18 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61881277A;
        Thu,  5 May 2022 06:30:38 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id n8so4417931plh.1;
        Thu, 05 May 2022 06:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=51mDZ0cyY489Y5og5yHEw5jaChmCSfiAiqAL0DmhUXw=;
        b=W5gfZdBHv3/QtOTMCzdHXm3MH44sEXegpd+TJRM1MCjGjtp6ZnfaKYlOEhrqk8pwvf
         FjbrczsdeLWAvlf6JDJO4c8bKmMy7HgfOby54F70XX4sla/eF6XAextoZB/jSYPndNUk
         hMHqHy5ZC0WsFc46XVZli/1pnbpdVY2704avm7L6snqzVKL6as9s4sfVqDHslZBsdJ8j
         hfYLpthx6qEijc9AX+eKJbuuzcd6BUFkutGLU7K4N0WhUX7zKIIx1U0iqoeQJZIE/l8J
         +jaB7Xfaio4i2Tqw763L5PHGcE6TrIaw+iuRk4RA5mMKk3Pc55mdiy8BwdmCzXP4L45j
         LvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=51mDZ0cyY489Y5og5yHEw5jaChmCSfiAiqAL0DmhUXw=;
        b=NuBzHRi2TmMCK2mS7y1594MCpioAJc3FqIsHuh94ZgU7ha9rNLQ5f/X/tu2KZ96EBR
         HicF/f6jp913nCFR4ACENpyDLZ2beq36FBgDHDkX+r9jrHE2A3PE/iVm+MAAgptK1CWv
         irwG2UNyaFisYUTngEBOgr5Fy/afSWUAuK9IsZJqsOWcBPSgapvU5Jpt055bcXEjJzEf
         eb3VnSSIqDaPvh4EGPEi/kJvC7sJeecN2C/EAD9lEXbKde6yc81QX8WbFMST5YVBjnlH
         kATurGHLb4e18U1BKg6zKEW50yMW0pUIcEatQU9nU54IrUWIeNa2t2tnkA0/TqPGuy3j
         q7PA==
X-Gm-Message-State: AOAM532f8T4U1uvCGI0O68S3HIHj9JXO/GNjHfDar1Dp6Yo7IfGJnpWn
        dNlsKziiCEaS4oMu46fV434=
X-Google-Smtp-Source: ABdhPJwSacmVgbxtXPGN4e7Dr103aA7fH/UYZnnVDm5WfNUn6YR8wN/EeVUgfnGA3MWO3PSiWCuxiw==
X-Received: by 2002:a17:902:a502:b0:15e:c251:b769 with SMTP id s2-20020a170902a50200b0015ec251b769mr9830558plq.115.1651757438087;
        Thu, 05 May 2022 06:30:38 -0700 (PDT)
Received: from localhost.localdomain ([115.99.184.228])
        by smtp.gmail.com with ESMTPSA id c64-20020a624e43000000b0050dc7628135sm1420120pfb.15.2022.05.05.06.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 06:30:37 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     dan@dlrobertson.com, jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 05/10] iio: accel: bma400: Add separate channel for step counter
Date:   Thu,  5 May 2022 19:00:16 +0530
Message-Id: <20220505133021.22362-6-jagathjog1996@gmail.com>
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

Added channel for step counter which can be enable or disable
through the sysfs interface.

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 drivers/iio/accel/bma400.h      |  2 +
 drivers/iio/accel/bma400_core.c | 69 +++++++++++++++++++++++++++++++--
 2 files changed, 67 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
index 907e1a6c0a38..32c08f8b0b98 100644
--- a/drivers/iio/accel/bma400.h
+++ b/drivers/iio/accel/bma400.h
@@ -53,6 +53,8 @@
 #define BMA400_STEP_CNT1_REG        0x16
 #define BMA400_STEP_CNT3_REG        0x17
 #define BMA400_STEP_STAT_REG        0x18
+#define BMA400_STEP_INT_MSK         BIT(0)
+#define BMA400_STEP_RAW_LEN         0x03
 
 /*
  * Read-write configuration registers
diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index 67e102c097bc..fdb7e8bd7b27 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -19,6 +19,9 @@
 #include <linux/mutex.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+
+#include <asm/unaligned.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
@@ -74,6 +77,7 @@ struct bma400_data {
 	int oversampling_ratio;
 	int scale;
 	struct iio_trigger *trig;
+	int steps_enabled;
 	/* Correct time stamp alignment */
 	struct {
 		__le16 buff[3];
@@ -209,6 +213,12 @@ static const struct iio_chan_spec bma400_channels[] = {
 			.endianness = IIO_LE,
 		},
 	},
+	{
+		.type = IIO_STEPS,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+				      BIT(IIO_CHAN_INFO_ENABLE),
+		.scan_index = -1, /* No buffer support */
+	},
 	IIO_CHAN_SOFT_TIMESTAMP(4),
 };
 
@@ -577,6 +587,40 @@ static int bma400_set_power_mode(struct bma400_data *data,
 	return 0;
 }
 
+static int bma400_enable_steps(struct bma400_data *data, int val)
+{
+	int ret;
+
+	if (data->steps_enabled == val)
+		return 0;
+
+	ret = regmap_update_bits(data->regmap, BMA400_INT_CONFIG1_REG,
+				 BMA400_STEP_INT_MSK,
+				 FIELD_PREP(BMA400_STEP_INT_MSK, !!val));
+	if (ret)
+		return ret;
+	data->steps_enabled = val;
+	return ret;
+}
+
+static int bma400_get_steps_reg(struct bma400_data *data, int *val)
+{
+	u8 *steps_raw;
+	int ret;
+
+	steps_raw = kmalloc(BMA400_STEP_RAW_LEN, GFP_KERNEL);
+	if (!steps_raw)
+		return -ENOMEM;
+
+	ret = regmap_bulk_read(data->regmap, BMA400_STEP_CNT0_REG,
+			       steps_raw, BMA400_STEP_RAW_LEN);
+	if (ret)
+		return ret;
+	*val = get_unaligned_le24(steps_raw);
+	kfree(steps_raw);
+	return IIO_VAL_INT;
+}
+
 static void bma400_init_tables(void)
 {
 	int raw;
@@ -716,10 +760,17 @@ static int bma400_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_PROCESSED:
-		mutex_lock(&data->mutex);
-		ret = bma400_get_temp_reg(data, val, val2);
-		mutex_unlock(&data->mutex);
-		return ret;
+		switch (chan->type) {
+		case IIO_TEMP:
+			mutex_lock(&data->mutex);
+			ret = bma400_get_temp_reg(data, val, val2);
+			mutex_unlock(&data->mutex);
+			return ret;
+		case IIO_STEPS:
+			return bma400_get_steps_reg(data, val);
+		default:
+			return -EINVAL;
+		}
 	case IIO_CHAN_INFO_RAW:
 		mutex_lock(&data->mutex);
 		ret = bma400_get_accel_reg(data, chan, val);
@@ -760,6 +811,9 @@ static int bma400_read_raw(struct iio_dev *indio_dev,
 
 		*val = data->oversampling_ratio;
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_ENABLE:
+		*val = data->steps_enabled;
+		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
@@ -825,6 +879,11 @@ static int bma400_write_raw(struct iio_dev *indio_dev,
 		ret = bma400_set_accel_oversampling_ratio(data, val);
 		mutex_unlock(&data->mutex);
 		return ret;
+	case IIO_CHAN_INFO_ENABLE:
+		mutex_lock(&data->mutex);
+		ret = bma400_enable_steps(data, val);
+		mutex_unlock(&data->mutex);
+		return ret;
 	default:
 		return -EINVAL;
 	}
@@ -841,6 +900,8 @@ static int bma400_write_raw_get_fmt(struct iio_dev *indio_dev,
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_ENABLE:
+		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
-- 
2.17.1

