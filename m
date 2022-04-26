Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA4F50F2D3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344134AbiDZHmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344098AbiDZHmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:42:00 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61B61331AD;
        Tue, 26 Apr 2022 00:38:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+PVu6NpFlAlXb2pESOOfxbmDHtew38bYnwuZsnxpc1nTznGU8HHtVt9IERk2CSWoQvgFran2dspV6bokGQbyOJ0gfmVfVXf8xMlAdw5sOMqVfnYYsCq+jWkHlu7d7yW6vfbKnMXxMkp1E83Lkqvmy2VNxGUXo+CtAzwuCwpQeYULdZnESikvP2nUkMVJBzexuTtG930OrJ6ZGFtfSOBvwaRSkR2AX5mA+KU8tAa78wd0yL3yJZ9pPbWuBb+tiXU2Sosf4Fpbk3nVv+3NgXYwwaE3o12SsDsh+QYGrsawGkJOabAQ5HE2CuTNndSyfqe6SdVfMo45Ev/i7nCS7h84A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4+iOkMEgxHudzLmFWp4EWIwA3zTti/25MkODhPY9Aw=;
 b=BZRylmcr3TEVWjeUPYp8BYq3C7xL/T/HVXwVwDkZh+yZA9JqvVXJu4O1qCHImRy4n7fCY+fn4jOcPD3KfTQMX07/OilBTy06VWMzr33zj1hh7bVluk1mQsfSumBF0TvxnXnXrTo6vnG3o5fLp5oQJU1zhbNUMjwemgoY3vevgXHWaMyxLVuIT2hqfK64kCVFpYB+451B4BOCY1aPXAebkHtGpWATSXLnLTeFSAYjMoLz8a+RysImZV8pk+M3Tf4t9MMthqRzZVC0xQpjywz1OoPxkkubiqZI+EijS4W+lmYAyEq3oTvMb74kToYnIXd4hsvkATQ+Q5E/xddRiBm86g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4+iOkMEgxHudzLmFWp4EWIwA3zTti/25MkODhPY9Aw=;
 b=l74DsnhLK1dX+hyGn/JIY6FlqflnfLGbwp5LZzU2rT0L6H1G9A4XV/S+SFfv1wWBRSVMyiOlR6hcQ43zcxQGXMopbURGTDY8V5l0g/z2lJM2RGyhrjjP8gghwVr30mWV32VTtSv90GqAgB6/Iyxk+DJm2avvMKnWFpwqNikGH7TiBT0C8iEd/FQ81I/4qq7MXFV1FNJ7f92U9xwPY4b+XV/OdPOlmsw1g2wsezGiGr2ieSyaatyNdqAQx2H43TLK1PUlMlRITotIB2qa2tT/r/xWIEvfJf/7HqmsZMl256CqfwCugWYfXsXtouULJTZ74hz0Pb7zhZVaUmA/bUOtdQ==
Received: from BN9PR03CA0036.namprd03.prod.outlook.com (2603:10b6:408:fb::11)
 by CY4PR12MB1413.namprd12.prod.outlook.com (2603:10b6:903:39::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.18; Tue, 26 Apr
 2022 07:38:52 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::d6) by BN9PR03CA0036.outlook.office365.com
 (2603:10b6:408:fb::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Tue, 26 Apr 2022 07:38:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5186.14 via Frontend Transport; Tue, 26 Apr 2022 07:38:51 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Tue, 26 Apr 2022 07:38:50 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 26 Apr 2022 00:38:50 -0700
Received: from amhetre.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Tue, 26 Apr 2022 00:38:46 -0700
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <krzysztof.kozlowski@linaro.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <digetx@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <dmitry.osipenko@collabora.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <vdumpa@nvidia.com>, <Snikam@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>
Subject: [Patch v9 1/4] memory: tegra: Add memory controller channels support
Date:   Tue, 26 Apr 2022 13:08:24 +0530
Message-ID: <20220426073827.25506-2-amhetre@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220426073827.25506-1-amhetre@nvidia.com>
References: <20220426073827.25506-1-amhetre@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6496e785-a644-426e-5f0e-08da2757cf2a
X-MS-TrafficTypeDiagnostic: CY4PR12MB1413:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1413568C24189E6B233077ACCAFB9@CY4PR12MB1413.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ae0KYFVfcPU9QzoXPAyAR6e2mP5upyTd9YF9SLpzUynzvvOPVmARvEGT3HY0Xg2sUMR/UiSoFsLoCGtvl8kyoVdPgNdHtVTPeFQfMibEuah8wh1+yih1wtvWnU7DfHqUFHdWnu0+MVKyxldPWW8yeekGc0kBWdBkZn2puKD20L8LK9D2idEFX1WmXtAIDIYnPn/l/1PI5XkP5/Fp4EEXbKNTzdDE4nVmiw+hK405KkBSy5SCDKfwLYKHVOf5gxjhuC1Vsy9dZyd63sZdnqTget1zVBQqPMOxB+m5sVZkOD1VMFCqjmzevGcLEwPmwZUsem5vTfgiJzgnq9vS1K3sMVFVLzYINo09Efra/gD5YtMwc0ppdQGMEdOlqou4hWo0ZQHYSUe99P/abEEhNnWwuSPQ2JH6llkgjH3qh/938Hy+Qk+YrHEA1g3xGuH0nhInzAxGqkMF0+nOpZMOeTiEtABl7rP98UEKMD/9Z01vZpbDY/7AKwspuZsG62SbB+ZtyGJ3CCAih6zE7WtCYeWzqjoBe1Ffxty1ftd5jHcvMIHFz5UhmdbyByzxhLZ5z1YcMH8S9ueSIy2RqCqy5jtBocxVN2F4Fh7+ikkt1D8Faubd2HcEPO8SNJvxeqd1daimJfGbtby9zJK2zXGqHUrejg2AqAnsAAEDl5d6fUsJtD6cIya79u7VwL1em5XVp7rnH3nEndg0ujkxNl9svV+E/vzViRAO5hiqJEVo0ilxNRA=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(54906003)(110136005)(82310400005)(70586007)(8676002)(81166007)(86362001)(921005)(316002)(356005)(47076005)(83380400001)(36860700001)(107886003)(36756003)(5660300002)(4326008)(2906002)(70206006)(426003)(1076003)(186003)(336012)(2616005)(26005)(508600001)(7696005)(6666004)(8936002)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 07:38:51.5926
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6496e785-a644-426e-5f0e-08da2757cf2a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1413
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

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
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
index 3d153881abc1..e20ea38d5f35 100644
--- a/drivers/memory/tegra/tegra186.c
+++ b/drivers/memory/tegra/tegra186.c
@@ -139,11 +139,44 @@ static int tegra186_mc_probe_device(struct tegra_mc *mc, struct device *dev)
 	return 0;
 }
 
+static int tegra186_mc_map_regs(struct tegra_mc *mc)
+{
+	struct platform_device *pdev = to_platform_device(mc->dev);
+	unsigned int i;
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
+				   sizeof(*mc->ch_regs), GFP_KERNEL);
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

