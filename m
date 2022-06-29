Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D08560629
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiF2QpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiF2QpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:45:06 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2074.outbound.protection.outlook.com [40.107.20.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91DE35A91;
        Wed, 29 Jun 2022 09:45:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLlxyCHQfF6ckmlRLEqrvzxk0Z42hiXmcKK5cj7hNJ68qnNXidDNIs/9aN4ScN6AwVQQTvijzsSF+DofFt8nJLk7seyJiUBPEiiKif+udpVFQUoSJa5gZYyQxfOerwGqlIpOQPHVCAf93KU07ODAJyXjskoi5ZpCR2ANC8bEiQZOqmon3CGC2b0ACuk2M2btOhQo8K/Mznesf4je2XC6p5MYzD63MS95cofs9FuLkax7ICsBEmv0dUe2sGd1pljszLjZpxyOSzhr9PMZjUN+vQtEDHAP6JXlXzLjyvhUzU3D1fza94hFi9B895+qw5WHaMnrv8TujFhjQQ+NOtzyFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9lU+THDBpsKJrvH7/bXgOUMsWpcMtO6asHDeRFpGk8Q=;
 b=BoE3VtxQhFebhZxB06Si7iRfy4liH0ZTc0Fo6EFu05ufw95EingdVJJZyCtCiZ/dNb0VUQNW7N6r3N7upYPgS3DPjJQphK2QstURknzDZaQwHCoAGuLAC+cqzgh0W9YqvemyUXvoN7SnllG5GXrC2P4fbzXUFN64hB9DR9VjvnoVgpuljwwljg6nT5+IWhFtQgv1+Yx42Mvl5FW6vb1+8HXiacvcJ9BCH6+LijGtOkadHBr1dRLnluAowxUzioJK2ZUuFbyIJ6kMs5GJ4Jp4oOY9wNkLHyxmhjR8WbBM4uYAiQFM+dKJdPQmuQq+cW/QvTTtWe9FIDDaKLtM3rW60A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lU+THDBpsKJrvH7/bXgOUMsWpcMtO6asHDeRFpGk8Q=;
 b=V2ngEMSLDEHjemnjNLUppINYj/x3HZXgsmJNam2IkLd0Td47Y0xIvyFyNo04R4sEUVv/cTe+rZp2gPvUiwZDIN8NQA0EE1cmsO/5ZJRk8BOu29ICGpR8jt7Z1ymAUvGxIOBeq9dFTq6TGq8/DfqC91IbeN5RKqiqAHhZ0jNUW3A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AM0PR04MB6401.eurprd04.prod.outlook.com (2603:10a6:208:172::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 16:45:03 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 16:45:03 +0000
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
Subject: [PATCH v6 02/14] dt-bindings: pinctrl: imx: Add fsl,scu-iomux yaml file
Date:   Wed, 29 Jun 2022 19:44:02 +0300
Message-Id: <20220629164414.301813-3-viorel.suman@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c9f10556-1a7c-45e4-6f2f-08da59eeb6a8
X-MS-TrafficTypeDiagnostic: AM0PR04MB6401:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RnC0//F0bplYlCy75fXC/VvrXqlRlU5y8d/2apKYvDVDW2kYDciUpJmiXBefv+fTd4I+skf/466YysrumxLSWZzfZov0rgkcGzRCULfurXvOUpFZvKofGioOZ7aHVpYjFTwuOetoKakO5uhTnkSyjgP5WfB3gLcTiDpqzhUNUT2/ryPOcmthNGrHvcbOWeHZk+IwvTwMsqmfPs68RYmJ/BFriGvMY3wEubNWXp8W/s9h670QYo5ZiqzHth8imfMxqajKHlZtLdyKzJ9lfTMdkb2yeeYys8PhY60U/M0rZFru0oPXS63p9ahFj1ZMRsOyBGDCZohOBQLs6YndL4EGYcHvPK2K2feZrZUYopU3azOMOmXE9w4N9zIeqBIzU+pKUWa0wBDuzG/MyXkJiy+c3iYmtCDDNKnyuXvJLRxQtJe64OcHkqzQuoAXmKorLjorax4OGabdWPwkN08lnOEbbbfTDG70vDGXnWpd7HWVa4ZtWPPmvSj0nB7rTkt0BzWhx5160np+xIoHPah2uT4Re1zZYEqvEYuRi2xjXsVZ5oIKwzTkh+LhxG7HLvme2TuBU6cJipK7lETxcYkX6XCYDHF+wsWPUrjuzcfMjwkojwPIA0799O8h0lFJ5KXCuIOB221lUnNtyFKHukFO+49GD0Igh7Q0YD0pVEMkOPTDo4cFQc2x4eVMV5IA+2B+8WCpaLMbGK4gTLitw/nsRLvur8HSNdKdfjwnqB4OR1wZ4t8je6MIfX9Dyf5AGvDMa4dW26VSG6xadP9QWqyL97MSk7vQdQh8yCcT+zewPZsdGaiEl9Vg1YeQqIdZRO8UXBmWqf1oPslPfYuiWoF402BHy03FqTaJ8rAljNVLHvFrgVek5TR/9sh8qVissagQ44Qa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(5660300002)(7416002)(38350700002)(110136005)(38100700002)(8936002)(316002)(2906002)(66946007)(66556008)(66476007)(52116002)(7406005)(8676002)(921005)(83380400001)(6512007)(26005)(6506007)(186003)(2616005)(478600001)(966005)(1076003)(6486002)(41300700001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?pQJeIdHlB0HG5RBy8sfFMOZ+ZAsFcFUR42pninzrZ5+kTQJ8jNVQbynYuD?=
 =?iso-8859-1?Q?FiuxFDaVkXX0UKQ07LYarHfXmdgB4QfXSZD+MsHIgOFKZcGubccaOopTNK?=
 =?iso-8859-1?Q?Q1WBu//7VAmzRD7b6KCFWFN4p7pCk2q+vp/Rh6gFV2zBDQ3cgdkoy+HNoz?=
 =?iso-8859-1?Q?fv0JXyAKd3dtqmhH6SW+7Bols9tFpCcs/i447Crk/DwheeHzd/hQDCmkdM?=
 =?iso-8859-1?Q?rYtipp8EBIcIhggWNdimC+LocfkU7o2zXPJxwTUQm4H8+hhCdNd774tAeY?=
 =?iso-8859-1?Q?dEsPX/2gr6uGy3c6Yem2DBDKG93jy/KB6W5q2IIToSrpn3sU31TOXd4hMF?=
 =?iso-8859-1?Q?NRf4ywRklAmoJZXKpl3Ub19pI5HZyF+mM7l7torUkf2+9suSw47tpTLkso?=
 =?iso-8859-1?Q?keiJDCkxOC2Amqf2yoTsK8yKR7HBsBnntwvHAIwaEEepK8jrWk68FZ0Tis?=
 =?iso-8859-1?Q?Fazr/j12SyX7YjdN2F6WaTv4+8LE2VHhgsGt1lD7qNW/Qaba9EippKLa6S?=
 =?iso-8859-1?Q?i7GIcD8k/LP1kHrAOx/c772YvnbC3UrRqGr/4/R7k6tYyJc7h1+moOtnv+?=
 =?iso-8859-1?Q?ymknRBX3mBXU9zgmWfL+kf+Ej4MCg9U6wSv8GOKBb557zCs5CE8K7v4HKw?=
 =?iso-8859-1?Q?u0ZycCTqpZxSbXwqAI6Z71Q0CDAZ44ctzls+2pmshbgTVAg3SXJLwA4dwr?=
 =?iso-8859-1?Q?PfamJkjIhp6vgXXR7xnMPZSR0U8XoN8BusCqmRerBuUFzRXfcnzjd+Plbv?=
 =?iso-8859-1?Q?HgkqBJkZM/95DA2bwhTJ+MFCKAs9gArtylDURa2460G26B15QEv98s//kz?=
 =?iso-8859-1?Q?M/e58QkfX3UmSctFlamKqmFGyEI49uPtBIIl8KuloQ59RtNsNH1mVnB8Ow?=
 =?iso-8859-1?Q?RBoILLT7vOuuXNOBnzyNm9v8UOq1FgSQ5cSwlU1KNIQNWoHznz3vALoZ0S?=
 =?iso-8859-1?Q?atEhmHqjxmWV3FRKMHtk2dyMTj/NTa/MURBWVUwY8caDerJ3EV919FNC2/?=
 =?iso-8859-1?Q?0DQ/q2ABmZCYr/eoO7vy/FXOWX9wofncQgcHZtBtnLPJyP77M+NKQx2WJC?=
 =?iso-8859-1?Q?EdduI2kT8SvHV+A6kolQr7vWLqBUimj8EgqbtFLiUQ1uVO9ro60EuJe438?=
 =?iso-8859-1?Q?MIlPRNIKyN0LIC4k/EJHIqbHEx0nKOxAtcRj9pyNz87HfcWEWGDCWvr/kb?=
 =?iso-8859-1?Q?jxDsqGhgaiutTqoBgP8wNEG9P2yHr1Qnq/Ivr8rixXq14hj8ha31whTp63?=
 =?iso-8859-1?Q?rWySc6Niz2UaCaC72gAdklDn28aLhmTdshMF4sgnyxto+S95L5ozJ2xt5S?=
 =?iso-8859-1?Q?vzNxwBz7dDzYW9RrvG3+rbghtKjQn6uC/+Lx9LBP5/oACh7et0gSNOSZsx?=
 =?iso-8859-1?Q?wLcvasuHGxWAA+x4Q4Uxq5NWS6N8DDo0uF1mX8KYSWO3V2Bu2I4wICVFdv?=
 =?iso-8859-1?Q?KsJSz42Bg7FfseBRTUE6DbqHbwGSfA/AW0JW6M9y2p7/OIc+dknpYC8mpz?=
 =?iso-8859-1?Q?htH+Imlk4BhTtnDik/0a7WYMIUV0K79fjFi9EsFw3DOxeKm92r/dGoC+CH?=
 =?iso-8859-1?Q?zKy7I4ulhFyRcwWZXkK3iiiR6Ro6nJtTPcukrsL5dGRfZd6wNgVz1DTFRq?=
 =?iso-8859-1?Q?omKGbqqH/pOsVRJZaleuNgjZYzfQdv5/0d?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f10556-1a7c-45e4-6f2f-08da59eeb6a8
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 16:45:02.9332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pov4ZXrgabKsMwwYpV0n/zHhPWMIS7dZNEJSW9OtNBJFNFzJQC8tayA+OhpkYKYvSl6yFvlXYoXfemu1u4fsiA==
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
separately the 'iomux/pinctrl' child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 .../bindings/pinctrl/fsl,scu-pinctrl.yaml     | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml
new file mode 100644
index 000000000000..76a2e7b28172
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/fsl,scu-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX SCU Client Device Node - Pinctrl bindings based on SCU Message Protocol
+
+maintainers:
+  - Dong Aisheng <aisheng.dong@nxp.com>
+
+description: i.MX SCU Client Device Node
+  Client nodes are maintained as children of the relevant IMX-SCU device node.
+  This binding uses the i.MX common pinctrl binding.
+  (Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt)
+
+allOf:
+  - $ref: "pinctrl.yaml#"
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx8qm-iomuxc
+      - fsl,imx8qxp-iomuxc
+      - fsl,imx8dxl-iomuxc
+
+patternProperties:
+  'grp$':
+    type: object
+    description:
+      Pinctrl node's client devices use subnodes for desired pin configuration.
+      Client device subnodes use below standard properties.
+
+    properties:
+      fsl,pins:
+        description:
+          each entry consists of 3 integers and represents the pin ID, the mux value
+          and config setting for the pin. The first 2 integers - pin_id and mux_val - are
+          specified using a PIN_FUNC_ID macro, which can be found in
+          <include/dt-bindings/pinctrl/pads-imx8qxp.h>. The last integer CONFIG is
+          the pad setting value like pull-up on this pin. Please refer to the
+          appropriate i.MX8 Reference Manual for detailed CONFIG settings.
+        $ref: /schemas/types.yaml#/definitions/uint32-matrix
+
+    required:
+      - fsl,pins
+
+    additionalProperties: false
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/pinctrl/pads-imx8qxp.h>
+
+    pinctrl {
+        compatible = "fsl,imx8qxp-iomuxc";
+
+        pinctrl_lpuart0: lpuart0grp {
+            fsl,pins = <
+                111 0 0x06000020
+                112 0 0x06000020
+            >;
+        };
+    };
-- 
2.25.1

