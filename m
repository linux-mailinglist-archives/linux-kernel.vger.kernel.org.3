Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CB95299C4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 08:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236775AbiEQGsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 02:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239615AbiEQGsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 02:48:00 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2084.outbound.protection.outlook.com [40.107.104.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3E645060;
        Mon, 16 May 2022 23:47:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VOxMpYsRzcj62TaXGNKZoj1mPxjNHWDf4MGspnAahJ3n8kzKOh2h13W5jbbjdkAL6XiSN5zicKM/9yyEATO1yV0KNPXDiiNShlBS0HpkV7OgXZparVrY4fPazkgTua9j12cBykGssOQYVvLcdz3UFsBHByBrwjDhLG4TiIiNP0+0LcKkBolpKz2CheO+/XUwNS4YKU5J1i0YRUZrZveVMMUDJZUGBbc4Ysl7uMWBSaQr60SAn7vSQhheGFPWyk/sFrcw11+EhE/0sy5sswYv2sZUHnCZLka8gxOI49w59iroRSqtLhIKvxkewydw/wTIuM2j25ush+pUYJXMeJO9Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBJ6N5+W0sIpUXtUGdnCD9H+FmqUaDWN+3rhFUIF5js=;
 b=lQQHvMNUIMKdJZMUswYYXRvMN/v9eI+nSGlLvsVR5xKS8oaJv8k8dS4ggOOt2pUCJ3OLgNfvXzv6YcqoXZFTWpp5QC0kQX0AXiGyUhVSA4AfAnDoEd2qvrOLIiM0dF+UW9xuWkdJjd0+eVnsw29R7vmkVocG30Q7ekKsNv/D5KKFZMlBoYOpj2bi3qyoW9AdFoznqT7NBp5VFD/Vmf8avQJezastW/NFZVtqFeqa1ITOb9Ii+MnzfQjS0xUUDHqKp65LdEBmEjR5RvrSVWuvxwXIAio/LOuY6ZAj7fEbwvRb0e2upNLKMiLAOfvkmyV9c4vfsmRVszEKRuVi3CKAfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBJ6N5+W0sIpUXtUGdnCD9H+FmqUaDWN+3rhFUIF5js=;
 b=XpgW4D7TGNrrV0wq1ApA0XZ4mij5TYEGhuH9xWTbJv8L2IwHfVX2DQairpoYaIlLxAHQGs0VXGxjiqjAM+tmVBAXRSGOwNDXUdCtrYLbgQ/YahmAsWpei3ZNN9Oy0Huw4czmpfiHI5i7XUjxQY5Mkmg0l2XpeftVCztqFkC3eNU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by HE1PR0402MB2697.eurprd04.prod.outlook.com (2603:10a6:3:e1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 06:47:56 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5250.014; Tue, 17 May 2022
 06:47:56 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 1/6] dt-bindings: remoteproc: imx_rproc: support i.MX8QXP
Date:   Tue, 17 May 2022 14:49:32 +0800
Message-Id: <20220517064937.4033441-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220517064937.4033441-1-peng.fan@oss.nxp.com>
References: <20220517064937.4033441-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0005.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::11) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2a8706d-bfc8-47f5-52d3-08da37d12c47
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2697:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <HE1PR0402MB2697A06CEC929BBCCB87D566C9CE9@HE1PR0402MB2697.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e8EPm5fO5Pgx3J0WIW7sTE72W1JZsMLOH/QpA+gUAzkYIpIo/WG1gOjuZt4Cn+ZAEeiKMBMP9zY+shPY/Og8lGYjEheja5qK8dk+p0pk+1xOlf2DDURzv3DY3I45pn3NJBHCh/n6DHzjVqv8A20+VlRSwGipy13lQ2zEL2RS+DQ6lLgpKr08gvXSzY3RRG3siTrDcp/00Nedwpch0BcgCC14b8JBep5UlxCwiM/MFHnncemFwsd8uRdu9EoRJ48SPEhTByx4CLEKIGi5kHrFERgUylWtLQ5/m43GC8e4kZz+3yspBo8S05AAcfMogQyyaE5Zuz0Rtu02hX0JYfG4lENtnTgW0Ui8I7sQCmZvCCC7aBtvqOpFhidYTElx68Q6F7j9oVevQUyzDErcKrkYEP9CSnWQy/+8bcRNdFcwlmbAD5u+y7aSd8wUwFmkrJlJ1C5cTc1ycMSuHsvuM1JNuzeO0eEOWx7RM160JhY1SrZR+JfzeAvLvfxCmEyDzm33XTLx2CeORDrPrNnB7Ycawb2AjIbKgz7Oz2GeoubxUbKwrzmEeCuH6oqJsXtbcqAPVm/QMxHLkH90ZaVFkG8JUZAfcET9HjXhEwB/+gM/57R0EDz5lsF92IcNM1ILqR8apNyeb3EnfxKaY7u8OQ+oBueFb3lab8lyU5G9Bc80ObEPIA+stOrLnd+BCYd4AXkfGc7o9x19E4UCpY2WBqzjFoQFjDlLOJKyfWCkAj0x1hY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(6506007)(2906002)(6512007)(38100700002)(6666004)(38350700002)(52116002)(316002)(8676002)(4326008)(508600001)(6486002)(26005)(66946007)(921005)(66476007)(1076003)(66556008)(8936002)(2616005)(186003)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HRXtrRNF9cQUfo8/NwZzDnvzKpNhLGZmRyfuqo8FJc6Ph4M4ZzjHnrNjSHSL?=
 =?us-ascii?Q?rZnlrC80zYalk9iPkkUPR++FTGgSCy9uPE6RwTVpua+l/La+1Aa8fuZwJYu8?=
 =?us-ascii?Q?5hGJ2YiCnJtYgr1Psybz6HQWQOYwZzoiFd92Z37ZhfhZuuDfDMWDg+05pKCO?=
 =?us-ascii?Q?GkxW6wWeyfd8jxD2h4UYaydGV8yyHEeWgJQXiS0bApdunJmzxo8IQmjIUTH1?=
 =?us-ascii?Q?ihbMYtYEFXMpNB4KpY2mIcN46BxdBs4dHIiOr5BP7cQrMH5NT/2ALQzx5ZgT?=
 =?us-ascii?Q?VD5QNG0JOLmF8VZlkh1eES5072J5deO1RNfFlYARUEDAxJbKrc1iicwzwY2n?=
 =?us-ascii?Q?ClGqPPFR4MZ62LIiO5f3OeMUFlsQ1YZOpn7/xfVJvZ/IZ2pp3UBwnSup6sY5?=
 =?us-ascii?Q?l/JIbvj6otdG0RP++S2sZSpeh7L+VoOAa1zTRYW/DDpym1naltJMV4hcxhnR?=
 =?us-ascii?Q?y/YCnOPkSHq5bnk/aHDGCUGDvmFavFO5DbS/XJp73Dz8+rlMUB2xip1f+u0i?=
 =?us-ascii?Q?0HU6M3wFh/KkOE0Y+8461OsiEVCS87phY6Q8dxesYGSUFOh2GQnfkd0BXnRw?=
 =?us-ascii?Q?U2BbqIKo7VWbMzpwknhp3QKdpfccGefkeMmgFkZONsZURMFn7SMvZHSmIDW7?=
 =?us-ascii?Q?0GbfOVWIrBXp28UYh8tWJiCfZHkzaExUmHBYjyPZzACbYJfibjZQOI3SHEvZ?=
 =?us-ascii?Q?LxWjm25Rex61qOVRlzBDjLM+Yr+omCC2YDRXpRrIRg6j9H/Z+x4ceNpaJXnH?=
 =?us-ascii?Q?3uU8zI/Wtst13R6evLDe/WB/xa+jUxTdpj5KLqjk4QexAB8JVePmDi+uRiII?=
 =?us-ascii?Q?hIYLvXT/4YqJAXz23e783Vt+7Bqn43TP4P4qQEM3TZv2RAP66dldlFep/N4w?=
 =?us-ascii?Q?cmwoU7skscU3iJBYGPxkvCgaUkJRT5AR622pUT/ejmfHgb62FuxOqpupcyko?=
 =?us-ascii?Q?VCbW2j6hYsuFOQS2qfHV310VQ/Ewc6egpY6ePQAH3JwK8suuGOjZHUmNedDG?=
 =?us-ascii?Q?qm3ewEtn66fYmQGzG5rAeB1zw7HaETrThZZDalFNzdJsKV/vlBLdIrzVNK2A?=
 =?us-ascii?Q?z4KHkxpp7B7gl26NDQNYh+Fp+EIwkCoeZPp6BrskBJavm9Fpo8VW5jys0FSO?=
 =?us-ascii?Q?1vjYIVmD3pBGPyNR4iM52FPXjY4LvFPNWxNbuN0DnIkZSzlgSjx8jx/qAtme?=
 =?us-ascii?Q?7OMsXnePEfpQuTKDdWPJ8YOQoundL562LZ0MP0A2djb0fk/aWLdx2kVDZyz9?=
 =?us-ascii?Q?+UrbX3/tiZ0uN8fkNxrOpzYzyqqQMM/g4h5/2uycs7ZD3SnlsdKVyMwsYpsu?=
 =?us-ascii?Q?QMJMC1gVJKRzX37QEQRo2NajfsCBLS8Jxrqu018G/hL9AVKQMtH8qJhXQ1IN?=
 =?us-ascii?Q?bD8gbWdzGsBbmUuqpJjHBxAeaCznbOC99QAkYUKCJbnwK90G3qf1xHhqvRuv?=
 =?us-ascii?Q?uBkAirQQFjdf38ePuCZYhpUzcjNR3a/M1o31na5PaydY+k0PLradvQkQxhBe?=
 =?us-ascii?Q?DX4PJk4oNIPEWZgNdWf8JPp9CllzJ8U0WAFnbKm9PGScUuE2E8HpS8Y/Eg60?=
 =?us-ascii?Q?ESOjtwrYmzy9cljTMSDq6TsJNfy30NQfq6qPHAmzGR8s/uNT9UML3CEqg32U?=
 =?us-ascii?Q?xmc57LEK1VWsT9v8BSU5USXSU2KfZibNJGKfHu6MIb5F1e9hskPI61Coq3Yd?=
 =?us-ascii?Q?R6K/GhXHMYVzpJ5t83Y4yuk+iVFWjTIxTjjapxjbznlllMNnuhk6PMUcDxGh?=
 =?us-ascii?Q?1vjSsZeCeQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a8706d-bfc8-47f5-52d3-08da37d12c47
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 06:47:55.9254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KyzpiDTRfvTWsMwafGsuTS6sBMfSH5Vfe9o3Zc24WJShYV0lwlV/3IAYIesmwJZize38cqnsiBK1RrOwFm71rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2697
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
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
2.25.1

