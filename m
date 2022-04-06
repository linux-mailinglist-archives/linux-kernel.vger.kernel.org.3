Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340974F5C71
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 13:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbiDFLe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 07:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236337AbiDFLcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 07:32:45 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2040.outbound.protection.outlook.com [40.107.21.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0F5448093;
        Wed,  6 Apr 2022 01:21:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iCEEvLuf2CHvXH4Ku/1FfEKWCH99LrDR888/Ls0rIvwqMT2dj8QwQL0AIouBPZF4NiP2Yo+ja3HZkXSKNtMszaGYkNIzJk1t6OYKNwIea1oWdh0qXhnScCzry421E6HdClsPErKFf6rnb7eonmJJFz3MHpTwhqzpPKZwHoyuHqpzM/j25IAeoiWFbkyE4Wilif5RBtfOr0rDdMx4E4SsidTYapPVR5jpuIx4fSC0MO/sHJQPCD2mSEVN4REBsVbTNNXw72/8zl3eddSCJoCkFh3tbY+qAXwCj9pxXf0kByVXAfuj9dEv/4fcXgMuomvVULoKErNtAgbmSx3c6FBqyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fRK63xfq/ioBGqn90TcyIcI8aCNenzK1DQTD7UuTN8=;
 b=E19/7us72ZHIVSewetBmp4mX7LOK5GRfsfUJ/OpDbLBU/dUBpkuzjjC0aEC5qxRXaLxFsfPNygM59qZhnQOj4/3iTsWIFTOSrxJz+x5gPDXuy94HsHz0V72+a12GWmPwiJ1XixozOD0kS8eCPSNBhNe1pt7dIjOEKZLsH6GJSdN+ZPFS7uQPiLCEUvH3wwAIpzzk3iFVIj1FZtlmGKW091rU3JI+pg4PIV3s/nZ/JOlFLXZSXvWchw1gn6KNANxbfJjxsPEoXQ4NL5ToDVP7dWffyFTaCPr3l9Aza2NcsE7LB6S9Cjag2B2slSgLeuEGi2/38d7YrgrF+HY69E1b5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fRK63xfq/ioBGqn90TcyIcI8aCNenzK1DQTD7UuTN8=;
 b=aFJFBexvXnCgEgmOSprfLddazx36wYvpfrThieLZRm5sOWkhRSc955LdAUBf/OPLFBFbq19mWsaQeFcdKfZ49jRGWITawpNw5fjKNDAFpccgtgktV08ZU1IWNYzHzEXjBoTPth6IThTEOGFwSqBWj5Qt2EbZRoMtKYCl+bbX9Tw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8970.eurprd04.prod.outlook.com (2603:10a6:20b:409::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.19; Wed, 6 Apr
 2022 08:21:40 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::389f:e6eb:a7a2:61b6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::389f:e6eb:a7a2:61b6%7]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 08:21:40 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de
Cc:     festevam@gmail.com, linux-imx@nxp.com,
        laurent.pinchart@ideasonboard.com, l.stach@pengutronix.de,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/5] imx: support noc settings with power domain
Date:   Wed,  6 Apr 2022 16:23:25 +0800
Message-Id: <20220406082330.2681591-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4cf23ffd-c6df-41aa-0282-08da17a67977
X-MS-TrafficTypeDiagnostic: AM9PR04MB8970:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM9PR04MB8970CF7216A19887F4D64093C9E79@AM9PR04MB8970.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nDdHob3vEV5QE2PTr9mIwvNgj20YYL3Dib36PSrsqevRuy0MGIJiweAgO3YfBpKkH7pOuY+tWDglYwxRMtQlBUkO9jBh6wz/yBcvz3tNlM6LsCP5IMR4WvwTlESbmxDQKXB52bG2q0fdp4R1BTNUS7WkuolAblcOg04+VVZHAbZ8vWUJah12p1xmB44HGntJ7ejD91nfpTdMFPD6G/lTzFHEDsDswdDyl/wZp/F83nvy2cj2Odq+tMMsKop3H1vvgVo/M8hM9LE1y6LXRlbY4FE1zB+bCievNAHXJz5EjXToYMD/QzDPsqd0YLFhlG7PHaKZS/IeeK7lJiyqqfj2lb//KeXO++/PsS4dKwzSM3De1612s2Dhn2DMpQ+nG/ZXblDF5gaTxROvNXHTNnxe1lKm0X8yXOD6SaWC47xyAvYIZ3H/xB0KfR0EY8F8CW8qGhDcmX7PH7+gxR2tsSaDAQSVrtrwtiIFSJd0zhDq7hx9+qxMEhI0tFmbZfOqXR/7VVuLoTo90Vz2rCx+qhaPcIZVsb+kdhSJJaLR9GgdS8c1P4PFnvoW89VlIqmIIIc/pwhWawkp8Jn1dlgBhhaNEYT0gZlQRL0C3PslU0uoWdvpyS01i6FLPtpgGm6ihBSjpaPU7rW+Tk+tMCdH6YYjdil6bibQLWpAudZNDXtZVKqVYfm/R2c6nf3O3Rwpb8lpduxvFhrRU1D3PDuNlJuNCQi33A2DeuXO7pEfSlxpORFqLZ3yH+EsmGeo68poyl/iS37sWF/X3aFmKAWAEu4Ka4zUE16W3OUxWZhOCXaIC/g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(966005)(6486002)(508600001)(5660300002)(1076003)(26005)(2616005)(186003)(86362001)(83380400001)(7416002)(6666004)(6512007)(52116002)(6506007)(8936002)(66946007)(38350700002)(38100700002)(2906002)(4326008)(66556008)(316002)(66476007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UEJJPNOfPbW2ynro3fOPv+AAHE6BswPTesK+kQqfz9B9qKivqTcLg/4w6vNk?=
 =?us-ascii?Q?QjnVVEgJJeY35Mtji7DONtG8Uvbd8TeXnuUpeY0CrGYcMh3U4Gldo8WlqEO9?=
 =?us-ascii?Q?fdtzk/6bGbZjSXXsePqbuz63XibDM9fQHiX5V+88gidz03l4tfszmF5Y4cMN?=
 =?us-ascii?Q?Z70J9EfiDYUZDRcAH6Gcfir0fU2If4X0bdz4qDuILQmy9I+iYntutubh8g3L?=
 =?us-ascii?Q?ykQJTFe7SefUl6HLqwK6uvcmEB9IaUpXiHlSFBx/u1SSTSX2HwYRlC3+BgMK?=
 =?us-ascii?Q?PgcDzvlK/Tn3S6+axW3Yx1ulVCLZZR0gIcDVkVl8xQa3G/mqsaIQ8aTCQuSp?=
 =?us-ascii?Q?kiT9imAdSSjejU1OKW5Wrk8X7mHjANmLDe9oZ/Xxjd0Qh6X5yN2CsrxqAtBS?=
 =?us-ascii?Q?itnaiU0FFOGYlzMTU/YW9hVHlau/73qSOqBaFRhcfvabLY1+4nhH69E1aOLn?=
 =?us-ascii?Q?n2RXUMwoto59Jc9sL2QEogOgcBEPatO2xvWrhedkFt/ZgKqR2wdO05bI6wQV?=
 =?us-ascii?Q?5pjATKWvUKC66SU90Jd22PgMldHkh+penrYJcyuTGPilzbuAzrwNOsIx4MKT?=
 =?us-ascii?Q?iCpY0u4oZ15sdtxP1J8P0Zl1hc86WYtiX6GZfGa9HbQIGAykvOMAjlIkUoeD?=
 =?us-ascii?Q?3M69x2GNw/uZEVfvxLlEvut+mjEeE+mewo91z75TpsJaQ7gKKd3BM3Wv7K5K?=
 =?us-ascii?Q?svotDKk/o6YtcPZkh2fKcW5WgzKQZD34dUX5BbkdeDSerGVlzs03izMkOK0D?=
 =?us-ascii?Q?0CHJ2cBL06t0Hmr4BuQdwqWM27CviTWn8nozqFN9XPAoll2krWM17nAl9485?=
 =?us-ascii?Q?QhukgPxbMUlDuFuoS34IaIrga0zZsknuYKjGPJme3Vz9/hHIOXKN5Y9OISNs?=
 =?us-ascii?Q?q3CvqowMESmmzw2DtCn7TlU9ZkzCDSkbFzPlHlhbXE3b3W8YUnRXsASzDtN5?=
 =?us-ascii?Q?/jziAsVWU54Fn0geQZ7N92RQ8mWPCq5kiuuj8gLhjaCwAI6b175205rOsgJA?=
 =?us-ascii?Q?3VMooolSTq7b13YZBZgoOo04GKmofeHtt1BXOqM3pSJT/SsimOm/dx2vjGrY?=
 =?us-ascii?Q?dWyaHs6apWrpqb6cVz5uA9PDaRfjJstzMbDLNaTQv5fqBL1fNkQaoa1HldIB?=
 =?us-ascii?Q?uziblqtUY9rtWC+/KFoi4oIe0Ima1j7jv0RqLMGyfTFpwOu4i26oWw3lfc7U?=
 =?us-ascii?Q?HCfbYWqCSjUmJ4bEgaEUXD8fnnigS9UMvOR8vCibqkQicYLKDD/2Apl6dWvw?=
 =?us-ascii?Q?Qj7qMrQHWpz5xZWmrzDn8o4frSr0FfEXGGoxmx6xig+81Zdl9BO601BX+xlT?=
 =?us-ascii?Q?bLH1qPqCDH6h2PPjqZclBjPMQqRNkTGBIAmKE3WjjW3EQPPe/60j/CFViYDF?=
 =?us-ascii?Q?MfIStTWkUm7XJiF9Na/p0582P+oVfdSc5OFyuv1fc/Ja5gRd3nroSb2mWwtx?=
 =?us-ascii?Q?HKe7+5cPLK2h+c9LkwKY/PmcMiXBCQTAhEnLlTdMd9H+p2nFruKEpjjj6iA6?=
 =?us-ascii?Q?lCvBVot5tByu7n5YabdVS9sn810yZ7mYXAQzcZxJLvVLfsFRXJDtxb4do/g5?=
 =?us-ascii?Q?8e3qgSGtntM4zixCKttpGC1xZbzx7DsLA0M3nY6xlyNJx49eZXnqBYgil6Kq?=
 =?us-ascii?Q?DWRTaUDzf2+JS6JCJORkOwSYzkr0ULZJg6nni7EP6KiKTfhDGP6vQrRNB5Sb?=
 =?us-ascii?Q?ydyAqeXuopCOFwR/K0u5vMTV9SGRO8IA4lXjHa8puVdHRYh3aACkTbK89DwT?=
 =?us-ascii?Q?Cg2v7fd3Mw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf23ffd-c6df-41aa-0282-08da17a67977
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 08:21:39.8702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MExtysMNz/ZXatAJwaiUfoQdFb97ecAU7CRVHjxPKH3IpdoYMf8/jmsVTbhn+jpbN1DlWfpgUApd6Uk5mIAwcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8970
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8MP has a design that NoC(Not main NoC) is distributed in multiple
blocks, such as vpumix, hsiomix and etc. The access to NoC requires
power domain on and blk ctrl settings configured.

So the design here is for mixes that not have blk-ctrl, configure
the NoC in gpcv2 driver, for mixes that have blk-ctrl, configure
the NoC in blk-ctrl drivers.

This v1 patchset not apply on Shawn's tree, I picked up Lucas's HSIO
and Laurent's mediablk patches, then worked out this patchset:
https://github.com/MrVan/linux/tree/noc-imx8mp

Note: This interconnect related functions not added. This patchset
is only to replace the function did in NXP downstream:
https://source.codeaurora.org/external/imx/imx-atf/tree/plat/imx/imx8m/imx8mp/gpc.c?h=lf_v2.4#n157

Peng Fan (5):
  dt-bindings: interconnect: imx8m: Add bindings for imx8mp noc
  arm64: dts: imx8mp: add noc node
  soc: imx: gpcv2: support i.MX8MP NoC settings
  soc: imx: imx8m-blk-ctrl: support i.MX8MP media blk ctrl noc settings
  soc: imx: imx8mp-blk-ctrl: introduce HSIO blk ctrl noc settings

 .../bindings/interconnect/fsl,imx8m-noc.yaml  |   6 +
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     |   7 ++
 drivers/soc/imx/gpcv2.c                       |  56 ++++++++-
 drivers/soc/imx/imx8m-blk-ctrl.c              | 109 ++++++++++++++++++
 drivers/soc/imx/imx8mp-blk-ctrl.c             |  74 ++++++++++++
 5 files changed, 251 insertions(+), 1 deletion(-)

-- 
2.25.1

