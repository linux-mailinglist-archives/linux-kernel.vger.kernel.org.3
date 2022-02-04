Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9FE4A97D1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 11:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357529AbiBDKaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 05:30:17 -0500
Received: from mail-bn8nam11on2045.outbound.protection.outlook.com ([40.107.236.45]:49377
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1357542AbiBDKaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 05:30:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CfJ68Crd+ZafXksX3nyihzgZo5w/Iuo3i24dLL/b2zC/kiYf5XyFJJwCTzgxbj4lxRH0b/VxHRZm3JklstB5Ih3I+zAZJd5E0lYQQfB8EAC11//ILXFaOvF4q6jdgBwCvpabbfAu1raeOpQaKjR4rq8rOVVQWhRAXBnbirzMwKjxeoGpyooB2cQWqr39j/YuYUDav3Zoi+5BuI0a/B+iqAyzul5fbeDCfDttlECgjJm3TmKDS+lDvnPGeVSeJBw/MgdSE3noFD9tiUbF/lpHvm8OQEbHKbwakKvqrs0rg75rPGxzlRbdjxI0xz91Ji0lYjUUeZIyaCj1O2H98ufXXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LuKk3xQhUAkfjIcMlnA9pOqw9tDtdGWLi77f8njxZnA=;
 b=k/MII4igo1YKbdQrAe4m/NBF0amuGtHBxKDzoIKRCYnmGN3LHvNDePFozyYtDh/I/PaLqosL1bWp/DypKVo6aAihUODZ4JAptafnUcXZ+MbHqojmCdxHSLW2ZA41EsJmugkriTSVpYfxVk6eMOtefg5izrhLphqjR6uQoOfm1LU3fbruAe923rBm/r4OVehMo7mY0WY5TQ9g6iGdy0WvSUGtVkjwIjbZ0r3ALG3sKjRS/p8qEewH/8jCH9+2ksuW8kQPQSDaM9yH+VmJMqBtz721f3HCd8RanEpBenefSqeTRxaq9AH+5f0hGZOLVGcmVmMJH8DE5SzFCPR0fEvHKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuKk3xQhUAkfjIcMlnA9pOqw9tDtdGWLi77f8njxZnA=;
 b=dIte0HmCurboDxo5GhvbQeuIUTzYz10qIxPp7liGEZlP4wLGjdIUnPHeHW5YOT+dGYL5g/yDSkQR606dPP/Z1bIYP6tGWwURQ/GXWE8GTEKc9Yb8fR8E21l/mQmTHFVAsufyMoRRLmbCxdDtMwfVC7RER6BgZQ+Jn9papOVWahq0AM9hiHU3x7AxUPTShQEtqn+ns4pl5tTMkvHZixP21YZEybuPY31CXzQzJQctFIvchns39C2pbHiVZJDXcrEQEfM1pXmtTS1GRfTVt3BHOytWqY8OwZDWNBeoWpbePoO/bNryuUfsK1ZWXOPhNNS7tOEYTyUFPowRFnbV1kf5ig==
Received: from BN0PR04CA0145.namprd04.prod.outlook.com (2603:10b6:408:ed::30)
 by MN2PR12MB3743.namprd12.prod.outlook.com (2603:10b6:208:168::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Fri, 4 Feb
 2022 10:30:11 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::35) by BN0PR04CA0145.outlook.office365.com
 (2603:10b6:408:ed::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11 via Frontend
 Transport; Fri, 4 Feb 2022 10:30:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Fri, 4 Feb 2022 10:30:11 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 4 Feb
 2022 10:30:07 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Fri, 4 Feb 2022
 02:30:07 -0800
Received: from kyarlagadda-linux.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Fri, 4 Feb 2022 02:30:03 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <broonie@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
CC:     <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <p.zabel@pengutronix.de>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH 3/6] spi: tegra210-quad: add new chips to compatible
Date:   Fri, 4 Feb 2022 15:59:33 +0530
Message-ID: <1643970576-31503-4-git-send-email-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643970576-31503-1-git-send-email-kyarlagadda@nvidia.com>
References: <1643970576-31503-1-git-send-email-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbc69843-614c-49c8-2ee9-08d9e7c952d5
X-MS-TrafficTypeDiagnostic: MN2PR12MB3743:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3743D50731882CAB287F1F0BC3299@MN2PR12MB3743.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yg6wrAuvzj62svD3iUDSlfy8xzljxw6odmcux2oAFJvnEeDupfAxIZtOyx9fOKrIm6TKFSU4OaH/9gXwQQ3f0xWrMtbKdk+lw/a6JBYhnVZwvXnEW+RW6CBq91GfIr7c952lijrsen/onNsVn/WjKiDmBmc/C3zRSBG6TZRD1mw9Lyx+WcF/He05D2VfO+wOMmuRNLJaBLaZqoKacQxRbCkheHxcpVpHllfvebRPuj8Tjqf2eMupdK2RJeVC7W92nLMqzDdrZCksHUgfaSBC2ABFlcDyhuTve5yWzJHHgBhu999y3U6hisqOyIWj96MgTc8hF2z4w09j8Sf7GbRPM3SXN4M2z0A+qDok3GH3oN+ier64CVNgQtp2SY3ODj4yksb2Ydw4WHmQOLhvxmQRLRWWxQXOz/MtwD4dn+HvKp67S3kI2sVJ/r4mfp2/PVXyz8yvw78qeCMtsQkA/dhKjUgEfJdljXPu/5dpmOOPVkXOn+vMINlCiEhMyi7lp1oolY8JdXFVWNWS3R2JBVM8nLNM1fRYPHUSyPG7JNAQCt7JTdrhN6O4Hsmp+rMWeCuVyVsSukGqDQm+WqR0+QRJ3qsZB5fxB+23xwMBQwcEgN+c8EdSloQfKUZG/NNMVNDxtS76g1gmhNMet4B/0S0rmCbgh23MU1mrZCnKwZFurACv7TrctOfk1ZH6Cay/7yrlYrRZiHkKxwhrpRvF3cfaOA==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(110136005)(8676002)(8936002)(40460700003)(54906003)(4326008)(47076005)(70206006)(70586007)(82310400004)(316002)(36860700001)(2906002)(508600001)(86362001)(356005)(6666004)(81166007)(7696005)(83380400001)(5660300002)(186003)(336012)(426003)(26005)(2616005)(107886003)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 10:30:11.1906
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc69843-614c-49c8-2ee9-08d9e7c952d5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3743
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Tegra234 and soc data to select capabilities.

Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index ef93e40..2e5f20c 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -125,6 +125,10 @@
 #define QSPI_DMA_TIMEOUT			(msecs_to_jiffies(1000))
 #define DEFAULT_QSPI_DMA_BUF_LEN		(64 * 1024)
 
+struct tegra_qspi_soc_data {
+	bool has_dma;
+};
+
 struct tegra_qspi_client_data {
 	int tx_clk_tap_delay;
 	int rx_clk_tap_delay;
@@ -184,6 +188,7 @@ struct tegra_qspi {
 	u32					*tx_dma_buf;
 	dma_addr_t				tx_dma_phys;
 	struct dma_async_tx_descriptor		*tx_dma_desc;
+	const struct tegra_qspi_soc_data	*soc_data;
 };
 
 static inline u32 tegra_qspi_readl(struct tegra_qspi *tqspi, unsigned long offset)
@@ -1190,10 +1195,32 @@ static irqreturn_t tegra_qspi_isr_thread(int irq, void *context_data)
 	return handle_dma_based_xfer(tqspi);
 }
 
+static struct tegra_qspi_soc_data tegra210_qspi_soc_data = {
+	.has_dma = true,
+};
+
+static struct tegra_qspi_soc_data tegra186_qspi_soc_data = {
+	.has_dma = true,
+};
+
+static struct tegra_qspi_soc_data tegra234_qspi_soc_data = {
+	.has_dma = false,
+};
+
 static const struct of_device_id tegra_qspi_of_match[] = {
-	{ .compatible = "nvidia,tegra210-qspi", },
-	{ .compatible = "nvidia,tegra186-qspi", },
-	{ .compatible = "nvidia,tegra194-qspi", },
+	{
+		.compatible = "nvidia,tegra210-qspi",
+		.data	    = &tegra210_qspi_soc_data,
+	}, {
+		.compatible = "nvidia,tegra186-qspi",
+		.data	    = &tegra186_qspi_soc_data,
+	}, {
+		.compatible = "nvidia,tegra194-qspi",
+		.data	    = &tegra186_qspi_soc_data,
+	}, {
+		.compatible = "nvidia,tegra234-qspi",
+		.data	    = &tegra234_qspi_soc_data,
+	},
 	{}
 };
 
-- 
2.7.4

