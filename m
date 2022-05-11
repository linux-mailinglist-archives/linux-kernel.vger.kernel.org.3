Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D46523EAA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 22:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347638AbiEKUR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 16:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347640AbiEKURX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 16:17:23 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2088.outbound.protection.outlook.com [40.107.95.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85A96949D;
        Wed, 11 May 2022 13:17:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nsGuXSRy4pojeoK5VsEU1Ou9uvViuEd/LEmE9aPgOOy2KrTL8A1jDeoNXdKqzobgV1JmzW86unkgq/e9Ux/9hqkpG1i6ArHlEsnR4aegUi/iblU99pC2t8HDCkobmrckunaubk2RuNuqBDnmkOloD6GcIWYC1NsKsCb7ygy1AEFC8KoFz0EGvWMop29Ik1OVDa9Lg0TXCfGscLRv8Qe7aRH8rR0TIVW8qm687vKpnagtwrivWqCRFY5mavZU9/kYJYERpDfvTZ09Nql5aEA3nFcnCtpRFA9nUPv8hqnFccXJT9NpYXxLUXNZXDNaYRdhStPFrbjmavUivbILjUHuzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxwQx15yfYaHq4bDjHNhn9lRY8pLFCupMyO3VFKQLEQ=;
 b=b2cXxcxZTBaSmV0RwW2+eKFjsbjNQf/q2JFQCtZ2RLISlTjpD5bmmwmcG39+vZ/AW+peSAHklocbSI5ZJfesKHBnA2zSII9xYPXqEnBG4cP6HufHyjEmAS0vjE87eGddHa9eGaC6b862R6KNWha/vST/KMLDrPg/y+WT3GdQeG32W6zQdU0U8TLnfs75o1sNNyCTN4TiSiNY1lVcl6gQbaObI9Or16dEMzTmqmYX9G5XEM40oxu2yIpXM0X4Vr0vVW1SjR/w0Qce2mM59n7802DBtol2+/yKaoKDiNq1HEXXfF1cHIda3XNTbA2nEuGMP1xDe0eQWxCfkS41GkF6WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxwQx15yfYaHq4bDjHNhn9lRY8pLFCupMyO3VFKQLEQ=;
 b=QcLXlHhP2vHJkRF4fMvDI6lf1YBSrjGWYFzzha3B4BvFmMn3VJ5HDLZXioxgkl3xvzk8mh+T/I81dWZ/B7gJVBeZuvKuowwY3PP1Ex7aay1gVokjcla66lQLqvAk/dkdjLgvjpayu+IrjVWy1nIuPd9idS8wlGMIEqM6IR0mT4/U8/ZywGm2wAPRBEc9ufjZ2NKKu26hrmNxDySEQv110OJ8685jLeyAtiomkf0lcjsMi9BUBApKW2qbGQb6eafGUmtVDmY5P6ghrOcwt4XIfckKh4yv0lonkhQWUH8PgLbKf4GJrQhSj0ymMi4FspZ59z9R/KqfsCLqqeg8A+/+Tw==
Received: from MW4PR04CA0317.namprd04.prod.outlook.com (2603:10b6:303:82::22)
 by MWHPR1201MB0126.namprd12.prod.outlook.com (2603:10b6:301:57::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Wed, 11 May
 2022 20:17:20 +0000
Received: from CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::c5) by MW4PR04CA0317.outlook.office365.com
 (2603:10b6:303:82::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22 via Frontend
 Transport; Wed, 11 May 2022 20:17:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT012.mail.protection.outlook.com (10.13.175.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 20:17:20 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL101.nvidia.com (10.27.9.10) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Wed, 11 May 2022 20:17:19 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 11 May 2022 13:17:19 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Wed, 11 May 2022 13:17:16 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <kbuild-all@lists.01.org>
CC:     <sumitg@nvidia.com>, <bbasu@nvidia.com>, <vsethi@nvidia.com>,
        <jsequeira@nvidia.com>
Subject: [Patch v6 1/9] soc: tegra: set ERD bit to mask inband errors
Date:   Thu, 12 May 2022 01:46:43 +0530
Message-ID: <20220511201651.30695-3-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220511201651.30695-1-sumitg@nvidia.com>
References: <20220511201651.30695-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 982e762e-90f1-4ed6-b52e-08da338b407e
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0126:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0126D8A74759072036253B41B9C89@MWHPR1201MB0126.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +pSbAcLR/Jl31Rtp30VCkJ+Al3ytydEoyGzdDp6PNeRNT1zmmTPA6gtLXwq3661fHiBh4NT9JTq3a5KAUtOqHpRQbRgrtg0HovC92FJL5I6FsES6YdoX8PMDYUV4qZa5JkHw9epT/FVZS5I7dfCfEvO+nsZBMN/1Hxatp1RD3gCkhCi/BLis/euBOc0kOuLwGp05QHjvwflZPvOIFwKX2AcqI28TI+HATE1vJAZYmUAwwuWgQcBCsKOH4uAepd+qMbJKQcuDzKVtry+u7h3kJmQipTCW8urmHqaDlWf3xx1S1xUkNhycvFshpvnSDNLTc+MFw21LO65xMaLawLlOHnKtGlt2176vrSreShioYcemOciIp+v4joG2AJ5Gwukn75qkSWqu/M4V6WEMrgdLfXrS0QTRu0CyjDAFrfra9bc/qEV2+h5cdGGhCe+fPi/VkkOm823CgDZsK5jWOkGc0YUW1DPmqbjPz4taz1HgWbqdxKQ5ItY50oH3AQxboqk5HP4oVq4VzT6tttgSUlR0SJOx7k2uh5EVKye6GkqwEpfkyRmSTNCocbN+DjHw8UJXoAZr7LyowQAWusn7wm/LVaoyPKGJeR0DtfSJBGlEDci7qyNooANEuob9ewICLhxG3zxr865Oua2cyidjO2DzmtiwM3e1MsVHhavqI7ciEcGjDWIczAzhsXVGhIBvQB5UAXiNOc5/QykYn+Ojo81uBA==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(70586007)(86362001)(70206006)(82310400005)(186003)(8936002)(8676002)(4326008)(316002)(36756003)(54906003)(107886003)(426003)(36860700001)(83380400001)(5660300002)(508600001)(336012)(47076005)(110136005)(40460700003)(81166007)(6666004)(2906002)(7696005)(356005)(2616005)(26005)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 20:17:20.0925
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 982e762e-90f1-4ed6-b52e-08da338b407e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0126
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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

