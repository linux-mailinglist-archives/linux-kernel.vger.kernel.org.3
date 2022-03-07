Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29904D04A7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 17:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244337AbiCGQ4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 11:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244326AbiCGQ4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 11:56:30 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF5D7E097;
        Mon,  7 Mar 2022 08:55:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQTDkyS90uwqI48JGIBcpSOle2oTgII69t2FKNZjazSnw4/hLwBKmPKD/bG0fqJMKH45/8h1tzkLUJvALmZXG1FylTx/xD8ZPNaTfuB5+Vom2c9KsujSJv4crlfpVB6EO4Qk5xVfwm2LKFOmDtLs8AbnKlDOuDJYmLYP3Icjk+/8yspO56zLKO4Ct2RGJdwSk6MBW7iyEjn9zyz3tVYN9NLBbP9szhllRXRcRKmAnKVXJ3TkKR9z7VZCQkDjyLrJZqurQjxx44jv4nC/eB2RVX9C+uqEw7PUTRAYwtlMpK7mnRs0AlHFV2zusK2+03p4qXofr1AuJbqHcccs+K+vgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtb87rDk/KNU2TKKn8CwNyQpdAB+gESCW5J7pSxIluA=;
 b=jXCY+YUKwMiVbrN5bsvuRGGTHZLqUICMwnBe/57iMiCrDIs8Qp9ZweMGT05gU8ShI3Qe9jU1+Wz9r7XYb9CxcWnCCXodIieNNMmsgMZO5cfa9wGXHjry8C1KEcvR9+cooXpG3POsy15kDvTWEz6Pv55jyZB9ppaGGNb04NcjI32hca+BTfSP3ZupJhMqMCr0XcI3qvrjfuMTul1zazU4+bkBd9AR1bK8k10K9RubdakQGPWfukYUeNH/rE5aQ135r7gqpBAJ6Zz0Y16b08IHO0rwV/2gTtQeCHcZPLeauzpnMjD5DuJOen7A6uOIWvg2GhRa6EAWYeShxnIamBAY7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtb87rDk/KNU2TKKn8CwNyQpdAB+gESCW5J7pSxIluA=;
 b=CD78RXqD7X2HuhlsYs0dtXYTYq7aQZkj9YoQ2xsJL+NL+eUUcM0gFWARqvcn2UY5QhX9IoUwxHfwdm80HDzayzWCVYcAn+XzLleOai977g5F6sCgOZryHMerUIOaD4hzsEhTaQuQ9lH+j9sJyHBhfhzm31+8VMcXvAf1OoZSUt0J3crlYm7kywYubOX9/8/CttkYKC+OKTzJ/ocvN4zK+/i2f9ydRDATsNGumf90Q2tfANPXi8XF18568shUHHL6NsmdLJoN3S4sqaUoM8HyXq86Oo6oOmGLKLn6tAAvNvA6y3TkbLMgaD0GckdKj0lWCHykgIKOyRLmy0qv6R0PPQ==
Received: from MWHPR13CA0028.namprd13.prod.outlook.com (2603:10b6:300:95::14)
 by MWHPR12MB1360.namprd12.prod.outlook.com (2603:10b6:300:12::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Mon, 7 Mar
 2022 16:55:33 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:95:cafe::ff) by MWHPR13CA0028.outlook.office365.com
 (2603:10b6:300:95::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.3 via Frontend
 Transport; Mon, 7 Mar 2022 16:55:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 16:55:32 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 7 Mar
 2022 16:55:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Mon, 7 Mar 2022
 08:55:31 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Mon, 7 Mar 2022 08:55:27 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <broonie@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <ashishsingha@nvidia.com>
CC:     <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <p.zabel@pengutronix.de>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH v3 1/3] spi: tegra210-quad: add acpi support
Date:   Mon, 7 Mar 2022 22:25:17 +0530
Message-ID: <20220307165519.38380-2-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220307165519.38380-1-kyarlagadda@nvidia.com>
References: <20220307165519.38380-1-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da0df145-bce0-4cef-8f66-08da005b4b34
X-MS-TrafficTypeDiagnostic: MWHPR12MB1360:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1360FB00AFF99F6B37D3953EC3089@MWHPR12MB1360.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0n7UqRCWfFpJlKgB7WwKsA3xRbagfdZtZpciPrBe72CzB32zfpol+rX4CIIcEyx61tj+meK+axR2h8ouRW9ieVVPnB3NVgGI05zfRSIZYlkTNp8u4DlB20JfgBa3jhJtAysSv7F6MibTb+HOLUQj2EeAEwIefT297p+kLkPVgBQH02grNmYGw1VSo9liwEeY7H8lkA1KI40x1nqAYO9M8RF/bi0a+/HQ8L9k2ip9+6ZLoOWLfTSPmv6W+OAKemU6x6eHv+j1IEju9zTAMR6uf2xrmeeB2otizlBph5QsH5fprzXMpot4ii2tUu980+pqb/pPUpHKmLKoa9rotUi2UMNUzwEMwi87F723X1q4fpK9DCJD95QXplkqM2Z6wyqkljwrTg/AC/PM9GFbRiUViMDe2opuH10snWTUI3buTF8xAI+/+GGQuVFyT1FJuadGPtnCGRsElDAU4WrVi9kha5hrmMracYgqWSSm+glVDG9MQLdG16tMyx67k28lx1tRgQ+jimqeuBpNomhjYTCyCKF9PUcKNRiiWQpcIuwHXT3sKB8c+k9/NVQYHl973JD5SRZhFp5F9kOGDfvnBxf6k0s250EHcIIGCbF71NQoqhLYUw4/dxT2sG2bpB2zAiEi+K/3BVR1c/lKTDYPSnpACxlFczM5OeqWeVhE7DjTaEq/cP3f9VbcadcOIUVUgaWkadYmq6ci2Gc+lV77HYBvpA==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(8676002)(4326008)(70586007)(70206006)(508600001)(81166007)(1076003)(2616005)(54906003)(336012)(26005)(186003)(110136005)(316002)(6636002)(83380400001)(356005)(426003)(82310400004)(6666004)(7696005)(40460700003)(2906002)(86362001)(47076005)(8936002)(36756003)(107886003)(5660300002)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 16:55:32.8856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da0df145-bce0-4cef-8f66-08da005b4b34
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1360
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ACPI ID for Tegra QUAD SPI. Switch to common device property calls.
Skip clock calls that are not updated in ACPI boot.
Runtime PM support is not yet enabled with ACPI boot.

Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 52 ++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 3725ee5331ae..517a348d1c19 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -21,6 +21,8 @@
 #include <linux/of_device.h>
 #include <linux/reset.h>
 #include <linux/spi/spi.h>
+#include <linux/acpi.h>
+#include <linux/property.h>
 
 #define QSPI_COMMAND1				0x000
 #define QSPI_BIT_LENGTH(x)			(((x) & 0x1f) << 0)
@@ -771,7 +773,7 @@ static u32 tegra_qspi_setup_transfer_one(struct spi_device *spi, struct spi_tran
 	u32 tx_tap = 0, rx_tap = 0;
 	int req_mode;
 
-	if (speed != tqspi->cur_speed) {
+	if (!has_acpi_companion(tqspi->dev) && speed != tqspi->cur_speed) {
 		clk_set_rate(tqspi->clk, speed);
 		tqspi->cur_speed = speed;
 	}
@@ -879,16 +881,16 @@ static int tegra_qspi_start_transfer_one(struct spi_device *spi,
 static struct tegra_qspi_client_data *tegra_qspi_parse_cdata_dt(struct spi_device *spi)
 {
 	struct tegra_qspi_client_data *cdata;
-	struct device_node *slave_np = spi->dev.of_node;
 
 	cdata = devm_kzalloc(&spi->dev, sizeof(*cdata), GFP_KERNEL);
 	if (!cdata)
 		return NULL;
 
-	of_property_read_u32(slave_np, "nvidia,tx-clk-tap-delay",
-			     &cdata->tx_clk_tap_delay);
-	of_property_read_u32(slave_np, "nvidia,rx-clk-tap-delay",
-			     &cdata->rx_clk_tap_delay);
+	device_property_read_u32(&spi->dev, "nvidia,tx-clk-tap-delay",
+				 &cdata->tx_clk_tap_delay);
+	device_property_read_u32(&spi->dev, "nvidia,rx-clk-tap-delay",
+				 &cdata->rx_clk_tap_delay);
+
 	return cdata;
 }
 
@@ -1227,6 +1229,24 @@ static const struct of_device_id tegra_qspi_of_match[] = {
 
 MODULE_DEVICE_TABLE(of, tegra_qspi_of_match);
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id tegra_qspi_acpi_match[] = {
+	{
+		.id = "NVDA1213",
+		.driver_data = (kernel_ulong_t)&tegra210_qspi_soc_data,
+	}, {
+		.id = "NVDA1313",
+		.driver_data = (kernel_ulong_t)&tegra186_qspi_soc_data,
+	}, {
+		.id = "NVDA1413",
+		.driver_data = (kernel_ulong_t)&tegra234_qspi_soc_data,
+	},
+	{}
+};
+
+MODULE_DEVICE_TABLE(acpi, tegra_qspi_acpi_match);
+#endif
+
 static int tegra_qspi_probe(struct platform_device *pdev)
 {
 	struct spi_master	*master;
@@ -1269,11 +1289,14 @@ static int tegra_qspi_probe(struct platform_device *pdev)
 		return qspi_irq;
 	tqspi->irq = qspi_irq;
 
-	tqspi->clk = devm_clk_get(&pdev->dev, "qspi");
-	if (IS_ERR(tqspi->clk)) {
-		ret = PTR_ERR(tqspi->clk);
-		dev_err(&pdev->dev, "failed to get clock: %d\n", ret);
-		return ret;
+	if (!has_acpi_companion(tqspi->dev)) {
+		tqspi->clk = devm_clk_get(&pdev->dev, "qspi");
+		if (IS_ERR(tqspi->clk)) {
+			ret = PTR_ERR(tqspi->clk);
+			dev_err(&pdev->dev, "failed to get clock: %d\n", ret);
+			return ret;
+		}
+
 	}
 
 	tqspi->max_buf_size = QSPI_FIFO_DEPTH << 2;
@@ -1377,6 +1400,9 @@ static int __maybe_unused tegra_qspi_runtime_suspend(struct device *dev)
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct tegra_qspi *tqspi = spi_master_get_devdata(master);
 
+	/* Runtime pm disabled with ACPI */
+	if (has_acpi_companion(tqspi->dev))
+		return 0;
 	/* flush all write which are in PPSB queue by reading back */
 	tegra_qspi_readl(tqspi, QSPI_COMMAND1);
 
@@ -1391,6 +1417,9 @@ static int __maybe_unused tegra_qspi_runtime_resume(struct device *dev)
 	struct tegra_qspi *tqspi = spi_master_get_devdata(master);
 	int ret;
 
+	/* Runtime pm disabled with ACPI */
+	if (has_acpi_companion(tqspi->dev))
+		return 0;
 	ret = clk_prepare_enable(tqspi->clk);
 	if (ret < 0)
 		dev_err(tqspi->dev, "failed to enable clock: %d\n", ret);
@@ -1408,6 +1437,7 @@ static struct platform_driver tegra_qspi_driver = {
 		.name		= "tegra-qspi",
 		.pm		= &tegra_qspi_pm_ops,
 		.of_match_table	= tegra_qspi_of_match,
+		.acpi_match_table = ACPI_PTR(tegra_qspi_acpi_match),
 	},
 	.probe =	tegra_qspi_probe,
 	.remove =	tegra_qspi_remove,
-- 
2.17.1

