Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A15457B0AB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 08:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238202AbiGTGAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 02:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237743AbiGTGAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 02:00:43 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD10599EF;
        Tue, 19 Jul 2022 23:00:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g99ceCDC++qF1sEZsmYym5q/GQiSzT5r7Kute608ac12F7FjbCeHaukV9AsoKwrMsAa7REr0lRxlXJhpYAnRNv7Ymp6GWDTgkpyaHQmqHl8ZAmNOu/8Vvd5kP8WrvjYVeaEmtNJDaviOeH80/l0SExLmd0PVJcoWe3H77vXY1hyFlC82rlJPKGONH745sSvYl0XbeHS4LUpHfrGEjB1yu/4ElAlYGBJsAHWUoXv/0f5XUj5EaeLyHi0SSmFrVEKwXAxEaIXlLkpxwfM/OtswnlqYn4pF0uYHd3ud5SkF/m1uZjKpQ3IOrTtU4tuRTD5k4gthFA65+QFC9mgrX6Kkwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GtIBs36yZrtOAzi5tVH3se8kBvp2BvGfeMWgH2rVoKc=;
 b=X2F6S8ch3scaUuJ8xdonXq0itaqGi/fPiKZpgTPlgLaNzFzK1z6xchHVN9u7629TJxlw8jV3n6B9lgVMpJB51BVlayTb6mnQlB5WoDDeFYDZaskVF3aY70aMIk+ezaqYja3xUEiE4ISXY40TVF5AKyqm6JwfhrCWmjbOA+srovPv5CoIu/KV6+kKHtvgMrBgoshF8hp7odh+AjbuaRKMbXnGi2mjOkjRXWXR2v1LEXbJuXT5N1kUXAFvm0/VYK+u7jwRgrkA2vCD7Jxsti+uV0W9P4ZKLV9R/emCzXJwVj+QVqPUuya9w4SHT+P7IbNMR4vYSBYULW6HtnqVTtPxFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtIBs36yZrtOAzi5tVH3se8kBvp2BvGfeMWgH2rVoKc=;
 b=xGZvW08cKEAOUFEcS1VPpr1RlpwfDZka9U6NReFuzM1eL4ARuzPXk85BqTcQNv5ps0mTQ3fZhHXj8GmEFCzGOpAc3uW7pVEe06i6wpCW1ceQ556sSJ3qLHb/2vUpmWMhWSoV72c2KTxQUthSajUKP+tDRdyL1s8VVGZBsxnGt20=
Received: from BN9PR03CA0577.namprd03.prod.outlook.com (2603:10b6:408:10d::12)
 by MN2PR12MB4222.namprd12.prod.outlook.com (2603:10b6:208:19a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.15; Wed, 20 Jul
 2022 06:00:37 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::b1) by BN9PR03CA0577.outlook.office365.com
 (2603:10b6:408:10d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23 via Frontend
 Transport; Wed, 20 Jul 2022 06:00:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Wed, 20 Jul 2022 06:00:37 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 20 Jul
 2022 01:00:35 -0500
From:   Appana Durga Kedareswara rao 
        <appana.durga.kedareswara.rao@amd.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <michal.simek@xilinx.com>, <derek.kiernan@xilinx.com>,
        <dragan.cvetic@xilinx.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>
CC:     <appanad@amd.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@amd.com>,
        <git@xilinx.com>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Subject: [PATCH v2 4/4] drivers: misc: Add Support for TMR Inject IP
Date:   Wed, 20 Jul 2022 11:30:16 +0530
Message-ID: <20220720060016.1646317-5-appana.durga.kedareswara.rao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220720060016.1646317-1-appana.durga.kedareswara.rao@amd.com>
References: <20220720060016.1646317-1-appana.durga.kedareswara.rao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c1d0600-6a38-4e98-0c5e-08da6a152b06
X-MS-TrafficTypeDiagnostic: MN2PR12MB4222:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +ZY0eHgv2HWUJOz/BapLFyYNQR7jTfHzBXr8GJuaFQICSigK98zMKRaPkMNIeqmfzR5SbzewMLoGBCwKdPnQ+fkV9CSGzaIflCf73HgqRz6Av4duP4mscdFzbpoors57vSvkiEFq5lf6Zya6YImFIPejqfDfFhglF6vGKQVz/y+/ZFK3eNR/ewjgBmTo38Ze8J2L+6Z0iD+crC6hJctyZ6MQpDWXdsPWJvXbw4ClQjB1WWpZj1j6X3T9mAdmBQ/Faf4Gtt5nopvsq0DKLXjTsPiLwST15yAxmDriE4XDocGg1W7wIwTquN/CoE4RnEzLHkJrCSavq+4rw/s0H3ra/47t13Ko1v4j21wVaZ3NtA9HOnXFMlO9AtfJ1dBc+7XAp6q/vIoXYVEI03Z3OFH/gw0kUkzKzZH8pLwSOhq1NT5Rkg2R6yeD5vn1IUOmO8kQphsQSvBGzv8u/s3cm59VDNEVehygkMl+kLP6RrL7uWLy/pVt6EsBqP4faOwC6gSsP8Ax8uF6HyTCt+XGKbbmmIXPKkxfNwqOeQybX7Mq3laULC/I+Eoy6j6+HeX1yiggQK4WC4+bEcy5IK2qPoW+wtnJrIAVIE893LjhsjLVvc5CH2kCSPSPNDes8y3XOIAOh0S0rNsjbbWJ3+7bNtbVes8gfRYjXCyNMNabQRxI70D3qXi0CZ24BZJoX32IIjwScAplC6t8fE3iqyeSjrhinZJ9BO9KE0qUDcrTB+/I/pTkBe4nTO/p20G//JZLAX17ZZxYIYdNf/HNGrvMMndoXGWJ1UwAekjI4OOFy5gP8FMz3xPdL7Y2x0/c5VfcKjL5fW3jgyk5iWE5vwFrDHTWrA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(136003)(396003)(346002)(36840700001)(40470700004)(46966006)(8676002)(70206006)(70586007)(5660300002)(54906003)(316002)(103116003)(110136005)(86362001)(8936002)(2906002)(36756003)(36860700001)(82740400003)(4326008)(81166007)(16526019)(426003)(478600001)(186003)(336012)(356005)(26005)(6666004)(41300700001)(82310400005)(83380400001)(40480700001)(2616005)(40460700003)(107886003)(1076003)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 06:00:37.4239
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c1d0600-6a38-4e98-0c5e-08da6a152b06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4222
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>

The Triple Modular Redundancy(TMR) provides functional fault injection by
changing selected MicroBlaze instructions, which provides the possibility
to verify that the TMR subsystem error detection and fault recovery logic
is working properly, provided sysfs entries which allow the user to inject
a fault.

Usage:
echo 1 > /sys/devices/platform/amba_pl/44a30000.tmr_inject/inject_err

Signed-off-by: Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>
Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
---
Changes for v2:
--> Added Examples for sysfs entries
--> Removed uneeded struct dev from the driver private structure
--> Updated driver to use sysfs_emit() API instead of sprintf() API
--> Added error checks wherever applicable.
--> Fixed sysfs registration.
 .../testing/sysfs-driver-xilinx-tmr-inject    |  16 ++
 MAINTAINERS                                   |   7 +
 drivers/misc/Kconfig                          |  10 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/xilinx_tmr_inject.c              | 186 ++++++++++++++++++
 5 files changed, 220 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-xilinx-tmr-inject
 create mode 100644 drivers/misc/xilinx_tmr_inject.c

diff --git a/Documentation/ABI/testing/sysfs-driver-xilinx-tmr-inject b/Documentation/ABI/testing/sysfs-driver-xilinx-tmr-inject
new file mode 100644
index 000000000000..d274b30ee24c
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-xilinx-tmr-inject
@@ -0,0 +1,16 @@
+What:		/sys/devices/platform/amba_pl/<dev>/inject_err
+Date:		June 2022
+Contact:	appana.durga.rao@xilinx.com
+Description:	This control file allows to inject fault using tmr inject.
+		This file is write only.
+		Example:
+		# echo 1 > /sys/devices/platform/amba_pl/44a30000.tmr_inject/inject_err
+
+What:		/sys/devices/platform/amba_pl/<dev>/inject_cpuid
+Date:		June 2022
+Contact:	appana.durga.rao@xilinx.com
+Description:	This control file allows to configure the CPU identifier
+		to enable fault injection.
+		This file is write only.
+		Example:
+		# echo 1 > /sys/devices/platform/amba_pl/44a30000.tmr_inject/inject_cpuid
diff --git a/MAINTAINERS b/MAINTAINERS
index 732fd9ae7d9f..c903b45c204a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13087,6 +13087,13 @@ F:	Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager
 F:	Documentation/devicetree/bindings/misc/xlnx,tmr-manager.yaml
 F:	drivers/misc/xilinx_tmr_manager.c
 
+MICROBLAZE TMR INJECT
+M:	Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>
+S:	Supported
+F:	Documentation/ABI/testing/sysfs-driver-xilinx-tmr-inject
+F:	Documentation/devicetree/bindings/misc/xlnx,tmr-inject.yaml
+F:	drivers/misc/xilinx_tmr_inject.c
+
 MICROCHIP AT91 DMA DRIVERS
 M:	Ludovic Desroches <ludovic.desroches@microchip.com>
 M:	Tudor Ambarus <tudor.ambarus@microchip.com>
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 555ae2e33b91..0989c36f3051 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -493,6 +493,16 @@ config TMR_MANAGER
 
 	  Say N here unless you know what you are doing.
 
+config TMR_INJECT
+	bool "Select TMR Inject"
+	depends on TMR_MANAGER
+	help
+	  This option enables the driver developed for TMR Inject.
+	  The Triple Modular Redundancy(TMR) Inject provides
+	  fault injection.
+
+	  Say N here unless you know what you are doing.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 28b9803f909b..e9d0a709e207 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -61,3 +61,4 @@ obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
 obj-$(CONFIG_HI6421V600_IRQ)	+= hi6421v600-irq.o
 obj-$(CONFIG_OPEN_DICE)		+= open-dice.o
 obj-$(CONFIG_TMR_MANAGER)	+= xilinx_tmr_manager.o
+obj-$(CONFIG_TMR_INJECT)	+= xilinx_tmr_inject.o
diff --git a/drivers/misc/xilinx_tmr_inject.c b/drivers/misc/xilinx_tmr_inject.c
new file mode 100644
index 000000000000..930d89e90b61
--- /dev/null
+++ b/drivers/misc/xilinx_tmr_inject.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for Xilinx TMR Inject IP.
+ *
+ * Copyright (C) 2022 Xilinx, Inc.
+ *
+ * Description:
+ * This driver is developed for TMR Inject IP,The Triple Modular Redundancy(TMR)
+ * Inject provides fault injection.
+ * Fault injection and detection features are provided through sysfs entries
+ * which allow the user to generate a fault.
+ */
+
+#include <asm/xilinx_mb_manager.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+
+/* TMR Inject Register offsets */
+#define XTMR_INJECT_CR_OFFSET		0x0
+#define XTMR_INJECT_AIR_OFFSET		0x4
+#define XTMR_INJECT_IIR_OFFSET		0xC
+#define XTMR_INJECT_EAIR_OFFSET		0x10
+#define XTMR_INJECT_ERR_OFFSET		0x204
+
+/* Register Bitmasks/shifts */
+#define XTMR_INJECT_CR_CPUID_SHIFT	8
+#define XTMR_INJECT_CR_IE_SHIFT		10
+#define XTMR_INJECT_IIR_ADDR_MASK	GENMASK(31, 16)
+
+#define XTMR_INJECT_MAGIC_MAX_VAL	255
+
+/**
+ * struct xtmr_inject_dev - Driver data for TMR Inject
+ * @regs: device physical base address
+ * @cr_val: control register value
+ * @magic: Magic hardware configuration value
+ * @err_cnt: error statistics count
+ */
+struct xtmr_inject_dev {
+	void __iomem *regs;
+	u32 cr_val;
+	u32 magic;
+	u32 err_cnt;
+};
+
+/* IO accessors */
+static inline void xtmr_inject_write(struct xtmr_inject_dev *xtmr_inject,
+				     u32 addr, u32 value)
+{
+	iowrite32(value, xtmr_inject->regs + addr);
+}
+
+static inline u32 xtmr_inject_read(struct xtmr_inject_dev *xtmr_inject,
+				   u32 addr)
+{
+	return ioread32(xtmr_inject->regs + addr);
+}
+
+static ssize_t inject_err_store(struct device *dev,
+				struct device_attribute *attr, const char *buf,
+				size_t size)
+{
+	int ret;
+	long value;
+
+	ret = kstrtoul(buf, 16, &value);
+	if (ret)
+		return ret;
+
+	if (value > 1)
+		return -EINVAL;
+
+	xmb_inject_err();
+
+	return size;
+}
+static DEVICE_ATTR_WO(inject_err);
+
+static ssize_t inject_cpuid_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t size)
+{
+	struct xtmr_inject_dev *xtmr_inject = dev_get_drvdata(dev);
+	int ret;
+	long value;
+
+	ret = kstrtoul(buf, 0, &value);
+	if (ret)
+		return ret;
+
+	if (value > 3)
+		return -EINVAL;
+
+	xtmr_inject->cr_val |= (value << XTMR_INJECT_CR_CPUID_SHIFT);
+	xtmr_inject_write(xtmr_inject, XTMR_INJECT_CR_OFFSET,
+			  xtmr_inject->cr_val);
+
+	return size;
+}
+static DEVICE_ATTR_WO(inject_cpuid);
+
+static struct attribute *xtmr_inject_dev_attrs[] = {
+	&dev_attr_inject_err.attr,
+	&dev_attr_inject_cpuid.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(xtmr_inject_dev);
+
+static void xtmr_inject_init(struct xtmr_inject_dev *xtmr_inject)
+{
+	/* Allow fault injection */
+	xtmr_inject->cr_val = xtmr_inject->magic |
+				(1 << XTMR_INJECT_CR_IE_SHIFT) |
+				(1 << XTMR_INJECT_CR_CPUID_SHIFT);
+	xtmr_inject_write(xtmr_inject, XTMR_INJECT_CR_OFFSET,
+			  xtmr_inject->cr_val);
+	/* Initialize the address inject and instruction inject registers */
+	xtmr_inject_write(xtmr_inject, XTMR_INJECT_AIR_OFFSET,
+			  XMB_INJECT_ERR_OFFSET);
+	xtmr_inject_write(xtmr_inject, XTMR_INJECT_IIR_OFFSET,
+			  XMB_INJECT_ERR_OFFSET & XTMR_INJECT_IIR_ADDR_MASK);
+}
+
+/**
+ * xtmr_inject_probe - Driver probe function
+ * @pdev: Pointer to the platform_device structure
+ *
+ * This is the driver probe routine. It does all the memory
+ * allocation and creates sysfs entries for the device.
+ *
+ * Return: 0 on success and failure value on error
+ */
+static int xtmr_inject_probe(struct platform_device *pdev)
+{
+	struct xtmr_inject_dev *xtmr_inject;
+	int err;
+
+	xtmr_inject = devm_kzalloc(&pdev->dev, sizeof(*xtmr_inject),
+				   GFP_KERNEL);
+	if (!xtmr_inject)
+		return -ENOMEM;
+
+	xtmr_inject->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(xtmr_inject->regs))
+		return PTR_ERR(xtmr_inject->regs);
+
+	err = of_property_read_u32(pdev->dev.of_node, "xlnx,magic",
+				   &xtmr_inject->magic);
+	if (err < 0) {
+		dev_err(&pdev->dev, "unable to read xlnx,magic property");
+		return err;
+	}
+
+	if (xtmr_inject->magic > XTMR_INJECT_MAGIC_MAX_VAL) {
+		dev_err(&pdev->dev, "invalid xlnx,magic property value");
+		return -EINVAL;
+	}
+
+	/* Initialize TMR Inject */
+	xtmr_inject_init(xtmr_inject);
+
+	platform_set_drvdata(pdev, xtmr_inject);
+
+	return 0;
+}
+
+static const struct of_device_id xtmr_inject_of_match[] = {
+	{
+		.compatible = "xlnx,tmr-inject-1.0",
+	},
+	{ /* end of table */ }
+};
+MODULE_DEVICE_TABLE(of, xtmr_inject_of_match);
+
+static struct platform_driver xtmr_inject_driver = {
+	.driver = {
+		.name = "xilinx-tmr_inject",
+		.of_match_table = xtmr_inject_of_match,
+		.dev_groups = xtmr_inject_dev_groups,
+	},
+	.probe = xtmr_inject_probe,
+};
+module_platform_driver(xtmr_inject_driver);
+MODULE_AUTHOR("Xilinx, Inc");
+MODULE_DESCRIPTION("Xilinx TMR Inject Driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1

