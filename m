Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A864C6134
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 03:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbiB1CjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 21:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbiB1CjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 21:39:13 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80047.outbound.protection.outlook.com [40.107.8.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F3A53B70;
        Sun, 27 Feb 2022 18:38:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3456Ox8oBRQDwhpjC7wercst4M8KkatZKjc4AmfBxUzkKyHseS4byK0Oym4Be6JlaRVBikG8mAzzcLoR8+FgWZV38REP442ohrhlbt04viWMHm5QV629+CUSxiRJvHr5tbpArWeY3js03Ul0HC8kmp7ImKx2uiTUrAFCyljb6GiiTKwn39BUKaqlJc+zmzro8pFsnJZQXFKM+GwKfIoZwMpES0CstVGOS5fb7nxY0AWZZkbHF/fayYN3iU36PBEifXhlWcqgjFj1BsKcGGxDJc43oWcrnWamL/AY7fM8apwt9BvmAn/XKyi7NN7theCFzczT4qicNnAHu4/N2b8dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43Clk41BbpZi1Tp/y1LKpukuonFGlLmlo0T0A5wtwY4=;
 b=lvImvaECseOmCBGRg9jtdUlWg7AoKSey2PgqpyG9ES2j/0B/Z8MzxpZW4j19pFct9ICyWcqY5+Cepz9oC5a1675lrfWXZrv7dWJrYPCO1hdGVH72Z/W0+UE+/ogVPnl72s3R9nyJE1b6EVDLvArCVtx210rQWUUHSUwladasy8BuTakrWJ5XMhw4CFso2fdIFHvpAHNwSsF0NvDGc8CRqVIWMQCtooKxuyqech4uiI53LVPo+vP7nRLVqe+t5ZHLKTTXeaW7U4DK/uyxhj1uxzicNG+4j3ErT9LNA6L0gr3MNtDXU4TIiG/tK3DH1IUZ5chBoXN4zKVkJei5EGkkbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43Clk41BbpZi1Tp/y1LKpukuonFGlLmlo0T0A5wtwY4=;
 b=MY0gg5XmU3lWsayfYVIptv46risN1UyIozfVIKySyrqiZI+WWC0p6RT334gWy4CIofpViyEIDoR7xtUNoXYJSvPn/L039OU9XjyljQN0HrV51f4tEIbydxvzgkp72MtCbR+LgXqRX2XaTbENssx57CTwFI6HVIBGKb6gEclL/Ws=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8720.eurprd04.prod.outlook.com (2603:10a6:102:21f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Mon, 28 Feb
 2022 02:38:33 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Mon, 28 Feb 2022
 02:38:33 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@canonical.com, daniel.baluta@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 2/5] dt-bindings: mailbox: imx-mu: add i.MX93 S4 MU support
Date:   Mon, 28 Feb 2022 10:40:10 +0800
Message-Id: <20220228024013.2866386-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228024013.2866386-1-peng.fan@oss.nxp.com>
References: <20220228024013.2866386-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::24)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a9e320c-524e-4c42-0349-08d9fa63696f
X-MS-TrafficTypeDiagnostic: PAXPR04MB8720:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <PAXPR04MB8720EEEC26FFB4F3F0526B1AC9019@PAXPR04MB8720.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dARgLBCnIRPFILeD+/BfjpvWtkGY+IszXLLrvrBLlvPy3xwvNu5qv1IoxEpKBXEDG5VN3a26WcvuxAyHjjW/ZfpOslOKbUN2MBZo1aTxA59DoRSUVAb4bdUBW3+BmB5us2Fwfl0SvIjZlLKvRaCHSVil1mXUOSzsgAlfNJIGirbYwA3UFR6AX06ztHwtvEfiQOAyvPj9LcEnKw9iWVjFWFUFzPJ3c2SZUhtx+V8MEHsx3ZGfaGcBIQSJ+lHn1XOFGem+Dbkjni1xhoA1j9gJDElDmza6kpoHIfMsiGMdBUkOyE7C0KkJRVLAfvIQoKSihoSfksqRgea+9XHESixzyBwtElpjOPAUYjSBQJz0LR3PF4fXjsCsg0lxXaKMdqYiTVqCZ+Soq3ksCAk2KfXrpa3y5y1Os0hv6YESfkXR6OfRiphtfUXlWRnIEaFXjc1tEyH8Ivqd8g4CKYBaRjNiChV97C7l/wVdJOMzK/wr24/Wzku3thIXKseyo8jBMtaQ1zrBFHq/EoPmSSVZDoj/Bm+0o2wbUwMt35k07RdUaMp8dbBdjGXjLu2srNLuoH+pQ+7nYeiETT8NtGsKy+I4f8R5wCPwoRh+5s7xWJDY7NeIXDJwCSlkEu/3fO88lZmV1P1CZLss1eRYtNJhT9XfVvrmq5NquqHdRaaH38QEK85uENMZokXmtO7EIYJjSsIHVDW63DytX2XFxXcGug2pJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6666004)(2906002)(186003)(86362001)(1076003)(52116002)(26005)(316002)(2616005)(83380400001)(66946007)(66476007)(8936002)(6506007)(66556008)(8676002)(4326008)(6512007)(15650500001)(38350700002)(38100700002)(508600001)(5660300002)(7416002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4glnfcn1dzQVaJtxqCOAkCmTe+0hbZvyzBWM5htoamfCKHhBR/Od1bblT6Hi?=
 =?us-ascii?Q?0/+S5gjyzWRTQ8dXof43LtA4zhr3H64HvOd1HvQvRNSddShQIQlEx/UBwWHO?=
 =?us-ascii?Q?n84ssSt6k/Rro4pO+sMHtFpv8LlKicbrm+DFdeqaxzec+03AmJ2+Cob+0lTx?=
 =?us-ascii?Q?P6K5yxDwMCliIJfTgKYQztEZ0ZBzLbA1hzMgorONulvXdbSaXhtf7gIxL4Ab?=
 =?us-ascii?Q?3omz9mUfQ052mEb1Q2fqcyNmgXkTzzmopd6tyz1JIsdI/NQ1SRteitWs3V2f?=
 =?us-ascii?Q?+QAYDZ14sp2zmE4AQCzSS2NVrm5DffTY6qBWLYdnFxTt3cki//lVBGJDnm58?=
 =?us-ascii?Q?GRwyFObUTAH1BcJprBPQ7mku8ccxAmby2AM8IQ1PrzgxVg20DvcMZ+74tUv4?=
 =?us-ascii?Q?bgvlwDaV6vYUf8m69gSUaP1+4Vnx7fPMdEpQ4JHZbRYvpKncCFWxrtvF4PPj?=
 =?us-ascii?Q?p3ttQO9bCXrFP3If++JOtCswD2gvB8s5p04P9P2Asd9Uw5+nNsbDLce+1o6V?=
 =?us-ascii?Q?RJHShYrMPJZX+0BlLVeBP3MaQ+ec6nb5JI+N/CXu7mmby/kTYj78s4zpaUPN?=
 =?us-ascii?Q?/AyUrFDrGYRh9tj5PjR07oxT+raD1GxpThd7KKsngs9cEEsn8iEGGrUmWzyz?=
 =?us-ascii?Q?6QBDQMCKMCyARydPqIr1aaTUTqgYCDrabXe9yTpRKS+0e8/vGFIb5PMYjK4d?=
 =?us-ascii?Q?eLnx3LBbK4UhFoilNZSJNJrj2HcJvi6QuLMKMZBFFCe+Aw2QstX0G+b6lhqy?=
 =?us-ascii?Q?pd0G1QS9nnApDFeFuvpvtycpVwSRmCVA1FRyPEyNFjg6kt55YvlAIxXhmg1d?=
 =?us-ascii?Q?9q6dj1wxRRe78is3X9acKbYaW7H/HHlQ87VefXY6qGs6Lr+f1HnNZ+KT1UdK?=
 =?us-ascii?Q?bN2pJLyYjfxgxChymSE+ZTVV8GoGBx/6le6OUs93G94V5QK2ywPNNrBxtbQM?=
 =?us-ascii?Q?I9txLp3M60LwafNJMkrBlcIHV48xop/0fIBMk348JseCBoVs9RB9PbbZbqKA?=
 =?us-ascii?Q?C499CMBJpjWgTaXashFUPLzC1hjHwQV67ESiq+Oc9Cd+HZjLxlYWVCWGXIzS?=
 =?us-ascii?Q?ZbJooiIf9wL5DK46aaVuviUd7BG+0q3cvWR/Z85vUOMsmbZ6+mGXfR7zlFJd?=
 =?us-ascii?Q?SmLLY+TJjU4sZK9vstR5U9C3pn46EdIN4kNhPoiU6np4K13geKlS41CNA8SD?=
 =?us-ascii?Q?rVFYg7VL5fbGEB/fR/n2iZGC6yHf0Tm7jYw0Qr1cnEOnB+oem8vYKFzCBrpR?=
 =?us-ascii?Q?4I3aMtWaxOJ0AK47hmb5AmLRPJQJeil/gMN//rZBqE4isHMMFetmcGu4rYOB?=
 =?us-ascii?Q?kPjT2QcEzh0aN+mjnZrzehp8R1XrPJWNuRo+VKwC3ay5J8g2gAQPyQnWU59S?=
 =?us-ascii?Q?wOyhkUlO12Ejnc6eqA8r7o96c/6PDgPozph5PKAHKa73PLiVYXdMIgtQIV0D?=
 =?us-ascii?Q?LczLLtw7KfVne1MWdi6SeFUbdLFuhuuRRD+IPBweoPztUnsjJah1Znj96APF?=
 =?us-ascii?Q?bhUuwA1xyb3E8l+dZfSuUUDbg0cGbD589H6a65Z6G4HMPAV4stsHTrglqXe2?=
 =?us-ascii?Q?4e5wHs8CpIIc66/skjEVua+hcI9yJJ05YUqZo7sp9HB3YMAafJBcu4T/URkL?=
 =?us-ascii?Q?AkOfh7I+f76D1duRkdf2ytQ=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a9e320c-524e-4c42-0349-08d9fa63696f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 02:38:32.9099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QadQ23GCTJmSRiMvM//YrwC8aXmT1741GZe3mz8Bt3D96eF5YfAiKG5KOkCOeMDaD66asIMbs0M81U0uYE3NLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8720
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Similar to i.MX8ULP S4 MU, i.MX93 MU is dedicated for communication
between Sentinel and Cortex-A cores from hardware design, it could not be
reused for other purpose.

However i.MX93 S4 MU use separate tx/rx interrupt, so update
interrupts and add interrupt-names property.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---


Hi Rob,
 For dual entries, I tested below with dt_binding_check and dtbs_check
 "
 +		s4muap: s4muap@47520000 {
 +			compatible = "fsl,imx93-mu-s4";
 +			reg = <0x47520000 0x10000>;
 +			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
 +			interrupt-names = "tx", "rx";
 +			#mbox-cells = <2>;
 +			status = "okay";
 +		};
 +
 +		s4muap1: s4muap@48520000 {
 +			compatible = "fsl,imx8ulp-mu-s4";
 +			reg = <0x48520000 0x10000>;
 +			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 +			interrupt-names = "tx", "rx";
 +			#mbox-cells = <2>;
 +			status = "okay";
 +		};
 "

 .../devicetree/bindings/mailbox/fsl,mu.yaml   | 28 ++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
index 6d056d5e16bf..82ce0280add9 100644
--- a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
+++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
@@ -29,6 +29,7 @@ properties:
       - const: fsl,imx8ulp-mu
       - const: fsl,imx8-mu-scu
       - const: fsl,imx8-mu-seco
+      - const: fsl,imx93-mu-s4
       - const: fsl,imx8ulp-mu-s4
       - items:
           - const: fsl,imx93-mu
@@ -55,7 +56,14 @@ properties:
     maxItems: 1
 
   interrupts:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
+
+  interrupt-names:
+    minItems: 1
+    items:
+      - const: tx
+      - const: rx
 
   "#mbox-cells":
     description: |
@@ -90,6 +98,24 @@ required:
   - interrupts
   - "#mbox-cells"
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imx93-mu-s4
+    then:
+      properties:
+        interrupt-names:
+          minItems: 2
+        interrupts:
+          minItems: 2
+
+    else:
+      properties:
+        interrupts:
+          maxItems: 1
+
 additionalProperties: false
 
 examples:
-- 
2.25.1

