Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B5A4D04AE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 17:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244346AbiCGQ4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 11:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244342AbiCGQ4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 11:56:35 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F3C7E0A9;
        Mon,  7 Mar 2022 08:55:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9+MMa0I5Qj6XAH73/x20PqaCsHqmcOWQHZxWCEZGTxvy38+99M2DR1bEbr1R6ivtcXeZy5/sOttO8or5DUbwy3ecAFDdWS57ezsMKYf0eu6RkyxXP8/dGdBRoseTTV5Qk/ZxILnbmcksUrqjc1viUyAv4y3v3i7PrF6HFnDsbMePu2/cQrcBcxzCWBOtPFX1DT1lpmULhYe27CC0ePa/0mvFipKFrXSWziI0H7TbERY74s2PA0fB50wy2c7lsp/4RHT6G03zBN4FcSVMo2queqN++5M5pG4BV4bPbYVaUZEyYd71k26J9GWv3keA+Kz3+fKnGH/ptcANEOrbP0urw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGR+oINxj6oi398hesBRwz4mYEXVWSpw8F/hFN7Gfd0=;
 b=kkUfOA5/YpJViSeMEPiD/HY78mJgpzdVZHJ/MlJfcaRikAdsT5o4+38HhyraiUbIedQ9VYcDu2esHj7c5IPdCylbRyWJHBr3zAP5xNxd3w4F2OR3YM9YSwxXt3jp241vVkK3U6puZuWWWBkSE8EYJCarDeTe17bNfbYOIruwketDZYJ300ngBHdqxM48QPGJNN/VZEjP7M0N7aTmNN4NXObgM3QwKj0jxxy8s1i3kDj6YBbYMgCn9wkukbVbCfF1G9Uq5Vt0QzwjTOV7nc79IJF1ZBNP+ocmi2R8FFsx8kSlzYKX27anZTt0vMYYdcUIO12Uf0Ajw9GoxRm9oJ9M9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGR+oINxj6oi398hesBRwz4mYEXVWSpw8F/hFN7Gfd0=;
 b=mRVE/WKvoWfyuJHRKkDgbHb1bvetMU49r/m56GhXeXqUS1bnE0Ugd57gEq12rv4EWQvrr/Exbw3+SrN7Ivp0KkvtsRaGXrK8ZZYj21j+Z4dFEctEg8y2Why1GyfRjIJZUxW9y5iVrqvY7/Yc5BHEZ/y9l3sqTUVSntkYvVxG3PQS/gmRvsjYdEd0LJGwJHFqtVER8zuFoEaAnflyXqQ5CBivOB7bkAkeSsfKVnb2JmKZoWvaxruLdu+m+jAfc1FmdJKO/kZx742648FqU+4QwzG1ZalNg+vV2cm7QvXvVvZjjI1of8M7zQf9iyYDpHD4xT2jnvfowr0iEo2t1dYrBw==
Received: from DM6PR06CA0099.namprd06.prod.outlook.com (2603:10b6:5:336::32)
 by CH0PR12MB5188.namprd12.prod.outlook.com (2603:10b6:610:bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Mon, 7 Mar
 2022 16:55:37 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::fa) by DM6PR06CA0099.outlook.office365.com
 (2603:10b6:5:336::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Mon, 7 Mar 2022 16:55:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 16:55:36 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 7 Mar
 2022 16:55:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Mon, 7 Mar 2022
 08:55:35 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Mon, 7 Mar 2022 08:55:31 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <broonie@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <ashishsingha@nvidia.com>
CC:     <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <p.zabel@pengutronix.de>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH v3 2/3] spi: tegra210-quad: combined sequence mode
Date:   Mon, 7 Mar 2022 22:25:18 +0530
Message-ID: <20220307165519.38380-3-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220307165519.38380-1-kyarlagadda@nvidia.com>
References: <20220307165519.38380-1-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4285ec3-a28e-4508-d7d6-08da005b4da7
X-MS-TrafficTypeDiagnostic: CH0PR12MB5188:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB51886ED1AD11AFE36F76AAF8C3089@CH0PR12MB5188.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GbIz1t63c5ic6dbofxGw7j94IBxy7cbEyNALjZHhphHr3HhCpIIVRJXMtEif9T0xVQUzWeGpBI5zc/qkTCuGhl/dhSlUVo3AkenM6Q43VpLfe0cWy1su6aA7UhiFx6jgEhYGl4CSppDW6dJMJfq2n5MOh1lBQ6Bpo4U/IlFRicwyu6cZ0uIs8Bbbo3Jr0O+OPfX3bXfBeTcE+5xvonVCGuI3wgFYzvjS7c7qw2lJezctlBBnRlVDIdoKOsOzA0MV7JjeTDo0yEXdLjJyUR9Tjr/8Rznhl5W2iDbkZ2mx9cBeSGLC3ztLfvxNuzT6B4WsYj6RLDAGyZlUX8UR+i//FzSeAMFRgY7TsfZ7H50yksIGgRO33YD6L3wfWd4z60BTVsL76wkndfzI+BBpuPksMQ1/vfm3Y0QBBdp3LVrWR1Z99+rDSA4i2SpoM4+81LhvsGFSAKwC4wmou8s/GvEX6Kdxt1g74OSRbsddAGyLDy3XCPXELGZ25Jh25g+sxKdxS0nsCOlHMV3mzVgK0AzQ9eVZITb4pwWcx3kgPdj1JeYR476kTgYirRCEAo6h/xB6GOMEAtypoImeKJw8nHxi2lqqCqH6W0aIcePGbzOxfOnp5KBBK/epxKj6uuVYWnp2hUDWn9SDbPq2A0NkvJAyDVa7vEtELjHRzdtaWDqBg6llXQin5xct3NXL2KlUhNiSR5GcE/TYgr6lGBDb9YmMEg==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(6666004)(2616005)(70586007)(8936002)(107886003)(4326008)(8676002)(2906002)(70206006)(5660300002)(508600001)(83380400001)(36756003)(86362001)(1076003)(26005)(316002)(186003)(7696005)(36860700001)(6636002)(110136005)(54906003)(81166007)(336012)(426003)(47076005)(40460700003)(356005)(82310400004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 16:55:36.9184
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4285ec3-a28e-4508-d7d6-08da005b4da7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5188
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add combined sequence mode supported by Tegra QSPI controller.
For commands which contain cmd, addr, data parts to it, controller
can accept all 3 transfers at once and avoid interrupt for each
transfer. This would improve read & write performance.

Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/spi/spi-tegra210-quad.c | 238 +++++++++++++++++++++++++++++++-
 1 file changed, 233 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 517a348d1c19..66f647f32876 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -121,14 +121,39 @@
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
@@ -912,7 +937,6 @@ static int tegra_qspi_setup(struct spi_device *spi)
 		cdata = tegra_qspi_parse_cdata_dt(spi);
 		spi->controller_data = cdata;
 	}
-
 	spin_lock_irqsave(&tqspi->lock, flags);
 
 	/* keep default cs state to inactive */
@@ -971,19 +995,179 @@ static void tegra_qspi_transfer_end(struct spi_device *spi)
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
+	struct spi_transfer *xfer;
+	struct spi_device *spi = msg->spi;
+	u8 transfer_phase = 0;
+	u32 cmd1 = 0, dma_ctl = 0;
+	int ret = 0;
+	u32 address_value = 0;
+	u32 cmd_config = 0, addr_config = 0;
+	u8 cmd_value = 0, val = 0;
+
+	/* Enable Combined sequence mode */
+	val = tegra_qspi_readl(tqspi, QSPI_GLOBAL_CONFIG);
+	val |= QSPI_CMB_SEQ_EN;
+	tegra_qspi_writel(tqspi, val, QSPI_GLOBAL_CONFIG);
+	/* Process individual transfer list */
+	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+		switch (transfer_phase) {
+		case CMD_TRANSFER:
+			/* X1 SDR mode */
+			cmd_config = tegra_qspi_cmd_config(false, 0,
+							   xfer->len);
+			cmd_value = *((const u8 *)(xfer->tx_buf));
+			break;
+		case ADDR_TRANSFER:
+			/* X1 SDR mode */
+			addr_config = tegra_qspi_addr_config(false, 0,
+							     xfer->len);
+			address_value = *((const u32 *)(xfer->tx_buf));
+			break;
+		case DATA_TRANSFER:
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
+				if (device_reset(tqspi->dev) < 0)
+					dev_warn_once(tqspi->dev,
+						      "device reset failed\n");
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
+			break;
+		default:
+			ret = -EINVAL;
+			goto exit;
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
-	int ret;
+	int ret = 0, val = 0;
 
 	msg->status = 0;
 	msg->actual_length = 0;
 	tqspi->tx_status = 0;
 	tqspi->rx_status = 0;
 
+	/* Disable Combined sequence mode */
+	val = tegra_qspi_readl(tqspi, QSPI_GLOBAL_CONFIG);
+	val &= ~QSPI_CMB_SEQ_EN;
+	tegra_qspi_writel(tqspi, val, QSPI_GLOBAL_CONFIG);
 	list_for_each_entry(transfer, &msg->transfers, transfer_list) {
 		struct spi_transfer *xfer = transfer;
 		u8 dummy_bytes = 0;
@@ -1021,7 +1205,6 @@ static int tegra_qspi_transfer_one_message(struct spi_master *master, struct spi
 			goto complete_xfer;
 		}
 
-		is_first_msg = false;
 		ret = wait_for_completion_timeout(&tqspi->xfer_completion,
 						  QSPI_DMA_TIMEOUT);
 		if (WARN_ON(ret == 0)) {
@@ -1066,7 +1249,48 @@ static int tegra_qspi_transfer_one_message(struct spi_master *master, struct spi
 	ret = 0;
 exit:
 	msg->status = ret;
+
+	return ret;
+}
+
+static bool tegra_qspi_validate_cmb_seq(struct tegra_qspi *tqspi,
+					struct spi_message *msg)
+{
+	int transfer_count = 0;
+	struct spi_transfer *xfer;
+
+	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+		transfer_count++;
+	}
+	if (!tqspi->soc_data->cmb_xfer_capable || transfer_count != 3)
+		return false;
+	xfer = list_first_entry(&msg->transfers, typeof(*xfer),
+				transfer_list);
+	if (xfer->len > 2)
+		return false;
+	xfer = list_next_entry(xfer, transfer_list);
+	if (xfer->len > 4 || xfer->len < 3)
+		return false;
+	xfer = list_next_entry(xfer, transfer_list);
+	if (!tqspi->soc_data->has_dma || xfer->len > (QSPI_FIFO_DEPTH << 2))
+		return false;
+
+	return true;
+}
+
+static int tegra_qspi_transfer_one_message(struct spi_master *master,
+					   struct spi_message *msg)
+{
+	struct tegra_qspi *tqspi = spi_master_get_devdata(master);
+	int ret;
+
+	if (tegra_qspi_validate_cmb_seq(tqspi, msg))
+		ret = tegra_qspi_combined_seq_xfer(tqspi, msg);
+	else
+		ret = tegra_qspi_non_combined_seq_xfer(tqspi, msg);
+
 	spi_finalize_current_message(master);
+
 	return ret;
 }
 
@@ -1200,14 +1424,17 @@ static irqreturn_t tegra_qspi_isr_thread(int irq, void *context_data)
 
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
@@ -1278,6 +1505,7 @@ static int tegra_qspi_probe(struct platform_device *pdev)
 	tqspi->dev = &pdev->dev;
 	spin_lock_init(&tqspi->lock);
 
+	tqspi->soc_data = device_get_match_data(&pdev->dev);
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	tqspi->base = devm_ioremap_resource(&pdev->dev, r);
 	if (IS_ERR(tqspi->base))
-- 
2.17.1

