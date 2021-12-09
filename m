Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEBC446E356
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 08:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbhLIHmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 02:42:12 -0500
Received: from mail-mw2nam12on2045.outbound.protection.outlook.com ([40.107.244.45]:19809
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233919AbhLIHmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 02:42:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ApmFL78tx1V48Vt6qNiZ0Ll0OOA87J65RqSKiqI3+pkQAoONi+2dUz4l7gAAI+h1UmG8Ti3ViRvdjq1afneXiO2KI3C2kfjhLUM80pWVjsSFhvdQNqlA1kIvf9nVFnqpqn6+0zSO3x8dE2Svifwck9UwiGXetragD/W59YvjKMqYUA5VVA1PpMHJz/EHnxvpqAOVuZlDBdm3CrMQVDgPiOSTVGH1I044FPUaLddacLzGBN2u28DFHsx83wiOFxpjZIp5F8InEyHatOYJiLtnk4E3CIOL9lTzvyoaBHvYe0pi19zE5pl9rDjHSktGyqH+7UqKY/ARhE4hLUcBr9o+1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=np2NeiV1rWR+33bNbyEuUFxstxGN4OBJBsRraL5cTOk=;
 b=HAAOyA6LbJJg5bf0h7E8wJljRvXXWamooM16TtwZXpNzcP9UogLWSybkK/fJ2tk9RShi77rIg76k3bkHCGGqkfl3R3rbA98jjrfMAKlXElV0TpCdY4uHYg8BQZ0wKkznRj/NnLqy18TimKKvhfWk22lFR/uMhv4imHkr3D6xYIv2JofcfOyks6kP7w2SGo9kL0lbEobvJwA/DPtC08/5lc4OD60/wbhI4VOf/eVFzeQYW+KLlUPMeKLty+PuvOExrckPR90WBMw4aTZcu1ZVF5R35rcr+01MwMoXA4egLi3ge8vwJ4CZGlqqxSQeW3Xb3gzH/AwK2V3a4Q/mqFI6Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.12) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=np2NeiV1rWR+33bNbyEuUFxstxGN4OBJBsRraL5cTOk=;
 b=NVDME0Kpoy9RUtKdtkRDN3Q47NNq0o7NQ63sucLQWTO+XLLGc/qyUL8NO/p0Ojz+UgNj+jFzc8KyFWw/LPjmKOSaNrMF5OM8R19Mh8e3mcOtYb+9D22YIpjw+xXakVut2k2h4DHuGlQGRX7+sqFtgqP71OIDb+viLjRixNtFT54ZRcu5zejttE3Un7sfbnFvB9mgKjIopjBnpoDxXLOS7HxGBWGblJF4itJXm4sjW1a5k9Ny4eFGvfyS+k4EVw33LfsdsdwcnTuycEPHCv4uz9SKMO8dqvx4mYjEgPO6UWtW02XBsXVVCUkRAZMomow0jIQS/qGmJDijPVhRr3bmuQ==
Received: from CO1PR15CA0106.namprd15.prod.outlook.com (2603:10b6:101:21::26)
 by DM6PR12MB3082.namprd12.prod.outlook.com (2603:10b6:5:11b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 07:38:30 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:21:cafe::f7) by CO1PR15CA0106.outlook.office365.com
 (2603:10b6:101:21::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.22 via Frontend
 Transport; Thu, 9 Dec 2021 07:38:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.12)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.12; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.12) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Thu, 9 Dec 2021 07:38:29 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 07:38:25 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 07:38:25 +0000
Received: from Asurada-Nvidia.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 8 Dec 2021 23:38:24 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <thierry.reding@gmail.com>, <joro@8bytes.org>, <will@kernel.org>
CC:     <digetx@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 1/6] iommu/tegra-smmu: Rename struct iommu_group *group to *grp
Date:   Wed, 8 Dec 2021 23:38:17 -0800
Message-ID: <20211209073822.26728-2-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211209073822.26728-1-nicolinc@nvidia.com>
References: <20211209073822.26728-1-nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 069d1c08-1175-4a67-856f-08d9bae6e553
X-MS-TrafficTypeDiagnostic: DM6PR12MB3082:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3082CAE5F91BE2C8D3FF7CFAAB709@DM6PR12MB3082.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H64wDTZahHwxCuNMrz8q+f8gKWnECy0aJBA3kKXWP9alJPpkDCD2fLv+TYnvuBO+LbKZRXNLWBfKcWxfqjapWyWfa75p90jf22IZsV6BSk0N4lIK1TN9ePdZbakXnfFOzuc0smBOz4z9lQ/SX+Ez62dtX87W2UPh2+hnbvgSKawEc2gPM0AZOJIqkHrZrhwqETqFMuti8CjO+p81jQDhowMqVC0rxIjtoY9JBxvAqIJ0SaZYSK/oJ/vlsPia5DcTGt5/bhGHsCDh+QAHUjdxo3YQOFKFIhJbU6lJMlQeIXHn93ogvS2JOOLKSbNGTDjmvbMeL10MESWA+RAFejrLJHJ3lovKLfa7dfmxqNydaWC4/g5iNPr2YmQkbWkkA3FHsly7nUaB8GOxaMsDOEDC86w6NqHPD0Yndj50/mkUgqdRRqFdtvKdHhhLszVleeXub8EOl228B+TEzOhW3kS0uJ6mt8aVv5RQ16GdwTpxn4iu837dOYtbGnoEXZa03FbktDx+y89PXZMLxY/tSjRs9FVO/MdSSKNQClkDqdvni2NKefr5PzqHkBM09jV+46UUTjexsxE+HX93Ndwhy6NJfYGDIBulmIIdrNV1DcaMUmG7FO3MLRWVrp6v26ttQ3+uaJ2V1kz3iOhlvd/XCeOTykvaqtPtfmC9wYPlCF1Fs3xwzyVs1dQXHE899Fq5Tn5G3W58OuyWeIkuC10/gvxqh1a5b2GtMJLoZuZBq/a9ucVy5J2RymxutleJhWV2LY1REg3BFgzoYgmJqHmULGSIb5Ou4m2jWYwSt5207Wm94Mw=
X-Forefront-Antispam-Report: CIP:203.18.50.12;CTRY:HK;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:hkhybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(83380400001)(508600001)(1076003)(54906003)(110136005)(34070700002)(4326008)(2616005)(40460700001)(426003)(186003)(36756003)(36860700001)(8676002)(26005)(82310400004)(8936002)(5660300002)(336012)(356005)(316002)(6666004)(2906002)(7696005)(70206006)(70586007)(7636003)(47076005)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 07:38:29.7649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 069d1c08-1175-4a67-856f-08d9bae6e553
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[203.18.50.12];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3082
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few structs using "group" for their pointer instances.
This gets confusing sometimes. The instance of struct iommu_group
is used in local function with an alias "grp", which can separate
it from others.

So this patch simply renames "group" to "grp" as a cleanup.

Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/tegra-smmu.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 8e906504882d..fd9ef08cb7d9 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -24,7 +24,7 @@ struct tegra_smmu_group {
 	struct list_head list;
 	struct tegra_smmu *smmu;
 	const struct tegra_smmu_group_soc *soc;
-	struct iommu_group *group;
+	struct iommu_group *grp;
 	unsigned int swgroup;
 };
 
@@ -911,7 +911,7 @@ static struct iommu_group *tegra_smmu_device_group(struct device *dev)
 	/* Find existing iommu_group associating with swgroup or group_soc */
 	list_for_each_entry(group, &smmu->groups, list)
 		if ((group->swgroup == swgroup) || (soc && group->soc == soc)) {
-			grp = iommu_group_ref_get(group->group);
+			grp = iommu_group_ref_get(group->grp);
 			mutex_unlock(&smmu->lock);
 			return grp;
 		}
@@ -928,23 +928,23 @@ static struct iommu_group *tegra_smmu_device_group(struct device *dev)
 	group->soc = soc;
 
 	if (dev_is_pci(dev))
-		group->group = pci_device_group(dev);
+		group->grp = pci_device_group(dev);
 	else
-		group->group = generic_device_group(dev);
+		group->grp = generic_device_group(dev);
 
-	if (IS_ERR(group->group)) {
+	if (IS_ERR(group->grp)) {
 		devm_kfree(smmu->dev, group);
 		mutex_unlock(&smmu->lock);
 		return NULL;
 	}
 
-	iommu_group_set_iommudata(group->group, group, tegra_smmu_group_release);
+	iommu_group_set_iommudata(group->grp, group, tegra_smmu_group_release);
 	if (soc)
-		iommu_group_set_name(group->group, soc->name);
+		iommu_group_set_name(group->grp, soc->name);
 	list_add_tail(&group->list, &smmu->groups);
 	mutex_unlock(&smmu->lock);
 
-	return group->group;
+	return group->grp;
 }
 
 static int tegra_smmu_of_xlate(struct device *dev,
-- 
2.17.1

