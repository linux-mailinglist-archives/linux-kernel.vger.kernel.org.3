Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67512495E49
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 12:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380076AbiAULTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 06:19:44 -0500
Received: from mail-dm6nam08on2044.outbound.protection.outlook.com ([40.107.102.44]:50912
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1380056AbiAULTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 06:19:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqKnGbzFq3ZOBCi1BqUz71ufeu0AZa3JHHqqNRqPkXgmQXJ9qwbAVcxu7UtZgXAiHTdWZn/sAfIuPEFJzw3/p5jzyei5CKVCHfKXlKzlUI4Iy/FJNXyjR0epk0C8bKXXQCIhiUXNt8j0E+MPGhF37oxiNF5BuKswYQ1u3l9ZJTDHJt7itpNiqI9xmBErlJNj7lsKU9pKPrUqWd44zg8v7NMsXkGwzQ4MIQSh+IIhm4DCAJypzH/IDlEXyjqaqQ4DsQEV1jnZ1Fih6nn+tdU6d3nO68gGsK44wd/9DTB1746Eues0yv5rWrrJ9xVgU4MX1ylmJM8GaS3zAa/+lkNbOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fR0JcOirh+2Tom70mG83P5yp4ooD3CBf2g/jCnlIQtw=;
 b=B6zt3DCiTF7hfm6gER4HIs99BrVet3HoKtk5c5Jl+ki9GVZGiUb2K+0EhVsvGnzmsD5A36b4Mt/KF7ZAAWdYmKjRgd/rpNMM7d3FTm4voIY+jVvxRjI09XFGpQLAJfanI4/zOPT5tklnwX52PzxW7/CxC5DFRklqYxYbLBO3TsLeHCgQVdZ4ZTKkgESM+tdHU+wW/r+Dx6HAv8jAERItL4UttNTimkjJIELmlYqcg8xHX1swjZ8U3rl2WeRBThQAwhbpV6e9EvKpqzNXJarK92RH6t9GN6tiFmjfgFNa99eRBWUvvbPHshsuuvmlN2PtZ0I+ZNa2GoVQUICSj6Pj6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=canonical.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fR0JcOirh+2Tom70mG83P5yp4ooD3CBf2g/jCnlIQtw=;
 b=pctqsI+nMeAngNE5DLdYoEyfUejJMWhA9Z2lrCBx9BgWfkj6Enw7npGiC4oRZ+iETdzGUXOzDGlHzZl0NpjTDKvq9MmeodBi/+IlcxEsE0FeYlw0K3ucgQ0fEiH3MN3AENFk5Dw98JX3BeyRByMRRN1GZBjBzHCPwTSLWSeLbA3sco2V1KTcRMeQzTGZhk4t1G2+6yCrHTWQYeCDRS1MB/ojp469BRlG7irRVb6TuD0phvhLTTQeMy0NsfJOgOeVKl94AaapWG21beGm/BFILHKvFgQ7FviBoLrf8g3ID/ELqQcX6qtS0MV+nq0D9mDH2JzBisSa1Wfvt46H+cTbiw==
Received: from BN6PR22CA0058.namprd22.prod.outlook.com (2603:10b6:404:ca::20)
 by MN2PR12MB4520.namprd12.prod.outlook.com (2603:10b6:208:26f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Fri, 21 Jan
 2022 11:19:34 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:ca:cafe::6f) by BN6PR22CA0058.outlook.office365.com
 (2603:10b6:404:ca::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12 via Frontend
 Transport; Fri, 21 Jan 2022 11:19:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4909.7 via Frontend Transport; Fri, 21 Jan 2022 11:19:34 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL101.nvidia.com (10.27.9.10) with Microsoft SMTP Server (TLS) id
 15.0.1497.18; Fri, 21 Jan 2022 11:19:33 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9;
 Fri, 21 Jan 2022 03:19:33 -0800
Received: from amhetre.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Fri, 21 Jan 2022 03:19:30 -0800
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <digetx@gmail.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <krzysztof.kozlowski@canonical.com>, <linux-kernel@vger.kernel.org>
CC:     <Snikam@nvidia.com>, <vdumpa@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>
Subject: [Patch V3] memory: tegra: Add MC error logging on tegra186 onward
Date:   Fri, 21 Jan 2022 16:49:22 +0530
Message-ID: <1642763962-32129-1-git-send-email-amhetre@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80fa8f7f-49dd-48b7-c64c-08d9dccfe716
X-MS-TrafficTypeDiagnostic: MN2PR12MB4520:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB45200C1A53F44C3FB8BA7182CA5B9@MN2PR12MB4520.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:26;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GW4FvIlMptlA5Y8E1WQ3K5LH9GxdANCIrmtdlCyCC73QxWxYw/PMjhnczOkQtCBbgrwkw8Eeryntav+9S5EViDBFdnsMit9qSe+NaS5k7g63SYzaC5BiWCgafjqbdGD6En0oitYf5VU3+SkeYe4i/gwZ3WB6vEBpvEC+kxUORzbxi5d5ZY9lJaSMOo3txrBlBfiTnEiThDvnZ+k8tiZ4kvgVWXFcE39VvnO5OtDfRxsBWfl97AAoG23nhEx8BueTwHw7v7wf38H+Wl5jD/XrLMQ205ABdTmFE2YrA7cK0xV097M0KLuaEb3V5ESjDQPrftTFrZPWt2ey16WpgqwsDUV2LhfjhZICBx5NKbalhFKwyjzqL0TmtLcv0yZnzEGjM8aQJGZQJLgb/Rev21c78my/IGVuF9c0WQr0mKJzPkzasDhL/RCt6jqe4SvT3GtGrarrbTmgQrGk5fKuVjrRRx5dkaYcsPj9XLrl9VRTvmaadXG1Z4yZXd0w20TKYOYK+phdQ11twR9MQ/bYQmBQAxU3kvOHYIHGm8tb4gtCTYXAs6vPQOehk7u5yfAei4TuunsxCoHuri9QVFHjo+gPZWYCltSVMAvb8Wg8X2aeMgRKVy7oprM6kjOboQdNVlQQDGYdCfN1kMOgMPoRi4Vfa6KqvQ0CTM08BgCrVitD8C0/kZ5Hru3EE04cG4FOmt/F87vB9VpYLEWBdt0zWdjiRW5fUHpUPM7eb0WX1pMMK9B1LnzPKZ0zB8HB+13zbfqeEtVHSQoIo+dy75NG783NP9fL5lqT/wWHt2vfClsjKV8=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(40470700002)(46966006)(36840700001)(36860700001)(5660300002)(36756003)(186003)(26005)(107886003)(86362001)(47076005)(83380400001)(336012)(4326008)(426003)(316002)(356005)(82310400004)(54906003)(40460700001)(81166007)(110136005)(2616005)(7696005)(6666004)(508600001)(2906002)(8676002)(70586007)(8936002)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 11:19:34.1287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80fa8f7f-49dd-48b7-c64c-08d9dccfe716
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4520
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove static from tegra30_mc_handle_irq and use it as interrupt handler
for MC interrupts on tegra186, tegra194 and tegra234 to log the errors.
Add error specific MC status and address register bits and use them on
tegra186, tegra194 and tegra234.
Add error logging for generalized carveout interrupt on tegra186, tegra194
and tegra234.
Add error logging for route sanity interrupt on tegra194 an tegra234.
Add register for higher bits of error address which is available on
tegra194 and tegra234.
Add a boolean variable 'has_addr_hi_reg' in tegra_mc_soc struture which
will be true if soc has register for higher bits of memory controller
error address. Set it true for tegra194 and tegra234.

Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
Changes in v3:
- Removed unnecessary ifdefs
- Grouped newly added MC registers with existing MC registers
- Removed unnecessary initialization of variables
- Updated code to use newly added field 'has_addr_hi_reg' instead of ifdefs

Changes in v2:
- Updated patch subject and commit message
- Removed separate irq handlers
- Updated tegra30_mc_handle_irq to be used for Tegra186 onwards as well

 drivers/memory/tegra/mc.c       | 57 +++++++++++++++++++++++++++++++++--------
 drivers/memory/tegra/mc.h       | 16 +++++++++++-
 drivers/memory/tegra/tegra186.c |  7 +++++
 drivers/memory/tegra/tegra194.c |  6 +++++
 drivers/memory/tegra/tegra234.c |  6 +++++
 include/soc/tegra/mc.h          |  1 +
 6 files changed, 81 insertions(+), 12 deletions(-)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index bf3abb6..5ebe675 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -508,7 +508,13 @@ int tegra30_mc_probe(struct tegra_mc *mc)
 	return 0;
 }
 
-static irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
+const struct tegra_mc_ops tegra30_mc_ops = {
+	.probe = tegra30_mc_probe,
+	.handle_irq = tegra30_mc_handle_irq,
+};
+#endif
+
+irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
 {
 	struct tegra_mc *mc = data;
 	unsigned long status;
@@ -521,6 +527,7 @@ static irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
 
 	for_each_set_bit(bit, &status, 32) {
 		const char *error = tegra_mc_status_names[bit] ?: "unknown";
+		u32 addr_hi_reg = 0, status_reg, addr_reg;
 		const char *client = "unknown", *desc;
 		const char *direction, *secure;
 		phys_addr_t addr = 0;
@@ -529,12 +536,44 @@ static irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
 		u8 id, type;
 		u32 value;
 
-		value = mc_readl(mc, MC_ERR_STATUS);
+		switch (bit) {
+		case MC_INT_DECERR_VPR:
+			status_reg = MC_ERR_VPR_STATUS;
+			addr_reg = MC_ERR_VPR_ADR;
+			break;
+		case MC_INT_SECERR_SEC:
+			status_reg = MC_ERR_SEC_STATUS;
+			addr_reg = MC_ERR_SEC_ADR;
+			break;
+		case MC_INT_DECERR_MTS:
+			status_reg = MC_ERR_MTS_STATUS;
+			addr_reg = MC_ERR_MTS_ADR;
+			break;
+		case MC_INT_DECERR_GENERALIZED_CARVEOUT:
+			status_reg = MC_ERR_GENERALIZED_CARVEOUT_STATUS;
+			addr_reg = MC_ERR_GENERALIZED_CARVEOUT_ADR;
+			break;
+		case MC_INT_DECERR_ROUTE_SANITY:
+			status_reg = MC_ERR_ROUTE_SANITY_STATUS;
+			addr_reg = MC_ERR_ROUTE_SANITY_ADR;
+			break;
+		default:
+			status_reg = MC_ERR_STATUS;
+			addr_reg = MC_ERR_ADR;
+			if (mc->soc->has_addr_hi_reg)
+				addr_hi_reg = MC_ERR_ADR_HI;
+			break;
+		}
+
+		value = mc_readl(mc, status_reg);
 
 #ifdef CONFIG_PHYS_ADDR_T_64BIT
 		if (mc->soc->num_address_bits > 32) {
-			addr = ((value >> MC_ERR_STATUS_ADR_HI_SHIFT) &
-				MC_ERR_STATUS_ADR_HI_MASK);
+			if (addr_hi_reg)
+				addr = mc_readl(mc, addr_hi_reg);
+			else
+				addr = ((value >> MC_ERR_STATUS_ADR_HI_SHIFT) &
+					MC_ERR_STATUS_ADR_HI_MASK);
 			addr <<= 32;
 		}
 #endif
@@ -591,7 +630,7 @@ static irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
 			break;
 		}
 
-		value = mc_readl(mc, MC_ERR_ADR);
+		value = mc_readl(mc, addr_reg);
 		addr |= value;
 
 		dev_err_ratelimited(mc->dev, "%s: %s%s @%pa: %s (%s%s)\n",
@@ -605,12 +644,6 @@ static irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-const struct tegra_mc_ops tegra30_mc_ops = {
-	.probe = tegra30_mc_probe,
-	.handle_irq = tegra30_mc_handle_irq,
-};
-#endif
-
 const char *const tegra_mc_status_names[32] = {
 	[ 1] = "External interrupt",
 	[ 6] = "EMEM address decode error",
@@ -622,6 +655,8 @@ const char *const tegra_mc_status_names[32] = {
 	[12] = "VPR violation",
 	[13] = "Secure carveout violation",
 	[16] = "MTS carveout violation",
+	[17] = "Generalized carveout violation",
+	[20] = "Route Sanity error",
 };
 
 const char *const tegra_mc_error_names[8] = {
diff --git a/drivers/memory/tegra/mc.h b/drivers/memory/tegra/mc.h
index 062886e..47d2163 100644
--- a/drivers/memory/tegra/mc.h
+++ b/drivers/memory/tegra/mc.h
@@ -43,7 +43,20 @@
 #define MC_EMEM_ARB_OVERRIDE				0xe8
 #define MC_TIMING_CONTROL_DBG				0xf8
 #define MC_TIMING_CONTROL				0xfc
-
+#define MC_ERR_VPR_STATUS				0x654
+#define MC_ERR_VPR_ADR					0x658
+#define MC_ERR_SEC_STATUS				0x67c
+#define MC_ERR_SEC_ADR					0x680
+#define MC_ERR_MTS_STATUS				0x9b0
+#define MC_ERR_MTS_ADR					0x9b4
+#define MC_ERR_ROUTE_SANITY_STATUS			0x9c0
+#define MC_ERR_ROUTE_SANITY_ADR				0x9c4
+#define MC_ERR_GENERALIZED_CARVEOUT_STATUS		0xc00
+#define MC_ERR_GENERALIZED_CARVEOUT_ADR			0xc04
+#define MC_ERR_ADR_HI					0x11fc
+
+#define MC_INT_DECERR_ROUTE_SANITY			BIT(20)
+#define MC_INT_DECERR_GENERALIZED_CARVEOUT		BIT(17)
 #define MC_INT_DECERR_MTS				BIT(16)
 #define MC_INT_SECERR_SEC				BIT(13)
 #define MC_INT_DECERR_VPR				BIT(12)
@@ -156,6 +169,7 @@ extern const struct tegra_mc_ops tegra30_mc_ops;
 extern const struct tegra_mc_ops tegra186_mc_ops;
 #endif
 
+irqreturn_t tegra30_mc_handle_irq(int irq, void *data);
 extern const char * const tegra_mc_status_names[32];
 extern const char * const tegra_mc_error_names[8];
 
diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
index 3d15388..a619e6c 100644
--- a/drivers/memory/tegra/tegra186.c
+++ b/drivers/memory/tegra/tegra186.c
@@ -16,6 +16,8 @@
 #include <dt-bindings/memory/tegra186-mc.h>
 #endif
 
+#include "mc.h"
+
 #define MC_SID_STREAMID_OVERRIDE_MASK GENMASK(7, 0)
 #define MC_SID_STREAMID_SECURITY_WRITE_ACCESS_DISABLED BIT(16)
 #define MC_SID_STREAMID_SECURITY_OVERRIDE BIT(8)
@@ -144,6 +146,7 @@ const struct tegra_mc_ops tegra186_mc_ops = {
 	.remove = tegra186_mc_remove,
 	.resume = tegra186_mc_resume,
 	.probe_device = tegra186_mc_probe_device,
+	.handle_irq = tegra30_mc_handle_irq,
 };
 
 #if defined(CONFIG_ARCH_TEGRA_186_SOC)
@@ -875,6 +878,10 @@ const struct tegra_mc_soc tegra186_mc_soc = {
 	.num_clients = ARRAY_SIZE(tegra186_mc_clients),
 	.clients = tegra186_mc_clients,
 	.num_address_bits = 40,
+	.client_id_mask = 0xff,
+	.intmask = MC_INT_DECERR_GENERALIZED_CARVEOUT | MC_INT_DECERR_MTS |
+		   MC_INT_SECERR_SEC | MC_INT_DECERR_VPR |
+		   MC_INT_SECURITY_VIOLATION | MC_INT_DECERR_EMEM,
 	.ops = &tegra186_mc_ops,
 };
 #endif
diff --git a/drivers/memory/tegra/tegra194.c b/drivers/memory/tegra/tegra194.c
index cab998b..2765830 100644
--- a/drivers/memory/tegra/tegra194.c
+++ b/drivers/memory/tegra/tegra194.c
@@ -1347,5 +1347,11 @@ const struct tegra_mc_soc tegra194_mc_soc = {
 	.num_clients = ARRAY_SIZE(tegra194_mc_clients),
 	.clients = tegra194_mc_clients,
 	.num_address_bits = 40,
+	.client_id_mask = 0xff,
+	.intmask = MC_INT_DECERR_ROUTE_SANITY |
+		   MC_INT_DECERR_GENERALIZED_CARVEOUT | MC_INT_DECERR_MTS |
+		   MC_INT_SECERR_SEC | MC_INT_DECERR_VPR |
+		   MC_INT_SECURITY_VIOLATION | MC_INT_DECERR_EMEM,
+	.has_addr_hi_reg = true,
 	.ops = &tegra186_mc_ops,
 };
diff --git a/drivers/memory/tegra/tegra234.c b/drivers/memory/tegra/tegra234.c
index 45efc51..2497b82 100644
--- a/drivers/memory/tegra/tegra234.c
+++ b/drivers/memory/tegra/tegra234.c
@@ -77,5 +77,11 @@ const struct tegra_mc_soc tegra234_mc_soc = {
 	.num_clients = ARRAY_SIZE(tegra234_mc_clients),
 	.clients = tegra234_mc_clients,
 	.num_address_bits = 40,
+	.client_id_mask = 0xff,
+	.intmask = MC_INT_DECERR_ROUTE_SANITY |
+		   MC_INT_DECERR_GENERALIZED_CARVEOUT | MC_INT_DECERR_MTS |
+		   MC_INT_SECERR_SEC | MC_INT_DECERR_VPR |
+		   MC_INT_SECURITY_VIOLATION | MC_INT_DECERR_EMEM,
+	.has_addr_hi_reg = true,
 	.ops = &tegra186_mc_ops,
 };
diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
index 1066b11..8ee0ae4 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -198,6 +198,7 @@ struct tegra_mc_soc {
 	const struct tegra_smmu_soc *smmu;
 
 	u32 intmask;
+	bool has_addr_hi_reg;
 
 	const struct tegra_mc_reset_ops *reset_ops;
 	const struct tegra_mc_reset *resets;
-- 
2.7.4

