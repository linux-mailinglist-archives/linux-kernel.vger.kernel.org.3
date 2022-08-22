Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E90B59B8E8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 08:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbiHVGCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 02:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbiHVGCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 02:02:16 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80078.outbound.protection.outlook.com [40.107.8.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFA61F624;
        Sun, 21 Aug 2022 23:02:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPm/hvk3C8rfbX7hgJuSSV98q7BGlezZwZ9s1qECbWP5of5KQxcv8k+sFJKZjZxZuTbaa/33A2X0vodtbi66p7PXJws35n3jtCpRMFTapY/i89/4WS4ilzDH3c6fd09khCVLhFmTMjTZp3K6Jbt/S/C3FCf60To8U2OczfPD/vXXWH/bbkcEwUVLMYzdvwcq0Lj8+pATqovd0qDPy7EVMK5dGm/o+k8ZHpOnSp+mqk17JlLjJypa+/NqY18XSvmtC1mDjBvHNVIM6VU1rJ8YUOuGkoHJMH0Kk3m96Rp7k/J8iBr73nS+XAGRps3qAZO5mDbdwpdzs5y821G4SB5haQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5Qz/xZ9bzxPcMnxHffUArFRPcezeVaXDHcoxVlcbyA=;
 b=lPOIWDUO7WsuQD3TwnF7wO1f9oVcC8GXtv06nRTZ9oDrndrkNGcB6UT+ogCkJk50y1xcNqHwNDhg9JD3ubaojAiplf7rXmcbIehrY1C2cG3Ld07Ousu3kamnKEeeZEchY3X706E/cTz4aP/gVglEmc6pJcQymjDYneK6hgsWDqCKWv7iRE7xdHkTEwrLWFT63AuytdFKJbbuKhErlczfYHDX0dTT+BmBv0bMipTdPnw/hDuDboi+eabQF3v7stNM8ektDLme1a3uVhBrBdG4z4NPTMypWoT0tDyaceju0bVRGoCizM4ADIzYpzBkXhH0tCi9oJvjnv7e7E+z575ZAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5Qz/xZ9bzxPcMnxHffUArFRPcezeVaXDHcoxVlcbyA=;
 b=P028fCw7Bg4pHmLSTmOSc6sryA3yvCwp7ctt/qon1mXtDTqoFMFs2vyWTdPaQnyaVjFNxG7zcDoMCGp0v4kVtDmq7AizCF2XBz89d1lqxrjk1Nyrq/PQJx9TT815csanl+MYRaWtqHQTNIeNyNtEk9iCAByGaalQfFG1UI2vcR4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by VI1PR04MB5135.eurprd04.prod.outlook.com (2603:10a6:803:62::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Mon, 22 Aug
 2022 06:02:08 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b%6]) with mapi id 15.20.5504.027; Mon, 22 Aug 2022
 06:02:08 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, saravanak@google.com,
        gregkh@linuxfoundation.org, geert+renesas@glider.be,
        krzysztof.kozlowski@linaro.org, robh@kernel.org
Subject: [PATCH RESEND v4 2/2] dt-bindings: bus: Add Freescale i.MX8qxp pixel link MSI bus binding
Date:   Mon, 22 Aug 2022 14:03:23 +0800
Message-Id: <20220822060323.3481384-3-victor.liu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220822060323.3481384-1-victor.liu@nxp.com>
References: <20220822060323.3481384-1-victor.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0224.apcprd06.prod.outlook.com
 (2603:1096:4:68::32) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f042a092-cfac-4945-4080-08da8403d8e7
X-MS-TrafficTypeDiagnostic: VI1PR04MB5135:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5daS7exzWfOppEjens1wYwdx3F0uin8yUi1yvxIVsOODlWYT4/a/ohAz18w/z3kaTPkY12B1iPL5BJO54HMcAk9RblqnhRxjxsgwfuB0SSUInRU9F031hxZuZRMw/hGrirKBGdPlwhM5Iftx5/zb7ZxIwDiUN90AijPTZX0ngfaj6skF1rSr7o69HyhoInOwZTRvZri9CNsGc4MbOKb7B3JDUmRt5Ol2Dn0zML3HpFg05JH+uZ9CaYEiiT3yHFXofX9X2HoZsK66HXxAmskPaeSGNROLfnxonw6RFvy0EZArZg8TAM61AhtRdY8U4oqoK6IAPRmJErEcdfAijiJeMACVqvyCxF0alHC1osDwUqN8VJ1QOc9nFS0fhYSCRNYOmcAibmyn+dMXn/tdG+F8279fdPZ3tjTvozshj29YDkTY3dCnPNTVynY8ZXM9cVesN/eMt3xbO7kuEFShi/FyVV16IvzSchhIbqdXP8fdr8xogDc2CEN+pDRtij7fJOlfrJPikOKX+DYoIMC1aoHDvVWIVUS8WicfY2cRruLKTwNfUPOv3q8sVY7/u47PA309i4KfurVTw4DzO/SJC/tK2cgI7bneEIao5yH5QFE9365pLJXWTqcu6BkwaJx1ZhIcPK5Pz3e2tGc8+gfYuMBM/9QyXSpcBgVs1s+QCP/tvSbyMUtWYRm5sqA2jOOW/aFL5eRHoRGCVdsdrHJ/ydmPQDNKXX8h7YjYjDhHu/yafzn8Oy6ANlrwBsLNczXHi3Ltnwa5luD3T9JN5Pd8obbh+GL8KDYxZAnHOaf4Gss+Di+2Z52x4+UuvBeAUrAtgided/OPkqXB7884HrdNfO4AJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(38350700002)(8676002)(316002)(66556008)(66946007)(5660300002)(7416002)(8936002)(2906002)(38100700002)(66476007)(4326008)(86362001)(36756003)(6666004)(41300700001)(6506007)(52116002)(966005)(6486002)(186003)(1076003)(478600001)(83380400001)(26005)(6512007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YquB3eBW35wzSQsKdd9zGVXHI320eou4eaEzrGfS+f3NT51X3nGSFHIJ0tYz?=
 =?us-ascii?Q?vT2eSIgrWPvaQpQN17755+2rZdw6E4uOViT9g/pFfr0EKHZ4B8yfMRfo8bbQ?=
 =?us-ascii?Q?PwXyi/a2PlO9uLrP3cNbCHTqTUfAi4lM8MJbDrs6zcs5nWXaq3DqedpjmEc+?=
 =?us-ascii?Q?jtFHEMIDsKaoylaner/7ihlRw0iktx18bTSUKCytZ3+Y3AQKsM0UWWPFADvQ?=
 =?us-ascii?Q?GTr9zsAd2B5WEc5Ra6geWj5c7UtCSUkVhcE28TaB4pxOKqvluuvrr82V2mep?=
 =?us-ascii?Q?yiN+tUtihcKBIDiqEmbA7/KeLJjvS12VnIhQqAktkinS6t0eHAF5Ze0C/tcQ?=
 =?us-ascii?Q?6OJBpxyRAphl4Uo/YdUMN1lbdvxBW9EkDBREcFyvlu68+zc54rg6M4D4o7UP?=
 =?us-ascii?Q?kdELo8KKRDsp/Ald0Q1gWXk67m1mrMGO7+fM3wAxQ071ZVBmNtsDteMk7FAX?=
 =?us-ascii?Q?waMWS46Ydph6ZZ/vdXEAUzeaPgpSXovfM8YT8ihI9f6nygfI73MCM3JpSCnK?=
 =?us-ascii?Q?aFOkJj8jAK7tKLnho/qn7mmNc/xQu2YyXnDFgV33OXDea8Yi8wmOEBzKo3hA?=
 =?us-ascii?Q?wfh830pYlxfYm9qXLRsaqLOFiXAGE6ijlp4O7Aof3Gk6LGoOlwoo1rmUTM4z?=
 =?us-ascii?Q?8b9A5FEzYYcU2qjvCmPa67illQlvZtsFu/zHOnqbITVQLA8MNGovq5AcAfP1?=
 =?us-ascii?Q?W++9FcgmhVFtpIV3wJ0PKnJfamrnZuQGOwjY/warG6zEsCa5tN2DgFJ3hYsT?=
 =?us-ascii?Q?MyUl2GXEDVS46LWqs2iLAvyJdHm6oa76acnFXjwvqUU5q1G3w8PEUx3/uITe?=
 =?us-ascii?Q?wHY9Mx2ercUWEmf89DLheyTbZiUewy3jTQwFz8xrkRMFrQixkZ0sz5xDPTsR?=
 =?us-ascii?Q?M7/Jc1MBJy9aaN8n9kNiEdbFd3mls5pVroFmUtUfTjNTq9UFcZ8hoU+Fl/QD?=
 =?us-ascii?Q?KHvLkdnn78KFJI53j+v7Vxe1+BwERZT+AvPxjWyBhyBQ2DtIVvzpCHpZ68tC?=
 =?us-ascii?Q?wXi38OCw/aPUCXWInmseMq78naPJXDcrDm4GNYFE7nFA+962723X0ajGEbbA?=
 =?us-ascii?Q?hEfsuRdtkyPKTeoIzqG14PAWBa/7srh5C64v0hxOg+wYsZ9xW45Xzfck5pzh?=
 =?us-ascii?Q?LY+C117zOQuicTo8gNhhSXw73K7T3ex2BHwA6Ju8GXdwFA1dyzlgRRQTdbOJ?=
 =?us-ascii?Q?mRh/MPrKRNg/BQ6f4fGPzuNZC7zfrTstlme74XfEuF6VYrwzTVOHVvAZFt4N?=
 =?us-ascii?Q?1k7ddpRkoYYlc8ZW6iUkPB2RyLwQ4e5VHmiDzMVMq2djIoY/XQK11xyuXaC8?=
 =?us-ascii?Q?GYvZw516wrsmY9ZCQ7QDLuadHo0dXdeoYC7mYrUvLiSiQP17jPqqpt/IzWHW?=
 =?us-ascii?Q?IVkx0HmpdicccsdaAJrqpUiRlKwdYsGIRGIN0t2WjHhaADQPx46VSFtmZUfT?=
 =?us-ascii?Q?1srNu5TjSehSJ1NF2r7PeW5QzJPPAL8empIDUKSuta2T6CShakIYjGuCLcbo?=
 =?us-ascii?Q?DMuONFaTVG9eoeU8kKruveC63UWzJAcKFoxINnV9uxBlOHOFNRV5NR4HCL8e?=
 =?us-ascii?Q?6UaYqIU4IFIj8MZz2GMkP16pLyZeiiYdyevUYHFT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f042a092-cfac-4945-4080-08da8403d8e7
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 06:02:08.7816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b5K8J3SNOn+S7Om8r7s+WGZ/7epQN00OWr3EwiuNxF+ih75yzYUvtnkTh7VESypFfXfec7rGqM45W6gsT1eudA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5135
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
* Resend v4 to imply this patch is based on v6.0-rc1 so that there are not any
  dependencies. (Rob)

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

