Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7EC54C6C8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352667AbiFOLA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348846AbiFOK7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:59:34 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2068.outbound.protection.outlook.com [40.107.20.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A89751E6C;
        Wed, 15 Jun 2022 03:59:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hR1yJ0f/9aYv9w4ByImzWdOHd+BidJrNhirm0HH2HuUe1p8qIlzrRKZkyI+C2UiEIZ9/5/TauQ9k+GEwY28jZNizUUNpLq9PkTi/tQloIlP1oT7Ef3KXWLWr8nOEQBWGg8pxAbfaaSimot5M0sexUCpFqYwnOk7dBsxJcGy8awX2b86NDEciTyXpvR9qAJF/T56dd8I57HiHtsckBkcAeeO1vj5hcltu6Lef+DfiAILLKLkmYxhYD5/KaUbstCB3EptzoNpMjT339Hq6MpN5zu+NqYAxaYTZUxtA6sWqKdYiKQ942ldcc5KSj13PPb+qUM7FgwK0aKBUJ44MZNiQiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yciRjK5VMs5kFQp/Ck94eaQI0MASYSaCfcj294nfsBE=;
 b=hKleI/3iX1xo40yG6vn1WUcn8zl+g8OBO1k0qphncAqb/u+1UrejOKsfFdeRHboK2tGpHdaSfmMJ8B4h/BC/TGmXSJInYfjVneB2yaDvU7X341Wecal1pT/ycgUuYl5IX7eVqH1XDzqTIi9BjMN5uu4/UKPBOSI8xmRsipTSzdhB9xI2CGYSrkXdRzNhogzTfEYwxbLSXopTOYKZuWeJFxBT56YuLiXOfaS/5IkTF1MHkfBQewlgPxPy8WH67dT1dUOgPKmEVaaMozfroKm/vA+XT/KQDGiiikwWXm0n0F/Nc8TpNYYjXsuU3PFXn/2Nj1Fq8ENBtL7yZtND/gicaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yciRjK5VMs5kFQp/Ck94eaQI0MASYSaCfcj294nfsBE=;
 b=FgYyti6IbGTnahcLSaZb1x8JcUIbzRAC2rcDGp0sUf8rdDWn3Dq39szi2S1AzrOVwhAkCo39x0nEr1m9zQ44ew1cTKncYJzjL7MALWLIH2uFah436VM6YahHKLIRLWAOCjXSQK/H2UMcB0mMQc1FmgYVzf1J2eZjm2AfieyN0F4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by DB3PR0402MB3948.eurprd04.prod.outlook.com (2603:10a6:8:d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.17; Wed, 15 Jun
 2022 10:59:27 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619%5]) with mapi id 15.20.5332.022; Wed, 15 Jun 2022
 10:59:27 +0000
From:   Viorel Suman <viorel.suman@nxp.com>
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
        Abel Vesa <abel.vesa@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Liu Ying <victor.liu@nxp.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Peng Fan <peng.fan@nxp.com>, Shijie Qin <shijie.qin@nxp.com>,
        Ming Qian <ming.qian@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     LnxNXP@nxp.com
Subject: [PATCH v4 04/14] dt-bindings: input: Add fsl,scu-key yaml file
Date:   Wed, 15 Jun 2022 13:58:24 +0300
Message-Id: <20220615105834.743045-5-viorel.suman@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220615105834.743045-1-viorel.suman@nxp.com>
References: <20220615105834.743045-1-viorel.suman@nxp.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0159.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::26) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3eab4d66-b01b-407a-22cb-08da4ebe1d4d
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3948:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <DB3PR0402MB3948B89D223AF5742E04BEA792AD9@DB3PR0402MB3948.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LVwpW3CSesNZnw2yYZBcMk1zGYljiFH/FNiWINC1GFiIL/O2MJEbJcg/Av5ZbiXnu/Nq5llZN461s0UcvQu57GssYHA76OcS4URFX6J3vE/IFx9a0FbUzUm1PRMSsMCWYTn4ntoLu8kURpf7madWJGPyEXaB/CntMXKnV1HEuEddZXWvz4k8Spc26ziGW7pDgmyIIcFwW1r83SlsBgu9angCf0ANiok1K6gjAYRtd03/kvdTrOkLgDrpPFCNJF++g559lsP0tJbIAVvN6pxO5XEBraY6hirilVG/QhFZ9QnbNtBlRL541ktxHwOoErlHxHUa5ZykrxQ20zZeGgkC57cr8Nyu/Lzr7cNEY65RL0SC7aFCi+LffLOaFH4E2N6RlIZ0Y3n7/UpEzroRnsmhKGoJXNzlRdjPmVJRcuw8DGCtjmoYCcnaq8I0wcreOOhX9Q4Tmt7Cjryh6sB4MnpxNuBoelp1HwNqpvD5zgw7OvdHZ2fcjtxMdOYbE3gcwRia+D0YJca9UQYOxmnh2VnB/4JcVZUngIqvjH/1GfG9MBneB7IFC9OOMAxQuBM526qXoKXNIWNcD7JqA9CqgwSwGzZTLvFgguficBm/D+pIR9Vy9spP1IiUKJwc2nbC49iWMzLkaeuqyBJvnpzw8f2VykQDPXO8kRTgEzcz5n7XHi4aGq+ouM0bw2Q+oHIBnd4D9Ir46Rlee2k3wppcDvJi347Vcza27+8LXyd6lJwOY8bErn4GhAslS6qI7eWBrbIcqXtieP5bf0d1hAP5x+lXvpSmWJFiJP2h1bzxpvM4OOER4ABE6YEOQrzrXyY4wXZi0m24PEz07q307BRT2S2Cn8oN7KYmrwRnMvagf06emnU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(26005)(52116002)(6512007)(44832011)(7416002)(2616005)(4326008)(6486002)(6666004)(508600001)(186003)(83380400001)(1076003)(8676002)(966005)(6506007)(7406005)(2906002)(38100700002)(38350700002)(66476007)(316002)(66556008)(86362001)(36756003)(66946007)(921005)(8936002)(110136005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?gwlPQpvY4dvbNIZMok1tIWbBEKTnDOUGQgSW73R0xKAAtjaOoQTgpq5iUm?=
 =?iso-8859-1?Q?Ndx5X2dQYDTqQXvLgrEsitXh2v+k7CDpL6W/7QYBrLn8AY1Ljo3zA08UCT?=
 =?iso-8859-1?Q?EW3RSv7D+zBi2ssj9QaIpJXf7aJNRzp2TRCEp6Q3ABSj45IJsp4ejXSyzF?=
 =?iso-8859-1?Q?G0wOetTrynpOCcAQ0RI6R1nddNcKsSt0/AIsBDb7gnM4M91YDoIMtrb0EB?=
 =?iso-8859-1?Q?CtWHO2lHBsvZSoP0a7kT+DRmUQHssPXolw0WB3TC+v8ToJdQT3InxthxtL?=
 =?iso-8859-1?Q?kIobQ9l8WRJO23AzyAFdk1mteB9rRRpIlnh3w6mCLfG1PDc9ArtzRCUXFA?=
 =?iso-8859-1?Q?aHejpHcASbQkiTeotTFQKss1rWSaVaBEJ9i1RHvsWF9ZBGSbdxWo1313Av?=
 =?iso-8859-1?Q?9rlsaJ5AqEsUp8xiACwEfZLdM7iLPshelr4PqZfZ4KFW18vScLq3xcgiCW?=
 =?iso-8859-1?Q?EE7lBvZbeVEeTlUTRYhh+/vKoHQZflovXCrYirZ/nEwzOAlesq9FeWLVSU?=
 =?iso-8859-1?Q?rlJ+UGaaOfpD5p6on1OF69cf4MiEWJ2PqjI0MGVaErAlWsmllz1cm7Ti5E?=
 =?iso-8859-1?Q?nb3NubIaNmXjuzdC1Mx+sFyr0F06p8upDu4GK0L+ls56mN0E9w8mg2rSAX?=
 =?iso-8859-1?Q?sO9K6kZWaPri+MBpRx3AIf9j9BPtWnAnjCwbUoWNTtJ8dipFWYuddP6wiC?=
 =?iso-8859-1?Q?XfnTrOydynqXmEVs1X3q4dxiUq47ToIEdAAdF3cNtRwNkI2tbv4vpSTJHT?=
 =?iso-8859-1?Q?CQFipw13QLW7Ie2CvALXrawhuJmgtBFsIjuPdZuKQVlR+3Aw3AYwxCO5ok?=
 =?iso-8859-1?Q?0xGTlElIVrbkeOzwRiua1yK57EL2qR4WS0OhJQPIonKlTYnJv2BVEPAMBh?=
 =?iso-8859-1?Q?a0QHEIZKLgYonxMTa6//tnSnHiLEV+9QPxksveILRUsQ7cUnAelWWfW9mJ?=
 =?iso-8859-1?Q?+ZwzoEo09rzER6OyARqfQ9Pw9ulokEzQJhWesRen08Kb077N+oArDT7Ok2?=
 =?iso-8859-1?Q?W5xLA5sjP3GCVczCTuUkDeLpQpSx1XNFHjqxqUhsexUoq0kWryHub9zdPv?=
 =?iso-8859-1?Q?CTmgm0F9Q2iJBmAvxx7+dOFLx8/ghrpx77PSyQzI1ICnxX1caU3MdJOU27?=
 =?iso-8859-1?Q?uKnPWgWyBr49odjOyc1k4TPpwsB3Z+txk8Ys1PYGcCcgF133fTzdPbOY/i?=
 =?iso-8859-1?Q?N8QYOSlabOVP4dCJyxcDeIN2uhZwR7zgTjEERQHIlygKj1xIKQb+zB6UqG?=
 =?iso-8859-1?Q?eEOIAWKtYhLnXr+zmqAIQFDe/0nWuZFFRaXzRuI/b5iHeomyq5HfDd24Pk?=
 =?iso-8859-1?Q?PweYzhQxYLEUlhkNgOw9vYNdLo4VWaOHSkDWiiaZbDKAnkzNsEY/LA/lrw?=
 =?iso-8859-1?Q?F1PsID8fQmKSC+6IEgicxyDuqvyKLzoJw0rQEaKRrmSCT6et3pxUH99YAh?=
 =?iso-8859-1?Q?M2lA1PYFAZ1C8Xa5JbcO/Zb9sndYhxzvaoI4ixp7yKMJfV+HutYZZvl0CN?=
 =?iso-8859-1?Q?z8EXv95KrZvVE1pZvuQGQrFFKty5r3VJeXAXRNZtiHG1wa1w1WO/NTjjbm?=
 =?iso-8859-1?Q?pF9MeXn+EBFBj8hfJDNx7hyToEITJ2G/LVJlxmcP1BLlDDzyRGPa6mIkd3?=
 =?iso-8859-1?Q?2z084inmbYDfXFss5ecOE5RNXZHMnUnDjsCAWVZTXc/IyAjD19RbQEF3f4?=
 =?iso-8859-1?Q?CAHfQWRZ1CK8xhSQxzI1xGPasKLOXvN2O1XvUTlUiI1nSAT2xvxCYnfKMU?=
 =?iso-8859-1?Q?JIvZUEu/4G8pmkS+pK1b612j2J4kSvznuOjXO42Frfc8yDTQzGZ4W96bzi?=
 =?iso-8859-1?Q?nlJLxFa1Dg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eab4d66-b01b-407a-22cb-08da4ebe1d4d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 10:59:27.1349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8jhz6wb2AY4D0SW8u1C6f6qenoTpFq5lRvVkqZ/0CwerLdp7LadJn8BbEUs/eToDeu0vcBcxFIG4vGuSXlsSeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3948
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 .../bindings/input/fsl,scu-key.yaml           | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/fsl,scu-key.yaml

diff --git a/Documentation/devicetree/bindings/input/fsl,scu-key.yaml b/Documentation/devicetree/bindings/input/fsl,scu-key.yaml
new file mode 100644
index 000000000000..b0f4c5b553ce
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/fsl,scu-key.yaml
@@ -0,0 +1,39 @@
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
+  linux,keycodes: true
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
+             compatible = "fsl,imx8qxp-sc-key", "fsl,imx-sc-key";
+             linux,keycodes = <KEY_POWER>;
+    };
-- 
2.25.1

