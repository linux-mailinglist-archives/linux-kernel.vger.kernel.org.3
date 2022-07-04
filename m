Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3CD565B02
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 18:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235019AbiGDQQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 12:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234826AbiGDQQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 12:16:46 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60048.outbound.protection.outlook.com [40.107.6.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DD211A25;
        Mon,  4 Jul 2022 09:16:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VItd2/hK6ijmCjGHVRE+XXKUd9T0gQCJCzYmROIbEzIePQyqQew6HPfwCFQCcaSr6qrQjrAcbuveErce8yYEw/eC0VdyUN8UJmX+f26SWSG13814FfQ2GXcU+3U1GrnWB7sPrZOn86SaYcD6ZHyaFGkBUFKXQi39QCBfJBjCj/Efr+btFdaJHT0e2LgjCGNmS+8M4zifIlBLsyL09T2NLQbfTdaSanzj8DtCk+fwiQnmSSdnV9ZNnjRspZBk0Lk/wfAhp/s33jW2NR5ZdycDYJ/yZXvk7aNbib+ejfqDycGCKv5eN1PCpQ8D9OLFfGGGJzufWnRsd4MHiOY1AFf/FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sMdQHOwDTIsAKgEIOrUlM+jfdc6vmQyGTL4GHeTeTAQ=;
 b=lNCxprKcVrxm7feMTMAjXkTk60Jq8h2XAojn3Q5I2WMPa5BWPFy6X8rx0mKB4kFjY096a1Q24rkiSbhYddEcKdi/KKKbQeLRlYHDagaAQ8tiaLkgVaEDG2o9Wqux8IHQlGDVoYtVXgY5zCYksclCmM9xBhSex0825BPxpKXhnipSzZyuZi5gmQiaPZ1L+SkZRL5e4t3pYC4rLhYezkTwzqhWzes7fjPKBdbfR/JsHZDn5/p2gMTu3T9MKwjD4ppPOAxOpxw0ReztnQgemSXgI4qdlg8De2hseY0NgT+N0C42tOPdWXQn8vcPPUGC7HWMOrJ5O0XYHc574ncbd/7l/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sMdQHOwDTIsAKgEIOrUlM+jfdc6vmQyGTL4GHeTeTAQ=;
 b=FOCB5Jpqqrp3vHp+04TFrRPeZRxeDn0ZBh2yvgNsyfyGAPovPmyvSgYOdLC2K8L10WEKMJtAFZLY/Kos2aNYC2Rv1mENQ4+mSO4+TnvXF7jX3ZhpXvK13nYP31QZ7gTNee04ygkrL81kdtCFQWX3TJsOiTV58QjHvtw2bO/Tu4k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AM6PR04MB6293.eurprd04.prod.outlook.com (2603:10a6:20b:71::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Mon, 4 Jul
 2022 16:16:32 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 16:16:32 +0000
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
        Peng Fan <peng.fan@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Liu Ying <victor.liu@nxp.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Ming Qian <ming.qian@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Viorel Suman <viorel.suman@oss.nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v7 04/15] dt-bindings: nvmem: Add fsl,scu-ocotp yaml file
Date:   Mon,  4 Jul 2022 19:15:30 +0300
Message-Id: <20220704161541.943696-5-viorel.suman@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220704161541.943696-1-viorel.suman@oss.nxp.com>
References: <20220704161541.943696-1-viorel.suman@oss.nxp.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR07CA0008.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::21) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c87f5668-24f7-4e34-8835-08da5dd88eee
X-MS-TrafficTypeDiagnostic: AM6PR04MB6293:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iq1843yb5/Mt/ulkRBaIdsYThrG+FzmCvwQQjPdcKkuS5apzWu7tDbufG3Lgxc/KuGAAUCCjgxOYcTHgoRBhCnk3qsJ35IRaSpSJtsWIaCjmq9SGBaAHXHTBtBN4ofXi012xGF/SozIjolMMX9tInr9/sQc01Kie1u1NyGaq65C/5O3I9hDFRWnMNQEKeC0bh5qoNtbzO8IGnI7CYdxIyOH2BsqxtgeU2Ve5MMwFpKKhk04rjy21XvFTnwT3c9eh8RcFdPviNmIYxhE1fRhpjblN83qv3E+X0cMF5IKowtQ9UUxv/3+CvkFVma9VyvZK8Tcnj+wsEnguw1djbfE2kGGf5RfiwRPRkzc20s2sy+E29NPdiwKEk7cdXHMyfSZRZf3Vi2AqkM+AWTv4KuMxEYLBzcle5WVQHODrABkHSGqjPw7ba5DII0GLYF33/JGQsULhdBVfVZzju2caZuJN2K36T7aV4FHUxqLpeE3jNYqX1zQCRbY3dcVejWAjwwA7o2O8A+cSBCVfSuYPZYrc6AbU3NB47m7cPiW/3rHnRPQwrW+rd0Yd6BJpuRCIgdLprJK2ggROZuYqFZu3jx1gToqTeqF3h4wiiOVmPj6Ea3WgpubtZXpJld651Rs80m9uDsPDXkPfYuR0sM00Plkte0Ve4L+g1v8bjxDABHyV3bM4zZnSisOz5BoVqPlAX9rE/BEGJagUrgQpAt4ZU0u5RZOKtZ1swsR1R5kAT8Aez/emCCpw9wSp6hGfXpRcWb0LgtFky78PJCnD158wc+pLB3Sd9POOAplJbbuVB8NCaNxp7mbdS7cODbQ4oYRU9wqPrcqy4K+SYIY4gQu8G31RzrmHgodC3wvCGTX5Qcsgoi4rn51I7SP+Nwaqn19YDCMJXIfaOvjNLb9hrO/N5f05Pw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(2616005)(186003)(1076003)(38100700002)(38350700002)(54906003)(110136005)(66476007)(66946007)(8676002)(4326008)(83380400001)(66556008)(316002)(86362001)(5660300002)(6512007)(7416002)(7406005)(6486002)(966005)(478600001)(8936002)(26005)(6506007)(41300700001)(2906002)(921005)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?MpN5P03laLN+0lQ0K8uxxOLYFX3PtnwJCUCujpuWNytmWv3eo1gURIyOj0?=
 =?iso-8859-1?Q?gQOsmw10RODDvpkpqqZxJVuVts3JK4k3g1o+i7uaEXYoiMVNX2/Yw7+G5b?=
 =?iso-8859-1?Q?xwJjcjZRByK4A0A0tqYXpzQbSrddr/2EDVqPiT+PLYkFlwoaLTtaieW/ws?=
 =?iso-8859-1?Q?GI8yhT7fDxsJV33oaapUe0Ft02nEabWiExgiRQjOIzhfkZ0yV7hwv1rph5?=
 =?iso-8859-1?Q?CujdWd/LiyNydqfj/s3N6XXwkB66GjUx/BnB7QVp3soF8Vu8IYVcdZsZiX?=
 =?iso-8859-1?Q?uh4o11Vf/Wf4w161lv9ViJG26TOr61jBO6OhouXnMtfvh5fGPsL2VoN+8k?=
 =?iso-8859-1?Q?AvGi3EeBzbCwtdGs0+aiEvlhK+3ZUqwZhL5GH3KKgmygGnNlLvaEzCdZjT?=
 =?iso-8859-1?Q?eBf92SV2b+MkUysncjnFjXDtJEFmpW22lF/zldLeGm69FX2T8bkOD6vz02?=
 =?iso-8859-1?Q?VIrgr5YT62XYgPUzepp+95RTL2AbWxLxxTRNcoLIlYSbRr+SGhZrRZkcNa?=
 =?iso-8859-1?Q?IQeCJKHNFoX4TJrjCeUGN7DPGVl30iRosFmu0pXF3dap9fAIA9z6j1YKae?=
 =?iso-8859-1?Q?qJED+zcFrtxxPOrQeWVMpmHDBl65IiTnDMHZpKCXO29FZwaZPRIeTfxW4A?=
 =?iso-8859-1?Q?UgaOtPfKhhMRoBwYy0unrGx6UficgHuYaRdNUIZMd7TA50cvdGzesx8KMk?=
 =?iso-8859-1?Q?St+KKGG/KS6zcU4wv2P+g+jie9zPH0kZIB7CTlVG/ROg9c0vkexljJgC8l?=
 =?iso-8859-1?Q?yD1giZNkNqxJYGyg4LrtBfFO4vOZ5L/IvnhY9+Wucd/s8grwl3dJmTYpO3?=
 =?iso-8859-1?Q?RpS8X7tZaKhQHUqlArBcxaGyn7Yg2Yi7z7jkuJfEO4FiZeEvXPfvjMUUUS?=
 =?iso-8859-1?Q?DlkjUDMrjj1VFObtOx0buQd1nmxkfRj1puMx32oEuMfvZNAt2WvJ+doBCm?=
 =?iso-8859-1?Q?pTw5Y68r2JqAm6GtT651wDnfPyumGdyLcgD9BksZ7tPTpUNaEVJrJ0Fmp6?=
 =?iso-8859-1?Q?8ILbLvvZcC1pq9B9YYj7/FXzXTWnc9I5iojZofxP/0BqkGbGtIeUw0EuH+?=
 =?iso-8859-1?Q?L9MDKrBAmG/rZVedFdpD+GYSxgvsY1VBEGY+qLEAIoIQhpUz04TBuWPV7Z?=
 =?iso-8859-1?Q?8LkQ25d3X2X7XkuM86TMqyaGuuxjz1ncxSM3ryfigk/dze8DuQCl/yU0b7?=
 =?iso-8859-1?Q?vbUB41qGSd1k7l5p7hZeeIIQlzldJ/RxAnIzJaQaL8m4W5oG31BoBJjXTQ?=
 =?iso-8859-1?Q?Z0he+uFml+nmy6lE9G/zKgt66El0gl8mIYwbdepIb6J6o4AJz5jKpu5X7b?=
 =?iso-8859-1?Q?hY+iDBerkzstdZQ8f3F00bqM0gajOjgyDzzY7Qh9Rz6RhsdFVRf6t0MT8t?=
 =?iso-8859-1?Q?tfDGozkLcO1L2McJ5NvaTaBW09NXyvh5Y1+/6rtqD0on56N5Rth7SUeRVE?=
 =?iso-8859-1?Q?n4GdZBqRVHhcwRz2F5OynS3g0hktrxSvwtaEjBHW0GL/O3QiSekzeQs9PS?=
 =?iso-8859-1?Q?GUt7sNUh9DRM3pYNscm3DslebFKiLA3g24FPjcdtp9sVsDx/G9ledgce5r?=
 =?iso-8859-1?Q?chyyWQukV8SIxwk9vFvJgH2Pj1OiXGE1+7jF6l9CRss3vy4Fr9AXgEI1ii?=
 =?iso-8859-1?Q?+simJ4DhyP0xEA7lWoz73hSC8HIGATl/Pg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c87f5668-24f7-4e34-8835-08da5dd88eee
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 16:16:32.2881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qvq9+KW78c+umiP87jGICVldaKVjsO96TbuSetnVhNrN+387Z7xKWuUklukoFRFLAITmZCtukaQMxC2dYfjuNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6293
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
separately the 'ocotp' child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 .../bindings/arm/freescale/fsl,scu.txt        | 24 --------
 .../bindings/nvmem/fsl,scu-ocotp.yaml         | 56 +++++++++++++++++++
 2 files changed, 56 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/fsl,scu-ocotp.yaml

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index 572cb2e628bf..0841ad8bbd22 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -87,20 +87,6 @@ RTC bindings based on SCU Message Protocol
 Required properties:
 - compatible: should be "fsl,imx8qxp-sc-rtc";
 
-OCOTP bindings based on SCU Message Protocol
-------------------------------------------------------------
-Required properties:
-- compatible:		Should be one of:
-			"fsl,imx8qm-scu-ocotp",
-			"fsl,imx8qxp-scu-ocotp".
-- #address-cells:	Must be 1. Contains byte index
-- #size-cells:		Must be 1. Contains byte length
-
-Optional Child nodes:
-
-- Data cells of ocotp:
-  Detailed bindings are described in bindings/nvmem/nvmem.txt
-
 Watchdog bindings based on SCU Message Protocol
 ------------------------------------------------------------
 
@@ -149,16 +135,6 @@ firmware {
 			  &lsio_mu1 1 3
 			  &lsio_mu1 3 3>;
 
-		ocotp: imx8qx-ocotp {
-			compatible = "fsl,imx8qxp-scu-ocotp";
-			#address-cells = <1>;
-			#size-cells = <1>;
-
-			fec_mac0: mac@2c4 {
-				reg = <0x2c4 8>;
-			};
-		};
-
 		pd: imx8qx-pd {
 			compatible = "fsl,imx8qxp-scu-pd", "fsl,scu-pd";
 			#power-domain-cells = <1>;
diff --git a/Documentation/devicetree/bindings/nvmem/fsl,scu-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/fsl,scu-ocotp.yaml
new file mode 100644
index 000000000000..682688299b26
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/fsl,scu-ocotp.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/fsl,scu-ocotp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX SCU Client Device Node - OCOTP bindings based on SCU Message Protocol
+
+maintainers:
+  - Dong Aisheng <aisheng.dong@nxp.com>
+
+description: i.MX SCU Client Device Node
+  Client nodes are maintained as children of the relevant IMX-SCU device node.
+
+allOf:
+  - $ref: nvmem.yaml#
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx8qm-scu-ocotp
+      - fsl,imx8qxp-scu-ocotp
+
+patternProperties:
+  '^mac@[0-9a-f]*$':
+    type: object
+    description:
+      MAC address.
+
+    properties:
+      reg:
+        description:
+          Byte offset within OCOTP where the MAC address is stored
+        maxItems: 1
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    ocotp {
+        compatible = "fsl,imx8qxp-scu-ocotp";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        fec_mac0: mac@2c4 {
+            reg = <0x2c4 6>;
+        };
+    };
-- 
2.25.1

