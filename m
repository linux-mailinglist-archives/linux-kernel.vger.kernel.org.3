Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CACC47C017
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 13:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237918AbhLUMwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 07:52:05 -0500
Received: from mail-co1nam11on2077.outbound.protection.outlook.com ([40.107.220.77]:54368
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237888AbhLUMv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:51:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CP3ayU7Zv0fK++PFamNIVrBlLnE0NYrpGkYsY6Rc2T2t/jWRIWqdqhMe++T9DQZF0x1y7ha5snPW6mvQKa+5iAlO98lBdrxbfCcdnJZED4gwrizFvrvjazovCJ81Fnc3kI7rhpPrpKQY5gQZKQzhdFlY5PSO01ivdVz3vN/Hh58aVOmAW2Eo6S24V8S6GD+nhBtRObpHd1CCKI2DVgO8TquGUfTO7AJYbf0fu6HLQMBCEqEvHpho2VLDLnXf6nSQ1JAglvT2WcOhxvGqBTuVbRWTQ1eBy4St2TRbgRQtOD5YTYWlEgSqI1VIT8yKx7ADk/3SknEeEonaAa87vVV17g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ZXaf5NxtB2/NUxx4azpkK7xhcVZv+viyfdUXcKIMBM=;
 b=mLosWY6OOTkwvrwUW2+XWSuIwmF7nEXel6OTAIrBfPx1LTkB7OouplFMElwIrvmWoJ3cxqXCVlZtV3qdeW8lS/kvaWhHQvhOLI5fOYmR9HEA4nyRxqpOK8jMQ7VsmFqC5AZxMZZKwjSjf0mDi15T6gCW94jpjSoO0G4AQSHz9/biB81cg3Mn1gYLGBXbaH8LYL/x021Xmg7gbpMUbOJ0KwW5YDRs3El0xe804P0uQi1EDspN9H18j22HLYIMrn75TrFZsU174JB/gMMcSI/DAQgPAnAByRTRYueopVNBe+7VADJCjVVswfiOe2l2r6l5menWIPkatUfMF3/zt+C09w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZXaf5NxtB2/NUxx4azpkK7xhcVZv+viyfdUXcKIMBM=;
 b=rokEKbk3ZqsV+R4opvljrnEszcdYn/2AjsP3vJQCFB0oy8cfknAoSjsuprwf+GOZy+XsL6EXoluToz0BaM5tYtLxJqP6lXyim6QC04p9lVgUX7GR1k/W/7MNMjgVzCNO/zSvrlXFkvj5VKNkuwex9hFdja3IlBPIIqVS4kDVL+2gXoH6RNKxcdTNzovT0qH54iDIDn+mM82fv/YyhX++2I22uNcofYkPTGHran/yxX4nQOxtW3rWmtFJMXHBcs5ev8jKY6JgiElQTfFy719FZy5vvIKQNnIiQnTSWy0+HHJf0fWvLrcuXiLbLDZaz09vybuEX/BWCBqR2ahoE4voqQ==
Received: from MW4PR03CA0266.namprd03.prod.outlook.com (2603:10b6:303:b4::31)
 by BL0PR12MB5537.namprd12.prod.outlook.com (2603:10b6:208:1cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.14; Tue, 21 Dec
 2021 12:51:54 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::17) by MW4PR03CA0266.outlook.office365.com
 (2603:10b6:303:b4::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Tue, 21 Dec 2021 12:51:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4801.14 via Frontend Transport; Tue, 21 Dec 2021 12:51:53 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 21 Dec
 2021 12:51:53 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 21 Dec
 2021 12:51:52 +0000
Received: from sumitg-l4t.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Tue, 21 Dec 2021 12:51:49 +0000
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>
CC:     <kbuild-all@lists.01.org>, <sumitg@nvidia.com>, <bbasu@nvidia.com>,
        <vsethi@nvidia.com>, <jsequeira@nvidia.com>
Subject: [Patch v3 8/9] soc: tegra: cbb: Add driver for Tegra234 CBB2.0
Date:   Tue, 21 Dec 2021 18:21:16 +0530
Message-ID: <20211221125117.6545-9-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211221125117.6545-1-sumitg@nvidia.com>
References: <20211221125117.6545-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 187dd5dd-3d07-41ff-4ef5-08d9c480aa2c
X-MS-TrafficTypeDiagnostic: BL0PR12MB5537:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB55376187C4BA7E76DBF9FD8DB97C9@BL0PR12MB5537.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:162;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rlllp9dcs4lzeyPxTHNSJsp77joU0eujEWNXMTNBoPPOwt7Ijq6XoNLMdNjYd6og7s+2frpFX0xV0cu2j5pN8GDGRsG/oeB12LwItz/KRY57v9wL7mn9dVQoC1wvA1w8lIR4Zz4jBVRuJnr8hcD/wTy1ZXv+9BJFcaWLmV8DEX/s/jNQmb/PbrR/7Z8RhlPonm5sqxSEmeMARkyhYS4Cj7QxhDCW1bBkigd38qe4UTZqV4YZqG0chGl+6M6hBemykggy25jnp3Vr4keCkemP64QgqWgmYYkclQj9CelFMqROcdZuXstgL2YoXMkyio4nND2sWg7gmJyb7PxX6LwPlL3ky/6QVceyz0jwIv4LLgkg+y7dbeDYK01oYxDfwONWneJqllCC+mxVeJ5rZPeE3jtoLn+CFmTvapq7a/gYrbyMn3KckmXOezctcZHGwo62MHni5VDakFa77Rj2MyDDUKNDYSk0jYhvKQKmxixg221um+C8OZHIpU1pqiN1HtOpYuFH+9abp3EaM2fctboNRK0vkrJ+fUo3tZolnnDhfZMHv1C5JSdskx087DBeNZXII+9Chr3B/47Okx3oQurByH+nMOhlQzD+tQSrkSyILZc/i/XLLCCo9gpLUf+HeQM2ZtUtkJefwVqezJtYuwPbGCcyMge0DpNFKpJQ4g3r5mgC3AVVWfg8Bs5TYtd+p0B/6Bh15XE+FKgDBwSAB2PiEvc0BFvIZ/wW5oQ6nEqPgVg5HXaljUbglMTYzHIO1Al/pmiyo3cdOLZGXoU8ThyVLeha5gbhzbIY5cWR8KzftUzorEYEdO/s7lZy/EyZY5ixDb1ZD0dq3izBKEzymRPNoQ==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(40470700002)(46966006)(36840700001)(5660300002)(6666004)(36860700001)(4326008)(40460700001)(26005)(107886003)(336012)(110136005)(82310400004)(83380400001)(316002)(54906003)(8936002)(86362001)(508600001)(70206006)(70586007)(30864003)(356005)(2616005)(47076005)(34020700004)(186003)(36756003)(81166007)(8676002)(7696005)(1076003)(2906002)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 12:51:53.8017
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 187dd5dd-3d07-41ff-4ef5-08d9c480aa2c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5537
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding driver to handle errors from CBB version 2.0 which is
used in Tegra234 SOC. The driver prints debug information about
failed transaction on receiving interrupt from Error Notifier.
Error notifier collates the interrupts from various Error
Monitor blocks and presents a single interrupt to the SOC
Interrupt Controller.
For timeout errors, the driver also does the lookup to find
timedout clients and prints client id. The IP's who want to
reset if there is a timeout will have to call BPMP from the
client IP's driver. BPMP firmware will also clear the timeout
bit after resetting the IP so that next transactions are send
to them after reset.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/soc/tegra/Kconfig            |   2 +-
 drivers/soc/tegra/cbb/Makefile       |   1 +
 drivers/soc/tegra/cbb/tegra234-cbb.c | 741 +++++++++++++++++++++++++++
 include/soc/tegra/tegra234-cbb.h     | 342 +++++++++++++
 4 files changed, 1085 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soc/tegra/cbb/tegra234-cbb.c
 create mode 100644 include/soc/tegra/tegra234-cbb.h

diff --git a/drivers/soc/tegra/Kconfig b/drivers/soc/tegra/Kconfig
index 0520b9744ec4..f0cf6a33cb5b 100644
--- a/drivers/soc/tegra/Kconfig
+++ b/drivers/soc/tegra/Kconfig
@@ -164,7 +164,7 @@ config SOC_TEGRA30_VOLTAGE_COUPLER
 
 config SOC_TEGRA_CBB
 	tristate "Tegra driver to handle error from CBB"
-	depends on ARCH_TEGRA_194_SOC
+	depends on ARCH_TEGRA_194_SOC || ARCH_TEGRA_234_SOC
 	default y
 	help
 	  Support for handling error from Tegra Control Backbone(CBB).
diff --git a/drivers/soc/tegra/cbb/Makefile b/drivers/soc/tegra/cbb/Makefile
index 3f9ff6575628..71877d20651f 100644
--- a/drivers/soc/tegra/cbb/Makefile
+++ b/drivers/soc/tegra/cbb/Makefile
@@ -5,4 +5,5 @@
 ifdef CONFIG_SOC_TEGRA_CBB
 obj-y += tegra-cbb.o
 obj-$(CONFIG_ARCH_TEGRA_194_SOC)        += tegra194-cbb.o
+obj-$(CONFIG_ARCH_TEGRA_234_SOC)        += tegra234-cbb.o
 endif
diff --git a/drivers/soc/tegra/cbb/tegra234-cbb.c b/drivers/soc/tegra/cbb/tegra234-cbb.c
new file mode 100644
index 000000000000..56069eb8dc2b
--- /dev/null
+++ b/drivers/soc/tegra/cbb/tegra234-cbb.c
@@ -0,0 +1,741 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021, NVIDIA CORPORATION. All rights reserved
+ *
+ * The driver handles Error's from Control Backbone(CBB) version 2.0.
+ * generated due to illegal accesses. The driver prints debug information
+ * about failed transaction on receiving interrupt from Error Notifier.
+ * Error types supported by CBB2.0 are:
+ *   UNSUPPORTED_ERR, PWRDOWN_ERR, TIMEOUT_ERR, FIREWALL_ERR, DECODE_ERR,
+ *   SLAVE_ERR
+ */
+
+#include <asm/cpufeature.h>
+#include <linux/clk.h>
+#include <linux/debugfs.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
+#include <linux/version.h>
+#include <soc/tegra/fuse.h>
+#include <soc/tegra/tegra-cbb.h>
+#include <soc/tegra/tegra234-cbb.h>
+
+static LIST_HEAD(cbb_errmon_list);
+static DEFINE_SPINLOCK(cbb_errmon_lock);
+
+static void tegra234_cbb_errmon_faulten(struct tegra_cbb *cbb)
+{
+	struct tegra_cbb_errmon_record *errmon;
+	void __iomem *addr;
+
+	errmon = (struct tegra_cbb_errmon_record *)cbb->err_rec;
+
+	addr = errmon->vaddr + errmon->err_notifier_base;
+	writel(0x1FF, addr + FABRIC_EN_CFG_INTERRUPT_ENABLE_0_0);
+	dsb(sy);
+}
+
+static void tegra234_cbb_errmon_errclr(struct tegra_cbb *cbb)
+{
+	void __iomem *addr;
+
+	addr = ((struct tegra_cbb_errmon_record *)cbb->err_rec)->addr_errmon;
+
+	writel(0x3F, addr + FABRIC_MN_MASTER_ERR_STATUS_0);
+	dsb(sy);
+}
+
+static u32 tegra234_cbb_errmon_errvld(struct tegra_cbb *cbb)
+{
+	struct tegra_cbb_errmon_record *errmon;
+	void __iomem *addr;
+	u32 errvld;
+
+	errmon = (struct tegra_cbb_errmon_record *)cbb->err_rec;
+
+	addr = errmon->vaddr + errmon->err_notifier_base;
+	errvld = readl(addr + FABRIC_EN_CFG_STATUS_0_0);
+	dsb(sy);
+
+	return errvld;
+}
+
+static void tegra234_cbb_mn_mask_serror(struct tegra_cbb *cbb)
+{
+	struct tegra_cbb_errmon_record *errmon;
+	void __iomem *erd_mask;
+
+	errmon = (struct tegra_cbb_errmon_record *)cbb->err_rec;
+
+	erd_mask = errmon->vaddr + errmon->off_mask_erd;
+	writel(0x1, erd_mask);
+	dsb(sy);
+}
+
+u32 tegra234_cbb_readl(unsigned long offset)
+{
+	struct tegra_cbb_errmon_record *errmon;
+	bool flag = 0;
+	u32 val = 0;
+
+	if (offset > 0x3FFFFF) {
+		pr_err("%s: wrong offset value\n", __func__);
+		return 0;
+	}
+
+	list_for_each_entry(errmon, &cbb_errmon_list, node) {
+		if (strstr(errmon->name, "cbb")) {
+			val = readl(errmon->vaddr + offset);
+			flag = true;
+			break;
+		}
+	}
+	if (!flag)
+		pr_err("%s: cbb fabric not initialized\n", __func__);
+
+	return val;
+}
+EXPORT_SYMBOL(tegra234_cbb_readl);
+
+void tegra234_cbb_writel(unsigned long offset, u32 val)
+{
+	struct tegra_cbb_errmon_record *errmon;
+	bool flag = 0;
+
+	if (offset > 0x3FFFFF) {
+		pr_err("%s: wrong offset value\n", __func__);
+		return;
+	}
+
+	list_for_each_entry(errmon, &cbb_errmon_list, node) {
+		if (strstr(errmon->name, "cbb")) {
+			writel(val, errmon->vaddr + offset);
+			flag = true;
+			break;
+		}
+	}
+	if (!flag)
+		pr_err("%s: cbb fabric not initialized\n", __func__);
+}
+EXPORT_SYMBOL(tegra234_cbb_writel);
+
+static u32 tegra234_cbb_get_tmo_slv(void __iomem *addr)
+{
+	u32 timeout;
+
+	timeout = readl(addr);
+	return timeout;
+}
+
+static void tegra234_cbb_tmo_slv(struct seq_file *file, char *slv_name,
+				 void __iomem *addr, u32 tmo_status)
+{
+	tegra_cbb_print_err(file, "\t  %s : 0x%x\n", slv_name, tmo_status);
+}
+
+static void tegra234_cbb_lookup_apbslv(struct seq_file *file, char *slave_name, u64 addr)
+{
+	unsigned int blkno_tmo_status, tmo_status;
+	unsigned int reset_client, client_id;
+	char slv_name[40];
+	int block_num = 0;
+
+	tmo_status = tegra234_cbb_get_tmo_slv((void __iomem *)addr);
+	if (tmo_status)
+		tegra_cbb_print_err(file, "\t  %s_BLOCK_TMO_STATUS : 0x%x\n",
+				    slave_name, tmo_status);
+
+	while (tmo_status) {
+		if (!(tmo_status & BIT(0)))
+			goto next_iter;
+
+		addr =  addr + APB_BLOCK_NUM_TMO_OFFSET + (block_num * 4);
+		blkno_tmo_status = tegra234_cbb_get_tmo_slv((void __iomem *)addr);
+		reset_client = blkno_tmo_status;
+
+		if (blkno_tmo_status) {
+			client_id = 1;
+			while (blkno_tmo_status) {
+				if (blkno_tmo_status & 0x1) {
+					if (reset_client != 0xffffffff)
+						reset_client &= client_id;
+
+					sprintf(slv_name, "%s_BLOCK%d_TMO", slave_name, block_num);
+
+					tegra234_cbb_tmo_slv(file, slv_name, (void __iomem *)addr,
+							     reset_client);
+				}
+				blkno_tmo_status >>= 1;
+				client_id <<= 1;
+			}
+		}
+next_iter:
+		tmo_status >>= 1;
+		block_num++;
+	}
+}
+
+static void tegra234_lookup_slave_timeout(struct seq_file *file,
+					  struct tegra_cbb_errmon_record *errmon,
+					  u8 slave_id, u8 fab_id)
+{
+	struct tegra_sn_addr_map *sn_lookup = errmon->sn_addr_map;
+	void __iomem *base_addr = errmon->vaddr;
+	unsigned int tmo_status;
+	char slv_name[40];
+	int i = slave_id;
+	u64 addr = 0;
+
+	/*
+	 * 1) Get slave node name and address mapping using slave_id.
+	 * 2) Check if the timed out slave node is APB or AXI.
+	 * 3) If AXI, then print timeout register and reset axi slave
+	 *    using <FABRIC>_SN_<>_SLV_TIMEOUT_STATUS_0_0 register.
+	 * 4) If APB, then perform an additional lookup to find the client
+	 *    which timed out.
+	 *	a) Get block number from the index of set bit in
+	 *	   <FABRIC>_SN_AXI2APB_<>_BLOCK_TMO_STATUS_0 register.
+	 *	b) Get address of register repective to block number i.e.
+	 *	   <FABRIC>_SN_AXI2APB_<>_BLOCK<index-set-bit>_TMO_0.
+	 *	c) Read the register in above step to get client_id which
+	 *	   timed out as per the set bits.
+	 *      d) Reset the timedout client and print details.
+	 *	e) Goto step-a till all bits are set.
+	 */
+
+	addr = (u64)base_addr + sn_lookup[i].off_slave;
+
+	if (strstr(sn_lookup[i].slave_name, "AXI2APB")) {
+		addr = addr + APB_BLOCK_TMO_STATUS_0;
+		tegra234_cbb_lookup_apbslv(file, sn_lookup[i].slave_name, addr);
+	} else {
+		addr = addr + AXI_SLV_TIMEOUT_STATUS_0_0;
+
+		tmo_status = tegra234_cbb_get_tmo_slv((void __iomem *)addr);
+		if (tmo_status) {
+			sprintf(slv_name, "%s_SLV_TIMEOUT_STATUS", sn_lookup[i].slave_name);
+			tegra234_cbb_tmo_slv(file, slv_name, (void __iomem *)addr, tmo_status);
+		}
+	}
+}
+
+static void print_errmon_err(struct seq_file *file, struct tegra_cbb_errmon_record *errmon,
+			     unsigned int em_err_status, unsigned int em_overflow_status)
+{
+	int err_type = 0;
+
+	if (em_err_status & (em_err_status - 1))
+		tegra_cbb_print_err(file, "\t  Multiple type of errors reported\n");
+
+	while (em_err_status) {
+		if (em_err_status & 0x1)
+			tegra_cbb_print_err(file, "\t  Error Code\t\t: %s\n",
+					    t234_errmon_errors[err_type].errcode);
+		em_err_status >>= 1;
+		err_type++;
+	}
+
+	err_type = 0;
+	while (em_overflow_status) {
+		if (em_overflow_status & 0x1)
+			tegra_cbb_print_err(file, "\t  Overflow\t\t: Multiple %s\n",
+					    t234_errmon_errors[err_type].errcode);
+		em_overflow_status >>= 1;
+		err_type++;
+	}
+}
+
+static void print_errlog_err(struct seq_file *file, struct tegra_cbb_errmon_record *errmon)
+{
+	u8 cache_type = 0, prot_type = 0, burst_length = 0;
+	u8 mstr_id = 0, grpsec = 0, vqc = 0, falconsec = 0;
+	u8 beat_size = 0, access_type = 0, access_id = 0;
+	u8 slave_id = 0, fab_id = 0, burst_type = 0;
+	char fabric_name[20];
+
+	mstr_id   = FIELD_GET(FAB_EM_EL_MSTRID, errmon->mn_user_bits);
+	vqc	  = FIELD_GET(FAB_EM_EL_VQC, errmon->mn_user_bits);
+	grpsec	  = FIELD_GET(FAB_EM_EL_GRPSEC, errmon->mn_user_bits);
+	falconsec = FIELD_GET(FAB_EM_EL_FALCONSEC, errmon->mn_user_bits);
+
+	fab_id	   = FIELD_GET(FAB_EM_EL_FABID, errmon->mn_attr2);
+	slave_id   = FIELD_GET(FAB_EM_EL_SLAVEID, errmon->mn_attr2);
+
+	access_id  = FIELD_GET(FAB_EM_EL_ACCESSID, errmon->mn_attr1);
+
+	cache_type   = FIELD_GET(FAB_EM_EL_AXCACHE, errmon->mn_attr0);
+	prot_type    = FIELD_GET(FAB_EM_EL_AXPROT, errmon->mn_attr0);
+	burst_length = FIELD_GET(FAB_EM_EL_BURSTLENGTH, errmon->mn_attr0);
+	burst_type   = FIELD_GET(FAB_EM_EL_BURSTTYPE, errmon->mn_attr0);
+	beat_size    = FIELD_GET(FAB_EM_EL_BEATSIZE, errmon->mn_attr0);
+	access_type  = FIELD_GET(FAB_EM_EL_ACCESSTYPE, errmon->mn_attr0);
+
+	tegra_cbb_print_err(file, "\n");
+	tegra_cbb_print_err(file, "\t  Error Code\t\t: %s\n",
+			    t234_errmon_errors[errmon->err_type].errcode);
+
+	tegra_cbb_print_err(file, "\t  MASTER_ID\t\t: %s\n", errmon->tegra_cbb_master_id[mstr_id]);
+	tegra_cbb_print_err(file, "\t  Address\t\t: 0x%llx\n", (u64)errmon->addr_access);
+
+	tegra_cbb_print_cache(file, cache_type);
+	tegra_cbb_print_prot(file, prot_type);
+
+	tegra_cbb_print_err(file, "\t  Access_Type\t\t: %s", (access_type) ? "Write\n" : "Read\n");
+	tegra_cbb_print_err(file, "\t  Access_ID\t\t: 0x%x", access_id);
+
+	if (fab_id == PSC_FAB_ID)
+		strcpy(fabric_name, "psc-fabric");
+	else if (fab_id == FSI_FAB_ID)
+		strcpy(fabric_name, "fsi-fabric");
+	else
+		strcpy(fabric_name, errmon->name);
+
+	tegra_cbb_print_err(file, "\t  Fabric\t\t: %s\n", fabric_name);
+	tegra_cbb_print_err(file, "\t  Slave_Id\t\t: 0x%x\n", slave_id);
+	tegra_cbb_print_err(file, "\t  Burst_length\t\t: 0x%x\n", burst_length);
+	tegra_cbb_print_err(file, "\t  Burst_type\t\t: 0x%x\n", burst_type);
+	tegra_cbb_print_err(file, "\t  Beat_size\t\t: 0x%x\n", beat_size);
+	tegra_cbb_print_err(file, "\t  VQC\t\t\t: 0x%x\n", vqc);
+	tegra_cbb_print_err(file, "\t  GRPSEC\t\t: 0x%x\n", grpsec);
+	tegra_cbb_print_err(file, "\t  FALCONSEC\t\t: 0x%x\n", falconsec);
+
+	if ((fab_id == PSC_FAB_ID) || (fab_id == FSI_FAB_ID))
+		return;
+
+	if (!strcmp(errmon->noc_errors[errmon->err_type].errcode, "TIMEOUT_ERR")) {
+		tegra234_lookup_slave_timeout(file, errmon, slave_id, fab_id);
+		return;
+	}
+	tegra_cbb_print_err(file, "\t  Slave\t\t\t: %s\n",
+			    errmon->sn_addr_map[slave_id].slave_name);
+}
+
+static int print_errmonX_info(struct seq_file *file, struct tegra_cbb_errmon_record *errmon)
+{
+	unsigned int em_overflow_status = 0;
+	unsigned int em_err_status = 0;
+	unsigned int el_err_status = 0;
+	u64 addr = 0;
+
+	errmon->err_type = 0;
+
+	em_err_status = readl(errmon->addr_errmon +
+					FABRIC_MN_MASTER_ERR_STATUS_0);
+	if (!em_err_status) {
+		pr_err("Error Notifier received a spurious notification\n");
+		BUG();
+	}
+
+	if (em_err_status == 0xFFFFFFFF) {
+		pr_err("CBB registers returning all 1's which is invalid\n");
+		return -EINVAL;
+	}
+
+	/*get overflow flag*/
+	em_overflow_status = readl(errmon->addr_errmon +
+				   FABRIC_MN_MASTER_ERR_OVERFLOW_STATUS_0);
+
+	print_errmon_err(file, errmon, em_err_status, em_overflow_status);
+
+	el_err_status = readl(errmon->addr_errmon + FABRIC_MN_MASTER_LOG_ERR_STATUS_0);
+	if (!el_err_status) {
+		pr_info("Error Monitor doesn't have Error Logger\n");
+		return -EINVAL;
+	}
+
+	while (el_err_status) {
+		if (el_err_status & BIT(0)) {
+			addr = readl(errmon->addr_errmon +
+				     FABRIC_MN_MASTER_LOG_ADDR_HIGH_0);
+			addr = (addr << 32) |
+				readl(errmon->addr_errmon +
+				      FABRIC_MN_MASTER_LOG_ADDR_LOW_0);
+			errmon->addr_access = (void __iomem *)addr;
+
+			errmon->mn_attr0 = readl(errmon->addr_errmon +
+						 FABRIC_MN_MASTER_LOG_ATTRIBUTES0_0);
+
+			errmon->mn_attr1 = readl(errmon->addr_errmon +
+						 FABRIC_MN_MASTER_LOG_ATTRIBUTES1_0);
+
+			errmon->mn_attr2 = readl(errmon->addr_errmon +
+						 FABRIC_MN_MASTER_LOG_ATTRIBUTES2_0);
+
+			errmon->mn_user_bits = readl(errmon->addr_errmon +
+						     FABRIC_MN_MASTER_LOG_USER_BITS0_0);
+
+			print_errlog_err(file, errmon);
+		}
+		errmon->err_type++;
+		el_err_status >>= 1;
+	}
+	return 0;
+}
+
+static int print_err_notifier(struct seq_file *file, struct tegra_cbb *cbb,
+			      struct tegra_cbb_errmon_record *errmon, int err_notifier_sts)
+{
+	u64 em_addr_offset = 0;
+	u64 em_phys_addr = 0;
+	int errmon_no = 1;
+	int ret = 0;
+
+	pr_crit("**************************************\n");
+	pr_crit("CPU:%d, Error:%s, Errmon:%d\n", smp_processor_id(),
+		errmon->name, err_notifier_sts);
+
+	while (err_notifier_sts) {
+		if (err_notifier_sts & BIT(0)) {
+			writel(errmon_no, errmon->vaddr + errmon->err_notifier_base +
+			       FABRIC_EN_CFG_ADDR_INDEX_0_0);
+
+			em_phys_addr = readl(errmon->vaddr + errmon->err_notifier_base +
+					     FABRIC_EN_CFG_ADDR_HI_0);
+			em_phys_addr = (em_phys_addr << 32) |
+					    readl(errmon->vaddr + errmon->err_notifier_base +
+						  FABRIC_EN_CFG_ADDR_LOW_0);
+
+			em_addr_offset = em_phys_addr - errmon->start;
+			errmon->addr_errmon = (void __iomem *)(errmon->vaddr + em_addr_offset);
+
+			errmon->errmon_no = errmon_no;
+
+			ret = print_errmonX_info(file, errmon);
+			tegra234_cbb_errmon_errclr(cbb);
+			if (ret)
+				return ret;
+		}
+		err_notifier_sts >>= 1;
+		errmon_no <<= 1;
+	}
+
+	tegra_cbb_print_err(file, "\t**************************************\n");
+	return 0;
+}
+
+#ifdef CONFIG_DEBUG_FS
+static DEFINE_MUTEX(cbb_err_mutex);
+
+static int tegra234_cbb_err_show(struct tegra_cbb *cbb, struct seq_file *file, void *data)
+{
+	struct tegra_cbb_errmon_record *errmon;
+	unsigned int errvld = 0;
+	int ret = 0;
+
+	mutex_lock(&cbb_err_mutex);
+
+	list_for_each_entry(errmon, &cbb_errmon_list, node) {
+		cbb = errmon->cbb;
+		errvld = tegra_cbb_errvld(cbb);
+		if (errvld) {
+			ret = print_err_notifier(file, cbb, errmon, errvld);
+			if (ret)
+				goto en_show_exit;
+		}
+	}
+
+en_show_exit:
+	mutex_unlock(&cbb_err_mutex);
+	return ret;
+}
+#endif
+
+/*
+ * Handler for CBB errors
+ */
+static irqreturn_t tegra234_cbb_err_isr(int irq, void *data)
+{
+	struct tegra_cbb_errmon_record *errmon;
+	struct tegra_cbb *cbb = data;
+	bool is_inband_err = 0;
+	unsigned long flags;
+	u32 errvld = 0;
+	u8 mstr_id = 0;
+	int ret = 0;
+
+	spin_lock_irqsave(&cbb_errmon_lock, flags);
+
+	list_for_each_entry(errmon, &cbb_errmon_list, node) {
+		errvld = tegra_cbb_errvld(cbb);
+
+		if (errvld && (irq == errmon->sec_irq)) {
+			tegra_cbb_print_err(NULL, "CPU:%d, Error:%s@0x%llx, irq=%d\n",
+					    smp_processor_id(), errmon->name,
+					    errmon->start, irq);
+
+			ret = print_err_notifier(NULL, cbb, errmon, errvld);
+			if (ret)
+				goto en_isr_exit;
+
+			mstr_id =  FIELD_GET(USRBITS_MSTR_ID, errmon->mn_user_bits);
+
+			/* If illegal request is from CCPLEX(id:0x1)
+			 * master then call BUG() to crash system.
+			 */
+			if ((mstr_id == 0x1) && errmon->erd_mask_inband_err)
+				is_inband_err = 1;
+		}
+	}
+en_isr_exit:
+	spin_unlock_irqrestore(&cbb_errmon_lock, flags);
+
+	WARN_ON(is_inband_err);
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * Register handler for CBB_SECURE interrupt for reporting errors
+ */
+static int tegra234_cbb_intr_en(struct tegra_cbb *cbb)
+{
+	struct platform_device *pdev = cbb->pdev;
+	int sec_irq;
+	int err = 0;
+
+	sec_irq = ((struct tegra_cbb_errmon_record *)cbb->err_rec)->sec_irq;
+
+	if (sec_irq) {
+		err = devm_request_irq(&pdev->dev, sec_irq, tegra234_cbb_err_isr,
+				       0, dev_name(&pdev->dev), cbb);
+		if (err) {
+			dev_err(&pdev->dev, "%s: Unable to register (%d) interrupt\n",
+				__func__, sec_irq);
+			goto isr_err_free_sec_irq;
+		}
+	}
+	return 0;
+
+isr_err_free_sec_irq:
+	free_irq(sec_irq, pdev);
+
+	return err;
+}
+
+static void tegra234_cbb_err_en(struct tegra_cbb *cbb)
+{
+	tegra_cbb_faulten(cbb);
+}
+
+static struct tegra_cbb_err_ops tegra234_cbb_errmon_ops = {
+	.errvld	 = tegra234_cbb_errmon_errvld,
+	.errclr	 = tegra234_cbb_errmon_errclr,
+	.faulten = tegra234_cbb_errmon_faulten,
+	.cbb_err_enable = tegra234_cbb_err_en,
+	.cbb_intr_enable = tegra234_cbb_intr_en,
+#ifdef CONFIG_DEBUG_FS
+	.cbb_err_debugfs_show = tegra234_cbb_err_show
+#endif
+};
+
+static struct tegra_cbb_fabric_data tegra234_aon_fab_data = {
+	.name   = "aon-fabric",
+	.tegra_cbb_master_id = t234_master_id,
+	.sn_addr_map = t234_aon_sn_lookup,
+	.noc_errors = t234_errmon_errors,
+	.err_notifier_base = 0x17000
+};
+
+static struct tegra_cbb_fabric_data tegra234_bpmp_fab_data = {
+	.name   = "bpmp-fabric",
+	.tegra_cbb_master_id = t234_master_id,
+	.sn_addr_map = t234_bpmp_sn_lookup,
+	.noc_errors = t234_errmon_errors,
+	.err_notifier_base = 0x19000
+};
+
+static struct tegra_cbb_fabric_data tegra234_cbb_fab_data = {
+	.name   = "cbb-fabric",
+	.tegra_cbb_master_id = t234_master_id,
+	.sn_addr_map = t234_cbb_sn_lookup,
+	.noc_errors = t234_errmon_errors,
+	.err_notifier_base = 0x60000,
+	.off_mask_erd = 0x3a004
+};
+
+static struct tegra_cbb_fabric_data tegra234_dce_fab_data = {
+	.name   = "dce-fabric",
+	.tegra_cbb_master_id = t234_master_id,
+	.sn_addr_map = t234_dce_sn_lookup,
+	.noc_errors = t234_errmon_errors,
+	.err_notifier_base = 0x19000
+};
+
+static struct tegra_cbb_fabric_data tegra234_rce_fab_data = {
+	.name   = "rce-fabric",
+	.tegra_cbb_master_id = t234_master_id,
+	.sn_addr_map = t234_rce_sn_lookup,
+	.noc_errors = t234_errmon_errors,
+	.err_notifier_base = 0x19000
+};
+
+static struct tegra_cbb_fabric_data tegra234_sce_fab_data = {
+	.name   = "sce-fabric",
+	.tegra_cbb_master_id = t234_master_id,
+	.sn_addr_map = t234_sce_sn_lookup,
+	.noc_errors = t234_errmon_errors,
+	.err_notifier_base = 0x19000
+};
+
+static const struct of_device_id tegra234_cbb_dt_ids[] = {
+	{.compatible    = "nvidia,tegra234-cbb-fabric",
+		.data = &tegra234_cbb_fab_data},
+	{.compatible    = "nvidia,tegra234-aon-fabric",
+		.data = &tegra234_aon_fab_data},
+	{.compatible    = "nvidia,tegra234-bpmp-fabric",
+		.data = &tegra234_bpmp_fab_data},
+	{.compatible    = "nvidia,tegra234-dce-fabric",
+		.data = &tegra234_dce_fab_data},
+	{.compatible    = "nvidia,tegra234-rce-fabric",
+		.data = &tegra234_rce_fab_data},
+	{.compatible    = "nvidia,tegra234-sce-fabric",
+		.data = &tegra234_sce_fab_data},
+	{},
+};
+MODULE_DEVICE_TABLE(of, tegra234_cbb_dt_ids);
+
+static int
+tegra234_cbb_errmon_init(const struct tegra_cbb_fabric_data *pdata,
+			 struct tegra_cbb *cbb, struct resource *res_base)
+{
+	struct platform_device *pdev = cbb->pdev;
+	struct tegra_cbb_errmon_record *errmon;
+	unsigned long flags = 0;
+	int err = 0;
+
+	errmon = (struct tegra_cbb_errmon_record *)cbb->err_rec;
+	errmon->vaddr = devm_ioremap_resource(&pdev->dev, res_base);
+	if (IS_ERR(errmon->vaddr))
+		return -EINVAL;
+
+	errmon->name = pdata->name;
+	errmon->start = res_base->start;
+	errmon->tegra_cbb_master_id = pdata->tegra_cbb_master_id;
+	errmon->err_notifier_base = pdata->err_notifier_base;
+	errmon->off_mask_erd = pdata->off_mask_erd;
+	errmon->sn_addr_map = pdata->sn_addr_map;
+	errmon->noc_errors = pdata->noc_errors;
+	errmon->cbb = cbb;
+
+	if (errmon->off_mask_erd)
+		errmon->erd_mask_inband_err = 1;
+
+	err = tegra_cbb_err_getirq(pdev, NULL, &errmon->sec_irq);
+	if (err)
+		return err;
+
+	cbb->ops = &tegra234_cbb_errmon_ops;
+
+	spin_lock_irqsave(&cbb_errmon_lock, flags);
+	list_add(&errmon->node, &cbb_errmon_list);
+	spin_unlock_irqrestore(&cbb_errmon_lock, flags);
+
+	return 0;
+};
+
+static int tegra234_cbb_probe(struct platform_device *pdev)
+{
+	struct tegra_cbb_errmon_record *errmon = NULL;
+	const struct tegra_cbb_fabric_data *pdata = NULL;
+	struct resource *res_base = NULL;
+	struct tegra_cbb *cbb;
+	int err = 0;
+
+	pdata = of_device_get_match_data(&pdev->dev);
+	if (!pdata) {
+		dev_err(&pdev->dev, "No device match found\n");
+		return -EINVAL;
+	}
+
+	res_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res_base) {
+		dev_err(&pdev->dev, "Could not find base address");
+		return -ENOENT;
+	}
+
+	cbb = devm_kzalloc(&pdev->dev, sizeof(*cbb), GFP_KERNEL);
+	if (!cbb)
+		return -ENOMEM;
+
+	errmon = devm_kzalloc(&pdev->dev, sizeof(*errmon), GFP_KERNEL);
+	if (!errmon)
+		return -ENOMEM;
+
+	cbb->err_rec = errmon;
+	cbb->pdev = pdev;
+	err = tegra234_cbb_errmon_init(pdata, cbb, res_base);
+	if (err) {
+		dev_err(&pdev->dev, "cbberr init for soc failing\n");
+		return err;
+	}
+
+	/* set ERD bit to mask SError and generate interrupt to report error */
+	if (errmon->erd_mask_inband_err)
+		tegra234_cbb_mn_mask_serror(cbb);
+
+	return tegra_cbb_register_isr_enaberr(cbb);
+}
+
+static int tegra234_cbb_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int tegra234_cbb_resume_noirq(struct device *dev)
+{
+	struct tegra_cbb *cbb = dev_get_drvdata(dev);
+	struct tegra_cbb_errmon_record *errmon;
+
+	errmon = (struct tegra_cbb_errmon_record *)cbb->err_rec;
+
+	if (!errmon)
+		return -EINVAL;
+
+	tegra234_cbb_err_en(cbb);
+
+	dev_info(dev, "%s resumed\n", errmon->name);
+	return 0;
+}
+
+static const struct dev_pm_ops tegra234_cbb_pm = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(NULL, tegra234_cbb_resume_noirq)
+};
+#endif
+
+static struct platform_driver tegra234_cbb_driver = {
+	.probe          = tegra234_cbb_probe,
+	.remove         = tegra234_cbb_remove,
+	.driver = {
+		.owner  = THIS_MODULE,
+		.name   = "tegra234-cbb",
+		.of_match_table = of_match_ptr(tegra234_cbb_dt_ids),
+#ifdef CONFIG_PM_SLEEP
+		.pm     = &tegra234_cbb_pm,
+#endif
+	},
+};
+
+static int __init tegra234_cbb_init(void)
+{
+	return platform_driver_register(&tegra234_cbb_driver);
+}
+
+static void __exit tegra234_cbb_exit(void)
+{
+	platform_driver_unregister(&tegra234_cbb_driver);
+}
+
+pure_initcall(tegra234_cbb_init);
+module_exit(tegra234_cbb_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Control Backbone 2.0 error handling driver for Tegra234");
diff --git a/include/soc/tegra/tegra234-cbb.h b/include/soc/tegra/tegra234-cbb.h
new file mode 100644
index 000000000000..8c3ff758c845
--- /dev/null
+++ b/include/soc/tegra/tegra234-cbb.h
@@ -0,0 +1,342 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021, NVIDIA CORPORATION. All rights reserved
+ */
+
+#define FABRIC_EN_CFG_INTERRUPT_ENABLE_0_0	0x0
+#define FABRIC_EN_CFG_STATUS_0_0		0x40
+#define FABRIC_EN_CFG_ADDR_INDEX_0_0		0x60
+#define FABRIC_EN_CFG_ADDR_LOW_0		0x80
+#define FABRIC_EN_CFG_ADDR_HI_0			0x84
+
+#define FABRIC_MN_MASTER_ERR_EN_0		0x200
+#define FABRIC_MN_MASTER_ERR_FORCE_0		0x204
+#define FABRIC_MN_MASTER_ERR_STATUS_0		0x208
+#define FABRIC_MN_MASTER_ERR_OVERFLOW_STATUS_0	0x20c
+
+#define FABRIC_MN_MASTER_LOG_ERR_STATUS_0	0x300
+#define FABRIC_MN_MASTER_LOG_ADDR_LOW_0		0x304
+#define FABRIC_MN_MASTER_LOG_ADDR_HIGH_0	0x308
+#define FABRIC_MN_MASTER_LOG_ATTRIBUTES0_0	0x30c
+#define FABRIC_MN_MASTER_LOG_ATTRIBUTES1_0	0x310
+#define FABRIC_MN_MASTER_LOG_ATTRIBUTES2_0	0x314
+#define FABRIC_MN_MASTER_LOG_USER_BITS0_0	0x318
+
+#define AXI_SLV_TIMEOUT_STATUS_0_0		0x8
+#define APB_BLOCK_TMO_STATUS_0			0xC00
+#define APB_BLOCK_NUM_TMO_OFFSET		0x20
+
+#define FAB_EM_EL_MSTRID		GENMASK(29, 24)
+#define FAB_EM_EL_VQC			GENMASK(17, 16)
+#define FAB_EM_EL_GRPSEC		GENMASK(14, 8)
+#define FAB_EM_EL_FALCONSEC		GENMASK(1, 0)
+
+#define FAB_EM_EL_FABID			GENMASK(20, 16)
+#define FAB_EM_EL_SLAVEID		GENMASK(7, 0)
+
+#define FAB_EM_EL_ACCESSID		GENMASK(7, 0)
+
+#define FAB_EM_EL_AXCACHE		GENMASK(27, 24)
+#define FAB_EM_EL_AXPROT		GENMASK(22, 20)
+#define FAB_EM_EL_BURSTLENGTH		GENMASK(19, 12)
+#define FAB_EM_EL_BURSTTYPE		GENMASK(9, 8)
+#define FAB_EM_EL_BEATSIZE		GENMASK(6, 4)
+#define FAB_EM_EL_ACCESSTYPE		GENMASK(0, 0)
+
+#define USRBITS_MSTR_ID GENMASK(29, 24)
+
+enum tegra_cbb_fabric_ids {
+	CBB_FAB_ID,
+	SCE_FAB_ID,
+	RCE_FAB_ID,
+	DCE_FAB_ID,
+	AON_FAB_ID,
+	PSC_FAB_ID,
+	BPMP_FAB_ID,
+	FSI_FAB_ID,
+	MAX_FAB_ID,
+};
+
+struct tegra_sn_addr_map {
+	char *slave_name;
+	u32 off_slave;
+};
+
+struct tegra_cbb_fabric_data {
+	char *name;
+	phys_addr_t off_mask_erd;
+	bool erd_mask_inband_err;
+	char **tegra_cbb_master_id;
+	phys_addr_t err_notifier_base;
+	struct tegra_noc_errors *noc_errors;
+	struct tegra_sn_addr_map *sn_addr_map;
+};
+
+struct tegra_cbb_errmon_record {
+	struct list_head node;
+	char *name;
+	int errmon_no;
+	int err_type;
+	phys_addr_t start;
+	phys_addr_t err_notifier_base;
+	int num_intr;
+	int sec_irq;
+	void __iomem *vaddr;
+	void __iomem *addr_errmon;
+	void __iomem *addr_access;
+	u32 mn_attr0;
+	u32 mn_attr1;
+	u32 mn_attr2;
+	u32 mn_user_bits;
+	phys_addr_t off_mask_erd;
+	bool erd_mask_inband_err;
+	struct tegra_cbb *cbb;
+	char **tegra_cbb_master_id;
+	struct tegra_noc_errors *noc_errors;
+	struct tegra_sn_addr_map *sn_addr_map;
+};
+
+u32 tegra234_cbb_readl(unsigned long offset);
+void tegra234_cbb_writel(unsigned long offset, u32 val);
+
+static char *t234_master_id[] = {
+	"TZ",				/* 0x0  */
+	"CCPLEX",			/* 0x1  */
+	"CCPMU",			/* 0x2  */
+	"BPMP_FW",			/* 0x3  */
+	"AON",				/* 0x4  */
+	"SCE",				/* 0x5  */
+	"GPCDMA_P",			/* 0x6  */
+	"TSECA_NONSECURE",		/* 0x7  */
+	"TSECA_LIGHTSECURE",		/* 0x8  */
+	"TSECA_HEAVYSECURE",		/* 0x9  */
+	"CORESIGHT",			/* 0xA  */
+	"APE",				/* 0xB  */
+	"PEATRANS",			/* 0xC  */
+	"JTAGM_DFT",			/* 0xD  */
+	"RCE",				/* 0xE  */
+	"DCE",				/* 0xF  */
+	"PSC_FW_USER",			/* 0x10 */
+	"PSC_FW_SUPERVISOR",		/* 0x11 */
+	"PSC_FW_MACHINE",		/* 0x12 */
+	"PSC_BOOT",			/* 0x13 */
+	"BPMP_BOOT",			/* 0x14 */
+	"NVDEC_NONSECURE",		/* 0x15 */
+	"NVDEC_LIGHTSECURE",		/* 0x16 */
+	"NVDEC_HEAVYSECURE",		/* 0x17 */
+	"CBB_INTERNAL",			/* 0x18 */
+	"RSVD"				/* 0x3F */
+};
+
+static struct tegra_noc_errors t234_errmon_errors[] = {
+	{.errcode = "SLAVE_ERR",
+	 .type = "Slave being accessed responded with an error"
+	},
+	{.errcode = "DECODE_ERR",
+	 .type = "Attempt to access an address hole"
+	},
+	{.errcode = "FIREWALL_ERR",
+	 .type = "Attempt to access a region which is firewall protected"
+	},
+	{.errcode = "TIMEOUT_ERR",
+	 .type = "No response returned by slave"
+	},
+	{.errcode = "PWRDOWN_ERR",
+	 .type = "Attempt to access a portion of fabric that is powered down"
+	},
+	{.errcode = "UNSUPPORTED_ERR",
+	 .type = "Attempt to access a slave through an unsupported access"
+	}
+};
+
+#define AON_SN_AXI2APB_1	0x00000
+#define AON_SN_AST1_T		0x14000
+#define AON_SN_CBB_T		0x15000
+#define AON_SN_CPU_T		0x16000
+
+#define BPMP_SN_AXI2APB_1	0x00000
+#define BPMP_SN_AST0_T		0x15000
+#define BPMP_SN_AST1_T		0x16000
+#define BPMP_SN_CBB_T		0x17000
+#define BPMP_SN_CPU_T		0x18000
+
+#define DCE_SN_AXI2APB_1	0x00000
+#define DCE_SN_AST0_T		0x15000
+#define DCE_SN_AST1_T		0x16000
+#define DCE_SN_CPU_T		0x18000
+
+#define RCE_SN_AXI2APB_1	0x00000
+#define RCE_SN_AST0_T		0x15000
+#define RCE_SN_AST1_T		0x16000
+#define RCE_SN_CPU_T		0x18000
+
+#define SCE_SN_AXI2APB_1	0x00000
+#define SCE_SN_AST0_T		0x15000
+#define SCE_SN_AST1_T		0x16000
+#define SCE_SN_CBB_T		0x17000
+#define SCE_SN_CPU_T		0x18000
+
+#define CBB_SN_AON_SLAVE	0x40000
+#define CBB_SN_BPMP_SLAVE	0x41000
+#define CBB_SN_CBB_CENTRAL	0x42000
+#define CBB_SN_HOST1X		0x43000
+#define CBB_SN_STM		0x44000
+#define CBB_SN_FSI_SLAVE	0x45000
+#define CBB_SN_PSC_SLAVE	0x46000
+#define CBB_SN_PCIE_C1		0x47000
+#define CBB_SN_PCIE_C2		0x48000
+#define CBB_SN_PCIE_C3		0x49000
+#define CBB_SN_PCIE_C0		0x4A000
+#define CBB_SN_PCIE_C4		0x4B000
+#define CBB_SN_GPU		0x4C000
+#define CBB_SN_SMMU0		0x4D000
+#define CBB_SN_SMMU1		0x4E000
+#define CBB_SN_SMMU2		0x4F000
+#define CBB_SN_SMMU3		0x50000
+#define CBB_SN_SMMU4		0x51000
+#define CBB_SN_PCIE_C10		0x52000
+#define CBB_SN_PCIE_C7		0x53000
+#define CBB_SN_PCIE_C8		0x54000
+#define CBB_SN_PCIE_C9		0x55000
+#define CBB_SN_PCIE_C5		0x56000
+#define CBB_SN_PCIE_C6		0x57000
+#define CBB_SN_DCE_SLAVE	0x58000
+#define CBB_SN_RCE_SLAVE	0x59000
+#define CBB_SN_SCE_SLAVE	0x5A000
+#define CBB_SN_AXI2APB_1	0x70000
+#define CBB_SN_AXI2APB_10	0x71000
+#define CBB_SN_AXI2APB_11	0x72000
+#define CBB_SN_AXI2APB_12	0x73000
+#define CBB_SN_AXI2APB_13	0x74000
+#define CBB_SN_AXI2APB_14	0x75000
+#define CBB_SN_AXI2APB_15	0x76000
+#define CBB_SN_AXI2APB_16	0x77000
+#define CBB_SN_AXI2APB_17	0x78000
+#define CBB_SN_AXI2APB_18	0x79000
+#define CBB_SN_AXI2APB_19	0x7A000
+#define CBB_SN_AXI2APB_2	0x7B000
+#define CBB_SN_AXI2APB_20	0x7C000
+#define CBB_SN_AXI2APB_21	0x7D000
+#define CBB_SN_AXI2APB_22	0x7E000
+#define CBB_SN_AXI2APB_23	0x7F000
+#define CBB_SN_AXI2APB_25	0x80000
+#define CBB_SN_AXI2APB_26	0x81000
+#define CBB_SN_AXI2APB_27	0x82000
+#define CBB_SN_AXI2APB_28	0x83000
+#define CBB_SN_AXI2APB_29	0x84000
+#define CBB_SN_AXI2APB_30	0x85000
+#define CBB_SN_AXI2APB_31	0x86000
+#define CBB_SN_AXI2APB_32	0x87000
+#define CBB_SN_AXI2APB_33	0x88000
+#define CBB_SN_AXI2APB_34	0x89000
+#define CBB_SN_AXI2APB_35	0x92000
+#define CBB_SN_AXI2APB_4	0x8B000
+#define CBB_SN_AXI2APB_5	0x8C000
+#define CBB_SN_AXI2APB_6	0x8D000
+#define CBB_SN_AXI2APB_7	0x8E000
+#define CBB_SN_AXI2APB_8	0x8F000
+#define CBB_SN_AXI2APB_9	0x90000
+#define CBB_SN_AXI2APB_3	0x91000
+
+#define SLAVE_LOOKUP(sn) #sn, sn
+
+static struct tegra_sn_addr_map t234_aon_sn_lookup[] = {
+	{ SLAVE_LOOKUP(AON_SN_AXI2APB_1) },
+	{ SLAVE_LOOKUP(AON_SN_AST1_T) },
+	{ SLAVE_LOOKUP(AON_SN_CBB_T) },
+	{ SLAVE_LOOKUP(AON_SN_CPU_T) }
+};
+
+static struct tegra_sn_addr_map t234_bpmp_sn_lookup[] = {
+	{ SLAVE_LOOKUP(BPMP_SN_AXI2APB_1) },
+	{ SLAVE_LOOKUP(BPMP_SN_AST0_T) },
+	{ SLAVE_LOOKUP(BPMP_SN_AST1_T) },
+	{ SLAVE_LOOKUP(BPMP_SN_CBB_T) },
+	{ SLAVE_LOOKUP(BPMP_SN_CPU_T) },
+};
+
+static struct tegra_sn_addr_map t234_sce_sn_lookup[] = {
+	{ SLAVE_LOOKUP(SCE_SN_AXI2APB_1) },
+	{ SLAVE_LOOKUP(SCE_SN_AST0_T) },
+	{ SLAVE_LOOKUP(SCE_SN_AST1_T) },
+	{ SLAVE_LOOKUP(SCE_SN_CBB_T) },
+	{ SLAVE_LOOKUP(SCE_SN_CPU_T) }
+};
+
+static struct tegra_sn_addr_map t234_dce_sn_lookup[] = {
+	{ SLAVE_LOOKUP(DCE_SN_AXI2APB_1) },
+	{ SLAVE_LOOKUP(DCE_SN_AST0_T) },
+	{ SLAVE_LOOKUP(DCE_SN_AST1_T) },
+	{ SLAVE_LOOKUP(DCE_SN_CPU_T) }
+};
+
+static struct tegra_sn_addr_map t234_rce_sn_lookup[] = {
+	{ SLAVE_LOOKUP(RCE_SN_AXI2APB_1) },
+	{ SLAVE_LOOKUP(RCE_SN_AST0_T) },
+	{ SLAVE_LOOKUP(RCE_SN_AST1_T) },
+	{ SLAVE_LOOKUP(RCE_SN_CPU_T) }
+};
+
+static struct tegra_sn_addr_map t234_cbb_sn_lookup[] = {
+	{ SLAVE_LOOKUP(CBB_SN_AON_SLAVE) },
+	{ SLAVE_LOOKUP(CBB_SN_BPMP_SLAVE) },
+	{ SLAVE_LOOKUP(CBB_SN_CBB_CENTRAL) },
+	{ SLAVE_LOOKUP(CBB_SN_HOST1X) },
+	{ SLAVE_LOOKUP(CBB_SN_STM) },
+	{ SLAVE_LOOKUP(CBB_SN_FSI_SLAVE) },
+	{ SLAVE_LOOKUP(CBB_SN_PSC_SLAVE) },
+	{ SLAVE_LOOKUP(CBB_SN_PCIE_C1) },
+	{ SLAVE_LOOKUP(CBB_SN_PCIE_C2) },
+	{ SLAVE_LOOKUP(CBB_SN_PCIE_C3) },
+	{ SLAVE_LOOKUP(CBB_SN_PCIE_C0) },
+	{ SLAVE_LOOKUP(CBB_SN_PCIE_C4) },
+	{ SLAVE_LOOKUP(CBB_SN_GPU) },
+	{ SLAVE_LOOKUP(CBB_SN_SMMU0) },
+	{ SLAVE_LOOKUP(CBB_SN_SMMU1) },
+	{ SLAVE_LOOKUP(CBB_SN_SMMU2) },
+	{ SLAVE_LOOKUP(CBB_SN_SMMU3) },
+	{ SLAVE_LOOKUP(CBB_SN_SMMU4) },
+	{ SLAVE_LOOKUP(CBB_SN_PCIE_C10) },
+	{ SLAVE_LOOKUP(CBB_SN_PCIE_C7) },
+	{ SLAVE_LOOKUP(CBB_SN_PCIE_C8) },
+	{ SLAVE_LOOKUP(CBB_SN_PCIE_C9) },
+	{ SLAVE_LOOKUP(CBB_SN_PCIE_C5) },
+	{ SLAVE_LOOKUP(CBB_SN_PCIE_C6) },
+	{ SLAVE_LOOKUP(CBB_SN_DCE_SLAVE) },
+	{ SLAVE_LOOKUP(CBB_SN_RCE_SLAVE) },
+	{ SLAVE_LOOKUP(CBB_SN_SCE_SLAVE) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_1) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_10) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_11) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_12) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_13) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_14) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_15) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_16) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_17) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_18) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_19) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_2) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_20) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_21) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_22) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_23) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_25) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_26) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_27) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_28) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_29) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_30) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_31) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_32) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_33) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_34) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_35) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_4) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_5) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_6) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_7) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_8) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_9) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_3) }
+};
-- 
2.17.1

