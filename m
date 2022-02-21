Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBF94BDF42
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242778AbiBUKXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 05:23:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354500AbiBUKW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 05:22:58 -0500
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5636060066;
        Mon, 21 Feb 2022 01:42:45 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4K2HQq72Wyz9sQG;
        Mon, 21 Feb 2022 10:42:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1645436561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XmCRsFfqKWupKsZhpAsq325oyBah0xqhWui/oax6grU=;
        b=UKD2jPdKhpwjoGB1+UFwwb2O8Ybqy7HAi5c/NHrCfu2K8PgN5tVUAb9sUlrE893BwPIkBb
        e2Z7Xs2qt2HFSY1Xz+p2OFjtyQUSJCQjs9aKOf7UfZ5BSzGQOVDREO1iudvC4TWNoZ4vPE
        gWK0+Q1cYq3ftETmELJj7M2jMyv0ZNrGXSBDdYJMyMGpeHa6XpfaTdpRETpsdeNNodFRn7
        YhLX29IFykD+dSLzMwhBvZTsI/ySCxzGxYVKnnZHH270Q9fGamcaJtONLUxI9NMbdzqgYg
        Dy2jzeviT20Q7xe+gOqoVrvK4s0ommqMhKZX51nURbMZdv2w75FpV9miLfqc4Q==
From:   Marcello Sylvester Bauer <sylv@sylv.io>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>,
        linux-doc@vger.kernel.org
Subject: [PATCH v4 3/4] pmbus: Add support for pli1209bc
Date:   Mon, 21 Feb 2022 10:42:06 +0100
Message-Id: <4e016e66275bc46c90974aec18b150c874e64787.1645435888.git.sylv@sylv.io>
In-Reply-To: <cover.1645435888.git.sylv@sylv.io>
References: <cover.1645435888.git.sylv@sylv.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PLI1209BC is a Digital Supervisor from Vicor Corporation.

Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
---
 Documentation/hwmon/index.rst     |   1 +
 Documentation/hwmon/pli1209bc.rst |  75 +++++++++++++++++++
 drivers/hwmon/pmbus/Kconfig       |   9 +++
 drivers/hwmon/pmbus/Makefile      |   1 +
 drivers/hwmon/pmbus/pli1209bc.c   | 115 ++++++++++++++++++++++++++++++
 5 files changed, 201 insertions(+)
 create mode 100644 Documentation/hwmon/pli1209bc.rst
 create mode 100644 drivers/hwmon/pmbus/pli1209bc.c

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index b69fdaf1af82..075d1defcd20 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -161,6 +161,7 @@ Hardware Monitoring Kernel Drivers
    pc87427
    pcf8591
    pim4328
+   pli1209bc
    pm6764tr
    pmbus
    powr1220
diff --git a/Documentation/hwmon/pli1209bc.rst b/Documentation/hwmon/pli1209bc.rst
new file mode 100644
index 000000000000..ea5b3f68a515
--- /dev/null
+++ b/Documentation/hwmon/pli1209bc.rst
@@ -0,0 +1,75 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Kernel driver pli1209bc
+=======================
+
+Supported chips:
+
+  * Digital Supervisor PLI1209BC
+
+    Prefix: 'pli1209bc'
+
+    Addresses scanned: 0x50 - 0x5F
+
+    Datasheet: https://www.vicorpower.com/documents/datasheets/ds-PLI1209BCxyzz-VICOR.pdf
+
+Authors:
+    - Marcello Sylvester Bauer <sylv@sylv.io>
+
+Description
+-----------
+
+The Vicor PLI1209BC is an isolated digital power system supervisor that provides
+a communication interface between a host processor and one Bus Converter Module
+(BCM). The PLI communicates with a system controller via a PMBus compatible
+interface over an isolated UART interface. Through the PLI, the host processor
+can configure, set protection limits, and monitor the BCM.
+
+Sysfs entries
+-------------
+
+======================= ========================================================
+in1_label		"vin2"
+in1_input		Input voltage.
+in1_rated_min		Minimum rated input voltage.
+in1_rated_max		Maximum rated input voltage.
+in1_max			Maximum input voltage.
+in1_max_alarm		Input voltage high alarm.
+in1_crit		Critical input voltage.
+in1_crit_alarm		Input voltage critical alarm.
+
+in2_label		"vout2"
+in2_input		Output voltage.
+in2_rated_min		Minimum rated output voltage.
+in2_rated_max		Maximum rated output voltage.
+in2_alarm		Output voltage alarm
+
+curr1_label		"iin2"
+curr1_input		Input current.
+curr1_max		Maximum input current.
+curr1_max_alarm		Maximum input current high alarm.
+curr1_crit		Critical input current.
+curr1_crit_alarm	Input current critical alarm.
+
+curr2_label		"iout2"
+curr2_input		Output current.
+curr2_crit		Critical output current.
+curr2_crit_alarm	Output current critical alarm.
+curr2_max		Maximum output current.
+curr2_max_alarm		Output current high alarm.
+
+power1_label		"pin2"
+power1_input		Input power.
+power1_alarm		Input power alarm.
+
+power2_label		"pout2"
+power2_input		Output power.
+power2_rated_max	Maximum rated output power.
+
+temp1_input		Die temperature.
+temp1_alarm		Die temperature alarm.
+temp1_max		Maximum die temperature.
+temp1_max_alarm		Die temperature high alarm.
+temp1_crit		Critical die temperature.
+temp1_crit_alarm	Die temperature critical alarm.
+======================= ========================================================
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index c73aa50c7615..f18f67a94697 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -317,6 +317,15 @@ config SENSORS_PIM4328
 	  This driver can also be built as a module. If so, the module will
 	  be called pim4328.
 
+config SENSORS_PLI1209BC
+	tristate "Vicor PLI1209BC"
+	help
+	  If you say yes here you get hardware monitoring support for Vicor
+	  PLI1209BC Digital Supervisor.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called pli1209bc.
+
 config SENSORS_PM6764TR
 	tristate "ST PM6764TR"
 	help
diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
index e5935f70c9e0..a4a96ac71de7 100644
--- a/drivers/hwmon/pmbus/Makefile
+++ b/drivers/hwmon/pmbus/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_SENSORS_MAX8688)	+= max8688.o
 obj-$(CONFIG_SENSORS_MP2888)	+= mp2888.o
 obj-$(CONFIG_SENSORS_MP2975)	+= mp2975.o
 obj-$(CONFIG_SENSORS_MP5023)	+= mp5023.o
+obj-$(CONFIG_SENSORS_PLI1209BC)	+= pli1209bc.o
 obj-$(CONFIG_SENSORS_PM6764TR)	+= pm6764tr.o
 obj-$(CONFIG_SENSORS_PXE1610)	+= pxe1610.o
 obj-$(CONFIG_SENSORS_Q54SJ108A2)	+= q54sj108a2.o
diff --git a/drivers/hwmon/pmbus/pli1209bc.c b/drivers/hwmon/pmbus/pli1209bc.c
new file mode 100644
index 000000000000..5f8847307e55
--- /dev/null
+++ b/drivers/hwmon/pmbus/pli1209bc.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Hardware monitoring driver for Vicor PLI1209BC Digital Supervisor
+ *
+ * Copyright (c) 2022 9elements GmbH
+ */
+
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/pmbus.h>
+#include "pmbus.h"
+
+/*
+ * The capability command is only supported at page 0. Probing the device while
+ * the page register is set to 1 will falsely enable PEC support. Disable
+ * capability probing accordingly, since the PLI1209BC does not have any
+ * additional capabilities.
+ */
+static struct pmbus_platform_data pli1209bc_plat_data = {
+	.flags = PMBUS_NO_CAPABILITY,
+};
+
+static int pli1209bc_read_word_data(struct i2c_client *client, int page,
+				    int phase, int reg)
+{
+	int data;
+
+	switch (reg) {
+	/* PMBUS_READ_POUT uses a direct format with R=0 */
+	case PMBUS_READ_POUT:
+		data = pmbus_read_word_data(client, page, phase, reg);
+		if (data < 0)
+			return data;
+		data = sign_extend32(data, 15) * 10;
+		return clamp_val(data, -32768, 32767) & 0xffff;
+	default:
+		return -ENODATA;
+	}
+}
+
+static struct pmbus_driver_info pli1209bc_info = {
+	.pages = 2,
+	.format[PSC_VOLTAGE_IN] = direct,
+	.format[PSC_VOLTAGE_OUT] = direct,
+	.format[PSC_CURRENT_IN] = direct,
+	.format[PSC_CURRENT_OUT] = direct,
+	.format[PSC_POWER] = direct,
+	.format[PSC_TEMPERATURE] = direct,
+	.m[PSC_VOLTAGE_IN] = 1,
+	.b[PSC_VOLTAGE_IN] = 0,
+	.R[PSC_VOLTAGE_IN] = 1,
+	.m[PSC_VOLTAGE_OUT] = 1,
+	.b[PSC_VOLTAGE_OUT] = 0,
+	.R[PSC_VOLTAGE_OUT] = 1,
+	.m[PSC_CURRENT_IN] = 1,
+	.b[PSC_CURRENT_IN] = 0,
+	.R[PSC_CURRENT_IN] = 3,
+	.m[PSC_CURRENT_OUT] = 1,
+	.b[PSC_CURRENT_OUT] = 0,
+	.R[PSC_CURRENT_OUT] = 2,
+	.m[PSC_POWER] = 1,
+	.b[PSC_POWER] = 0,
+	.R[PSC_POWER] = 1,
+	.m[PSC_TEMPERATURE] = 1,
+	.b[PSC_TEMPERATURE] = 0,
+	.R[PSC_TEMPERATURE] = 0,
+	/*
+	 * Page 0 sums up all attributes except voltage readings.
+	 * The pli1209 digital supervisor only contains a single BCM, making
+	 * page 0 redundant.
+	 */
+	.func[1] = PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT
+	    | PMBUS_HAVE_IIN | PMBUS_HAVE_IOUT
+	    | PMBUS_HAVE_PIN | PMBUS_HAVE_POUT
+	    | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP
+	    | PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_STATUS_INPUT,
+	.read_word_data = pli1209bc_read_word_data,
+};
+
+static int pli1209bc_probe(struct i2c_client *client)
+{
+	client->dev.platform_data = &pli1209bc_plat_data;
+	return pmbus_do_probe(client, &pli1209bc_info);
+}
+
+static const struct i2c_device_id pli1209bc_id[] = {
+	{"pli1209bc", 0},
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, pli1209bc_id);
+
+#ifdef CONFIG_OF
+static const struct of_device_id pli1209bc_of_match[] = {
+	{ .compatible = "vicor,pli1209bc" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, pli1209bc_of_match);
+#endif
+
+static struct i2c_driver pli1209bc_driver = {
+	.driver = {
+		   .name = "pli1209bc",
+		   .of_match_table = of_match_ptr(pli1209bc_of_match),
+		   },
+	.probe_new = pli1209bc_probe,
+	.id_table = pli1209bc_id,
+};
+
+module_i2c_driver(pli1209bc_driver);
+
+MODULE_AUTHOR("Marcello Sylvester Bauer <sylv@sylv.io>");
+MODULE_DESCRIPTION("PMBus driver for Vicor PLI1209BC");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(PMBUS);
-- 
2.34.1

