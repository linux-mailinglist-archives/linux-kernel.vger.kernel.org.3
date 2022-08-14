Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43EE7591F03
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 10:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiHNIDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 04:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiHNIDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 04:03:46 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60043.outbound.protection.outlook.com [40.107.6.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E325E41D20
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 01:03:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lbk07b2RYjLHheiYJw7bwQ+Ygzzqum354u06Giy6DhthHhQAQJjhGcKGhr7oVZu178t30BIbW/3QAjM7U39JYKGH2ejFN86ZeF1rourm38m8LXZ8piIGm3nARG0JGBYHhJ5J7IcaYUBlcTSGys+fPzxP3Fkrtt2TTKzZu76mLWl6fj2KFUlYUxU5SC+fEAFY1O7txPChohLgpjl3KSp3ROo2/yRq7t98NME7c+qo/oUQybxa05K+mMyCzhjljyJDBqOylJB10z7tfLtN27FTSq/Bgs1lrBstC1Th5IgsvZRNlvqPHQyhbh4a2K7JZhtZSXtlamBk2yo/Jwjep9q6mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SdwRPuazq/Ct1tI14Ucg3Bw6pBRcW78TiGF3jDQ2RTs=;
 b=HemixdTkNYKepA9IhtZKQLAYVSKpE3C4GhMoEepIg0le/HEYFJrDNiL/1dY0/tTk5OjA+DD73n376ZRZa2d5XprFSTbP6UcN7Cda8rVx8j+ayoDubXEXPRf4qYibwY0im4gJVzTta5K0Q8oQVbhj/ZXkVwVADnSPzuvFeTq/1r2g5+qSsy1A8/AVt1xBQ9funYKbdkQboccuvXqa5ZM9u4u6CL8+gYuQMm8+Hf4726U4wEPp1ZeGDMINzlkx6mZPNnpB3LFj4lNPp1Q6EdTrA/VHW4pzlKlWkE7MzmVf3jRg7sYCrJ8nRvOQESeN0vBhIFnPdWvyikhwzLCr+HvUCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SdwRPuazq/Ct1tI14Ucg3Bw6pBRcW78TiGF3jDQ2RTs=;
 b=byx8plFKvms4clVF+FIeNbDEGqTxElSpmot0XQyKrmyzTZUzX1dYLJ8MX1zlEJ15tuXsuJOmsW07bKutg/D3CpvsJizFwkAvGh0YvUVv7/CaItTjD/HlMTmm+yoFYR1EvV28JFZafZ2S5NjgQJBiWVf/q/pMF7gRW+iGVItxots=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AM6PR0402MB3734.eurprd04.prod.outlook.com (2603:10a6:209:1b::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Sun, 14 Aug
 2022 08:03:42 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b%6]) with mapi id 15.20.5504.027; Sun, 14 Aug 2022
 08:03:42 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     lee.jones@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com
Subject: [PATCH] mfd: Add Freescale i.MX8qxp Control and Status Registers (CSR) module driver
Date:   Sun, 14 Aug 2022 16:04:57 +0800
Message-Id: <20220814080457.454056-1-victor.liu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0164.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::20) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb6fd17a-e502-4e03-cf1c-08da7dcb8113
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3734:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SHnZIQPhIxmp9ToPrNBEr1XpZrzXwIPIVMj+lwr7GiD8Jx1XkyHufaUXchkyj4V3OqsMdrCj2k+Fqxlab7stRblWR6uLKWEIcoLikpTAifgV7UZizmJzH/BX3ivJOrnUimdflDz9Yu/RedFJewe19v0QC8+jxa+O08hG7dE/bNvKJZtwpjbneI5LOTybgfo8orLvB643mTovzfzNTmDSIYJMNVXt6o1CmJh+CjPktzizOVC4Y8B7wgVccjWlh41kX9YodvLtc29KkWun+KbGQ7wPsZTAUZftVFzhfq26zmEf58aFwUjyzhigu0ygeBnThGIwmIUQvoh8dB1gACEFNmpq1Vqf6zb3/0jyyh7ChumazXa227jU69mahFOlbsNxKVvihriF+jrFQPcRDS280qW8lpm5aatgvgmQTKbgPCoYlTywNkFRgXmzLEp+7EDwb8lTxeV1xWdPLEk1pNxIgrnl6hoxGn/u2yX1fuiC9d5ckw21P6LTElagAPs5WwF3OzOANBbzO4QYDVX2QSZglGOhzUdIG5+gYvd3JV9B98dATFdr8Q60L3Zy/NFRzS+vXDVeZOBjNgMm1C/1MrNuKmQNfY05UzNDA9+vQiilPmtwxL5Ivd8N0ELAHFBT2irqglS3hrUhu3RiscE9zM3VfyTbewOrOE9wf2YrpMP7HTzNYfAeHI9D7xyeHkKxBAHhpQ5Lit7YUMp9SdWj+B2cP5eYLTdyuLfN+vlmSSJzlVh/58STxBAEF8U76svj2SuKhpZFhM9pwHvU16n1DLSUReVS16/NaS+H2ptKBEEO/P1UJ5ye0ISJ6MBBWvY41GQu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(38350700002)(36756003)(86362001)(52116002)(2616005)(26005)(6512007)(6506007)(1076003)(186003)(6666004)(6486002)(41300700001)(316002)(478600001)(66556008)(8936002)(8676002)(66946007)(5660300002)(38100700002)(66476007)(4326008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qXQ9KQAym4NRfqcr4J2Pfm2pw8+mnTAnKFeP5nQZAh4ZCrtjNaWdg1AJ9srm?=
 =?us-ascii?Q?QF8cLfBgGSBgL6EySpumOGQPGPIGIUaCQ8PcQRVnVX7Ixlfj1yRwhZBeSJFE?=
 =?us-ascii?Q?EcNXt4ms3nop982Ud0lvhIORo1EgZCPEyLlJnpD85ykdH3PrWq/RZrt51CCE?=
 =?us-ascii?Q?ysPWC4LJzlohHLM1dc/uAsxEtVVA3VSwJn6Re4M+stozYjw+xpCniEiqkokn?=
 =?us-ascii?Q?ZPqz7r7ezlqBZ2b1qDfCkzyOvoiKO1DkcZssj5G9+JTh/6tXvAziMv4bTzaR?=
 =?us-ascii?Q?GCz99+5O92ccXIG0WFwbWiYUSYeO249ssvCbW4ciD5U5Q6JihBmx9u9H3pc6?=
 =?us-ascii?Q?Gfq85oHw/nqbpcy2s8mVLUNDpG7X33UkBkDf+YQjXJkSRdw8YZ2a/fEkLGOT?=
 =?us-ascii?Q?bRG4ZAHa+btn+nIJz4HPFDzinJcnX+l7w4V9z8n42jg/uc0TEhJ3oCV54NZx?=
 =?us-ascii?Q?u45yYYDxSHfMjHSXpTvw5K2xNwrM/YfEVwb1lmFoO+bIQIHy3H344oDt8hPw?=
 =?us-ascii?Q?0UsSWcyIna2XFz+H+OpmFVLxCfV7SuGHtYRm93sSzw1O4c/iKvoNR7rn0h+f?=
 =?us-ascii?Q?FSImvH2WUBGPz3XMAhlUHgthDrue8lhL963xMoGariQ+hvk38+a/wJjcKJo+?=
 =?us-ascii?Q?vRBWXqOiZ8CU0bDTeF2ZFw+Mm7jYywGYZvpa/qwdSqPqiNS6VD8VQOBdpTRD?=
 =?us-ascii?Q?BwtmC727zBEzLzmmzob+wJ0juhrM9TGIzK1hY2NvSEzaPDX7BEaPOTiBYJ3E?=
 =?us-ascii?Q?MlPDdRQt5qMRgZZQ2JQ6bkzQ45Xk9cn3RRgWUJN3wZdmjdQHmGU/NLP3UyAn?=
 =?us-ascii?Q?IZAmGeJ2bclnPA8VkhlUyNT0Fq1RF90JexhZIgSsuUu0cnYpASxjQU76bbEr?=
 =?us-ascii?Q?Sx351JRcUlLWlf5k/LSheJXvcWZR43Mi6W6l/H7VfndWhJYFl3HvsDBZL9z+?=
 =?us-ascii?Q?W69QXzj1M52E2hlSjjPREJQ1j++LLKfxUhkMN7NwWiYOfiVdlCm3ordXCo2h?=
 =?us-ascii?Q?tKBbEzShCy1ZWpJR9PREdRvkwttLpe8yyerue1oI/0QIWK4usxhtfMHEoJuD?=
 =?us-ascii?Q?P8iJBZ9vASILBTZ/xNBKJ375Ptwn+I3AZZGWP2vNtZFCFhPycw54UYFP//HW?=
 =?us-ascii?Q?PRwrvj2flmjH8xoWfRaojh2O508fI8L4Bs6qIUqIZHr4HlGODLcgwEEv8XoB?=
 =?us-ascii?Q?0U7BihKApkNyQOkCZr1mnsncGF6wxWVRF54wEdo+c0axUaCdNi6n2SRp9kx8?=
 =?us-ascii?Q?0Pemyid97pEgtwih0uP9K2PFz7M0g1lcmIheybaPJhiEO+AJpN8/YTvipolW?=
 =?us-ascii?Q?7EOLWnkHomtqTw+CFfv4Nk5CjYhKDBVI8vzsbNTRTgCcbkUt6c9SlScsCkG5?=
 =?us-ascii?Q?GB/exBAtRJ/BEzF96d4T2wl0qCWaHoQpUwENS8IlFZDXqmWTqYcFlNdvKAbL?=
 =?us-ascii?Q?vP/4BVBLXdbFcbQs7RiLKGODeO4pTVmdb8s4fpIPWcvOJcajoWWPffjaigBN?=
 =?us-ascii?Q?ZXtPO5tG1P54UThvcVu844FeHtuZkS6AfE8w6uFPS5Bg8lfQsQG/XcF19Znv?=
 =?us-ascii?Q?hSN3OrPlJPqnZ9C2RzWGCBc+m4JCSECOK9SJNuix?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb6fd17a-e502-4e03-cf1c-08da7dcb8113
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2022 08:03:42.5300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0yHRbefnySfBvTuYGLlFhYhU9WMtlZbYNPKpvtZbSJsQ8IxXb/nih2m8h9oyv1kBCInE7iv7euGXRSYz96VTQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3734
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Freescale i.MX8qxp Control and Status Registers (CSR) module is a system
controller. It represents a set of miscellaneous registers of a specific
subsystem. It may provide control and/or status report interfaces to a
mix of standalone hardware devices within that subsystem.

The CSR module in i.MX8qm/qxp SoCs is a child node of a simple power-managed
bus(i.MX8qxp pixel link MSI bus). To propagate power management operations
of the CSR module's child devices to that simple power-managed bus, add a
dedicated driver for the CSR module. Also, the driver would populate the CSR
module's child devices.

Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
The Freescale i.MX8qxp CSR DT bindings is at
Documentation/devicetree/bindings/mfd/fsl,imx8qxp-csr.yaml.

 drivers/mfd/Kconfig           | 10 +++++++
 drivers/mfd/Makefile          |  1 +
 drivers/mfd/fsl-imx8qxp-csr.c | 53 +++++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+)
 create mode 100644 drivers/mfd/fsl-imx8qxp-csr.c

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 3b59456f5545..45af4a98c02f 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -499,6 +499,16 @@ config MFD_MX25_TSADC
 	  i.MX25 processors. They consist of a conversion queue for general
 	  purpose ADC and a queue for Touchscreens.
 
+config MFD_MX8QXP_CSR
+	tristate "Freescale i.MX8qxp Control and Status Registers (CSR) Module"
+	depends on (ARCH_MXC && OF) || COMPILE_TEST
+	help
+	  Enable support for Freescale i.MX8qm/qxp Control and Status Registers
+	  (CSR) Module. As a system controller, CSR represents a set of
+	  miscellaneous registers of a specific subsystem. It may provide
+	  control and/or status report interfaces to a mix of standalone
+	  hardware devices within that subsystem.
+
 config MFD_HI6421_PMIC
 	tristate "HiSilicon Hi6421 PMU/Codec IC"
 	depends on OF
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 858cacf659d6..c792abe24906 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -113,6 +113,7 @@ obj-$(CONFIG_MFD_TWL4030_AUDIO)	+= twl4030-audio.o
 obj-$(CONFIG_TWL6040_CORE)	+= twl6040.o
 
 obj-$(CONFIG_MFD_MX25_TSADC)	+= fsl-imx25-tsadc.o
+obj-$(CONFIG_MFD_MX8QXP_CSR)	+= fsl-imx8qxp-csr.o
 
 obj-$(CONFIG_MFD_MC13XXX)	+= mc13xxx-core.o
 obj-$(CONFIG_MFD_MC13XXX_SPI)	+= mc13xxx-spi.o
diff --git a/drivers/mfd/fsl-imx8qxp-csr.c b/drivers/mfd/fsl-imx8qxp-csr.c
new file mode 100644
index 000000000000..3915d3d6ca65
--- /dev/null
+++ b/drivers/mfd/fsl-imx8qxp-csr.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/*
+ * Copyright 2022 NXP
+ */
+
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+
+static int imx8qxp_csr_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	pm_runtime_enable(&pdev->dev);
+
+	ret = devm_of_platform_populate(&pdev->dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to populate sub-devices: %d\n", ret);
+		pm_runtime_disable(&pdev->dev);
+	}
+
+	return ret;
+}
+
+static int imx8qxp_csr_remove(struct platform_device *pdev)
+{
+	pm_runtime_disable(&pdev->dev);
+	return 0;
+}
+
+static const struct of_device_id imx8qxp_csr_of_match[] = {
+	{ .compatible = "fsl,imx8qxp-mipi-lvds-csr", },
+	{ .compatible = "fsl,imx8qm-lvds-csr", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, imx8qxp_csr_of_match);
+
+static struct platform_driver imx8qxp_csr_driver = {
+	.probe = imx8qxp_csr_probe,
+	.remove = imx8qxp_csr_remove,
+	.driver = {
+		.name = "imx8qxp-csr",
+		.of_match_table = imx8qxp_csr_of_match,
+	},
+};
+
+module_platform_driver(imx8qxp_csr_driver);
+
+MODULE_DESCRIPTION("Freescale i.MX8qm/qxp Control and Status Registers Module Driver");
+MODULE_AUTHOR("Liu Ying <victor.liu@nxp.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.37.1

