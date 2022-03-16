Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2161E4DAD66
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 10:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354852AbiCPJ1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 05:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345828AbiCPJ1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 05:27:04 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7463C62A3D;
        Wed, 16 Mar 2022 02:25:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtbfqtQAs85FyoCFmjdyI+YL3Z5lmdrV/I+cQX9FMmJH20xCoyyMhfabew2jxJblNvxelj6cBkuOeRe/DJdao5RuLuvFRLcsDgKIMmirmF3QVSy3DbZjU8NLYonHZyyuiLBUaQDWVp7VKKqkzi/YeCIFTmi6tBTMiBmlvjpIVXauwfIMMqviR3f89gE18xBZXCdwZlReQxUmaHKCsO99qUvnnYZ+S/6AHNK2i31OUmkRje2I+E7+1Pfu7JxcBpnauD5fS/0xAwk1JLJJnBPAHEUPHDsiIG1xMR1L26YrKJPPRo+arI6ZzqCD/Qn1QDGH28ywbPSJZ7GhcmGoVQBKhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iir9LMNTJGer+eHTQxxbGOmojodr9ahIfMkJS+CROIM=;
 b=hJ8Y5IYO3yWEHLMIjT77Lsc+znBHoDrXQaFprtJyDyXrIz4SQ1+EGEfgA3520NeZR4i3nUr1m2D6pw/pw2U+4mImZ+FHSTauQnaR9TlIWGurCs1wV1I+vbbf10fxlq91dhnTQd0qFbSNYB5y1d7UQdf830HrtsxgK23PhEXPZIeynUJBlFOIyAbStYc+9z1oCoVOnzyulPa4qYBHn0S6Zyr8hYJu15oosKfYlSBI8ANB4PkQW3evOr02Gtxe2LyO186kVBZ9wze0c6aIxgWVNIohEZGWV2efuvrQWC+Ja6KGC1sa/TdbQKnpeMLy8hItp5kVhHBiaBT4BkSBoXeY8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iir9LMNTJGer+eHTQxxbGOmojodr9ahIfMkJS+CROIM=;
 b=WfPT/e2TD0hGkDRtrwt+x4M9Yb4ibuBg4vmBBn4HmaDqOv6kX/xCZ6dpbEY4UoXNi3XJsQxMdcLz9vf1DVOjorDAx03QeM72gqJgAX1RSg2avSDx95Ry3e54BH3fjRVFqIlnsNBXgTRdFDcDFbtW5sEDxvGfrpmK/zd54iqTSlvdLKEHURrYaIrjPQ6hVzfFyO9mRpnkjHSZf3go6xuSJsNMTIkRBRiAIAZBe+gl0kn+kEOjILWsFs3OYLJ7OQ41tG3ze/HYr7FRmNdUPf/ixk/tNeXGagb5bP2zrY+szSARi/EOnrdUsX5zi4kgiVvfabtYSnK/XvXXQy03JrsvQA==
Received: from DM6PR07CA0121.namprd07.prod.outlook.com (2603:10b6:5:330::33)
 by SN6PR12MB2846.namprd12.prod.outlook.com (2603:10b6:805:70::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Wed, 16 Mar
 2022 09:25:48 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::56) by DM6PR07CA0121.outlook.office365.com
 (2603:10b6:5:330::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22 via Frontend
 Transport; Wed, 16 Mar 2022 09:25:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5081.14 via Frontend Transport; Wed, 16 Mar 2022 09:25:48 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 16 Mar
 2022 09:25:47 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 16 Mar
 2022 02:25:45 -0700
Received: from amhetre.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Wed, 16 Mar 2022 02:25:42 -0700
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <krzysztof.kozlowski@canonical.com>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <digetx@gmail.com>,
        <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>
CC:     <vdumpa@nvidia.com>, <Snikam@nvidia.com>, <amhetre@nvidia.com>
Subject: [Patch v5 1/4] memory: tegra: Add memory controller channels support
Date:   Wed, 16 Mar 2022 14:55:22 +0530
Message-ID: <20220316092525.4554-2-amhetre@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220316092525.4554-1-amhetre@nvidia.com>
References: <20220316092525.4554-1-amhetre@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 432e1537-0d9d-4266-5044-08da072ef4b3
X-MS-TrafficTypeDiagnostic: SN6PR12MB2846:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB28467BC726A44B7B5511E151CA119@SN6PR12MB2846.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IPVRaC0zkQ81uyv+EOyKliEs3XCyeKPSr5pselrw+p9x560dVvWwnWPmBGWEm5GfnTVMUMSwY/Um3WDKSjx9tAU7e5IMb82xhRqPCvaAlqIvgYHoOMxHh2NdoJuVwTQLzqdiMvX+Kplf6HnDRB901qmetYD4QCSH9RyBx5GekZbLFfED8Qhm6tBNt4MhK6Fy3V0wVyh+26/8han/VCSwjphltZ5Lvl8M5LfehC0b1XR5CqEnMzUMdMGnX0/8p+K/w62xn0wtun2hzZYRVO8rU5XxhnseJ3IGl3w50C9Rs4CGJFHk2LKKp1NEzfOZeRKTmW2po7YEI+fbGiemsUI29zJzW3y218QckxuwD7upAy5KJhU4Ng1OTd+P7zI9SIn3oFVraFiDx4b6aFrm7qiaeHuncFieveq0RkhlDBxWjH68gMz09UdhRRzop3P3cNxXiWHHnCHlXp+VZa4cv5b32iN1rJFXPS7ExCLAqYKoRaKpsJ67PPbj5EJSchq4keekPgmhzZHAwhjhez4aURnYZpGiIYWyW3Jv9akZPHsrLRZFeMlywrjogZ+essRv0HdQcacyBQ2b2bFGUrxYQiT2iIYox+fymqgXmOvzCLET5egVWQVEaNBTYPAFC8oPu26f73DM0jcjZEyFoeypwqtopG41UcAa2PATLlnBCKRYmfZHUJqRxx4qHAOdD5VL9wjV7cHJxtOGnwsj1S8RijmNrg==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(316002)(110136005)(7696005)(54906003)(36756003)(83380400001)(6666004)(2906002)(2616005)(336012)(70586007)(508600001)(186003)(26005)(1076003)(4326008)(426003)(70206006)(8676002)(40460700003)(36860700001)(47076005)(82310400004)(5660300002)(8936002)(356005)(86362001)(107886003)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 09:25:48.0222
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 432e1537-0d9d-4266-5044-08da072ef4b3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2846
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/memory/tegra/tegra186.c | 52 +++++++++++++++++++++++++++++++++
 drivers/memory/tegra/tegra194.c |  1 +
 drivers/memory/tegra/tegra234.c |  1 +
 include/soc/tegra/mc.h          |  7 +++++
 5 files changed, 67 insertions(+)

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
index 3d153881abc1..a8a45e6ff1f1 100644
--- a/drivers/memory/tegra/tegra186.c
+++ b/drivers/memory/tegra/tegra186.c
@@ -139,11 +139,62 @@ static int tegra186_mc_probe_device(struct tegra_mc *mc, struct device *dev)
 	return 0;
 }
 
+static int tegra186_mc_map_regs(struct tegra_mc *mc,
+				struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.parent->of_node;
+	int num_dt_channels, reg_cells = 0;
+	struct resource *res;
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
+		dev_warn(&pdev->dev, "MC channels are missing, please update\n");
+		return 0;
+	}
+
+	mc->mcb_regs = devm_platform_get_and_ioremap_resource(pdev, 1, &res);
+	if (IS_ERR(mc->mcb_regs))
+		return PTR_ERR(mc->mcb_regs);
+
+	for (i = 0; i < mc->soc->num_channels; i++) {
+		mc->mc_regs[i] = devm_platform_get_and_ioremap_resource(pdev, i + 2, &res);
+		if (IS_ERR(mc->mc_regs[i]))
+			return PTR_ERR(mc->mc_regs[i]);
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
@@ -875,6 +926,7 @@ const struct tegra_mc_soc tegra186_mc_soc = {
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
index 1066b1194a5a..92f810c55b43 100644
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
+	void __iomem *mcb_regs;
+	void __iomem *mc_regs[MC_MAX_CHANNELS];
 	struct clk *clk;
 	int irq;
 
-- 
2.17.1

