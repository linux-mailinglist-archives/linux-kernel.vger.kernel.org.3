Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6DE50DAAD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 09:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbiDYH7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 03:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241477AbiDYHzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 03:55:25 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF1040E62;
        Mon, 25 Apr 2022 00:51:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWFQMvxpOMOT20cCEWkyiWewvZIp1W8c7/7/4wULcWNx28Ojzbn5tqNg2BCTbfdzWe3wLiOteJKMyzuTefetbO3dMx2AUAToZJT39MjxVQwcHK1Wr89MWKpssnykE3/wAzQbw1wVad53cPPNWm24j/lockSHhwh4jBZTo9cCoy/jsaWDdSvpy4JpFD1GhmsgXeoc900/inCeBoaUg8Kwm61k6UNhoP26xU2yQ9JnE1kht6kUij3cjCn8jfWGv6vX5yXauZjGCqWl713JZXa+hfzoo6dJ+hh1bSfQQef+sYT6/0tEDklpy3Fek2TaBvBIKxfXV9tCilpsnw9BapR6Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0GuHW/whgoBIZPGoUueykBNGen9uvgcXXeLEcCnips=;
 b=HNt4hQjQrDCaqimBc3/YOC8Z+Rl0m0HZ0idcnUnqY6eQg7bPrMMl54aTPkZG7hD8j9wAEQNAnAcxjLhhYKovi3/UApNxvLgPz9oCDUYpgEzOe0kNRXgLQl/SgwTs6aRS7iZRs5pVVjvuf2lLsqmPaS21SynX3hCjQfvorQKgxVnqUz68Luadu754LxiYXJReSrqWEtaj+uCnl0GG5cegdGsAcYdrAUXGnJE0uTkyO8PH8emn23lQ8Z8DPYfvqD6zE1/a5endpghAGXUvRJu2O5u6ut4FItbfuzJkoGuvE9Kk2l0VNP7rToVshU/s545uG4CP+XfSWzTUjCnk94YO6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0GuHW/whgoBIZPGoUueykBNGen9uvgcXXeLEcCnips=;
 b=DQNnrNCvmH/R6V6JM/BVlbx3KeJc3bu8SK5hKmwn+LCPUQZHB+2868cg+GF1cGzEqWkXA9L76+3szYYbxwLL72/bwAA937/DjYK1SC4MPjQ/4NtX2dzoyhzzLME0tEehy9aX0SDDw3hMwq61uvwUik/mMXzIHj1p3/sjpDIF8rNqawjR5E+NiinxRZoIg+jqdxxf76oISLg6nSobTWWCVA6wFzcMDLYm1uC/nGV+jXQq17ZFF2pzGCjn4nQBw+U3gAmodd00U9ULNZqgVx2LvN0A4CqR+rpDsD+SX9/XqmbSr82gy9gEvgcG6NHwz7vHTB2S3XtbuhlnYQCrHTbIjw==
Received: from DM6PR07CA0086.namprd07.prod.outlook.com (2603:10b6:5:337::19)
 by CY4PR1201MB0119.namprd12.prod.outlook.com (2603:10b6:910:1e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Mon, 25 Apr
 2022 07:51:02 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::8f) by DM6PR07CA0086.outlook.office365.com
 (2603:10b6:5:337::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Mon, 25 Apr 2022 07:51:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5186.14 via Frontend Transport; Mon, 25 Apr 2022 07:51:02 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 25 Apr
 2022 07:51:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 25 Apr
 2022 00:51:00 -0700
Received: from amhetre.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Mon, 25 Apr 2022 00:50:56 -0700
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <krzysztof.kozlowski@linaro.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <digetx@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <dmitry.osipenko@collabora.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <vdumpa@nvidia.com>, <Snikam@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>
Subject: [Patch v8 1/4] memory: tegra: Add memory controller channels support
Date:   Mon, 25 Apr 2022 13:20:33 +0530
Message-ID: <20220425075036.30098-2-amhetre@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220425075036.30098-1-amhetre@nvidia.com>
References: <20220425075036.30098-1-amhetre@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12cc09bd-c64e-42e0-d07d-08da26905818
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0119:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0119AF2D017647F45305C59CCAF89@CY4PR1201MB0119.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: utSbbhFygq/Iyfj/NGX6gxfIFMfS/u22t+ewkgK2yS1Ay8K8jYdPBXBTmPK/qJzx/7Paw9wsMOfr1SG5zNZ33xOuP6MMkv/K38JVhUx1457TD220pb3fXPvAy663RQq6aEMhZV7zbaHAy0jAY4qdlM3rZVfdB354a8zTEUVCkN17divGwsre+RiOTwDMEjm/CuvXKIP17F8Zl8ki2BzZOlDApGE/hrauW4L9Jb6rjY/UNZBpOgDk+qm4PwaagS/WOE2sCw2nVzudiWPDi2j1ocluMB7Fo9zzjz6yL3npCvw6JL4dG8poD16/njVxVM3t7WXYDbCR9tZwvreVMf9XTh2IQASMylFTbiySD5ZF0haMYzh2EK9s0daoZsyv/dSZ0wQIxtBj92NkhyWyiVPikyBDBI/Ylp0lBKltU6xFDlk3/FUwIrYIuup6y9URDSPmtaXZcCjbze8fBjGxFlVyzzsYFoS4xG3yshj9lKRAkNqRUICOrFb/F9yQ5vByEjQXeWUq8RYN7Uwdtcn2wHO5rjIx5or76EnRnpQg/yRd8fMYM+B6tK4FmIjBg4cQbv/d0UiOrQVzmhmpKkD1K3mabRh0ZNIkvsQjjeO0hcxxsjtw04dWC6tLiDjaUCsqkOqs0vrVBXaByDuBmQzmEPfx//fF6WIaAm/R4O6nrosu02CZ+DP/Tz7zz+kviQ6t8R+zpmn+O7anTifsH9t2jr6bhsxOEWC9HWmJdOqxV2Iz4c4=
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(426003)(47076005)(336012)(4326008)(1076003)(26005)(82310400005)(5660300002)(186003)(8676002)(70586007)(110136005)(54906003)(36756003)(40460700003)(8936002)(36860700001)(70206006)(316002)(81166007)(508600001)(83380400001)(6666004)(107886003)(2616005)(7696005)(86362001)(356005)(921005)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 07:51:02.0263
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12cc09bd-c64e-42e0-d07d-08da26905818
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0119
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From tegra186 onwards, memory controller support multiple channels.
Add support for mapping address spaces of these channels.
Add number of channels supported by tegra186, tegra194 and tegra234.
In case of old bindings, channels won't be present. If channels are not
present then print warning and continue so that backward compatibility
will be preserved in driver.
During error interrupts from memory controller, appropriate registers
from these channels need to be accessed for logging error info.

Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 drivers/memory/tegra/mc.c       |  6 ++++++
 drivers/memory/tegra/tegra186.c | 34 +++++++++++++++++++++++++++++++++
 drivers/memory/tegra/tegra194.c |  1 +
 drivers/memory/tegra/tegra234.c |  1 +
 include/soc/tegra/mc.h          |  4 ++++
 5 files changed, 46 insertions(+)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index bf3abb6d8354..c1dd24542093 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -749,6 +749,12 @@ static int tegra_mc_probe(struct platform_device *pdev)
 	if (IS_ERR(mc->regs))
 		return PTR_ERR(mc->regs);
 
+	if (mc->soc->ops && mc->soc->ops->map_regs) {
+		err = mc->soc->ops->map_regs(mc);
+		if (err < 0)
+			return err;
+	}
+
 	mc->debugfs.root = debugfs_create_dir("mc", NULL);
 
 	if (mc->soc->ops && mc->soc->ops->probe) {
diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
index 3d153881abc1..6bc1d0336e37 100644
--- a/drivers/memory/tegra/tegra186.c
+++ b/drivers/memory/tegra/tegra186.c
@@ -139,11 +139,44 @@ static int tegra186_mc_probe_device(struct tegra_mc *mc, struct device *dev)
 	return 0;
 }
 
+static int tegra186_mc_map_regs(struct tegra_mc *mc)
+{
+	struct platform_device *pdev = to_platform_device(mc->dev);
+	int i;
+
+	mc->bcast_ch_regs = devm_platform_ioremap_resource_byname(pdev, "broadcast");
+	if (IS_ERR(mc->bcast_ch_regs)) {
+		if (PTR_ERR(mc->bcast_ch_regs) == -EINVAL) {
+			dev_warn(&pdev->dev, "Broadcast channel is missing, please update your device-tree\n");
+			mc->bcast_ch_regs = NULL;
+			return 0;
+		}
+		return PTR_ERR(mc->bcast_ch_regs);
+	}
+
+	mc->ch_regs = devm_kcalloc(mc->dev, mc->soc->num_channels,
+				   sizeof(void __iomem *), GFP_KERNEL);
+	if (!mc->ch_regs)
+		return -ENOMEM;
+
+	for (i = 0; i < mc->soc->num_channels; i++) {
+		char name[5];
+
+		snprintf(name, sizeof(name), "ch%u", i);
+		mc->ch_regs[i] = devm_platform_ioremap_resource_byname(pdev, name);
+		if (IS_ERR(mc->ch_regs[i]))
+			return PTR_ERR(mc->ch_regs[i]);
+	}
+
+	return 0;
+}
+
 const struct tegra_mc_ops tegra186_mc_ops = {
 	.probe = tegra186_mc_probe,
 	.remove = tegra186_mc_remove,
 	.resume = tegra186_mc_resume,
 	.probe_device = tegra186_mc_probe_device,
+	.map_regs = tegra186_mc_map_regs,
 };
 
 #if defined(CONFIG_ARCH_TEGRA_186_SOC)
@@ -875,6 +908,7 @@ const struct tegra_mc_soc tegra186_mc_soc = {
 	.num_clients = ARRAY_SIZE(tegra186_mc_clients),
 	.clients = tegra186_mc_clients,
 	.num_address_bits = 40,
+	.num_channels = 4,
 	.ops = &tegra186_mc_ops,
 };
 #endif
diff --git a/drivers/memory/tegra/tegra194.c b/drivers/memory/tegra/tegra194.c
index cab998b8bd5c..94001174deaf 100644
--- a/drivers/memory/tegra/tegra194.c
+++ b/drivers/memory/tegra/tegra194.c
@@ -1347,5 +1347,6 @@ const struct tegra_mc_soc tegra194_mc_soc = {
 	.num_clients = ARRAY_SIZE(tegra194_mc_clients),
 	.clients = tegra194_mc_clients,
 	.num_address_bits = 40,
+	.num_channels = 16,
 	.ops = &tegra186_mc_ops,
 };
diff --git a/drivers/memory/tegra/tegra234.c b/drivers/memory/tegra/tegra234.c
index e22824a79f45..6335a132be2d 100644
--- a/drivers/memory/tegra/tegra234.c
+++ b/drivers/memory/tegra/tegra234.c
@@ -97,5 +97,6 @@ const struct tegra_mc_soc tegra234_mc_soc = {
 	.num_clients = ARRAY_SIZE(tegra234_mc_clients),
 	.clients = tegra234_mc_clients,
 	.num_address_bits = 40,
+	.num_channels = 16,
 	.ops = &tegra186_mc_ops,
 };
diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
index 1066b1194a5a..42b9c509773e 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -181,6 +181,7 @@ struct tegra_mc_ops {
 	int (*resume)(struct tegra_mc *mc);
 	irqreturn_t (*handle_irq)(int irq, void *data);
 	int (*probe_device)(struct tegra_mc *mc, struct device *dev);
+	int (*map_regs)(struct tegra_mc *mc);
 };
 
 struct tegra_mc_soc {
@@ -194,6 +195,7 @@ struct tegra_mc_soc {
 	unsigned int atom_size;
 
 	u8 client_id_mask;
+	u8 num_channels;
 
 	const struct tegra_smmu_soc *smmu;
 
@@ -212,6 +214,8 @@ struct tegra_mc {
 	struct tegra_smmu *smmu;
 	struct gart_device *gart;
 	void __iomem *regs;
+	void __iomem *bcast_ch_regs;
+	void __iomem **ch_regs;
 	struct clk *clk;
 	int irq;
 
-- 
2.17.1

