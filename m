Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A824DBC36
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 02:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358235AbiCQBVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 21:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357254AbiCQBVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 21:21:43 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2070.outbound.protection.outlook.com [40.107.101.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888781DA50;
        Wed, 16 Mar 2022 18:20:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qc+rHWUMcU6uQki/1OrSVXe3jV2sKy8l5PZ0wenh7mBm610TdUn0Ne3c4QgHl+KnwjbzoHWAtO+J/W2wrDZ0uQBOn6a3HutQi5zKE6vBsC/u+51US+miJC65Wgw6o9cRch7JmKBGZmiwB0aadcUzkZPMEBJrGdC5ZLST7vpPYMNA+CnDEdfnxBg3qF7fnAbeBOj4GlNOBHLJfhsxmW8lypXGyy3WSAyNN84JRqynWPi8yVgBzpwYecK0m1lCPk8l8J9YCi8pWZEzKbbCBl8hYb26d/M/4XoihAvM0vLs//+w8wQZtKwhn8+wMMG3qYIt0Aht2AHbybSfOcPcLy9pMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksx4i/z74I5ji5w5d1pK66cCe62mhmQ5aF6wgwthj6Y=;
 b=d7pT2SCPWIvd3cq2HG9KZ2DtZebYPtQGoWNR21H8IIkiaOhbmD2ypgov4VteX0X9CY4hreRMiDQjophz2Z35vgP18EBbzjPMaV7lRy5GPFT5HWiAIVTxt/a1sWJAABOKGfuvna4qNPJryRXkhX74pFKN7yREX5B2t/EIfXdD6YUhUAChdFyIm5vtvkECCxFXPTGZByA/B6G4dD1JX834WNhCTzp9HOfPcRTq8NFkbCkk375fwtpaAKIpqUskHJ6ofEHxMb8faYJCZQ93tM3bAZQKdYox+LfHqm0ThvZ/1wivSAazwCE9YAFf7cd6iUamJ7A0P7HXC+kd/QaLwtv0ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksx4i/z74I5ji5w5d1pK66cCe62mhmQ5aF6wgwthj6Y=;
 b=W2w39jmE/SCVLqYr2PbVM//p2OHmSFofNmTgnOqxKMWBnwt0MZESci0+kS1Q/6rqeIqDYBsVafLNicbAC+bK2R7npvm3icgQ7ac+4PMupezB3nWgSlp6rHPwzLSdExJY2xU2KRJxcuNzsziu5uGL1PQm7cGSQTl/Q0zn69uEkc+P4S5v5usAuuyz7mVuka5B4hQsheBh8WjYHazG+ul8W7A9cDtv3c6djFHlGTOqfXHJLRWuyxja2cBo5bLNT3D4Ilit+3vc5UQw6cJC2Mvzs/8CIu6sVMggvMpaGuCSTJ5IQghLyCXvUIXk8EW6YmbHPT8WLdsL4PL0r331Da/Oew==
Received: from DM5PR1101CA0019.namprd11.prod.outlook.com (2603:10b6:4:4c::29)
 by DM4PR12MB5054.namprd12.prod.outlook.com (2603:10b6:5:389::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Thu, 17 Mar
 2022 01:20:25 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4c:cafe::b2) by DM5PR1101CA0019.outlook.office365.com
 (2603:10b6:4:4c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.16 via Frontend
 Transport; Thu, 17 Mar 2022 01:20:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5081.14 via Frontend Transport; Thu, 17 Mar 2022 01:20:25 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 17 Mar
 2022 01:20:24 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 16 Mar
 2022 18:20:23 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Wed, 16 Mar 2022 18:20:20 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <broonie@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <ashishsingha@nvidia.com>
CC:     <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Krishna Yarlagadda" <kyarlagadda@nvidia.com>
Subject: [PATCH 2/3] spi: tegra210-quad: Add wait polling support
Date:   Thu, 17 Mar 2022 06:50:05 +0530
Message-ID: <20220317012006.15080-3-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220317012006.15080-1-kyarlagadda@nvidia.com>
References: <20220317012006.15080-1-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2c8c317-1c25-4bc2-2ab3-08da07b450de
X-MS-TrafficTypeDiagnostic: DM4PR12MB5054:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB50540E0432EAEFF67A0FDB39C3129@DM4PR12MB5054.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yRvmOfjNFeKtheclSmfnNNPZt+a05E1Nm/MUx1jRwz4QqarZZj2IX+QO/br3wdxEA1Memks7tPMlwtSEgF6JTKx2jISd8SXxKWiZTqLoDcJgB1Gq5I/DvpUjfVKM5Ykzs8rrfbnlqsLfCnSKam9UwZZ4Wsk+L/PjrGoBACfDpti8gxiiXkWJwrdQzqVE+NT6RjNo4xj3UZLWZB4P7TGFs5G/WYdwcRaIVDODCqKu5Sam9cfbPQ+ccx1XIJr6/pKcAbQCVuyOkGPXYGVvCt41bIBbulhdWDsUbp9wbc9Qfovb82T1cwPdhlva6TU8vJV8A6/wnB0U6MbwHOLrQDIDjCwNg7CWuru31yuFDaSEs1lROfbaaHpvY9uIdSr5KAN0OR6sNTHvdPfH0fQZWXQVs5/gKW5azsCYarTya/n2bvYoVNyQaQCJ4nn6mXvx0Qx4hUpk5yhn0nfFaPgkRTui/wbEdx1hk7aFvlupCgPgqrWuMBk3CnzLa5aher4osgWshVAbq1Cwnz35MePXORLOnkOGzDDX8y4iKTrYIPgkPeuGR838FRah9MF6arQD1SLWZIcgOc1F0Faqv6djs5Ma8R2LbLtug1kHQQOcKYMR+bh/daSSvlp7Z7ge6853m4d7lFX6Vq/GSBowAGj1TP5wdoNUkhBRnmxxov76S/xMX0FNXeIaGRQ2RoECwo4QOf81VHphBkFIXdZb8pwRvQ+Pug==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(2616005)(2906002)(36756003)(1076003)(107886003)(186003)(26005)(36860700001)(356005)(81166007)(426003)(336012)(47076005)(86362001)(8936002)(7696005)(70586007)(70206006)(40460700003)(316002)(82310400004)(110136005)(6636002)(54906003)(508600001)(8676002)(6666004)(4326008)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 01:20:25.7497
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2c8c317-1c25-4bc2-2ab3-08da07b450de
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5054
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Controller can poll for wait state inserted by TPM device and
handle it.

Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index a2e225e8f7f0..ecf171bfcdce 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -142,6 +142,7 @@
 
 #define QSPI_GLOBAL_CONFIG			0X1a4
 #define QSPI_CMB_SEQ_EN				BIT(0)
+#define QSPI_TPM_WAIT_POLL_EN			BIT(1)
 
 #define QSPI_CMB_SEQ_ADDR			0x1a8
 #define QSPI_ADDRESS_VALUE_SET(X)		(((x) & 0xFFFF) << 0)
@@ -165,11 +166,13 @@ struct tegra_qspi_soc_data {
 	bool has_dma;
 	bool cmb_xfer_capable;
 	bool cs_count;
+	bool has_wait_polling;
 };
 
 struct tegra_qspi_client_data {
 	int tx_clk_tap_delay;
 	int rx_clk_tap_delay;
+	bool wait_polling;
 };
 
 struct tegra_qspi {
@@ -833,6 +836,11 @@ static u32 tegra_qspi_setup_transfer_one(struct spi_device *spi, struct spi_tran
 		else
 			command1 |= QSPI_CONTROL_MODE_0;
 
+		if (tqspi->soc_data->cmb_xfer_capable)
+			command1 &= ~QSPI_CS_SW_HW;
+		else
+			command1 |= QSPI_CS_SW_HW;
+
 		if (spi->mode & SPI_CS_HIGH)
 			command1 |= QSPI_CS_SW_VAL;
 		else
@@ -917,6 +925,7 @@ static int tegra_qspi_start_transfer_one(struct spi_device *spi,
 
 static struct tegra_qspi_client_data *tegra_qspi_parse_cdata_dt(struct spi_device *spi)
 {
+	struct tegra_qspi *tqspi = spi_master_get_devdata(spi->master);
 	struct tegra_qspi_client_data *cdata;
 
 	cdata = devm_kzalloc(&spi->dev, sizeof(*cdata), GFP_KERNEL);
@@ -927,6 +936,11 @@ static struct tegra_qspi_client_data *tegra_qspi_parse_cdata_dt(struct spi_devic
 				 &cdata->tx_clk_tap_delay);
 	device_property_read_u32(&spi->dev, "nvidia,rx-clk-tap-delay",
 				 &cdata->rx_clk_tap_delay);
+	if (tqspi->soc_data->has_wait_polling)
+		cdata->wait_polling = device_property_read_bool
+					(&spi->dev,
+					 "nvidia,wait-polling");
+
 
 	return cdata;
 }
@@ -1049,6 +1063,7 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 	bool is_first_msg = true;
 	struct spi_transfer *xfer;
 	struct spi_device *spi = msg->spi;
+	struct tegra_qspi_client_data *cdata = spi->controller_data;
 	u8 transfer_phase = 0;
 	u32 cmd1 = 0, dma_ctl = 0;
 	int ret = 0;
@@ -1059,6 +1074,10 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 	/* Enable Combined sequence mode */
 	val = tegra_qspi_readl(tqspi, QSPI_GLOBAL_CONFIG);
 	val |= QSPI_CMB_SEQ_EN;
+	if (cdata->wait_polling)
+		val |= QSPI_TPM_WAIT_POLL_EN;
+	else
+		val &= ~QSPI_TPM_WAIT_POLL_EN;
 	tegra_qspi_writel(tqspi, val, QSPI_GLOBAL_CONFIG);
 	/* Process individual transfer list */
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
@@ -1158,6 +1177,8 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 		transfer_phase++;
 	}
 
+	ret = 0;
+
 exit:
 	msg->status = ret;
 
@@ -1180,6 +1201,7 @@ static int tegra_qspi_non_combined_seq_xfer(struct tegra_qspi *tqspi,
 	/* Disable Combined sequence mode */
 	val = tegra_qspi_readl(tqspi, QSPI_GLOBAL_CONFIG);
 	val &= ~QSPI_CMB_SEQ_EN;
+	val &= ~QSPI_TPM_WAIT_POLL_EN;
 	tegra_qspi_writel(tqspi, val, QSPI_GLOBAL_CONFIG);
 	list_for_each_entry(transfer, &msg->transfers, transfer_list) {
 		struct spi_transfer *xfer = transfer;
@@ -1439,24 +1461,28 @@ static struct tegra_qspi_soc_data tegra210_qspi_soc_data = {
 	.has_dma = true,
 	.cmb_xfer_capable = false,
 	.cs_count = 1,
+	.has_wait_polling = false,
 };
 
 static struct tegra_qspi_soc_data tegra186_qspi_soc_data = {
 	.has_dma = true,
 	.cmb_xfer_capable = true,
 	.cs_count = 1,
+	.has_wait_polling = false,
 };
 
 static struct tegra_qspi_soc_data tegra234_qspi_soc_data = {
 	.has_dma = false,
 	.cmb_xfer_capable = true,
 	.cs_count = 1,
+	.has_wait_polling = true,
 };
 
 static struct tegra_qspi_soc_data tegra_grace_qspi_soc_data = {
 	.has_dma = false,
 	.cmb_xfer_capable = true,
 	.cs_count = 4,
+	.has_wait_polling = true,
 };
 
 static const struct of_device_id tegra_qspi_of_match[] = {
@@ -1509,6 +1535,7 @@ static int tegra_qspi_probe(struct platform_device *pdev)
 	struct resource		*r;
 	int ret, qspi_irq;
 	int bus_num;
+	u8 val = 0;
 
 	master = devm_spi_alloc_master(&pdev->dev, sizeof(*tqspi));
 	if (!master)
@@ -1585,6 +1612,10 @@ static int tegra_qspi_probe(struct platform_device *pdev)
 	tqspi->spi_cs_timing1 = tegra_qspi_readl(tqspi, QSPI_CS_TIMING1);
 	tqspi->spi_cs_timing2 = tegra_qspi_readl(tqspi, QSPI_CS_TIMING2);
 	tqspi->def_command2_reg = tegra_qspi_readl(tqspi, QSPI_COMMAND2);
+	val = tegra_qspi_readl(tqspi, QSPI_GLOBAL_CONFIG);
+	val &= ~QSPI_CMB_SEQ_EN;
+	val &= ~QSPI_TPM_WAIT_POLL_EN;
+	tegra_qspi_writel(tqspi, val, QSPI_GLOBAL_CONFIG);
 
 	pm_runtime_put(&pdev->dev);
 
-- 
2.17.1

