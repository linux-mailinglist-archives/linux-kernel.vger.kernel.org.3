Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCFDB5925F0
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 20:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbiHNSYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 14:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbiHNSYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 14:24:42 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49056186F4;
        Sun, 14 Aug 2022 11:24:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bl7EBwy3GIwhmr1sKcZVvC0bZCGAOSsn9KHBtyihxAzO2qKMwOHsZO7VwG9qy1asMYWMQNuseURLDc8kpc8Iu1pfJRYLigBbI4ss/dLiWGVAngKHzVb14zgctC1ADBcq3sbuP+JRAS0aWQaDVWk1I3ceFulVRkWMe+p4w7Dv6ecJZnbYJlkf5IlNWPmXzSQ6NOBwaWZJduPIkagDY3pINlXABRZP+4GUTa0vljdh2l8QSq0XJTeXOPTKK/tqdPI1EDnXRyV2YeN+egSWuPT6peqz9MG7NOrwT/atc0hou68zOB/AKvBzcT+QzIC0e4Q2jt7cj6FHmxtY9ZQBFuxD0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/6STzlKBt0ktArzxRD2VKeTehjlMcOSk5OhHHjl4yI=;
 b=k68C02vSMnsEPp0OrpfbYn6VXutp4PKhVB86vlXU3Xdt+YARdS7GttILyKCJHfzDaTLoAI3xy57Nf5IGhKu3rAvfdQoBOYErvBGCE/MUFV0O54w3/cpeFwlUxUu92GvvxSNUBOWJextlwjSH2IqeV+EtFoY13k+uc6sH/AbQ4CLhqNq88ci1M8IL8aqAL73xxaqvftJGMLmrfF6zp+7NVfjnt2xEt4Wh0WTZWFgba9KZ9eBks1WXsuRXvIdooWKYLF8ETMnMqzBwlnfg1HyTMeRId3sCFy1MxFdYU/hBaWmpPqXp9b7b2ZqvFSieU/3d/R1HBSAtkIJmqXvkOStl9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/6STzlKBt0ktArzxRD2VKeTehjlMcOSk5OhHHjl4yI=;
 b=arD6ntYvWg8SEBhoCR91nsPdalUlrXWtIp9EWIXZCeWFGWXiJFEDHa0v8s7nZq/wg4hLeZJ/7dFLDNuQMJVaK1jlpQ7bM47XMYqTENTnJ9FuflydU3mXVVyUWHOkb0MoEMbgyvfFxy+C7AIA4Zrhy5jnyUNn8J1ZaEfUvX6Wtyzwb7JLnf8aLVhDPgTVtyqVdjaFi/okmsJkSWtcDlyalav7Ag3YPTQP99jm/nCDfk2mLQga42isEQtNrPQxZ7P/AEU/48jmVUxnVgCEn9VNRFR+LWTxr7IoJgl3i5yMCwmaq+vaWVyN8ZTOMObC2QxOxmQEKJ4/dhVytsV7nKCX+A==
Received: from MW4PR03CA0032.namprd03.prod.outlook.com (2603:10b6:303:8e::7)
 by PH0PR12MB5646.namprd12.prod.outlook.com (2603:10b6:510:143::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Sun, 14 Aug
 2022 18:24:34 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::e) by MW4PR03CA0032.outlook.office365.com
 (2603:10b6:303:8e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.18 via Frontend
 Transport; Sun, 14 Aug 2022 18:24:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5525.11 via Frontend Transport; Sun, 14 Aug 2022 18:24:34 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL101.nvidia.com (10.27.9.10) with Microsoft SMTP Server (TLS) id
 15.0.1497.38; Sun, 14 Aug 2022 18:24:33 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Sun, 14 Aug 2022 11:24:33 -0700
Received: from msst-build.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Sun, 14 Aug 2022 11:24:32 -0700
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     <suzuki.poulose@arm.com>, <robin.murphy@arm.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <sudeep.holla@arm.com>, <thanu.rangarajan@arm.com>,
        <Michael.Williams@arm.com>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
        <mathieu.poirier@linaro.org>, <mike.leach@linaro.org>,
        <leo.yan@linaro.org>, Besar Wicaksono <bwicaksono@nvidia.com>
Subject: [PATCH v4 1/2] perf: arm_cspmu: Add support for ARM CoreSight PMU driver
Date:   Sun, 14 Aug 2022 13:23:50 -0500
Message-ID: <20220814182351.8861-2-bwicaksono@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220814182351.8861-1-bwicaksono@nvidia.com>
References: <20220814182351.8861-1-bwicaksono@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 271176d4-e01e-4abc-5861-08da7e223cfd
X-MS-TrafficTypeDiagnostic: PH0PR12MB5646:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XJo84yWjxMokpLTC8ScttWvFCv45GW30rY6WTlikdQf6JhUzHNsnn4G8gGM7?=
 =?us-ascii?Q?63bjAtei7iH/zQl7xbxTabaHKrGp4Qwpy1nudKrI6IB897Z7X3Isv8RpIjsG?=
 =?us-ascii?Q?pnVQtz08shIq6cJAv0f86ng9EjY/bM4odOYPzEei5pk4DCljoabE6t29xKUZ?=
 =?us-ascii?Q?Mfip0sZblpRSGoOzMhkE1WA2mVD6OxMnS0fQW9wu4idfOsCAWPBFDJ+Psx2R?=
 =?us-ascii?Q?yyl+hssgAvOIB/hbx9FdOE+BnGO9MbkQKE7SnSjifMH0S0P7PUKqV1ZiBHp7?=
 =?us-ascii?Q?G2lc3VLIebLJsJY95UG65nK8y5dfbQNR93g/clSlN4+9pfb4S3TUjPmcTA7Q?=
 =?us-ascii?Q?U5wb03KruacY6UYJ19iGQxZSr/lXX2Seeu1wH6o5Rii53hEfpTWlIFZaiswt?=
 =?us-ascii?Q?rA+g3f+dcHOPUwJWWL/l4mcOfEcVTAuOXtr1HIg6CBwfcCZXc0TblcqwQP7D?=
 =?us-ascii?Q?lVYixp67q87ZgjQutrZ5xZ9canL+vg3iHvqo0YH+ONP2IyvwtkheJua9XlUb?=
 =?us-ascii?Q?DZhk1B7NJamMrj77x6OYiHNTYe3FnxF3xYozUbSBkLZ349OudU3cXcFHodGo?=
 =?us-ascii?Q?JysbHrXe5/81sjIiJkKn63UHOjWjAZphb+SPGCTIExza3QdCbChQJ9pAEr0Y?=
 =?us-ascii?Q?guFryMju5/Flt9bnm87rN9T2Z9H08Km/7xT2jPcyA+YY/Sapj6ktx43d0xI6?=
 =?us-ascii?Q?iN8QjOYZBsHVCCtb8DSTUuLnnlTilPv+tPJS0L6qW2UA7/b7X8pWCyMiJks/?=
 =?us-ascii?Q?pIZXMm/UkQFrhEvQazesVNR0pnZobSXPtJ+FSB0KtrA1vHXESDpdF8wh67c+?=
 =?us-ascii?Q?Fqq2KgXERbWiW3PqTs4nlmBaDHvSgVuKQm0PjQ9wpEeqnkXmBtnhcdmqJ3gM?=
 =?us-ascii?Q?m3KJvYgnBkLpfb0l5ihVu6mz2nsP08VanzgAk6o15pYZvEzhpXFKiOmBtBId?=
 =?us-ascii?Q?bbaH3VaOFxW7WDlwUr5jTw=3D=3D?=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(396003)(376002)(346002)(40470700004)(46966006)(36840700001)(40460700003)(426003)(336012)(478600001)(5660300002)(1076003)(186003)(47076005)(36756003)(107886003)(2616005)(966005)(83380400001)(110136005)(54906003)(40480700001)(8936002)(86362001)(36860700001)(41300700001)(7416002)(356005)(30864003)(8676002)(316002)(81166007)(82310400005)(4326008)(7696005)(70586007)(82740400003)(70206006)(2906002)(26005)(6666004)(36900700001)(579004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2022 18:24:34.2320
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 271176d4-e01e-4abc-5861-08da7e223cfd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5646
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for ARM CoreSight PMU driver framework and interfaces.
The driver provides generic implementation to operate uncore PMU based
on ARM CoreSight PMU architecture. The driver also provides interface
to get vendor/implementation specific information, for example event
attributes and formating.

The specification used in this implementation can be found below:
 * ACPI Arm Performance Monitoring Unit table:
        https://developer.arm.com/documentation/den0117/latest
 * ARM Coresight PMU architecture:
        https://developer.arm.com/documentation/ihi0091/latest

Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
---
 arch/arm64/configs/defconfig       |    1 +
 drivers/perf/Kconfig               |    2 +
 drivers/perf/Makefile              |    1 +
 drivers/perf/arm_cspmu/Kconfig     |   13 +
 drivers/perf/arm_cspmu/Makefile    |    6 +
 drivers/perf/arm_cspmu/arm_cspmu.c | 1262 ++++++++++++++++++++++++++++
 drivers/perf/arm_cspmu/arm_cspmu.h |  151 ++++
 7 files changed, 1436 insertions(+)
 create mode 100644 drivers/perf/arm_cspmu/Kconfig
 create mode 100644 drivers/perf/arm_cspmu/Makefile
 create mode 100644 drivers/perf/arm_cspmu/arm_cspmu.c
 create mode 100644 drivers/perf/arm_cspmu/arm_cspmu.h

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7d1105343bc2..ee31c9159a5b 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1212,6 +1212,7 @@ CONFIG_PHY_UNIPHIER_USB3=y
 CONFIG_PHY_TEGRA_XUSB=y
 CONFIG_PHY_AM654_SERDES=m
 CONFIG_PHY_J721E_WIZ=m
+CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU=y
 CONFIG_ARM_SMMU_V3_PMU=m
 CONFIG_FSL_IMX8_DDR_PMU=m
 CONFIG_QCOM_L2_PMU=y
diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 1e2d69453771..c94d3601eb48 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -192,4 +192,6 @@ config MARVELL_CN10K_DDR_PMU
 	  Enable perf support for Marvell DDR Performance monitoring
 	  event on CN10K platform.
 
+source "drivers/perf/arm_cspmu/Kconfig"
+
 endmenu
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index 57a279c61df5..3bc9323f0965 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -20,3 +20,4 @@ obj-$(CONFIG_ARM_DMC620_PMU) += arm_dmc620_pmu.o
 obj-$(CONFIG_MARVELL_CN10K_TAD_PMU) += marvell_cn10k_tad_pmu.o
 obj-$(CONFIG_MARVELL_CN10K_DDR_PMU) += marvell_cn10k_ddr_pmu.o
 obj-$(CONFIG_APPLE_M1_CPU_PMU) += apple_m1_cpu_pmu.o
+obj-$(CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += arm_cspmu/
diff --git a/drivers/perf/arm_cspmu/Kconfig b/drivers/perf/arm_cspmu/Kconfig
new file mode 100644
index 000000000000..c2c56ecafccb
--- /dev/null
+++ b/drivers/perf/arm_cspmu/Kconfig
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES.
+
+config ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU
+	tristate "ARM Coresight Architecture PMU"
+	depends on ACPI
+	depends on ACPI_APMT || COMPILE_TEST
+	help
+	  Provides support for performance monitoring unit (PMU) devices
+	  based on ARM CoreSight PMU architecture. Note that this PMU
+	  architecture does not have relationship with the ARM CoreSight
+	  Self-Hosted Tracing.
diff --git a/drivers/perf/arm_cspmu/Makefile b/drivers/perf/arm_cspmu/Makefile
new file mode 100644
index 000000000000..cdc3455f74d8
--- /dev/null
+++ b/drivers/perf/arm_cspmu/Makefile
@@ -0,0 +1,6 @@
+# Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES.
+#
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += \
+	arm_cspmu.o
diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
new file mode 100644
index 000000000000..410876f86eb0
--- /dev/null
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -0,0 +1,1262 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ARM CoreSight Architecture PMU driver.
+ *
+ * This driver adds support for uncore PMU based on ARM CoreSight Performance
+ * Monitoring Unit Architecture. The PMU is accessible via MMIO registers and
+ * like other uncore PMUs, it does not support process specific events and
+ * cannot be used in sampling mode.
+ *
+ * This code is based on other uncore PMUs like ARM DSU PMU. It provides a
+ * generic implementation to operate the PMU according to CoreSight PMU
+ * architecture and ACPI ARM PMU table (APMT) documents below:
+ *   - ARM CoreSight PMU architecture document number: ARM IHI 0091 A.a-00bet0.
+ *   - APMT document number: ARM DEN0117.
+ *
+ * The user should refer to the vendor technical documentation to get details
+ * about the supported events.
+ *
+ * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES.
+ *
+ */
+
+#include <linux/acpi.h>
+#include <linux/cacheinfo.h>
+#include <linux/ctype.h>
+#include <linux/interrupt.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/module.h>
+#include <linux/perf_event.h>
+#include <linux/platform_device.h>
+#include <acpi/processor.h>
+
+#include "arm_cspmu.h"
+
+#define PMUNAME "arm_cspmu"
+#define DRVNAME "arm-cs-arch-pmu"
+
+#define ARM_CSPMU_CPUMASK_ATTR(_name, _config)			\
+	ARM_CSPMU_EXT_ATTR(_name, arm_cspmu_cpumask_show,	\
+				(unsigned long)_config)
+
+/*
+ * CoreSight PMU Arch register offsets.
+ */
+#define PMEVCNTR_LO					0x0
+#define PMEVCNTR_HI					0x4
+#define PMEVTYPER					0x400
+#define PMCCFILTR					0x47C
+#define PMEVFILTR					0xA00
+#define PMCNTENSET					0xC00
+#define PMCNTENCLR					0xC20
+#define PMINTENSET					0xC40
+#define PMINTENCLR					0xC60
+#define PMOVSCLR					0xC80
+#define PMOVSSET					0xCC0
+#define PMCFGR						0xE00
+#define PMCR						0xE04
+#define PMIIDR						0xE08
+
+/* PMCFGR register field */
+#define PMCFGR_NCG					GENMASK(31, 28)
+#define PMCFGR_HDBG					BIT(24)
+#define PMCFGR_TRO					BIT(23)
+#define PMCFGR_SS					BIT(22)
+#define PMCFGR_FZO					BIT(21)
+#define PMCFGR_MSI					BIT(20)
+#define PMCFGR_UEN					BIT(19)
+#define PMCFGR_NA					BIT(17)
+#define PMCFGR_EX					BIT(16)
+#define PMCFGR_CCD					BIT(15)
+#define PMCFGR_CC					BIT(14)
+#define PMCFGR_SIZE					GENMASK(13, 8)
+#define PMCFGR_N					GENMASK(7, 0)
+
+/* PMCR register field */
+#define PMCR_TRO					BIT(11)
+#define PMCR_HDBG					BIT(10)
+#define PMCR_FZO					BIT(9)
+#define PMCR_NA						BIT(8)
+#define PMCR_DP						BIT(5)
+#define PMCR_X						BIT(4)
+#define PMCR_D						BIT(3)
+#define PMCR_C						BIT(2)
+#define PMCR_P						BIT(1)
+#define PMCR_E						BIT(0)
+
+/* Each SET/CLR register supports up to 32 counters. */
+#define ARM_CSPMU_SET_CLR_COUNTER_SHIFT		5
+#define ARM_CSPMU_SET_CLR_COUNTER_NUM		\
+	(1 << ARM_CSPMU_SET_CLR_COUNTER_SHIFT)
+
+/* The number of 32-bit SET/CLR register that can be supported. */
+#define ARM_CSPMU_SET_CLR_MAX_NUM ((PMCNTENCLR - PMCNTENSET) / sizeof(u32))
+
+static_assert(
+	(ARM_CSPMU_SET_CLR_MAX_NUM * ARM_CSPMU_SET_CLR_COUNTER_NUM) >=
+	ARM_CSPMU_MAX_HW_CNTRS);
+
+/* Convert counter idx into SET/CLR register number. */
+#define COUNTER_TO_SET_CLR_ID(idx)			\
+	(idx >> ARM_CSPMU_SET_CLR_COUNTER_SHIFT)
+
+/* Convert counter idx into SET/CLR register bit. */
+#define COUNTER_TO_SET_CLR_BIT(idx)			\
+	(idx & (ARM_CSPMU_SET_CLR_COUNTER_NUM - 1))
+
+#define ARM_CSPMU_ACTIVE_CPU_MASK		0x0
+#define ARM_CSPMU_ASSOCIATED_CPU_MASK		0x1
+
+/* Check if field f in flags is set with value v */
+#define CHECK_APMT_FLAG(flags, f, v) \
+	((flags & (ACPI_APMT_FLAGS_ ## f)) == (ACPI_APMT_FLAGS_ ## f ## _ ## v))
+
+/* Check and use default if implementer doesn't provide attribute callback */
+#define CHECK_DEFAULT_IMPL_OPS(ops, callback)			\
+	do {							\
+		if (!ops->callback)				\
+			ops->callback = arm_cspmu_ ## callback;	\
+	} while (0)
+
+static unsigned long arm_cspmu_cpuhp_state;
+
+/*
+ * In CoreSight PMU architecture, all of the MMIO registers are 32-bit except
+ * counter register. The counter register can be implemented as 32-bit or 64-bit
+ * register depending on the value of PMCFGR.SIZE field. For 64-bit access,
+ * single-copy 64-bit atomic support is implementation defined. APMT node flag
+ * is used to identify if the PMU supports 64-bit single copy atomic. If 64-bit
+ * single copy atomic is not supported, the driver treats the register as a pair
+ * of 32-bit register.
+ */
+
+/*
+ * Read 64-bit register as a pair of 32-bit registers using hi-lo-hi sequence.
+ */
+static u64 read_reg64_hilohi(const void __iomem *addr)
+{
+	u32 val_lo, val_hi;
+	u64 val;
+
+	/* Use high-low-high sequence to avoid tearing */
+	do {
+		val_hi = readl(addr + 4);
+		val_lo = readl(addr);
+	} while (val_hi != readl(addr + 4));
+
+	val = (((u64)val_hi << 32) | val_lo);
+
+	return val;
+}
+
+/* Check if PMU supports 64-bit single copy atomic. */
+static inline bool supports_64bit_atomics(const struct arm_cspmu *cspmu)
+{
+	return CHECK_APMT_FLAG(cspmu->apmt_node->flags, ATOMIC, SUPP);
+}
+
+/* Check if cycle counter is supported. */
+static inline bool supports_cycle_counter(const struct arm_cspmu *cspmu)
+{
+	return (cspmu->pmcfgr & PMCFGR_CC);
+}
+
+/* Get counter size, which is (PMCFGR_SIZE + 1). */
+static inline u32 counter_size(const struct arm_cspmu *cspmu)
+{
+	return FIELD_GET(PMCFGR_SIZE, cspmu->pmcfgr) + 1;
+}
+
+/* Get counter mask. */
+static inline u64 counter_mask(const struct arm_cspmu *cspmu)
+{
+	return GENMASK_ULL(counter_size(cspmu) - 1, 0);
+}
+
+/* Check if counter is implemented as 64-bit register. */
+static inline bool use_64b_counter_reg(const struct arm_cspmu *cspmu)
+{
+	return (counter_size(cspmu) > 32);
+}
+
+ssize_t arm_cspmu_sysfs_event_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct dev_ext_attribute *eattr =
+		container_of(attr, struct dev_ext_attribute, attr);
+	return sysfs_emit(buf, "event=0x%llx\n",
+			  (unsigned long long)eattr->var);
+}
+EXPORT_SYMBOL_GPL(arm_cspmu_sysfs_event_show);
+
+/* Default event list. */
+static struct attribute *arm_cspmu_event_attrs[] = {
+	ARM_CSPMU_EVENT_ATTR(cycles, ARM_CSPMU_EVT_CYCLES_DEFAULT),
+	NULL,
+};
+
+static struct attribute **
+arm_cspmu_get_event_attrs(const struct arm_cspmu *cspmu)
+{
+	return arm_cspmu_event_attrs;
+}
+
+static umode_t
+arm_cspmu_event_attr_is_visible(struct kobject *kobj,
+				struct attribute *attr, int unused)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct arm_cspmu *cspmu = to_arm_cspmu(dev_get_drvdata(dev));
+	struct perf_pmu_events_attr *eattr;
+
+	eattr = container_of(attr, typeof(*eattr), attr.attr);
+
+	/* Hide cycle event if not supported */
+	if (!supports_cycle_counter(cspmu) &&
+	    eattr->id == ARM_CSPMU_EVT_CYCLES_DEFAULT)
+		return 0;
+
+	return attr->mode;
+}
+
+ssize_t arm_cspmu_sysfs_format_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct dev_ext_attribute *eattr =
+		container_of(attr, struct dev_ext_attribute, attr);
+	return sysfs_emit(buf, "%s\n", (char *)eattr->var);
+}
+EXPORT_SYMBOL_GPL(arm_cspmu_sysfs_format_show);
+
+static struct attribute *arm_cspmu_format_attrs[] = {
+	ARM_CSPMU_FORMAT_EVENT_ATTR,
+	ARM_CSPMU_FORMAT_FILTER_ATTR,
+	NULL,
+};
+
+static struct attribute **
+arm_cspmu_get_format_attrs(const struct arm_cspmu *cspmu)
+{
+	return arm_cspmu_format_attrs;
+}
+
+static u32 arm_cspmu_event_type(const struct perf_event *event)
+{
+	return event->attr.config & ARM_CSPMU_EVENT_MASK;
+}
+
+static bool arm_cspmu_is_cycle_counter_event(const struct perf_event *event)
+{
+	return (event->attr.config == ARM_CSPMU_EVT_CYCLES_DEFAULT);
+}
+
+static u32 arm_cspmu_event_filter(const struct perf_event *event)
+{
+	return event->attr.config1 & ARM_CSPMU_FILTER_MASK;
+}
+
+static ssize_t arm_cspmu_identifier_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *page)
+{
+	struct arm_cspmu *cspmu = to_arm_cspmu(dev_get_drvdata(dev));
+
+	return sysfs_emit(page, "%s\n", cspmu->identifier);
+}
+
+static struct device_attribute arm_cspmu_identifier_attr =
+	__ATTR(identifier, 0444, arm_cspmu_identifier_show, NULL);
+
+static struct attribute *arm_cspmu_identifier_attrs[] = {
+	&arm_cspmu_identifier_attr.attr,
+	NULL,
+};
+
+static struct attribute_group arm_cspmu_identifier_attr_group = {
+	.attrs = arm_cspmu_identifier_attrs,
+};
+
+static const char *arm_cspmu_get_identifier(const struct arm_cspmu *cspmu)
+{
+	const char *identifier =
+		devm_kasprintf(cspmu->dev, GFP_KERNEL, "%x",
+			       cspmu->impl.pmiidr);
+	return identifier;
+}
+
+static const char *arm_cspmu_type_str[ACPI_APMT_NODE_TYPE_COUNT] = {
+	"mc",
+	"smmu",
+	"pcie",
+	"acpi",
+	"cache",
+};
+
+static const char *arm_cspmu_get_name(const struct arm_cspmu *cspmu)
+{
+	struct device *dev;
+	struct acpi_apmt_node *apmt_node;
+	u8 pmu_type;
+	char *name;
+	char acpi_hid_string[ACPI_ID_LEN] = { 0 };
+	static atomic_t pmu_idx[ACPI_APMT_NODE_TYPE_COUNT] = { 0 };
+
+	dev = cspmu->dev;
+	apmt_node = cspmu->apmt_node;
+	pmu_type = apmt_node->type;
+
+	if (pmu_type >= ACPI_APMT_NODE_TYPE_COUNT) {
+		dev_err(dev, "unsupported PMU type-%u\n", pmu_type);
+		return NULL;
+	}
+
+	if (pmu_type == ACPI_APMT_NODE_TYPE_ACPI) {
+		memcpy(acpi_hid_string,
+			&apmt_node->inst_primary,
+			sizeof(apmt_node->inst_primary));
+		name = devm_kasprintf(dev, GFP_KERNEL, "%s_%s_%s_%u", PMUNAME,
+				      arm_cspmu_type_str[pmu_type],
+				      acpi_hid_string,
+				      apmt_node->inst_secondary);
+	} else {
+		name = devm_kasprintf(dev, GFP_KERNEL, "%s_%s_%d", PMUNAME,
+				      arm_cspmu_type_str[pmu_type],
+				      atomic_fetch_inc(&pmu_idx[pmu_type]));
+	}
+
+	return name;
+}
+
+static ssize_t arm_cspmu_cpumask_show(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	struct pmu *pmu = dev_get_drvdata(dev);
+	struct arm_cspmu *cspmu = to_arm_cspmu(pmu);
+	struct dev_ext_attribute *eattr =
+		container_of(attr, struct dev_ext_attribute, attr);
+	unsigned long mask_id = (unsigned long)eattr->var;
+	const cpumask_t *cpumask;
+
+	switch (mask_id) {
+	case ARM_CSPMU_ACTIVE_CPU_MASK:
+		cpumask = &cspmu->active_cpu;
+		break;
+	case ARM_CSPMU_ASSOCIATED_CPU_MASK:
+		cpumask = &cspmu->associated_cpus;
+		break;
+	default:
+		return 0;
+	}
+	return cpumap_print_to_pagebuf(true, buf, cpumask);
+}
+
+static struct attribute *arm_cspmu_cpumask_attrs[] = {
+	ARM_CSPMU_CPUMASK_ATTR(cpumask, ARM_CSPMU_ACTIVE_CPU_MASK),
+	ARM_CSPMU_CPUMASK_ATTR(associated_cpus, ARM_CSPMU_ASSOCIATED_CPU_MASK),
+	NULL,
+};
+
+static struct attribute_group arm_cspmu_cpumask_attr_group = {
+	.attrs = arm_cspmu_cpumask_attrs,
+};
+
+struct impl_match {
+	u32 pmiidr;
+	u32 mask;
+	int (*impl_init_ops)(struct arm_cspmu *cspmu);
+};
+
+static const struct impl_match impl_match[] = {
+	{}
+};
+
+static int arm_cspmu_init_impl_ops(struct arm_cspmu *cspmu)
+{
+	int ret;
+	struct acpi_apmt_node *apmt_node = cspmu->apmt_node;
+	struct arm_cspmu_impl_ops *impl_ops = &cspmu->impl.ops;
+	const struct impl_match *match = impl_match;
+
+	/*
+	 * Get PMU implementer and product id from APMT node.
+	 * If APMT node doesn't have implementer/product id, try get it
+	 * from PMIIDR.
+	 */
+	cspmu->impl.pmiidr =
+		(apmt_node->impl_id) ? apmt_node->impl_id :
+				       readl(cspmu->base0 + PMIIDR);
+
+	/* Find implementer specific attribute ops. */
+	for (; match->pmiidr; match++) {
+		const u32 mask = match->mask;
+
+		if ((match->pmiidr & mask) == (cspmu->impl.pmiidr & mask)) {
+			ret = match->impl_init_ops(cspmu);
+			if (ret)
+				return ret;
+
+			break;
+		}
+	}
+
+	/* Use default callbacks if implementer doesn't provide one. */
+	CHECK_DEFAULT_IMPL_OPS(impl_ops, get_event_attrs);
+	CHECK_DEFAULT_IMPL_OPS(impl_ops, get_format_attrs);
+	CHECK_DEFAULT_IMPL_OPS(impl_ops, get_identifier);
+	CHECK_DEFAULT_IMPL_OPS(impl_ops, get_name);
+	CHECK_DEFAULT_IMPL_OPS(impl_ops, is_cycle_counter_event);
+	CHECK_DEFAULT_IMPL_OPS(impl_ops, event_type);
+	CHECK_DEFAULT_IMPL_OPS(impl_ops, event_filter);
+	CHECK_DEFAULT_IMPL_OPS(impl_ops, event_attr_is_visible);
+
+	return 0;
+}
+
+static struct attribute_group *
+arm_cspmu_alloc_event_attr_group(struct arm_cspmu *cspmu)
+{
+	struct attribute_group *event_group;
+	struct device *dev = cspmu->dev;
+	const struct arm_cspmu_impl_ops *impl_ops = &cspmu->impl.ops;
+
+	event_group =
+		devm_kzalloc(dev, sizeof(struct attribute_group), GFP_KERNEL);
+	if (!event_group)
+		return NULL;
+
+	event_group->name = "events";
+	event_group->attrs = impl_ops->get_event_attrs(cspmu);
+	event_group->is_visible = impl_ops->event_attr_is_visible;
+
+	return event_group;
+}
+
+static struct attribute_group *
+arm_cspmu_alloc_format_attr_group(struct arm_cspmu *cspmu)
+{
+	struct attribute_group *format_group;
+	struct device *dev = cspmu->dev;
+
+	format_group =
+		devm_kzalloc(dev, sizeof(struct attribute_group), GFP_KERNEL);
+	if (!format_group)
+		return NULL;
+
+	format_group->name = "format";
+	format_group->attrs = cspmu->impl.ops.get_format_attrs(cspmu);
+
+	return format_group;
+}
+
+static struct attribute_group **
+arm_cspmu_alloc_attr_group(struct arm_cspmu *cspmu)
+{
+	struct attribute_group **attr_groups = NULL;
+	struct device *dev = cspmu->dev;
+	const struct arm_cspmu_impl_ops *impl_ops = &cspmu->impl.ops;
+	int ret;
+
+	ret = arm_cspmu_init_impl_ops(cspmu);
+	if (ret)
+		return NULL;
+
+	cspmu->identifier = impl_ops->get_identifier(cspmu);
+	cspmu->name = impl_ops->get_name(cspmu);
+
+	if (!cspmu->identifier || !cspmu->name)
+		return NULL;
+
+	attr_groups = devm_kcalloc(dev, 5, sizeof(struct attribute_group *),
+				   GFP_KERNEL);
+	if (!attr_groups)
+		return NULL;
+
+	attr_groups[0] = arm_cspmu_alloc_event_attr_group(cspmu);
+	attr_groups[1] = arm_cspmu_alloc_format_attr_group(cspmu);
+	attr_groups[2] = &arm_cspmu_identifier_attr_group;
+	attr_groups[3] = &arm_cspmu_cpumask_attr_group;
+
+	if (!attr_groups[0] || !attr_groups[1])
+		return NULL;
+
+	return attr_groups;
+}
+
+static inline void arm_cspmu_reset_counters(struct arm_cspmu *cspmu)
+{
+	u32 pmcr = 0;
+
+	pmcr |= PMCR_P;
+	pmcr |= PMCR_C;
+	writel(pmcr, cspmu->base0 + PMCR);
+}
+
+static inline void arm_cspmu_start_counters(struct arm_cspmu *cspmu)
+{
+	writel(PMCR_E, cspmu->base0 + PMCR);
+}
+
+static inline void arm_cspmu_stop_counters(struct arm_cspmu *cspmu)
+{
+	writel(0, cspmu->base0 + PMCR);
+}
+
+static void arm_cspmu_enable(struct pmu *pmu)
+{
+	bool disabled;
+	struct arm_cspmu *cspmu = to_arm_cspmu(pmu);
+
+	disabled = bitmap_empty(cspmu->hw_events.used_ctrs,
+				cspmu->num_logical_ctrs);
+
+	if (disabled)
+		return;
+
+	arm_cspmu_start_counters(cspmu);
+}
+
+static void arm_cspmu_disable(struct pmu *pmu)
+{
+	struct arm_cspmu *cspmu = to_arm_cspmu(pmu);
+
+	arm_cspmu_stop_counters(cspmu);
+}
+
+static int arm_cspmu_get_event_idx(struct arm_cspmu_hw_events *hw_events,
+				struct perf_event *event)
+{
+	int idx;
+	struct arm_cspmu *cspmu = to_arm_cspmu(event->pmu);
+
+	if (supports_cycle_counter(cspmu)) {
+		if (cspmu->impl.ops.is_cycle_counter_event(event)) {
+			/* Search for available cycle counter. */
+			if (test_and_set_bit(cspmu->cycle_counter_logical_idx,
+					     hw_events->used_ctrs))
+				return -EAGAIN;
+
+			return cspmu->cycle_counter_logical_idx;
+		}
+
+		/*
+		 * Search a regular counter from the used counter bitmap.
+		 * The cycle counter divides the bitmap into two parts. Search
+		 * the first then second half to exclude the cycle counter bit.
+		 */
+		idx = find_first_zero_bit(hw_events->used_ctrs,
+					  cspmu->cycle_counter_logical_idx);
+		if (idx >= cspmu->cycle_counter_logical_idx) {
+			idx = find_next_zero_bit(
+				hw_events->used_ctrs,
+				cspmu->num_logical_ctrs,
+				cspmu->cycle_counter_logical_idx + 1);
+		}
+	} else {
+		idx = find_first_zero_bit(hw_events->used_ctrs,
+					  cspmu->num_logical_ctrs);
+	}
+
+	if (idx >= cspmu->num_logical_ctrs)
+		return -EAGAIN;
+
+	set_bit(idx, hw_events->used_ctrs);
+
+	return idx;
+}
+
+static bool arm_cspmu_validate_event(struct pmu *pmu,
+				 struct arm_cspmu_hw_events *hw_events,
+				 struct perf_event *event)
+{
+	if (is_software_event(event))
+		return true;
+
+	/* Reject groups spanning multiple HW PMUs. */
+	if (event->pmu != pmu)
+		return false;
+
+	return (arm_cspmu_get_event_idx(hw_events, event) >= 0);
+}
+
+/*
+ * Make sure the group of events can be scheduled at once
+ * on the PMU.
+ */
+static bool arm_cspmu_validate_group(struct perf_event *event)
+{
+	struct perf_event *sibling, *leader = event->group_leader;
+	struct arm_cspmu_hw_events fake_hw_events;
+
+	if (event->group_leader == event)
+		return true;
+
+	memset(&fake_hw_events, 0, sizeof(fake_hw_events));
+
+	if (!arm_cspmu_validate_event(event->pmu, &fake_hw_events, leader))
+		return false;
+
+	for_each_sibling_event(sibling, leader) {
+		if (!arm_cspmu_validate_event(event->pmu, &fake_hw_events,
+						  sibling))
+			return false;
+	}
+
+	return arm_cspmu_validate_event(event->pmu, &fake_hw_events, event);
+}
+
+static int arm_cspmu_event_init(struct perf_event *event)
+{
+	struct arm_cspmu *cspmu;
+	struct hw_perf_event *hwc = &event->hw;
+
+	cspmu = to_arm_cspmu(event->pmu);
+
+	/*
+	 * Following other "uncore" PMUs, we do not support sampling mode or
+	 * attach to a task (per-process mode).
+	 */
+	if (is_sampling_event(event)) {
+		dev_dbg(cspmu->pmu.dev,
+			"Can't support sampling events\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (event->cpu < 0 || event->attach_state & PERF_ATTACH_TASK) {
+		dev_dbg(cspmu->pmu.dev,
+			"Can't support per-task counters\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Make sure the CPU assignment is on one of the CPUs associated with
+	 * this PMU.
+	 */
+	if (!cpumask_test_cpu(event->cpu, &cspmu->associated_cpus)) {
+		dev_dbg(cspmu->pmu.dev,
+			"Requested cpu is not associated with the PMU\n");
+		return -EINVAL;
+	}
+
+	/* Enforce the current active CPU to handle the events in this PMU. */
+	event->cpu = cpumask_first(&cspmu->active_cpu);
+	if (event->cpu >= nr_cpu_ids)
+		return -EINVAL;
+
+	if (!arm_cspmu_validate_group(event))
+		return -EINVAL;
+
+	/*
+	 * The logical counter id is tracked with hw_perf_event.extra_reg.idx.
+	 * The physical counter id is tracked with hw_perf_event.idx.
+	 * We don't assign an index until we actually place the event onto
+	 * hardware. Use -1 to signify that we haven't decided where to put it
+	 * yet.
+	 */
+	hwc->idx = -1;
+	hwc->extra_reg.idx = -1;
+	hwc->config = cspmu->impl.ops.event_type(event);
+
+	return 0;
+}
+
+static inline u32 counter_offset(u32 reg_sz, u32 ctr_idx)
+{
+	return (PMEVCNTR_LO + (reg_sz * ctr_idx));
+}
+
+static void arm_cspmu_write_counter(struct perf_event *event, u64 val)
+{
+	u32 offset;
+	struct arm_cspmu *cspmu = to_arm_cspmu(event->pmu);
+
+	if (use_64b_counter_reg(cspmu)) {
+		offset = counter_offset(sizeof(u64), event->hw.idx);
+
+		writeq(val, cspmu->base1 + offset);
+	} else {
+		offset = counter_offset(sizeof(u32), event->hw.idx);
+
+		writel(lower_32_bits(val), cspmu->base1 + offset);
+	}
+}
+
+static u64 arm_cspmu_read_counter(struct perf_event *event)
+{
+	u32 offset;
+	const void __iomem *counter_addr;
+	struct arm_cspmu *cspmu = to_arm_cspmu(event->pmu);
+
+	if (use_64b_counter_reg(cspmu)) {
+		offset = counter_offset(sizeof(u64), event->hw.idx);
+		counter_addr = cspmu->base1 + offset;
+
+		return supports_64bit_atomics(cspmu) ?
+			       readq(counter_addr) :
+			       read_reg64_hilohi(counter_addr);
+	}
+
+	offset = counter_offset(sizeof(u32), event->hw.idx);
+	return readl(cspmu->base1 + offset);
+}
+
+/*
+ * arm_cspmu_set_event_period: Set the period for the counter.
+ *
+ * To handle cases of extreme interrupt latency, we program
+ * the counter with half of the max count for the counters.
+ */
+static void arm_cspmu_set_event_period(struct perf_event *event)
+{
+	struct arm_cspmu *cspmu = to_arm_cspmu(event->pmu);
+	u64 val = counter_mask(cspmu) >> 1ULL;
+
+	local64_set(&event->hw.prev_count, val);
+	arm_cspmu_write_counter(event, val);
+}
+
+static void arm_cspmu_enable_counter(struct arm_cspmu *cspmu, int idx)
+{
+	u32 reg_id, reg_bit, inten_off, cnten_off;
+
+	reg_id = COUNTER_TO_SET_CLR_ID(idx);
+	reg_bit = COUNTER_TO_SET_CLR_BIT(idx);
+
+	inten_off = PMINTENSET + (4 * reg_id);
+	cnten_off = PMCNTENSET + (4 * reg_id);
+
+	writel(BIT(reg_bit), cspmu->base0 + inten_off);
+	writel(BIT(reg_bit), cspmu->base0 + cnten_off);
+}
+
+static void arm_cspmu_disable_counter(struct arm_cspmu *cspmu, int idx)
+{
+	u32 reg_id, reg_bit, inten_off, cnten_off;
+
+	reg_id = COUNTER_TO_SET_CLR_ID(idx);
+	reg_bit = COUNTER_TO_SET_CLR_BIT(idx);
+
+	inten_off = PMINTENCLR + (4 * reg_id);
+	cnten_off = PMCNTENCLR + (4 * reg_id);
+
+	writel(BIT(reg_bit), cspmu->base0 + cnten_off);
+	writel(BIT(reg_bit), cspmu->base0 + inten_off);
+}
+
+static void arm_cspmu_event_update(struct perf_event *event)
+{
+	struct arm_cspmu *cspmu = to_arm_cspmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	u64 delta, prev, now;
+
+	do {
+		prev = local64_read(&hwc->prev_count);
+		now = arm_cspmu_read_counter(event);
+	} while (local64_cmpxchg(&hwc->prev_count, prev, now) != prev);
+
+	delta = (now - prev) & counter_mask(cspmu);
+	local64_add(delta, &event->count);
+}
+
+static inline void arm_cspmu_set_event(struct arm_cspmu *cspmu,
+					struct hw_perf_event *hwc)
+{
+	u32 offset = PMEVTYPER + (4 * hwc->idx);
+
+	writel(hwc->config, cspmu->base0 + offset);
+}
+
+static inline void arm_cspmu_set_ev_filter(struct arm_cspmu *cspmu,
+					   struct hw_perf_event *hwc,
+					   u32 filter)
+{
+	u32 offset = PMEVFILTR + (4 * hwc->idx);
+
+	writel(filter, cspmu->base0 + offset);
+}
+
+static inline void arm_cspmu_set_cc_filter(struct arm_cspmu *cspmu, u32 filter)
+{
+	u32 offset = PMCCFILTR;
+
+	writel(filter, cspmu->base0 + offset);
+}
+
+static void arm_cspmu_start(struct perf_event *event, int pmu_flags)
+{
+	struct arm_cspmu *cspmu = to_arm_cspmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	u32 filter;
+
+	/* We always reprogram the counter */
+	if (pmu_flags & PERF_EF_RELOAD)
+		WARN_ON(!(hwc->state & PERF_HES_UPTODATE));
+
+	arm_cspmu_set_event_period(event);
+
+	filter = cspmu->impl.ops.event_filter(event);
+
+	if (event->hw.extra_reg.idx == cspmu->cycle_counter_logical_idx) {
+		arm_cspmu_set_cc_filter(cspmu, filter);
+	} else {
+		arm_cspmu_set_event(cspmu, hwc);
+		arm_cspmu_set_ev_filter(cspmu, hwc, filter);
+	}
+
+	hwc->state = 0;
+
+	arm_cspmu_enable_counter(cspmu, hwc->idx);
+}
+
+static void arm_cspmu_stop(struct perf_event *event, int pmu_flags)
+{
+	struct arm_cspmu *cspmu = to_arm_cspmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (hwc->state & PERF_HES_STOPPED)
+		return;
+
+	arm_cspmu_disable_counter(cspmu, hwc->idx);
+	arm_cspmu_event_update(event);
+
+	hwc->state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
+}
+
+static inline u32 to_phys_idx(struct arm_cspmu *cspmu, u32 idx)
+{
+	return (idx == cspmu->cycle_counter_logical_idx) ?
+		ARM_CSPMU_CYCLE_CNTR_IDX : idx;
+}
+
+static int arm_cspmu_add(struct perf_event *event, int flags)
+{
+	struct arm_cspmu *cspmu = to_arm_cspmu(event->pmu);
+	struct arm_cspmu_hw_events *hw_events = &cspmu->hw_events;
+	struct hw_perf_event *hwc = &event->hw;
+	int idx;
+
+	if (WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(),
+					   &cspmu->associated_cpus)))
+		return -ENOENT;
+
+	idx = arm_cspmu_get_event_idx(hw_events, event);
+	if (idx < 0)
+		return idx;
+
+	hw_events->events[idx] = event;
+	hwc->idx = to_phys_idx(cspmu, idx);
+	hwc->extra_reg.idx = idx;
+	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
+
+	if (flags & PERF_EF_START)
+		arm_cspmu_start(event, PERF_EF_RELOAD);
+
+	/* Propagate changes to the userspace mapping. */
+	perf_event_update_userpage(event);
+
+	return 0;
+}
+
+static void arm_cspmu_del(struct perf_event *event, int flags)
+{
+	struct arm_cspmu *cspmu = to_arm_cspmu(event->pmu);
+	struct arm_cspmu_hw_events *hw_events = &cspmu->hw_events;
+	struct hw_perf_event *hwc = &event->hw;
+	int idx = hwc->extra_reg.idx;
+
+	arm_cspmu_stop(event, PERF_EF_UPDATE);
+
+	hw_events->events[idx] = NULL;
+
+	clear_bit(idx, hw_events->used_ctrs);
+
+	perf_event_update_userpage(event);
+}
+
+static void arm_cspmu_read(struct perf_event *event)
+{
+	arm_cspmu_event_update(event);
+}
+
+static struct arm_cspmu *arm_cspmu_alloc(struct platform_device *pdev)
+{
+	struct acpi_apmt_node *apmt_node;
+	struct arm_cspmu *cspmu;
+	struct device *dev;
+
+	dev = &pdev->dev;
+	apmt_node = *(struct acpi_apmt_node **)dev_get_platdata(dev);
+	if (!apmt_node) {
+		dev_err(dev, "failed to get APMT node\n");
+		return NULL;
+	}
+
+	cspmu = devm_kzalloc(dev, sizeof(*cspmu), GFP_KERNEL);
+	if (!cspmu)
+		return NULL;
+
+	cspmu->dev = dev;
+	cspmu->apmt_node = apmt_node;
+
+	platform_set_drvdata(pdev, cspmu);
+
+	return cspmu;
+}
+
+static int arm_cspmu_init_mmio(struct arm_cspmu *cspmu)
+{
+	struct device *dev;
+	struct platform_device *pdev;
+	struct acpi_apmt_node *apmt_node;
+
+	dev = cspmu->dev;
+	pdev = to_platform_device(dev);
+	apmt_node = cspmu->apmt_node;
+
+	/* Base address for page 0. */
+	cspmu->base0 = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(cspmu->base0)) {
+		dev_err(dev, "ioremap failed for page-0 resource\n");
+		return PTR_ERR(cspmu->base0);
+	}
+
+	/* Base address for page 1 if supported. Otherwise point to page 0. */
+	cspmu->base1 = cspmu->base0;
+	if (CHECK_APMT_FLAG(apmt_node->flags, DUAL_PAGE, SUPP)) {
+		cspmu->base1 = devm_platform_ioremap_resource(pdev, 1);
+		if (IS_ERR(cspmu->base1)) {
+			dev_err(dev, "ioremap failed for page-1 resource\n");
+			return PTR_ERR(cspmu->base1);
+		}
+	}
+
+	cspmu->pmcfgr = readl(cspmu->base0 + PMCFGR);
+
+	cspmu->num_logical_ctrs = FIELD_GET(PMCFGR_N, cspmu->pmcfgr) + 1;
+
+	cspmu->cycle_counter_logical_idx = ARM_CSPMU_MAX_HW_CNTRS;
+
+	if (supports_cycle_counter(cspmu)) {
+		/*
+		 * The last logical counter is mapped to cycle counter if
+		 * there is a gap between regular and cycle counter. Otherwise,
+		 * logical and physical have 1-to-1 mapping.
+		 */
+		cspmu->cycle_counter_logical_idx =
+			(cspmu->num_logical_ctrs <= ARM_CSPMU_CYCLE_CNTR_IDX) ?
+				cspmu->num_logical_ctrs - 1 :
+				ARM_CSPMU_CYCLE_CNTR_IDX;
+	}
+
+	cspmu->num_set_clr_reg =
+		DIV_ROUND_UP(cspmu->num_logical_ctrs,
+				ARM_CSPMU_SET_CLR_COUNTER_NUM);
+
+	cspmu->hw_events.events =
+		devm_kcalloc(dev, cspmu->num_logical_ctrs,
+			     sizeof(*cspmu->hw_events.events), GFP_KERNEL);
+
+	if (!cspmu->hw_events.events)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static inline int arm_cspmu_get_reset_overflow(struct arm_cspmu *cspmu,
+					       u32 *pmovs)
+{
+	int i;
+	u32 pmovclr_offset = PMOVSCLR;
+	u32 has_overflowed = 0;
+
+	for (i = 0; i < cspmu->num_set_clr_reg; ++i) {
+		pmovs[i] = readl(cspmu->base1 + pmovclr_offset);
+		has_overflowed |= pmovs[i];
+		writel(pmovs[i], cspmu->base1 + pmovclr_offset);
+		pmovclr_offset += sizeof(u32);
+	}
+
+	return has_overflowed != 0;
+}
+
+static irqreturn_t arm_cspmu_handle_irq(int irq_num, void *dev)
+{
+	int idx, has_overflowed;
+	struct perf_event *event;
+	struct arm_cspmu *cspmu = dev;
+	u32 pmovs[ARM_CSPMU_SET_CLR_MAX_NUM] = { 0 };
+	bool handled = false;
+
+	arm_cspmu_stop_counters(cspmu);
+
+	has_overflowed = arm_cspmu_get_reset_overflow(cspmu, pmovs);
+	if (!has_overflowed)
+		goto done;
+
+	for_each_set_bit(idx, cspmu->hw_events.used_ctrs,
+			cspmu->num_logical_ctrs) {
+		event = cspmu->hw_events.events[idx];
+
+		if (!event)
+			continue;
+
+		if (!test_bit(event->hw.idx, (unsigned long *)pmovs))
+			continue;
+
+		arm_cspmu_event_update(event);
+		arm_cspmu_set_event_period(event);
+
+		handled = true;
+	}
+
+done:
+	arm_cspmu_start_counters(cspmu);
+	return IRQ_RETVAL(handled);
+}
+
+static int arm_cspmu_request_irq(struct arm_cspmu *cspmu)
+{
+	int irq, ret;
+	struct device *dev;
+	struct platform_device *pdev;
+	struct acpi_apmt_node *apmt_node;
+
+	dev = cspmu->dev;
+	pdev = to_platform_device(dev);
+	apmt_node = cspmu->apmt_node;
+
+	/* Skip IRQ request if the PMU does not support overflow interrupt. */
+	if (apmt_node->ovflw_irq == 0)
+		return 0;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_irq(dev, irq, arm_cspmu_handle_irq,
+			       IRQF_NOBALANCING | IRQF_NO_THREAD, dev_name(dev),
+			       cspmu);
+	if (ret) {
+		dev_err(dev, "Could not request IRQ %d\n", irq);
+		return ret;
+	}
+
+	cspmu->irq = irq;
+
+	return 0;
+}
+
+static inline int arm_cspmu_find_cpu_container(int cpu, u32 container_uid)
+{
+	u32 acpi_uid;
+	struct device *cpu_dev = get_cpu_device(cpu);
+	struct acpi_device *acpi_dev = ACPI_COMPANION(cpu_dev);
+
+	if (!cpu_dev)
+		return -ENODEV;
+
+	while (acpi_dev) {
+		if (!strcmp(acpi_device_hid(acpi_dev),
+			    ACPI_PROCESSOR_CONTAINER_HID) &&
+		    !kstrtouint(acpi_device_uid(acpi_dev), 0, &acpi_uid) &&
+		    acpi_uid == container_uid)
+			return 0;
+
+		acpi_dev = acpi_dev->parent;
+	}
+
+	return -ENODEV;
+}
+
+static int arm_cspmu_get_cpus(struct arm_cspmu *cspmu)
+{
+	struct acpi_apmt_node *apmt_node;
+	int affinity_flag;
+	int cpu;
+
+	apmt_node = cspmu->apmt_node;
+	affinity_flag = apmt_node->flags & ACPI_APMT_FLAGS_AFFINITY;
+
+	if (affinity_flag == ACPI_APMT_FLAGS_AFFINITY_PROC) {
+		for_each_possible_cpu(cpu) {
+			if (apmt_node->proc_affinity ==
+			    get_acpi_id_for_cpu(cpu)) {
+				cpumask_set_cpu(cpu, &cspmu->associated_cpus);
+				break;
+			}
+		}
+	} else {
+		for_each_possible_cpu(cpu) {
+			if (arm_cspmu_find_cpu_container(
+				    cpu, apmt_node->proc_affinity))
+				continue;
+
+			cpumask_set_cpu(cpu, &cspmu->associated_cpus);
+		}
+	}
+
+	return 0;
+}
+
+static int arm_cspmu_register_pmu(struct arm_cspmu *cspmu)
+{
+	int ret;
+	struct attribute_group **attr_groups;
+
+	attr_groups = arm_cspmu_alloc_attr_group(cspmu);
+	if (!attr_groups)
+		return -ENOMEM;
+
+	ret = cpuhp_state_add_instance(arm_cspmu_cpuhp_state,
+				       &cspmu->cpuhp_node);
+	if (ret)
+		return ret;
+
+	cspmu->pmu = (struct pmu){
+		.task_ctx_nr	= perf_invalid_context,
+		.module		= THIS_MODULE,
+		.pmu_enable	= arm_cspmu_enable,
+		.pmu_disable	= arm_cspmu_disable,
+		.event_init	= arm_cspmu_event_init,
+		.add		= arm_cspmu_add,
+		.del		= arm_cspmu_del,
+		.start		= arm_cspmu_start,
+		.stop		= arm_cspmu_stop,
+		.read		= arm_cspmu_read,
+		.attr_groups	= (const struct attribute_group **)attr_groups,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
+	};
+
+	/* Hardware counter init */
+	arm_cspmu_stop_counters(cspmu);
+	arm_cspmu_reset_counters(cspmu);
+
+	ret = perf_pmu_register(&cspmu->pmu, cspmu->name, -1);
+	if (ret) {
+		cpuhp_state_remove_instance(arm_cspmu_cpuhp_state,
+					    &cspmu->cpuhp_node);
+	}
+
+	return ret;
+}
+
+static int arm_cspmu_device_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct arm_cspmu *cspmu;
+
+	cspmu = arm_cspmu_alloc(pdev);
+	if (!cspmu)
+		return -ENOMEM;
+
+	ret = arm_cspmu_init_mmio(cspmu);
+	if (ret)
+		return ret;
+
+	ret = arm_cspmu_request_irq(cspmu);
+	if (ret)
+		return ret;
+
+	ret = arm_cspmu_get_cpus(cspmu);
+	if (ret)
+		return ret;
+
+	ret = arm_cspmu_register_pmu(cspmu);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int arm_cspmu_device_remove(struct platform_device *pdev)
+{
+	struct arm_cspmu *cspmu = platform_get_drvdata(pdev);
+
+	perf_pmu_unregister(&cspmu->pmu);
+	cpuhp_state_remove_instance(arm_cspmu_cpuhp_state, &cspmu->cpuhp_node);
+
+	return 0;
+}
+
+static struct platform_driver arm_cspmu_driver = {
+	.driver = {
+			.name = DRVNAME,
+			.suppress_bind_attrs = true,
+		},
+	.probe = arm_cspmu_device_probe,
+	.remove = arm_cspmu_device_remove,
+};
+
+static void arm_cspmu_set_active_cpu(int cpu, struct arm_cspmu *cspmu)
+{
+	cpumask_set_cpu(cpu, &cspmu->active_cpu);
+	WARN_ON(irq_set_affinity(cspmu->irq, &cspmu->active_cpu));
+}
+
+static int arm_cspmu_cpu_online(unsigned int cpu, struct hlist_node *node)
+{
+	struct arm_cspmu *cspmu =
+		hlist_entry_safe(node, struct arm_cspmu, cpuhp_node);
+
+	if (!cpumask_test_cpu(cpu, &cspmu->associated_cpus))
+		return 0;
+
+	/* If the PMU is already managed, there is nothing to do */
+	if (!cpumask_empty(&cspmu->active_cpu))
+		return 0;
+
+	/* Use this CPU for event counting */
+	arm_cspmu_set_active_cpu(cpu, cspmu);
+
+	return 0;
+}
+
+static int arm_cspmu_cpu_teardown(unsigned int cpu, struct hlist_node *node)
+{
+	int dst;
+	struct cpumask online_supported;
+
+	struct arm_cspmu *cspmu =
+		hlist_entry_safe(node, struct arm_cspmu, cpuhp_node);
+
+	/* Nothing to do if this CPU doesn't own the PMU */
+	if (!cpumask_test_and_clear_cpu(cpu, &cspmu->active_cpu))
+		return 0;
+
+	/* Choose a new CPU to migrate ownership of the PMU to */
+	cpumask_and(&online_supported, &cspmu->associated_cpus,
+		    cpu_online_mask);
+	dst = cpumask_any_but(&online_supported, cpu);
+	if (dst >= nr_cpu_ids)
+		return 0;
+
+	/* Use this CPU for event counting */
+	perf_pmu_migrate_context(&cspmu->pmu, cpu, dst);
+	arm_cspmu_set_active_cpu(dst, cspmu);
+
+	return 0;
+}
+
+static int __init arm_cspmu_init(void)
+{
+	int ret;
+
+	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
+					"perf/arm/cspmu:online",
+					arm_cspmu_cpu_online,
+					arm_cspmu_cpu_teardown);
+	if (ret < 0)
+		return ret;
+	arm_cspmu_cpuhp_state = ret;
+	return platform_driver_register(&arm_cspmu_driver);
+}
+
+static void __exit arm_cspmu_exit(void)
+{
+	platform_driver_unregister(&arm_cspmu_driver);
+	cpuhp_remove_multi_state(arm_cspmu_cpuhp_state);
+}
+
+module_init(arm_cspmu_init);
+module_exit(arm_cspmu_exit);
diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h b/drivers/perf/arm_cspmu/arm_cspmu.h
new file mode 100644
index 000000000000..f1d7b2c9ade3
--- /dev/null
+++ b/drivers/perf/arm_cspmu/arm_cspmu.h
@@ -0,0 +1,151 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * ARM CoreSight Architecture PMU driver.
+ * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES.
+ *
+ */
+
+#ifndef __ARM_CSPMU_H__
+#define __ARM_CSPMU_H__
+
+#include <linux/acpi.h>
+#include <linux/bitfield.h>
+#include <linux/cpumask.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/perf_event.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
+
+#define to_arm_cspmu(p) (container_of(p, struct arm_cspmu, pmu))
+
+#define ARM_CSPMU_EXT_ATTR(_name, _func, _config)			\
+	(&((struct dev_ext_attribute[]){				\
+		{							\
+			.attr = __ATTR(_name, 0444, _func, NULL),	\
+			.var = (void *)_config				\
+		}							\
+	})[0].attr.attr)
+
+#define ARM_CSPMU_FORMAT_ATTR(_name, _config)				\
+	ARM_CSPMU_EXT_ATTR(_name, arm_cspmu_sysfs_format_show, (char *)_config)
+
+#define ARM_CSPMU_EVENT_ATTR(_name, _config)				\
+	PMU_EVENT_ATTR_ID(_name, arm_cspmu_sysfs_event_show, _config)
+
+
+/* Default event id mask */
+#define ARM_CSPMU_EVENT_MASK	GENMASK_ULL(63, 0)
+
+/* Default filter value mask */
+#define ARM_CSPMU_FILTER_MASK	GENMASK_ULL(63, 0)
+
+/* Default event format */
+#define ARM_CSPMU_FORMAT_EVENT_ATTR	\
+	ARM_CSPMU_FORMAT_ATTR(event, "config:0-32")
+
+/* Default filter format */
+#define ARM_CSPMU_FORMAT_FILTER_ATTR	\
+	ARM_CSPMU_FORMAT_ATTR(filter, "config1:0-31")
+
+/*
+ * This is the default event number for cycle count, if supported, since the
+ * ARM Coresight PMU specification does not define a standard event code
+ * for cycle count.
+ */
+#define ARM_CSPMU_EVT_CYCLES_DEFAULT	(0x1ULL << 32)
+
+/*
+ * The ARM Coresight PMU supports up to 256 event counters.
+ * If the counters are larger-than 32-bits, then the PMU includes at
+ * most 128 counters.
+ */
+#define ARM_CSPMU_MAX_HW_CNTRS		256
+
+/* The cycle counter, if implemented, is located at counter[31]. */
+#define ARM_CSPMU_CYCLE_CNTR_IDX	31
+
+/* PMIIDR register field */
+#define ARM_CSPMU_PMIIDR_IMPLEMENTER	GENMASK(11, 0)
+#define ARM_CSPMU_PMIIDR_PRODUCTID	GENMASK(31, 20)
+
+struct arm_cspmu;
+
+/* This tracks the events assigned to each counter in the PMU. */
+struct arm_cspmu_hw_events {
+	/* The events that are active on the PMU for a given logical index. */
+	struct perf_event **events;
+
+	/*
+	 * Each bit indicates a logical counter is being used (or not) for an
+	 * event. If cycle counter is supported and there is a gap between
+	 * regular and cycle counter, the last logical counter is mapped to
+	 * cycle counter. Otherwise, logical and physical have 1-to-1 mapping.
+	 */
+	DECLARE_BITMAP(used_ctrs, ARM_CSPMU_MAX_HW_CNTRS);
+};
+
+/* Contains ops to query vendor/implementer specific attribute. */
+struct arm_cspmu_impl_ops {
+	/* Get event attributes */
+	struct attribute **(*get_event_attrs)(const struct arm_cspmu *cspmu);
+	/* Get format attributes */
+	struct attribute **(*get_format_attrs)(const struct arm_cspmu *cspmu);
+	/* Get string identifier */
+	const char *(*get_identifier)(const struct arm_cspmu *cspmu);
+	/* Get PMU name to register to core perf */
+	const char *(*get_name)(const struct arm_cspmu *cspmu);
+	/* Check if the event corresponds to cycle count event */
+	bool (*is_cycle_counter_event)(const struct perf_event *event);
+	/* Decode event type/id from configs */
+	u32 (*event_type)(const struct perf_event *event);
+	/* Decode filter value from configs */
+	u32 (*event_filter)(const struct perf_event *event);
+	/* Hide/show unsupported events */
+	umode_t (*event_attr_is_visible)(struct kobject *kobj,
+					 struct attribute *attr, int unused);
+};
+
+/* Vendor/implementer descriptor. */
+struct arm_cspmu_impl {
+	u32 pmiidr;
+	struct arm_cspmu_impl_ops ops;
+	void *ctx;
+};
+
+/* Coresight PMU descriptor. */
+struct arm_cspmu {
+	struct pmu pmu;
+	struct device *dev;
+	struct acpi_apmt_node *apmt_node;
+	const char *name;
+	const char *identifier;
+	void __iomem *base0;
+	void __iomem *base1;
+	int irq;
+	cpumask_t associated_cpus;
+	cpumask_t active_cpu;
+	struct hlist_node cpuhp_node;
+
+	u32 pmcfgr;
+	u32 num_logical_ctrs;
+	u32 num_set_clr_reg;
+	int cycle_counter_logical_idx;
+
+	struct arm_cspmu_hw_events hw_events;
+
+	struct arm_cspmu_impl impl;
+};
+
+/* Default function to show event attribute in sysfs. */
+ssize_t arm_cspmu_sysfs_event_show(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf);
+
+/* Default function to show format attribute in sysfs. */
+ssize_t arm_cspmu_sysfs_format_show(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf);
+
+#endif /* __ARM_CSPMU_H__ */
-- 
2.17.1

