Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6512E46E35C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 08:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbhLIHmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 02:42:14 -0500
Received: from mail-dm6nam12on2061.outbound.protection.outlook.com ([40.107.243.61]:17536
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233918AbhLIHmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 02:42:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+r2go0LvVGMAK6XkL8d9BPqP+hSCfTHS036f93qOHhy1FcIbzPcWVh6JQqvka9I6pKPI1h77EtCjwMhuj5sUgCnCbDMn1VtrQ0d8uoGkmfzB8V94vFTBb1YeeAESRq7r1+2Ft7p0Dd+9d4OdvieP11bi11XrMxZ5MV6ZVEg/ilWY6NwxwJePiDW2NeVKAMwQQR4NRHUly+p4MyYQy05DtF0JPMk3OU5JjbBp62/yNYI/0zrKEj8Y8EfQL1zJTv8syLAslGFkkCNZq00ezYTq4NXYcZ+4q8h6f3GTOYPKOkLeFOUGSteFoMBUZl6+GnQSP1m02JwM5Zqyb5DiVPmwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ma8XuHOABdZZk6S2/5jyCM1IQAxfj4J2+bSpPM33n4M=;
 b=oQ3sHNUE0SgLSUR1VEXdoli4hl8C7tBMNk3EyFOmN8kerGCzcbOTkOx7C7wpUXHHlbteO7qdAIMea+Yb62nmBSPnugdRbbiN1A5XDbyzFMHKkhtWXdTecuYzvZcty2PGrgOFYc4YO2UaY4dPka0D2beInZTu+vJZlqq/8w37MFGTWSTuIaysBiDBYLIrR+V0kFwuWc7ZLsLepiF5z3zPXslCeRsHriishCOW7MBxEraQAatKuOxY/f+KdP1lVBY2gPirOv62vghQx8ehRd3PMpLlmUqOPhUwT9VDZ3VHu3kPNBUSIDFDmex9eXRrcjQ/35GrWJ8h5yv8cuBe2klI/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.14) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ma8XuHOABdZZk6S2/5jyCM1IQAxfj4J2+bSpPM33n4M=;
 b=Nu66Dixg7zVPVHuMZnzCBxIOUENQNefOon27CrxIS7LEnXxMXnGBgVuEOQAvb+h9fdqFZxhNfK+NjOVUuat6iyaGfNdhyg1Owfl7yS4ZpOYKZe9Xz2UTPQQVQ4RZjOSZdBD/QFn963se5aYtmoe38ZCDmklNZdDMQSEPYXY12Hn2vRRyEguPOMYfZjukkHw1cSTwI/Kzt3b8hnrSnO4J6lIZlXIjoV8oIUooZO3weiksl0Bsn472ghTaAvTJeb0Z9JCOkGrIHc5XXspZ/r0Hjk6iXJ7ig45VXTFWue+v1Zkl2/fY1RG+OmFUrHZm8aXvPwgmVcGXeyag8HJ61xQAEQ==
Received: from MWHPR12CA0028.namprd12.prod.outlook.com (2603:10b6:301:2::14)
 by CH2PR12MB4086.namprd12.prod.outlook.com (2603:10b6:610:7c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 07:38:30 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:2:cafe::41) by MWHPR12CA0028.outlook.office365.com
 (2603:10b6:301:2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Thu, 9 Dec 2021 07:38:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.14)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.14 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.14; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.14) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Thu, 9 Dec 2021 07:38:30 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 07:38:29 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 8 Dec
 2021 23:38:27 -0800
Received: from Asurada-Nvidia.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 8 Dec 2021 23:38:27 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <thierry.reding@gmail.com>, <joro@8bytes.org>, <will@kernel.org>
CC:     <digetx@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 5/6] iommu/tegra-smmu: Attach as pointer to tegra_smmu_group
Date:   Wed, 8 Dec 2021 23:38:21 -0800
Message-ID: <20211209073822.26728-6-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211209073822.26728-1-nicolinc@nvidia.com>
References: <20211209073822.26728-1-nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72e1d09e-7795-40f3-6084-08d9bae6e592
X-MS-TrafficTypeDiagnostic: CH2PR12MB4086:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB408604169A2D897118B53260AB709@CH2PR12MB4086.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xxR4n76Bd5zopJuGlZuCVOayHOlQWRoxpTDWiStzfdDUHPWDpMYDtUq1O6EeT+aywGXP8+o7HuVBbizXbD2srIOWo1lH5bExIOM54HEjigfiupyzkp2Bn7OO3PxwXaKqxWvEqJAjEM+s++w/3FYh4UUQpFrsZm53KCUxe9HwPz+q2IRJlqOa3v1M5F226iQxlkz9RPkBL3ze2OKcfElIq5ZnlUyVSpmuSr9agMBIBz7OHJm9c9wKO6YLJ7ciAx45qKU6w5VNJbTwBBREaXJI8sAmdxePizcn2RerAR1mI6Zc+SDK1h8SRxKT4gmnGSury6QLj70yrAXhYA+nHbDu30be0A+KRBKmgWYS1z92zG2vizh4V1fTfG5lS1E1nLNdeCkH1MGqXoaMuwUDLMGKN381D+VD5bXAUHOQf+GMzVODnUMfwFUcxhlus7USEdIKJGKpDdouR18/f/CUmrBsc9QKkDnGvZzS6W/VbHtngwX4a5O+RlT0etWFMhcHdPfNdxgVXfc0Apn+wNhuy42xyIkxm2ufSOnA1aZM3ivSkv9K0KnyAQvGSPtFHu6Oad8Vslnt1q4uKKTYC5fNNiRfRQE0FiwJ0fzbsz3Tt6icXw9flSZf2HrkE2pe3Q84/HgZFTtrG5NZiVvhDlXHE31QtWXND05h+zZHTAmTssWnw1oQ1mg+59jCRlusuzOZkAMyafMjeMAn01CxekAKJehGaI953ijM2ayfJTZqfTaHoHWsEYs8xe9hoQOPkGVwobazi7VjIdf19oZURDfv8n6cjT9oJcygCHORagKz14qkwPg=
X-Forefront-Antispam-Report: CIP:203.18.50.14;CTRY:HK;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:hkhybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(54906003)(110136005)(26005)(82310400004)(5660300002)(40460700001)(336012)(83380400001)(36756003)(2616005)(1076003)(70206006)(70586007)(356005)(47076005)(8676002)(186003)(316002)(4326008)(34070700002)(6666004)(2906002)(426003)(7636003)(8936002)(508600001)(86362001)(36860700001)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 07:38:30.2592
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e1d09e-7795-40f3-6084-08d9bae6e592
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[203.18.50.14];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4086
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This could ease driver to access corresponding as pointer
when having tegra_smmu_group pointer only, which can help
new mappings debugfs nodes.

Also moving tegra_smmu_find_group_soc() upward, for using
it in new tegra_smmu_attach_as(); and it's better to have
all tegra_smmu_find_* functions together.

Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/tegra-smmu.c | 96 +++++++++++++++++++++++++++++++-------
 1 file changed, 80 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 532c843eb631..454504aa6602 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -25,6 +25,7 @@ struct tegra_smmu_group {
 	struct tegra_smmu *smmu;
 	const struct tegra_smmu_group_soc *soc;
 	const struct tegra_smmu_swgroup *swgrp;
+	struct tegra_smmu_as *as;
 	struct iommu_group *grp;
 };
 
@@ -351,6 +352,19 @@ tegra_smmu_find_swgrp(struct tegra_smmu *smmu, unsigned int swgroup)
 	return swgrp;
 }
 
+static const struct tegra_smmu_group_soc *
+tegra_smmu_find_group_soc(struct tegra_smmu *smmu, unsigned int swgroup)
+{
+	unsigned int i, j;
+
+	for (i = 0; i < smmu->soc->num_groups; i++)
+		for (j = 0; j < smmu->soc->groups[i].num_swgroups; j++)
+			if (smmu->soc->groups[i].swgroups[j] == swgroup)
+				return &smmu->soc->groups[i];
+
+	return NULL;
+}
+
 static void tegra_smmu_enable(struct tegra_smmu *smmu, unsigned int swgroup,
 			      unsigned int asid)
 {
@@ -484,6 +498,59 @@ static void tegra_smmu_as_unprepare(struct tegra_smmu *smmu,
 	mutex_unlock(&smmu->lock);
 }
 
+static void tegra_smmu_attach_as(struct tegra_smmu *smmu,
+				 struct tegra_smmu_as *as,
+				 unsigned int swgroup)
+{
+	const struct tegra_smmu_swgroup *swgrp;
+	struct tegra_smmu_group *group;
+
+	/* Find swgrp according to the swgroup id */
+	swgrp = tegra_smmu_find_swgrp(smmu, swgroup);
+	if (!swgrp)
+		return;
+
+	mutex_lock(&smmu->lock);
+
+	list_for_each_entry(group, &smmu->groups, list) {
+		if (group->swgrp != swgrp)
+			continue;
+		if (group->as == as)
+			break;
+
+		if (group->as)
+			dev_warn(smmu->dev,
+				 "overwriting group->as for swgroup: %s\n", swgrp->name);
+		group->as = as;
+		break;
+	}
+
+	mutex_unlock(&smmu->lock);
+}
+
+static void tegra_smmu_detach_as(struct tegra_smmu *smmu,
+				 unsigned int swgroup)
+{
+	const struct tegra_smmu_swgroup *swgrp;
+	struct tegra_smmu_group *group;
+
+	/* Find swgrp according to the swgroup id */
+	swgrp = tegra_smmu_find_swgrp(smmu, swgroup);
+	if (!swgrp)
+		return;
+
+	mutex_lock(&smmu->lock);
+
+	list_for_each_entry(group, &smmu->groups, list) {
+		if (group->swgrp != swgrp)
+			continue;
+		group->as = NULL;
+		break;
+	}
+
+	mutex_unlock(&smmu->lock);
+}
+
 static int tegra_smmu_attach_dev(struct iommu_domain *domain,
 				 struct device *dev)
 {
@@ -497,11 +564,15 @@ static int tegra_smmu_attach_dev(struct iommu_domain *domain,
 		return -ENOENT;
 
 	for (index = 0; index < fwspec->num_ids; index++) {
+		unsigned int swgroup = fwspec->ids[index];
+
 		err = tegra_smmu_as_prepare(smmu, as);
 		if (err)
 			goto disable;
 
-		tegra_smmu_enable(smmu, fwspec->ids[index], as->id);
+		tegra_smmu_attach_as(smmu, as, swgroup);
+
+		tegra_smmu_enable(smmu, swgroup, as->id);
 	}
 
 	if (index == 0)
@@ -511,7 +582,10 @@ static int tegra_smmu_attach_dev(struct iommu_domain *domain,
 
 disable:
 	while (index--) {
-		tegra_smmu_disable(smmu, fwspec->ids[index], as->id);
+		unsigned int swgroup = fwspec->ids[index];
+
+		tegra_smmu_disable(smmu, swgroup, as->id);
+		tegra_smmu_detach_as(smmu, swgroup);
 		tegra_smmu_as_unprepare(smmu, as);
 	}
 
@@ -529,7 +603,10 @@ static void tegra_smmu_detach_dev(struct iommu_domain *domain, struct device *de
 		return;
 
 	for (index = 0; index < fwspec->num_ids; index++) {
-		tegra_smmu_disable(smmu, fwspec->ids[index], as->id);
+		unsigned int swgroup = fwspec->ids[index];
+
+		tegra_smmu_disable(smmu, swgroup, as->id);
+		tegra_smmu_detach_as(smmu, swgroup);
 		tegra_smmu_as_unprepare(smmu, as);
 	}
 }
@@ -871,19 +948,6 @@ static struct iommu_device *tegra_smmu_probe_device(struct device *dev)
 
 static void tegra_smmu_release_device(struct device *dev) {}
 
-static const struct tegra_smmu_group_soc *
-tegra_smmu_find_group_soc(struct tegra_smmu *smmu, unsigned int swgroup)
-{
-	unsigned int i, j;
-
-	for (i = 0; i < smmu->soc->num_groups; i++)
-		for (j = 0; j < smmu->soc->groups[i].num_swgroups; j++)
-			if (smmu->soc->groups[i].swgroups[j] == swgroup)
-				return &smmu->soc->groups[i];
-
-	return NULL;
-}
-
 static void tegra_smmu_group_release(void *iommu_data)
 {
 	struct tegra_smmu_group *group = iommu_data;
-- 
2.17.1

