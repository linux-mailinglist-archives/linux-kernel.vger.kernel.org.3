Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B3D4C0CAC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 07:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238451AbiBWGms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 01:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238431AbiBWGmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 01:42:44 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70070.outbound.protection.outlook.com [40.107.7.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15996D870;
        Tue, 22 Feb 2022 22:42:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0VUUydJq1PjT0Wn/1Rmu1Ebfxa1RSFzjRj0NJ6xVwTuqM8wamrQqOnY5o+YoS2HTIHsJpb6w1TGpFs82wE9/nKSM5akXoCuMkB26lIEBuAZboR42rOKnKv8oIf+plhHrsCYa3UfbJMixICmLxEwc4lsMJwxRL2BvqCa2MP+zKx1ay/j/PW4ekXdhmQlCQqMl61tVpriM1AhIClZOYLI4WRKMZ8Tsxxunieer/PuSbGHVrhMu9h6GSrhQgz+S3M0wwOaLiR4gX1W6xLkBXxUabLvODHoVkF60yVq/ZaTTdpmVGV8pPe3Y++TYXfvfTOJ5RtvuVlHc1mxUJFkwEwJJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JFJZhKTGSa5lsjtLLCCFdEq69GcftU+K0cdBdAhDE/Y=;
 b=QNJWQhae113HCLkIlcvpoT8IUEuHvsupwrTmpzGjcRrAIhwOek59I4nCyKZRb8tW75fa+aRITzY1UaNJjJx5A1uLv0GDwLSyVgoYlPiX/rI3VKrZjMx9Qu0ypwq37rYWjsNduwnZBwl/vmoCVI9Af2OjzwDXod0ZXuu5rhVr8XOXw8+6P3Y7XBN/Fe1FNf9bEvovOSMzeOFWaUbkuWU3nGb+cNBfDp6veUl//LFfG0O49yWN1+6p9i7kvtaGOIVVRpDeYfEdn39BnlJe6Jv0ONKvPXlRsOGKF0yW88TMuoJSUiIWI1lhZ/jgDJIEz/CmjVTeZl5rEWuObQIDM1bEkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFJZhKTGSa5lsjtLLCCFdEq69GcftU+K0cdBdAhDE/Y=;
 b=Oue2q6nJOgGMEBzwCb4ilwRc0DYGYmZoNu2WB30gizAa2OCIP5RTyaEIFWK7uq+ke+Is08gagrzUK+dEIq+N+bL0kegOgW14NRmWS3caRQeAr5/SAFgH/rvFub1wQ3wZ+r4ysEKjp+K5OuNt/UF88G6xv81ipPDYEEl/6gXAO9Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB5542.eurprd04.prod.outlook.com (2603:10a6:20b:2c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.26; Wed, 23 Feb
 2022 06:42:14 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Wed, 23 Feb 2022
 06:42:14 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 1/5] dt-bindings: clock: Add imx93 clock support
Date:   Wed, 23 Feb 2022 14:43:54 +0800
Message-Id: <20220223064358.4097307-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220223064358.4097307-1-peng.fan@oss.nxp.com>
References: <20220223064358.4097307-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0110.apcprd06.prod.outlook.com
 (2603:1096:1:1d::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04a0caab-6778-4474-1956-08d9f697a078
X-MS-TrafficTypeDiagnostic: AM6PR04MB5542:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB554252AFC783FB9A330785E6C93C9@AM6PR04MB5542.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +88g4BDebxRN9RNUeUqLYy9wWmhHXQxRv4jvN3dRFHYQ7Gpx0OVRLY/f1xio+OExqZ9jNgr5U4JZQKAeGSPDBhRj2CV5YAqh0qvk3RLTlpPsDcZL+afgQ9b9Vyv/zx8jjvxfw4w3A9P9CglX+abVq7z9tLjGFp0ibunTyE5Tp+H0rwDGnu4lqTq1SrUBS3cMmbCXMNz1bhw49vPynSMmauf6S0l9jmu2H0UR2uWZS5fmuHIueH/PY+f6O353adlmlYEVn+CqTevsBUIELy8zSBzLh6HtLeL9gvVOKywHvBkf+e7EEgpKwHlgTyv1OWGKMbB670z/wKMWudEzFxUTbysZNb0MzCmEU5UDzHUPTws+RVMUEgFH9j2PvqMNxAeNjVugtF2hqkMcIrAD0xuVIluTy7xca/xrQnO4ZpuUlVZWfF75UEPrCfJHBMvSSASCOP7yapp9LgJW0TYOaFQWzwrhx62B96V1VNGrF3G8Z6ux+eJIP5oktheNNjw3JheEcy8SRGX/zY58u/7TO3XMmlI6vuz2KaRCUVVyXOA8Ke6s1U2vAaAE3KDK6SMfLGQeJWiapHs0/5Ze6bily8s8t+Swdbil2NfDLPGZ08lIfsyxQD1PWGZuHX7jI13YfrdW4MsGBFBN47cHw0G8eq+M4dqXEEmZoj7+U4Lp2Ky3boFAS8asJym2g9VZT8sZrKTqBTSxpwkNH1zaSx7yVchEhQ/D43PyP1Tf72OHgly/RYkZ1Z6E80edgBILCHG5sUzlqWrjNicLXjzPU5+FfQM8rkhrU1CfvceHSJ2QHBCBXbE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(52116002)(4326008)(6666004)(66476007)(66556008)(1076003)(6506007)(66946007)(38350700002)(8676002)(186003)(2616005)(26005)(6512007)(508600001)(316002)(83380400001)(86362001)(966005)(8936002)(7416002)(6486002)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xuxMmndAzYI/o2bpRG/5s/+Xt7ULsa9zYqVH5SVEJI2Bs/M07M7Qc4ZDVjay?=
 =?us-ascii?Q?qaLkzOfEEqeiwxIok+Mwo5KUcazJbLVAhgpLOBCq+yZBqmgPHyiyUIEgcAUO?=
 =?us-ascii?Q?7qMdqmN/TRVO7o7xcwgc6fA9uRJ13HznqouO7u4EiY5BsjhJ36psp0MQcxSH?=
 =?us-ascii?Q?XXzKeIdOlzC63qiQJR6O2OLWMzQcLooXl9KVwQr1ERLVGSD0/wR8BE6oYqRC?=
 =?us-ascii?Q?ALFozsDZ59pLggJh+dVQfgz5bAgZnTQ8jA1p17+f+gspRUqQMTU3PbxTsOVD?=
 =?us-ascii?Q?NUmyPR4BOkO9l1AuKIm8jj+TphO8q771Rk6mqwfW+JSrANw8X0GcUQsnJpUn?=
 =?us-ascii?Q?7Wreu4t2NHgSuWPdLNIdW235cRcgnVHBvBslzekvDDzpjwG6wPygBcoin2VV?=
 =?us-ascii?Q?dpg/7QhSmIZfdiVpqwsEDtFYD2fwCXn/gB5t9kmZvEHRFaShmZ8ltsQG8SkT?=
 =?us-ascii?Q?argETDZXY+Sor1ohhNhoM2cQG1zDaUvv7MmOJU2IHAD6WFrcJKI9eHyRURPO?=
 =?us-ascii?Q?FmErj98Jfk6yibrmiifsoJrM1uBQpu5snqHGOnL7TPPzXiV8h4Q3kLqQsmnr?=
 =?us-ascii?Q?eKLWBJY1vmuLAOmaR/1+BHXetiOlFuiFw98M48zzxuee89kSOXSFCOow2UKA?=
 =?us-ascii?Q?N/JvhAaCS1WGGBWtmnR9MoWztAdMHviqGw6zWS5s7mkRw2sf/LDfIBBIsBf3?=
 =?us-ascii?Q?xPOAsiW+zkg1mXmp9zg9d7O1vei6ws3eNI40slQ0qWhchWGDoyt8b5gJqYpZ?=
 =?us-ascii?Q?HZlZxmHUNDC3bNJGGA3Gc2poe7a8DPxWC+/9GnF+DVQ8ORtGNVuul6uQrsW2?=
 =?us-ascii?Q?5JuYlJ8l0w3ag7wA9SlTih2hCgbMekfREq3YT1/X2HwfhrWGjIcPw9/MCMPA?=
 =?us-ascii?Q?Jy/zeJllJX2xmIyKQu3P/63cbRwip+Kikskf6rnvMBhdFf5rmBrmfrUMfKmi?=
 =?us-ascii?Q?oC+Yuo8Gva6OBK9pBEKVgMCIuvFkxkL8bfAMv7ZS4xL28n9EF/Cxp72zDe7w?=
 =?us-ascii?Q?Eg6loASogjLbU5VLSvt/91Wdu7NndBzmyStzep7IUWX09lg+DHOiybtDHZxG?=
 =?us-ascii?Q?DwHYS6IN5Zs5jIhgL5bhRt/52de4kT2HIAHG9eDmPiKXoeswDZdOw6gM1uxO?=
 =?us-ascii?Q?oWtv6iKtLNq5hONTJ47Hc7QmseCC+LyOW1LMJgWr9/LmXl7poeaBk56DsEGV?=
 =?us-ascii?Q?rJvnRB3sma68FOvdkM36dn5G2tluiTVi3zJl8gMLRnv33Fswm9Hz5d7i79Li?=
 =?us-ascii?Q?XmCWBmwryaBloF4qlzt2J7VTe5ozS2ZKC2Xqs3vQCYB7wbnRX/xxw2aDAa9q?=
 =?us-ascii?Q?nLGLiFNNKV5ONt29u30w9Si1xfeQJ3jV7phPPDB1Fj28nV9UJeJWX/rqaiK7?=
 =?us-ascii?Q?mt3+K3FZkAZmTA9+pZ9wcKKr1IdPk7FQHnbmNI/mOAPBcHcPD7IuC4LFNnzu?=
 =?us-ascii?Q?5I7Eq5Gwn/2MS/wQ5Jr8fUgdqYZJMISwYlmjg0RkZnoaFBGJ21u0wmdLp/nj?=
 =?us-ascii?Q?hl4QO80NvS1wXhOtuzwBzF97rGA4Qb4k52TpPIONSrdO0bcsHITpVoX6/ZSV?=
 =?us-ascii?Q?fEvahAsre44CK2QESkA6edzEIuDziKeEoACBw08vcej1MZl9l/ylqv3SBbLr?=
 =?us-ascii?Q?Y6Hd1VQiqJz461S9ibabby8=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a0caab-6778-4474-1956-08d9f697a078
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 06:42:14.4398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Do4PoZkpCyJAci5hQ8bDgs8wLVlfJ0WcTOis5iK32E4XHGyZcEEbQ/4vP7tp5/qE9k/6BhRM1smBVPvB1t/iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5542
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add the clock dt-binding file for i.MX93.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../bindings/clock/imx93-clock.yaml           | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/imx93-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/imx93-clock.yaml b/Documentation/devicetree/bindings/clock/imx93-clock.yaml
new file mode 100644
index 000000000000..a4c3ae23b8c3
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imx93-clock.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/imx93-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX93 Clock Control Module Binding
+
+maintainers:
+  - Peng Fan <peng.fan@nxp.com>
+
+description: |
+  i.MX93 clock control module is an integrated clock controller, which
+  includes clock generator, clock gate and supplies to all modules.
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx93-ccm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    description:
+      specify the external clocks used by the CCM module.
+    items:
+      - description: 32k osc
+      - description: 24m osc
+      - description: ext1 clock input
+
+  clock-names:
+    description:
+      specify the external clocks names used by the CCM module.
+    items:
+      - const: osc_32k
+      - const: osc_24m
+      - const: clk_ext1
+
+  '#clock-cells':
+    const: 1
+    description:
+      The clock consumer should specify the desired clock by having the clock
+      ID in its "clocks" phandle cell. See include/dt-bindings/clock/imx93-clock.h
+      for the full list of i.MX93 clock IDs.
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  # Clock Control Module node:
+  - |
+    clock-controller@44450000 {
+        compatible = "fsl,imx93-ccm";
+        reg = <0x44450000 0x10000>;
+        #clock-cells = <1>;
+    };
+
+...
-- 
2.25.1

