Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9856F54C6C7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352302AbiFOLAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348848AbiFOK7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:59:38 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2068.outbound.protection.outlook.com [40.107.20.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD1A522CC;
        Wed, 15 Jun 2022 03:59:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvhMluYjjnH46CSRwmlUgn4eJvXq8OarDZ2dE0c3QpX3QuIsA6QNmV4ByU/VIaEqPHKwLwf274VBCbFMLq3pNWq3SFnRkDpG+dJOKYEpouM2I4+LXcgS5L+MexqNaip5BRUtwABZB/FjOUaZvPZ3KsIgIGFRf9jK3YZ6lAfZZelXR2V7VppRzNv91Eihmrjx5tKjrtTgsj7y9tIEUTjjEJZScyc973r+LnSeHolrn8ZwFAua1AkG07l8saSNFKaPVweaKyhWBb/7xUTWZ6+lhW30oEoqNMNxY/O+bvIrQgK1bEbsqfzttgGY7WzoTxA/MyOxlwAvRQafsnhak8CU4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ga6YTzEhicQSaD2Q/12AVwYi2lKVZk8yry12MyVEVN8=;
 b=SwZUPoJXy9pavM3wi3ImcJ2Adp2xv76CFqB9DKZ6zbpF/hk7ilYTpVwU2D47rF3IdS7HvEl8Jlvf5ehWYaQpnpEOUFoM1EPJMEowvzHYtHvipyWWEl9JF8BdcOvbFrJDLusLvRKktenQ74ac/5EAzbQkFSCpQhO8+avwcWkHXk72yx3OCpODQp81uNU4Wh2EZSfMYT+Z+NDkxnHilxYFUdFLDj0muKB6VwlgsCw12xGF2sJ48yHDsrtBOxMRmoF8S4pVVIplrfxiRawRvUoNGrVcP+n9PpGZWkiTLjFnWGGKIg+PXPoBmi5vxZFc8scaWB9O8bXD9vZQGn2jvUEfwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ga6YTzEhicQSaD2Q/12AVwYi2lKVZk8yry12MyVEVN8=;
 b=Alw8RznQn6pzCDkmmPyleR5UqHHHt6/SwI/NH39wyTTVbwINOXlOnv4qAHaDQ6n7yNVdwoYLxMgdnz9N+UFdzSV7olHjD1aKtqRYxnpngO8NuOQ8UhdSPsdIf+MT/4xoeVSoHVXKUt1EHBoo6yZqEpNMONZq5dsiZVgcgVvWUhY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by DB3PR0402MB3948.eurprd04.prod.outlook.com (2603:10a6:8:d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.17; Wed, 15 Jun
 2022 10:59:30 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619%5]) with mapi id 15.20.5332.022; Wed, 15 Jun 2022
 10:59:30 +0000
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
Subject: [PATCH v4 05/14] dt-bindings: nvmem: Add fsl,scu-ocotp yaml file
Date:   Wed, 15 Jun 2022 13:58:25 +0300
Message-Id: <20220615105834.743045-6-viorel.suman@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: e5cc382e-405e-4e77-2bb9-08da4ebe1f25
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3948:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <DB3PR0402MB3948468FBBB368381CEB415692AD9@DB3PR0402MB3948.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fW7r19tLv2RnsUheRgJJJcNST/BEO4+XHAxFLa6goq+Cw91y4H1sgm8Z7k1GM2YQTJZvsHcqdVZfO5wJmIIlVo2FSQxlJWg5tuBCx+fUPvFeGp8BL0ufUs/gpgW38N6ukDxGsqw7CrbUfxawkCkxTzXdj31gBy+REWuzLFMiPb9XmB7oENDpDKues2wXvyf/ryj9cjgzz5hN4dCqSnpp2kv1GnyHurq/YbYaTgOcuy1XzOJLNwkeejO9h4jxWXGyq0AUqqo/zF5cxsJV/wYuC5pZJ0oRDJ+sdn7oHtIFHsb6Ih/lSqPDnQuMvLkVJAg8M3o+Sxow8mOJ0AyCjakXrojl7sJdpZzRlk7utd/PHqi8DyNts2tGJ/D9CY6eWbdkgfDV6G8OKO1VXmSlekjBYMARJEmEko0ir5WeJKQWXgiy9kj+6cOmrpAmPP3pz4esOJcduU4m21zLSByYV7Hhpt/UrTALevxZu7PzA916o5zYCzg0Si/ioyOyv0Uk4LmTUOIvkU5VMM04IlpmiaKAfpIPqGObah5JuXUsDhYaWJiPmkJY4PPy/65ZGRMpLBHRBHsmCxFWQ0JWp4pl8h/1GjYdLAh/5QqRaWDqqxfQTVT3NVQQHuWSE74hDbGSUd1UUB/yuamHLb9ct+E/8HxEp0HclYJyfMwuvpWTSnzzu1lJ4PfCmtmOckVcoLELxD4krAl6RJqTe7GDt0gW0TQDd2xikrs+AYluAaOXKwwSpxaOjEi9gVR1/YbWzHQ0FVDyjem8l8Qn/Wm/5ag44qxQ2huoHu2Rndo1fH5fzSNMpusqIv3WIwKJt7CtAJrxll0VAssJKg/17n+NeiI1lUU+4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(26005)(52116002)(6512007)(44832011)(7416002)(2616005)(4326008)(6486002)(6666004)(508600001)(186003)(83380400001)(1076003)(8676002)(966005)(6506007)(7406005)(2906002)(38100700002)(38350700002)(66476007)(316002)(66556008)(86362001)(36756003)(66946007)(921005)(8936002)(110136005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?kV5AW7/UjVQ95Qbu20jS+BOL7WS/Mdz2h04nhYtNvHr7Qxe/zHA8tlXhub?=
 =?iso-8859-1?Q?lxRNEEj/geV0jtpENsYLoOcUWmlGdSoLF0vB05rQZAGt4Dglg7VVHC8dQN?=
 =?iso-8859-1?Q?oeUWxcEeKKReWiVwghBPsXeBklx5G7gCPUDjmkUHVbDzJmAz8PZU7t/k+/?=
 =?iso-8859-1?Q?Lr7r4jUFL7W8khHfGg2R8T11ZvwLOeZMI3eYwt5brpa50s1XwJjL7YexZU?=
 =?iso-8859-1?Q?TiJd3TsH4wxQfhUklc7uzjjPTRf8hrAF4932ZAgOk/MRsmwMKnqDHUZXL1?=
 =?iso-8859-1?Q?y0gPZBCcQfhMfW1NfyyYlJ32qauUPp3ICvVcMJ9lg2ZamjYJehOHeKflDQ?=
 =?iso-8859-1?Q?FMUmVszaQSPBCjVMKwfhh+XKITC2n3ojcEmLHmBo1H7ULRplMzK2QO6tBC?=
 =?iso-8859-1?Q?gFpyzVxyYh+32gaKaD+copbdbpSk3c2eMhnY0UKgDdcBgAyjawJ+5mDSzi?=
 =?iso-8859-1?Q?2QoCkOQAtlCHzelyZR4maoDVFq2390SIR65WCJhGcn6xIzS2Qpy/Go5fcO?=
 =?iso-8859-1?Q?5CYc6VS0llen//2PRFytdzYu5SpHl0ItBFapT+fgxgJ/B0adP3q6TsSOuF?=
 =?iso-8859-1?Q?jVBXjcahgBwzyQcOnVTSO1kCItp6n0kw9Z/O12FQQk+LdBaOjmL3u/Rdaj?=
 =?iso-8859-1?Q?LZ5ULFdf+588J+/LRnbU838dCk8kNQLfT1bmyODIvT/UTfiAlfqCCLTwTL?=
 =?iso-8859-1?Q?RuBWMGC3jRxEXOrs13Cjs3vj7qzLZAaYqTpFoXe1+cLT7SpHZqsQPE1bjW?=
 =?iso-8859-1?Q?wx3IJ+RYkVQ5I8xt8Iyhuu8YGEg1LpEDsQpPLBYR7Iw6Ql3oVlC+8PCccu?=
 =?iso-8859-1?Q?SfucWm2vPKTUAQtQM1wGC0lRqEHGWOQ3uRQeb6eW3yEhHQeau54r03VUsJ?=
 =?iso-8859-1?Q?GIZS2o1Mgda2xWyK77LBd14RhQFBYt29jE1i0D7uBxrAUhX83Z5Gl8aqJw?=
 =?iso-8859-1?Q?RVTK2gx5fxqqIV0Q/HFfbwJMGNFOluEGiwiiE4vI7qL2EAg0/bRouSovAV?=
 =?iso-8859-1?Q?+d04PW+yzo0Z2BYwq4B/TMrgvV+bkSqL0yyAuaDd1U4boxUNojXn71Lg7z?=
 =?iso-8859-1?Q?dnan/+mxpPohMd2IsAXc8EC7NNbgY28H8mgAAAo3ms1jZXJRwTQ/NmoxYY?=
 =?iso-8859-1?Q?N4hZtntvwVnOIUzFne+zdB0ihy74/OhvUax922P6KJb+B+mmHhOtvHlRI3?=
 =?iso-8859-1?Q?kQ6sPlo5E/7sHBm2frwCEFVqCaOyUjQYrVbJmnLmdrDP8AL+bv5kUp5M4f?=
 =?iso-8859-1?Q?Wq8kEEdncuKQnqNiFYhXVkiXhALReoEva5nLbCLfSm+K1CcoIaG00xj3WX?=
 =?iso-8859-1?Q?p3O7oo1ju73fRNGesGlcjZBZMvqOxnkx9N/Lu1vEymYigx3oOkgldvTm0F?=
 =?iso-8859-1?Q?c+lWpvJ97Q9WS8nfgmcvoqdnkoU+LzPGya4rDbiO0w4xy4ps6M94wHFQBY?=
 =?iso-8859-1?Q?dIVDpbuCIN7iFvYIujcddUbrG5QF2TbR7RfphNlEAv606hcalPtjk2DRVw?=
 =?iso-8859-1?Q?rhzIM4H0ha8auQsn/rIk0O5i86j2pQeefojdf1mv6vp0pZO5V7dyLpbo6v?=
 =?iso-8859-1?Q?d6zo1XnxFLLmWzKgowDyujvc0HDYRev4IGj9H1M8jJ3dN8+IquMoA92fn2?=
 =?iso-8859-1?Q?uDoVGgvTSxK3AybAIEPXBv61YMrhVLgzjqTH+EFXnsUTTyqlcm10AYxD3g?=
 =?iso-8859-1?Q?F1l7mTNN/XWi8nNivwNZX8aZEV61symrlC/JgrVVDNJLFmA8tqU+bZLoJS?=
 =?iso-8859-1?Q?eo3SyaNSJT+sM+cDndaJeUPOb8mNj9Go8C/uVUSh9odUW0ck0MwOll/bOM?=
 =?iso-8859-1?Q?tZ4YC7JjJw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5cc382e-405e-4e77-2bb9-08da4ebe1f25
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 10:59:30.1347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YfIZdr0N8aZl0HPBHC1k7I+hUAD6b1jOapkECHMB3LxSlgvv/Z2VE0UBCkmFpDajFLHBaF1vfZi3wOVBX7l5CA==
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
separately the 'ocotp' child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 .../bindings/nvmem/fsl,scu-ocotp.yaml         | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/fsl,scu-ocotp.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/fsl,scu-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/fsl,scu-ocotp.yaml
new file mode 100644
index 000000000000..071171e55218
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/fsl,scu-ocotp.yaml
@@ -0,0 +1,49 @@
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
+  Detailed bindings are described in bindings/nvmem/nvmem.txt
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx8qm-scu-ocotp
+      - fsl,imx8qxp-scu-ocotp
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+patternProperties:
+  "^mac@[0-9a-f]*$":
+    type: object
+
+required:
+  - compatible
+  - '#address-cells'
+  - '#size-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    imx8qx-ocotp {
+             compatible = "fsl,imx8qxp-scu-ocotp";
+             #address-cells = <1>;
+             #size-cells = <1>;
+
+             fec_mac0: mac@2c4 {
+                    reg = <0x2c4 6>;
+             };
+    };
-- 
2.25.1

