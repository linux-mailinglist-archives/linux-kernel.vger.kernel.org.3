Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFAD46954A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 12:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242759AbhLFL43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 06:56:29 -0500
Received: from mail-co1nam11on2061.outbound.protection.outlook.com ([40.107.220.61]:42896
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242675AbhLFL4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 06:56:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0Ktu9RNNb+XaWIORQYBwWL0oewflnIzdFSNHyD1Cdxxk1EODOdts9YXfexiHtZOVoQrs6wzs1Hu4lFgwgPodCH4DMzzj11mtttO0qLIGv6rg9I12XaYxIvTQhnTi+4iBC5DwirwCEzoxf1DGOXQaNxF0GQEEAa+NubXn9EgKLoOXHa73iL846N9Ckjt9Z1W56EnBzCptdVK3H9sLWlixhr8MdONZlbI1ATjZA7jvDiZvuA8eckL6sUvpfmrPpZ+Gjx3SUBHCdxECWJmrDM7USOqr0r3o6J2btRRMEml+rI85Nn5sA7a3K27cWtw7xJfpCvSjNWllSf8zISh0cxJ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ykWsmD3dWKbaro9WUEIp3HzzgipG05B8GLcabA6sRg=;
 b=SJh6LuKpau94zouZqrGIl95pQpwIxCA7updy2KFY2u7skjSjPuM0COdYZWUWwjayYX7DamG7nEk0pZmnpYjljFNgVfEOOn/OYW9h0/Obiamwx6rM6K/ustt4qQUlitoih9CfSl44Pkpjr/AR0k9a+sY+xU1x4kMoxZqwua7acF0KqgqGI0Sfk1sMMgsLbWZGeKHoUjNG/0ZWBgvFaToRiwwcST/ZRFeXm2naDBNQy0TvesDee0w4l4EPurPhpI2tBcnlY+C1983IEw+fQrr8/iJmrcyDvqDaKuLYkxbCDt9SZKY0vGlwPLf1FwUMeq9kkIPVBIp9B0GN2t+RYFzvmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ykWsmD3dWKbaro9WUEIp3HzzgipG05B8GLcabA6sRg=;
 b=bgVHQS5BlicLoRgRecoYi8LtFzc1apP2Wp2vw6qGMq5ke/4Etqaruu2Fic2MgKedhkGivyIm8MJ9M82KcKuf8JXqLreyls20jBothNGxMWGmvrdqRBkZnysjom1ELxXH35FpQQ7X5RlWYRvINHoJxPh3+iew19mMl8TTOq31o4CCxvOVlJqz2+UCO5PKe3f3K09BiH7jf9zxcHe6NxnWag9uUz7JwaAev0P4mR0V7XAY0Wd1jhiyFxFWJmENuaysNdWJ8WZS04+BymU8ErTQdpytfEFltSLpGIYelXMed+1OBMJmwPZnKq7UJ0Z7r5yN/4U8z51nlRWO0egduYuPZw==
Received: from BN9PR03CA0491.namprd03.prod.outlook.com (2603:10b6:408:130::16)
 by DM6PR12MB4043.namprd12.prod.outlook.com (2603:10b6:5:216::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Mon, 6 Dec
 2021 11:52:53 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::86) by BN9PR03CA0491.outlook.office365.com
 (2603:10b6:408:130::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Mon, 6 Dec 2021 11:52:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Mon, 6 Dec 2021 11:52:53 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 6 Dec
 2021 03:52:50 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 6 Dec
 2021 11:52:50 +0000
Received: from kkartik-desktop.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 6 Dec 2021 03:52:48 -0800
From:   Kartik <kkartik@nvidia.com>
To:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jonathanh@nvidia.com>, <thierry.reding@gmail.com>,
        <digetx@gmail.com>
CC:     <kkartik@nvidia.com>, <smangipudi@nvidia.com>, <pshete@nvidia.com>
Subject: [PATCH] soc/tegra: fuse: update nvmem cell list
Date:   Mon, 6 Dec 2021 17:22:45 +0530
Message-ID: <1638791565-3137-1-git-send-email-kkartik@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f1d3aec-827e-4c8f-85e8-08d9b8aeef9c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4043:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB40437248091967E77C5A82CCCD6D9@DM6PR12MB4043.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UTgx135uast9E1U0CkchRgm5p6SwvcXgC8bkaXCwPGLvBPFtNPcf5YcS91U/9CimfGmD/3cgwy1dCWrl5kDpDUe7BUvSa7FcqRmpc2mfSxik+zlXB2x9CRz6HGQd7oLoNxeZF1Ytt8pQAam7ZiK13HDSCXFaOqIsC8sAegmXUj0iX4HuBOtO1JE7n066TjVV7NOvIxNzD3n31qINMzmMCOIYuOnGcHQgKwS86iCj7pYLy/jL3lNI+T9quZxgoJEN2ubDIncxj3eM2SJM7AQqJU3JKjQYYCppQNMTinjE4eEIuKGPHX2snOnVIC1Kd7Af/16oks1WwK6EjPknBaHTqfWLrY6M/3M7mVT2CEcihSnaGFUHMMtcgRKrQI3d+5QGN9j+ONmmX5Gby0brp2IBki+jWa/99CuAI7HBHbdgLKLZQRdiv8ONFey1aRErqhp6SsT5rZaJ0ZAPAsQc9knMjRoZAFIpw6z+tT2fLHieYHjipijQ0th4VSH1VWRtL61e0OjT4T+QL6mhbvVx5Pu+v+6GpQje7tEg+/UeI9FCg8pWkKv5uvUA+BxVQk67IvNlgLa7PF7w6OEbjEk4upUNVM7+J4LndDRsPLwDY2uWCD4qVXraBj7fmJLXVQYPeLtNxJO7+4RSIs3yh7fbXmxgujyylOHFXy1fPWZ52HUBCU9P21vEUCI0aVDSYy9BFNjaiK2tJvUwtY5eKDSKyUCh7ezmDSkM0jnN10tvRfBHSw2L1eCmrCxzeirxtx/DiyW3v77wPYhG7RX77429MlomjQ==
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(54906003)(40460700001)(86362001)(36860700001)(7696005)(2616005)(2906002)(110136005)(107886003)(82310400004)(5660300002)(47076005)(356005)(4326008)(70206006)(8676002)(83380400001)(6666004)(7636003)(70586007)(26005)(508600001)(316002)(426003)(186003)(336012)(15650500001)(8936002)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 11:52:53.1750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f1d3aec-827e-4c8f-85e8-08d9b8aeef9c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4043
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kartik <kkartik@nvidia.com>

Update tegra_fuse_cells with below entries:
 - gcplex-config-fuse:
     Configuration bits for GPU, used to enable/disable write protected
     region used for storing GPU firmware.
 - pdi0:
     Unique per chip public identifier.
 - pdi1:
     Unique per chip public identifier.

Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
Signed-off-by: kartik <kkartik@nvidia.com>
---
 drivers/soc/tegra/fuse/fuse-tegra.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index f215181..c65252e 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2013-2014, NVIDIA CORPORATION.  All rights reserved.
+ * Copyright (c) 2013-2021, NVIDIA CORPORATION.  All rights reserved.
  */
 
 #include <linux/clk.h>
@@ -161,6 +161,12 @@ static const struct nvmem_cell_info tegra_fuse_cells[] = {
 		.bit_offset = 0,
 		.nbits = 32,
 	}, {
+		.name = "gcplex-config-fuse",
+		.offset = 0x1c8,
+		.bytes = 4,
+		.bit_offset = 0,
+		.nbits = 32,
+	}, {
 		.name = "tsensor-realignment",
 		.offset = 0x1fc,
 		.bytes = 4,
@@ -178,6 +184,18 @@ static const struct nvmem_cell_info tegra_fuse_cells[] = {
 		.bytes = 4,
 		.bit_offset = 0,
 		.nbits = 32,
+	}, {
+		.name = "pdi0",
+		.offset = 0x300,
+		.bytes = 4,
+		.bit_offset = 0,
+		.nbits = 32,
+	}, {
+		.name = "pdi1",
+		.offset = 0x304,
+		.bytes = 4,
+		.bit_offset = 0,
+		.nbits = 32,
 	},
 };
 
-- 
2.7.4

