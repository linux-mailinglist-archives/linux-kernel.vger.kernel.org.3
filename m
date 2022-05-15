Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0D45278C1
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 18:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237713AbiEOQb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 12:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237666AbiEOQbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 12:31:49 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592521A39C;
        Sun, 15 May 2022 09:31:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVOKXQfK4r8Qw11n7e2J2mgp0bYvazauZpzCbpmKfBfMORjOTw8x5CrI0SbHRtZ9l54zRjwwwWUgjS32azzezi3CVLBdn2bSvn37EmVmwsaxVB3pEJxC0175+SsGTUyJ5Am4BE32dU+pKGRmPCvfeCl9LBp541OAmvXLCTJ9cGg/GxCNMCVfVznbqDpk/q65Ge9LtGCnNvtwRUVXPbNlPto7Dfnh754Fz445IyIPTHxy97L6tFJVEPaOXKFfk7mj+iFnYOpt5aQULtpukyaxbmjls3kS9DmJFm+J6l266QzYJP7CNiTb3Y3Cn+5Gr3njE/P4y88RzHgXmzrfKs6b2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+aIHiFtfTUOr1WO0/P+DEFgEzQ7lmzRKpQOiLt5X98=;
 b=AgtErov10NTPPjzwJr2msmIAhRho1THVJ84/uMIvPK0PzD+C24hYuqWZcxLNiP6JNt0u3hinvDiPjt8cCL/FImawvIyWtOnYAU1xsNWrd48oIajw4LgfRzp29K8xU5bFmGqfNuWAblptw4xgxD+1PRqqpW54ylfAll4rGGr0+IICYs4troBgTQek49e1feNt6ao/lwx/cZB+8Fjcy9WgFAdCMVi9dfV+rTp0e1vFxccS/i6M7a+pC4A4GACGTZ/aWwdxZDfMqZMyaxObTJ8LbxgU2aH1stZrMxAG9qtpbvnU1mxLF0sVAcTAxpeZ8c8M98PAUkhOIFKUpEsE760stQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+aIHiFtfTUOr1WO0/P+DEFgEzQ7lmzRKpQOiLt5X98=;
 b=Wua7qOoaY/+RBFlGR5M33XUkgla/CyyKZqM476lwdGgj4Ux6oUQJ0NyUMg4flaTgxo3insJSuOa5fqTQP22dZ+dvsSbL2G/pP5AAeoGBsBFvmk/THc/ohUPSK6ePYeKQ3CVx+nxk93uGjWuMTOkZu/paAjdBcBOs7AtC8vmztbqocjYlWgKRywdUFULatjnLXVajFkTH83vyOEi+lloI/GJ8CTRRk2uSf/BjJmsFnC2KNa0+DByseLNHmcxzEETEaEne2mJO0yIucw4KtB28gHeEvSwqXHczLZWCrrd2kOF6KuaA3q4bXSUGRCOeoSq6iHmnhWfegM0ly/5v3B7UjQ==
Received: from DM6PR02CA0072.namprd02.prod.outlook.com (2603:10b6:5:177::49)
 by MWHPR12MB1373.namprd12.prod.outlook.com (2603:10b6:300:14::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Sun, 15 May
 2022 16:31:44 +0000
Received: from DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::fb) by DM6PR02CA0072.outlook.office365.com
 (2603:10b6:5:177::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21 via Frontend
 Transport; Sun, 15 May 2022 16:31:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT035.mail.protection.outlook.com (10.13.172.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5250.13 via Frontend Transport; Sun, 15 May 2022 16:31:44 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 DRHQMAIL101.nvidia.com (10.27.9.10) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Sun, 15 May 2022 16:31:35 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 15 May 2022 09:31:34 -0700
Received: from msst-build.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Sun, 15 May 2022 09:31:33 -0700
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     <robin.murphy@arm.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <sudeep.holla@arm.com>, <thanu.rangarajan@arm.com>,
        <Michael.Williams@arm.com>, <suzuki.poulose@arm.com>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>
Subject: [PATCH v2 0/2] perf: ARM CoreSight PMU support
Date:   Sun, 15 May 2022 11:30:42 -0500
Message-ID: <20220515163044.50055-1-bwicaksono@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220509002810.12412-1-bwicaksono@nvidia.com>
References: <20220509002810.12412-1-bwicaksono@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88d1a4ce-9363-4c15-5bd4-08da36906613
X-MS-TrafficTypeDiagnostic: MWHPR12MB1373:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1373EC6A94F5052BC529AA79A0CC9@MWHPR12MB1373.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ooiFPALhLq16GbPWZ3zPz9VfpQGi4ieetXJFvg7pVgLWUhPyiECncXZ+7xm8iz591nLP0zqq9lkHnHIdJUNKdsyJW5gGbx4wq1gt6KDlCddZK5+0DAl3yO72FMWFERucxy98TMndFp61yPg/yBNa74dwbnAgIqMm4dmiTJV4eFtYGvUFTI5w/CX5kSQJ0RL0ssm5gFGc3mW6vWhAZ0lihGWRJTsuf3j8KWf1MkqLb3zpKDMZtiPKcoldUdYUk1a0c/CTJtpbRELwqAr9ukQS/M/F0eaYI4G3mJWDQ0sU4du9BF3BvGkDhDvn/nRq2MABjbm81+MQnPjYQ4/1OoGtkI6vIKPdnnCRvJ0HOMzauDMCeE1kt9UPAcbVObN9u4L2KYJqXgn0MqiGK6eLZ2FQVKwinPi4flI0Jb3kYn9OQOnK73afgibxS1FfNI0zA+9z1vFSAm+LlkA87nitIbl7Y4OhOmihJFjJzbmmP4rfXMzJCzw+UV3kjBuAa/YMCjJNzdhZ7qQqrmNqLIbnB4EiKok042+Rl/Uz1DqFUtiCqkVEMfAofytJQHqhzkm6I0571D4vAHjnulso20KLPVMMz2ps70Nwn1aR47mvPaIkPudj77dNlx632pNxOp/h5xsPBdQmYPuQrgmiCGilQwLU4ZPKJqP4tUD0ALxh47JZrM+WJ6mMEbNWfXmlLjYh5dUOGOadg/j4kdF5j4549I/JgL6ivZSBPu+/nT1038ysMneqemIkAXq0srFoLMoBnzlsVqNpWZX3R9PTlhXyW2Emo/KY6rsziz5nr8X/rwonDbBcU7Rq+KDOlSyvxTh+SkS8Z7SVcTcAzn0l8CEbgthLAA==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(107886003)(4326008)(8676002)(81166007)(2616005)(2906002)(426003)(186003)(336012)(70206006)(70586007)(1076003)(82310400005)(36756003)(54906003)(36860700001)(966005)(508600001)(86362001)(7416002)(356005)(316002)(7696005)(40460700003)(83380400001)(6666004)(47076005)(110136005)(8936002)(26005)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2022 16:31:44.0675
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d1a4ce-9363-4c15-5bd4-08da36906613
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1373
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

Notes:
 * There is a concern on the naming of the PMU device.
   Currently the driver is probing "arm-coresight-pmu" device, however the APMT
   spec supports different kinds of CoreSight PMU based implementation. So it is
   open for discussion if the name can stay or a "generic" name is required.
   Please see the following thread:
   http://lists.infradead.org/pipermail/linux-arm-kernel/2022-May/740485.html

Changes from v1:
 * Remove CPU arch dependency.
 * Remove 32-bit read/write helper function and just use read/writel.
 * Add .is_visible into event attribute to filter out cycle counter event.
 * Update pmiidr matching.
 * Remove read-modify-write on PMCR since the driver only writes to PMCR.E.
 * Assign default cycle event outside the 32-bit PMEVTYPER range.
 * Rework the active event and used counter tracking.

Besar Wicaksono (2):
  perf: coresight_pmu: Add support for ARM CoreSight PMU driver
  perf: coresight_pmu: Add support for NVIDIA SCF and MCF attribute

 arch/arm64/configs/defconfig                  |    1 +
 drivers/perf/Kconfig                          |    2 +
 drivers/perf/Makefile                         |    1 +
 drivers/perf/coresight_pmu/Kconfig            |   11 +
 drivers/perf/coresight_pmu/Makefile           |    7 +
 .../perf/coresight_pmu/arm_coresight_pmu.c    | 1271 +++++++++++++++++
 .../perf/coresight_pmu/arm_coresight_pmu.h    |  171 +++
 .../coresight_pmu/arm_coresight_pmu_nvidia.c  |  292 ++++
 .../coresight_pmu/arm_coresight_pmu_nvidia.h  |   17 +
 9 files changed, 1773 insertions(+)
 create mode 100644 drivers/perf/coresight_pmu/Kconfig
 create mode 100644 drivers/perf/coresight_pmu/Makefile
 create mode 100644 drivers/perf/coresight_pmu/arm_coresight_pmu.c
 create mode 100644 drivers/perf/coresight_pmu/arm_coresight_pmu.h
 create mode 100644 drivers/perf/coresight_pmu/arm_coresight_pmu_nvidia.c
 create mode 100644 drivers/perf/coresight_pmu/arm_coresight_pmu_nvidia.h

-- 
2.17.1

