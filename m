Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834AE599355
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 05:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345351AbiHSDGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 23:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238548AbiHSDGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 23:06:49 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DC7DABA4;
        Thu, 18 Aug 2022 20:06:48 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id h28so3197699pfq.11;
        Thu, 18 Aug 2022 20:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=KmjwltB4DAqEz8CKvWyccwR6omX4tpoi/2zk3QXTTF8=;
        b=TjG9Xue/7c6d6jQxS8Kg8HGSWgknK1+RpbXc/UrwYljaaXJNPKCEVgSa2zQW9es0Bo
         K2lFqEdQijQRoObEZ51rKnPMdsD710nEEU8ofi9i81xNOqTsTUY78uHMgsPP1NiQ/J8B
         Mx8t9OlyISeTzTNXD1VqH8xBT9PpfYD9lC8qj8eQlmsUu50XuXg0kYMqENV8Pq6OAtzl
         7RQdUabHseygjrtAej8W295t70g8UhgZaeJatRufzqkMrO3izZUO+Qf+rioG+DUd2tpC
         IurPSyDz0BjGFhh/w4GVKIF7ck4QMyHuiU47iFWW41RO1FLik6wgR7Ca2qkHZL/xx8vA
         AtNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=KmjwltB4DAqEz8CKvWyccwR6omX4tpoi/2zk3QXTTF8=;
        b=3WZsleWtSeeL6X4DAI6A5eRiV+Sol8WtX4ceMz9ue2dFeOItfHWumATpWFUJjVuvCu
         Z8qdeUrdJUILdPnEzLIP1mBPVkSkNcO9aSfAq32QC5ta0KYgy8x6FK1u58dYHOYLqHn0
         yj50CyaW/pchyFhHwhoWYDckLjdaemkZOlrUsbdGj9M3L220OwAg0nF/al7g30xEhHT/
         4vN9X+fT1emz1Yc99eUax379QBc5NrubJfB6Kp9H1XR7rFkRLrlqsl8/AJiiNqT/Jpnn
         v5aoJC31h8i/yx5e0n8nnyRM5eThDlfrDszmBwIx7GFOnfuAl1U1JbJ3KMMOVcqoBzbm
         Lucw==
X-Gm-Message-State: ACgBeo0m/fiIhNGKPp6yYBABWWtcQBlx2Mk/z/EDJq4+a9kavyK5gWiW
        h/kBur7P47ZN/mw9nL4gmIo=
X-Google-Smtp-Source: AA6agR6issoxGo3rm4XebZYWXXEob0Heta9BRGvy1kSyqkmYAp+xWc2Btnl1YJAu6HVMCK9FRR/Pbw==
X-Received: by 2002:a65:588d:0:b0:42a:2778:164f with SMTP id d13-20020a65588d000000b0042a2778164fmr2896958pgu.616.1660878407524;
        Thu, 18 Aug 2022 20:06:47 -0700 (PDT)
Received: from dusj-System-Product-Name.dhcpserver.bu9bmc.local (125-228-123-29.hinet-ip.hinet.net. [125.228.123.29])
        by smtp.gmail.com with ESMTPSA id c4-20020a170903234400b0016f09d217c1sm2050265plh.281.2022.08.18.20.06.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Aug 2022 20:06:47 -0700 (PDT)
From:   Duke Du <dukedu83@gmail.com>
X-Google-Original-From: Duke Du <Duke.Du@quantatw.com>
To:     jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     fran.hsu@quantatw.com, charles.hsu@quantatw.com,
        george.hung@quantatw.com, duke.du@quantatw.com
Subject: [PATCH v3] hwmon: Add driver for the TEXAS TPS546D24 Buck Converter.
Date:   Fri, 19 Aug 2022 11:04:43 +0800
Message-Id: <1660878283-9512-1-git-send-email-Duke.Du@quantatw.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the pmbus driver for TEXAS tps546d24 Buck Converter. The
tps546d24 PMBUS_VOUT_MODE is 0x97 (i.e. the bit 5~7 are 100)
which could not meet the standard pmbus spec, the standard mode
of PMBUS_VOUT_MODE must be 000 (linear foramt) or 001 (vid format).
Make the tps546d24 PMBUS_VOUT_MODE return value 0x17 (i.e. the
bit5~7 are 000), VOUT returned value is linear11.

Signed-off-by: Duke Du <Duke.Du@quantatw.com>
---
Change in v1: 
    Initial patchset.
Change in v2:
    Correct the tps546d24.rst format.
Change in v3:
    1. Modify the patch description. 
    2. Put the change log between the dashes and diffstat.
---
---
 Documentation/hwmon/index.rst     |  1 +
 Documentation/hwmon/tps546d24.rst | 35 +++++++++++++++++++
 MAINTAINERS                       |  7 ++++
 drivers/hwmon/pmbus/Kconfig       |  9 +++++
 drivers/hwmon/pmbus/Makefile      |  1 +
 drivers/hwmon/pmbus/tps546d24.c   | 73 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 126 insertions(+)
 create mode 100644 Documentation/hwmon/tps546d24.rst
 create mode 100644 drivers/hwmon/pmbus/tps546d24.c

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index f7113b0..d3eede4 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -205,6 +205,7 @@ Hardware Monitoring Kernel Drivers
    tps23861
    tps40422
    tps53679
+   tps546d24
    twl4030-madc-hwmon
    ucd9000
    ucd9200
diff --git a/Documentation/hwmon/tps546d24.rst b/Documentation/hwmon/tps546d24.rst
new file mode 100644
index 0000000..3061fd8
--- /dev/null
+++ b/Documentation/hwmon/tps546d24.rst
@@ -0,0 +1,35 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+Kernel driver tps546d24
+======================
+
+Supported chips:
+
+  * TI TPS546D24
+
+    Prefix: 'tps546d24'
+
+    Addresses scanned: -
+
+    Datasheet: https://www.ti.com/lit/gpn/tps546d24
+
+Author: Duke Du <dukedu83@gmail.com>
+
+
+Description
+-----------
+
+The TPS546D24A is a highly integrated, non-isolated DC/DC converter capable
+of high frequency operation and 40-A current output from a 7-mm x 5-mm
+package.
+
+Two, three, and four TPS546D24A devices can be interconnected
+to provide up to 160 A on a single output. The device has an option to
+overdrive the internal 5-V LDO with an external 5-V supply via the VDD5
+pin to improve efficiency and reduce power dissipation of the converter.
+
+
+Platform data support
+---------------------
+
+The driver supports standard PMBus driver platform data.
diff --git a/MAINTAINERS b/MAINTAINERS
index 8a5012b..fa2d4fb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20583,6 +20583,13 @@ Q:	https://patchwork.kernel.org/project/linux-integrity/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
 F:	drivers/char/tpm/
 
+TPS546D24 DRIVER
+M:	Duke Du <dukedu83@gmail.com>
+L:	linux-hwmon@vger.kernel.org
+S:	Maintained
+F:	Documentation/hwmon/tps546d24.rst
+F:	drivers/hwmon/pmbus/tps546d24.c
+
 TRACING
 M:	Steven Rostedt <rostedt@goodmis.org>
 M:	Ingo Molnar <mingo@redhat.com>
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 951e4a9..89668af 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -397,6 +397,15 @@ config SENSORS_TPS53679
 	  This driver can also be built as a module. If so, the module will
 	  be called tps53679.
 
+config SENSORS_TPS546D24
+	tristate "TPS546D24"
+	help
+	  If you say yes here you get hardware monitoring support for TEXAS
+	  TPS546D24.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called tps546d24
+
 config SENSORS_UCD9000
 	tristate "TI UCD90120, UCD90124, UCD90160, UCD90320, UCD9090, UCD90910"
 	help
diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
index e2fe86f..0002dbe 100644
--- a/drivers/hwmon/pmbus/Makefile
+++ b/drivers/hwmon/pmbus/Makefile
@@ -41,6 +41,7 @@ obj-$(CONFIG_SENSORS_Q54SJ108A2)	+= q54sj108a2.o
 obj-$(CONFIG_SENSORS_STPDDC60)	+= stpddc60.o
 obj-$(CONFIG_SENSORS_TPS40422)	+= tps40422.o
 obj-$(CONFIG_SENSORS_TPS53679)	+= tps53679.o
+obj-$(CONFIG_SENSORS_TPS546D24)	+= tps546d24.o
 obj-$(CONFIG_SENSORS_UCD9000)	+= ucd9000.o
 obj-$(CONFIG_SENSORS_UCD9200)	+= ucd9200.o
 obj-$(CONFIG_SENSORS_XDPE122)	+= xdpe12284.o
diff --git a/drivers/hwmon/pmbus/tps546d24.c b/drivers/hwmon/pmbus/tps546d24.c
new file mode 100644
index 0000000..f6f79d3
--- /dev/null
+++ b/drivers/hwmon/pmbus/tps546d24.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Hardware monitoring driver for TEXAS TPS546D24 buck converter
+ */
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pmbus.h>
+#include "pmbus.h"
+
+static int tps546d24_read_byte_data(struct i2c_client *client, int page, int reg)
+{
+	int ret;
+
+	switch (reg) {
+	case PMBUS_VOUT_MODE:
+		ret = 0x17;
+		break;
+	default:
+		ret = -ENODATA;
+		break;
+	}
+	return ret;
+}
+
+static struct pmbus_driver_info tps546d24_info = {
+	.pages = 1,
+	.format[PSC_VOLTAGE_IN] = linear,
+	.format[PSC_VOLTAGE_OUT] = linear,
+	.format[PSC_TEMPERATURE] = linear,
+	.format[PSC_CURRENT_OUT] = linear,
+	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN |
+	    PMBUS_HAVE_IOUT | PMBUS_HAVE_VOUT |
+		PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_STATUS_VOUT |
+		PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
+	.read_byte_data = tps546d24_read_byte_data,
+};
+
+static int tps546d24_probe(struct i2c_client *client)
+{
+	return pmbus_do_probe(client, &tps546d24_info);
+}
+
+static const struct i2c_device_id tps546d24_id[] = {
+	{"tps546d24", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, tps546d24_id);
+
+static const struct of_device_id __maybe_unused tps546d24_of_match[] = {
+	{.compatible = "tps546d24"},
+	{}
+};
+
+/* This is the driver that will be inserted */
+static struct i2c_driver tps546d24_driver = {
+	.driver = {
+		   .name = "tps546d24",
+		   .of_match_table = of_match_ptr(tps546d24_of_match),
+	   },
+	.probe_new = tps546d24_probe,
+	.id_table = tps546d24_id,
+};
+
+module_i2c_driver(tps546d24_driver);
+
+MODULE_AUTHOR("Duke Du <dukedu83@gmail.com>");
+MODULE_DESCRIPTION("PMBus driver for TI tps546d24");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(PMBUS);
-- 
2.7.4

