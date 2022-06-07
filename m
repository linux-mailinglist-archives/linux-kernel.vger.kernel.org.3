Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA83E53FDD3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 13:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243129AbiFGLrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 07:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243092AbiFGLrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 07:47:16 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154F1D71;
        Tue,  7 Jun 2022 04:47:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ndc7tJQ7xFuuaSb6PKSeWwiWQd7s5CI6xw90swwjYnVheEeUd96949SHnIQx4kl6QVJa3KlAl59s/tExkitLz6Hja4uiQG3y45Xwjf7wfjmSqQCS0MVILqSB/zc/s1GT6GTPDyI7R6yz4fYoQZG2PfxCbycTOx9E+8QV8JN5l8xtyXBQG6mdS9zVdTCVMIPG0ujmyJF4bQnjXjZoFJlKRSCk7YCZ3McwesG3ob71iFnb7/1Xwg0g/wth0gZz6E4GtWCLXHO5ShyzjfhtGF0GHQ6bYfbwc86u2CXmmp3s2JOV5T1dXC0yx+D96oKwPssBpmiEw75Rt4aYcgm0Ww5clw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXTvF4/l4s6vx+lH9WNjmD5knlHh4tPSJUy3kHPskl0=;
 b=arrDIzAVIWatIewgsJ74lS8535QvHtaW5uFClNVvSv4taSlTEbK3YTvA3a11FWZj06f2/nXUGiYcMUNzLFHoYSAu5fF/2VcEOb/Ez2RFOYutk36+iy3rvqF1xRb+0PtdcGmiZOvJ80FTVEjzasl7FYQIejn0EItFhzAgGE3JasKRe58embVl/Lp8qFQqi0kSWRsJJnvcy7a+wm1dZBDZOMmRv+sqXdQWjAMlZlJRl16OP755Z6n6bbZa2tC+2kxi68veefI+hY7JVVwXM9HN9opqaxKSrBpW7fidPaJ9Bs41cu6LS9q9CMuH7UWYhFFWpb2Rm41HQ4qlzQiQTUAksQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXTvF4/l4s6vx+lH9WNjmD5knlHh4tPSJUy3kHPskl0=;
 b=OFdeXa269mXbCbe7N+UgWPawy7opFvB8dfOypPyoMsY82Ll/n6bkrrCRFbysJBZIQY30wAxrVNJYnG6cXU74rc3uQRlbm3UNXkQfMmoaVdzxxxAiNmDEW72uGO0jYVxz69OR0V3rfMPxXW8Pgt1JteGkRO3GDGQxqHDAst48q6JCtb40pKvlfKYkZYgoWrrWzYifrBaaP03hwgarToVntFyGPQDFb0I6fl/OBC5D59jtrrdTThyR7UE22TixshJf+qUin4gS7453oPM2lK2TL5Nz1RTTC2UwvFB+0Q2l0ViDqyxeEL3+K5+xtH9yVrU7dhLUs/7k0btMC/+CtDihHA==
Received: from DM3PR03CA0015.namprd03.prod.outlook.com (2603:10b6:0:50::25) by
 MW3PR12MB4555.namprd12.prod.outlook.com (2603:10b6:303:59::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.13; Tue, 7 Jun 2022 11:47:12 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:50:cafe::db) by DM3PR03CA0015.outlook.office365.com
 (2603:10b6:0:50::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13 via Frontend
 Transport; Tue, 7 Jun 2022 11:47:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5314.12 via Frontend Transport; Tue, 7 Jun 2022 11:47:12 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 DRHQMAIL105.nvidia.com (10.27.9.14) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Tue, 7 Jun 2022 11:47:11 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 7 Jun 2022 04:47:10 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Tue, 7 Jun 2022 04:47:07 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <broonie@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <ashishsingha@nvidia.com>,
        <robh+dt@kernel.org>
CC:     <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Krishna Yarlagadda" <kyarlagadda@nvidia.com>
Subject: [Patch V3 1/3] spi: tegra210-quad: Multi-cs support
Date:   Tue, 7 Jun 2022 17:16:57 +0530
Message-ID: <20220607114659.54314-2-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220607114659.54314-1-kyarlagadda@nvidia.com>
References: <20220607114659.54314-1-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbdb6315-2af2-44e1-7083-08da487b75f3
X-MS-TrafficTypeDiagnostic: MW3PR12MB4555:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB45555DD27F4D9474144C988CC3A59@MW3PR12MB4555.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yUUsrRBoYuDrWsZwLJxjFXKaf5fgPLjKoHpQewJZoag7IZQwQZJAjtkKuiIn1/U3sAJEpLxwqYdPovZdzqDAFU+zH0Ymx3/soISLE1Zj2WNSdF/r7AVe36nurLpD74sRpFq/pjMibj90ZzRDj9MPFXer3sBI6OxwUHkXZwUcUfYfZ+uO26qq6aUiopSJ2Ji6zMM1E7rZLedoVxIQPVKZovJ1OWyFNf3C9bI5huDZ21ebaj0o2b7Y7OzKu7N3a5+0Ke2+o35s/KRTszqNk22tBC/5cl8t4uoCFtWepccuK2OSYws8w56CK6VY1zCtxicFvXcdbmxHYqcxMFURzktDLoX2fZ40QKKlZTa0BJtX477DmYrMsN/KGe7RH/pLOkhTmBgUzz2dlLV6H67Vi2pJ3FOrRrlcasfdIuq3V1/nYnJWWOGgIMaUbYzfo5VyTc6YffPor//wQFzO2dfMY/MXhGMy36nh9KCJnTYZ962UuYLoAfKZcWFwuvLP6krU6XYV7vs1C2TbN9a5Qu1C8l4PJLD6AMMjiqAfirTJ7F1mMDBggxSQksvF/QDyXr4D+bcBZVyhheWM8SFy8U5CzphXSZAFE+AJ/crmsawMQ4mP83Jxew6KKFgA4IRluqNhQYp+25JWfZH7cY/bJekWYVhQAsApYuOQ+5PDgx7/qQ3B+BsThjvIVPDbGQkupsp3QM+1nCwQnk5UyydeIhtIao3ejg==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(82310400005)(81166007)(36860700001)(86362001)(7696005)(356005)(8936002)(6666004)(2906002)(40460700003)(508600001)(83380400001)(5660300002)(1076003)(26005)(426003)(47076005)(2616005)(107886003)(70206006)(70586007)(316002)(110136005)(186003)(54906003)(8676002)(4326008)(336012)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 11:47:12.2162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbdb6315-2af2-44e1-7083-08da487b75f3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4555
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra Grace and later chips can support upto 4 chip select lines
for QUAD SPI. Added new compatible for Tegra Grace.

Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 66f647f32876..c89592b21ffc 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -37,6 +37,16 @@
 #define QSPI_RX_EN				BIT(12)
 #define QSPI_CS_SW_VAL				BIT(20)
 #define QSPI_CS_SW_HW				BIT(21)
+
+#define QSPI_CS_POL_INACTIVE(n)			(1 << (22 + (n)))
+#define QSPI_CS_POL_INACTIVE_MASK		(0xF << 22)
+#define QSPI_CS_SEL_0				(0 << 26)
+#define QSPI_CS_SEL_1				(1 << 26)
+#define QSPI_CS_SEL_2				(2 << 26)
+#define QSPI_CS_SEL_3				(3 << 26)
+#define QSPI_CS_SEL_MASK			(3 << 26)
+#define QSPI_CS_SEL(x)				(((x) & 0x3) << 26)
+
 #define QSPI_CONTROL_MODE_0			(0 << 28)
 #define QSPI_CONTROL_MODE_3			(3 << 28)
 #define QSPI_CONTROL_MODE_MASK			(3 << 28)
@@ -154,6 +164,7 @@
 struct tegra_qspi_soc_data {
 	bool has_dma;
 	bool cmb_xfer_capable;
+	unsigned int cs_count;
 };
 
 struct tegra_qspi_client_data {
@@ -812,6 +823,7 @@ static u32 tegra_qspi_setup_transfer_one(struct spi_device *spi, struct spi_tran
 		tegra_qspi_mask_clear_irq(tqspi);
 
 		command1 = tqspi->def_command1_reg;
+		command1 |= QSPI_CS_SEL(spi->chip_select);
 		command1 |= QSPI_BIT_LENGTH(bits_per_word - 1);
 
 		command1 &= ~QSPI_CONTROL_MODE_MASK;
@@ -941,10 +953,11 @@ static int tegra_qspi_setup(struct spi_device *spi)
 
 	/* keep default cs state to inactive */
 	val = tqspi->def_command1_reg;
+	val |= QSPI_CS_SEL(spi->chip_select);
 	if (spi->mode & SPI_CS_HIGH)
-		val &= ~QSPI_CS_SW_VAL;
+		val &= ~QSPI_CS_POL_INACTIVE(spi->chip_select);
 	else
-		val |= QSPI_CS_SW_VAL;
+		val |= QSPI_CS_POL_INACTIVE(spi->chip_select);
 
 	tqspi->def_command1_reg = val;
 	tegra_qspi_writel(tqspi, tqspi->def_command1_reg, QSPI_COMMAND1);
@@ -1425,16 +1438,25 @@ static irqreturn_t tegra_qspi_isr_thread(int irq, void *context_data)
 static struct tegra_qspi_soc_data tegra210_qspi_soc_data = {
 	.has_dma = true,
 	.cmb_xfer_capable = false,
+	.cs_count = 1,
 };
 
 static struct tegra_qspi_soc_data tegra186_qspi_soc_data = {
 	.has_dma = true,
 	.cmb_xfer_capable = true,
+	.cs_count = 1,
 };
 
 static struct tegra_qspi_soc_data tegra234_qspi_soc_data = {
 	.has_dma = false,
 	.cmb_xfer_capable = true,
+	.cs_count = 1,
+};
+
+static struct tegra_qspi_soc_data tegra241_qspi_soc_data = {
+	.has_dma = false,
+	.cmb_xfer_capable = true,
+	.cs_count = 4,
 };
 
 static const struct of_device_id tegra_qspi_of_match[] = {
@@ -1450,6 +1472,9 @@ static const struct of_device_id tegra_qspi_of_match[] = {
 	}, {
 		.compatible = "nvidia,tegra234-qspi",
 		.data	    = &tegra234_qspi_soc_data,
+	}, {
+		.compatible = "nvidia,tegra241-qspi",
+		.data	    = &tegra241_qspi_soc_data,
 	},
 	{}
 };
@@ -1467,6 +1492,9 @@ static const struct acpi_device_id tegra_qspi_acpi_match[] = {
 	}, {
 		.id = "NVDA1413",
 		.driver_data = (kernel_ulong_t)&tegra234_qspi_soc_data,
+	}, {
+		.id = "NVDA1513",
+		.driver_data = (kernel_ulong_t)&tegra241_qspi_soc_data,
 	},
 	{}
 };
@@ -1506,6 +1534,7 @@ static int tegra_qspi_probe(struct platform_device *pdev)
 	spin_lock_init(&tqspi->lock);
 
 	tqspi->soc_data = device_get_match_data(&pdev->dev);
+	master->num_chipselect = tqspi->soc_data->cs_count;
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	tqspi->base = devm_ioremap_resource(&pdev->dev, r);
 	if (IS_ERR(tqspi->base))
-- 
2.17.1

