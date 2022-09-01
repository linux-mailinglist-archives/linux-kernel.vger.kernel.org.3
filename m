Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE715A8D8D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 07:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbiIAFsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 01:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbiIAFry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 01:47:54 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FC71166ED;
        Wed, 31 Aug 2022 22:47:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NwjtoaEzA2vjC8peA88sTF0frK911AgtuR2icnM8d3R45rRUJjlCZ6B7IDB4ZgHskE/HjZHu7jCHePkfyyjiwcjqvRKsmcdm7nGDxv7UYCVgvWnxYOm0nKcbSzagzOJb1NxnK9ynuV75xnYhH4zb1IguDUc9aiSMXEssw1y3Fhv8rg4QL/cONz8by3vP3l5epeDvztf0OXClSWYTVH5W1yI2LLRHmi1QHKOLgWvYHI05rHz0CNOP8gatibTr5jc8M1Hs4rcTyjWg94OiwBFf/ehStKUkbPu7RzdAVmAzy5VUXlhelPqVNSq/xrzyWZThwa1k4Cn8OSVhUwCcRjW2Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HnWf26i6HRrEYTwVMWYEY+hsZPGTiFfXu/6snWcPqY8=;
 b=eJDkF7ckft4PapW6KwVL1pPGKo75a+fME0n/VLizF2yVpg/zRrPa8GEULfVa0cHJ9zOx3VDDzqISpdxRX9HTwa30WUzoyFo18ohKJbYB/7HsR4fE90kRcFQZY+u77l1vOI073isDrsywpaYM3/meMRSdHbMG/EHf+PkP5uN4hnyuxWyCcyTFVE/sOe32dnC39S3CXOxQRr/7UusH/PKo5GWVGmymd1zV3j7lGNTeI4gFTX4qODowKIBCjSlbco8mVhN15sqFBhPk17kjo/+fbqknBUGuZzzJOBkHP1cNnTqPb6XWmVZeJMPDzP7eNhb27tvRz6Wgqsl3+LqO3Lipkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnWf26i6HRrEYTwVMWYEY+hsZPGTiFfXu/6snWcPqY8=;
 b=LezBr6f5gqDccN6uCAjj+o2I/u4LiCT6vV67NNHAGbZdo+yauilz1AlnU/c6Xs8unNzk6A9c1kSbNWaC43TAadOkJezYLSiev1Ps2PaQc4z/uGGaKzfX7lc3E8umAZ/aO4t1D74fifOhs6dgiFiM9NuoryR0ZyLlbqXh7bioB0w=
Received: from DS7PR03CA0145.namprd03.prod.outlook.com (2603:10b6:5:3b4::30)
 by CY4PR02MB2503.namprd02.prod.outlook.com (2603:10b6:903:73::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 05:47:48 +0000
Received: from DM3NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::94) by DS7PR03CA0145.outlook.office365.com
 (2603:10b6:5:3b4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11 via Frontend
 Transport; Thu, 1 Sep 2022 05:47:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT062.mail.protection.outlook.com (10.13.5.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Thu, 1 Sep 2022 05:47:48 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 31 Aug 2022 22:47:46 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2507.6 via Frontend Transport; Wed, 31 Aug 2022 22:47:46 -0700
Envelope-to: broonie@kernel.org,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 git@amd.com,
 michal.simek@amd.com,
 linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 akumarma@amd.com
Received: from [10.140.6.18] (port=60724 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1oTd3J-000Eqz-KZ; Wed, 31 Aug 2022 22:47:46 -0700
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <git@amd.com>, <michal.simek@amd.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <akumarma@amd.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Subject: [PATCH 3/7] spi: spi-zynqmp-gqspi: Avoid setting baud rate multiple times for same SPI frequency
Date:   Thu, 1 Sep 2022 11:17:27 +0530
Message-ID: <20220901054731.7705-4-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220901054731.7705-1-amit.kumar-mahapatra@xilinx.com>
References: <20220901054731.7705-1-amit.kumar-mahapatra@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 790e3c20-f182-4782-5570-08da8bdd8060
X-MS-TrafficTypeDiagnostic: CY4PR02MB2503:EE_
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: US4uZ1+kQcw4eTIXxzoBwuU+HZfcY8Iv9CMFEY7bUyqJhcibpzd8TBnEj8sZKxmXE6tIISJLuwJkuNwVgoVyxh0OFyLan0Io04NR7lt75XPr08W4IxXYv4AYbTpJ6hfK1EYT+1sjRX5diGdLn+JmWqyEYJ8fNKFclJ/zA/o0PTMuik9+8t+y0Sqk0ExYJXjnYZCpoge/bJDh6TiPN1k0/OyPzbaUu7TEgyK9m2Djusn6u2xLdt9CFGRuDvlsA7XI4mKUBcZ0l3U6EzgOOiimi1cGGuRSmguAbGy/Gapr7tEfWR5jnQH6feM7+GgkyTJpRYj29OpfbR+uQ5QI1+rYL4tromG5TEiuGEK2NQ7MgaPYmhj61utbC4xzN8gw8KgOKCP7MDXnyFrl4jOYdrlTY3A6W0var2MzDTE0d6N6+u8SR+df+jEA3Ueug1UFTtgXPs9xx9v7+NvKKQYLHmwzHZj8l02mLhgrBH99hyJu+HEILPzBefVhDeanBmSOu4bvw9wXyLUzAlbDWlmH76elh87ljiNS93SBR5g/Z6F3D9MYK2t/p/jX1AQu1YI9UU5sn0l6IS+rWTtc4yP8U5ryZItLHOQpW/Cm27hJ268OGvnqvFzOSHfOCVyqreA5iIciSkXp//6IGPFt15O6UY18XLJpwMheUUo9uLMqzEwUhRbQDteBxlu6m0Xrte0XkQYpIoDs2c/okakqjh9mR15Rgo5ypHgFVLZ+bG8mSaK82iMgoEEX+nPk8upJrq6HeBAY4HK5FlJQPRSkt/C7ANlrTR/0VPD2hAdL/yVv/IR1WAo=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(346002)(39860400002)(136003)(40470700004)(46966006)(36840700001)(110136005)(82310400005)(36756003)(82740400003)(2616005)(336012)(426003)(41300700001)(83380400001)(36860700001)(186003)(107886003)(7696005)(47076005)(1076003)(26005)(6666004)(54906003)(40480700001)(478600001)(4326008)(316002)(70206006)(70586007)(9786002)(40460700003)(356005)(7636003)(8676002)(7416002)(5660300002)(2906002)(8936002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 05:47:48.3083
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 790e3c20-f182-4782-5570-08da8bdd8060
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT062.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2503
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During every transfer the GQSPI driver configures the baud rate value. But
when there is no change in the SPI clock frequency the driver should avoid
rewriting the same baud rate value to the configuration register. With this
patch the GQSPI driver rewrites the baud rate value if there is a change in
SPI clock frequency.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 49 ++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 6771496c1f86..024085098515 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -157,6 +157,7 @@ enum mode_type {GQSPI_MODE_IO, GQSPI_MODE_DMA};
  * @mode:		Defines the mode in which QSPI is operating
  * @data_completion:	completion structure
  * @op_lock:		Operational lock
+ * @speed_hz:		Current SPI bus clock speed in hz
  */
 struct zynqmp_qspi {
 	struct spi_controller *ctlr;
@@ -177,6 +178,7 @@ struct zynqmp_qspi {
 	enum mode_type mode;
 	struct completion data_completion;
 	struct mutex op_lock;
+	u32 speed_hz;
 };
 
 /**
@@ -271,7 +273,8 @@ static void zynqmp_gqspi_selectslave(struct zynqmp_qspi *instanceptr,
  */
 static void zynqmp_qspi_init_hw(struct zynqmp_qspi *xqspi)
 {
-	u32 config_reg;
+	u32 config_reg, baud_rate_val = 0;
+	ulong clk_rate;
 
 	/* Select the GQSPI mode */
 	zynqmp_gqspi_write(xqspi, GQSPI_SEL_OFST, GQSPI_SEL_MASK);
@@ -316,6 +319,16 @@ static void zynqmp_qspi_init_hw(struct zynqmp_qspi *xqspi)
 	else
 		config_reg &= ~GQSPI_CFG_CLK_POL_MASK;
 
+	/* Set the clock frequency */
+	clk_rate = clk_get_rate(xqspi->refclk);
+	while ((baud_rate_val < GQSPI_BAUD_DIV_MAX) &&
+	       (clk_rate /
+		(GQSPI_BAUD_DIV_SHIFT << baud_rate_val)) > xqspi->speed_hz)
+		baud_rate_val++;
+
+	config_reg &= ~GQSPI_CFG_BAUD_RATE_DIV_MASK;
+	config_reg |= (baud_rate_val << GQSPI_CFG_BAUD_RATE_DIV_SHIFT);
+
 	zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST, config_reg);
 
 	/* Clear the TX and RX FIFO */
@@ -459,22 +472,29 @@ static int zynqmp_qspi_config_op(struct zynqmp_qspi *xqspi,
 				 struct spi_device *qspi)
 {
 	ulong clk_rate;
-	u32 config_reg, baud_rate_val = 0;
+	u32 config_reg, req_speed_hz, baud_rate_val = 0;
 
-	/* Set the clock frequency */
-	/* If req_hz == 0, default to lowest speed */
-	clk_rate = clk_get_rate(xqspi->refclk);
+	req_speed_hz = qspi->max_speed_hz;
 
-	while ((baud_rate_val < GQSPI_BAUD_DIV_MAX) &&
-	       (clk_rate /
-		(GQSPI_BAUD_DIV_SHIFT << baud_rate_val)) > qspi->max_speed_hz)
-		baud_rate_val++;
+	if (xqspi->speed_hz != req_speed_hz) {
+		xqspi->speed_hz = req_speed_hz;
 
-	config_reg = zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST);
+		/* Set the clock frequency */
+		/* If req_speed_hz == 0, default to lowest speed */
+		clk_rate = clk_get_rate(xqspi->refclk);
 
-	config_reg &= ~GQSPI_CFG_BAUD_RATE_DIV_MASK;
-	config_reg |= (baud_rate_val << GQSPI_CFG_BAUD_RATE_DIV_SHIFT);
-	zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST, config_reg);
+		while ((baud_rate_val < GQSPI_BAUD_DIV_MAX) &&
+		       (clk_rate /
+			(GQSPI_BAUD_DIV_SHIFT << baud_rate_val)) >
+		       req_speed_hz)
+			baud_rate_val++;
+
+		config_reg = zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST);
+
+		config_reg &= ~GQSPI_CFG_BAUD_RATE_DIV_MASK;
+		config_reg |= (baud_rate_val << GQSPI_CFG_BAUD_RATE_DIV_SHIFT);
+		zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST, config_reg);
+	}
 	return 0;
 }
 
@@ -1165,6 +1185,8 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 
 	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_RX_DUAL | SPI_RX_QUAD |
 		SPI_TX_DUAL | SPI_TX_QUAD;
+	ctlr->max_speed_hz = clk_get_rate(xqspi->refclk) / 2;
+	xqspi->speed_hz = ctlr->max_speed_hz;
 
 	/* QSPI controller initializations */
 	zynqmp_qspi_init_hw(xqspi);
@@ -1190,7 +1212,6 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	ctlr->num_chipselect = GQSPI_DEFAULT_NUM_CS;
 	ctlr->mem_ops = &zynqmp_qspi_mem_ops;
 	ctlr->setup = zynqmp_qspi_setup_op;
-	ctlr->max_speed_hz = clk_get_rate(xqspi->refclk) / 2;
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
 	ctlr->dev.of_node = np;
 	ctlr->auto_runtime_pm = true;
-- 
2.17.1

