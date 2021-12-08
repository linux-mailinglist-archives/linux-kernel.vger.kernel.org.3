Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9EA46CF6C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 09:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbhLHIvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 03:51:33 -0500
Received: from mail-dm6nam10on2087.outbound.protection.outlook.com ([40.107.93.87]:9889
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229653AbhLHIvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 03:51:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5XoClsNvJHXNg8q4zVHg8a18Jv1zHzepY93h+djKumhG2KvNGK6S55HbJWnnmGSLh8FaCyC/+iMIfXljSH/bxp7Dkamhs6tDS3sNbGxCbn3thW17yYrlWd8XSVbeRv+bjcG6WOczJV8Jd7obyOV1h4spgsJytsIC1881nPPrUpC5jwBVcIAu00uwpram3XNBaxPARSlBI9Vk30a1GKCWQVbjXJwuEVZod2E8C30bJd4ckuj5sgH/qO9JmpFAHAWBA1ZJLeP8R4OVxDSq1DHvSN55tES4BYipiUqijIDLMQuhWIXCWfdQhvwH03b556uM7Np7750aBHY+lGqmM0bDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGKQbL5ijjSEl0o5E3TT/Emj3HABxIqXErz6A8aEbpo=;
 b=fVdSWLB2FcQ5AfGI4SrJfxAbMWQWQlM9dOMYd0qJorm3jQuZcRj9aau5Rzl2ED9DGqHoU21bjb3qQpiyaGVCXoa9dkY7Cc3ztyObfBlxzkZbXboU09o2a1z2uJjK8x0jGnb/hvVqeh9ZIlXd36vFTUog/xUivSRewTV+yv7aqtoe1eurPYwGRFA6C2rQhmeAHOmss624TgJC1E78JWRn+aJjB79EJYrfyj87Sfx9pzPSdpnYvQiZzp5k+fPb3TAAqmK6BKAAX/AS2yNfnEzjG/X/ifQTFVlCpoh8mcFX4so5Et+rG21pY7qQp+BeoDtc0ETQx1FRnFZoywnjg7niPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.13) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGKQbL5ijjSEl0o5E3TT/Emj3HABxIqXErz6A8aEbpo=;
 b=iqlOw3l4wPPZnQidH0WcY775R9wRsw45crqy6UOG3Xh3U5ymA3C6PM6bjmXnnUUCENiQMdbeEwQ5lfVxJT9UgsvGK/08uJKP+vagfJv/V4H2fQfV0ldzyDpeM7Kv6hOlqDmtRrySd3tlYcovERrNFyTY69X3RAYDRoBY5AOHu674pU7Sil4KOta7/VWbfmf8y7Khcy+JH5RS6s7jN42u7CSsOt6mJ2r8/rahhgBrO2iSSZ52YqDEA5MkM/Lb5BJATN+fdurt9a1n6LDQnG+f24EOJkRDWwrr5l9DMVE5Jm7nw20BGKKrYUl+Oz3OhxftInjhm6hPWT4lgjpu0kOmEA==
Received: from MWHPR12CA0050.namprd12.prod.outlook.com (2603:10b6:300:103::12)
 by CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Wed, 8 Dec
 2021 08:47:49 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:103:cafe::b2) by MWHPR12CA0050.outlook.office365.com
 (2603:10b6:300:103::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.22 via Frontend
 Transport; Wed, 8 Dec 2021 08:47:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.13)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.13 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.13; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.13) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Wed, 8 Dec 2021 08:47:48 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 8 Dec
 2021 08:47:46 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 8 Dec
 2021 08:47:43 +0000
Received: from Asurada-Nvidia.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 8 Dec 2021 00:47:43 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <thierry.reding@gmail.com>, <joro@8bytes.org>, <will@kernel.org>
CC:     <digetx@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 5/6] iommu/tegra-smmu: Attach as pointer to tegra_smmu_group
Date:   Wed, 8 Dec 2021 00:47:31 -0800
Message-ID: <20211208084732.23363-6-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211208084732.23363-1-nicolinc@nvidia.com>
References: <20211208084732.23363-1-nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2cf63450-bb08-4461-f192-08d9ba2769d4
X-MS-TrafficTypeDiagnostic: CH2PR12MB4262:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4262CFCEDCF76287DF360211AB6F9@CH2PR12MB4262.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XhKomhVTYdjf2a/27/0W0zporiBKlUI7ywLeGwyt2gKVOni+Gm5PDy5NjXkcxzsI8RcuyDUwoQvZbxgUyafo72+1xWug3yuiN5CV0TXKpt9D/CLolp2L7Co/23NNErjaXcQnRG7vm/uiRJojAUtJBZCHKcKqyHKaPgPGUKnFuuSyU9kXkeui8EcLtYNGhvy+1RYB3pWgLzSlG4HZps4RCNw305sJGJdubroeSeUWAq2uhVwWs/HnKlRoPFse47ZBPZVLpztSoA9sAPaFAqA/ybyiGmde1VFhs0rm7ax2PJsxmyjj+3cOIrRF6Tg2pgjRA3K0+M1AIwicrR5Bs31v0pHi8ozhi/fIsGtulUYdQkjcrSx2/5tThnCiHhXIBj5Ywaiec4/qBOAgicUcqzxP8DTaWhwGSQGLmcHSphg9KZaaF/sb6co+gTRbosoKOnDAZKdsAdb/sEAvzSj1ildfkdgyOycSgEYaJylLFJc5YXuJx8DNcfAd9/4ywSGiVfFl9jPcdTPOU5qBKaU+Gd6uG74P0wJFX8Y7DhCOyitE6MueJfqM6TTQnMCDbVgIudozJoYFrB/FjyQueN6V/++O41eFK1eq7nW41YnvpIqsKlc3CmYep3FE88laI7KkZkXyfY/sMLxqm64JYaLWdaLgO/KxeP2YAMvi0nXOjUn7f0lfuE1RHqEDww5dsRmolrc0PpqCW6hPOYEG/XHO3LbLOex2gE0oVFdIxEfJeUuXKOD2SpBtjAAQ1/hqVUQ9nVkspS7/nI1h4vTdpxpRAA9ifteQmgvUysjYuIYPbhJCcYnK6UI1xlp9QGpbUoS2ZpmmUOq9CX5AXuDnD8a1g9Dscw==
X-Forefront-Antispam-Report: CIP:203.18.50.13;CTRY:HK;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:hkhybrid02.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(5660300002)(316002)(356005)(186003)(336012)(70586007)(7636003)(70206006)(86362001)(7696005)(36860700001)(26005)(426003)(2616005)(8676002)(8936002)(34070700002)(2906002)(508600001)(1076003)(83380400001)(47076005)(36756003)(4326008)(110136005)(6666004)(54906003)(82310400004)(40460700001)(334744004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 08:47:48.8252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cf63450-bb08-4461-f192-08d9ba2769d4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[203.18.50.13];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4262
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
 drivers/iommu/tegra-smmu.c | 94 +++++++++++++++++++++++++++++++-------
 1 file changed, 78 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index b0a04cc8f560..1fbb93215463 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -24,6 +24,7 @@ struct tegra_smmu_group {
 	struct tegra_smmu *smmu;
 	const struct tegra_smmu_group_soc *soc;
 	const struct tegra_smmu_swgroup *swgrp;
+	struct tegra_smmu_as *as;
 	struct iommu_group *grp;
 };
 
@@ -349,6 +350,19 @@ tegra_smmu_find_swgrp(struct tegra_smmu *smmu, unsigned int swgroup)
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
@@ -482,6 +496,57 @@ static void tegra_smmu_as_unprepare(struct tegra_smmu *smmu,
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
+	struct dentry *d;
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
@@ -495,11 +560,15 @@ static int tegra_smmu_attach_dev(struct iommu_domain *domain,
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
@@ -509,7 +578,10 @@ static int tegra_smmu_attach_dev(struct iommu_domain *domain,
 
 disable:
 	while (index--) {
-		tegra_smmu_disable(smmu, fwspec->ids[index], as->id);
+		unsigned int swgroup = fwspec->ids[index];
+
+		tegra_smmu_disable(smmu, swgroup, as->id);
+		tegra_smmu_detach_as(smmu, swgroup);
 		tegra_smmu_as_unprepare(smmu, as);
 	}
 
@@ -527,7 +599,10 @@ static void tegra_smmu_detach_dev(struct iommu_domain *domain, struct device *de
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
@@ -869,19 +944,6 @@ static struct iommu_device *tegra_smmu_probe_device(struct device *dev)
 
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

