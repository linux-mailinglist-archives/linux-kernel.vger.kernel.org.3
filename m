Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F6B51F225
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 03:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbiEIB2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 21:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235183AbiEIAcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 20:32:36 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96192B85C;
        Sun,  8 May 2022 17:28:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tw7XuYLZKLBCYELOja6phmWnCQI6Nc5GBvlSD0vMeFhK46LL7xRub49XmuizuT0JPzRWp46yy17udb5LZa3WOmdNU1n4ceka1u1BEmyRTFzwoqk2TGVH2Oj2vGp3snzLR6pafS+Z0O1DNUn5eKJQAwEHgf1wBPkLPN5pT9Od/cEAgqINoCmElS0G6g0sFZg6tiqDHzaDNZgjt171WZ7jN5iYacDC5foL6/3rY5jgi2j4yakA0t1JEehAOO1g6iphLR9hTyo1zaue8CEYPf+P+jMA1Du85luaybDQL0tx7R+S5o/gNPEWkBfljdcpqM7EDCbFC4zvgYQYpHd/oAVh7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JuwxCudIiRTuGqXH0tRCu2AbKeodtxo24H8b5MlSVeI=;
 b=ZAEKvRzhALW+ciDmQk+GVAFJ30yvN14w515yALkmCRysdIATMXiHAv7F+9GILOltLlYHbCnEzgBJtQiK/mGjbWQU93VPgh+fM/8JDhdtdsqfHlVMaQmJ3b36dWFwgFPPS1kJOVtq6Gi9kN8GufvPVGHmfcVIoYNnQLMbx1g5KXT+N+rVOSXlvebMnYxH6lIfUb2g2MorpdRZ4/gTeGh8kUV7GuhyVph4aFBjnwvY5eRXLowPtmIdPFmEb/D4tET7E/BkIMQJ/Zn8E98V4qu30S7H/ddVg2GzofdGqgDu2eDbOYcaS5sx+AtrQeKIZ3Um9JBL3+J41CRni3ctyYyy3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuwxCudIiRTuGqXH0tRCu2AbKeodtxo24H8b5MlSVeI=;
 b=QmNscfahd9/wiOfOv3hQJw0lWZ7ggTXmRnXSibLGnMzsQ7PWx1GDw8FAMq+qdk/2o7IuEb9FBtv0LhA+MZIW/jBxId7rmxbXmIf4CushYTcmAksMFTeV+F85I6IZfcU+pCQcsJNPK0igKuFoael41m5e5bXSu9Vz1ORUVX3Yc+CbJ9SJM3wGO5qmatPZxYbFumOoPbq48NJ5QLR9IbamH3+/77OeSs9tBJni7DHKMrhmfStcmk07n6DbQj7WVxG7sNJDCdP7WOup93TAcuAWhGlgBWU7DVAVblwNEH01b2wkKiSfZTDuyWdUpIFf7r6EypalWdJuiMw3OeC+4GLFEA==
Received: from BN8PR12CA0012.namprd12.prod.outlook.com (2603:10b6:408:60::25)
 by MW3PR12MB4507.namprd12.prod.outlook.com (2603:10b6:303:2c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Mon, 9 May
 2022 00:28:35 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::bd) by BN8PR12CA0012.outlook.office365.com
 (2603:10b6:408:60::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20 via Frontend
 Transport; Mon, 9 May 2022 00:28:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5227.15 via Frontend Transport; Mon, 9 May 2022 00:28:34 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL101.nvidia.com (10.27.9.10) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Mon, 9 May 2022 00:28:33 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 8 May 2022 17:28:32 -0700
Received: from msst-build.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Sun, 8 May 2022 17:28:32 -0700
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <sudeep.holla@arm.com>, <thanu.rangarajan@arm.com>,
        <Michael.Williams@arm.com>, <suzuki.poulose@arm.com>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>
Subject: [PATCH 0/2] perf: ARM CoreSight PMU support
Date:   Sun, 8 May 2022 19:28:08 -0500
Message-ID: <20220509002810.12412-1-bwicaksono@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f322b7b-3bd4-412b-e87a-08da3152da27
X-MS-TrafficTypeDiagnostic: MW3PR12MB4507:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB4507E8DB3537E2EE9F496ADDA0C69@MW3PR12MB4507.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6wearZA25Jur+1HEWv4FNZP7bE/HFmI49Dd32Pj9K6MSTv3rDy3JEVzWV2EwS+iZ3YIIFxzPo/k92n7xXOKdpvMFgaHy3oEES4lmEdBNK7rC4HI0FIwRgJ6+x6t35JS6YHiJVGoLQXlBGJilb9tveIkXjNpWJU5EurAI4j1Z6j7V6VaYqKpDdv5sdlrZh+fN0FVmk47guQWlBM6vpKG53gQ6ahUgeIBVa8C1AfQ5ASZIlcEEV+Ac7rkxUr/i5sl7ioQGkCF1fXq5uiDbdeFN1mht+/QFLL7nKM7YdNceFk/kHKFTO75DGjufP44Gn2ruYp5YtxzWo/zYmvL/KJ6YbpRGAM+NdfQGtrjigneQcQmjTuhJrgy3LkkBeyy439o0jU3c6M8fNpIj64m4+S24yWGsm4Cv6L/xHfV0yZkuOOh2SOm9CBNuM2pKC9LPKkKEqw8/1ydOI+KBmhFXc1CqiP5YzdWf+8+VTwpXJFXrYlDI+uoYJk1eepTDP8Ptw3rr97/TtWtgt4YT3/s+pvnwR2jTvfKUG2MzY0NkuGGdSTBoz/waMs4GsiJrKvGnAYOewfSW/a03qKtZnbhJBVioocXnMX/MsC6lPQe8Hge5eoZusssuQY8xC/lmk034XEnb3+9IXnlZXyp05dMLD1oyMV0fghHlm/mVaSxEXCRp+rWnquOtzpf0c9HIL9PIUbBSiQ4W7dxk7cEcXxqkVpe469Qt8Rh+BFgLAzcnVxMEWAqV/j/+GG/fXS4tevVo0QhrP6k9bBK+FTqgAKuc8xp46b5umeC1B3XrXu9dFvrHC/II2XFCQ5DU4WuZharl0qlUxvPEG3a3NEV6bZTYytjxcw==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(1076003)(54906003)(36860700001)(36756003)(316002)(2616005)(110136005)(6666004)(426003)(186003)(47076005)(356005)(336012)(107886003)(82310400005)(40460700003)(86362001)(4326008)(8936002)(8676002)(81166007)(26005)(70586007)(70206006)(7696005)(508600001)(2906002)(7416002)(966005)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 00:28:34.1911
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f322b7b-3bd4-412b-e87a-08da3152da27
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4507
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Besar Wicaksono (2):
  perf: coresight_pmu: Add support for ARM CoreSight PMU driver
  perf: coresight_pmu: Add support for NVIDIA SCF and MCF attribute

 arch/arm64/configs/defconfig                  |    1 +
 drivers/perf/Kconfig                          |    2 +
 drivers/perf/Makefile                         |    1 +
 drivers/perf/coresight_pmu/Kconfig            |   10 +
 drivers/perf/coresight_pmu/Makefile           |    7 +
 .../perf/coresight_pmu/arm_coresight_pmu.c    | 1317 +++++++++++++++++
 .../perf/coresight_pmu/arm_coresight_pmu.h    |  147 ++
 .../coresight_pmu/arm_coresight_pmu_nvidia.c  |  300 ++++
 .../coresight_pmu/arm_coresight_pmu_nvidia.h  |   17 +
 9 files changed, 1802 insertions(+)
 create mode 100644 drivers/perf/coresight_pmu/Kconfig
 create mode 100644 drivers/perf/coresight_pmu/Makefile
 create mode 100644 drivers/perf/coresight_pmu/arm_coresight_pmu.c
 create mode 100644 drivers/perf/coresight_pmu/arm_coresight_pmu.h
 create mode 100644 drivers/perf/coresight_pmu/arm_coresight_pmu_nvidia.c
 create mode 100644 drivers/perf/coresight_pmu/arm_coresight_pmu_nvidia.h

-- 
2.17.1

