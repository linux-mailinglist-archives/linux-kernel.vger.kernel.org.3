Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCCB4E62F0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 13:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349882AbiCXMKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 08:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbiCXMKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 08:10:44 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A400F10FDA;
        Thu, 24 Mar 2022 05:09:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjlezoazQXiTxij9ZETb3oZONO8YF0BclFtzpXuQ6CEO/1G9Kc+ruzOvzD4/AnbvcUIYadO5Y3oWMGD8jvgasByJdsGtHneCSaawv6+88XAVIentu2ZGRQlyLcnrVsU5Hwn66tQmN90dFVsRoYqN3mt1ehyNH8S5QV5CH++/FHDiM449qszidJNDLyzsgF0Egd7qo4PevTWNake1gOfNJ3yaaXtF3wBMwWhGxm2tDTCJ9THFWH0oaswqgyXZ+oc2/ED0dG3v70z02gat8m0OrLxhTcDg86t6rO8rGYhXNuUH4Q89Cx6P6waslpgbtkazxP05vIB7VYCcCJCtojosoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRaptyOTkca0c2sHOQoHQ7Wm7twLFb0+2spIpFRJw2g=;
 b=nTus/XRQcX+dix0z9J1LL/I0zNFrI95QRVdLV8Koy6iaWTiGXl24bumvxBB/gtVJ4UQPiE71Ecz+lUVheYly6J1pHSxVNM3eoAn1MEQBvuhZS6lRatHF6TDLZUyPLUY2+5H74IcJUWVvOfXWHeI/AhEoBI5zvdYuQa9k88gjaFBXSpkwLcFWhgVUgTIa4urIGHO3WYz5X7CgKEgDVEVafkQ6TbSfpNJ7WP4ot0FQVkTjQELEN6dPLj4iTb+ali2NbMoYjoWPa3f3Fvbk/KRB3EjF+0ljF84TJKU52OuHACccPgd/fBCXv0JOw8i6OrVZsA6lAJ9Z7URnf6+c5tH4Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRaptyOTkca0c2sHOQoHQ7Wm7twLFb0+2spIpFRJw2g=;
 b=W+TFKfpKkXnm6iAB3sEoDKHBkq+sp4434qunvcBIvQ4ta4E/GzBk0tmiP7dGLsdrVTJ7R6cPwib2DMTzXlZKRssO2Q5vZomPFlP6e2OxWmpzwtpgIaXf+wMxboqCKsWSlLrGzucZdKBp9dzoqZ9CE7k5FO4lPv5Qdl+RAZROhw70YYibnC0Mp0SM7TCfHHMHn6SBvlYboAWKUjiIJAaYySGiN9jy5EBKHdl7DbmXIU+4bxErEjLsSddIHi22S/Rs2SRQ7Wg33EMGZO3oZSYXjh9mTQnAVYNiKZuhuQ2cs4KjkZIvvVxnYXq3UTMSZlXD6CFiXQ+8t+DdXakTE5kt6A==
Received: from BN9P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::26)
 by MN2PR12MB2912.namprd12.prod.outlook.com (2603:10b6:208:ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Thu, 24 Mar
 2022 12:09:10 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::77) by BN9P220CA0021.outlook.office365.com
 (2603:10b6:408:13e::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18 via Frontend
 Transport; Thu, 24 Mar 2022 12:09:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5102.17 via Frontend Transport; Thu, 24 Mar 2022 12:09:10 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 24 Mar
 2022 12:09:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 24 Mar
 2022 05:09:08 -0700
Received: from skamble-desk.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Thu, 24 Mar 2022 05:09:05 -0700
From:   Sagar Kamble <skamble@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <digetx@gmail.com>, <yangyingliang@huawei.com>,
        <ndesaulniers@google.com>, <pshete@nvidia.com>,
        <nathan@kernel.org>, <kkartik@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <skamble@nvidia.com>
Subject: [PATCH 1/1] soc/tegra: fuse: Add nvmem cell lookup entries for tegra194
Date:   Thu, 24 Mar 2022 17:38:48 +0530
Message-ID: <1648123728-16737-1-git-send-email-skamble@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 281733fa-db67-4727-be15-08da0d8f1a96
X-MS-TrafficTypeDiagnostic: MN2PR12MB2912:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB291291B53D26C5810BCF5129D7199@MN2PR12MB2912.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OH9iH5KkLitqw5KzmcJkZxBoD0i5QbjW6Luaei0xTrWNRBmaWB9rz/F+habspfQyb1jZdU1MvVpCa9nbIfgX6I2jaZN70IM48gsP6pnymAirvlia+qIMKtumUL9lblptESjXMFdTivOyPUFF/7tq4XKiBQE5NWLbvVoQwCXAoaPS35aYr7jr8ZdvGvJ43Mh8sjROxB23bDThyKhaacWmUfxb7biJfnN/NUkEBygK1hbPU82ZDjJzjopaYj00DhE8ObHTWZfOqaGCct2BZWo1ShKynw7s7gdCRqYzZmVYXrrSQeIy1WpsJa97FxuQgzhdx4BuDafrR7UUhNxtI1tQyQL/y6ThMC0AqX+t31n+81tT0C0HPBcCxpOzIgwCvA+c2xcYx4jdah209C/RBrI+qs0VefNDKkFCopnS2osqo0LvRAQEKWh8dTUp8rxfVWysZH+A6UAbJnwWA3jEuawitKm9ofLWl2sd0TgEEUwwnf2/UfpsIKG4RueikUGI7yXbks5joRKWcpxvLIKx8x+2+COZrsYESGNkX3FgII88fyxmkECS5TW+neih4Nr4RqcvmVgbyJSMjP7pn5UEs6+DhlWWxybmDlkiaE/KgON0XIy3lIxzCzjQlGDzmzqWZNzrWQtKPg/qJ3V0zMxf2K0iTJJiE8Ns/LOxuM63yWSqS6yHuCBq7QdAHbS04VWfU8zTF4gK9ZUDStcIkod2JQqXC4Vd5e0ezoA+cbzp4bqfZKc=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(508600001)(86362001)(36860700001)(8676002)(70586007)(70206006)(110136005)(82310400004)(316002)(47076005)(4326008)(83380400001)(40460700003)(7696005)(6666004)(2616005)(107886003)(426003)(336012)(186003)(356005)(921005)(26005)(81166007)(2906002)(5660300002)(8936002)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 12:09:10.2355
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 281733fa-db67-4727-be15-08da0d8f1a96
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2912
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nvmem cell lookup entries for below fuse cells:
 - gcplex-config-fuse
 - pdi0
 - pdi1

Also include the device name prefix "gpu-" in the names of the gpu fuse
cells in nvmem_cell_info.

Signed-off-by: Sagar Kamble <skamble@nvidia.com>
---
 drivers/soc/tegra/fuse/fuse-tegra.c   |  8 ++++----
 drivers/soc/tegra/fuse/fuse-tegra30.c | 17 ++++++++++++++++-
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index aa94fda282f4..b0a8405dbdb1 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2013-2021, NVIDIA CORPORATION.  All rights reserved.
+ * Copyright (c) 2013-2022, NVIDIA CORPORATION.  All rights reserved.
  */
 
 #include <linux/clk.h>
@@ -162,7 +162,7 @@ static const struct nvmem_cell_info tegra_fuse_cells[] = {
 		.bit_offset = 0,
 		.nbits = 32,
 	}, {
-		.name = "gcplex-config-fuse",
+		.name = "gpu-gcplex-config-fuse",
 		.offset = 0x1c8,
 		.bytes = 4,
 		.bit_offset = 0,
@@ -186,13 +186,13 @@ static const struct nvmem_cell_info tegra_fuse_cells[] = {
 		.bit_offset = 0,
 		.nbits = 32,
 	}, {
-		.name = "pdi0",
+		.name = "gpu-pdi0",
 		.offset = 0x300,
 		.bytes = 4,
 		.bit_offset = 0,
 		.nbits = 32,
 	}, {
-		.name = "pdi1",
+		.name = "gpu-pdi1",
 		.offset = 0x304,
 		.bytes = 4,
 		.bit_offset = 0,
diff --git a/drivers/soc/tegra/fuse/fuse-tegra30.c b/drivers/soc/tegra/fuse/fuse-tegra30.c
index b071d433d74f..f01d8a2547b6 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra30.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra30.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2013-2014, NVIDIA CORPORATION.  All rights reserved.
+ * Copyright (c) 2013-2022, NVIDIA CORPORATION.  All rights reserved.
  */
 
 #include <linux/device.h>
@@ -344,6 +344,21 @@ static const struct nvmem_cell_lookup tegra194_fuse_lookups[] = {
 		.cell_name = "xusb-pad-calibration-ext",
 		.dev_id = "3520000.padctl",
 		.con_id = "calibration-ext",
+	}, {
+		.nvmem_name = "fuse",
+		.cell_name = "gpu-gcplex-config-fuse",
+		.dev_id = "17000000.gpu",
+		.con_id = "gcplex-config-fuse",
+	}, {
+		.nvmem_name = "fuse",
+		.cell_name = "gpu-pdi0",
+		.dev_id = "17000000.gpu",
+		.con_id = "pdi0",
+	}, {
+		.nvmem_name = "fuse",
+		.cell_name = "gpu-pdi1",
+		.dev_id = "17000000.gpu",
+		.con_id = "pdi1",
 	},
 };
 
-- 
2.7.4

