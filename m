Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0B457B0AC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 08:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238213AbiGTGA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 02:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238232AbiGTGAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 02:00:51 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CAE5C368;
        Tue, 19 Jul 2022 23:00:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ct0RNw//hAPrHuiKnS4Afr/xSFxhHKOUrYm6flHwXrU3qO/c0Uee5rlV8V3pUSW7U4DbfPaWVMr0emHTjXDHA27HXig08pNN0BsJ4k1NG5oIDhdek8g8bAbhAZSAG27GjKhpXWaMg1GiDwR8QqTk7OL7KNEZyUrRjwXhLm4r8COsp8g9a3jjCv35gE0Cu4O6OL0bUqzyq9yjVd0fxqfY+Whe3fgbkmHQ7sBMQbg5PFomVens/OjVIonBavh27jYSQtx2ap8HdedMyKuW0n46GxN61/uEO8I7TOn4/SlnnGpigS1YxxQltWqkgDA9xlr1kCUfZOLfqWsjvdF30lqfpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JfSxSGajdliAQGX/+wjaeqXKno2qoe5UqjtYi8Kii40=;
 b=krUIVB/kBOtQK4oAQDNOhWL2pdF3b1D0xV0W2ese/TfAMRApU6ZVKmm8d0MR/2PjxzyQ8nFnJcn2nCiG3V259eL6KBljXm0DYRZs/ZO+P5OMSPzqhs+0fD2M2yj1QRamrr7fuCyvTVJ8OH66/IDWYDuhQi51AimDsoQBiaI+nTj7ZzbtKapTPpJ55uNiZHbKAYkCsjTqfjH5ogjL1kmKTQ1jD8phlrYtA1lCyXVN2NBsjIVhicJm135XZK19FMON+wBJNYEWI5wDwRoQ4L1l+TprrQoEImOdEf5E2gM+kY4K3Fjk9gfjpmtVpa1A0j6UFHSzlcGlw8spYGto60Pnrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfSxSGajdliAQGX/+wjaeqXKno2qoe5UqjtYi8Kii40=;
 b=fG0cQaNq9IZGkfAjGGpAjOT7vsCKOwJkY9DndQOIxuYTElI2gmDgZ1y7gpVZPpVwxpxaDAwtSf5ICMCMM1we7fQfv5dEHaz5d6VvV5NuuR8+xQin6oHWU+91/HIJJxEhdrxSNNov9GKng6nsYmhQDiJJY+ul0or5J83TYUeuCXI=
Received: from BN9PR03CA0650.namprd03.prod.outlook.com (2603:10b6:408:13b::25)
 by BN7PR12MB2595.namprd12.prod.outlook.com (2603:10b6:408:30::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.15; Wed, 20 Jul
 2022 06:00:44 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::52) by BN9PR03CA0650.outlook.office365.com
 (2603:10b6:408:13b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21 via Frontend
 Transport; Wed, 20 Jul 2022 06:00:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Wed, 20 Jul 2022 06:00:43 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 20 Jul
 2022 01:00:27 -0500
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
Subject: [PATCH v2 2/4] drivers: misc: Add Support for TMR Manager
Date:   Wed, 20 Jul 2022 11:30:14 +0530
Message-ID: <20220720060016.1646317-3-appana.durga.kedareswara.rao@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1986e1e9-793f-4b35-45a1-08da6a152ed5
X-MS-TrafficTypeDiagnostic: BN7PR12MB2595:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jGuiPlKIQg+kTkooQmHVywKm3TNDq1UKG7w6xA8Nr4zMW051daKGLg6nBK8NjRzZCjd42fsnmcskPOZN79cVYgGSJMqTr+qP66YDf9aP+DozBNAZ11C/qJ/sjwR1FYC8Qjrcv4tmZpXD7XRC1sztATZ7QkBWvbtO2kMFEjl/wC3bhohzVLrsZGNJBr4vsoOPEFuaorFwAp0qJb8bbEJHF81hUceb9MKor75NuUWx1bLC6XWWYRRrJZm4KyAgZpmGpU4l9CfObRpaujTxHFZKlBtD4tVIMoUW8dR1wO4OZTvBSzW9ps1BcReWEYnDUZ8UbNrv8AziTe/UpDccIBfYBZToHCmwXzSblLwOPGE+fbB9gPi8FvqGKV1wJLfKA2OHT0fct8VEQCTLo9E7e9uOSWsYqRYXn+7hlHiJ20+T0L7F6o7d0EwAh1VMuB+Ca89JuFQM14liJPisFzzNihJXpV0RbpH5rAeFBWkNrgwT0DAB51wgOa+kTQDTgz0tUy7G4FOzsXqey8yWhWuLFvDfFMdrvNajvbShTQ1VcFlsZloCEVJgt0IDk1JEla6gCeKslgrx/ltLVjYE8aYQ83n4pOSgIHgfm03QGj8zw/sZRl2dCMe1Aj9hozHJ7jpiye1dNeXToUv5IXFsQIHOVXlkzi/SwMThOAjU3ypLym2kU6C3zndzaHT1f+WMC96QfHh5KhEasHJkkFV2qK61DU6hC9U/EM46BFYQyUIax8WAEo2iyY4gyAwapJJt2//8gpPW+B/NnfNT8zZ5blA059TTPQw1fL1O3jCT2AHB9mZZVDiW6wL5WK7GgdUwcV9fZ9khUvkmaXYhkUz3rYj5HfT87yjZvWm3QtGESFOUJdyywfUqmOcWhll3dOD2VHV6b2Ty
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(136003)(396003)(39860400002)(40470700004)(36840700001)(46966006)(47076005)(426003)(356005)(86362001)(16526019)(81166007)(82310400005)(1076003)(82740400003)(8936002)(2906002)(2616005)(5660300002)(26005)(36756003)(103116003)(336012)(83380400001)(186003)(966005)(70206006)(8676002)(40480700001)(4326008)(30864003)(478600001)(41300700001)(70586007)(36860700001)(40460700003)(54906003)(107886003)(316002)(110136005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 06:00:43.8151
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1986e1e9-793f-4b35-45a1-08da6a152ed5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2595
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

Triple Modular Redundancy(TMR) subsystem contains three microblaze cores,
subsystem is fault-tolerant and continues to operate nominally after
encountering an error. Together with the capability to detect and recover
from errors, the implementation ensures the reliability of the entire
subsystem.  TMR Manager is responsible for performing recovery of the
subsystem detects the fault via a break signal it invokes microblaze
software break handler which calls the tmr manager driver api to
update the error count and status, added support for fault detection
feature via sysfs interface.

Usage:
To know the hardware status:
cat /sys/devices/platform/amba_pl/44a10000.tmr_manager/status
To know the break handler count(Error count):
cat /sys/devices/platform/amba_pl/44a10000.tmr_manager/errcnt

Signed-off-by: Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>
Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
---
Changes for v2:
--> Added Examples for sysfs entries
--> Removed uneeded struct dev from the driver private structure
--> Fixed style issues (Used resource_size_t instead of uintptr_t)
--> Updated driver to use sysfs_emit() API instead of sprintf() API
--> Added error checks wherever applicable.
--> Fixed sysfs registration.
 .../testing/sysfs-driver-xilinx-tmr-manager   |  27 ++
 MAINTAINERS                                   |   7 +
 drivers/misc/Kconfig                          |  10 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/xilinx_tmr_manager.c             | 253 ++++++++++++++++++
 5 files changed, 298 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager
 create mode 100644 drivers/misc/xilinx_tmr_manager.c

diff --git a/Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager b/Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager
new file mode 100644
index 000000000000..fc5fe7e22b09
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager
@@ -0,0 +1,27 @@
+What:		/sys/devices/platform/amba_pl/<dev>/status
+Date:		June 2022
+Contact:	appana.durga.rao@xilinx.com
+Description:	This control file provides the status of the tmr manager
+		useful for getting the status of fault.
+		This file cannot be written.
+		Example:
+		# cat /sys/devices/platform/amba_pl/44a10000.tmr_manager/status
+		  Lockstep mismatch between processor 1 and 2
+		  Lockstep mismatch between processor 2 and 3
+
+What:		/sys/devices/platform/amba_pl/<dev>/errcnt
+Date:		June 2022
+Contact:	appana.durga.rao@xilinx.com
+Description:	This control file provides the fault detection count.
+		This file cannot be written.
+		Example:
+		# cat /sys/devices/platform/amba_pl/44a10000.tmr_manager/errcnt
+		  1
+
+What:		/sys/devices/platform/amba_pl/<dev>/dis_block_break
+Date:		June 2022
+Contact:	appana.durga.rao@xilinx.com
+Description:	This control file enables the break signal.
+		This file is write only.
+		Example:
+		# echo 1 > /sys/devices/platform/amba_pl/44a10000.tmr_manager/dis_block_break
diff --git a/MAINTAINERS b/MAINTAINERS
index 651616ed8ae2..732fd9ae7d9f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13080,6 +13080,13 @@ W:	http://www.monstr.eu/fdt/
 T:	git git://git.monstr.eu/linux-2.6-microblaze.git
 F:	arch/microblaze/
 
+MICROBLAZE TMR MANAGER
+M:	Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>
+S:	Supported
+F:	Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager
+F:	Documentation/devicetree/bindings/misc/xlnx,tmr-manager.yaml
+F:	drivers/misc/xilinx_tmr_manager.c
+
 MICROCHIP AT91 DMA DRIVERS
 M:	Ludovic Desroches <ludovic.desroches@microchip.com>
 M:	Tudor Ambarus <tudor.ambarus@microchip.com>
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 41d2bb0ae23a..555ae2e33b91 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -483,6 +483,16 @@ config OPEN_DICE
 
 	  If unsure, say N.
 
+config TMR_MANAGER
+	bool "Select TMR Manager"
+	depends on MICROBLAZE && MB_MANAGER
+	help
+	  This option enables the driver developed for TMR Manager. The Triple
+	  Modular Redundancy(TMR) manager provides support for fault detection
+	  via sysfs interface.
+
+	  Say N here unless you know what you are doing.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 70e800e9127f..28b9803f909b 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -60,3 +60,4 @@ obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
 obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
 obj-$(CONFIG_HI6421V600_IRQ)	+= hi6421v600-irq.o
 obj-$(CONFIG_OPEN_DICE)		+= open-dice.o
+obj-$(CONFIG_TMR_MANAGER)	+= xilinx_tmr_manager.o
diff --git a/drivers/misc/xilinx_tmr_manager.c b/drivers/misc/xilinx_tmr_manager.c
new file mode 100644
index 000000000000..dbeca18c409f
--- /dev/null
+++ b/drivers/misc/xilinx_tmr_manager.c
@@ -0,0 +1,253 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx TMR Subsystem.
+ *
+ * Copyright (C) 2022 Xilinx, Inc.
+ *
+ * Description:
+ * This driver is developed for TMR Manager,The Triple Modular Redundancy(TMR)
+ * Manager is responsible for handling the TMR subsystem state, including
+ * fault detection and error recovery. The core is triplicated in each of
+ * the sub-blocks in the TMR subsystem, and provides majority voting of
+ * its internal state provides soft error detection, correction and
+ * recovery. Error detection feature is provided through sysfs
+ * entries which allow the user to observer the TMR microblaze
+ * status.
+ */
+
+#include <asm/xilinx_mb_manager.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+
+/* TMR Manager Register offsets */
+#define XTMR_MANAGER_CR_OFFSET		0x0
+#define XTMR_MANAGER_FFR_OFFSET		0x4
+#define XTMR_MANAGER_CMR0_OFFSET	0x8
+#define XTMR_MANAGER_CMR1_OFFSET	0xC
+#define XTMR_MANAGER_BDIR_OFFSET	0x10
+#define XTMR_MANAGER_SEMIMR_OFFSET	0x1C
+
+/* Register Bitmasks/shifts */
+#define XTMR_MANAGER_CR_MAGIC1_MASK	GENMASK(7, 0)
+#define XTMR_MANAGER_CR_MAGIC2_MASK	GENMASK(15, 8)
+#define XTMR_MANAGER_CR_RIR_MASK	BIT(16)
+#define XTMR_MANAGER_FFR_LM12_MASK	BIT(0)
+#define XTMR_MANAGER_FFR_LM13_MASK	BIT(1)
+#define XTMR_MANAGER_FFR_LM23_MASK	BIT(2)
+
+#define XTMR_MANAGER_CR_MAGIC2_SHIFT	4
+#define XTMR_MANAGER_CR_RIR_SHIFT	16
+#define XTMR_MANAGER_CR_BB_SHIFT	18
+
+#define XTMR_MANAGER_MAGIC1_MAX_VAL	255
+
+/**
+ * struct xtmr_manager_dev - Driver data for TMR Manager
+ * @regs: device physical base address
+ * @cr_val: control register value
+ * @magic1: Magic 1 hardware configuration value
+ * @err_cnt: error statistics count
+ * @phys_baseaddr: Physical base address
+ */
+struct xtmr_manager_dev {
+	void __iomem *regs;
+	u32 cr_val;
+	u32 magic1;
+	u32 err_cnt;
+	resource_size_t phys_baseaddr;
+};
+
+/* IO accessors */
+static inline void xtmr_manager_write(struct xtmr_manager_dev *xtmr_manager,
+				      u32 addr, u32 value)
+{
+	iowrite32(value, xtmr_manager->regs + addr);
+}
+
+static inline u32 xtmr_manager_read(struct xtmr_manager_dev *xtmr_manager,
+				    u32 addr)
+{
+	return ioread32(xtmr_manager->regs + addr);
+}
+
+static void xmb_manager_reset_handler(struct xtmr_manager_dev *xtmr_manager)
+{
+	/* Clear the FFR Register contents as a part of recovery process. */
+	xtmr_manager_write(xtmr_manager, XTMR_MANAGER_FFR_OFFSET, 0);
+}
+
+static void xmb_manager_update_errcnt(struct xtmr_manager_dev *xtmr_manager)
+{
+	xtmr_manager->err_cnt++;
+}
+
+static ssize_t errcnt_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	struct xtmr_manager_dev *xtmr_manager = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%x\n", xtmr_manager->err_cnt);
+}
+static DEVICE_ATTR_RO(errcnt);
+
+static ssize_t status_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	struct xtmr_manager_dev *xtmr_manager = dev_get_drvdata(dev);
+	size_t ffr;
+	int len = 0;
+
+	ffr = xtmr_manager_read(xtmr_manager, XTMR_MANAGER_FFR_OFFSET);
+	if ((ffr & XTMR_MANAGER_FFR_LM12_MASK) == XTMR_MANAGER_FFR_LM12_MASK) {
+		len += sysfs_emit_at(buf, len, "Lockstep mismatch between ");
+		len += sysfs_emit_at(buf, len, "processor 1 and 2\n");
+	}
+
+	if ((ffr & XTMR_MANAGER_FFR_LM13_MASK) == XTMR_MANAGER_FFR_LM13_MASK) {
+		len += sysfs_emit_at(buf, len, "Lockstep mismatch between ");
+		len += sysfs_emit_at(buf, len, "processor 1 and 3\n");
+	}
+
+	if ((ffr & XTMR_MANAGER_FFR_LM23_MASK) == XTMR_MANAGER_FFR_LM23_MASK) {
+		len += sysfs_emit_at(buf, len, "Lockstep mismatch between ");
+		len += sysfs_emit_at(buf, len, "processor 2 and 3\n");
+	}
+
+	return len;
+}
+static DEVICE_ATTR_RO(status);
+
+static ssize_t dis_block_break_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t size)
+{
+	struct xtmr_manager_dev *xtmr_manager = dev_get_drvdata(dev);
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
+	/* unblock the break signal*/
+	xtmr_manager->cr_val &= ~(1 << XTMR_MANAGER_CR_BB_SHIFT);
+	xtmr_manager_write(xtmr_manager, XTMR_MANAGER_CR_OFFSET,
+			   xtmr_manager->cr_val);
+	return size;
+}
+static DEVICE_ATTR_WO(dis_block_break);
+
+static struct attribute *xtmr_manager_dev_attrs[] = {
+	&dev_attr_dis_block_break.attr,
+	&dev_attr_status.attr,
+	&dev_attr_errcnt.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(xtmr_manager_dev);
+
+static void xtmr_manager_init(struct xtmr_manager_dev *xtmr_manager)
+{
+	/* Clear the SEM interrupt mask register to disable the interrupt */
+	xtmr_manager_write(xtmr_manager, XTMR_MANAGER_SEMIMR_OFFSET, 0);
+
+	/* Allow recovery reset by default */
+	xtmr_manager->cr_val = (1 << XTMR_MANAGER_CR_RIR_SHIFT) |
+				xtmr_manager->magic1;
+	xtmr_manager_write(xtmr_manager, XTMR_MANAGER_CR_OFFSET,
+			   xtmr_manager->cr_val);
+	/*
+	 * Configure Break Delay Initialization Register to zero so that
+	 * break occurs immediately
+	 */
+	xtmr_manager_write(xtmr_manager, XTMR_MANAGER_BDIR_OFFSET, 0);
+
+	/*
+	 * To come out of break handler need to block the break signal
+	 * in the tmr manager, update the xtmr_manager cr_val for the same
+	 */
+	xtmr_manager->cr_val |= (1 << XTMR_MANAGER_CR_BB_SHIFT);
+
+	/*
+	 * When the break vector gets asserted because of error injection,
+	 * the break signal must be blocked before exiting from the
+	 * break handler, Below api updates the TMR manager address and
+	 * control register and error counter callback arguments,
+	 * which will be used by the break handler to block the
+	 * break and call the callback function.
+	 */
+	xmb_manager_register(xtmr_manager->phys_baseaddr, xtmr_manager->cr_val,
+			     (void *)xmb_manager_update_errcnt,
+			     xtmr_manager, (void *)xmb_manager_reset_handler);
+}
+
+/**
+ * xtmr_manager_probe - Driver probe function
+ * @pdev: Pointer to the platform_device structure
+ *
+ * This is the driver probe routine. It does all the memory
+ * allocation and creates sysfs entries for the device.
+ *
+ * Return: 0 on success and failure value on error
+ */
+static int xtmr_manager_probe(struct platform_device *pdev)
+{
+	struct xtmr_manager_dev *xtmr_manager;
+	struct resource *res;
+	int err;
+
+	xtmr_manager = devm_kzalloc(&pdev->dev, sizeof(*xtmr_manager),
+				    GFP_KERNEL);
+	if (!xtmr_manager)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	xtmr_manager->regs =  devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(xtmr_manager->regs))
+		return PTR_ERR(xtmr_manager->regs);
+
+	xtmr_manager->phys_baseaddr = res->start;
+
+	err = of_property_read_u32(pdev->dev.of_node, "xlnx,magic1",
+				   &xtmr_manager->magic1);
+	if (err < 0) {
+		dev_err(&pdev->dev, "unable to read xlnx,magic1 property");
+		return err;
+	}
+
+	if (xtmr_manager->magic1 > XTMR_MANAGER_MAGIC1_MAX_VAL) {
+		dev_err(&pdev->dev, "invalid xlnx,magic1 property value");
+		return -EINVAL;
+	}
+
+	/* Initialize TMR Manager */
+	xtmr_manager_init(xtmr_manager);
+
+	platform_set_drvdata(pdev, xtmr_manager);
+
+	return 0;
+}
+
+static const struct of_device_id xtmr_manager_of_match[] = {
+	{
+		.compatible = "xlnx,tmr-manager-1.0",
+	},
+	{ /* end of table */ }
+};
+MODULE_DEVICE_TABLE(of, xtmr_manager_of_match);
+
+static struct platform_driver xtmr_manager_driver = {
+	.driver = {
+		.name = "xilinx-tmr_manager",
+		.of_match_table = xtmr_manager_of_match,
+		.dev_groups = xtmr_manager_dev_groups,
+	},
+	.probe = xtmr_manager_probe,
+};
+module_platform_driver(xtmr_manager_driver);
+
+MODULE_AUTHOR("Xilinx, Inc");
+MODULE_DESCRIPTION("Xilinx TMR Manager Driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1

