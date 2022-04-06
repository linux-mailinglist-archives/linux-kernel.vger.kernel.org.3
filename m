Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB524F5C33
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 13:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236952AbiDFLdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 07:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236690AbiDFLcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 07:32:50 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140080.outbound.protection.outlook.com [40.107.14.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B61454048;
        Wed,  6 Apr 2022 01:21:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hC/P8+mPjAO1/5GFHEtQ5X0inQL87tcGqQ9qI+/Fvs/TGpptf36hrRh6Smi2ohr4xVq50KtJItgKkBrw7xHnfQYAoZwhvY9EMpsIQdkNEpXnZVsyNPnXEnAN0AKGgcqx7m7rECLfUJLvVKxMjnsO06kY1XVsWVTYtU5Tu9BHsdt5sdBssvltZ32jOqOxcf76fb2s1WBPR/j7QcM4AGP8YcXimlCi6otImF49Q4XWIouPVzUrttXmzipi6/BRWggxCrn7/WWngIoP56rwKrublyGPnLJsdkgWLTJeOsOPoAK8CH7pqJ8qMcjUCpFjn+2Ba72oKz6I6PDMlz53jQUbEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAiHltzt9iPXWs7va5jg1kDM5JO/U1I2D5o0n0klu5k=;
 b=VOYDW84wZMZ35kiNZBbxyAbRF67rwXn5UyHYRhqkAYzk27XWqxUus4tUm0TXub3xjDNghdOOGkgBLHT8InT7vv8Z4NBvducbQrmMunQh9jc+zUrqd5ESasK+ttstlh92fR1dwA+nMLImVHjeaG7VqV9xUU82Q2PaWc5JExQpoam82rdlE3KI7caFdnRzyhsIBqxCR4H1Otqd4L020Mh+2xoZgnOa/x2c5v1EaYi2XxkqiPvUWp17EMEPmoZX8YjcRprEV0163tGregxFHlkPORDQUBZemuyi0BKFcpNoQIewjbF1U4SvEfyXCSkvdw1dNH9sdGPTLDZ86LQFBMnqBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAiHltzt9iPXWs7va5jg1kDM5JO/U1I2D5o0n0klu5k=;
 b=CpOz7Itsduqbg3SF9FqpHf9RavPrBzuov8av3fnNcQE64XsnoxmCLXfo7FPaEHmdgjOimp0zLQMNyMVEFkHmPNE296o1pZrzMjKeGIqUT5JBPK9UbJRVx9JlXEHoGZ1NA2IqafclYvwnBcroizXxDIcewDo2f49ubXkInCwV10Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB7PR04MB4988.eurprd04.prod.outlook.com (2603:10a6:10:1a::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 08:21:45 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::389f:e6eb:a7a2:61b6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::389f:e6eb:a7a2:61b6%7]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 08:21:45 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de
Cc:     festevam@gmail.com, linux-imx@nxp.com,
        laurent.pinchart@ideasonboard.com, l.stach@pengutronix.de,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/5] dt-bindings: interconnect: imx8m: Add bindings for imx8mp noc
Date:   Wed,  6 Apr 2022 16:23:26 +0800
Message-Id: <20220406082330.2681591-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220406082330.2681591-1-peng.fan@oss.nxp.com>
References: <20220406082330.2681591-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 310d2d00-5f44-4e2d-a585-08da17a67ca6
X-MS-TrafficTypeDiagnostic: DB7PR04MB4988:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB49883FEE30F6F7B9B1171557C9E79@DB7PR04MB4988.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CyYJsXmBT/a0o8Sp01HOHHVUNTiVIG+CoG5duD9mm4hKYDXnCz7ukbDRjs3H9PIvaDqrVkn69ypL0RNUmDlk57qkLGlRyMOiOTDOFML+gmIScvwflvna44ciYPjwmaUZcwFokIvpzX1bHm7DY+LR0PFg+GeNCRsmJZ8A+Pmr3q2/TLZwvw6IEDcFFR4XOjxj97NrZCj/pcw8F8AwmtSvBTJH/zl2EGYPFR5+YITF719cB34VX46+L/qkCRdijtyBbuXGLv9Ea0yLGf3cO4Tt95wFXy6rWEKaYst2BJlDaEkzx1C0veEMfZvARhj/8UBNF83xJax9dSBXSTMbnse1GYX7JH/vfJpkAuBt85DaMW5nRJf69P222I6BgrkDw/pxs7EJgq7/iarRSeEEdDAw9qpiEyChIEABcXf2AGITv4aDrA3/6VQGvkJs3niSNZzQWTQ850TAOIiutPFNPJGQZECeqqWvXUL3mFr7gs1+RtlV2+vsleARmh2bLpI3Wwqp62HJtm/Ebm/UzmO77g4sy33tdx9xYh7F0kJQUpoZaQ5N13i5/Hc3W1HlGyRd1uHn/SkBOzjA5nQ3bwTsGNGJ/IN1ec92e1blcAbRSth7+rlEjy0gATNmu3taP0I0TL9PfKVlzpumY1usrxyzQdSgV9ET8qo95f2/flBqt1aA1IrR2J55dWQHAdrg8HN64zLd9Cqgn2pFE9OEpejKtGY1w/lTuNkZCPk0diUzjbqIFxs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(7416002)(8936002)(4744005)(86362001)(2906002)(38350700002)(186003)(38100700002)(2616005)(1076003)(26005)(52116002)(6666004)(6512007)(6506007)(4326008)(66556008)(508600001)(66946007)(66476007)(8676002)(6486002)(316002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1XK1hcD2OdwJ4GcmXP1qV7l+3voBLiOYVZsdSXzi+besQrH3IuW5ZnVkuhx4?=
 =?us-ascii?Q?2oDgBE6AowJutXUPO0A5yN4FfszDDhNjgxHOjmLIAlf5HYKdJtZYcTcKL2CD?=
 =?us-ascii?Q?UW9jj0galc5u5JkFm28clhNRun/coO9o5LshvMA/XSofl6ggPy30huTYnyHS?=
 =?us-ascii?Q?Ybr9SNpWWYNuHaDdkw2EO8YWfmUfJwW+ijeNJQTKH6sxRVaYGDOoTHFGIF+z?=
 =?us-ascii?Q?n5CoCVCnSzROwYFWQPebJCtLmN6JGkRonsLCu2SEFlijD0ecdLtgS+1JuVkH?=
 =?us-ascii?Q?ktUdD7IGTvSdwc/WBU04X57RwGEz64FdIRcPea8GdjKP/Tv+63slYt/2SAQE?=
 =?us-ascii?Q?lyezzHnlnT2zAGEPX1S3Qkk8wwhuwrV6/tGqOif9f7zINJvEF2+xtsXYRnCW?=
 =?us-ascii?Q?QtNim+9aDhh9f+4GY3WTHxbFyMz6ZeHDjuaDgtvVEnOcE/LC24OwO7vVdOkZ?=
 =?us-ascii?Q?ZBB+qPXY3DpmdGPdY5p1S9aOLa2lcOgSN/vKJyoaFcxWc3UY0JOOb7v5aHR1?=
 =?us-ascii?Q?qGJ+TUaTohCaYUrUzDq4WnXb8+5GcFLsJ6diPesn+wcuCt1x9roWNCJbd/qb?=
 =?us-ascii?Q?d/1zPrzSp3QnJvw1AzmIKWS1OCwSMU3j/B9VVK3Ldbv6jo+SdnJ6z8mBlQx3?=
 =?us-ascii?Q?sdzce0UxGA+pvqknOTxCyJ650OT/DI9aoEqBJ1v8A3JdWur2+y2cg7juGzpM?=
 =?us-ascii?Q?SHTZ6SWBugYR2n3tPkOpBBiSBqyIaPjr6dfAThOAP9FsC+oxmzjJqLCSr9pu?=
 =?us-ascii?Q?BEnB99VCM6q6THbdhNsHeelukp4Mt5zRCy0MqX5uOVogRorfQ1fzXXFs6feB?=
 =?us-ascii?Q?MTUn3lLOjzSQXN6qlyfMtMjDKZFBG3a88SrDB+Oqo9fSrvAD9YIJYjTsN+7b?=
 =?us-ascii?Q?1uUawD/v9NiUndGisrvIwIH3pfyf54tUqgZCOWvIyo/cW99+PKD7Sh2kmwPr?=
 =?us-ascii?Q?1cEFrIVhHfzFZDDiPva015r55Ji0rOBFWO0x1PglKsj3B2E3cpz1d4DbhLES?=
 =?us-ascii?Q?W6jESkmam/z36b6ystnR7S4JY4oAQAvTJsFkWDoHXzG4ip8QkaWABBUnN2oq?=
 =?us-ascii?Q?dUJ9IWnJ8d+a65i27sExp7iCAunUGjw/ARzbYYq7YFGQ6sOs11HhFTmENBzL?=
 =?us-ascii?Q?hv8FiBV2oPqiuJv05AMn3xFVZ6Q0YUQ6g34G+QAc2HEb7rQJjeHkSPfkFv4p?=
 =?us-ascii?Q?tLm00KAyMtaE3O/9bjvnUPPVwcAk5Lox8WGiHce+yOP25oZPAg85bD2o4enK?=
 =?us-ascii?Q?vlIxiUkWnOQNIU9tm+1f1bq8i9QdzIXA3clUeMAFgAYoxA7YYlSJTfelYNM+?=
 =?us-ascii?Q?7mrj1727uzRlMIj3nf3bWnhJZnxkC2xLbTwGTop97rTeLde3SGRP6Yolok5n?=
 =?us-ascii?Q?7UxgoqXbL9bYDMGbteOWKYZrK5aXRiXATVDcRiftS6bOVhrCdhRhOfvtWgd8?=
 =?us-ascii?Q?e3QNXY9UPOYSmDpSiTztUxZ6bbx+5ogAJCnKNwShUZPbdT0TxhwiQRz26DNs?=
 =?us-ascii?Q?pLuKWp8JHnmJAcJzKP2S8+tTmZ55to9W0D+eJEIp5yjT1USsXFNfMovxnbUu?=
 =?us-ascii?Q?COJP0FZFGOFt1fCu1AHiWJwtHVwSiPZN/zJC9zcDVFYQo51Lrutbyooaalb5?=
 =?us-ascii?Q?H/OCejcaKtJnHZ1E1sm98hpSsYa/WLTJtuyzg/n7EZbBZ3+R5VuJy9G+h8tb?=
 =?us-ascii?Q?QdtcBLLJrMEElNEShfuR4qYfgECeOBXCWXcLopfuhqMrbSWgHnowDJ4jTp7G?=
 =?us-ascii?Q?dqwbiIjujQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 310d2d00-5f44-4e2d-a585-08da17a67ca6
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 08:21:45.2933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KNMbnuL6MpJilGOCDJiZgJOM4kL1g0duFtjzPicggQ4eMJQqZEVVzXBAyEVNqgBzP/iD05MsWrNv/laEEdYQEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4988
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8MP features same NoC/NIC as i.MX8MM/N/Q, and use two compatible
strings.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/interconnect/fsl,imx8m-noc.yaml     | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml b/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
index b8204ed22dd5..0923cd28d6c6 100644
--- a/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
+++ b/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
@@ -26,16 +26,22 @@ properties:
     oneOf:
       - items:
           - enum:
+              - fsl,imx8mp-nic
               - fsl,imx8mn-nic
               - fsl,imx8mm-nic
               - fsl,imx8mq-nic
           - const: fsl,imx8m-nic
       - items:
           - enum:
+              - fsl,imx8mp-noc
               - fsl,imx8mn-noc
               - fsl,imx8mm-noc
               - fsl,imx8mq-noc
           - const: fsl,imx8m-noc
+      - items:
+          - const: fsl,imx8mp-noc
+          - const: fsl,imx8m-noc
+          - const: syscon
       - const: fsl,imx8m-nic
 
   reg:
-- 
2.25.1

