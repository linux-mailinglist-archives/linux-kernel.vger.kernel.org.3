Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8DE4F57A0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 10:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347583AbiDFHMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 03:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239897AbiDFG5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 02:57:19 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2074.outbound.protection.outlook.com [40.107.96.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DB24A62C6;
        Tue,  5 Apr 2022 22:25:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFtog8bGBi8M2bUDRkFLKEWi9Hb55d5vqJz2WHX1hsN4T/8IBhQmG3odPf6jRcOFQKR7z3bMgQ6sBRg+S0VDlWqw6rDTbkQY/GQcOMCXhZ5bnKHWVH+oDsHnaFFLMTjNFJCkLzHpX2aLHiXtObA2TLgzm+9uiqGLUrv8TSCzWzmJT5ect1mbMe4yeclpuE+OzFMTYp7XrVX6CFLA/E6ccWBx67CQ8uD74TNUKITbCeTms6Rn0QrXGBReIiovP9dx97FgH7s7kNOj87RB7J9z66Rj2xflzJeAodJlK2+ZBr2CWD1V+JFkWt9ihQgsVaqK+WyF+HW+A3QTVWvd2vy5Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwvEEuJ6rLaI0wHAmB3u5L173A3DpSS9OlzEYbgDie8=;
 b=JVaHsgqy+WlSCD7zSkdAKtEq+tMQ6Emr/jN+hH/Zl2GOgXKGBHmIQ1L/t1seG+zPTpaMAsXYPZSiO7L8yC9WWDwgiekuGW67zM7y8jA4KCzjS6a6t2Cl2TnfQr0kmuIjkDQcjHk8E2EQZZzX16CYHAuGfQQGjYMl8wOKObG9opTvnCC/oOnhEZc1xrO1Rwcovfnb+5FVJhPSJWIaMotcYwPVEkc/X/6jdTdUSw6VmTWvaECZoG+7BznhvTdDxN12oeFuWuwAtXNKpKQxN74ZIpyg9TwHm9mqn3GKt+IUdcxowRBH1lufiUOPpHqx8H0RhtcH10iZrnPrrvIeUrLNPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwvEEuJ6rLaI0wHAmB3u5L173A3DpSS9OlzEYbgDie8=;
 b=t/hZMVoVFjwApXrYUSXyJZ0NV3crhxTWFO8NcTHIrgMgnlLwS2XcAp13cp0lDfnpSn05Mq1dv6hwlTVO2JLz4gtYomgv6z6+kkkIMcaFrkvUHWD9W8ulyIXMHdgb480P5oTaarYMRHaRmSJ6RCiZPd9kS9wSbVeUESxCmtJ9H5foCZjI2nWkbMbIr64+keA+qR5LmFicF8oD59KflhRrQEbESqIn3lFoPF3w8fyuml1y763R+wAT+DvR7R/tF33t7lmrS/UpWakgCNMot5ZhiswYrLqqym125B6q5yg7zAyRHznHf/bTTpb3sTuL9LRrY63M5AuOqOqXv0mluWW2oQ==
Received: from MW2PR16CA0043.namprd16.prod.outlook.com (2603:10b6:907:1::20)
 by MWHPR12MB1215.namprd12.prod.outlook.com (2603:10b6:300:d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 05:25:21 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::5c) by MW2PR16CA0043.outlook.office365.com
 (2603:10b6:907:1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.19 via Frontend
 Transport; Wed, 6 Apr 2022 05:25:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5144.20 via Frontend Transport; Wed, 6 Apr 2022 05:25:21 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 6 Apr
 2022 05:25:21 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 5 Apr 2022
 22:25:20 -0700
Received: from amhetre.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Tue, 5 Apr 2022 22:25:16 -0700
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <krzysztof.kozlowski@linaro.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <digetx@gmail.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <vdumpa@nvidia.com>, <Snikam@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>
Subject: [Patch v6 2/4] memory: tegra: Add MC error logging on tegra186 onward
Date:   Wed, 6 Apr 2022 10:54:57 +0530
Message-ID: <20220406052459.10438-3-amhetre@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220406052459.10438-1-amhetre@nvidia.com>
References: <20220406052459.10438-1-amhetre@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 227ce230-11d1-4197-5596-08da178dd866
X-MS-TrafficTypeDiagnostic: MWHPR12MB1215:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB121541B9D1C0273441DB1F48CAE79@MWHPR12MB1215.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PFieehUKTFna0l4njagbYmNF6MZg5wQQXc3sZQu3yKvHZrPz6DUnq/4uHGAPoeCNpIe8voZR/YwWUFAMCOpybg8oxCua9M+i/2BSR9mnmzsxTxWV2TO1tBUuAjCDqt1Gj+1rvmTUQpbL8dFVmY+Kfhv0TGTh4IMD4c5YfdgVNSbkr6S8udn6cnpMGAd0XptneVe/kHjuIFPPkv1o0eBwHswlvXZoKiRtHrsosHeWx5eWXZ9QYL2P4+oM4tvZ+LvzXS0l5zaY9zdlLyGSFy2oeBPJRS4Eo7h5ljZMb7TixDX2xXjZwpWkOTHXJwX7KdIelbTsaz6ltSVsQ81d06xq4QB+xdkj/mh4SxbfMnJKBuzyAkN/W1bbd27qexR8S6LU8UGBno6ik+N2aUzh6jjM3LYn2QJMNEt7Z7tctPdemId57DBPEur/To1lDWkMMgoEjes2NGuiq2PjCsVWP8Z+TARdqn8QavcGphKGlOq6uNxGSHxmUft+55AfDPTDF78cvfRPyiqoGPgw+WkW9XqoYU7Ba/ls51ScHlORSvXHBysLB/Xo77U7gELZoX+CI49bYvIlMdzpOfYKBBQATIZO4J/68aVpuOGJYTlVVqUq0TmhMUSbAf6IgknrJpRJAFRwqilJPrUCr8ojzX807ojMf0PibZxzXveqFOwpkKjPDWWDIDeOYD1bQgG7qebEUpjfXAiE/zWk0VV7QvYZEOsBKg==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(336012)(426003)(86362001)(8936002)(4326008)(2906002)(26005)(47076005)(186003)(8676002)(36860700001)(36756003)(70206006)(70586007)(83380400001)(40460700003)(30864003)(82310400005)(110136005)(81166007)(54906003)(356005)(2616005)(316002)(7696005)(508600001)(5660300002)(1076003)(6666004)(107886003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 05:25:21.3196
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 227ce230-11d1-4197-5596-08da178dd866
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1215
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for reading MC_GLOBAL_INTSTATUS register which points to the
memory controller channels on which interrupts have occurred.
Add new function 'global_intstatus_to_channel' which returns the channel
which should be used to get the information of interrupts.
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
Clear the global_intstatus bit corresponding to channel of which
interrupts are logged.

Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 drivers/memory/tegra/mc.c       | 128 ++++++++++++++++++++++++++++----
 drivers/memory/tegra/mc.h       |  37 ++++++++-
 drivers/memory/tegra/tegra186.c |   9 +++
 drivers/memory/tegra/tegra194.c |   8 ++
 drivers/memory/tegra/tegra234.c |   7 ++
 include/soc/tegra/mc.h          |   3 +
 6 files changed, 175 insertions(+), 17 deletions(-)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index 3cda1d9ad32a..6f4e29d4bd33 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -508,14 +508,48 @@ int tegra30_mc_probe(struct tegra_mc *mc)
 	return 0;
 }
 
-static irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
+const struct tegra_mc_ops tegra30_mc_ops = {
+	.probe = tegra30_mc_probe,
+	.handle_irq = tegra30_mc_handle_irq,
+};
+#endif
+
+static int global_intstatus_to_channel(const struct tegra_mc *mc, u32 status,
+				       unsigned int *mc_channel)
+{
+	if ((status & mc->soc->ch_intmask) == 0)
+		return -EINVAL;
+
+	*mc_channel = __ffs((status & mc->soc->ch_intmask) >>
+			    mc->soc->status_reg_chan_shift);
+
+	return 0;
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
+		err = global_intstatus_to_channel(mc, global_status, &channel);
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
 
@@ -523,18 +557,70 @@ static irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
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
@@ -591,7 +677,10 @@ static irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
 			break;
 		}
 
-		value = mc_readl(mc, MC_ERR_ADR);
+		if (mc->soc->num_channels)
+			value = mc_ch_readl(mc, channel, addr_reg);
+		else
+			value = mc_readl(mc, addr_reg);
 		addr |= value;
 
 		dev_err_ratelimited(mc->dev, "%s: %s%s @%pa: %s (%s%s)\n",
@@ -600,17 +689,18 @@ static irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
 	}
 
 	/* clear interrupts */
-	mc_writel(mc, status, MC_INTSTATUS);
+	if (mc->soc->num_channels) {
+		u32 status_chan_bit;
+
+		mc_ch_writel(mc, channel, status, MC_INTSTATUS);
+		status_chan_bit = BIT(channel) << mc->soc->status_reg_chan_shift;
+		mc_ch_writel(mc, MC_BROADCAST_CHANNEL, status_chan_bit, MC_GLOBAL_INTSTATUS);
+	} else
+		mc_writel(mc, status, MC_INTSTATUS);
 
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
@@ -622,6 +712,8 @@ const char *const tegra_mc_status_names[32] = {
 	[12] = "VPR violation",
 	[13] = "Secure carveout violation",
 	[16] = "MTS carveout violation",
+	[17] = "Generalized carveout violation",
+	[20] = "Route Sanity error",
 };
 
 const char *const tegra_mc_error_names[8] = {
@@ -770,7 +862,11 @@ static int tegra_mc_probe(struct platform_device *pdev)
 
 		WARN(!mc->soc->client_id_mask, "missing client ID mask for this SoC\n");
 
-		mc_writel(mc, mc->soc->intmask, MC_INTMASK);
+		if (mc->soc->num_channels && mc->bcast_ch_regs)
+			mc_ch_writel(mc, MC_BROADCAST_CHANNEL, mc->soc->intmask,
+				     MC_INTMASK);
+		else
+			mc_writel(mc, mc->soc->intmask, MC_INTMASK);
 
 		err = devm_request_irq(&pdev->dev, mc->irq, mc->soc->ops->handle_irq, 0,
 				       dev_name(&pdev->dev), mc);
diff --git a/drivers/memory/tegra/mc.h b/drivers/memory/tegra/mc.h
index 062886e94c04..77b3873e245c 100644
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
@@ -92,6 +108,24 @@ icc_provider_to_tegra_mc(struct icc_provider *provider)
 	return container_of(provider, struct tegra_mc, provider);
 }
 
+static inline u32 mc_ch_readl(const struct tegra_mc *mc, int ch,
+			       unsigned long offset)
+{
+	if (ch == MC_BROADCAST_CHANNEL)
+		return readl_relaxed(mc->bcast_ch_regs + offset);
+
+	return readl_relaxed(mc->ch_regs[ch] + offset);
+}
+
+static inline void mc_ch_writel(const struct tegra_mc *mc, int ch,
+				u32 value, unsigned long offset)
+{
+	if (ch == MC_BROADCAST_CHANNEL)
+		writel_relaxed(value, mc->bcast_ch_regs + offset);
+	else
+		writel_relaxed(value, mc->ch_regs[ch] + offset);
+}
+
 static inline u32 mc_readl(const struct tegra_mc *mc, unsigned long offset)
 {
 	return readl_relaxed(mc->regs + offset);
@@ -156,6 +190,7 @@ extern const struct tegra_mc_ops tegra30_mc_ops;
 extern const struct tegra_mc_ops tegra186_mc_ops;
 #endif
 
+irqreturn_t tegra30_mc_handle_irq(int irq, void *data);
 extern const char * const tegra_mc_status_names[32];
 extern const char * const tegra_mc_error_names[8];
 
diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
index 2ca8ce349188..bb2cc405eb20 100644
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
@@ -197,6 +199,7 @@ const struct tegra_mc_ops tegra186_mc_ops = {
 	.resume = tegra186_mc_resume,
 	.probe_device = tegra186_mc_probe_device,
 	.map_regs = tegra186_mc_map_regs,
+	.handle_irq = tegra30_mc_handle_irq,
 };
 
 #if defined(CONFIG_ARCH_TEGRA_186_SOC)
@@ -929,6 +932,12 @@ const struct tegra_mc_soc tegra186_mc_soc = {
 	.clients = tegra186_mc_clients,
 	.num_address_bits = 40,
 	.num_channels = 4,
+	.client_id_mask = 0xff,
+	.intmask = MC_INT_DECERR_GENERALIZED_CARVEOUT | MC_INT_DECERR_MTS |
+		   MC_INT_SECERR_SEC | MC_INT_DECERR_VPR |
+		   MC_INT_SECURITY_VIOLATION | MC_INT_DECERR_EMEM,
 	.ops = &tegra186_mc_ops,
+	.ch_intmask = 0x0000000f,
+	.status_reg_chan_shift = 0,
 };
 #endif
diff --git a/drivers/memory/tegra/tegra194.c b/drivers/memory/tegra/tegra194.c
index 94001174deaf..963d6085a247 100644
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
+	.status_reg_chan_shift = 8,
 };
diff --git a/drivers/memory/tegra/tegra234.c b/drivers/memory/tegra/tegra234.c
index 6335a132be2d..44884fb78b5c 100644
--- a/drivers/memory/tegra/tegra234.c
+++ b/drivers/memory/tegra/tegra234.c
@@ -98,5 +98,12 @@ const struct tegra_mc_soc tegra234_mc_soc = {
 	.clients = tegra234_mc_clients,
 	.num_address_bits = 40,
 	.num_channels = 16,
+	.intmask = MC_INT_DECERR_ROUTE_SANITY |
+		   MC_INT_DECERR_GENERALIZED_CARVEOUT | MC_INT_DECERR_MTS |
+		   MC_INT_SECERR_SEC | MC_INT_DECERR_VPR |
+		   MC_INT_SECURITY_VIOLATION | MC_INT_DECERR_EMEM,
+	.has_addr_hi_reg = true,
 	.ops = &tegra186_mc_ops,
+	.ch_intmask = 0x0000ff00,
+	.status_reg_chan_shift = 8,
 };
diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
index c3c121fbfbb7..284ad5988d10 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -203,6 +203,9 @@ struct tegra_mc_soc {
 	const struct tegra_smmu_soc *smmu;
 
 	u32 intmask;
+	u32 ch_intmask;
+	u32 status_reg_chan_shift;
+	bool has_addr_hi_reg;
 
 	const struct tegra_mc_reset_ops *reset_ops;
 	const struct tegra_mc_reset *resets;
-- 
2.17.1

