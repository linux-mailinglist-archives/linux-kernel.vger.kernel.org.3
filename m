Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9DE56A2B9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 14:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235639AbiGGMvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 08:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235163AbiGGMvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 08:51:05 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2078.outbound.protection.outlook.com [40.107.21.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2262B639;
        Thu,  7 Jul 2022 05:51:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahCb+nelweNfoF1kOwl/P0outH43uwlXtGksnFJzm7dzb6B02g0TI3w50ZjYfPuQ+r5nUDAGtegmWCUfaOAffU5V0q48VnJvsFduk30nZCi0wpHzspen+eEn6Ug1if6KO8zryFzLL/LiLYEGPdl8qaNtwbxud5pfxFbE/t0MyRy9QN1XeTVWwxjgUsk+AMZfvnX8HnlldwsyYhrmttJt32VvJSe1oZ+wTbxfNxKIxKQMwx/h0rZq5G5t95EbUggvPYhT1rL+klCbbe1wu+//O0GNDM4brOkKcfMHVFjGsudmEWgAxyodHrQWZ3fTuHDzZPmz6rnMfPcokF0WBnenvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+chh9o4nIrSqxcuuLON4gUKhTkPGphmx8ispHNGmT04=;
 b=S9cHNiNQz96H2LdTneW3JJmrh3uPj8nFTV+GnOhjLNKPjdr4v4H913x2KpE7lZI9Q0YWzwcJlh+9/EEGy5jjRqv7oxoonJ3SM73i6CQSEa0sdyftsOtSTITzYA+EUx116Z8Ju79wF3qauWNbqYVFftBekcnGutcJL8/BqID+RmKMsslYiXEfLJp5NGm3Lp9LaQ8c5lc3wReu4Es19et/CdAiI5VeW58FljVuawHFGP1aixUyWRLASqm4mYjXTf6KRQd7CtMKJs5zwmZAs1HEq7pjwgIFuu5PfLf0MgCxzNthymTVxrx/v0K6WwP83ps9d323UFIMR+v/EFGjGdlA+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+chh9o4nIrSqxcuuLON4gUKhTkPGphmx8ispHNGmT04=;
 b=KNbgKOnGXVIWRfudOi3pfzMTtLuAqlp1Q58GHys1iTbQ/SpwP4//xuF29BFn5QdtOaDQLzeUX+gct9uT0VEta6bmUKI0etfDwMaPM+uz7VQr2ByKfXE+B0ELju4XgkXWGakYMt2rGrKF1C8f+eQoVrB0l3U7Z2oeM2BQjTW3YIk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AM0PR04MB6418.eurprd04.prod.outlook.com (2603:10a6:208:169::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 12:51:01 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 12:51:01 +0000
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
Subject: [PATCH v8 03/15] dt-bindings: input: Add fsl,scu-key yaml file
Date:   Thu,  7 Jul 2022 15:50:10 +0300
Message-Id: <20220707125022.1156498-4-viorel.suman@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6882d1a2-0e07-4077-138c-08da60175822
X-MS-TrafficTypeDiagnostic: AM0PR04MB6418:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kDfV/swYiYjqpvlYQfRMYnDHfnee5TUG9TB/KRWuavtNe5ukZBVdg86iDOsiRSXI3OjbN9jM3Q3SaQZLJl9NgXK1m4lcZimkUmJQx2b01Jp9dCcx8nGasYUwHAenzYsQpPJuycE1/gAxIt117/2mIb33+3g5uZL94Thvi4mPd78AgkoWI2RbhckldW7YC9lkE+HRFu7uEDN77vPla3TPoxv4cPb+Fv/T+lSJuNVz2G/0sRxRXdL3bwsucqTRZzxZ8g3zOSFLFjpw3Wbbyw93A1JoTdcwVGy7HQzBtqwcINbP5Kd4lpm1DII+9rl/pwS5YskJGt5/k2ijJd8uZct8ltoGHy7ZEqD3yz4gEAoTMzw2T9eiMA/5heaSBNnSFyWm8MCU9JW5gC8+7oAko6wXHTJ7Ozrv1LBicK+qQputoSHx4CPFUrzHTqhicR7wbNeMJ11Peaxnx+gtGBrKdYb2gR/+wryJ3DIBVtgygWjYO1FcDBEecYQFrPKLGQtQlCeH2A/dBuDndo2WePyIVYcDdZxTbMmc6ytN+ZtZKCJbi3y0cNu7PHWv3LydDAiH3jPlmbxR2enFo8ZlOoqqXucbww9xda9PhiC4Agv7+Qowdt8X5Lif+FujmBDIzJdJDoe19f4L47T+YcNnWEXICSk7n+bEhJgsCNOYifZifElZp/NevBbkHzGSE4qNkMbObv0vU8ffx2nf9ap/6fqI0SiYTBc/OcH3+avdLgvK3eyzG1P25pNCbqZvs+PYpdQf0tJUpQthXOUs0ObErxr9EWVmW9MyXSEJeqWJI5XbRW39LiBQ5norU0HoasT1GHyiK6KXAh4+s8jXDm6PLB/YGJ3LnHaEmCg2x1J0anjCQ9TI3VkZjFW5ANwrWNA0VDdMdeBMPAF4BFni3DYowZnkVzBBgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(6666004)(86362001)(5660300002)(966005)(38350700002)(6486002)(316002)(38100700002)(2906002)(41300700001)(7416002)(478600001)(921005)(7406005)(66946007)(66476007)(6512007)(66556008)(8676002)(4326008)(8936002)(186003)(52116002)(83380400001)(26005)(110136005)(2616005)(6506007)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?/SCKZgUHtbn2bqTAukmv+M9rAfeMR65+60G5Z37jSTX2/Ihj+NIK0lK5+z?=
 =?iso-8859-1?Q?VGsomzu5+z/QuH58zGUo8kCmlGRmdlHyRlpJAmyQ1Jo4jkCLRFM8E9qSLU?=
 =?iso-8859-1?Q?Ahb8zOXpg5DXsc4RuYskJ1QgsrvCwSXLrJFf1W9X36RYM7h0i7ZrvTWlkU?=
 =?iso-8859-1?Q?2DFs+Ak+LeNUA6dNZhahu6rxcS056BwzqDt+DCibt7cAlkEsJn7w5Ytu8n?=
 =?iso-8859-1?Q?BuaXqiYvFyqgxSc+c1ppHYSdUO9ELj/7kp7+4otCkti3J70HOrlHTnXFKZ?=
 =?iso-8859-1?Q?HwcA1RGuWUET/pWT4NLXqa2NCHlqyTUYFScJITNpguuEpA3pXhTCrmklEL?=
 =?iso-8859-1?Q?yHEW6FzwwBmeG/qahYPS4zA11o2vk3ubIa9WFnChOLH9K61S6CgclUAR4E?=
 =?iso-8859-1?Q?UJUbDEIlqrqfL8gFjAufe3KRoqh7z5tp0JS2NqQUeLJc72jP+VNCLcU0Ky?=
 =?iso-8859-1?Q?gwUnJRCCHtIxYGsgquuuGsGvgFaVAl2t5zu59fS+nO6T8JIfeI/lvn0o1S?=
 =?iso-8859-1?Q?G1CtaL+1ylFZfP3m/cn1OIdSGMIR1cv1lvsW2C4fgCNtrtUdt1ArzzREo0?=
 =?iso-8859-1?Q?19eZI6YHEp818zTZOKY8xRpXV6maLmm5ysIU3hMF0qB3KdyLeQBeLIeqjm?=
 =?iso-8859-1?Q?9IAJugsHR4XZ3FPNL+YSI7HpnaYHIRpqYmqZdLjqwnPg8Mi6jKIxSPb8OL?=
 =?iso-8859-1?Q?bwS29HI8iqa8ApxMiRYY2cgu1Tyqy81fovz1/6HqJLE0BSRSyMChsZ+u6q?=
 =?iso-8859-1?Q?+zY35ul5fD44CGejoZ5myxUGlG1tKQeAT8kvKYrvAsk5V9aJwrl7noADLV?=
 =?iso-8859-1?Q?HUbHc0ZQJD07PnVrDxG8poHeoLvbiTJJWruq2Oe81pYrW+DsL/Va86kntQ?=
 =?iso-8859-1?Q?cMvjQMgg+2BigvD5JMNDtY/F0q+eN/herbitoMVa96mcvcsj35FRP++cXt?=
 =?iso-8859-1?Q?vWeVDlVysw74jgQaRwOhakbHVIpoWe+ICA+kZauZeiA63FCM17fX6tH5yC?=
 =?iso-8859-1?Q?K/R1pUApWsvyi2jbi223gjDTb5B9HHSMhGC6uluA1qjbYaQv65HDaVjOPl?=
 =?iso-8859-1?Q?CcSAYPsCGk6A3KFThLoJdy22aSsVOrCTRrEBl1AfW2g5CgzwXMC8WBuGEy?=
 =?iso-8859-1?Q?ida8GaFpG0CIayLQmPgGDxVtNjQkEGDZkEr9nkMKoo5eQYlaogIHIdQKmG?=
 =?iso-8859-1?Q?f2URMEu/NGCVnQcH52qwNAlJL5BNn/7d9wFtm+1j6+R2WfBUNMJi+/ukPR?=
 =?iso-8859-1?Q?S3rJG81Jy9fpfTDE8MhvlScr2D+F3/eU4AUGNuL60ENTcfuCRFlMhfnzfl?=
 =?iso-8859-1?Q?EcW7/sp0dlf1AXDDcetzRui6L3tCvb1SWHs/Z+UqZSDHpiiCdGmcX4PE0V?=
 =?iso-8859-1?Q?3xx+jZHjNktFTKWzoWubAT8yJyXQrojgxN3tZR5rkeMyLToTmXdcJhO9wN?=
 =?iso-8859-1?Q?ODgzinBBejvJtvr1hSSyHMj49qzDffBjZmS4x/CKy6Oeanjwrep21mhEEr?=
 =?iso-8859-1?Q?24hl2dNCpXA0xF4tBnLI4eu4euCxvtjeuB+q9TZKTaO7IOdv+kUjbrTUBa?=
 =?iso-8859-1?Q?qV/sotKYl6YBRCo4wNVERjpuz4o5CGjX8lXSapGcJDfNNbY+NBZluWmmwK?=
 =?iso-8859-1?Q?tP1xg0xCTO+WLT66xypgrU9mwyus3LcDCB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6882d1a2-0e07-4077-138c-08da60175822
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 12:51:01.0176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zc5q891Qs3psbmrhTaf8ivJgswU4AKDfZ40B30jPNYcsKTNku6P4HNsDA8LDOyUYFTU5HsGu7Oi5RUh9Xrr2gQ==
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
separately the 'keys' child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/arm/freescale/fsl,scu.txt        | 14 -------
 .../bindings/input/fsl,scu-key.yaml           | 40 +++++++++++++++++++
 2 files changed, 40 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/fsl,scu-key.yaml

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index 5ec2a031194e..572cb2e628bf 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -111,15 +111,6 @@ Required properties:
 Optional properties:
 - timeout-sec: contains the watchdog timeout in seconds.
 
-SCU key bindings based on SCU Message Protocol
-------------------------------------------------------------
-
-Required properties:
-- compatible: should be:
-              "fsl,imx8qxp-sc-key"
-              followed by "fsl,imx-sc-key";
-- linux,keycodes: See Documentation/devicetree/bindings/input/input.yaml
-
 Thermal bindings based on SCU Message Protocol
 ------------------------------------------------------------
 
@@ -177,11 +168,6 @@ firmware {
 			compatible = "fsl,imx8qxp-sc-rtc";
 		};
 
-		scu_key: scu-key {
-			compatible = "fsl,imx8qxp-sc-key", "fsl,imx-sc-key";
-			linux,keycodes = <KEY_POWER>;
-		};
-
 		watchdog {
 			compatible = "fsl,imx8qxp-sc-wdt", "fsl,imx-sc-wdt";
 			timeout-sec = <60>;
diff --git a/Documentation/devicetree/bindings/input/fsl,scu-key.yaml b/Documentation/devicetree/bindings/input/fsl,scu-key.yaml
new file mode 100644
index 000000000000..e6266d188266
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
+  - $ref: input.yaml#
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

