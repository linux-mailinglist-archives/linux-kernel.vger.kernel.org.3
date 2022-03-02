Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53104C9B26
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 03:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239105AbiCBCYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 21:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239102AbiCBCYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 21:24:31 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130043.outbound.protection.outlook.com [40.107.13.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACDBA88B9;
        Tue,  1 Mar 2022 18:23:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kO1dBh/b28h9rC2SKn42NS70S5cM6V3Qo2oxshrEms0CxoWenf5TdcjwmISUU8rgyAyEtwa3o8t8bNuzMGrl3PWK3ceGNK/VSkuqQfTjypBusznanTuqHMSW7WmO33QNU7tF4tVuNpYGHks/xepyt1QvKaR/4dCkSid8+pLyhcvh5LnhZn4jPiCXpUKV863zLmf51q91VEAW7HhgujMZvWTJ+UQKPuyHREOqoRfaXlk5b9TT6Qs0gBSXCU+865Iv2YORGUawxJ2nwtrjB583QQe26+Hm0ecilEStDBMa1juFmr5UeLD3vM9v0NchEzkJWaiPeYmnSKB2fKV5TQfzBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYq1mJTT54ZvXojXX6Pdv0a8WLHKRubphEpbj3qcCys=;
 b=Sza2wymDk9/GfoQTmlkg8vcbBhYYhZB4x1mLQrsNxfazflJFfCgWJp+OzVDCh4+eYIjnwVR1tiiQMgGMZws/OGDJCQPyyE0TrUAgnEDZg+tBzXMJw6qyU8V0lft5q130Mk1CZME2cTJ/wotPfFSgU2oJreaK3kQ5p+xV/TMrIVhoUyW8MD4mIkt5FtEwB/EoUSV2P229EHyhzeK/ksM/A0nGsJiTsCDVuJP+SKzke8ZJjIQJV62p2T2pg0dhAam59IOJ12hy5U/Sjxmop7yctvY0EylPJnBS4xwqdalE2VVwgrh0cqdpycyaM5zc9V0NcT9ajzDF5zkdio2YwmY31A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYq1mJTT54ZvXojXX6Pdv0a8WLHKRubphEpbj3qcCys=;
 b=JtOqIZfMdbGQFt7gHo/cG35xi33IqHEswrO+4oPU258d8JTR6Bh768dWnJ2JbE1HzWq+XdiVwZ8FaF9EU4sJBEQ5jrd0/y3daR2WDoUg0VpFfxkk8w+o/cJR2Pqas1v41bpKmRlOf5U4nerRGDzJq0O4l2Bu6CwW1zhCvtoJooc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB4144.eurprd04.prod.outlook.com (2603:10a6:803:45::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Wed, 2 Mar
 2022 02:23:45 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Wed, 2 Mar 2022
 02:23:45 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@canonical.com, daniel.baluta@nxp.com,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH V6 2/5] dt-bindings: mailbox: imx-mu: add i.MX93 S4 MU support
Date:   Wed,  2 Mar 2022 10:25:19 +0800
Message-Id: <20220302022522.1789588-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220302022522.1789588-1-peng.fan@oss.nxp.com>
References: <20220302022522.1789588-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0016.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8ef725f-036a-48e8-41be-08d9fbf3ad10
X-MS-TrafficTypeDiagnostic: VI1PR04MB4144:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB4144B5F93489AB546D7D1C05C9039@VI1PR04MB4144.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sNOa1nrikm0sWJYR8gWHp+0N2bP4CArZ3nbwyLMihrRTI/Kg9TJU17JvC3u6310qjFgeBLWVRqpqOSt1DS6GhYbPEIfoayhfdBowfCq+PCkZ40pT+EAT35jCR+AzoTsd89tAt9GODf8KL2XkhaFYBdF94ojDJ5TJCqGmt425pdsp6Ovk1AeYVa6vO5DEV9ScSbtqPLv3klmYmPjoPFwt8iGoXh6MyGV8lH86OHTnAJJxMUwtiRLIJaA8KQsP1B/EZm/0dx5rE4yz6/K0biHrpFTMFFugQPdh8F0SCn6zFh3brUP8cghDGa4HASPRY5gKGP2WfkMOH4MS1lCDVWXBZg/NdW/w1Ir+8mdQbWnR9Fn8xeBc4oXAj5rI3V2rAmy5M/3nX74WXUohfcub8KxG5jozibTovFhLoSpXRO2aLYBp7lzJ08+ymQ7rWK9wkjtuLrXHs4aMk/OE5/gzwRmYmi1GE8d/d75zKTtTNJ2l9w0gsA/2AbChp6s7Ap079NiBALGAWUx5FnkOz5Dc6Gn7rfpqPy8cUDayoy8+lFGX6qZcFwRX45t1C1fPtyitIB8cqi7nUlwg386QkyrjDGeLkK1XtubtKyNygWiKMeWJn7AAM6fkHDIS1BwRBPobSqNHBbmfjLvkLheNH5xffIl/ZUc95m5XwQhqA+05XjhruO4AH4tvPmOAxsoYVC42nbbA+2jqSIV5L8FGJHzE+Wwv3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(5660300002)(15650500001)(8936002)(7416002)(66946007)(54906003)(66476007)(66556008)(4326008)(8676002)(6486002)(316002)(6512007)(38100700002)(38350700002)(2616005)(6506007)(52116002)(6666004)(508600001)(2906002)(186003)(26005)(1076003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/Ha0E5TBoyLYSNabowPI3SQxaB+iLQiv25SEqr0EwnC/pTLkmW/k0/+CBT51?=
 =?us-ascii?Q?Kj2VRJsmokUeZ13TbcYon4li5L7PmaOeuycLdMiINNOl2/g+HfXjI2yZI2YA?=
 =?us-ascii?Q?3Md2tDEHDCe5gLyxt0bZMzOyyDQyclQ1sqKruBRrYJjXQiLSw1bNWSupYvhl?=
 =?us-ascii?Q?7j12jwP4mxtFy0w2PIhUIQJJvz0bKL7u7Wl/MnWVdVZG2VaOscnklqR+8Ud4?=
 =?us-ascii?Q?u/o5EKOgganOTPkEZZPc0K9gBtQPljXd8WXTMeHJkt/sy70ztyQl/AENvYnD?=
 =?us-ascii?Q?eDlHVI7/X862lZLmcHDpcb9ETBCNxAUBQjge4jgzY2sK42c88tluwwhp46G6?=
 =?us-ascii?Q?OXSwicVf5ME+cUPiFn28J4NAgvS0+yodbOsbWK7dZDd0jrDtMk37ch2cODIb?=
 =?us-ascii?Q?1s1wq7zFQgFFocKDRkcshFo20akudy//gyb0T/iV7l6wXNW5cbhBCvbTEMUp?=
 =?us-ascii?Q?cP/sGUszgAJDLY7t9/JDU9qN0X9xE4N2M+SB8HFBcEJ/9nWRj/4i9KjFI57R?=
 =?us-ascii?Q?WBegp5Q5ozAwYUYxVHfFJ6EHRAxOZn6lNiwKMqnV9+lhGX7piahHAjPk+RrO?=
 =?us-ascii?Q?ID6Vhuh+5dOAXJYD7hi0gT/3bpT5l7bpb1z5Kf2t0EXlAYlFpnOqS8yFYFDP?=
 =?us-ascii?Q?MPFJWViQw20FZnYFXtb5PQlkCE9N7g2jKn5P6e+Y1lULThqVgg3csXxuK5Q8?=
 =?us-ascii?Q?5DATaukmc3bSy7AmUSJq7fAq0kUNyzX7JyYc8JV0tS4RNPWmK03EDvpkrVV/?=
 =?us-ascii?Q?i+mkIM55gLTqj2nci136sp+HaQ0cCwz9UPhSDfkp0NtafPZb+zKovby2LI4a?=
 =?us-ascii?Q?QP6bU2Cke+oNS3EZvnkcqVhgpGeKtHhQ5POBpZpOYTzeodI0Gho9fbq6bacs?=
 =?us-ascii?Q?bvXNPRe+u3nVGK/2w3Pf8HetXlDgyBrz4lxMAEdl0FwZWmCxdSCKxauh4xeZ?=
 =?us-ascii?Q?rTYm16yHcRVzv/Rq6zNQDdctj+Bpr5b8bxi67Ubn7Rt0lN1sNSt/Tnizg/7Z?=
 =?us-ascii?Q?ci06p3MD2STf6kHajiuZ6DkPEXC2qKUwdLuPRU9dJ1pMQnAOsfi8zZsUCKw6?=
 =?us-ascii?Q?6LjMBkhna34KSWZhMsJHHys4//G225oEkSdXu9ykkwbHiYAbW5cVuwm1LpLC?=
 =?us-ascii?Q?RgHEHjPWPwcXfxuGBj14owh+yf1WhVRkzW5MkhPLi367B2GQDbuFFdUIdjVA?=
 =?us-ascii?Q?vSykoAgf0PGw6gjihJJpmcWpFCUwUmBagl2PnROVv48qTu+AWUW3FwzOl8ZY?=
 =?us-ascii?Q?C7KYCu9Fro/0lQ5IudPwKNpIYKSpg8KomHswJhtsukl1B3IrWw6CO8kyJrud?=
 =?us-ascii?Q?FmAbiDQw5U6wKc2PtVnF3bNpdskyUdOck9HM7QlJb5KonDLBjORHoMQqW3q1?=
 =?us-ascii?Q?0uVbmH77kkZD2hMXyj7LyUIfHXB1M/Pw1VQcOhG0Dm54GGNoJxZQ6+8fQ9DK?=
 =?us-ascii?Q?NWHX48yt6h6B36BTgFZZkHpJMlpIJcfh10Q0+9ZGq9GwSxRDxiXmT1czGljC?=
 =?us-ascii?Q?QQVSiNcW61EB37aCYG4pH4INK9DKN7U4Ck5y9JsBufdwcUD0S6fS16nLiyAH?=
 =?us-ascii?Q?cAAfe/vIYJomAd4LYRp82GatMetSus4KCR4yo4vntElPpI0/opXe1XDFNbhK?=
 =?us-ascii?Q?DNGP8dmATNyOoUAlFnkUelE=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ef725f-036a-48e8-41be-08d9fbf3ad10
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 02:23:45.1283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kfcQyOcdfWIV92VM08er4p0RiTwZy0ppU2mSNlmGALUfjsphetNgcSb4wMWcjRWV+jF1lpyrY7jr6xHki18y/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4144
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
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/mailbox/fsl,mu.yaml   | 31 ++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
index 6d056d5e16bf..7a86e7926dd2 100644
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
@@ -90,6 +98,27 @@ required:
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
+      not:
+        required:
+          - interrupt-names
+
 additionalProperties: false
 
 examples:
-- 
2.25.1

