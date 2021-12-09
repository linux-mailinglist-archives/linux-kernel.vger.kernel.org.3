Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E65F046F18D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242766AbhLIRZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:25:56 -0500
Received: from mail-mw2nam10on2042.outbound.protection.outlook.com ([40.107.94.42]:50657
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230216AbhLIRZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:25:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQQe964q9cM7r99WHafVB/mJcYEcAHdDGYk+zVIopoFqiVmekd5gvp1CLyCpx326GCiM9MxqmSNYsd4Y2QKX2fBXWxPXKaYjFYpewz5KWgSCtofAD5XqcbJuo+3kiE4vunKEMHn0lnSvyPT8LXY9t8bPcgIdujXBHWv72TF40JxEzY2DNl6uTRZzGTS5TqTpAy08AFb1gyMB3b6/xVTmlr3CtSePAGk58opsYOng1MxQ7prPIiUMSXWH+bA8RADNqwGeAgfc2UA7EJowWaR+VpkSx/iU3zWCNmx42gBR4apY1u0rCvEIZJT+5cA4udA/q+BnN7jIFh8mQkzN2YE11g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxwQx15yfYaHq4bDjHNhn9lRY8pLFCupMyO3VFKQLEQ=;
 b=Yju8LTLLBpIxxHc2BdUFUICAAPaN216xrHIvs51o4/w8LtfiDP5SVXSiqROKU39sgaqFjAj+M8E8onDK3snOgG+ScJa84RZuwu9m+RIW+x96Tv0+avEuDTJxeQG9lipksyTjXNqEYxBOtr5kdeeICZ2yLbidlkbwfjjOQmOYkGbeQ4cUhCs6Jc/mX4hJ1huM+MH5FeGBIkvOM8WXdPfLJlPZBArJjahCHMfk7byjV4nK+bVkT+nXna4epTctlN1XoX6UM+N4t2jXwx6YlVit1fJ/+vN12wiYwl3aoIQ5WwDNWS+BhX0axT3/+6GFYsik8B4OFPach+fppBVAvQ4sPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.14) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxwQx15yfYaHq4bDjHNhn9lRY8pLFCupMyO3VFKQLEQ=;
 b=mzvhyw53xx5c0SJgFoLSpkkT1XKmoyvbJMhm+UyfLuu7YyW0s6MA9xpdyM1Xf9ckdX6i+WZoSriJwBCkwFggndl9A4Qba/tvWtfkSmDL/Muw093YC3XPq20e/tWzGxT+43+BxGTRo6cr8OqmlI0MSdS5h6AsBuiD8a++/2jtaZ5n21SXl5FurWjj19e9IYOqBn8+D9J8otebyMNYPOCqP8bcCaahkLzKlTCe8cENR/DZFriezmyFbSV4m6D2Hk3M6tFWLgXAoYV+4PzdaR2SCNv2PFGDyD0f35SvDXmzNHe/uQyuw5EJF/ZSr2xWezWstBJ+29Rv1r69kRI43ppOiA==
Received: from MWHPR12CA0072.namprd12.prod.outlook.com (2603:10b6:300:103::34)
 by DM5PR12MB2421.namprd12.prod.outlook.com (2603:10b6:4:b4::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Thu, 9 Dec
 2021 17:22:20 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:103:cafe::d4) by MWHPR12CA0072.outlook.office365.com
 (2603:10b6:300:103::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Thu, 9 Dec 2021 17:22:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.14)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.14 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.14; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.14) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Thu, 9 Dec 2021 17:22:19 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 17:22:18 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 09:22:16 -0800
Received: from sumitg-l4t.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 9 Dec 2021 17:22:13 +0000
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>
CC:     <sumitg@nvidia.com>, <bbasu@nvidia.com>, <vsethi@nvidia.com>,
        <jsequeira@nvidia.com>
Subject: [Patch Resend v1 1/8] soc: tegra: set ERD bit to mask inband errors
Date:   Thu, 9 Dec 2021 22:51:59 +0530
Message-ID: <20211209172206.17778-2-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211209172206.17778-1-sumitg@nvidia.com>
References: <20211209172206.17778-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1c74ba6-7ed5-4194-ba2d-08d9bb387485
X-MS-TrafficTypeDiagnostic: DM5PR12MB2421:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB24211482E9A6C390D0048199B9709@DM5PR12MB2421.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JNQd1rBCKj9ncIxgsYDqmMfSZJfy33GZBEZHsbCZUD5f8dKS3KQeOuV2nKUGZ/hLPFzSkwdFJtTJ2QMFXjlMsL0Y5mlLrwxl8TfrxwBJBIgKRrrWVRA9nY3/pwo144tb4hgl6mYyObGdj9wns45iIarf+mQWj90MuCtPPl94eKjy2o2YC6mxfgxeYe/V1RIgBzMedkV/xdWnbCENH1idkdAc+YVFOctOrl27h7CPR9Xt3byKX6xfTAYppJqp3cf1sD5DOSTcDhz1dbW3ftJ1e3bphlw0fLeR/GJcl1VVSjf/a2mQAGBBNS1Sn/8yHKlGrb/ha5h3OIHMTFRshzcHombV6ykbyvHwGfxLurthN8aKmw10w7jLs174qaphk6YASKg9vMxzx2nYV94yqJGjCW5s1zoVP4Gll1qfPtoTVgxZo1EfF2iVdlxwPCoPIyvDIcCkkdOBALxLA7SNyFcRYpWxRNxdlRzyJyEkgMFCeR2e+iUWA5L/+Dde9NpxrlZX1zp4l85PE4XC+s61CrNpxzg3VkNrZIYMbhm8ebpLM+Evchz2yiLiN0BTevYMABhjFybeTPGe/DeI2n5AK4sUh3xg3NvsN2gYYHbwHDl33Gd8hzRv01UZTMykSODw3LILEuTEV04fI4WVg6N8xOWMaOc17oA0o9gk2a9XKmkORQI6qWfRQcP5jArd+xOwvbLTFbQi5JuZP9UmeNR+QaRzLkfdrUQ4h/LyFbUhxzz0h+A5sNkuY+qkAnrh1noYlRgQr8j6umzEKMIwD+abBJ/jwNn/QNOs+zJXt2jyqAVcotw=
X-Forefront-Antispam-Report: CIP:203.18.50.14;CTRY:HK;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:hkhybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(86362001)(2906002)(316002)(8936002)(47076005)(83380400001)(82310400004)(54906003)(4326008)(110136005)(107886003)(336012)(36860700001)(34020700004)(2616005)(426003)(508600001)(70206006)(186003)(5660300002)(7696005)(7636003)(356005)(36756003)(1076003)(40460700001)(6666004)(70586007)(8676002)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 17:22:19.3526
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c74ba6-7ed5-4194-ba2d-08d9bb387485
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[203.18.50.14];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2421
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

