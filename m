Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A3F50474C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 11:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbiDQJH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 05:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbiDQJHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 05:07:23 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940F36456;
        Sun, 17 Apr 2022 02:04:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dlgYq5q7114vEK+dSmQAwtzczD3Jis9PlwAqytXA9G31rauc3HpsGLgmnesuAx9a21P/qFbbdOHDGvzC7kxAAIMd7F0UX3m/AGX0Hd30bNbgHB0+0oBpgDTignM1lTLsHRKslFbNNovbX/JVcV8zgfLWVl2VE/yRW3ac5J50FUV6BFS7db87MQqo0QZGy2wig2cxAlbZMzcFYl4Iy2gCcHpLQddeGNSHCQQDskWbaZlMQ+mmbNiJP2pK6kIdtei4dn47adf9r4OGwjd1O3z+alIuKbrEcBTdnLnoprNUgV83b2c7QxBcPObxVuitvnZh7CkEg2fGXPyiCKZx2DHbpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SG8YOrOqHAJwqMSZB7DKkcZxWNAjqunFBhBOe8/6NAk=;
 b=kL63PD81ozh+I9x91rRmNH7qHhlUxfq8FO9XLgadS9wZ3I+mSBuz9UnIGHVMVW1EAupbn1W4wMoi76pmZ/x2J8ElaOa7H9nWxwGUsNO3cC1mgLjjBs1frFh3qx1pR+ZRNwb3PdvfukVKdjTxLuY6mG0nTQ0AZV70wtdolG6aVFnhaYPr42NqCpVFQyqBmLliy7jWuLJwThkuYjL712lpt/cuoEjpOmZIdGMjsy44S4UnrIpU4/YkWBxWCn2Sq4XPnvSoRyzfN9MIQeOtmMfll/Z0TPsouC9dEo+iJudh08HhlUvVTPNS6/rzqeXNKXfBZ0GH1IOk1c/3oFDr4T0WKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SG8YOrOqHAJwqMSZB7DKkcZxWNAjqunFBhBOe8/6NAk=;
 b=jJrn2VHuJGgd+h1csYVU50j3ZP/dSeFBgUjKQ55g6fS1j1vMsxHTigHR+Emvqt7ecyminwH2ve6ax5JSP7725xtxOBTskilBWBg4zioNqAAg+djX4Z8Tgeul9vknZqFZWj1qCRugBlHorQVYfvsvlrXCBomt1kbzP4j1ASMrFSjxmoL/GLyzPMtvx5WIxKDt9J3oD31XfIH+F4uarWrtWCmcx6FTTQOnkSJVAlBrtVXB0mE9XAKSYEb5zOjnsNmFMeWELl08BzT8w5oKBEsjcvemwDW9J0zG6mhWHxvXIAaVvHcex3zOVtMbAAmFMhIVIHcgpE6ANfMe6iaFaEtKlw==
Received: from BN8PR03CA0006.namprd03.prod.outlook.com (2603:10b6:408:94::19)
 by BYAPR12MB3013.namprd12.prod.outlook.com (2603:10b6:a03:a9::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.25; Sun, 17 Apr
 2022 09:04:45 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::6d) by BN8PR03CA0006.outlook.office365.com
 (2603:10b6:408:94::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18 via Frontend
 Transport; Sun, 17 Apr 2022 09:04:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5164.19 via Frontend Transport; Sun, 17 Apr 2022 09:04:44 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL109.nvidia.com (10.27.9.19) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Sun, 17 Apr 2022 09:04:43 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 17 Apr 2022 02:04:43 -0700
Received: from amhetre.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Sun, 17 Apr 2022 02:04:39 -0700
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <will@kernel.org>,
        <robin.murphy@arm.com>, <joro@8bytes.org>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
CC:     <nicolinc@nvidia.com>, <Snikam@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>,
        Pritesh Raithatha <praithatha@nvidia.com>
Subject: [Patch v1] iommu: arm-smmu: disable large page mappings for Nvidia arm-smmu
Date:   Sun, 17 Apr 2022 14:34:32 +0530
Message-ID: <20220417090432.21110-1-amhetre@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d50f2d1-80a0-4563-9e9c-08da205150ac
X-MS-TrafficTypeDiagnostic: BYAPR12MB3013:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB30131E940283962994FA4469CAF09@BYAPR12MB3013.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Io9RGGAZ58PUas1nqdxPxVxRcExHcCXilmNPKFtiam8cIZo2X52oO2Wm8uFEpgbIzX6PS23dhKla0PgI44tlR33M0kp/Z2wopAQ84VGbsF3C8vHpUgRHok0cLgWozdtY/NOECbgw0PhU2/a85dV58L7sTqkSBpZwcnv9uLPJbEEWHPK8IXh8/4JE4w6Ad/Lkd35gKfdDeiN6b0U6eueeKPkjUOMsnWqy7M/pKJ+TOWzqeIuzD0XTtbkOeU4P0gVuRS+4cEbnYmG1vEZPheYfJCqije0BMlXowoB9FHUHb1q6IK1Jtix8CRFz0msQNTzvlV8+YJFP7eNwLE2LyJgac2l9ZFi/S+bJx8w8n9ExQp5IEsMgWBVIq5ziMU+4cXfLFPNxAML1gl7onrBv5pRsdhs3LzPm4xMknYm1QFEGzjygk3/0DdtB3z1GLSEARbadF0uv+LN25/mDN6DC9KgnTkPUgA3amKFeeEyH/S01dUhQVSMtcZXuONWhR4rQcnwSu4T4U2xHeKsc6WrJeIsgTscXWEi+vVEubMeRkS0c6lpRvQr4O6XT9phsQtHzXuZfECnpyQE9vzOHkNdfWyUnOyagBuBkufKz4f++pCeQ0PjSXRqkBKZ3woR4zvhLoJ1gAqQHxCHcY8gytXtA2gA4g6je8BcEsRg+ud+B4HbGtjIrJseBe9SFEiNsYfdB4vRb4ACUucGjFpiBg84dZsSv06p07LGuDrwFi8wTilU7xrr6JFaRsKKVATkPskm/+uWwYifiMGpxFZgkzLKe+KO2g==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(8676002)(70206006)(70586007)(86362001)(4326008)(7696005)(82310400005)(83380400001)(2906002)(26005)(356005)(40460700003)(921005)(508600001)(81166007)(36860700001)(2616005)(110136005)(107886003)(1076003)(6666004)(36756003)(54906003)(316002)(426003)(336012)(186003)(47076005)(5660300002)(8936002)(2101003)(83996005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2022 09:04:44.2557
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d50f2d1-80a0-4563-9e9c-08da205150ac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3013
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c | 23 ++++++++++++++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu.c        |  3 +++
 drivers/iommu/arm/arm-smmu/arm-smmu.h        |  1 +
 3 files changed, 27 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c b/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
index 01e9b50b10a1..b7a3d06da2f4 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
@@ -258,6 +258,27 @@ static void nvidia_smmu_probe_finalize(struct arm_smmu_device *smmu, struct devi
 			dev_name(dev), err);
 }
 
+static void nvidia_smmu_cfg_pgsize_bitmap(struct arm_smmu_device *smmu)
+{
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
+	    of_device_is_compatible(np, "nvidia,tegra194-smmu"))
+		smmu->pgsize_bitmap = PAGE_SIZE;
+}
+
 static const struct arm_smmu_impl nvidia_smmu_impl = {
 	.read_reg = nvidia_smmu_read_reg,
 	.write_reg = nvidia_smmu_write_reg,
@@ -268,10 +289,12 @@ static const struct arm_smmu_impl nvidia_smmu_impl = {
 	.global_fault = nvidia_smmu_global_fault,
 	.context_fault = nvidia_smmu_context_fault,
 	.probe_finalize = nvidia_smmu_probe_finalize,
+	.cfg_pgsize_bitmap = nvidia_smmu_cfg_pgsize_bitmap,
 };
 
 static const struct arm_smmu_impl nvidia_smmu_single_impl = {
 	.probe_finalize = nvidia_smmu_probe_finalize,
+	.cfg_pgsize_bitmap = nvidia_smmu_cfg_pgsize_bitmap,
 };
 
 struct arm_smmu_device *nvidia_smmu_impl_init(struct arm_smmu_device *smmu)
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 568cce590ccc..3692a19a588a 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1872,6 +1872,9 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 	if (smmu->features & ARM_SMMU_FEAT_FMT_AARCH64_64K)
 		smmu->pgsize_bitmap |= SZ_64K | SZ_512M;
 
+	if (smmu->impl && smmu->impl->cfg_pgsize_bitmap)
+		smmu->impl->cfg_pgsize_bitmap(smmu);
+
 	if (arm_smmu_ops.pgsize_bitmap == -1UL)
 		arm_smmu_ops.pgsize_bitmap = smmu->pgsize_bitmap;
 	else
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index 2b9b42fb6f30..5d9b03024969 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -442,6 +442,7 @@ struct arm_smmu_impl {
 	void (*write_s2cr)(struct arm_smmu_device *smmu, int idx);
 	void (*write_sctlr)(struct arm_smmu_device *smmu, int idx, u32 reg);
 	void (*probe_finalize)(struct arm_smmu_device *smmu, struct device *dev);
+	void (*cfg_pgsize_bitmap)(struct arm_smmu_device *smmu);
 };
 
 #define INVALID_SMENDX			-1
-- 
2.17.1

