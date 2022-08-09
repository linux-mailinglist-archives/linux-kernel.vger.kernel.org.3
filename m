Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7871058E13C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 22:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244740AbiHIUmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 16:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242240AbiHIUmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 16:42:03 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103241EEFA;
        Tue,  9 Aug 2022 13:42:02 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 279KbmGZ001213;
        Tue, 9 Aug 2022 20:41:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=mm/bcT1C2yHhWetnHksi+91BYuyqpZ16akRoaKY20wo=;
 b=jfwaXHd43mIpOxs0CuV59Mr+94jsP9Q04tpRcE4px345dnirJUZtBOXqOfM+Sh2p9XdZ
 NAF57y04yQqHNHPlftfzgQmcRIEcfXjnyRzmH/cD4COITE4Q2c7UUUpq11yN/dvcZAUc
 SNtUlH5bgTNSTz+tyjuOhT66UM+o+hvVKE3UrJUlmd6k8MPKhGRqy9NjFic3KMBt1YYR
 ZYpk7EgS6VWlwrmUvrRx+4sByHVXEm5DyCxbOYCbmUtN7Nj9deaxoiJY3qLp8JGWWRr8
 kRT2Ue6XtxTHKFWorRmL0x9XL8KoZ+YEDGnrSlccDTUE4hWyO5LI0Wyk1JdIzsX/w7Hy JQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3huwv6sp93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 20:41:51 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 279KcMIG004036;
        Tue, 9 Aug 2022 20:41:51 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3huwv6sp8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 20:41:51 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 279KKP74030677;
        Tue, 9 Aug 2022 20:41:50 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma04wdc.us.ibm.com with ESMTP id 3huww3raxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 20:41:50 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 279KfooI64094660
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Aug 2022 20:41:50 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E311A2805A;
        Tue,  9 Aug 2022 20:41:49 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F98628058;
        Tue,  9 Aug 2022 20:41:49 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.160.17.179])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  9 Aug 2022 20:41:49 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-input@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au,
        wsa+renesas@sang-engineering.com, eajames@linux.ibm.com
Subject: [PATCH v5 2/2] input: misc: Add IBM Operation Panel driver
Date:   Tue,  9 Aug 2022 15:41:47 -0500
Message-Id: <20220809204147.238132-3-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220809204147.238132-1-eajames@linux.ibm.com>
References: <20220809204147.238132-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OB6icZ9O4PziAax73DUxf4ag9t6kEdLK
X-Proofpoint-ORIG-GUID: JcDUONQOIUSNN_YcnA-pfNiZWEQ1bWgj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-09_05,2022-08-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 adultscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208090076
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver to get the button events from the panel and provide
them to userspace with the input subsystem. The panel is
connected with I2C and controls the bus, so the driver registers
as an I2C slave device.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com> # I2C slave parts
---
 MAINTAINERS                    |   1 +
 drivers/input/misc/Kconfig     |  18 +++
 drivers/input/misc/Makefile    |   1 +
 drivers/input/misc/ibm-panel.c | 198 +++++++++++++++++++++++++++++++++
 4 files changed, 218 insertions(+)
 create mode 100644 drivers/input/misc/ibm-panel.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 4dc90f22eb54..aec90a44c044 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9647,6 +9647,7 @@ M:	Eddie James <eajames@linux.ibm.com>
 L:	linux-input@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/input/ibm,op-panel.yaml
+F:	drivers/input/misc/ibm-panel.c
 
 IBM Power 842 compression accelerator
 M:	Haren Myneni <haren@us.ibm.com>
diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index a18ab7358d8f..8901528bbeb0 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -730,6 +730,24 @@ config INPUT_ADXL34X_SPI
 	  To compile this driver as a module, choose M here: the
 	  module will be called adxl34x-spi.
 
+config INPUT_IBM_PANEL
+	tristate "IBM Operation Panel driver"
+	depends on I2C_SLAVE || COMPILE_TEST
+	help
+	  Say Y here if you have an IBM Operation Panel connected to your system
+	  over I2C. The panel is typically connected only to a system's service
+	  processor (BMC).
+
+	  If unsure, say N.
+
+	  The Operation Panel is a controller with some buttons and an LCD
+	  display that allows someone with physical access to the system to
+	  perform various administrative tasks. This driver only supports the part
+	  of the controller that sends commands to the system.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called ibm-panel.
+
 config INPUT_IMS_PCU
 	tristate "IMS Passenger Control Unit driver"
 	depends on USB
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 28dfc444f0a9..9eea13e98d48 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -41,6 +41,7 @@ obj-$(CONFIG_INPUT_GPIO_DECODER)	+= gpio_decoder.o
 obj-$(CONFIG_INPUT_GPIO_VIBRA)		+= gpio-vibra.o
 obj-$(CONFIG_INPUT_HISI_POWERKEY)	+= hisi_powerkey.o
 obj-$(CONFIG_HP_SDC_RTC)		+= hp_sdc_rtc.o
+obj-$(CONFIG_INPUT_IBM_PANEL)		+= ibm-panel.o
 obj-$(CONFIG_INPUT_IMS_PCU)		+= ims-pcu.o
 obj-$(CONFIG_INPUT_IQS269A)		+= iqs269a.o
 obj-$(CONFIG_INPUT_IQS626A)		+= iqs626a.o
diff --git a/drivers/input/misc/ibm-panel.c b/drivers/input/misc/ibm-panel.c
new file mode 100644
index 000000000000..c77cb9b12ebc
--- /dev/null
+++ b/drivers/input/misc/ibm-panel.c
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) IBM Corporation 2020
+ */
+
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/kernel.h>
+#include <linux/limits.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/spinlock.h>
+
+#define DEVICE_NAME		"ibm-panel"
+#define PANEL_KEYCODES_COUNT	3
+
+struct ibm_panel {
+	u8 idx;
+	u8 command[11];
+	u32 keycodes[PANEL_KEYCODES_COUNT];
+	spinlock_t lock;	/* protects writes to idx and command */
+	struct input_dev *input;
+};
+
+static u8 ibm_panel_calculate_checksum(struct ibm_panel *panel)
+{
+	u8 chksum;
+	u16 sum = 0;
+	unsigned int i;
+
+	for (i = 0; i < sizeof(panel->command) - 1; ++i) {
+		sum += panel->command[i];
+		if (sum & 0xff00) {
+			sum &= 0xff;
+			sum++;
+		}
+	}
+
+	chksum = sum & 0xff;
+	chksum = ~chksum;
+	chksum++;
+
+	return chksum;
+}
+
+static void ibm_panel_process_command(struct ibm_panel *panel)
+{
+	u8 button;
+	u8 chksum;
+
+	if (panel->command[0] != 0xff && panel->command[1] != 0xf0) {
+		dev_dbg(&panel->input->dev, "command invalid: %02x %02x\n",
+			panel->command[0], panel->command[1]);
+		return;
+	}
+
+	chksum = ibm_panel_calculate_checksum(panel);
+	if (chksum != panel->command[sizeof(panel->command) - 1]) {
+		dev_dbg(&panel->input->dev,
+			"command failed checksum: %u != %u\n", chksum,
+			panel->command[sizeof(panel->command) - 1]);
+		return;
+	}
+
+	button = panel->command[2] & 0xf;
+	if (button < PANEL_KEYCODES_COUNT) {
+		input_report_key(panel->input, panel->keycodes[button],
+				 !(panel->command[2] & 0x80));
+		input_sync(panel->input);
+	} else {
+		dev_dbg(&panel->input->dev, "unknown button %u\n",
+			button);
+	}
+}
+
+static int ibm_panel_i2c_slave_cb(struct i2c_client *client,
+				  enum i2c_slave_event event, u8 *val)
+{
+	unsigned long flags;
+	struct ibm_panel *panel = i2c_get_clientdata(client);
+
+	dev_dbg(&panel->input->dev, "event: %u data: %02x\n", event, *val);
+
+	spin_lock_irqsave(&panel->lock, flags);
+
+	switch (event) {
+	case I2C_SLAVE_STOP:
+		if (panel->idx == sizeof(panel->command))
+			ibm_panel_process_command(panel);
+		else
+			dev_dbg(&panel->input->dev,
+				"command incorrect size %u\n", panel->idx);
+		fallthrough;
+	case I2C_SLAVE_WRITE_REQUESTED:
+		panel->idx = 0;
+		break;
+	case I2C_SLAVE_WRITE_RECEIVED:
+		if (panel->idx < sizeof(panel->command))
+			panel->command[panel->idx++] = *val;
+		else
+			/*
+			 * The command is too long and therefore invalid, so set the index
+			 * to it's largest possible value. When a STOP is finally received,
+			 * the command will be rejected upon processing.
+			 */
+			panel->idx = U8_MAX;
+		break;
+	case I2C_SLAVE_READ_REQUESTED:
+	case I2C_SLAVE_READ_PROCESSED:
+		*val = 0xff;
+		break;
+	default:
+		break;
+	}
+
+	spin_unlock_irqrestore(&panel->lock, flags);
+
+	return 0;
+}
+
+static int ibm_panel_probe(struct i2c_client *client,
+			   const struct i2c_device_id *id)
+{
+	int i;
+	int rc;
+	struct ibm_panel *panel = devm_kzalloc(&client->dev, sizeof(*panel),
+					       GFP_KERNEL);
+
+	if (!panel)
+		return -ENOMEM;
+
+	panel->input = devm_input_allocate_device(&client->dev);
+	if (!panel->input)
+		return -ENOMEM;
+
+	panel->input->name = client->name;
+	panel->input->id.bustype = BUS_I2C;
+
+	rc = device_property_read_u32_array(&client->dev, "linux,keycodes",
+					    panel->keycodes,
+					    PANEL_KEYCODES_COUNT);
+	if (rc) {
+		/*
+		 * Use gamepad buttons as defaults for compatibility with
+		 * existing applications.
+		 */
+		panel->keycodes[0] = BTN_NORTH;
+		panel->keycodes[1] = BTN_SOUTH;
+		panel->keycodes[2] = BTN_SELECT;
+	}
+
+	for (i = 0; i < PANEL_KEYCODES_COUNT; ++i)
+		input_set_capability(panel->input, EV_KEY, panel->keycodes[i]);
+
+	rc = input_register_device(panel->input);
+	if (rc) {
+		dev_err(&client->dev, "Failed to register input device: %d\n",
+			rc);
+		return rc;
+	}
+
+	spin_lock_init(&panel->lock);
+
+	i2c_set_clientdata(client, panel);
+	rc = i2c_slave_register(client, ibm_panel_i2c_slave_cb);
+	if (rc)
+		dev_err(&client->dev, "Failed to register as i2c slave: %d\n",
+			rc);
+
+	return rc;
+}
+
+static int ibm_panel_remove(struct i2c_client *client)
+{
+	i2c_slave_unregister(client);
+
+	return 0;
+}
+
+static const struct of_device_id ibm_panel_match[] = {
+	{ .compatible = "ibm,op-panel" },
+	{ }
+};
+
+static struct i2c_driver ibm_panel_driver = {
+	.driver = {
+		.name = DEVICE_NAME,
+		.of_match_table = ibm_panel_match,
+	},
+	.probe = ibm_panel_probe,
+	.remove = ibm_panel_remove,
+};
+module_i2c_driver(ibm_panel_driver);
+
+MODULE_AUTHOR("Eddie James <eajames@linux.ibm.com>");
+MODULE_DESCRIPTION("IBM Operation Panel Driver");
+MODULE_LICENSE("GPL");
-- 
2.31.1

