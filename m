Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CB74D21B0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 20:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350044AbiCHTgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 14:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350029AbiCHTgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 14:36:38 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80082.outbound.protection.outlook.com [40.107.8.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5256054BC0;
        Tue,  8 Mar 2022 11:35:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bws+cYYERIEykc1PlRfUOlejT4RZ9rt4nNsOdQRaDZddYNcNMoqRNYwzKEC7GF7cjMC7LC8s2EMnbHLMLB5wtwL0hnfmTHscO7pFbaSfiAeSiRVx6wzk8p1av1hWjZ0VXSCq+tFB+/v54GsnCQPnYRwt+vKDK5BWtH0vg2CNWqAwayOma0t2GB9+Q2YS59hVbGw+8wMMaUNO5mFy5IBpZFkxwSfo3zazglBmi0DtQShZooVm7w0/kjH986/4mUcDw1otIJkpgo488wnVI6XQsk0keIciKmtjw3Mz+QzUkwlT/6DvkNzzKBXBKZbreyBhviM+pIEONHBbvGCzXzkC4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4P/pZiBUzjfO1TSlGB10tzMEhZLzoCZVJDPflngopzw=;
 b=d/hWoh5JufIl/rn2NXUCO8BPeZor/qqYwNfSGJavPmyYDOuVtPDRFtt/oLdlIb9VN7NGQHEFq18iCJFOX4ebkvPOEGv/3t+4RDCCoo2Lh6gcbgo08j3tfJLYdbdk1Cf5rP9dX0lkYthipiKq4rT09NfYqLuuh9NrfRMKgEj4UVC1uCeLWMEZawjnbqj986CCtKVwvniec0WsW6g4/fBO5SA60WeV1F7Yi8VW6YCW/pciE57G1qgX3nQJwimDQ2+E/fqEnbJP80vGsbTOoVjXXFTDemqlYf9ak1Lr9tDHkyC7YU53efVq5Hno8yZqmKmp3OediMDa7md5BiFebNYLBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4P/pZiBUzjfO1TSlGB10tzMEhZLzoCZVJDPflngopzw=;
 b=LuFWKqgQB4lv0NjVQ4DwpDSLYMLffW2cGlwseGB3ESVNVfEVhnYILmKkaVQ7s2UR10B0d5iTQKC1mixjnKDwmjHPZ2tMGcwcD39xuZIuawWPEIQqz6Ug1EsSoPSfxVwFtk8OEYfP1GGjZ2CrjNZ+BZ7xSpxbwVQNGV7fVa08WGqQaZ9hUoSPqx3UDD8Ue5ZOmY+yZ/kAqJTBOg81e9u7mebjc7+D9Noa/iWX6/HaqeSc/wDTCE3TiIDSYmLc/j7rfSCYwYKr0jfOR0G3sfQJozHoDzKP2r4v6IfBM5GCW+kuIgOMatT2FuuXnt2knlc29z5KzLDpStYkxoPLfMksKg==
Received: from DU2PR04CA0039.eurprd04.prod.outlook.com (2603:10a6:10:234::14)
 by VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:e3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Tue, 8 Mar
 2022 19:35:36 +0000
Received: from DB5EUR01FT053.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:234:cafe::7b) by DU2PR04CA0039.outlook.office365.com
 (2603:10a6:10:234::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Tue, 8 Mar 2022 19:35:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.73) by
 DB5EUR01FT053.mail.protection.outlook.com (10.152.5.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Tue, 8 Mar 2022 19:35:36 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 8 Mar 2022 20:35:35 +0100
Received: from localhost.localdomain (167.87.32.5) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 8 Mar 2022 20:35:35 +0100
From:   Henning Schild <henning.schild@siemens.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Mark Gross <markgross@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>, Enrico Weigelt <lkml@metux.net>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH 2/2] leds: simatic-ipc-leds-gpio: add GPIO version of Siemens driver
Date:   Tue, 8 Mar 2022 20:35:22 +0100
Message-ID: <20220308193522.26696-3-henning.schild@siemens.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220308193522.26696-1-henning.schild@siemens.com>
References: <20220131151346.45792-1-andriy.shevchenko@linux.intel.com>
 <20220308193522.26696-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [167.87.32.5]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--8.549500-8.000000
X-TMASE-MatchedRID: cFv5M0vAheta0fQUqAzR3e3DB3+/CehKE34mKqQRielKtJAbYAprczMD
        HwdijHSHBph69XjMbdmAecOigRAlta3aC25avUuaSwG3KDMI8e8i0gNgcOfRtoY5QY8KaJtTdFS
        hyLDxof9WtqPVHVdXmMRLhY4YFk6tSpLsaBDNZu9NiTj8hqiOOFCmyOJJq7C0TvKpZzlxUs+NY/
        pqxovzxSiho3Yx5jAibuUFf/ftHinvTdvFoUrn/1PN/NUwB3i/MNC3Xj2tG7LfSQNpZkETVDFcf
        92WG8u/WaGFzkcqBkl79xCSa3QbsXjfaEUd3sukxtBcxzOivxZ8Ce7b2ZEcq1N7BS4nAhYVhVDn
        kfzD7uYOkJQR4QWbsMRf0/tVPfcblOSYZlnQW/AiTMW5ZqQa6FP8N0xmYb7azNIobH2DzGFVogW
        RsEaR/msoHwKHdDo36dAjf9Fk9GpL0qen/wedYdoP5MB/iAfxlCv0a7truiKeAiCmPx4NwBnUJ0
        Ek6yhjxEHRux+uk8jHUU+U0ACZwHqMCzY77a4j0Vld27YPhBhkd0fT8AYHwRVt3i2HPS02nqg/V
        rSZEiM=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.549500-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: BD2C0BDDC919A38E5A4C1749FD5AAE3AB33D97C4C9A76F87F2E99345013E8B8D2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60eae7c2-d319-4d37-299b-08da013ad1b0
X-MS-TrafficTypeDiagnostic: VI1PR10MB2672:EE_
X-Microsoft-Antispam-PRVS: <VI1PR10MB2672450BB36033A5ACAC7DE385099@VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XI0bBFjoZaBNSI4Gqe7tXobyrsLlMGlBZQskbyn/xp01PyaA8ycJLwT5vqZkT9scVYfVccIla6I9rd49EIB2tIG7g9gGyec90vYHXb7bjZvJT+5Xt0ETweG6Y8fPMzOf9wDtDzcvvDxGELmh9QgD/aJih3lUkeGqck0OG+vgFSvmTsd6JLS5N6/uSb3Ss9IcaRN4AJFpiXGQFDYdS4/N1yiuenWLGBU60w/JdAO1n9WWafV1ILvlCZ8jFRkiVpwwglJsBj+sC7VEUDA7WWAumAo3u1QazrPmxReMrWP50kCtiz41F3bqUH3PJq0CIKKAl2pbxQ/2jZluTkSZd1CYgBbA+BFPkhrMvtXXIz/z4rb+YRCNORyJp7LMQ5/bOI4TcBKciFH/PP51LQiAzhwZ6TFFVUvGy8hO3m26ChysV4U+aT96Z/H/1eDzJuA5IOBoBGGrGthx3QFWnY805TwvRyfHaR9fYtS4W1URN1CM3f6gd/m1549AGohgBgSUw90+Uoon8t5wW/vmINSRj74umk9xQbCeYzOef+z96mHqdbF93DGlcCiqYImCMzoeT83HMsdqY20xCL1VSV14DCkDiwbqIjy0qjJA04GmDgg0kdBDcgiYBdqN+S8EetbkQiPOkiTuHjPetlwoBX7h3MOxGj3sma6Nhw6Y5j9pVJQKDzXAzb8WTC/fBczEFO+7DqAn/jLsdtLkpHu13hTMyySipg==
X-Forefront-Antispam-Report: CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(2616005)(16526019)(40460700003)(82960400001)(2906002)(82310400004)(81166007)(5660300002)(30864003)(36756003)(356005)(86362001)(8936002)(44832011)(316002)(6916009)(107886003)(956004)(336012)(186003)(26005)(508600001)(54906003)(6666004)(1076003)(47076005)(8676002)(36860700001)(4326008)(83380400001)(70586007)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 19:35:36.3346
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60eae7c2-d319-4d37-299b-08da013ad1b0
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT053.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2672
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Apollo Lake the pinctrl drivers will now come up without ACPI. Use
that instead of open coding it.
Create a new driver for that which can later be filled with more GPIO
based models, and which has different dependencies.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/leds/simple/Kconfig                 |  12 ++-
 drivers/leds/simple/Makefile                |   3 +-
 drivers/leds/simple/simatic-ipc-leds-gpio.c | 108 ++++++++++++++++++++
 drivers/leds/simple/simatic-ipc-leds.c      |  75 +-------------
 drivers/platform/x86/simatic-ipc.c          |   5 +-
 5 files changed, 129 insertions(+), 74 deletions(-)
 create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio.c

diff --git a/drivers/leds/simple/Kconfig b/drivers/leds/simple/Kconfig
index 9293e6b36c75..9d2487908743 100644
--- a/drivers/leds/simple/Kconfig
+++ b/drivers/leds/simple/Kconfig
@@ -3,10 +3,20 @@ config LEDS_SIEMENS_SIMATIC_IPC
 	tristate "LED driver for Siemens Simatic IPCs"
 	depends on LEDS_CLASS
 	depends on SIEMENS_SIMATIC_IPC
-	select P2SB if X86
 	help
 	  This option enables support for the LEDs of several Industrial PCs
 	  from Siemens.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called simatic-ipc-leds.
+
+config LEDS_SIEMENS_SIMATIC_IPC_GPIO
+	tristate "LED driver for Siemens Simatic IPCs, GPIO based"
+	depends on SIEMENS_SIMATIC_IPC
+	depends on LEDS_GPIO
+	help
+	  This option enables support for the LEDs of several Industrial PCs
+	  from Siemens.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called simatic-ipc-leds-gpio.
diff --git a/drivers/leds/simple/Makefile b/drivers/leds/simple/Makefile
index 8481f1e9e360..e1df74fb5915 100644
--- a/drivers/leds/simple/Makefile
+++ b/drivers/leds/simple/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)	+= simatic-ipc-leds.o
+obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)		+= simatic-ipc-leds.o
+obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC_GPIO)	+= simatic-ipc-leds-gpio.o
diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio.c b/drivers/leds/simple/simatic-ipc-leds-gpio.c
new file mode 100644
index 000000000000..552b65a72e04
--- /dev/null
+++ b/drivers/leds/simple/simatic-ipc-leds-gpio.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Siemens SIMATIC IPC driver for GPIO based LEDs
+ *
+ * Copyright (c) Siemens AG, 2022
+ *
+ * Authors:
+ *  Henning Schild <henning.schild@siemens.com>
+ */
+
+#include <linux/gpio/machine.h>
+#include <linux/gpio/consumer.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+static struct gpiod_lookup_table simatic_ipc_led_gpio_table = {
+	.dev_id = "leds-gpio",
+	.table = {
+		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 51, NULL, 0, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 52, NULL, 1, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 53, NULL, 2, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 57, NULL, 3, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 58, NULL, 4, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 60, NULL, 5, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 56, NULL, 6, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 59, NULL, 7, GPIO_ACTIVE_HIGH),
+	}
+};
+
+static const struct gpio_led simatic_ipc_gpio_leds[] = {
+	{ .name = "green:" LED_FUNCTION_STATUS "-3" },
+	{ .name = "red:" LED_FUNCTION_STATUS "-1" },
+	{ .name = "green:" LED_FUNCTION_STATUS "-1" },
+	{ .name = "red:" LED_FUNCTION_STATUS "-2" },
+	{ .name = "green:" LED_FUNCTION_STATUS "-2" },
+	{ .name = "red:" LED_FUNCTION_STATUS "-3" },
+};
+
+static const struct gpio_led_platform_data simatic_ipc_gpio_leds_pdata = {
+	.num_leds	= ARRAY_SIZE(simatic_ipc_gpio_leds),
+	.leds		= simatic_ipc_gpio_leds,
+};
+
+static struct platform_device *simatic_leds_pdev;
+
+static int simatic_ipc_leds_gpio_remove(struct platform_device *pdev)
+{
+	gpiod_remove_lookup_table(&simatic_ipc_led_gpio_table);
+	platform_device_unregister(simatic_leds_pdev);
+
+	return 0;
+}
+
+static int simatic_ipc_leds_gpio_probe(struct platform_device *pdev)
+{
+	struct gpio_desc *gpiod;
+	int err;
+
+	gpiod_add_lookup_table(&simatic_ipc_led_gpio_table);
+	simatic_leds_pdev = platform_device_register_resndata(NULL,
+		"leds-gpio", PLATFORM_DEVID_NONE, NULL, 0,
+		&simatic_ipc_gpio_leds_pdata,
+		sizeof(simatic_ipc_gpio_leds_pdata));
+	if (IS_ERR(simatic_leds_pdev)) {
+		err = PTR_ERR(simatic_leds_pdev);
+		goto out;
+	}
+
+	/* PM_BIOS_BOOT_N */
+	gpiod = gpiod_get_index(&simatic_leds_pdev->dev, NULL, 6, 0);
+	if (IS_ERR(gpiod)) {
+		err = PTR_ERR(gpiod);
+		goto out;
+	}
+	gpiod_set_value(gpiod, 0);
+	gpiod_put(gpiod);
+
+	/* PM_WDT_OUT */
+	gpiod = gpiod_get_index(&simatic_leds_pdev->dev, NULL, 7, 0);
+	if (IS_ERR(gpiod)) {
+		err = PTR_ERR(gpiod);
+		goto out;
+	}
+	gpiod_set_value(gpiod, 0);
+	gpiod_put(gpiod);
+
+	return 0;
+out:
+	simatic_ipc_leds_gpio_remove(pdev);
+
+	return err;
+}
+
+static struct platform_driver simatic_ipc_led_gpio_driver = {
+	.probe = simatic_ipc_leds_gpio_probe,
+	.remove = simatic_ipc_leds_gpio_remove,
+	.driver = {
+		.name = KBUILD_MODNAME,
+	}
+};
+
+module_platform_driver(simatic_ipc_led_gpio_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" KBUILD_MODNAME);
+MODULE_SOFTDEP("pre: platform:leds-gpio");
+MODULE_AUTHOR("Henning Schild <henning.schild@siemens.com>");
diff --git a/drivers/leds/simple/simatic-ipc-leds.c b/drivers/leds/simple/simatic-ipc-leds.c
index 215ef5b74236..0f0dee053aa1 100644
--- a/drivers/leds/simple/simatic-ipc-leds.c
+++ b/drivers/leds/simple/simatic-ipc-leds.c
@@ -24,7 +24,7 @@
 #define SIMATIC_IPC_LED_PORT_BASE	0x404E
 
 struct simatic_ipc_led {
-	unsigned int value; /* mask for io and offset for mem */
+	unsigned int value; /* mask for io */
 	char *name;
 	struct led_classdev cdev;
 };
@@ -39,21 +39,6 @@ static struct simatic_ipc_led simatic_ipc_leds_io[] = {
 	{ }
 };
 
-/* the actual start will be discovered with p2sb, 0 is a placeholder */
-struct resource simatic_ipc_led_mem_res = DEFINE_RES_MEM_NAMED(0, 0, KBUILD_MODNAME);
-
-static void *simatic_ipc_led_memory;
-
-static struct simatic_ipc_led simatic_ipc_leds_mem[] = {
-	{0x500 + 0x1A0, "red:" LED_FUNCTION_STATUS "-1"},
-	{0x500 + 0x1A8, "green:" LED_FUNCTION_STATUS "-1"},
-	{0x500 + 0x1C8, "red:" LED_FUNCTION_STATUS "-2"},
-	{0x500 + 0x1D0, "green:" LED_FUNCTION_STATUS "-2"},
-	{0x500 + 0x1E0, "red:" LED_FUNCTION_STATUS "-3"},
-	{0x500 + 0x198, "green:" LED_FUNCTION_STATUS "-3"},
-	{ }
-};
-
 static struct resource simatic_ipc_led_io_res =
 	DEFINE_RES_IO_NAMED(SIMATIC_IPC_LED_PORT_BASE, SZ_2, KBUILD_MODNAME);
 
@@ -89,27 +74,6 @@ static enum led_brightness simatic_ipc_led_get_io(struct led_classdev *led_cd)
 	return inw(SIMATIC_IPC_LED_PORT_BASE) & led->value ? LED_OFF : led_cd->max_brightness;
 }
 
-static void simatic_ipc_led_set_mem(struct led_classdev *led_cd,
-				    enum led_brightness brightness)
-{
-	struct simatic_ipc_led *led = cdev_to_led(led_cd);
-
-	u32 *p;
-
-	p = simatic_ipc_led_memory + led->value;
-	*p = (*p & ~1) | (brightness == LED_OFF);
-}
-
-static enum led_brightness simatic_ipc_led_get_mem(struct led_classdev *led_cd)
-{
-	struct simatic_ipc_led *led = cdev_to_led(led_cd);
-
-	u32 *p;
-
-	p = simatic_ipc_led_memory + led->value;
-	return (*p & 1) ? LED_OFF : led_cd->max_brightness;
-}
-
 static int simatic_ipc_leds_probe(struct platform_device *pdev)
 {
 	const struct simatic_ipc_platform *plat = pdev->dev.platform_data;
@@ -117,8 +81,7 @@ static int simatic_ipc_leds_probe(struct platform_device *pdev)
 	struct simatic_ipc_led *ipcled;
 	struct led_classdev *cdev;
 	struct resource *res;
-	int err, type;
-	u32 *p;
+	int err;
 
 	switch (plat->devmode) {
 	case SIMATIC_IPC_DEVICE_227D:
@@ -133,35 +96,10 @@ static int simatic_ipc_leds_probe(struct platform_device *pdev)
 			}
 			ipcled = simatic_ipc_leds_io;
 		}
-		type = IORESOURCE_IO;
 		if (!devm_request_region(dev, res->start, resource_size(res), KBUILD_MODNAME)) {
 			dev_err(dev, "Unable to register IO resource at %pR\n", res);
 			return -EBUSY;
 		}
-		break;
-	case SIMATIC_IPC_DEVICE_127E:
-		res = &simatic_ipc_led_mem_res;
-		ipcled = simatic_ipc_leds_mem;
-		type = IORESOURCE_MEM;
-
-		err = p2sb_bar(NULL, 0, res);
-		if (err)
-			return err;
-
-		/* do the final address calculation */
-		res->start = res->start + (0xC5 << 16);
-		res->end = res->start + SZ_4K - 1;
-
-		simatic_ipc_led_memory = devm_ioremap_resource(dev, res);
-		if (IS_ERR(simatic_ipc_led_memory))
-			return PTR_ERR(simatic_ipc_led_memory);
-
-		/* initialize power/watchdog LED */
-		p = simatic_ipc_led_memory + 0x500 + 0x1D8; /* PM_WDT_OUT */
-		*p = (*p & ~1);
-		p = simatic_ipc_led_memory + 0x500 + 0x1C0; /* PM_BIOS_BOOT_N */
-		*p = (*p | 1);
-
 		break;
 	default:
 		return -ENODEV;
@@ -169,13 +107,8 @@ static int simatic_ipc_leds_probe(struct platform_device *pdev)
 
 	while (ipcled->value) {
 		cdev = &ipcled->cdev;
-		if (type == IORESOURCE_MEM) {
-			cdev->brightness_set = simatic_ipc_led_set_mem;
-			cdev->brightness_get = simatic_ipc_led_get_mem;
-		} else {
-			cdev->brightness_set = simatic_ipc_led_set_io;
-			cdev->brightness_get = simatic_ipc_led_get_io;
-		}
+		cdev->brightness_set = simatic_ipc_led_set_io;
+		cdev->brightness_get = simatic_ipc_led_get_io;
 		cdev->max_brightness = LED_ON;
 		cdev->name = ipcled->name;
 
diff --git a/drivers/platform/x86/simatic-ipc.c b/drivers/platform/x86/simatic-ipc.c
index 26c35e1660cb..ca3647b751d5 100644
--- a/drivers/platform/x86/simatic-ipc.c
+++ b/drivers/platform/x86/simatic-ipc.c
@@ -51,6 +51,7 @@ static int register_platform_devices(u32 station_id)
 {
 	u8 ledmode = SIMATIC_IPC_DEVICE_NONE;
 	u8 wdtmode = SIMATIC_IPC_DEVICE_NONE;
+	char *pdevname = KBUILD_MODNAME "_leds";
 	int i;
 
 	platform_data.devmode = SIMATIC_IPC_DEVICE_NONE;
@@ -64,10 +65,12 @@ static int register_platform_devices(u32 station_id)
 	}
 
 	if (ledmode != SIMATIC_IPC_DEVICE_NONE) {
+		if (ledmode == SIMATIC_IPC_DEVICE_127E)
+			pdevname = KBUILD_MODNAME "_leds_gpio";
 		platform_data.devmode = ledmode;
 		ipc_led_platform_device =
 			platform_device_register_data(NULL,
-				KBUILD_MODNAME "_leds", PLATFORM_DEVID_NONE,
+				pdevname, PLATFORM_DEVID_NONE,
 				&platform_data,
 				sizeof(struct simatic_ipc_platform));
 		if (IS_ERR(ipc_led_platform_device))
-- 
2.34.1

