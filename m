Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A46560630
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbiF2QpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiF2QpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:45:09 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70089.outbound.protection.outlook.com [40.107.7.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DB135878;
        Wed, 29 Jun 2022 09:45:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIuoT3twhdTDoEVPy2HBIAIZz7g0Uqx/uc74Ueyv3l0bhkCZnHDKNqM6aZ+Zwk+/VEpH2n9PeYDDWd5bdZjjRm3WDqfR/hvzFv9iQ4E4e0u2Q73gw3wrnv7BJ3GF4OlpSInc2wC3WGAxbDwevWUM5baPa76YCYgh77H27Ms+EF95k81uWthNAL7ZcIWkaPBtscTRcUkvFvA45cidyoZH1U5SL+G5oRuEC0j1a7XaPGPbuIfQz8br56U17wKeo7lYnFNKxS+SiqwWFlbk5BfK1om5XtvzdVwLZNXyU0zhKdvcCuXKAjbDs1IqWW3C7c6tPZPUvtT6UWA4M9rFMnQGuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=co3aEqTQJ7YlSMHsUVYp+kqOefZ3lxCkpbfT0hKWtCE=;
 b=iRv2VDVcR3FXyJ01ZfDF/iH0lAnb33ROKvA8g+Srl1PDk5EkTm1LFiwyd2+ZQLsIYbVuOsfJaef2YQcQ+7zHRV0U3rt1ouHa8rb3gOnylkVMKeEIAjg/B2JUVUeTQYMXSObb/zkBIL4IFFsn3PXQB+1+wsw8NhDofBoX862qodkGESyuCf3ao5yG2DDgoTSPjsXJ0nrwwgkXqY/LV/iDfZGuIx2EYAZUDc5OjOqabrQyZxzCI16e0L/WHAZfyyLSDpcN89NnV4Q1dPM06UFJedkWSoa80EXRopQPpOSnzfaWtaGpWJsYMr4lZR/35RHcw+NYufwWlmUccCnbm1ZpnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=co3aEqTQJ7YlSMHsUVYp+kqOefZ3lxCkpbfT0hKWtCE=;
 b=b4caaIBAfOmHNOvSGIZhxXYJajwfnlmm4EQilqje1AX2anb4s5DTWDtf3Dj8LTS4LLi8S4Dz5NR3D+U5WOhlN0AnavxFM79L2jj8ZLeHiFqIH4dQpJWYwhCAp9lXKV+DhGo8/6z5HUQ2rT97rZZGvphXJ7b5e3tlvzjIMt/iwiw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AM0PR04MB6401.eurprd04.prod.outlook.com (2603:10a6:208:172::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 16:45:06 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 16:45:06 +0000
From:   "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Viorel Suman <viorel.suman@nxp.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Liu Ying <victor.liu@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Ming Qian <ming.qian@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 03/14] dt-bindings: input: Add fsl,scu-key yaml file
Date:   Wed, 29 Jun 2022 19:44:03 +0300
Message-Id: <20220629164414.301813-4-viorel.suman@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220629164414.301813-1-viorel.suman@oss.nxp.com>
References: <20220629164414.301813-1-viorel.suman@oss.nxp.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM9P195CA0028.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::33) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93c5e3b8-1a7e-4deb-3eb4-08da59eeb866
X-MS-TrafficTypeDiagnostic: AM0PR04MB6401:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2T7tKWpKZwqTJ6663BhDng6/Yek3Hm25lmYB2sYNkywKwVMiNQA/A1T//OUf+8wU2GVqTp0LpegugE7ykF7FC3TkBlaRjBBYGEUjaf4vCNtKXiwpyPVRpFrvxVI5JiTEIJVKGNL5CP/G3P0tzKxRoFzzngVI4NYWc9AgMB3qymSFo6y/W5JAjxkSmEP2DXiOFxIViEjdQa5UjyCZWk2ywB4CDI1Oak/Mm5HMGVq/54mtvyGiwEvcdbkHZxWRZC4FgqhjMaV/X/0nq+6xFierShgbCAs7JWTQrx3S1TOPzKmqWIZRrC6bbSh1PHdEmWT9NbL4sKaR687U4fcHXrzwyKqtHba1Wskq40zH73777HUBOlDC5C6eh9O+9fC/QSz+b7dIg8JsS21mVCt0imJkDyuXpgt5XpJ0kNCez3GDFLuvCLn9caJgJfsyjWedzPxy4NKu3xVTv7JbPM5xdns2yzq8/hBSnVDagBsN69xhKypjynyrv0OwQW4oFNX63NMwBIwS/alxLY/fzvvtyiZhVgjfus485VCL94XqqCisFWymtAt/iEXGr109BXv81GBqVD4vvAnQ5XUWJbPAJybGxeLeNpGNcP+3ne0/SBBMZa8JjGGwgxEb21AzLz1ZjMWKnaSMqKmhUHf8/xobwljfwCYgySEiMfQawfZVZuxTAnONvxZQYTH3ssSPYECRQLBiwCuVbMsdsE2WSdyZNrMGFRxocmUnosyKZC74fqtOJDdQ+0ibwBsww4b8ek/2ellGosP7Bd8OpBCDBcytum2BYZKapg9z9H/deOnHPG1dCXtonP+7LoMbJz1t1Jah3t675ZsA20VGcaHc3sk5ju+7Tt8HgKZnVWl8S7ujl00bVKItVAVgN9OWcLtfgC2mGxip
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(5660300002)(7416002)(38350700002)(110136005)(38100700002)(8936002)(316002)(2906002)(66946007)(66556008)(66476007)(52116002)(7406005)(8676002)(921005)(83380400001)(6512007)(26005)(6506007)(186003)(2616005)(478600001)(966005)(1076003)(6486002)(6666004)(41300700001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Jl3MtaUYixEYWKBi3SuCLD+0LDx+R7k8PT/8aTCLLpx1oqiRYVH2wmeMpO?=
 =?iso-8859-1?Q?tJQrTvbCaV5EaR0HZUvoHEC1VH1io5y4ejB+OO1bdjs664MQKUz2kQ7bzE?=
 =?iso-8859-1?Q?gL0o46ue3v+5k5mloaXR1VGOihkAGozUsVstZO5jA+mNIAcqU9jbyrk9rd?=
 =?iso-8859-1?Q?rsZy/KUL2xdYwpovOlFE80Wycp8nnK/6faumNJst62kwOuA1IculC9mrl6?=
 =?iso-8859-1?Q?YNRcAN9RuvCTW9F7WY/9PHTjmrpCMm/WPdRlyeT0DQLwgBDmSo7Vwe+Q/Y?=
 =?iso-8859-1?Q?Dg3HlnYHMW5tmJG2FszxY/81C4/COrs/OHUep2CTiWO/BtTPPPQWST++y6?=
 =?iso-8859-1?Q?sV+d3DB7eLFLX5s7GH4yoBjNcSDWrzXcIy3DeU47dpqovpyCgFRelhOe7d?=
 =?iso-8859-1?Q?RXKehXwVouHA9K6o6u2CrZeRU47oAOE/fDbjtLjm4DnAzGO8F0xUt23As+?=
 =?iso-8859-1?Q?Sl2DdT1TJhAzv2rA5KUDjclrSTcTAnWKJNtT/o120kKdGx7MLK2KC/u7gx?=
 =?iso-8859-1?Q?deUjcl1NxX4sZmLRMAtWVO9F+AhIu0f6mR7F8KSO+Vy9uiHYtGqnluc+yM?=
 =?iso-8859-1?Q?KmWXceXngKq584uY1wFh+s8p7I9ndjgesufbabGYyDX2D80gYVtsQlvbSO?=
 =?iso-8859-1?Q?EP0TbCwW7WCqE5OIfL32nTRT8RuUolxDQPSblwefsBIEYIw7fDX02SBdFx?=
 =?iso-8859-1?Q?FVFzFQzEEtyxv82unlIXIJ/n3fC15YV9QsBngwyzGNp5JcQZ0X785ibEpN?=
 =?iso-8859-1?Q?sm1o8j0beIYC6aekXJ3oi3pir5ZxVO6z7HNj3VO7JHpLbGm3vTkd4IxxXl?=
 =?iso-8859-1?Q?Veeh0xMfFY0GzndyxqadVoZD61ATxONYOiUfI4ng1xPRMKtbnll4PZesC9?=
 =?iso-8859-1?Q?8xkvBpocw5oCs1+eChxJyz8ayvTkKZMq3Td6B35DZigMnR9ky5dX3AUUcf?=
 =?iso-8859-1?Q?ZCSws9cb8VC8H0aQpzpPgnWgr2ygk/NsM9OGnr0jK4iKw9tLpywmrbSlsY?=
 =?iso-8859-1?Q?dsQJmf5vBWPFJ0LRMeP16/EYZGbHv4nE696oiDvAwMv+Nte4v0BoT6Rp/U?=
 =?iso-8859-1?Q?B0h0+SVgQfX7+WAcRVGxLNNb4XilnWR3Y/NZz7tszdm/EDiUBKd65Wdyoj?=
 =?iso-8859-1?Q?nZzRX/FVUKfjjz3eorlmm1IKI/iJ4+5sZn56iZnWLpYougNW7OI0PxEMz7?=
 =?iso-8859-1?Q?l2SoHBQJkbN2ySxeF2Dqk1eHJLQ3QNXjcRXDuiJTQ0V+Xd17ivWlBKtZ2x?=
 =?iso-8859-1?Q?aQlSiMZ4i4Ze6WL1vxrfl0spPVbAeuI4TKzH56B2ybycKJ51bcpd51wK19?=
 =?iso-8859-1?Q?0GYrEhWBiCrQ/nFlRF/wWpLTPS5Cgn5+uWoMZjf3el/ixjLukKa/wb0VqC?=
 =?iso-8859-1?Q?80J8I3X0rONRB3iP4vlVHmVchaipAiasCHytx4p1e2N+4zhKPClzODy2IV?=
 =?iso-8859-1?Q?vIMgUZBEkahOl6u8opK03L1cqtuaIuUwHsaoC7UfYeVdKnTDsG7w1ikXIk?=
 =?iso-8859-1?Q?QigpuK7/pmwFyE2DMh+ZlHZOpz+N6hFOazdOmlh5WZjzUpDNnbj+ncDo3J?=
 =?iso-8859-1?Q?7ni5ekTbRJ3It3O/I+f6p27Z3mowfojgbNqUnpQlBT4UJsO0om3RsG+zER?=
 =?iso-8859-1?Q?v1japBIFa9PTOI6RJOvpgKgoMjLmV2E0UU?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93c5e3b8-1a7e-4deb-3eb4-08da59eeb866
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 16:45:05.8549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qyRVubnyKPCQfQzKK5/qEIG0/UbSBBeYMjG12CvnWI51Rvq0P/q1Th6Nr049lEEhc99N+CG6B8HLLQpJ4lJrBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6401
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abel Vesa <abel.vesa@nxp.com>

In order to replace the fsl,scu txt file from bindings/arm/freescale,
we need to split it between the right subsystems. This patch documents
separately the 'keys' child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 .../bindings/input/fsl,scu-key.yaml           | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/fsl,scu-key.yaml

diff --git a/Documentation/devicetree/bindings/input/fsl,scu-key.yaml b/Documentation/devicetree/bindings/input/fsl,scu-key.yaml
new file mode 100644
index 000000000000..7d870cbed02d
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/fsl,scu-key.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/fsl,scu-key.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX SCU Client Device Node - SCU key bindings based on SCU Message Protocol
+
+maintainers:
+  - Dong Aisheng <aisheng.dong@nxp.com>
+
+description: i.MX SCU Client Device Node
+  Client nodes are maintained as children of the relevant IMX-SCU device node.
+
+allOf:
+  - $ref: /schemas/input/input.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: fsl,imx8qxp-sc-key
+      - const: fsl,imx-sc-key
+
+  linux,keycodes:
+    maxItems: 1
+
+required:
+  - compatible
+  - linux,keycodes
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/input/input.h>
+
+    keys {
+        compatible = "fsl,imx8qxp-sc-key", "fsl,imx-sc-key";
+        linux,keycodes = <KEY_POWER>;
+    };
-- 
2.25.1

