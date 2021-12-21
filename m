Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC9347BFFA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 13:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237811AbhLUMvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 07:51:31 -0500
Received: from mail-dm6nam11on2051.outbound.protection.outlook.com ([40.107.223.51]:48859
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235157AbhLUMva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:51:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BpaPvjk27jdw1BMTa2TQp1nxQfL1W/9sU56DnY0UjxqeDS4XWI+887KlmQg6VSsnUqPST1VIyJGytpqsAsOyoTJDOmUu16f8YZ3AlY1PF5yc1WWE3khlZ7sjeCa9U4v+g0OJfviZOxcU7PdWwPAvV1gGjlYtPVo73+qx9jRyEOqpDjG98288kW2jOQeNj02mBDUlsMiGq0XU9VkrMrgrgcKPrTEda/CYVoi8on53SN4TijT0vN4+7JvuW2FhmHEm0Dfg7q2uxPMhdJXzB36girEh7tYomxbeevMGxlLjRuo/dSmQN4j2yB0tR3GSORgaobSsmjExpcH6GMdfFkFwRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxwQx15yfYaHq4bDjHNhn9lRY8pLFCupMyO3VFKQLEQ=;
 b=dMQNlqD+fvxv/tOKrJnhZ2n/kdOIRnAqNDKOeEM9ws8hQVB2uRWcm+UyebNdr6iz1xfXXOyIDgUvaKiNzpkP4dvkrW3ebOV7ZlGAVG4BoxY64j5Tf8GjDxqvmokjQXUDTIbjU9OsedU8VAAJLxDBKzz1bCBqeXri58BZ3G4sXfAKOQe6tVax/c5YyIDkkpiKwdW8ZPAeeES9ivCygUW4H6tyY+j6iygLRh5s31rPrJwM1oAUTaJu9GqxXkCkQJrGIMV+MJoKNeN0sLVa+k5r66Gw9DbVWd52C2f6/h8k5lDiuu1pPaFsl8/4pcljgh5Z1Q2u8eTLvZdIWcRsczVw+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxwQx15yfYaHq4bDjHNhn9lRY8pLFCupMyO3VFKQLEQ=;
 b=MuxaU6n4Ad3JthrfzBjTQxOZXrsEz5J3zEH2yGnmHUwGRdr7k9KLlVQcdn/Htsl2azizhO/7gtc8AbK4ddwSM+v20ur/d1kdCX+hXrL/hm+91ApuEnMvt2qhK0A9p4L6rxw2szk31QjrnufbW7Mk8Om0ifA6nDtnDpmuiakbzO2FzmgE2fx5S83jTTQLpTFH0efbiZ+m01YL4UT/rRj2Yn5D4b/ucjYSJrVJyxyimgaaITf9sD6x4JDcyGxjisrsLSZl1eYjrEH0ugK4bFMx88hUlbr2o+wL5+OrnBkigVBPlB0ievPRMQlVgNBR9F3ltJiU/mNEnkuO/lYSnmH1ZA==
Received: from MW4PR04CA0384.namprd04.prod.outlook.com (2603:10b6:303:81::29)
 by DM6PR12MB2938.namprd12.prod.outlook.com (2603:10b6:5:18a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.20; Tue, 21 Dec
 2021 12:51:28 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::ce) by MW4PR04CA0384.outlook.office365.com
 (2603:10b6:303:81::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17 via Frontend
 Transport; Tue, 21 Dec 2021 12:51:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4801.14 via Frontend Transport; Tue, 21 Dec 2021 12:51:27 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 21 Dec
 2021 12:51:27 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 21 Dec
 2021 12:51:26 +0000
Received: from sumitg-l4t.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Tue, 21 Dec 2021 12:51:23 +0000
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>
CC:     <kbuild-all@lists.01.org>, <sumitg@nvidia.com>, <bbasu@nvidia.com>,
        <vsethi@nvidia.com>, <jsequeira@nvidia.com>
Subject: [Patch v3 1/9] soc: tegra: set ERD bit to mask inband errors
Date:   Tue, 21 Dec 2021 18:21:09 +0530
Message-ID: <20211221125117.6545-2-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211221125117.6545-1-sumitg@nvidia.com>
References: <20211221125117.6545-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07ec0851-38ae-40cc-aade-08d9c4809ab3
X-MS-TrafficTypeDiagnostic: DM6PR12MB2938:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2938B521CC34D3BF48D1D8FAB97C9@DM6PR12MB2938.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CSu2McATJsQW9uP4p/AiI2QFZ3u90vSJyQu78eFhz/LbklLmbqh8KQu2WFRLRcakZPnlof40TOV15kj6eDaX9nntNlOXOpI/B6uCG4w+5uReZfDafNO1QYwa+o5gDcX5SNIZ4uYYna9bavS1Sb4Sye7DSFUwfCYsniMDN532PThpnQEhdu7wdPi5LkauqBYk2cegqJ1GTguIfrbz5b8oIchVPT4773uLIBiwhxVMdgLOaTOUB+V4/mlm0iR+oi04p3LVHAeL7vpvygSUIp6DkY5LIXHBYYBrMBVpZpgJVRTzxmWpGynwF5k/w7brDfAM8jWAMYkOQLKbWxteP3ycYO5Wel33NxmSeguiDIw5VNPfE7CQzCgiXHgLJfEN9axpJF3IkxIPeq496A/5xI0QD2iidwezq8gpEy0s/huyw73UgK/fkzamdrgEyNBGADQPAsKnH8f4/TMNobWrGoKtK/9ti7OZzlAB8oxw/EbBtaMCGfMCyKlVlRTKRpXHAeau3J31a+vZoZ5fle9go/WB14St6b7Qi8axNJL2TYnBRY86oTbmKpZuHBbitrIf5f1UMhCzJkasyvDC3kQTL4jsyyuscrRuQYouCVx4KfAoPIT6e5fsKFXQS4gguygUordYq0mIQPQWJzzoSgKNNx0yq0BOgyvMUG74R8eA0tGZQVxC2RRHR07Gk2RJcRMnXoeEO9q1mSr5OYidJetEI/sBo2IXtztXJpfmlwOywH3vezVWbcqsbFL6yrH8sRtMMZq7Emu1ARvx3TEUEnd3W3WP8CMyVXR6YW+7TTS6TTtw6wLXrVXqbf7wAXyaDdRalZ+VAvIX2qliI8BF+JksUCjJ+A==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(46966006)(40470700002)(36840700001)(70206006)(54906003)(34020700004)(2906002)(508600001)(7696005)(70586007)(107886003)(110136005)(1076003)(36860700001)(6666004)(36756003)(47076005)(186003)(81166007)(8676002)(83380400001)(40460700001)(82310400004)(5660300002)(2616005)(336012)(4326008)(86362001)(8936002)(316002)(26005)(356005)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 12:51:27.8941
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07ec0851-38ae-40cc-aade-08d9c4809ab3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2938
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

