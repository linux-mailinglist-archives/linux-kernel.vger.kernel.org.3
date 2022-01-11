Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48D9548B603
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 19:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346218AbiAKSqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 13:46:06 -0500
Received: from mail-mw2nam08on2045.outbound.protection.outlook.com ([40.107.101.45]:11691
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346159AbiAKSqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 13:46:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTaX2uql9+/Ass4p0tkhhqgi5QjpnhLsRllogzsd8ibdAqfFmzgfzCOA9NE9g9JnYUe/FjIENU0hlFkmGptRcCbZEuur1ei4vmw0jhvUf+fDpJknJ5UHlLX7Ekc3X6RtESv9JTTKrjU3f6xUWzQHKAiVjDxbo2QGVw2JdaKEDUkiGU6hz37EAQ1xaOwZXHDaZAYVMHqgnK56fVinXVhmoxhFJUQbaVR/e8Rt2xTuYiSZ/C/NrilrHnxEyGhSHMtoEzHhrhnpFWzaDLYZTU4O6eYl1+o3vaMlDptA5eG5MVAh3ss9dW9i5ZDOMybVMhjG6xnp/Sj9Sfkfz/hu9uYDqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBiHA3im8jTzhDAGMDtYFO2m+bw+5wull6p8c+CuuzM=;
 b=JMAP4yJ+uS38al+9pqOZV+yANuHBP+Px8AxhBOtBHm69D6sRS6+643t1NnxdJIz58ApVsZ3an14EaebuS6H47HzNwtxWtf4eg9Qvc6zV8RqjbuqOLlJJ4qfV7R8bDcEg54HrrehQqkUWrLb4XkDPEsUPbNvcOCosdCmAv+LaDG223scMrbhJYUIsoDBgQVti0kjAb6EQXVyTN5a5ahWg6vVIBf2xYltJwc/iV7lCSIoBzGiiGCeK244qIpwFkBZ8D59l8J+ctdcWJW5UkNTlvTC8KyUbXXbZ+q9JoneDBvSITiXZ+PfQAKSnR/Pmx4iBs9JjSIKcZ77QdpN+EJhHeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBiHA3im8jTzhDAGMDtYFO2m+bw+5wull6p8c+CuuzM=;
 b=c6sAWCiaAGes+OHDhZCG8m64EF9bn1jDKQTAdFq5WgQ5G6qWcwGyrUNqLwmtPor3ZYm/WphSJ8pvcpWM+mkIdhePHwbq95hy+0WbrZhBXr/9/rfUPfNSiyy2/avsEG2n64ZkEiwU6AT3klNLfEVA6x0zoOvWJQvUrtD53sYSTm1Cxt8NIz89AKCe6/np3Hx/nH1durZht0jondt89u9cyGB7OOhbQNjucNoHYWdlmM8R+pw0HXFvgAps/XzpRyxQvyWVtj5TNRHvx+cDyX+Zn98g1veevBUPnDmfw2DQbB17u6DLD1ruGXuFdSansz1KS13Qc5S5ZEaXnOzQR6adQA==
Received: from DM6PR11CA0055.namprd11.prod.outlook.com (2603:10b6:5:14c::32)
 by BN6PR12MB1876.namprd12.prod.outlook.com (2603:10b6:404:104::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Tue, 11 Jan
 2022 18:46:01 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::d7) by DM6PR11CA0055.outlook.office365.com
 (2603:10b6:5:14c::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Tue, 11 Jan 2022 18:46:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4867.9 via Frontend Transport; Tue, 11 Jan 2022 18:46:01 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 11 Jan
 2022 18:46:00 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 11 Jan
 2022 18:46:00 +0000
Received: from amhetre.nvidia.com (10.127.8.9) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Tue, 11 Jan 2022 18:45:57 +0000
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <amhetre@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <krzysztof.kozlowski@canonical.com>, <linux-kernel@vger.kernel.org>
CC:     <Snikam@nvidia.com>, <vdumpa@nvidia.com>
Subject: [Patch V1 1/4] memory: tegra: Add support for mc interrupts
Date:   Wed, 12 Jan 2022 00:15:47 +0530
Message-ID: <1641926750-27544-2-git-send-email-amhetre@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1641926750-27544-1-git-send-email-amhetre@nvidia.com>
References: <1641926750-27544-1-git-send-email-amhetre@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebb67651-cfae-4c01-813e-08d9d5329d77
X-MS-TrafficTypeDiagnostic: BN6PR12MB1876:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1876949F547DF5D193CC5D29CA519@BN6PR12MB1876.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:208;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +fdT9LroEk5Hjt5rou2yxrkQz/m199EH+troHgcGgCHwq/MXTV8o2cQRHDVdCE7F+oBP1LiNc13ln8PfVpGVQ/DjLqcJewS3tw1gZ30Jrsr/exCN3ENFIdIpecxt9w/6t8shvSG1QApoBgdsafA+xWhbis1ygeSrd1gLb39+4o5BI9cIRfrHGcJjI69xeAlkjW2P+1BGLLptOcvdX2C1RXlmw2ZIbMIh6pJyOi/YcmS9jNAHKe8on5wPrp7CbCJblVCKEoR5OMGyeX+jm65jc7sk2HPIZNGil1SaGHwMlisatNHMZm0T6MLOpl46RUuFRBRQzc4oa1jgjwaNC1w0xWIvRz0jzz+hhlD60cMzkEhxT53xcTWnF6JgeSMvIx0Dzzg8kjD/8JfFSgYSqqoipeX8+YShKS0cmUyDBCGFEU0k94EKB0UgPWAr6EY9lDaXO0PB/qn1mIcKfA0jGHmSFt2zd+VXfTLvBI9rQKWRiBpIVIHj80M8plz6VS15ZfzqoNPEejq7i0U2JjgWXYKc0h7zTx/LNbGsyqhHoULoQOp0KIE53/mfft/HfJuzK5kGTAodILkNya1ay+3vdfoHrWRbNEEq6+BSeCFEoHwfhE1SBVGRRzWrxTQnSagTByLLLKdFYGkAaloo+Pr56gDbgPrdbCHucXB0pMBTn394BnaLTfaNUJynD/LZoQ/tfU3BEepXnNahcfLHy7rAyLdoRUTnWwgj0IzkUpX7BXeF8x3/OuCCJjCCT5JNyOQC/MLmZTWFUc0xXsl/nysQ0vce9wAlUVff7NAQUKDVRRkrSMA=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700002)(7696005)(26005)(508600001)(336012)(186003)(107886003)(356005)(2616005)(83380400001)(6666004)(86362001)(47076005)(40460700001)(82310400004)(4326008)(36860700001)(316002)(8936002)(36756003)(110136005)(54906003)(81166007)(5660300002)(8676002)(70206006)(426003)(2906002)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 18:46:01.5165
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb67651-cfae-4c01-813e-08d9d5329d77
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1876
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement new structure for function related to mc interrupts.
Move handle_irq into this structure.
Add support for clearing interrupts.

Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 drivers/memory/tegra/mc.c       | 14 +++++++++++---
 drivers/memory/tegra/mc.h       |  1 +
 drivers/memory/tegra/tegra114.c |  1 +
 drivers/memory/tegra/tegra124.c |  2 ++
 drivers/memory/tegra/tegra186.c | 14 ++++++++++++++
 drivers/memory/tegra/tegra194.c | 12 ++++++++++++
 drivers/memory/tegra/tegra20.c  |  6 +++++-
 drivers/memory/tegra/tegra210.c |  1 +
 drivers/memory/tegra/tegra30.c  |  1 +
 include/soc/tegra/mc.h          |  7 ++++++-
 10 files changed, 54 insertions(+), 5 deletions(-)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index 3c5aae7..3b3f052 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -604,9 +604,12 @@ static irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+const struct tegra_mc_interrupt_ops tegra30_mc_interrupt_ops = {
+	.handle_irq = tegra30_mc_handle_irq,
+};
+
 const struct tegra_mc_ops tegra30_mc_ops = {
 	.probe = tegra30_mc_probe,
-	.handle_irq = tegra30_mc_handle_irq,
 };
 #endif
 
@@ -765,16 +768,21 @@ static int tegra_mc_probe(struct platform_device *pdev)
 			return err;
 	}
 
-	if (mc->soc->ops && mc->soc->ops->handle_irq) {
+	if (mc->soc->interrupt_ops && mc->soc->interrupt_ops->handle_irq) {
 		mc->irq = platform_get_irq(pdev, 0);
 		if (mc->irq < 0)
 			return mc->irq;
 
 		WARN(!mc->soc->client_id_mask, "missing client ID mask for this SoC\n");
 
+		/* clear any mc-errs that occurred before. */
+		if (mc->soc->interrupt_ops->clear_interrupt)
+			mc->soc->interrupt_ops->clear_interrupt(mc);
+
 		mc_writel(mc, mc->soc->intmask, MC_INTMASK);
 
-		err = devm_request_irq(&pdev->dev, mc->irq, mc->soc->ops->handle_irq, 0,
+		err = devm_request_irq(&pdev->dev, mc->irq,
+				       mc->soc->interrupt_ops->handle_irq, 0,
 				       dev_name(&pdev->dev), mc);
 		if (err < 0) {
 			dev_err(&pdev->dev, "failed to request IRQ#%u: %d\n", mc->irq,
diff --git a/drivers/memory/tegra/mc.h b/drivers/memory/tegra/mc.h
index 1e49298..f1fd457 100644
--- a/drivers/memory/tegra/mc.h
+++ b/drivers/memory/tegra/mc.h
@@ -144,6 +144,7 @@ extern const struct tegra_mc_soc tegra194_mc_soc;
     defined(CONFIG_ARCH_TEGRA_210_SOC)
 int tegra30_mc_probe(struct tegra_mc *mc);
 extern const struct tegra_mc_ops tegra30_mc_ops;
+extern const struct tegra_mc_interrupt_ops tegra30_mc_interrupt_ops;
 #endif
 
 #if defined(CONFIG_ARCH_TEGRA_186_SOC) || \
diff --git a/drivers/memory/tegra/tegra114.c b/drivers/memory/tegra/tegra114.c
index 4135057..f7b8dd9 100644
--- a/drivers/memory/tegra/tegra114.c
+++ b/drivers/memory/tegra/tegra114.c
@@ -1114,4 +1114,5 @@ const struct tegra_mc_soc tegra114_mc_soc = {
 	.resets = tegra114_mc_resets,
 	.num_resets = ARRAY_SIZE(tegra114_mc_resets),
 	.ops = &tegra30_mc_ops,
+	.interrupt_ops = &tegra30_mc_interrupt_ops,
 };
diff --git a/drivers/memory/tegra/tegra124.c b/drivers/memory/tegra/tegra124.c
index d780a84..8b704c1 100644
--- a/drivers/memory/tegra/tegra124.c
+++ b/drivers/memory/tegra/tegra124.c
@@ -1275,6 +1275,7 @@ const struct tegra_mc_soc tegra124_mc_soc = {
 	.num_resets = ARRAY_SIZE(tegra124_mc_resets),
 	.icc_ops = &tegra124_mc_icc_ops,
 	.ops = &tegra30_mc_ops,
+	.interrupt_ops = &tegra30_mc_interrupt_ops,
 };
 #endif /* CONFIG_ARCH_TEGRA_124_SOC */
 
@@ -1307,5 +1308,6 @@ const struct tegra_mc_soc tegra132_mc_soc = {
 	.num_resets = ARRAY_SIZE(tegra124_mc_resets),
 	.icc_ops = &tegra124_mc_icc_ops,
 	.ops = &tegra30_mc_ops,
+	.interrupt_ops = &tegra30_mc_interrupt_ops,
 };
 #endif /* CONFIG_ARCH_TEGRA_132_SOC */
diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
index e65eac5..b548b6a 100644
--- a/drivers/memory/tegra/tegra186.c
+++ b/drivers/memory/tegra/tegra186.c
@@ -12,6 +12,8 @@
 
 #include <soc/tegra/mc.h>
 
+#include "mc.h"
+
 #if defined(CONFIG_ARCH_TEGRA_186_SOC)
 #include <dt-bindings/memory/tegra186-mc.h>
 #endif
@@ -20,6 +22,8 @@
 #define MC_SID_STREAMID_SECURITY_WRITE_ACCESS_DISABLED BIT(16)
 #define MC_SID_STREAMID_SECURITY_OVERRIDE BIT(8)
 
+#define MC_INTSTATUS_CLEAR			0x00033340
+
 static void tegra186_mc_program_sid(struct tegra_mc *mc)
 {
 	unsigned int i;
@@ -137,6 +141,15 @@ static int tegra186_mc_probe_device(struct tegra_mc *mc, struct device *dev)
 	return 0;
 }
 
+static void tegra186_mc_clear_interrupt(struct tegra_mc *mc)
+{
+	mc_writel(mc, MC_INTSTATUS_CLEAR, MC_INTSTATUS);
+}
+
+const struct tegra_mc_interrupt_ops tegra186_mc_interrupt_ops = {
+	.clear_interrupt = tegra186_mc_clear_interrupt,
+};
+
 const struct tegra_mc_ops tegra186_mc_ops = {
 	.probe = tegra186_mc_probe,
 	.remove = tegra186_mc_remove,
@@ -874,5 +887,6 @@ const struct tegra_mc_soc tegra186_mc_soc = {
 	.clients = tegra186_mc_clients,
 	.num_address_bits = 40,
 	.ops = &tegra186_mc_ops,
+	.interrupt_ops = &tegra186_mc_interrupt_ops,
 };
 #endif
diff --git a/drivers/memory/tegra/tegra194.c b/drivers/memory/tegra/tegra194.c
index cab998b..19f135f 100644
--- a/drivers/memory/tegra/tegra194.c
+++ b/drivers/memory/tegra/tegra194.c
@@ -9,6 +9,17 @@
 
 #include "mc.h"
 
+#define MC_INTSTATUS_CLEAR			0x00133340
+
+static void tegra194_mc_clear_interrupt(struct tegra_mc *mc)
+{
+	mc_writel(mc, MC_INTSTATUS_CLEAR, MC_INTSTATUS);
+}
+
+const struct tegra_mc_interrupt_ops tegra194_mc_interrupt_ops = {
+	.clear_interrupt = tegra194_mc_clear_interrupt,
+};
+
 static const struct tegra_mc_client tegra194_mc_clients[] = {
 	{
 		.id = TEGRA194_MEMORY_CLIENT_PTCR,
@@ -1348,4 +1359,5 @@ const struct tegra_mc_soc tegra194_mc_soc = {
 	.clients = tegra194_mc_clients,
 	.num_address_bits = 40,
 	.ops = &tegra186_mc_ops,
+	.interrupt_ops = &tegra194_mc_interrupt_ops,
 };
diff --git a/drivers/memory/tegra/tegra20.c b/drivers/memory/tegra/tegra20.c
index fcd7738..3bcb2ca 100644
--- a/drivers/memory/tegra/tegra20.c
+++ b/drivers/memory/tegra/tegra20.c
@@ -786,11 +786,15 @@ static irqreturn_t tegra20_mc_handle_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static const struct tegra_mc_interrupt_ops tegra20_mc_interrupt_ops = {
+	.handle_irq = tegra20_mc_handle_irq,
+};
+
 static const struct tegra_mc_ops tegra20_mc_ops = {
 	.probe = tegra20_mc_probe,
 	.suspend = tegra20_mc_suspend,
 	.resume = tegra20_mc_resume,
-	.handle_irq = tegra20_mc_handle_irq,
+	.interrupt_ops = tegra20_mc_interrupt_ops,
 };
 
 const struct tegra_mc_soc tegra20_mc_soc = {
diff --git a/drivers/memory/tegra/tegra210.c b/drivers/memory/tegra/tegra210.c
index 8ab6498..d7ed163 100644
--- a/drivers/memory/tegra/tegra210.c
+++ b/drivers/memory/tegra/tegra210.c
@@ -1287,4 +1287,5 @@ const struct tegra_mc_soc tegra210_mc_soc = {
 	.resets = tegra210_mc_resets,
 	.num_resets = ARRAY_SIZE(tegra210_mc_resets),
 	.ops = &tegra30_mc_ops,
+	.interrupt_ops = &tegra30_mc_interrupt_ops,
 };
diff --git a/drivers/memory/tegra/tegra30.c b/drivers/memory/tegra/tegra30.c
index 8431635..bb5ff68 100644
--- a/drivers/memory/tegra/tegra30.c
+++ b/drivers/memory/tegra/tegra30.c
@@ -1400,4 +1400,5 @@ const struct tegra_mc_soc tegra30_mc_soc = {
 	.num_resets = ARRAY_SIZE(tegra30_mc_resets),
 	.icc_ops = &tegra30_mc_icc_ops,
 	.ops = &tegra30_mc_ops,
+	.interrupt_ops = &tegra30_mc_interrupt_ops,
 };
diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
index 1066b11..debc47b 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -170,6 +170,11 @@ struct tegra_mc_icc_ops {
 						void *data);
 };
 
+struct tegra_mc_interrupt_ops {
+	void (*clear_interrupt)(struct tegra_mc *mc);
+	irqreturn_t (*handle_irq)(int irq, void *data);
+};
+
 struct tegra_mc_ops {
 	/*
 	 * @probe: Callback to set up SoC-specific bits of the memory controller. This is called
@@ -179,7 +184,6 @@ struct tegra_mc_ops {
 	void (*remove)(struct tegra_mc *mc);
 	int (*suspend)(struct tegra_mc *mc);
 	int (*resume)(struct tegra_mc *mc);
-	irqreturn_t (*handle_irq)(int irq, void *data);
 	int (*probe_device)(struct tegra_mc *mc, struct device *dev);
 };
 
@@ -205,6 +209,7 @@ struct tegra_mc_soc {
 
 	const struct tegra_mc_icc_ops *icc_ops;
 	const struct tegra_mc_ops *ops;
+	const struct tegra_mc_interrupt_ops *interrupt_ops;
 };
 
 struct tegra_mc {
-- 
2.7.4

