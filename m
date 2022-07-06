Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C04567CC7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 05:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbiGFDsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 23:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbiGFDsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 23:48:32 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150071.outbound.protection.outlook.com [40.107.15.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB1C222BC;
        Tue,  5 Jul 2022 20:46:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AcL6TNTnMAFg+KITuY00qgqdy2XlGiblaxEmjWXeFUBfgBwoqyR3LcJ8VD6ZWBwk2JFOnYNVgd4xk8Ko2jtknGE1iY8PtGkFfkn4bMKWEZdHSukqo+oYkHKbN76XKn36WYZSir+mStXVQ7k8NVR27qZ7AEdkdj0KktPpR3/106bmYc2lyuMHE8LU8dY+O8+PC9fi8YLHv7tJB5XB0IYi+3Rs8x1UWhSlSNYspzIG6dK1F3OBJd30+pfZqSE8VfEc9GqNrVXljMJkPHhzIH8N/zdeYg1vY61UjxVOW/1pr6C0agEkVIMLdKC6toN+o8rzBBi47m+ittvkydgkkqLQ7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3yL0oKPiNq5Stt1CJixjtKZ4M36JU7kNRG9yTIA/to=;
 b=XFcYCUNLAZ/YlRmSJ8Zxh0RiBhWKKxECdiHJ2V1zGx5KOHIbZEi7Gn3awe3E8/vq8Yfg+v86WChx8bZdwfYKAjewBXzxBZFvwM55IU0fEyZDzr8nW5RdtT3sfBxKhOk6SeGgkFRSUaaY4UVvdUhMzB6uPgasAraB9GvP/wFY6WKmKsQB+FcTD5aUAOUozFgA1hWETbtft0LeYJmGXFsbQCKA8jUPqiCyGCMtO0BK7D48u1EHryOf2fDGy5KWeYEJWeeyCWOUSpIfqOOJxOA2ozPbdFEJLOwvxxA24VJGEAhU8Bnti6lECpjPpiVUK/l7c2C9zHCNm5sVIJnadXOFEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3yL0oKPiNq5Stt1CJixjtKZ4M36JU7kNRG9yTIA/to=;
 b=I+EcFEfO5gf1CHdjhFgTL2cK7+v88rUHxY0DzrfSGK9jZBq5gIbcItCSXRG70SSdpDy61IgeFohnEwap7hZulACKydMaNN7AjCKE+fXYbc/9wDgepM+2W89MSMMq3Um+bft0mgJHH6MwRLyzWfJsFB5PQHhN3j5uXvHVaglLXLI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by VE1PR04MB6463.eurprd04.prod.outlook.com (2603:10a6:803:11d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21; Wed, 6 Jul
 2022 03:46:42 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::416e:6e99:bac6:d3a9]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::416e:6e99:bac6:d3a9%5]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 03:46:42 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, krzysztof.kozlowski@linaro.org
Subject: [PATCH v4 2/3] dt-bindings: phy: Add Freescale i.MX8qm Mixel LVDS PHY binding
Date:   Wed,  6 Jul 2022 11:48:09 +0800
Message-Id: <20220706034810.2352641-3-victor.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220706034810.2352641-1-victor.liu@nxp.com>
References: <20220706034810.2352641-1-victor.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0045.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::14)
 To AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c50f23c5-1c53-46e8-4beb-08da5f02239b
X-MS-TrafficTypeDiagnostic: VE1PR04MB6463:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TDi0p8dia1kD4io5vh3I2Ew6cs73ldNsW1PYmnq2PWNFb4HSj4B0PjQh2pZYyCD+hU4YopDEES7ob/e0EvnK/NUYGbyj8lw0jYxL8rXkbSW6+Bw065/UsAP0Z+PcxGjXpW3StPJsAZS1qYnp7xePArCvdYb6shKrt9+sD9/6ym2TY7GQs7u3NUPyfXuZepC/vGIDCyjLZQKIGN/HR/Tc72RZo9wZ9Cp5NqyM/bb2QUb13k3VgiCDTNbWCrr4pJi7cL79LRq14xZ/PwVct9yPk4sWpjNbL5YoVgchE4fyasCS0wRGTeTb6SrbksiS5AQg/DhsuRDVywqHtSfXnmv+mgv9t0lRX63MMk0NcDZTZve3LUypPhwPpPYKsrCAtKRYD4IpRoKjjcBQHonB2Wtu4k3CcFIE80YlGrhg59XSTCutu+hVXHNBXOr7tr2QZuuHSH5i7+LJuS3YBEdtmEvTP94i7euVxzM0dlEuBJqN9KbXrYs8pdaukGCgSFuYe54IpXgS2TwSVwMhN3WEdY3MGo6fYsXW10dKuBGB1CSLj1OLw4MkQxyrQL5BV2YqShMPEIi4+C3TQDnwqilT3Ho1n7H0kTa3Zfa1iWbh9286r1yOo0/xigjc30rKJlfb4TYQ0hpIaE2eHRrsSiPNSkjN3e5YY/lHbS32mW6Ad4zhK9ArLK+HevOY0iyKXT3ggjMtBwP28g6tl2vZmYW6ygTUwdtmIPBGgrreGnyMCEogoXwZvAHAPU9ka6pEm8FBapJiU9poJTD7w1XotcCHN4uqt5LAXWmix9iZTfNgRpI73acWNpM1cEOOmm9sSjr6M62DFmR70M8GoYbbFYikugycc/PwztMMcfRpv8LPDkabJ9iYfhmoT9n8DCZTsmRHMYBD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(1076003)(8936002)(966005)(6486002)(478600001)(86362001)(38100700002)(38350700002)(66946007)(4326008)(6512007)(8676002)(66476007)(66556008)(5660300002)(2616005)(7416002)(26005)(186003)(52116002)(36756003)(316002)(2906002)(6506007)(41300700001)(83380400001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pZVDXTlSBVd58KgmWqhfWHVKFPMkyNzgeCOqkbirL3GxFlv1EDF9WfaaHt3R?=
 =?us-ascii?Q?3Fy35rXMJi5UyvIEPSERH1PsibeY0kCkoU8GMN847In5GgulRiBxzEW9r7Wo?=
 =?us-ascii?Q?WdNH96Iih5JvtXqxkPUjX+AKTRRdxYG6kp1XyPFf74h5dNgJOaihzHg6zOW0?=
 =?us-ascii?Q?9Djy7BFB1a3ztOfJEi8JH7AQw7nP4MRVoCaYCllSjzgr64H4AShBHxtZb1Ae?=
 =?us-ascii?Q?ZW6AwnF684TFgmnH1Y7LQacunejACw7NYRMUA4CVTdDz9fHTJ7Qq9LdOca0Z?=
 =?us-ascii?Q?NeU9BPhJewvoYqtcygAc4rp1ejEHICs67Ak35iLwKmPpzEqbgu0c1cMYSY2W?=
 =?us-ascii?Q?UnG8tvcw0LrUq1lQwIxwXMmEk1k5mONcHyUTHu92ldLhGkzm2T1lTKVt9Qfb?=
 =?us-ascii?Q?eWSxsK0UPZ+WWLyhJYktx1vcTCRsPIstGk1AAJbRyUzVEOQDNiBtToQKkJ9k?=
 =?us-ascii?Q?2onHz9NGy8Fds2jbao4EAaPrqpbD+8z6xQAMIfY93gQmX8RvuXA4IJM52C9y?=
 =?us-ascii?Q?3DgNtv7HL+7tdRd9X7MsnrBQUJQ6W3dAjeZU5oFwDxsYSgGpeZ6QP2KmvjPU?=
 =?us-ascii?Q?C0sARaq9zCw74a9wVkT0SUXLKJS6Isan/IZE1axB11l3wigHraw59QmW+4ab?=
 =?us-ascii?Q?AQS56T3YByc0Uf+/cAF0Ecfvm18vfldZXlnp+norn6tZwY16Rc+YE6Nt+p+m?=
 =?us-ascii?Q?kzfo+yEpzh6AAjnPtNggF+2MvsUlzuz+DCvH8K1wGs2PFAtxe5m5R5DiDO6m?=
 =?us-ascii?Q?EI2hTfHCAH+os/PiQljuavSKALk6oB4sqIr50cFv3ByAtaCNqr/UXu76j2Xe?=
 =?us-ascii?Q?eWB3fzyS2ZbJV3XzzQn546WBU8JFeu/WByTwMJFpq9kH/Z+CfQfEoyFbJitC?=
 =?us-ascii?Q?uM10sV2J+J4eo4jyAmL4lO7sota2oshIHVreljEx1O7NDeam+lLUUKe9qR4R?=
 =?us-ascii?Q?lwFOImMzpcZWJOO43J94ud3oFwswiUqzV/DWf6zUaE2yds3rdmi+AoFx6+Hn?=
 =?us-ascii?Q?Z+kNILGYORYCAaiTyJvIF0eZrH+8Cg3nJzm2DTRkxtW5fmV/K5hsP25liSyt?=
 =?us-ascii?Q?Y3PuqQeqKmf3WDqrRmXM4kCUk+Q2J7ClP1W8/cy3h7dzhwJc3SrOw2K+qYar?=
 =?us-ascii?Q?kahcHjbhcXWHIt8JTfWRN6wGgg+U426qVPZ1MmC5JPmeY01RqZCuKteMxfwK?=
 =?us-ascii?Q?ghQOkDQZZH5whScb/P+Efa6xfGJKNDkeX6tbNf54arXz4XjkT8eaeMcOStv9?=
 =?us-ascii?Q?mzL+8D8tBQN7ElllOixKB2o8nj/EekbDrywWjm1zdW/DQcyrrC5yGTqYoddK?=
 =?us-ascii?Q?vL4qzvC1Mc6/deawe7iRsSetALxf7HwJqWk8rN9gVY+Z+s2DUmr9evthBK/U?=
 =?us-ascii?Q?KoYhIotcEQbIL/yw2v5oCJhn1D1ITp5vxkseIGmIWmjDs3evwtUi9lfm0B6z?=
 =?us-ascii?Q?zjgyMiEx+GdFQLkDQOuLNj8ENVdj8J90P8D4e7+Ruew1sWplz5Tb7B4Lmr3B?=
 =?us-ascii?Q?8xkvjmCwvWJPW3ZFGhYOQ9rix6+rCA/9bTJ7g5k8vK5rvx7gtsdOaCZG6xJf?=
 =?us-ascii?Q?onf6AYAXo9kjUOZKa5qz9gqVsA+HTA28ohJcI8Y1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c50f23c5-1c53-46e8-4beb-08da5f02239b
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 03:46:42.0486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6qANtd+mwwDA3ML03dETnfiY6I1YA8WAMba0Kyalr5ScVYpLaSu1Q6kBdYp56RgRNSsvqsaDcWqAKFF3uUWaxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6463
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for Mixel LVDS PHY found on Freescale i.MX8qm SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v3->v4:
* Add Krzysztof's R-b tag.

v2->v3:
* Change compatible string from 'mixel,lvds-phy' to
  'mixel,28fdsoi-lvds-1250-8ch-tx-pll'. (Krzysztof)
* Rename dt-binding file to 'fsl,imx8qm-lvds-phy.yaml'. (Krzysztof)

v1->v2:
* Set fsl,imx8qm-lvds-phy' and 'mixel,lvds-phy' as compatible's enum. (Krzysztof)
* Skip 'clock-names' property. (Krzysztof)
* Drop 'This patch' from commit message. (Krzysztof)

 .../bindings/phy/fsl,imx8qm-lvds-phy.yaml     | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/fsl,imx8qm-lvds-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/fsl,imx8qm-lvds-phy.yaml b/Documentation/devicetree/bindings/phy/fsl,imx8qm-lvds-phy.yaml
new file mode 100644
index 000000000000..8767e48c71a6
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/fsl,imx8qm-lvds-phy.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/fsl,imx8qm-lvds-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mixel LVDS PHY for Freescale i.MX8qm SoC
+
+maintainers:
+  - Liu Ying <victor.liu@nxp.com>
+
+description: |
+  The Mixel LVDS PHY IP block is found on Freescale i.MX8qm SoC.
+  It converts two groups of four 7/10 bits of CMOS data into two
+  groups of four data lanes of LVDS data streams. A phase-locked
+  transmit clock is transmitted in parallel with each group of
+  data streams over a fifth LVDS link. Every cycle of the transmit
+  clock, 56/80 bits of input data are sampled and transmitted
+  through the two groups of LVDS data streams. Together with the
+  transmit clocks, the two groups of LVDS data streams form two
+  LVDS channels.
+
+  The Mixel LVDS PHY found on Freescale i.MX8qm SoC is controlled
+  by Control and Status Registers(CSR) module in the SoC. The CSR
+  module, as a system controller, contains the PHY's registers.
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx8qm-lvds-phy
+      - mixel,28fdsoi-lvds-1250-8ch-tx-pll
+
+  "#phy-cells":
+    const: 1
+    description: |
+      Cell allows setting the LVDS channel index of the PHY.
+      Index 0 is for LVDS channel0 and index 1 is for LVDS channel1.
+
+  clocks:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - "#phy-cells"
+  - clocks
+  - power-domains
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/firmware/imx/rsrc.h>
+    phy {
+        compatible = "fsl,imx8qm-lvds-phy";
+        #phy-cells = <1>;
+        clocks = <&clk IMX_SC_R_LVDS_0 IMX_SC_PM_CLK_PHY>;
+        power-domains = <&pd IMX_SC_R_LVDS_0>;
+    };
-- 
2.25.1

