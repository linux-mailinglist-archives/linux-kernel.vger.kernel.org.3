Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9E85967B6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 05:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237896AbiHQDV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 23:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiHQDVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 23:21:24 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A4E6CF59;
        Tue, 16 Aug 2022 20:21:23 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id p125so11008484pfp.2;
        Tue, 16 Aug 2022 20:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=cOr6gkZL5EYRbTmZIAth2irEiQu6fAMwiaRXpZKh5rw=;
        b=h2K7d+BBbZCOkkh6OHJGvRUcsxU0NErLoLx9BxXaCdloz3CRjpYTgUJQXOMCREoL3t
         t9zHeQPJidoDG/1PWIAXUowZUWYnPQHcem12GAXjko4yEXD6CxXTwv4FPu8gt36yEdQy
         4R3dCXBfKGjzEpSmBsbdZGEIe8545keEgzsU3f/cd1cuXutWOWHGKj7Z2kCHVPdXWhMR
         okYyqwA6l+8WGpl2lmeQHzENj8hGs8JDt0/wgIu0Wl1yI5xCqY8GYeLxBQUVBLGL/+Nd
         DK8VM69uHIA+pRy9h6EbusxLFCfJYNu2dsL4k+OrKYOlBEfwfYJSvmvdqUVU9e5jqs0M
         IcpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=cOr6gkZL5EYRbTmZIAth2irEiQu6fAMwiaRXpZKh5rw=;
        b=B1CK8hNEaq/+4LN+yfFFSOix4o16O1ec0qX/FulyfOH3xU1ED1XqUM2xPxNGPwK/No
         cYYdSeSSnpKNCQyiCTY/G7ZmcTiKzECC/dFi+6Uh9xalqLhq4N2FizukqxVkCFo7y0fz
         jVGVL669I6qJEU/+VUEl7SK40/RhnMu8X1kwIay6VweD05bb5dBwfhHI8JIGlVE47II7
         s/VM7fmVPjv+iUbqlMA6CaLhf498tE8ZynsBSynb5RhkWuu8WFwwAQQIadBcLpGM/Pg3
         QaoK51lgXQUJcN2vULWMRCMGcpYLdVWd5CDIoTCKndpDuHuJbN/+Q4Vz9wDGRMLeHyfD
         yDNg==
X-Gm-Message-State: ACgBeo3L++3RIV3pQ64W/gV6gJIQoKKRSa1YbC5WHU0lhvfZa51OKffb
        uE64C1D68k/10+lLWoQlzSs=
X-Google-Smtp-Source: AA6agR7GEtUqMPz4OWJj8k2Jj27LS6TDrRlNOFAyAIXIU+UzEASSS7gW/GmqbRF+8LyA1/x2zl86LQ==
X-Received: by 2002:a05:6a00:2195:b0:52e:6157:904d with SMTP id h21-20020a056a00219500b0052e6157904dmr23795022pfi.44.1660706482618;
        Tue, 16 Aug 2022 20:21:22 -0700 (PDT)
Received: from dusj-System-Product-Name.dhcpserver.bu9bmc.local (125-228-123-29.hinet-ip.hinet.net. [125.228.123.29])
        by smtp.gmail.com with ESMTPSA id m4-20020a170902d18400b0016ef7235e09sm147988plb.168.2022.08.16.20.21.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Aug 2022 20:21:22 -0700 (PDT)
From:   Duke Du <dukedu83@gmail.com>
X-Google-Original-From: Duke Du <Duke.Du@quantatw.com>
To:     jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     fran.hsu@quantatw.com, charles.hsu@quantatw.com,
        duke.du@quantatw.com
Subject: [PATCH v1] hwmon: Add the pmbus driver for the TEXAS TPS546D24 Buck Converter.
Date:   Wed, 17 Aug 2022 11:19:19 +0800
Message-Id: <1660706359-29076-1-git-send-email-Duke.Du@quantatw.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make the PMBUS_VOUT_MODE return value 0x17,
VOUT returned value is linear11.

v1: Initial patchset.

Signed-off-by: Duke Du <Duke.Du@quantatw.com>
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
index 0000000..1219013
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
+of high frequency operation and 40-A current output from a 7-mm × 5-mm
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

