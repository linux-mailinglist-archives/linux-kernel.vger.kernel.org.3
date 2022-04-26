Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44BEF50FE95
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350708AbiDZNPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350743AbiDZNOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:14:34 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCF760AAD;
        Tue, 26 Apr 2022 06:11:23 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id k36-20020a05600c1ca400b00393f18c8fc5so1494269wms.4;
        Tue, 26 Apr 2022 06:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fNiY+gnAgGTG9yYAQiBJAjwz/XqTriPSXBVdo6NAMn4=;
        b=VDdoy/HoT4mP8e2l/VFTsUbHzRKwPkIIs+psTh+HwgFCfX6EWtfwOZLSv1+W7sATra
         8qnt2U/tWG4BMWPFBBCDFxMJOdLk6vCuHXysVgFVPqbWO3N7RtypyKzjgF7COk3//mnu
         f5ef79L/qg4nQxInfppnuCYUonP70n96Akj0a8z9Bh3fZAcbI3T9oAIPtBBEVHQz2LY0
         EZHVg9cDiggo1uvjBIWPq6ElISVGglg1/v99T/g2RFwlUohOTzWfLUJ2oxt4DQGebCw4
         Ye5hrmIGrLYnREkjE+x4HGY5jEyj7ctKO0eg39E3dbKSuvyxor38ow4AF+TlVlRE5KaF
         W1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fNiY+gnAgGTG9yYAQiBJAjwz/XqTriPSXBVdo6NAMn4=;
        b=qoVTH7X8+fTIIQ8FwCEuQ/N1DZWYOhWGux7yrsFcBUwUsTVQH4ZgE+NwAJFicDJxt+
         xTuBvF3sRM9ObYmA4sZWcFKBJdAwM/aVnmSO2BFLYikwfVscjItetCO/Axq1Q17nmN7L
         rkhLMm+dKRiyIUzdfobajsR80oX20kHli6PvCkoPKhoRH3ROZG/Aa/biYfpyilfqinFH
         agCc9uMxNRnfuRBxh2cL3a7+c/2vFap5t0lk/ifVLSR9BBcM/uitZ2elK0r9FMK5/0fh
         uOx+bYerkOgsZ9EM74JypLLddsZsAQyt93bJ62GNibX6NEfhdWC6GvAu88gCzlxUf1f6
         x+jA==
X-Gm-Message-State: AOAM531/SdS8BFMOJm/ZGqUhUbGbN5yOMzl90fmRIYGn24WPaN6kDcpk
        yIIGa4hUxm7L7NpkD/TRc9g=
X-Google-Smtp-Source: ABdhPJxxMjhXSo0DcvSB4cVbQABszdhFsbHtBet/KalIo7ahtC6BdZBf22mBt41Apr2IbCOl062wDQ==
X-Received: by 2002:a1c:4c05:0:b0:38e:b736:350 with SMTP id z5-20020a1c4c05000000b0038eb7360350mr30757265wmf.65.1650978681505;
        Tue, 26 Apr 2022 06:11:21 -0700 (PDT)
Received: from poker.lan (static.2-229-210-222.ip198.fastwebnet.it. [2.229.210.222])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c350900b00393f01c8f00sm3262910wmq.47.2022.04.26.06.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 06:11:21 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@iit.it>
Subject: [v5 13/14] iio: imu: add BNO055 I2C driver
Date:   Tue, 26 Apr 2022 15:11:01 +0200
Message-Id: <20220426131102.23966-14-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426131102.23966-1-andrea.merello@gmail.com>
References: <20220426131102.23966-1-andrea.merello@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Merello <andrea.merello@iit.it>

Add an I2C driver for communicating to a BNO055 IMU via I2C bus and enable
the BNO055 core driver to work in this scenario.

Signed-off-by: Andrea Merello <andrea.merello@iit.it>
---
 drivers/iio/imu/bno055/Kconfig      | 11 ++++++
 drivers/iio/imu/bno055/Makefile     |  2 +
 drivers/iio/imu/bno055/bno055_i2c.c | 57 +++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+)
 create mode 100644 drivers/iio/imu/bno055/bno055_i2c.c

diff --git a/drivers/iio/imu/bno055/Kconfig b/drivers/iio/imu/bno055/Kconfig
index d014b68cd43d..ccf9ea7c50f8 100644
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
index 212307ce9c08..f0be80accb5b 100644
--- a/drivers/iio/imu/bno055/Makefile
+++ b/drivers/iio/imu/bno055/Makefile
@@ -6,3 +6,5 @@ bno055_ser-y := bno055_ser_core.o
 # define_trace.h needs to know how to find our header
 CFLAGS_bno055_ser_trace.o := -I$(src)
 bno055_ser-$(CONFIG_TRACING) += bno055_ser_trace.o
+
+obj-$(CONFIG_BOSCH_BNO055_I2C) += bno055_i2c.o
diff --git a/drivers/iio/imu/bno055/bno055_i2c.c b/drivers/iio/imu/bno055/bno055_i2c.c
new file mode 100644
index 000000000000..9bb256fdb0d3
--- /dev/null
+++ b/drivers/iio/imu/bno055/bno055_i2c.c
@@ -0,0 +1,57 @@
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
+#include <linux/mod_devicetable.h>
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

