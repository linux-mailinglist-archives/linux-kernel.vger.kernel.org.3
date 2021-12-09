Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8D346E35F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 08:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbhLIHmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 02:42:23 -0500
Received: from mail-mw2nam10on2062.outbound.protection.outlook.com ([40.107.94.62]:43808
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233933AbhLIHmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 02:42:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWiegKCrAnVjvEz19NmVCm8uTLU+BbeKYuFyFf0BJgmaUZ5addK5mdjsEJF2zJ4yckrMchqSGESWj7VippNbWHtOLE2QzI0zqJdttTi/rl1AB84I+rgfmfSeiZH9AwAAWJg6aOZlcKC8KVTgNBcZ2ESPi++DzdjQO9AZq4N2TKJO2TC4GLwvVHdo6CxkCySGltXELROIh2FgFVkWT5DHNyrTF5C4FrpvwNWK3NrafXFpyyIEyUCYI0zDiTTXXP3y/VnYXKpFmRPM/i3+B53p//3SOrQYuNNhlhhzxqWDHoNDyBYJ96lWJyG+tUgG8IAMgMsnUE6uAC8W+Hr/VPbqHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOTG1d4rBvNLhhTcrp32ba9Ys0WCtNwL+lBBmHhb/kQ=;
 b=KnypXvOhkV2Sf45P0DYmEM8FBfglvpy+ETcS8t3sTd5flr4QwqJHYhioER6xgbWJ950SGZyLyCVnwaO73G4K4k9o5CjzFUf6fTo3XXZKofeDgyjzGGoe0FTX82USnWZgHJqOWE3EpsDe4AJUDm3pXAeTI6IwI1RedupiA5OKzRkjEKT+czd4MpZCGRvvXCOh50ekMRhda9TTjX5rnANRXHdQRZBXM5XasFrW47cp0Vru8t6yX527bCAqUdnj+6xw6b+0by9BF1Da4Uasa+48SgxW/rVlIRanoqm4ncUlK35UWjT1iEBojU5jYBLUxmg7qd43OJFoRTI49uEPUQz7AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.12) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOTG1d4rBvNLhhTcrp32ba9Ys0WCtNwL+lBBmHhb/kQ=;
 b=g9H2uRV/6X+7OZf08ehbZkUtswwQr0Bvb1kUDXMg9q0qE3vfc1pS+kikfV42C/dYgO3gFhjf1RgohfwwUGhlzOGfxEeHw4DiR1zAjhwSELCeuG5TeuU5rBS1aNh0UMpYNWu7OH1Gz9CB1HAvRssDiZf1v51dxHyayIC0yUaKtowNU0fLcHwHpIm9T/XuagW4XbGbZQ5qvjJeBv/wvn2unTsKN0JxM6Kn+bQh//pmdI+IHecQEDFsNwi3M0JRnk21erhIw9aJlWZp7SfqBiclYj/J6f0DbW0TYnKk7/OIPR1s+zi2A+7pjl0RmXFtv6RE/li+/YCMPyNQcss40Uciyg==
Received: from CO1PR15CA0106.namprd15.prod.outlook.com (2603:10b6:101:21::26)
 by BY5PR12MB3683.namprd12.prod.outlook.com (2603:10b6:a03:1a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Thu, 9 Dec
 2021 07:38:34 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:21:cafe::9f) by CO1PR15CA0106.outlook.office365.com
 (2603:10b6:101:21::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.22 via Frontend
 Transport; Thu, 9 Dec 2021 07:38:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.12)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.12; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.12) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Thu, 9 Dec 2021 07:38:33 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 07:38:27 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 07:38:27 +0000
Received: from Asurada-Nvidia.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 8 Dec 2021 23:38:26 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <thierry.reding@gmail.com>, <joro@8bytes.org>, <will@kernel.org>
CC:     <digetx@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 4/6] iommu/tegra-smmu: Use swgrp pointer instead of swgroup id
Date:   Wed, 8 Dec 2021 23:38:20 -0800
Message-ID: <20211209073822.26728-5-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211209073822.26728-1-nicolinc@nvidia.com>
References: <20211209073822.26728-1-nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1682f348-8c12-4e8a-9a71-08d9bae6e79b
X-MS-TrafficTypeDiagnostic: BY5PR12MB3683:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB36832FB18D1D26A0BD0B094BAB709@BY5PR12MB3683.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q/SXwRn0y0q3UBAKYGQjPP/LWT6hzqDTqvuOXEVmAJ3DPPgHYpop07tB95xmc7VsUqf1gNfsks1/2LhTXl5K9MpusHJiBryITQwKQdd9u7ujnMVQliEQq2pYmMByywwd8JOxHa3+8Me/fxpZHJjndhypDUqj3L2XE+uhYSUocUvukdCgw02OEx8wDMjT64zopSmXjwhFbchFeq/gwBaiRuLwyDXILD1r91tehh8dbM5RBmrfPQJlpTUpf5L0anbadx1ffE1UsPiLJZtPCr2EWCLYQg6P5xmdIoM/GPcttBgonAgpGLbaNonpbwYsqwD9I8tkqcalHizJf6RTKVfIwc+3SUhcJFiyAUVbhI0PVttEN8ghLzPFVaBEu2ZsDjneMZyzA7SlSamM4y1QtdzLZTYHLfRJd3/fJfJ4q+ErcdMDlPppWfiJjOIOLjBLye+IAFKEYprHMLyN40RX2HsGkCbPC4CEbFxGB/mtEtu0LjBj0RBTRCXtY6TN2Junu6a+fYlkdcf0FLrRPuwE6j0HIbrrR9oBOVG9WnLnxGX0Acs4eiMWyJCuuYN48SYTwarw4zRveM2tXkCAPp4vhGWOtlZV+ZuLR+HL0UXAL2dlhf7W/KSAlMP4eXvW+0RlGQCy8DLRa/3CPAqrQctQWu/kDD2KpM6kCtID4qmQCNCvOX7NgA/p8YGMMAAhj57Aa6hfzD97GCBOVuAqTKb5oi9qxjZbMEfQ1JWUjXh4IlFmYhe6DHX6K814jplymR760l9ZG4EyBqVWyQKP1QAUyGfbd02IM4CnNy1NRvRJoifG0rCguhvyRVnAoAk6Llnj+9+24epUSgNL+Ev+DNt3+l6EBytr0SzcML40X1KzYP2W2rM=
X-Forefront-Antispam-Report: CIP:203.18.50.12;CTRY:HK;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:hkhybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(2616005)(40460700001)(186003)(336012)(426003)(70206006)(70586007)(26005)(34070700002)(83380400001)(82310400004)(36756003)(508600001)(2906002)(356005)(5660300002)(1076003)(7636003)(6666004)(47076005)(8676002)(8936002)(54906003)(86362001)(7696005)(110136005)(316002)(4326008)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 07:38:33.5771
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1682f348-8c12-4e8a-9a71-08d9bae6e79b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[203.18.50.12];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3683
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes in struct tegra_smmu_group to use swgrp
pointer instead of swgroup, as a preparational change for
the "mappings" debugfs feature.

Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/tegra-smmu.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 05a386036fce..532c843eb631 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -24,8 +24,8 @@ struct tegra_smmu_group {
 	struct list_head list;
 	struct tegra_smmu *smmu;
 	const struct tegra_smmu_group_soc *soc;
+	const struct tegra_smmu_swgroup *swgrp;
 	struct iommu_group *grp;
-	unsigned int swgroup;
 };
 
 struct tegra_smmu {
@@ -899,18 +899,22 @@ static struct iommu_group *tegra_smmu_device_group(struct device *dev)
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct tegra_smmu *smmu = dev_iommu_priv_get(dev);
 	const struct tegra_smmu_group_soc *soc;
+	const struct tegra_smmu_swgroup *swgrp;
 	unsigned int swgroup = fwspec->ids[0];
 	struct tegra_smmu_group *group;
 	struct iommu_group *grp;
 
+	/* Find swgrp according to the swgroup id */
+	swgrp = tegra_smmu_find_swgrp(smmu, swgroup);
+
 	/* Find group_soc associating with swgroup */
 	soc = tegra_smmu_find_group_soc(smmu, swgroup);
 
 	mutex_lock(&smmu->lock);
 
-	/* Find existing iommu_group associating with swgroup or group_soc */
+	/* Find existing iommu_group associating with swgrp or group_soc */
 	list_for_each_entry(group, &smmu->groups, list)
-		if ((group->swgroup == swgroup) || (soc && group->soc == soc)) {
+		if ((swgrp && group->swgrp == swgrp) || (soc && group->soc == soc)) {
 			grp = iommu_group_ref_get(group->grp);
 			mutex_unlock(&smmu->lock);
 			return grp;
@@ -923,7 +927,7 @@ static struct iommu_group *tegra_smmu_device_group(struct device *dev)
 	}
 
 	INIT_LIST_HEAD(&group->list);
-	group->swgroup = swgroup;
+	group->swgrp = swgrp;
 	group->smmu = smmu;
 	group->soc = soc;
 
-- 
2.17.1

