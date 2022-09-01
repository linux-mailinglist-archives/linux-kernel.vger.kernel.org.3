Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC805A8D8A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 07:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbiIAFry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 01:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233137AbiIAFru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 01:47:50 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20602.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::602])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26D11166E6;
        Wed, 31 Aug 2022 22:47:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WMBYCWA2VJZt8w7UVUgTW/Yggzc8JI7AnelTNpZeaOp2nuCyBJv6XuYH8sZaetwwW7/Vkrvh+onGqcQO4L92OYYqDBttXjs5E0TNU0XmXX/lk8nNxqMQl2w/PPuHU+j9RU8GEeBsNhb2nREbKWSj0pF24/bpuEqdx7FPERb9AYwK70HRgnLcin7pBU2r7XsRg6QRXN/S4CTtQWhIsN/IvToM7LJbA1dNNrLD2BdW9rRn6hvWHSpJIQvZFDFrRIBIB61gcy2BlPWkj2UOfj4OY0dsyd6+41lzF8Z/8D/VRsTll7HOmUmZ0W+h7qkBXaEUKvM0SIEa9vCm4CDnh9hYNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UgsZg/jnrHjQmMNSN9GEuuFrEMAg6JLBScz6NtXlJGs=;
 b=T4ie4zNvQL58u3rFr6bHtGxSOZjbxnziRCnoQgmUmRJeKttp33U5fu2Aztj/1OpxQseebnOu7yOqe+lstPxK3RtVf9LP3WbS30/hRK6BWXQuqwnMpeAy4uNU6RY9zMCQ64i9dj6rPy14iu77nOnYiLDeTLN8s/OlrfHMmmzroAzkPckdzl9Ne2a9LQIxlnBQWjOHKZYLOaoKAvmxvPMfrPqlO4esii0dFM7CSXQ+fQtxhqreo5R1j40mpAhtRnJCbrW/6X20wpmI6qSOHAPVWOSmaSws/rBWggcD4MJx+tyJsoKO04ru5fiZlTvgBVs9Jfa2Bo7fgXwMvW3+3n9XAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UgsZg/jnrHjQmMNSN9GEuuFrEMAg6JLBScz6NtXlJGs=;
 b=LJMQ/VLTGhnqB92qQ11OtG/GfoW9SPXoYra83U0/UoOMfE4dOTwIou/Lb58/RPNeogXCWrn0fk4pgHwoMEKJbx6UVuZMukWvKpXop8c6c8zMDCRKaY0EdBsdxfybz3m6NGK7VHx8KtNuW6mPrCVsL8YwxUIuszEk1tb7UGRVQAQ=
Received: from SA1P222CA0060.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::10)
 by SN6PR02MB4894.namprd02.prod.outlook.com (2603:10b6:805:95::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16; Thu, 1 Sep
 2022 05:47:45 +0000
Received: from SN1NAM02FT0034.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:2c1:cafe::dd) by SA1P222CA0060.outlook.office365.com
 (2603:10b6:806:2c1::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Thu, 1 Sep 2022 05:47:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0034.mail.protection.outlook.com (10.97.5.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Thu, 1 Sep 2022 05:47:45 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.6; Wed, 31 Aug 2022 22:47:42 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2507.6 via Frontend Transport; Wed, 31 Aug 2022 22:47:42 -0700
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
        id 1oTd3G-000Eqz-Gr; Wed, 31 Aug 2022 22:47:42 -0700
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <git@amd.com>, <michal.simek@amd.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <akumarma@amd.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Subject: [PATCH 2/7] spi: spi-zynqmp-gqspi: Set CPOL and CPHA during hardware init
Date:   Thu, 1 Sep 2022 11:17:26 +0530
Message-ID: <20220901054731.7705-3-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220901054731.7705-1-amit.kumar-mahapatra@xilinx.com>
References: <20220901054731.7705-1-amit.kumar-mahapatra@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0284e752-78c6-4e7a-acd0-08da8bdd7e9f
X-MS-TrafficTypeDiagnostic: SN6PR02MB4894:EE_
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3rAacHM/2wn4PgoAJPugUQz3b946ZMxNzi/ZJhYhgXNjKYrbrvGY8nNvrW0ivX9fdMI+t/KZOggZP9kHcZPbZ16gP8+KXj+NrKMQOJMhgnR/Xz/yJF4k/cax340E7IafMJiBxcSUWzs4PLyWJ2KeQxQwy+tnlYDPxrYqxr7Xdx8BaVvXcxJMZpvBCgfcxNN10YaxEDDgoj+h92u6ns9ULr6YJz8pXZChOYsQpGSANziblNAsNAWNGUJqUOC/c3V96WlUG8EdDyAG3fi+kjA50hvbHgm/zOHPNnrMWneaKPO+4zBw4f0De0hy0sXVT8QYQeJcaassR24LAmLmqip4CnSBaGEgyshcGgLI8ZI2+g7B2CoKEgEnFiuZdFAlIc75OXkR7QYh04kqVkNUExIHG12aUTCFs/tAppTa+T3FoJnRwpDGZvZVNEtpBMMZ9yVDyRO5WXGsGwqPt0L/AbtQQTpfAIrcIW7eiaGpC41OLyjk17+s88RlSzhGbPCXF8eGGYs8JVTrq+R62JWK2qxDyb5m71A020wPFUZGNwLObjF2dooOrMDx/8pXMcopFFTuYJSkYfBW9cSUe8SVXS8beRPzarBrpjISuiqvIEg7VhGuG0acuEXU9m2DI1B+sdcRNRfxO5mbS8isfvCxLDxhLHdeliBtNKOZLwSKrkuVNGtJnULBFjY34XdaATa0yXtr0tWrwLaD9FwK4aSisK9XMR0DmSXU3nwoE+cMY9iFL1iirhsmeVla0pgh99X+/x2w/oFGFQXIZfstpqELvD6y9QFObihEszA5FWOlMxZqr4k=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(136003)(39860400002)(376002)(46966006)(36840700001)(40470700004)(6666004)(8936002)(8676002)(9786002)(4326008)(110136005)(47076005)(1076003)(426003)(5660300002)(36860700001)(2616005)(7416002)(70206006)(70586007)(2906002)(54906003)(316002)(36756003)(107886003)(478600001)(41300700001)(7696005)(26005)(82310400005)(7636003)(356005)(83380400001)(336012)(186003)(40480700001)(40460700003)(82740400003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 05:47:45.3836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0284e752-78c6-4e7a-acd0-08da8bdd7e9f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0034.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4894
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During every transfer GQSPI driver writes the CPOL & CPHA values to the
configuration register. But the CPOL & CPHA values do not change in between
multiple transfers, so moved the CPOL & CPHA initialization to hardware
init so that the values are written only once.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index b07bb97cf874..6771496c1f86 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -264,7 +264,9 @@ static void zynqmp_gqspi_selectslave(struct zynqmp_qspi *instanceptr,
  *	- Enable manual slave select
  *	- Enable manual start
  *	- Deselect all the chip select lines
- *	- Set the little endian mode of TX FIFO and
+ *	- Set the little endian mode of TX FIFO
+ *	- Set clock phase
+ *	- Set clock polarity and
  *	- Enable the QSPI controller
  */
 static void zynqmp_qspi_init_hw(struct zynqmp_qspi *xqspi)
@@ -303,10 +305,17 @@ static void zynqmp_qspi_init_hw(struct zynqmp_qspi *xqspi)
 	config_reg |= GQSPI_CFG_WP_HOLD_MASK;
 	/* Clear pre-scalar by default */
 	config_reg &= ~GQSPI_CFG_BAUD_RATE_DIV_MASK;
-	/* CPHA 0 */
-	config_reg &= ~GQSPI_CFG_CLK_PHA_MASK;
-	/* CPOL 0 */
-	config_reg &= ~GQSPI_CFG_CLK_POL_MASK;
+	/* Set CPHA */
+	if (xqspi->ctlr->mode_bits & SPI_CPHA)
+		config_reg |= GQSPI_CFG_CLK_PHA_MASK;
+	else
+		config_reg &= ~GQSPI_CFG_CLK_PHA_MASK;
+	/* Set CPOL */
+	if (xqspi->ctlr->mode_bits & SPI_CPOL)
+		config_reg |= GQSPI_CFG_CLK_POL_MASK;
+	else
+		config_reg &= ~GQSPI_CFG_CLK_POL_MASK;
+
 	zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST, config_reg);
 
 	/* Clear the TX and RX FIFO */
@@ -463,14 +472,6 @@ static int zynqmp_qspi_config_op(struct zynqmp_qspi *xqspi,
 
 	config_reg = zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST);
 
-	/* Set the QSPI clock phase and clock polarity */
-	config_reg &= (~GQSPI_CFG_CLK_PHA_MASK) & (~GQSPI_CFG_CLK_POL_MASK);
-
-	if (qspi->mode & SPI_CPHA)
-		config_reg |= GQSPI_CFG_CLK_PHA_MASK;
-	if (qspi->mode & SPI_CPOL)
-		config_reg |= GQSPI_CFG_CLK_POL_MASK;
-
 	config_reg &= ~GQSPI_CFG_BAUD_RATE_DIV_MASK;
 	config_reg |= (baud_rate_val << GQSPI_CFG_BAUD_RATE_DIV_SHIFT);
 	zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST, config_reg);
@@ -1162,6 +1163,9 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 		goto clk_dis_all;
 	}
 
+	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_RX_DUAL | SPI_RX_QUAD |
+		SPI_TX_DUAL | SPI_TX_QUAD;
+
 	/* QSPI controller initializations */
 	zynqmp_qspi_init_hw(xqspi);
 
@@ -1188,8 +1192,6 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	ctlr->setup = zynqmp_qspi_setup_op;
 	ctlr->max_speed_hz = clk_get_rate(xqspi->refclk) / 2;
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
-	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_RX_DUAL | SPI_RX_QUAD |
-			    SPI_TX_DUAL | SPI_TX_QUAD;
 	ctlr->dev.of_node = np;
 	ctlr->auto_runtime_pm = true;
 
-- 
2.17.1

