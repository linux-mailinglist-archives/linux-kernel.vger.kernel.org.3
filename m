Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7D2514847
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 13:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358546AbiD2Lia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 07:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358560AbiD2LiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 07:38:20 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2062.outbound.protection.outlook.com [40.107.95.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3751DBF52E;
        Fri, 29 Apr 2022 04:34:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lcu1T6z0SxMmt+JiH81AQ2yw1BQ5myMZvYKNMRR+vVdBFcvj9WqyxkgAc5OF3szDCeNpAeIeCCZ9siZpVOMhiXogeTKY85XjAckzySFU+eCOGplYM931EaNvpwynAA8hLakb7W6Im7lLF30D1ssB4VRT+1BPCDoHGxybI26UhmhIhKzmFDlaFtG+jdNWhYPiuPLHZy3dv3WYekjc1YYoxuEVUX72ss1g5asCre373y51dzAjfNcjuH5hzRZtXmBt7FlcTz5Jju4VkV6lXAnoNJ2NuZtSmk1nyC4t2kmDymcDdIalrMWIrCBJsTtr6Cb+q7H8DmUMq2vg9aAXJhBJ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XkTSpj8sk7U5I1jwmlzm2tluwv9J9oIwOQjyZTXC1To=;
 b=Oup660UJZ4oTCb4IlkzvZUhuwG2yiM2aSxQQukPbdxydwLd2Lp40BaThzozjrkzLc4Ya+OupcgxoyFmSblOzDklwkWtabKevgd25s3jCdUvm7z0jlgl6v0l/RyS763UOIIWLVfmDTljJjf9wVGQX/jvQeollfYjEauGpNwTmJSPBcv+mBVa7WLwqKXrx4EclsZ/Bpk60awrjlF2DzOSU5W3r2DtSJDiUHKZMfPnwaRFtDUVQwi9O4LeAn2GO18v2Mw2J3gfVKgVCKLphXqkshvHo3xqb9DqSSmBD5Wk5G77SpVGGOwPByRTGo4m+myTd8UCQdgF3w8EKjbcKJ3ac/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkTSpj8sk7U5I1jwmlzm2tluwv9J9oIwOQjyZTXC1To=;
 b=ddfPicAX8d/o01nw8BBz3ym85HelY+Kieo+ccq8c7JdbrdTYxIOfPpRd5B0Csvh3kyaDnlsKM7gHocpXlku/Ln1P9n5MrmnjeK4CvDKwJJwTdav17jpGa5Vs7fuzk+pN+1yNt0Ln7MUUWul5TACxLZ+WzqmVLOchtXmRhTUTTYRwn/QajS5HgSC+sAqQ/D3OmI1+6/H2JKSxj5Ea1ihmvgPruhHR14/BhYfHzgL8nWVJStK1lkwiam0D0aONo92bJ1TWj3XpezFtzR50zgobA4jEkyq8MaiFdo4oSo7S5xHlle7EAFs0POatrBvFkw0hOjVL8ujcA5Jrp7jpTDn5Dw==
Received: from DS7PR07CA0017.namprd07.prod.outlook.com (2603:10b6:5:3af::14)
 by LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Fri, 29 Apr
 2022 11:34:54 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::35) by DS7PR07CA0017.outlook.office365.com
 (2603:10b6:5:3af::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Fri, 29 Apr 2022 11:34:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 11:34:54 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 DRHQMAIL105.nvidia.com (10.27.9.14) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Fri, 29 Apr 2022 11:34:53 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 29 Apr 2022 04:34:52 -0700
Received: from amhetre.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Fri, 29 Apr 2022 04:34:48 -0700
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <krzysztof.kozlowski@linaro.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <digetx@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <dmitry.osipenko@collabora.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <vdumpa@nvidia.com>, <Snikam@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>
Subject: [Patch v10 1/4] memory: tegra: Add memory controller channels support
Date:   Fri, 29 Apr 2022 17:04:35 +0530
Message-ID: <20220429113438.13988-2-amhetre@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220429113438.13988-1-amhetre@nvidia.com>
References: <20220429113438.13988-1-amhetre@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1dda27c2-420f-43c3-1a79-08da29d4480f
X-MS-TrafficTypeDiagnostic: LV2PR12MB5990:EE_
X-Microsoft-Antispam-PRVS: <LV2PR12MB59908D33035043069E1092F0CAFC9@LV2PR12MB5990.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eWlS3rBl46gL0ZsAKQ9Df+tdMTXU2VZWmr9VYpM6ZMygJwZdJQsapnEfPOBKfvjYjXGuBil5SsZBhnoifoaKnmO+LUkhtOasM1AQiERnN5RQFV0yoAOL+C6vazUmx1+9fzuA8GIcMOTm1H/ReHmlwV/J7//aYWGx/00z+0tkgLZOhM03PI3aax79CRJ9zKVO2GlwMBGmVtS5wIjFPuvYe2JMY8e2bRtU4lxhkIOEFMH3XEyyUEIO87wqzLCxA7CYKDzEOMgffk/H2cHHmMHXoi82GYYNz8NEu0telgzSGwuN58NmwMgf8aJXfcLCvrEGI4QuZ8cKDAMJlUJveHYEDTCLIzI7dlcscfwwyQQRo/AoxwFBVD7pIhj6pgzXtr4OA8Mu5SE5IGFzpmn2HL5V74QzITDe4PYGOjFbyzDtBAX+3gIDJ3lgHEf3A8JcuFFUn0gNIEw7TR1kGAJZ5e2MVKFvoquvMC6V0xWhRFGIf2Q3Q6DTAItPGA9MeXP2bOw8zF5sXMMdeU4rJXUntRqCvscQ8FO87JQcC5T3cDmw4RJX3bKBqzWQ65wCR185rVObbabUTmDvoOHKlZH8rccD9qfEeibd9PmD6cyxw/IYpY98JZjv+e+Jo+Ga9VNDtj1ETQuqKq6iQHudDeHhBAEemnALC9gugFJNDSjWoiM0/wDBn2lWwNemppAtxkNfhaz5kupMzncmtxzN1hUK4D0y024wg+tlh5MRsHZ3ItpGJKs=
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(7696005)(26005)(70586007)(70206006)(8676002)(82310400005)(54906003)(4326008)(2616005)(316002)(6666004)(107886003)(40460700003)(36860700001)(86362001)(110136005)(426003)(47076005)(336012)(1076003)(186003)(508600001)(81166007)(356005)(921005)(83380400001)(36756003)(2906002)(8936002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 11:34:54.4007
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dda27c2-420f-43c3-1a79-08da29d4480f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5990
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
 drivers/memory/tegra/tegra186.c | 28 ++++++++++++++++++++++++++++
 drivers/memory/tegra/tegra194.c |  1 +
 drivers/memory/tegra/tegra234.c |  1 +
 include/soc/tegra/mc.h          |  3 +++
 4 files changed, 33 insertions(+)

diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
index 3d153881abc1..cd7f9079312f 100644
--- a/drivers/memory/tegra/tegra186.c
+++ b/drivers/memory/tegra/tegra186.c
@@ -48,8 +48,35 @@ static void tegra186_mc_program_sid(struct tegra_mc *mc)
 
 static int tegra186_mc_probe(struct tegra_mc *mc)
 {
+	struct platform_device *pdev = to_platform_device(mc->dev);
+	unsigned int i;
 	int err;
 
+	mc->bcast_ch_regs = devm_platform_ioremap_resource_byname(pdev, "broadcast");
+	if (IS_ERR(mc->bcast_ch_regs)) {
+		if (PTR_ERR(mc->bcast_ch_regs) == -EINVAL) {
+			dev_warn(&pdev->dev, "Broadcast channel is missing, please update your device-tree\n");
+			mc->bcast_ch_regs = NULL;
+			goto skip_map_regs;
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
+skip_map_regs:
 	err = of_platform_populate(mc->dev->of_node, NULL, NULL, mc->dev);
 	if (err < 0)
 		return err;
@@ -875,6 +902,7 @@ const struct tegra_mc_soc tegra186_mc_soc = {
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
index 1066b1194a5a..40f1d02a1358 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -194,6 +194,7 @@ struct tegra_mc_soc {
 	unsigned int atom_size;
 
 	u8 client_id_mask;
+	u8 num_channels;
 
 	const struct tegra_smmu_soc *smmu;
 
@@ -212,6 +213,8 @@ struct tegra_mc {
 	struct tegra_smmu *smmu;
 	struct gart_device *gart;
 	void __iomem *regs;
+	void __iomem *bcast_ch_regs;
+	void __iomem **ch_regs;
 	struct clk *clk;
 	int irq;
 
-- 
2.17.1

