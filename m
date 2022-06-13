Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2005554B0AB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 14:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235410AbiFNM2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 08:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbiFNM16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 08:27:58 -0400
Received: from es400ra02.iit.it (mx.iit.it [90.147.26.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDF921269;
        Tue, 14 Jun 2022 05:27:50 -0700 (PDT)
Received: from es400ra02.iit.it (127.0.0.1) id hl1vc40171s9; Mon, 13 Jun 2022 14:05:57 +0200 (envelope-from <prvs=1163b4114e=Andrea.Merello@iit.it>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iit.it;
        s=mx; i=@iit.it; h=Received:Received:From:To:CC:Subject:Date:
        Message-ID:In-Reply-To:References:MIME-Version:
        Content-Transfer-Encoding:Content-Type; bh=l8Ahxgl+9kp6R2YaL5zEc
        e2N/Lu7/gPoBOC+0RYxG7w=; b=HbkqlXgSkqXTuyBFoGd441G7xXfDp8vpml+FZ
        /h+lVGxnfgphKJ0/CeMP/gYmFDLAzZ5/9rzY2rCQgCMVuZW1dEitNZfZetH9QcB4
        hdsQ0Xa2ErFGN7TGH0CoK7BRDhjVFfHqV4eGg2mepCbK19Kp1rsEwsBgco4tZOvZ
        RZrV5E=
Received: from mail.iit.it ([10.255.8.186])
        by es400ra02.iit.it ([172.31.0.242]) (SonicWall 10.0.16.7295)
        with ESMTPS (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256)
        id o202206131205570231027-8; Mon, 13 Jun 2022 14:05:57 +0200
Received: from poker.lan (90.147.26.235) by iitmxwge020.iit.local
 (10.255.8.186) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.17; Mon, 13 Jun
 2022 14:05:56 +0200
From:   <andrea.merello@iit.it>
To:     <jic23@kernel.org>, <mchehab+huawei@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <lars@metafoo.de>, <robh+dt@kernel.org>,
        <andy.shevchenko@gmail.com>, <matt.ranostay@konsulko.com>,
        <ardeleanalex@gmail.com>, <jacopo@jmondi.org>,
        Andrea Merello <andrea.merello@iit.it>
Subject: [v6 13/14] iio: imu: add BNO055 I2C driver
Date:   Mon, 13 Jun 2022 14:05:33 +0200
Message-ID: <20220613120534.36991-14-andrea.merello@iit.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220613120534.36991-1-andrea.merello@iit.it>
References: <20220613120534.36991-1-andrea.merello@iit.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [90.147.26.235]
X-ClientProxiedBy: IITMXWGE021.iit.local (10.255.8.187) To
 iitmxwge020.iit.local (10.255.8.186)
X-Mlf-DSE-Version: 6873
X-Mlf-Rules-Version: s20220519150137; ds20200715013501;
        di20220610180234; ri20160318003319; fs20220610211824
X-Mlf-Smartnet-Version: 20210917223710
X-Mlf-Envelope-From: Andrea.Merello@iit.it
X-Mlf-Version: 10.0.16.7295
X-Mlf-License: BSV_C_AP_T_R
X-Mlf-UniqueId: o202206131205570231027
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Merello <andrea.merello@iit.it>

Add an I2C driver for communicating to a BNO055 IMU via I2C bus and enable
the BNO055 core driver to work in this scenario.

Signed-off-by: Andrea Merello <andrea.merello@iit.it>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
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

