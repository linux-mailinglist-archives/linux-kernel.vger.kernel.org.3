Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988C654C716
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353271AbiFOLDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348913AbiFOK7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:59:39 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2068.outbound.protection.outlook.com [40.107.20.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B0552E68;
        Wed, 15 Jun 2022 03:59:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CmggIylw8/fhOxIMqILWgeqP662Pgv3Z7v7we1KxuuK8tr0f2jC4BrW8WiXToR3tdRZkTCMeoO5jg0eJDjJB0aVnQ8G+7j/c9LNE3JiEC0Sb6XsMVDYk/II4pWWf/AI0IKm4/HZ+51leOdqjSrDcBgGEw8OkGcvR7Z+v4gsSCMy84QpGny3bMYRuSs5qWupJbN/BueKBGzTGbdPIxi0VJ84eKOH0avhxtNYBsFUziol7Vv+cURfitnirC31HCteJ9V8lknv8348iLkxAUlD2pw77q5RlbOqNSKUsRcB4QPIk8owLau8g0tdKNAWFYBdGMCzZEb2yXQAHpQehW8aouQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3T6PGykkr0EN1epJe4PHAp2+NCMB8Im8icnjXlm7uuI=;
 b=cfTegu8Tw9mnMFprKE5/LPBDV+QvUa2W6hNnGgMIP+ULeFPaZWbOcrFDmSEp3fz5dGFMbxBlkboifHXoSY1rHGBrGuNdfXtNJaA3KenlEkrn2C9iQfdBorB+2z2qQX33WCU54ci+nEx2sbcexmstvrGE3Rdo25ISfqb3tcJOJxrDJIHACjom9dUS8FPi+k3UJdzR6/hvBLezKgCQGrhoKnsiyn7vXpVFlJ2uY9bwbULQrHPU02nfwZae0KLqMH668JKg5IkZ5iYsEW8zAEhQNhd07yRa1MhMRrncRvgcnXZGpowLAESn30gRnq+iECaujBAlRZEfZC6DVoJnT1LiIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3T6PGykkr0EN1epJe4PHAp2+NCMB8Im8icnjXlm7uuI=;
 b=gf/bJXOtr272uUP7YnZeLAfJg4HKluzEaX5yjKmpSBFzmrGzJ+rD0xpDjbYr/00XCWZ3G3LydcVIpHU1HMivUF4Ism2EQerIeZIiWETfy1L03cZWKQLF5HrqlPH//kwuH+NDVtfSPjgNLKqoqI3nkjN7lbc7yz3ycljjJlu9pss=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by DB3PR0402MB3948.eurprd04.prod.outlook.com (2603:10a6:8:d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.17; Wed, 15 Jun
 2022 10:59:33 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619%5]) with mapi id 15.20.5332.022; Wed, 15 Jun 2022
 10:59:33 +0000
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
Subject: [PATCH v4 06/14] dt-bindings: power: Add fsl,scu-pd yaml file
Date:   Wed, 15 Jun 2022 13:58:26 +0300
Message-Id: <20220615105834.743045-7-viorel.suman@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: bbbb83c9-7c54-432d-f952-08da4ebe2101
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3948:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <DB3PR0402MB3948F487EC8901F52F9C2F5E92AD9@DB3PR0402MB3948.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: butiUWaa4Z3Q2XvER4utSxyWv+KeRTKGVJerDJ0yWnQbykyl+weeLHeH+8pt35fXVgzWv2OuXsxBSidliwvS/1gBstoU3RG5f15dkl1hzOnj7s63Wnik/WxXFmoiomgKB21WMghfgvXM68bSpGUv4GpNobi7GXjAh/iey6lKmL2gnhAdIn4rPDm2ijlMH6IqFkUHU3ZScHvSIlg697t+cCFSi4A8yLya4cPkOH8gX+L4HBU8x8sEDcx9D/RUpntD65pQ6cDMpw+1huCOCOeB5yConQGhnLYfZpVOqVZm8AJA52fIiOg0hUgHAj+02y/xfKf0sOtIXUnB1rBNdRihie0NOY1QyMsuwIlxXjuUk0seF+KfxCxgm8OHPN3cBpKE679/QKW+ABhtf9K3ROLgCR+sldugd1UK24/oCmSv/m86sJgEiwNMREeHLh/FtDeRqHyf/povCAJWB6kJQ2W8aFq6tOmcuwPl2SkICIHDVQz84whtkGs6KbjYtzRd/NnUDEEYqQI0kkHv0RpvhqHSLFCKAveI1virEQxshSqf1jIcZCpHS+n28Ib9Tl0qak4wpk1CXLMTRir9o6QEIHYHiKomgCmanwqsndt1DvgPCTN8Q+rZ5kmZhuDFELsQvvlVdsM82S1eBlb+vv+GzSFIUlyb1YtYoSHpO2iL56LOFs+JSGqSDssGAYbgxGawArkSds1grq7e1nj9jlMmP/LUMFel0b6p4uni6YLpi/EpXjEhXPcfggfHDa5Dbsdrc4KToc/nkCHCQpMWlIEBEqcUUj5GRHObGcEY5ET+eIVNIIbDBtPTKZPKrGSzXO/F4ZS/TW8zzWnjHH9ZVkaLOY2TsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(26005)(52116002)(6512007)(44832011)(7416002)(2616005)(4326008)(6486002)(6666004)(508600001)(186003)(83380400001)(1076003)(8676002)(966005)(6506007)(7406005)(2906002)(38100700002)(38350700002)(66476007)(316002)(66556008)(86362001)(36756003)(66946007)(921005)(8936002)(110136005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?dc5RqIyONTh5cWI4imJEhJaqdrsQUhg/stcMTWAOr8LOKVvO2fcY7W4Es+?=
 =?iso-8859-1?Q?KVLQer6pM74/ptaqvCpxp4b590a6Iq6dPh1TdCkXhpQy6WelloiN4KrXbq?=
 =?iso-8859-1?Q?+3+TiLdaOU8+Xl+fA6Os6FSrfQJEphHuet5klqIRaLLj5FHaCuMcv09QhS?=
 =?iso-8859-1?Q?notaCbeWo44+vDSU2cdtXiHpb51Vr/AD1LGYSQ+8tc3/5jnPDmewhP3yjP?=
 =?iso-8859-1?Q?bVCpRv5oxaa1gj5TDwFstUsQhTjKL6hu9Y0Ngq6JcRGKJfTkIM80ET4hhr?=
 =?iso-8859-1?Q?amEvYTEikgfF5bHaZmN1ODP2rEfDN6woohGOtBQgVkALM/5vofYW35wbT5?=
 =?iso-8859-1?Q?QHI/EEZNSRo/Aqr+kWlgPw5nty0hmOyqMLcgjJ4eBjX0mXCm1uSry3VVm2?=
 =?iso-8859-1?Q?UduF8pYNAYrw4gs5NHb6jKY2kEG2GLrcxy+xzPobXyO4LVJIcUkEZaXFT6?=
 =?iso-8859-1?Q?bXHqiOZFwe+mTKXsI45AZpAOhKpaK7fkXQmk+/yCEEI5gfj2khituufS+U?=
 =?iso-8859-1?Q?WffBazdIYn1q0JMVmypfuS5ecQgCKJOSreRRTkuE/Sg87dkcz2Wjn1858B?=
 =?iso-8859-1?Q?QtCKsi3WK6sI7tdf4iUeOeExtvQdUnngRu6qVvGiRvP85/0biGlhr5gBmg?=
 =?iso-8859-1?Q?QLzWaY24yMuqMpgYESypZhX7eAr4PB3v3GgtRzaGMd34spcHAAoAyGTQgW?=
 =?iso-8859-1?Q?uwwDrLbMlJosCSYVHzVW14g1Mw2iNGz0WHVcXFilK5TbVJuOy6GOttLvs+?=
 =?iso-8859-1?Q?Z93ONgsPVNXtjXO0g9PJeBJUcf1bGdeVASsFRnJoB9u05HAZQm58idkzjo?=
 =?iso-8859-1?Q?lN0f9I4l18b7AHge8r/yrk9zwh4huhX9bUPo+S3G2iWI78FUWQInTyCjjb?=
 =?iso-8859-1?Q?d9dkDVwI4IK+mNZzVQxAG523SyaVSd5gGdsgCSPkOgV864vLM89PypyCga?=
 =?iso-8859-1?Q?oxp4or+Fh5VnZ93ZtUFTUfjxFIqu/sk8YwwCZVEMqoR9beZOSyetoRHSIW?=
 =?iso-8859-1?Q?n90lA7Mlp9swQ2QOL7G3NUKaGV8YJhCTJwhlpj8zSPoeO3BtoUEKbJkz4c?=
 =?iso-8859-1?Q?DDP4lUpw2yxg4NA0uxQ/EnM/ONxxiQqIBy7OjfUHNJbGkNOQkMfMzN9I80?=
 =?iso-8859-1?Q?LHPadCEeB8PVfIMWb7106Y4zVpJ6T2E6Ca/D14E7lArgpaks5nJJXiC9jw?=
 =?iso-8859-1?Q?JXVsUYyOyoDb57Q30WPqz8JHaJlYTPEcCPICpLPQo2EtXmqhdlFnYDw15v?=
 =?iso-8859-1?Q?skST2v9aXtDVjBKtcKH3uloiNRsh0MNcXyzl2tC17txahTw/RCo1xdYOeF?=
 =?iso-8859-1?Q?eGvt/WS1z7/qTIin1CSWci3Kb/cg73FdKvhfl/SiFMDleZeQLXe7NPVFNH?=
 =?iso-8859-1?Q?SNBLYHmF8aV59faucRSCzCdhRsB8Te2aKtYfEQ2xRgOyE3ZFCk3eQoqS/r?=
 =?iso-8859-1?Q?ZawQ+wr74CrL5UdhE0deO2rQwJNkjmJeFeoSc75YNBRuMQeyC9kc8liNNb?=
 =?iso-8859-1?Q?1V1Q3wIlX9qHmcxx8fYeJDi8AFrQIMlGqIv+9FQ+D0QW/vaiYBwAP3Blhy?=
 =?iso-8859-1?Q?px+fyRYw0Y8ixuAzj2XJUUfDqc7vJsFDsYIEPFJzXLyw5+7JVJQPjK0zua?=
 =?iso-8859-1?Q?dswDPxXwz/bs1rp/2hWkv3HCxhfeFWZJyvFZet5jFNlT/DMKgkb/6p/MPf?=
 =?iso-8859-1?Q?tCilp4YJsixjtpLOMBeZjna34nESgMNVOvQIuDOhJaWpjjvwfNnJw25gxB?=
 =?iso-8859-1?Q?uw+mJMgAsmn8UO4szOPdZCdAm15sn5xCoDQ2Q8bEhTGdj9FivwLMLF6P/l?=
 =?iso-8859-1?Q?YwaemEikeg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbbb83c9-7c54-432d-f952-08da4ebe2101
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 10:59:33.2907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bWPn/VUiOAHgc04FGC87k2i4FNk7LQNNLivG+K407kKDgVRc1B8oatxphTYd1XbJEHepw7B6f7jsf1pumaoAuw==
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
separately the 'power controller' child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 .../devicetree/bindings/power/fsl,scu-pd.yaml | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/fsl,scu-pd.yaml

diff --git a/Documentation/devicetree/bindings/power/fsl,scu-pd.yaml b/Documentation/devicetree/bindings/power/fsl,scu-pd.yaml
new file mode 100644
index 000000000000..9d3cb51d7b37
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
+  - $ref: /schemas/power/power-domain.yaml
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
+             compatible = "fsl,imx8qxp-scu-pd", "fsl,scu-pd";
+             #power-domain-cells = <1>;
+    };
-- 
2.25.1

