Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A55478ADD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 13:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235940AbhLQMHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 07:07:16 -0500
Received: from mail-bn8nam12on2073.outbound.protection.outlook.com ([40.107.237.73]:51073
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235919AbhLQMHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 07:07:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=naOQQskjtAYlZ2qaJBuzy5lFMK5odKINpOkH43qUnHw9OCd0QxCEWrFvDWL+aT7evChW+f0SHMqql+44xagGqxZqRcYBEgFpZGbg5rxoOfea+hA9S4owkf/adYEONqM2I3uf9KlgrHGdUJIQHdDVcVRUMQPpUiL9gIQTTlx7fz28WsRp90PFi7SlWO9pUHPToOlOkqII3ZzcMHMZuc6F40RNKcb+Yx24Bo39HoX4NAnACSFuGeIZjwIEMITJH2lCjKiMzGFE8JrAPUgRd6ngaJ6Jk8mihkJkNybBQ58qSGf2cyVDPqNZl2PcfJVJMmELEfWTqEfUMZbgvxC/e7LDfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxwQx15yfYaHq4bDjHNhn9lRY8pLFCupMyO3VFKQLEQ=;
 b=oTxT0Q1kdhCJIsD+oohMiWFlPbPpLL9AbqpkaVqFHJ/lK+9rU7WoumHBNXD9k/efE+uItgH216tr/kibJ1EQdLUbl0tJ7aWbMOCmTkzW88VOcYgdoG307hXsLbz4NA5mfmM/HtjVq9pKantXDDypCzuGGid3PUj3puurc50Fg5QU498BQ00gvh6o7L5teqCD4u/GqeiBPSEXT/1J0CANCKlRD9ufpYHHEcZ6aF3FGGWcjBqS/XvlU2LDxmcDXChYfkB95eukDhkYriocrn3/0XV21MfbTjZ7QrUQy9UK2LT4zD3ZkLtIXbI2+ZTb6ROJ0LwgFw75idEL90FbnveqTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxwQx15yfYaHq4bDjHNhn9lRY8pLFCupMyO3VFKQLEQ=;
 b=KVMGa1EbDfLREvLNDm7u3dMUuA8xaPdHXUSOH5zgDCQMa9mCFama312ijlTQm575jEe3cMfmsalDa95HVMlvsmEVn3n664qrnQleiKab6z+FfgSIxgUShAr1zY3/qNjUkz8kwiZITm5OobGeJUragDl+0ZvhCUOVvWakpWokH1V2uAoIt2SDv1nthh1x8jwJ1wviKBB2QoLsGXOitCIZ0httr4sDkMwP2Y4CFRJLqtA7mATYoVrn3uVNwG06oJBhgwfBuKfA+2u/zGlncY3MjGxoxZ+uHqbgusaIy5K/7aH28NWkg/EQKJepoVXMQHn0kj/oba4Bw5jAQUA7+4kzZQ==
Received: from DM5PR19CA0049.namprd19.prod.outlook.com (2603:10b6:3:116::11)
 by DM6PR12MB5008.namprd12.prod.outlook.com (2603:10b6:5:1b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Fri, 17 Dec
 2021 12:07:08 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:116:cafe::b8) by DM5PR19CA0049.outlook.office365.com
 (2603:10b6:3:116::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Fri, 17 Dec 2021 12:07:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4801.14 via Frontend Transport; Fri, 17 Dec 2021 12:07:08 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 17 Dec
 2021 12:07:08 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 17 Dec
 2021 12:07:04 +0000
Received: from sumitg-l4t.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Fri, 17 Dec 2021 12:07:02 +0000
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>
CC:     <sumitg@nvidia.com>, <bbasu@nvidia.com>, <vsethi@nvidia.com>,
        <jsequeira@nvidia.com>
Subject: [Patch v2 1/9] soc: tegra: set ERD bit to mask inband errors
Date:   Fri, 17 Dec 2021 17:36:48 +0530
Message-ID: <20211217120656.16480-2-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211217120656.16480-1-sumitg@nvidia.com>
References: <20211217120656.16480-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43bedcf8-1ffd-4918-5e5f-08d9c155c014
X-MS-TrafficTypeDiagnostic: DM6PR12MB5008:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB50085AE5807E96CC4C733B0DB9789@DM6PR12MB5008.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6xDi/hJdzP4xLXdb+H1uHePHiCDPUaBKamxle+XXGjF3hfGMExfa5TbZAp03++biZNXco6SjD0CmN9dqoNn5z043vidVxtCYOfdx2z+3k10Go1TFju56ovgbCseu2KqyT6uHcaIMK2H+JwKmilJ74oY0JzUBsanBN3MEQiqQ3TH/QvFR0zgRRlQ2MoxiI2hQ990ujFP409u3a5969yMcllFIWxOJL3vsNiawePdXjCUPnWt4KVp8LON0myc30ZMqDhpGX6HEpKoJZNIz0i3v1zAboacIqMirRHsiN/B733KRS+m6ZSMRL/qfGx3L46UN66cxT37dQbu2XrnqSYraVxlJUnpjuNl1ytndEKkdXAdGSOp6Yvhkgr2w7RV2uEsveak7eXD/jW11xeTjh8VOFPKcbS+P0eNhlWAmBJH9B54R3378BZYuoAC3kTSYIBA6Ssk/npJaI0mAdrR13c9CI8B20zucpVFrN0xg6i7LSq3EqzNYAylrqSzUECsqDgJmEEfBJuT9L0T+9kcZNhv5TR5r2FqEoiiGKPV4Oql6S73CTW93xTOEpiKLVXu+C27vvF3aK94Q/lW9dbvGPwju2ADNAhWWiJRiPkc7yMo16+ngsk3dCRY+j6HJImRG1MbAEo7VggtlPv6NzZ8hBqd+Q8hJMRJmb7ACJH25iucroDApmsgKA2UmsT3L1JsB5WH+/qjhfhvJ/HeNnTplXgYM5EadGsHg54A9fOb7XrJKA12H5hvX/AmdYBYsqofXxu3mdpuYBzrCv4C6tf3VhDgTB/B8fWoPx0GzqI7TMA5++Qgit1hjnnP6e/s/fCXmzFX/+IR2anJruyGnGW6+sh+10w==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(5660300002)(508600001)(36860700001)(47076005)(40460700001)(2906002)(83380400001)(82310400004)(8676002)(2616005)(4326008)(186003)(110136005)(36756003)(1076003)(81166007)(6666004)(26005)(316002)(356005)(54906003)(7696005)(70586007)(70206006)(34020700004)(107886003)(8936002)(336012)(86362001)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 12:07:08.6858
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43bedcf8-1ffd-4918-5e5f-08d9c155c014
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5008
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add function to set Error Response Disable bit in MISCREG_CCROC_ERR_CONFIG
register from the Control Backbone(CBB) error handler driver.
ERD bit allows masking of SError due to inband errors which are caused by
illegal register accesses through CBB. When the bit is set, interrupt is
used for reporting errors and magic code '0xdead2003' is returned.
This change is only required for Tegra194 SOC as the config is moved to CBB
register space for future SOC's. Also, remove unmapping the apbmisc_base as
it's required to get the base address for accessing the misc register.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/soc/tegra/fuse/tegra-apbmisc.c | 29 ++++++++++++++++++++++++--
 include/soc/tegra/fuse.h               |  6 ++++++
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/tegra/fuse/tegra-apbmisc.c b/drivers/soc/tegra/fuse/tegra-apbmisc.c
index 590c862538d0..de833f8d2408 100644
--- a/drivers/soc/tegra/fuse/tegra-apbmisc.c
+++ b/drivers/soc/tegra/fuse/tegra-apbmisc.c
@@ -16,12 +16,16 @@
 
 #define FUSE_SKU_INFO	0x10
 
+#define ERD_ERR_CONFIG 0x120c
+#define ERD_MASK_INBAND_ERR 0x1
+
 #define PMC_STRAPPING_OPT_A_RAM_CODE_SHIFT	4
 #define PMC_STRAPPING_OPT_A_RAM_CODE_MASK_LONG	\
 	(0xf << PMC_STRAPPING_OPT_A_RAM_CODE_SHIFT)
 #define PMC_STRAPPING_OPT_A_RAM_CODE_MASK_SHORT	\
 	(0x3 << PMC_STRAPPING_OPT_A_RAM_CODE_SHIFT)
 
+static void __iomem *apbmisc_base;
 static bool long_ram_code;
 static u32 strapping;
 static u32 chipid;
@@ -93,6 +97,28 @@ u32 tegra_read_ram_code(void)
 }
 EXPORT_SYMBOL_GPL(tegra_read_ram_code);
 
+/*
+ * The function sets ERD(Error Response Disable) bit.
+ * This allows to mask inband errors and always send an
+ * OKAY response from CBB to the master which caused error.
+ */
+int tegra194_miscreg_mask_serror(void)
+{
+	if (!apbmisc_base)
+		return -EPROBE_DEFER;
+
+	if (!of_machine_is_compatible("nvidia,tegra194")) {
+		WARN(1, "Only supported for Tegra194 devices!\n");
+		return -EOPNOTSUPP;
+	}
+
+	writel_relaxed(ERD_MASK_INBAND_ERR,
+		       apbmisc_base + ERD_ERR_CONFIG);
+
+	return 0;
+}
+EXPORT_SYMBOL(tegra194_miscreg_mask_serror);
+
 static const struct of_device_id apbmisc_match[] __initconst = {
 	{ .compatible = "nvidia,tegra20-apbmisc", },
 	{ .compatible = "nvidia,tegra186-misc", },
@@ -134,7 +160,7 @@ void __init tegra_init_revision(void)
 
 void __init tegra_init_apbmisc(void)
 {
-	void __iomem *apbmisc_base, *strapping_base;
+	void __iomem *strapping_base;
 	struct resource apbmisc, straps;
 	struct device_node *np;
 
@@ -196,7 +222,6 @@ void __init tegra_init_apbmisc(void)
 		pr_err("failed to map APBMISC registers\n");
 	} else {
 		chipid = readl_relaxed(apbmisc_base + 4);
-		iounmap(apbmisc_base);
 	}
 
 	strapping_base = ioremap(straps.start, resource_size(&straps));
diff --git a/include/soc/tegra/fuse.h b/include/soc/tegra/fuse.h
index 67d2bc856fbc..977c334136e9 100644
--- a/include/soc/tegra/fuse.h
+++ b/include/soc/tegra/fuse.h
@@ -58,6 +58,7 @@ u32 tegra_read_chipid(void);
 u8 tegra_get_chip_id(void);
 u8 tegra_get_platform(void);
 bool tegra_is_silicon(void);
+int tegra194_miscreg_mask_serror(void);
 #else
 static struct tegra_sku_info tegra_sku_info __maybe_unused;
 
@@ -95,6 +96,11 @@ static inline bool tegra_is_silicon(void)
 {
 	return false;
 }
+
+static inline int tegra194_miscreg_mask_serror(void)
+{
+	return false;
+}
 #endif
 
 struct device *tegra_soc_device_register(void);
-- 
2.17.1

