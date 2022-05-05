Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A8B51C5B6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 19:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382380AbiEERKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241101AbiEERKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:10:31 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2080.outbound.protection.outlook.com [40.107.212.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0DC167D8;
        Thu,  5 May 2022 10:06:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHgHWXHYBj9uB6ccMpy8dBNM140AvzQpOrlkBin3qajdzgxuvKHXdmO7z920lZrzw6JvH+tYy0wUPS9OrmaMNMKvOTNsjfA6GqgIeIBMUKkaDKboRgVAAxiIP7CMCtpAn5u/0QslEy68sjJg55kp3pVqUbh261PUAAXc0LcoCSkAP+EH7MIokQjR8U1Aypqq0Dech9nn2HWXHzfAaz9o5aEchaBR/BkaqA7M4+9O0mfNTJz6Wwp8lzaqWEGWFOVLGmo4YjKfPot79hHeZT4aDxbCXXe74NYd2SkCWY+D0GthWqH7MjjL/IeiRjpE/Vm89ma5BNXRUKHYqxZhtT4xRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxwQx15yfYaHq4bDjHNhn9lRY8pLFCupMyO3VFKQLEQ=;
 b=AVcHie3+M3L5EhpQyIIwcgFx5SQMh4lI93iIAr0yLxGiNveH6ge2k2SB8t6fM1eBiFGENA+em6+eic/xpvJHoO7ztOXAQbHjbRZYzVJXRoPUq2V0esdwtEKRuaW3Orz36IRvaga8xRGChXijm7d63CWs0iYXHOALvoJELNe9MuD4uPxb7kDK9rB8yTqAxE1+WIxPWbivqqjh7ij0qh4T+renFrNzRr8F+po26mZdqDC9DQG4yvf9fSLjlWFegZJXg6lojdmpJvRRCjJhb0tixk38nZ1UZHaaYZWyKeUBTDi/RV4llpOdMEfV3xarOVpyTxgNW9S1Vvj8V5BdNIBpng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxwQx15yfYaHq4bDjHNhn9lRY8pLFCupMyO3VFKQLEQ=;
 b=it/eKk923b+26YZ2xJ68AZoe9U8kgAYw+Bv3PKnE6/rhDxI/6RrOCjsLGtgxwKdgZqGGlfHImpeWK1x+/101jd1OoLxY6Z+BrYqgZuPL2KOVZf0spn0+uAiab2qrXS+RZg6fjemof/XtfDnPySRf60SerXS3QrIuWU+MJ+CIFcLdZ+XuAJwsnwFu4eNW3O8mf2wl3a0gl3+9i2gjLswGFHkl/wH3IYFQaFo1I+TBeYTyramV/Cjn6ihZDl5MS/jzPABsQQhUNVMdI+Zm0dBv7e3wYvjwfZpXDjRQWdhlYtQaYrUZ443MNC3ZDM/FAYz4l+qGqFTK58E0Su9pYbdqBw==
Received: from MW4P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::23)
 by BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 5 May
 2022 17:06:50 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::f6) by MW4P220CA0018.outlook.office365.com
 (2603:10b6:303:115::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Thu, 5 May 2022 17:06:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 17:06:50 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 DRHQMAIL109.nvidia.com (10.27.9.19) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Thu, 5 May 2022 17:06:49 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 5 May 2022 10:06:49 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Thu, 5 May 2022 10:06:46 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <kbuild-all@lists.01.org>
CC:     <sumitg@nvidia.com>, <bbasu@nvidia.com>, <vsethi@nvidia.com>,
        <jsequeira@nvidia.com>
Subject: [Patch v4 1/9] soc: tegra: set ERD bit to mask inband errors
Date:   Thu, 5 May 2022 22:36:29 +0530
Message-ID: <20220505170637.26538-2-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220505170637.26538-1-sumitg@nvidia.com>
References: <20220505170637.26538-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd23a19c-c56b-464b-32ab-08da2eb9a528
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB23708C60C7C867971CEF3667B9C29@BL0PR12MB2370.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CBr++BbjlHdmToXRfzupgGl6xhRFKLS3Xw65xgANyb8oKc0z1RuX9Eo/uGjPFCFc38MFmqN7bmy81GGg4yXbA7ZuiQND+a7AA/ilz6tlGDVvDLZ770t6FNT6ZMiDlk598sLavrfohLprQbbKilp5+VewT5BAR3urRbj7Ha6lcLANysTh3R1K51ovPBOgVK3kGjb7Rbv3RV7PqJ1nZSIq9lRiYzT/UOmVMkOiCovBqVF0yVQtiN+zyK8cX0waKrprTslcWhPiUzkqJ44cSUwR8JhL1gH0ksxZcG/9EeeN8kn3NrqYlIoSyBR82Kuuys+Ep8OBgSuuXKJC9rUxJcIYxlAYf9Vve8Tl4V7ofUZo0f+5Am5WBvTXeYXiJlpBcp1uHuGcfVbD8aESQFcCH9uIGjyIiUNEcKuGhApULDNt4t/6/Kznr6c8CjkK+jc2iXbXrTFbSWR//Ap89HoVcbZEnJA/l49aO7efSj5iKgOyj8XFoMJrjM1spYMjsiNv12GLo5+6rGKpRmmz4UsDQ1weHePg0uWiB0Od1llWp5CrHQ+SMUDQJ5qoJxzm2pYJwqTyUp9Jfcalff4kqWvtd2JGAJneEGlR5uWyDOJZZCX69OmYEU3UeYWQFfYK4raWQzaJ8SGjqSqUgYxJ76J1CA2ZcA0a+k6s6fUaMUmWaxLXhuLs94NKDXBEZOqYUWvvGJKulwIgfLtkE4eboB2AVWWdQA==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(110136005)(26005)(54906003)(316002)(2906002)(81166007)(1076003)(6666004)(356005)(336012)(426003)(86362001)(186003)(47076005)(107886003)(2616005)(83380400001)(36756003)(40460700003)(508600001)(36860700001)(82310400005)(7696005)(5660300002)(8676002)(8936002)(70206006)(70586007)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 17:06:50.0111
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd23a19c-c56b-464b-32ab-08da2eb9a528
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2370
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

