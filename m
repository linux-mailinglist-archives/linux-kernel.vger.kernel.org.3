Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D76D53A0E1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 11:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351213AbiFAJln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 05:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351313AbiFAJlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 05:41:09 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2086.outbound.protection.outlook.com [40.107.22.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53CA79399;
        Wed,  1 Jun 2022 02:41:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SHbtYo39ui4QuheA3WrgR5tOUBnwjFwbwX7QnDF1zxLJbRCD68wH4S5k/gwJdrjz2fguJf5/S2W4eL8wQnbY1Y81D+krpJ2KACkWhh6WPEdWgRJ6w+cf1AwnBzVyp1AvbTXYY/l2fDnxIdYtI1QV0a+zuzlBmnsEH2nysTjx1beWynmLJzGSpU4wn7vRnQ3iBmJdRnrT+6yPuP1CpigCfyfEjEpRmUnhONAjWFk8JveaeRIa4BgJDPXlwoyAHg6LL3X/hejtJB1xMSEN30JvRSxJLv5dRAT4zmpVzYezsvECaieqmzNfmTCMtFWLS+yJboUmd1belbdknTH0dYn84g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXmHcJ3MLtbtxDCWLcOJx1jbJ+ahJkHD+wX6ZjFXmMU=;
 b=B2oqZv3E5nofYIUH7+W3Vsuzrn6P09zO90DcyTogsKjhNduele5nvRWFNeI4qbi61JJOGLfD3zPpJkS83Xpz/P0QY/zRmmO/Eg13N/juPeo0vcgPdoFl89xkkfZjTJeBcjE4JChhuh6fATc2o5ZFgHO8MLAx3fux76mmYVYfxTbvJ321DRM33kWJGxc3KEPdpTGmlgDFs/PszxkJw2fyefJ69IEXzO02zNoCdqzzdZGD5T+Xh16YQwjHjVeAzWkBac4FSjTYwIYewDDvShHcxD/PndYj7TeuOL+r9x0QvvYOXLcp3AV1s82/ShoLiUzHLW+C/w8trS0rpuPiww3UXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXmHcJ3MLtbtxDCWLcOJx1jbJ+ahJkHD+wX6ZjFXmMU=;
 b=RLAtoGr2sObLnErvNQbDwHK8xJActyLLe+U8D9fJo4G8bfsla+8WVRJ8IO66kEdwAxdiUOAFSfFkcoiBa3rMVwxQwA6YqMvf5ngUKNtUqW0CfqdhnBlFt/Cus3mLeVMo6Rltghny4+O8kySffWa9AfxgaZ+dQYLh9MXnzzbMvXI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by HE1PR0401MB2441.eurprd04.prod.outlook.com (2603:10a6:3:7e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Wed, 1 Jun
 2022 09:41:03 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%9]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 09:41:03 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     djakov@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, abel.vesa@nxp.com,
        abailon@baylibre.com, l.stach@pengutronix.de,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, Markus.Niebel@ew.tq-group.com,
        aford173@gmail.com
Cc:     kernel@pengutronix.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 8/8] interconnect: imx: Add platform driver for imx8mp
Date:   Wed,  1 Jun 2022 17:41:56 +0800
Message-Id: <20220601094156.3388454-9-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220601094156.3388454-1-peng.fan@oss.nxp.com>
References: <20220601094156.3388454-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0078.apcprd02.prod.outlook.com
 (2603:1096:4:90::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6a0f9d3-c834-4187-7b27-08da43b2d774
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2441:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <HE1PR0401MB2441F62DFDD2A97DC5ADCD89C9DF9@HE1PR0401MB2441.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D9Qd+ovyLFLq00PyQ8A793aMR5k6qnG3V+Q65NAZJT+LKya8dnlDIvvhtg1hotRJ4q5Iitmltw8kZvLYLHZlQ8EvMRwll3xeoYHgExYPaF5BFXman+aSTq7ZqeCsGroPvIYcZekc3hp9+tMz32eLileCgRFFKHH8a86WYOXKjAaj79zfP83oJaYqX4g8jz/j1TCsxr5tvRSPirQpeiL+rrBcsZv9jg70I5CzGNL5gntyPvNqYT2+JSTXp7KAAVw+nNlq6R+JVILWzow0iOguaYW6c7w5ts644rMJWvFlM2kwdctwPj5RrOfuaMTUD6VC2GOzZ5CfhWEZEBc/8VG22Au/AlOnaJtRcZX8RupRqlR+dAeF8+kSh9gnBFCIHmfgZTIpeXyz3OHPNGRcFD86l2+nh8vZPiJ66yBLkxBBlO86Sb++iZcQPZ23OpxjmsT9pbABpVuJqnVWS3nD/I8PrLr1LXzbrCxa3yV6jqwrrj4XfKH1gSqY2InBGaG9eKeKvIpkBFHLAtjjYzLQtEJwRXxiUor7wU+ftv2nYV2L3u7xhJKkgyxkOxLhbrzPvya/oWuvRkucBc8CAH2D+ZRSE0xbgifI8k71v2IYvts4Ci4DCOJkgZ6VrWcK0qyLXcdpqldZACou9RVdG7qwohIw7LpPHJwD+BZ38i3A07xxVT8udl03Zdbt8MF6un1sCe3Kb66ViAZvazAv7UOIvdIxibVEU75Ez5XfTo5XIHRXCGeUjwJS637o+Sb8YwyS3ym4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(66476007)(66556008)(86362001)(38100700002)(7416002)(30864003)(38350700002)(316002)(52116002)(1076003)(8936002)(186003)(5660300002)(2616005)(4326008)(8676002)(508600001)(6666004)(6506007)(6512007)(26005)(921005)(6486002)(2906002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ACb0xy4GZKKsxUqC0MNdydZOT+hWewwAOmJOlrBDOhRYQraYh0SOtr0TDnGc?=
 =?us-ascii?Q?E4CHYU0wAg7/pMPFTe8nHRqA/zlieO3yne/YUyPEVXAztC6Hx3TC9kvyI2mv?=
 =?us-ascii?Q?zA98y9pZeoKXvdVQurJB4rYXXG6Vgt36/+6N2kLfocHjFgeNxLOP30Yz1cUg?=
 =?us-ascii?Q?GokqiuYii7RJT0tgIELEUCcPkd40pR5tUGB6R2/7OybkTNSWBG17cZKk8sOP?=
 =?us-ascii?Q?VZQgqEUdtFU7CULYVGIUgHK5Qo6WWiOCwPfwZzigtV909WihOR+MD6EQnM9L?=
 =?us-ascii?Q?zeI3jSp9nJbXby0PvMXXNUp9TnxrykZGzs0Yw4BzDOLp4rZjNTE1eYtvqkZR?=
 =?us-ascii?Q?f50hkxcLXGkRZia3Bv0HfnU7Do/bpuokX/ZL1/ck5S7wT3JGuK8Nsz1GUp1p?=
 =?us-ascii?Q?wsCARbiBHIvX0mD4WGX+PagawgcmkVRkXl7G/saZGIoP4ELgRPWpDlFW0fUN?=
 =?us-ascii?Q?JEAOzjlXO3hfq/jhL2HgoXGXWu83FEmczrZ3oby/NzVSJ9U+7V7Nf1Y3JIWG?=
 =?us-ascii?Q?Ake4Wdn3MHQ1ySJSFSli9nQ5AhG1L3jsmvNL9TY1yd9dRJXbTMEB+zePFm9+?=
 =?us-ascii?Q?qYCG+m9jkSwOCK7uJdJdeltp/doOPLFG4vLgWBodl1fECkFnuoBKOUnVsmPp?=
 =?us-ascii?Q?CrrnWiTHH+VI00YtK/g1T0B6VitkMte4fusGnZSRq/r89IDnyzKvlA79P3yP?=
 =?us-ascii?Q?qcWW6KtyKQ8X8+LgQ07q26n0ymfp0HXCV8qle7gm4sPrxsBVf59VJictUKRB?=
 =?us-ascii?Q?j4cU58ZetxW9PYC4EsKZ26cayt8FKvsH78TWaUfRLjSz0ry0EKwBT8T7XMUU?=
 =?us-ascii?Q?jgzjFTjN1uthjUR0+3cVe901u2PoT5R5/fbSIQSTvGPziri7NGfJ3Ha434mG?=
 =?us-ascii?Q?Eu1Q/2zm5fsaI3Kr0pOZnMtX/fUqbMsi30EDQrBVDXotMZiLyE+4G2fjUkAK?=
 =?us-ascii?Q?25ENz/D/M188WK7v6ojUq3SIErWFf2FJW6qadbZ6GT83Nm83eQftlMpmrHt6?=
 =?us-ascii?Q?J14ahPdFmM3ceJwCS+DFRkuaxbCztDA7+9CRcZIzVYNDszR+9qe5Bq7dHuoN?=
 =?us-ascii?Q?JD3aFywOwaSbTqpwwiPkze1LaC3WqxWR7qAiOPkDyf1NsTyzteI56cFkj1r3?=
 =?us-ascii?Q?uVSH7LzVcX9r5O2W0qSOef1aWsRyjAKNpvso2c6R4ncPRNdePhrgp5eKhWUE?=
 =?us-ascii?Q?EuLFeARB39RWonbhUJDWo6+hsHatCVwzB4GJcabHBzJdZJ7r85fbbt1QrSjX?=
 =?us-ascii?Q?qZEOFbGTxTG/IvsHNS6BGrnLOL4YXtyQP11dHJ/OyHBRzDnI4sy7tXz07Ty6?=
 =?us-ascii?Q?hC1FDY9CQ/xJqKlNTBxspdFvnsWcdps4MasPwVAGvvlFZ/zYVhtjuN4MTIal?=
 =?us-ascii?Q?ofmtC803Tgcour8OY50VXMOw33zY1GU5nWi1L1Zd+0Gtgs69YMryTrGGagWr?=
 =?us-ascii?Q?k68AVXy/BZP/85tQ02PLuVM6pe7s26+/az/uSm1rMOWh4jb4G78Oq6EYFviG?=
 =?us-ascii?Q?ThmJ7MmfLG63OpTw9APYJ9UJ/nMasQ8ctu0La09ME0IfXAqPbuB6+fk8KZa3?=
 =?us-ascii?Q?VYuWS5t43b2/y7mKhLK1cGyjgbZpWCVA7Lgq8sTJxCgGaoliRjzGN97oWy1V?=
 =?us-ascii?Q?zT3DMW3Nm5Ug88lulVcjoLkP9hTvOidFct2bRURlk141coSXEpVoOgE/lJxi?=
 =?us-ascii?Q?yZ1m5quKCjDe5GM/pi6tPuGVAqBv9Kidw4TD3sXPhR/YwgEmnvTuBY4rSH4Z?=
 =?us-ascii?Q?iVKjXnSJMQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a0f9d3-c834-4187-7b27-08da43b2d774
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 09:41:03.0271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZuDmMcJrPbIztjMst2bnuZiPS7+7ox73UpCzfc1y4DC8vAfwRaMDhTfC/PwBpPOOEQKNiWVfOg/0J8+zBnO54w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2441
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add a platform driver for the i.MX8MP SoC describing bus topology, based
on internal documentation.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/interconnect/imx/Kconfig              |   4 +
 drivers/interconnect/imx/Makefile             |   2 +
 drivers/interconnect/imx/imx8mp.c             | 232 ++++++++++++++++++
 include/dt-bindings/interconnect/fsl,imx8mp.h |  59 +++++
 4 files changed, 297 insertions(+)
 create mode 100644 drivers/interconnect/imx/imx8mp.c
 create mode 100644 include/dt-bindings/interconnect/fsl,imx8mp.h

diff --git a/drivers/interconnect/imx/Kconfig b/drivers/interconnect/imx/Kconfig
index be2928362bb7..c772552431f5 100644
--- a/drivers/interconnect/imx/Kconfig
+++ b/drivers/interconnect/imx/Kconfig
@@ -15,3 +15,7 @@ config INTERCONNECT_IMX8MN
 config INTERCONNECT_IMX8MQ
 	tristate "i.MX8MQ interconnect driver"
 	depends on INTERCONNECT_IMX
+
+config INTERCONNECT_IMX8MP
+	tristate "i.MX8MP interconnect driver"
+	depends on INTERCONNECT_IMX
diff --git a/drivers/interconnect/imx/Makefile b/drivers/interconnect/imx/Makefile
index 21fd5233754f..16d256cdeab4 100644
--- a/drivers/interconnect/imx/Makefile
+++ b/drivers/interconnect/imx/Makefile
@@ -2,8 +2,10 @@ imx-interconnect-objs			:= imx.o
 imx8mm-interconnect-objs       		:= imx8mm.o
 imx8mq-interconnect-objs       		:= imx8mq.o
 imx8mn-interconnect-objs       		:= imx8mn.o
+imx8mp-interconnect-objs       		:= imx8mp.o
 
 obj-$(CONFIG_INTERCONNECT_IMX)		+= imx-interconnect.o
 obj-$(CONFIG_INTERCONNECT_IMX8MM)	+= imx8mm-interconnect.o
 obj-$(CONFIG_INTERCONNECT_IMX8MQ)	+= imx8mq-interconnect.o
 obj-$(CONFIG_INTERCONNECT_IMX8MN)	+= imx8mn-interconnect.o
+obj-$(CONFIG_INTERCONNECT_IMX8MP)	+= imx8mp-interconnect.o
diff --git a/drivers/interconnect/imx/imx8mp.c b/drivers/interconnect/imx/imx8mp.c
new file mode 100644
index 000000000000..f13683ac941c
--- /dev/null
+++ b/drivers/interconnect/imx/imx8mp.c
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Interconnect framework driver for i.MX8MP SoC
+ *
+ * Copyright 2022 NXP
+ * Peng Fan <peng.fan@nxp.com>
+ */
+
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <dt-bindings/interconnect/fsl,imx8mp.h>
+
+#include "imx.h"
+
+static const struct imx_icc_node_adj_desc imx8mp_noc_adj = {
+	.bw_mul = 1,
+	.bw_div = 16,
+	.main_noc = true,
+};
+
+static struct imx_icc_noc_setting noc_setting_nodes[] = {
+	[IMX8MP_ICM_MLMIX] = {
+		.reg = 0x180,
+		.prio_level = 0x80000303,
+	},
+	[IMX8MP_ICM_DSP] = {
+		.reg = 0x200,
+		.prio_level = 0x80000303,
+	},
+	[IMX8MP_ICM_SDMA2PER] = {
+		.reg = 0x280,
+		.prio_level = 0x80000404,
+	},
+	[IMX8MP_ICM_SDMA2BURST] = {
+		.reg = 0x300,
+		.prio_level = 0x80000404,
+	},
+	[IMX8MP_ICM_SDMA3PER] = {
+		.reg = 0x380,
+		.prio_level = 0x80000404,
+	},
+	[IMX8MP_ICM_SDMA3BURST] = {
+		.reg = 0x400,
+		.prio_level = 0x80000404,
+	},
+	[IMX8MP_ICM_EDMA] = {
+		.reg = 0x480,
+		.prio_level = 0x80000404,
+	},
+	[IMX8MP_ICM_GPU3D] = {
+		.reg = 0x500,
+		.prio_level = 0x80000303,
+	},
+	[IMX8MP_ICM_GPU2D] = {
+		.reg = 0x580,
+		.prio_level = 0x80000303,
+	},
+	[IMX8MP_ICM_HRV] = {
+		.reg = 0x600,
+		.prio_level = 0x80000202,
+		.ext_control = 1,
+	},
+	[IMX8MP_ICM_LCDIF_HDMI] = {
+		.reg = 0x680,
+		.prio_level = 0x80000202,
+		.ext_control = 1,
+	},
+	[IMX8MP_ICM_HDCP] = {
+		.reg = 0x700,
+		.prio_level = 0x80000505,
+	},
+	[IMX8MP_ICM_NOC_PCIE] = {
+		.reg = 0x780,
+		.prio_level = 0x80000303,
+	},
+	[IMX8MP_ICM_USB1] = {
+		.reg = 0x800,
+		.prio_level = 0x80000303,
+	},
+	[IMX8MP_ICM_USB2] = {
+		.reg = 0x880,
+		.prio_level = 0x80000303,
+	},
+	[IMX8MP_ICM_PCIE] = {
+		.reg = 0x900,
+		.prio_level = 0x80000303,
+	},
+	[IMX8MP_ICM_LCDIF_RD] = {
+		.reg = 0x980,
+		.prio_level = 0x80000202,
+		.ext_control = 1,
+	},
+	[IMX8MP_ICM_LCDIF_WR] = {
+		.reg = 0xa00,
+		.prio_level = 0x80000202,
+		.ext_control = 1,
+	},
+	[IMX8MP_ICM_ISI0] = {
+		.reg = 0xa80,
+		.prio_level = 0x80000202,
+		.ext_control = 1,
+	},
+	[IMX8MP_ICM_ISI1] = {
+		.reg = 0xb00,
+		.prio_level = 0x80000202,
+		.ext_control = 1,
+	},
+	[IMX8MP_ICM_ISI2] = {
+		.reg = 0xb80,
+		.prio_level = 0x80000202,
+		.ext_control = 1,
+	},
+	[IMX8MP_ICM_ISP0] = {
+		.reg = 0xc00,
+		.prio_level = 0x80000707,
+	},
+	[IMX8MP_ICM_ISP1] = {
+		.reg = 0xc80,
+		.prio_level = 0x80000707,
+	},
+	[IMX8MP_ICM_DWE] = {
+		.reg = 0xd00,
+		.prio_level = 0x80000707,
+	},
+	[IMX8MP_ICM_VPU_G1] = {
+		.reg = 0xd80,
+		.prio_level = 0x80000303,
+	},
+	[IMX8MP_ICM_VPU_G2] = {
+		.reg = 0xe00,
+		.prio_level = 0x80000303,
+	},
+	[IMX8MP_ICM_VPU_H1] = {
+		.reg = 0xe80,
+		.prio_level = 0x80000303,
+	},
+	[IMX8MP_ICN_MEDIA] = {
+		.ignore = true,
+	},
+	[IMX8MP_ICN_VIDEO] = {
+		.ignore = true,
+	},
+	[IMX8MP_ICN_AUDIO] = {
+		.ignore = true,
+	},
+	[IMX8MP_ICN_HDMI] = {
+		.ignore = true,
+	},
+	[IMX8MP_ICN_GPU] = {
+		.ignore = true,
+	},
+	[IMX8MP_ICN_HSIO] = {
+		.ignore = true,
+	},
+};
+
+/* Describe bus masters, slaves and connections between them */
+static struct imx_icc_node_desc nodes[] = {
+	DEFINE_BUS_INTERCONNECT("NOC", IMX8MP_ICN_NOC, &imx8mp_noc_adj,
+				IMX8MP_ICS_DRAM, IMX8MP_ICN_MAIN),
+
+	DEFINE_BUS_SLAVE("OCRAM", IMX8MP_ICS_OCRAM, NULL),
+	DEFINE_BUS_SLAVE("DRAM", IMX8MP_ICS_DRAM, NULL),
+	DEFINE_BUS_MASTER("A53", IMX8MP_ICM_A53, IMX8MP_ICN_NOC),
+	DEFINE_BUS_MASTER("SUPERMIX", IMX8MP_ICM_SUPERMIX, IMX8MP_ICN_NOC),
+	DEFINE_BUS_MASTER("GIC", IMX8MP_ICM_GIC, IMX8MP_ICN_NOC),
+	DEFINE_BUS_MASTER("MLMIX", IMX8MP_ICM_MLMIX, IMX8MP_ICN_NOC),
+
+	DEFINE_BUS_INTERCONNECT("NOC_AUDIO", IMX8MP_ICN_AUDIO, NULL, IMX8MP_ICN_NOC),
+	DEFINE_BUS_MASTER("DSP", IMX8MP_ICM_DSP, IMX8MP_ICN_AUDIO),
+	DEFINE_BUS_MASTER("SDMA2PER", IMX8MP_ICM_SDMA2PER, IMX8MP_ICN_AUDIO),
+	DEFINE_BUS_MASTER("SDMA2BURST", IMX8MP_ICM_SDMA2BURST, IMX8MP_ICN_AUDIO),
+	DEFINE_BUS_MASTER("SDMA3PER", IMX8MP_ICM_SDMA3PER, IMX8MP_ICN_AUDIO),
+	DEFINE_BUS_MASTER("SDMA3BURST", IMX8MP_ICM_SDMA3BURST, IMX8MP_ICN_AUDIO),
+	DEFINE_BUS_MASTER("EDMA", IMX8MP_ICM_EDMA, IMX8MP_ICN_AUDIO),
+
+	DEFINE_BUS_INTERCONNECT("NOC_GPU", IMX8MP_ICN_GPU, NULL, IMX8MP_ICN_NOC),
+	DEFINE_BUS_MASTER("GPU 2D", IMX8MP_ICM_GPU2D, IMX8MP_ICN_GPU),
+	DEFINE_BUS_MASTER("GPU 3D", IMX8MP_ICM_GPU3D, IMX8MP_ICN_GPU),
+
+	DEFINE_BUS_INTERCONNECT("NOC_HDMI", IMX8MP_ICN_HDMI, NULL, IMX8MP_ICN_NOC),
+	DEFINE_BUS_MASTER("HRV", IMX8MP_ICM_HRV, IMX8MP_ICN_HDMI),
+	DEFINE_BUS_MASTER("LCDIF_HDMI", IMX8MP_ICM_LCDIF_HDMI, IMX8MP_ICN_HDMI),
+	DEFINE_BUS_MASTER("HDCP", IMX8MP_ICM_HDCP, IMX8MP_ICN_HDMI),
+
+	DEFINE_BUS_INTERCONNECT("NOC_HSIO", IMX8MP_ICN_HSIO, NULL, IMX8MP_ICN_NOC),
+	DEFINE_BUS_MASTER("NOC_PCIE", IMX8MP_ICM_NOC_PCIE, IMX8MP_ICN_HSIO),
+	DEFINE_BUS_MASTER("USB1", IMX8MP_ICM_USB1, IMX8MP_ICN_HSIO),
+	DEFINE_BUS_MASTER("USB2", IMX8MP_ICM_USB2, IMX8MP_ICN_HSIO),
+	DEFINE_BUS_MASTER("PCIE", IMX8MP_ICM_PCIE, IMX8MP_ICN_HSIO),
+
+	DEFINE_BUS_INTERCONNECT("NOC_MEDIA", IMX8MP_ICN_MEDIA, NULL, IMX8MP_ICN_NOC),
+	DEFINE_BUS_MASTER("LCDIF_RD", IMX8MP_ICM_LCDIF_RD, IMX8MP_ICN_MEDIA),
+	DEFINE_BUS_MASTER("LCDIF_WR", IMX8MP_ICM_LCDIF_WR, IMX8MP_ICN_MEDIA),
+	DEFINE_BUS_MASTER("ISI0", IMX8MP_ICM_ISI0, IMX8MP_ICN_MEDIA),
+	DEFINE_BUS_MASTER("ISI1", IMX8MP_ICM_ISI1, IMX8MP_ICN_MEDIA),
+	DEFINE_BUS_MASTER("ISI2", IMX8MP_ICM_ISI2, IMX8MP_ICN_MEDIA),
+	DEFINE_BUS_MASTER("ISP0", IMX8MP_ICM_ISP0, IMX8MP_ICN_MEDIA),
+	DEFINE_BUS_MASTER("ISP1", IMX8MP_ICM_ISP1, IMX8MP_ICN_MEDIA),
+	DEFINE_BUS_MASTER("DWE", IMX8MP_ICM_DWE, IMX8MP_ICN_MEDIA),
+
+	DEFINE_BUS_INTERCONNECT("NOC_VIDEO", IMX8MP_ICN_VIDEO, NULL, IMX8MP_ICN_NOC),
+	DEFINE_BUS_MASTER("VPU G1", IMX8MP_ICM_VPU_G1, IMX8MP_ICN_VIDEO),
+	DEFINE_BUS_MASTER("VPU G2", IMX8MP_ICM_VPU_G2, IMX8MP_ICN_VIDEO),
+	DEFINE_BUS_MASTER("VPU H1", IMX8MP_ICM_VPU_H1, IMX8MP_ICN_VIDEO),
+	DEFINE_BUS_INTERCONNECT("PL301_MAIN", IMX8MP_ICN_MAIN, NULL,
+				IMX8MP_ICN_NOC, IMX8MP_ICS_OCRAM),
+};
+
+static int imx8mp_icc_probe(struct platform_device *pdev)
+{
+	return imx_icc_register(pdev, nodes, ARRAY_SIZE(nodes), noc_setting_nodes);
+}
+
+static int imx8mp_icc_remove(struct platform_device *pdev)
+{
+	return imx_icc_unregister(pdev);
+}
+
+static struct platform_driver imx8mp_icc_driver = {
+	.probe = imx8mp_icc_probe,
+	.remove = imx8mp_icc_remove,
+	.driver = {
+		.name = "imx8mp-interconnect",
+	},
+};
+
+module_platform_driver(imx8mp_icc_driver);
+MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:imx8mp-interconnect");
diff --git a/include/dt-bindings/interconnect/fsl,imx8mp.h b/include/dt-bindings/interconnect/fsl,imx8mp.h
new file mode 100644
index 000000000000..732547577c76
--- /dev/null
+++ b/include/dt-bindings/interconnect/fsl,imx8mp.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Interconnect framework driver for i.MX SoC
+ *
+ * Copyright 2022 NXP
+ * Peng Fan <peng.fan@nxp.com>
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_IMX8MP_H
+#define __DT_BINDINGS_INTERCONNECT_IMX8MP_H
+
+#define IMX8MP_ICN_NOC		0
+#define IMX8MP_ICN_MAIN		1
+#define IMX8MP_ICS_DRAM		2
+#define IMX8MP_ICS_OCRAM	3
+#define IMX8MP_ICM_A53		4
+#define IMX8MP_ICM_SUPERMIX	5
+#define IMX8MP_ICM_GIC		6
+#define IMX8MP_ICM_MLMIX	7
+
+#define IMX8MP_ICN_AUDIO	8
+#define IMX8MP_ICM_DSP		9
+#define IMX8MP_ICM_SDMA2PER	10
+#define IMX8MP_ICM_SDMA2BURST	11
+#define IMX8MP_ICM_SDMA3PER	12
+#define IMX8MP_ICM_SDMA3BURST	13
+#define IMX8MP_ICM_EDMA		14
+
+#define IMX8MP_ICN_GPU		15
+#define IMX8MP_ICM_GPU2D	16
+#define IMX8MP_ICM_GPU3D	17
+
+#define IMX8MP_ICN_HDMI		18
+#define IMX8MP_ICM_HRV		19
+#define IMX8MP_ICM_LCDIF_HDMI	20
+#define IMX8MP_ICM_HDCP		21
+
+#define IMX8MP_ICN_HSIO		22
+#define IMX8MP_ICM_NOC_PCIE	23
+#define IMX8MP_ICM_USB1		24
+#define IMX8MP_ICM_USB2		25
+#define IMX8MP_ICM_PCIE		26
+
+#define IMX8MP_ICN_MEDIA	27
+#define IMX8MP_ICM_LCDIF_RD	28
+#define IMX8MP_ICM_LCDIF_WR	29
+#define IMX8MP_ICM_ISI0		30
+#define IMX8MP_ICM_ISI1		31
+#define IMX8MP_ICM_ISI2		32
+#define IMX8MP_ICM_ISP0		33
+#define IMX8MP_ICM_ISP1		34
+#define IMX8MP_ICM_DWE		35
+
+#define IMX8MP_ICN_VIDEO	36
+#define IMX8MP_ICM_VPU_G1	37
+#define IMX8MP_ICM_VPU_G2	38
+#define IMX8MP_ICM_VPU_H1	39
+
+#endif /* __DT_BINDINGS_INTERCONNECT_IMX8MP_H */
-- 
2.25.1

