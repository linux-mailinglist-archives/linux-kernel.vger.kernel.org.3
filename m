Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1714C6081
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 01:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbiB1BAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 20:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbiB1A77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 19:59:59 -0500
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00070.outbound.protection.outlook.com [40.107.0.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83530522E9;
        Sun, 27 Feb 2022 16:59:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzOV6YFxeXEFY1Y//aBiJekvxQjpOY87DbyIcQOdpUp0MmXDt5eYe68VRtUoIyi7judt6YXWfUd3khGiaUQwCWlM+8Skb49GjspPaYcdWOM1d1E2ZWxvQg56+P6MbyfdVPwV4uQOEfIzItr0eZN2eVSbKwiFOdEQvlSxeifQf8mmWGfNb0y4KLe22XEAvP2dksfi2em+Aw+jlYqedKQzAkurR6r/A11I6qzQhyBHXD+wEm3GOteKLA2mrTbtGjyGYBbcD9mp+tp092zHJbiSBg4CRa+s4BzkD+WnmL0F5A9wo3uGFKqTpsbzcM0ogM7JlgA0GvHdPrKdbdmIvJHKGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBGgrEECbAqInweHGgVtWlxWdzj2F5lKmjC+sCzsdtY=;
 b=Cll7PuFR+yx5TJOg2bWKAO1V/BuFGTi5SnERSRXEp+sg+ufMxbCBBi2xoE/Go682zwvP+jvaS3GPFbMA8fI0bUbJFNPuH+VXJmxKCA9aLG5dzbSjQ0k/RWb3KlkgtnfUFi5xGATE7LeIEPh78343e/UP1wAmqjyEEtcRcmaeO8BkibTXRp3RwJ7Vx/QyvdSUmgRDYg/rDsAZiIBa1YsN4k0h0ABFdTTo4+Rg0ZQtWJ3gY+o9xx0hmgKGoy87ayEPW4Fz3+DzZVHBgHpD5VzIF77ZdYJONSQotEo8iknGRRf//5tng4AtH5NFOYq5TlhNWRVNd2bQPyVbV7aT9k1iMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBGgrEECbAqInweHGgVtWlxWdzj2F5lKmjC+sCzsdtY=;
 b=G04Qg3kM3MNWs+HWuvBJLtW5BSgjDMF1TBtWZqCs7dxuAk+3n5HTFkcURjvBIVPcpsEUX3ybV0M0865ZM1Gmxj2VSVnAFdmtwlVSSn0Qzkcr+4YEFbnN/kQCNEVg3KfQGYJyrXxxheTCHdOUR/TvZ9HjBJuPixZ2xS//PYUBKhM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB5412.eurprd04.prod.outlook.com (2603:10a6:208:10f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Mon, 28 Feb
 2022 00:59:19 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Mon, 28 Feb 2022
 00:59:19 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     aisheng.dong@nxp.com, festevam@gmail.com, shawnguo@kernel.org,
        stefan@agner.ch, robh+dt@kernel.org
Cc:     kernel@pengutronix.de, linus.walleij@linaro.org, linux-imx@nxp.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 2/2] pinctrl: imx93: Add pinctrl driver support
Date:   Mon, 28 Feb 2022 09:01:03 +0800
Message-Id: <20220228010103.2725893-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228010103.2725893-1-peng.fan@oss.nxp.com>
References: <20220228010103.2725893-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0013.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::25)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44d01706-ecd5-402a-2c18-08d9fa558cbf
X-MS-TrafficTypeDiagnostic: AM0PR04MB5412:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB54128085DE020AB608B58F0BC9019@AM0PR04MB5412.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PZGmRlHsineY6D2+HUL9C2g+Pg32Gihe051DQvFqg0dXFn4n26U93T8Bm9qbTdiwPuEQRTW7UHHh1QUhOLAoDqtftLgQ8RYxi72cYWH+Lbuu+wfZYpOr5qAfK1M2pFDRP+cSDBcv5F+sV/nqVwAmzKotToHHw5ZD1ypOs0W7eg3lm+icXXGvJoyDt4fnTEFtx3pUa8KgezcWHQRDUCafWEX5fHF/bk47Zr+SFshMwQVlNCXHV7RLQasi28wM0QwvChD+ggvQLsnMzSQXCHybKPBvUA59TAoK57mf32BlpwpxCUBuwQkM+jkyGf9cOScRkPBzO9ZTJqpTNDl3uUuEMet+4XI2XtuPstvkzTKhBeboTPU7cedXgkxLnoGqT2SpRQDjjSiL6LwWDvGsqyTyAtBNTgX27Efum4VE36AxzekXnOca0EHOYR0aVolcQaNgoj1biHAr8MCssC5L1DzXK4kGzoqBRluwEQ39I1ztTGe7w2c9qdSclzk/6gSTe0LcuJ5GMiZ14RO9iTXwWRof7Q/jdM96NsbCVrgGzgZkU2j6g91SWQdpC6YMiiPPdEiQfswupLBASZXSZKB8Nsq0G6Xfwjcwxtjsfaz6OzT21FMw4GmQQnzHxScZ8PP2c8zq+FawNAZp61OkZAguk6WmSJdHAWTgOosik7tWoB7nbq50yDk1gAlG20SFkMf7ikkFHSnZ+LNna01mVX/IlgwnXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(66946007)(66556008)(66476007)(8676002)(4326008)(86362001)(6506007)(6486002)(52116002)(38350700002)(30864003)(6666004)(2616005)(316002)(2906002)(6512007)(8936002)(7416002)(26005)(186003)(5660300002)(508600001)(54906003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hCuq/Udkh3QbiPNYgdXi4lJQJfGu+sEuPC1WYQLXAiIvlCQFYl+TJ/CaknuN?=
 =?us-ascii?Q?D74fF2v4L+b42k8ji21j5k4PgL5lb5hgQ25+YEQDm6hNksBJOcyNoJgt3qgM?=
 =?us-ascii?Q?WtQ6sMl+j5YJ8ZSAEJ9H1l38eGb+bWsRSooFg+vHHPraNW6FSOH2YBlD7tYN?=
 =?us-ascii?Q?Q18LXkRCKyGFnuqeaLvVX93kgA/7PA4F1Su53KgP3croMk1Xu/vsq9+37MVS?=
 =?us-ascii?Q?GFWFs2NAqueftGUY83O4fnNfz1YiYLxyHXdE1HJOWhdlLiE0P55m/BS9I78E?=
 =?us-ascii?Q?WSqpbvqhhx1fMrHZndl47lOC1d5TyvAdUngzd66RkMytW3JaIwxD903GLqZw?=
 =?us-ascii?Q?HX4p/fXOXc7lhxALhDnTdHUecERdjaCKl+RKL25SL0F3KqK8nMLg9IG0ptyw?=
 =?us-ascii?Q?IF1XcrNH8LhkFMtO5bkHgosdpfsK7uJTVlkRmk77MaT2mZVky84EcG3xCdpE?=
 =?us-ascii?Q?iN8Hz/S0sqDT9hNRzfKc2HcaaBkwbVHbha/HdBUX/uvJFKQ053yz1x8z5TcG?=
 =?us-ascii?Q?0mxFnKyI97dE9IWb96QZ/q5/QT0In5rnc4bBydOUq6K3rbqkw7WO3uClPC2d?=
 =?us-ascii?Q?h3VnUE968jF9L9Cg2Wyeig5kzmNwdHkN2kCYq0FL2Pnch2SuQf/7pIBAuhiz?=
 =?us-ascii?Q?FGxYr1yoq0UaJOrB+QUu1bOFofKiOs5p4QUjZeNfDv7A1WY2k6egk516fR7O?=
 =?us-ascii?Q?yJwqmoJZFEU0Dwt3uOqEYdHctx/1PMz//yxnyB7/lFTrLtOUrS0DUm3q2Fam?=
 =?us-ascii?Q?thKewPsh3VQ/VUyrAPfQ+nPv7W1/R6YCEBtk2YQxXlBoc4DKKdUGoMsziJwR?=
 =?us-ascii?Q?GIr8aC0QgE3ZprgAbNJqUE6ETlHcUESFhQRxlWsjp1fy95JqWDtmnbUFS6Gu?=
 =?us-ascii?Q?yyYfmEtIYOug63FW48XWML8hTWieND3Yg8eV07IFNulUfhKTiGkG5HXXtxGs?=
 =?us-ascii?Q?M3kImZMtDA43MLnCzQJtBHIDVfzw0rjj8jtkE+eLd4vVZuHAWaNz4LNFmmmv?=
 =?us-ascii?Q?fU0YwspcvLmM5k80ISFy8C5ti0Ix/5NztpaK2pEegYZDiFhZyVzxUbqXqFI4?=
 =?us-ascii?Q?duR6cIz+EnvmNQzZsRQ2eHOPBzS9xpH8X15nYUdIvMvKABVqscUabVD9boVL?=
 =?us-ascii?Q?D1zkOuIqiBzpZCDYMYtZJ3dYAuidsVmFnLaoIQs/LaPK1GLrCDdzVJLg5kg2?=
 =?us-ascii?Q?xM4j4FFcXBBvRpL7Fc8sWcQ6fQRcNg3rw7PPsfKasb2O62cE8oY824sAt8iW?=
 =?us-ascii?Q?yTJ96YO1eQjJdWTumw41TtX4G2F1khSkrHZFtYhF6O9yxm/iFxPBYxDSq1wh?=
 =?us-ascii?Q?MbjxB2Vgbw4fmIzzxLCeE5tKt+x3fVLPgPJnLMkTNbrPhSwY0PfZLJV3cdJy?=
 =?us-ascii?Q?jftfgoahkpX2WJIqIASD3LQqeDeMQ5r8uU7dyngqxZXDjAPAONqQ3oP6CpSp?=
 =?us-ascii?Q?zSeqFPb5LsINphjiB387sQ65fXqjLBTLNPEN4m2UC6G8eQ9kC2pTMRldqYhd?=
 =?us-ascii?Q?2ykYlRtW9Frzi4S/CJpv/ZYwde5HD3R9DylCf53hcY8KVp2v+lgxRPimUGFx?=
 =?us-ascii?Q?8GdpqhVvQ5dR/uAD6OpnlKeThdzWI6+bkUcMfv/UNSvCJKaxl9ZFZq2Up/+6?=
 =?us-ascii?Q?slNWtTOZrLOwlsYa0Kd6FcU=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d01706-ecd5-402a-2c18-08d9fa558cbf
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 00:59:19.3420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TIeuDwb8c8z7RAeWGc/uQgDNzHaJ+FHZiJDus5clvHK/S7KWBKK8vVYafful5u2EjNnFFdhUfIqFDVRy/INkUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5412
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

V2:
 None

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

