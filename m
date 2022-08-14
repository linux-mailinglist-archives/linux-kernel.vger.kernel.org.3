Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A15A5925EE
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 20:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbiHNSYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 14:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiHNSYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 14:24:22 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81137186CE;
        Sun, 14 Aug 2022 11:24:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WfItz8B2LkfbmXbj326fAyU53/jws1/R4ivJVAyfbPO4r3mL5308yw7LIFwE8xK8SxfXQSeRQkWDMzEcZrI4PAIUzAuaTQsbd3fJgzxZQX8pd5+mr+xarYxv8cp4xa70xc02JWe4UCCxjht7uIWTB/KFPr9VgDEWrg/moY80RvG1pslaRQUaydlfTTuafj9eds0p8OE9xtqd2IaAKHyzDigOLwEA+1id8z5y6o+kj5VMSZNcQtoMx3YS2RuzrVIRnon3JsYp1Q6CwyRf6wO/Ic1yd5DkXnMLUrneyoD/aDCZzn+HoPPBgU2HckvjAvN8HNyioeY9uX9P/q6mvGQKCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzSwCJE7auqLh2wd0qHkisGW2LH3QZbLiffTsHY/eEo=;
 b=On+tCdiXC1WylLq0BQ1DwwIO9uxoKQmj1BLuebpk+FRJHnFTw8JMA706BPmawtmHCt0kaqQw1ywc0Y/r6gsz6R0Oje/aSlcU/8GoTy/kYYl5PDl+XdrcH9v7yqdAsIOhk3+2SySLqsMx6f5Ef0zosrIQCm/0ZwdNEP1AG6D6jZSKXlVFwy6L8Y8O6jB6Ws6Yl/MYPe3LlYG8G/gjkwG+TtJad5PB5HR6X19yU5I/qrNA2ePk4r++HfGq0Gqny54AuKskdjzJrmnHrPSrK1orKvbIW9X/UYSqa0Vra7f5f47eFUGcPcjjiV3X1ZQZuNNYfBdgm7JQt7j+kKJ/xQQ18g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzSwCJE7auqLh2wd0qHkisGW2LH3QZbLiffTsHY/eEo=;
 b=cU0PVv5PPLCdMCxifdd7KN9xsW9Mde+I/8HLqBFMlwqk6QNV7IRMaYNWSu7cFR0zRCEjQChWIEXpfEZp99a8w68NkgW+7VuNvt5laMxI5BFwbOs6EwebuBcG8YjneV/2bBDJZFFJ8kgy5UAlZfYaElVnG43vchhAmr7C9d7m4drC6SSUWz4Zy5j+kXBE9tU42UnXgUikq/bp7OGKok/h3yGTq/I2ND9pWCGAKvhpiTGpCw/grNzXutkt1vX6j9vVMoRwYt9JEjbN5Z5r7Hhi7Y25G3za/1YXUjo8nquy7PJ4YH8BNlegRbLpvs3aMGrYagFbQlfqTV3UPLpp9gjOgg==
Received: from MWH0EPF00056D0E.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:12) by MWHPR1201MB0221.namprd12.prod.outlook.com
 (2603:10b6:301:56::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Sun, 14 Aug
 2022 18:24:17 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::204) by MWH0EPF00056D0E.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.14 via Frontend
 Transport; Sun, 14 Aug 2022 18:24:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5525.11 via Frontend Transport; Sun, 14 Aug 2022 18:24:17 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.38; Sun, 14 Aug 2022 18:24:17 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Sun, 14 Aug 2022 11:24:16 -0700
Received: from msst-build.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Sun, 14 Aug 2022 11:24:15 -0700
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
Subject: [PATCH v4 0/2] perf: ARM CoreSight PMU support
Date:   Sun, 14 Aug 2022 13:23:49 -0500
Message-ID: <20220814182351.8861-1-bwicaksono@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ce8f7e4-3b1e-4bf1-2843-08da7e2232ec
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0221:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?leZ+OoB51MpURc3eY6CMSLmL3RQG/cpQN+nqUANfgtTE9XLfGGyNuKXmJfam?=
 =?us-ascii?Q?PURRTCSvjtkLxFqXtMMKBgGhOfO6VOzXT7q6PB/rBGh04vmsDHpRtGIGCyxw?=
 =?us-ascii?Q?schoTkJtNpRpiWOZMdvPz0RAkmrT5oVcGwqCrpvoWGqC3x23l5pw+t7WkMtH?=
 =?us-ascii?Q?BBaPnJMoUFD8Mh7aXdtuJVAqMQfgvOhCMuA1ISHLErPrkAg7g/9z8EYafLpp?=
 =?us-ascii?Q?WhAsXw+b1w4058j9cK3TODBqXTtxk0u7RbpS25mxs9uPMRuELcVQdP9cpFwX?=
 =?us-ascii?Q?2IxMgcn3DdLWiyHs3Fxz0/tbX0MefwYr7BNCl5C6KYI/u7SR5OaQa8w3GbQU?=
 =?us-ascii?Q?zqNRfh2ps5sVXB68zwTjaKT9Cv3aXGhU9bOpIh0bIjf3LIpVsHGAhM2r+kaS?=
 =?us-ascii?Q?eoT5BqbQkTVGKUbmlS6L+C8VXZdsaQzL7rRi6Xrbg0oA85F/AWS3lkKBrKJa?=
 =?us-ascii?Q?e9Bsu/GJ+08OZhlD05MGXke9cCg4e2aI+ki+7nfNJuy7Sf6d4yDJjZW41Hwz?=
 =?us-ascii?Q?IQ7uGHgNIg/gf4y2VTnu4rt4gLCQlZnPdCq2HhW4WxKW5OhlXWmTC5zR9rUK?=
 =?us-ascii?Q?8Ds6CcT6iecMVtXpbBMLCA7pHmhP1RvG/6pAO1vSSc3Po5jWHs6SQBr4YY5k?=
 =?us-ascii?Q?Z44zhxv1X33riGnoaQlzlqSZCkQXgWHLh5+0VOc3VQ/z/+Jy8xHpEaNHQ+8r?=
 =?us-ascii?Q?ojqIMXH2gTRpX4BkZKI5e6OWm754NHE+ddshYaDCsoe+g/loZJne3G4rdJPL?=
 =?us-ascii?Q?8vthh9rQN9sP1c81AD8CgQ32UGr37EkyVFxOEljkPeI0yZ1Ke9yThgc7ZPDP?=
 =?us-ascii?Q?AzfvcdBZtBctsxksvkUU3gAo5s9Jas/SDggu7fWL2FEmZCL+n54lEzDMfQmx?=
 =?us-ascii?Q?KHu1uD9mzgrOYL8A/jvfYLYN38fzEINuadwAaW3m//HNWObNIuuounaR6FFO?=
 =?us-ascii?Q?jS4+rj7JCnOIFZ5JPPusRA=3D=3D?=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(346002)(136003)(396003)(36840700001)(46966006)(40470700004)(186003)(36860700001)(86362001)(36756003)(107886003)(82740400003)(83380400001)(2616005)(426003)(7696005)(1076003)(356005)(81166007)(336012)(47076005)(6666004)(26005)(316002)(478600001)(54906003)(966005)(41300700001)(8936002)(5660300002)(110136005)(7416002)(40460700003)(8676002)(2906002)(70206006)(40480700001)(4326008)(82310400005)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2022 18:24:17.3578
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ce8f7e4-3b1e-4bf1-2843-08da7e2232ec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0221
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver support for ARM CoreSight PMU device and event attributes for NVIDIA
implementation. The code is based on ARM Coresight PMU architecture and ACPI ARM
Performance Monitoring Unit table (APMT) specification below:
 * ARM Coresight PMU:
        https://developer.arm.com/documentation/ihi0091/latest
 * APMT: https://developer.arm.com/documentation/den0117/latest

The patchset applies on top of
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  master next-20220524

For APMT support, please see patchset: https://lkml.org/lkml/2022/4/19/1395 

Changes from v3:
 * Driver is now probing "arm-cs-arch-pmu" device.
 * The driver files, directory, functions are renamed with "arm_cspmu" prefix.
 * Use Kconfig ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU.
 * Add kernel doc for NVIDIA Uncore PMU.
 * Use GENMASK and FIELD_GET macros everywhere.
Thanks to suzuki.poulose@arm.com and will@kernel.org for the review comments.
v3: https://lore.kernel.org/linux-arm-kernel/20220621055035.31766-1-bwicaksono@nvidia.com/

Changes from v2:
 * Driver is now probing "arm-system-pmu" device.
 * Change default PMU naming to "arm_<APMT node type>_pmu".
 * Add implementor ops to generate custom name.
Thanks to suzuki.poulose@arm.com for the review comments.
v2: https://lore.kernel.org/linux-arm-kernel/20220515163044.50055-1-bwicaksono@nvidia.com/

Changes from v1:
 * Remove CPU arch dependency.
 * Remove 32-bit read/write helper function and just use read/writel.
 * Add .is_visible into event attribute to filter out cycle counter event.
 * Update pmiidr matching.
 * Remove read-modify-write on PMCR since the driver only writes to PMCR.E.
 * Assign default cycle event outside the 32-bit PMEVTYPER range.
 * Rework the active event and used counter tracking.
Thanks to robin.murphy@arm.com for the review comments.
v1: https://lore.kernel.org/linux-arm-kernel/20220509002810.12412-1-bwicaksono@nvidia.com/

Besar Wicaksono (2):
  perf: arm_cspmu: Add support for ARM CoreSight PMU driver
  perf: arm_cspmu: Add support for NVIDIA SCF and MCF attribute

 Documentation/admin-guide/perf/index.rst      |    1 +
 Documentation/admin-guide/perf/nvidia-pmu.rst |  120 ++
 arch/arm64/configs/defconfig                  |    1 +
 drivers/perf/Kconfig                          |    2 +
 drivers/perf/Makefile                         |    1 +
 drivers/perf/arm_cspmu/Kconfig                |   13 +
 drivers/perf/arm_cspmu/Makefile               |    7 +
 drivers/perf/arm_cspmu/arm_cspmu.c            | 1269 +++++++++++++++++
 drivers/perf/arm_cspmu/arm_cspmu.h            |  151 ++
 drivers/perf/arm_cspmu/nvidia_cspmu.c         |  367 +++++
 drivers/perf/arm_cspmu/nvidia_cspmu.h         |   17 +
 11 files changed, 1949 insertions(+)
 create mode 100644 Documentation/admin-guide/perf/nvidia-pmu.rst
 create mode 100644 drivers/perf/arm_cspmu/Kconfig
 create mode 100644 drivers/perf/arm_cspmu/Makefile
 create mode 100644 drivers/perf/arm_cspmu/arm_cspmu.c
 create mode 100644 drivers/perf/arm_cspmu/arm_cspmu.h
 create mode 100644 drivers/perf/arm_cspmu/nvidia_cspmu.c
 create mode 100644 drivers/perf/arm_cspmu/nvidia_cspmu.h


base-commit: 09ce5091ff971cdbfd67ad84dc561ea27f10d67a
-- 
2.17.1

