Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF44946E35D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 08:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbhLIHmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 02:42:17 -0500
Received: from mail-mw2nam08on2079.outbound.protection.outlook.com ([40.107.101.79]:14816
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233925AbhLIHmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 02:42:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jYzKpfC8jxxgvdgKza8QJvFylvkQYOxmddUob44qPoSsZ0ijzR+fc4zovXOaCrJg6371HpaYDco/HRPe4j7S5ANFQOC4FA5V8ssqm8bgAmI0xnwVyhBY7PC7W+3oM5aJI3utL5bEbvW0pq+YXonDadGHte7akzgNRHKLYmcFj6skTc4csRiIOxvR8sDhLkFop/ndhTAYD2BE4dmwIIE4fRYoHpCeLHtRcdqxXT9YZrk+DzeQUdo0kWP6yw/2Qu4x+BmP7BWnf8RTGbtpRph0ndm6bO47UMzTu95xI0VeOy/t199zuu37G/0kwOmZo21meH1RiBXmOV6UlcYmaeAujg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWJI1NWGTQab9INU/ee4SgvyVu4mwH+Z25jTeppM0E4=;
 b=PjedXKCqfpuX71xgsrpw2H33mUcyGVRrLfhTYfeXS4jUbjgMutk6Oypj07S/GJpqhDE1IJdiRPvDhV0HHSxBRt9CTol96y1JJNoPQO4qpA9row8Xt4UfE97fJKl9nZawVC1ZxPy9XnE6fkMrZVucT381TbRAGJxLB3iKYH5/FC3Xnjig4FO59R9hKjd+5CBw1Yu/4xQgzqqU4WAxL+eTbTBHU4k+FIAMCa4K2e1vneg1vp+bPyCXgbKLHCCeTwFLdMJJbfKhts4aKFJCS6wfg1jnvxhCoeH1qLVAHUx2/E80qhWjcfAeWop62SNUHrRYb/sIwSmVSXW2uSkYFWFBjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.12) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWJI1NWGTQab9INU/ee4SgvyVu4mwH+Z25jTeppM0E4=;
 b=fCsf9jNnLgIc7pHF06L8B28zN0tVm++rl5rAn+16n+IXD2gAvUKJwS9EdnAnmU2/iraYQxLqCiD1x+kf39D1T9/eEBWaR5b75CwKPD371ds05O2RsH7FoSpUx7qW/Y6eHIBdhvDVpM1TtbdKQqUITFSLMu4yzT9sJtTVDYi/uNauBi1FG+6HR50+AVgnSvxU3oPxYZhw4OPU1oQ+kWQb2lQaA8M+WaGJtFLLhJCVDZZhIlDRDyqIgI7vTAW8+LdguWjrIebrPLaXizRTGpi2rFBZP8FtmCkTX/2ia/Yx4MHtX8CgYbd3cEPysmMbJDwhw9Oe0jARojRB6tO3piCiBw==
Received: from CO1PR15CA0113.namprd15.prod.outlook.com (2603:10b6:101:21::33)
 by BN9PR12MB5066.namprd12.prod.outlook.com (2603:10b6:408:133::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.22; Thu, 9 Dec
 2021 07:38:33 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:21:cafe::fe) by CO1PR15CA0113.outlook.office365.com
 (2603:10b6:101:21::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend
 Transport; Thu, 9 Dec 2021 07:38:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.12)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.12; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.12) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Thu, 9 Dec 2021 07:38:32 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 07:38:27 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 07:38:25 +0000
Received: from Asurada-Nvidia.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 8 Dec 2021 23:38:25 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <thierry.reding@gmail.com>, <joro@8bytes.org>, <will@kernel.org>
CC:     <digetx@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 2/6] iommu/tegra-smmu: Rename tegra_smmu_find_group to tegra_smmu_find_group_soc
Date:   Wed, 8 Dec 2021 23:38:18 -0800
Message-ID: <20211209073822.26728-3-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211209073822.26728-1-nicolinc@nvidia.com>
References: <20211209073822.26728-1-nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2bbf8b17-8b21-4337-cd7b-08d9bae6e6e8
X-MS-TrafficTypeDiagnostic: BN9PR12MB5066:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB50668CD8EF4B427BAADFDE07AB709@BN9PR12MB5066.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5+kxLd74LIZ3cSDu1jmXAPrVlU4gHSH24XX9d5Dg+hzDVf0Fu3PWuQwy7XCPOxGt3IUMeL312xKU9e2dVbWdR2wbODLnAGQ8bJcL/kW1dW9i9GCytmH4jZa5lviaDKVLUAk5AVDLnxzQ6xBFH5RLgRfmC6ChXnemyc3kMfn/48VMf4TcWL+wGcGjBcxT7QindO+8IOwkfCo2A6QzanKjH9P0P2O5ZAgys6vK8fKc8S3n6dcRa0ry49YfjyNoon3qLjAV55PMR306GnpczGnQtDgP0oPGe55+Ko/7NRWwG+FHEYm0iAhbxEihXzV/UcBvCABTxx+4/OZhl3GximTy4YynakiB443IQPbpqSDCuPM4pTxWlutT8kiDLGEYW81q34GuQn82KrR7JwjWuVniBnNvJzGPZzJ35oOsS52mRCjGVIUxA4NRyKitEqMvT+E0qEYtfrzZK6gGZoMuFt3lPLw8TUalNbORA9EFGQWinqqGr35PmQWypjQEBA/+eljvO8HZSKwL4ohq+plLIufscuNZO6+OSi5j4BBc0xPqL4H5rxGuzXwCDAeeJjkKIBf1mEu1/5VHR+UCs7gg8IoSxYUWNpVCaO2/DDgyb3nhWUPvGe1f4X4bw4vpH6NCA7IHgRnH0CyI+2b0mpnBEnLcmx2HuW2ES2sVHg/2heCsQlkxXmjmmbMMa5WhoN1gaMnT9sxPyooWJd4O5GjJH1KYCIxtqa2Ot6fwZSpiXBTmxYFvCsTIgnfssRSW4Vd3KdDTlrojEXs+9mw0fxK3ECLRFkmRDCubXh79D+1sZyB1szQ=
X-Forefront-Antispam-Report: CIP:203.18.50.12;CTRY:HK;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:hkhybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(336012)(426003)(4326008)(2616005)(186003)(40460700001)(36756003)(70586007)(2906002)(8936002)(26005)(316002)(8676002)(70206006)(508600001)(86362001)(83380400001)(54906003)(110136005)(1076003)(47076005)(6666004)(36860700001)(5660300002)(7696005)(34070700002)(356005)(82310400004)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 07:38:32.1709
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bbf8b17-8b21-4337-cd7b-08d9bae6e6e8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[203.18.50.12];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5066
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing function tegra_smmu_find_group really finds group->soc
pointer, so naming it "find_group" might not be clear by looking at
it alone. This patch renames it to tegra_smmu_group_soc in order to
disambiguate the use of "group" in this driver.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/tegra-smmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index fd9ef08cb7d9..5628865c04b0 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -872,7 +872,7 @@ static struct iommu_device *tegra_smmu_probe_device(struct device *dev)
 static void tegra_smmu_release_device(struct device *dev) {}
 
 static const struct tegra_smmu_group_soc *
-tegra_smmu_find_group(struct tegra_smmu *smmu, unsigned int swgroup)
+tegra_smmu_find_group_soc(struct tegra_smmu *smmu, unsigned int swgroup)
 {
 	unsigned int i, j;
 
@@ -904,7 +904,7 @@ static struct iommu_group *tegra_smmu_device_group(struct device *dev)
 	struct iommu_group *grp;
 
 	/* Find group_soc associating with swgroup */
-	soc = tegra_smmu_find_group(smmu, swgroup);
+	soc = tegra_smmu_find_group_soc(smmu, swgroup);
 
 	mutex_lock(&smmu->lock);
 
-- 
2.17.1

