Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3621F5AEDD5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 16:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbiIFOe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 10:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242295AbiIFOdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 10:33:43 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060c.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1b::60c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C2882860;
        Tue,  6 Sep 2022 06:59:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSL8uHO7K3Tv48fQSWkmVAxOyV7e57GuC2jO76MeepIXAh205W2FZ6+NT6i7ktzIL//oPTJ3SaqA581PWZCS4NhMQGlURhp7vNo4UQzZeLS+ZM/pLfXBqk1GXc+PjMnijBu65H3Bq+1Rg1MK8C/I5UaJKDa5FwBAYOsyPJYDMqWKAvboQn50uV/jluVGTP4lqprAWUKzT/j9vUWaWdoqJEot/B7n9uqs69C05czWQ+r58Z7zRbb2DfW5ng6z3JdoczFllKFs/2Uk/Y6m6zQsRgqpGtQZkfajXky9FN0yVk8JJg1ziWb3Ndp0lyDj4V1V37U+h6iyzs088GhjW5iD3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHhiC5QsF+JzIhG6doRHhCQtHC9jdJD///6vKdKxEAs=;
 b=XIkl+Lo+E1pdla8VGCR/TFcy96v4AOZmsrOGuKmX1CfS9CdXtKsI0DsGN2ai9f6D1F4RTuQkVpORhPy0wVsWvDmQTkJfLs7NeZFkPO/gDOtr9CZxChHKmYLyY5NmCKitlSp4y2RYwqWFJko/MMGnt3DUG8wfOZhWVJq/4ABa0KZWAGg83/qr4SDoOsL26nROsaN3UjbypYhHW/P2fKb/mXn0W8cYlIm2OelRb+Gq6hQxPYzfgQcw2WmwL9yMUPctF3XkkuEomB15G3nPezC3dy31a1O8I2DFdQ6NkpRdvuOWvaWkHid4KrduJ0zLWkAK87Ql04FEicDn3RLqGQBujg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHhiC5QsF+JzIhG6doRHhCQtHC9jdJD///6vKdKxEAs=;
 b=ph89c1aeTGUr6mM6AVZ108MhNI2MOQsFr+2rOvJ66rfttjnudOvcgQQvPaq/3upXtKY4yhXk9pV+cCnnbcBmhfhVw46HDijxcvJ5ismOWLtxU5TdKHAtva5KM2n8MiSoeThMTCU1TYpDsRoM7BLiS8Ukthd0s61SGiV2xye+oPk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Tue, 6 Sep
 2022 13:55:12 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::b152:60ce:3622:7962]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::b152:60ce:3622:7962%4]) with mapi id 15.20.5566.021; Tue, 6 Sep 2022
 13:55:12 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Denys Drozdov <denys.drozdov@toradex.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Marek Vasut <marex@denx.de>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Alex Marginean <alexandru.marginean@nxp.com>,
        Reinhold Mueller <reinhold.mueller@emtrion.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>, Ming Qian <ming.qian@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev, Rob Herring <robh@kernel.org>
Subject: [PATCH v7 1/5] dt-bindings: firmware: add missing resource IDs for imx8dxl
Date:   Tue,  6 Sep 2022 08:53:39 -0500
Message-Id: <20220906135345.38345-3-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220906135345.38345-1-shenwei.wang@nxp.com>
References: <20220906135345.38345-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0050.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::25) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91e7b8d1-e8ff-42b4-0b11-08da900f6af6
X-MS-TrafficTypeDiagnostic: PAXPR04MB8749:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wdq/LawN5u5Pie9BmqdA/TcFEbyquzgJt0wlB/8okbCsuZQiG4/rc7zmqaxkXIsexY6mFfPFEjzjH6g3iIwUWBTwm4YuNADpCFwVKxXoVcURcSQhyIdXM+iG6M5FY0+g3ZrKCjgn1CN478pgeENrn0B3ataYyl9DJPMDS0IqvnJ8yJerCD+FE3SVxH+pkmXVi5CGi54FyjdpYDPh0h2wn4eIdYfSWHMI/gnBrEUNdUS5i1ZdOJkcP2fAupc4MM8yBrQqnK0yr9qtSTYRy9zUmsqN8OjgOjDQeQL2RyDXVcxIc7kkhKw3YeYdPvlP7mzsNC0YzTeKDji1zO2Flc+vuv3JO2L2Gh30287egKe8c+ZRA93+taJqF0nCftQVFSdDEeH5eJzsacbIgoc6R4ah0S+IJvJbxoqiOgLkfB6KzUNKSl5XMMrSs4oQXmT+E3hfgdHryyEUfdNpQ3d0g7KOp7sJ7FOXpmpp/ZcR9hzcBUnXWtU2t8uEKr0yc7wrmy4LaPU+Nmsa6UDCCrO/UV96UrkSTr6ubQaPXuzUPSJbjFVU+lYwktgIlehWSlhzaBlPtWsT4fpt7dnhI+Up/Zkq4m7PCjc3V8OMP//tO/eGuAqUdgyTG4+eoCVCuayQ2koRo3GT8+FhjCUnGjFFK4mouCCRXdi7lRg6L5u1nlnmh7F5jjCXbVtb+BLZJIvSMEJaewR4guyZG59q/u+GgVXjLll1KmZh02aNjxn8dIyE5yJGtOly5K8XUYYCV/EckKgnxttGLPrrExgw1Hgc4riQfwjNIaOQsdGEQQ0sM30pjyw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(39860400002)(396003)(376002)(136003)(8676002)(86362001)(36756003)(66556008)(66946007)(66476007)(4326008)(38350700002)(38100700002)(6486002)(6512007)(478600001)(6506007)(52116002)(41300700001)(6666004)(26005)(55236004)(1076003)(186003)(316002)(54906003)(110136005)(2906002)(2616005)(7416002)(5660300002)(44832011)(8936002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ePJZNStvQW51QQKzq1bU1IRZ3Bpf9Axct6UPqLJpSjnPKK1Uq2SSWFJrmq7P?=
 =?us-ascii?Q?9zrkeIgbNeR5Dav9zdFv2m5HIhO/RufwAF2X7L1ArXk/K2E2DZv/676Fr1lM?=
 =?us-ascii?Q?UHrZh6wpNDubzDxxijCFAterbeNYURPC1nH+G8ooarFQpk/bKKwRIP3ukJzp?=
 =?us-ascii?Q?fCxmMUWSKP2KyHHvwnwFMiUXptxH3cf4HW3lnbs5LfOee4cPF0utVZleGSnt?=
 =?us-ascii?Q?cGKNiczYeEUVDlH0+ETtCUALU2JWGWw8UWrj5EjpsrLxlsXoTtohME9vA60V?=
 =?us-ascii?Q?JiTeOD4IZLwZo/ZZ/SOT96gtDCUXhUTb678VErUmZAorK4NQfrHBe7ou66DL?=
 =?us-ascii?Q?A69EHym+j3WNK5dAZoOskUBv+Ls+CFYs1JHB38/7R4d/KtNwvsy6bCSXuYt4?=
 =?us-ascii?Q?qp0zPIwpHNrNNI2+WyOzCIf6Utgr8NOeEoRk3vNmHT2BKdt6bx+EcPyYsBYa?=
 =?us-ascii?Q?sI2GfvvTPuFTEqw6wF2VD9bSO43ueN7snS2SN2cbYANiq750X05WcN1haIiN?=
 =?us-ascii?Q?FBrQmCrSTIOhEg1j3SKs/X+ncUUz8/BcNVMFc2eFuRS5TOvZriGhrOlf/9ji?=
 =?us-ascii?Q?1FllyuQ2PGKfyMTdj3i46GIqUgtPANwMCQvDG2lnOp/aQONg7GRrSxRc48zH?=
 =?us-ascii?Q?Zk6iLtvnDTHnlntT8j/8mFhNquiMg/MX/Ndo7yH4zloSLgfgf77yJdSExeWH?=
 =?us-ascii?Q?UHAKABeyL6g6lXIDVfeTw8nelDE1T6Eo/w+EHdDTmnStqB6oBNHFhTjwQIEU?=
 =?us-ascii?Q?lNdtKLL+ydD+MqMu9yVKwz+QhETi6KhD4/NfeltfYZL7Npyu5c7m1ZdUwHLc?=
 =?us-ascii?Q?EHETRcWLkDNIVRzVYxpMGBausZdzSL7RcidleH+7dIVsdTeZQmJ4WVIP/Vz+?=
 =?us-ascii?Q?geu9WrRQSkXo3odBbjBOY0pdzju7PKA3j9HvD/WhXSE8FXfqkjMmcd6lrnO3?=
 =?us-ascii?Q?rY6ABkIPRE4uUQYGK2nKnqNJeSx9AQUsWGZ4rXx+t+rXKPgOWfs6atr2gmkK?=
 =?us-ascii?Q?tnevPBXaIs3lsi05+ia2D9iZwJnGooN8YWPWadNfatiGPQfMHB4d5JkiJk+L?=
 =?us-ascii?Q?dgYl23JVmdPP5wORlZevjax7wPNnUDiJ40f6UAd/AMNGEom2YYjy7A7qZDfe?=
 =?us-ascii?Q?dBan/L9Yl1UILlNNDAP0/il1rafJyW3aCzmQv/xPehIUqqe2uJa7MtqBIct1?=
 =?us-ascii?Q?ifzcK3vuDBBxnEyJRK/hA3niyyBfMwDz6icDFg2LLruau3r37zTJYsUyXsjr?=
 =?us-ascii?Q?tmbU9AS9xnOn1A9nRWpUrjxXmmbmLyIuOK9SyDl8elCaJIbJZx9ejBA6p7VG?=
 =?us-ascii?Q?jsB4QcoIrB1Gz8Y6XDiL8S80JaSxqcrWJz8CQblyP9YaDUhpCU8+/RM+uan+?=
 =?us-ascii?Q?5hJ77AgiWplp/BMwHjEBLiWB/Y2C1JVjHnJFqqrGZRQ4YmTCcS6atVBxZvZS?=
 =?us-ascii?Q?v8NOvuuwQ6UCqhVnHWtXFucRf+qIS9alJZvn63OKW4XjUdyPFXib0ts1BHP3?=
 =?us-ascii?Q?oJVD5QMJq13qF+9tvG72aSO0B+fWoooM5gl2wXD0ttvXR4Ld710Jlu4ztZ0/?=
 =?us-ascii?Q?HVlq04frFtkZwCP/QDjeJ+WrwDOaubpicB8mUtcf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e7b8d1-e8ff-42b4-0b11-08da900f6af6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 13:55:12.3983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7zeC0L06HRrMaCZovy+w7lwy/tVNlj1IxRfvGM/ybuF4ODapDWOXVf2kVNop/1+bl/4ExyM/VsAnwqusHDn0bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8749
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing resource IDs for imx8dxl.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 include/dt-bindings/firmware/imx/rsrc.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/dt-bindings/firmware/imx/rsrc.h b/include/dt-bindings/firmware/imx/rsrc.h
index 43885056557c..1675de05ad33 100644
--- a/include/dt-bindings/firmware/imx/rsrc.h
+++ b/include/dt-bindings/firmware/imx/rsrc.h
@@ -37,10 +37,14 @@
 #define IMX_SC_R_DC_0_BLIT2		21
 #define IMX_SC_R_DC_0_BLIT_OUT		22
 #define IMX_SC_R_PERF			23
+#define IMX_SC_R_USB_1_PHY		24
 #define IMX_SC_R_DC_0_WARP		25
+#define IMX_SC_R_V2X_MU_0		26
+#define IMX_SC_R_V2X_MU_1		27
 #define IMX_SC_R_DC_0_VIDEO0		28
 #define IMX_SC_R_DC_0_VIDEO1		29
 #define IMX_SC_R_DC_0_FRAC0		30
+#define IMX_SC_R_V2X_MU_2		31
 #define IMX_SC_R_DC_0			32
 #define IMX_SC_R_GPU_2_PID0		33
 #define IMX_SC_R_DC_0_PLL_0		34
@@ -49,7 +53,10 @@
 #define IMX_SC_R_DC_1_BLIT1		37
 #define IMX_SC_R_DC_1_BLIT2		38
 #define IMX_SC_R_DC_1_BLIT_OUT		39
+#define IMX_SC_R_V2X_MU_3		40
+#define IMX_SC_R_V2X_MU_4		41
 #define IMX_SC_R_DC_1_WARP		42
+#define IMX_SC_R_SECVIO			44
 #define IMX_SC_R_DC_1_VIDEO0		45
 #define IMX_SC_R_DC_1_VIDEO1		46
 #define IMX_SC_R_DC_1_FRAC0		47
-- 
2.25.1

