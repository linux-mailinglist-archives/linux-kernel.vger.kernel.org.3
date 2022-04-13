Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CB44FF3E3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbiDMJnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234645AbiDMJnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:43:00 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C3C3630F;
        Wed, 13 Apr 2022 02:40:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+Y/wHJg8qjBTOQ6aJ3vj7mXuFaKAw0Jdcff2XJwI8Zw5k01Yrq1J60dJdA2kWPQ6J/KXEc76iZgsHXzit7Vz32xX5P1GSdQqjasFPaOyqUu9XGc1vSXBYZNZ4Tqn2e1gdRymATzr57k7lweginneHk17sPQjFfENj1ySMt4k+bp7QRqQvikgBRyUniTY6pyGJN9HQayAirYpOplUIuWc1t5QFKvpNJYd44ES4fWdVOSUDT+1PKVT9bDIxUS3Qw0MJQvUnybHeuSV8truVlAKyumOsSuH3btLDExfaBA1Ywe81cHCckuaORPEl1ebvL1iitZh+DwccwP40sekT24Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7r4Q0L/4V7oUSMS5KDB3Z8fj0kJ8uJ8u1GZplrGXRo=;
 b=Y67YwSFdYVBGTVKmiuUl6VwfJCMOh+iaJEKqTT8Mv3Nvw0Uc7wAwgesm76jJo6T5y0+Ar+IRjjuWyuaAc9iEoNct6flzLHEBAweYu7BereFmMXArt3sKiDuzYVRMspUfAXoujl8R8THmaoxZjxiWvV2NjybD2H8s43aQSeYOpZWGpS4Gl5pSp4OBsVJFXXBRgPpc14StXHqhONII6SEvELjx5HzTsinDFMTGwhKFlXtXcC2P5OEmjUxGPi3Nt8QlORuegWS9FvtvgfKVDeZb/rH6GYX72oku0dwibuXEik2lphzUv1EqYYo/FJRtwRH26z2Fl16woZcjxyYJmGQ4sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7r4Q0L/4V7oUSMS5KDB3Z8fj0kJ8uJ8u1GZplrGXRo=;
 b=QcFtdlKvzTRKIcpJw0K424lwLoZ1dJycBhAV9YHGl1YHnqziuDh4BSXOvj2XQi7BUscx3iNB4LhgMj6XswGsKPV0GL4MUQ8k6UOlUSgxi+KUL0p7/yxhnF+/2qHSTmbW+xATF/emmcOpAhvfoyDq5t5O/er/9O2GZglAXzE4qcL/CMAN0utRnwCnP7dCiiIqBR4t0PLBRruKlp4KkGvqv99WEWmBukb2aLsnvJPE8rRRhr8FdQQtOLttk3BPcG5nZmJiqaNoxRDKUpCK3HSNc97ZHi6fqku3bcGA/IJz5HQU161b/ZuGCRx+RxTQvjbyif4EejjrL4RlHy6yDXVCVg==
Received: from BN1PR12CA0029.namprd12.prod.outlook.com (2603:10b6:408:e1::34)
 by DM6PR12MB4959.namprd12.prod.outlook.com (2603:10b6:5:208::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 09:40:35 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::34) by BN1PR12CA0029.outlook.office365.com
 (2603:10b6:408:e1::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29 via Frontend
 Transport; Wed, 13 Apr 2022 09:40:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5164.19 via Frontend Transport; Wed, 13 Apr 2022 09:40:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 13 Apr
 2022 09:40:34 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 13 Apr
 2022 02:40:33 -0700
Received: from amhetre.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Wed, 13 Apr 2022 02:40:30 -0700
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <dmitry.osipenko@collabora.com>, <digetx@gmail.com>,
        <krzysztof.kozlowski@linaro.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <vdumpa@nvidia.com>, <Snikam@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>
Subject: [Patch v7 1/4] memory: tegra: Add memory controller channels support
Date:   Wed, 13 Apr 2022 15:10:09 +0530
Message-ID: <20220413094012.13589-2-amhetre@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220413094012.13589-1-amhetre@nvidia.com>
References: <20220413094012.13589-1-amhetre@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82e15140-21e1-49ac-3098-08da1d31a902
X-MS-TrafficTypeDiagnostic: DM6PR12MB4959:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB49592AD785D7509678EA163ACAEC9@DM6PR12MB4959.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7rGlhDLQRfjsU9oPU52TXb4hgMtSRC6gsqdtYjR/fRZfWB5Tpo6nlshRUkQZYkliRlUhxRSgpI/J+W3zUfYPxql94v7Y0ilxKdnolnsf0RQWf3gvAxunOJR3coldkaa/Pn0xV33D0kLPrabgl/XiIMLYh3bFMusLNqqAkzodZfI3+jXRL/5tMCzGRSYq6hjC7rRnbman1KYI2wcc1r7OMqsK1Y1/jKBGuedGWn+//HhjXtfZhE+JIGdMUAB8TGwwKLYE0bPPTf4sZ8TV+I2gCILJgfAjXk1vrHaSsyv+sSzm+ibxUHuGm9gPzPZzIe5JaY+AnhK501H0VCRIVWdRKa4npvLGjL+3tsovv4j8Gmv+3beMhLWO8BWMttNebiKydj74BYmr/V3C+In0PmuAQ4V4Z47Qs1MwV/UCMLJLBSDA6FCs+6QleJiom+wNqUlZXe0PAIJ15bXTRml98wQkSKJWAhj+qI7qjO4RGOvNQOeCnjDlhNUPnG6W/vVqYcTOWCU1N/EIGe8f9smeXqCaEId4RCDbdQhzenhTIxihmRJkl8U0s7DjvpvzhHDvm2SuuTmq08+PWrID9Dex3S79EOKshYoXYFN1IiaW6IhtnWKxprxY/K9Aa9TmdeQDGiCHZaR3Lw8Bs1ThcfCVMGXRDHkTBO2eKusURSQ9GJwAZjU/o8enJhB3T0URJigwkS4VLU1QnBh6GI42EQRQRs8qNA4Q8+AF6jf+HpBdmPmMc+jGQmbQiCvSyqY61LJGWaxzDju65v9pcTRxj1rQ97TkqA==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(336012)(110136005)(81166007)(86362001)(107886003)(2906002)(54906003)(8676002)(6666004)(26005)(2616005)(356005)(1076003)(36756003)(921005)(7696005)(426003)(47076005)(316002)(82310400005)(40460700003)(70206006)(4326008)(70586007)(186003)(83380400001)(5660300002)(36860700001)(508600001)(8936002)(36900700001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 09:40:35.0880
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e15140-21e1-49ac-3098-08da1d31a902
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4959
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
 drivers/memory/tegra/mc.c       |  6 ++++++
 drivers/memory/tegra/tegra186.c | 33 +++++++++++++++++++++++++++++++++
 drivers/memory/tegra/tegra194.c |  1 +
 drivers/memory/tegra/tegra234.c |  1 +
 include/soc/tegra/mc.h          |  4 ++++
 5 files changed, 45 insertions(+)

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
index 3d153881abc1..9b151b98362b 100644
--- a/drivers/memory/tegra/tegra186.c
+++ b/drivers/memory/tegra/tegra186.c
@@ -139,11 +139,43 @@ static int tegra186_mc_probe_device(struct tegra_mc *mc, struct device *dev)
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
+		char name[4];
+
+		sprintf(name, "ch%u", i);
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
@@ -875,6 +907,7 @@ const struct tegra_mc_soc tegra186_mc_soc = {
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

