Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FF94DE9F2
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 19:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243841AbiCSSMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 14:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243791AbiCSSL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 14:11:59 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937978FE60;
        Sat, 19 Mar 2022 11:10:38 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id o13so7384430pgc.12;
        Sat, 19 Mar 2022 11:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xAshbbCBTuYOBwYQ431+MMdTrkfc3vce11+ie44orN0=;
        b=JnMentE4eJhOuVigDnrFALlsPP8Hou2yOZKShv4MPkV3GXbl83FJRE33TV/ywaIzrj
         mmVUXJ2vPz+KPP1iSxyVGNMUZWmBboPg/zSA4Un++uv6jQIZbUuL39eyxVY+X7wsOX/e
         EyNC1xhCV7PKjGxvfTPZHnk2KsuqMORYsfjv6rYXB2qHbpMNYE8Ufrsqm6cHSkLNfx54
         A4k6eaDtvqN+AP52pLPsQRyRaiG4L8RE7odJE6gh860W1Edo1Z0bfra6cy1AaSWrxvSd
         uKfJ31zbGm3dZ34jcwfLzpuNHeUFS+khOA5ihicUwnLDXDbGKm+deUcvNOkYWVKuTtTw
         /a9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xAshbbCBTuYOBwYQ431+MMdTrkfc3vce11+ie44orN0=;
        b=3h0Do/xLmKhq4Gq4xPnWyVwMbAjfZLYWWUXxvliKi8X20YtsrA5Dg0Ir8lsvXV2onL
         QyyRf4Ch+4IkFkS5KrXrMj2tWgKPS7hHUrBSezMUq+Dt9ccVwvWF19d7wiJzrMX/jm/H
         ARXUEhA32IrD+kUil1RCVF6Zj/aQ2twfZQYcDuVrG/EAlSLI+5mGd2zGOyqgwmd0l4JG
         wGBBuwHJCPIUMgDWcmvItUi2LngjjU6MLkwDVVOZwYPvDFhpQ/ckNXzo72WzDA2zbuQc
         O807bJCFACk4+8FJ5VQVzkGSSGCJf3k0yCNVCNoS6lkkC+My/4USFpgZaIFZ7D0BXMgm
         XyrQ==
X-Gm-Message-State: AOAM532ebVxiY6ABzk7hSnn/yucHzu9+zUBn03U/d1lg1inHKL3qWQ2h
        wBUJ+xK7RY6ef+a6XzESiX3IcuwtU5wknw==
X-Google-Smtp-Source: ABdhPJxuG8XtKSOpvdZ+GqckD15RBfeXvPQ4EcpqjJsNHvcvMX3u+jb16/CMEhgE30lagYb6AXvdJw==
X-Received: by 2002:aa7:82d9:0:b0:4fa:2c7f:41e with SMTP id f25-20020aa782d9000000b004fa2c7f041emr15866562pfn.1.1647713438015;
        Sat, 19 Mar 2022 11:10:38 -0700 (PDT)
Received: from localhost.localdomain ([115.99.145.231])
        by smtp.gmail.com with ESMTPSA id nu4-20020a17090b1b0400b001bf497a9324sm16413981pjb.31.2022.03.19.11.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 11:10:37 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     dan@dlrobertson.com, jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/5] iio: accel: bma400: Add separate channel for step counter
Date:   Sat, 19 Mar 2022 23:40:22 +0530
Message-Id: <20220319181023.8090-5-jagathjog1996@gmail.com>
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

Added channel for step counter which can be enable or disable
through the sysfs interface.

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 drivers/iio/accel/bma400.h      |  1 +
 drivers/iio/accel/bma400_core.c | 47 ++++++++++++++++++++++++++++++---
 2 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
index b306a5ad513a..65bbc80cbb7f 100644
--- a/drivers/iio/accel/bma400.h
+++ b/drivers/iio/accel/bma400.h
@@ -53,6 +53,7 @@
 #define BMA400_STEP_CNT1_REG        0x16
 #define BMA400_STEP_CNT3_REG        0x17
 #define BMA400_STEP_STAT_REG        0x18
+#define BMA400_STEP_INT_MSK         BIT(0)
 
 /*
  * Read-write configuration registers
diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index 797403c7dd85..305643e99eb5 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -68,6 +68,7 @@ struct bma400_data {
 	int oversampling_ratio;
 	int scale;
 	struct iio_trigger *trig;
+	int steps_enabled;
 	/* Correct time stamp alignment */
 	struct {
 		__be16 buff[3];
@@ -202,6 +203,13 @@ static const struct iio_chan_spec bma400_channels[] = {
 			.endianness = IIO_LE,
 		},
 	},
+	{
+		.type = IIO_STEPS,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+				      BIT(IIO_CHAN_INFO_ENABLE),
+		.scan_index = -1, /* No buffer support */
+	},
+
 	IIO_CHAN_SOFT_TIMESTAMP(4),
 };
 
@@ -686,13 +694,28 @@ static int bma400_read_raw(struct iio_dev *indio_dev,
 {
 	struct bma400_data *data = iio_priv(indio_dev);
 	int ret;
+	u32 steps_raw;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_PROCESSED:
-		mutex_lock(&data->mutex);
-		ret = bma400_get_temp_reg(data, val, val2);
-		mutex_unlock(&data->mutex);
-		return ret;
+		switch (chan->type) {
+		case IIO_STEPS:
+			mutex_lock(&data->mutex);
+			ret = regmap_bulk_read(data->regmap, BMA400_STEP_CNT0_REG,
+					       &steps_raw, 3 * sizeof(u8));
+			mutex_unlock(&data->mutex);
+			if (ret)
+				return ret;
+			*val = steps_raw & 0x00FFFFFF;
+			return IIO_VAL_INT;
+		case IIO_TEMP:
+			mutex_lock(&data->mutex);
+			ret = bma400_get_temp_reg(data, val, val2);
+			mutex_unlock(&data->mutex);
+			return ret;
+		default:
+			return -EINVAL;
+		}
 	case IIO_CHAN_INFO_RAW:
 		mutex_lock(&data->mutex);
 		ret = bma400_get_accel_reg(data, chan, val);
@@ -733,6 +756,9 @@ static int bma400_read_raw(struct iio_dev *indio_dev,
 
 		*val = data->oversampling_ratio;
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_ENABLE:
+		*val = data->steps_enabled;
+		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
@@ -798,6 +824,17 @@ static int bma400_write_raw(struct iio_dev *indio_dev,
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
@@ -814,6 +851,8 @@ static int bma400_write_raw_get_fmt(struct iio_dev *indio_dev,
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

