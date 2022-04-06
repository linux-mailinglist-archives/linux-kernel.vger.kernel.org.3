Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAAB44F574F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 10:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348967AbiDFHMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 03:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241462AbiDFG6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 02:58:00 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2075.outbound.protection.outlook.com [40.107.102.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B754A62CD;
        Tue,  5 Apr 2022 22:25:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S1pedEADJokrwv6/06KX+zcRNzj0fpegn4CoL5ml3naVCWx+/+XRw6Hius0SxAQKKoKZtWJJp1sd2fgAz+B5ZpoiBh3FYCRom2qpS5siarIuBHnaHdCd3W9Y+VzXREUJE42fW5iDUkP2hnkEdrI05qwiKYN1/i/nTsB3VGua5AUFGjmRs/lUh1R00lWFoBIRMACWosH6iZtGt+jB3ukof8ptHD78jILvIz+VMyRy3EfAjHOKgXKR5lLy9CA3HkzgtkCVV7OUibEIPaRAwK7XjoSp3sLLedMBkPdxkxvp/VeAtLCvbdV3ejG9m8hrUel0kzqYej224KbvXvrE3UJVrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CjXjqq3Eb9hycxwzA64umgnvByy/9XGlqlhfGXTz8iE=;
 b=mBxrcTuQ7GjPNOCg+dF5pMtl3mYkJMwTmQI8pmNzrr1WC8MP08z+bTuxP09BcU5XEeEzVJxXnv5VW0jvUxUpC7z/7EXsxS/y49qmaj/VOExAkBm2Hk5BEVJAGvC6o30geVXF69lu1tyPNgs7FZC+gdnUO94IpnAoda0PdT0t+RZzRsBSnD0Y1Rxxht7c7CyLWVHF+S2QKO+3da774aaeWfb4pbXlx4C+s+FpkryqSNv5Xl5s22F8MaAiWd47w2uQiUoBNAqh2q8UmdGHe59+qVGe2HQ6gLsL4P9/5VD/gadfhkHk6nbQbBJG/emd+ogEDGaGGxri4lMJmkGliq0CEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjXjqq3Eb9hycxwzA64umgnvByy/9XGlqlhfGXTz8iE=;
 b=BKlP9F+P0V8sWbAorejfL837dDYweupu7BvGY39hnJNUAuwFtSTtE8fmhZV9VD6a7FL3iORxN5wrPHs3FkRmALjcWdaYJm92eGRjXxnN36dTCIXw258HlvY1WVxjglj6sdyovVRcPvegf2hf9hDOano/cdA7wR31/+uQJsxGJ9nKvm5pG/SMTdD3sEkytIWjDWu7bjir6fO0lza96wF5QBHdOo/4klnynHMuE0dK0FnS4+P7YVmNKlxV4aEDUGudKVm1T9IvqyHsU2fVRDWRfZ2Z/opqV2wip2SMI9XaPw1ECVlwMG0rKgVk98H6t46ciiBkiBe16H3HjpOV9jeGMQ==
Received: from BN9PR03CA0878.namprd03.prod.outlook.com (2603:10b6:408:13c::13)
 by MW2PR12MB2377.namprd12.prod.outlook.com (2603:10b6:907:11::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.34; Wed, 6 Apr
 2022 05:25:23 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::f8) by BN9PR03CA0878.outlook.office365.com
 (2603:10b6:408:13c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Wed, 6 Apr 2022 05:25:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5144.20 via Frontend Transport; Wed, 6 Apr 2022 05:25:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 6 Apr
 2022 05:25:15 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 5 Apr 2022
 22:25:14 -0700
Received: from amhetre.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Tue, 5 Apr 2022 22:25:11 -0700
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <krzysztof.kozlowski@linaro.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <digetx@gmail.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <vdumpa@nvidia.com>, <Snikam@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>
Subject: [Patch v6 1/4] memory: tegra: Add memory controller channels support
Date:   Wed, 6 Apr 2022 10:54:56 +0530
Message-ID: <20220406052459.10438-2-amhetre@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220406052459.10438-1-amhetre@nvidia.com>
References: <20220406052459.10438-1-amhetre@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba0faf3b-90e2-444b-fdfb-08da178dd95f
X-MS-TrafficTypeDiagnostic: MW2PR12MB2377:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB2377DD557C411B18E9A5ABDDCAE79@MW2PR12MB2377.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ayehiaPlmf8XN4UJqG5V9b00W1e8tnnHSXKiW8vZ67H5FNujBSjyzHlLswqnzSvEFPYjOAAr2xiH8F2zdKh62PB58XgSWlg1yXDzNh+bJfJPZ7uRA55ttrKB2i9nJYW1d+NACXOOB0wabqbxow2h17Qs0AfJbehYZS/3+2Pg2CNEQfcgt6SxqjYz8unN8FBGkUlKgVpKAZOqXI4n8Z5R9HUx++3A1c7sLxbg60r+QMXSGjPXezHKCHC/OyvvTNH+2VLsClxws8kiFEukAzeW5mRYMs7320Rg4zYAc8J5Z34zhDzboa1clL7Q7O72cE0U6iNBUoImPjV9QeMy6EGsbGWxKd3c/RpCyIUFghJVpt6aPG1z03fyqqiEhPhRTWtQKqMl+YG+a5NhH3TSaZSgYt+r4iU9Jm+ns7qT7RPsZpZLnQWxNnJAsNHlpB4TR2fs2/5VuXn4Vg24/9nTC2ou+8G0QGZ0nzRydbeZjbSf8tA8fj2fm2rlRFykiJ4Xl622t5CQG7ON5u9XHNJguQaUPkA05iGsvz4cICnih9i1flUsNLJ7wwFSwOneKUFo1EvJvFAqNUlU+hA4Xiox2AQ82m8Ef8AtfYDBOYBH0zFDdttSM3GA78EJps4EavIJFl165tdoDUAba2e1PvPJAzn3FRGFGeO6uM7Ui5tDKIZy9UXJGbO8SLaO1eY0VF5wN+/+iiXUV12NBds+W4yb4GDcsA==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(6666004)(356005)(83380400001)(36756003)(81166007)(36860700001)(8936002)(5660300002)(70586007)(82310400005)(86362001)(1076003)(7696005)(70206006)(8676002)(426003)(47076005)(4326008)(316002)(54906003)(107886003)(110136005)(40460700003)(186003)(336012)(2906002)(26005)(508600001)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 05:25:22.9246
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0faf3b-90e2-444b-fdfb-08da178dd95f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2377
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From tegra186 onwards, memory controller support multiple channels.
Add support for mapping address spaces of these channels.
Make sure that number of channels are as expected on each SOC.
During error interrupts from memory controller, appropriate registers
from these channels need to be accessed for logging error info.

Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 drivers/memory/tegra/mc.c       |  6 ++++
 drivers/memory/tegra/tegra186.c | 54 +++++++++++++++++++++++++++++++++
 drivers/memory/tegra/tegra194.c |  1 +
 drivers/memory/tegra/tegra234.c |  1 +
 include/soc/tegra/mc.h          |  7 +++++
 5 files changed, 69 insertions(+)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index bf3abb6d8354..3cda1d9ad32a 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -749,6 +749,12 @@ static int tegra_mc_probe(struct platform_device *pdev)
 	if (IS_ERR(mc->regs))
 		return PTR_ERR(mc->regs);
 
+	if (mc->soc->ops && mc->soc->ops->map_regs) {
+		err = mc->soc->ops->map_regs(mc, pdev);
+		if (err < 0)
+			return err;
+	}
+
 	mc->debugfs.root = debugfs_create_dir("mc", NULL);
 
 	if (mc->soc->ops && mc->soc->ops->probe) {
diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
index 3d153881abc1..2ca8ce349188 100644
--- a/drivers/memory/tegra/tegra186.c
+++ b/drivers/memory/tegra/tegra186.c
@@ -139,11 +139,64 @@ static int tegra186_mc_probe_device(struct tegra_mc *mc, struct device *dev)
 	return 0;
 }
 
+static int tegra186_mc_map_regs(struct tegra_mc *mc,
+				struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.parent->of_node;
+	int num_dt_channels, reg_cells = 0;
+	int i, ret;
+	u32 val;
+
+	ret = of_property_read_u32(np, "#address-cells", &val);
+	if (ret) {
+		dev_err(&pdev->dev, "missing #address-cells property\n");
+		return ret;
+	}
+
+	reg_cells = val;
+
+	ret = of_property_read_u32(np, "#size-cells", &val);
+	if (ret) {
+		dev_err(&pdev->dev, "missing #size-cells property\n");
+		return ret;
+	}
+
+	reg_cells += val;
+
+	num_dt_channels = of_property_count_elems_of_size(pdev->dev.of_node, "reg",
+							  reg_cells * sizeof(u32));
+	/*
+	 * On tegra186 onwards, memory controller support multiple channels.
+	 * Apart from regular memory controller channels, there is one broadcast
+	 * channel and one for stream-id registers.
+	 */
+	if (num_dt_channels < mc->soc->num_channels + 2) {
+		dev_warn(&pdev->dev, "MC channels are missing, please update memory controller DT node with MC channels\n");
+		return 0;
+	}
+
+	mc->bcast_ch_regs = devm_platform_ioremap_resource_byname(pdev, "mc-broadcast");
+	if (IS_ERR(mc->bcast_ch_regs))
+		return PTR_ERR(mc->bcast_ch_regs);
+
+	for (i = 0; i < mc->soc->num_channels; i++) {
+		char name[4];
+
+		sprintf(name, "mc%u", i);
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
@@ -875,6 +928,7 @@ const struct tegra_mc_soc tegra186_mc_soc = {
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
index 1066b1194a5a..c3c121fbfbb7 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -13,6 +13,9 @@
 #include <linux/irq.h>
 #include <linux/reset-controller.h>
 #include <linux/types.h>
+#include <linux/platform_device.h>
+
+#define MC_MAX_CHANNELS 16
 
 struct clk;
 struct device;
@@ -181,6 +184,7 @@ struct tegra_mc_ops {
 	int (*resume)(struct tegra_mc *mc);
 	irqreturn_t (*handle_irq)(int irq, void *data);
 	int (*probe_device)(struct tegra_mc *mc, struct device *dev);
+	int (*map_regs)(struct tegra_mc *mc, struct platform_device *pdev);
 };
 
 struct tegra_mc_soc {
@@ -194,6 +198,7 @@ struct tegra_mc_soc {
 	unsigned int atom_size;
 
 	u8 client_id_mask;
+	u8 num_channels;
 
 	const struct tegra_smmu_soc *smmu;
 
@@ -212,6 +217,8 @@ struct tegra_mc {
 	struct tegra_smmu *smmu;
 	struct gart_device *gart;
 	void __iomem *regs;
+	void __iomem *bcast_ch_regs;
+	void __iomem *ch_regs[MC_MAX_CHANNELS];
 	struct clk *clk;
 	int irq;
 
-- 
2.17.1

