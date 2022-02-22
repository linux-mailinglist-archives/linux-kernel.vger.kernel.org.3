Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149D54C00A3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 18:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234737AbiBVR53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 12:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234736AbiBVR50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 12:57:26 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43269F381;
        Tue, 22 Feb 2022 09:56:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPBijGUz3qzh97A5gE2B35hx28z5KZN35c8IZ6rqGXjLUh69vp7GlDgk/NLD0+vCEAlQp5NYEBjPob1N8YvRuuzxeL9Gw4arZaG2Hb1N/uwyDQa9C3uiPy+hF30MbTLFKQstjGXFkeraUP+IaVYfrq0wiVUDe/hYXAryeW4qmUxaR0LnSYSKE/XMSxSyufq5Q384GVNL2+0vV5NxYb+1khIxRydE6s3JqDcMY+dsYhZYWkQLzDEQjpTf7iwIC7xepOZlIlhd7lcaGPckm/EVqq+kWDAnSONIVuIk8flJRxdMbLpl+lCtmDh3dkXXNt+AynisrNrODGrVfjf82EfTOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VhCPh12QtjsbeGwk9VqrPRYkcoS2zEIEM+Daar7D0rE=;
 b=Lf60AOHRFGd12S/KLuzBfYNkPjZ6Fmwi5SW/jM1EdTvD5OE3P84k+NKwIwHVXRyHnr0mZVSu5hECTfU5cTe2XSi1F5pQaBZlIM0Diz8O6o4D5q+vDmB5E53xclAHHgIWAWalodbo/Ct4yk2g4Klg4alnYNcWyTHY4m77xI2mRU5AvWspqy0+9u8+BTi3YpsC68uWLf4UWYOm/HiOu8U6/7qYIhlE/4K/6DHlZ2Af1quAgvq73R+NdlSg3PGOhcupSNRnnR64FYuwYsoC0iGsy2mmBhrsnQki+0Py+sKmp3Jdjczq7vIqtlyeJ0lfHUBK9tWdMSf/FW+vssWnF/yGUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhCPh12QtjsbeGwk9VqrPRYkcoS2zEIEM+Daar7D0rE=;
 b=mOP+YLyjWS/hm2VikYo3WBQWHAx+kwBkl5qL5ufDljWpV14Ud6fhUMkqhHzAVlVKSDkWDe0rEvMvItjNo83pKTsq7ny2CXkg8y04jwkSjJHaBfOwObuYv3r6A+N/6XroNzj6/vx/SOu5tv30HvrNza0df0xOrkHeXyQWqhoq0Zn9c/GxVDpg78+3P9LMZHcf9XH4iWyjAv0ypj08thaFYQ9Uk5LNRoBPt4WTO5A232bsUWxFcmhaNXIgz1b4Vf/7eAg30nFgMEXQflb3jluVCcLwXOClRJH7+FDhcIKP/cbeEViwO1StPYPHsfO6twFrkG6AMbnIqqGsmDIQdKx3fA==
Received: from MWHPR01CA0030.prod.exchangelabs.com (2603:10b6:300:101::16) by
 DM6PR12MB3467.namprd12.prod.outlook.com (2603:10b6:5:3c::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.17; Tue, 22 Feb 2022 17:56:46 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:101:cafe::f7) by MWHPR01CA0030.outlook.office365.com
 (2603:10b6:300:101::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Tue, 22 Feb 2022 17:56:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4995.15 via Frontend Transport; Tue, 22 Feb 2022 17:56:45 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 22 Feb
 2022 17:56:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 22 Feb 2022
 09:56:43 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Tue, 22 Feb 2022 09:56:40 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <broonie@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
CC:     <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <p.zabel@pengutronix.de>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH v2 4/5] spi: tegra210-quad: add acpi support
Date:   Tue, 22 Feb 2022 23:26:10 +0530
Message-ID: <20220222175611.58051-5-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220222175611.58051-1-kyarlagadda@nvidia.com>
References: <20220222175611.58051-1-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccc1462b-3670-4116-f8e7-08d9f62cb100
X-MS-TrafficTypeDiagnostic: DM6PR12MB3467:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB34671513551A6F68597295BCC33B9@DM6PR12MB3467.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n8EY0LAVvaIpIDZSxV/qWCmGVTHjbDt/1upoigRuzVeD/LWBdQCn8vPT2L4j2kDPH46i7nd5Kq0cSxCc8N7emDMs1Ync+jcx0e1A2oVO9NlzdlrDmOZoZLhlwe9FAMnj7gf6Hu2v/NvbmnJdK3M5QfIfMCYuAxept+8wLIhYmuHn08ZBVrUXjzGbWk1gm/gk8orOwZPFp2CSr7ylEa5IQKNEZSTy4UPZ1bxm8E1qoPjvc0LQ9fJMZ35w4wY4bUWpxfHo5S3+xAGwGS4y+45huFIFuwYNmKgNxPayneDzUnP6cyC7uqqRWKpzSLR6gDotyhUA5KXnxRTTBBA32VabBWhx2MAokKqY/lvbb2SVfmaBFrZy92ZSq3YNR2J3BSiKDc73px9kMHoEJhp6M4XK+/v/bsr2FifQXF++6ROnfmRXsQHEenMmxYvN8CYcGqp7ulBhf4+TA3o0vVKoSoak6TA6c7trbm4Mwml2j54xUv5ZiBGny6uTNHj6Xfg65RmucuYHw3SwfHD3q11ohdFo5sSxsixdOUm4u8XN0BNU97GN9bQEh2TfRXWccr8qJfkr4q3bBzE7dhraqPuIiPdO2zfgeD1KfOoz9w4j9sSXWMxj4F338rBbFEelX6X6iR0hDyNoUpIsSulgzqR2sKFFnSA2Y+esYbRfnc+xX2USVnCKhLf/3rPvmEU7Aynb3XcCnbUwG/kUbyiQDlSy1Pc7dw==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(26005)(186003)(7696005)(8676002)(36860700001)(508600001)(2616005)(110136005)(70206006)(6666004)(82310400004)(107886003)(316002)(54906003)(70586007)(1076003)(86362001)(356005)(81166007)(426003)(83380400001)(4326008)(47076005)(2906002)(5660300002)(8936002)(336012)(36756003)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 17:56:45.7167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc1462b-3670-4116-f8e7-08d9f62cb100
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3467
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 50 +++++++++++++++++++++++++--------
 1 file changed, 39 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 3725ee5331ae..0dbcb5fffc03 100644
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
@@ -1377,6 +1400,8 @@ static int __maybe_unused tegra_qspi_runtime_suspend(struct device *dev)
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct tegra_qspi *tqspi = spi_master_get_devdata(master);
 
+	if (has_acpi_companion(tqspi->dev))
+		return 0;
 	/* flush all write which are in PPSB queue by reading back */
 	tegra_qspi_readl(tqspi, QSPI_COMMAND1);
 
@@ -1391,6 +1416,8 @@ static int __maybe_unused tegra_qspi_runtime_resume(struct device *dev)
 	struct tegra_qspi *tqspi = spi_master_get_devdata(master);
 	int ret;
 
+	if (has_acpi_companion(tqspi->dev))
+		return 0;
 	ret = clk_prepare_enable(tqspi->clk);
 	if (ret < 0)
 		dev_err(tqspi->dev, "failed to enable clock: %d\n", ret);
@@ -1408,6 +1435,7 @@ static struct platform_driver tegra_qspi_driver = {
 		.name		= "tegra-qspi",
 		.pm		= &tegra_qspi_pm_ops,
 		.of_match_table	= tegra_qspi_of_match,
+		.acpi_match_table = ACPI_PTR(tegra_qspi_acpi_match),
 	},
 	.probe =	tegra_qspi_probe,
 	.remove =	tegra_qspi_remove,
-- 
2.17.1

