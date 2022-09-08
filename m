Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1DA5B13B2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 06:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbiIHEZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 00:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiIHEZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 00:25:34 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A846A47B94;
        Wed,  7 Sep 2022 21:25:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eShFNDJ48+pSoa2okmwafjZ5qKcu7NK1mS6mdl40sGx0vlnCU8eqJAZSsq7pudhy8nRW24lf4eoJMoOCWBTWuhjeugokOj/Qw2odNWK3zx7oaD1mZyc+NiOZlJvl8ByqKkA6bbRsxX9wymfx5jw+m/Yrqbwy4ea/vAqviloQmrmFkvCwiani5eAo7/Bq9c2v+cPwTmNLJ3SyDz+er1OGElquavREtfqzJqfsT8KIGJc++DEWhM6AP4BBkV6qFtEsgzGSkpv0uSNONZ2Z50X89hpXZQVuRNJMknc1tOq5jBk713ii5cUIy5TtsrBUuUDZNcwtOd8OMBfB2HUQuju68Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=koIgmqL31vXL9SrVoyp8TH578ccyX4B69TSOV7c31Tg=;
 b=dmPORkJQQ/z8t9T9wxGrjEBO/dLKgXHoG+5NX/c3nSS4vtvJrCmDL2k97NMsZLmJOFmWXjricYXVMRPBMTgdITNId1qHMmScdd17gfCFf3E7ITTnWGAU2xaqDCGoPWTQn0x8PZ2NsB5YPUnMo7X5q+0OsEP02Cbn1JlQdU2AXoSPJHaoFYoyZU9g81nrFJ78yUKyGXFSlL2WmNcO66BzTWkQDyC0rpeJDrUw+XlUKOM8+NQkze1mg+rcEzbbXEbokaabHO03ABxQTBSRsGr4CnwTfRSa/WLwYbniTrt2bxR6ogJxGIYNX0ft/2j2lbSh20qfpgqSttQT1J9Vu64iew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=koIgmqL31vXL9SrVoyp8TH578ccyX4B69TSOV7c31Tg=;
 b=xRTN6MgWvj/dl2r3VHtwT9CjOwhjhJoS8DpXSdfzze5lXh9Pr6Z3nWaR/acIbf1OG3rrsb/f+LVWkZy068Nz+vhXT+bcnYplNsDWMfRH/3+NYqCqoYPRSHBPrbCA4XBexV1L8CAPnZo7MVMxjl/MkudQ8p3NlPHWlD6HPO3mlmA=
Received: from DS7PR03CA0269.namprd03.prod.outlook.com (2603:10b6:5:3b3::34)
 by MW4PR12MB7357.namprd12.prod.outlook.com (2603:10b6:303:219::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Thu, 8 Sep
 2022 04:25:07 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::5f) by DS7PR03CA0269.outlook.office365.com
 (2603:10b6:5:3b3::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Thu, 8 Sep 2022 04:25:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Thu, 8 Sep 2022 04:25:06 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 23:25:03 -0500
From:   Appana Durga Kedareswara rao 
        <appana.durga.kedareswara.rao@amd.com>
To:     <appanad@amd.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <michal.simek@xilinx.com>,
        <derek.kiernan@xilinx.com>, <dragan.cvetic@xilinx.com>,
        <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <git@amd.com>
Subject: [PATCH v3 4/4] drivers: misc: Add Support for TMR Inject IP
Date:   Thu, 8 Sep 2022 09:54:44 +0530
Message-ID: <20220908042444.2866731-5-appana.durga.kedareswara.rao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220908042444.2866731-1-appana.durga.kedareswara.rao@amd.com>
References: <20220908042444.2866731-1-appana.durga.kedareswara.rao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT049:EE_|MW4PR12MB7357:EE_
X-MS-Office365-Filtering-Correlation-Id: e4f74c60-7c7f-451b-98d7-08da91521bd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4aC/upV3EHc6Ch1T9isuEpiXRq1JaS/FHcDX03oaOHhYtWq16YbNRNlvTDcRbuwDCUFj0Yv4dq9XulyTBPeZUJvY2I2PlqZOQ0PaptOXWcFOZFKOuPZC3JHWcNJm6TidVd0JjcUlAOABF9og4PN0wbLVanvgP6AWbIbl+wGUMJ6c39UJg7F/GmMnYoaO6UY7grHzV7WnXKv5grApovfW8/1izPt0KoHEb4S10K9vJoiaJVyYv8KcYatCk4DEx6ycJa5lnNOvV4Rg72Adeh2CP68mXWsaXxgkUAs969x2WsvuLfHGGMzSNY3uV+LSlB7yoxNDDAEwY1yKTlX1PHCeql/NIgxzTaoZpB1Ro6IVj5WudIj169jqOTpcpbcOEv6Z7mCjR2FPlCiZESS1T1PqNCPlKDVXrN0uMLhOAWxCKZejBW7rQq05pWOqgFvwvldrB2z+h4V/DPzXHuFoZoVpZirtcFwpunpaUNZzACNPyX1nsXY8xq3jOxjAbfRkH8BoHRyjBUof5rPA4KSA9r0urr5B4t/TuUw3rAkUF+Vwz9sQB/cJHqCZuSq55PPJJSJOJgHulDlVS4jHblAijF92P/x9WHCPRlYkBms/mCIGPaVNePLhoUgSjXb28RMSWmXxGCKZo4/Lls/6slgmADUxqJsb4Zv7wwDypWaouCHkIUPj0OKx51ubf8xSRTImtlgbMC8ZzVtguAMewXpV4s0qXYJo9LUdkxudNdsHF/W3J+HwEgw4q9vE+4akcfPb44nJ6qeA9BwVO59mJpq53rt7NGfoImVLgbqO53/OXqq8NvHd3FVP1vQywGUr79gZ5WjO
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(136003)(39860400002)(376002)(46966006)(36840700001)(40470700004)(54906003)(316002)(110136005)(36860700001)(36756003)(70206006)(5660300002)(103116003)(8936002)(2906002)(8676002)(4326008)(70586007)(41300700001)(82310400005)(86362001)(6666004)(478600001)(83380400001)(336012)(186003)(1076003)(40480700001)(47076005)(2616005)(16526019)(426003)(81166007)(921005)(40460700003)(356005)(26005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 04:25:06.5647
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4f74c60-7c7f-451b-98d7-08da91521bd6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7357
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Triple Modular Redundancy(TMR) provides functional fault injection by
changing selected MicroBlaze instructions, which provides the possibility
to verify that the TMR subsystem error detection and fault recovery logic
is working properly, provided sysfs entries which allow the user to inject
a fault.

Usage:
echo 1 > /sys/kernel/debug/xtmr_inject/inject_fault/inject_fault

Signed-off-by: Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>
---
Changes for v3:
--> Updated the driver to use fault-injection api as suggested by Greg.
--> Updated the Kconfig to compile the driver as a module.
Changes for v2:
--> Fixed Month in the sysfs description.
--> Fixed line over 80 char in driver.
--> Replaced kstrtol with kstrtoul as suggested by Michal.
--> Added error check for xlnx,magic value.

 MAINTAINERS                      |   6 +
 drivers/misc/Kconfig             |  10 ++
 drivers/misc/Makefile            |   1 +
 drivers/misc/xilinx_tmr_inject.c | 181 +++++++++++++++++++++++++++++++
 4 files changed, 198 insertions(+)
 create mode 100644 drivers/misc/xilinx_tmr_inject.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5fc5ec13985e..1207effa8e15 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13284,6 +13284,12 @@ F:	Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager
 F:	Documentation/devicetree/bindings/misc/xlnx,tmr-manager.yaml
 F:	drivers/misc/xilinx_tmr_manager.c
 
+MICROBLAZE TMR INJECT
+M:	Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/misc/xlnx,tmr-inject.yaml
+F:	drivers/misc/xilinx_tmr_inject.c
+
 MICROCHIP AT91 DMA DRIVERS
 M:	Ludovic Desroches <ludovic.desroches@microchip.com>
 M:	Tudor Ambarus <tudor.ambarus@microchip.com>
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 1508cc29b05a..7b1930a7f18a 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -506,6 +506,16 @@ config TMR_MANAGER
 
 	  Say N here unless you know what you are doing.
 
+config TMR_INJECT
+	tristate "Select TMR Inject"
+	depends on TMR_MANAGER && FAULT_INJECTION
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
index 4918f6632531..fff8606d505c 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -62,3 +62,4 @@ obj-$(CONFIG_HI6421V600_IRQ)	+= hi6421v600-irq.o
 obj-$(CONFIG_OPEN_DICE)		+= open-dice.o
 obj-$(CONFIG_VCPU_STALL_DETECTOR)	+= vcpu_stall_detector.o
 obj-$(CONFIG_TMR_MANAGER)      += xilinx_tmr_manager.o
+obj-$(CONFIG_TMR_INJECT)	+= xilinx_tmr_inject.o
diff --git a/drivers/misc/xilinx_tmr_inject.c b/drivers/misc/xilinx_tmr_inject.c
new file mode 100644
index 000000000000..592e1861c1bd
--- /dev/null
+++ b/drivers/misc/xilinx_tmr_inject.c
@@ -0,0 +1,181 @@
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
+#include <linux/fault-inject.h>
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
+ * @magic: Magic hardware configuration value
+ */
+struct xtmr_inject_dev {
+	void __iomem *regs;
+	u32 magic;
+};
+
+static DECLARE_FAULT_ATTR(inject_fault);
+static char *inject_request;
+module_param(inject_request, charp, 0);
+MODULE_PARM_DESC(inject_request, "default fault injection attributes");
+#ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
+static struct dentry *dbgfs_root;
+#endif
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
+#ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
+static int xtmr_inject_set(void *data, u64 val)
+{
+	if (val != 1)
+		return -EINVAL;
+
+	xmb_inject_err();
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(xtmr_inject_fops, NULL, xtmr_inject_set, "%llu\n");
+
+void xtmr_init_debugfs(struct xtmr_inject_dev *xtmr_inject)
+{
+	struct dentry *dir;
+
+	dbgfs_root = debugfs_create_dir("xtmr_inject", NULL);
+	dir = fault_create_debugfs_attr("inject_fault", dbgfs_root,
+					&inject_fault);
+	debugfs_create_file("inject_fault", 0200, dir, NULL,
+			    &xtmr_inject_fops);
+}
+#endif
+
+static void xtmr_inject_init(struct xtmr_inject_dev *xtmr_inject)
+{
+	u32 cr_val;
+
+	if (inject_request)
+		setup_fault_attr(&inject_fault, inject_request);
+	/* Allow fault injection */
+	cr_val = xtmr_inject->magic |
+		 (1 << XTMR_INJECT_CR_IE_SHIFT) |
+		 (1 << XTMR_INJECT_CR_CPUID_SHIFT);
+	xtmr_inject_write(xtmr_inject, XTMR_INJECT_CR_OFFSET,
+			  cr_val);
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
+#ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
+	xtmr_init_debugfs(xtmr_inject);
+#endif
+
+	platform_set_drvdata(pdev, xtmr_inject);
+
+	return 0;
+}
+
+static int xtmr_inject_remove(struct platform_device *pdev)
+{
+#ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
+	debugfs_remove_recursive(dbgfs_root);
+	dbgfs_root = NULL;
+#endif
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
+	},
+	.probe = xtmr_inject_probe,
+	.remove = xtmr_inject_remove,
+};
+module_platform_driver(xtmr_inject_driver);
+MODULE_AUTHOR("Xilinx, Inc");
+MODULE_DESCRIPTION("Xilinx TMR Inject Driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1

