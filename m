Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B57B4FC5D0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 22:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbiDKUeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 16:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349872AbiDKUeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 16:34:05 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68EB35DD8;
        Mon, 11 Apr 2022 13:31:50 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id be5so8892116plb.13;
        Mon, 11 Apr 2022 13:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=835pUviTP5ppYn2Uev225f172MsZVkj8fAJp6g5nVbI=;
        b=XhPM9Xi4hI3zlMqpp9LPk3LS02QFPR2NAM7wG0m0iEvHU4D6z1teuac9/BCiuEWmLf
         T5mwJwanfwNd/iTQrKsEpaRy3SC0pZzOK9HdIDm5e+ata02srKGJLo8VN0biA0SUJ0iY
         V8hxRV93crh3RmX9H0364EpEa7J3BSjmYiMHhUFl3tAKFeDwkC//OBJqkGbY9qJ9zjFp
         ns7I9Md7bCPTiFHYr7pcG/bvil0cdjsrujzJ62CYM5AKD5QtKX8FR0ZXefbcn4o2/h73
         XDF6GhiLgJv1fCPIo4k3P12qW3C1YdiafeQ4Vg6vpb+K1Ep2rNcuwmy/FDov5S360Z2H
         G3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=835pUviTP5ppYn2Uev225f172MsZVkj8fAJp6g5nVbI=;
        b=hKEQOn2r/tyhHiKn2EuVsNEc5hMM8pOX35RsAKZmshmaQIhPK3IjZcqunkyZkIx2HF
         bTi2L+O3ZPneG4hB/RBba/aPbYcqKP0yHJTHZk11gugvcv5d2WEFxzPlk8HzShhnYO/J
         rvwEizrU9voVtcmWdQNji6GfPS5EkzyorQDWYUvPgXeu676+XHBaMAhj5WAixjsmbuhD
         UrUbZCM6VPU1fjiucOCbnIPC2WQAYK8U9eIKnyqJHqxO3rD8TSOWSVVkEmQJzeGph8iI
         ETirCrvZjuLeCayWLbiRGJEnzIN6qlHfLGxbtIg3mBJ3YEkKDI+HuBQpmfiwqEr84NHq
         FDqg==
X-Gm-Message-State: AOAM533XIf5MLPQQXizp18pc4PVufpalVQP2jJOZhRqDc9HIP9wBrvKq
        dgVzgYiLu8fcP0ywk1VCl/Q=
X-Google-Smtp-Source: ABdhPJynU3w14f8aoQPexTNCXrSK2rl3LVDMIRfan7vGLbnzrPwQestibKe5rO5e+naCZPyx6Xrp2Q==
X-Received: by 2002:a17:902:e889:b0:151:a56d:eb8f with SMTP id w9-20020a170902e88900b00151a56deb8fmr33124044plg.142.1649709110223;
        Mon, 11 Apr 2022 13:31:50 -0700 (PDT)
Received: from localhost.localdomain ([27.7.99.112])
        by smtp.gmail.com with ESMTPSA id z15-20020a056a001d8f00b004fda37855ddsm34069828pfw.168.2022.04.11.13.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 13:31:49 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     dan@dlrobertson.com, jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/9] iio: accel: bma400: Add separate channel for step counter
Date:   Tue, 12 Apr 2022 02:01:29 +0530
Message-Id: <20220411203133.19929-6-jagathjog1996@gmail.com>
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

Added channel for step counter which can be enable or disable
through the sysfs interface.

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 drivers/iio/accel/bma400.h      |  1 +
 drivers/iio/accel/bma400_core.c | 48 ++++++++++++++++++++++++++++++---
 2 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
index a7482a66b36b..52f9ea95de81 100644
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
index b7b2b67aef31..c8f147163d3c 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -20,6 +20,8 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 
+#include <asm/unaligned.h>
+
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/trigger.h>
@@ -67,6 +69,7 @@ struct bma400_data {
 	int oversampling_ratio;
 	int scale;
 	struct iio_trigger *trig;
+	int steps_enabled;
 	/* Correct time stamp alignment */
 	struct {
 		__le16 buff[3];
@@ -201,6 +204,12 @@ static const struct iio_chan_spec bma400_channels[] = {
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
 
@@ -705,13 +714,28 @@ static int bma400_read_raw(struct iio_dev *indio_dev,
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
@@ -752,6 +776,9 @@ static int bma400_read_raw(struct iio_dev *indio_dev,
 
 		*val = data->oversampling_ratio;
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_ENABLE:
+		*val = data->steps_enabled;
+		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
@@ -817,6 +844,17 @@ static int bma400_write_raw(struct iio_dev *indio_dev,
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
@@ -833,6 +871,8 @@ static int bma400_write_raw_get_fmt(struct iio_dev *indio_dev,
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

