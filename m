Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D295525CD9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 10:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378073AbiEMIJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378023AbiEMIIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:08:55 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBABD1C0F33;
        Fri, 13 May 2022 01:08:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOFMrX8DlNdLERECnktVT33bQfCyNj0O+F5vFbZkpPFwj5lUGsYkGm505/XAWkP+gbeF9nmeB4ruph/fHZF8rSO22jzhCZSQ+WMXW7QzRObxng0mB9qkFM8O/AjJS9HVKTW25HhJ9F/E4XwRpLxQeZRczSoEuqPiSJkBDu2vq70EyUwsTZyc3eaPXiMAOWRuBF+wiD9Ol5B049qPl9RK8x/1XdyWfF6piyncfnv4kAx52h5+WJNsbVBUs7IT7i2FWqui9BapKViTk4ex4aULkii76+ITkLkKeNZh4Dp7/rrx6TtM7DDiJbveakzwZ2wY8hNRw1uK5WC1wrsZX3eDzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXTvF4/l4s6vx+lH9WNjmD5knlHh4tPSJUy3kHPskl0=;
 b=fcyp9IXSImLGmnibftO0kCuT1skgfkP1940Csmsz777qVRuTO61aFfLAQDpFxHsvQlOadJf8wgQ8nR5xP7X9G3MN2KJOi4bpUQcEKEI38PpZr9gnqH5+BL7EZdW1t5I2xKLvwCN6MC0FRtOg44WUTScsbJy0h+jOzwJdB9er9GVVF3nYzULy2V/H9Jtx4FA7jDajgQgsfbkxZ3y73FWAa6OFJf2XESYt9rQb8pLWaiT7Fx7jpOiytVq0M9PpSEqjWYRsFMSHOsGXiCmIhSYjFD4elGB8ee7QDbPPu1svnB+Iyd2aY118T6dpQeiI2tczSyULrGZswSQIL+jXmd+LLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXTvF4/l4s6vx+lH9WNjmD5knlHh4tPSJUy3kHPskl0=;
 b=PmIXah66DYgON8y3lBv2gSgRoHn3BjlS3N0VBOUchBIGpFqfY1AHorxzBJZpUmhOY5Gh37MnDzhyMdF+uzYx8sdjO9FI13cFXLaENrLJm8K5fi4sqHWHXfiFytMBlC/7YPLc3mv5MVN6lpVGfDJRGX9qwVBz/QljE3eo3nCGo3Vi/pVxsDnA2RUBp7SlrFtw9sOeFg2USBuATi3srzcb4FObKJwz/pgyzoLQkbJHIFU4SP6X/+eMMaU5tQDgA+f4UK4jiIPUwaNNcDlb+E3T2Dl2jHwFGokMzyF25Rvn09f838LGUQBtTHJ8jpT9K8Kgb/u6IeNOPrDhXpM/xDaXsA==
Received: from BN9PR03CA0286.namprd03.prod.outlook.com (2603:10b6:408:f5::21)
 by BL1PR12MB5062.namprd12.prod.outlook.com (2603:10b6:208:313::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Fri, 13 May
 2022 08:08:52 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::a0) by BN9PR03CA0286.outlook.office365.com
 (2603:10b6:408:f5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.15 via Frontend
 Transport; Fri, 13 May 2022 08:08:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5250.13 via Frontend Transport; Fri, 13 May 2022 08:08:52 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Fri, 13 May
 2022 08:08:51 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 13 May
 2022 01:08:50 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Fri, 13 May 2022 01:08:47 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <broonie@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <ashishsingha@nvidia.com>,
        <robh+dt@kernel.org>
CC:     <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Krishna Yarlagadda" <kyarlagadda@nvidia.com>
Subject: [Patch V2 1/3] spi: tegra210-quad: Multi-cs support
Date:   Fri, 13 May 2022 13:38:26 +0530
Message-ID: <20220513080828.22079-2-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220513080828.22079-1-kyarlagadda@nvidia.com>
References: <20220513080828.22079-1-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25ae2a2a-1222-40b6-58b3-08da34b7d166
X-MS-TrafficTypeDiagnostic: BL1PR12MB5062:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5062CFCA8C4013855C33C56EC3CA9@BL1PR12MB5062.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f7Jhj5/CclB3O4BuZhHTa+A7eeXUBKpT8winC8ydpksffxwXHRthov32/57iFFHOTOm0vpfB/Z3qhZkIqi4emFdZiMdyOps32DROw0k7h/UuMX7773WXvpLLeJtLvCiwNFZzowVwCSdUgztO2eirWBk2XYKn5JSs5P01F2F9D97m+BLONHchMKgm8vw3ywDLmDGy09fL2N/7tPjUZ6vi07sZdSHhn+hN3lSJBJqH+rPyXURaU/8YY3AkUvljtHiG4MVmXarGuX3uH6dA+MRomf84Qe7X/9lPhOM71Jqu/pkBTen0YNfnronmCPLT3iyfQQ7720rLcLV1Gs/xgBJt38jmJqMKfDFDHb6jhW/3Fo4QZQz4zTmKhTDdesZ/FT2hgdodtEjAu76V9f/8yPxuNwhnlrxhsLMAsD3PnoRjkDA6GRfpjza3CC8BlLgPRVFt/e8BaoDA1diOAgv8OWhMjx39JUVznBFLEIfaty3RyGBGJKdNTmif2K1HOEI5ljh9XubvFRy5LdSePDlakTSYtntcKLZT/ePIT8GzhzyN6pM7iRuy1eaWXVEd0ZlAf961IGa3bM+GBhd3EHQOUy7wawZAn2RFi8BEIvUELj1cmlmAJTEq1l3S8EgKdtPH3SMj1r2Ra9FWUBzJB89DbuVTTZ459MESfdPxPsFWXsEjKOGlK0ucOkURts7e6jG+f1Gts7frIO2iU/4eUagc96qWig==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(356005)(81166007)(36860700001)(8676002)(426003)(47076005)(7696005)(2616005)(2906002)(336012)(6666004)(54906003)(83380400001)(36756003)(316002)(70206006)(110136005)(82310400005)(70586007)(508600001)(4326008)(8936002)(5660300002)(26005)(107886003)(40460700003)(186003)(1076003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 08:08:52.1432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ae2a2a-1222-40b6-58b3-08da34b7d166
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5062
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

