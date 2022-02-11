Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C85F4B1E1E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 07:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343733AbiBKGEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 01:04:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237990AbiBKGEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 01:04:06 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662FC5F48;
        Thu, 10 Feb 2022 22:04:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkfqUl8MBpxRB3DV5j7N+iNeFrdYqcQ56iXiUKa1UTMJfRpaNGaaSxPcZvqeH+skpGwklz4nh9vOQ8drujkNTnaat2vaeRoZFESJ+EeNzQAgw0IOwV/GgPIUIkJ7Bc8Er4hXAGU3kyT63sNO7KqN/iT1f683RCLU3ibDWPfYwEu2OPo5ETKPbAeNwND0q50lBeEVKXVSsTF6L8d7iLWIjFFlShG4fVlf9CdKLttpCrOYEwTTOpxxWjYfu5i0npjkDTUBOG4HGTfNkZe27KiDbuUYD9UhuMC+EAhAY+S5ogvUA2mQVUoH3ifZqdKo14gTGB+75Dq8RSFAN39Wb9EaLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYmkcSn0ZSLUXO7Qv1Lc16Mn+3Y3Lw8IqId0umu7en4=;
 b=IMJfxWkcgu1NakGvh4UIk5eLEbLEceBmMJsIjO7py2F+H9ocAPK0C0Jm/10ZDQF8YB4Rs4bzt2KDOEswQ0yRM4TG3ryG4PQVIuMmLONhMUDQy+0LroNxezIJveaEM1CJfEU8yB/0+9vKXTuv1swgoHdxl4gtmbI+4xOio6jrEQCcVwzbr5ht9UpnwxTgxF3n8btKBLBOY665o4D9XmySG4yUmYeni/MkXP6hXwsJbu1JokqiG12LDGaLuoT+Fds32kdtQco+7LC57FXP7cjCmTkkAuM/wydjB/Zv4iDsZZFB8TycxUt2EphGFKrF5QiF8zIDKFCIdzWOWKQvCQG3LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYmkcSn0ZSLUXO7Qv1Lc16Mn+3Y3Lw8IqId0umu7en4=;
 b=KUgADgqM2YAGsI+Aw3SxexnvRqwuEvW+bjaQZvfSui5N031HMDeM+rtv4iAMZbB/SoWzlzEWdMYzk30evphC0YhExq7oAMPIKJ+2Kr1JgKsn7vRKH/puBqx+rey8Ln4tav2CiFmIXLej3hcvFtDJcj4iQyKtm6gwRzXokQ2hrq8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB7113.eurprd04.prod.outlook.com (2603:10a6:10:12a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Fri, 11 Feb
 2022 06:04:03 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::448c:19d:ca9a:123e]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::448c:19d:ca9a:123e%7]) with mapi id 15.20.4975.011; Fri, 11 Feb 2022
 06:04:03 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@canonical.com, daniel.baluta@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 2/5] dt-bindings: mailbox: imx-mu: add i.MX93 S4 MU support
Date:   Fri, 11 Feb 2022 14:02:58 +0800
Message-Id: <20220211060301.1852772-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211060301.1852772-1-peng.fan@oss.nxp.com>
References: <20220211060301.1852772-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:4:186::23) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24449a38-3307-41e4-013a-08d9ed244e16
X-MS-TrafficTypeDiagnostic: DB8PR04MB7113:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB7113B4A1E97A21BA5A233884C9309@DB8PR04MB7113.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lzSVB8mrkGzpVCJfugfUpi6qes+dJdB2lFTmi14bEqS/hXqIYFwaQEvP8Vo+IcwFCloPNWSzEJMptxAJG+ZheQecOIqe4PrJNY8NG9ARNvYDytUE5wpQ5NQVDEKJ74Dcmru0X6gYac0rcOxuy6eoq9H1CG6MgdwdLZR54SvCw3iEGXaAni/TXPMR5OnN5YSgdue4jaUpnrUrOBODCVf9fz0rhaQf2e1tI4kjAEK1ffNjV69LHBOglF9AjLxqhvFWaHVO0KXC8JrMuJtQJos1bND2qB8NI/Kfrx63qnziBOH84R8XWCkQwPXH/VMm4RlprmYdn4a1ragwq5a1XoR5iCxQ5vgnuh6MLhL5PVhW49ND6IycAFXGCnAvjLnhmjFLtKMsqUgjSYQ01hxEM2wWco1rEtpzfj6+BQtAMSFI5ZkVX4BafzOjiVZesmKGxXiJYw3CYBbK7AgCRbT1MNkIC+VAwvxmRp+QNzy+14Qs3xXf3pMlkdWC4ZsLu/79BMyCWDByH5gzcFUsVdHczw44EjTY+pXM4MmnbY8Ct3AFgN9rHDtPXMFUCMXXjZs+1Xgrm1YWpJ1JyWgCq20maJJUqf+LgVJoiPEfw5jekkOvmf+kAi8E3JjzhYKlXIeidoElK5feFWF3vXKEJiYDHSdLRblzw46dEEl1J+zP/ihdTBaJ52FwiShadstVZxTm0mKAb9NrTRWYw5OlWlj4+qxRYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(186003)(26005)(8676002)(4326008)(6486002)(2906002)(66556008)(66946007)(66476007)(508600001)(316002)(1076003)(2616005)(86362001)(38100700002)(38350700002)(7416002)(6506007)(8936002)(6666004)(83380400001)(15650500001)(5660300002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hs6vd4AcT2ZA6/BTYvMFjG9bGZzzokc8fZEo1mFkgax9X126rc0fgq6tlCz8?=
 =?us-ascii?Q?5FQfgZNRtpy5SEyVjnFHuzUt/p/wOnitj89XphW32kncnG9HcTpueuJYhdBU?=
 =?us-ascii?Q?WuUzuM7LtgEUQ4RyZgq//86NDtX6fN3XLC1r69DLPudxrT3YDN8cpOEYvipC?=
 =?us-ascii?Q?cFrv7Cb5C+aZPwFXHa+uA7II26VPEX9gAGuQgxaaFeBfgH5qLma3m9xabxxU?=
 =?us-ascii?Q?Moi9DWOlokuNWjRzyFg7/w04p836qtXSaJpVT8y3/jPpwLHQnHVMo5CkqhE7?=
 =?us-ascii?Q?JI9QM4aoKvNkolTDzXq8ROyslyAq5IoyjPN+bPiCNjn2OAee6D5sSjFHkhoL?=
 =?us-ascii?Q?OJ8hqtfUVbUzULN2YvRnervNCB6TkzZTp9YpO3+6SXC/i0vnEmKVaifxuaGi?=
 =?us-ascii?Q?Ju/v9okqKimarroLd5wAlkbPMM1Y/Py+TI+Jo7qkCVVSnfyQpLOEz0Ce7HUm?=
 =?us-ascii?Q?LiJZJ1esySqOE7bWBS61ZUGgDcyQ8Xfl4rWDboSL//fQyO+V2fJvGMghXGVH?=
 =?us-ascii?Q?e/mtP7+lcvWU161qdOSOskYl1qvIXbiwhzB8MafMNuSXOlN5SXUEZwH4+d5L?=
 =?us-ascii?Q?LBaZLiHenlI20Y/D6mVK6nXNW5oi5uDmi1c7GTgYlhxvqNdHcehvQWmB3nSf?=
 =?us-ascii?Q?Vq9JIIVV8bsIwqlN1UJaKFuDTB0/uOdqCgu8fu/XMROKUaPMoPNqAQiny249?=
 =?us-ascii?Q?nBf1rZynhV8Kqr6ghPGjfD3t6Rxa6ts7soB6w/zgfA/1HyzKhF3JvcHTFlfR?=
 =?us-ascii?Q?pqmAn/eAhdA3WXWownEs/hnKA08IQwWcDiwS6xuv6FGISgi1HMHl9EgjwNOL?=
 =?us-ascii?Q?jAKhZl8TXCqNRrCLnO8Qdy6ijwKTPmG5r03m5jTndhPXx/PFmx/5CIZOuESt?=
 =?us-ascii?Q?e4mQonJiOa/3vHROWzl7ehHgTKAlgOOE59wx8Kw8Iu2QRGPkCZ1QrfKzGhlY?=
 =?us-ascii?Q?Ykvk5GEj/3HNINaWMj6u9OdfBXtLvq18d+jYhNaEZtoa2LFIPXj0QAwBypaF?=
 =?us-ascii?Q?jgs+cGpDRE77LwpWaG+PoOGVm9mDZJZqcRADovivmJP06BFi6Or/Z86H0BkM?=
 =?us-ascii?Q?GoprWsHYflhohGNA/20OrNXnVooV2G4gxfH1fFrpfBcgnDep3z9AqZUUdaEq?=
 =?us-ascii?Q?pii+xSrYJYJe2h2tAuF3xjB9mlhYa8RuqjrmTqANo/iMkvjCDF/vYNBN5MRj?=
 =?us-ascii?Q?/qp88NLD/l+o+ZI0Q+stVUNkINsfvd9k8/vtkjjoa+CzhYptQ4Ca4FFMuHwK?=
 =?us-ascii?Q?+qavzGSCvxH9JKyXFxnV1vHGcgG83ubm4r6/Ibyzm2PzgB5CRIcvfMwG6O99?=
 =?us-ascii?Q?5aUnjmsKb1Yu/qiaK7tzC0/Mlht9qEhx6MXsoUKV/qfcFA77BbrA4+0XKJes?=
 =?us-ascii?Q?D63wfgBfQlxbOYv6lWXeUtTDUh9ZvEOuASO2hqIoYVHdrkSruQwQkrQzGoBg?=
 =?us-ascii?Q?6GFYLtL9eTRRTLTKB6J5o6n9Ks6E8VAfQP85Hv2b09V/d+95ZywohCoZD+Ik?=
 =?us-ascii?Q?2LYCtTZeyRX6GAu9MZFzk2kDN5BcjFoss0MASxvynhrdP1JHu/egLwZieZeD?=
 =?us-ascii?Q?ciw9SLszFBKMEvPzUQEks7S5DKPgiQwNU6Jd+MeVfrUC5hK5X6zu57IdUG/n?=
 =?us-ascii?Q?rjlZ1djst0ikXFjjPI/QGeA=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24449a38-3307-41e4-013a-08d9ed244e16
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 06:04:03.5868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FCVkppljfapQ+u0IbpOvSIx+8rQqSQq8d4VGEov7wteBiAg8/1Qta7JxO4XmQRa4OxFYqbzAIwmDezq8ciIaIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7113
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
 .../devicetree/bindings/mailbox/fsl,mu.yaml   | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
index 6d056d5e16bf..f0a7e693ebf8 100644
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
@@ -57,6 +58,12 @@ properties:
   interrupts:
     maxItems: 1
 
+  interrupt-names:
+    minItems: 1
+    items:
+      - const: txirq
+      - const: rxirq
+
   "#mbox-cells":
     description: |
       <&phandle type channel>
@@ -90,6 +97,20 @@ required:
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
+          maxItems: 2
+        interrupts:
+          maxItems: 2
+
 additionalProperties: false
 
 examples:
-- 
2.25.1

