Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A00648B60A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 19:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346367AbiAKSqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 13:46:22 -0500
Received: from mail-bn7nam10on2089.outbound.protection.outlook.com ([40.107.92.89]:45216
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1349997AbiAKSqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 13:46:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKtjcDvdOzgkhT3bvtkh0FVSutKX/8PlMvZPt3NO6Pp2UbBcRxoJTys7J3nMUdwL9yRqfhgIkIbdVv5NRBQangDFEBv/7tRlcpmIiJaIVYuOd7Kc2qQ9LWOkhyjSSTz3R9JhvixhYxD/NsFtK8iHR8+g9bPTyS2fQyosBzCaxsM4RaUk1/dHKJ/fdw93RmEq9Crw4vL7zcrEoJeLPyRTInf9RXtr5PTUmQnIHqfbhJM907dwk5lGgePJuKrNgHd/0XfmOAqudMYwYT/DkEOpX2X/Hxs8egXilx/8az1Z97P1gorNz65MMpZT4yfTc/1vGzP58+WVwgwrYW0U1rvpqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZzIAog4hER4wmq/II7cBW9bXtZoT79oP9IDSmmXYSU=;
 b=W+z+qgJUxhr12Q1YD6aLWbVzTZqoiB0wmToEzbXLDQQ/YHEYcNdjTl6w3en0E+wGqRLJZl5Ft820bSIKUSsbYWGLOnLgQAQ3NF/XGXko3yGZ4nmMJ6+L3Lhp7xdrf387lbSzMZkeqDr9HNSE/9LgEPvusJIGLn21OXw6yJ/uBTpgYLeqPtXLUoE2r8EnL+9SGwH6ve3CjpBzos6QMGEhWdGW4TRJtWHsV8vNXELWUEU1CiHhs3iGdl4iipgVz7ILxHrVmNw7QuwTyXjXw8pEHo0MgrWfWPwtKXK1MX2fLDAOCUqb3lHc5wK0mUt0Fe+lxLhNZMhI9pZHR4lbxvi/YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZzIAog4hER4wmq/II7cBW9bXtZoT79oP9IDSmmXYSU=;
 b=oyGTeqAi66t0KlqlmhebVg9q1Wg24nGlTotcj4cnj+8pBh3siRMQn34+b/j28wuSLprcwEVoFXEUNCSdJfmJEJYeLInUm6Ek1OByiCIOt2dtyDX1m6/Dto6xQaSt7ict9zxdoAFc4TpWmhRzQf+JsKm/y2OGHqXLwX3pSSv6N9wMg1M9HP+ngIootqR6UNuy6qf5Mhuqn0kwD1KrCalXEEdgeXCD71fDj1+HMOw0HPrCNf0rBJA2UFeqsKurbmfNuhFPMpVq+7+KO6d7EOB4EBR8bcMnO+N8o9hsN/BF454VGJ7FWW3hoFhD1/HkYPPfUdIJ2fK4XTEN9msOzoQPxA==
Received: from DM5PR19CA0053.namprd19.prod.outlook.com (2603:10b6:3:116::15)
 by DM5PR1201MB0187.namprd12.prod.outlook.com (2603:10b6:4:5b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 18:46:12 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:116:cafe::c0) by DM5PR19CA0053.outlook.office365.com
 (2603:10b6:3:116::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Tue, 11 Jan 2022 18:46:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4867.9 via Frontend Transport; Tue, 11 Jan 2022 18:46:11 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 11 Jan
 2022 18:46:11 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 11 Jan
 2022 10:46:11 -0800
Received: from amhetre.nvidia.com (10.127.8.9) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Tue, 11 Jan 2022 18:46:09 +0000
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <amhetre@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <krzysztof.kozlowski@canonical.com>, <linux-kernel@vger.kernel.org>
CC:     <Snikam@nvidia.com>, <vdumpa@nvidia.com>
Subject: [Patch V1 4/4] memory: tegra: add mc-err support for T194
Date:   Wed, 12 Jan 2022 00:15:50 +0530
Message-ID: <1641926750-27544-5-git-send-email-amhetre@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1641926750-27544-1-git-send-email-amhetre@nvidia.com>
References: <1641926750-27544-1-git-send-email-amhetre@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68804713-fa48-42ff-c8c2-08d9d532a3b4
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0187:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0187136441A514C810022DA1CA519@DM5PR1201MB0187.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:168;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RynJXY3uWiIOsAWZy+Evsz0FMvpwfjfimq8zng7LdPxVaas4P3ZLlbpD+VDA2DMV+OuGaT6r/czNuFwPDXoHeJ/SGRjsIe0kG6uyXLraHSrftCZIF3Ziu1y5/vOjnAVRo2XtmnqwWWAyxYlqgbPiLw5wOlEXffEg0CIDsqgWYSoSFybKtmoND0w6ol8nqzmv1jp58hglKmzvuduTy0XfUwkbKYHthhEhbX4L88jt/d+N0BlezMPLQHhlss2Kf3zcRbN62NUnABVsmIg5q5x7zDMNAThTH6SRXvieLsSytXmgHjPsb96T1/0DTdxCQFwHKsj3reSBPiLPdqQt+qWXrlCfLPBABcftNf8nPzoaMSPcwrFlQyN2n4GfsSl6NJBATTBIFlcZm8mNOWR452bSU4NfWyEOUKVcIPmarFofPuWnoUJzgD3XFWcI8GP28Tisrr9MIWKcBpIZ3YDvHbYo1W1qqEK4nrzVTW4AAa2tVkHk24m58PxELcu9j2++GovD3k8ZjLOVZsDbH1HSeULZp4g7U49LWhegX7ikegMMEwOykPOF7bSXK/3TTUy0C5JoTbzNSfc56V2g2ituHkPOqlJIXKTvUVS+1lhd6YfASAEVR5+ZcB5uFu4nTUbyi0looSPbfMUrzIRT2hNP6R6YMcuaW0GEbhGBjjBML9JRAEjtI/L96fUFcJOYet2g3lVVsaw2d0AkgmDAiu26nvo4HwW8wo6c6EFK69TFNyQyJQPyfFeQFcgNYEttuYw4vTNI+Ypka61wXM370REyNzgXiwY/cVug66mtjcmA+STA6Dg=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(40470700002)(46966006)(36840700001)(426003)(5660300002)(26005)(86362001)(36756003)(82310400004)(7696005)(36860700001)(70586007)(316002)(110136005)(4326008)(107886003)(508600001)(40460700001)(356005)(6666004)(70206006)(81166007)(186003)(8936002)(8676002)(54906003)(2616005)(47076005)(2906002)(83380400001)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 18:46:11.9844
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68804713-fa48-42ff-c8c2-08d9d532a3b4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0187
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add all basic mc-errors supported by T194.
Implement mc interrupt handling routine for T194.

Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 drivers/memory/tegra/mc.h       |   2 +
 drivers/memory/tegra/tegra194.c | 108 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+)

diff --git a/drivers/memory/tegra/mc.h b/drivers/memory/tegra/mc.h
index 7817492..1d881e7 100644
--- a/drivers/memory/tegra/mc.h
+++ b/drivers/memory/tegra/mc.h
@@ -43,6 +43,7 @@
 #define MC_EMEM_ARB_OVERRIDE				0xe8
 #define MC_TIMING_CONTROL_DBG				0xf8
 #define MC_TIMING_CONTROL				0xfc
+#define MC_ERR_ADR_HI					0x11fc
 
 #define MC_ERR_VPR_STATUS				0x654
 #define MC_ERR_VPR_ADR					0x658
@@ -50,6 +51,7 @@
 #define MC_ERR_SEC_ADR					0x680
 #define MC_ERR_MTS_STATUS				0x9b0
 #define MC_ERR_MTS_ADR					0x9b4
+#define MC_ERR_GENERALIZED_CARVEOUT_STATUS_1		0xbfc
 #define MC_ERR_GENERALIZED_CARVEOUT_STATUS		0xc00
 #define MC_ERR_GENERALIZED_CARVEOUT_ADR			0xc04
 
diff --git a/drivers/memory/tegra/tegra194.c b/drivers/memory/tegra/tegra194.c
index 76ba3da..a0af6a0 100644
--- a/drivers/memory/tegra/tegra194.c
+++ b/drivers/memory/tegra/tegra194.c
@@ -4,6 +4,7 @@
  */
 
 #include <soc/tegra/mc.h>
+#include <linux/platform_device.h>
 
 #include <dt-bindings/memory/tegra194-mc.h>
 
@@ -16,8 +17,114 @@ static void tegra194_mc_clear_interrupt(struct tegra_mc *mc)
 	mc_writel(mc, MC_INTSTATUS_CLEAR, MC_INTSTATUS);
 }
 
+static const struct tegra_mc_error int_mc_errors[] = {
+	{
+		.int_bit = MC_INT_DECERR_EMEM,
+		.msg = "EMEM address decode error",
+		.status_reg = MC_ERR_STATUS,
+		.addr_reg = MC_ERR_ADR,
+		.addr_reg_hi = MC_ERR_ADR_HI,
+	},
+	{
+		.int_bit = MC_INT_SECURITY_VIOLATION,
+		.msg = "non secure access to secure region",
+		.status_reg = MC_ERR_STATUS,
+		.addr_reg = MC_ERR_ADR,
+		.addr_reg_hi = MC_ERR_ADR_HI,
+	},
+	{
+		.int_bit = MC_INT_DECERR_VPR,
+		.msg = "MC request violates VPR requirements",
+		.status_reg = MC_ERR_VPR_STATUS,
+		.addr_reg = MC_ERR_VPR_ADR,
+	},
+	{
+		.int_bit = MC_INT_SECERR_SEC,
+		.msg = "MC request violated SEC carveout requirements",
+		.status_reg = MC_ERR_SEC_STATUS,
+		.addr_reg = MC_ERR_SEC_ADR,
+	},
+	{
+		.int_bit = MC_INT_DECERR_MTS,
+		.msg = "MTS carveout access violation",
+		.status_reg = MC_ERR_MTS_STATUS,
+		.addr_reg = MC_ERR_MTS_ADR,
+	},
+	{
+		.int_bit = MC_INT_DECERR_GENERALIZED_CARVEOUT,
+		.msg = "GSC access violation",
+		.status_reg = MC_ERR_GENERALIZED_CARVEOUT_STATUS,
+		.addr_reg = MC_ERR_GENERALIZED_CARVEOUT_ADR,
+		.addr_reg_hi = MC_ERR_GENERALIZED_CARVEOUT_STATUS_1,
+	},
+};
+
+static irqreturn_t tegra194_mc_handle_irq(int irq, void *data)
+{
+	struct tegra_mc *mc = data;
+	unsigned long status;
+	unsigned int bit;
+
+	status = mc_readl(mc, MC_INTSTATUS) & mc->soc->intmask;
+	if (!status)
+		return IRQ_NONE;
+
+	for_each_set_bit(bit, &status, 32) {
+		const char *error = int_mc_errors[bit].msg ?: "unknown";
+		const char *client = "unknown";
+		const char *direction, *secure;
+		phys_addr_t addr = 0;
+		unsigned int i;
+		u8 id;
+		u32 value;
+
+		value = mc_readl(mc, int_mc_errors[bit].status_reg);
+
+#ifdef CONFIG_PHYS_ADDR_T_64BIT
+		if (mc->soc->num_address_bits > 32) {
+			if (int_mc_errors[bit].addr_reg_hi)
+				addr = mc_readl(mc,
+						int_mc_errors[bit].addr_reg_hi);
+			else
+				addr = ((value >> MC_ERR_STATUS_ADR_HI_SHIFT) &
+					MC_ERR_STATUS_ADR_HI_MASK);
+			addr <<= 32;
+		}
+#endif
+		addr |= mc_readl(mc, int_mc_errors[bit].addr_reg);
+
+		if (value & MC_ERR_STATUS_RW)
+			direction = "write";
+		else
+			direction = "read";
+
+		if (value & MC_ERR_STATUS_SECURITY)
+			secure = "secure ";
+		else
+			secure = "";
+
+		id = value & mc->soc->client_id_mask;
+
+		for (i = 0; i < mc->soc->num_clients; i++) {
+			if (mc->soc->clients[i].id == id) {
+				client = mc->soc->clients[i].name;
+				break;
+			}
+		}
+
+		dev_err_ratelimited(mc->dev, "%s: %s%s @%pa: %s\n",
+				    client, secure, direction, &addr, error);
+	}
+
+	/* clear interrupts */
+	mc_writel(mc, status, MC_INTSTATUS);
+
+	return IRQ_HANDLED;
+}
+
 const struct tegra_mc_interrupt_ops tegra194_mc_interrupt_ops = {
 	.clear_interrupt = tegra194_mc_clear_interrupt,
+	.handle_irq = tegra194_mc_handle_irq,
 };
 
 static const struct tegra_mc_client tegra194_mc_clients[] = {
@@ -1358,6 +1465,7 @@ const struct tegra_mc_soc tegra194_mc_soc = {
 	.num_clients = ARRAY_SIZE(tegra194_mc_clients),
 	.clients = tegra194_mc_clients,
 	.num_address_bits = 40,
+	.client_id_mask = 0xff,
 	.intmask = MC_INT_DECERR_ROUTE_SANITY | MC_INT_WCAM_ERR |
 		   MC_INT_DECERR_GENERALIZED_CARVEOUT | MC_INT_DECERR_MTS |
 		   MC_INT_SECERR_SEC | MC_INT_DECERR_VPR |
-- 
2.7.4

