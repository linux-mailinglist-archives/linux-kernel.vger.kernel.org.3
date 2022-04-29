Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E2051484A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 13:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358556AbiD2Lil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 07:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358539AbiD2Li0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 07:38:26 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426B2C6671;
        Fri, 29 Apr 2022 04:35:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKf7WGNhTSTVoL9BZbQ8OI6UNWrWnqvKrer7bK5aY7bnn4eW0UpdJ/iKBRAo2yBn7MxK/CJKJVTCnlcTu297t0qpXhLUbFvLFe+DwHVAQSyXSkl3fVPv5W/UwSvHY2MeW9WE6dSlcO3T+zG+c4VxMslgmjgE0LiSwGMjzIIPEygMYnrSjCeHHGhKXoqtSeMZCeswCsv7XxCmz+KKO3beTDckQkahlbH/UJfxY6F1iY1Fb/SZEO3668YnRCPMyH6affGCzoRP1RV0EL5XWdcKxbSphhOdAs5ppNVWY3miwg8CjVlFq4M69CqWpXBNSrk2/IemxpqiUfpi4GvPg8UjlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dS17vuFxD7r8auKrzCPU+ukn1xYBrROvLasdUlWT6lw=;
 b=jryrmsDU1sxE3YnUdk1Fex+N4t4hRxkb2vbC9W+B5kq2xFOa4vVxs+aLpuWT3WNczBWNXkIDA2e3R2Um+EgTBcm0ZFf0L4yuYvmJsYfRRvXeDvox+uJ9C9Mz7KyLyMv5L8EaDKLOVpZiUWsnMe4592h28lEw0MlYoyMKjXxgObnUGqUR3aP/kKAiJDXMTKkK/pyxomIQ7Ygdq2Gz2rRtweSA0FAJX6bViEkMBxKyK4dNmu1qAQtJXajnqQLS8qs5gmD5yIDs/k3+MG+1KJG3YYhgdqL4Y3nKKkAMNN3jlFgmc4xGEBfWnKyZpHFFTYGpLgF+0lu3p4KBYH4X8TeoUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dS17vuFxD7r8auKrzCPU+ukn1xYBrROvLasdUlWT6lw=;
 b=OSkLOc4nD2Hx9+8Y95BVHGMIFAs6XiI5ewlHiuh0uXVzrilQkO1QcoPpIFCQaxJ1X1zlbJuwbneCHnwORbC5vkjf2AYCsOe3WoU+yHlPSZK4ILcVsIDwH0cX7w6bcXV4lrrhLlBp/SkpiAH4JpRuHVmHF2D2+4PvJKcprYF0IGB39iTinRJ9Vtstr8LJjS73NG0DoIfOPS4nCzTGIMBDehSyiWmvVfhtR0X3XUAXY9GvFhw5Rh2ysDeCnx061qolgs9TvJMl06WDZQOJYNHi8eD2p3YzsiO/cPRSl+HXyjLWovBD7g+3L9kMGwxCJtDm8OAl9Ks2JfkgUGtHmvlSrg==
Received: from MW4PR04CA0250.namprd04.prod.outlook.com (2603:10b6:303:88::15)
 by BN6PR1201MB0132.namprd12.prod.outlook.com (2603:10b6:405:4d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.17; Fri, 29 Apr
 2022 11:34:59 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::16) by MW4PR04CA0250.outlook.office365.com
 (2603:10b6:303:88::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Fri, 29 Apr 2022 11:34:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 11:34:58 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 DRHQMAIL109.nvidia.com (10.27.9.19) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Fri, 29 Apr 2022 11:34:58 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 29 Apr 2022 04:34:57 -0700
Received: from amhetre.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Fri, 29 Apr 2022 04:34:53 -0700
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <krzysztof.kozlowski@linaro.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <digetx@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <dmitry.osipenko@collabora.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <vdumpa@nvidia.com>, <Snikam@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>
Subject: [Patch v10 2/4] memory: tegra: Add MC error logging on tegra186 onward
Date:   Fri, 29 Apr 2022 17:04:36 +0530
Message-ID: <20220429113438.13988-3-amhetre@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220429113438.13988-1-amhetre@nvidia.com>
References: <20220429113438.13988-1-amhetre@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78a281f0-784c-4d53-57dc-08da29d44ab7
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0132:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0132ABA8E9CF814F3565BF80CAFC9@BN6PR1201MB0132.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: slQVPkFs32U0ncoCX49aIVceQ3MzWZFBgBJ/dghH2NiCdhZJOVJzJo3y4t4LxOMMa/Ln171HJ9cOIX0AZ/s5OC2bcCUwi9Zqds2cj49mjoZIAEw5lAVFCmYzzAW6p/wmp+T7fwXbtheU4MNr0ve8P1pcvfuVP8ygS/lQMGNW0pyQ35IBeU4MYcjZPHrhGFOb7sXhXYJk5ZnP5uDKHf+EJxY8poZoiWAvxtbAo0GMTmPWbi4SsCIB8ZzDpy9xU0QJ760i9VDFqJ/MSavvkmHrd5OjWR1/PVmIeVw6g5wH4FSulDxSz5MEFSOqoe9FBoRkx9XuIsYcNWK2lFfMwWwPIH1IrWBH8JRygEtAQ3H1jtKy2aU45omwXbjMFWUu4JwWRHde1uNMJLzt+uxwRm4CLZNCZFN6aiTw6BXsqoPzBP6ZFSsena9jgOCu1Do1Ok1sllM2+vkhQLzSuxM0KIw9kWAyckoS22fWtCvqJsE9lsCeztam/df3FxKdI59+lVqKccWjhjml8OkcHRpHJt6cTJlrbvNitsvJFrZNEkbXxB2i4xE0UcuITmqtBh0zuUk1/0F7V5khflHayBGhF6tQTAZuC9y3QBlbD747NUnCQv1PWyikO0rzn/exQQLAHKIvUWY02j9Gq1ETNcRRPZ/Bb0SBjStVBesLpTEXcomtEcvawsMfkpRWDVEG+A+1jlxuE0dqzRqQopSaN7Ud7cRWSw32uoXjA3UaivCU8rA19kM=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(8676002)(26005)(86362001)(2906002)(6666004)(7696005)(70206006)(70586007)(316002)(5660300002)(54906003)(81166007)(82310400005)(4326008)(36860700001)(921005)(356005)(110136005)(36756003)(47076005)(186003)(83380400001)(1076003)(2616005)(40460700003)(107886003)(336012)(30864003)(508600001)(426003)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 11:34:58.8275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a281f0-784c-4d53-57dc-08da29d44ab7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0132
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for logging memory controller errors on tegra186, tegra194
and tegra234. On these SoCs, interrupts can occur on multiple channels.
Add support required to read the status of interrupts across multiple
channels, log and clear them.
Also add new interrupts supported on these SoCs.

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 drivers/memory/tegra/mc.c       | 134 ++++++++++++++++++++++++++++----
 drivers/memory/tegra/mc.h       |  43 +++++++++-
 drivers/memory/tegra/tegra186.c |   9 +++
 drivers/memory/tegra/tegra194.c |   8 ++
 drivers/memory/tegra/tegra234.c |   8 ++
 include/soc/tegra/mc.h          |   5 +-
 6 files changed, 189 insertions(+), 18 deletions(-)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index 580e0987e5cd..2f7a58a9df1a 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -508,14 +508,54 @@ int tegra30_mc_probe(struct tegra_mc *mc)
 	return 0;
 }
 
-static irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
+const struct tegra_mc_ops tegra30_mc_ops = {
+	.probe = tegra30_mc_probe,
+	.handle_irq = tegra30_mc_handle_irq,
+};
+#endif
+
+static int mc_global_intstatus_to_channel(const struct tegra_mc *mc, u32 status,
+					  unsigned int *mc_channel)
+{
+	if ((status & mc->soc->ch_intmask) == 0)
+		return -EINVAL;
+
+	*mc_channel = __ffs((status & mc->soc->ch_intmask) >>
+			    mc->soc->global_intstatus_channel_shift);
+
+	return 0;
+}
+
+static u32 mc_channel_to_global_intstatus(const struct tegra_mc *mc,
+					  unsigned int channel)
+{
+	return BIT(channel) << mc->soc->global_intstatus_channel_shift;
+}
+
+irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
 {
 	struct tegra_mc *mc = data;
+	unsigned int bit, channel;
 	unsigned long status;
-	unsigned int bit;
 
-	/* mask all interrupts to avoid flooding */
-	status = mc_readl(mc, MC_INTSTATUS) & mc->soc->intmask;
+	if (mc->soc->num_channels) {
+		u32 global_status;
+		int err;
+
+		global_status = mc_ch_readl(mc, MC_BROADCAST_CHANNEL, MC_GLOBAL_INTSTATUS);
+		err = mc_global_intstatus_to_channel(mc, global_status, &channel);
+		if (err < 0) {
+			dev_err_ratelimited(mc->dev, "unknown interrupt channel 0x%08x\n",
+					    global_status);
+			return IRQ_NONE;
+		}
+
+		/* mask all interrupts to avoid flooding */
+		status = mc_ch_readl(mc, channel, MC_INTSTATUS) & mc->soc->intmask;
+	} else {
+		status = mc_readl(mc, MC_INTSTATUS) & mc->soc->intmask;
+	}
+
 	if (!status)
 		return IRQ_NONE;
 
@@ -523,18 +563,70 @@ static irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
 		const char *error = tegra_mc_status_names[bit] ?: "unknown";
 		const char *client = "unknown", *desc;
 		const char *direction, *secure;
+		u32 status_reg, addr_reg;
+		u32 intmask = BIT(bit);
 		phys_addr_t addr = 0;
+#ifdef CONFIG_PHYS_ADDR_T_64BIT
+		u32 addr_hi_reg = 0;
+#endif
 		unsigned int i;
 		char perm[7];
 		u8 id, type;
 		u32 value;
 
-		value = mc_readl(mc, MC_ERR_STATUS);
+		switch (intmask) {
+		case MC_INT_DECERR_VPR:
+			status_reg = MC_ERR_VPR_STATUS;
+			addr_reg = MC_ERR_VPR_ADR;
+			break;
+
+		case MC_INT_SECERR_SEC:
+			status_reg = MC_ERR_SEC_STATUS;
+			addr_reg = MC_ERR_SEC_ADR;
+			break;
+
+		case MC_INT_DECERR_MTS:
+			status_reg = MC_ERR_MTS_STATUS;
+			addr_reg = MC_ERR_MTS_ADR;
+			break;
+
+		case MC_INT_DECERR_GENERALIZED_CARVEOUT:
+			status_reg = MC_ERR_GENERALIZED_CARVEOUT_STATUS;
+			addr_reg = MC_ERR_GENERALIZED_CARVEOUT_ADR;
+			break;
+
+		case MC_INT_DECERR_ROUTE_SANITY:
+			status_reg = MC_ERR_ROUTE_SANITY_STATUS;
+			addr_reg = MC_ERR_ROUTE_SANITY_ADR;
+			break;
+
+		default:
+			status_reg = MC_ERR_STATUS;
+			addr_reg = MC_ERR_ADR;
+
+#ifdef CONFIG_PHYS_ADDR_T_64BIT
+			if (mc->soc->has_addr_hi_reg)
+				addr_hi_reg = MC_ERR_ADR_HI;
+#endif
+			break;
+		}
+
+		if (mc->soc->num_channels)
+			value = mc_ch_readl(mc, channel, status_reg);
+		else
+			value = mc_readl(mc, status_reg);
 
 #ifdef CONFIG_PHYS_ADDR_T_64BIT
 		if (mc->soc->num_address_bits > 32) {
-			addr = ((value >> MC_ERR_STATUS_ADR_HI_SHIFT) &
-				MC_ERR_STATUS_ADR_HI_MASK);
+			if (addr_hi_reg) {
+				if (mc->soc->num_channels)
+					addr = mc_ch_readl(mc, channel, addr_hi_reg);
+				else
+					addr = mc_readl(mc, addr_hi_reg);
+			} else {
+				addr = ((value >> MC_ERR_STATUS_ADR_HI_SHIFT) &
+					MC_ERR_STATUS_ADR_HI_MASK);
+			}
 			addr <<= 32;
 		}
 #endif
@@ -591,7 +683,10 @@ static irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
 			break;
 		}
 
-		value = mc_readl(mc, MC_ERR_ADR);
+		if (mc->soc->num_channels)
+			value = mc_ch_readl(mc, channel, addr_reg);
+		else
+			value = mc_readl(mc, addr_reg);
 		addr |= value;
 
 		dev_err_ratelimited(mc->dev, "%s: %s%s @%pa: %s (%s%s)\n",
@@ -600,17 +695,18 @@ static irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
 	}
 
 	/* clear interrupts */
-	mc_writel(mc, status, MC_INTSTATUS);
+	if (mc->soc->num_channels) {
+		mc_ch_writel(mc, channel, status, MC_INTSTATUS);
+		mc_ch_writel(mc, MC_BROADCAST_CHANNEL,
+			     mc_channel_to_global_intstatus(mc, channel),
+			     MC_GLOBAL_INTSTATUS);
+	} else {
+		mc_writel(mc, status, MC_INTSTATUS);
+	}
 
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
@@ -622,6 +718,8 @@ const char *const tegra_mc_status_names[32] = {
 	[12] = "VPR violation",
 	[13] = "Secure carveout violation",
 	[16] = "MTS carveout violation",
+	[17] = "Generalized carveout violation",
+	[20] = "Route Sanity error",
 };
 
 const char *const tegra_mc_error_names[8] = {
@@ -762,7 +860,11 @@ static int tegra_mc_probe(struct platform_device *pdev)
 
 		WARN(!mc->soc->client_id_mask, "missing client ID mask for this SoC\n");
 
-		mc_writel(mc, mc->soc->intmask, MC_INTMASK);
+		if (mc->soc->num_channels)
+			mc_ch_writel(mc, MC_BROADCAST_CHANNEL, mc->soc->intmask,
+				     MC_INTMASK);
+		else
+			mc_writel(mc, mc->soc->intmask, MC_INTMASK);
 
 		err = devm_request_irq(&pdev->dev, mc->irq, mc->soc->ops->handle_irq, 0,
 				       dev_name(&pdev->dev), mc);
diff --git a/drivers/memory/tegra/mc.h b/drivers/memory/tegra/mc.h
index 062886e94c04..bc01586b6560 100644
--- a/drivers/memory/tegra/mc.h
+++ b/drivers/memory/tegra/mc.h
@@ -43,7 +43,21 @@
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
+#define MC_GLOBAL_INTSTATUS				0xf24
+#define MC_ERR_ADR_HI					0x11fc
+
+#define MC_INT_DECERR_ROUTE_SANITY			BIT(20)
+#define MC_INT_DECERR_GENERALIZED_CARVEOUT		BIT(17)
 #define MC_INT_DECERR_MTS				BIT(16)
 #define MC_INT_SECERR_SEC				BIT(13)
 #define MC_INT_DECERR_VPR				BIT(12)
@@ -78,6 +92,8 @@
 
 #define MC_TIMING_UPDATE				BIT(0)
 
+#define MC_BROADCAST_CHANNEL				~0
+
 static inline u32 tegra_mc_scale_percents(u64 val, unsigned int percents)
 {
 	val = val * percents;
@@ -92,6 +108,30 @@ icc_provider_to_tegra_mc(struct icc_provider *provider)
 	return container_of(provider, struct tegra_mc, provider);
 }
 
+static inline u32 mc_ch_readl(const struct tegra_mc *mc, int ch,
+			      unsigned long offset)
+{
+	if (!mc->bcast_ch_regs)
+		return 0;
+
+	if (ch == MC_BROADCAST_CHANNEL)
+		return readl_relaxed(mc->bcast_ch_regs + offset);
+
+	return readl_relaxed(mc->ch_regs[ch] + offset);
+}
+
+static inline void mc_ch_writel(const struct tegra_mc *mc, int ch,
+				u32 value, unsigned long offset)
+{
+	if (!mc->bcast_ch_regs)
+		return;
+
+	if (ch == MC_BROADCAST_CHANNEL)
+		writel_relaxed(value, mc->bcast_ch_regs + offset);
+	else
+		writel_relaxed(value, mc->ch_regs[ch] + offset);
+}
+
 static inline u32 mc_readl(const struct tegra_mc *mc, unsigned long offset)
 {
 	return readl_relaxed(mc->regs + offset);
@@ -156,6 +196,7 @@ extern const struct tegra_mc_ops tegra30_mc_ops;
 extern const struct tegra_mc_ops tegra186_mc_ops;
 #endif
 
+irqreturn_t tegra30_mc_handle_irq(int irq, void *data);
 extern const char * const tegra_mc_status_names[32];
 extern const char * const tegra_mc_error_names[8];
 
diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
index cd7f9079312f..949cb5ae95e3 100644
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
@@ -171,6 +173,7 @@ const struct tegra_mc_ops tegra186_mc_ops = {
 	.remove = tegra186_mc_remove,
 	.resume = tegra186_mc_resume,
 	.probe_device = tegra186_mc_probe_device,
+	.handle_irq = tegra30_mc_handle_irq,
 };
 
 #if defined(CONFIG_ARCH_TEGRA_186_SOC)
@@ -903,6 +906,12 @@ const struct tegra_mc_soc tegra186_mc_soc = {
 	.clients = tegra186_mc_clients,
 	.num_address_bits = 40,
 	.num_channels = 4,
+	.client_id_mask = 0xff,
+	.intmask = MC_INT_DECERR_GENERALIZED_CARVEOUT | MC_INT_DECERR_MTS |
+		   MC_INT_SECERR_SEC | MC_INT_DECERR_VPR |
+		   MC_INT_SECURITY_VIOLATION | MC_INT_DECERR_EMEM,
 	.ops = &tegra186_mc_ops,
+	.ch_intmask = 0x0000000f,
+	.global_intstatus_channel_shift = 0,
 };
 #endif
diff --git a/drivers/memory/tegra/tegra194.c b/drivers/memory/tegra/tegra194.c
index 94001174deaf..b2416ee3ac26 100644
--- a/drivers/memory/tegra/tegra194.c
+++ b/drivers/memory/tegra/tegra194.c
@@ -1348,5 +1348,13 @@ const struct tegra_mc_soc tegra194_mc_soc = {
 	.clients = tegra194_mc_clients,
 	.num_address_bits = 40,
 	.num_channels = 16,
+	.client_id_mask = 0xff,
+	.intmask = MC_INT_DECERR_ROUTE_SANITY |
+		   MC_INT_DECERR_GENERALIZED_CARVEOUT | MC_INT_DECERR_MTS |
+		   MC_INT_SECERR_SEC | MC_INT_DECERR_VPR |
+		   MC_INT_SECURITY_VIOLATION | MC_INT_DECERR_EMEM,
+	.has_addr_hi_reg = true,
 	.ops = &tegra186_mc_ops,
+	.ch_intmask = 0x00000f00,
+	.global_intstatus_channel_shift = 8,
 };
diff --git a/drivers/memory/tegra/tegra234.c b/drivers/memory/tegra/tegra234.c
index 6335a132be2d..e23ebd421f17 100644
--- a/drivers/memory/tegra/tegra234.c
+++ b/drivers/memory/tegra/tegra234.c
@@ -98,5 +98,13 @@ const struct tegra_mc_soc tegra234_mc_soc = {
 	.clients = tegra234_mc_clients,
 	.num_address_bits = 40,
 	.num_channels = 16,
+	.client_id_mask = 0x1ff,
+	.intmask = MC_INT_DECERR_ROUTE_SANITY |
+		   MC_INT_DECERR_GENERALIZED_CARVEOUT | MC_INT_DECERR_MTS |
+		   MC_INT_SECERR_SEC | MC_INT_DECERR_VPR |
+		   MC_INT_SECURITY_VIOLATION | MC_INT_DECERR_EMEM,
+	.has_addr_hi_reg = true,
 	.ops = &tegra186_mc_ops,
+	.ch_intmask = 0x0000ff00,
+	.global_intstatus_channel_shift = 8,
 };
diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
index 40f1d02a1358..47ce6d434427 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -193,12 +193,15 @@ struct tegra_mc_soc {
 	unsigned int num_address_bits;
 	unsigned int atom_size;
 
-	u8 client_id_mask;
+	u16 client_id_mask;
 	u8 num_channels;
 
 	const struct tegra_smmu_soc *smmu;
 
 	u32 intmask;
+	u32 ch_intmask;
+	u32 global_intstatus_channel_shift;
+	bool has_addr_hi_reg;
 
 	const struct tegra_mc_reset_ops *reset_ops;
 	const struct tegra_mc_reset *resets;
-- 
2.17.1

