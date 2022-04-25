Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1130450DA94
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 09:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241605AbiDYH4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 03:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241546AbiDYHz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 03:55:27 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2040.outbound.protection.outlook.com [40.107.101.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1265E41338;
        Mon, 25 Apr 2022 00:51:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZV9qewvwLFk+5yjZ6sRiUrIn5WjypVwH5xoe2S0w3o7CYIIsQLpppx8wiITsq/2AhWvH7B6YwlIhx//ZcbLEit4JBQ4LMqXJsP0Lg2PhIIqyapIAsWFcgkK/nxKDQD3IJjMcTJ75KeD2KzRpFaPn93rfzgvtS++EqJdOEuZ0UmUcHIawZKEJMgw1YHdYpJfd2Ln+4NEqQv3J/fQ3llUkHgKHXIWlxgBQFa9i1thBkEmlgDC0HoxVJFzD/6stXgfIOvnohwjkzju5MsWnDqYbNBk3xZxmkt1lY+t/9lIVtkjGxYA3Z8RPketJ+Sydf0YgDiUBQucenn40sMeJbMDuNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hAOi4yttNV/j8VSs2VoUfhrdC+XB/8L2x6xosFk4Ko0=;
 b=aG6rwxX9rVFyyyWYcVlTeoSKOmv53flOkHMVg1cpPE7WhL5LNN08I0S0oEQa8R/YYdYkLen5fxMInCdAqRLW58o0nD7iJw4ymYPDQXkvbPeD8r5Ray+OX7M+CGApiAUtok82SNBWXIDVd/2WX8OpBKIAteDS3g3yufOgKPWEatCZQEXOTRSejVmYmbXMuLUXDmBlhHQA2Pd80Kk9TnM2eP4zhu0laoZEDPTKxNaBguK5wI+3vsriMCw6t2JwbAPXiYYobLjLrIumSe0Fg93BPm1Np8xAEj/ivfyCWQhzWIgPkmerk2r9nlST5imwKHN471YZHz4FoP/xhdiBY7ryzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAOi4yttNV/j8VSs2VoUfhrdC+XB/8L2x6xosFk4Ko0=;
 b=qgpNbzLZwUOiz0oB2GreZaMdo/EuNheo8aC8y7wMLq1dY3kwETRCGWnfeCRNdVP2rQLP/MRZlvBtbATxZJnBcHjJuXoWb301qSkQ4el2DPKl05beyKw9GDg6aGPrf5rPzb/jGEtrhU+xPl0a/GkWTjyWsFCBo7V1+QM+wr4BRhZ19YKet/WtjWfmo1uMlJC5fiww9FJp0lT9ZnYfJRPmdu4PdVLRf0l7lrANnWCbeIfcYqnLdy5aDvvUHqCFcbhfRXsDpPdlrL6eDd+tydrMZrVdrZHJukR6Oq4Oowrtxv/hnAmHq1AGqMJFK8X4E5mI9PvA5EqeaxUJrhWaMDRkOg==
Received: from DM6PR03CA0085.namprd03.prod.outlook.com (2603:10b6:5:333::18)
 by CO6PR12MB5426.namprd12.prod.outlook.com (2603:10b6:5:35d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Mon, 25 Apr
 2022 07:51:08 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::fb) by DM6PR03CA0085.outlook.office365.com
 (2603:10b6:5:333::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Mon, 25 Apr 2022 07:51:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5186.14 via Frontend Transport; Mon, 25 Apr 2022 07:51:07 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 25 Apr
 2022 07:51:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 25 Apr
 2022 00:51:06 -0700
Received: from amhetre.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Mon, 25 Apr 2022 00:51:02 -0700
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <krzysztof.kozlowski@linaro.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <digetx@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <dmitry.osipenko@collabora.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <vdumpa@nvidia.com>, <Snikam@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>
Subject: [Patch v8 2/4] memory: tegra: Add MC error logging on tegra186 onward
Date:   Mon, 25 Apr 2022 13:20:34 +0530
Message-ID: <20220425075036.30098-3-amhetre@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220425075036.30098-1-amhetre@nvidia.com>
References: <20220425075036.30098-1-amhetre@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6c858a8-2d20-48c1-282c-08da26905ba7
X-MS-TrafficTypeDiagnostic: CO6PR12MB5426:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB5426E888B57AE720CF410D16CAF89@CO6PR12MB5426.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wlDgFZ23zLyXk+d17iCyuRrCbj8hJA0FW1+jqL9qR2JuyDmyHlJv8L3Y5r3sxHUSLHMdjZ8uuBjAHD+2rBkKv/zr36VtqFLrBRTmLYsNh55aVzE98KXwgvi7Of+DH9zyj8phfR8nuQeraG5P9w9rLt9kgkZQ6ZYoD9VXm2qkNUfFTFOpydiU5bRbkOpmhn3XXlk1//IMpFLxtBU4oaf8o//5hPqsNEu7CyVJm8CDdvkLSWyIo6+Rz4s5CTe9tDUdNJaIf5MNiB0ZrTiDB0jI+UNC+8CwKUG6xLNDEHTLQmhycBP39mF6p9KIVl0KROShM7mpHoeP1ESI+o6mbkhMDOQ1LocS8XXW/sBN5gjfdThIL5Kbp+NfUPuWNHAGW8vm0C+g34UVIjExaC+B63nvQFtubYAo4gYADqDgcjJDQCUY8N6puBNp6zmdhQwnJCocKGMsp20lNRZ/WUzPnMBljm7dHugGxQuPE2cP0Gae7RdeXcQvWmD4H7p7XNbjuYRIIcXBO9cartTuvrTHUXgDBhpBHnAFwFkmsLeYA2+G3OjGy1omThKCxQsSGL1teS3BAwLEkHl6Kmz602kdW3JuBjFSB//7HDuQnxA26HIQ7LmmMHyH8ggirfSce6DDgNqLfX7bW0DwNqUp7UOhBaGiyzalc05VZ9N1MWkvM12+34LEFPnYnX93OtNEcUfLh13dJ+DvY9VwvBrmx52O4voo8WDt+nlc1GHrUJ29kJaYa1s=
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(5660300002)(81166007)(70206006)(316002)(36756003)(54906003)(30864003)(921005)(356005)(8676002)(26005)(508600001)(2906002)(82310400005)(110136005)(4326008)(2616005)(7696005)(107886003)(36860700001)(1076003)(86362001)(70586007)(8936002)(6666004)(40460700003)(336012)(426003)(47076005)(186003)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 07:51:07.9611
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6c858a8-2d20-48c1-282c-08da26905ba7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5426
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for reading MC_GLOBAL_INTSTATUS register which points to the
memory controller channels on which interrupts have occurred.
Add helper function 'mc_global_intstatus_to_channel' which returns the
channel which should be used to get the information of interrupts.
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
Add helper function 'mc_channel_to_global_intstatus' which returns the
bit of MC_GLOBAL_INSTATUS corresponding to channel of which interrupts
are logged and use it to clear that interrupt channel.
Update variable type of client_id_mask from u8 to u16 and add it for
tegra186, tegra194 and tegra234.

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
index c1dd24542093..9d3b1935fdff 100644
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
@@ -770,7 +868,11 @@ static int tegra_mc_probe(struct platform_device *pdev)
 
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
index 6bc1d0336e37..d650427b6624 100644
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
@@ -177,6 +179,7 @@ const struct tegra_mc_ops tegra186_mc_ops = {
 	.resume = tegra186_mc_resume,
 	.probe_device = tegra186_mc_probe_device,
 	.map_regs = tegra186_mc_map_regs,
+	.handle_irq = tegra30_mc_handle_irq,
 };
 
 #if defined(CONFIG_ARCH_TEGRA_186_SOC)
@@ -909,6 +912,12 @@ const struct tegra_mc_soc tegra186_mc_soc = {
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
index 42b9c509773e..6579de5e2828 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -194,12 +194,15 @@ struct tegra_mc_soc {
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

