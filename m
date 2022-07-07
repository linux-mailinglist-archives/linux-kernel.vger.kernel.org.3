Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCA056A29B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 14:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbiGGMva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 08:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235680AbiGGMvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 08:51:21 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2070.outbound.protection.outlook.com [40.107.21.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C0F2BB34;
        Thu,  7 Jul 2022 05:51:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKli49Hg7ZEJkHC9kFAXjd1L6po/QfB/fLLsmXKr/wvK5bB0m5kaTcc4slfFXvR0mYlfs/Xfn2ExMrBXDB45/DdCL9l4m5iya8GGr+OFqSzN18MXdoB51ic7f5sxphSTAgLaT0x0vLl2GluJE+LEh9lrakgd2jTNWvreEgzUmoKCvx0yjUP+6Hja7aCV2mlFyUzPMAb9s1UQpjPaYt43gsW8q+VmddQYpBhR5gvVa1ULv1V0C28sBj+kLvYc6+stPCx+KWVRYojk0SG0t1w2u9UZvCRsEmibwONNEevOB57y///h05eV6oZCP6qNScJpZiAbCBRnrge7XgIq4fg9uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIYh2iAnQH5EhAaTJSFNBdk3gd5cVGdL2SZ5BceczdQ=;
 b=Ot0Pjot0saev0vFGGFQWLdq34t2cS5wm0Od0X54QabL/m0UGzobHnC1k8RhfoMeW3ctDcWmkZ8ivs0Tstm/iD0TyzoSZbFDa0chYgItcBixqbi7FlGCcDmoXlgE6S5iaXlMg8R9T2mthOhq0Byp5v+Xoe7CfFCCl7a3ZLk3/PEyY0gOTU1IFxCCdLAJn1cZDIn0RBwbI0OyAoGbl6bG6eblx2Er6T7jOZTfthUA8nK0Q+HumfdcTu9WC2Ceq/X1iN1Qv+6quuSaUOvlFMXJlKIYMK0p9krRJSvSr51v2OvZU0TSxijy5yntzh6XHI17x478of4A3URAR5WDxlVvygw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIYh2iAnQH5EhAaTJSFNBdk3gd5cVGdL2SZ5BceczdQ=;
 b=KnANNkkeRGKJtTvR1GW5NEbCF3xqme1tiI6rLKERKa02Hq1CxW7DavtLoyZn2RLkRXKnpD0ay2iVlkyigbBAgkr/Cy5+FNmRCmxWlcTbCWBIpsDVFz4k9kkMHqE47ro1uGoRDoufEPtjpNSRtBCMkD42s3Q7akt874P68XL99Qo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AM0PR04MB6418.eurprd04.prod.outlook.com (2603:10a6:208:169::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 12:51:16 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 12:51:16 +0000
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
Subject: [PATCH v8 08/15] dt-bindings: watchdog: Add fsl,scu-wdt yaml file
Date:   Thu,  7 Jul 2022 15:50:15 +0300
Message-Id: <20220707125022.1156498-9-viorel.suman@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 515dfee8-f99a-4cd6-8d78-08da60176168
X-MS-TrafficTypeDiagnostic: AM0PR04MB6418:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uT0coQQMuqqPvybbaQ9xSUKCGO7UUKjBL04198U+sJqCipolOGPX2K72ZYesa8TMQhA+HJnn4W6kNOAyERKzvtaYCqgOqMnB+HsMKCUDpvfDqV1dtXeL/ttdvRF5IbhArhfQBnlY79yyOM2hduCqxSUk+5TEOv+i4vpVMMo06Isl8VH4TKl2cdKeQpGEH9B4V9AhvB8oAolWuaXkWIkbkGm0tKEmM4jaUs6la2nNrGTQGSGjbbR1GXlpPBej8wb2RxzMZOQxkgoznxGAYA/sDxV0aMTkZFXg69ngHhKKShtfDVfj6+ZLOWKFcCboMyH4Dhc4F65t5Y5h7D0huRCRrGJ/N2o4kZIh6F/MUSSQ+jpwpFyzzCBfMCFpGh35Z2H45c6yLUxiNvUpGYFTFCQfqlyEiex3y6s5/ZNqQvCbL3h24w/QrP+yyPvVAXSkSNexBUxszaYqqf6Bf125wbwjfl7NIs8D7vKnok1JfrbO887CdkfAGJDJozEEnRoWn2XEgeiEle31Khcaoh+glgD/iFm1xip5l6oHVgXGkR3wX63t8MWGhhaDCIX1uEcTJ0GrYoSdJxtCIC8nSDA7AqkxTPhatfa9vZ9x40Jwi4p82TFeuDW/6CjCapU1uKcCfcJS4poXm5nQSkVtDUp6OdZvEseU1UPdH5sqz14OsJ4z+EKstmLAOASXfxQ4UmHK8FnoKDfcmRypGP/CcsDtpAvUj3Et74lSNCsFqXtX5VcVJmyJgK7ZUzr/7ZwuNqkWRss7z57QlQK7Xq6DHMnhAqGUBBbvZY42JHST2pbSEjOi7JqiyvTxpR3J5g943QhstDcvHiqCMS6NRscW45BGzGjkE/XrJwYZq6Rh79GS/wLJFdzY+fnxMhMIyNj4jTCXuP9Kibp9pjjKtWLprNEMHhfSmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(86362001)(5660300002)(966005)(38350700002)(6486002)(316002)(38100700002)(2906002)(41300700001)(7416002)(478600001)(921005)(7406005)(66946007)(66476007)(6512007)(66556008)(8676002)(4326008)(8936002)(186003)(52116002)(83380400001)(26005)(110136005)(2616005)(6506007)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?/Q1QrvCaMl32Z5C9JsCuIy3hFfVZhoj2iaypWFecil6JoY+AqnTp2Bf/Tk?=
 =?iso-8859-1?Q?B7BGpnEa71rdFkC6R1cSIHU/5U/6nWpDFoxa4gTIm/M3UWY9VWcI7RSFMT?=
 =?iso-8859-1?Q?DbX+F2CrmpLOjLrj7gvvmAHjKRz4mHDHn65jFZR8lkpjmU/vYQ/8YEOdG9?=
 =?iso-8859-1?Q?WRgJvYJ3gkpFE49yr/awSUdaCGhD+YP9vfi5BdpHi8zGK34W/roPlplyJV?=
 =?iso-8859-1?Q?mdxBn7EAygeE0Q5EEu0XAnTSrXhG+mWdjMZzwfs6EAWX0draGFsoEeMXJb?=
 =?iso-8859-1?Q?o4lBh2q43UUvvJ0YJ79wvPzutnojjvKO6WjpL3VzdC0bwveDvQlqjUhw6j?=
 =?iso-8859-1?Q?O5HEvqNzbNxpUznRiwDWAiZ4+cOamifk0q/Bd1LxGnuAFjXAB8MaDlprs2?=
 =?iso-8859-1?Q?VkWb3Cp8TYBTY3Kr62IEC/MM655FfxY47SWOrQsEOgzdikpQqsQJkwL1A+?=
 =?iso-8859-1?Q?4Cjq9sv/LKTYPZC7DKN0WY9qxYeDYI7cmpTUcQ1dpefv6l7Ag9i/iZUCjq?=
 =?iso-8859-1?Q?BfMxOtYnlT0RjMlktwLYF8b3gw5uxMgEa2k2GJPcGnPgv+PDaMMCzctUNI?=
 =?iso-8859-1?Q?MCHQnTUKg3nTXjVkvJ2o2DFG+mAvY0PhnSfOWCIMYg8d3/GtOsuY5403SW?=
 =?iso-8859-1?Q?iog7XlftDoGaBsK+524485/5Fd4T5igwEcbydQjDixAbPrJ08bsz73+r2y?=
 =?iso-8859-1?Q?wtzu4eDdGf8Juc0GlHho063fTl8eZFQrwOPlSxFMFOxGnl0pc6II285buY?=
 =?iso-8859-1?Q?D4KEVQrjrAr62kyQSX4dGdXaISvB4ASeod+6JTh3qHkP8dgkqLcvkltcfT?=
 =?iso-8859-1?Q?7ZK4ho0wUuE3rUsGSBhugMdCjaCBjpzaO+kyPrYhEIHhxAE07HhNEe08Zg?=
 =?iso-8859-1?Q?roa2DB4BJZZIA+WcdsD9RC5a9VaxpkjixBiXcSQYJGAi7b0ALGu3M7K7iD?=
 =?iso-8859-1?Q?g4GKII256zJ+tNi7HMbtjfnZNpJPp0S2GCt6rw82Tovnl62qr/DO3M12ba?=
 =?iso-8859-1?Q?dN40RI+Nl+V0uU3yvBjp4LFfvgjsV6LS/p4w7rYOiMumw7jddV2K6Ga2fK?=
 =?iso-8859-1?Q?B82nvSiUj4y0MNYqC3IpXN6rU/cddikswBRsXLA4SoNmmsBektgpd2gQT6?=
 =?iso-8859-1?Q?HB+Q/fWtjxvL0p3x8y5Dc4jHZ3MwE4Tw/MmZtcZSSYTwpG+Y8/92PhXZZY?=
 =?iso-8859-1?Q?mZCc2lv2AWdWejC80M3r+S367q/MXx1t3Kw3sVVnecO1UFGyUEYDDrUy05?=
 =?iso-8859-1?Q?ohdXmkE3mA3EQ/GyYXXMKPiFTFgf6eQ1u2joZr41grbFdo8Dnt+gsNvi+D?=
 =?iso-8859-1?Q?T4hPXSLEHrYMYIBGbjngDQ9QUPVRmnf4A3KNsRau75yyOiT1kD3kOt29Oa?=
 =?iso-8859-1?Q?F+2eRcI32Pi1CbF7pTFt43b+MtTjO0445OM8czOKwQII76kXOxV7ahtWyE?=
 =?iso-8859-1?Q?jv0HfieO+9TCM/4b2oHR3VOCWhkwFFEebYpTsh2kCMKG9uGKmrXMjHD4+R?=
 =?iso-8859-1?Q?cVf1G+1RkP2pk+DqRanXoa0jaoPyt2XJbV3SXhgNVK3TsD6tfZMCk2dsAh?=
 =?iso-8859-1?Q?0ixy67VW1tyTXyHYwTiMymw+OTxSQnio3jyRyyTK19izl9Zpe5dOEWItE6?=
 =?iso-8859-1?Q?rFsblXY9eYnvnyVDwWMKqwSGx0KRGKgDj/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 515dfee8-f99a-4cd6-8d78-08da60176168
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 12:51:16.4696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7eW1SNYlBK/xM52dyTaLNlxksvSftJnyUZZt1F3a18IjJxLORf2dJawsNZ+iwA8l24zEW5x63l5mnneY8BRBFQ==
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
separately the 'watchdog' child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/arm/freescale/fsl,scu.txt        | 15 --------
 .../bindings/watchdog/fsl,scu-wdt.yaml        | 34 +++++++++++++++++++
 2 files changed, 34 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/fsl,scu-wdt.yaml

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index 03f927a33281..e1cc72741f1f 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -62,16 +62,6 @@ i.MX SCU Client Device Node:
 
 Client nodes are maintained as children of the relevant IMX-SCU device node.
 
-Watchdog bindings based on SCU Message Protocol
-------------------------------------------------------------
-
-Required properties:
-- compatible: should be:
-              "fsl,imx8qxp-sc-wdt"
-              followed by "fsl,imx-sc-wdt";
-Optional properties:
-- timeout-sec: contains the watchdog timeout in seconds.
-
 Example (imx8qxp):
 -------------
 aliases {
@@ -98,11 +88,6 @@ firmware {
 			  &lsio_mu1 1 2
 			  &lsio_mu1 1 3
 			  &lsio_mu1 3 3>;
-
-		watchdog {
-			compatible = "fsl,imx8qxp-sc-wdt", "fsl,imx-sc-wdt";
-			timeout-sec = <60>;
-		};
 	};
 };
 
diff --git a/Documentation/devicetree/bindings/watchdog/fsl,scu-wdt.yaml b/Documentation/devicetree/bindings/watchdog/fsl,scu-wdt.yaml
new file mode 100644
index 000000000000..f84c45d687d7
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/fsl,scu-wdt.yaml
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/fsl,scu-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX SCU Client Device Node - Watchdog bindings based on SCU Message Protocol
+
+maintainers:
+  - Dong Aisheng <aisheng.dong@nxp.com>
+
+description: i.MX SCU Client Device Node
+  Client nodes are maintained as children of the relevant IMX-SCU device node.
+
+allOf:
+  - $ref: watchdog.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: fsl,imx8qxp-sc-wdt
+      - const: fsl,imx-sc-wdt
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    watchdog {
+        compatible = "fsl,imx8qxp-sc-wdt", "fsl,imx-sc-wdt";
+        timeout-sec = <60>;
+    };
-- 
2.25.1

