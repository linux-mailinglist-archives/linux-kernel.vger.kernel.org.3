Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5314502AC9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 15:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354032AbiDONEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 09:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353934AbiDONDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 09:03:08 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0CB38DBE;
        Fri, 15 Apr 2022 06:00:38 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id s25so9388535edi.13;
        Fri, 15 Apr 2022 06:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VpFBoAucMx04fhru/HPVc9hMh3ZoQXSwPzGm5hltfNo=;
        b=i172QEL5bfupTDD+QAlNuNmKCGRWSKLevAT7xOV668pXAUZJ8TzNB1+5fbfxAgFbyo
         5X3mzpQAsc9UnZTl0Z3MrmbcVewm2w1kdLtZTNuo4Xw4S4SgXB2zFEsqvwZq3G503jEW
         f5mcj03Qd3y0enRXczTiUFSma9+ffda+GciwA/Fa8Qw20vea41N5Ec5ToNHxgnlmEBdt
         xsK3RbU1BlhdOrpMwmJyO6Z7Tu5UZSAvjV70ddJFGTJy4Qe88I2wC1gn16GuSYlXUClN
         6QmhWsDcN09JuptXOnRd+8bQmhSOiln7ntPWdUF7NJwH/kZQf1bmlkwyPZifDPuT1HC6
         iLtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VpFBoAucMx04fhru/HPVc9hMh3ZoQXSwPzGm5hltfNo=;
        b=7IjUsau4BkZdub1fxeb0L/FMtKoTyvPEsCBGyqx00KsSQfz8O2E1M6JruiuHxiuSDx
         UazCKy6jem88CYLPA5RBZ5TAJ6C0q0CMmiE7SoF/nKFsnZdUz9bvNeMB+lg0WxEv+1tL
         YzZfGNTdibd5HNyIIUtY5zKnBT6VYgRGuRHxYHHZv5TPiQYo5Qn77uCqgTotBBMj88HE
         0AVvfQEGnc3lMC1u5DyWOZ/8i2FMbihNfdfQEtubJ0oCMDFQTNxNO6JIOz4oCOR9TAOS
         lzO/eFMkSqnaG5I9nILffWqU6QX27d6xieb48VvDeURC8CF73qap77kVqgRHyDP5AmZN
         i/mQ==
X-Gm-Message-State: AOAM533Q+4Y5RX0UK0Xbd36EzT2RP1V7U4ImqUGqwpRstIlZEbFURelp
        xVzutAooWm7wVAJ/F/41c7h1UJ4yLERqGA==
X-Google-Smtp-Source: ABdhPJxnZUUC94sg6voi28VCF+ntH3/s5jDYmH/+AsUAl6AgnY/tSCBR5VdAGV+5QnkxzpN3y2ag3A==
X-Received: by 2002:a05:6402:34c8:b0:420:d786:bbcf with SMTP id w8-20020a05640234c800b00420d786bbcfmr8296488edc.73.1650027637134;
        Fri, 15 Apr 2022 06:00:37 -0700 (PDT)
Received: from poker.lan (static.2-229-210-222.ip198.fastwebnet.it. [2.229.210.222])
        by smtp.gmail.com with ESMTPSA id i26-20020a50d75a000000b0041e84bb406fsm2704715edj.0.2022.04.15.06.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 06:00:36 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@iit.it>
Subject: [v4 13/14] iio: imu: add BNO055 I2C driver
Date:   Fri, 15 Apr 2022 15:00:04 +0200
Message-Id: <20220415130005.85879-14-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220415130005.85879-1-andrea.merello@gmail.com>
References: <20220415130005.85879-1-andrea.merello@gmail.com>
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

From: Andrea Merello <andrea.merello@iit.it>

This path adds an I2C driver for communicating to a BNO055 IMU via I2C
bus and it enables the BNO055 core driver to work in this scenario.

Signed-off-by: Andrea Merello <andrea.merello@iit.it>
---
 drivers/iio/imu/bno055/Kconfig      | 11 ++++++
 drivers/iio/imu/bno055/Makefile     |  1 +
 drivers/iio/imu/bno055/bno055_i2c.c | 56 +++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+)
 create mode 100644 drivers/iio/imu/bno055/bno055_i2c.c

diff --git a/drivers/iio/imu/bno055/Kconfig b/drivers/iio/imu/bno055/Kconfig
index 5a1a574c9770..38b461646c02 100644
--- a/drivers/iio/imu/bno055/Kconfig
+++ b/drivers/iio/imu/bno055/Kconfig
@@ -18,3 +18,14 @@ config BOSCH_BNO055_SERDEV_TRACING
        depends on EVENT_TRACING && BOSCH_BNO055_SERIAL
        help
          Enable this to enable trace events for the BNO055 serdev driver.
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
index 20128b1a1afc..20f911aad94b 100644
--- a/drivers/iio/imu/bno055/Makefile
+++ b/drivers/iio/imu/bno055/Makefile
@@ -2,5 +2,6 @@
 
 obj-$(CONFIG_BOSCH_BNO055_IIO) += bno055.o
 obj-$(CONFIG_BOSCH_BNO055_SERIAL) += bno055_ser.o
+obj-$(CONFIG_BOSCH_BNO055_I2C) += bno055_i2c.o
 
 CFLAGS_bno055_ser.o := -I$(src)
diff --git a/drivers/iio/imu/bno055/bno055_i2c.c b/drivers/iio/imu/bno055/bno055_i2c.c
new file mode 100644
index 000000000000..d59bb4e661be
--- /dev/null
+++ b/drivers/iio/imu/bno055/bno055_i2c.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Support for I2C-interfaced Bosch BNO055 IMU.
+ *
+ * Copyright (C) 2021-2022 Istituto Italiano di Tecnologia
+ * Electronic Design Laboratory
+ * Written by Andrea Merello <andrea.merello@iit.it>
+ */
+
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#include "bno055.h"
+
+#define BNO055_I2C_XFER_BURST_BREAK_THRESHOLD 3 /* FIXME */
+
+static int bno055_i2c_probe(struct i2c_client *client)
+{
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_i2c(client, &bno055_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(&client->dev, PTR_ERR(regmap),
+				     "Unable to init register map");
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
+static const struct of_device_id __maybe_unused bno055_i2c_of_match[] = {
+	{ .compatible = "bosch,bno055" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, bno055_i2c_of_match);
+
+static struct i2c_driver bno055_driver = {
+	.driver = {
+		.name = "bno055-i2c",
+		.of_match_table = of_match_ptr(bno055_i2c_of_match),
+	},
+	.probe_new = bno055_i2c_probe,
+	.id_table = bno055_i2c_id,
+};
+module_i2c_driver(bno055_driver);
+
+MODULE_AUTHOR("Andrea Merello");
+MODULE_DESCRIPTION("Bosch BNO055 I2C interface");
+MODULE_IMPORT_NS(IIO_BNO055);
+MODULE_LICENSE("GPL");
-- 
2.17.1

