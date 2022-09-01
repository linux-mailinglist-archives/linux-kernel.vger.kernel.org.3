Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09FB25A8D99
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 07:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbiIAFsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 01:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbiIAFse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 01:48:34 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20622.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::622])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B0611821E;
        Wed, 31 Aug 2022 22:48:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F2S1CCPEbqKesCHOxK0Hwwg85MZblOnV/+ISL7qPWgYtY9gRqfJPJDxSuG0VMk0mLTwoJZZBqnJiDk/Efx6Ecph7AWwbggj/giODjMDLd9eBBgpnQYIDbNhjfVXthE2+Y/ORGt9a2MFtc1KNdt6th5mB/n0m2p3PwW55KLBu7/DZhGpdheKeDZ4rJZNJjK7EtytzkWZ1Zlg4iGjYMwRd8gkFS+N7KPP25apyMHKrS7/sWQpKN3NDrdsoCI5DzhW0URtfYIqqbsbUBMp5mVdw5PX0P1Q3ootsHh7wSIkRxwLV5/bMHJXaK6lVZosHPo7fUA22gwgpvDAZ55raPr/R9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPSSury2uzn3K5qTMHS2oI3Qb7rpTsUkGbuEh3bjL2A=;
 b=SpCnkQFI1TsTzJI2JGibT4mbImGbkaLbQEIGP4M57RIRsL7AFi/NAmUl2h+EeDbmbHUtEVEIHjRj5DoYGZiSAHpAHrdw4gWkqw9Dzx6yJwJgZzuDCJ1EZxz9c72lQ1oZVTtX0hNwBtOUMgVmKMFESoKMGH7uJN95Z9ksh9+GG2dnxqkY8Q8EdCuVKK1fmJZJi2Srq6OE/no9hsG9XqFCaOKeMIXVhE+xM8Rz5rox+Bif3erkG+fmVW4YffS6LxXlJEG2Yr/RMekTm7rw0JOcFlXU126jmIFpdfKWgFXSgZnNJLjtHaAsR5/SY3O56B3GgFDJotoUPUOsmk9Tnwi0Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPSSury2uzn3K5qTMHS2oI3Qb7rpTsUkGbuEh3bjL2A=;
 b=PfAr7S19g7B6m51ql5daeZFfjAdvntcj2Kid3/YepKkKxEeKfKwnHFQLxpP6IEWOstn4bu0Rl0VT1cFNBhdACTCo6YZZwFfK6KWiwuwzXGCeM0usOJiygri2xacNEluNZnCga0/e7fC9Nc8U/EafHJi7a1y32QqQkwiKs5g4MPM=
Received: from SA0PR11CA0066.namprd11.prod.outlook.com (2603:10b6:806:d2::11)
 by DM6PR02MB5452.namprd02.prod.outlook.com (2603:10b6:5:78::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Thu, 1 Sep
 2022 05:48:08 +0000
Received: from SN1NAM02FT0059.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:d2:cafe::e9) by SA0PR11CA0066.outlook.office365.com
 (2603:10b6:806:d2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Thu, 1 Sep 2022 05:48:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0059.mail.protection.outlook.com (10.97.5.175) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Thu, 1 Sep 2022 05:48:08 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.6; Wed, 31 Aug 2022 22:47:59 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2507.6 via Frontend Transport; Wed, 31 Aug 2022 22:47:59 -0700
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
        id 1oTd3W-000Eqz-NM; Wed, 31 Aug 2022 22:47:59 -0700
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <git@amd.com>, <michal.simek@amd.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <akumarma@amd.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>
Subject: [PATCH 7/7] spi: spi-zynqmp-gqspi: Add tap delay support for GQSPI controller on Versal platform
Date:   Thu, 1 Sep 2022 11:17:31 +0530
Message-ID: <20220901054731.7705-8-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220901054731.7705-1-amit.kumar-mahapatra@xilinx.com>
References: <20220901054731.7705-1-amit.kumar-mahapatra@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 922793f4-3812-42b6-7f29-08da8bdd8c1c
X-MS-TrafficTypeDiagnostic: DM6PR02MB5452:EE_
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3pY6JqOgy9pYIybdI5Zq2iG4ZhfbbTnalgM9KSOppqxbJLcoWVyynJSPnLq1pZ/PcpVw1qki4LQ6KBfkAFhpBnQEmD1jAaHNmF8hcicou4fe2svPZwyWrGMDJz5lVWQO+lWyY1mmeh1yficVo0qI18/aIA57k5XsxZPyPM1x9XGRxGHImFOJJj0EVxw4VnSYRYbY7kp0iOul0oMmjLLavW4dWwLn+YJynZ5FY08jhF1Bau1MXpvFM42q8vntYF/7Q3FGIk8lPlECYTuyjDwFspZi4aslufaocCWvzpHHC9OJ4hukM7P4049XGPVUq/sr2ePStGCPKy0hOcOjb+GWda1rYcTYm6MqjP88NqF5HQC34JFOcwvj9DQR1G74kS2NZQVVXT8JDghOWmY7bJEtT5FBQrmk4oz5f1YuAjRHlQcOOLOKrzuS2DGzrgkdFGR7L4XdYeAEvsPhWbEZxRVH/hBKKNWpjFKV49sl/e7B5ybcFlL0n3RKdOjoEq8TDH3fb1RjSQVza2zMJzt2gYEIohB996EpMiO2No1bSMmB9bEPV6oDPizgh8U9kABDa9tt/zQ8wRJr5rO917KzGvcEvyBKw4CjmdwmGMQ9s2HP35Fh7TI1dj1VrUtczcZEH/6EEQDM21YWMZjoh4ulDE+5eq+ikmm8jCGaJPSxgrKbhye0IA3uGXFTKae6wN9elRRG/ZCEH//U1IViSUZJCS2UOEq3grphTdqOWQCD4xY/NbyCTRz4f7rZKlmF7p4/4CtA/sVkOkR6WpIkCaPa2LymLbkMtfpwL7AP3ZYNGvmnLqQ=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(376002)(136003)(346002)(40470700004)(46966006)(36840700001)(2616005)(7636003)(186003)(40460700003)(426003)(47076005)(336012)(1076003)(6666004)(107886003)(41300700001)(5660300002)(8936002)(9786002)(7696005)(7416002)(356005)(2906002)(26005)(36860700001)(40480700001)(82740400003)(83380400001)(82310400005)(54906003)(36756003)(70206006)(478600001)(70586007)(8676002)(4326008)(316002)(110136005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 05:48:08.0120
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 922793f4-3812-42b6-7f29-08da8bdd8c1c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0059.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5452
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds tap delay support for GQSPI controller on Versal
platform.

Signed-off-by: Naga Sureshkumar Relli <nagasure@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 90 +++++++++++++++++++++++++++-------
 1 file changed, 71 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 0e6423ff33f4..825a2d072536 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/spi/spi.h>
@@ -34,6 +35,7 @@
 #define GQSPI_RXD_OFST			0x00000120
 #define GQSPI_TX_THRESHOLD_OFST		0x00000128
 #define GQSPI_RX_THRESHOLD_OFST		0x0000012C
+#define IOU_TAPDLY_BYPASS_OFST		0x0000003C
 #define GQSPI_LPBK_DLY_ADJ_OFST		0x00000138
 #define GQSPI_GEN_FIFO_OFST		0x00000140
 #define GQSPI_SEL_OFST			0x00000144
@@ -134,10 +136,17 @@
 #define GQSPI_SELECT_MODE_QUADSPI	0x4
 #define GQSPI_DMA_UNALIGN		0x3
 #define GQSPI_DEFAULT_NUM_CS	1	/* Default number of chip selects */
+#define GQSPI_LPBK_DLY_ADJ_DLY_1	0x1
+#define GQSPI_LPBK_DLY_ADJ_DLY_1_SHIFT	3
 #define GQSPI_USE_DATA_DLY              0x1
 #define GQSPI_USE_DATA_DLY_SHIFT        31
 #define GQSPI_DATA_DLY_ADJ_VALUE        0x2
 #define GQSPI_DATA_DLY_ADJ_SHIFT        28
+#define TAP_DLY_BYPASS_LQSPI_RX_VALUE	0x1
+#define TAP_DLY_BYPASS_LQSPI_RX_SHIFT	2
+
+/* set to differentiate versal from zynqmp, 1=versal, 0=zynqmp */
+#define QSPI_QUIRK_HAS_TAPDELAY	BIT(0)
 
 #define GQSPI_FREQ_37_5MHZ      37500000
 #define GQSPI_FREQ_40MHZ        40000000
@@ -147,6 +156,14 @@
 #define SPI_AUTOSUSPEND_TIMEOUT		3000
 enum mode_type {GQSPI_MODE_IO, GQSPI_MODE_DMA};
 
+/**
+ * struct qspi_platform_data - zynqmp qspi platform data structure
+ * @quirks:	Flags is used to identify the platform
+ */
+struct qspi_platform_data {
+	u32 quirks;
+};
+
 /**
  * struct zynqmp_qspi - Defines qspi driver instance
  * @ctlr:		Pointer to the spi controller information
@@ -167,7 +184,9 @@ enum mode_type {GQSPI_MODE_IO, GQSPI_MODE_DMA};
  * @mode:		Defines the mode in which QSPI is operating
  * @data_completion:	completion structure
  * @op_lock:		Operational lock
+
  * @speed_hz:		Current SPI bus clock speed in hz
+ * @has_tapdelay:	Used for tapdelay register available in qspi
  */
 struct zynqmp_qspi {
 	struct spi_controller *ctlr;
@@ -189,6 +208,7 @@ struct zynqmp_qspi {
 	struct completion data_completion;
 	struct mutex op_lock;
 	u32 speed_hz;
+	bool has_tapdelay;
 };
 
 /**
@@ -268,26 +288,46 @@ static void zynqmp_gqspi_selectslave(struct zynqmp_qspi *instanceptr,
  */
 static void zynqmp_qspi_set_tapdelay(struct zynqmp_qspi *xqspi, u32 baudrateval)
 {
-	u32 lpbkdlyadj = 0, datadlyadj = 0, clk_rate;
+	u32 tapdlybypass = 0, lpbkdlyadj = 0, datadlyadj = 0, clk_rate;
 	u32 reqhz = 0;
 
 	clk_rate = clk_get_rate(xqspi->refclk);
 	reqhz = (clk_rate / (GQSPI_BAUD_DIV_SHIFT << baudrateval));
 
-	if (reqhz <= GQSPI_FREQ_40MHZ) {
-		zynqmp_pm_set_tapdelay_bypass(PM_TAPDELAY_QSPI,
-					      PM_TAPDELAY_BYPASS_ENABLE);
-	} else if (reqhz <= GQSPI_FREQ_100MHZ) {
-		zynqmp_pm_set_tapdelay_bypass(PM_TAPDELAY_QSPI,
-					      PM_TAPDELAY_BYPASS_ENABLE);
-		lpbkdlyadj |= (GQSPI_LPBK_DLY_ADJ_USE_LPBK_MASK);
-		datadlyadj |= ((GQSPI_USE_DATA_DLY <<
-				GQSPI_USE_DATA_DLY_SHIFT)
-				| (GQSPI_DATA_DLY_ADJ_VALUE <<
-					GQSPI_DATA_DLY_ADJ_SHIFT));
-	} else if (reqhz <= GQSPI_FREQ_150MHZ) {
-		lpbkdlyadj |= GQSPI_LPBK_DLY_ADJ_USE_LPBK_MASK;
+	if (!xqspi->has_tapdelay) {
+		if (reqhz <= GQSPI_FREQ_40MHZ) {
+			zynqmp_pm_set_tapdelay_bypass(PM_TAPDELAY_QSPI,
+						      PM_TAPDELAY_BYPASS_ENABLE);
+		} else if (reqhz <= GQSPI_FREQ_100MHZ) {
+			zynqmp_pm_set_tapdelay_bypass(PM_TAPDELAY_QSPI,
+						      PM_TAPDELAY_BYPASS_ENABLE);
+			lpbkdlyadj |= (GQSPI_LPBK_DLY_ADJ_USE_LPBK_MASK);
+			datadlyadj |= ((GQSPI_USE_DATA_DLY <<
+					GQSPI_USE_DATA_DLY_SHIFT)
+					| (GQSPI_DATA_DLY_ADJ_VALUE <<
+						GQSPI_DATA_DLY_ADJ_SHIFT));
+		} else if (reqhz <= GQSPI_FREQ_150MHZ) {
+			lpbkdlyadj |= GQSPI_LPBK_DLY_ADJ_USE_LPBK_MASK;
+		}
+	} else {
+		if (reqhz <= GQSPI_FREQ_37_5MHZ) {
+			tapdlybypass |= (TAP_DLY_BYPASS_LQSPI_RX_VALUE <<
+					TAP_DLY_BYPASS_LQSPI_RX_SHIFT);
+		} else if (reqhz <= GQSPI_FREQ_100MHZ) {
+			tapdlybypass |= (TAP_DLY_BYPASS_LQSPI_RX_VALUE <<
+					TAP_DLY_BYPASS_LQSPI_RX_SHIFT);
+			lpbkdlyadj |= (GQSPI_LPBK_DLY_ADJ_USE_LPBK_MASK);
+			datadlyadj |= (GQSPI_USE_DATA_DLY <<
+					GQSPI_USE_DATA_DLY_SHIFT);
+		} else if (reqhz <= GQSPI_FREQ_150MHZ) {
+			lpbkdlyadj |= (GQSPI_LPBK_DLY_ADJ_USE_LPBK_MASK
+				       | (GQSPI_LPBK_DLY_ADJ_DLY_1 <<
+					       GQSPI_LPBK_DLY_ADJ_DLY_1_SHIFT));
+		}
+		zynqmp_gqspi_write(xqspi,
+				   IOU_TAPDLY_BYPASS_OFST, tapdlybypass);
 	}
+
 	zynqmp_gqspi_write(xqspi, GQSPI_LPBK_DLY_ADJ_OFST, lpbkdlyadj);
 	zynqmp_gqspi_write(xqspi, GQSPI_DATA_DLY_ADJ_OFST, datadlyadj);
 }
@@ -1147,6 +1187,15 @@ static const struct dev_pm_ops zynqmp_qspi_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(zynqmp_qspi_suspend, zynqmp_qspi_resume)
 };
 
+static const struct qspi_platform_data versal_qspi_def = {
+	.quirks = QSPI_QUIRK_HAS_TAPDELAY,
+};
+
+static const struct of_device_id zynqmp_qspi_of_match[] = {
+	{ .compatible = "xlnx,zynqmp-qspi-1.0"},
+	{ .compatible = "xlnx,versal-qspi-1.0", .data = &versal_qspi_def },
+	{ /* End of table */ }
+};
 static const struct spi_controller_mem_ops zynqmp_qspi_mem_ops = {
 	.exec_op = zynqmp_qspi_exec_op,
 };
@@ -1165,6 +1214,7 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	struct spi_controller *ctlr;
 	struct zynqmp_qspi *xqspi;
 	struct device *dev = &pdev->dev;
+	const struct of_device_id *match;
 	struct device_node *np = dev->of_node;
 
 	ctlr = spi_alloc_master(&pdev->dev, sizeof(*xqspi));
@@ -1176,6 +1226,13 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	xqspi->ctlr = ctlr;
 	platform_set_drvdata(pdev, xqspi);
 
+	match = of_match_node(zynqmp_qspi_of_match, pdev->dev.of_node);
+	if (match) {
+		const struct qspi_platform_data *p_data = match->data;
+
+		if (p_data && (p_data->quirks & QSPI_QUIRK_HAS_TAPDELAY))
+			xqspi->has_tapdelay = true;
+	}
 	xqspi->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(xqspi->regs)) {
 		ret = PTR_ERR(xqspi->regs);
@@ -1303,11 +1360,6 @@ static int zynqmp_qspi_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id zynqmp_qspi_of_match[] = {
-	{ .compatible = "xlnx,zynqmp-qspi-1.0", },
-	{ /* End of table */ }
-};
-
 MODULE_DEVICE_TABLE(of, zynqmp_qspi_of_match);
 
 static struct platform_driver zynqmp_qspi_driver = {
-- 
2.17.1

