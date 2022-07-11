Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7412A570128
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiGKLt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiGKLtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:49:17 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BB011827;
        Mon, 11 Jul 2022 04:49:15 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26B8F9ws029442;
        Mon, 11 Jul 2022 13:48:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=Bu5xyPbtPYx5VqFElRIOuAZAo8muyqqWqfpgWulD9O8=;
 b=khfTXDnMdgL/6KBkVJiFmPPvhgHuqT65F31UyjDfFac2a2yro+CStURadEFI1tSwD1fe
 +eq3MlHGZyiUp9oO/KJV9uvGKD8/rITlm7MnLmys8ZFAITBztvxW6Sr1KMVxXU1agLjZ
 10TUh/Fa6/EJCpmQBW5BJwSIv2ik5Ooe8yOJ/9kbc/1xq2bLtNSq6X7o3JJL5o1lJrn5
 yWLiYLRRN4G2cGNeOrO6gvcy+I/enLYOlNGvAqe6Ji1nfMHO52HUrdaNBiLA5I2zdAS5
 sFsfCGDezw90qhEWY/z8Zug80PpKp+h6MdF70Y9j696ahUABOJEbntcCKW5abWVhafgb zw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3h6xtak3vs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 13:48:48 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 64DF1100038;
        Mon, 11 Jul 2022 13:48:47 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5DDDC21D385;
        Mon, 11 Jul 2022 13:48:47 +0200 (CEST)
Received: from localhost (10.75.127.48) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Mon, 11 Jul
 2022 13:48:47 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <heikki.krogerus@linux.intel.com>, <gregkh@linuxfoundation.org>
CC:     <christophe.jaillet@wanadoo.fr>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <amelie.delaunay@foss.st.com>, <alexandre.torgue@foss.st.com>,
        <fabrice.gasnier@foss.st.com>
Subject: [PATCH v2 2/4] usb: typec: ucsi: stm32g0: add support for stm32g0 i2c controller
Date:   Mon, 11 Jul 2022 13:48:29 +0200
Message-ID: <20220711114831.25205-3-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220711114831.25205-1-fabrice.gasnier@foss.st.com>
References: <20220711114831.25205-1-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-11_17,2022-07-08_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

STM32G0 provides an integrated USB Type-C and power delivery interface.
It can be programmed with a firmware to handle UCSI protocol over I2C
interface. A GPIO is used as an interrupt line.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v2:
Christophe's remarks:
- use kmalloc instead of kzalloc
- Use-after-free of buf: directly print the offset
---
 drivers/usb/typec/ucsi/Kconfig        |  10 ++
 drivers/usb/typec/ucsi/Makefile       |   1 +
 drivers/usb/typec/ucsi/ucsi_stm32g0.c | 218 ++++++++++++++++++++++++++
 3 files changed, 229 insertions(+)
 create mode 100644 drivers/usb/typec/ucsi/ucsi_stm32g0.c

diff --git a/drivers/usb/typec/ucsi/Kconfig b/drivers/usb/typec/ucsi/Kconfig
index 5e9b37b3f25e1..8f9c4b9f31f79 100644
--- a/drivers/usb/typec/ucsi/Kconfig
+++ b/drivers/usb/typec/ucsi/Kconfig
@@ -48,4 +48,14 @@ config UCSI_ACPI
 	  To compile the driver as a module, choose M here: the module will be
 	  called ucsi_acpi
 
+config UCSI_STM32G0
+	tristate "UCSI Interface Driver for STM32G0"
+	depends on I2C
+	help
+	  This driver enables UCSI support on platforms that expose a STM32G0
+	  Type-C controller over I2C interface.
+
+	  To compile the driver as a module, choose M here: the module will be
+	  called ucsi_stm32g0.
+
 endif
diff --git a/drivers/usb/typec/ucsi/Makefile b/drivers/usb/typec/ucsi/Makefile
index 8a8eb5cb8e0f0..480d533d762fe 100644
--- a/drivers/usb/typec/ucsi/Makefile
+++ b/drivers/usb/typec/ucsi/Makefile
@@ -17,3 +17,4 @@ endif
 
 obj-$(CONFIG_UCSI_ACPI)			+= ucsi_acpi.o
 obj-$(CONFIG_UCSI_CCG)			+= ucsi_ccg.o
+obj-$(CONFIG_UCSI_STM32G0)		+= ucsi_stm32g0.o
diff --git a/drivers/usb/typec/ucsi/ucsi_stm32g0.c b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
new file mode 100644
index 0000000000000..bb5271bf7cdcf
--- /dev/null
+++ b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+/*
+ * UCSI driver for STMicroelectronics STM32G0 Type-C PD controller
+ *
+ * Copyright (C) 2022, STMicroelectronics - All Rights Reserved
+ * Author: Fabrice Gasnier <fabrice.gasnier@foss.st.com>.
+ */
+
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include "ucsi.h"
+
+struct ucsi_stm32g0 {
+	struct i2c_client *client;
+	struct completion complete;
+	struct device *dev;
+	unsigned long flags;
+	struct ucsi *ucsi;
+};
+
+static int ucsi_stm32g0_read(struct ucsi *ucsi, unsigned int offset, void *val, size_t len)
+{
+	struct ucsi_stm32g0 *g0 = ucsi_get_drvdata(ucsi);
+	struct i2c_client *client = g0->client;
+	u8 reg = offset;
+	struct i2c_msg msg[] = {
+		{
+			.addr	= client->addr,
+			.flags  = 0,
+			.len	= 1,
+			.buf	= &reg,
+		},
+		{
+			.addr	= client->addr,
+			.flags  = I2C_M_RD,
+			.len	= len,
+			.buf	= val,
+		},
+	};
+	int ret;
+
+	ret = i2c_transfer(client->adapter, msg, ARRAY_SIZE(msg));
+	if (ret != ARRAY_SIZE(msg)) {
+		dev_err(g0->dev, "i2c read %02x, %02x error: %d\n", client->addr, reg, ret);
+
+		return ret < 0 ? ret : -EIO;
+	}
+
+	return 0;
+}
+
+static int ucsi_stm32g0_async_write(struct ucsi *ucsi, unsigned int offset, const void *val,
+				    size_t len)
+{
+	struct ucsi_stm32g0 *g0 = ucsi_get_drvdata(ucsi);
+	struct i2c_client *client = g0->client;
+	struct i2c_msg msg[] = {
+		{
+			.addr	= client->addr,
+			.flags  = 0,
+		}
+	};
+	unsigned char *buf;
+	int ret;
+
+	buf = kmalloc(len + 1, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	buf[0] = offset;
+	memcpy(&buf[1], val, len);
+	msg[0].len = len + 1;
+	msg[0].buf = buf;
+
+	ret = i2c_transfer(client->adapter, msg, ARRAY_SIZE(msg));
+	kfree(buf);
+	if (ret != ARRAY_SIZE(msg)) {
+		dev_err(g0->dev, "i2c write %02x, %02x error: %d\n", client->addr, offset, ret);
+
+		return ret < 0 ? ret : -EIO;
+	}
+
+	return 0;
+}
+
+static int ucsi_stm32g0_sync_write(struct ucsi *ucsi, unsigned int offset, const void *val,
+				   size_t len)
+{
+	struct ucsi_stm32g0 *g0 = ucsi_get_drvdata(ucsi);
+	int ret;
+
+	set_bit(COMMAND_PENDING, &g0->flags);
+
+	ret = ucsi_stm32g0_async_write(ucsi, offset, val, len);
+	if (ret)
+		goto out_clear_bit;
+
+	if (!wait_for_completion_timeout(&g0->complete, msecs_to_jiffies(5000)))
+		ret = -ETIMEDOUT;
+
+out_clear_bit:
+	clear_bit(COMMAND_PENDING, &g0->flags);
+
+	return ret;
+}
+
+static irqreturn_t ucsi_stm32g0_irq_handler(int irq, void *data)
+{
+	struct ucsi_stm32g0 *g0 = data;
+	u32 cci;
+	int ret;
+
+	ret = ucsi_stm32g0_read(g0->ucsi, UCSI_CCI, &cci, sizeof(cci));
+	if (ret)
+		return IRQ_NONE;
+
+	if (UCSI_CCI_CONNECTOR(cci))
+		ucsi_connector_change(g0->ucsi, UCSI_CCI_CONNECTOR(cci));
+
+	if (test_bit(COMMAND_PENDING, &g0->flags) &&
+	    cci & (UCSI_CCI_ACK_COMPLETE | UCSI_CCI_COMMAND_COMPLETE))
+		complete(&g0->complete);
+
+	return IRQ_HANDLED;
+}
+
+static const struct ucsi_operations ucsi_stm32g0_ops = {
+	.read = ucsi_stm32g0_read,
+	.sync_write = ucsi_stm32g0_sync_write,
+	.async_write = ucsi_stm32g0_async_write,
+};
+
+static int ucsi_stm32g0_probe(struct i2c_client *client, const struct i2c_device_id *id)
+{
+	struct device *dev = &client->dev;
+	struct ucsi_stm32g0 *g0;
+	int ret;
+
+	g0 = devm_kzalloc(dev, sizeof(*g0), GFP_KERNEL);
+	if (!g0)
+		return -ENOMEM;
+
+	g0->dev = dev;
+	g0->client = client;
+	init_completion(&g0->complete);
+	i2c_set_clientdata(client, g0);
+
+	g0->ucsi = ucsi_create(dev, &ucsi_stm32g0_ops);
+	if (IS_ERR(g0->ucsi))
+		return PTR_ERR(g0->ucsi);
+
+	ucsi_set_drvdata(g0->ucsi, g0);
+
+	/* Request alert interrupt */
+	ret = request_threaded_irq(client->irq, NULL, ucsi_stm32g0_irq_handler, IRQF_ONESHOT,
+				   dev_name(&client->dev), g0);
+	if (ret) {
+		dev_err_probe(dev, ret, "request IRQ failed\n");
+		goto destroy;
+	}
+
+	ret = ucsi_register(g0->ucsi);
+	if (ret) {
+		dev_err_probe(dev, ret, "ucsi_register failed\n");
+		goto freeirq;
+	}
+
+	return 0;
+
+freeirq:
+	free_irq(client->irq, g0);
+destroy:
+	ucsi_destroy(g0->ucsi);
+
+	return ret;
+}
+
+static int ucsi_stm32g0_remove(struct i2c_client *client)
+{
+	struct ucsi_stm32g0 *g0 = i2c_get_clientdata(client);
+
+	ucsi_unregister(g0->ucsi);
+	free_irq(client->irq, g0);
+	ucsi_destroy(g0->ucsi);
+
+	return 0;
+}
+
+static const struct of_device_id __maybe_unused ucsi_stm32g0_typec_of_match[] = {
+	{ .compatible = "st,stm32g0-typec" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ucsi_stm32g0_typec_of_match);
+
+static const struct i2c_device_id ucsi_stm32g0_typec_i2c_devid[] = {
+	{"stm32g0-typec", 0},
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, ucsi_stm32g0_typec_i2c_devid);
+
+static struct i2c_driver ucsi_stm32g0_i2c_driver = {
+	.driver = {
+		.name = "ucsi-stm32g0-i2c",
+		.of_match_table = of_match_ptr(ucsi_stm32g0_typec_of_match),
+	},
+	.probe = ucsi_stm32g0_probe,
+	.remove = ucsi_stm32g0_remove,
+	.id_table = ucsi_stm32g0_typec_i2c_devid
+};
+module_i2c_driver(ucsi_stm32g0_i2c_driver);
+
+MODULE_AUTHOR("Fabrice Gasnier <fabrice.gasnier@foss.st.com>");
+MODULE_DESCRIPTION("STMicroelectronics STM32G0 Type-C controller");
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_ALIAS("platform:ucsi-stm32g0");
-- 
2.25.1

