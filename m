Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2604C9FA4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 09:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240190AbiCBIpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 03:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239779AbiCBIpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 03:45:13 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE9A42EC9;
        Wed,  2 Mar 2022 00:44:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A3dy96kTHq5/e3fKXMBY+b2iZuv6qXv7zUmRzri1LGmg1TZusv34Rilla9aI8dMfOJKLEzR6gSTJaZOAKMB7ZUj8+6iQQa91ERfgHCivWzchf+iiCFr+Vhen8N6Xm3XY1WlCeO+GuKg8XWXrcdAEQ7gZFHh2Gzbdl2ojxT4Voh+UShPmXAVeRu9ISmbP2X0zcP3XqfEJb5XaSrtrnwvpsdMftT3a+3+EULrz3TPHOBN6vt8VjjCRtf8KmEkAa1bDSTZBsg+5xgV2Bs6CpFlmZ8ng5W3a2js8XSLuvbKiLydNXfNPfM2GCR407VsIWR9DRhITUhO3IVoZnMNWmtd5rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0IRx0PsXAdMbu3v2NJGnHiJ8+paiR4YD/DgRAJb8sU=;
 b=ZDB+Zc7M6DjMs+ALzYyZICpsBZa9RxTyV9pmWlXZjlftQs8efbdC41xPEaEY+W6UbXCl3IYKnETvghBXHDxuwKohosiFc+cPXNv+8b5RGXEeMYxWCZT0R+8IWFlxqZ+cT1j6uTuNCI8pq5+KsowRjJ98bcM7AgSFdkY7cg/t/fzRIvyK+IcO5yBQEO/iEp2Q8y55FHCABsod5JLpbd5OdCHBzWzaPjHFgx4sN001CegW6qgX1SOOlWJeZLqI4KKX5+DWkKLEH7dJmewztUSHZJ0/VUwNQM4dQeC/egn9cVOmvDj3uVxBQJ+xAzwdkYAe8dYcl30oa5erV3c6pPkVlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0IRx0PsXAdMbu3v2NJGnHiJ8+paiR4YD/DgRAJb8sU=;
 b=B4Zh+ziUN0KaNkNk864aUjmdenYdygzWaiZuyJLaRQ98+JDc66QW20guMQ+GMILU7ysx2EJwQl3Qoa5xushiaAU6IfAi9A8OggMfzdNijxk9E3GIrX4+gBg/1/etuZu13hSBW2cA3afU72GFpecjGjskVLKhUJVl+PVfVHMMmrbXd8q0cr27ETn7bx4LTX7gyLp+UGnfcpLpqXBB0wWhhglx1JK7OaRHj0UZiulseXqljHz+tHysQShr9LF7WIDJRyDS1jaBcNZKq94e0aT+JGE+8MOA2PqbdIng4+f6kS77KQEvVT0NAQFpltwAvwbx25wISpW0D3pdbW7SVMtj/Q==
Received: from MW3PR05CA0028.namprd05.prod.outlook.com (2603:10b6:303:2b::33)
 by BN8PR12MB3249.namprd12.prod.outlook.com (2603:10b6:408:68::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Wed, 2 Mar
 2022 08:44:27 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::85) by MW3PR05CA0028.outlook.office365.com
 (2603:10b6:303:2b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.9 via Frontend
 Transport; Wed, 2 Mar 2022 08:44:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5038.14 via Frontend Transport; Wed, 2 Mar 2022 08:44:26 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 2 Mar
 2022 08:44:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Wed, 2 Mar 2022
 00:44:24 -0800
Received: from amhetre.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Wed, 2 Mar 2022 00:44:20 -0800
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski@canonical.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <digetx@gmail.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>
CC:     <vdumpa@nvidia.com>, <Snikam@nvidia.com>, <amhetre@nvidia.com>
Subject: [Patch v4 3/4] memory: tegra: Add memory controller channels support
Date:   Wed, 2 Mar 2022 14:13:28 +0530
Message-ID: <1646210609-21943-4-git-send-email-amhetre@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1646210609-21943-1-git-send-email-amhetre@nvidia.com>
References: <1646210609-21943-1-git-send-email-amhetre@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c7c4b1a-7f4f-454a-9585-08d9fc28dbc8
X-MS-TrafficTypeDiagnostic: BN8PR12MB3249:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB32499A45670BEB66064D35D1CA039@BN8PR12MB3249.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BaS1j+ZHh3TBsVQTAUquaQx+8AjWkoCiicfpSuaVMiduzeg2NXMDCkPye/t/BY0/dAGoRFMkURaovkW3h/ZHkeaFJeSya5QzWwGWPGpNzapZjmFDFTM5kOf2SvBMMR6kAFswnXKq/zV8oAQocoUl192LgS8oUAyRZremg3lxEohNDUK726JTid0u/xL1e907eC7UYSqX4ELo/HjN8f5krT1xLKn6DGO/MGHYS1DYhnvUbs7rZjgIsEgdOSfVuDp9SQWcGkgStBI8PiFim8RWwHSHsF1SyU2IIAowpbutQU20pF17rklz7EjtpEOij4JPZovynTBAQqXx795Gpo6VB+Mg/xmrC6HxoCGHLfZM52FA0vLSteiuzEVwqO2lPj4YrJjxSOeP5Pyxp/vh7ZvQLpng5KhLT+3T3UK+k/2RcJYGpRbA/UR5F+pHa230xUnxlMuhFSKsQEhHCjccH2CDnOq4n4ASrSuf323vk3P+oYqOC9xgwYyk4e2hbgvYjrwWQ9tJVGh07sLkBXSWfHPag9f9bKKuJAuXMEz2ab40WidDeLCJECz1YBzJCwv1k/5451kcyLud+CjoU2/VFfNnV93C/6GJM9NkrNnvt9a2FmojInmYN47KuIUX2vbPr0wfH3Ko4GRGLw7CukhUq3CNaYn+rMmA4Vw+eibm2hYenwPhzbXg+pQfch/Ri2OEJPNgSRFTAYMezgjzDZxPuYM7BA==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(5660300002)(426003)(7696005)(336012)(47076005)(81166007)(107886003)(356005)(36756003)(83380400001)(2616005)(2906002)(40460700003)(26005)(186003)(110136005)(54906003)(70206006)(8676002)(86362001)(4326008)(8936002)(70586007)(82310400004)(36860700001)(508600001)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 08:44:26.4633
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c7c4b1a-7f4f-454a-9585-08d9fc28dbc8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3249
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
During error interrupts from memory controller, appropriate registers
from these channels need to be accessed for logging error info.

Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 drivers/memory/tegra/mc.c       |  6 ++++++
 drivers/memory/tegra/tegra186.c | 21 +++++++++++++++++++++
 drivers/memory/tegra/tegra194.c |  1 +
 drivers/memory/tegra/tegra234.c |  1 +
 include/soc/tegra/mc.h          |  7 +++++++
 5 files changed, 36 insertions(+)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index bf3abb6..3cda1d9 100644
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
index 3d15388..59a4425 100644
--- a/drivers/memory/tegra/tegra186.c
+++ b/drivers/memory/tegra/tegra186.c
@@ -139,11 +139,31 @@ static int tegra186_mc_probe_device(struct tegra_mc *mc, struct device *dev)
 	return 0;
 }
 
+static int tegra186_mc_map_regs(struct tegra_mc *mc,
+				struct platform_device *pdev)
+{
+	struct resource *res;
+	int i;
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
@@ -875,6 +895,7 @@ const struct tegra_mc_soc tegra186_mc_soc = {
 	.num_clients = ARRAY_SIZE(tegra186_mc_clients),
 	.clients = tegra186_mc_clients,
 	.num_address_bits = 40,
+	.num_channels = 4,
 	.ops = &tegra186_mc_ops,
 };
 #endif
diff --git a/drivers/memory/tegra/tegra194.c b/drivers/memory/tegra/tegra194.c
index cab998b..9400117 100644
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
index e22824a..6335a13 100644
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
index 1066b11..92f810c 100644
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
2.7.4

