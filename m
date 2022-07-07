Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD95056A2B8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 14:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235676AbiGGMvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 08:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235592AbiGGMvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 08:51:12 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2053.outbound.protection.outlook.com [40.107.21.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78032C640;
        Thu,  7 Jul 2022 05:51:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhyDA1zDQiYaiLfiB1gK0tHmtOYGYfTW8Pdvq+DrrM+0Ngvd+AeApDi6J1TGmkoPeOoMarxGozO/CQ/6T+Tw/FLt2jQfxAYVw0rLIqChUQkAlvIZH0j7kLQxmsSQ4qUtnELcikQEfxczZ86LTVav2UX075JWwLpiVSggEQqatcs1bVbx4mko7ewOS278X/5cBLfNOyWPHhyZ5KUPrPB2zPA62PHN1KnzTtxTn9psXkas0lqnT1kysgvUkuBdIURZ+hkeMSxiGfjGGVzg3s/7Sse3tYQIEkH83GZ0x85rpMbCKwPPF4NbSRk+e8sco/17jspaTc3wTt+Feg57v0nh4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IoD55JLRcGyRIEZTPh5WN5ZAQ8uXmAsEanAHvu4Nj9U=;
 b=YQPofkYqobWVzUZMj3j25b1HYVwYN1vMhUpJcMsw7X07h6pCTU5DJKKY2LKUlatjNT2zu/0WSz+p/+DpY87CKcfy7iJl3DBlZdvtLfPFh10FnYDG6pWOY41NSjrY0YoHKy2d7j1FKyBbNPD8ZxjWUm0mSwUyaPdxzfT6N3VaQG3WH9Puv6tijkGB/4QlvJxAKRZSYyn3254mEQI40pUYnv4SMhldJbnwIodx9uYdgRgVVALBHI36BosquMo2TpF5A4u00D7kZeSGDrSDBTf5ku3HiEznAzIQdbpX3Nj4cETk5097BhkKoY8CR89Wuly+VvvNfhYuk9Byzqt2TeLw4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IoD55JLRcGyRIEZTPh5WN5ZAQ8uXmAsEanAHvu4Nj9U=;
 b=R8IRDmezVkJhcUPb5H8Acu6xUIUEl0YRwLyL9pU7W8khp1kXEr/brZefNsVcngy53lpllwefHJSPDeumFiaoyR/PiVHeNDlwvY5bRZzbfxlnFxVZ0Uj4BJs7eOD9yDH6JyQeYbApZdoeOyHsgBpqIbaoeBeO4Ljpe9KL7Uulyj4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AM0PR04MB6418.eurprd04.prod.outlook.com (2603:10a6:208:169::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 12:51:07 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 12:51:07 +0000
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
        Peng Fan <peng.fan@nxp.com>, Liu Ying <victor.liu@nxp.com>,
        Shijie Qin <shijie.qin@nxp.com>, Ming Qian <ming.qian@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Viorel Suman <viorel.suman@oss.nxp.com>
Subject: [PATCH v8 05/15] dt-bindings: power: Add fsl,scu-pd yaml file
Date:   Thu,  7 Jul 2022 15:50:12 +0300
Message-Id: <20220707125022.1156498-6-viorel.suman@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707125022.1156498-1-viorel.suman@oss.nxp.com>
References: <20220707125022.1156498-1-viorel.suman@oss.nxp.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM9P192CA0026.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::31) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f86dc661-602c-484e-2320-08da60175bf1
X-MS-TrafficTypeDiagnostic: AM0PR04MB6418:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GO067nxUaQP2Z3HRPWEACXVvyYb7lJjTxzTWqm4eWnOSSDb/a9NnKsuTDLAwVF8ZuW2PGx32wjHn9sVqF6TgW/T9hb2Bcs622r+HhZB6WTkjTsHwXWlrRmj2iTZduc/dr6H9cbAvDbMJWnFSjb/lLvodgOe2hmJUnYpgZ9QZ2trmrgTYs5qfaR0lKq5Zp8xknptuPF5UbN8P1H75oqWRECms2biphWTZyw8NX6iRq+EQIfHeZQVrf2azUFW2fAYGTGdBi8uMA/sM56fy930tK2K8J06Oh8P2HQMEU68rEyYMiYhkD6A8aWqn2gxW9rPN7TpMinm9/PHVTvC0SW4fq1dHEPAZpcodBldh56st/9NuCfUW4mFyCMtDZeUHSHi/QEB0lof4ShMkR1TlW+ERx4B3EBtGyTPaytkIIoBw8Z27YMpnrJcSgrt9zvMOBpEOM5nZKElrY5iFFfZcWI8qpgb+mb1lrSJnK9dOuLAByJ7suqvNxbhQWKt96qUOQ/Ib/1b7Qcr7GBmCYNQoCYfTyXzkb8JG6lzOIr05xJRyRlUdk6yqkknLKgpDk/Y0rFSm7BSXyxa7loQHheKOZ0rJbPhaQ8ZsRc4ErHNM9JgBKg1YclG0r+o9Dz/aU0ez96MKAk17UJHslQcHUXv14n8vAH4L94fP79nn541Hi1PXGamRX79PiyRkuhojSJ4JFwdF70Y+TmCk14poi5XjQtvl4/FRTvo6x/f9EH4+Pe1RaiyeEJ8fKYbr2pGZ6MU8ckfJtDxc4ayiZTek/IVKIuXVQFBqfEIw03l3+PGJttWr60UDCUPYlba+HKDVbbusFd54cCb/JuCEH6VZdMbzYApX1fm28G3PooVJuO0U1obUs/Ps81qo/hOfN5y0lLmKbeAYUOkEdHLYVWRjMBfouCE6pQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(6666004)(86362001)(5660300002)(966005)(38350700002)(6486002)(316002)(38100700002)(2906002)(41300700001)(7416002)(478600001)(921005)(7406005)(66946007)(66476007)(6512007)(66556008)(8676002)(4326008)(8936002)(186003)(52116002)(83380400001)(26005)(110136005)(2616005)(6506007)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ui+mIexETcdUkcjXbRpYbhair/6QFQJHD00v9CTqF1FOGiudxBLYJY4UUl?=
 =?iso-8859-1?Q?kn8pTOPnqkPUb1ZknAvRqUMRygqLWSSimx7AG8+Ccvv+gh9nkYwUuBvEbu?=
 =?iso-8859-1?Q?Fm5y3onNlGW3S7sMHP+nAdP8mOvYYW5U6CHQVDF1E22T30qUzaxYpVqqmB?=
 =?iso-8859-1?Q?mW7XzVeFJDj0LAqB2nbSGzBn6xhIPSfL8OCesGUaXofBF/yRScrEQoEwqD?=
 =?iso-8859-1?Q?4OiQNNpr6hE3TsmrPs8cPZyI0Ep/EYS6WyEtt8ZjleQgu/4ph8LSzIxTaA?=
 =?iso-8859-1?Q?atZHXqFMn08uT40rGivjnGiKEOepHvR87ylvk8dXSNZ6ISr7eyil+b4C8m?=
 =?iso-8859-1?Q?tASw/xnE+PmbFCecONNQagyRU3dGeKxrBLTdUFImIz3Syw7kedZ+Togf0K?=
 =?iso-8859-1?Q?Db2TEdoPaEf9/gekKOjHGm9n4VLrVqmnzstVEV21clFb8tyGxNzXdfVVwO?=
 =?iso-8859-1?Q?IdNcXGjTpOMwrhs2E6AdZduhlTZ26vFIlqSFmpQ0SiXh60isuo3IoNReLv?=
 =?iso-8859-1?Q?LnHYTVsGF2325/xESQxZP5F/GbCeT2l3OjGjC7ygkKQammruIyu1odkQEP?=
 =?iso-8859-1?Q?y7ceQ+HHE/WIHqJobbeG4myDFPYtdnfJqCcum3HOsJX1ECiLKFzm//ZoxE?=
 =?iso-8859-1?Q?r4Cv/kdAebD0If1zo3LGtck2dtuizalG3VTxzA286vOjjNIp6RS7NQEARb?=
 =?iso-8859-1?Q?uZU1wEHL39n/VOdSwyvEHAFnpEbx8R69vIY/IJh0tPjsrEMYPhbbLDZVZe?=
 =?iso-8859-1?Q?pC08AaJEt3rM33eMxp8uMryJW35m32IzCKhf8sBWMvWfFuCosOk11qaQMv?=
 =?iso-8859-1?Q?EhlQWrX0kDxcHy14Xj9FI5L8fUojifzWbdxmi0fs0ZJCSNf51awNDuhEH/?=
 =?iso-8859-1?Q?R2prT8QXBGtJhDO1bff5fNx3+HRM+vDkxgQfjXKW/tJ2QCfXfkeEVatsid?=
 =?iso-8859-1?Q?w+rKOVELb9ner3oIp1nDr5SIGTWKWgfj+8KD/eexao6uZzTYB+5uXPU7rl?=
 =?iso-8859-1?Q?aQ7p8gPvlsPPumUH3Khtr4T3Z/9Ejs9FrRWeyP6uddPZPvF8OQOnIZzpYz?=
 =?iso-8859-1?Q?Rjk2m9bAvdM0YNP17WwZMrlxEL8cD0PkaVZobW7rJ4Xnm40e6CKo3IbNkM?=
 =?iso-8859-1?Q?KmYCbVkf2c9FjnIzPYQJ6t0R5dCPGDibM1lfxSgB7I8pHkWIa0LC7LPrKK?=
 =?iso-8859-1?Q?Nj3lSnVU+l6ttjvpSm9fRuYOiGoZ4NFNpVagSzlYGGmBxZyZBvFHlPh+96?=
 =?iso-8859-1?Q?vCTJlKpIN9rUXKWJLHbKFfj1VQmg4j5wW0VmOAvNX6IiNKgQwYjCQbKXgz?=
 =?iso-8859-1?Q?BwoPB4KeqVPp9kejrMQOHv2MVIX7rGXFRyP6XtNt3ID44PlDYaO7XmhxEA?=
 =?iso-8859-1?Q?mpLrdF8SLLEo0PmbmIRKNmXD27AGvfoxwwCwQgpZ+V5avN0V1+GZPZsy4k?=
 =?iso-8859-1?Q?NN39hqPijhXSokTbBDpOTp/k/X1HfulZG+0nvSWI4uCGiE6Y7f4OspsXkR?=
 =?iso-8859-1?Q?tbRjFVaJriyXkKBIVXehfpC7z6P3tjAXdQZl+t4/6Z2i11Y+S+Qtvrn8Nw?=
 =?iso-8859-1?Q?X5yOav6K39P8nXx9ZJxulJbkvCJUq+RJ9/ToXqLEnwvg34LI02kcV8i2gY?=
 =?iso-8859-1?Q?iLc3VzmZCBAcmfJbS13/5ng9ipv4zY+ZP/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f86dc661-602c-484e-2320-08da60175bf1
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 12:51:07.2515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nr96cCU7qaCerjBsw+QgLPQdKaOYDNwlzjc/nuotMV1DPovq7PO1JCQ9dIUDeVdf//i60y9xQKORAfuqVcWJsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6418
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
separately the 'power controller' child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/arm/freescale/fsl,scu.txt        | 25 -----------
 .../devicetree/bindings/power/fsl,scu-pd.yaml | 41 +++++++++++++++++++
 2 files changed, 41 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/fsl,scu-pd.yaml

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index 0841ad8bbd22..1a06f627b125 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -62,25 +62,6 @@ i.MX SCU Client Device Node:
 
 Client nodes are maintained as children of the relevant IMX-SCU device node.
 
-Power domain bindings based on SCU Message Protocol
-------------------------------------------------------------
-
-This binding for the SCU power domain providers uses the generic power
-domain binding[2].
-
-Required properties:
-- compatible:		Should be one of:
-			  "fsl,imx8qm-scu-pd",
-			  "fsl,imx8qxp-scu-pd"
-			followed by "fsl,scu-pd"
-
-- #power-domain-cells:	Must be 1. Contains the Resource ID used by
-			SCU commands.
-			See detailed Resource ID list from:
-			include/dt-bindings/firmware/imx/rsrc.h
-
-[2] Documentation/devicetree/bindings/power/power-domain.yaml
-
 RTC bindings based on SCU Message Protocol
 ------------------------------------------------------------
 
@@ -135,11 +116,6 @@ firmware {
 			  &lsio_mu1 1 3
 			  &lsio_mu1 3 3>;
 
-		pd: imx8qx-pd {
-			compatible = "fsl,imx8qxp-scu-pd", "fsl,scu-pd";
-			#power-domain-cells = <1>;
-		};
-
 		rtc: rtc {
 			compatible = "fsl,imx8qxp-sc-rtc";
 		};
@@ -158,5 +134,4 @@ firmware {
 
 serial@5a060000 {
 	...
-	power-domains = <&pd IMX_SC_R_UART_0>;
 };
diff --git a/Documentation/devicetree/bindings/power/fsl,scu-pd.yaml b/Documentation/devicetree/bindings/power/fsl,scu-pd.yaml
new file mode 100644
index 000000000000..1f72b18ca0fc
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/fsl,scu-pd.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/fsl,scu-pd.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX SCU Client Device Node - Power domain bindings based on SCU Message Protocol
+
+maintainers:
+  - Dong Aisheng <aisheng.dong@nxp.com>
+
+description: i.MX SCU Client Device Node
+  Client nodes are maintained as children of the relevant IMX-SCU device node.
+  Power domain bindings based on SCU Message Protocol
+
+allOf:
+  - $ref: power-domain.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - fsl,imx8qm-scu-pd
+          - fsl,imx8qxp-scu-pd
+      - const: fsl,scu-pd
+
+  '#power-domain-cells':
+    const: 1
+
+required:
+  - compatible
+  - '#power-domain-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    power-controller {
+        compatible = "fsl,imx8qxp-scu-pd", "fsl,scu-pd";
+        #power-domain-cells = <1>;
+    };
-- 
2.25.1

