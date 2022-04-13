Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18DE4FF3DF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbiDMJoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234654AbiDMJnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:43:43 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2073.outbound.protection.outlook.com [40.107.100.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F2C3A1B3;
        Wed, 13 Apr 2022 02:41:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMDFfpoHbHdamAg+toenaxCR1odqArY/8NNKS9zEoA4gqAE27XgYmOSHFTWmR05YIXygxBW9EZgdIXMqY9btH9dqJ3/DV6xXrfPqfpoQ6sOnAYzJCPqPEL+Hx4v9waL/LrZKZqov/xKuekQN6QLcVp+xUo+07rAOVA0QCbGeBA4ta7vMPtEKo21DKfpG/2STje5Jlt4Mb+VtBUT8Qhz10wzH0fDbn6JLZngTzis9NI5W8SfHEK0nUwcmALjeWpBJPhK97ARucWfzc6ADiW+gdho8waqUpSmWBAjkYOidJoWJeJ/+k3Wb7TPjMyBbm5V+ubXewIdH7YPpS//qFYAnBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q3MCxDtOi7CQBQynQhNd+3dctmPM4UtBNk890NnsMZg=;
 b=X3dbY0kSbItwPTWeucSTEzuZzoOxpoIz7tKYZUyXunBsZc5oezQAkvvaTLCQp36QrDLjeQsbuUEUDcfCioPUGIS/wB6/Lo4wUvZ83BPdiXR7xBlgD9YdB8epqPtAi5ubhTSFMyQ/qSeIu5dwbTV0jDejmuDcXFD/YpF5aQnmDL8XheyTzbxKi6ODRPOXxyb6UpdTu/onobQp+OZXypWAlgGPQ2h3uOiZHN9pmSWVkPQJgW5v8M4kl0HRnVyIFMiGwVuorb8b06Zx/Gnzx3+/eA93SkZq6l+Nn9oUHrHdJjjzbz1H3olJSSskBVC/jDNVB+fCdGfes6r2uMxH9f2xzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3MCxDtOi7CQBQynQhNd+3dctmPM4UtBNk890NnsMZg=;
 b=QpgInwBEXkDw3kxdfKxkn401TVURjB4BucPcpeMPlO5wLSwpDTIu6HqHTGRuWmVnkEwnlt1tiaenDF/qt0aErjJQ2EOY6+prRTY9jPYs31979v0fwu+Zc9qCNPxYxpVzy33mAHcF8tKVjH1e5KDY5qsQi5Ad41KYeCsIEV3h+KjSF3/psJXTvaA0M8sPSrIGoC3mB0Bcpmc49MIOP0EqjL/bZ4MYms/ozRmr2quebOiM6ySiu+VHeWKBOk7H6lCkCVI+IGOsJ6N1PbBmOL8BIyQZdWziiMA+44c0Ixfr+VeVeVfKoWpmOB8Avf887kq6Qm5LKzRchjdfZCipY7DYoQ==
Received: from BN9PR03CA0958.namprd03.prod.outlook.com (2603:10b6:408:108::33)
 by DM6PR12MB3369.namprd12.prod.outlook.com (2603:10b6:5:117::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 09:41:16 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::b0) by BN9PR03CA0958.outlook.office365.com
 (2603:10b6:408:108::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18 via Frontend
 Transport; Wed, 13 Apr 2022 09:41:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5164.19 via Frontend Transport; Wed, 13 Apr 2022 09:41:16 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 13 Apr
 2022 09:40:41 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 13 Apr
 2022 02:40:40 -0700
Received: from amhetre.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Wed, 13 Apr 2022 02:40:37 -0700
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <dmitry.osipenko@collabora.com>, <digetx@gmail.com>,
        <krzysztof.kozlowski@linaro.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <vdumpa@nvidia.com>, <Snikam@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>
Subject: [Patch v7 2/4] memory: tegra: Add MC error logging on tegra186 onward
Date:   Wed, 13 Apr 2022 15:10:10 +0530
Message-ID: <20220413094012.13589-3-amhetre@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220413094012.13589-1-amhetre@nvidia.com>
References: <20220413094012.13589-1-amhetre@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08963cac-8e85-4abc-ed73-08da1d31c167
X-MS-TrafficTypeDiagnostic: DM6PR12MB3369:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3369F4B94F844C62C60E7C83CAEC9@DM6PR12MB3369.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4VXOn9sYxbfsamci612GM/VqNLrCw0rrLFhgjlmZpI5bYFqM+eDiOjkMArPBO+89NC8CQ/OahuIJxaPLG7iD4XR0LwSlJREwVDFQxaqmx6tBCyaq2wTecJPuCumAkBMQLTQCCmRqrZn31z4YDPcLd0oEiqWMJuWi5w1DYz4e0VsPXLTVtNLnw3IVC2p0OOOxkdEYLuuBh0A4QOKDbDHlpUfsnkj+Z7EfAJC0u6OCxn6y4M7rGr5gPnQnXUtizyZuBpfw28lNDfTgF8kr558GfWa6qSaMivaEeO+eUrtjEF381qsxBeXZcdilQdoPiEjeg06+FxuSdy9APxYUy7CEc0p83XoAMeXZK0x4rvmcfCtuF5qsKkrn0U9fLT9i+Q4BIaZucL7aEA7FRlBtRX8DKz+vgDJ03nfqOEsd+1leTiDYPFZarL1kg8e/T6nW/XzfSxzDtDWzN84Phw48JlddFkyj6/6z8ku7yAYCFlp41DVhPNhjD+AUkS7OuxFrSze/QlwlwyJORsQzYwZf5l8fq4FU2YM0CJZesYbQJA0cksqV+w4wgt0bH+YVWIzJ5oGbUv1lYI849uE8wFjYXHXFaBfEUSbcL8fNAzMNAwCsKOYIcmnOu/sv8RDVnKXCAwn62YJZmeFyCeAKnu+KQdzFXK62qChlLPa06zl2Kn3yISUNUjwRHpVTUXmgFMuQQ6MN4KAKJfUroYk3DemnUTwuVauhLhuNcS00ohPUPbTYe64aG+OD4eFhrHtrK+lI+qdgA99Xptjy1xOVyrKNrAGGnw==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(4326008)(7696005)(30864003)(2906002)(40460700003)(8676002)(107886003)(1076003)(70206006)(70586007)(5660300002)(86362001)(186003)(2616005)(26005)(36860700001)(82310400005)(508600001)(81166007)(921005)(356005)(316002)(8936002)(6666004)(336012)(426003)(36756003)(83380400001)(47076005)(110136005)(54906003)(83996005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 09:41:16.0044
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08963cac-8e85-4abc-ed73-08da1d31c167
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3369
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for reading MC_GLOBAL_INTSTATUS register which points to the
memory controller channels on which interrupts have occurred.
Add helper function 'global_intstatus_to_channel' which returns the
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

Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 drivers/memory/tegra/mc.c       | 134 ++++++++++++++++++++++++++++----
 drivers/memory/tegra/mc.h       |  37 ++++++++-
 drivers/memory/tegra/tegra186.c |   9 +++
 drivers/memory/tegra/tegra194.c |   8 ++
 drivers/memory/tegra/tegra234.c |   7 ++
 include/soc/tegra/mc.h          |   3 +
 6 files changed, 181 insertions(+), 17 deletions(-)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index c1dd24542093..209b7fc503c6 100644
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
+static int global_intstatus_to_channel(const struct tegra_mc *mc, u32 status,
+				       unsigned int *mc_channel)
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
+		if (mc->soc->num_channels && !IS_ERR(mc->bcast_ch_regs))
+			mc_ch_writel(mc, MC_BROADCAST_CHANNEL, mc->soc->intmask,
+				     MC_INTMASK);
+		else
+			mc_writel(mc, mc->soc->intmask, MC_INTMASK);
 
 		err = devm_request_irq(&pdev->dev, mc->irq, mc->soc->ops->handle_irq, 0,
 				       dev_name(&pdev->dev), mc);
diff --git a/drivers/memory/tegra/mc.h b/drivers/memory/tegra/mc.h
index 062886e94c04..79a4e63775a2 100644
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
+			      unsigned long offset)
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
index 9b151b98362b..50212045b5dd 100644
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
@@ -176,6 +178,7 @@ const struct tegra_mc_ops tegra186_mc_ops = {
 	.resume = tegra186_mc_resume,
 	.probe_device = tegra186_mc_probe_device,
 	.map_regs = tegra186_mc_map_regs,
+	.handle_irq = tegra30_mc_handle_irq,
 };
 
 #if defined(CONFIG_ARCH_TEGRA_186_SOC)
@@ -908,6 +911,12 @@ const struct tegra_mc_soc tegra186_mc_soc = {
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
index 6335a132be2d..81bab66bdd25 100644
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
+	.global_intstatus_channel_shift = 8,
 };
diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
index 42b9c509773e..df507e72af9f 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -200,6 +200,9 @@ struct tegra_mc_soc {
 	const struct tegra_smmu_soc *smmu;
 
 	u32 intmask;
+	u32 ch_intmask;
+	u32 global_intstatus_channel_shift;
+	bool has_addr_hi_reg;
 
 	const struct tegra_mc_reset_ops *reset_ops;
 	const struct tegra_mc_reset *resets;
-- 
2.17.1

