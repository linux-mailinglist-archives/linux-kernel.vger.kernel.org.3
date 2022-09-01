Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE385A8D92
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 07:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbiIAFsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 01:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233168AbiIAFsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 01:48:06 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17DF1178D3;
        Wed, 31 Aug 2022 22:47:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aq4uFnGrCTGR63oIbKYQ17G7bOcSf43EabuDrI4nIsXe/ptib/23xxnK3LRLyJ12T24V5L6SGB05XhYOcTmQuqWWYbeni/RM2y2PlkvjjokotGiguWSOrDTTKSsSf0b/FeTG/sZJ+nClphp1MAdRV3zvGpAua1ybxkkqeMvxX2RDR/uvPAIb7sqbJeBcYQvo9TZBNOqUfhmHtItWOKakrD8GLnvp7G7VIZRfaZbaaZl9sHhmk7FLqZEojxStcW+vr0o4NirCtKfrN4jiWQUmHHBH421BUVYj+lX+5wLbcuUpWZYYavKghlQ9X+t9vjWR6giWVFipOu6szHBUQabVgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCeMWA4CCyDuL5wRSFVcjF4x5fkLEgLMENwaMQwBoE8=;
 b=i739KQNE0eS0cVuGJztDJ9RAtBtfzeuahoPrFDn79O6f0oFjaqdlz+kk5c7eYRefTaxjywNxCpbRpdULRo6DkjpECVpDttkbu65a4ZB2I+ZEC3eHjfwZMoCYfOThCIb+/xrMhq9R4vflVCEdZuLdwLNZhKaw7g3DzjrnKf6J0i966NSqx9yAMAgV/4kNjC9gz1AJmgPYyS5LrucfUCH9clGooy1OXX1zdnzyeL1wLuBh4Qam1Jdj9uM3p8Q2VYFhOKqfk+N2Wj8tEN3RWMydcBh5nGs2VGeTb2w+DDNDSUzsBDS1o53yrG3DCk+RVQkISvCoAPVTcw4m3eeGunPjcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCeMWA4CCyDuL5wRSFVcjF4x5fkLEgLMENwaMQwBoE8=;
 b=KMi65kT81XywDlPs+6bJH2Ecj7c8Pbe8RU33ybQ/ZbHuWzcnkLhYyK+qxQiKXPXnxrpwH+FIl4q6CIt/HlZBTxCSCGTgtL4Rx3ZIWzn3hwzDNNGmUlTNoFZzMy5sWCkyGFZIheKAH3AhL0twHwQGYOjXoQRi9uGvQ0opdtyRtwk=
Received: from DS7PR03CA0122.namprd03.prod.outlook.com (2603:10b6:5:3b4::7) by
 SN6PR02MB4926.namprd02.prod.outlook.com (2603:10b6:805:94::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.11; Thu, 1 Sep 2022 05:47:55 +0000
Received: from DM3NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::e4) by DS7PR03CA0122.outlook.office365.com
 (2603:10b6:5:3b4::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Thu, 1 Sep 2022 05:47:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT062.mail.protection.outlook.com (10.13.5.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Thu, 1 Sep 2022 05:47:54 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 31 Aug 2022 22:47:52 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2507.6 via Frontend Transport; Wed, 31 Aug 2022 22:47:52 -0700
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
        id 1oTd3Q-000Eqz-98; Wed, 31 Aug 2022 22:47:52 -0700
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <git@amd.com>, <michal.simek@amd.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <akumarma@amd.com>, Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Subject: [PATCH 5/7] spi: spi-zynqmp-gqspi: Add tap delay support for ZynqMP GQSPI Controller
Date:   Thu, 1 Sep 2022 11:17:29 +0530
Message-ID: <20220901054731.7705-6-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220901054731.7705-1-amit.kumar-mahapatra@xilinx.com>
References: <20220901054731.7705-1-amit.kumar-mahapatra@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 508b1c09-0c36-43f7-ba69-08da8bdd841e
X-MS-TrafficTypeDiagnostic: SN6PR02MB4926:EE_
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J+GrrCO2UJqVbfY0pb+ewXxbalkHPDfpXm+1JGPRPCU0HGLWHYwJBmacMKFyWR7udFEVvX1AaWEjJKMQJcNVbzlqATTafelreukvTMzHcqNXQcG1x4upX4ZPmDBQHzMDCRUwKSYGdXWOCPpbJuOCfbh12RzGzmD6JWnry8kuex4SmaHQ0WrpkBRuzJu5tLUfHPdCLNcOEZMwRYwRZS8kY7WoPjNoNSNW8gN5T/IFhJnBCGU+H+8XMNy04GRXX5PUoQ1KU6WstTVv+m/X7uXII6jrsDA1++24EdF8nqbzxCczqyRjpC7wAFo5/UpVmslTOGyeakjOJySnO2wfioI8vdBLoh9aJql0LUfWULCGadSJclUI33rOjFI+pqWD1FO1IsFYpWwrx99tTWkkVsr5roagKwPa6s/qoDk4zvW+iU2HBpJKv5B9dDLi25DW1L/0DKTGaIitDAdZhJaJS11OtJ9B31iH1BdwNvkC+T4lQSDYFQYtHRUVm5DVmmcPZPz8DiA8qVYz3/1Ce5hlgqs2/DuSnkAUxyOAIylUTX8rkNqJCQjfKgVArCE80qnxsw0eDKQJnUbi4I+PuPhYcY0HVnAX8faae0lGxaXR//9h6BNzYGIZk/i3m7vI3qrhHtgdk9H93eEg8hiEVxNr2xHAr5dUAKB8au9yRaG+rVUsQEPAX07GOTDYeL3V7sG+8MoXbr/HyNoPyi5jNDehaqZRGDwj2hopB40BRCQTiKXq+zd3ksvfoCg419W8d5gvrzB/PtfGgGa0bjot+FA8Kt4s2sbHNzsLwhB0rxWSV1H3Qmw=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(376002)(136003)(39860400002)(40470700004)(46966006)(36840700001)(82310400005)(83380400001)(40480700001)(82740400003)(110136005)(316002)(4326008)(8676002)(478600001)(70206006)(70586007)(54906003)(36756003)(107886003)(6666004)(336012)(1076003)(8936002)(5660300002)(41300700001)(9786002)(7636003)(2616005)(47076005)(426003)(186003)(40460700003)(36860700001)(356005)(7416002)(7696005)(26005)(2906002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 05:47:54.6048
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 508b1c09-0c36-43f7-ba69-08da8bdd841e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT062.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4926
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naga Sureshkumar Relli <nagasure@xilinx.com>

GQSPI controller uses the internal clock for loopback mode. The loopback
mode is used with the high-speed Quad SPI timing mode, where the memory
interface clock needs to be greater than 40 MHz. Based on the tap delay
value programmed, the internal clock is delayed and used for capturing
the data.
Based upon the frequency of operation this patch sets the recommended
tap delay values.

Signed-off-by: Naga Sureshkumar Relli <nagasure@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 48 +++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 024085098515..0e6423ff33f4 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -48,6 +48,7 @@
 #define GQSPI_QSPIDMA_DST_I_MASK_OFST	0x00000820
 #define GQSPI_QSPIDMA_DST_ADDR_OFST	0x00000800
 #define GQSPI_QSPIDMA_DST_ADDR_MSB_OFST 0x00000828
+#define GQSPI_DATA_DLY_ADJ_OFST         0x000001F8
 
 /* GQSPI register bit masks */
 #define GQSPI_SEL_MASK				0x00000001
@@ -133,6 +134,15 @@
 #define GQSPI_SELECT_MODE_QUADSPI	0x4
 #define GQSPI_DMA_UNALIGN		0x3
 #define GQSPI_DEFAULT_NUM_CS	1	/* Default number of chip selects */
+#define GQSPI_USE_DATA_DLY              0x1
+#define GQSPI_USE_DATA_DLY_SHIFT        31
+#define GQSPI_DATA_DLY_ADJ_VALUE        0x2
+#define GQSPI_DATA_DLY_ADJ_SHIFT        28
+
+#define GQSPI_FREQ_37_5MHZ      37500000
+#define GQSPI_FREQ_40MHZ        40000000
+#define GQSPI_FREQ_100MHZ       100000000
+#define GQSPI_FREQ_150MHZ       150000000
 
 #define SPI_AUTOSUSPEND_TIMEOUT		3000
 enum mode_type {GQSPI_MODE_IO, GQSPI_MODE_DMA};
@@ -251,6 +261,37 @@ static void zynqmp_gqspi_selectslave(struct zynqmp_qspi *instanceptr,
 	}
 }
 
+/**
+ * zynqmp_qspi_set_tapdelay:	To configure qspi tap delays
+ * @xqspi:		Pointer to the zynqmp_qspi structure
+ * @baudrateval:	Buadrate to configure
+ */
+static void zynqmp_qspi_set_tapdelay(struct zynqmp_qspi *xqspi, u32 baudrateval)
+{
+	u32 lpbkdlyadj = 0, datadlyadj = 0, clk_rate;
+	u32 reqhz = 0;
+
+	clk_rate = clk_get_rate(xqspi->refclk);
+	reqhz = (clk_rate / (GQSPI_BAUD_DIV_SHIFT << baudrateval));
+
+	if (reqhz <= GQSPI_FREQ_40MHZ) {
+		zynqmp_pm_set_tapdelay_bypass(PM_TAPDELAY_QSPI,
+					      PM_TAPDELAY_BYPASS_ENABLE);
+	} else if (reqhz <= GQSPI_FREQ_100MHZ) {
+		zynqmp_pm_set_tapdelay_bypass(PM_TAPDELAY_QSPI,
+					      PM_TAPDELAY_BYPASS_ENABLE);
+		lpbkdlyadj |= (GQSPI_LPBK_DLY_ADJ_USE_LPBK_MASK);
+		datadlyadj |= ((GQSPI_USE_DATA_DLY <<
+				GQSPI_USE_DATA_DLY_SHIFT)
+				| (GQSPI_DATA_DLY_ADJ_VALUE <<
+					GQSPI_DATA_DLY_ADJ_SHIFT));
+	} else if (reqhz <= GQSPI_FREQ_150MHZ) {
+		lpbkdlyadj |= GQSPI_LPBK_DLY_ADJ_USE_LPBK_MASK;
+	}
+	zynqmp_gqspi_write(xqspi, GQSPI_LPBK_DLY_ADJ_OFST, lpbkdlyadj);
+	zynqmp_gqspi_write(xqspi, GQSPI_DATA_DLY_ADJ_OFST, datadlyadj);
+}
+
 /**
  * zynqmp_qspi_init_hw - Initialize the hardware
  * @xqspi:	Pointer to the zynqmp_qspi structure
@@ -330,16 +371,14 @@ static void zynqmp_qspi_init_hw(struct zynqmp_qspi *xqspi)
 	config_reg |= (baud_rate_val << GQSPI_CFG_BAUD_RATE_DIV_SHIFT);
 
 	zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST, config_reg);
+	/* Set the tapdelay for clock frequency */
+	zynqmp_qspi_set_tapdelay(xqspi, baud_rate_val);
 
 	/* Clear the TX and RX FIFO */
 	zynqmp_gqspi_write(xqspi, GQSPI_FIFO_CTRL_OFST,
 			   GQSPI_FIFO_CTRL_RST_RX_FIFO_MASK |
 			   GQSPI_FIFO_CTRL_RST_TX_FIFO_MASK |
 			   GQSPI_FIFO_CTRL_RST_GEN_FIFO_MASK);
-	/* Set by default to allow for high frequencies */
-	zynqmp_gqspi_write(xqspi, GQSPI_LPBK_DLY_ADJ_OFST,
-			   zynqmp_gqspi_read(xqspi, GQSPI_LPBK_DLY_ADJ_OFST) |
-			   GQSPI_LPBK_DLY_ADJ_USE_LPBK_MASK);
 	/* Reset thresholds */
 	zynqmp_gqspi_write(xqspi, GQSPI_TX_THRESHOLD_OFST,
 			   GQSPI_TX_FIFO_THRESHOLD_RESET_VAL);
@@ -494,6 +533,7 @@ static int zynqmp_qspi_config_op(struct zynqmp_qspi *xqspi,
 		config_reg &= ~GQSPI_CFG_BAUD_RATE_DIV_MASK;
 		config_reg |= (baud_rate_val << GQSPI_CFG_BAUD_RATE_DIV_SHIFT);
 		zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST, config_reg);
+		zynqmp_qspi_set_tapdelay(xqspi, baud_rate_val);
 	}
 	return 0;
 }
-- 
2.17.1

