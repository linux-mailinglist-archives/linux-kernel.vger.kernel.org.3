Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE68751F247
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 03:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbiEIBai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 21:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235214AbiEIAcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 20:32:54 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50AEB85C;
        Sun,  8 May 2022 17:29:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0+Op0yrkpp8Gx3CEoxwEw0YpFzCsZMLbrTVAIHoJsOs7ZDO4a7YD24x5aRhAMEznsmuhOCZvbjHEZ23mWaMcZ0MQ/jL9CnzfxMEtkGnShwDOLQj7N2heAC/EsfZnm87vlK++6mf9plQrMW/jhBwunCjJRxr9kAdZguLxmHQdyPiBAyTdcnEpH/wiU4/Pq2TNtUpsLcUIqSxs/fzIQNkG5qOETWhq/0hJTqn7RUUKWIvNmJiQPPzkBATHjP3xAhiSuy8Ze7KHD45UtbAwJerqRp75PpUX8RkIRI5bGBR0kDTqBd8olrTJnf6sqmgWgZFinAnUtITxZryWwrXUY+ttQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13AIc3CQvOTZWDXLqinyrlgZwBCqi9grFtJHt4VeWYs=;
 b=ggYGyKoinHhqCBKmxZbTI6fvclaiQWiHX9TMkKAQs+popHXFwVGVTy4zPRA7Pv3OR5kAc4nJWim1U+lwyiasF5ROdqklrbIXufrS4/C8hmkzk+R9M7VABU9Jd7K4jEvAkEqRQQSMVnYg25Asue/ETAb5NCxwvz+smMd67rtsHfcIdoCfYi09PzoGmxFgCg/wF1nf2kDoefpVoLu8ipPB3wfzZ0AcV80sfdanxe2RJxAzzbJ0PDm3GOvMg5YyaYhiszMxYDAvUMrfYS71Q/ZLWd5po1fhHEg81/GKp8nqEgFL2tPp8nchvL++r9Nj0o6aHM8wP1eFeQoit7QNLhBPmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13AIc3CQvOTZWDXLqinyrlgZwBCqi9grFtJHt4VeWYs=;
 b=jMEbjuIr7gyuJlJXJKbLdgEvQUWydUL2AgMh7OlnP4AQ/eBvNlf7Hu4fZ5ll1l46kjqiizLXke4Bp6tgD3bnuzFAROluT9bwmeXP7Ea13SkrJMdEahdwSLPFnX3IqYiaCGxSD8e/Llm0tsI2QBsa5ASbFfHu7MY1tKrKf4DYWmLHO5OAgBJm3GU0IEpgTeCe2HNF8Lvy/dX+7KHm0h8XuqSM2lREakS2DqoFfb1KtzJ4EDdgBKuEpnlv94ggctbiopPBjbtyRQEE3kXvnsXw799aDLzKR9/U7eHivGChSwTr+5MvYSq2izWPnkIhkqVGmF5nqaJX+T76tAKGGOwfpA==
Received: from DM6PR04CA0025.namprd04.prod.outlook.com (2603:10b6:5:334::30)
 by CO6PR12MB5489.namprd12.prod.outlook.com (2603:10b6:303:139::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Mon, 9 May
 2022 00:28:57 +0000
Received: from DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::e8) by DM6PR04CA0025.outlook.office365.com
 (2603:10b6:5:334::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Mon, 9 May 2022 00:28:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT038.mail.protection.outlook.com (10.13.173.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5227.15 via Frontend Transport; Mon, 9 May 2022 00:28:56 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Mon, 9 May 2022 00:28:56 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 8 May 2022 17:28:55 -0700
Received: from msst-build.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Sun, 8 May 2022 17:28:54 -0700
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <sudeep.holla@arm.com>, <thanu.rangarajan@arm.com>,
        <Michael.Williams@arm.com>, <suzuki.poulose@arm.com>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>
Subject: [PATCH 1/2] perf: coresight_pmu: Add support for ARM CoreSight PMU driver
Date:   Sun, 8 May 2022 19:28:09 -0500
Message-ID: <20220509002810.12412-2-bwicaksono@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220509002810.12412-1-bwicaksono@nvidia.com>
References: <20220509002810.12412-1-bwicaksono@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d05d48eb-1648-408d-2429-08da3152e79a
X-MS-TrafficTypeDiagnostic: CO6PR12MB5489:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB5489FE79C762CD8B74A830C6A0C69@CO6PR12MB5489.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JgLbcrnmeJYF0Pd3dtM2L+Q7/G3R/t5/zIj+nOHpYeI58+UdBSE6muvXp5lpAVM2Er9SI+nyohmx6dR9+cI20oj6liyzk1R38q2psMEe2OCTwbQxRR9BHnGy3RZJt3otYkNWTbDals2zTBdnhRhnNppJKjXzXGMuQkupnC+NmghRlqDdnsBhyizh9hF8kxYYZytC3CBZs0iSdbhrfRCWPexPCmLidbfXGNZwVCnwul2+nugb15RYb2rTIYgnp9rDt1uaVQf7y7oXOYG+Oz+n19posspoM3qkG9pRQVa3Kzy3bjGlIsoU6Y1J0xzVxHPLBUlxgVLUPIkqBZae/PyxU/jH2yOs8mCKdxQypOf6mt3XudTEO+CwhK0WuBh0SWrA7ntdjxE1CciKo6/JAEv3Os0yMZvf/+9K11EBGnQ+KYOT1gxPtKWxmtH5HZHmDRb17KjK9rP7IdSpznCGy+gZZ3lD3Wv+4L9nxjoaCBQxBs9Qwm/rMS6bmXgjtL+5X9hdsdgPHzxVQwwlBaGopC0s3xVXIL+s+sL/vSwVddUz/xYJI08yjrpYlUHdb25phHCC9Bt9td9hOvh/6Tw6frhNrC6uOJRwhqky77hjXqUreiSb5wL0a/GQ3h/oC4/1N3QReURKT3JSSlJh1OgeoCOKHGtj56i0ED/aSVSQDmiQp7uUa+FzigDlbB4kK5BkZafthE/BpM918GONq3fHgdqlBHW0ULldlmqtcrirX7h7yzz8HyLyMPQLcGBiIktXdVlNHf2xoJpShBcyRrT9K9CyfHk0sybbMcWptvKp1zxSDSq4khkN2fx3JH6BRyb9FrSAdOjN1oSBXFj5nDxLGHcdqA==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(1076003)(54906003)(36860700001)(36756003)(316002)(2616005)(110136005)(6666004)(426003)(186003)(47076005)(83380400001)(356005)(336012)(107886003)(82310400005)(40460700003)(86362001)(4326008)(8936002)(8676002)(81166007)(26005)(70586007)(70206006)(7696005)(30864003)(508600001)(2906002)(7416002)(966005)(5660300002)(36900700001)(579004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 00:28:56.7346
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d05d48eb-1648-408d-2429-08da3152e79a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5489
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 arch/arm64/configs/defconfig                  |    1 +
 drivers/perf/Kconfig                          |    2 +
 drivers/perf/Makefile                         |    1 +
 drivers/perf/coresight_pmu/Kconfig            |   10 +
 drivers/perf/coresight_pmu/Makefile           |    6 +
 .../perf/coresight_pmu/arm_coresight_pmu.c    | 1315 +++++++++++++++++
 .../perf/coresight_pmu/arm_coresight_pmu.h    |  147 ++
 7 files changed, 1482 insertions(+)
 create mode 100644 drivers/perf/coresight_pmu/Kconfig
 create mode 100644 drivers/perf/coresight_pmu/Makefile
 create mode 100644 drivers/perf/coresight_pmu/arm_coresight_pmu.c
 create mode 100644 drivers/perf/coresight_pmu/arm_coresight_pmu.h

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2ca8b1b336d2..8f2120182b25 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1196,6 +1196,7 @@ CONFIG_PHY_UNIPHIER_USB3=y
 CONFIG_PHY_TEGRA_XUSB=y
 CONFIG_PHY_AM654_SERDES=m
 CONFIG_PHY_J721E_WIZ=m
+CONFIG_ARM_CORESIGHT_PMU=y
 CONFIG_ARM_SMMU_V3_PMU=m
 CONFIG_FSL_IMX8_DDR_PMU=m
 CONFIG_QCOM_L2_PMU=y
diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 1e2d69453771..c4e7cd5b4162 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -192,4 +192,6 @@ config MARVELL_CN10K_DDR_PMU
 	  Enable perf support for Marvell DDR Performance monitoring
 	  event on CN10K platform.
 
+source "drivers/perf/coresight_pmu/Kconfig"
+
 endmenu
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index 57a279c61df5..4126a04b5583 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -20,3 +20,4 @@ obj-$(CONFIG_ARM_DMC620_PMU) += arm_dmc620_pmu.o
 obj-$(CONFIG_MARVELL_CN10K_TAD_PMU) += marvell_cn10k_tad_pmu.o
 obj-$(CONFIG_MARVELL_CN10K_DDR_PMU) += marvell_cn10k_ddr_pmu.o
 obj-$(CONFIG_APPLE_M1_CPU_PMU) += apple_m1_cpu_pmu.o
+obj-$(CONFIG_ARM_CORESIGHT_PMU) += coresight_pmu/
diff --git a/drivers/perf/coresight_pmu/Kconfig b/drivers/perf/coresight_pmu/Kconfig
new file mode 100644
index 000000000000..487dfee71ad1
--- /dev/null
+++ b/drivers/perf/coresight_pmu/Kconfig
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES.
+
+config ARM_CORESIGHT_PMU
+	tristate "ARM Coresight PMU"
+	depends on ARM64 && ACPI_APMT
+	help
+	  Provides support for Performance Monitoring Unit (PMU) events based on
+	  ARM CoreSight PMU architecture.
\ No newline at end of file
diff --git a/drivers/perf/coresight_pmu/Makefile b/drivers/perf/coresight_pmu/Makefile
new file mode 100644
index 000000000000..a2a7a5fbbc16
--- /dev/null
+++ b/drivers/perf/coresight_pmu/Makefile
@@ -0,0 +1,6 @@
+# Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES.
+#
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_ARM_CORESIGHT_PMU) += \
+	arm_coresight_pmu.o
diff --git a/drivers/perf/coresight_pmu/arm_coresight_pmu.c b/drivers/perf/coresight_pmu/arm_coresight_pmu.c
new file mode 100644
index 000000000000..1e9553d29717
--- /dev/null
+++ b/drivers/perf/coresight_pmu/arm_coresight_pmu.c
@@ -0,0 +1,1315 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ARM CoreSight PMU driver.
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
+ * The description of the PMU, like the PMU device identification, available
+ * events, and configuration options, is vendor specific. The driver provides
+ * interface for vendor specific code to get this information. This allows the
+ * driver to be shared with PMU from different vendors.
+ *
+ * CoreSight PMU devices are named as arm_coresight_pmu<node_id> where <node_id>
+ * is APMT node id. The description of the device, like the identifier,
+ * supported events, and formats can be found in sysfs
+ * /sys/bus/event_source/devices/arm_coresight_pmu<node_id>
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
+#include <linux/module.h>
+#include <linux/perf_event.h>
+#include <linux/platform_device.h>
+#include <acpi/processor.h>
+
+#include "arm_coresight_pmu.h"
+
+#define PMUNAME "arm_coresight_pmu"
+
+#define CORESIGHT_CPUMASK_ATTR(_name, _config)				\
+	CORESIGHT_EXT_ATTR(_name, coresight_pmu_cpumask_show,		\
+			   (unsigned long)_config)
+
+/**
+ * Register offsets based on CoreSight Performance Monitoring Unit Architecture
+ * Document number: ARM-ECM-0640169 00alp6
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
+#define PMCFGR_NCG_SHIFT				28
+#define PMCFGR_NCG_MASK					0xf
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
+#define PMCFGR_SIZE_SHIFT				8
+#define PMCFGR_SIZE_MASK				0x3f
+#define PMCFGR_N_SHIFT					0
+#define PMCFGR_N_MASK					0xff
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
+/* PMIIDR register field */
+#define PMIIDR_IMPLEMENTER_MASK				0xFFF
+#define PMIIDR_PRODUCTID_MASK				0xFFF
+#define PMIIDR_PRODUCTID_SHIFT				20
+
+/* Each SET/CLR register supports up to 32 counters. */
+#define CORESIGHT_SET_CLR_REG_COUNTER_NUM		32
+#define CORESIGHT_SET_CLR_REG_COUNTER_SHIFT		5
+
+/* The number of 32-bit SET/CLR register that can be supported. */
+#define CORESIGHT_SET_CLR_REG_MAX_NUM ((PMCNTENCLR - PMCNTENSET) / sizeof(u32))
+
+static_assert((CORESIGHT_SET_CLR_REG_MAX_NUM *
+	       CORESIGHT_SET_CLR_REG_COUNTER_NUM) >=
+	      CORESIGHT_PMU_MAX_HW_CNTRS);
+
+/* Convert counter idx into SET/CLR register number. */
+#define CORESIGHT_IDX_TO_SET_CLR_REG_ID(idx)				\
+	(idx >> CORESIGHT_SET_CLR_REG_COUNTER_SHIFT)
+
+/* Convert counter idx into SET/CLR register bit. */
+#define CORESIGHT_IDX_TO_SET_CLR_REG_BIT(idx)				\
+	(idx & (CORESIGHT_SET_CLR_REG_COUNTER_NUM - 1))
+
+#define CORESIGHT_ACTIVE_CPU_MASK			0x0
+#define CORESIGHT_ASSOCIATED_CPU_MASK			0x1
+
+#define CORESIGHT_EVENT_MASK				0xFFFFFFFFULL
+#define CORESIGHT_FILTER_MASK				0xFFFFFFFFULL
+#define CORESIGHT_FILTER_SHIFT				32ULL
+
+/* Check if field f in flags is set with value v */
+#define CHECK_APMT_FLAG(flags, f, v) \
+	((flags & (ACPI_APMT_FLAGS_ ## f)) == (ACPI_APMT_FLAGS_ ## f ## _ ## v))
+
+static unsigned long coresight_pmu_cpuhp_state;
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
+ * Read 32-bit register.
+ *
+ * @base    : base address of page-0 or page-1 if dual-page ext. is enabled.
+ * @offset  : register offset.
+ *
+ * @return 32-bit value of the register.
+ */
+static inline u32 read_reg32(void __iomem *base, u32 offset)
+{
+	return readl(base + offset);
+}
+
+/*
+ * Read 64-bit register using single 64-bit atomic copy.
+ *
+ * @base    : base address of page-0 or page-1 if dual-page ext. is enabled.
+ * @offset  : register offset.
+ *
+ * @return 64-bit value of the register.
+ */
+static u64 read_reg64(void __iomem *base, u32 offset)
+{
+	return readq(base + offset);
+}
+
+/*
+ * Read 64-bit register as a pair of 32-bit registers using hi-lo-hi sequence.
+ *
+ * @base    : base address of page-0 or page-1 if dual-page ext. is enabled.
+ * @offset  : register offset.
+ *
+ * @return 64-bit value of the register pair.
+ */
+static u64 read_reg64_hilohi(void __iomem *base, u32 offset)
+{
+	u32 val_lo, val_hi;
+	u64 val;
+
+	/* Use high-low-high sequence to avoid tearing */
+	do {
+		val_hi = read_reg32(base, offset + 4);
+		val_lo = read_reg32(base, offset);
+	} while (val_hi != read_reg32(base, offset + 4));
+
+	val = (((u64)val_hi << 32) | val_lo);
+
+	return val;
+}
+
+/*
+ * Write to 32-bit register.
+ *
+ * @val     : 32-bit value to write.
+ * @base    : base address of page-0 or page-1 if dual-page ext. is enabled.
+ * @offset  : register offset.
+ *
+ */
+static inline void write_reg32(u32 val, void __iomem *base, u32 offset)
+{
+	writel(val, base + offset);
+}
+
+/*
+ * Write to 64-bit register using single 64-bit atomic copy.
+ *
+ * @val     : 64-bit value to write.
+ * @base    : base address of page-0 or page-1 if dual-page ext. is enabled.
+ * @offset  : register offset.
+ *
+ */
+static void write_reg64(u64 val, void __iomem *base, u32 offset)
+{
+	writeq(val, base + offset);
+}
+
+/*
+ * Write to 64-bit register as a pair of 32-bit registers.
+ *
+ * @val     : 64-bit value to write.
+ * @base    : base address of page-0 or page-1 if dual-page ext. is enabled.
+ * @offset  : register offset.
+ *
+ */
+static void write_reg64_lohi(u64 val, void __iomem *base, u32 offset)
+{
+	u32 val_lo, val_hi;
+
+	val_hi = upper_32_bits(val);
+	val_lo = lower_32_bits(val);
+
+	write_reg32(val_lo, base, offset);
+	write_reg32(val_hi, base, offset + 4);
+}
+
+/* Check if cycle counter is supported. */
+static inline bool support_cc(const struct coresight_pmu *coresight_pmu)
+{
+	return (coresight_pmu->pmcfgr & PMCFGR_CC);
+}
+
+/* Get counter size. */
+static inline u32 pmcfgr_size(const struct coresight_pmu *coresight_pmu)
+{
+	return (coresight_pmu->pmcfgr >> PMCFGR_SIZE_SHIFT) & PMCFGR_SIZE_MASK;
+}
+
+/* Check if counter is implemented as 64-bit register. */
+static inline bool
+use_64b_counter_reg(const struct coresight_pmu *coresight_pmu)
+{
+	return (pmcfgr_size(coresight_pmu) > 31);
+}
+
+/* Get number of counters, minus one. */
+static inline u32 pmcfgr_n(const struct coresight_pmu *coresight_pmu)
+{
+	return (coresight_pmu->pmcfgr >> PMCFGR_N_SHIFT) & PMCFGR_N_MASK;
+}
+
+ssize_t coresight_pmu_sysfs_event_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct dev_ext_attribute *eattr =
+		container_of(attr, struct dev_ext_attribute, attr);
+	return sysfs_emit(buf, "event=0x%llx\n",
+			  (unsigned long long)eattr->var);
+}
+EXPORT_SYMBOL_GPL(coresight_pmu_sysfs_event_show);
+
+/**
+ * Event list of PMU that does not support cycle counter. Currently the
+ * CoreSight PMU spec does not define standard events, so it is empty now.
+ */
+static struct attribute *coresight_pmu_event_attrs[] = {
+	NULL,
+};
+
+/* Event list of PMU supporting cycle counter. */
+static struct attribute *coresight_pmu_event_attrs_cc[] = {
+	CORESIGHT_EVENT_ATTR(cycles, CORESIGHT_PMU_EVT_CYCLES_DEFAULT),
+	NULL,
+};
+
+struct attribute **
+coresight_pmu_get_event_attrs(const struct coresight_pmu *coresight_pmu)
+{
+	return (support_cc(coresight_pmu)) ? coresight_pmu_event_attrs_cc :
+					     coresight_pmu_event_attrs;
+}
+EXPORT_SYMBOL_GPL(coresight_pmu_get_event_attrs);
+
+ssize_t coresight_pmu_sysfs_format_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct dev_ext_attribute *eattr =
+		container_of(attr, struct dev_ext_attribute, attr);
+	return sysfs_emit(buf, "%s\n", (char *)eattr->var);
+}
+EXPORT_SYMBOL_GPL(coresight_pmu_sysfs_format_show);
+
+static struct attribute *coresight_pmu_format_attrs[] = {
+	CORESIGHT_FORMAT_ATTR(event, "config:0-31"),
+	CORESIGHT_FORMAT_ATTR(filter, "config:32-63"),
+	NULL,
+};
+
+struct attribute **
+coresight_pmu_get_format_attrs(const struct coresight_pmu *coresight_pmu)
+{
+	return coresight_pmu_format_attrs;
+}
+EXPORT_SYMBOL_GPL(coresight_pmu_get_format_attrs);
+
+u32 coresight_pmu_event_type(const struct perf_event *event)
+{
+	return event->attr.config & CORESIGHT_EVENT_MASK;
+}
+EXPORT_SYMBOL_GPL(coresight_pmu_event_type);
+
+u32 coresight_pmu_event_filter(const struct perf_event *event)
+{
+	return (event->attr.config >> CORESIGHT_FILTER_SHIFT) &
+	       CORESIGHT_FILTER_MASK;
+}
+EXPORT_SYMBOL_GPL(coresight_pmu_event_filter);
+
+static ssize_t coresight_pmu_identifier_show(struct device *dev,
+					     struct device_attribute *attr,
+					     char *page)
+{
+	struct coresight_pmu *coresight_pmu =
+		to_coresight_pmu(dev_get_drvdata(dev));
+
+	return sysfs_emit(page, "%s\n", coresight_pmu->identifier);
+}
+
+static struct device_attribute coresight_pmu_identifier_attr =
+	__ATTR(identifier, 0444, coresight_pmu_identifier_show, NULL);
+
+static struct attribute *coresight_pmu_identifier_attrs[] = {
+	&coresight_pmu_identifier_attr.attr,
+	NULL,
+};
+
+static struct attribute_group coresight_pmu_identifier_attr_group = {
+	.attrs = coresight_pmu_identifier_attrs,
+};
+
+const char *
+coresight_pmu_get_identifier(const struct coresight_pmu *coresight_pmu)
+{
+	const char *identifier =
+		devm_kasprintf(coresight_pmu->dev, GFP_KERNEL, "%x",
+			       coresight_pmu->impl.pmiidr);
+	return identifier;
+}
+EXPORT_SYMBOL_GPL(coresight_pmu_get_identifier);
+
+static ssize_t coresight_pmu_cpumask_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct pmu *pmu = dev_get_drvdata(dev);
+	struct coresight_pmu *coresight_pmu = to_coresight_pmu(pmu);
+	struct dev_ext_attribute *eattr =
+		container_of(attr, struct dev_ext_attribute, attr);
+	unsigned long mask_id = (unsigned long)eattr->var;
+	const cpumask_t *cpumask;
+
+	switch (mask_id) {
+	case CORESIGHT_ACTIVE_CPU_MASK:
+		cpumask = &coresight_pmu->active_cpu;
+		break;
+	case CORESIGHT_ASSOCIATED_CPU_MASK:
+		cpumask = &coresight_pmu->associated_cpus;
+		break;
+	default:
+		return 0;
+	}
+	return cpumap_print_to_pagebuf(true, buf, cpumask);
+}
+
+static struct attribute *coresight_pmu_cpumask_attrs[] = {
+	CORESIGHT_CPUMASK_ATTR(cpumask, CORESIGHT_ACTIVE_CPU_MASK),
+	CORESIGHT_CPUMASK_ATTR(associated_cpus, CORESIGHT_ASSOCIATED_CPU_MASK),
+	NULL,
+};
+
+static struct attribute_group coresight_pmu_cpumask_attr_group = {
+	.attrs = coresight_pmu_cpumask_attrs,
+};
+
+static const struct coresight_pmu_impl_ops default_impl_ops = {
+	.get_event_attrs	= coresight_pmu_get_event_attrs,
+	.get_format_attrs	= coresight_pmu_get_format_attrs,
+	.get_identifier		= coresight_pmu_get_identifier,
+	.is_cc_event		= coresight_pmu_is_cc_event,
+	.event_type		= coresight_pmu_event_type,
+	.event_filter		= coresight_pmu_event_filter
+};
+
+struct impl_match {
+	u32 jedec_jep106_id;
+	int (*impl_init_ops)(struct coresight_pmu *coresight_pmu);
+};
+
+static const struct impl_match impl_match[] = {
+	{}
+};
+
+static int coresight_pmu_init_impl_ops(struct coresight_pmu *coresight_pmu)
+{
+	int idx, ret;
+	u32 jedec_id;
+	struct acpi_apmt_node *apmt_node = coresight_pmu->apmt_node;
+	const struct impl_match *match = impl_match;
+
+	/*
+	 * Get PMU implementer and product id from APMT node.
+	 * If APMT node doesn't have implementer/product id, try get it
+	 * from PMIIDR.
+	 */
+	coresight_pmu->impl.pmiidr =
+		(apmt_node->impl_id) ? apmt_node->impl_id :
+				       read_reg32(coresight_pmu->base0, PMIIDR);
+
+	jedec_id = coresight_pmu->impl.pmiidr & PMIIDR_IMPLEMENTER_MASK;
+
+	/* Find implementer specific attribute ops. */
+	for (idx = 0; match->jedec_jep106_id; match++, idx++) {
+		if (match->jedec_jep106_id == jedec_id) {
+			ret = match->impl_init_ops(coresight_pmu);
+			if (ret)
+				return ret;
+
+			return 0;
+		}
+	}
+
+	/* We don't find implementer specific attribute ops, use default. */
+	coresight_pmu->impl.ops = &default_impl_ops;
+	return 0;
+}
+
+static struct attribute_group *
+coresight_pmu_alloc_event_attr_group(struct coresight_pmu *coresight_pmu)
+{
+	struct attribute_group *event_group;
+	struct device *dev = coresight_pmu->dev;
+
+	event_group =
+		devm_kzalloc(dev, sizeof(struct attribute_group), GFP_KERNEL);
+	if (!event_group)
+		return NULL;
+
+	event_group->name = "events";
+	event_group->attrs =
+		coresight_pmu->impl.ops->get_event_attrs(coresight_pmu);
+
+	return event_group;
+}
+
+static struct attribute_group *
+coresight_pmu_alloc_format_attr_group(struct coresight_pmu *coresight_pmu)
+{
+	struct attribute_group *format_group;
+	struct device *dev = coresight_pmu->dev;
+
+	format_group =
+		devm_kzalloc(dev, sizeof(struct attribute_group), GFP_KERNEL);
+	if (!format_group)
+		return NULL;
+
+	format_group->name = "format";
+	format_group->attrs =
+		coresight_pmu->impl.ops->get_format_attrs(coresight_pmu);
+
+	return format_group;
+}
+
+static struct attribute_group **
+coresight_pmu_alloc_attr_group(struct coresight_pmu *coresight_pmu)
+{
+	const struct coresight_pmu_impl_ops *impl_ops;
+	struct attribute_group **attr_groups = NULL;
+	struct device *dev = coresight_pmu->dev;
+	int ret;
+
+	ret = coresight_pmu_init_impl_ops(coresight_pmu);
+	if (ret)
+		return NULL;
+
+	impl_ops = coresight_pmu->impl.ops;
+
+	coresight_pmu->identifier = impl_ops->get_identifier(coresight_pmu);
+
+	attr_groups = devm_kzalloc(dev, 5 * sizeof(struct attribute_group *),
+				   GFP_KERNEL);
+	if (!attr_groups)
+		return NULL;
+
+	attr_groups[0] = coresight_pmu_alloc_event_attr_group(coresight_pmu);
+	attr_groups[1] = coresight_pmu_alloc_format_attr_group(coresight_pmu);
+	attr_groups[2] = &coresight_pmu_identifier_attr_group;
+	attr_groups[3] = &coresight_pmu_cpumask_attr_group;
+
+	return attr_groups;
+}
+
+static inline void
+coresight_pmu_start_counters(struct coresight_pmu *coresight_pmu)
+{
+	u32 pmcr;
+
+	pmcr = read_reg32(coresight_pmu->base0, PMCR);
+	pmcr |= PMCR_E;
+	write_reg32(pmcr, coresight_pmu->base0, PMCR);
+}
+
+static inline void
+coresight_pmu_stop_counters(struct coresight_pmu *coresight_pmu)
+{
+	u32 pmcr;
+
+	pmcr = read_reg32(coresight_pmu->base0, PMCR);
+	pmcr &= ~PMCR_E;
+	write_reg32(pmcr, coresight_pmu->base0, PMCR);
+}
+
+static void coresight_pmu_enable(struct pmu *pmu)
+{
+	int enabled;
+	struct coresight_pmu *coresight_pmu = to_coresight_pmu(pmu);
+
+	enabled = bitmap_weight(coresight_pmu->hw_events.used_ctrs,
+				CORESIGHT_PMU_MAX_HW_CNTRS);
+
+	if (!enabled)
+		return;
+
+	coresight_pmu_start_counters(coresight_pmu);
+}
+
+static void coresight_pmu_disable(struct pmu *pmu)
+{
+	struct coresight_pmu *coresight_pmu = to_coresight_pmu(pmu);
+
+	coresight_pmu_stop_counters(coresight_pmu);
+}
+
+static inline bool is_cycle_cntr_idx(const struct perf_event *event)
+{
+	struct coresight_pmu *coresight_pmu = to_coresight_pmu(event->pmu);
+	int idx = event->hw.idx;
+
+	return (support_cc(coresight_pmu) && idx == CORESIGHT_PMU_IDX_CCNTR);
+}
+
+bool coresight_pmu_is_cc_event(const struct perf_event *event)
+{
+	struct coresight_pmu *coresight_pmu = to_coresight_pmu(event->pmu);
+	u32 evtype = coresight_pmu->impl.ops->event_type(event);
+
+	return (support_cc(coresight_pmu) &&
+		evtype == CORESIGHT_PMU_EVT_CYCLES_DEFAULT);
+}
+EXPORT_SYMBOL_GPL(coresight_pmu_is_cc_event);
+
+static int
+coresight_pmu_get_event_idx(struct coresight_pmu_hw_events *hw_events,
+			    struct perf_event *event)
+{
+	int idx, reserve_cc;
+	struct coresight_pmu *coresight_pmu = to_coresight_pmu(event->pmu);
+
+	if (coresight_pmu->impl.ops->is_cc_event(event)) {
+		/* Search for available cycle counter. */
+		if (test_and_set_bit(CORESIGHT_PMU_IDX_CCNTR,
+				     hw_events->used_ctrs))
+			return -EAGAIN;
+
+		return CORESIGHT_PMU_IDX_CCNTR;
+	}
+
+	/*
+	 * CoreSight PMU can support up to 256 counters. The cycle counter is
+	 * always on counter[31]. To prevent regular event from using cycle
+	 * counter, we reserve the cycle counter bit temporarily.
+	 */
+	reserve_cc = 0;
+	if (support_cc(coresight_pmu) &&
+	    coresight_pmu->num_adj_counters >= CORESIGHT_PMU_IDX_CCNTR)
+		reserve_cc = (test_and_set_bit(CORESIGHT_PMU_IDX_CCNTR,
+					       hw_events->used_ctrs) == 0);
+
+	/* Search available regular counter from the used counter bitmap. */
+	idx = find_first_zero_bit(hw_events->used_ctrs,
+				  coresight_pmu->num_adj_counters);
+
+	/* Restore cycle counter bit. */
+	if (reserve_cc)
+		clear_bit(CORESIGHT_PMU_IDX_CCNTR, hw_events->used_ctrs);
+
+	if (idx >= coresight_pmu->num_adj_counters)
+		return -EAGAIN;
+
+	set_bit(idx, hw_events->used_ctrs);
+
+	return idx;
+}
+
+static bool
+coresight_pmu_validate_event(struct pmu *pmu,
+			     struct coresight_pmu_hw_events *hw_events,
+			     struct perf_event *event)
+{
+	if (is_software_event(event))
+		return true;
+
+	/* Reject groups spanning multiple HW PMUs. */
+	if (event->pmu != pmu)
+		return false;
+
+	return (coresight_pmu_get_event_idx(hw_events, event) >= 0);
+}
+
+/**
+ * Make sure the group of events can be scheduled at once
+ * on the PMU.
+ */
+static bool coresight_pmu_validate_group(struct perf_event *event)
+{
+	struct perf_event *sibling, *leader = event->group_leader;
+	struct coresight_pmu_hw_events fake_hw_events;
+
+	if (event->group_leader == event)
+		return true;
+
+	memset(&fake_hw_events, 0, sizeof(fake_hw_events));
+
+	if (!coresight_pmu_validate_event(event->pmu, &fake_hw_events, leader))
+		return false;
+
+	for_each_sibling_event(sibling, leader) {
+		if (!coresight_pmu_validate_event(event->pmu, &fake_hw_events,
+						  sibling))
+			return false;
+	}
+
+	return coresight_pmu_validate_event(event->pmu, &fake_hw_events, event);
+}
+
+static int coresight_pmu_event_init(struct perf_event *event)
+{
+	struct coresight_pmu *coresight_pmu;
+	struct hw_perf_event *hwc = &event->hw;
+
+	coresight_pmu = to_coresight_pmu(event->pmu);
+
+	/**
+	 * Following other "uncore" PMUs, we do not support sampling mode or
+	 * attach to a task (per-process mode).
+	 */
+	if (is_sampling_event(event)) {
+		dev_dbg(coresight_pmu->pmu.dev,
+			"Can't support sampling events\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (event->cpu < 0 || event->attach_state & PERF_ATTACH_TASK) {
+		dev_dbg(coresight_pmu->pmu.dev,
+			"Can't support per-task counters\n");
+		return -EINVAL;
+	}
+
+	/**
+	 * Make sure the CPU assignment is on one of the CPUs associated with
+	 * this PMU.
+	 */
+	if (!cpumask_test_cpu(event->cpu, &coresight_pmu->associated_cpus)) {
+		dev_dbg(coresight_pmu->pmu.dev,
+			"Requested cpu is not associated with the PMU\n");
+		return -EINVAL;
+	}
+
+	/* Enforce the current active CPU to handle the events in this PMU. */
+	event->cpu = cpumask_first(&coresight_pmu->active_cpu);
+	if (event->cpu >= nr_cpu_ids)
+		return -EINVAL;
+
+	if (!coresight_pmu_validate_group(event))
+		return -EINVAL;
+
+	/**
+	 * We don't assign an index until we actually place the event onto
+	 * hardware. Use -1 to signify that we haven't decided where to put it
+	 * yet.
+	 */
+	hwc->idx = -1;
+	hwc->config_base = coresight_pmu->impl.ops->event_type(event);
+
+	return 0;
+}
+
+static inline u32 counter_offset(u32 reg_sz, u32 ctr_idx)
+{
+	return (PMEVCNTR_LO + (reg_sz * ctr_idx));
+}
+
+static void coresight_pmu_write_counter(struct perf_event *event, u64 val)
+{
+	u32 offset;
+	struct coresight_pmu *coresight_pmu = to_coresight_pmu(event->pmu);
+
+	if (use_64b_counter_reg(coresight_pmu)) {
+		offset = counter_offset(sizeof(u64), event->hw.idx);
+
+		coresight_pmu->write_reg64(val, coresight_pmu->base1, offset);
+	} else {
+		offset = counter_offset(sizeof(u32), event->hw.idx);
+
+		write_reg32(lower_32_bits(val), coresight_pmu->base1, offset);
+	}
+}
+
+static u64 coresight_pmu_read_counter(struct perf_event *event)
+{
+	u32 offset;
+	struct coresight_pmu *coresight_pmu = to_coresight_pmu(event->pmu);
+
+	if (use_64b_counter_reg(coresight_pmu)) {
+		offset = counter_offset(sizeof(u64), event->hw.idx);
+		return coresight_pmu->read_reg64(coresight_pmu->base1, offset);
+	}
+
+	offset = counter_offset(sizeof(u32), event->hw.idx);
+	return read_reg32(coresight_pmu->base1, offset);
+}
+
+/**
+ * coresight_pmu_set_event_period: Set the period for the counter.
+ *
+ * To handle cases of extreme interrupt latency, we program
+ * the counter with half of the max count for the counters.
+ */
+static void coresight_pmu_set_event_period(struct perf_event *event)
+{
+	struct coresight_pmu *coresight_pmu = to_coresight_pmu(event->pmu);
+	u64 val = GENMASK_ULL(pmcfgr_size(coresight_pmu), 0) >> 1;
+
+	local64_set(&event->hw.prev_count, val);
+	coresight_pmu_write_counter(event, val);
+}
+
+static void coresight_pmu_enable_counter(struct coresight_pmu *coresight_pmu,
+					 int idx)
+{
+	u32 reg_id, reg_bit, inten_off, cnten_off;
+
+	reg_id = CORESIGHT_IDX_TO_SET_CLR_REG_ID(idx);
+	reg_bit = CORESIGHT_IDX_TO_SET_CLR_REG_BIT(idx);
+
+	inten_off = PMINTENSET + (4 * reg_id);
+	cnten_off = PMCNTENSET + (4 * reg_id);
+
+	write_reg32(BIT(reg_bit), coresight_pmu->base0, inten_off);
+	write_reg32(BIT(reg_bit), coresight_pmu->base0, cnten_off);
+}
+
+static void coresight_pmu_disable_counter(struct coresight_pmu *coresight_pmu,
+					  int idx)
+{
+	u32 reg_id, reg_bit, inten_off, cnten_off;
+
+	reg_id = CORESIGHT_IDX_TO_SET_CLR_REG_ID(idx);
+	reg_bit = CORESIGHT_IDX_TO_SET_CLR_REG_BIT(idx);
+
+	inten_off = PMINTENCLR + (4 * reg_id);
+	cnten_off = PMCNTENCLR + (4 * reg_id);
+
+	write_reg32(BIT(reg_bit), coresight_pmu->base0, cnten_off);
+	write_reg32(BIT(reg_bit), coresight_pmu->base0, inten_off);
+}
+
+static void coresight_pmu_event_update(struct perf_event *event)
+{
+	struct coresight_pmu *coresight_pmu = to_coresight_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	u64 delta, prev, now;
+
+	do {
+		prev = local64_read(&hwc->prev_count);
+		now = coresight_pmu_read_counter(event);
+	} while (local64_cmpxchg(&hwc->prev_count, prev, now) != prev);
+
+	delta = (now - prev) & GENMASK_ULL(pmcfgr_size(coresight_pmu), 0);
+	local64_add(delta, &event->count);
+}
+
+static inline void coresight_pmu_set_event(struct coresight_pmu *coresight_pmu,
+					   struct hw_perf_event *hwc)
+{
+	u32 offset = PMEVTYPER + (4 * hwc->idx);
+
+	write_reg32(hwc->config_base, coresight_pmu->base0, offset);
+}
+
+static inline void
+coresight_pmu_set_ev_filter(struct coresight_pmu *coresight_pmu,
+			    struct hw_perf_event *hwc, u32 filter)
+{
+	u32 offset = PMEVFILTR + (4 * hwc->idx);
+
+	write_reg32(filter, coresight_pmu->base0, offset);
+}
+
+static inline void
+coresight_pmu_set_cc_filter(struct coresight_pmu *coresight_pmu, u32 filter)
+{
+	u32 offset = PMCCFILTR;
+
+	write_reg32(filter, coresight_pmu->base0, offset);
+}
+
+static void coresight_pmu_start(struct perf_event *event, int pmu_flags)
+{
+	struct coresight_pmu *coresight_pmu = to_coresight_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	u32 filter;
+
+	/* We always reprogram the counter */
+	if (pmu_flags & PERF_EF_RELOAD)
+		WARN_ON(!(hwc->state & PERF_HES_UPTODATE));
+
+	coresight_pmu_set_event_period(event);
+
+	filter = coresight_pmu->impl.ops->event_filter(event);
+
+	if (is_cycle_cntr_idx(event)) {
+		coresight_pmu_set_cc_filter(coresight_pmu, filter);
+	} else {
+		coresight_pmu_set_event(coresight_pmu, hwc);
+		coresight_pmu_set_ev_filter(coresight_pmu, hwc, filter);
+	}
+
+	hwc->state = 0;
+
+	coresight_pmu_enable_counter(coresight_pmu, hwc->idx);
+}
+
+static void coresight_pmu_stop(struct perf_event *event, int pmu_flags)
+{
+	struct coresight_pmu *coresight_pmu = to_coresight_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (hwc->state & PERF_HES_STOPPED)
+		return;
+
+	coresight_pmu_disable_counter(coresight_pmu, hwc->idx);
+	coresight_pmu_event_update(event);
+
+	hwc->state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
+}
+
+static int coresight_pmu_add(struct perf_event *event, int flags)
+{
+	struct coresight_pmu *coresight_pmu = to_coresight_pmu(event->pmu);
+	struct coresight_pmu_hw_events *hw_events = &coresight_pmu->hw_events;
+	struct hw_perf_event *hwc = &event->hw;
+	int idx;
+
+	if (WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(),
+					   &coresight_pmu->associated_cpus)))
+		return -ENOENT;
+
+	idx = coresight_pmu_get_event_idx(hw_events, event);
+	if (idx < 0)
+		return idx;
+
+	hw_events->events[idx] = event;
+	hwc->idx = idx;
+	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
+
+	if (flags & PERF_EF_START)
+		coresight_pmu_start(event, PERF_EF_RELOAD);
+
+	/* Propagate changes to the userspace mapping. */
+	perf_event_update_userpage(event);
+
+	return 0;
+}
+
+static void coresight_pmu_del(struct perf_event *event, int flags)
+{
+	struct coresight_pmu *coresight_pmu = to_coresight_pmu(event->pmu);
+	struct coresight_pmu_hw_events *hw_events = &coresight_pmu->hw_events;
+	struct hw_perf_event *hwc = &event->hw;
+	int idx = hwc->idx;
+
+	coresight_pmu_stop(event, PERF_EF_UPDATE);
+
+	hw_events->events[idx] = NULL;
+
+	clear_bit(idx, hw_events->used_ctrs);
+
+	perf_event_update_userpage(event);
+}
+
+static void coresight_pmu_read(struct perf_event *event)
+{
+	coresight_pmu_event_update(event);
+}
+
+static int coresight_pmu_alloc(struct platform_device *pdev,
+			       struct coresight_pmu **coresight_pmu)
+{
+	struct acpi_apmt_node *apmt_node;
+	struct device *dev;
+	struct coresight_pmu *pmu;
+
+	dev = &pdev->dev;
+	apmt_node = *(struct acpi_apmt_node **)dev_get_platdata(dev);
+	if (!apmt_node) {
+		dev_err(dev, "failed to get APMT node\n");
+		return -ENOMEM;
+	}
+
+	pmu = devm_kzalloc(dev, sizeof(*pmu), GFP_KERNEL);
+	if (!pmu)
+		return -ENOMEM;
+
+	*coresight_pmu = pmu;
+
+	pmu->dev = dev;
+	pmu->apmt_node = apmt_node;
+	pmu->name =
+		devm_kasprintf(dev, GFP_KERNEL, PMUNAME "%u", apmt_node->id);
+
+	platform_set_drvdata(pdev, coresight_pmu);
+
+	return 0;
+}
+
+static int coresight_pmu_init_mmio(struct coresight_pmu *coresight_pmu)
+{
+	struct device *dev;
+	struct platform_device *pdev;
+	struct resource *res;
+	struct acpi_apmt_node *apmt_node;
+
+	dev = coresight_pmu->dev;
+	pdev = to_platform_device(dev);
+	apmt_node = coresight_pmu->apmt_node;
+
+	/* Base address for page 0. */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(dev, "failed to get page-0 resource\n");
+		return -ENOMEM;
+	}
+
+	coresight_pmu->base0 = devm_ioremap_resource(dev, res);
+	if (IS_ERR(coresight_pmu->base0)) {
+		dev_err(dev, "ioremap failed for page-0 resource\n");
+		return PTR_ERR(coresight_pmu->base0);
+	}
+
+	/* Base address for page 1 if supported. Otherwise point it to page 0. */
+	coresight_pmu->base1 = coresight_pmu->base0;
+	if (CHECK_APMT_FLAG(apmt_node->flags, DUAL_PAGE, SUPP)) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+		if (!res) {
+			dev_err(dev, "failed to get page-1 resource\n");
+			return -ENOMEM;
+		}
+
+		coresight_pmu->base1 = devm_ioremap_resource(dev, res);
+		if (IS_ERR(coresight_pmu->base1)) {
+			dev_err(dev, "ioremap failed for page-1 resource\n");
+			return PTR_ERR(coresight_pmu->base1);
+		}
+	}
+
+	if (CHECK_APMT_FLAG(apmt_node->flags, ATOMIC, SUPP)) {
+		coresight_pmu->read_reg64 = &read_reg64;
+		coresight_pmu->write_reg64 = &write_reg64;
+	} else {
+		coresight_pmu->read_reg64 = &read_reg64_hilohi;
+		coresight_pmu->write_reg64 = &write_reg64_lohi;
+	}
+
+	coresight_pmu->pmcfgr = read_reg32(coresight_pmu->base0, PMCFGR);
+
+	coresight_pmu->num_adj_counters = pmcfgr_n(coresight_pmu) + 1;
+
+	if (support_cc(coresight_pmu)) {
+		/**
+		 * Exclude the cycle counter if there is a gap between
+		 * cycle counter id and the last regular event counter id.
+		 */
+		if (coresight_pmu->num_adj_counters <= CORESIGHT_PMU_IDX_CCNTR)
+			coresight_pmu->num_adj_counters -= 1;
+	}
+
+	coresight_pmu->num_set_clr_reg =
+		round_up(coresight_pmu->num_adj_counters,
+			 CORESIGHT_SET_CLR_REG_COUNTER_NUM) /
+		CORESIGHT_SET_CLR_REG_COUNTER_NUM;
+
+	return 0;
+}
+
+static inline int
+coresight_pmu_get_reset_overflow(struct coresight_pmu *coresight_pmu,
+				 u32 *pmovs)
+{
+	int i;
+	u32 pmovclr_offset = PMOVSCLR;
+	u32 has_overflowed = 0;
+
+	for (i = 0; i < coresight_pmu->num_set_clr_reg; ++i) {
+		pmovs[i] = read_reg32(coresight_pmu->base1, pmovclr_offset);
+		has_overflowed |= pmovs[i];
+		write_reg32(pmovs[i], coresight_pmu->base1, pmovclr_offset);
+		pmovclr_offset += sizeof(u32);
+	}
+
+	return has_overflowed != 0;
+}
+
+static irqreturn_t coresight_pmu_handle_irq(int irq_num, void *dev)
+{
+	int idx, has_overflowed;
+	struct coresight_pmu *coresight_pmu = dev;
+	u32 pmovs[CORESIGHT_SET_CLR_REG_MAX_NUM] = { 0 };
+	bool handled = false;
+
+	coresight_pmu_stop_counters(coresight_pmu);
+
+	has_overflowed = coresight_pmu_get_reset_overflow(coresight_pmu, pmovs);
+	if (!has_overflowed)
+		goto done;
+
+	for_each_set_bit(idx, (unsigned long *)pmovs,
+			 CORESIGHT_PMU_MAX_HW_CNTRS) {
+		struct perf_event *event = coresight_pmu->hw_events.events[idx];
+
+		if (!event)
+			continue;
+
+		coresight_pmu_event_update(event);
+		coresight_pmu_set_event_period(event);
+
+		handled = true;
+	}
+
+done:
+	coresight_pmu_start_counters(coresight_pmu);
+	return IRQ_RETVAL(handled);
+}
+
+static int coresight_pmu_request_irq(struct coresight_pmu *coresight_pmu)
+{
+	int irq, ret;
+	struct device *dev;
+	struct platform_device *pdev;
+	struct acpi_apmt_node *apmt_node;
+
+	dev = coresight_pmu->dev;
+	pdev = to_platform_device(dev);
+	apmt_node = coresight_pmu->apmt_node;
+
+	/* Skip IRQ request if the PMU does not support overflow interrupt. */
+	if (apmt_node->ovflw_irq == 0)
+		return 0;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_irq(dev, irq, coresight_pmu_handle_irq,
+			       IRQF_NOBALANCING | IRQF_NO_THREAD, dev_name(dev),
+			       coresight_pmu);
+	if (ret) {
+		dev_err(dev, "Could not request IRQ %d\n", irq);
+		return ret;
+	}
+
+	coresight_pmu->irq = irq;
+
+	return 0;
+}
+
+static inline int coresight_pmu_find_cpu_container(int cpu, u32 container_uid)
+{
+	u32 acpi_uid;
+	struct device *cpu_dev = get_cpu_device(cpu);
+	struct acpi_device *acpi_dev = ACPI_COMPANION(cpu_dev);
+	int level = 0;
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
+		level++;
+	}
+
+	return -ENODEV;
+}
+
+static int coresight_pmu_get_cpus(struct coresight_pmu *coresight_pmu)
+{
+	struct acpi_apmt_node *apmt_node;
+	int affinity_flag;
+	int cpu;
+
+	apmt_node = coresight_pmu->apmt_node;
+	affinity_flag = apmt_node->flags & ACPI_APMT_FLAGS_AFFINITY;
+
+	if (affinity_flag == ACPI_APMT_FLAGS_AFFINITY_PROC) {
+		for_each_possible_cpu(cpu) {
+			if (apmt_node->proc_affinity ==
+			    get_acpi_id_for_cpu(cpu)) {
+				cpumask_set_cpu(
+					cpu, &coresight_pmu->associated_cpus);
+				break;
+			}
+		}
+	} else {
+		for_each_possible_cpu(cpu) {
+			if (coresight_pmu_find_cpu_container(
+				    cpu, apmt_node->proc_affinity))
+				continue;
+
+			cpumask_set_cpu(cpu, &coresight_pmu->associated_cpus);
+		}
+	}
+
+	return 0;
+}
+
+static int coresight_pmu_register_pmu(struct coresight_pmu *coresight_pmu)
+{
+	int ret;
+	struct attribute_group **attr_groups;
+
+	attr_groups = coresight_pmu_alloc_attr_group(coresight_pmu);
+	if (!attr_groups) {
+		ret = -ENOMEM;
+		return ret;
+	}
+
+	ret = cpuhp_state_add_instance(coresight_pmu_cpuhp_state,
+				       &coresight_pmu->cpuhp_node);
+	if (ret)
+		return ret;
+
+	coresight_pmu->pmu = (struct pmu){
+		.task_ctx_nr	= perf_invalid_context,
+		.module		= THIS_MODULE,
+		.pmu_enable	= coresight_pmu_enable,
+		.pmu_disable	= coresight_pmu_disable,
+		.event_init	= coresight_pmu_event_init,
+		.add		= coresight_pmu_add,
+		.del		= coresight_pmu_del,
+		.start		= coresight_pmu_start,
+		.stop		= coresight_pmu_stop,
+		.read		= coresight_pmu_read,
+		.attr_groups	= (const struct attribute_group **)attr_groups,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
+	};
+
+	ret = perf_pmu_register(&coresight_pmu->pmu, coresight_pmu->name, -1);
+	if (ret) {
+		cpuhp_state_remove_instance(coresight_pmu_cpuhp_state,
+					    &coresight_pmu->cpuhp_node);
+	}
+
+	return ret;
+}
+
+static int coresight_pmu_device_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct coresight_pmu *coresight_pmu;
+
+	ret = coresight_pmu_alloc(pdev, &coresight_pmu);
+	if (ret)
+		return ret;
+
+	ret = coresight_pmu_init_mmio(coresight_pmu);
+	if (ret)
+		return ret;
+
+	ret = coresight_pmu_request_irq(coresight_pmu);
+	if (ret)
+		return ret;
+
+	ret = coresight_pmu_get_cpus(coresight_pmu);
+	if (ret)
+		return ret;
+
+	ret = coresight_pmu_register_pmu(coresight_pmu);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int coresight_pmu_device_remove(struct platform_device *pdev)
+{
+	struct coresight_pmu *coresight_pmu = platform_get_drvdata(pdev);
+
+	perf_pmu_unregister(&coresight_pmu->pmu);
+	cpuhp_state_remove_instance(coresight_pmu_cpuhp_state,
+				    &coresight_pmu->cpuhp_node);
+
+	return 0;
+}
+
+static struct platform_driver coresight_pmu_driver = {
+	.driver = {
+			.name = "arm-coresight-pmu",
+			.suppress_bind_attrs = true,
+		},
+	.probe = coresight_pmu_device_probe,
+	.remove = coresight_pmu_device_remove,
+};
+
+static void coresight_pmu_set_active_cpu(int cpu,
+					 struct coresight_pmu *coresight_pmu)
+{
+	cpumask_set_cpu(cpu, &coresight_pmu->active_cpu);
+	WARN_ON(irq_set_affinity(coresight_pmu->irq,
+				 &coresight_pmu->active_cpu));
+}
+
+static int coresight_pmu_cpu_online(unsigned int cpu, struct hlist_node *node)
+{
+	struct coresight_pmu *coresight_pmu =
+		hlist_entry_safe(node, struct coresight_pmu, cpuhp_node);
+
+	if (!cpumask_test_cpu(cpu, &coresight_pmu->associated_cpus))
+		return 0;
+
+	/* If the PMU is already managed, there is nothing to do */
+	if (!cpumask_empty(&coresight_pmu->active_cpu))
+		return 0;
+
+	/* Use this CPU for event counting */
+	coresight_pmu_set_active_cpu(cpu, coresight_pmu);
+
+	return 0;
+}
+
+static int coresight_pmu_cpu_teardown(unsigned int cpu, struct hlist_node *node)
+{
+	int dst;
+	struct cpumask online_supported;
+
+	struct coresight_pmu *coresight_pmu =
+		hlist_entry_safe(node, struct coresight_pmu, cpuhp_node);
+
+	/* Nothing to do if this CPU doesn't own the PMU */
+	if (!cpumask_test_and_clear_cpu(cpu, &coresight_pmu->active_cpu))
+		return 0;
+
+	/* Choose a new CPU to migrate ownership of the PMU to */
+	cpumask_and(&online_supported, &coresight_pmu->associated_cpus,
+		    cpu_online_mask);
+	dst = cpumask_any_but(&online_supported, cpu);
+	if (dst >= nr_cpu_ids)
+		return 0;
+
+	/* Use this CPU for event counting */
+	perf_pmu_migrate_context(&coresight_pmu->pmu, cpu, dst);
+	coresight_pmu_set_active_cpu(dst, coresight_pmu);
+
+	return 0;
+}
+
+static int __init coresight_pmu_init(void)
+{
+	int ret;
+
+	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN, PMUNAME,
+				      coresight_pmu_cpu_online,
+				      coresight_pmu_cpu_teardown);
+	if (ret < 0)
+		return ret;
+	coresight_pmu_cpuhp_state = ret;
+	return platform_driver_register(&coresight_pmu_driver);
+}
+
+static void __exit coresight_pmu_exit(void)
+{
+	platform_driver_unregister(&coresight_pmu_driver);
+	cpuhp_remove_multi_state(coresight_pmu_cpuhp_state);
+}
+
+module_init(coresight_pmu_init);
+module_exit(coresight_pmu_exit);
diff --git a/drivers/perf/coresight_pmu/arm_coresight_pmu.h b/drivers/perf/coresight_pmu/arm_coresight_pmu.h
new file mode 100644
index 000000000000..59fb40eafe45
--- /dev/null
+++ b/drivers/perf/coresight_pmu/arm_coresight_pmu.h
@@ -0,0 +1,147 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * ARM CoreSight PMU driver.
+ * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES.
+ *
+ */
+
+#ifndef __ARM_CORESIGHT_PMU_H__
+#define __ARM_CORESIGHT_PMU_H__
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
+#define to_coresight_pmu(p) (container_of(p, struct coresight_pmu, pmu))
+
+#define CORESIGHT_EXT_ATTR(_name, _func, _config)			\
+	(&((struct dev_ext_attribute[]){				\
+		{							\
+			.attr = __ATTR(_name, 0444, _func, NULL),	\
+			.var = (void *)_config				\
+		}							\
+	})[0].attr.attr)
+
+#define CORESIGHT_FORMAT_ATTR(_name, _config)				\
+	CORESIGHT_EXT_ATTR(_name, coresight_pmu_sysfs_format_show,	\
+			   (char *)_config)
+
+#define CORESIGHT_EVENT_ATTR(_name, _config)				\
+	PMU_EVENT_ATTR_ID(_name, coresight_pmu_sysfs_event_show, _config)
+
+/**
+ * This is the default event number for cycle count, if supported, since the
+ * ARM Coresight PMU specification does not define a standard event code
+ * for cycle count.
+ */
+#define CORESIGHT_PMU_EVT_CYCLES_DEFAULT (0x1ULL << 31)
+
+/**
+ * The ARM Coresight PMU supports up to 256 event counters.
+ * If the counters are larger-than 32-bits, then the PMU includes at
+ * most 128 counters.
+ */
+#define CORESIGHT_PMU_MAX_HW_CNTRS 256
+
+/* The cycle counter, if implemented, is located at counter[31]. */
+#define CORESIGHT_PMU_IDX_CCNTR 31
+
+struct coresight_pmu;
+
+/* This tracks the events assigned to each counter in the PMU. */
+struct coresight_pmu_hw_events {
+	/* The events that are active on the PMU for the given index. */
+	struct perf_event *events[CORESIGHT_PMU_MAX_HW_CNTRS];
+
+	/* Each bit indicates a counter is being used (or not) for an event. */
+	DECLARE_BITMAP(used_ctrs, CORESIGHT_PMU_MAX_HW_CNTRS);
+};
+
+/* Contains ops to query vendor/implementer specific attribute. */
+struct coresight_pmu_impl_ops {
+	/* Get event attributes */
+	struct attribute **(*get_event_attrs)(
+		const struct coresight_pmu *coresight_pmu);
+	/* Get format attributes */
+	struct attribute **(*get_format_attrs)(
+		const struct coresight_pmu *coresight_pmu);
+	/* Get string identifier */
+	const char *(*get_identifier)(const struct coresight_pmu *coresight_pmu);
+	/* Check if the event corresponds to cycle count event */
+	bool (*is_cc_event)(const struct perf_event *event);
+	/* Decode event type/id from configs */
+	u32 (*event_type)(const struct perf_event *event);
+	/* Decode filter value from configs */
+	u32 (*event_filter)(const struct perf_event *event);
+};
+
+/* Vendor/implementer descriptor. */
+struct coresight_pmu_impl {
+	u32 pmiidr;
+	const struct coresight_pmu_impl_ops *ops;
+};
+
+/* Coresight PMU descriptor. */
+struct coresight_pmu {
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
+	u32 num_adj_counters;
+	u32 num_set_clr_reg;
+
+	struct coresight_pmu_hw_events hw_events;
+
+	void (*write_reg64)(u64 val, void __iomem *base, u32 offset);
+	u64 (*read_reg64)(void __iomem *base, u32 offset);
+
+	struct coresight_pmu_impl impl;
+};
+
+/* Default function to show event attribute in sysfs. */
+ssize_t coresight_pmu_sysfs_event_show(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf);
+
+/* Default function to show format attribute in sysfs. */
+ssize_t coresight_pmu_sysfs_format_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf);
+
+/* Get the default Coresight PMU event attributes. */
+struct attribute **
+coresight_pmu_get_event_attrs(const struct coresight_pmu *coresight_pmu);
+
+/* Get the default Coresight PMU format attributes. */
+struct attribute **
+coresight_pmu_get_format_attrs(const struct coresight_pmu *coresight_pmu);
+
+/* Get the default Coresight PMU device identifier. */
+const char *
+coresight_pmu_get_identifier(const struct coresight_pmu *coresight_pmu);
+
+/* Default function to query if an event is a cycle counter event. */
+bool coresight_pmu_is_cc_event(const struct perf_event *event);
+
+/* Default function to query the type/id of an event. */
+u32 coresight_pmu_event_type(const struct perf_event *event);
+
+/* Default function to query the filter value of an event. */
+u32 coresight_pmu_event_filter(const struct perf_event *event);
+
+#endif /* __ARM_CORESIGHT_PMU_H__ */
-- 
2.17.1

