Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 613C646CF6A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 09:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbhLHIva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 03:51:30 -0500
Received: from mail-dm6nam12on2078.outbound.protection.outlook.com ([40.107.243.78]:14144
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229637AbhLHIvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 03:51:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIx0wTjkBWB0s61rYPwpLI4Gnndy88SGL2/Ed1m1EUH5vheWctLdONGVnVRl1YsVx1Hy7L1OAp6xML128zPBibg6hCn1D/02hIgMh37crMWFIDWk2n72eLIazxdok13BFDKrw4LFelTvauZgIs4TBZGpaw8unDY4N/ub4umYLumcpwk1od5gIz8WhkxGBX45YFqmTx3T9cC51BWBYFQA8X77zru7V0Em6eI7WTZd/GI/praQaXco8q8aXXaztA1W7LURBqXbDZL560Cp8luNBhqm5HcHtuvoldPUigX6ox1HptGjyZedAGHmDiegSCbF2H8eypVTrk0kEbxk03Au+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OAe/UoCW0aw5pnRhUCQi5Xm6kq4Z8f5iBiSAAd/WPBg=;
 b=ihTPoC21JR/BX03LTCshtAOTcWVVRsQpGY5z9QUcY9WaFKD60CkZtBUZ8ys6Nf4PtQd0Hxbf7Q5J/KJbapxZ4bFT4mKQJvKAHmHRgqL6vDWiUtsP6HHrDkHSDJWybCWUlRBw/08lveDBdI7D9eM/MHrBfCUW35tlYgwUzpAQ7FmRvyhibEdm5xfxNwr/fXnqKxVknmCfmw5oguD9u9ldb/ATJ0PeitfeLukiemldVY64W+spHiCrj1pBADCoMg4EjPpAP9vmwHM4kBtjH9JH5x4r/cwGtvecrhNcxXN0c0WaYgeHJyFwmcJx8MklN6802Ilk80X8ayx8Imvw75myiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.14) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAe/UoCW0aw5pnRhUCQi5Xm6kq4Z8f5iBiSAAd/WPBg=;
 b=f41JNNwmWhDHPgUyPfnxggspJvB0ywocfLyazf+ObC/4cDKuj5FEaq3WnnRqUME+XmFvstakyaaVa05G5jypmL0mrv9HQAwRnzQOYSqJbtBMTAr3TEg/dMHP1ohe/HckDzLJfg6OXHjHzwTfpqqg0akT0S0puFRS3boZ860kwbaZ6m7r2U8MHHcWolKVJA8Bw/mU64MEQH1UgyPXDoI9ZrTirQKOgDi4+HxW4roXX9Iso9ZufzaGSCWgkKgqP6/E7zkK8j6eTchRPDl2YWiqBbmHbKvHGaFoFRzE8Nk1pqwjaKu44etcHcj+wgTf/ivA8rEoCmXo7RcpYOFjVzqUFQ==
Received: from MWHPR14CA0063.namprd14.prod.outlook.com (2603:10b6:300:81::25)
 by BN6PR12MB1266.namprd12.prod.outlook.com (2603:10b6:404:14::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Wed, 8 Dec
 2021 08:47:48 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:81:cafe::5c) by MWHPR14CA0063.outlook.office365.com
 (2603:10b6:300:81::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11 via Frontend
 Transport; Wed, 8 Dec 2021 08:47:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.14)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.14 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.14; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.14) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Wed, 8 Dec 2021 08:47:47 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 8 Dec
 2021 08:47:42 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 8 Dec
 2021 00:47:40 -0800
Received: from Asurada-Nvidia.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 8 Dec 2021 00:47:40 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <thierry.reding@gmail.com>, <joro@8bytes.org>, <will@kernel.org>
CC:     <digetx@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 1/6] iommu/tegra-smmu: Rename struct iommu_group *group to *grp
Date:   Wed, 8 Dec 2021 00:47:27 -0800
Message-ID: <20211208084732.23363-2-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211208084732.23363-1-nicolinc@nvidia.com>
References: <20211208084732.23363-1-nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b90eaa2-4d2b-4703-c627-08d9ba2768e4
X-MS-TrafficTypeDiagnostic: BN6PR12MB1266:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1266F162B669091CCC898404AB6F9@BN6PR12MB1266.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FrGkuhpTCx/CF7JlQb1dd8+mPJaeNNkhKTTI44jupRuDKPsn1b5L43iDzsO3bPt4ip0aFRUumpbk5BkxNThjJIc4tWiAfoUge0MkzeD06sedK6ty2uhti0frtiNkkGCEC3s83N/Jq8o075cV4+IH8pRhgo+mC8pcNDciaUqus+ddzNMmXIvRHXIG0Ae5SuKmEQg3sSmekyPaJ8Zy1d1RNuJlhbaaHxD32SY6bFhN11oZJ5z7pW4psB22gdryZ3JFaOdGMkWQQDb8E0MZINdfmI4cxsglZJ6LCETnnMM6CJfjS8tgd1r27paaIXxS+P5a05buNII1cbl0wc3sj+FH6//Wuq7PDtp0oNkwk54lhMwZJNJtCrVQWg/GQI/Qa+FWf5uaO2oVz1pJ5ofszUVrJsz744f+jSMhJnW9UdZ09pW+d1uUhonoUslm3EKKddypQIfrpRgcVgv1/lGuusp2Wi0ulXCAzzsqbHhhhG0hAz6+rYLlxOtohCwTfPQr4QpnjcB+ssVlzR7kR6MnUIfKjhkv2skgFEBkROHpFPu5U36MnpxYyeNeJlEFbDUORNY5IM5Txft53AM+/hlB8Afw8bcI6shVnpA5xy0mZIf8pAZZw3CiL28cZOJjNPFyfix2cd8xHSnbHUIpYn1OAQR90HQvdC9nPdy+Tbz4oQABMCX4p7sBkSOk8WQHjI8j8zDgHK4wYqtMUr5kHjL8iMZxJa7u4ekOidpzVgLNYCKJ+m5AwSpOjd0RxRGwnSEjpsx1gOrOn1b6NVg6QgigppMbmUg2SQfoQ9sKjNp4iv/Bwi4=
X-Forefront-Antispam-Report: CIP:203.18.50.14;CTRY:HK;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:hkhybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(36860700001)(316002)(2906002)(1076003)(4326008)(7696005)(336012)(8936002)(426003)(2616005)(70206006)(5660300002)(26005)(186003)(34070700002)(70586007)(47076005)(8676002)(83380400001)(54906003)(86362001)(36756003)(6666004)(82310400004)(110136005)(7636003)(356005)(40460700001)(508600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 08:47:47.2669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b90eaa2-4d2b-4703-c627-08d9ba2768e4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[203.18.50.14];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1266
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
index c5fa8b8673b6..f874ee2600e5 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -23,7 +23,7 @@ struct tegra_smmu_group {
 	struct list_head list;
 	struct tegra_smmu *smmu;
 	const struct tegra_smmu_group_soc *soc;
-	struct iommu_group *group;
+	struct iommu_group *grp;
 	unsigned int swgroup;
 };
 
@@ -909,7 +909,7 @@ static struct iommu_group *tegra_smmu_device_group(struct device *dev)
 	/* Find existing iommu_group associating with swgroup or group_soc */
 	list_for_each_entry(group, &smmu->groups, list)
 		if ((group->swgroup == swgroup) || (soc && group->soc == soc)) {
-			grp = iommu_group_ref_get(group->group);
+			grp = iommu_group_ref_get(group->grp);
 			mutex_unlock(&smmu->lock);
 			return grp;
 		}
@@ -926,23 +926,23 @@ static struct iommu_group *tegra_smmu_device_group(struct device *dev)
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

