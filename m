Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A574C3B29
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 02:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236461AbiBYBlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 20:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236374AbiBYBlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 20:41:23 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2066.outbound.protection.outlook.com [40.107.21.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CD528F443;
        Thu, 24 Feb 2022 17:40:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gA8VM3ATkKdDGfRRHP/JrX7NcMThJGmyIC8XTOxSQXCm/erBfONTljVgfgKeQiNAoiwh7RGS6PCWw0gaZ87kb86KScM/stj62H93QSrSSW6df/TIs0x1/M1AH5S7uwjdkVg1bjkdOUvY3Bs9abhjXCivFvXjSbppP7WOytjk8Yr3IMDACHVQ28oY2imCNoBsSeBBggJOqxIOL4OJsxkkz96iPkdMuYYfVoVUyZ5jl+52v4u8k9/3EuarejLFyxFIAtBIPOWJJZeWcwdrhxGsgRomvZaCX2v7/+QzNPqISVXeaFC53XupQwjle44KdLR0AcRK6mC0RffbSm96IrxJzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MfF5Y7GmTNKJ45HdHi0W7Efe3Jzbng9SswwoEO+DmMY=;
 b=ljFjxK7L1HDN1gcH8nI3BehB8O7Yye36kejZKnbQ0n7gOWbepRMzEEpXsyzMeFNUBDOPK6IKLa7i3rVwzurnT+HxuvLrFZ1VI7XO4M8hyrfC31qpYSwRnBJtZ/TTID87Y6zEgRF0d9g/4HUpU9vYrmb42C+EZ+vmvtXpMQ7oEAke1CBU01nDkjmokEc3W6B9UjetlccuubCbOHYKIn593ep8F9M1nfor2zdcI0IiTWXqMxCJ+uWEx+CRw9cOmwCluznvHTuQ9vCeqOWkS7bPXo8VN5FuXun4Hs185lBozfXX3ApAbQI85eTVNvsGPSJib8MLeQQ3fzO0XnwVofvCdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MfF5Y7GmTNKJ45HdHi0W7Efe3Jzbng9SswwoEO+DmMY=;
 b=GanfsarwHEntysEKVjigAMCgOZrLNrK3smfFiPNu/2ylF1t15fPcremE5cayhkO0CmDeHskQL+zAHFyPW/AXNy+eDbNdin4uV4LU7zqjasNwG+60X8/TpKuh95iEMhGZvJUoF7YOQcbafZ5HAw4WEGE68gJTE/qjvEUa3kp9DqE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB5316.eurprd04.prod.outlook.com (2603:10a6:208:d0::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Fri, 25 Feb
 2022 01:40:50 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Fri, 25 Feb 2022
 01:40:50 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH V5 1/5] dt-bindings: clock: Add imx93 clock support
Date:   Fri, 25 Feb 2022 09:42:30 +0800
Message-Id: <20220225014234.1766305-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220225014234.1766305-1-peng.fan@oss.nxp.com>
References: <20220225014234.1766305-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:194::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 700afbc4-e083-42f0-d5b7-08d9f7ffda27
X-MS-TrafficTypeDiagnostic: AM0PR04MB5316:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB531617937899D242FFB8C310C93E9@AM0PR04MB5316.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oSS2x2MDbJIF0g3Ygc7B+ef06u7s11zxp3XFnbiMTgRaoG6WyGMXPHzyVS1HRxQPn9ZQRHuDBZESCOP0ohKL0WFZ2Ts1W3SqASw9yWVEWlXRO5HfOkCSyikI4FoASqU4Z++GKXEbW5GBB9qSdmNOPgRD9/C2byt9uXIfNzVL3es/bvr1nmGouAVZV55PbJMtAxnOFB5WldUlCaiSP9E6WojsWTCihNhdmUZS1FkLfe7MDq1SAntJA5ALUQCOuvutPHNyc4eVdUzkwjTMdtpKm1j63SRIrzccfyCqGhhJ4+zDMCc9k2PYS6IYmEmGbYw++e+h0bSshwKatkgnsg3KammhSjic53q2zabEo1HY8Tgpet1yyRLmGFDH+t+5YlXexRjGsh4AY5ebosddR79oJoxtBZtyJe3IvwmjES4uWHbfkcQ5njV3KgupMCWw9vifbXyKnh9N3sfP4nUm5q0RWE1Sm0Twvkts6MDZX/fasxFtY0RgER0ulcwpxdMys26R0vXle35NMn3i+betKr/pxe1ozAy5qtS8oM8dpraPI1b+ZGN86F7TrgNTnrW444OgDGV9IySF1G/kb7uIo9msyanu4kptVS2HKxXecAgC5xVORnNMuP+cVE/QRIHiAfx8aLLPEJYf/irxIjUznfFn+TtLxpovJtnmKZNUE53CmKjNLcjp62WuLhFFOu551yahnDMiDrlyZ9n4jLAf49Sg5ye/+bjpe2WivIo30KkBFr0FUjoLez6k/mUdtWKZJdcL9V2/SI6mP8HmIWpmKTWJ/EPyz/p0ENkFgUAGSnAMKmeD5WtweTUHe1bgzaEjL1OlxE0rDhDPJ9WrXbqpcn+VeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(508600001)(38100700002)(83380400001)(38350700002)(54906003)(966005)(6486002)(316002)(66946007)(5660300002)(7416002)(6512007)(6666004)(8676002)(86362001)(66476007)(66556008)(4326008)(52116002)(2906002)(2616005)(26005)(1076003)(186003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KmDWWlKmsW80HWEiu9oeyFQM21qxb3HT/3V0r+KuJnWDT/A5EewrPZg7PlG5?=
 =?us-ascii?Q?aum8tFeXiXP9vsUPCq7H/6+2udz3as5M70FkmBbOs/XDyOXrJw26Y6pLxtea?=
 =?us-ascii?Q?IEztlj6dJ54PBPlHWoYKvND3BL8JvTW0sRlTyBNg5IPGOdjryeGtxj0OTZOE?=
 =?us-ascii?Q?Xl7gBZW+zvn674fBHYKQ9IaLxxwVZ+be95EVFZY10WKLaX1dRXfjJnb7fDnl?=
 =?us-ascii?Q?uHnmpBSyj5GxVUMcGR9ISaNVftxMggSkX4zawZe80m0xtRwTa5QkyYsqo7ze?=
 =?us-ascii?Q?NP801DeF3PbglnFZZ0xTeOZsIZmb0nR1OZQRBq803gLiPd1Sc40ZOgLNxeNW?=
 =?us-ascii?Q?fqneZFUe3oDJno4NNsGeZx7erhj5oURs3pDAQ1Rsj6CaNvkm1w4SaWBaf+nU?=
 =?us-ascii?Q?y4H1+33bgr0gKonFVdvnOMYfA3jgasXQWPSvTQM0chMK1kinoW9pk0BX4c0L?=
 =?us-ascii?Q?UFuuzPn/FjgGtOnXzseBBPZDceaDLFr6SUArwXf1f4hgDzUv3KsIu3BMErMJ?=
 =?us-ascii?Q?1tuNxhiic4Rm7CdzieDfQ04G4YKW8DKDo9p0BCGQcOD+6yS6FNU5UXftRyA3?=
 =?us-ascii?Q?8nGXG/AG9o10BJIaL8sMyYEZymwvwD7aqGT+HlbR9gWjW86Lf0ysHzlP+MxA?=
 =?us-ascii?Q?bPTeZ/F3PbhuJamX19HI/FSnYaVae3eFvGpCmSl25yqMz2Mz9ozSMm4Gl1cO?=
 =?us-ascii?Q?bGy+4EezVIARUh7A3CEsgXE378OBBfIhWgIIzDPn+imBzStG7os5zGKCVg8N?=
 =?us-ascii?Q?BWFS7Dw5tnI9cH5h/zNtW1iMDksVkXkSqcm+oPVOmPLQvdeZRD2PSAwD6pW0?=
 =?us-ascii?Q?zbsw/Ca//0STw5Uyl+LI+DkYoNIalMuZDnI/nC9VZt6PwGNm5hR5UH4nN5xd?=
 =?us-ascii?Q?Y1D6mYruRlBN/jzrlxbOpRyhu5JIIHyVKbclC1LrY1JdLF50Nzp9IjE/2C0+?=
 =?us-ascii?Q?KfxWul/Awm2e2mFxyii2Hh/WmrDNQiVUSKzyon4OufXqQvP5Ffm1yz+qy15t?=
 =?us-ascii?Q?Z4nTkcFfnTwipITqwYYL9BLojqUXpFgOWdhCUwFJccztvtxbnarYGTKWZRT0?=
 =?us-ascii?Q?yzhyAPq5vwuFpIHdNderF7mSChTz90acTam96OKYzRXxu0QeuiVaoYQNNXke?=
 =?us-ascii?Q?kNG+dw1AKkHG00EnTSEztozR1Yzjrq80QOBeox/BUGr+c2aif+tUphE/WCET?=
 =?us-ascii?Q?4wdUW9cynlogDqCP1MHziFRPJQ76+NWdD/96UkuP5Mw5m9ZuZStEzo4irYcp?=
 =?us-ascii?Q?sBwKd5bdIFum7H1mgkpBbhEY9vXj57Mhokdb+EDrEFZgGJI6ewlLKoLovytC?=
 =?us-ascii?Q?u+YLl1aSGq0P4vO0MbXEVBJMugL4hvBS8Lt3/or+NAAsZx/d1Vrng8dTCHJb?=
 =?us-ascii?Q?+xKOXmDDIQxOOL+7GtRxuQz8ROTgQgvqU0EuHqNKzZScJAb9xIn/GndzaYeR?=
 =?us-ascii?Q?5lqYV9gMb4ZcG3JB2IFjYVLGYU2OSblKjWrXYe+kjsAjxwFNt+C+JO7V75QJ?=
 =?us-ascii?Q?vfZ0FgDSXnB85j2PXr7LpRlhino5wfHUUnXdd8X/+05ELU6OJGGCydFlZDPc?=
 =?us-ascii?Q?uiX71Lh96GN4B44vEUIYR17GIc8e6Xz4D1gDMO4Cq0WDvtofZCh3V1sR3SXl?=
 =?us-ascii?Q?y30ySNC/X7+SPtGyRQSbLDk=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 700afbc4-e083-42f0-d5b7-08d9f7ffda27
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 01:40:50.1056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zo6Qo+F8PBs8FQ7UMITK+kyYXV8xlgF5OwJ7vyGQS5L5dus9Ei3uUnyF3bmO6HpmnLAs68Gvfo3iePr5768nEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5316
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

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/clock/imx93-clock.yaml           | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/imx93-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/imx93-clock.yaml b/Documentation/devicetree/bindings/clock/imx93-clock.yaml
new file mode 100644
index 000000000000..21a06194e4a3
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imx93-clock.yaml
@@ -0,0 +1,62 @@
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
+      See include/dt-bindings/clock/imx93-clock.h for the full list of
+      i.MX93 clock IDs.
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

