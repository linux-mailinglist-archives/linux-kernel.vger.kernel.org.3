Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D93509A7B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386553AbiDUISW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385907AbiDUIST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:18:19 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171BD2BCD;
        Thu, 21 Apr 2022 01:15:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HEzqmHz120kC0FDJR/ic1P0KDXnc3kL/Qepu/x/nELypoP/zOVAaxjq5MNk1BK5DO/EVOpN5inVisdbMicsPTDlF9HQVgwamA9xud3pWD3Vq0RSP774tRzmjestrRfevC1op87GxGXRdD9XHscYMsOEBI7z/B/764bt8wj6CP+uTslk0va4BXLNF+1Y1MgptOmEHkAzsqohDZ478en0V4reGCJ835K7WL7olYDmKigRmHJnLHsL8uFAoZmN9TD+h8TUpVH+HXyT0I0USu+NfezqRuxrP53wnPR0oSr6YBXaddAIEZJ4EEpSCAd83XBXBu/D5W539PqupnZipmKvOpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B43xn0XriVShkZc3gHBGqcwtiLj4diWTnChKvsTKsME=;
 b=aZJgNEKJcdC3uTuYz0GNahA30dlA9nO+KjI4AhxwLW+uo8weVKoOhi4JKItZrV3ZjQYEsd+u9KB4r4lVvlfF5ajPPdRV5FWl9JuPu8T2DsS+bZCTmL1FU23nAEvbK46ODWQKxGp8chNjeGVg4VUctlpmE1d9Of6CUL4ZqNMAS6jbSyJYuitTaxKznkZCF95gq4A68WMoPcaNq6IBQm6PUEsGh5kdlcILYCAMGuOUZnWMFjWI8qyu2R45RcWASVHh387rcSUBeoBWWADFUmRE5m5V85Ex0zDmCiftjAxTQrGSblPbx+IF10anxO5OU8s5CGJjByS83an2NZQr6e/UnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B43xn0XriVShkZc3gHBGqcwtiLj4diWTnChKvsTKsME=;
 b=CAeWxcVltkC9cHbyYP8NdowEUJ7Rf12HR1T5zbpnIBY4CiOLLkDqTH5JJn67yqGJ86dp0PdUpyi3g/tD0xco7K52NA7TSAtCfGZ6rms6Sk+ISKNUIwxI+GeYtDjeCAGpex5zRFjUKdiQihZDdY47bJsnCuph6+uWkyU/C5wU0or4x347egvBxfdUjgu2tw2uDNBimhlAzvF9LsyRNvrUkG3ziXRbx7qbuYk/0VrWWQ6U98d7zEMl9YwE4yENT8gGXa/b3R9KvOq9jyyerIrkpFasYG+jpFqRnPP3goBzYtRyiCNQlc8Vd91j5mpMIxxuQVSu/jVLon7a7wgdtG/bfw==
Received: from MW4PR04CA0088.namprd04.prod.outlook.com (2603:10b6:303:6b::33)
 by MN0PR12MB5737.namprd12.prod.outlook.com (2603:10b6:208:370::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 21 Apr
 2022 08:15:29 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::62) by MW4PR04CA0088.outlook.office365.com
 (2603:10b6:303:6b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Thu, 21 Apr 2022 08:15:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5186.14 via Frontend Transport; Thu, 21 Apr 2022 08:15:28 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 21 Apr
 2022 08:15:28 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 21 Apr
 2022 01:15:27 -0700
Received: from amhetre.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Thu, 21 Apr 2022 01:15:23 -0700
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <will@kernel.org>,
        <robin.murphy@arm.com>, <joro@8bytes.org>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
CC:     <Snikam@nvidia.com>, <nicolinc@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>,
        Pritesh Raithatha <praithatha@nvidia.com>
Subject: [Patch v2] iommu: arm-smmu: disable large page mappings for Nvidia arm-smmu
Date:   Thu, 21 Apr 2022 13:45:04 +0530
Message-ID: <20220421081504.24678-1-amhetre@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f229e9ca-aa37-440e-28d8-08da236f18b2
X-MS-TrafficTypeDiagnostic: MN0PR12MB5737:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB5737ABBC55BAC50D23983932CAF49@MN0PR12MB5737.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vNNbKsEoceNrD9EzmMl77KYLYgJbrqFuLOMhAUIt6SV4WE8rjStTfwSQbzFg2cG6DKoUktfonkIwj7bdEYmJ8rp64pPUFgkTb3ui/4ictjBYb3liW4kwPQ/c4LQmRP4d3jRRvJG18YgIH/7m2D2TyP9BMeYyf/23x9MKi5bVVkI/KgHnKc0CCDsI4aQ3qMOewB6Qv6AU4kMl0tF6fIpLW8w0+AUZ1NcJJ4tzWqwRhAYbpCEsutdsbFO+A6k7aUIaVDg80ds/1AgwtIC8iARS6HDxTo/ds7Onog7fXwB0xKLrvFK7HxXkA6RUdIdkxy5EPXZ1UubLbQYlsZkBqh+6UDIe66gAcBulew/GKjF9YaZgUj3MLh6WLxhGquBEPonBUuPm7saMKK/8hEESATTYtQDFyi5bWT2UNOe17YfgjM9tCh7iN0kBTNF23EDQQujz35jzKb+pvaorB0Fyto48744sxnBk1rUfVPwLUy2P+0eBI4kAO+o7vMYlAYqNS9XMryrXqfK7sftKo2Mx8FKa1Suz8gI+WcETEDRzl/OzQ5v60XY9Cr/pzrBaWAW77wYd1dM5wnPuUGD2oQdGoM7Q0NTnEyzQ1DNgLuHqk+9IqohuYdR9YHZo5PNwVrPZ/VnkgaWfpebw4t5LzbbZQ8zxENJwgx2xzF7LoQZdSu9RcV7jHAFQstTFhHOcpdM+I56ehSMsCPXWBTYfFrbjBasXl8odLVqeUJzJtwe/fz65IPIOblO1XBJjBX+MMZnYyxoOpHaqANDu25IgjsxI2nfzLg==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(70586007)(70206006)(8936002)(110136005)(4326008)(8676002)(508600001)(921005)(356005)(82310400005)(36756003)(40460700003)(83380400001)(81166007)(36860700001)(54906003)(86362001)(5660300002)(107886003)(47076005)(186003)(2616005)(1076003)(426003)(336012)(2906002)(26005)(6666004)(7696005)(316002)(2101003)(83996005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 08:15:28.7923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f229e9ca-aa37-440e-28d8-08da236f18b2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5737
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra194 and Tegra234 SoCs have the erratum that causes walk cache
entries to not be invalidated correctly. The problem is that the walk
cache index generated for IOVA is not same across translation and
invalidation requests. This is leading to page faults when PMD entry is
released during unmap and populated with new PTE table during subsequent
map request. Disabling large page mappings avoids the release of PMD
entry and avoid translations seeing stale PMD entry in walk cache.
Fix this by limiting the page mappings to PAGE_SIZE for Tegra194 and
Tegra234 devices. This is recommended fix from Tegra hardware design
team.

Co-developed-by: Pritesh Raithatha <praithatha@nvidia.com>
Signed-off-by: Pritesh Raithatha <praithatha@nvidia.com>
Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
Changes in v2:
- Using init_context() to override pgsize_bitmap instead of new function

 drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c | 30 ++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c b/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
index 01e9b50b10a1..87bf522b9d2e 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
@@ -258,6 +258,34 @@ static void nvidia_smmu_probe_finalize(struct arm_smmu_device *smmu, struct devi
 			dev_name(dev), err);
 }
 
+static int nvidia_smmu_init_context(struct arm_smmu_domain *smmu_domain,
+				    struct io_pgtable_cfg *pgtbl_cfg,
+				    struct device *dev)
+{
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	const struct device_node *np = smmu->dev->of_node;
+
+	/*
+	 * Tegra194 and Tegra234 SoCs have the erratum that causes walk cache
+	 * entries to not be invalidated correctly. The problem is that the walk
+	 * cache index generated for IOVA is not same across translation and
+	 * invalidation requests. This is leading to page faults when PMD entry
+	 * is released during unmap and populated with new PTE table during
+	 * subsequent map request. Disabling large page mappings avoids the
+	 * release of PMD entry and avoid translations seeing stale PMD entry in
+	 * walk cache.
+	 * Fix this by limiting the page mappings to PAGE_SIZE on Tegra194 and
+	 * Tegra234.
+	 */
+	if (of_device_is_compatible(np, "nvidia,tegra234-smmu") ||
+	    of_device_is_compatible(np, "nvidia,tegra194-smmu")) {
+		smmu->pgsize_bitmap = PAGE_SIZE;
+		pgtbl_cfg->pgsize_bitmap = smmu->pgsize_bitmap;
+	}
+
+	return 0;
+}
+
 static const struct arm_smmu_impl nvidia_smmu_impl = {
 	.read_reg = nvidia_smmu_read_reg,
 	.write_reg = nvidia_smmu_write_reg,
@@ -268,10 +296,12 @@ static const struct arm_smmu_impl nvidia_smmu_impl = {
 	.global_fault = nvidia_smmu_global_fault,
 	.context_fault = nvidia_smmu_context_fault,
 	.probe_finalize = nvidia_smmu_probe_finalize,
+	.init_context = nvidia_smmu_init_context,
 };
 
 static const struct arm_smmu_impl nvidia_smmu_single_impl = {
 	.probe_finalize = nvidia_smmu_probe_finalize,
+	.init_context = nvidia_smmu_init_context,
 };
 
 struct arm_smmu_device *nvidia_smmu_impl_init(struct arm_smmu_device *smmu)
-- 
2.17.1

