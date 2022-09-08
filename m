Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B365B1480
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 08:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiIHGP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 02:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiIHGPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 02:15:24 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D47C85FCC;
        Wed,  7 Sep 2022 23:15:23 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d82so3264066pfd.10;
        Wed, 07 Sep 2022 23:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=peZT/o3/Rwk7cwSmlA95lM9nUMw76YizSZmiVcCi3zw=;
        b=ek18FFuxMETzTmhw6GDkVlKTtFHuoV7gd6YfRU4AhyN2Mykcteg7vX0Z//Seyy9u3j
         RAbVpcIr21ENhFnywNc3Wizkbcf9bBlwnMnTJcqcJhh7Ks8Hfes1g7JRuYp/RbdEjzel
         bUr1oOAfePipZ7NxDLIpKIV07kqEdbDHRlGmmhDzBcknj9wN9DPuN2sZ+hAJQAzSYdXz
         Y5HT0tqGVJ7cbza5SuLr2SkaXBFonVx+sOyz6Go79qRFH8Db1ieY0ULgr0RX1LDdYlAY
         +hrGuXacE7xVQdwB8I4msdYFs1xKV0ieh+rKunohz1ksgeeqBXFLxsR6Ial97AJZoT3W
         yESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=peZT/o3/Rwk7cwSmlA95lM9nUMw76YizSZmiVcCi3zw=;
        b=K00oQ+oZQVv+qt0PT1Hqsg7pHuiYRRw+IK/eU+cyRFAh7CRD9zUwM4Owb8RpLyoyBu
         //kSmX55m3jqOIXdsbbYuGMG5ynL+9RsFtye38SPxWWfUtltM1U85/2yvTsL15zWs5Ty
         6wL1JH4htxp3QIROwGonpcQQ8CwnbdK+oYotLEhmsRRPuRhlAPk2z0d574IHw3iTsNhl
         MYVZ99qagRuwX1Hp8Q04N082nLySGNcFC16Nrvjc2dPh1gYhzD3NLARaunLTh2pNUC0X
         TlCW1EEbSX+/hMGEq2UpNAW8tz9OSTkMA9UlOsW5AcB/e9h/uLPMJKDwqymL7ggFnfLW
         AnTQ==
X-Gm-Message-State: ACgBeo3Wah6eN2KWEGXjkeYAb4lN7t79w6M1bix4dWOu0yzGojlDzPxX
        JOeK85J/pRepk4UjU+k+xkSCDJLTmP0xbw==
X-Google-Smtp-Source: AA6agR4Ol9ODukriAyWNcdbU5EXdTIk7JzZAtHx5Ky+W/6LhsP1SUepMH0v27SwHDrSnh8N+E38PDA==
X-Received: by 2002:a63:225c:0:b0:42c:3811:93fb with SMTP id t28-20020a63225c000000b0042c381193fbmr6286217pgm.543.1662617722545;
        Wed, 07 Sep 2022 23:15:22 -0700 (PDT)
Received: from dusj-System-Product-Name.dhcpserver.bu9bmc.local (125-228-123-29.hinet-ip.hinet.net. [125.228.123.29])
        by smtp.gmail.com with ESMTPSA id a16-20020a621a10000000b00537a6b81bb7sm14268403pfa.148.2022.09.07.23.15.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Sep 2022 23:15:22 -0700 (PDT)
From:   Duke Du <dukedu83@gmail.com>
X-Google-Original-From: Duke Du <Duke.Du@quantatw.com>
To:     jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     fran.hsu@quantatw.com, george.hung@quantatw.com,
        charles.hsu@quantatw.com, duke.du@quantatw.com
Subject: [PATCH v4] hwmon: Add driver for the TEXAS TPS546D24 Buck Converter.
Date:   Thu,  8 Sep 2022 14:13:19 +0800
Message-Id: <1662617599-15270-1-git-send-email-Duke.Du@quantatw.com>
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

From: Duke Du <dukedu83@gmail.com>

Add the pmbus driver for TEXAS tps546d24 Buck Converter.
The vout mode of tps546d24 supported relative data format,
which is not meet for the original driver (pmbus.c).

Signed-off-by: Duke Du <dukedu83@gmail.com>
---
Change in v1: 
    Initial patchset.
Change in v2:
    Correct the tps546d24.rst format.
Change in v3:
    1. Modify the patch description. 
    2. Put the change log between the dashes and diffstat.
Change in v4:
    1. Modify the patch description. 
    2. Clear the bit 7 of PMBUS_VOUT_MODE to change the mode from relative 
       to absolute.
    3. Add the vendor prefix.
---
---
 Documentation/hwmon/index.rst     |  1 +
 Documentation/hwmon/tps546d24.rst | 35 ++++++++++++++++++++++
 MAINTAINERS                       |  7 +++++
 drivers/hwmon/pmbus/Kconfig       |  9 ++++++
 drivers/hwmon/pmbus/Makefile      |  1 +
 drivers/hwmon/pmbus/tps546d24.c   | 63 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 116 insertions(+)
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
index 0000000..84f3dc9
--- /dev/null
+++ b/drivers/hwmon/pmbus/tps546d24.c
@@ -0,0 +1,63 @@
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
+static struct pmbus_driver_info tps546d24_info = {
+	.pages = 1,
+	.format[PSC_VOLTAGE_IN] = linear,
+	.format[PSC_VOLTAGE_OUT] = linear,
+	.format[PSC_TEMPERATURE] = linear,
+	.format[PSC_CURRENT_OUT] = linear,
+	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN
+			| PMBUS_HAVE_IOUT | PMBUS_HAVE_VOUT
+			| PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_STATUS_VOUT
+			| PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
+};
+
+static int tps546d24_probe(struct i2c_client *client)
+{
+	int reg;
+
+	reg = i2c_smbus_read_byte_data(client, PMBUS_VOUT_MODE);
+	if (reg > 0x80)
+		i2c_smbus_write_byte_data(client, PMBUS_VOUT_MODE, reg & 0x7f);
+	return pmbus_do_probe(client, &tps546d24_info);
+}
+
+static const struct i2c_device_id tps546d24_id[] = {
+	{"tps546d24", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, tps546d24_id);
+
+static const struct of_device_id tps546d24_of_match[] = {
+	{.compatible = "ti,tps546d24"},
+	{}
+};
+MODULE_DEVICE_TABLE(of, tps546d24_of_match);
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

