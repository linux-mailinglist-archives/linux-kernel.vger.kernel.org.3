Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5326E48B608
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 19:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346309AbiAKSqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 13:46:14 -0500
Received: from mail-dm6nam11on2083.outbound.protection.outlook.com ([40.107.223.83]:56928
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346268AbiAKSqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 13:46:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awfVeEciVjMQrlpHOYFQGrNrOVDW4DTLo19t5DlZnb8SoqjRZ2NXADUqQSnsHdIVkqixWRupl2dSHeo03y6kfSdvHuIJHSMvOg+766Ccg401Itb3bha7kLvvphKVMqKRca3I1MVuOp+FgD/+xGTPa8yBQ2NFDEU9Nb9+cOB1h/dVYySrewTQQQRqPmz+92SRNWoJFqVWCPX9ek+F0eNMd8ijbybfOypyLaF90VuOQGSQzjfvX5bkMexFklZnUxHcpTIImZQwAybrfb3lhAXi+9KZOUrJicEwTgdKrvyWdX7xSOkNwETXQc10n8s4JY03lQD5TmzuySBLzvKRdpmiSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXYZNUzTWVTPgL4YEYRncozB2YklqYyv/gNe11XxZic=;
 b=iz+3GiqkvQKcynvTSmDblvHwBMjai688xGf3kDt4AaQWRY+CQ51lAzO/oEXSupffSLwH2Sjr662p0PBOpCXbSpuvaCMM2S3tso++BSxkOehu+Bu24AdFs6wVqBZnC7JsH2OL0A75fv6trez2KRTvIBd/yifmhP7VNhuEDItHuyRvVzcRa7C7p85CkjhGQqRg8ecV4TC6cK2MBnYcRfBt5kyyH5VEiWapTW0h46AumJoxUwGDBvyhq2jGn6TfVKP1xiFY6EA+1TEG3cVwvkoSmqvEJBEvFYJ7Hc/cTI1f6CrBsnmdg3kBdDVMzOOidzn8oGYSRvlrrgKfs2S738f6Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXYZNUzTWVTPgL4YEYRncozB2YklqYyv/gNe11XxZic=;
 b=uRKhga3Zcpvmgn50JyjgICDn+Soh/kXUQskTKdUQWJmQtujHJX1g92Ri/MAR1w6gboz3/Y393FSY8fAwyR61j3O2d+uAhBHdupu9TCwTGM2HfJDQNRAiIYj3msA8k6usgil6nO+/ZyE/y32JivaC1H2y1fxBwkm5e8F4BbxkPE5URWHmhJIidBPSEY90Wb+GYkzWJ9xY4bUvcCZ1inT1Zrj22tsC0sFr8GXyiI7W7IYiIlsp6vnKWbS1i3/5Ba9LiB2VV6UW/1fBzUPc0CroipM2EzgWGoEDlMMKrRjQm/yTfYtz/K1oR8mfmXa5YT+TRMr30iBQmrWd2Bn6D5u26A==
Received: from DM6PR11CA0049.namprd11.prod.outlook.com (2603:10b6:5:14c::26)
 by MN2PR12MB4048.namprd12.prod.outlook.com (2603:10b6:208:1d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 18:46:08 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::f4) by DM6PR11CA0049.outlook.office365.com
 (2603:10b6:5:14c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9 via Frontend
 Transport; Tue, 11 Jan 2022 18:46:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4867.9 via Frontend Transport; Tue, 11 Jan 2022 18:46:08 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 11 Jan
 2022 18:46:07 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 11 Jan
 2022 10:46:07 -0800
Received: from amhetre.nvidia.com (10.127.8.9) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Tue, 11 Jan 2022 18:46:05 +0000
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <amhetre@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <krzysztof.kozlowski@canonical.com>, <linux-kernel@vger.kernel.org>
CC:     <Snikam@nvidia.com>, <vdumpa@nvidia.com>
Subject: [Patch V1 3/4] memory: tegra: add mc-err support for T186
Date:   Wed, 12 Jan 2022 00:15:49 +0530
Message-ID: <1641926750-27544-4-git-send-email-amhetre@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1641926750-27544-1-git-send-email-amhetre@nvidia.com>
References: <1641926750-27544-1-git-send-email-amhetre@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f0c1262-28a1-4cda-3c0e-08d9d532a195
X-MS-TrafficTypeDiagnostic: MN2PR12MB4048:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB40489B768C6C7AAB4CC6C564CA519@MN2PR12MB4048.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:245;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +eNKrul/PgH8HmAk0rJxI4F0M7YarS6Xx5/EI+ZW+SJzQyyOBRGuCVIzNUmDc/F3MjfZeEc2UHoFyEFXQsLKBD+ZM+Bnin4pCZBgXbSvbL298hyZyZ8zmS+fXSlDZchJ8Ymr3Z4OwH9yfu4mp0SwzFarJ2aC7EEPjUX/g85irIjbV/FWMaJMf4+xAZ6UkdugvCt1jIUuRmRseRkIbMsp0PP1tqsk65gYaDdvXsUGjZL6kxIk1SsJO64R+ZEDQzhTlnqUsStd1/qWI4/DaH5AOsbcet3GH2sAghRDd0VgPjXE5oiDWs85m1iAZ1bZQ6PzrxkZuErGXHnbKAASn+QDtVmD20Mj7STxC20BCdD/9TXc0GOngkEkPgr8QT1Qj9+YChFBaVjmamOWCulyH3EFAqtoEvtcjM1dwJgFNOpbVC9Ql/KghdTzPm9GD1KGzN3j1c86oaiPLfxb2Pq62pLRg4FJ38e1n36N4HtX9NghoObhHij9RANHbgjx8FKMsLbHiK2jXuWD3lzTRTLiXmzVPG5l1kEl5E/0L1IT1WDIQgccsHkVA/g4Th+1N1D2ZawNna/AAKs++a436BFxTOMWBIK/OpZlFHYGuJOOWUF96rMhufj4WZ04M7BqIRZ4HUBqa15b+cFid1blydh2UFSr5oBmNKhEcZyUbay0JX0VywI7vUVK+8+Ctw1ea443zuR9uO86lqkhvS7eHQYxSb0vYURdG56TDeMa06PwVa5MZJudMWP2rLIx38Qh910svNmrqdOE1Dnd66Q+MNVLZ0YwJkGvgGAWQWZNoXwi3Tvsgtw=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700002)(356005)(70206006)(4326008)(8936002)(81166007)(26005)(2906002)(54906003)(36756003)(86362001)(36860700001)(70586007)(47076005)(7696005)(107886003)(40460700001)(508600001)(83380400001)(316002)(6666004)(82310400004)(2616005)(110136005)(426003)(186003)(336012)(5660300002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 18:46:08.2504
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f0c1262-28a1-4cda-3c0e-08d9d532a195
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4048
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add all mc-errors supported by T186.
Implement mc interrupt handling routine for T186.

Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 drivers/memory/tegra/mc.h       |  17 +++++++
 drivers/memory/tegra/tegra186.c | 100 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 117 insertions(+)

diff --git a/drivers/memory/tegra/mc.h b/drivers/memory/tegra/mc.h
index 2d4f495..7817492 100644
--- a/drivers/memory/tegra/mc.h
+++ b/drivers/memory/tegra/mc.h
@@ -44,6 +44,15 @@
 #define MC_TIMING_CONTROL_DBG				0xf8
 #define MC_TIMING_CONTROL				0xfc
 
+#define MC_ERR_VPR_STATUS				0x654
+#define MC_ERR_VPR_ADR					0x658
+#define MC_ERR_SEC_STATUS				0x67c
+#define MC_ERR_SEC_ADR					0x680
+#define MC_ERR_MTS_STATUS				0x9b0
+#define MC_ERR_MTS_ADR					0x9b4
+#define MC_ERR_GENERALIZED_CARVEOUT_STATUS		0xc00
+#define MC_ERR_GENERALIZED_CARVEOUT_ADR			0xc04
+
 #define MC_INT_DECERR_ROUTE_SANITY			BIT(20)
 #define MC_INT_WCAM_ERR					BIT(19)
 #define MC_INT_SCRUB_ECC_WR_ACK				BIT(18)
@@ -159,6 +168,14 @@ extern const struct tegra_mc_ops tegra186_mc_ops;
 extern const char * const tegra_mc_status_names[32];
 extern const char * const tegra_mc_error_names[8];
 
+struct tegra_mc_error {
+	u32 int_bit;
+	const char *msg;
+	u32 status_reg;
+	u32 addr_reg;
+	u32 addr_reg_hi;
+};
+
 /*
  * These IDs are for internal use of Tegra ICC drivers. The ID numbers are
  * chosen such that they don't conflict with the device-tree ICC node IDs.
diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
index 6766cc4..4f3ae71 100644
--- a/drivers/memory/tegra/tegra186.c
+++ b/drivers/memory/tegra/tegra186.c
@@ -146,8 +146,107 @@ static void tegra186_mc_clear_interrupt(struct tegra_mc *mc)
 	mc_writel(mc, MC_INTSTATUS_CLEAR, MC_INTSTATUS);
 }
 
+static const struct tegra_mc_error int_mc_errors[] = {
+	{
+		.int_bit = MC_INT_DECERR_EMEM,
+		.msg = "EMEM address decode error",
+		.status_reg = MC_ERR_STATUS,
+		.addr_reg = MC_ERR_ADR,
+	},
+	{
+		.int_bit = MC_INT_SECURITY_VIOLATION,
+		.msg = "non secure access to secure region",
+		.status_reg = MC_ERR_STATUS,
+		.addr_reg = MC_ERR_ADR,
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
+	},
+};
+
+static irqreturn_t tegra186_mc_handle_irq(int irq, void *data)
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
+			addr = ((value >> MC_ERR_STATUS_ADR_HI_SHIFT) &
+				MC_ERR_STATUS_ADR_HI_MASK);
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
 const struct tegra_mc_interrupt_ops tegra186_mc_interrupt_ops = {
 	.clear_interrupt = tegra186_mc_clear_interrupt,
+	.handle_irq = tegra186_mc_handle_irq,
 };
 
 const struct tegra_mc_ops tegra186_mc_ops = {
@@ -886,6 +985,7 @@ const struct tegra_mc_soc tegra186_mc_soc = {
 	.num_clients = ARRAY_SIZE(tegra186_mc_clients),
 	.clients = tegra186_mc_clients,
 	.num_address_bits = 40,
+	.client_id_mask = 0xff,
 	.intmask = MC_INT_WCAM_ERR | MC_INT_SCRUB_ECC_WR_ACK |
 		   MC_INT_DECERR_GENERALIZED_CARVEOUT | MC_INT_DECERR_MTS |
 		   MC_INT_SECERR_SEC | MC_INT_DECERR_VPR |
-- 
2.7.4

