Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E25564635
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 11:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbiGCJLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 05:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbiGCJLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 05:11:00 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2066.outbound.protection.outlook.com [40.107.21.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66CA6389;
        Sun,  3 Jul 2022 02:10:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Geo0+SVv6MmP11AEVuUi93vWh/jC9pSFiwfVhm/fDbHJruTDh2bRJD8Gh82ui9uVJHuHiJmafDGzE+D57fY77tShC7ma5Udyi9rB8yVsUW8AlGlAIN0sfgctNqLDI6wctoMYtCbKoGjcxJurH2mnanVFkzjnq1mCn5fSIl7oxy3eX356fz6zagdzMUZQFLKH/zigghPwGP24RTzoSi6eMQJaQUqGKQWExRop2IBNzo4kQ45TAqWCkxmN7EsXvSB/lxLU0rWsWVdEZydfVvN//Kyi4PZkGCFbMEGKkkhqaePbwgWzflv2LtdZKtEbNhXLA4Z3CqZ8g15D5/sIYqB21g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0gvyVhO8d6zKCc9sZBbin9+hFld36hUitEtcmitD1w=;
 b=flR06oZGAB72JkHpDkN7i52nwqrbCQXYDTJ06ChO2HzHDck6h2EW8EQLteHQJsB2M/okWMxrXIp4UNHyJZHrQAjDGsnqovdI89duIvS1wcNpKss39jAFUUdWcoUcQySOYv6Ou/Z6ntw0hLbJJJLuWSXM5N5vHA5JWLGwVqE/FqCsaJImIlvMVsoIlycVqLSnAECN0FljsgWErf9SYYElKxwciLhGAIQ6c+ib+s3B2GC29u/DvtPHyQqZL6tJSSO+ixA9atJWdCS+0QhE8RxZ/CjJYJ0nHHVWqxTsh507NKJV0Esg02jyYhnn5wPiuKWSXrRoVNjJGIGyWYXwrgXarg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0gvyVhO8d6zKCc9sZBbin9+hFld36hUitEtcmitD1w=;
 b=h8YF9YODMmz0QnbnUV5qUWrf+l/XTK0HW+4Cg4vZiJLj9WqjBVUBbl2neEosaV1ABvBL6sRm/4wH395fB2ux1VhVZeEQeIyGU/xQodDqx2etOaZje302O+5Cr/bhlVqZJT2cnz3/A4BJIk9QkpgXUyPqm+RPdMFfWcHGWZT5uaw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB6165.eurprd04.prod.outlook.com (2603:10a6:20b:bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Sun, 3 Jul
 2022 09:10:55 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%5]) with mapi id 15.20.5395.018; Sun, 3 Jul 2022
 09:10:55 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     djakov@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, abel.vesa@nxp.com,
        abailon@baylibre.com, l.stach@pengutronix.de,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, Markus.Niebel@ew.tq-group.com,
        aford173@gmail.com, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, myungjoo.ham@samsung.com
Cc:     kernel@pengutronix.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        abelvesa@kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 08/10] interconnect: imx: Add platform driver for imx8mp
Date:   Sun,  3 Jul 2022 17:11:30 +0800
Message-Id: <20220703091132.1412063-9-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220703091132.1412063-1-peng.fan@oss.nxp.com>
References: <20220703091132.1412063-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0173.apcprd04.prod.outlook.com (2603:1096:4::35)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48d7e8cb-1c7c-4e6c-90d5-08da5cd3ef57
X-MS-TrafficTypeDiagnostic: AM6PR04MB6165:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KNa1UHc7J+Xdig36n0UagH5soK+ZyT9/anwcCycPG1cvtyg2F022XoVzTJ8pSgFfOyv13gG5bylcgN2BWU/PuhsTlRGEtFJCnu1Vf5HB7slUEC5dvEq+W6zD46iP446v7bo+Mr/qi7GDnpSwshKmUHVfdH/53YQN6bdmsy2GFflU9HvttvuXxitkypDtWH4ATxcLxgtxDTmW2eqF7Amdvb3lpPyUBU9qMlkurZFp8pn0awwJQvyx5XiWS6aQfk1/GHdMyJFv0P93RxzTvkWVq9MJYIWjZnyiKvXADoq6r25J7Ohg/lUdZZIgptcZ9gUxK+6u3e7JEauDxnSwKzRwg4qD0iYbNshme+yKIiacHYam4RF+0brLsH0p1WL7n4xLCgw52zwaIN128GIphZbqNDi8FWlSlsIa+3n1pT6qckNV3S74GhQA6Kv3LZhX7gw2ZPRNA9jxz/ugk+eP++TwY94GBQGg9M12Is0brPWgdPa1yc1nG+JUvwukQ4z2+IyBY9WIXngsknrUcMPZhZ2/CWOIjEki4GujFB0x+QcjF1KTnCa6xZ+Ai4A4N8qkU1yfBIGh/FTKKScnlGSbYaZ8Eo04X+4FH8iBza7rNaAZMOhnkzYc7aAHjWGl+nmeyRfUJWQA3bJ2+vRfSIvO1hgn6kR/JsbqswpwGCZn9rVJ4m2g9pnlCerlDrMGhUViywrr5FEUr6DYht1uokgOk2PO+1JoCqi8b+RtSUFJYGTsJXQEI4X6xsolc3YcoMZmaJJYvTRl83mOJnGbAtnhwUuSaXbBPH5mEAFwHZQ9i3lCJeWpzZpKoJ8gAoCXUlOgQdJk0wWJTMNOUY5Q8JhOZXVMJXt8qzxMLjohP3PfcosQCyg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(86362001)(921005)(38100700002)(38350700002)(5660300002)(6486002)(478600001)(8936002)(6666004)(2906002)(41300700001)(316002)(7416002)(4326008)(8676002)(66476007)(66556008)(66946007)(186003)(1076003)(6506007)(52116002)(26005)(2616005)(6512007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9Q9MXRXDwueYfh6JL0hfeAEEI2pntBG8btlASWMNQ8dllVt+7Td935WWiwzt?=
 =?us-ascii?Q?cCPIVxcKng+ZyaTF6GT+4w6KE5+meHrqpSTf1bZMLUMtQILGHi3pKnWIKVb1?=
 =?us-ascii?Q?JJo+nBcID9wlLBpaoRGBTbNbx3GE1sxCKvPPu12QNU1LIIYTg3tjKGOTEQwq?=
 =?us-ascii?Q?kwFxxyTn8nFuwIxH1cWnf/8lxx1NYKwTItU0Lfq3/CjH0WWowpRCWjG6AOqI?=
 =?us-ascii?Q?vayQJHC8mlWzmRRjsIitlpEMIoUi85xkCpeAoBdnl/zJaQKv5vxXP9j/7MHF?=
 =?us-ascii?Q?bw2O3aUpQ7Y2Tf2bIe4bd6PxxQnwn7JnzNi7i6EMfePisMsHyfv4FBPqE2jG?=
 =?us-ascii?Q?mTcnYBzvz80pgY3aOGW7yJl+EdtLMznc/tqwxgMCD+loyMnFLWZvvLHhI6nl?=
 =?us-ascii?Q?aqbduMuCWRJfWm8aQQPlVCKdxuYcJv/b4p75aXsCtYyrOfATJZ9KW+6wGBKp?=
 =?us-ascii?Q?Ueu9Nx1qyQKlHD8bYTefqSjIOB/VDC4e/3mO9849RRzN3MItLX21Jif2w76t?=
 =?us-ascii?Q?VgcXkfiSGfBjN3Q1CtrlPYCtyBgQXqjXVbaAkhqIK/+QsClMouvn5Cer1wO/?=
 =?us-ascii?Q?NNB4p+vWE5GkowF0Xb3wMQ6JeYHUYoyclq0Ee0xyhvA7yPk6KGmVdBVFaBe3?=
 =?us-ascii?Q?DPPXneux2Y9EUH3I4TwSqEeuS5YyZ0yR2Xo5imhMDnk583sPzAoMtFKZrqx0?=
 =?us-ascii?Q?OdJgLjsPnNYm8lOS+wxfEQg0xwBYU4atc5RHwVnXrebF7C6WpSQC9i6qGtP5?=
 =?us-ascii?Q?VDbKFsAH0mATXX73XIOulIQXwF8jqksRiY0ltd4sh0RGXIeQoMflG1Mqj2wS?=
 =?us-ascii?Q?fggsVrdiV3FogQ0hnPz2NwPVFJFFMG5HAN9TKJDFY3unCtg+zDf1P9ZlOMEd?=
 =?us-ascii?Q?U945nm3/bCqzyUAfGGVNP1iOhpf9RYwAJfUWZNeyvRMLZuYH2hGF8q1wve2J?=
 =?us-ascii?Q?NDzs+twUWm1OojMEweiPDpTOiyO5XS0lM/aQu3XksysMI5pCUE4TBRcqB2wi?=
 =?us-ascii?Q?yOh0i2ohqtSxSEwEA+Xfzf4LsS4KlkxfJq0ETdPpOcGuNpAeb4J15Xx/uMlt?=
 =?us-ascii?Q?2bV6GdMbpDB4xkV0CHaf2k7dnVu0h9d4q5rYs2WZtBoJEIUBRymBPuWGLjYp?=
 =?us-ascii?Q?UMAj7NjNQMN997cMAw5EUNUCfVvm/r56t2SO3u+TevGm5n27+xUDwp1USgtH?=
 =?us-ascii?Q?jVW2+GBchiIv7g8W96zM2jRffUc8Z1REpwYJITxJLq66Wmofw11qHgpC3s0i?=
 =?us-ascii?Q?X5jaAOVQmgYjg9Roz1RRGrlFmKm2xmr++EqcecSAk+SSe2xz4S6BmYrduVce?=
 =?us-ascii?Q?vA35LHcbq1FYkvwSW5/66wek7WAyCgMnlyws2m99nNVfH59ZT/mT+qvq3xul?=
 =?us-ascii?Q?fci2RMsVa56nagqf5eFVzZT95C6YeLRBl5PDeMb5pICdvaMSn2XspPHt/lfM?=
 =?us-ascii?Q?yO75oWJGakGwsaq1li/kUxrkknI12er9INIxn4IO33xtO81SyZq7LWxKhdYT?=
 =?us-ascii?Q?FovnZm4GWZbmmgitg1sxlZ/9svmm/S7iblkI4VuXEcUDFaT2jaoRk6k4A825?=
 =?us-ascii?Q?BcIKU+ua3Lv1BBqz3LU+6v2uydEjwTEIbNLPxE1E?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48d7e8cb-1c7c-4e6c-90d5-08da5cd3ef57
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2022 09:10:55.2819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G2KnPF8YPrZuZNfsQ0IXsFB1EcpY3zkCS7DOFqV5tZWSx6lIsWSNvkhlSTuimMYxQC6fdyfq6kD/UskHOzsV2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6165
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
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
 drivers/interconnect/imx/Kconfig  |   4 +
 drivers/interconnect/imx/Makefile |   2 +
 drivers/interconnect/imx/imx8mp.c | 259 ++++++++++++++++++++++++++++++
 3 files changed, 265 insertions(+)
 create mode 100644 drivers/interconnect/imx/imx8mp.c

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
index 000000000000..5f1c83ed157b
--- /dev/null
+++ b/drivers/interconnect/imx/imx8mp.c
@@ -0,0 +1,259 @@
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
+		.mode = IMX_NOC_MODE_FIXED,
+		.prio_level = 3,
+	},
+	[IMX8MP_ICM_DSP] = {
+		.reg = 0x200,
+		.mode = IMX_NOC_MODE_FIXED,
+		.prio_level = 3,
+	},
+	[IMX8MP_ICM_SDMA2PER] = {
+		.reg = 0x280,
+		.mode = IMX_NOC_MODE_FIXED,
+		.prio_level = 4,
+	},
+	[IMX8MP_ICM_SDMA2BURST] = {
+		.reg = 0x300,
+		.mode = IMX_NOC_MODE_FIXED,
+		.prio_level = 4,
+	},
+	[IMX8MP_ICM_SDMA3PER] = {
+		.reg = 0x380,
+		.mode = IMX_NOC_MODE_FIXED,
+		.prio_level = 4,
+	},
+	[IMX8MP_ICM_SDMA3BURST] = {
+		.reg = 0x400,
+		.mode = IMX_NOC_MODE_FIXED,
+		.prio_level = 4,
+	},
+	[IMX8MP_ICM_EDMA] = {
+		.reg = 0x480,
+		.mode = IMX_NOC_MODE_FIXED,
+		.prio_level = 4,
+	},
+	[IMX8MP_ICM_GPU3D] = {
+		.reg = 0x500,
+		.mode = IMX_NOC_MODE_FIXED,
+		.prio_level = 3,
+	},
+	[IMX8MP_ICM_GPU2D] = {
+		.reg = 0x580,
+		.mode = IMX_NOC_MODE_FIXED,
+		.prio_level = 3,
+	},
+	[IMX8MP_ICM_HRV] = {
+		.reg = 0x600,
+		.mode = IMX_NOC_MODE_FIXED,
+		.prio_level = 2,
+		.ext_control = 1,
+	},
+	[IMX8MP_ICM_LCDIF_HDMI] = {
+		.reg = 0x680,
+		.mode = IMX_NOC_MODE_FIXED,
+		.prio_level = 2,
+		.ext_control = 1,
+	},
+	[IMX8MP_ICM_HDCP] = {
+		.reg = 0x700,
+		.mode = IMX_NOC_MODE_FIXED,
+		.prio_level = 5,
+	},
+	[IMX8MP_ICM_NOC_PCIE] = {
+		.reg = 0x780,
+		.mode = IMX_NOC_MODE_FIXED,
+		.prio_level = 3,
+	},
+	[IMX8MP_ICM_USB1] = {
+		.reg = 0x800,
+		.mode = IMX_NOC_MODE_FIXED,
+		.prio_level = 3,
+	},
+	[IMX8MP_ICM_USB2] = {
+		.reg = 0x880,
+		.mode = IMX_NOC_MODE_FIXED,
+		.prio_level = 3,
+	},
+	[IMX8MP_ICM_PCIE] = {
+		.reg = 0x900,
+		.mode = IMX_NOC_MODE_FIXED,
+		.prio_level = 3,
+	},
+	[IMX8MP_ICM_LCDIF_RD] = {
+		.reg = 0x980,
+		.mode = IMX_NOC_MODE_FIXED,
+		.prio_level = 2,
+		.ext_control = 1,
+	},
+	[IMX8MP_ICM_LCDIF_WR] = {
+		.reg = 0xa00,
+		.mode = IMX_NOC_MODE_FIXED,
+		.prio_level = 2,
+		.ext_control = 1,
+	},
+	[IMX8MP_ICM_ISI0] = {
+		.reg = 0xa80,
+		.mode = IMX_NOC_MODE_FIXED,
+		.prio_level = 2,
+		.ext_control = 1,
+	},
+	[IMX8MP_ICM_ISI1] = {
+		.reg = 0xb00,
+		.mode = IMX_NOC_MODE_FIXED,
+		.prio_level = 2,
+		.ext_control = 1,
+	},
+	[IMX8MP_ICM_ISI2] = {
+		.reg = 0xb80,
+		.mode = IMX_NOC_MODE_FIXED,
+		.prio_level = 2,
+		.ext_control = 1,
+	},
+	[IMX8MP_ICM_ISP0] = {
+		.reg = 0xc00,
+		.mode = IMX_NOC_MODE_FIXED,
+		.prio_level = 7,
+	},
+	[IMX8MP_ICM_ISP1] = {
+		.reg = 0xc80,
+		.mode = IMX_NOC_MODE_FIXED,
+		.prio_level = 7,
+	},
+	[IMX8MP_ICM_DWE] = {
+		.reg = 0xd00,
+		.mode = IMX_NOC_MODE_FIXED,
+		.prio_level = 7,
+	},
+	[IMX8MP_ICM_VPU_G1] = {
+		.reg = 0xd80,
+		.mode = IMX_NOC_MODE_FIXED,
+		.prio_level = 3,
+	},
+	[IMX8MP_ICM_VPU_G2] = {
+		.reg = 0xe00,
+		.mode = IMX_NOC_MODE_FIXED,
+		.prio_level = 3,
+	},
+	[IMX8MP_ICM_VPU_H1] = {
+		.reg = 0xe80,
+		.mode = IMX_NOC_MODE_FIXED,
+		.prio_level = 3,
+	},
+	[IMX8MP_ICN_MEDIA] = {
+		.mode = IMX_NOC_MODE_UNCONFIGURED,
+	},
+	[IMX8MP_ICN_VIDEO] = {
+		.mode = IMX_NOC_MODE_UNCONFIGURED,
+	},
+	[IMX8MP_ICN_AUDIO] = {
+		.mode = IMX_NOC_MODE_UNCONFIGURED,
+	},
+	[IMX8MP_ICN_HDMI] = {
+		.mode = IMX_NOC_MODE_UNCONFIGURED,
+	},
+	[IMX8MP_ICN_GPU] = {
+		.mode = IMX_NOC_MODE_UNCONFIGURED,
+	},
+	[IMX8MP_ICN_HSIO] = {
+		.mode = IMX_NOC_MODE_UNCONFIGURED,
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
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:imx8mp-interconnect");
-- 
2.25.1

