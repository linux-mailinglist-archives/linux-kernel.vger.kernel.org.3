Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAE05503D3
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 11:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbiFRJVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 05:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbiFRJU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 05:20:58 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80074.outbound.protection.outlook.com [40.107.8.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70F226129;
        Sat, 18 Jun 2022 02:20:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIbI9omGKAHmDYP9T5VbFwJKGToCVoq/6qgydy3bo9Jxe2mgjGYLt/qO5XWPhcdL35GdvloOFiFEN0bUsgd/+DgwwbFONh+csMFLbShFRxqZRrdgFbeXG8MuU0BnRU34BjVO4IRHE1vd2BaaWBD+Zcj8NGu2HSyvuU1+vV+728osRDOhA1O8sYBr6V7De0Yvku1bkkZT0mUuSrqgKRYvAHvPlbuAC1aEbXlT3Bcra2n6xhI3i8qQ8LeFDbCDay3EeIOo2s7h7gvrQYbM8RusDSYRHwWlkL0Jmk/pfTWbD83nGF8kVS6xSd2bPB8ymCDUH7Ito2WBinxM7WLJlH9TVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RprVZMswvISUBjJJ45u6eS1AWRSE2VgsPS9xn79qxj4=;
 b=eZrCsjvQWku4U2UH/BbOz6+dQHw7/q4t1sJCYCkpWdhlBd6Fi0l05PkJENNmEbtovRAZZ25I/5etx57mLDk58rq9AUW7NS8bevkUxWWefvhb/f4pJg/0oAlzWOYFXjx1qNR0D+MW4n0uUcmuwJ3inlFKfMSxTh+q8ptWbnsufHZgtwM7GfayLCjJYylgoHYWYkzf4sygLeiw4ILdzbw555mpwc+KJqR7I58W4DycLsnfrXvKWCho44tomXvEoWUtipOv2NUwxtXt+aW2wdALhIfXxl2/zwazHLMd3ifhSMhcPNie2cGnzS/UDNv9uwFkUZzBaekW74RUcIx0UAOswQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RprVZMswvISUBjJJ45u6eS1AWRSE2VgsPS9xn79qxj4=;
 b=KHiy98Cm/10ucS8Ic0vO19TqHP/UAEEHLy6+54czG3wPWVjNKj6lhWHU1ljdokXJLebgo0Sjkk0KuLy+Yq5S/tLBe9d3gaPFDCuyiCVDl2bsQyf/CEdVNT0mLAybgA9XprsFyGk0vUYM39xU9yiREuTjEHPcI0KDBE6UmoojRbQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AM0PR04MB4209.eurprd04.prod.outlook.com (2603:10a6:208:62::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Sat, 18 Jun
 2022 09:20:54 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::3c82:f63b:711a:502]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::3c82:f63b:711a:502%7]) with mapi id 15.20.5353.018; Sat, 18 Jun 2022
 09:20:54 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com
Subject: [PATCH 1/2] dt-bindings: phy: Add Freescale i.MX8qm Mixel LVDS PHY binding
Date:   Sat, 18 Jun 2022 17:22:00 +0800
Message-Id: <20220618092201.3837791-2-victor.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220618092201.3837791-1-victor.liu@nxp.com>
References: <20220618092201.3837791-1-victor.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0012.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::15) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e08f44e6-6eb0-4092-28c6-08da510bd84b
X-MS-TrafficTypeDiagnostic: AM0PR04MB4209:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB4209DFBC07CD3865419C746198AE9@AM0PR04MB4209.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bKBypqa2LFAtYKbPcg5lVSGk0Rak+XGxX+FD6BvwxZFNAkQTM+OxqCd8sRvgunIsx77G7bk5kVTOGVeimNHJpx8fLP+yIWHkTsobqVPPaqv12TPcOBi0BwbhEQklLVHPyIMQIY0Dbwna/a54QYaxIDLWbaAYtW7LlgUdurnPSxQP3beC58mIIBZ2UYVEuwg1aJzkMTh1rM93h23llw1tAnModYjOPf0h7hSWTn55M7MupZXHEE34guCaWWrm/xVQGNx9faIkUIc6nqQtGdlWhCrRdeABF5qVjWa/k24KSLU5cTL/YR9+TNsp3QZJ/WB34twOPcqYoTDs4t30seBaK3hBZeGDxIWNDxcTkgBsnopgvmqbL6ZDmY7iXAoJ0Wq2v6xMF+9nzC+e73b9j+QF0xx4KoTk4vcSAA079tdWB+LGJIp0ZprvG0ZondXWKxUa9+8NURXBChzXzX+7IZg4sVmr2YjST6pu+4MZI75rbCMxaURpBp86EgB4lTGfgP4vvGiMpN+Godv2nyR+WCPPxFdWwipsvbu+crJ9UKuC1ynRzp17RMVvfBZDHJrUi6sruzazridXsrQUMDdGIS9KZN8BqQtf75CXbGaWKZWD43xYbcWZWyGYM+1eIY8y6ovED3qzDTU+erlKsR19ui4dcGZVT2TbpKbu3A4Fxk6TLxCJogu3nD5mZn+BRgOYo2Dvs1aFLxua9WspmphlGOFU2izDw9MG/VqkaXJUh0ecGi5UNcsSV1VwMLgvmbO7JgwPpP1OVwC4y5JjiD5JjvRtZT0SfABq5zuso5iGkrejgp9umU5UQ7ak4IGRrlDWeOSZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(186003)(26005)(1076003)(38350700002)(7416002)(38100700002)(316002)(6512007)(83380400001)(6506007)(2616005)(36756003)(8676002)(6666004)(52116002)(966005)(6486002)(86362001)(2906002)(8936002)(66946007)(4326008)(66556008)(66476007)(5660300002)(498600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YM4GPTkdg9IJh36iEng2lnK9loY8KlP/kbFLvy5M98Crr8GiaCzagtINwKox?=
 =?us-ascii?Q?JwUdnJtRgnXuT6ZsORZmb0pOLZJn4LeJ2Dw9MHcLKXBB+tI3KJMUdYYxDPuy?=
 =?us-ascii?Q?xKAzZ11en4fK8J14JtTSCEXBlj7zYgPj3PebreyDUNWAai+yoMnS/ygvKXqw?=
 =?us-ascii?Q?dB6nbIVMdpg2FsWIhzj/0yuFYRIlBlr7r+WWeTWlY+bGzdGgN0EvXbjGA0y7?=
 =?us-ascii?Q?+y5/bwAz/Gmvv2ZeLg6ka20kfxbirHywhv9lJ1si2gpyFDfcTpvfUp9FqFnE?=
 =?us-ascii?Q?8TTglJ6056D48GWSD3umn4/Wmnt63I1Nn7e6Ft+Ri1kFRL2eZfRF+4AJq1AC?=
 =?us-ascii?Q?OyXpHX4Gg6aGMXfjfM1tv6YqbziLOLqHBZ3myK89Rsp77qRkaZ0A2P1xg25G?=
 =?us-ascii?Q?EeSTvohkdAQhzbjVHgA/NjmuI+fjeL8hO5+ySNdd+I8F709ng3ILGAcNn9Jb?=
 =?us-ascii?Q?kZU4oqPVoaAw8YJRxInSA4AMVBxfdR4KcLOHDq+pg7XDjzLHIgn/wqLFXmna?=
 =?us-ascii?Q?IyOWl5S4NQmVNvIYhMf9tymoB0yookM8hAjnjScpI+vGotjHVrKDyowYEp4A?=
 =?us-ascii?Q?QEtUA1bXorbYXe1SPeyF7Q7EQh93f1CvMm3v2oPDSZaz0mJmdSGIIcelwbeF?=
 =?us-ascii?Q?v4mlh6+3ih0wiJlMQb3etGzpIvdxubVNRU4PQANOQXAqOOdm2in+iBC2VeUJ?=
 =?us-ascii?Q?F3iS/j+BJxMM1HuRH4FpTmwCDHeN1/VECitjJm/dvaVMkm+kJV62LndRv9nI?=
 =?us-ascii?Q?m0dwZdESv1WdIDyhkEs2A0A0dMDGjwdC0e1Eh8qqb/PHAC276w5g3Y+dr0GP?=
 =?us-ascii?Q?UDBpHfQhLu8nTjirhShf5kgk6UY8X3nuZGgR48+BbqwPeFLXKhFARIbZT3Sf?=
 =?us-ascii?Q?CZ3cghcWTdB2j0NXw4PgaZb/DSXVXzLLuiLcsUZfO0nqgB03swA+dFNL8+k7?=
 =?us-ascii?Q?41XkPC5htoQ5GiuCq9t9x4sU3g9hG08HL54sr4K+FtM7Tq3OAb2RBz/N0Fsk?=
 =?us-ascii?Q?EyxApoNRIrjM4/JNVIu6v4BtA9yVlvnguEh8tet6KnXyp2wcJWrXItq+tEVC?=
 =?us-ascii?Q?kR8lh2y2RjGiNMyKgI1fkETSNLJ8tTN8GK8+OEJ559EfRVJVIr1yoCC/hyI2?=
 =?us-ascii?Q?Tfkg70pr7B5QWhoZYKvAVXcjiddxFpLdgZoF7ZPXOZ+Cozod0IMEd3HkBwKO?=
 =?us-ascii?Q?V4RbFNMf4S+TlrATCe7QT5pvtFLRKIzfssnqJagrwD+7G4WKF8NhIYlwj5f9?=
 =?us-ascii?Q?fIj7Xhfa9t5IQ5p4grP5F8AnqrIPFGNrQ9D5EQ9HL5njCSKc3Tmz5+sbW/jZ?=
 =?us-ascii?Q?W+d9IOxknlxQwq6FxQfZ934E3zvGinSGJ2L0h8YdipXN2/3V31LZi+1wb0kA?=
 =?us-ascii?Q?3XQqWE9jKt2QxuMeih1cElamGyaoDxlyumL/ZyEj9phmlGayT2Te4Y+QyBUp?=
 =?us-ascii?Q?pezB5PoIlQjAUA4vZ2G+ylpzzHeP0Ee8+GuCQft0Pv+ZylFZYCKXxm9764ZB?=
 =?us-ascii?Q?goYRWG6/uY597kRNdwbjXLi0BYnSzGuqyRiWh/AN8B7or1pJAqbfFOo9U5ob?=
 =?us-ascii?Q?7mgeZ24T5gAdugDr9pTiE5Ow3Hq1B2InHRZ8XpIKDvbdVSTaOtbVyf20urJW?=
 =?us-ascii?Q?Ux8/5CQB2uvE5s0ZelfVPFP3hVewV/D21m2+w3NwYrwyrGsWJPI6yyZwEedc?=
 =?us-ascii?Q?04/90mMAqd+gXmiGChv0ry5jT0bH1ArVwP3/LCms1MvdkySrQHMd9UxeyAUO?=
 =?us-ascii?Q?ru/+mNVlbQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e08f44e6-6eb0-4092-28c6-08da510bd84b
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2022 09:20:54.4452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IFWjDTcz36evyS0KBDW+y5NmD9Oy2ONMblCXiiLUr7k0oGY0vOKWeZt3IMBNFOuAA7CeXCLkggClqDuvXXdyww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4209
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds bindings for Mixel LVDS PHY found on
Freescale i.MX8qm SoC.

Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
 .../bindings/phy/mixel,lvds-phy.yaml          | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/mixel,lvds-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/mixel,lvds-phy.yaml b/Documentation/devicetree/bindings/phy/mixel,lvds-phy.yaml
new file mode 100644
index 000000000000..de964ffb9356
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/mixel,lvds-phy.yaml
@@ -0,0 +1,64 @@
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
+    const: fsl,imx8qm-lvds-phy
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
+  clock-names:
+    const: phy_ref
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - "#phy-cells"
+  - clocks
+  - clock-names
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
+        clock-names = "phy_ref";
+        power-domains = <&pd IMX_SC_R_LVDS_0>;
+    };
-- 
2.25.1

