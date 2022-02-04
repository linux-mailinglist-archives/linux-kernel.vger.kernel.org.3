Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5DEF4A97D6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 11:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357764AbiBDKa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 05:30:27 -0500
Received: from mail-bn8nam11on2063.outbound.protection.outlook.com ([40.107.236.63]:45515
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1357826AbiBDKaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 05:30:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0N9CS9NIJDYn5IZSm/g8lHmmpbXAHQp3YO+QdCr4bhuBYrBkVU+vosH9mmUdZJCEKFiAKKCMsN8FXNdd28PZZ+xRg5s9qMeFGEWxvKbCp4mILccnECZTps0LsW082kBjzbv/+DYjqY1dJ8+7lLFQaDbQFa3LMSTtUgo7LrI2KTE8HUrSq5AxUZxd8F2jYSQySnkPTSDEQsh6pWBB5zinLaMO5kvVcADIT172diIYU0f2Mq78/I71hYeIjPEP9IcF4DbBiHwOvhotqpGZg4LdMhAS0lN7koCl5AmpC6Y98/xprjewhZtuBt4/2HbJ6//rXOQCjD6jeQoxKCRk7Bg6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/p20RMc2I4+Itip+d3tq0XxSBl+EGN/YG0SyMbFSyg=;
 b=N7tVrRvuCVUHrZipvj7xO7gvov9P3kbiNRw/+HYD1gCg2GdQOVsPad7q9U/rISZN5s5ordchFia8J/xiE0eTizAgCNJQhPafevIw299hdBAzFxoolOTN26gWCezB0WJ2YGY50WjgK5pvTOMP1l7gde21F9KExp+6lLCQUHa58/Gw+uyHwvMGbMIfyd1ahc4702fOYJIZYQR8kanr8MkJNGj405JvrFJVqiVeTkvmoO5lHmDP+6VcQ7Dx9coLof3qVIMWJQTOGhmsZEnco8Lryt6wbhfTqlwqDTFr5Qb5PQCj6yaGkpiLAGcJJyU1wQxuDqDcPkPyiYArFHs3MxGD1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/p20RMc2I4+Itip+d3tq0XxSBl+EGN/YG0SyMbFSyg=;
 b=mobIK44NqXbk1ISrTXOa4eEKlD3hFugoMzmbUC61tJZNTRaa89dGeFqMHfJdLHgxlo+sI4LwYTjngVKg69YTBABwDS0LHO622Ew8yeYOPtlqbg51PctyLGN2+2qBTjYQYVrXFTeTiBo+3BzjaZcb9wLKSwzPPZ/RNTkfRUoPVQZpkHP2VesIvjG7PsrUIcejamlS+NSnwUHC/R9JSJEW9FRDmiLca2Xdb/65Y6Gttrb1CN8BUOJtqZd8veUKcT4BNhI/gYbvxApd8g8kuwKjUcjjOH8Q27iY8hPxFX8Wcx7syLT7jP9I3tFen3W8RWAdL48w/3geBPHsEfl9dZkkYw==
Received: from BN0PR04CA0138.namprd04.prod.outlook.com (2603:10b6:408:ed::23)
 by DM5PR12MB1706.namprd12.prod.outlook.com (2603:10b6:3:10f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Fri, 4 Feb
 2022 10:30:22 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::68) by BN0PR04CA0138.outlook.office365.com
 (2603:10b6:408:ed::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Fri, 4 Feb 2022 10:30:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Fri, 4 Feb 2022 10:30:21 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 4 Feb
 2022 10:30:20 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Fri, 4 Feb 2022
 02:30:19 -0800
Received: from kyarlagadda-linux.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Fri, 4 Feb 2022 02:30:16 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <broonie@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
CC:     <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <p.zabel@pengutronix.de>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH 6/6] spi: tegra210-quad: combined sequence mode
Date:   Fri, 4 Feb 2022 15:59:36 +0530
Message-ID: <1643970576-31503-7-git-send-email-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643970576-31503-1-git-send-email-kyarlagadda@nvidia.com>
References: <1643970576-31503-1-git-send-email-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4ef3691-e821-4a88-2324-08d9e7c958ed
X-MS-TrafficTypeDiagnostic: DM5PR12MB1706:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB17064F32DFD2B87BD579B726C3299@DM5PR12MB1706.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bGdlvUG9ZQpIEAfuKsodD/QsMbDVU2rhKesRzgm2LHhMCt3gZT0xJyDYaEt1BdNzHMG79Nxv01HctJHZtuscOIe4v/831pLODkr/Yt88b1D7hHjaK60ODDJx+rVu9I9rsspo8RHAy6P6JBJDrYth/lHPCdYVIqt5Qv1UBGWhTorZwZu5gnOkCsGg/byD28pBAkHH7glsUt+mHyWzyCCIc+47YLW6vmLeejP21Fr2HN9Liylvo2zF8VppDvLuehsjEaG4r5Zb0q0zoQ6mdoRBdYUezygMHcNQ9r+gk0Z9ibGREP3ZNDFhvNJtXASqA6WmoZCvV+8xbdu1cS8UpHdS9C6JWe5yaSY5v3cl6WG1LyAbjOEVUh9R66KS85QBNuBDv8OFfnfQ09d+MH1U8P7GZQNlaaygo13+QQUrtzHthJcsE7uTcRhR0iFfhxhIWQeG1Srvf/ql7TO2W77Vvm4Bkt8fSEimffiq9LjGNhAiZTUEQrSQnxr+lks4AcjYeYq4e2PrI3szCNQfmEYgM2nS5Tmxraqzgu8S/DNbqQUx8DU9Vj3QK83OpYO0AqyUbkdgWJpMRUbmRBYW5gwJjBA0H5fWnKf0pd8k2dsD1eNpmgA+1VPg5otVSL4coWa885/qF4p5ht34hiCF4PlsjGiUlYS4IDxy8ue1qms5JFXsTxGarpkyWFY0wTmgdIgdca5+HPXG/3KJfoGy4Kvukj/q9w==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(2906002)(36860700001)(110136005)(356005)(26005)(36756003)(47076005)(81166007)(5660300002)(82310400004)(186003)(40460700003)(83380400001)(70586007)(8936002)(70206006)(508600001)(4326008)(2616005)(336012)(54906003)(316002)(107886003)(86362001)(6666004)(7696005)(426003)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 10:30:21.4452
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ef3691-e821-4a88-2324-08d9e7c958ed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1706
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add combined sequence mode supported by Tegra QSPI controller.
For commands which contain cmd, addr, data parts to it,controller
can accept all 3 transfers at once and xfer avoiding interrupt for each
transfer. This would improve read & write performance.

Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 216 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 212 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index c83701b..1c6cec8 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -121,19 +121,45 @@
 #define QSPI_NUM_DUMMY_CYCLE(x)			(((x) & 0xff) << 0)
 #define QSPI_DUMMY_CYCLES_MAX			0xff
 
+#define QSPI_CMB_SEQ_CMD			0x19c
+#define QSPI_COMMAND_VALUE_SET(X)		(((x) & 0xFF) << 0)
+
+#define QSPI_CMB_SEQ_CMD_CFG			0x1a0
+#define QSPI_COMMAND_X1_X2_X4(x)		(((x) & 0x3) << 13)
+#define QSPI_COMMAND_X1_X2_X4_MASK		(0x03 << 13)
+#define QSPI_COMMAND_SDR_DDR			BIT(12)
+#define QSPI_COMMAND_SIZE_SET(x)		(((x) & 0xFF) << 0)
+
+#define QSPI_GLOBAL_CONFIG			0X1a4
+#define QSPI_CMB_SEQ_EN				BIT(0)
+
+#define QSPI_CMB_SEQ_ADDR			0x1a8
+#define QSPI_ADDRESS_VALUE_SET(X)		(((x) & 0xFFFF) << 0)
+
+#define QSPI_CMB_SEQ_ADDR_CFG			0x1ac
+#define QSPI_ADDRESS_X1_X2_X4(x)		(((x) & 0x3) << 13)
+#define QSPI_ADDRESS_X1_X2_X4_MASK		(0x03 << 13)
+#define QSPI_ADDRESS_SDR_DDR			BIT(12)
+#define QSPI_ADDRESS_SIZE_SET(x)		(((x) & 0xFF) << 0)
+
 #define DATA_DIR_TX				BIT(0)
 #define DATA_DIR_RX				BIT(1)
 
 #define QSPI_DMA_TIMEOUT			(msecs_to_jiffies(1000))
 #define DEFAULT_QSPI_DMA_BUF_LEN		(64 * 1024)
+#define CMD_TRANSFER				0
+#define ADDR_TRANSFER				1
+#define DATA_TRANSFER				2
 
 struct tegra_qspi_soc_data {
 	bool has_dma;
+	bool cmb_xfer_capable;
 };
 
 struct tegra_qspi_client_data {
 	int tx_clk_tap_delay;
 	int rx_clk_tap_delay;
+	bool is_cmb_xfer;
 };
 
 struct tegra_qspi {
@@ -880,6 +906,7 @@ static int tegra_qspi_start_transfer_one(struct spi_device *spi,
 
 static struct tegra_qspi_client_data *tegra_qspi_parse_cdata_dt(struct spi_device *spi)
 {
+	struct tegra_qspi *tqspi = spi_master_get_devdata(spi->master);
 	struct tegra_qspi_client_data *cdata;
 
 	cdata = devm_kzalloc(&spi->dev, sizeof(*cdata), GFP_KERNEL);
@@ -890,6 +917,12 @@ static struct tegra_qspi_client_data *tegra_qspi_parse_cdata_dt(struct spi_devic
 				 &cdata->tx_clk_tap_delay);
 	device_property_read_u32(&spi->dev, "nvidia,rx-clk-tap-delay",
 				 &cdata->rx_clk_tap_delay);
+	if (tqspi->soc_data->cmb_xfer_capable)
+		cdata->is_cmb_xfer = device_property_read_bool
+					(&spi->dev,
+					 "nvidia,cmb-xfer");
+	else
+		cdata->is_cmb_xfer = false;
 
 	return cdata;
 }
@@ -912,7 +945,6 @@ static int tegra_qspi_setup(struct spi_device *spi)
 		cdata = tegra_qspi_parse_cdata_dt(spi);
 		spi->controller_data = cdata;
 	}
-
 	spin_lock_irqsave(&tqspi->lock, flags);
 
 	/* keep default cs state to inactive */
@@ -970,9 +1002,160 @@ static void tegra_qspi_transfer_end(struct spi_device *spi)
 	tegra_qspi_writel(tqspi, tqspi->def_command1_reg, QSPI_COMMAND1);
 }
 
-static int tegra_qspi_transfer_one_message(struct spi_master *master, struct spi_message *msg)
+static u32 tegra_qspi_cmd_config(bool is_ddr, u8 bus_width, u8 len)
+{
+	u32 cmd_config = 0;
+
+	/* Extract Command configuration and value */
+	if (is_ddr)
+		cmd_config |= QSPI_COMMAND_SDR_DDR;
+	else
+		cmd_config &= ~QSPI_COMMAND_SDR_DDR;
+
+	cmd_config |= QSPI_COMMAND_X1_X2_X4(bus_width);
+	cmd_config |= QSPI_COMMAND_SIZE_SET((len * 8) - 1);
+
+	return cmd_config;
+}
+
+static u32 tegra_qspi_addr_config(bool is_ddr, u8 bus_width, u8 len)
+{
+	u32 addr_config = 0;
+
+	/* Extract Address configuration and value */
+	is_ddr = 0; //Only SDR mode supported
+	bus_width = 0; //X1 mode
+
+	if (is_ddr)
+		addr_config |= QSPI_ADDRESS_SDR_DDR;
+	else
+		addr_config &= ~QSPI_ADDRESS_SDR_DDR;
+
+	addr_config |= QSPI_ADDRESS_X1_X2_X4(bus_width);
+	addr_config |= QSPI_ADDRESS_SIZE_SET((len * 8) - 1);
+
+	return addr_config;
+}
+
+static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
+					struct spi_message *msg)
+{
+	bool is_first_msg = true;
+	int single_xfer;
+	struct spi_transfer *xfer;
+	struct spi_device *spi = msg->spi;
+	u8 transfer_phase = 0;
+	u32 cmd1 = 0, dma_ctl = 0;
+	int ret;
+	u32 address_value = 0;
+	u32 cmd_config = 0, addr_config = 0;
+	u8 cmd_value = 0, len = 0, val = 0;
+
+	/* Enable Combined sequence mode */
+	val = tegra_qspi_readl(tqspi, QSPI_GLOBAL_CONFIG);
+	val |= QSPI_CMB_SEQ_EN;
+	tegra_qspi_writel(tqspi, val, QSPI_GLOBAL_CONFIG);
+	single_xfer = list_is_singular(&msg->transfers);
+	/* Process individual transfer list */
+	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+		if (transfer_phase == CMD_TRANSFER) {
+			/* X1 SDR mode */
+			cmd_config = tegra_qspi_cmd_config(false, 0,
+							   xfer->len);
+			cmd_value = *((const u8 *)(xfer->tx_buf));
+
+		} else if (transfer_phase == ADDR_TRANSFER) {
+			len = xfer->len;
+			/* X1 SDR mode */
+			addr_config = tegra_qspi_addr_config(false, 0,
+							     xfer->len);
+			address_value = *((const u32 *)(xfer->tx_buf));
+		} else {
+			/* Program Command, Address value in register */
+			tegra_qspi_writel(tqspi, cmd_value, QSPI_CMB_SEQ_CMD);
+			tegra_qspi_writel(tqspi, address_value,
+					  QSPI_CMB_SEQ_ADDR);
+			/* Program Command and Address config in register */
+			tegra_qspi_writel(tqspi, cmd_config,
+					  QSPI_CMB_SEQ_CMD_CFG);
+			tegra_qspi_writel(tqspi, addr_config,
+					  QSPI_CMB_SEQ_ADDR_CFG);
+
+			reinit_completion(&tqspi->xfer_completion);
+			cmd1 = tegra_qspi_setup_transfer_one(spi, xfer,
+							     is_first_msg);
+			ret = tegra_qspi_start_transfer_one(spi, xfer,
+							    cmd1);
+
+			if (ret < 0) {
+				dev_err(tqspi->dev, "Failed to start transfer-one: %d\n",
+					ret);
+				return ret;
+			}
+
+			is_first_msg = false;
+			ret = wait_for_completion_timeout
+					(&tqspi->xfer_completion,
+					QSPI_DMA_TIMEOUT);
+
+			if (WARN_ON(ret == 0)) {
+				dev_err(tqspi->dev, "QSPI Transfer failed with timeout: %d\n",
+					ret);
+				if (tqspi->is_curr_dma_xfer &&
+				    (tqspi->cur_direction & DATA_DIR_TX))
+					dmaengine_terminate_all
+						(tqspi->tx_dma_chan);
+
+				if (tqspi->is_curr_dma_xfer &&
+				    (tqspi->cur_direction & DATA_DIR_RX))
+					dmaengine_terminate_all
+						(tqspi->rx_dma_chan);
+
+				/* Abort transfer by resetting pio/dma bit */
+				if (!tqspi->is_curr_dma_xfer) {
+					cmd1 = tegra_qspi_readl
+							(tqspi,
+							 QSPI_COMMAND1);
+					cmd1 &= ~QSPI_PIO;
+					tegra_qspi_writel
+							(tqspi, cmd1,
+							 QSPI_COMMAND1);
+				} else {
+					dma_ctl = tegra_qspi_readl
+							(tqspi,
+							 QSPI_DMA_CTL);
+					dma_ctl &= ~QSPI_DMA_EN;
+					tegra_qspi_writel(tqspi, dma_ctl,
+							  QSPI_DMA_CTL);
+				}
+
+				/* Reset controller if timeout happens */
+				device_reset(tqspi->dev);
+				ret = -EIO;
+				goto exit;
+			}
+
+			if (tqspi->tx_status ||  tqspi->rx_status) {
+				dev_err(tqspi->dev, "QSPI Transfer failed\n");
+				tqspi->tx_status = 0;
+				tqspi->rx_status = 0;
+				ret = -EIO;
+				goto exit;
+			}
+		}
+		msg->actual_length += xfer->len;
+		transfer_phase++;
+	}
+
+exit:
+	msg->status = ret;
+
+	return ret;
+}
+
+static int tegra_qspi_non_combined_seq_xfer(struct tegra_qspi *tqspi,
+					    struct spi_message *msg)
 {
-	struct tegra_qspi *tqspi = spi_master_get_devdata(master);
 	struct spi_device *spi = msg->spi;
 	struct spi_transfer *transfer;
 	bool is_first_msg = true;
@@ -1020,7 +1203,6 @@ static int tegra_qspi_transfer_one_message(struct spi_master *master, struct spi
 			goto complete_xfer;
 		}
 
-		is_first_msg = false;
 		ret = wait_for_completion_timeout(&tqspi->xfer_completion,
 						  QSPI_DMA_TIMEOUT);
 		if (WARN_ON(ret == 0)) {
@@ -1065,7 +1247,29 @@ static int tegra_qspi_transfer_one_message(struct spi_master *master, struct spi
 	ret = 0;
 exit:
 	msg->status = ret;
+
+	return ret;
+}
+
+static int tegra_qspi_transfer_one_message(struct spi_master *master,
+					   struct spi_message *msg)
+{
+	struct tegra_qspi *tqspi = spi_master_get_devdata(master);
+	struct tegra_qspi_client_data *cdata = msg->spi->controller_data;
+	int ret;
+	int transfer_count = 0;
+	struct spi_transfer *transfer;
+
+	list_for_each_entry(transfer, &msg->transfers, transfer_list) {
+		transfer_count++;
+	}
+	if (cdata->is_cmb_xfer && transfer_count == 3)
+		ret = tegra_qspi_combined_seq_xfer(tqspi, msg);
+	else
+		ret = tegra_qspi_non_combined_seq_xfer(tqspi, msg);
+
 	spi_finalize_current_message(master);
+
 	return ret;
 }
 
@@ -1199,14 +1403,17 @@ static irqreturn_t tegra_qspi_isr_thread(int irq, void *context_data)
 
 static struct tegra_qspi_soc_data tegra210_qspi_soc_data = {
 	.has_dma = true,
+	.cmb_xfer_capable = false,
 };
 
 static struct tegra_qspi_soc_data tegra186_qspi_soc_data = {
 	.has_dma = true,
+	.cmb_xfer_capable = true,
 };
 
 static struct tegra_qspi_soc_data tegra234_qspi_soc_data = {
 	.has_dma = false,
+	.cmb_xfer_capable = true,
 };
 
 static const struct of_device_id tegra_qspi_of_match[] = {
@@ -1277,6 +1484,7 @@ static int tegra_qspi_probe(struct platform_device *pdev)
 	tqspi->dev = &pdev->dev;
 	spin_lock_init(&tqspi->lock);
 
+	tqspi->soc_data = device_get_match_data(&pdev->dev);
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	tqspi->base = devm_ioremap_resource(&pdev->dev, r);
 	if (IS_ERR(tqspi->base))
-- 
2.7.4

