Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3F4550F07
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 05:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238003AbiFTDoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 23:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238030AbiFTDoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 23:44:23 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2073.outbound.protection.outlook.com [40.107.21.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659A8BF69;
        Sun, 19 Jun 2022 20:44:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ex3h/jBwXmzEPwv1Pj/jeXERG1QNAshdlX3QZjA0lpB9+rkr91laHOt7v0DQwpe1Di3maoWLfSuh/ZC7YdG24VBHCDtdZHSu5aqOIoVU4A+vTO0O312Gkf7m4WtgN309x5DRw5u2YApek8EGINhMI/YgKGyWZLQF9F6IG863XoEFisshiEbd5CfnNly6NC1hm58TUNIE04Gyoe557FMq7S/uaqItD2SVHc/7rBveNjXDC3rCpYBKYfIFK91CE5IGtAlz7yw5f1nQFJ1S+V0AyTnsphc3BdtRiOJ5xj7e0Gjdueb/HzBjC2B6T79DEUr6WflLcqXVfm2VTcvpyyM6aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=juizKsphdYpyNHz5IT+Ty8u1IHR49IBXFXuhYegspOA=;
 b=SBteW4ABl396b6bDIsBEHRaywNlH8fsbFoCqAXr48RFmOsOGhEHNvFwAfo9MCzxocNRhGcf8kkMQK3fFphJjbpuIpvxt3ssfif2U122mFKPHQa7DSZNH50JfPuQ0CPeKGAaiwDU+mFCnlSx24RrLYfwsIiGdDSB6nBH/YSq92e/7ZsbmZ9AMMrTpjstgvE7g/3if06YAUNFERFasCTx3Fw5Bi5baf/GFh7Pqwnyt6Q2cOHcXPZJCaQtXVUznaA+bVxYhP6CQ1x+gvS6Gdi5G0PAJYlZhLFIp0p8peCPitp68C2BsB5V8rAYRwV0gMZOYIMM2Z8Z7VwL6aKAdhmetCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=juizKsphdYpyNHz5IT+Ty8u1IHR49IBXFXuhYegspOA=;
 b=P4luNwISB6/II7uSg6HyzHupSWwJSkpmUfSGjaMeGXZAMUUntAYIrRwxEOSrZd/7Fnv8c1e2mPTs9GXXnwYUGigz5DcP04YJj+SmG111hzfeM3Ctap0FBxdzPgNCyttNgqgphjiLlsvWg9s2u5VXuVF2wHRUtjzx2YZT7qUfcLI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by PA4PR04MB7965.eurprd04.prod.outlook.com (2603:10a6:102:c9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Mon, 20 Jun
 2022 03:44:20 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::3c82:f63b:711a:502]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::3c82:f63b:711a:502%6]) with mapi id 15.20.5353.021; Mon, 20 Jun 2022
 03:44:20 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, krzysztof.kozlowski@linaro.org
Subject: [PATCH v2 2/3] dt-bindings: phy: Add Freescale i.MX8qm Mixel LVDS PHY binding
Date:   Mon, 20 Jun 2022 11:45:32 +0800
Message-Id: <20220620034533.4108170-3-victor.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220620034533.4108170-1-victor.liu@nxp.com>
References: <20220620034533.4108170-1-victor.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:196::7) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93202865-cfa6-4622-cff8-08da526f285a
X-MS-TrafficTypeDiagnostic: PA4PR04MB7965:EE_
X-Microsoft-Antispam-PRVS: <PA4PR04MB796509C0916A37B122BC4F0698B09@PA4PR04MB7965.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jSXzEzZY0jLnqRuefjmSQLEJsL+WFirEpYiVo7rwsYkRsnBBFatUBws7LWwtM0yCaan5+1OX/tTWUkknef2kwlj6B5KIY1cRbKZo707o2kZJlSvSpqchaGUlamgSU89Yhi0pOnt3dgTntbeNUi5VPE3Qz8X7vr8kgmjEg/MeJp3dujrdy67izIRGzUpCrVUjAtQ5o7cwiqOMsm8bRtOcpCy9XlMNePGgZELYy7d9eopnMD1LsDLcfLQ3eEkrqH/FobnZGL2rW2FbPhJR57B2cOi56H7EXfAXOZsJxpzPIhYmmxQ0Ynr0XoPdRyGAeme5bIkZjRM7jNnOCx1aISeKsuHYxgK4xbkHpY4NV6kiS18TCllq7D4wa0MUVdcaCWINPcTGuq2A1WuQL5ADJSFoVpSb6yLeTjVqjAsHlB1IinIVOg9GjzOjavwopfD4fw4RYp44hyzYc/YmA1Msd6UidzLFGMJ71hAtbwhEJ7Tvz42vxyBVjbC3Q1m02xI/4/M15Z/T890ym//2nqa4UgQn93AZAGmspltQs8ZP2dZC2tjadBgTmOftuw7ynQEafLyIK0m29Or9rrOFIQrBGS1br19dCfuGjW60XZ6FwlhNKKSE0+0UMgcJXpn7FAudardmvAEgubwUU0w7vFPO8LvkkesKMhVfaDV4U94ASAETqBX3zsuU8eSSZHuHAdogr6k3v+V/lTeuQAnXvRllBeM9WCxVdcUwLXxK7xDUp9ngoeI+IkqV0vBx0geCsan3uinLDViG8J135vgUQQosflegrDdFLWJoqbeGkgWuLgdgt0U3UYxy8P86Hd4Yq6V6bXEW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(6506007)(66556008)(52116002)(7416002)(5660300002)(316002)(26005)(6512007)(6666004)(966005)(66476007)(498600001)(86362001)(8936002)(8676002)(66946007)(6486002)(4326008)(2906002)(1076003)(2616005)(186003)(36756003)(38350700002)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZHPaI2ZHo0uK2w5dCtQ61HCleJIzyeZr7Z9qe6A9DZriOYOHIqbAOQwFhBwP?=
 =?us-ascii?Q?DrFVQmUaA+KC1dCEIQf5EhW/9kH2KMp370kQYO+EvbNNFxaHL2WMlZUUbses?=
 =?us-ascii?Q?H/F4IOELYfMk3IXy3tJvFruiQuC38wSdbZDbLQrjBoXYLuM46ttMvECIGa4U?=
 =?us-ascii?Q?y7vPgfJD2hfi/xIH5uHoBA7M2MEdCGNV92jFqIwygTJgB8gOi+97TkhVbZsZ?=
 =?us-ascii?Q?O1IHR2GmXisruHDJUgldfDGJT9v2izgOte18neSwjfb0WxBYZ5kQ8kxcKy7Y?=
 =?us-ascii?Q?CPiQXRTLIyfGKH1IDArSZaKrZaOsGbhLTbxX7xxTz1cB2bNQRqKh9a1AzDUW?=
 =?us-ascii?Q?nZo0WtHBOgtD2evLeomqUAE2n4/pSPVvRrbg0FURTOGlwS3lTdk2PkxwCgeE?=
 =?us-ascii?Q?GfjAI3XzsRoDPZ8AUfsiGRI0KSQz/PKrRNQSTKPSSH3OZ5DjA1OCuwdNaiwv?=
 =?us-ascii?Q?O7ftZNIxi/VUTh3TQoL43xsTSkRAHOBfzPYq7QAp4f2dsg//lw2rMw3laYsN?=
 =?us-ascii?Q?KBHMUVHfzm+ObKg00X1i7LvQXOQryuItYQEd8ykobtxMh11tBTjHFMORT8Nq?=
 =?us-ascii?Q?YeOk1uzrxwMU4Ore5TaoqCRcswq2xjiq6uRgzYpbrIT8knmgSV81eK5moFQT?=
 =?us-ascii?Q?V1StzNZj64RUnBwx5ICMyHCTtwS+6f7ujhKIXWemrijHTszZbIqwMCDCh1lk?=
 =?us-ascii?Q?ujT3T5c7qJlO2ikb23GAAuA4nWCm4qlRVcfJIS3fkVlcizuY3TpTVx2j/cRy?=
 =?us-ascii?Q?4wPhauXrSnHXfouMROpgxHo2+ys7fiTxHkr8XN1Pxuwc7wZ8gXuNnGTlTDy+?=
 =?us-ascii?Q?JsCTP0uj0FE8em871u+vT0aZuDwwlSIAotXuyQUMCflHFDtKAGA8+V+nw8dv?=
 =?us-ascii?Q?HAVV0YYwjkeEo53vLxLUP/XXVnhvyPgdHvCNhNIX2BIbxDb3vJdMKGVCtHM7?=
 =?us-ascii?Q?jDiQNRJoG/PGLNzPL/DnunKbv1geVtwlGrsjrVDdvCTtwo/DBby/recDx82m?=
 =?us-ascii?Q?3V3YVkqiMNEQuYSyBHwHddR2xRgQotL2XFS/Mf1Sn1YOe3ohSl/7OnlbOMTz?=
 =?us-ascii?Q?+1Mia1mj+VxeV6Dfag+XyAjjxPU1sXmfVz268G1c96uLyi35pIZndQxcs47m?=
 =?us-ascii?Q?XRqDBNvtymcNyAIf514F4RqWG081kA239KMUGpVp76G0B6D7EpBI/X8sddlt?=
 =?us-ascii?Q?YoG4Q/LccsGGiteD7cgeWeX2xUbzBjqaiptuyUdUScGL1NuhieE4lIl+kMna?=
 =?us-ascii?Q?EUyyvGYC/P2kQRWVdVXaqLiWljrjCMYnoGixmTLcADZK1qyCTToxX46cG7Y4?=
 =?us-ascii?Q?M39l26MGfOnOqObiN4XeBBITPIFMxwhDBZhcdJL6NHjJvMDXt6MlnoA5u+KF?=
 =?us-ascii?Q?d8uK84sGDEXlzWSUgkGXtblgxFgy6fvu+ba0Lgwm/MZeRO84OfGoo3leBEEM?=
 =?us-ascii?Q?JYPLVMxixpOiBFd2qJ26NfNDhytIpJ0RIhoDDV1zclyW+nTlBk3NWbMHDbec?=
 =?us-ascii?Q?7oBg2NojytRW59hPz3n7RoMTP8Fgwt9a1Q1Mq3o6Dforos3HhGgWpfMo+okg?=
 =?us-ascii?Q?29Cw8hdfzlAq8d/S0F1xfc41BdOKSwpqhHO/85XzNnbi5QXAA3g+r5Y7QB6R?=
 =?us-ascii?Q?XakAw7BeafvfRC/QRhPU3dwAiqZ8X3a5ju+PGHXlzvUCBFNRSJUu/i9DOquz?=
 =?us-ascii?Q?SVTmGbeQfmuF8O3FvzFpoWhko4R4WrFh9/sYN29t593dY3fGowJ9dhTPMrnh?=
 =?us-ascii?Q?SwIwREu0iQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93202865-cfa6-4622-cff8-08da526f285a
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 03:44:20.0733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8CtaQZUXwdPX6ZM31zTk1dnOY9qHaVCOOq8NQR9xRGhF0Z5hlSwR721Pzxf37MWWlryovcUTW74GuL26lYlRPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7965
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

Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v1->v2:
* Set fsl,imx8qm-lvds-phy' and 'mixel,lvds-phy' as compatible's enum. (Krzysztof)
* Skip 'clock-names' property. (Krzysztof)
* Drop 'This patch' from commit message. (Krzysztof)

 .../bindings/phy/mixel,lvds-phy.yaml          | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/mixel,lvds-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/mixel,lvds-phy.yaml b/Documentation/devicetree/bindings/phy/mixel,lvds-phy.yaml
new file mode 100644
index 000000000000..4bfcc0dd987f
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/mixel,lvds-phy.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/mixel,lvds-phy.yaml#
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
+      - mixel,lvds-phy
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

