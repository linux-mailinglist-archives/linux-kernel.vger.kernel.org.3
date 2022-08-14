Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA85591EED
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 09:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240325AbiHNHm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 03:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240267AbiHNHmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 03:42:23 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2061.outbound.protection.outlook.com [40.107.22.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27C41F613;
        Sun, 14 Aug 2022 00:42:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FmvRFHp+or/bCS6pULtiKiD90Rmp6mlZf+rh/QEFFLLQVOHo8L4WFNASrI7DiVbkeYGczLg58hby2lGoOsnAAF3zp2zv4XsGHVbRpmTpLo/8yI/ws/pyeGepwIZvtcFPOey6MTpnB1NezHbYaAzpV4UcqXO81rgH3G4YGYiX4aKFCeXrerVyixMGLhSK2AFCFvAT5OzlonQFd8KcR6jEZwD45vOmKFaOmbOaGzQtUeyLPsgi9IQQ0MDTGshKSF6HkA5QV7N2UrU5DamzSSvl9deU5sc4XBhcGbUUohTBVweyCZLDTXzzvvaTW+5H+EeDb/+dIDjudS1Rdq06/+t0ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqKqC8AAuS/yDl+DyVKFBybSgaZcMYjz5AdVDUoaKvQ=;
 b=kwtEhIeJAJwcOhq7G1hpvQJgGvQC27dLv2LNfP2k7jn2+pTpp4VUgmhsoNPIUae4cNXuoNUP1/zD9JmAjuxLaVOd774l3ea9RI4MXJFrK+0oemf5G9cAB0IOyY9Xt79VTr4fSPxNt3VydRVxUo8d/rNFv8+BmTIHk+FbwOWXvpJxjbLJ9/SyY0f7opigjXqDrLaXS+yw5xvgzBBfJCnFyb6+JXTNbWzFU21IAVGaJieppuI5TUoE5azLB7En+TcAFYUP75soRcrqBt0uiIrbWmVAE38wOKH1p9QnlH601YIAy6qg0x8yD49pNTkU1hcekWEcC9qMcFzGFRKHKYU7UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqKqC8AAuS/yDl+DyVKFBybSgaZcMYjz5AdVDUoaKvQ=;
 b=atTrgKh5PwEVzCzV3miAERHC0wakysp8X/8Dbd+lLljevnNBNpKYbRdALRpPooAHblkllstbGEXF6EiFulGWkI+YSphLkw1LaWxY9UdZvqQzGjAb7qTMB3eb20DQqkjSs6HqEsJ+6jt11MceTRbUH5O40SL7AkwfHg2fy8gQALc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by VI1PR04MB4016.eurprd04.prod.outlook.com (2603:10a6:803:4a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Sun, 14 Aug
 2022 07:42:14 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b%6]) with mapi id 15.20.5504.027; Sun, 14 Aug 2022
 07:42:14 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, saravanak@google.com,
        gregkh@linuxfoundation.org, geert+renesas@glider.be,
        krzysztof.kozlowski@linaro.org, robh@kernel.org
Subject: [PATCH v4 2/2] dt-bindings: bus: Add Freescale i.MX8qxp pixel link MSI bus binding
Date:   Sun, 14 Aug 2022 15:43:38 +0800
Message-Id: <20220814074338.453608-3-victor.liu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220814074338.453608-1-victor.liu@nxp.com>
References: <20220814074338.453608-1-victor.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0197.apcprd06.prod.outlook.com (2603:1096:4:1::29)
 To AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78d2ab91-196c-448c-2240-08da7dc880f2
X-MS-TrafficTypeDiagnostic: VI1PR04MB4016:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N5rZPb9LUa5mVsRVPm0PjV9L5d9JKgZ+z82HoH5xKGo+MRmEBXkBqY7WWgS0XQ7d2pC8aIlGZ5wvdPg4WqfiRKtupylTuGshoDg1QnRbW1qJZsXrev1pwzU5NubimcNx3pPi7tsNZerBxpydvrqRhCZBNPl02hjiOE7AZZ9mwYzmNAp91hzVHtbSBzkUL0QcMyRUMcW2A6AlpBMSJ7Eg/EYZgCuDjcZk6mQTEmKc6uP2mmRnIN6PpN4usDQsklETNyhZL43dO/ofLTW7+YJ/72kJBtr1NFBrxuxkCLDDXe9DEHQAIgTFJTzgyGhvDdRVZPHpY2j/qvGY9ze/Zq05nP5KO9RF7XOw0YynYmim6ouNxX2d6rvlXkdn95q1ZN1V5+E93b150ssEqU+0firm9xbP5K6H0mwhjWBm1ZD9lkihplcW3qDsqyaoLPUSnGN+756KNFfLx81gqN8Tq5+D0jum7YTm6PCYHpC9ojBGq6RsPSyB9KPuqAbDbdw8kCOZ0aQ1zCaiup+PI9jM8uYq01vWcMybtzQ1UTQQNR5UZzyDRibEyumLwCKwoaKJnA9boNSydRt3H4iKSZliYE02ofn7aOkVJsbI9bCx7TzNqR2qoElLu2kyonVBwG9KHAMc68lBhmXtMfXpQaDIxuMRYVYEv+PFruyatpVTKbKwJPrznZaLGm8FlZ6BAq0Bg0E4Mn39mIaYHBCjcjbKofMZCpIXicBE7o7Rk+gpPOHYmnOaOkm8SHAc9YhgruGhHgtJ+aP80KqSv2GWqDPheRyYXqeU9alDs+MnOw3ouJ5CLOVOsdpw9nX0XXCYQYtJ5ehVWBiLuQIpuT+sxU8wBLnN+4GtpVu4NET1E8HEviUFWLU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39850400004)(396003)(346002)(136003)(376002)(366004)(36756003)(86362001)(26005)(6666004)(83380400001)(6506007)(6512007)(2616005)(1076003)(52116002)(186003)(6486002)(38350700002)(4326008)(966005)(41300700001)(316002)(478600001)(66946007)(5660300002)(8676002)(66556008)(8936002)(7416002)(38100700002)(66476007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6Fuz4GBa6OxqFRFXD/ALo7rhrjzTkNlY6hxX2aPgTUTzQyEr+BpTfaLXmX/f?=
 =?us-ascii?Q?uICWeBKNyNt/xutL4PmiXq6p2x61w8LQiw/h9At4TJRjgrFXX61uI7TK/fki?=
 =?us-ascii?Q?Tb4kFLwuzzeIuYjEiezDw8bnK/CZBfCGO0XVSEFPcwaZCzBbQafVA8uvlgVI?=
 =?us-ascii?Q?9Mgo/NZD47EUTIGI/gv6NzDZrtjJ77BYCEiiGAF4KsSHR9vvcb7uun0V1rPI?=
 =?us-ascii?Q?pYRhJ6BSKx3Ku2b2OBqEvyweONQPMy0WATYicItlspl0f9nzT7BQlWzZ5CLa?=
 =?us-ascii?Q?hZN3MY5AuNP0nutEcERUzp52FbVBhqklSYICsj1ZuLfmgNejfzo3u3SKYRXu?=
 =?us-ascii?Q?VhzMJcxaUA+fsuDXAFc9H/C9D5dzNXLYUbRr5oOmLTQHir4oB0IgYcd4PSx8?=
 =?us-ascii?Q?WHYdjtghFRqxk/Cyr7b97D0V9n4j+Kjyp8XN8pcD5uEhEp7QHoWhKpleCPSt?=
 =?us-ascii?Q?nfsuG+u6JWpbOs7VRYTckrC/2pncyd9XFPU/8DmgX0EG0Fzuw5cZnt6ioPoy?=
 =?us-ascii?Q?lDVF3T+71WTFSXlJFlZt6Ywec1xsX/dpP2LaYhIBt29ed3RM7hvTt0KC2A8k?=
 =?us-ascii?Q?uBJg6AQYbUUcRpMC09OIYWZ/l4T+LnNMBrHyssz0pDgHA3dGBpH9iGvtGgjN?=
 =?us-ascii?Q?7vSIe8thJqWlXl9yvez7MYBgZ2ypXXmFVkz09qhCEhX2njWjpv/y+yDjMnuj?=
 =?us-ascii?Q?cyprRw2pv/hO7nvLwrPa/QKeuC9ndGaVc9BYIbT96l7Lz6rqeo+6U6GAVgje?=
 =?us-ascii?Q?scxSYfy93PGm/01eOnORUMfQZqlCj4Unukd20ujSjKVxALoySWphuZyPsU6G?=
 =?us-ascii?Q?O8pc+gfq7d5iK8FPgb2xMZBv+SuoR9WlNg64H1XpMSVpd3Lgu8Qw/YauKzg9?=
 =?us-ascii?Q?hcb4FR0fNcqlLu8svwbFIoEQndKXHb6qG9/3ZSiIKZa6lh0FotGJ0nisXfrX?=
 =?us-ascii?Q?NG+zmF4TqEzHG35d8eqemAK3jxjm8dZkzgRJd/o2qXgV9e9345MArcaeIvS8?=
 =?us-ascii?Q?fIN/iN5P1rt2GYzitUudq8MiqEdmUzGLI7gkwWPq/BaYbyMwWIRQbU1bu1qx?=
 =?us-ascii?Q?LhxRGsYOczcspmRj65VAz7FQmFJzGw2xcDVYUDlXOA6N09bZMF6v2c3yIxCm?=
 =?us-ascii?Q?JrezD84F2o2wjxvQ5aHrzr2RReeBQ8LtWLICgKjTB9tDZ1KNLW7y7gU7YPUG?=
 =?us-ascii?Q?gshOqhMGjpyBgvzzc77fGw2UPxMsfJoCr5bKIwfr+hTQttzSO1FYN3jgMTPy?=
 =?us-ascii?Q?/cS8OBvNItaMv8WVM8BqaRrBAP7wERtkDPrwDl65OTYS38iGTgOUK9XaZK+U?=
 =?us-ascii?Q?oDhFZWxruxLTsTOM9b1kMKLEWhWfVzv3XxI/5gDHB/4FBdUcaHAjWuNovtkM?=
 =?us-ascii?Q?wxSKO4+OIjqcJ8FTeu+3a+hcYZDj8iY+6w/sjyL8tvZqefiR/v4XC/KKpx65?=
 =?us-ascii?Q?yukV0AFw6WhiDUuogrL5hhjLJEd6BnfTGFNm98wtTBwQzlL5+5nOWTFCOncr?=
 =?us-ascii?Q?LoOjfKg9hrttuXuAKZpKt0VXOzVCR+J25782Ud4cjjNAzAu9eYZ8fTCzS4lZ?=
 =?us-ascii?Q?OQRbf2FcrimXb0fFaYG4SSq1J+ey9r7pTsdWDTJ7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d2ab91-196c-448c-2240-08da7dc880f2
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2022 07:42:13.9754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +M4QHIrEh5oCvWKLl0WaWXfDV3PaDJFr9RBDQb3ebsRaE/6OYO9HfJxrp8f7cYgJtn5+muh8bjQwXed7v1PKIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4016
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Freescale i.MX8qxp pixel link MSI bus is a simple memory-mapped bus.
It is used to access peripherals in i.MX8qm/qxp imaging, LVDS, MIPI
DSI and HDMI TX subsystems, like I2C controller, PWM controller,
MIPI DSI controller and Control and Status Registers (CSR) module.

Reference simple-pm-bus bindings and add Freescale i.MX8qxp pixel
link MSI bus specific bindings.

Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v3->v4:
* Add child nodes in the example MSI bus node of the MSI bus dt-binding. (Krzysztof)

v2->v3:
* Add a pattern property to allow child nodes. (Rob)

v1->v2:
Address Krzysztof's comments:
* Add a select to explicitly select the MSI bus dt-binding.
* List 'simple-pm-bus' explicitly as one item of compatible strings.
* Require compatible and reg properties.
* Put reg property just after compatible property in example.

 .../bus/fsl,imx8qxp-pixel-link-msi-bus.yaml   | 232 ++++++++++++++++++
 1 file changed, 232 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-bus.yaml

diff --git a/Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-bus.yaml b/Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-bus.yaml
new file mode 100644
index 000000000000..b568d0ce438d
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-bus.yaml
@@ -0,0 +1,232 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bus/fsl,imx8qxp-pixel-link-msi-bus.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX8qxp Pixel Link Medium Speed Interconnect (MSI) Bus
+
+maintainers:
+  - Liu Ying <victor.liu@nxp.com>
+
+description: |
+  i.MX8qxp pixel link MSI bus is used to control settings of PHYs, I/Os
+  sitting together with the PHYs.  It is not the same as the MSI bus coming
+  from i.MX8 System Controller Unit (SCU) which is used to control power,
+  clock and reset through the i.MX8 Distributed Slave System Controller (DSC).
+
+  i.MX8qxp pixel link MSI bus is a simple memory-mapped bus. Two input clocks,
+  that is, MSI clock and AHB clock, need to be enabled so that peripherals
+  connected to the bus can be accessed. Also, the bus is part of a power
+  domain. The power domain needs to be enabled before the peripherals can
+  be accessed.
+
+  Peripherals in i.MX8qm/qxp imaging, LVDS, MIPI DSI and HDMI TX subsystems,
+  like I2C controller, PWM controller, MIPI DSI controller and Control and
+  Status Registers (CSR) module, are accessed through the bus.
+
+  The i.MX System Controller Firmware (SCFW) owns and uses the i.MX8qm/qxp
+  pixel link MSI bus controller and does not allow SCFW user to control it.
+  So, the controller's registers cannot be accessed by SCFW user. Hence,
+  the interrupts generated by the controller don't make any sense from SCFW
+  user's point of view.
+
+allOf:
+  - $ref: simple-pm-bus.yaml#
+
+# We need a select here so we don't match all nodes with 'simple-pm-bus'.
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - fsl,imx8qxp-display-pixel-link-msi-bus
+          - fsl,imx8qm-display-pixel-link-msi-bus
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - fsl,imx8qxp-display-pixel-link-msi-bus
+          - fsl,imx8qm-display-pixel-link-msi-bus
+      - const: simple-pm-bus
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: master gated clock from system
+      - description: AHB clock
+
+  clock-names:
+    items:
+      - const: msi
+      - const: ahb
+
+patternProperties:
+  "^.*@[0-9a-f]+$":
+    description: Devices attached to the bus
+    type: object
+    properties:
+      reg:
+        maxItems: 1
+
+    required:
+      - reg
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - power-domains
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx8-lpcg.h>
+    #include <dt-bindings/firmware/imx/rsrc.h>
+    bus@56200000 {
+        compatible = "fsl,imx8qxp-display-pixel-link-msi-bus", "simple-pm-bus";
+        reg = <0x56200000 0x20000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        interrupt-parent = <&dc0_irqsteer>;
+        interrupts = <320>;
+        ranges;
+        clocks = <&dc0_disp_ctrl_link_mst0_lpcg IMX_LPCG_CLK_4>,
+                 <&dc0_disp_ctrl_link_mst0_lpcg IMX_LPCG_CLK_4>;
+        clock-names = "msi", "ahb";
+        power-domains = <&pd IMX_SC_R_DC_0>;
+
+        syscon@56221000 {
+            compatible = "fsl,imx8qxp-mipi-lvds-csr", "syscon", "simple-mfd";
+            reg = <0x56221000 0x1000>;
+            clocks = <&mipi_lvds_0_di_mipi_lvds_regs_lpcg IMX_LPCG_CLK_4>;
+            clock-names = "ipg";
+
+            pxl2dpi {
+                compatible = "fsl,imx8qxp-pxl2dpi";
+                fsl,sc-resource = <IMX_SC_R_MIPI_0>;
+                power-domains = <&pd IMX_SC_R_MIPI_0>;
+
+                ports {
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+
+                    port@0 {
+                        #address-cells = <1>;
+                        #size-cells = <0>;
+                        reg = <0>;
+
+                        mipi_lvds_0_pxl2dpi_dc0_pixel_link0: endpoint@0 {
+                            reg = <0>;
+                            remote-endpoint = <&dc0_pixel_link0_mipi_lvds_0_pxl2dpi>;
+                        };
+
+                        mipi_lvds_0_pxl2dpi_dc0_pixel_link1: endpoint@1 {
+                            reg = <1>;
+                            remote-endpoint = <&dc0_pixel_link1_mipi_lvds_0_pxl2dpi>;
+                        };
+                    };
+
+                    port@1 {
+                        #address-cells = <1>;
+                        #size-cells = <0>;
+                        reg = <1>;
+
+                        mipi_lvds_0_pxl2dpi_mipi_lvds_0_ldb_ch0: endpoint@0 {
+                            reg = <0>;
+                            remote-endpoint = <&mipi_lvds_0_ldb_ch0_mipi_lvds_0_pxl2dpi>;
+                        };
+
+                        mipi_lvds_0_pxl2dpi_mipi_lvds_0_ldb_ch1: endpoint@1 {
+                            reg = <1>;
+                            remote-endpoint = <&mipi_lvds_0_ldb_ch1_mipi_lvds_0_pxl2dpi>;
+                        };
+                    };
+                };
+            };
+
+            ldb {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                compatible = "fsl,imx8qxp-ldb";
+                clocks = <&clk IMX_SC_R_LVDS_0 IMX_SC_PM_CLK_MISC2>,
+                         <&clk IMX_SC_R_LVDS_0 IMX_SC_PM_CLK_BYPASS>;
+                clock-names = "pixel", "bypass";
+                power-domains = <&pd IMX_SC_R_LVDS_0>;
+
+                channel@0 {
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+                    reg = <0>;
+                    phys = <&mipi_lvds_0_phy>;
+                    phy-names = "lvds_phy";
+
+                    port@0 {
+                        reg = <0>;
+
+                        mipi_lvds_0_ldb_ch0_mipi_lvds_0_pxl2dpi: endpoint {
+                            remote-endpoint = <&mipi_lvds_0_pxl2dpi_mipi_lvds_0_ldb_ch0>;
+                        };
+                    };
+
+                    port@1 {
+                        reg = <1>;
+
+                        /* ... */
+                    };
+                };
+
+                channel@1 {
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+                    reg = <1>;
+                    phys = <&mipi_lvds_0_phy>;
+                    phy-names = "lvds_phy";
+
+                    port@0 {
+                        reg = <0>;
+
+                        mipi_lvds_0_ldb_ch1_mipi_lvds_0_pxl2dpi: endpoint {
+                            remote-endpoint = <&mipi_lvds_0_pxl2dpi_mipi_lvds_0_ldb_ch1>;
+                        };
+                    };
+
+                    port@1 {
+                        reg = <1>;
+
+                        /* ... */
+                    };
+                };
+            };
+        };
+
+        clock-controller@56223004 {
+            compatible = "fsl,imx8qxp-lpcg";
+            reg = <0x56223004 0x4>;
+            #clock-cells = <1>;
+            clocks = <&mipi_lvds_0_ipg_clk>;
+            clock-indices = <IMX_LPCG_CLK_4>;
+            clock-output-names = "mipi_lvds_0_di_mipi_lvds_regs_lpcg_ipg_clk";
+            power-domains = <&pd IMX_SC_R_MIPI_0>;
+        };
+
+        phy@56228300 {
+            compatible = "fsl,imx8qxp-mipi-dphy";
+            reg = <0x56228300 0x100>;
+            clocks = <&clk IMX_SC_R_LVDS_0 IMX_SC_PM_CLK_PHY>;
+            clock-names = "phy_ref";
+            #phy-cells = <0>;
+            fsl,syscon = <&mipi_lvds_0_csr>;
+            power-domains = <&pd IMX_SC_R_MIPI_0>;
+        };
+    };
-- 
2.37.1

