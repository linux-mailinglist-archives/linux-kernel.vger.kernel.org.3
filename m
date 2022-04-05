Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F1C4F4846
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238149AbiDEVeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379717AbiDELl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 07:41:26 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2082.outbound.protection.outlook.com [40.107.100.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D938205D8;
        Tue,  5 Apr 2022 04:01:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCnNyYNNdB5Iz1Tc6qVgozA0YxQTYvGq6tKxph+2GH/WFh/BZpNZGQhvaepOkFznuKfjWlxjT5b614/Cg4B5RmqmLocApUOdVSeHVmQ9cwvfeoAi77Qx0quTb6w8NDjurqi5yzrWJbj/ZT5lJgklexUCgEA04UTsMrix8C2mYB9AhAYzGLEgPELKkI02s23pB0DLtXyIQF1eO/mos5oWUIx6AOxm/7afGyj0RJKnKpzQXyhLltyMvaDkYgDRgPiVcXJeS2XtqUb7XNpjA4vjt4TWrxA7rS9Xgc5AKt12qdWtFBI9+6X28NSSDKmkvxqzZ4hyRhPRJ8w6U0oNIpU4/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oU78YsGy19mx9XwxEnjAN+mvVVZSJTbTRTjCTZ1jSbs=;
 b=dZsweh8QZlkpEN6FbCl6UOs/14Qv41HiZT0O0H4kImW6ZLseR9hUfZn1eKcS1UsHqN13p7Zq9h/lVsRQzcOvd9Ja3DA2Vlrsd5T4Z71eS49lLLJvHbQrDj1f6nOHrCEJ/YswdLQYKTB5YQhcYXzL4xQcb35nR0WxXi4oPzzoEYGK9OJLqg+FjPSRoq0738tBOgKlJxG00wOv2kgEozvKRkt6bMEiP5pU2y/PpTz6bjVKctPe5DG0Ey+/phcaL4TFVXlDuB1ZWF7ufGHe0vekDxyXqUnrfPSa3P9uLNXf2JJGKkz9XVZIm05UviQM11NujGWX+tmKPG963vvzrTNbiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oU78YsGy19mx9XwxEnjAN+mvVVZSJTbTRTjCTZ1jSbs=;
 b=rh19foGHVZJ4J/HT2a2lIq1kbjDM76DS0u2dK3d0W/HwCBaxIa9F7nfA4bmcae2YulVtXYOKyG6gd3Y5wNByZ1tiTfsNbLS0q/89e/vbpcwinjQfpspWIJZQdQIKrZEa8UAUg3UukeBW+s3XHioDOsLp+ZXgS7Gks5qz3kRfBBw=
Received: from SN4PR0201CA0005.namprd02.prod.outlook.com
 (2603:10b6:803:2b::15) by SJ0PR02MB7679.namprd02.prod.outlook.com
 (2603:10b6:a03:31a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 11:01:36 +0000
Received: from SN1NAM02FT0023.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2b:cafe::d5) by SN4PR0201CA0005.outlook.office365.com
 (2603:10b6:803:2b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Tue, 5 Apr 2022 11:01:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0023.mail.protection.outlook.com (10.97.4.236) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Tue, 5 Apr 2022 11:01:35 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 5 Apr 2022 04:01:30 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 5 Apr 2022 04:01:30 -0700
Envelope-to: git@xilinx.com,
 saikrishna12468@gmail.com,
 broonie@kernel.org,
 robh+dt@kernel.org,
 p.yadav@ti.com,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
Received: from [172.23.64.7] (port=48931 helo=xhdvnc107.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lakshmi.sai.krishna.potthuri@xilinx.com>)
        id 1nbgwE-000Frj-4y; Tue, 05 Apr 2022 04:01:30 -0700
Received: by xhdvnc107.xilinx.com (Postfix, from userid 14964)
        id 36BEC60FF7; Tue,  5 Apr 2022 16:31:03 +0530 (IST)
From:   Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-spi@vger.kernel.org>,
        Michal Simek <michal.simek@xilinx.com>, <git@xilinx.com>,
        <saikrishna12468@gmail.com>, <sgoud@xilinx.com>,
        "Sai Krishna Potthuri" <lakshmi.sai.krishna.potthuri@xilinx.com>
Subject: [PATCH 2/2] spi: cadence-quadspi: Add support for OSPI device reset
Date:   Tue, 5 Apr 2022 16:30:37 +0530
Message-ID: <1649156437-15609-3-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1649156437-15609-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
References: <1649156437-15609-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8be70b7b-8d6e-44bd-dced-08da16f3a6e4
X-MS-TrafficTypeDiagnostic: SJ0PR02MB7679:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR02MB76793BBD04A48AAAF0391810BDE49@SJ0PR02MB7679.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3ojN54z4x0Imr43o4lbLZ6xiYqKZMnG8RrqBTBJluG9ewtYcG4H1dvuBqIW+0Q5pvXpMhlBZXu+Oj/9nREqd9brOkbTNe51R78vGzf8py80nA4XPNTqK4enVKGty76eTFt4y21sb7cA00gk93zKQNM5zaPX1f1TUce8TshbiLplfg9Myyij6wLCOr4l+fc3xu+zf/rwTAvzkASxc38Z1KpFOecU2RYggkckZuCOEgIzPIrrCPKl9XjDTm1/F9FTFHgN5TIQnSnz2imMxUUW9HOSqHfsF/YFACw6Nhv2REQFVKQqhegS3xPcUAXo/az27HW26BOsr4T3qc3H1m/Oun9kRWoWL1AdGLXFUkQij0Fe/y4qVd7CiRpup0Chw3nyDjm8laD/izABGK8p/QItpVtzsaoqJFP6SHAoXxTrTOAt849Q2cV78K9wKyRSkkm+kw0JGZQbyepGF3ezuQM2pfzEPmgr+4+ClS6DK5l4bv+GsSi64/qHvRT6QTs3ywywsktnyCFyvuB6CGzyLVk1+6YZiVRgT+6/+6JLe1SrtTgppr0uZsdHb4v7rXjZWs+1OhyDPSJOHy8D29EsCNLpNW65q+7dfeGQA07epjMNk+9nyncK/1z8987rlQVKM4TUqqP7/1dIB9CO1vPrGymWa8FqNgdtKqWOgAN94CNfR1LHIpmUwTvT0os11EuaOBfUnyRjn2FLq6p1AjXW3WOeXDA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(4326008)(110136005)(70586007)(70206006)(40460700003)(426003)(336012)(42186006)(107886003)(8676002)(2616005)(356005)(8936002)(508600001)(2906002)(7636003)(36860700001)(82310400005)(316002)(5660300002)(54906003)(36756003)(47076005)(6666004)(186003)(83380400001)(6266002)(26005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 11:01:35.8445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be70b7b-8d6e-44bd-dced-08da16f3a6e4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0023.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7679
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cadence OSPI controller always start in SDR mode and it doesn't know
the current mode of the flash device (SDR or DDR). This creates issue
during Cadence OSPI driver probe if OSPI flash device is in DDR mode.
This patch add OSPI flash device reset using HW reset pin for Xilinx
Versal platform, this will make sure both Controller and Flash device
are in same mode (SDR).
Xilinx Versal platform has a dedicated pin used for OSPI device reset.
As part of the reset sequence, configure the pin to enable
hysteresis and set the direction of the pin to output before toggling
the pin. Provided the required delay ranges while toggling the pin to
meet the most of the OSPI flash devices reset pulse width, reset recovery
and CS high to reset high timings.

Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
---
 drivers/spi/spi-cadence-quadspi.c | 72 +++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index b808c94641fa..6e5b5b180347 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -21,6 +21,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/of_gpio.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
@@ -96,6 +97,7 @@ struct cqspi_driver_platdata {
 	int (*indirect_read_dma)(struct cqspi_flash_pdata *f_pdata,
 				 u_char *rxbuf, loff_t from_addr, size_t n_rx);
 	u32 (*get_dma_status)(struct cqspi_st *cqspi);
+	int (*device_hw_reset)(struct cqspi_st *cqspi);
 };
 
 /* Operation timeout value */
@@ -281,6 +283,7 @@ struct cqspi_driver_platdata {
 #define CQSPI_DMA_UNALIGN		0x3
 
 #define CQSPI_REG_VERSAL_DMA_VAL		0x602
+#define CQSPI_VERSAL_MIO_NODE_ID_12	0x14108027
 
 static int cqspi_wait_for_bit(void __iomem *reg, const u32 mask, bool clr)
 {
@@ -835,6 +838,68 @@ static int cqspi_indirect_read_execute(struct cqspi_flash_pdata *f_pdata,
 	return ret;
 }
 
+static int cqspi_versal_device_reset(struct cqspi_st *cqspi)
+{
+	struct platform_device *pdev = cqspi->pdev;
+	int ret;
+	int gpio;
+	enum of_gpio_flags flags;
+
+	gpio = of_get_named_gpio_flags(pdev->dev.of_node,
+				       "reset-gpios", 0, &flags);
+	if (!gpio_is_valid(gpio))
+		return gpio;
+
+	ret = devm_gpio_request_one(&pdev->dev, gpio, flags,
+				    "flash-reset");
+	if (ret) {
+		dev_err(&pdev->dev,
+			"failed to get reset-gpios: %d\n", ret);
+		return ret;
+	}
+
+	/* Request for PIN */
+	ret = zynqmp_pm_pinctrl_request(CQSPI_VERSAL_MIO_NODE_ID_12);
+	if (ret)
+		return ret;
+
+	/* Enable hysteresis in cmos receiver */
+	ret = zynqmp_pm_pinctrl_set_config(CQSPI_VERSAL_MIO_NODE_ID_12,
+					   PM_PINCTRL_CONFIG_SCHMITT_CMOS,
+					   PM_PINCTRL_INPUT_TYPE_SCHMITT);
+	if (ret)
+		return ret;
+
+	/* Set the direction as output and enable the output */
+	gpio_direction_output(gpio, 1);
+
+	/*
+	 * Experimental Minimum Chip select high to Reset delay value
+	 * based on the supported OSPI flash device spec.
+	 */
+	usleep_range(1, 5);
+
+	/* Set value 0 to pin */
+	gpio_set_value(gpio, 0);
+
+	/*
+	 * Experimental Minimum Reset pulse width value based on the
+	 * supported OSPI flash device spec.
+	 */
+	usleep_range(10, 15);
+
+	/* Set value 1 to pin */
+	gpio_set_value(gpio, 1);
+
+	/*
+	 * Experimental Minimum Reset recovery delay value based on the
+	 * supported OSPI flash device spec.
+	 */
+	usleep_range(35, 40);
+
+	return 0;
+}
+
 static int cqspi_versal_indirect_read_dma(struct cqspi_flash_pdata *f_pdata,
 					  u_char *rxbuf, loff_t from_addr,
 					  size_t n_rx)
@@ -1783,6 +1848,12 @@ static int cqspi_probe(struct platform_device *pdev)
 		goto probe_setup_failed;
 	}
 
+	if (ddata->device_hw_reset) {
+		ret = ddata->device_hw_reset(cqspi);
+		if (ret)
+			goto probe_setup_failed;
+	}
+
 	if (cqspi->use_direct_mode) {
 		ret = cqspi_request_mmap_dma(cqspi);
 		if (ret == -EPROBE_DEFER)
@@ -1878,6 +1949,7 @@ static const struct cqspi_driver_platdata versal_ospi = {
 	.quirks = CQSPI_DISABLE_DAC_MODE | CQSPI_SUPPORT_EXTERNAL_DMA,
 	.indirect_read_dma = cqspi_versal_indirect_read_dma,
 	.get_dma_status = cqspi_get_versal_dma_status,
+	.device_hw_reset = cqspi_versal_device_reset,
 };
 
 static const struct of_device_id cqspi_dt_ids[] = {
-- 
2.17.1

