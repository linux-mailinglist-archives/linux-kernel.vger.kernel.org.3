Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6932B46E350
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 08:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbhLIHmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 02:42:09 -0500
Received: from mail-mw2nam10on2080.outbound.protection.outlook.com ([40.107.94.80]:27104
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233896AbhLIHmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 02:42:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7kpi0z/V8uKcQUKWbE+cOxri/VVYrQ2ppUj805DXRtRegv9typcKClR+plKmcLZ2mnLgZ5BCjLIH3BgFlBMtFb28l6YVjpIY1LYLk4w8wLZghRU8YRhP7NrWBdIobPy+yqKD9sg8jsiWY7Y0z/uFS6hlSBhPe/BCMVCS9wSH+15aIVOWDxvgei2PEIB1d7ue2rcYhxAXJa15nyGBsce66pkOlV7gjemitmhpSrNTOZE60sAadRxFT+/0l87XbPebk+bTSXJAomyWXcXSZJEAOHDqiNkGoiLoukAZI/pSS2j6EHzTYWW9/2I3eCO9nOFgsGcVIdMnWPseKAxy1pAgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pTPyWxfJJzAnO+VP3aN9w7vIUq65eWf0zIjqK0o9WCE=;
 b=DPbsQymlZbzgpxyB0moJET72Eo4f4suc4085pxw53B81RZGlW4TcXlXCDqgaFefKIQH2YQU4PqH983PC6wMe4QJVxjOjLoPhifHoFocQdllrj02Oy625ORBlAN3g6KBCrlXB/psfOxpARRf7M+Vz0eDqBqbR2GluSnBtY2ga0qCSoX6pnqlCsRuHCBaNuQWNsPrLn5DoaY5RE/I6SsEpX511HA2nRg6tqX4frxzssXXHM9jIKKZlCax61nuDT5TdUEeyAVqJHHHHmrH8BS2xw97WGfAmYrPbnZy9E2KruFyD3uL5qPH1XUTSvbrdKPGHxUMKzo0ti7MWlmB7ZolS+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.14) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTPyWxfJJzAnO+VP3aN9w7vIUq65eWf0zIjqK0o9WCE=;
 b=XhtuTjdehW8OLbfym5ckMgz66XTvxbiEPzKtFEt22lWfeAMgaeHmlD0dcLSWl1b8YI0DArTh0GVXINbZkMOiGTcs/B8YJveULkmWY8HX7AOhs5cHMbLKnw6TRQFXvHPH6vm9H8BffJpzmImG+cD0JDDEMXvC7viOHwdOh4ex3iz6xscmVQkNGy2kX3pdk1jgxSsNcPlfJj5nCxa2SM/RkQRVsWeMRr2aZ3PDdpVJ293gS2AyGVBNDlXbh3vtzZNX+ZhDMXBGy5oKr8fpZyJRhxJ7lUFijNuNU2134EWU4PNFBQL+68/Sdyh1HaYtP1NqnEkQkIvihnZ2BryUMTzWjw==
Received: from MWHPR12CA0025.namprd12.prod.outlook.com (2603:10b6:301:2::11)
 by DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 07:38:29 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:2:cafe::9) by MWHPR12CA0025.outlook.office365.com
 (2603:10b6:301:2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13 via Frontend
 Transport; Thu, 9 Dec 2021 07:38:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.14)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.14 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.14; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.14) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Thu, 9 Dec 2021 07:38:29 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 07:38:28 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 8 Dec
 2021 23:38:26 -0800
Received: from Asurada-Nvidia.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 8 Dec 2021 23:38:25 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <thierry.reding@gmail.com>, <joro@8bytes.org>, <will@kernel.org>
CC:     <digetx@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 3/6] iommu/tegra-smmu: Rename struct tegra_smmu_swgroup *group to *swgrp
Date:   Wed, 8 Dec 2021 23:38:19 -0800
Message-ID: <20211209073822.26728-4-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211209073822.26728-1-nicolinc@nvidia.com>
References: <20211209073822.26728-1-nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98e759fe-e4ff-4da6-f63f-08d9bae6e504
X-MS-TrafficTypeDiagnostic: DM6PR12MB2939:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB29399185C3B65DC9368E63D5AB709@DM6PR12MB2939.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:480;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I4AMk3DTCmBsGc5jWiZvDhvd7bEKT7ak4M6jClV6T0bZrVzt/7OWckkIXwRbkC7w6GMY0TFTgqoAl9ymCEjvku5+VF8VzlMuIWOV6xP05wUK3lH6hunu69SuGG4KHXyaQ7Dwc8mJbPr9Ry0+9ksbbBWViQ6QiG0uHDpmMTLI1qes0+eQPpDUaGgj35hLaFXGK6ghsyfqlwj8A2puHQyia6T5EPt0663XHY8WCYqrLb+b189U85/lk+MGatxzTXjgqgB7HnsZ/B8eK14VAjVzaiyOP5mhAZmc97exrBr6w8e5d0o0WRubayeMjBOj9q0rDXtj7ndjfto9b59jEbCscA+r6DgXxoxua99Lo/V3gQIvJpj8oRLK7NYwXdJo5GS9BcUMv9aotoHi7zkY5gBJRj5ddoQoOZkDKBiuMtv/+jTXh3zKXAXm/D8HEPSOMrekBNeBjAAOzqDRoE2gebRBlx8a5BFVhv45hLzf+/H6JBO0+7bRjErvEBtoiMxhu2Qc+FPo+oqFSsjzr8hf+1CKdPa6CoDYSonhJLZMGOWVOpvGRfsNd/G3P2QhrCy9b0VnGqkPjYfR8Iuicd2HHinMsEv3Qy8ospwHN07xoOuvBBrWKksKoz8UsE5yiFv69IIsdgtv++2BR28PdjyV+RsZNHw590Js3StwQehg0Yzy7I0UidPDWsvvH/I3w6V4iGq4grgRSP9zGZ9HnKOR9zwxIP4ZxUCq3lj887BwF12I5AAYFNoKiLmbNxTVAqDpNioNzCj5VoOVYfI137x5ddC83nligbCjKVAPhwgxzm28m+E=
X-Forefront-Antispam-Report: CIP:203.18.50.14;CTRY:HK;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:hkhybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(7696005)(356005)(47076005)(7636003)(316002)(110136005)(40460700001)(86362001)(2906002)(54906003)(83380400001)(82310400004)(70206006)(36860700001)(70586007)(5660300002)(2616005)(336012)(1076003)(8676002)(426003)(6666004)(4326008)(508600001)(26005)(34070700002)(186003)(36756003)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 07:38:29.3055
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e759fe-e4ff-4da6-f63f-08d9bae6e504
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[203.18.50.14];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2939
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are both tegra_smmu_swgroup and tegra_smmu_group structs
using "group" for their pointer instances. This gets confusing
to read the driver sometimes.

So this patch renames "group" of struct tegra_smmu_swgroup to
"swgrp" as a cleanup. Also renames its "find" function.

Note that we already have "swgroup" being used for an unsigned
int type variable that is inside struct tegra_smmu_swgroup, so
it's not able to use "swgroup" but only something like "swgrp".

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/tegra-smmu.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 5628865c04b0..05a386036fce 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -336,35 +336,35 @@ static void tegra_smmu_domain_free(struct iommu_domain *domain)
 }
 
 static const struct tegra_smmu_swgroup *
-tegra_smmu_find_swgroup(struct tegra_smmu *smmu, unsigned int swgroup)
+tegra_smmu_find_swgrp(struct tegra_smmu *smmu, unsigned int swgroup)
 {
-	const struct tegra_smmu_swgroup *group = NULL;
+	const struct tegra_smmu_swgroup *swgrp = NULL;
 	unsigned int i;
 
 	for (i = 0; i < smmu->soc->num_swgroups; i++) {
 		if (smmu->soc->swgroups[i].swgroup == swgroup) {
-			group = &smmu->soc->swgroups[i];
+			swgrp = &smmu->soc->swgroups[i];
 			break;
 		}
 	}
 
-	return group;
+	return swgrp;
 }
 
 static void tegra_smmu_enable(struct tegra_smmu *smmu, unsigned int swgroup,
 			      unsigned int asid)
 {
-	const struct tegra_smmu_swgroup *group;
+	const struct tegra_smmu_swgroup *swgrp;
 	unsigned int i;
 	u32 value;
 
-	group = tegra_smmu_find_swgroup(smmu, swgroup);
-	if (group) {
-		value = smmu_readl(smmu, group->reg);
+	swgrp = tegra_smmu_find_swgrp(smmu, swgroup);
+	if (swgrp) {
+		value = smmu_readl(smmu, swgrp->reg);
 		value &= ~SMMU_ASID_MASK;
 		value |= SMMU_ASID_VALUE(asid);
 		value |= SMMU_ASID_ENABLE;
-		smmu_writel(smmu, value, group->reg);
+		smmu_writel(smmu, value, swgrp->reg);
 	} else {
 		pr_warn("%s group from swgroup %u not found\n", __func__,
 				swgroup);
@@ -387,17 +387,17 @@ static void tegra_smmu_enable(struct tegra_smmu *smmu, unsigned int swgroup,
 static void tegra_smmu_disable(struct tegra_smmu *smmu, unsigned int swgroup,
 			       unsigned int asid)
 {
-	const struct tegra_smmu_swgroup *group;
+	const struct tegra_smmu_swgroup *swgrp;
 	unsigned int i;
 	u32 value;
 
-	group = tegra_smmu_find_swgroup(smmu, swgroup);
-	if (group) {
-		value = smmu_readl(smmu, group->reg);
+	swgrp = tegra_smmu_find_swgrp(smmu, swgroup);
+	if (swgrp) {
+		value = smmu_readl(smmu, swgrp->reg);
 		value &= ~SMMU_ASID_MASK;
 		value |= SMMU_ASID_VALUE(asid);
 		value &= ~SMMU_ASID_ENABLE;
-		smmu_writel(smmu, value, group->reg);
+		smmu_writel(smmu, value, swgrp->reg);
 	}
 
 	for (i = 0; i < smmu->soc->num_clients; i++) {
@@ -1009,11 +1009,11 @@ static int tegra_smmu_swgroups_show(struct seq_file *s, void *data)
 	seq_printf(s, "------------------------\n");
 
 	for (i = 0; i < smmu->soc->num_swgroups; i++) {
-		const struct tegra_smmu_swgroup *group = &smmu->soc->swgroups[i];
+		const struct tegra_smmu_swgroup *swgrp = &smmu->soc->swgroups[i];
 		const char *status;
 		unsigned int asid;
 
-		value = smmu_readl(smmu, group->reg);
+		value = smmu_readl(smmu, swgrp->reg);
 
 		if (value & SMMU_ASID_ENABLE)
 			status = "yes";
@@ -1022,7 +1022,7 @@ static int tegra_smmu_swgroups_show(struct seq_file *s, void *data)
 
 		asid = value & SMMU_ASID_MASK;
 
-		seq_printf(s, "%-9s  %-7s  %#04x\n", group->name, status,
+		seq_printf(s, "%-9s  %-7s  %#04x\n", swgrp->name, status,
 			   asid);
 	}
 
-- 
2.17.1

