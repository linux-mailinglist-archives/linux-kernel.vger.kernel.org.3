Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9128A54DBCD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 09:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359585AbiFPHdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 03:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiFPHcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 03:32:43 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2072.outbound.protection.outlook.com [40.107.104.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664ED2196;
        Thu, 16 Jun 2022 00:32:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RUxXNCz9FMJrxIPu9O7hgE0Ug7PLjKE4hj7pFvxbUDyg1kh6JU29AGAg8LWiX68DJkinaiTbQVihe84opBsYKVHzxJKIYaL55WGUIcwEHDvzGxank5n+hJdaeBgcLLT7cR312B2W3npRZezKQ7Pn/WCvCEAPG1oAvZ46/TsNUzAeR+0F//BfWUSP6gnncdL2F6AutZjduw6Xw09LtEenjWiWr5ERlxTQ3B5vPtS871ZjPifBtGOgTe2k7jRwMZqJPllNNdG/USktZCWQcU6QdwuF1xTg5w4BBb9cuBneC4zuyGx1bwAuXx+kS5WXsspml8Lt70d/9vLz0Ih1YjlPNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcjUJHrInmewz1//bW92dJq1Y7i4Z0g5MVVPA8FCLy4=;
 b=MF/VphZNTep0CR6Dcl9FzlTLBLyn3fGqpoJC2TV3uRRlf2hs1RQBpNZzTjj7j6hwhRNTJxbiJydM0Ci2gvUCGLV0PAfcjcrmV0iEFijd6r1xe8PsZICiXW6G2t1M8IwUO1K6UvZ8FPIdQoxFltRxddyj95+5UHtFT27mqM6ngnolpkOCJn6J4gInEPU+uRRZIiredAI0lfR/CauGCe4+dS2SPQOzHpGu4W42RGHnh2ic5GNhV2wXrjP+9YahR2ESJdHpzPml4E6AX97Ig17jaTMmpkTURPcEYzLZU4TvcxaVJ66KGmQu0/TFsXc0QD28A9WK6qRSwBoIiX8U4JwkkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcjUJHrInmewz1//bW92dJq1Y7i4Z0g5MVVPA8FCLy4=;
 b=AW4J3M644bIz2gSBx8NcepuPJZp6lG+HXLkyRU2cJwcIWgwR2Ta0fs1mUnhud+CaRUUWizNSpNo/qWe+oCOK+vlBCINDQEz9cAjw0oeMZfSPkqv6IfLgq0fMFH+7BY32ljagVfy54Fqa5rvTc2/l+KT2iFo43t0jNAupwiGzvnc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8435.eurprd04.prod.outlook.com (2603:10a6:20b:346::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Thu, 16 Jun
 2022 07:32:37 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5353.014; Thu, 16 Jun 2022
 07:32:37 +0000
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
        abelvesa@kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 9/9] interconnect: imx: Add platform driver for imx8mp
Date:   Thu, 16 Jun 2022 15:33:20 +0800
Message-Id: <20220616073320.2203000-10-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220616073320.2203000-1-peng.fan@oss.nxp.com>
References: <20220616073320.2203000-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0121.apcprd02.prod.outlook.com
 (2603:1096:4:188::21) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6aa3f1c5-8f84-4317-d483-08da4f6a6304
X-MS-TrafficTypeDiagnostic: AS8PR04MB8435:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AS8PR04MB8435DEA385C20862216F74CAC9AC9@AS8PR04MB8435.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Mm1YZJLrFfstvLjoCu193hZUYI94mMlyiKhWHIxItKwyP/plFSDV1H2aCcrPhE2EdvsHSrkfgoEGzrrqmRJBytT0X8vSNvGFbM5bA/AdFiBGfYuTEJxh0eQvweaF12xO9fzjzJI9Ml7IN27I6cgofA6AOoJF/o+TU5ZtYLynzSVv41MgVXC1VfoVCg55eRUvlX2dHQl5CX0ymiJqC786JQA0l98BksS5tG/WB4Tbx+CD/WVlLnxW6SxJBYwPPPYlPFgGTyTCI9H7jQAc197tTzAsnV5plVb52/+S/U1ksUVjWFqWUrEiwF/ZYa8SZ+MI3uc5hHPiz24lIfYElbUDrO+wxNXeAcvszB0IfDt6BDic2oJMAOhmJ8paHwb00qOziK+G67rK9abjRGzqF8r6IvBO2hgLOzG+QZbpKJwvoUQ67HBJSBVFUPCscLlFdm4ys1rxrARGQc7cpy/DLTMZaGCtYdXbQo9ILyCELaLcYv/pccqaywDJPTHopW9StPBB10ADzcLab8N3hRrzSVj9DxzMHs3mdi7+6vChmQJO4iXp/NtF3JJqwHmthPsn4vAGVW8kOgv/7wupp2ZXCfi5Z7M4haun4biGrMjTRh9dF3C7OoK5Cel/cVmm/Ao/tODxmQKabvabyhUpzaJ//hjP8Vl8mPruocAJStG8qz70PkIT61LCQi8SdWbHuGIpybYO/tZnEBUInHFMviAdBRpN6iOrUAM9cNiMdG/iqexiVDLXClqsnrXfPV8jm+UhT6A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(26005)(316002)(6666004)(6512007)(52116002)(66946007)(66476007)(4326008)(66556008)(8676002)(2616005)(86362001)(6506007)(921005)(5660300002)(7416002)(38350700002)(38100700002)(508600001)(2906002)(6486002)(1076003)(8936002)(186003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wiZnVBAo3bwq5zHlwvribmXZyCPGdJ2Bos6pCsZ1JLBaPk2eZyyOULDJ8844?=
 =?us-ascii?Q?/FYWF1pFoTDdBAd1iEddCVpFeCqmLMWKL5lL2PWTfsa/sotsjSR5vh6LUZDb?=
 =?us-ascii?Q?daXCHF/jpwkaxu0pK+dkObDG1wJBOJPJqvd1YZIQ9n79RJ7pAe3PhR6U2Nlq?=
 =?us-ascii?Q?zxq422iKPEGc069gPtqVGd8ZLxzITgtpI6XtH4EAT8rBe6jVuB94cSz3c6iU?=
 =?us-ascii?Q?1nERay2mnCjHh6v7bFSG6RpnsN61GptMWD/z8LJCjsHuiCP2VUBWn6MjTKQW?=
 =?us-ascii?Q?QlPJ06RWlXyvtGkB8BOZAb/nal639owuY1YY0tQVI1Uxy3arp9OTc+F6UMe6?=
 =?us-ascii?Q?gVC8u/a/+dii64Ocfh/Rmjc7m2OXhapvzs8yXpRhcV04aeLkpjpQIXQh8aoO?=
 =?us-ascii?Q?Nc1TuBPyrl34pfpz7iYsW0nLzDXcZ5w3ffDtmo8IJrc/P7zjZktSkjCI6kpI?=
 =?us-ascii?Q?4meJX78rT+CCTwn0sr+mrpkU+ZzFLKlm4raoX0jUbsKOK/x87jITqyf0ZUdU?=
 =?us-ascii?Q?JGR4Bd8LcNgmcGYw6Fr1TCN9gprKjJ3FeHGs8R1cNre6czQU9ncbNb6gYRZU?=
 =?us-ascii?Q?DGbC6xP1xYn0bET0B1T12iVqrD6RdSpZ/uMBYR1BEWQ4Yp3EKbqSiRnyVsQH?=
 =?us-ascii?Q?8AtOFn/UsTOJOnVVbytfPspf6i3ljw+VvZWEH6tIqBAuBg+5dzm7fjST2kas?=
 =?us-ascii?Q?D7fDPk8UPdop4rL5EF/j6eejYO19ttIqxn5x4YIhDI+eLk2sYhxpWNfmTScd?=
 =?us-ascii?Q?EP1+kjje/7PiY3Wg/YRSljYqVzVDw7oI8Fwxc7T4RJRQc+Tk1gAnbOp1FX59?=
 =?us-ascii?Q?b/+eYj2kxfXC8fsL4h3zyeqW+z3J+8XAnP9ZGH1Tz8ikC2FfAnk3z5M965S7?=
 =?us-ascii?Q?1UvztqvZJTL0T7IWukm0hy3e1xtAviGNzSQpIzAoJ3gGOwtmD+5XNZVv6RFP?=
 =?us-ascii?Q?mcHfX7iIEJEBf5Okc0rMa7y7ZCkpxryttJKDU5zgq4GnqePjzUKGWGA8ONXE?=
 =?us-ascii?Q?4OPnPrriHIcyesRmU4JLlhJNZSNxadpbm1nwZQuU+FpEHg8XD04dm6Sm/Gfs?=
 =?us-ascii?Q?G6oBuqXYrNKoIfP71UWo3XjkR65rLbfg5H2qIyOCJFoGh2vM7WRA/yKO5ga8?=
 =?us-ascii?Q?4a/WetJ8fQqAUxMJdQT2+iIZdP2gX7RH7zJT7onWLQ/Lkqvwn20Mb2YcU2np?=
 =?us-ascii?Q?c6o9Ggtbv/0A447927+4PwNBYflJqO0nvJUOfsE6VE/xykufS60XDOoY9oX2?=
 =?us-ascii?Q?3H8c/F84xzDVSKI7MNm1l9ReVt6rdmUn8gpys9i0FZfM5Ip5Hy8DzjiHDBGg?=
 =?us-ascii?Q?uCRUbT2C3YCtDmn5Z9qsuQd71A3W3Yxws9KRCfkI3Q0iWtEVmUbrW2xvadWJ?=
 =?us-ascii?Q?FpHVr0LX2XulrX2nhG/Wdyc7ZrudAsIhS6W1rWsl9TvygnAx8oMCwSDFKPs+?=
 =?us-ascii?Q?YoB2m7JrswMVsE/AlREO5HoVar2M8gmK0k96tFOsl4QyvBPp6S8rfQyDw6uP?=
 =?us-ascii?Q?tKGaf4XFU/BJD3doYtb8IOUY4zWWqhGYd8wWNrdMCo7URdEasxtAE73biThz?=
 =?us-ascii?Q?AcZkOrIfM7l6I9ML3IkPFg7bc8sK5dGMxhpkjOxF8qAvOPKRv4E2Oass0HfS?=
 =?us-ascii?Q?9lYbBIOJUa5BAHSeSovPFBN+ivR5fuda4IKcpdmsNF3htk3jD9jyeFVLel1a?=
 =?us-ascii?Q?PElabCPaOwegUCemupm/We8ox1VjM3tCK2239YZptadC/aAVs0hWWrE1aXtz?=
 =?us-ascii?Q?1c81z1ijZg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa3f1c5-8f84-4317-d483-08da4f6a6304
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 07:32:37.6484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FOvNKHItxCTYTEUWfNZig0Ih8gZpuDOdqjl0p9jyOsP+O/5AqEQy4jr3XMnmTIp0/XX9JoLeMnkg3dvHdgN3sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8435
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
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
index 000000000000..2be2e9e2974e
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
-- 
2.25.1

