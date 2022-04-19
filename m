Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65855507B72
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 22:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357854AbiDSU7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 16:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357849AbiDSU67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:58:59 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979DE41608;
        Tue, 19 Apr 2022 13:56:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/ePUu+W5/ldI071p2dbSZHYY7CYtjKcnrjB/alP+OQRKvFalZUmnBYjhjPTj9Rb80ypbVen/PoyHAezvqs3HSDVYxk0QrR+mzsPsLIAMhYr35UKyUzo59hYfYYXr1u/LO+nVzT0r/0yEecmciPfqWpQgelcVym58LsQ2Ux92MaCLoD5sZVMaRRuaDrp0kXp8kS6qfUWrKjUU4aywTrB6fyo1+20RP+LWTZ7e+EPYs4sufZydJgQcsgdZn0GyBvAHM4lo5ZK5ON8nfdHDuxwm2c0gmOOgklKGx2fn/oTMLyJQiltTSor5oXPMO/AiO1PPmCubqFYLv5dSz86Y+GFWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PjCMmxNUDb17fLLmWNtUH74HFvAfFrSNLKzdFJr8fA=;
 b=apYbXbP/5LGaQcM+egopR8T9lEk42CuVTQKujKhIImpM3S6LKMsnjkM2G1yy0BMjA65SOP4K8cf4elOH4RRfdO106F4pokHOvbvZh7bWR5GtgJEncc5sBmn03rSAD/d409A8fUcI1+GswUoDtMS4o97eMatbbNd+szu2C3O2NMu2nAZGAUuwT5JnaM7OWdqBWE/f9T4A/spBwSORpRZpd9+0bqTxIfjCP1i7KEAc0d1Vz+b2Dz+qNz7m9Nvkbp+fYMWExFt/U8Rrj6WIb8rvoIAuF8Jpl1cYUGHw63WftI2NcoB5YvpsYp1UuzoUmLuKfbAG3IfRygJS95m6WZ/VDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PjCMmxNUDb17fLLmWNtUH74HFvAfFrSNLKzdFJr8fA=;
 b=KVMycS4f8gk0R6AzE2qodJfKWlImX5tErVaIImM8TtIptHnEFiOFlf/vVddHUBtLfSMJKdmuoqR4V7vMHF1lqWVpkJe8C4Me34ovxHRGxr0U3fWdORgoD4E5rt/aL0WzTNTg/st+5eliwO5cZflORJ0kjEnJqy4sIotE3d/IY5r9dkpVtz45o8DAYuuyDcMCmjxxcC96OE5R+v91JZOFLjx7WYVOoKeMKkKlrClR17l0vfhi4GSFa7I0JlD/EhHwMpfJHSy5UurO8cHWiTdgysal0GaZA28TijXZxeOimCqatPTYfhNxr8Bew6Hf4LZTIka4BtCj5ePH2Sp1m6l6bA==
Received: from BN1PR12CA0024.namprd12.prod.outlook.com (2603:10b6:408:e1::29)
 by DM5PR12MB1226.namprd12.prod.outlook.com (2603:10b6:3:75::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5164.20; Tue, 19 Apr 2022 20:56:13 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::fd) by BN1PR12CA0024.outlook.office365.com
 (2603:10b6:408:e1::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20 via Frontend
 Transport; Tue, 19 Apr 2022 20:56:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5164.19 via Frontend Transport; Tue, 19 Apr 2022 20:56:13 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 19 Apr
 2022 20:56:02 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 19 Apr
 2022 13:56:01 -0700
Received: from msst-build.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Tue, 19 Apr 2022 13:56:00 -0700
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     <rafael@kernel.org>, <lenb@kernel.org>, <robert.moore@intel.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <guohanjun@huawei.com>,
        <sudeep.holla@arm.com>
CC:     <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <linux-acpi@vger.kernel.org>,
        <devel@acpica.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Besar Wicaksono" <bwicaksono@nvidia.com>
Subject: [PATCH 2/2] ACPI: ARM Performance Monitoring Unit Table (APMT) initial support
Date:   Tue, 19 Apr 2022 15:54:32 -0500
Message-ID: <20220419205432.46021-3-bwicaksono@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220419205432.46021-1-bwicaksono@nvidia.com>
References: <20220419205432.46021-1-bwicaksono@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21570fed-648c-4649-9d0a-08da22470a3d
X-MS-TrafficTypeDiagnostic: DM5PR12MB1226:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB122644D040CF0CBF4D6241FEA0F29@DM5PR12MB1226.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8lTYqV+GcY9AXuOzlIIGitnvU0bKF6qtxhAfaIIOlyzRbCqS2akXXZcITbnMi3bnalhl3sbH6PiuVEbD8pteNtYsJTgaGu75aFMZQTxSOLyoiySnE9uCuwIBMbmET+q6Z49oLQDFM0/zHxG/Gt5LaUjRn9qq6qTOKImk73kzree2Ovx+H1B3Mn41S4vrykR5/zGZpjPwXwKOdHjngFjYlVk7IAuFa0OvIkhPoKBbluNuawramFdiiQcHipXh8KeTkTNJ3kN8RYx4LKc4HB0DvDXOdiWwzBJQaJsdGM3Olz5ndLSNlVmd7mHU/rHq/65I8W1V2E3TWGBNkrA2H5z6NTRfiJKMdAuGFxoBLllFaVQ6kj+dZYRX2z6DAPL8WBqyuXR7ISIYsw1VM7wXEzkgCKzLkY7faX9mb8wYgh1WSLAznjBpL548f10bk5yaxk9xFrLke85+FfsJ3iFUPCBnk/2wMLHN6czfOI0ec/JZiff9gapR3kMb2OZGnNhwspEyFWRE16tLS8FUcvRB8Csayr1OYAEO2aeUJntHViE8MFgPdMqd8wNX9rS0W3gqZ4DbdP+zIT7bWrpzIKTWoHOcoaT22ce6k2Jw6EZ1DrdLhdtaOCg42L2kgrmE0/6gjVa+rlCfspx2pJwHp56I3bp7l0afFV0MPzufSQ84+CDyp9ClaNHjlxgvEHbpjU//L9Xls4ex+TP6tU8KcIfKdelthJcU3rtx2iKnz+ThP/miw0RS6eyo8qN0vfIZ5fjgl0w/i7uSqLNPNCbUk7IY5KQjF5WZIq8cuzLpSTaYyn42hjIx7jnx3osaQZezulN+dg/ezpQPOiZ3eBF2DwrGkgkp2w==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(110136005)(5660300002)(7416002)(356005)(508600001)(966005)(54906003)(2906002)(82310400005)(81166007)(70586007)(4326008)(8676002)(70206006)(40460700003)(83380400001)(1076003)(36860700001)(316002)(86362001)(8936002)(26005)(107886003)(186003)(36756003)(426003)(47076005)(6666004)(7696005)(336012)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2022 20:56:13.4460
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21570fed-648c-4649-9d0a-08da22470a3d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1226
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM Performance Monitoring Unit Table describes the properties of PMU
support in ARM-based system. The APMT table contains a list of nodes,
each represents a PMU in the system that conforms to ARM CoreSight PMU
architecture. The properties of each node include information required
to access the PMU (e.g. MMIO base address, interrupt number) and also
identification. For more detailed information, please refer to the
specification below:
 * APMT: https://developer.arm.com/documentation/den0117/latest
 * ARM Coresight PMU:
        https://developer.arm.com/documentation/ihi0091/latest

The initial support adds the detection of APMT table and generic
infrastructure to create platform devices for ARM CoreSight PMUs.
Similar to IORT the root pointer of APMT is preserved during runtime
and each PMU platform device is given a pointer to the corresponding
APMT node.

Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
---
 arch/arm64/Kconfig          |   1 +
 drivers/acpi/arm64/Kconfig  |   3 +
 drivers/acpi/arm64/Makefile |   1 +
 drivers/acpi/arm64/apmt.c   | 176 ++++++++++++++++++++++++++++++++++++
 drivers/acpi/bus.c          |   2 +
 include/linux/acpi_apmt.h   |  19 ++++
 6 files changed, 202 insertions(+)
 create mode 100644 drivers/acpi/arm64/apmt.c
 create mode 100644 include/linux/acpi_apmt.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e80fd2372f02..49e01c4377f2 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config ARM64
 	def_bool y
+	select ACPI_APMT if ACPI
 	select ACPI_CCA_REQUIRED if ACPI
 	select ACPI_GENERIC_GSI if ACPI
 	select ACPI_GTDT if ACPI
diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
index d4a72835f328..b3ed6212244c 100644
--- a/drivers/acpi/arm64/Kconfig
+++ b/drivers/acpi/arm64/Kconfig
@@ -18,3 +18,6 @@ config ACPI_AGDI
 	  reset command.
 
 	  If set, the kernel parses AGDI table and listens for the command.
+
+config ACPI_APMT
+	bool
diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
index 7b9e4045659d..e21a9e84e394 100644
--- a/drivers/acpi/arm64/Makefile
+++ b/drivers/acpi/arm64/Makefile
@@ -2,4 +2,5 @@
 obj-$(CONFIG_ACPI_AGDI) 	+= agdi.o
 obj-$(CONFIG_ACPI_IORT) 	+= iort.o
 obj-$(CONFIG_ACPI_GTDT) 	+= gtdt.o
+obj-$(CONFIG_ACPI_APMT) 	+= apmt.o
 obj-y				+= dma.o
diff --git a/drivers/acpi/arm64/apmt.c b/drivers/acpi/arm64/apmt.c
new file mode 100644
index 000000000000..8b8b9f480548
--- /dev/null
+++ b/drivers/acpi/arm64/apmt.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ARM APMT table support.
+ * Design document number: ARM DEN0117.
+ *
+ * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES.
+ *
+ */
+
+#define pr_fmt(fmt)	"ACPI: APMT: " fmt
+
+#include <linux/acpi.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+
+#define DEV_NAME "arm-csite-pmu"
+
+/* There can be up to 3 resources: page 0 and 1 address, and interrupt. */
+#define DEV_MAX_RESOURCE_COUNT 3
+
+/* Root pointer to the mapped APMT table */
+static struct acpi_table_header *apmt_table;
+
+static int __init apmt_init_resources(struct resource *res,
+					      struct acpi_apmt_node *node)
+{
+	int irq, trigger;
+	int num_res = 0;
+
+	res[num_res].start = node->base_address0;
+	res[num_res].end = node->base_address0 + SZ_4K - 1;
+	res[num_res].flags = IORESOURCE_MEM;
+
+	num_res++;
+
+	res[num_res].start = node->base_address1;
+	res[num_res].end = node->base_address1 + SZ_4K - 1;
+	res[num_res].flags = IORESOURCE_MEM;
+
+	num_res++;
+
+	if (node->ovflw_irq != 0) {
+		trigger = (node->ovflw_irq_flags & ACPI_APMT_OVFLW_IRQ_FLAGS_MODE);
+		trigger = (trigger == ACPI_APMT_OVFLW_IRQ_FLAGS_MODE_LEVEL) ?
+			ACPI_LEVEL_SENSITIVE : ACPI_EDGE_SENSITIVE;
+		irq = acpi_register_gsi(NULL, node->ovflw_irq, trigger,
+						ACPI_ACTIVE_HIGH);
+
+		if (irq <= 0) {
+			pr_warn("APMT could not register gsi hwirq %d\n", irq);
+			return num_res;
+		}
+
+		res[num_res].start = irq;
+		res[num_res].end = irq;
+		res[num_res].flags = IORESOURCE_IRQ;
+
+		num_res++;
+	}
+
+	return num_res;
+}
+
+/**
+ * apmt_add_platform_device() - Allocate a platform device for APMT node
+ * @node: Pointer to device ACPI APMT node
+ *
+ * Returns: 0 on success, <0 failure
+ */
+static int __init apmt_add_platform_device(struct acpi_apmt_node *node,
+							struct fwnode_handle *fwnode)
+{
+	struct platform_device *pdev;
+	int ret, count;
+	struct resource res[DEV_MAX_RESOURCE_COUNT];
+
+	pdev = platform_device_alloc(DEV_NAME, PLATFORM_DEVID_AUTO);
+	if (!pdev)
+		return -ENOMEM;
+
+	memset(res, 0, sizeof(res));
+
+	count = apmt_init_resources(res, node);
+
+	ret = platform_device_add_resources(pdev, res, count);
+	if (ret)
+		goto dev_put;
+
+	/*
+	 * Add a copy of APMT node pointer to platform_data to be used to
+	 * retrieve APMT data information.
+	 */
+	ret = platform_device_add_data(pdev, &node, sizeof(node));
+	if (ret)
+		goto dev_put;
+
+	pdev->dev.fwnode = fwnode;
+
+	ret = platform_device_add(pdev);
+
+	if (ret)
+		goto dev_put;
+
+	return 0;
+
+dev_put:
+	platform_device_put(pdev);
+
+	return ret;
+}
+
+static int __init apmt_init_platform_devices(void)
+{
+	struct acpi_apmt_node *apmt_node;
+	struct acpi_table_apmt *apmt;
+	struct fwnode_handle *fwnode;
+	u64 offset, end;
+	int ret;
+
+	/*
+	 * apmt_table and apmt both point to the start of APMT table, but
+	 * have different struct types
+	 */
+	apmt = (struct acpi_table_apmt *)apmt_table;
+	offset = sizeof(*apmt);
+	end = apmt->header.length;
+
+	while (offset < end) {
+		apmt_node = ACPI_ADD_PTR(struct acpi_apmt_node, apmt,
+				 offset);
+
+		fwnode = acpi_alloc_fwnode_static();
+		if (!fwnode)
+			return -ENOMEM;
+
+		ret = apmt_add_platform_device(apmt_node, fwnode);
+		if (ret) {
+			acpi_free_fwnode_static(fwnode);
+			return ret;
+		}
+
+		offset += apmt_node->length;
+	}
+
+	return 0;
+}
+
+void __init acpi_apmt_init(void)
+{
+	acpi_status status;
+	int ret;
+
+	/**
+	 * APMT table nodes will be used at runtime after the apmt init,
+	 * so we don't need to call acpi_put_table() to release
+	 * the APMT table mapping.
+	 */
+	status = acpi_get_table(ACPI_SIG_APMT, 0, &apmt_table);
+
+	if (ACPI_FAILURE(status)) {
+		if (status != AE_NOT_FOUND) {
+			const char *msg = acpi_format_exception(status);
+
+			pr_err("Failed to get APMT table, %s\n", msg);
+		}
+
+		return;
+	}
+
+	ret = apmt_init_platform_devices();
+	if (ret) {
+		pr_err("Failed to initialize APMT platform devices, ret: %d\n", ret);
+		acpi_put_table(apmt_table);
+	}
+}
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 3e58b613a2c4..25ddd9f300e7 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -27,6 +27,7 @@
 #include <linux/dmi.h>
 #endif
 #include <linux/acpi_agdi.h>
+#include <linux/acpi_apmt.h>
 #include <linux/acpi_iort.h>
 #include <linux/acpi_viot.h>
 #include <linux/pci.h>
@@ -1367,6 +1368,7 @@ static int __init acpi_init(void)
 	acpi_setup_sb_notify_handler();
 	acpi_viot_init();
 	acpi_agdi_init();
+	acpi_apmt_init();
 	return 0;
 }
 
diff --git a/include/linux/acpi_apmt.h b/include/linux/acpi_apmt.h
new file mode 100644
index 000000000000..40bd634d082f
--- /dev/null
+++ b/include/linux/acpi_apmt.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * ARM CoreSight PMU driver.
+ * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES.
+ *
+ */
+
+#ifndef __ACPI_APMT_H__
+#define __ACPI_APMT_H__
+
+#include <linux/acpi.h>
+
+#ifdef CONFIG_ACPI_APMT
+void acpi_apmt_init(void);
+#else
+static inline void acpi_apmt_init(void) { }
+#endif /* CONFIG_ACPI_APMT */
+
+#endif /* __ACPI_APMT_H__ */
-- 
2.17.1

