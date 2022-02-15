Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032484B65EC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 09:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbiBOIVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 03:21:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235373AbiBOIVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 03:21:18 -0500
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10059.outbound.protection.outlook.com [40.107.1.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB639BBA9;
        Tue, 15 Feb 2022 00:21:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjtKhUsCIrIDZjjuAH2YEtAglJrh0fWmAYq7TmDJ59B0+jB8SHM97b2PHpydIJJ/jRWOsf0pJRtybOel5kThy2rB6NvkuMD2eDZ4KY/79TDN+x3fNRHbTIK5/1J/8MLscg+JVJFQhGdcEjl1YofxcNj/N3u8BCOA6qhvNowUP8Xg2d6s4pMz2oIAjEuRPfsO7XCFy0BNA614Pkw6zRAbD/C3iaWaPsiDCKj0Y81jp6NPK8SYpFJPGyVXSTHKjJI1/vImwpTEnP/cdGJrXnRgfFAZEE56dmccbMVWuvseLjldp1aF2ePjV80yofYaxyoo1305Nlux9q9mOH9jKTsZ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pAuQ+iaz4ygoKoC3iY0qHJsmmVTlst9+1+36zwvZovw=;
 b=jRhsZgpbEARWTtNPs1YvKbysdiX6+jp0Z5L962Bdlwc0mNG0BtaEQSgnoebNcYvGFXp/Q1MD2gJWZYkf0nasfuYW5dnSyv3/6VZFpOurFfGP0beIv1AU71p0GwlLZHfpFfug25v9g06FtgzKmqoKQzXooU7nEYODowydm3ekycd401qCtOr7HWBUDL/c7zO56aXG16Chb21hS8DbTuqusgrdP28GoP0kWfu33Ji4JhQr3iZ5+CDDJhgh5V+M0hHnfoeojNYtJlsWQdT/xN/EUlbLqHKWyt6uyY2ApjU1/scQhY3RX7oUdQOFlb+hcXrUwBwYtDauwM2bUYT9qtYmtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAuQ+iaz4ygoKoC3iY0qHJsmmVTlst9+1+36zwvZovw=;
 b=Pn4WQJY8aiiir+FYXSZ1zV3/LYHTZYHrHFuKcyn3QErMmzWcJvj907LSy9Lt1k0zuLTYa1loiLEcom0FgAAQG5LIitjwXuixMGwriFX0W59VF2oPcipeqEDc13L2OpPAAE5Ln8OErJxiYmvbccGhXl0e5h7hwWBkZOpHSwE00p0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB5940.eurprd04.prod.outlook.com (2603:10a6:208:117::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Tue, 15 Feb
 2022 08:21:04 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::448c:19d:ca9a:123e]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::448c:19d:ca9a:123e%7]) with mapi id 15.20.4975.018; Tue, 15 Feb 2022
 08:21:04 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     aisheng.dong@nxp.com, festevam@gmail.com, shawnguo@kernel.org,
        stefan@agner.ch, robh+dt@kernel.org
Cc:     kernel@pengutronix.de, linus.walleij@linaro.org, linux-imx@nxp.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] pinctrl: imx93: Add pinctrl driver support
Date:   Tue, 15 Feb 2022 16:20:06 +0800
Message-Id: <20220215082006.790843-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220215082006.790843-1-peng.fan@oss.nxp.com>
References: <20220215082006.790843-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0046.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c970f51b-0052-4e8d-9bf0-08d9f05c1bc6
X-MS-TrafficTypeDiagnostic: AM0PR04MB5940:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB594032BCDF3EC51164D6BDE6C9349@AM0PR04MB5940.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bGIorEcoEsb4up7E6cwHLuTVsP+daFmLMhYfDOQ/p4pjcKd5fJt8dNnErn5qGtgGInEazlM0MsdUQcUBwiTduz8NUoC/ChlNDf08ae7+HNdi+0bIGEJKwQB+ijljOAYOAM2V46fhM8aY0zzd8A01cyH524spxncvkwgGGpN5C956p0e0OgilO8mR4nph4UtqiR8cf6f26JP3hfM+z0CbSJ28DsZefq0EwP34Qth0bIQykGc3HxoNbv1PN6Pr19kvjlFVG4csSjCifuOwLlaL1P1oaEQDNtkgUxDqU4ssL4yvLTBkCPKv40wzWiQJ1Gx46GBh8hhiEDdoq4xdY7L6edYGHPJx7MFaCWACZFdEmsLy8Nfxw4AePv0nUYE4xamSc34kJG7er3Bhq+cGK/g8MxgCIUWfWq9TT8ncTSfBBJIBhVoDJSI0n24+3FADxZ8ga5A0YRhWT7EWnnv9uELaKK0vjOfo1JNTwe7DUZzZiqSo7wveENvFEp88vuHJpqfBOHf9w9Y8/J0+InnVcZFXX0/RPpwItJrJ+Wtf9wo36O+25spO9i7+hbrNWIoxPv9JwmTxyHgCbp2n9mYyo3WnIhrlvaYS1vpGCgctl7dI1Rgvuz0dJ8PcTq7usGpUpPb+iWvtgyKrgXKeuID9Pj9SOKK6KiARRLePMQBGL+V1evslHd33l0euoJ4hz035+cGaAdgUpigk9wF0pjy/OqFgLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(186003)(6486002)(26005)(54906003)(5660300002)(1076003)(508600001)(86362001)(30864003)(2616005)(2906002)(38100700002)(66946007)(66556008)(8936002)(66476007)(4326008)(7416002)(6512007)(52116002)(8676002)(6506007)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NYBXwEJqNTnCXleHbGQIJe1h+SW9zDZvQ71bnSyJ7ZSZqDmbhF0r/kCNfQS2?=
 =?us-ascii?Q?L30zD3+ItJJj1i6hADE+0nIEYqlzc5WGCQ3VvPSWGRd8pg9PApotVS32VGPV?=
 =?us-ascii?Q?dkBU8lTVBJ6Stg7GSG5zUSWkQbxNpTxC9mmtl8r1JTyxNbYfRovCvT2xXVnJ?=
 =?us-ascii?Q?LbDlQAA7fcRWAmLYxsVoRn8ellAgqogz7mH8RMmmA9YGn8v/mA14TUR3UFJz?=
 =?us-ascii?Q?GmXEn/EvNXjkbXmDNHbrUdP8yJKhdSgKfFCrdGeFVAEJDal8m9QjQwGDyxI1?=
 =?us-ascii?Q?q4uPcdDEGFycpdn7WZPtiGVxH+T00vBlIWzcZHkeJfx0h7bM7GS4mvYby65v?=
 =?us-ascii?Q?UlWAO1CVgeo0/tTF0I3SvXDRRqiNl4IdqS8YiMRjV5HhKpjVJhu4e3spS2/P?=
 =?us-ascii?Q?q0J4ykhHp3q7EXbjcxrLztQY2y75TQ48LYscEP7ymAjrajvK6TX69ahhKpzM?=
 =?us-ascii?Q?P6k7bXP7pheNxBKx9ruLlFqswh6JqEMIuixBAAv9wkkLbMAi9i7DkPelogVr?=
 =?us-ascii?Q?660CkM6L0uYz3Qu6CEO5uG95gdy+fOs7fE6bGum++vJS+0G4RpCGPOLm0/b+?=
 =?us-ascii?Q?t1eakq5+2GofpcRblSpaPQ3q5WO9StEZIg+uuXLDHn2VolVZrF4wBBRyUacO?=
 =?us-ascii?Q?I1TDMqNZq+200lKKyv0EXxfByZh8KvomCZXmIJaLE4kaPhzlWgxDbQC0SwrG?=
 =?us-ascii?Q?63AT6JxwjW1eyaYabJ30sb3bISxZHTDuYa/wA3IVO023W1cW5KfbM7TP/Ihf?=
 =?us-ascii?Q?qr3WomXj3KRhsuydnbkR3vm5w5QFfVPXGV0+OqJTLFaCxy9h+j4YiXcHNRHb?=
 =?us-ascii?Q?9f6S8L4uLn3m9bdxr+wKMcKkgjAdKt+epV69BFauMdMeJadJg94DVvt7UjAe?=
 =?us-ascii?Q?mn9Z0oumh14nxUPfjH7m1xX7DTm4rId4ZOXmd6zVZ2lcop55SAdCEjG07RwA?=
 =?us-ascii?Q?zzdEb7rVgrDswC07gq72w5DqWb2ZfbX1/ssqSPWeYLDwvcYpb3JvvAqA3xfE?=
 =?us-ascii?Q?n2/y+FUMGbjU0ZJVGxi9uQIsDNDCF2nVSK2y42pqhl0mCx8e53msJWaMrS1Z?=
 =?us-ascii?Q?2ycZYvRAeMw9YxCrpnGpz5pp8vHD6raBh09C48dfHl2sfyCVHpYZJ/IIfTtg?=
 =?us-ascii?Q?iOlLG1WDcCALKu8Q+Tc8LYLVvLUizD5fuXFxwyYRO0y+A/Zqs0rkL4bZfQB3?=
 =?us-ascii?Q?z7XtUFKdJ/VT6yIvAtLpWdeY9ZQG9J6hBySYBdnbUiZ0r0OrsINsENWSob5C?=
 =?us-ascii?Q?qx44saSiiXEN97gWZU3Ewt6jMC3qWC6Vx+BKrNvjd8k4GTV6hP7rKACUwtsd?=
 =?us-ascii?Q?5IPPZZ+Q+vR1pK0mZv/CKlavE6kjNELJU9ej8OBNNAplJFPQywddHKzoEuz8?=
 =?us-ascii?Q?rPyHXgn+eiWDtimZgmhdhIIczmBgGKRwactldViBU18pPUBb3c37OwmNKuIA?=
 =?us-ascii?Q?TqF0kr1cJ9pp9EFeWeWjAn0Z+F1JHjBtS0RGfW1Fkqk+i9nQ8SWh7R1f5e2t?=
 =?us-ascii?Q?WupoFHwxSHu4TM4kR5CV0GghOJGHA2/HeWTWeOBy9t0ZDw5R9H2A5676G+Nm?=
 =?us-ascii?Q?nWplkHvwj1geoN9qwyslGde6N1DOK9tga1LlxPdRo1VcMKec4vuT3q02DHSL?=
 =?us-ascii?Q?vJXyvAILUpMWDa7y4/6JjEM=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c970f51b-0052-4e8d-9bf0-08d9f05c1bc6
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 08:21:04.6887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SOtu6u8WLm/cuJGMSCZ+YoZxzimrHJB++dNQkRyvIePLKN28/QwLIz35/1EsWOXOHw1crJ41sRWEbB8ybAnHzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5940
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Bai <ping.bai@nxp.com>

Add i.MX93 pinctrl driver

Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/freescale/Kconfig         |   7 +
 drivers/pinctrl/freescale/Makefile        |   1 +
 drivers/pinctrl/freescale/pinctrl-imx93.c | 272 ++++++++++++++++++++++
 3 files changed, 280 insertions(+)
 create mode 100644 drivers/pinctrl/freescale/pinctrl-imx93.c

diff --git a/drivers/pinctrl/freescale/Kconfig b/drivers/pinctrl/freescale/Kconfig
index 8bdafaf40b29..453dc47f4fa4 100644
--- a/drivers/pinctrl/freescale/Kconfig
+++ b/drivers/pinctrl/freescale/Kconfig
@@ -180,6 +180,13 @@ config PINCTRL_IMXRT1050
 	help
 	  Say Y here to enable the imxrt1050 pinctrl driver
 
+config PINCTRL_IMX93
+	tristate "IMX93 pinctrl driver"
+	depends on ARCH_MXC
+	select PINCTRL_IMX
+	help
+	  Say Y here to enable the imx93 pinctrl driver
+
 config PINCTRL_VF610
 	bool "Freescale Vybrid VF610 pinctrl driver"
 	depends on SOC_VF610
diff --git a/drivers/pinctrl/freescale/Makefile b/drivers/pinctrl/freescale/Makefile
index 565a0350bf09..9f5d1c090338 100644
--- a/drivers/pinctrl/freescale/Makefile
+++ b/drivers/pinctrl/freescale/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_PINCTRL_IMX8QM)	+= pinctrl-imx8qm.o
 obj-$(CONFIG_PINCTRL_IMX8QXP)	+= pinctrl-imx8qxp.o
 obj-$(CONFIG_PINCTRL_IMX8DXL)	+= pinctrl-imx8dxl.o
 obj-$(CONFIG_PINCTRL_IMX8ULP)	+= pinctrl-imx8ulp.o
+obj-$(CONFIG_PINCTRL_IMX93)	+= pinctrl-imx93.o
 obj-$(CONFIG_PINCTRL_VF610)	+= pinctrl-vf610.o
 obj-$(CONFIG_PINCTRL_MXS)	+= pinctrl-mxs.o
 obj-$(CONFIG_PINCTRL_IMX23)	+= pinctrl-imx23.o
diff --git a/drivers/pinctrl/freescale/pinctrl-imx93.c b/drivers/pinctrl/freescale/pinctrl-imx93.c
new file mode 100644
index 000000000000..c0630f69e995
--- /dev/null
+++ b/drivers/pinctrl/freescale/pinctrl-imx93.c
@@ -0,0 +1,272 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2021 NXP
+ */
+
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/pinctrl/pinctrl.h>
+
+#include "pinctrl-imx.h"
+
+enum imx93_pads {
+	IMX93_IOMUXC_DAP_TDI = 0,
+	IMX93_IOMUXC_DAP_TMS_SWDIO = 1,
+	IMX93_IOMUXC_DAP_TCLK_SWCLK = 2,
+	IMX93_IOMUXC_DAP_TDO_TRACESWO = 3,
+	IMX93_IOMUXC_GPIO_IO00 = 4,
+	IMX93_IOMUXC_GPIO_IO01 = 5,
+	IMX93_IOMUXC_GPIO_IO02 = 6,
+	IMX93_IOMUXC_GPIO_IO03 = 7,
+	IMX93_IOMUXC_GPIO_IO04 = 8,
+	IMX93_IOMUXC_GPIO_IO05 = 9,
+	IMX93_IOMUXC_GPIO_IO06 = 10,
+	IMX93_IOMUXC_GPIO_IO07 = 11,
+	IMX93_IOMUXC_GPIO_IO08 = 12,
+	IMX93_IOMUXC_GPIO_IO09 = 13,
+	IMX93_IOMUXC_GPIO_IO10 = 14,
+	IMX93_IOMUXC_GPIO_IO11 = 15,
+	IMX93_IOMUXC_GPIO_IO12 = 16,
+	IMX93_IOMUXC_GPIO_IO13 = 17,
+	IMX93_IOMUXC_GPIO_IO14 = 18,
+	IMX93_IOMUXC_GPIO_IO15 = 19,
+	IMX93_IOMUXC_GPIO_IO16 = 20,
+	IMX93_IOMUXC_GPIO_IO17 = 21,
+	IMX93_IOMUXC_GPIO_IO18 = 22,
+	IMX93_IOMUXC_GPIO_IO19 = 23,
+	IMX93_IOMUXC_GPIO_IO20 = 24,
+	IMX93_IOMUXC_GPIO_IO21 = 25,
+	IMX93_IOMUXC_GPIO_IO22 = 26,
+	IMX93_IOMUXC_GPIO_IO23 = 27,
+	IMX93_IOMUXC_GPIO_IO24 = 28,
+	IMX93_IOMUXC_GPIO_IO25 = 29,
+	IMX93_IOMUXC_GPIO_IO26 = 30,
+	IMX93_IOMUXC_GPIO_IO27 = 31,
+	IMX93_IOMUXC_GPIO_IO28 = 32,
+	IMX93_IOMUXC_GPIO_IO29 = 33,
+	IMX93_IOMUXC_CCM_CLKO1 = 34,
+	IMX93_IOMUXC_CCM_CLKO2 = 35,
+	IMX93_IOMUXC_CCM_CLKO3 = 36,
+	IMX93_IOMUXC_CCM_CLKO4 = 37,
+	IMX93_IOMUXC_ENET1_MDC = 38,
+	IMX93_IOMUXC_ENET1_MDIO = 39,
+	IMX93_IOMUXC_ENET1_TD3 = 40,
+	IMX93_IOMUXC_ENET1_TD2 = 41,
+	IMX93_IOMUXC_ENET1_TD1 = 42,
+	IMX93_IOMUXC_ENET1_TD0 = 43,
+	IMX93_IOMUXC_ENET1_TX_CTL = 44,
+	IMX93_IOMUXC_ENET1_TXC = 45,
+	IMX93_IOMUXC_ENET1_RX_CTL = 46,
+	IMX93_IOMUXC_ENET1_RXC = 47,
+	IMX93_IOMUXC_ENET1_RD0 = 48,
+	IMX93_IOMUXC_ENET1_RD1 = 49,
+	IMX93_IOMUXC_ENET1_RD2 = 50,
+	IMX93_IOMUXC_ENET1_RD3 = 51,
+	IMX93_IOMUXC_ENET2_MDC = 52,
+	IMX93_IOMUXC_ENET2_MDIO = 53,
+	IMX93_IOMUXC_ENET2_TD3 = 54,
+	IMX93_IOMUXC_ENET2_TD2 = 55,
+	IMX93_IOMUXC_ENET2_TD1 = 56,
+	IMX93_IOMUXC_ENET2_TD0 = 57,
+	IMX93_IOMUXC_ENET2_TX_CTL = 58,
+	IMX93_IOMUXC_ENET2_TXC = 59,
+	IMX93_IOMUXC_ENET2_RX_CTL = 60,
+	IMX93_IOMUXC_ENET2_RXC = 61,
+	IMX93_IOMUXC_ENET2_RD0 = 62,
+	IMX93_IOMUXC_ENET2_RD1 = 63,
+	IMX93_IOMUXC_ENET2_RD2 = 64,
+	IMX93_IOMUXC_ENET2_RD3 = 65,
+	IMX93_IOMUXC_SD1_CLK = 66,
+	IMX93_IOMUXC_SD1_CMD = 67,
+	IMX93_IOMUXC_SD1_DATA0 = 68,
+	IMX93_IOMUXC_SD1_DATA1 = 69,
+	IMX93_IOMUXC_SD1_DATA2 = 70,
+	IMX93_IOMUXC_SD1_DATA3 = 71,
+	IMX93_IOMUXC_SD1_DATA4 = 72,
+	IMX93_IOMUXC_SD1_DATA5 = 73,
+	IMX93_IOMUXC_SD1_DATA6 = 74,
+	IMX93_IOMUXC_SD1_DATA7 = 75,
+	IMX93_IOMUXC_SD1_STROBE = 76,
+	IMX93_IOMUXC_SD2_VSELECT = 77,
+	IMX93_IOMUXC_SD3_CLK = 78,
+	IMX93_IOMUXC_SD3_CMD = 79,
+	IMX93_IOMUXC_SD3_DATA0 = 80,
+	IMX93_IOMUXC_SD3_DATA1 = 81,
+	IMX93_IOMUXC_SD3_DATA2 = 82,
+	IMX93_IOMUXC_SD3_DATA3 = 83,
+	IMX93_IOMUXC_SD2_CD_B = 84,
+	IMX93_IOMUXC_SD2_CLK = 85,
+	IMX93_IOMUXC_SD2_CMD = 86,
+	IMX93_IOMUXC_SD2_DATA0 = 87,
+	IMX93_IOMUXC_SD2_DATA1 = 88,
+	IMX93_IOMUXC_SD2_DATA2 = 89,
+	IMX93_IOMUXC_SD2_DATA3 = 90,
+	IMX93_IOMUXC_SD2_RESET_B = 91,
+	IMX93_IOMUXC_I2C1_SCL = 92,
+	IMX93_IOMUXC_I2C1_SDA = 93,
+	IMX93_IOMUXC_I2C2_SCL = 94,
+	IMX93_IOMUXC_I2C2_SDA = 95,
+	IMX93_IOMUXC_UART1_RXD = 96,
+	IMX93_IOMUXC_UART1_TXD = 97,
+	IMX93_IOMUXC_UART2_RXD = 98,
+	IMX93_IOMUXC_UART2_TXD = 99,
+	IMX93_IOMUXC_PDM_CLK = 100,
+	IMX93_IOMUXC_PDM_BIT_STREAM0 = 101,
+	IMX93_IOMUXC_PDM_BIT_STREAM1 = 102,
+	IMX93_IOMUXC_SAI1_TXFS = 103,
+	IMX93_IOMUXC_SAI1_TXC = 104,
+	IMX93_IOMUXC_SAI1_TXD0 = 105,
+	IMX93_IOMUXC_SAI1_RXD0 = 106,
+	IMX93_IOMUXC_WDOG_ANY  = 107,
+};
+
+/* Pad names for the pinmux subsystem */
+static const struct pinctrl_pin_desc imx93_pinctrl_pads[] = {
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_DAP_TDI),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_DAP_TMS_SWDIO),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_DAP_TCLK_SWCLK),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_DAP_TDO_TRACESWO),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_GPIO_IO00),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_GPIO_IO01),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_GPIO_IO02),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_GPIO_IO03),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_GPIO_IO04),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_GPIO_IO05),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_GPIO_IO06),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_GPIO_IO07),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_GPIO_IO08),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_GPIO_IO09),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_GPIO_IO10),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_GPIO_IO11),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_GPIO_IO12),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_GPIO_IO13),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_GPIO_IO14),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_GPIO_IO15),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_GPIO_IO16),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_GPIO_IO17),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_GPIO_IO18),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_GPIO_IO19),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_GPIO_IO20),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_GPIO_IO21),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_GPIO_IO22),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_GPIO_IO23),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_GPIO_IO24),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_GPIO_IO25),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_GPIO_IO26),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_GPIO_IO27),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_GPIO_IO28),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_GPIO_IO29),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_CCM_CLKO1),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_CCM_CLKO2),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_CCM_CLKO3),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_CCM_CLKO4),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_ENET1_MDC),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_ENET1_MDIO),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_ENET1_TD3),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_ENET1_TD2),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_ENET1_TD1),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_ENET1_TD0),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_ENET1_TX_CTL),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_ENET1_TXC),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_ENET1_RX_CTL),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_ENET1_RXC),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_ENET1_RD0),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_ENET1_RD1),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_ENET1_RD2),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_ENET1_RD3),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_ENET2_MDC),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_ENET2_MDIO),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_ENET2_TD3),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_ENET2_TD2),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_ENET2_TD1),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_ENET2_TD0),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_ENET2_TX_CTL),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_ENET2_TXC),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_ENET2_RX_CTL),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_ENET2_RXC),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_ENET2_RD0),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_ENET2_RD1),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_ENET2_RD2),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_ENET2_RD3),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_SD1_CLK),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_SD1_CMD),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_SD1_DATA0),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_SD1_DATA1),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_SD1_DATA2),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_SD1_DATA3),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_SD1_DATA4),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_SD1_DATA5),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_SD1_DATA6),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_SD1_DATA7),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_SD1_STROBE),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_SD2_VSELECT),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_SD3_CLK),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_SD3_CMD),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_SD3_DATA0),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_SD3_DATA1),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_SD3_DATA2),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_SD3_DATA3),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_SD2_CD_B),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_SD2_CLK),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_SD2_CMD),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_SD2_DATA0),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_SD2_DATA1),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_SD2_DATA2),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_SD2_DATA3),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_SD2_RESET_B),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_I2C1_SCL),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_I2C1_SDA),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_I2C2_SCL),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_I2C2_SDA),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_UART1_RXD),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_UART1_TXD),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_UART2_RXD),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_UART2_TXD),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_PDM_CLK),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_PDM_BIT_STREAM0),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_PDM_BIT_STREAM1),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_SAI1_TXFS),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_SAI1_TXC),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_SAI1_TXD0),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_SAI1_RXD0),
+	IMX_PINCTRL_PIN(IMX93_IOMUXC_WDOG_ANY),
+};
+
+static const struct imx_pinctrl_soc_info imx93_pinctrl_info = {
+	.pins = imx93_pinctrl_pads,
+	.npins = ARRAY_SIZE(imx93_pinctrl_pads),
+	.gpr_compatible = "fsl,imx93-iomuxc-gpr",
+};
+
+static const struct of_device_id imx93_pinctrl_of_match[] = {
+	{ .compatible = "fsl,imx93-iomuxc", },
+	{ /* sentinel */ }
+};
+
+static int imx93_pinctrl_probe(struct platform_device *pdev)
+{
+	return imx_pinctrl_probe(pdev, &imx93_pinctrl_info);
+}
+
+static struct platform_driver imx93_pinctrl_driver = {
+	.driver = {
+		.name = "imx93-pinctrl",
+		.of_match_table = imx93_pinctrl_of_match,
+		.suppress_bind_attrs = true,
+	},
+	.probe = imx93_pinctrl_probe,
+};
+
+static int __init imx93_pinctrl_init(void)
+{
+	return platform_driver_register(&imx93_pinctrl_driver);
+}
+arch_initcall(imx93_pinctrl_init);
+
+MODULE_AUTHOR("Bai Ping <ping.bai@nxp.com>");
+MODULE_DESCRIPTION("NXP i.MX93 pinctrl driver");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

