Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7CC259F08D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 03:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbiHXBJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 21:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiHXBI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 21:08:57 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C305080B6E;
        Tue, 23 Aug 2022 18:08:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBP7S4dXBOYkLcxHvR3wzArX+1v+gNhNt7BZzPkblUVQg/jguuXHlIlGY41cxjySmcivk5kXDp/krMrp8lyCQXYUlfqK7HFOu5+LQk6uw7R2m9bal9g0GCg8KrjuXSDEsHQXlRt3YjiX1jD1CabrPecd3dnDcrMozLdygoMNK2g/cW1ltl1vhgkkfBpzQStc37Ufq37VUjQLI2dH3ZEPfkUV/kRM3Yr7U8Z5EGa45ucCt6rbkhciO89k84TeC13rmBofTyT1XhkY6Sye5czJ97XFeN8jBhzmMHo8pJ/oKn8d6FFB64logh4BcD6jWoEI5NtFxxobEllWEI4Vvyt9Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05Sxwp2qiuQnWOyN46jehy6hs5jPcBhHTOijKpW514o=;
 b=VighQUlbPtcQzXSYmb0ilykoWlrQMR67mormgw7P5Ldg4QcgvWVNyIBUOIBEajlJNtWkOiwqVR0i8ydzN9U57DFt2nDpAJvAxgJ8Mq525dmIl65yhWNQhYLX4Dvk7s+9URgdLspKtlj6ilwtczWes1/yS0yuAcrcaZ3FbeFPJUph+TnvUMKDv9hnHz/v6v1wOL7feJjvzRsathMtPYSKImFtGeSAslrST2Kl1KH5Olb3+rCHb7tLHMfwmrrBlbFH9RAYHzGiQb5bapBBoPObwYwbO3fPresIda0nL98xspvD0+QFa2T/rP21IsNNkgN0pjOfnmMjRWFvQKlSBzK1AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05Sxwp2qiuQnWOyN46jehy6hs5jPcBhHTOijKpW514o=;
 b=Qjelrzprxv7o2UnElJc8fwPbG+HzCtCiiN0mKU8TqKAv99h4Y2aQPFENwVHE6R+a4JP1tbaUr7a5AWOSgZ0UW8tZv2Hob+AeL5up7g4pGYpaY3beNJTg4TKFQdUoJYp5QSjP+2RNUVOS4Jq8qBmPhn68xQ2ROlh96f7sj1owwQg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB6182.eurprd04.prod.outlook.com (2603:10a6:20b:bb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 24 Aug
 2022 01:08:52 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5546.023; Wed, 24 Aug 2022
 01:08:52 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@kernel.org, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH V5 1/6] dt-bindings: remoteproc: imx_rproc: support i.MX8QXP
Date:   Wed, 24 Aug 2022 09:10:18 +0800
Message-Id: <20220824011023.1493050-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220824011023.1493050-1-peng.fan@oss.nxp.com>
References: <20220824011023.1493050-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0192.apcprd06.prod.outlook.com (2603:1096:4:1::24)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe774178-2945-459c-336d-08da856d3596
X-MS-TrafficTypeDiagnostic: AM6PR04MB6182:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8yDgUrfSOxOTSe5PthWAA/ovyWGHXfw54mv65hrm1EFH37IwcLER2H55DDLQ5Bk0/IV2YHGElfR9EceMFmLjBCmYHK40SIK9gOn6RceTUPYHN7R5zgT3FVIxCB689Thkd/J5k4MFJ9/43onyFD6U/mUV4UvBALjNA652BT4ShLnCAfwGxmvo2s7glYa7iKd0EPhWboJK4BQDkXSLX/H1jf+47TDZFdVgCsfDuJEOVIbsM/tjcLTMXIngT/Cy/Zlfwt9h1gqolYcXRfU3YcD3+r/NKw8yzPGjVAMYS3+KVnZrSlw0GCxwYNxLKvt43h7TW4lyNkLPBAyd+Sja2nxcMt+LUrMa8wIYCHvNt/CIQoNCUByOU1unSzkpP8r0TirJSOW7IkDUtZ+e7owRHHv2z2BTzJB4agMhXVJa69T8bCZsAVQCixIH+zGOys6irK3Np1+q3A0Rv3vvXBvWnPA8rStd9LrYdh/ldjehTosLI38gJ9WgQMSI59ClGGLCYDSA/JUFvhX4zCGbSRSLo1IwAhxRb9OxrZjtxG5qMXaSfPEQehN1lhGqZ13UMcnHK1WZiYIAI4GCaTyj6AmCZuJaisaQpaPOqzr3ttyANC997/qGJv3gP19H/cldX+R2i1lhS583IgvgQFpuAwqN7QOiWEBDoMVqpmx1WtdvUbwPweJeG6hgT/p0P0NDWxhU+q/pNi1TaVRQNmvJ/QZ5A0SzzTaxvSh1TBx6RpSS+/OPLDQNs9goYnlkubOS1pfWrb0nLlsBGUzxdeeN41voP/3DbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(38100700002)(316002)(38350700002)(41300700001)(6486002)(66476007)(8676002)(4326008)(66556008)(66946007)(6666004)(478600001)(5660300002)(7416002)(26005)(6512007)(8936002)(86362001)(6506007)(2906002)(52116002)(1076003)(186003)(2616005)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g9IA5SO0BAUTihkFcaFWS2JOUH5Q0LYyvS5AQj10M2UOuyMxrcxzPvsSfLJj?=
 =?us-ascii?Q?9pVNNJLVepMGVOIrg3vZ0rjswV1Mf31aNr0ekyPGnXfFz21Pm6XDtC83wg3x?=
 =?us-ascii?Q?8J4ZaGus33Y6j11L3043PRA8tkMTcdlavQnXCkCImKCQMEumO1hctbqswpOR?=
 =?us-ascii?Q?dzJLJoMB/Cyyg4DAd+lOc2RS5gwXiV6FRTwzCqIIUK7bNiAVFuOzhyhKCVFa?=
 =?us-ascii?Q?cPr+9Y9aERr7Ey/tEY/3u/U/6br8d1YyxbwJUS1UtZnSyezQRJQXmCy7fPC8?=
 =?us-ascii?Q?orm8u7w5F45TqhKAQF8FWCO1qeGx1X0+LOElRPnvBtlHVN8XJy3MKH30zMOA?=
 =?us-ascii?Q?tYCPlFuqly7Y4Vpp2KqbRy3KUiuPeOwt9vkQ17FzRA5N7389tizCwBu5c+Fc?=
 =?us-ascii?Q?LkT9MmrlwE+qICZFXeLtcBfeMoR8tYjiv1x2Rjvwc5L/No52d5TGBA8jrul2?=
 =?us-ascii?Q?TelqbGMqYg4i6hr0NBW3eHhr+rgXJxeip5Geu05BUIGiBUBdOMBjhBP1feFV?=
 =?us-ascii?Q?ZXr1fCc2UCZrNa67tg05ZPaQNLpovxF//Ok/N4MKQLM1cYrrxvvtu37eeECJ?=
 =?us-ascii?Q?u24s/E6IvDYMuER03JieAllidsAwACov7Q4JqpjBNlm2+YsSDrf2FE6VbMKM?=
 =?us-ascii?Q?TOWyRgwusdWZsAuWTuJGMde307nH6IqxGisBHrLjF/RubYZ0AuPDBazACkq/?=
 =?us-ascii?Q?KewM5cawaUfgzDR/KUMxUeC6eV6uo8VTmFeJPwuXr+153ZnMRdsvUmHI2qoT?=
 =?us-ascii?Q?YzxRmTDkM13p1/mzAAnpoV0h4EEQg/omCXZvI6eVfTGeELSYl6qdpMD+6paI?=
 =?us-ascii?Q?9D5E+Nw0PboVZ465TChtw6c1TY1eUYgknqe7is/stbHmcrCbTHqZAQrZobqh?=
 =?us-ascii?Q?WgxvB17PnxgeMmGhOC0KxTW8YczxCKTJIjH7GIScdsxzCuHfQP/UA8mB2tov?=
 =?us-ascii?Q?8YhcG9R9AOcS1VbcwuDLaBtxAn5OIYqP8iTxqnNjtJ03Qyh2NqxlLRlSrdju?=
 =?us-ascii?Q?veyz0EK7ussaSGh+zbNjdZfK9dcew0hXc92AfTmfiNe2PE15M3IAoZtN6iPB?=
 =?us-ascii?Q?mY4HUU9FgRYAi71TKJABqPrz57N1ZCzKd8cHOehFb2mm+D/3ZC3qYy9FGNN+?=
 =?us-ascii?Q?KpLJnZZPHlg8NfDdTwnSWNzoRqugPRBwh4o5Ftv/ZPm/nUVak8k1sFlSOpKs?=
 =?us-ascii?Q?7gX8m4MMB2qJEUhS/RYAHUS3AqBo/vmoEImjDFH65SSA8ezEvuku7MnoRwdB?=
 =?us-ascii?Q?zcvTl9gWp4wX8IW5ZmXeQkUUCCeoJiWIiAy9f5NzXH8KFSXuLxZSOeb8nNQu?=
 =?us-ascii?Q?kKzdxJto8lKR1NiwtctHgrpAMw7ZFezuOeuPz2Rmg4CT2aYnwTrOv2NzGNhZ?=
 =?us-ascii?Q?uz1ZdEOaePaosm36odxKvey3Famr4gvug+MnriNLJPTbvBmscbH1bUWH+D0U?=
 =?us-ascii?Q?8g/epo+eRWycSBXQkxDSe4qpINT2cuEUHLs3cdb5K807+oMxdRP3mr78+/y0?=
 =?us-ascii?Q?VyWOllYne+d1jf8PVV8ig5aMokH7P+DETz0W7A356SRHUqxDJXyyF3N49jaK?=
 =?us-ascii?Q?ysV4QIbWobbVwPC9yE+eivR6brkoAUCE5LWuyC0U?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe774178-2945-459c-336d-08da856d3596
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 01:08:52.5342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zCmxW99+DNf2zUG8Ne7qbfehTErOSJPPQxSnIqqalwyYEbo0Mc99gZvNwU9C/v6u8aZPrPKAt0sUh2ZB6cUt9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6182
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX8QXP compatible

Add a new property fsl,resource-id for SoC which supports SCFW.
This property is used to check whether remote process is under control
of Linux or not.

Add fsl,entry-address to specify the entry address which used by SCFW
to kick M4.

To i.MX8QM/QXP, when M4 is in the same hardware partition with Cortex-A
cores, need power up M4 through SCFW, then M4 could start. So introduce
power-domains property

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../bindings/remoteproc/fsl,imx-rproc.yaml        | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
index 3a1f59ad79e2..70322e57b6ff 100644
--- a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
@@ -22,6 +22,7 @@ properties:
       - fsl,imx8mn-cm7
       - fsl,imx8mp-cm7
       - fsl,imx8mq-cm4
+      - fsl,imx8qxp-cm4
       - fsl,imx8ulp-cm33
       - fsl,imx93-cm33
 
@@ -54,12 +55,26 @@ properties:
     minItems: 1
     maxItems: 32
 
+  power-domains:
+    maxItems: 8
+
   fsl,auto-boot:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
       Indicate whether need to load the default firmware and start the remote
       processor automatically.
 
+  fsl,entry-address:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Specify CPU entry address for SCU enabled processor.
+
+  fsl,resource-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      This property is to specify the resource id of the remote processor in SoC
+      which supports SCFW
+
 required:
   - compatible
 
-- 
2.37.1

