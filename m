Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392AB46F095
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242343AbhLIRKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:10:04 -0500
Received: from mail-mw2nam12on2069.outbound.protection.outlook.com ([40.107.244.69]:30816
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242350AbhLIRJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:09:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYjn5Xk8R5JMOWBqka7NAyzuxWMdWD6syRxIko9+7Tk7xcwKfy9oGli3mBVBxjb0ntFBTrLJM0/kNwvzXebCozX9wP8x6peOaX9SINuHXECcHfdSCmsh7DQgOcNgSJ7sg0i8It1cM8WfWKDpaKTPHtWMZaLm3SlpRHEiZoe96NZbhSFUJ/fbrtoI+a6lli20ej69Age6QqKQvzX8cn2fvuL6v4Csu7nY96+STW8i+WEcrdMcmniuKM/n8P36hMfs90+HIF4baz+tRXddy/D29Kvy5DLlzEM4h7zvxDJvH2eRrPNyn8cecSNYqiAHQbovETRr5lViyEJ/H1rUNZTnbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxwQx15yfYaHq4bDjHNhn9lRY8pLFCupMyO3VFKQLEQ=;
 b=d+nyb6zXooaDlZO0ERDYkhqrYcbVmOW7YaePjFslPCSpJvmxXc9jIM3wxXngFzuX/asd2JAFALvmbpV6/tEzLCOtJKlTLKZpuO09cXK5vZvgv0sjKeLIeBmKDTpWd9tlpWE9IWARyfLHI57T5PGhWRl+f0Q9q1qqCg97sy26DBbMshoaKR21lXBMGZmhjZ5+vK6ZJ8bzm4k60IuhAqtTH3I625ipc1NK1IlH3R7pSVkwhWos514lElLkEne7p8GsHyRO+PTOzziYEM0eb21NtzeWKIS654B6Eoj3ABSzQjAjaH03DMR4OqqYA2tnWqzN6soxEvWaxIyv/Du0uu77DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.13) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxwQx15yfYaHq4bDjHNhn9lRY8pLFCupMyO3VFKQLEQ=;
 b=kYYBzA2WjDvZ6gknznBUwvJ1TvsErrpJ2anU1iytlORUSq5R0KzVnXWvT4ByD1+YNEtIIxuVkV8dIC9pCOXe8zJ214k9Egy6pSiWU0rpqJhGTEeAbiN1n9tzUT224F7eoM/jswuTYT926QhaKk2P0bWCdp5AUq/D/eg8/ebf4YRpz50wvRe1i/OdGDQ5lgiUypAKwTvRV3vDoHH20hUs+xm25D9+lhThJcegbKC/ZC6Pf0Ecl39O5AP1+9ekKqVhSAguhc+i0+ndRt8avGfj58szYTsm9wibM1HNpO+R4LB2AiIu3GIPbnG4X80mrQUpatNo4sByf6j1H/nUj+/fEA==
Received: from CO2PR04CA0088.namprd04.prod.outlook.com (2603:10b6:104:6::14)
 by CY4PR1201MB0215.namprd12.prod.outlook.com (2603:10b6:910:1d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Thu, 9 Dec
 2021 17:05:59 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:6:cafe::37) by CO2PR04CA0088.outlook.office365.com
 (2603:10b6:104:6::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Thu, 9 Dec 2021 17:05:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.13)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.13 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.13; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.13) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Thu, 9 Dec 2021 17:05:59 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 17:05:55 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 17:05:53 +0000
Received: from sumitg-l4t.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 9 Dec 2021 17:05:50 +0000
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>
CC:     <sumitg@nvidia.com>, <bbasu@nvidia.com>, <vsethi@nvidia.com>,
        <jsequeira@nvidia.com>
Subject: [Patch v1 1/8] soc: tegra: set ERD bit to mask inband errors
Date:   Thu, 9 Dec 2021 22:35:48 +0530
Message-ID: <20211209170548.17144-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71979a2b-00ba-4d9b-bed1-08d9bb362c3b
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0215:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0215B88CEF2750491FCCA0E4B9709@CY4PR1201MB0215.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XJLABPpcuVWm/zyYqKk9FJqmQKg7+NakC7CnHePR6MOZt0J2m6ikbXu9y+E7MhMQF1Xp+lI86grDi0ELz7ZzuJ+Mo6IPNKKx+yRmzprDIV6ZO8PyKK6k1DAhknm0t9ub6GW4ID6+mg0yT8cVdADJD9EOLx5UZdm63iWnxRerlmNkcSR+45buYsD8Eu1JdQ6Uz7dr8TrmAv7vrLLsFJoN744h2ZC3DNJ9oKmYzAdwuqneTXgSxzxzc1ZFDKGTsQGpu/Qn96Tmv8o7L15ky/y+zYaJ5YzxBTuT3O1H0aO3tRQO42oTABhCO4Sc8OtgErxs+Fxcct1sSw9UFWZFjG/1KwkUabD1YHOvPHcLmGq5fYFBAxGU9JBIzgMeaebUEnPvzz+T6/Lfh9N6jSR1J5FsbgiDGWBWi5m4RIJMRndo5v8H54k+Zb5taP8jPFLjDzlJGIU0v4UGKkoUAnOXLdzkfyny68KBg0GfeDWz8YTEuJxLb3dXGT4KRg/wn2/Q7BENIf7g+TEiuJIcQ/wjaGDn3tTrZbBSYFGyp1IyFMP8SYmkolM44jCFZ78DnYJbG5kvyNv6tBgiO/Sv9i2IgFQpkb9Y0ljT33kAXYY4CEUrUzpeXqLKAbdimt+4E6HxTW2VFY0w23zKkmOm8ze9nabrCmDCoI6JYcJltoFsxNr9xMSl5vgIlNBSpXnYaRvgUbuyMDDIWzmwvEiMw5KtaRG3ugmw95EG35MCgwzdfZiY/A92BAUderL1+Eq6YLQHOhjmRYYcqS2hdlv07yP0iJyjU7faXFmJ8nuJHhy1MP1Xpk4=
X-Forefront-Antispam-Report: CIP:203.18.50.13;CTRY:HK;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:hkhybrid02.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(34020700004)(5660300002)(2906002)(4326008)(336012)(8936002)(7696005)(83380400001)(86362001)(186003)(82310400004)(36860700001)(40460700001)(26005)(426003)(54906003)(356005)(110136005)(7636003)(70206006)(47076005)(2616005)(316002)(70586007)(1076003)(107886003)(8676002)(36756003)(508600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 17:05:59.0939
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71979a2b-00ba-4d9b-bed1-08d9bb362c3b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[203.18.50.13];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0215
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

