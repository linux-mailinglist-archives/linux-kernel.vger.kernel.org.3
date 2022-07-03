Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E9B56461C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 11:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbiGCJKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 05:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbiGCJKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 05:10:25 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD9D271A;
        Sun,  3 Jul 2022 02:10:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JzO294bHuvB3ZZD8nG2W3GbDS8eQuHDN4/kzrSU0vSRifdZy47weMZd1RlcwUWM1mdgHb06uZWySLjgiiPQy5anY/0G+GjAioFTXES3fJiuUv/+pv+vKC08Z+l+Cumh57yohjIxxzXpwCiHsvIEndxb8PV8Jel1mde8lWOlNYLIzDxkm0f3Qja8dIPJ7rKOocJucrsFlvXyZbgT4sFWg4LCYkH9euQ8RDUxtzG9TO9tPRV1/pK0WvBwQCQMt69by1TC9TMrcUvfMCOA6A2JKIN+LpI9zjqtP9fe2Sd+qpB9z4G2rHWm1kOZRf/xWpbJOO+R4KshzzS7k4eZux0VXrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Kzdj8uDNBAbOohENvhCvhc4J2KIYtOKDIHWPEbOCNs=;
 b=d8/lBm/hkR3K/N3Z+3z1BjVFnb/HP4g4I7jetpfWKUvZEEXPjCVW1W6IGmDBLG6aer4lJiyaokSh+vyGCxCUMAXivJkJhoNEYgq7/zVdiIp9+CK9oT4O2ORAwPwmoTH/fKTk4w2L9XJiNQYqSkKvDXbeOTgPGmpmUuwyEP+f0onXCgs3XF0UW/OmHl7AzoNX7bk2SNazRrO6768+6k5zyxTX2meB+ccGz3uOvDcmWgCZfPTx5oG0ubmAlwCsUGUfed0aaDaPHwm2qDK8qUZjE9nesSRNRnZEQcRn7fNPucHcv0MDNcaskVaDutTINDuFwspTcBPwWftBFInxmBQrMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Kzdj8uDNBAbOohENvhCvhc4J2KIYtOKDIHWPEbOCNs=;
 b=jJEZXMYP7wk/8gs1p13mNcEGyapfRFOuW1xeoSKWSouJG3qKFiLvhuEBTyiRtL7zHxKp4O6EweICT1XK74z8/qfdykGEDqpHcxTje303CNaNcn5eE/MlWvw/FkrvvSkVw8lQf2sljRXR8wzd5ukQKn3BqjCUr4nBxmsnH7Dojlk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB6165.eurprd04.prod.outlook.com (2603:10a6:20b:bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Sun, 3 Jul
 2022 09:10:13 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%5]) with mapi id 15.20.5395.018; Sun, 3 Jul 2022
 09:10:13 +0000
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
        abelvesa@kernel.org, Peng Fan <peng.fan@nxp.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH V3 02/10] dt-bindings: interconnect: add fsl,imx8mp.h
Date:   Sun,  3 Jul 2022 17:11:24 +0800
Message-Id: <20220703091132.1412063-3-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 86dc08e2-6510-40e2-0ebc-08da5cd3d688
X-MS-TrafficTypeDiagnostic: AM6PR04MB6165:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sOJqDaC5VSgH0pAH69f9Cui1LtqZeGnyt9kLpwo+ftLI9HT4XuPUbKHrNvF5f8qqUdoX9v9jx9c8M7WvWjo7fCIeuD4/0SlBbHUSA+xfDnuFJ1M6ou5Uf6Z6zUfMxarmA0erVlVyDQNyBBNj7OVN94fhPPN6i/JJ9KnFHHyzmANSkjXzJFKfN5Klc2/X7qXj6f5snT/bib1IOsqp/1UUrqq53DruNTvr9IKsbb5X3aeKRlUv0LuJ/tySK5J41A3GamHry9Hkf8alDPuJEzSuq81DMF54bRNyM58EdPcGnbFzkbL1x+kbiYQGErVXvUcLSuMX/u8yKjvxGMGeSHq79zCNvLe3FLEElYCHNQow8JYmFjmRTQJn3PdHltzuVH/+fNKC+A6xxeqBfLL9V4z0knDYoQJjJBpTjotEQ/v3QjgCpHd7VjANQjVX6TJT9U248N9wyGsPw7cLwegcoK2KXgkueIfboN1Soj/5Nz4I0/vDuEtFhq1TE8rzUH70bhluidWNpBBRQrGIyRNrhz28THlNJ7A01lCQtsWHpNr036+Lz25/Cm+Dde6qm6XxRVsS2z9cblWd7NqeEygyH5DAbWul7wkoOZTYuhk4QTwZdTcCVfBZIFPH35/9wSzoliFwCjQqz/czgVI1FFf2MYzDnbz0nuaUGT/yw4xF0dyjB02WKDnQsTJ4nZYfbVXunx4NNiLxKOEJVWmzu2upPLSPal4Q7OkIJbSYtSL8VAMt0lD1oI7fmPfcDAITOu/kj6cZXmGjjqCMLBIk1U9Fs1GElU/kgwqhYvcbphj26d/BbSJVzurl8hVI5/tU84gtC+z9gYvnNbEnIOsadfULfmHf8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(86362001)(921005)(38100700002)(38350700002)(5660300002)(6486002)(478600001)(8936002)(6666004)(2906002)(41300700001)(316002)(7416002)(54906003)(4326008)(8676002)(66476007)(66556008)(66946007)(186003)(1076003)(6506007)(52116002)(26005)(2616005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fL7TK3E7oJZSAD1sBkt0Yg6ehpg3rIH7E03m7wKxPAlrR5pkLVCLNkDpOG/X?=
 =?us-ascii?Q?kSsroQXCV/aOvCKQGHgXYUOf/3vYZRUMnSD4dNHYnBah7KOmVJF/PYIIRGOw?=
 =?us-ascii?Q?4V4JwPpbNHkCaE7cjO1PJUy6gT/OhjvzV1OXtTYUuWEVZjgx+cLvi2rYuHp1?=
 =?us-ascii?Q?ukIc3vhibdkAWL8xINin4nI198i9daI5TzCnmK2kx2XHKQejuRuKvv03BjXw?=
 =?us-ascii?Q?/7iXYbWauW/BdhR/AAGhoaoGHv3EGTjPWhu5BCJQ3tVWTqAfOCCJh9XyN+aU?=
 =?us-ascii?Q?IpZN9q81hYtF3HIUio6F9VDhN/3qQ0CU82V7MSeYXLS1XvDwS7qMSXcj1r+4?=
 =?us-ascii?Q?SYiJjAhJgkH4c7TblenVTuT2uCqNa2Wp/I8GATxpspFSZ5FosvGuSt3eAi3I?=
 =?us-ascii?Q?zzgGMfTZF68aZyTVn45mQoJ2nQgw086SFPFHjAQTR2D0VkIX4C9lZPfFzIem?=
 =?us-ascii?Q?okGU7PIp4dzQvDOSVA7qMANp51I3OKn8g/KR7+VcXeRhomHnyebWl29FKx2P?=
 =?us-ascii?Q?BcNJDe2NqRQZEgQJ3icfPodHmnSGl1868wz+5moqVa4gIhDfTPhRP5YsEdIz?=
 =?us-ascii?Q?F1MIspovZ6DfLCAiREhqOpj1BpnfSaUOSTkNN+Tmqh0Q+Zat7HfEthCkRs/k?=
 =?us-ascii?Q?aYdIU+JuCN5gmnGx/Xuiajev2TkaDfGKa3cfRC7HSbfhVH80gIkaRmtLEHb1?=
 =?us-ascii?Q?0a7G2l2HhB3PqaowXQ23g3cOB0GkMdQEL6hXKk99nptBEYGfp9PSNKhBYW6m?=
 =?us-ascii?Q?D4dfTyNfo1hDORXzZkxjte72Q/DWJuUtM+RPGk4C0xQUdD2Ivng4ScgwtK/v?=
 =?us-ascii?Q?OkB9DhZGCL8ymv0PwUCdT2wr6Ortn9Y+kOXcVS5+tlRaYz6LQgD9oiLZAyay?=
 =?us-ascii?Q?lYeAlOAeYujS8J6A+Z3EQryI3psMUAHNkiXUke4hVJzvrdlF6zOL/ZW9jIua?=
 =?us-ascii?Q?QQ3GQ09xUS3YBoksnmEslMsguqpznpl41CcwGOHcY/J9PXfpGcvKyMQVJIzK?=
 =?us-ascii?Q?A/nT5X2eQly/hDrTfgKyruMAAln64XU3vyPZlCPR0QTcDj+7d5fulW1hcLKK?=
 =?us-ascii?Q?jHLl6DLKhsCTy2I/hfDYHz5fUYsPIMSNk6Yad6dUHiTep4l9TMohLklEyBCr?=
 =?us-ascii?Q?13IfgOOtodNONk8tH14xi4DL0lhj1qOpM/b9DgeAdSZbhCODgLUQxBSTWYUJ?=
 =?us-ascii?Q?/c6DFkRFbLHpnC/M7vttgK/3LCkVxPt6Ce2KczPcvEK8fK4w5q9NDarMI45f?=
 =?us-ascii?Q?1LGORgRQAOYBOEREhBPaSQQxT4ATIWg8iOVvEfBNXAQZE0KzNwqFsuD3wlA0?=
 =?us-ascii?Q?hod+MEHzoAPNMRU7/h3Ov0I0Wa1Ji+MbtxLUySIn3byATJ2aM+VBA1Q9PLYg?=
 =?us-ascii?Q?liqcaZJnJDxJAv9yHnjhnM1Y+CpTgTmYssNrLbZSIYDJ0vCpqZrRu34i8/BB?=
 =?us-ascii?Q?LSV3Fpj8K77UlRckjw7yKvcmKowYWffM2mZa+1WVkeSvvByNSkPyXizXPvyW?=
 =?us-ascii?Q?pQt+ylfLBOsicbXPEkgYMfaEqwkmeEOpSQLWFk+4SBdj2rxBtsgLreeXWVI3?=
 =?us-ascii?Q?sekAaNMC/nqYNMQqSYQxbYiELwoCl7OsN6YZze8P?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86dc08e2-6510-40e2-0ebc-08da5cd3d688
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2022 09:10:13.6254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sfeOzVdrfyKk8dQHL0LbFfXzFkBi71xpFZf9JaQI526luQy+JyRXSrWVA2MJoyj8L7+ZaE9ijXNcAGMDIXEWgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6165
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add fsl,imx8mp.h for i.MX8MP

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 include/dt-bindings/interconnect/fsl,imx8mp.h | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 include/dt-bindings/interconnect/fsl,imx8mp.h

diff --git a/include/dt-bindings/interconnect/fsl,imx8mp.h b/include/dt-bindings/interconnect/fsl,imx8mp.h
new file mode 100644
index 000000000000..7357d417529a
--- /dev/null
+++ b/include/dt-bindings/interconnect/fsl,imx8mp.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
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

