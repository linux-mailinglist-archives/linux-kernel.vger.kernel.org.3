Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B524C9FAF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 09:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240155AbiCBIp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 03:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240044AbiCBIpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 03:45:18 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9608DBAB9D;
        Wed,  2 Mar 2022 00:44:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BiTxFXJLJ5XN7Brxj0aqyQRvyKi/wI+y7rZSmMkortGyNSqDJtNXRV6RGsl4EVHMsdRp428rShtbFgqJdw16mB6HlG39OnVGiK4oDkYNB+dcK8faCGISLQfuL+N7Kln06WQN0+i7ZZzvEJhzPrVwzXzOaXRUwOLRbdJP+P2xbEmCBGGmO9EsQdPx5iFCr/B7HLkcCNwaVkCW0RH+4SWDjXKJVW/7N+8TGX0XfG2AycpPVZCA11Pbw+IL0pNjwl+LeKkg9Bpz1L60OrmfE3sFSGsiozqnKRWxxMcyqXBKFAWkABlKk0Wkx8qdcRww5SD2ISgMZ9Dm2pkoNHBYv9N0pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vW4s4F+DuxJ2yCCx+lL6FOhzaqwbYDcf/dPYcQXSTB0=;
 b=ZRQ5A0GvTe8QD4HlOq2jG+XUPSMOjl8hOdd/rRhurq6nvWRLV+uGYqWJ3dU0FFF60e31FL+EosBBaSHsRPmxUSYHNNexid64SFh4hH4uOOituFuENWLUKtelivHj5d0VZOeQJd3PHegFFxnarCO/kRaxVw5dxedOdQKHu9xf2acVhdShUU+aEbZ5L09Q7guCfcv5BoQ32bBs6viMMQB7WVw3o1mH0IjaW6wPJdGqW5oX70AlE4Sd0fiwjmRmas9Dpj85pkddkkal7cLE1fK6MCJkFlBBuOhXIMRVr0GqTTTphs8t30Q3Hf+qa/TaIp8d9EqwnW4BTe8+LKwj/Kongw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vW4s4F+DuxJ2yCCx+lL6FOhzaqwbYDcf/dPYcQXSTB0=;
 b=Od4xJsXwLKbCR8N31uvrVDihRI00IL8Z+PTJGO3dux5L4qKZX4oOwpnJED+1Co4Fpf4wrnMX3l3O3gcHUpwfSXxo9ztEtGGcKRpv2BFSsSxk2wdSoAGaoseqbDdNf9j6qbS7+MjC9lX3eBx4PSMiBgejcQqnWJdobB1C/W2fpU1da2vqX+p3HPvjpB6rwZhga1sKwxgmx8hz1sbyVBx40tfJ9CbxJyJ9twSuIltlnf8iAWtR5+z6ttZwvSB1YMgN9a2HKMrEnbSCazbrZrEHjiTI6AFpuV/R5YR1D4Ywu84qLWrjbeImFmlMZkjHqkKnDnbh5yV8J0C1EDzeuoAQGQ==
Received: from BN8PR15CA0041.namprd15.prod.outlook.com (2603:10b6:408:80::18)
 by BL0PR12MB2402.namprd12.prod.outlook.com (2603:10b6:207:45::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13; Wed, 2 Mar
 2022 08:44:32 +0000
Received: from BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::e1) by BN8PR15CA0041.outlook.office365.com
 (2603:10b6:408:80::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Wed, 2 Mar 2022 08:44:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT049.mail.protection.outlook.com (10.13.177.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5038.14 via Frontend Transport; Wed, 2 Mar 2022 08:44:32 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 2 Mar
 2022 08:44:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Wed, 2 Mar 2022
 00:44:30 -0800
Received: from amhetre.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Wed, 2 Mar 2022 00:44:26 -0800
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski@canonical.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <digetx@gmail.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>
CC:     <vdumpa@nvidia.com>, <Snikam@nvidia.com>, <amhetre@nvidia.com>
Subject: [Patch v4 4/4] memory: tegra: Add MC error logging on tegra186 onward
Date:   Wed, 2 Mar 2022 14:13:29 +0530
Message-ID: <1646210609-21943-5-git-send-email-amhetre@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1646210609-21943-1-git-send-email-amhetre@nvidia.com>
References: <1646210609-21943-1-git-send-email-amhetre@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45e5324d-1943-47da-8d51-08d9fc28df5f
X-MS-TrafficTypeDiagnostic: BL0PR12MB2402:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB2402BD27FBAE96094CB26490CA039@BL0PR12MB2402.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CVPmgrDkx0zRREn0aUwDKGylwFGmdOBwiCUe5NWSZQtlFK/tuyrKsjXJGT6MmJbATPeZLbL0FO54++7ZbG1KdPR59B2k+DLH2rGS4duotiD7IkAYXk+KZBDfXM/AVH0KJyGdL+wQ/kVodhWYhW0nPQ9P1xVzwPIXpa+CRdbTqCZU35gpR0cNg99KVx0lsYaKfqDbm/XDP1RjPWlNDSwF023e3E8l3RH0RLresgTy4yTKBspQxgNuhuaaryGIBxj2ISV4g6AH3g/Bu1ZiVSn2+B/RyUQvScf3q4cdbVKtGZJGOx8lNwvTINJjgCLljpT+m/TkxPSkONRqn/L9iVwkcwUr3M/5DrliBlHZLPJqa1Bs/CnpCzTY1MiUoU0MMuNYhSMLlZHrfALJVw5tD6MUknmINf+BVXcThKSBgzu5MwgXnbHZiLswf7nBERV+kVV+II0lCl6XgwZ6GvZbiJUMa5V16VWzJWHJIhSMJMdXQJXB1SQrTqJ4q22ImvSNHmsQ7flNfCXWq6YHNrUH8U3QFd9yVOSDlBXOjm4VZ+wUg8R3CqZNExNIQBa4XamV7sArIUdnlAxYFdWhVypQVa+lEHR0XyCqOPbsJbZ17C+q/38mdzrNm35aMC9u0daM12baGWeEVDAJlSnkHt6wIgd6Z/hIwMccRzb/gJc1zxKsENwzNSjIPYYZ2Jdhx59qRVxgkAj6dlizZhbH00L7/6Z4yw==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(316002)(8936002)(4326008)(8676002)(5660300002)(26005)(54906003)(110136005)(40460700003)(2906002)(86362001)(36756003)(508600001)(70206006)(30864003)(70586007)(36860700001)(7696005)(356005)(81166007)(2616005)(82310400004)(426003)(336012)(47076005)(83380400001)(186003)(107886003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 08:44:32.3760
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e5324d-1943-47da-8d51-08d9fc28df5f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2402
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new function 'get_int_channel' in tegra_mc_soc struture which is
implemented by tegra SOCs which support multiple MC channels. This
function returns the channel which should be used to get the information
of interrupts.
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
 drivers/memory/tegra/mc.c       | 102 ++++++++++++++++++++++++++++++++++------
 drivers/memory/tegra/mc.h       |  37 ++++++++++++++-
 drivers/memory/tegra/tegra186.c |  45 ++++++++++++++++++
 drivers/memory/tegra/tegra194.c |  44 +++++++++++++++++
 drivers/memory/tegra/tegra234.c |  59 +++++++++++++++++++++++
 include/soc/tegra/mc.h          |   4 ++
 6 files changed, 275 insertions(+), 16 deletions(-)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index 3cda1d9..bb861a8 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -508,14 +508,32 @@ int tegra30_mc_probe(struct tegra_mc *mc)
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
 	unsigned int bit;
+	int channel;
+
+	if (mc->soc->num_channels && mc->soc->get_int_channel) {
+		int err;
+
+		err = mc->soc->get_int_channel(mc, &channel);
+		if (err < 0)
+			return IRQ_NONE;
+
+		/* mask all interrupts to avoid flooding */
+		status = mc_ch_readl(mc, channel, MC_INTSTATUS) & mc->soc->intmask;
+	} else {
+		status = mc_readl(mc, MC_INTSTATUS) & mc->soc->intmask;
+	}
 
-	/* mask all interrupts to avoid flooding */
-	status = mc_readl(mc, MC_INTSTATUS) & mc->soc->intmask;
 	if (!status)
 		return IRQ_NONE;
 
@@ -523,18 +541,66 @@ static irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
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
+			if (addr_hi_reg)
+				addr = mc_ch_readl(mc, channel, addr_hi_reg);
+			else
+				addr = ((value >> MC_ERR_STATUS_ADR_HI_SHIFT) &
+					MC_ERR_STATUS_ADR_HI_MASK);
 			addr <<= 32;
 		}
 #endif
@@ -591,7 +657,10 @@ static irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
 			break;
 		}
 
-		value = mc_readl(mc, MC_ERR_ADR);
+		if (mc->soc->num_channels)
+			value = mc_ch_readl(mc, channel, addr_reg);
+		else
+			value = mc_readl(mc, addr_reg);
 		addr |= value;
 
 		dev_err_ratelimited(mc->dev, "%s: %s%s @%pa: %s (%s%s)\n",
@@ -600,17 +669,14 @@ static irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
 	}
 
 	/* clear interrupts */
-	mc_writel(mc, status, MC_INTSTATUS);
+	if (mc->soc->num_channels)
+		mc_ch_writel(mc, channel, status, MC_INTSTATUS);
+	else
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
@@ -622,6 +688,8 @@ const char *const tegra_mc_status_names[32] = {
 	[12] = "VPR violation",
 	[13] = "Secure carveout violation",
 	[16] = "MTS carveout violation",
+	[17] = "Generalized carveout violation",
+	[20] = "Route Sanity error",
 };
 
 const char *const tegra_mc_error_names[8] = {
@@ -770,7 +838,11 @@ static int tegra_mc_probe(struct platform_device *pdev)
 
 		WARN(!mc->soc->client_id_mask, "missing client ID mask for this SoC\n");
 
-		mc_writel(mc, mc->soc->intmask, MC_INTMASK);
+		if (mc->soc->num_channels)
+			mc_ch_writel(mc, MC_BROADCAST_CHANNEL, mc->soc->intmask,
+				  MC_INTMASK);
+		else
+			mc_writel(mc, mc->soc->intmask, MC_INTMASK);
 
 		err = devm_request_irq(&pdev->dev, mc->irq, mc->soc->ops->handle_irq, 0,
 				       dev_name(&pdev->dev), mc);
diff --git a/drivers/memory/tegra/mc.h b/drivers/memory/tegra/mc.h
index 062886e..3836c35 100644
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
+		return readl_relaxed(mc->mcb_regs + offset);
+
+	return readl_relaxed(mc->mc_regs[ch] + offset);
+}
+
+static inline void mc_ch_writel(const struct tegra_mc *mc, int ch,
+				u32 value, unsigned long offset)
+{
+	if (ch == MC_BROADCAST_CHANNEL)
+		writel_relaxed(value, mc->mcb_regs + offset);
+	else
+		writel_relaxed(value, mc->mc_regs[ch] + offset);
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
index 59a4425..bce0237 100644
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
@@ -164,6 +166,7 @@ const struct tegra_mc_ops tegra186_mc_ops = {
 	.resume = tegra186_mc_resume,
 	.probe_device = tegra186_mc_probe_device,
 	.map_regs = tegra186_mc_map_regs,
+	.handle_irq = tegra30_mc_handle_irq,
 };
 
 #if defined(CONFIG_ARCH_TEGRA_186_SOC)
@@ -891,11 +894,53 @@ static const struct tegra_mc_client tegra186_mc_clients[] = {
 	},
 };
 
+static int tegra186_mc_get_channel(struct tegra_mc *mc, int *mc_channel)
+{
+	u32 g_intstatus;
+
+	g_intstatus = mc_ch_readl(mc, MC_BROADCAST_CHANNEL,
+				  MC_GLOBAL_INTSTATUS);
+
+	switch (g_intstatus & mc->soc->int_channel_mask) {
+	case BIT(0):
+		*mc_channel = 0;
+		break;
+
+	case BIT(1):
+		*mc_channel = 1;
+		break;
+
+	case BIT(2):
+		*mc_channel = 2;
+		break;
+
+	case BIT(3):
+		*mc_channel = 3;
+		break;
+
+	case BIT(24):
+		*mc_channel = MC_BROADCAST_CHANNEL;
+		break;
+
+	default:
+		pr_err("Unknown interrupt source\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 const struct tegra_mc_soc tegra186_mc_soc = {
 	.num_clients = ARRAY_SIZE(tegra186_mc_clients),
 	.clients = tegra186_mc_clients,
 	.num_address_bits = 40,
 	.num_channels = 4,
+	.client_id_mask = 0xff,
+	.intmask = MC_INT_DECERR_GENERALIZED_CARVEOUT | MC_INT_DECERR_MTS |
+		   MC_INT_SECERR_SEC | MC_INT_DECERR_VPR |
+		   MC_INT_SECURITY_VIOLATION | MC_INT_DECERR_EMEM,
 	.ops = &tegra186_mc_ops,
+	.int_channel_mask = 0x100000f,
+	.get_int_channel = tegra186_mc_get_channel,
 };
 #endif
diff --git a/drivers/memory/tegra/tegra194.c b/drivers/memory/tegra/tegra194.c
index 9400117..bc16567 100644
--- a/drivers/memory/tegra/tegra194.c
+++ b/drivers/memory/tegra/tegra194.c
@@ -1343,10 +1343,54 @@ static const struct tegra_mc_client tegra194_mc_clients[] = {
 	},
 };
 
+static int tegra194_mc_get_channel(struct tegra_mc *mc, int *mc_channel)
+{
+	u32 g_intstatus;
+
+	g_intstatus = mc_ch_readl(mc, MC_BROADCAST_CHANNEL,
+				  MC_GLOBAL_INTSTATUS);
+
+	switch (g_intstatus & mc->soc->int_channel_mask) {
+	case BIT(8):
+		*mc_channel = 0;
+		break;
+
+	case BIT(9):
+		*mc_channel = 1;
+		break;
+
+	case BIT(10):
+		*mc_channel = 2;
+		break;
+
+	case BIT(11):
+		*mc_channel = 3;
+		break;
+
+	case BIT(25):
+		*mc_channel = MC_BROADCAST_CHANNEL;
+		break;
+
+	default:
+		pr_err("Unknown interrupt source\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 const struct tegra_mc_soc tegra194_mc_soc = {
 	.num_clients = ARRAY_SIZE(tegra194_mc_clients),
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
+	.int_channel_mask = 0x2000f00,
+	.get_int_channel = tegra194_mc_get_channel,
 };
diff --git a/drivers/memory/tegra/tegra234.c b/drivers/memory/tegra/tegra234.c
index 6335a13..8e09fc4 100644
--- a/drivers/memory/tegra/tegra234.c
+++ b/drivers/memory/tegra/tegra234.c
@@ -93,10 +93,69 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
 	},
 };
 
+static int tegra234_mc_get_channel(struct tegra_mc *mc, int *mc_channel)
+{
+	u32 g_intstatus;
+
+	g_intstatus = mc_ch_readl(mc, MC_BROADCAST_CHANNEL,
+				  MC_GLOBAL_INTSTATUS);
+
+	switch (g_intstatus & mc->soc->int_channel_mask) {
+	case BIT(8):
+		*mc_channel = 0;
+		break;
+
+	case BIT(9):
+		*mc_channel = 1;
+		break;
+
+	case BIT(10):
+		*mc_channel = 2;
+		break;
+
+	case BIT(11):
+		*mc_channel = 3;
+		break;
+
+	case BIT(12):
+		*mc_channel = 4;
+		break;
+
+	case BIT(13):
+		*mc_channel = 5;
+		break;
+
+	case BIT(14):
+		*mc_channel = 6;
+		break;
+
+	case BIT(15):
+		*mc_channel = 7;
+		break;
+
+	case BIT(25):
+		*mc_channel = MC_BROADCAST_CHANNEL;
+		break;
+
+	default:
+		pr_err("Unknown interrupt source\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 const struct tegra_mc_soc tegra234_mc_soc = {
 	.num_clients = ARRAY_SIZE(tegra234_mc_clients),
 	.clients = tegra234_mc_clients,
 	.num_address_bits = 40,
 	.num_channels = 16,
+	.intmask = MC_INT_DECERR_ROUTE_SANITY |
+		   MC_INT_DECERR_GENERALIZED_CARVEOUT | MC_INT_DECERR_MTS |
+		   MC_INT_SECERR_SEC | MC_INT_DECERR_VPR |
+		   MC_INT_SECURITY_VIOLATION | MC_INT_DECERR_EMEM,
+	.has_addr_hi_reg = true,
 	.ops = &tegra186_mc_ops,
+	.int_channel_mask = 0x200ff00,
+	.get_int_channel = tegra234_mc_get_channel,
 };
diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
index 92f810c..1fe6a62 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -203,6 +203,8 @@ struct tegra_mc_soc {
 	const struct tegra_smmu_soc *smmu;
 
 	u32 intmask;
+	u32 int_channel_mask;
+	bool has_addr_hi_reg;
 
 	const struct tegra_mc_reset_ops *reset_ops;
 	const struct tegra_mc_reset *resets;
@@ -210,6 +212,8 @@ struct tegra_mc_soc {
 
 	const struct tegra_mc_icc_ops *icc_ops;
 	const struct tegra_mc_ops *ops;
+
+	int (*get_int_channel)(struct tegra_mc *mc, int *mc_channel);
 };
 
 struct tegra_mc {
-- 
2.7.4

