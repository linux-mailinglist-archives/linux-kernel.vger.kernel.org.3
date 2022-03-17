Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27B94DBC37
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 02:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358245AbiCQBVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 21:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358225AbiCQBVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 21:21:46 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1E71DA70;
        Wed, 16 Mar 2022 18:20:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h8Lc9CyZlshbCctjFqfED7byqk1GfzwXf8YxPfr4YdWZf4GG8mMRBB6XdX40q2//pZVV4FniUKqThN6KSBylHOFxcKZ7Y5Yb+xJTxLQP+wvTytiKaGxVbHs+JEhk0o0dQuKh17V/TiA7igpGiwfBdCsQlTUNdJdrfJIP3gaL9v+xP2zTkirxNSUJEiMSAHpZ8djR6FXu9J3GuLb6wr9RxEYdVUEFwn/EQNLG1LMd4SY7VAqKBiw1V7M5tKtqWFTNcqdBfJJMnL0jXDwbzcV6m7eATf6tS+IzFEC5lhnQTFBAju72ICvecIRT2NDZhutVtgyTM7gh/sfiJ75wMbHwzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BF4d9U5XUF1bBhJvZOyajr0RrmHTE6TLgRa4mXsDF6M=;
 b=ld4VavqMPuQnXxm2ZaBUMLXJ7RbuIfE5EjhfWDV5nNFM1kMo1VDPRb1fxstdQ6KmiDNKY3s6bAepuvFYRii1Gyfr7QZi+Dzd0L4xTS7n8LeFd3KrA2FAAka5wqnS1ZqdyaK1aZRJX6C3aPVRa1L8Jt6eaQgqezZ9RrXv5XvLw6cvHDfJHJlKniUs5dWvOLTMm9RpKYYbmdx6koNAsrJv2o0VDRv3b2sTrnpy1zYPzPRu0+GHamUm5DzGp0OBXpeyzAtgsfGNiuluTyDIl988Wem42TBoYBPBucF/+K62C9aRlDJf4J9h2kfaDpvLUO7jPV1Y4JVPjMsKggWXX9CuMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BF4d9U5XUF1bBhJvZOyajr0RrmHTE6TLgRa4mXsDF6M=;
 b=ocCSXQnZYoFgB8hZiYlgKP2UqBYyxfxeSh7xuCfZEOgqUPTgp/mbf1dpxFnwdvuSl6NuQfX2W2th+qTY/6wFu+dCpfiCTPaS/Swn7h1uh2ingM12SvjVl+dL2ITr6hQBYnz9zPMq9NcKNdfLmc1KOH4sY4oGv35w2PM2hM1hFZ0hKMejTMpfigrkSa0zh6zB9Y+zik3h4usdyRP7JoL2vwkNBD8+ztXEnncoe5cTPofeG2gXRpGyRH53Qq6uTNeuRsuz2NmUux8AAKnrdMKVjzyeJnh9sEZxWopZZfvaTUa8bsYzpIBYoA8k3dGcqCySi1tQjtp8zTxSp5tUNYzyHw==
Received: from BN8PR15CA0003.namprd15.prod.outlook.com (2603:10b6:408:c0::16)
 by MN2PR12MB3408.namprd12.prod.outlook.com (2603:10b6:208:cd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Thu, 17 Mar
 2022 01:20:29 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::79) by BN8PR15CA0003.outlook.office365.com
 (2603:10b6:408:c0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17 via Frontend
 Transport; Thu, 17 Mar 2022 01:20:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5081.14 via Frontend Transport; Thu, 17 Mar 2022 01:20:28 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 17 Mar
 2022 01:20:20 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 16 Mar
 2022 18:20:19 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Wed, 16 Mar 2022 18:20:16 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <broonie@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <ashishsingha@nvidia.com>
CC:     <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Krishna Yarlagadda" <kyarlagadda@nvidia.com>
Subject: [PATCH 1/3] spi: tegra210-quad: Multi-cs support
Date:   Thu, 17 Mar 2022 06:50:04 +0530
Message-ID: <20220317012006.15080-2-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220317012006.15080-1-kyarlagadda@nvidia.com>
References: <20220317012006.15080-1-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0de5828-c533-464c-09c3-08da07b452cc
X-MS-TrafficTypeDiagnostic: MN2PR12MB3408:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB34085AB4673F0ABA66D1628CC3129@MN2PR12MB3408.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m8kr9MCPunSPhz0LQOPYC8MIYZhEQRtTRqRJ1+/084in8A4y6t+gFS66CPT9j+MMUtSvt/FNShwoz0q7vvQVOdN8a0Enmwi+k1FU11rewu+lHI7P+NtBS8QVdoznyH6ybhrBb04RLIm2OyIEBFpKUftCnPbqN04hug+CSyz9K0gdcGPZmoR+W3YLI2ED06PvMcaNO2Id6ZYGxYtCxcu4rnHQ2uwaASgKKWzrGYdVuPfduD2fLhunrM5e7zn27DGNYpK+3M9Gc1Kc+N53WJTV0vTMldJX86aXq61VgabSPO6yYF6n23ONKyQ1OmqWiwlbOm2Fehji/AO83m/ItryrwEXF/hrRDZiil3aTdJY+l4KPk3bPbLTNfYjpc25QNxlMUaC161HzGuKBItyJN7ZgY2xgQELvXbRYKM85qJ4ElmkW5g6T/K+T/i/6ai8f7EZAHumJlzVW98V5OYUSYh34Cv2HglYgjHcF27WSQXm1PrDhWe/UOzWa1XJG7iBxNwDC+xY5z1/1Mgycijs3lfBS6hr5qmW+9koTT5FT/SpbuDREQXzbA/ljYfgdXOB8mb4irVpX5p5TnG5hRj2+3xeiZdZh1MJgyVsMI/MySs03t9YNmUp2tzcFutEthTgo7I4tAbwgMsHT+MYNrvpfL5jH5uOUI0d3F0K0uNHGNm03ZWpTYSk9mVlLCxAEQDTfvbfFdfRNg4hGTDq24YDwn5VrEw==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(26005)(1076003)(336012)(186003)(426003)(70586007)(107886003)(70206006)(8676002)(4326008)(82310400004)(508600001)(2616005)(316002)(110136005)(6636002)(54906003)(86362001)(7696005)(6666004)(2906002)(81166007)(36756003)(356005)(40460700003)(8936002)(83380400001)(5660300002)(47076005)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 01:20:28.9239
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0de5828-c533-464c-09c3-08da07b452cc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3408
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 66f647f32876..a2e225e8f7f0 100644
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
+	bool cs_count;
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
+static struct tegra_qspi_soc_data tegra_grace_qspi_soc_data = {
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
+		.compatible = "nvidia,tegra-grace-qspi",
+		.data	    = &tegra_grace_qspi_soc_data,
 	},
 	{}
 };
@@ -1467,6 +1492,9 @@ static const struct acpi_device_id tegra_qspi_acpi_match[] = {
 	}, {
 		.id = "NVDA1413",
 		.driver_data = (kernel_ulong_t)&tegra234_qspi_soc_data,
+	}, {
+		.id = "NVDA1513",
+		.driver_data = (kernel_ulong_t)&th500_qspi_soc_data,
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

