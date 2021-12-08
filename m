Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA3446CF5A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 09:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbhLHIvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 03:51:20 -0500
Received: from mail-mw2nam08on2079.outbound.protection.outlook.com ([40.107.101.79]:44288
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229537AbhLHIvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 03:51:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dL1Gvg3P/JyOX0r9nglrvrZDI/XKmu2MhLdBSoVHxvGnxJXtzt29skTtOE5U+xfW34IyOl38WukpeQj0qDMi9GCx625W+WVP1IWebhM78sZ8M99fNBGbcW5+GjWHYvrmaaLTZJUlPCkCCCot9UzzQ2zGFQqR5qqtfgO87nHAk3o1c0D/5InsBXyG9+OrzuJiCh9NJUCLlgWjTVagFXrSHVljqO8h/+BcHG3eNlTfHUVJ6OSt9lfxf2gync3DsHyp4CjpOUquR3X8wgcP9wqR4xO4UvMyNcGzIsQqceED0ThTqWDNxqhZHjw+/tRBegnJKugkN3Pr3s/yDQxwDjA/tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBEzcwybTjL5zi0VaMLc/oTyAZ4BrFDjA8AU3tDIYaU=;
 b=PfKkMhNwdpFHmstj00lpBX2+LulCj1MetudRMMJUWbh0wHtfQCWykK8cSmW8B8tPf29HndhMcBqBcLkCbuUZsazz8HyqOYFhudMRxIamlasEEnG0oh7p+0jB6KeDaeyz5EHcONEsrBwyY/rBB3o5fKOQqiZ8fotAzQGQDguZWaGfEabiwT+Ac89wxRvweQzjeeSksi8rfi5H2wsVOR8XG1FZu+rvlQErcTLjHBrBrcY/2V265199wW+iFBGvtTpL4Scvhj40ONXG1COGJKLAdDLxFL25mM44bJDyHisnUrht3bt+FQqFsSo71Z3b2xAX3uW4/04r41jS+S4abe8xfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.13) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBEzcwybTjL5zi0VaMLc/oTyAZ4BrFDjA8AU3tDIYaU=;
 b=m1aoCzPXVRFyTEzuy9SLipWxtTzcyzguU26jNBTf8Zub3QUI6QJt1ILU4T1XM1qBJDsGa/5XbH5bEKX51QDkCt9SRk5m0JInlN/L1Ha1v1MSKj1m+YereSnzcCMnZnzyszCtFcZNZhBongRz6hVCyeHz/piCLw4xUM28243EoMG0F1shmdKPvIznjXHrf/C6PB8xRE9nFlscPpGwpK6pmM3OBLRQV3kJSFSxl8XoAwk9VY2ci22TZs9exBfO09un3Zni08XUzFDfaj7gWOaAEjcyx5uEWx/P8QSSOvkn8zRX1gQDCLn09MRgLA5PRyeV1oAyccFodQImot8ujbkNhA==
Received: from MWHPR12CA0071.namprd12.prod.outlook.com (2603:10b6:300:103::33)
 by BN6PR12MB1762.namprd12.prod.outlook.com (2603:10b6:404:fe::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Wed, 8 Dec
 2021 08:47:45 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:103:cafe::9) by MWHPR12CA0071.outlook.office365.com
 (2603:10b6:300:103::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend
 Transport; Wed, 8 Dec 2021 08:47:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.13)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.13 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.13; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.13) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Wed, 8 Dec 2021 08:47:45 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 8 Dec
 2021 08:47:43 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 8 Dec
 2021 08:47:41 +0000
Received: from Asurada-Nvidia.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 8 Dec 2021 00:47:41 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <thierry.reding@gmail.com>, <joro@8bytes.org>, <will@kernel.org>
CC:     <digetx@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 2/6] iommu/tegra-smmu: Rename tegra_smmu_find_group to tegra_smmu_find_group_soc
Date:   Wed, 8 Dec 2021 00:47:28 -0800
Message-ID: <20211208084732.23363-3-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211208084732.23363-1-nicolinc@nvidia.com>
References: <20211208084732.23363-1-nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa9dc445-e425-430a-d9ba-08d9ba2767ab
X-MS-TrafficTypeDiagnostic: BN6PR12MB1762:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1762750F38CC6C3BFB26F76BAB6F9@BN6PR12MB1762.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YTHzsxBGQyBinAeL7Sq5JEXEsBfKgSoiNPDPbRBE3er8kJF1lIoUSqSCevqpT6ByKyA+Y1bzpYGdx6BzepzWazQOl2TWgf2+RXoz49PbI4/PZGJbZ9iAhzuGnUI9zK957JlQanwv0BzQOA6hpWT3O3k15lDlLhQkHVeKALKoRIJ+JEDAhH4kKShg33tJhBtTG+W0kb2aCSyYZfQh2nIUBJB7JD2f+7LtXRRYw3c4vjbZcKdldgDNQNby083A0ylDXEZr6a/DdWLrx5BAEGBlliY5uUUE8XOiL4djDTbnf5j9kEI2RA0RJUI7IVJMGQYqGDR9wA8nMaAhsYgahiruEznS2/tHWcVWq/ICcwEZmRnfIzSApaj/QBgRpDz7u4e0vlltYf7PZPWjA3N9a5VKBEUonlF+hjRgZvCiO0mDmuO4sWkKT5xthEVcgtbXPDdKScvntuP5EkrWNpIsoSib2aV8XOWtlPvpCAxWHmIHWsafdev453NSrPRO43BkjpqC96unNGPZPzToITOb1aFYEK2HMdz1qbruQp/AbMUR30WkAlVh89MlmAb6U5ZqcgaDI3rknYYz48fEaO+yTRlwD8jiSNQ/nXLozQfhZLqs2QAVVP61BGw2brgd/XyKHn7ILc415KUIKbYpx8D2IUpVoTSrvf7MAeBMlwjVLoIX50J2mec6DWVuAQrXdtdVTPIZmV2ITQXgcsAqbdNwQ7VI0zbUOnkEvQrsj7/FUoMDcojOCrlsloy1H8g1NECHt6xzflUXGG2WUKVUtq4RglruxLmDuwUE2wZiJW8dBumaygs=
X-Forefront-Antispam-Report: CIP:203.18.50.13;CTRY:HK;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:hkhybrid02.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(40460700001)(82310400004)(26005)(2616005)(8936002)(336012)(1076003)(7696005)(54906003)(508600001)(426003)(70206006)(36756003)(110136005)(316002)(70586007)(36860700001)(4326008)(7636003)(47076005)(186003)(5660300002)(8676002)(34070700002)(83380400001)(356005)(86362001)(2906002)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 08:47:45.2005
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa9dc445-e425-430a-d9ba-08d9ba2767ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[203.18.50.13];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1762
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
index f874ee2600e5..9e9f37e4894c 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -870,7 +870,7 @@ static struct iommu_device *tegra_smmu_probe_device(struct device *dev)
 static void tegra_smmu_release_device(struct device *dev) {}
 
 static const struct tegra_smmu_group_soc *
-tegra_smmu_find_group(struct tegra_smmu *smmu, unsigned int swgroup)
+tegra_smmu_find_group_soc(struct tegra_smmu *smmu, unsigned int swgroup)
 {
 	unsigned int i, j;
 
@@ -902,7 +902,7 @@ static struct iommu_group *tegra_smmu_device_group(struct device *dev)
 	struct iommu_group *grp;
 
 	/* Find group_soc associating with swgroup */
-	soc = tegra_smmu_find_group(smmu, swgroup);
+	soc = tegra_smmu_find_group_soc(smmu, swgroup);
 
 	mutex_lock(&smmu->lock);
 
-- 
2.17.1

