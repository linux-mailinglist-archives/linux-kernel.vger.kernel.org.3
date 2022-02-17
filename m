Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6F64BA5BF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 17:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243223AbiBQQ2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 11:28:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243169AbiBQQ1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 11:27:51 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F5F9AD9B;
        Thu, 17 Feb 2022 08:27:36 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id cm8so971039edb.3;
        Thu, 17 Feb 2022 08:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vzovTl/jqBctY9Wgr8NGlwjyey7kAE9qazeOjjaFmFE=;
        b=Y26qCVcbVhLSulZRd0QT6IR37Qk3jWFZlSoHlq/2WQAJUyOSoz7JsIhOS0Q8y0c+nI
         yW4QPuJU/nZZEy7UKl3Fg27esghnzTfHf8gJvtK2QcKThwDzFP1uCZdO6tAmFbyRgMrN
         8bcIoq4i/4zSDBooGhqN5VizJWAvf1hMA4yJBGCroclO6XI+X4EBK71gx2hNfcuXOjBR
         I8yzV783dE4fzL1TEBmfGBrzSpU1Sf/vM5TwUfYLwqTvlISwQrTtMUwZ4sr5RQZ8Uj2F
         FZhkpny5K/OSPbUEyX4kx7XIvknyaExjfBw9IJeZThWwTZgFxXRslcQVCz0qBbRCyu8X
         oABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vzovTl/jqBctY9Wgr8NGlwjyey7kAE9qazeOjjaFmFE=;
        b=djjWQsWeATlOmSXm5Bdcabuf97hJ35YU+mn/6CVPsjiRo0DOKdKbVVCKsIVB8KFvPN
         H4iL+/oeZAgjGgXf9ojkjubXynAJ6Z4q6AFhUKT+hiC3VAqXvP8E1ILIMEUL5CQa0uLT
         oh6sx93CjWuvfwRnFibhnYXJvU4gElIeOsiKcdjqiesPOWQO1qEIsCIGkVtUmHtqyaYS
         wOF+yUe/0tf+xDB+GADRSWSFL6PhzCWNR2aO5uxSNPNb3eDd4Ofi9+kuAazltqdLEBWB
         Qm0DTm6qvKvTe3lItiduDvzd8kePr0AUknmZWzCpvb/Macd4dwGKmead96x4S52zU6Ec
         SbRA==
X-Gm-Message-State: AOAM533bVYwXpM1RYqriMArSvC9B5KZKuTItHmGuZ6diunewF/ndw0mL
        EiGn7of5JYXS9SUIBmfVOvs=
X-Google-Smtp-Source: ABdhPJw33QZ9iKLv6ORoshM/pjgLfmYsDSLJ9+/KkoQa0lnqJqwD7eHAqlULIgO6+vXzpI+Bm8ASIQ==
X-Received: by 2002:aa7:c582:0:b0:40a:92b2:1bc4 with SMTP id g2-20020aa7c582000000b0040a92b21bc4mr3520586edq.202.1645115254750;
        Thu, 17 Feb 2022 08:27:34 -0800 (PST)
Received: from poker.lan (static.2-229-210-222.ip198.fastwebnet.it. [2.229.210.222])
        by smtp.gmail.com with ESMTPSA id j13sm3653742edw.24.2022.02.17.08.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 08:27:34 -0800 (PST)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@gmail.com>,
        Andrea Merello <andrea.merello@iit.it>
Subject: [v3 12/13] iio: imu: add BNO055 I2C driver
Date:   Thu, 17 Feb 2022 17:27:09 +0100
Message-Id: <20220217162710.33615-13-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220217162710.33615-1-andrea.merello@gmail.com>
References: <20220217162710.33615-1-andrea.merello@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This path adds an I2C driver for communicating to a BNO055 IMU via I2C
bus and it enables the BNO055 core driver to work in this scenario.

Signed-off-by: Andrea Merello <andrea.merello@iit.it>
---
 drivers/iio/imu/bno055/Kconfig      | 11 +++++++
 drivers/iio/imu/bno055/Makefile     |  1 +
 drivers/iio/imu/bno055/bno055_i2c.c | 50 +++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+)
 create mode 100644 drivers/iio/imu/bno055/bno055_i2c.c

diff --git a/drivers/iio/imu/bno055/Kconfig b/drivers/iio/imu/bno055/Kconfig
index 8a83639ad2a9..3693a408e270 100644
--- a/drivers/iio/imu/bno055/Kconfig
+++ b/drivers/iio/imu/bno055/Kconfig
@@ -12,3 +12,14 @@ config BOSCH_BNO055_SERIAL
 
 	  This driver can also be built as a module. If so, the module will be
 	  called bno055_sl.
+
+config BOSCH_BNO055_I2C
+	tristate "Bosch BNO055 attached via I2C bus"
+	depends on I2C
+	select REGMAP_I2C
+	select BOSCH_BNO055_IIO
+	help
+	  Enable this to support Bosch BNO055 IMUs attached via I2C bus.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called bno055_i2c.
diff --git a/drivers/iio/imu/bno055/Makefile b/drivers/iio/imu/bno055/Makefile
index 416f0ff96de5..2fe2b0857903 100644
--- a/drivers/iio/imu/bno055/Makefile
+++ b/drivers/iio/imu/bno055/Makefile
@@ -2,3 +2,4 @@
 
 obj-$(CONFIG_BOSCH_BNO055_IIO) += bno055.o
 obj-$(CONFIG_BOSCH_BNO055_SERIAL) += bno055_sl.o
+obj-$(CONFIG_BOSCH_BNO055_I2C) += bno055_i2c.o
diff --git a/drivers/iio/imu/bno055/bno055_i2c.c b/drivers/iio/imu/bno055/bno055_i2c.c
new file mode 100644
index 000000000000..9900e2a4d905
--- /dev/null
+++ b/drivers/iio/imu/bno055/bno055_i2c.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Support for I2C-interfaced Bosch BNO055 IMU.
+ *
+ * Copyright (C) 2021 Istituto Italiano di Tecnologia
+ * Electronic Design Laboratory
+ * Written by Andrea Merello <andrea.merello@iit.it>
+ */
+
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+#include <linux/module.h>
+
+#include "bno055.h"
+
+#define BNO055_I2C_XFER_BURST_BREAK_THRESHOLD 3 /* FIXME */
+
+static int bno055_i2c_probe(struct i2c_client *client,
+			    const struct i2c_device_id *id)
+{
+	struct regmap *regmap =
+		devm_regmap_init_i2c(client, &bno055_regmap_config);
+
+	if (IS_ERR(regmap)) {
+		dev_err(&client->dev, "Unable to init register map");
+		return PTR_ERR(regmap);
+	}
+
+	return bno055_probe(&client->dev, regmap,
+			    BNO055_I2C_XFER_BURST_BREAK_THRESHOLD, true);
+}
+
+static const struct i2c_device_id bno055_i2c_id[] = {
+	{"bno055", 0},
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, bno055_i2c_id);
+
+static struct i2c_driver bno055_driver = {
+	.driver = {
+		.name = "bno055-i2c",
+	},
+	.probe = bno055_i2c_probe,
+	.id_table = bno055_i2c_id
+};
+module_i2c_driver(bno055_driver);
+
+MODULE_AUTHOR("Andrea Merello");
+MODULE_DESCRIPTION("Bosch BNO055 I2C interface");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

