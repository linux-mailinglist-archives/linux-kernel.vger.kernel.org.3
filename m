Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5555091DA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 23:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382405AbiDTVOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 17:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382376AbiDTVOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 17:14:07 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AE93C4B1;
        Wed, 20 Apr 2022 14:11:20 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id c23so2982219plo.0;
        Wed, 20 Apr 2022 14:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t5sPZakAg0ct8LT+itigj1pjaZMC1J3HuLuF+Ekf3LU=;
        b=p9S1lVu1ckEtxXD+cH0NNYPc9j1avtaWzgb7Noh+h3pv0zGKL+nc6gkqlKz3q47cro
         +khmYcjTWJl2LBLWRFwLP1LlzalZMuUNdQWKS1mVIW8j9xdvzE4jKL6VmDBPfkHDEMOL
         VrxFhJjp28iL+501Dm7A6kiuKOsZcfMqs7CYnX215qc9ZBooFJNpRUwSxwMe04zFOgnn
         fXqWU+7wMkDiHSEjOQ3g0IZOhhgtSqgi1Ak5Dn06cnXYYo9DEqNC4BDLzs9SNBxsc7y/
         LVEimhm6hnQq/CR9OWjeN8OD88MC+Qnpp2Rh11sJ9EGrWS7XGeGFdebmKQG0pJChfF4Y
         mXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t5sPZakAg0ct8LT+itigj1pjaZMC1J3HuLuF+Ekf3LU=;
        b=ku9ivwpPhfd3JJ0SUyIspHZ3lIHccU5037xkQOVu8OWglR5u9fDyjAVEqWAqHBAHPA
         9ksI9UK8K0Zj/miH4dRfoKJa5SJh5LZ0C/CaFfN/d0qSPYcI0v7AckkUGTWBivfwhFf/
         mdEgDE1WDNwp1G6USGQEVG60G+uQ+mRbzYHaM9r5FhASXA/vI1utamuqqn7DjIMYGVhs
         veRmKkt+KK/jDQEx6LXQEqEKXJc/eJZlkx8ZfwWfKyZC8W5BIoAXElhLRIdW/432LqKV
         psnIKmC58PspsIwEW5qT7ngtw63JuuFZtboQZFBKzmu7AlJgEFpsVFBTVPvgUulIsT6K
         a7TQ==
X-Gm-Message-State: AOAM530OacpvruO3aDieAt92HAuLOqIl/iJtNLSMDAsBe5xofxTEuksK
        ZJ1u/Kr+XGI962X86HOMyUc=
X-Google-Smtp-Source: ABdhPJwmAbmlO5UQJECtLFzG/OBi1lXS7QwYWUSkk8uflR7xgavuQnL3dfESEawIQaEo052HqmjKrw==
X-Received: by 2002:a17:902:b948:b0:153:9994:b587 with SMTP id h8-20020a170902b94800b001539994b587mr22755078pls.68.1650489080160;
        Wed, 20 Apr 2022 14:11:20 -0700 (PDT)
Received: from localhost.localdomain ([27.7.104.83])
        by smtp.gmail.com with ESMTPSA id v13-20020a17090a00cd00b001cd4989fee4sm106652pjd.48.2022.04.20.14.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 14:11:19 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     dan@dlrobertson.com, jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/9] iio: accel: bma400: Add separate channel for step counter
Date:   Thu, 21 Apr 2022 02:41:01 +0530
Message-Id: <20220420211105.14654-6-jagathjog1996@gmail.com>
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

Added channel for step counter which can be enable or disable
through the sysfs interface.

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 drivers/iio/accel/bma400.h      |  2 +
 drivers/iio/accel/bma400_core.c | 67 +++++++++++++++++++++++++++++++--
 2 files changed, 65 insertions(+), 4 deletions(-)

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
index 57910ccf9180..aafb5a40944d 100644
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
@@ -67,6 +70,7 @@ struct bma400_data {
 	int oversampling_ratio;
 	int scale;
 	struct iio_trigger *trig;
+	int steps_enabled;
 	/* Correct time stamp alignment */
 	struct {
 		__le16 buff[3];
@@ -202,6 +206,12 @@ static const struct iio_chan_spec bma400_channels[] = {
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
 
@@ -570,6 +580,38 @@ static int bma400_set_power_mode(struct bma400_data *data,
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
@@ -709,10 +751,17 @@ static int bma400_read_raw(struct iio_dev *indio_dev,
 
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
@@ -753,6 +802,9 @@ static int bma400_read_raw(struct iio_dev *indio_dev,
 
 		*val = data->oversampling_ratio;
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_ENABLE:
+		*val = data->steps_enabled;
+		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
@@ -818,6 +870,11 @@ static int bma400_write_raw(struct iio_dev *indio_dev,
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
@@ -834,6 +891,8 @@ static int bma400_write_raw_get_fmt(struct iio_dev *indio_dev,
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

