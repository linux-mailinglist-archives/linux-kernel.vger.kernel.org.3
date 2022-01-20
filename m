Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF35A494A43
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 10:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240961AbiATJDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 04:03:37 -0500
Received: from mail-co1nam11on2048.outbound.protection.outlook.com ([40.107.220.48]:27489
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231354AbiATJDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 04:03:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H2op0gYJQGf34WNgdFE/2l9hMvIpwia1uv77Zrmtdabl6zIvSGe0MlFuoNvFOvSQY/MSlnBlJU2UzVtgV8rfdXjMQ14Wx6FAqg8JaMO/WDot4xFuQpNR5IjQlEHRj4gkSBs6Sokl80zZ6+Yo+Gk72cRq+/UYYmHg6bTDk4pgKlBy0QG0dqPJOZLgQFy+Pzysy9dlTwNUr5yUDKr0NzfeTJD3F7jgXpnro/JzFoURfLK8hKIjF03a22WyByFVDxSHtyVK/EPgYm8+6DFcFnbiFEVL+4GLcen7YI0VYMMfEN7gDzR1NSVlzRBVNA7CV7VRQIKL0RxuKvy85kiRBOrAkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dmt5KitIk5qxv//VB+yrVZ1jx974AMhMavgfawCeq5c=;
 b=EhwUhmofQPGLTeWVOPewt4g4pHfDIJv8EQpSoDG9wyAk6XWE61dZL9t160YfNRAj/x2RZnGbFMQsE5XhLtAExFnqVj4aSfYgE4ksQpXHLe1NqEMX7gRsk725sJ08dRlX/Ja3VAygNrj/xx5DBqc0TmrZwLcHfDrykdVkDZyry0JMPAs4wP6M6VrMSCVWG2nAzePMHsRjGDVu3e2wqWONbdMyqIhNE07EgqKXdMY6dW/kzF7iM1KPV0BBHdTH1pzFDQhn6n3zt8ZNBZxdCWNq6eot/b0wV4CzCo4NafXmKmR4Rwj9cfkqpcVKTQQWO3l9gG/uSy3DKyg9pIDKQ/uSsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dmt5KitIk5qxv//VB+yrVZ1jx974AMhMavgfawCeq5c=;
 b=i6+Vy0y+3hvaADDc798X8FPNdJcGGyRL/uGR1ZAxhhDXuTLbVkhU5IWyHFnORJQToCPJ0uL8KT177y1zD6dTFnlJJIr49voSfAeLIg2tQadJLqwLBJJBGlbow2TLQzoIlUyB7UlUQtuZyfbW2Gfqi/GRlgT62+OGqR2z7IZwCJnU+MBkhi8n1tNAHqvGLGIaQBQWy9t6HUey24lTiy9ToN+7or0Y+b3oXh1mqDiicFbBGRTh6p0YGvzgPGWTS6sBbgaLD3/Eb87tpKSClpX7lF5hXRF4xAlVoAMHC2mltYk4fZGbbETuooimOb96+5K7f7bYSIXkYUEhefcTbaVkTQ==
Received: from DS7PR03CA0084.namprd03.prod.outlook.com (2603:10b6:5:3bb::29)
 by BN6PR12MB1714.namprd12.prod.outlook.com (2603:10b6:404:107::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Thu, 20 Jan
 2022 09:03:32 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::83) by DS7PR03CA0084.outlook.office365.com
 (2603:10b6:5:3bb::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11 via Frontend
 Transport; Thu, 20 Jan 2022 09:03:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4909.7 via Frontend Transport; Thu, 20 Jan 2022 09:03:31 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 20 Jan
 2022 09:03:31 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 20 Jan
 2022 09:03:30 +0000
Received: from amhetre.nvidia.com (10.127.8.9) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 20 Jan 2022 09:03:27 +0000
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <digetx@gmail.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <krzysztof.kozlowski@canonical.com>, <linux-kernel@vger.kernel.org>
CC:     <Snikam@nvidia.com>, <vdumpa@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>
Subject: [Patch V2] memory: tegra: Add MC error logging on tegra186 onward
Date:   Thu, 20 Jan 2022 14:32:48 +0530
Message-ID: <1642669368-20605-1-git-send-email-amhetre@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a64da251-5102-49d8-ddd9-08d9dbf3bb80
X-MS-TrafficTypeDiagnostic: BN6PR12MB1714:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1714CD579CE244EEADD282CBCA5A9@BN6PR12MB1714.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SEvdlaP4I9kNbnlnOWQbsnWPu5Y7bQTCFgVAM9ffOXaqv8B0eS6+3HxWTLhQw0KcvM3zYJrMNpHYNaUrW7AkDJDs1EpdT89WLGLBhukIhmaLJ8+YU8m9YrhYKmz3i9NOlpDlzD0APNHglA9tw8Dj7ThxOSuS0MKp3WAxff3w5spF7uvkGkqn9xQ+f6cw91gSaUMuwPEVUkyaC0Ue1VDmYob/LzXizRLy1XPjPXiLLjodME5t+6xNM9OsMxVH0fVZ1zK3rkW6XlUf7phmqfXTydjWWDegZv6z6JLP1Gw8RhgtPt91mg0P47c5m2aeFxdq//j4JahkbjTD3ps/OTnal5JuwwmqWhPE2hWI/Kck2NGtvb0076wlsm8OhiYKheWXaPXA2DOhhp0eOaynp4hLktz4kS9JnCyzppuRrnvPIOtrqZLU+Jc918u9e/ND9o6Du5NzUyJWGjIANxaU0EYhKnRvrHEmS4muhYEgu9xHIRBK4TJ4AoWhXAPPcDjS+Ec+FfH3qIYf4zZaRri8NpGKe448qwQyIf3woTV5HqDqLGCuXCg1XBo8j4KzqWQR9uK0aMVBsU7ZA+NiJcu/QbEhTMWaMd1h4Zmwcflm6KzcRz4qk53SNF6jat4pEDI4FUHpCahDLEJepuauHuFTofi4nKvCE+5SvQWN1UgWUU8MkKA0Tt+GsQqepm/LKQqCpr6BiB8DzEUJ0rc0PupRrNtrnHKGg2n3jYv4bhOXpm0R7fHFNRrRWj1uffRB6435UMgovaIG/jOS5hL0vt6BLfEEU4ePPtjL0MwMof6GMJAEEsQ=
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(36840700001)(40470700002)(46966006)(70206006)(70586007)(336012)(508600001)(36756003)(356005)(426003)(6666004)(2616005)(83380400001)(86362001)(110136005)(54906003)(82310400004)(40460700001)(7696005)(316002)(2906002)(186003)(8676002)(36860700001)(26005)(47076005)(4326008)(81166007)(107886003)(8936002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 09:03:31.7550
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a64da251-5102-49d8-ddd9-08d9dbf3bb80
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1714
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
Add register for higher bits of error address and use it on tegra194 and
tegra234.

Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
Changes in v2:
- Updated patch subject and commit message
- Removed separate irq handlers
- Updated tegra30_mc_handle_irq to be used for Tegra186 onwards as well

 drivers/memory/tegra/mc.c       | 73 ++++++++++++++++++++++++++++++++++-------
 drivers/memory/tegra/mc.h       | 16 +++++++++
 drivers/memory/tegra/tegra186.c |  7 ++++
 drivers/memory/tegra/tegra194.c |  5 +++
 drivers/memory/tegra/tegra234.c |  5 +++
 5 files changed, 94 insertions(+), 12 deletions(-)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index bf3abb6..badebe8 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -508,7 +508,21 @@ int tegra30_mc_probe(struct tegra_mc *mc)
 	return 0;
 }
 
-static irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
+const struct tegra_mc_ops tegra30_mc_ops = {
+	.probe = tegra30_mc_probe,
+	.handle_irq = tegra30_mc_handle_irq,
+};
+#endif
+
+#if defined(CONFIG_ARCH_TEGRA_3x_SOC) || \
+    defined(CONFIG_ARCH_TEGRA_114_SOC) || \
+    defined(CONFIG_ARCH_TEGRA_124_SOC) || \
+    defined(CONFIG_ARCH_TEGRA_132_SOC) || \
+    defined(CONFIG_ARCH_TEGRA_210_SOC) || \
+    defined(CONFIG_ARCH_TEGRA_186_SOC) || \
+    defined(CONFIG_ARCH_TEGRA_194_SOC) || \
+    defined(CONFIG_ARCH_TEGRA_234_SOC)
+irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
 {
 	struct tegra_mc *mc = data;
 	unsigned long status;
@@ -521,23 +535,64 @@ static irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
 
 	for_each_set_bit(bit, &status, 32) {
 		const char *error = tegra_mc_status_names[bit] ?: "unknown";
+		u32 status_reg = MC_ERR_STATUS, addr_reg = MC_ERR_ADR;
 		const char *client = "unknown", *desc;
 		const char *direction, *secure;
 		phys_addr_t addr = 0;
+		u32 addr_hi_reg = 0;
 		unsigned int i;
 		char perm[7];
 		u8 id, type;
 		u32 value;
 
-		value = mc_readl(mc, MC_ERR_STATUS);
+#if defined(CONFIG_ARCH_TEGRA_186_SOC) || \
+    defined(CONFIG_ARCH_TEGRA_194_SOC) || \
+    defined(CONFIG_ARCH_TEGRA_234_SOC)
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
+#if defined(CONFIG_ARCH_TEGRA_194_SOC) || \
+    defined(CONFIG_ARCH_TEGRA_234_SOC)
+			addr_hi_reg = MC_ERR_ADR_HI;
+#endif
+			break;
+		}
+#endif
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
+		addr |= mc_readl(mc, addr_reg);
 
 		if (value & MC_ERR_STATUS_RW)
 			direction = "write";
@@ -591,9 +646,6 @@ static irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
 			break;
 		}
 
-		value = mc_readl(mc, MC_ERR_ADR);
-		addr |= value;
-
 		dev_err_ratelimited(mc->dev, "%s: %s%s @%pa: %s (%s%s)\n",
 				    client, secure, direction, &addr, error,
 				    desc, perm);
@@ -604,11 +656,6 @@ static irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
 
 	return IRQ_HANDLED;
 }
-
-const struct tegra_mc_ops tegra30_mc_ops = {
-	.probe = tegra30_mc_probe,
-	.handle_irq = tegra30_mc_handle_irq,
-};
 #endif
 
 const char *const tegra_mc_status_names[32] = {
@@ -622,6 +669,8 @@ const char *const tegra_mc_status_names[32] = {
 	[12] = "VPR violation",
 	[13] = "Secure carveout violation",
 	[16] = "MTS carveout violation",
+	[17] = "Generalized carveout violation",
+	[20] = "Route Sanity error",
 };
 
 const char *const tegra_mc_error_names[8] = {
diff --git a/drivers/memory/tegra/mc.h b/drivers/memory/tegra/mc.h
index 062886e..9b1b0dc 100644
--- a/drivers/memory/tegra/mc.h
+++ b/drivers/memory/tegra/mc.h
@@ -44,6 +44,8 @@
 #define MC_TIMING_CONTROL_DBG				0xf8
 #define MC_TIMING_CONTROL				0xfc
 
+#define MC_INT_DECERR_ROUTE_SANITY			BIT(20)
+#define MC_INT_DECERR_GENERALIZED_CARVEOUT		BIT(17)
 #define MC_INT_DECERR_MTS				BIT(16)
 #define MC_INT_SECERR_SEC				BIT(13)
 #define MC_INT_DECERR_VPR				BIT(12)
@@ -65,6 +67,18 @@
 #define MC_ERR_STATUS_SECURITY				BIT(17)
 #define MC_ERR_STATUS_RW				BIT(16)
 
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
 #define MC_EMEM_ADR_CFG_EMEM_NUMDEV			BIT(0)
 
 #define MC_EMEM_ARB_CFG_CYCLES_PER_UPDATE(x)		((x) & 0x1ff)
@@ -147,12 +161,14 @@ extern const struct tegra_mc_soc tegra234_mc_soc;
     defined(CONFIG_ARCH_TEGRA_132_SOC) || \
     defined(CONFIG_ARCH_TEGRA_210_SOC)
 int tegra30_mc_probe(struct tegra_mc *mc);
+irqreturn_t tegra30_mc_handle_irq(int irq, void *data);
 extern const struct tegra_mc_ops tegra30_mc_ops;
 #endif
 
 #if defined(CONFIG_ARCH_TEGRA_186_SOC) || \
     defined(CONFIG_ARCH_TEGRA_194_SOC) || \
     defined(CONFIG_ARCH_TEGRA_234_SOC)
+irqreturn_t tegra30_mc_handle_irq(int irq, void *data);
 extern const struct tegra_mc_ops tegra186_mc_ops;
 #endif
 
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
index cab998b..6f622d7 100644
--- a/drivers/memory/tegra/tegra194.c
+++ b/drivers/memory/tegra/tegra194.c
@@ -1347,5 +1347,10 @@ const struct tegra_mc_soc tegra194_mc_soc = {
 	.num_clients = ARRAY_SIZE(tegra194_mc_clients),
 	.clients = tegra194_mc_clients,
 	.num_address_bits = 40,
+	.client_id_mask = 0xff,
+	.intmask = MC_INT_DECERR_ROUTE_SANITY |
+		   MC_INT_DECERR_GENERALIZED_CARVEOUT | MC_INT_DECERR_MTS |
+		   MC_INT_SECERR_SEC | MC_INT_DECERR_VPR |
+		   MC_INT_SECURITY_VIOLATION | MC_INT_DECERR_EMEM,
 	.ops = &tegra186_mc_ops,
 };
diff --git a/drivers/memory/tegra/tegra234.c b/drivers/memory/tegra/tegra234.c
index 45efc51..cddb764 100644
--- a/drivers/memory/tegra/tegra234.c
+++ b/drivers/memory/tegra/tegra234.c
@@ -77,5 +77,10 @@ const struct tegra_mc_soc tegra234_mc_soc = {
 	.num_clients = ARRAY_SIZE(tegra234_mc_clients),
 	.clients = tegra234_mc_clients,
 	.num_address_bits = 40,
+	.client_id_mask = 0xff,
+	.intmask = MC_INT_DECERR_ROUTE_SANITY |
+		   MC_INT_DECERR_GENERALIZED_CARVEOUT | MC_INT_DECERR_MTS |
+		   MC_INT_SECERR_SEC | MC_INT_DECERR_VPR |
+		   MC_INT_SECURITY_VIOLATION | MC_INT_DECERR_EMEM,
 	.ops = &tegra186_mc_ops,
 };
-- 
2.7.4

