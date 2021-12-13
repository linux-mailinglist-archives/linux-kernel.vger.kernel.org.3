Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5974F472BE6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 13:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236428AbhLMMFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 07:05:24 -0500
Received: from mail-vi1eur05on2057.outbound.protection.outlook.com ([40.107.21.57]:30720
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231464AbhLMMFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 07:05:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E7uCnrK66u6EYdzkhV594z9eBgBCac2KLxDlP6zUVxfvgPZxe6FIx+pkimx3Kmr1Xusg7tpQ9JeWlh8TC2LqMnOlqlgiFXblFQ8nsyMth0fz3cEauuQCAGGpvhnmzQn56SBir0xewkVXSPRAa8buYurJO1CqGQt5O2Dyc2H0IZQV+AnpqUBBGYyBqiShTjwKJFSRV8wKUCCa54/8xJiAv5IAnoUUIIbrUiinfpCx1ac6UCivhMh1/j4HZjDi9rcEbrudgRrdZk6PIEIOYEaPs1bUq/JVmVq7YDgzRD+KOIrMA2YznVcId2LRzbQvTG5fQty1ILWUELQKb/1vGBEcSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ln0ZnVsgkeqt6Yn0oalr7/XDDfXbDzMIcyaFMYjPe40=;
 b=KfQ7/prHgMJkBCrcDR/DNcDZ2r1sDWZYkFdgemAPa+8ABXdn5f0MKYcicgsK0XIyRNOHFyYszpbxh05ZAFVHDHV2+9nDa4oQQU9H5V57CbTpdBUR9UvMkFjdytloSbclFnJ+CcfFvcb00jrcin0Ku4CxQnynwJ0Mej7pBQ9yuvO6RciSdTMRfD0bC5hg+CmHB4QLkmnqebJkmtkkJlCl76uVjEskfpcX0lmL4IHSVCfWXGqbRf54Cj9VsdXV1OoN5lToC+O5CZiys/4oZFj/jNLOg7n9Y7S1qfJmrNk9SAx1fCamuhb4RntSZwz5GoJjreP6k0FekI3FB6GaJpq/NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ln0ZnVsgkeqt6Yn0oalr7/XDDfXbDzMIcyaFMYjPe40=;
 b=CXZVh+r3HJ5oSpa6sIuok2yrFzEHCxgZYl0qo38SXYpINuTjMFBLSkPZ3kZMBfqPtJBMP+SA7+75aEnqiLB/QVYYMqgaLlHlaFPug7Ix8EUx0BCX7OGAED1NiM995eOXGac6t+BUoGqNDlOOpWZdbfGDmguTTQ8I9cr3usEERay7RnICXK1akThyFJQVhI0Y/ll6fclTzICs+/B+XvzVIvbmsnsbcAgz6ebgeRNnZ5JuydCxf1vsqGiT1wGLQ04qusl++h7nfio+biQAmhiroqjjBSF0vfarAsXGmyvrhw11KFP00d8/Ij6bD2LfcRuleOMxR8GXiOqsBwzC/sfBbg==
Received: from OL1P279CA0044.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:14::13)
 by AM9PR10MB3990.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1cf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 12:05:14 +0000
Received: from HE1EUR01FT037.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:14:cafe::94) by OL1P279CA0044.outlook.office365.com
 (2603:10a6:e10:14::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13 via Frontend
 Transport; Mon, 13 Dec 2021 12:05:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.71) by
 HE1EUR01FT037.mail.protection.outlook.com (10.152.1.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.12 via Frontend Transport; Mon, 13 Dec 2021 12:05:13 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 13 Dec 2021 13:05:13 +0100
Received: from md1za8fc.ad001.siemens.net (139.25.69.80) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 13 Dec 2021 13:05:12 +0100
From:   Henning Schild <henning.schild@siemens.com>
To:     <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>
CC:     Srikanth Krishnakar <skrishnakar@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Henning Schild <henning.schild@siemens.com>,
        "Gerd Haeussler" <gerd.haeussler.ext@siemens.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mark Gross <mgross@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Pavel Machek <pavel@ucw.cz>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Enrico Weigelt <lkml@metux.net>
Subject: [PATCH v5 1/4] platform/x86: simatic-ipc: add main driver for Siemens devices
Date:   Mon, 13 Dec 2021 13:04:59 +0100
Message-ID: <20211213120502.20661-2-henning.schild@siemens.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211213120502.20661-1-henning.schild@siemens.com>
References: <20211213120502.20661-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.69.80]
X-ClientProxiedBy: DEMCHDC89YA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9741f765-0615-4aed-e0ef-08d9be30d1e4
X-MS-TrafficTypeDiagnostic: AM9PR10MB3990:EE_
X-Microsoft-Antispam-PRVS: <AM9PR10MB3990D88EDFE5C31B158E551285749@AM9PR10MB3990.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:972;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yHq6Y+QHPKX0goyQ/GqrK0MhHgC1Kk4Fy7p4LOXDTS6BFjDaNSuwvUWj/ItsZLv7aPmwZm4TZYzCtbLFNOHc7oJUrnvG25TAd7GEk9RL9FRCMrXvjOJqwwQ9C+EtbiXxOSDbPIkzBO/XLlxsjWZ4ycFpjLIXPAaKqtIi5XT76ZALHngQ+50C0Cd1Qr0sOOk+JimP692ScKidfGMNR4x1RnKLvCW3HTV9fOPQCzYwp8765ciMKeqLQ6eA/1wHzn0hEVBcMkIX33hJzHabb2IRzgAJcIOPuMqEls3z9dQFdjnybhQrogz7onvQU/i4F9UrFjGguFhMmpbaYkx4fjDFadyNZFjr+07R7KSRCLj5+V8HjO/MoQz9ujSQ5TBYLaUKEeegcYDFm7fFMU+7LSJvLbezBSh4IkLj+U5lfqzVw4YpXokxh0XuXCmvZolk/ryJvmZmYxc+2THUCG1rZ3F2inTgancG+2DyIZ0OzwGmGulFTKM9+bRVoHR4aYDN30TVRdWB+Rb6ckhFEN+Ib8pwnHiOAG5AAQcxV6VOez6itlhYgWMJlJ3rVVDH2dR5oP1D7+lTg/tVOCM6nAhN5O5jf+yZ+hZLR2MQVXpXmmOSlvpr+AaSmvwzJ95sgCnLAGK2sIU4b03ss83q/6l2SGOldhDS/A5mQ4UI0x0I3i1riIOdc43poCBRNKBeEsgfAk1Rhk8+BfT6ZETjVrqXpKSTePQxnSp5sq+XrqE1gvVF1zc=
X-Forefront-Antispam-Report: CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(36756003)(30864003)(4326008)(5660300002)(81166007)(356005)(83380400001)(70586007)(336012)(86362001)(7416002)(2906002)(26005)(8676002)(54906003)(82310400004)(70206006)(44832011)(8936002)(2616005)(956004)(508600001)(110136005)(1076003)(36860700001)(6666004)(47076005)(82960400001)(16526019)(316002)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 12:05:13.8000
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9741f765-0615-4aed-e0ef-08d9be30d1e4
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT037.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB3990
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This mainly implements detection of these devices and will allow
secondary drivers to work on such machines.

The identification is DMI-based with a vendor specific way to tell them
apart in a reliable way.

Drivers for LEDs and Watchdogs will follow to make use of that platform
detection.

There is also some code to allow secondary drivers to find GPIO memory,
that needs to be in place because the pinctrl drivers do not come up.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/platform/x86/Kconfig                  |  12 ++
 drivers/platform/x86/Makefile                 |   3 +
 drivers/platform/x86/simatic-ipc.c            | 176 ++++++++++++++++++
 .../platform_data/x86/simatic-ipc-base.h      |  29 +++
 include/linux/platform_data/x86/simatic-ipc.h |  72 +++++++
 5 files changed, 292 insertions(+)
 create mode 100644 drivers/platform/x86/simatic-ipc.c
 create mode 100644 include/linux/platform_data/x86/simatic-ipc-base.h
 create mode 100644 include/linux/platform_data/x86/simatic-ipc.h

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 7400bc5da5be..a59f3bff5ae1 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1075,6 +1075,18 @@ config INTEL_SCU_IPC_UTIL
 	  low level access for debug work and updating the firmware. Say
 	  N unless you will be doing this on an Intel MID platform.
 
+config SIEMENS_SIMATIC_IPC
+	tristate "Siemens Simatic IPC Class driver"
+	depends on PCI
+	help
+	  This Simatic IPC class driver is the central of several drivers. It
+	  is mainly used for system identification, after which drivers in other
+	  classes will take care of driving specifics of those machines.
+	  i.e. LEDs and watchdog.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called simatic-ipc.
+
 endif # X86_PLATFORM_DEVICES
 
 config PMC_ATOM
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 219478061683..310d1d2a0886 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -123,3 +123,6 @@ obj-$(CONFIG_INTEL_SCU_PLATFORM)	+= intel_scu_pltdrv.o
 obj-$(CONFIG_INTEL_SCU_WDT)		+= intel_scu_wdt.o
 obj-$(CONFIG_INTEL_SCU_IPC_UTIL)	+= intel_scu_ipcutil.o
 obj-$(CONFIG_PMC_ATOM)			+= pmc_atom.o
+
+# Siemens Simatic Industrial PCs
+obj-$(CONFIG_SIEMENS_SIMATIC_IPC)	+= simatic-ipc.o
diff --git a/drivers/platform/x86/simatic-ipc.c b/drivers/platform/x86/simatic-ipc.c
new file mode 100644
index 000000000000..b599cda5ba3c
--- /dev/null
+++ b/drivers/platform/x86/simatic-ipc.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Siemens SIMATIC IPC platform driver
+ *
+ * Copyright (c) Siemens AG, 2018-2021
+ *
+ * Authors:
+ *  Henning Schild <henning.schild@siemens.com>
+ *  Jan Kiszka <jan.kiszka@siemens.com>
+ *  Gerd Haeussler <gerd.haeussler.ext@siemens.com>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/dmi.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/platform_data/x86/simatic-ipc.h>
+#include <linux/platform_device.h>
+
+static struct platform_device *ipc_led_platform_device;
+static struct platform_device *ipc_wdt_platform_device;
+
+static const struct dmi_system_id simatic_ipc_whitelist[] = {
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "SIEMENS AG"),
+		},
+	},
+	{}
+};
+
+static struct simatic_ipc_platform platform_data;
+
+static struct {
+	u32 station_id;
+	u8 led_mode;
+	u8 wdt_mode;
+} device_modes[] = {
+	{SIMATIC_IPC_IPC127E, SIMATIC_IPC_DEVICE_127E, SIMATIC_IPC_DEVICE_NONE},
+	{SIMATIC_IPC_IPC227D, SIMATIC_IPC_DEVICE_227D, SIMATIC_IPC_DEVICE_NONE},
+	{SIMATIC_IPC_IPC227E, SIMATIC_IPC_DEVICE_427E, SIMATIC_IPC_DEVICE_227E},
+	{SIMATIC_IPC_IPC277E, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_227E},
+	{SIMATIC_IPC_IPC427D, SIMATIC_IPC_DEVICE_427E, SIMATIC_IPC_DEVICE_NONE},
+	{SIMATIC_IPC_IPC427E, SIMATIC_IPC_DEVICE_427E, SIMATIC_IPC_DEVICE_427E},
+	{SIMATIC_IPC_IPC477E, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_427E},
+};
+
+static int register_platform_devices(u32 station_id)
+{
+	u8 ledmode = SIMATIC_IPC_DEVICE_NONE;
+	u8 wdtmode = SIMATIC_IPC_DEVICE_NONE;
+	int i;
+
+	platform_data.devmode = SIMATIC_IPC_DEVICE_NONE;
+
+	for (i = 0; i < ARRAY_SIZE(device_modes); i++) {
+		if (device_modes[i].station_id == station_id) {
+			ledmode = device_modes[i].led_mode;
+			wdtmode = device_modes[i].wdt_mode;
+			break;
+		}
+	}
+
+	if (ledmode != SIMATIC_IPC_DEVICE_NONE) {
+		platform_data.devmode = ledmode;
+		ipc_led_platform_device =
+			platform_device_register_data(NULL,
+				KBUILD_MODNAME "_leds", PLATFORM_DEVID_NONE,
+				&platform_data,
+				sizeof(struct simatic_ipc_platform));
+		if (IS_ERR(ipc_led_platform_device))
+			return PTR_ERR(ipc_led_platform_device);
+
+		pr_debug("device=%s created\n",
+			 ipc_led_platform_device->name);
+	}
+
+	if (wdtmode != SIMATIC_IPC_DEVICE_NONE) {
+		platform_data.devmode = wdtmode;
+		ipc_wdt_platform_device =
+			platform_device_register_data(NULL,
+				KBUILD_MODNAME "_wdt", PLATFORM_DEVID_NONE,
+				&platform_data,
+				sizeof(struct simatic_ipc_platform));
+		if (IS_ERR(ipc_wdt_platform_device))
+			return PTR_ERR(ipc_wdt_platform_device);
+
+		pr_debug("device=%s created\n",
+			 ipc_wdt_platform_device->name);
+	}
+
+	if (ledmode == SIMATIC_IPC_DEVICE_NONE &&
+	    wdtmode == SIMATIC_IPC_DEVICE_NONE) {
+		pr_warn("unsupported IPC detected, station id=%08x\n",
+			station_id);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/* FIXME: this should eventually be done with generic P2SB discovery code
+ * the individual drivers for watchdogs and LEDs access memory that implements
+ * GPIO, but pinctrl will not come up because of missing ACPI entries
+ *
+ * While there is no conflict a cleaner solution would be to somehow bring up
+ * pinctrl even with these ACPI entries missing, and base the drivers on pinctrl.
+ * After which the following function could be dropped, together with the code
+ * poking the memory.
+ */
+/*
+ * Get membase address from PCI, used in leds and wdt module. Here we read
+ * the bar0. The final address calculation is done in the appropriate modules
+ */
+u32 simatic_ipc_get_membase0(unsigned int p2sb)
+{
+	struct pci_bus *bus;
+	u32 bar0 = 0;
+	/*
+	 * The GPIO memory is in bar0 of the hidden P2SB device.
+	 * Unhide the device to have a quick look at it, before we hide it
+	 * again.
+	 * Also grab the pci rescan lock so that device does not get discovered
+	 * and remapped while it is visible.
+	 * This code is inspired by drivers/mfd/lpc_ich.c
+	 */
+	bus = pci_find_bus(0, 0);
+	pci_lock_rescan_remove();
+	pci_bus_write_config_byte(bus, p2sb, 0xE1, 0x0);
+	pci_bus_read_config_dword(bus, p2sb, PCI_BASE_ADDRESS_0, &bar0);
+
+	bar0 &= ~0xf;
+	pci_bus_write_config_byte(bus, p2sb, 0xE1, 0x1);
+	pci_unlock_rescan_remove();
+
+	return bar0;
+}
+EXPORT_SYMBOL(simatic_ipc_get_membase0);
+
+static int __init simatic_ipc_init_module(void)
+{
+	const struct dmi_system_id *match;
+	u32 station_id;
+	int err;
+
+	match = dmi_first_match(simatic_ipc_whitelist);
+	if (!match)
+		return 0;
+
+	err = dmi_walk(simatic_ipc_find_dmi_entry_helper, &station_id);
+
+	if (err || station_id == SIMATIC_IPC_INVALID_STATION_ID) {
+		pr_warn("DMI entry %d not found\n", SIMATIC_IPC_DMI_ENTRY_OEM);
+		return 0;
+	}
+
+	return register_platform_devices(station_id);
+}
+
+static void __exit simatic_ipc_exit_module(void)
+{
+	platform_device_unregister(ipc_led_platform_device);
+	ipc_led_platform_device = NULL;
+
+	platform_device_unregister(ipc_wdt_platform_device);
+	ipc_wdt_platform_device = NULL;
+}
+
+module_init(simatic_ipc_init_module);
+module_exit(simatic_ipc_exit_module);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Gerd Haeussler <gerd.haeussler.ext@siemens.com>");
+MODULE_ALIAS("dmi:*:svnSIEMENSAG:*");
diff --git a/include/linux/platform_data/x86/simatic-ipc-base.h b/include/linux/platform_data/x86/simatic-ipc-base.h
new file mode 100644
index 000000000000..62d2bc774067
--- /dev/null
+++ b/include/linux/platform_data/x86/simatic-ipc-base.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Siemens SIMATIC IPC drivers
+ *
+ * Copyright (c) Siemens AG, 2018-2021
+ *
+ * Authors:
+ *  Henning Schild <henning.schild@siemens.com>
+ *  Gerd Haeussler <gerd.haeussler.ext@siemens.com>
+ */
+
+#ifndef __PLATFORM_DATA_X86_SIMATIC_IPC_BASE_H
+#define __PLATFORM_DATA_X86_SIMATIC_IPC_BASE_H
+
+#include <linux/types.h>
+
+#define SIMATIC_IPC_DEVICE_NONE 0
+#define SIMATIC_IPC_DEVICE_227D 1
+#define SIMATIC_IPC_DEVICE_427E 2
+#define SIMATIC_IPC_DEVICE_127E 3
+#define SIMATIC_IPC_DEVICE_227E 4
+
+struct simatic_ipc_platform {
+	u8	devmode;
+};
+
+u32 simatic_ipc_get_membase0(unsigned int p2sb);
+
+#endif /* __PLATFORM_DATA_X86_SIMATIC_IPC_BASE_H */
diff --git a/include/linux/platform_data/x86/simatic-ipc.h b/include/linux/platform_data/x86/simatic-ipc.h
new file mode 100644
index 000000000000..f3b76b39776b
--- /dev/null
+++ b/include/linux/platform_data/x86/simatic-ipc.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Siemens SIMATIC IPC drivers
+ *
+ * Copyright (c) Siemens AG, 2018-2021
+ *
+ * Authors:
+ *  Henning Schild <henning.schild@siemens.com>
+ *  Gerd Haeussler <gerd.haeussler.ext@siemens.com>
+ */
+
+#ifndef __PLATFORM_DATA_X86_SIMATIC_IPC_H
+#define __PLATFORM_DATA_X86_SIMATIC_IPC_H
+
+#include <linux/dmi.h>
+#include <linux/platform_data/x86/simatic-ipc-base.h>
+
+#define SIMATIC_IPC_DMI_ENTRY_OEM	129
+/* binary type */
+#define SIMATIC_IPC_DMI_TYPE		0xff
+#define SIMATIC_IPC_DMI_GROUP		0x05
+#define SIMATIC_IPC_DMI_ENTRY		0x02
+#define SIMATIC_IPC_DMI_TID		0x02
+
+enum simatic_ipc_station_ids {
+	SIMATIC_IPC_INVALID_STATION_ID = 0,
+	SIMATIC_IPC_IPC227D = 0x00000501,
+	SIMATIC_IPC_IPC427D = 0x00000701,
+	SIMATIC_IPC_IPC227E = 0x00000901,
+	SIMATIC_IPC_IPC277E = 0x00000902,
+	SIMATIC_IPC_IPC427E = 0x00000A01,
+	SIMATIC_IPC_IPC477E = 0x00000A02,
+	SIMATIC_IPC_IPC127E = 0x00000D01,
+};
+
+static inline u32 simatic_ipc_get_station_id(u8 *data, int max_len)
+{
+	struct {
+		u8	type;		/* type (0xff = binary) */
+		u8	len;		/* len of data entry */
+		u8	group;
+		u8	entry;
+		u8	tid;
+		__le32	station_id;	/* station id (LE) */
+	} __packed * data_entry = (void *)data + sizeof(struct dmi_header);
+
+	while ((u8 *)data_entry < data + max_len) {
+		if (data_entry->type == SIMATIC_IPC_DMI_TYPE &&
+		    data_entry->len == sizeof(*data_entry) &&
+		    data_entry->group == SIMATIC_IPC_DMI_GROUP &&
+		    data_entry->entry == SIMATIC_IPC_DMI_ENTRY &&
+		    data_entry->tid == SIMATIC_IPC_DMI_TID) {
+			return le32_to_cpu(data_entry->station_id);
+		}
+		data_entry = (void *)((u8 *)(data_entry) + data_entry->len);
+	}
+
+	return SIMATIC_IPC_INVALID_STATION_ID;
+}
+
+static inline void
+simatic_ipc_find_dmi_entry_helper(const struct dmi_header *dh, void *_data)
+{
+	u32 *id = _data;
+
+	if (dh->type != SIMATIC_IPC_DMI_ENTRY_OEM)
+		return;
+
+	*id = simatic_ipc_get_station_id((u8 *)dh, dh->length);
+}
+
+#endif /* __PLATFORM_DATA_X86_SIMATIC_IPC_H */
-- 
2.32.0

