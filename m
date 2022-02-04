Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593D94A97D2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 11:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347780AbiBDKaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 05:30:19 -0500
Received: from mail-sn1anam02on2056.outbound.protection.outlook.com ([40.107.96.56]:34145
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1357331AbiBDKaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 05:30:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJ2+iia4wSdy39gmdIkFtz3vCm8BzNoi/jeZO2YWq7eobGiTT7mXfvXa1eVLOIv4uLrikH8M7Q5Ak8aKnRCef9ijZS3KrLIvrBjRIyaksO5/Sp9NAdgU2Ipc6GyGHhgBmI9hyMuwkXRujyXq+Ge1n/Sgi8n0UHc972sEaX7pvoLVxNh4oELN2J7wBD/Pp7aJO0JKY1OyfveydZcMO04iwFyLVYxOeBYzHzlk53J14Lfnof8dJAvxckBhy5ZDjGA9NhAn/TKRpxMaNRzes8vIQ65eqvRnSkwAuq9FRC/z3LiTNYtBvzcdpQ30KK4UTa+NbQND7+l3NwttK8PkhDCbtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LTQonPq69Wos/4IT02D08IgAIBtysfhuEKobaoxMlus=;
 b=cXn027P2aRg2KL1DtNkELdejRbKsuRFoZ2DSExjLBrClHtYJ0So3PYSJfckjwxy465Zs3bTZAeAIGoWt8EIec4bxgfiWCZpOfZ3Re06vP0YAdgtoeBUtRz840bYKp3/gTQutwoDDx97+LCO0mwNnYrO0kWvEsWZe9d0JoCNVbddBWFP4vWKI7VDq0iBDw8jgn2GSJ30fNOGLbAMdDeYvEemv7tKY11ry8uOLj2yHl69GH5yZyAWXp97QvJ6AgpbeMFheoZL0vDFhsNv11dNVLkJtH+gWNtv8Bwouz2R/QDu8eRGBJiZnUuZIueyoLf+GhUXBNqOUDvGRKeID42ZB1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTQonPq69Wos/4IT02D08IgAIBtysfhuEKobaoxMlus=;
 b=OdvtfH04FyQVl1NxSit+ojWfVv5H9f1JvBZLRTDfzzGc5gYAGqtliudf/6gqvBMY1RBGmf5MhmKjXCQpZrHm3ZEpKivcwbRwEGF4U0HQd1Hn2xf3nccCZmhY8DPl8Nr1neTNHEYBSXwZspymPcS9TzwnpmHWos5espM0VDoJ3IyeyjKmpwEm2JmnBvNuoOFzr42Srh+Bk8QFiIP9PtRjIHnF7RiE5kFZH1qdbo2uE/KZvWKwv/Fvj8VCdV0mzigHh8p70Ssn0W9JRffEkJyu5LkKQgb9Ts+TXHRixnR3UkoRtCuA2iYtT+hT3SZbS8+wY+magtIJWHFrQRDQtNjfXQ==
Received: from DS7PR03CA0045.namprd03.prod.outlook.com (2603:10b6:5:3b5::20)
 by DM6PR12MB4942.namprd12.prod.outlook.com (2603:10b6:5:1be::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 10:30:14 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b5:cafe::8e) by DS7PR03CA0045.outlook.office365.com
 (2603:10b6:5:3b5::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Fri, 4 Feb 2022 10:30:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Fri, 4 Feb 2022 10:30:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 4 Feb
 2022 10:30:12 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Fri, 4 Feb 2022
 02:30:11 -0800
Received: from kyarlagadda-linux.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Fri, 4 Feb 2022 02:30:07 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <broonie@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
CC:     <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <p.zabel@pengutronix.de>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH 4/6] spi: tegra210-quad: add acpi support
Date:   Fri, 4 Feb 2022 15:59:34 +0530
Message-ID: <1643970576-31503-5-git-send-email-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643970576-31503-1-git-send-email-kyarlagadda@nvidia.com>
References: <1643970576-31503-1-git-send-email-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4cb23c87-6214-410b-5e64-08d9e7c95489
X-MS-TrafficTypeDiagnostic: DM6PR12MB4942:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB494285FFE542E5A511DFFB1EC3299@DM6PR12MB4942.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q7cDMx9zHPiCgOWqQOh4wWKuV7r75119GgrPOOYfT6O9lAsDnxZYlvE67keB0YVD1GJXED94qhic8XJIGTxiYTosJulj4iV2NmGEr1khY378BunVmSqfZVL9XghyWSLgqB+KFTCAzISw7g1v/iOmG9QnFTSZ9EdnWNlxOAZwBu5+ChKGWpciX+lntOtS/5JwjYSgwR8cdMNOUm0wwuPfc+ePv5OWJ21n4+puW4rMrJsugTrd0LPI3X1sdJJ0CIBp0Gp40w2u4juuuLWyl4BLykTsOIILg1HjgDEIVzN+HmDWRz5pBBCKlnb9CWWauQsHJInqzNNEu382kw35ljRTPA5WcRQPx6CUeCHUficb75YuOfQefRm0kiBfbGIMWwckT0xak+6WIKRb6fggwyJXf7UDqjAwgHvJ8zs8as7ohaLAxCWiCKRijKuwk2i0KBqSiRI1bVZnQCFvbpCqgpM23IAiNbZBAR3o2T25NQhy0xttru+dNP06yrqJ5rfcLEO//6tA7sSt9xFpz/3BV7ztI+1rylBsLQCRNScHpQ0SFpgD30NgbdceyWUkXJP4H3V/VtNvyUrAD0US4sXKTd3tYHsN+Akzhg9fwKjgsSyGNCIfIsbjL2F9niMKOUgQvuqJnlTPvdKMchUySZODTVnyyLubEC9rZWg/Xs+VYY5ZQCzaZ+2A998uXn02MQBGHvMptgmzC4twi1nXqpF71R6lAQ==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(81166007)(5660300002)(7696005)(83380400001)(107886003)(356005)(6666004)(336012)(426003)(26005)(36756003)(2616005)(186003)(47076005)(70206006)(70586007)(4326008)(82310400004)(40460700003)(54906003)(8936002)(8676002)(110136005)(2906002)(508600001)(86362001)(316002)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 10:30:14.0961
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb23c87-6214-410b-5e64-08d9e7c95489
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4942
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ACPI ID for Tegra QUAD SPI. Switch to common device property calls.
Skip clock calls that are not updated in ACPI boot.

Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 50 ++++++++++++++++++++++++++++++++---------
 1 file changed, 39 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 2e5f20c..c83701b 100644
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
 
@@ -1226,6 +1228,24 @@ static const struct of_device_id tegra_qspi_of_match[] = {
 
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
@@ -1266,11 +1286,14 @@ static int tegra_qspi_probe(struct platform_device *pdev)
 	qspi_irq = platform_get_irq(pdev, 0);
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
@@ -1373,6 +1396,8 @@ static int __maybe_unused tegra_qspi_runtime_suspend(struct device *dev)
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct tegra_qspi *tqspi = spi_master_get_devdata(master);
 
+	if (has_acpi_companion(tqspi->dev))
+		return 0;
 	/* flush all write which are in PPSB queue by reading back */
 	tegra_qspi_readl(tqspi, QSPI_COMMAND1);
 
@@ -1387,6 +1412,8 @@ static int __maybe_unused tegra_qspi_runtime_resume(struct device *dev)
 	struct tegra_qspi *tqspi = spi_master_get_devdata(master);
 	int ret;
 
+	if (has_acpi_companion(tqspi->dev))
+		return 0;
 	ret = clk_prepare_enable(tqspi->clk);
 	if (ret < 0)
 		dev_err(tqspi->dev, "failed to enable clock: %d\n", ret);
@@ -1404,6 +1431,7 @@ static struct platform_driver tegra_qspi_driver = {
 		.name		= "tegra-qspi",
 		.pm		= &tegra_qspi_pm_ops,
 		.of_match_table	= tegra_qspi_of_match,
+		.acpi_match_table = ACPI_PTR(tegra_qspi_acpi_match),
 	},
 	.probe =	tegra_qspi_probe,
 	.remove =	tegra_qspi_remove,
-- 
2.7.4

