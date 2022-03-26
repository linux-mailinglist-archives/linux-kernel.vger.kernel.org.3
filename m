Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D894E83D5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 20:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234812AbiCZTnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 15:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234790AbiCZTnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 15:43:37 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F29174BB7;
        Sat, 26 Mar 2022 12:41:59 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id e5so11456550pls.4;
        Sat, 26 Mar 2022 12:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dDuXdIX9ztuO+V8BPkvUWGSMJTVD8xCUW3sKbXhy9IY=;
        b=Z7pAq5ZHSpQm6DtWxwcYpAPFaEPn+JMNAJGdVjYpAKl+WP/TnGQOuUXvYBbTi8dJYI
         aR54n+nqlxgWdPkobYBHpJOKSbFx+qOfMZE4xE3icRzyKavDrYtfGbApgZwhdeuGoTjf
         WVvAaVZMVS9LrApvHZZb3rvDC8jc2IdmNvXkTB5Ls0t+DToKIeuD5MQ8wvwg+8Nhp1Jf
         Gy0KcQkxf3UHTb2g3hJb0tzbZb95FBaGHEeRwtfXJjGvwT5/wvAXchJyH9Lqd73P2KB9
         zUvMUkh8U6Ml+o6dIBcmwwZEVLyOQUvsg6fIPGPGmcfKwAuSB+SazJqEFsdz3ncU6Tip
         A29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dDuXdIX9ztuO+V8BPkvUWGSMJTVD8xCUW3sKbXhy9IY=;
        b=gXL2Q5Ildo25hBg3RGEe4h8ZtO0CwYBYBE34AjIijX46uU54WQglot23K3CfjhKM3j
         LruWtMWKBkyZvx/ZFT5FS6Qxlds8ZTNbDZ0gUStyy7eRKgsfxt7WHKw7KeAXk58kW7PL
         +HK55RwHMNTZbWUy6VfoXOLbx3mnRJzFSDLxcz/WzFWwxv4lY4ZnJ3gms6qSnO0Efr4f
         h/dE/md7AO4H/HsQJHQW2cSP55kasIB/sQSZWlM1GHrmigANxh73F9uJjbeGciPOpJXM
         67uNfnJpL8L3TY2eCNxu31YhnsDKublUtApTGKFbX9QA+br1/zEOiKHMOdOiIyiRvdzR
         Tmpw==
X-Gm-Message-State: AOAM530Ji6JYuSLax59KlHHVzPJ3sCM1GBf22kX7v2SNPq4BT6W4JRla
        Xi0EWT+XGpTpdWpnQOzheh0=
X-Google-Smtp-Source: ABdhPJwKExcEC7UIysNSn9RE9WEtIAfid0mn6hSDFYe4xnmmy9lmJcogdTLDFYwgEi/JzwY3AECP+Q==
X-Received: by 2002:a17:902:edd5:b0:153:abee:1093 with SMTP id q21-20020a170902edd500b00153abee1093mr18775290plk.77.1648323719355;
        Sat, 26 Mar 2022 12:41:59 -0700 (PDT)
Received: from localhost.localdomain ([116.75.119.161])
        by smtp.gmail.com with ESMTPSA id k185-20020a6384c2000000b003821dcd9020sm8778784pgd.27.2022.03.26.12.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 12:41:59 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     dan@dlrobertson.com, jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] iio: accel: bma400: Add separate channel for step counter
Date:   Sun, 27 Mar 2022 01:11:45 +0530
Message-Id: <20220326194146.15549-5-jagathjog1996@gmail.com>
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

Added channel for step counter which can be enable or disable
through the sysfs interface.

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 drivers/iio/accel/bma400.h      |  1 +
 drivers/iio/accel/bma400_core.c | 47 ++++++++++++++++++++++++++++++---
 2 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
index 24d2b705343a..c9b856b37021 100644
--- a/drivers/iio/accel/bma400.h
+++ b/drivers/iio/accel/bma400.h
@@ -53,6 +53,7 @@
 #define BMA400_STEP_CNT1_REG        0x16
 #define BMA400_STEP_CNT3_REG        0x17
 #define BMA400_STEP_STAT_REG        0x18
+#define BMA400_STEP_INT_MSK	    BIT(0)
 
 /*
  * Read-write configuration registers
diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index fa3f4b5f229f..ec2f9c380bda 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -19,6 +19,7 @@
 #include <linux/mutex.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <asm/unaligned.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -68,6 +69,7 @@ struct bma400_data {
 	int oversampling_ratio;
 	int scale;
 	struct iio_trigger *trig;
+	int steps_enabled;
 	/* Correct time stamp alignment */
 	struct {
 		__le16 buff[3];
@@ -202,6 +204,12 @@ static const struct iio_chan_spec bma400_channels[] = {
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
 
@@ -706,13 +714,28 @@ static int bma400_read_raw(struct iio_dev *indio_dev,
 {
 	struct bma400_data *data = iio_priv(indio_dev);
 	int ret;
+	u8 steps_raw[3];
 
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
+			mutex_lock(&data->mutex);
+			ret = regmap_bulk_read(data->regmap, BMA400_STEP_CNT0_REG,
+					       &steps_raw, sizeof(steps_raw));
+			mutex_unlock(&data->mutex);
+			if (ret)
+				return ret;
+			*val = get_unaligned_le24(steps_raw);
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
 	case IIO_CHAN_INFO_RAW:
 		mutex_lock(&data->mutex);
 		ret = bma400_get_accel_reg(data, chan, val);
@@ -753,6 +776,9 @@ static int bma400_read_raw(struct iio_dev *indio_dev,
 
 		*val = data->oversampling_ratio;
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_ENABLE:
+		*val = data->steps_enabled;
+		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
@@ -818,6 +844,17 @@ static int bma400_write_raw(struct iio_dev *indio_dev,
 		ret = bma400_set_accel_oversampling_ratio(data, val);
 		mutex_unlock(&data->mutex);
 		return ret;
+	case IIO_CHAN_INFO_ENABLE:
+		if (data->steps_enabled == val)
+			return 0;
+
+		mutex_lock(&data->mutex);
+		ret = regmap_update_bits(data->regmap, BMA400_INT_CONFIG1_REG,
+					 BMA400_STEP_INT_MSK,
+					 FIELD_PREP(BMA400_STEP_INT_MSK, !!val));
+		mutex_unlock(&data->mutex);
+		data->steps_enabled = val;
+		return ret;
 	default:
 		return -EINVAL;
 	}
@@ -834,6 +871,8 @@ static int bma400_write_raw_get_fmt(struct iio_dev *indio_dev,
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

