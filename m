Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E554C00A8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 18:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbiBVR5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 12:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234736AbiBVR5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 12:57:30 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B92A9F6C3;
        Tue, 22 Feb 2022 09:56:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KytI0/9Rs683f/hEekg/Z0Ty1FKHhAgjgFRLk5gCcE4flJdDVbdn/UVeSP8MmS1z2OL6oGcNvL5D+llnRFlbX+V/Y0Xefb5XBaZe1MPFoenRvQv0tIw8giBKhFc4zyHc6ihFHxlYzZ4JL13ruvuHY6eia/JvR3vgPBE5dzeziiOfObylyIYMT9Y1IqrTvhGzgKn03R/I0yNGrKFFTdFNP8/m3ucdbKPuGlRVvYTwcM/RBO02S93RmCTNUhtFsxUl0Ub66EtGfHcizpKojpK6UC8si/cR3z3Avs8ytuP+ve3awyEDDQQK6CrtlNn9OOHCWpw/dCS7yz3SP85IEXfvBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5EHKEqdP5q4t8Cd5lCGvMKQ94HAskGi74F6yvGyJDwU=;
 b=mXFMRUqeEoo0LNXUyFRhuB754vCEH0P606Liwn5a2QWhFZw2WbuSwLmFhLiDIXXhnV6tD1Bi+DsFRyeKesDGxE09FBNcYmR697ZBM4LWwg0mLeS1bKwd5Ksj4fo4WX8x34qLSQ9fHXvVo2zv4Z8dZrf6JGrv2lnePC5uQrFyWVTt36xQ0PBoz+VCFwH39gmyaZZiYZMGlIM3oQ/d86grVjI4DgjhqbzwXmFuzjD61ou9zkNeQpktaysSfaVw0q5djdvURBbql7uvmKw1Rip/K+O1r0c9R+/VFLuhtUNq2OcVdperl801/3OvyGrHhF33Qmvt1GXhK47yUSIY9ftGGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5EHKEqdP5q4t8Cd5lCGvMKQ94HAskGi74F6yvGyJDwU=;
 b=RVoxxJP2th8Jd5cwbZhJDE/zTuvEDIvuKVCls21+yhbFjwV7e86LTg0xpBxmO0Qu2H7zxzv9FFpbQ42ScxHgMgu35au3cCgrypCu0U3Hdx3B/XaWIku3wHWkK1LwfJ3dhSpBMBfkzXk9oMWE7g1ompMK2ml+EOBdoIPDI1r7J6Dupzzm1FvPP79Whubnn+QnIBPMFL/9yYTMXoiOVb/7rVYyGLdSdp2RKeTASkDD1hZwX5bacKqysqincz+DhHFR1ZAer4HoveFTWh0/4WTlleItf0LTgREfAkqSiFUSsGbXzm9VhUAKma+QynQvBHGoWKnmNANGoXrynK2aCGp3eQ==
Received: from DM5PR07CA0029.namprd07.prod.outlook.com (2603:10b6:3:16::15) by
 DM4PR12MB5184.namprd12.prod.outlook.com (2603:10b6:5:397::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.17; Tue, 22 Feb 2022 17:56:49 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:16:cafe::c5) by DM5PR07CA0029.outlook.office365.com
 (2603:10b6:3:16::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22 via Frontend
 Transport; Tue, 22 Feb 2022 17:56:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4995.15 via Frontend Transport; Tue, 22 Feb 2022 17:56:49 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 22 Feb
 2022 17:56:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 22 Feb 2022
 09:56:47 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Tue, 22 Feb 2022 09:56:44 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <broonie@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
CC:     <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <p.zabel@pengutronix.de>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH v2 5/5] spi: tegra210-quad: combined sequence mode
Date:   Tue, 22 Feb 2022 23:26:11 +0530
Message-ID: <20220222175611.58051-6-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220222175611.58051-1-kyarlagadda@nvidia.com>
References: <20220222175611.58051-1-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7bd266e-0712-4069-7d3d-08d9f62cb336
X-MS-TrafficTypeDiagnostic: DM4PR12MB5184:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB51845C4228720B681A5A4C7FC33B9@DM4PR12MB5184.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hLITtvyyHyapJGfLDLkcEBQ7hgRaQQlioyylUl733FdhEKQR40XFH5LjEbNdwze6ecMHNthUv6rz6HBskR2p9GOQ2DVF1vZEiE+TU1uGqXMcpgaW+UlwBR28hi3wwhQRkORIdkZvgGKPercR+bt7P1EIG35iC0vIUsnljzb3Cmgt+wEmU/O21OfrxYd7AbNjefUoRM7K1UMtnNQHbVKcxpvSdtRb79hY8dcA6vx9EvfFlGrPMOlhh4b/EBk9bVc5jLg0iPyIOQL0z4ZDoovof+jjIFN7rqess+skLLhTcUgGC8BO8jB4N21re/7OM3iEEkVrz+KTVtucEGQcraZgHgVZwVbU1+xFH5bBtL/3K7AdQEI3+z1anOWSoZPAYqKydeVNexCR31Qvs+geZbrSY3RJsHArT5qr5uR04Yhk29mwnKBIMvbSKimTmufebxFwCcMoiFvfuch3t2AfzuJkS9SQJ60QEoeeLgK0y7EpYekBNBBkCus7YkVYg3a1tL6BC/ryk4bTwqV4zuOTr/B7SJNd+58GBIvhuQgY5BaGkFwdB8c6+eVGdeHXwTY1KzmPdgzzixxpE/scB3VXjUOGOicXE1J6jbNW10G7irzGdtRi9frxXyVm1hPUWRTaoBRBudsZegwVRHHA1nV3BCnBZk2jHoiKE2KrMOCfVKkFSVzzurDqWJIWxjE65hqtayv5XgRwESnLHDYjjCbvPtyFSw==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(83380400001)(26005)(186003)(1076003)(47076005)(6666004)(356005)(2906002)(40460700003)(54906003)(110136005)(8936002)(81166007)(86362001)(107886003)(36756003)(82310400004)(316002)(36860700001)(508600001)(2616005)(5660300002)(7696005)(8676002)(426003)(4326008)(70206006)(70586007)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 17:56:49.3447
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7bd266e-0712-4069-7d3d-08d9f62cb336
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5184
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
---
 drivers/spi/spi-tegra210-quad.c | 231 +++++++++++++++++++++++++++++++-
 1 file changed, 227 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 0dbcb5fffc03..0899dca52c5a 100644
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
@@ -971,9 +995,164 @@ static void tegra_qspi_transfer_end(struct spi_device *spi)
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
+	int ret;
+	u32 address_value = 0;
+	u32 cmd_config = 0, addr_config = 0;
+	u8 cmd_value = 0, len = 0, val = 0;
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
+			len = xfer->len;
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
+		default:
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
@@ -1021,7 +1200,6 @@ static int tegra_qspi_transfer_one_message(struct spi_master *master, struct spi
 			goto complete_xfer;
 		}
 
-		is_first_msg = false;
 		ret = wait_for_completion_timeout(&tqspi->xfer_completion,
 						  QSPI_DMA_TIMEOUT);
 		if (WARN_ON(ret == 0)) {
@@ -1066,7 +1244,48 @@ static int tegra_qspi_transfer_one_message(struct spi_master *master, struct spi
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
 
@@ -1200,14 +1419,17 @@ static irqreturn_t tegra_qspi_isr_thread(int irq, void *context_data)
 
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
@@ -1278,6 +1500,7 @@ static int tegra_qspi_probe(struct platform_device *pdev)
 	tqspi->dev = &pdev->dev;
 	spin_lock_init(&tqspi->lock);
 
+	tqspi->soc_data = device_get_match_data(&pdev->dev);
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	tqspi->base = devm_ioremap_resource(&pdev->dev, r);
 	if (IS_ERR(tqspi->base))
-- 
2.17.1

