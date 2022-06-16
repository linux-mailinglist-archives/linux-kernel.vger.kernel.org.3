Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B040E54DBAB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 09:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359397AbiFPHcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 03:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359382AbiFPHb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 03:31:57 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2055.outbound.protection.outlook.com [40.107.20.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAF35C37F;
        Thu, 16 Jun 2022 00:31:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FfMCNdGcFiugX6RCduG86ezlz4lJz6YyuyI5yjcaupEBrB2rR78cedQlEIDduXse22moBixoUm4f3BoKDTsv/fu2AQUNBFf6q0/xlUphGYo2StPytWSZ0LKQ2XWIJBmD7Fl72gJ8vBkzJBs4gVNY4leOQP7fzBtOZW7D4ExW5mtRwQDan3+IkO71chX099lNIXHDqmWY2IUti28k5NiY2g+us/fWmkFNUoQXptuYG6aHpMwgjKZiH2d8KAkzUyIpbFUE9hILSOLk/Y1qqx0rtFJeuB6nYZu41fmUNic4dkOegJ8LSL9YIbuF27EvuhJ4oKABCsWlzuhMkPlBtww/tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbYD8X+m6jaM2B7uCAGNN2ZG1liFoRO8cSULmisVsbg=;
 b=EJUPcpXp99jBnG1tIgf5wo1HsiCbF0In22Wr1YjJGVLt/1ATWnfzVW9HHXb4xyrEKGJPWIioEMavdnJdWBYvHBgrECu3ldEL1OeQllpiyFyL13OHFB2+WgOHP/brxzvTnDjIZa4zPQv68XNgna1kOI47cqA4thqwDz5aYoseRM6/cViTXmBrvjui8k+QaSnblltYlxw9j7MIjk2qKMutyFTaQRr1h7wob3N7joQwqq6/IOZuPosD48DdPsluOlol9952a6ue5cFqcq2VVvHVSVKqCmOTlhqhzQtQJ10dHjTrPAN4WG/Azi1AtJFb0uRJmIlXwA3yfj8E/5SrInIT1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbYD8X+m6jaM2B7uCAGNN2ZG1liFoRO8cSULmisVsbg=;
 b=bFyhofeoz6LD2g8AZ6YydHos2eyLY5DCtdfQtKXblVdqyx3Ymv/RwIDGQISFhUXRFoux2+fW7IpckXGOorkBKEZeP3rx+7x6NrSN0fy8VQvBfLYQebyPVytPTMsnSrTLyqAycri80mFU84gMVj1vSLwKkh/8qJUzs+nm+0ErGY8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB4850.eurprd04.prod.outlook.com (2603:10a6:208:c7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Thu, 16 Jun
 2022 07:31:53 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5353.014; Thu, 16 Jun 2022
 07:31:53 +0000
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
Subject: [PATCH V2 2/9] dt-bindings: interconnect: add fsl,imx8mp.h
Date:   Thu, 16 Jun 2022 15:33:13 +0800
Message-Id: <20220616073320.2203000-3-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: f4f6d8a7-3439-49ab-e63d-08da4f6a48cc
X-MS-TrafficTypeDiagnostic: AM0PR04MB4850:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB48502C66DC60EAB0ABD6EEB2C9AC9@AM0PR04MB4850.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D4i8evrDOt/duc4sYzJibnO73QsoE8Ox3+3tDBb/g+jYbtw7IMHY09fPBw+erpQ13fCevAU2ea7r2Iwhr0gb7qofpJCNQNUWZkLw2c8ZtSSQ9KnS0Bhkay/S9NE++hwxjNx7tJy7WkX9OE2n1KbcOLjF4H9Soezi0E/s1CnfgV2ituoNWT8OvMV8D9FdMiy6PA+CNiHjtPZX/wCeK4hoB7AG+hLFLX2RXHlJFI/r7sid1vanSzFO/zTpNg6G2ZquqFsKeMkhWryCQ0P7V9Z/Ngu0VmdEZaLNaDB0uaBTB64d+DzyUyEz1ERyCx2NprZp7G722YUxaAHhcejttZ3ADlHc2hkNj5paGc6o1gXbAbF9StftOmuu/IfgfcqxjFL+6nLtPAHmMXC5tanU0JE4MlzCkhjUDw365UZQDDjKe18X2qvm1Nq5OVTpFidByV2qEsG6888WYZ+hVYteGU75cl0oMrXj77bVsvrAvwxIiQs12DbZqE/pCFTF/Sxsp92Tsg0Y6IXr5Eaug1u9IeO2TUd1GOalvOgGHED8c7BrTZ3efEKmUr51L0anV4pEtJt1vGd8QdCjJd7xm3Ahc3I5w6/OnqdOwmnq61E5qoojtu2SVmvvWlxk+KoBcM5ocEP5OySX5H1YW0MWfgBgbLJ9zbTe+pPb5YjY/VBxFURJ3fbz4ijlYQL+dfQQmLuBIiuU2QLhvdiHWcpreenoXGHV0x4VOhhTcL5gAubHRtO1Q+w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(66476007)(26005)(52116002)(6506007)(4326008)(66946007)(6512007)(2906002)(66556008)(2616005)(86362001)(6666004)(8936002)(38350700002)(316002)(38100700002)(8676002)(508600001)(7416002)(6486002)(1076003)(186003)(921005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QYpC4sW9J53ZipjAjj7gI5KZdYpsnbrqk55G3dGoaQSUeg5gmFvGIgQ0Ysf1?=
 =?us-ascii?Q?AY/g1eeryf03ha+tj49ZrVyLfTdBO2dglgYl5wdyVC7+zp6AOOF7wLG8noF3?=
 =?us-ascii?Q?7vJ8kegbEscRYRXT2yeViTKb3/S0X8XduOumN/YvJr6GuEVmy28J/x/7bDlT?=
 =?us-ascii?Q?gQfJx8B2JKRZ3UAX6dpj0Oy/Ut4vMGpwinhX0R0+lM7mwTrIlluSxdCRq8B5?=
 =?us-ascii?Q?Mm3a2kGOL8ArjTiFjWcso24oRjUkKSepBl7AqFg8g0hJSE53msf2/mHMF0PJ?=
 =?us-ascii?Q?4RoNmFA1jDU5iiFKHc/IZopMHhr9ZuHGLZQbzuyYrN+Z5Cj1ZxOX7plJogB5?=
 =?us-ascii?Q?yezbE/SGyAqVDQ+dJ1QCm4RtBDCFZhOOIR9h5vMsuFzpNSLaz0yLJRQ+mSgz?=
 =?us-ascii?Q?QdlAiAIdf8g2Qkb1MGg7D5FtS/ZRRNBjtuIgHyLLccKc8EkZ38365hU7a3vb?=
 =?us-ascii?Q?lxI68E/Ts3e8X2/tZiTOwVE+F82PGMfXNSpMn97wtua3Czu+ny73mZqgi94n?=
 =?us-ascii?Q?rNLsqSn78p4ndiXJeEBStc50rqIHlXUduKJZ4Be5ag/80IUvEF3kaxrA8xok?=
 =?us-ascii?Q?7oElwwu7V8+TLwrL4MrlTfYGwaLAeYWUrXK6eo/od2skyc8dRYcMjoZ/5UI2?=
 =?us-ascii?Q?mz5ZoC3vZl9KK68H2/7FXgRHQR+P8adqGUr5GySxo9lx1DfswxwN14Rj7dVG?=
 =?us-ascii?Q?dIHke7H1vVeHBNiKPK9SCXedWRYxBUoHZPj9n8AtUrrwz1p/IbGwp59UVkCy?=
 =?us-ascii?Q?zzDeE6j3VejaSGAyOOg5559gaCQQy9E9I+q40sqDwU7+kjweRUoCcilYawdD?=
 =?us-ascii?Q?iQ1ytyJEipv5XSu/nrJyNgAeeiU4WHFzDsHbrTv5dwqcgGYfVod7tbGfCttJ?=
 =?us-ascii?Q?k44+VfLPulpSAzyPFQllWzGeenzlFLO3Pnwt3PHNeh8ZMbri1Fivd7G8yauY?=
 =?us-ascii?Q?GsZDlhNm0VxZgND4ANdaT7bK5tzqNrzXxA+/8riXA9DxU0jQxndwWFbmybj/?=
 =?us-ascii?Q?O5YlbSxWoNhs8KWOVnSpHZe3dHg6ZYyhQdUveHsxynh6gXMSoe75Z/4/j6RQ?=
 =?us-ascii?Q?odskDPhpnEjegDHjpUMAyV0mw5C3kvfS+dqMUwUafaIzJX9xieJ2oMCCU5PV?=
 =?us-ascii?Q?GK0fgPnkhou5qqDUmxK5DFuKt/j3ZEfRK7a9LJff8pCcPkIUPUKgNjzf2UZW?=
 =?us-ascii?Q?AN8u22WPkshU8I43r9UBBb80SlXEdH56XKWsRJzz/g15bDhtL6pSO9e+8kt4?=
 =?us-ascii?Q?IIdaodc0UwYoWmX78ULK8lDvJSDGTDz/fGFZe4bmwDvkVWYnmHof7+PT7ChA?=
 =?us-ascii?Q?d6jvZidTMpTZQnV8VM4jHJblnSIoOQ36G7xZJSZprrYeDrAD5hjL7XBboWAN?=
 =?us-ascii?Q?xNH3S8nmlO7G+EKRZI1i3oeSWl9MG7sgxoADSELOoSbYQevh8RQJclI0xwNk?=
 =?us-ascii?Q?Zb1EVuLgq2J0SRGJcDUpuL6l08L8Ipacftmqu+ijP+yr8LdzNXAEh6PY8eJE?=
 =?us-ascii?Q?WBxeVucFLRqA23T7t+PIPswfDdSnmv7C5he+S/QEprbONIXZ6dmpYqlhqpKy?=
 =?us-ascii?Q?MJfCHMlOn3LrQuZIv1VzdGoRmp7xDTv8gPPY7N+bZAzSQ+/heHlvORZOKjpF?=
 =?us-ascii?Q?udRSBsG3HQuuciVZYzoyuAudo+eLTqZgy0xSq2XTjEJnKtrIBYtPYZXSLdeE?=
 =?us-ascii?Q?Xh3CYJYDaif0xvIJ8LncDtLishUNoLFU2lUEvVXEmXDlqX74WoA6QsKeR1vC?=
 =?us-ascii?Q?KzTxerCAEg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4f6d8a7-3439-49ab-e63d-08da4f6a48cc
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 07:31:53.5687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yoj3HuhA3eizU8mhqSjhe02Oq0STdoYW8DS6ENIVa1Fakv1MjP1eavNubDhZSMHrStgBhNid09Yc08d7K7gHrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4850
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

