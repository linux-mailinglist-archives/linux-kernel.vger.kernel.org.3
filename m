Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E0157ED40
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 11:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237450AbiGWJm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 05:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237388AbiGWJmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 05:42:43 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30076.outbound.protection.outlook.com [40.107.3.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16463CBCC;
        Sat, 23 Jul 2022 02:42:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gu5qtMMnT6KV1F7OMkWLt8jWmsYrWy6cf4MCm96gR6bQZGOKRLOUFL74y4ma3DKbRk+B4wpxXAoycbajFRLUoho7fFz+vcgAIpiNjjrTtryxOm+Sz7Qa9wt+VbAClwFAhB8KOWWHehpa/5zbx4jFmB1/eVWT91/PRcD7ULL0pxmQIBPcsehfxibdIpxhyrQRy3k66/roMaM0YQuevw/g7TVbz3L5dDZrdsIwqKmIGImfDbaJ/pTd9wMGCthgmRKzwCWBUC3kakiBW0cWCQv2ug+FUp4D/PVYTTvRaefATyiy3Bkt1n1ixB46U9/mz70Q+V5I9jqDbIpW7qMBIuCpwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6lpemj8+/m3wlGA1zvJvhD1j39ef11gydU2KC/52i4E=;
 b=AXFfZBfXcoll3ca+aS/ocNLFshb1FwbnELt/Nha6cJuMnRlbN78Tb4o7jVTGtVMZTLBsDJs8l8xGgtJh66FFLhJr3UNaVoM0R5KEd061EuBZQkqjEs4jXBhovpCHsJe2WxHA50x65sJ9f51Ah087qBxdTLMUI9bzyIFWdgXTX+qzQb3ocY2tyYaD+PY7XB2FKTmynk+u11sr2VvRc9mZYIhMMZkKKtLQbZibR/xhUSAoFc2Rej4disGg3Q10FqoO19NpgrEMf3YMF250A4xEWHSR+ipFehO17VELiaDGjl+yKckJLQIRZBctggmrnznQUgKQBw9FpYE4F/5cocHYzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lpemj8+/m3wlGA1zvJvhD1j39ef11gydU2KC/52i4E=;
 b=ZT1dViHvd+Tn2KhvTDvsoLV4kqnoy0f7p61dzCj97QeW7oWe4+Ikj20Rjm3BJwIr8Qn6728bETIh2+SszTQyvL49NCkAXw3beOHpCmwcE91gwmTNFLGFpPs6TAuH4ZE1g+BYiyy2Doczvn4XWI61Q1qoFwuzzN6mWVuY3OUWSAs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6067.eurprd04.prod.outlook.com (2603:10a6:208:13a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Sat, 23 Jul
 2022 09:42:29 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597%3]) with mapi id 15.20.5458.019; Sat, 23 Jul 2022
 09:42:29 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, aisheng.dong@nxp.com,
        festevam@gmail.com, ping.bai@nxp.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 8/9] dt-bindings: pinctrl: imx: scu: correct example
Date:   Sat, 23 Jul 2022 17:43:34 +0800
Message-Id: <20220723094335.3577048-9-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220723094335.3577048-1-peng.fan@oss.nxp.com>
References: <20220723094335.3577048-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:194::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8d1c08b-eef3-4297-2dcf-08da6c8fa8b8
X-MS-TrafficTypeDiagnostic: AM0PR04MB6067:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BGxDvtwrFS9HlT7sXS/6tJE+2U27RJ2emDiX+kieZM4Mhg1SU0bLO5HVKbijonTVZEx6e4nKK7jZsPMXtQBx3wDiK9019Xo2YMNjg3NIEiDR+lIZh9ng0tCT1PzEBauOX0biRZWkbaid11WM9iks2HUaBL94MQh6S4L5ecXw85+AzErZZEaTMQMJQp24erOQaCmd33OmI+ehCQQ0Rfhy7U8E+UPy36y7gAFn7CV935l9wSxtLFSE1kuGP7CZBKhXXPcd/vRWlXRzeijJx2xS9C6KbxYoa1zKIVVyoQcrvoxHA2bymDu8OpFogyTLsRjAWcaQv70xObvA7gJsA2Qjid9ti0oH3PzbntlmMYGvitWVAX04mHimtspi4qKTxjnuMs0QMg5zRga9rtEOk34vEjFz1Es8sDLR8oj1JVrNNcN0HsUeO4sQaf3GhYtpmEDu76GszxAHsXNncOZL31wI99QhPu+VIns5RxaOIGYWUAHUUW8iKxLAlsetH5fv4cRKwSmiH4bEU9BEZcXs3KN8H6wXhrZh8Qq/yF84QKAbdFLIr88Oxh+fHv8Puv5tyJUS/rE3s2sb5h5PO4z7MfiR321SwO0L8LXDPCVJqXXEM64Hn3OGf7Pw52FThHt5s3VUGrOUztlWkdChYfRT7Uiq01hI9NXuxsyCLohy/mQffPNgZp0zC9WDyadfRlsf6OjNGfUBlqaIHyiH5sxqdoUYc1So6QnW87EWbb9SJjs4oeko9TDOSI1tCAaMIFQzJJKHTme1qgkwRiWNAofCnKIgL0II9o+DYj9qAvTiT7OVbV3G+qdpE9b17OFWNavKed2v
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(2906002)(8936002)(7416002)(4744005)(316002)(26005)(2616005)(38350700002)(52116002)(38100700002)(1076003)(6506007)(5660300002)(6512007)(41300700001)(66476007)(4326008)(8676002)(6666004)(6486002)(478600001)(66556008)(66946007)(186003)(83380400001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gBaqWhdwOGyKNRkIAIkKDHrXOEpK1DmN1ToFPQUbiL5qFUU1luka/1UCi+w4?=
 =?us-ascii?Q?12J9IruczSYdmsCpqToawl70iuw6HRSSIaWUhgUuDCNKspJ/XlC/m0ezsgfh?=
 =?us-ascii?Q?eTFmdjpXFdqm/fwqOApzacjn/L0+Llllo0PEkZo2fCsuTJ6l9LtTTwAFocUf?=
 =?us-ascii?Q?ET0J/4G+/OE4pLD+1ox+T3/jof1NqVUsCD6NAG7lRZhj+rKf4mhtDqCvCi7+?=
 =?us-ascii?Q?LQ9SsvNXANzGz/Tn3hsxgHPNB4RIEe4kX8DSrZacd3CU7ffhN7T/ogkWvjDy?=
 =?us-ascii?Q?QbATAYxM4KxAhFL0y3Hk9RMiuWGbtlvBgdrYL00LifxRIhDVsbpTJ6yOafSt?=
 =?us-ascii?Q?eXkUl6VFkl+HGH59tyuY5S3WmGICrepWicst3pIM8IH618osGd8S79BXgkQK?=
 =?us-ascii?Q?AAifKAh+oFWoUs4hHzIerFo5Sq6G5L5Lf54JyZZ9oZepYtJbkxQ3OcVAL0zK?=
 =?us-ascii?Q?Rzfg6ic4BCw0tuEIPAn5kLRjqF5PKI7/czC8+KB28RPxu6nvAODKuEdmyWEX?=
 =?us-ascii?Q?qVlG+uGkFKKXwtmHLGAYTuZ9Xud/b314fVaw8SFyS73Rpx8q/oDkFZQC6Rgt?=
 =?us-ascii?Q?o42NlMddyGTF16TkggaTmr8elkwz8c9+WyHXufDFwzz0uZ58Mp6Aa93kq3sA?=
 =?us-ascii?Q?ZrazW7dNscAErAKnjuTbz6RXglGAGdFFyGUa40MIZ0a6NlDJV6lk9zTEgnnG?=
 =?us-ascii?Q?VfsbKhRBnA4pXSKQco1UzwbAFK8wT/892P6hyS3vOYdFdwZDzympiCQQzWqw?=
 =?us-ascii?Q?TzaT6ia07wL9g/XsJeGYS3cNOzBS2NrmiRjz6fZIDyibxCb5f73Vh/pzVdor?=
 =?us-ascii?Q?d+0lQ3C4rBMrg+Pxmxrvhcqi+NPfJ2FqUKNUgEU2TBgCumlZuF0SKQJN/me7?=
 =?us-ascii?Q?UoFfxV06nbhxVTr/lovRn1rKVEeXlq6mNnDMgWj4XBhQIW5/fuUwLwK+1U8O?=
 =?us-ascii?Q?UopcbCfsq6aRxwnHV0EsLcNFcPhICfj/WJqGgXnH2pwlzuzFpzHU8US8W2VN?=
 =?us-ascii?Q?D0mVyiVavyEVhSmsKaOp9HglKKnJqF362W69YMdPSDntMJ+xR4W1jIRgNmOm?=
 =?us-ascii?Q?RqfPF1ftCyVp/fbP91l3aLaBfk0eVpwIKcOUH07RZRKFLdZVJEOMCDwFr7eK?=
 =?us-ascii?Q?LJuEHA4umX7cNKnzDHnNZjGounx2DanxypmAfkl584gVKJ0tzew0zGBwhab/?=
 =?us-ascii?Q?2U4vbYuBXDWv6vm1bQlmcTzK2uB7GYqb1EBTeJiHRnmxNr3ILMZFsq7t2NdU?=
 =?us-ascii?Q?CHSVg+793md/PA399uiLnR9DxfaEIukcKOj4v1ynMiHeXUoYdgAZgMgIx/QX?=
 =?us-ascii?Q?/2tJFNRXBqF/pUbVsANEi3EXLTnDMf365ldl04Kjl/ESkOYE/eIvb8VVlwUT?=
 =?us-ascii?Q?c0l+Q0bHQ2HPXgFxfxT09fzV6L5zD+ex/X5gL9Qi2w+jpbKDh5OD+TZvKJ13?=
 =?us-ascii?Q?RrV6T5+kaq1Cfcq4Wh1chx7IKRXAfSlqbiE3P0zaGMxxws800Cg1bYlc7a4O?=
 =?us-ascii?Q?7ciu1QLpZZEfbszsKBhEmItdpP66MLwpv8MegCCD94dEzYXojFBa7W1FcIj3?=
 =?us-ascii?Q?WmJTLKLfwy0X53CFnc1SpTCZMnUqLHFTMuwmXMm/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d1c08b-eef3-4297-2dcf-08da6c8fa8b8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2022 09:42:29.6393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CTURDT6qnqcEHrLERy4V3qepavYsqOVPmwufF36SnfqX9zmACWnV4AXJSNOAsE7dQUibAOQRz4SHOdLJ3J7BDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6067
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The fsl,pins use uint32-matrix type, but the example is uint32-array,
correct the example.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml       | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml
index 793e9e9cb597..0e817dedc7de 100644
--- a/Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml
@@ -67,9 +67,8 @@ examples:
         compatible = "fsl,imx8qxp-iomuxc";
 
         pinctrl_lpuart0: lpuart0grp {
-            fsl,pins = <
-                111 0 0x06000020
-                112 0 0x06000020
-            >;
+            fsl,pins =
+                <111 0 0x06000020>,
+                <112 0 0x06000020>;
         };
     };
-- 
2.25.1

