Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4D748378F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 20:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236166AbiACT3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 14:29:49 -0500
Received: from mail-eopbgr60082.outbound.protection.outlook.com ([40.107.6.82]:60390
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236147AbiACT3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 14:29:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIkvJiSGnVMrChovV8PpcABuOElyOrHBx8L02slnNEybZXsbQI/8iPXVCCp9aGDqAz5rZUNydbWuPO1aMHqkXSWWhMhTXOuhWWMTWp9GlBUeyVrW637fJp5t9Z58Vsr9y/IfjI9qLtIzVzfYA1Hcll8/iGY9MSCFRa3fNb6TEntFoMXiyqdtYLY3TPx8sFd1hVGzdLdSwhcXCP/hezlQv9dWS4xDyv6EyVgOvP85eKIvM8Aj07Bi56kzTFNI2Mve6SdKj3DJKz4jO/n59HKEl8FdldtjOIUvZQX+1Ko8veIyQZ6bmBlRkX/R5iTAlm8Nd/5wC5qYOhu8xg7+ApbyAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MjIiGWf1Xn+raLbQsAQGGyRnimTamCAvL/Q45z38u2g=;
 b=cot8Gp0zLqH8Y/m8VsfccuvXaLep/UpK5Mp3t4zG+lCQnG8kej0yfGPtib3SACgnIZoR5AFQSOOA4xnchroIDqi8h1ITGxVTkt/kFxMcIJuoxG2qAVimQ9bheTv/nXRPApngEPDSUzL1qKkdJpAlWAORg03hn0n1Ei3G42jF/xP6a302NGOt3I796jes8aECugum2aIcJY7Mdafk4WiFYabYvf+XhkhhkaoDthaeH65UaiDYroiNSDDeKKnSvejkUe0OCyThxhOplyxy3Ego82z9k+5NS+kuKwnRZaHeuD6PvmiET6tRHz2BEPRTuu8lOOLuaytouUYfVpeP8WFBFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjIiGWf1Xn+raLbQsAQGGyRnimTamCAvL/Q45z38u2g=;
 b=SKKkTE5BdnT9jNNxaJGgYBWEkeiFuvXJssVrjNOw5e4cAGZlEpXrqCM0iH+H+FtIUPc8680ek09Wqa7W2BfF3rb/NPDTY1mRuEJS5Q2yvWwljpjiGAhcAxGcUp43EPnkw6b79Vb9pqkONpUhR7qYVScRa2FWg2EJzgLmBuALjCU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.13; Mon, 3 Jan
 2022 19:29:42 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::4c4c:f2b2:addb:841]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::4c4c:f2b2:addb:841%6]) with mapi id 15.20.4844.016; Mon, 3 Jan 2022
 19:29:42 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Georgi Djakov <djakov@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/3] dt-bindings: interconnect: imx8m-noc: Add fsl,icc-id property
Date:   Mon,  3 Jan 2022 21:28:58 +0200
Message-Id: <20220103192900.946521-1-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0501CA0009.eurprd05.prod.outlook.com
 (2603:10a6:800:92::19) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: adbb3cc7-ca21-42c4-b034-08d9ceef640a
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB7104D059F1CE62E5C0F5DBC3F6499@VI1PR04MB7104.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W07myL301wKoPRNM89uyeSNNr8UFmiRMY0iREI8nfD2A2RLueGgyaqjsReo6US7Ux2bpAYAx03NlmAJ2pelASCact/V8ZehjBm4slBCwvegzB9kfWk9qebS5eB4HLn41vLBO3OqyDpLmTHM/uu7zxSmsyNbOI6tLhDoK0GXZTbxNjSmOuf2PWJPVRK4U6hlUDhvlfvHQAth51WkIj91iCuYeCRpvF1KV8FuTs/imp5K2+QVcecIXm/bchkRZ1LJcUNqeSsyaFmxaTOh8P1fizhhhC7BbwO+hJbAdzBIHtmlNWzK24utLrruXFJ9KKZkcStJXWXMambvhjPc5uBuCLsVkhQ8b8hYGTj5/FRJ9t9aMUREUUBkqHmnqlAIrFKeGzc+ZYVgLpRJsvBFmPKHWxObLPdZqj9H7dmpDVEEq8AgN3NSyDYyrnFzgOZxUlh2aqmaPhnDccpCtyn3RojoMTz+kfm+2OGcNJ53P/3bOxRUJoKk1+2d5h4MTwSTf9aWWTJ7GN8ytU3tRv3f42wB8cbUFnZ/w4RWV09+nLnGQUnHrrJEDiOwZH5ykJBZECWI3NAzwqLVVYjRsrTBJKZE5ykDwzHzM0Rk9c4025rqoEayQZgXgzY00fkLvpMM47rd/HPfKpYgWWQRSOmqzuWa69rKWlc97pcO/zei0jTqP/Og0HjdcFIpKyMU6dhKymfqbYGtIYR7fY2hXrtq+UkQCdpCTByR9m+piJIlxkO+hIE0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(2906002)(66476007)(8936002)(36756003)(8676002)(38350700002)(38100700002)(54906003)(110136005)(86362001)(4326008)(66556008)(2616005)(66946007)(186003)(26005)(316002)(1076003)(6506007)(6486002)(6512007)(44832011)(5660300002)(4744005)(52116002)(6666004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7z0OEBVPQS1CgfDe18rbAMwB3xfoB5O5TPGvQe8ZnCrXAZeeiVrpfg1abOlP?=
 =?us-ascii?Q?xWD5rfIoDOiK3NmJ+j43mKRkK++hV9i2ihGjoxFq6gQodXQrV7DLxJu3pUCf?=
 =?us-ascii?Q?HLj+j0oMhOMDUzSvbFi5SdVv9IHuKQa+NZRARmJcRXMBuZ9dTstFReDlPgun?=
 =?us-ascii?Q?d29rbAp77JN174UNQgiRCqTPN7f/tGYW9UmwLh8ySBRepsv7oofyD5KdGGus?=
 =?us-ascii?Q?J7e2oV4m5r4Y27D/0ilzbiOJF8wNqasppBWEdBdosXQlP46guqlhAIY1UgdF?=
 =?us-ascii?Q?O4/hZizI2bNAFopYW2t2IS8L3lZth0nvwCr2EQMp6oeX9ujE0eeeyYnPMzeT?=
 =?us-ascii?Q?no0h+0ZFIAZi0J8L9RYy18Lw8K+f0xYpOwlhWIpi+KN8MUDr16LbA1T/Cg/A?=
 =?us-ascii?Q?x00HTWx5ctQ9rur2xvCre3HDfEtbninPxAIyGMdkr+FXoiQJpYAkge2oCZWK?=
 =?us-ascii?Q?hCJkLyUfkagF+2VdSJiNbdZyIy8s7o17lRSfLYznLnNqKpAb91hNLknS58+v?=
 =?us-ascii?Q?U7B0Ad0HxrS9ATp5ijgpbqiGPlB8ut3TWi3OmrSzyd9VEY0K1SJeW44spSNp?=
 =?us-ascii?Q?p5XxHcu4+vKcTuV8cp1Wm5NYwKKdd0snrGRcqXGcj9lbPA4/gvaNP+xyPRLC?=
 =?us-ascii?Q?+I4mZugMu7cUP4dA0roeu+Oe5TgE/KPT762yhXlDLDF0aF3P5sECzk4JvFcy?=
 =?us-ascii?Q?DApF5ozi34J+jVO8O/G1wcmnhro4tpTfCvRRs9d5k+w6FxTyM4gHdTkNMyN5?=
 =?us-ascii?Q?EXV55l0xGp/y6QM4peQtl4uoPt0zC8iHfzWqt+Yg8pNL7CD7QwfJLu4aGjjm?=
 =?us-ascii?Q?jTcscFqOE7HN1ZpwlAqTxhys/wcSRkfzLbiq1cDsFB6modw3q2Z68YliZOXB?=
 =?us-ascii?Q?l6oYZZUqUDcfko7liUodpCn92q/GuY8UjOIzOh7X21k5VdlwLD+I/OJSUxDy?=
 =?us-ascii?Q?fj0IXma0/PXSft2pGAFY6mp8uszQ6O0xPO/xzu/s0uiYWrg8z2YrNsq15w7s?=
 =?us-ascii?Q?Xgv5UJxkvMX6IyfzUhzrTeF6LhEru3SwWwEPS7WSq4hzQ+TMK7z/2V5zLiuz?=
 =?us-ascii?Q?RGl9opfLCKa2drESmdy7gXkcLx4uOrhLr6xwJylwLX1NOLLbNo5WrRXFSSKc?=
 =?us-ascii?Q?z/asAisH+lza3Sp9zQnQ8RNdIqxI90JgK/9xTxfcIme/IeMTVeEyPGjdnihq?=
 =?us-ascii?Q?BsVYDesqCWSRGNzyEWEyvx6yvHZvcyTMN1REhXY5qBc+fKGi7HaBuZ0AHm8y?=
 =?us-ascii?Q?6EYdeOD7xDRHy0XXaZ9I4jnxW8Yr5xyUcil7vpE1UKLWFqO7oLH6vvmfYsLh?=
 =?us-ascii?Q?cLFLEbeizBh2PbGrRrKwnOoU59da2fH+z5nGZSVy0XMGRtNWzrfd9/eMzTZM?=
 =?us-ascii?Q?KLdkHbncN2fbvYxXeRWBQbBUg0X3XqFs7EpBHfQWefqKmnkWDUqEmfsiWrj7?=
 =?us-ascii?Q?VoJMhxTOkNQi5ZUkxjqQ5mOTYbOCgU0ZOD3B0KUKbwZiKwly2NT/IHyyq0Al?=
 =?us-ascii?Q?kdiDQeGYMtVInTVDAbgc8hrAcVTekK1aofR2Ivkl8XlkPDF4hFrshiZAJBcQ?=
 =?us-ascii?Q?+jKvcOFLJUDsWfIeHMd5MR64bTf+WzeIAXFch1Dg5cziDUS4+W1wojHNiXu5?=
 =?us-ascii?Q?S64P2a7znFz5T4itp+/I340=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adbb3cc7-ca21-42c4-b034-08d9ceef640a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2022 19:29:42.3341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BnKUFjPNOyILtcqnAT0g5EAG5jhS1+NJY8RoMac1ncNnuPZmufAjMsD9t70yNZAclfKrEAmELbRQyrubQNBWvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7104
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for fsl,icc-id property.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 .../devicetree/bindings/interconnect/fsl,imx8m-noc.yaml      | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml b/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
index b8204ed22dd5..4924743e8cb1 100644
--- a/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
+++ b/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
@@ -47,6 +47,11 @@ properties:
   operating-points-v2: true
   opp-table: true
 
+  fsl,icc-id:
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    description:
+      unique ID used for linking i.MX bus or ddrc node to inteconnect
+
   fsl,ddrc:
     $ref: "/schemas/types.yaml#/definitions/phandle"
     description:
-- 
2.31.1

