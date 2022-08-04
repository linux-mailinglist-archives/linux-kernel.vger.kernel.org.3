Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBAD45897A7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 08:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238989AbiHDGKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 02:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238997AbiHDGKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 02:10:17 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60075.outbound.protection.outlook.com [40.107.6.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1EC2DDE;
        Wed,  3 Aug 2022 23:10:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WIl9RYFpo+cF3HvjH0micAV4mT7B3JWiE3Ktbw445q11QoT3d3hqur8xOk3Jd91v65X+3HqdkYVhrtWAzuJuw8pVWjDMD+AhkQyP/4tKJyN32aY053fXwDDKY+a1eztTNlzT1OnU8bUDSKJqHFrv3jSRjj3cP7YSjuwmf/5kP5ljL8DwCBpNbrbtyKEN05TTu/1EsI1ZHPkpv9zCgEcctxBZyhPnyKCMqZKjjuFl8asQypHhLySWIIvcNYWCHSh4cw/KMMNdq65BB7oq6zcl7+EOp9bnQXHH+s2wXRRcSD+WI6BclLT8x+BG+Fwl7rPyse506AjpE/iBjFhCFqChTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4BQGKeCLn9rgRYIv8E0vnMF/lAYZtm1zchHbCVzbH7o=;
 b=FpafqQgaKT8wBdtO7PqKEmNlnEbNpKxKzlABBoVCtbU2Z/KYltksiENEWua6T7+JlIfRXZDPTcs28qerrVxUCxmXoz7eJt6OHenYJQKiMP7/vK9ZTTa1jhjogLJqy8gS1kimKa28nH50FIMDsduJoa9ksTuPpsuFOWs6aXcGpdhLNs3jX5WpUMQlCnwk6TGNKLOcpi+zBcFy7PnDi0dRNLhY252c6H7C64746weTPypdby9/BqM/NFy0iAaAGK6b3YI5yujibCXZpOkkpgUbAD3FtQ0cJw2kvva7U93BrvLSiYiHKY7uzAwgcmz/l3e7yPHPUOW3vC020crb7zBA8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BQGKeCLn9rgRYIv8E0vnMF/lAYZtm1zchHbCVzbH7o=;
 b=kg2jBJXA4ezt2bedfapmhx9uu9EhL56b66PODvwtnWODQpJb/HYQlqqFmkiPxIbluvytHhuR/PSZIHJ2MFVqPdBYwsgmL3/6WmZMMwdtMYeHm9egdsw0pxElBHnP7OXk8SFGFZUZAWhwIUxLTxhUyjnOpWpAcWXquSrOHNrkJoo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by DBBPR04MB7721.eurprd04.prod.outlook.com (2603:10a6:10:1f6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Thu, 4 Aug
 2022 06:10:11 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b%5]) with mapi id 15.20.5504.015; Thu, 4 Aug 2022
 06:10:11 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, saravanak@google.com,
        gregkh@linuxfoundation.org, geert+renesas@glider.be,
        krzysztof.kozlowski@linaro.org, robh@kernel.org
Subject: [PATCH v3 3/3] dt-bindings: bus: Add Freescale i.MX8qxp pixel link MSI bus binding
Date:   Thu,  4 Aug 2022 14:11:33 +0800
Message-Id: <20220804061133.4110734-4-victor.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220804061133.4110734-1-victor.liu@nxp.com>
References: <20220804061133.4110734-1-victor.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3912b1fb-c19b-40d4-4091-08da75dffd4d
X-MS-TrafficTypeDiagnostic: DBBPR04MB7721:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BINWT6avB+B5tSFAEm+nC5ngFtfF0j5DZ5M3jRXYrZ5x98U8s1Tjpn10Ex5X6myJGfgj5j8qu0PUb7ZopcZTX+UTtuXpK7cW25RkWnv2ng2ZPgGy6FF5OizwRGLeHnTn6JsKJWVbkU/bnZGHQJwh81xkD1VfU2HlbB1lnzH41SOI2uQXF8cHFqWO9WBwGsk98jurNX0Ra2NID3A5cFf0zdjo5Z/ngq5B3HnngoJQmQS0WQfmUOObkYXKfaYeOFSDoxgVNjFYas7UzMQm/lre9+8shGot/ACsEx74RX7Qf9f33IZ4jyULPwIv9RNfMhZVyDPOpe6RjUd3fBSp9WLTwvQvrQWAx1qxjIumhjLVgWsHXDqwg/IGd2FUiwqPohy17cUrTQR60V05UNfufkWVJIhzLX4pB91wCPn5SuQiyh+17qgOvvI1L3hsSAkKA8Pfij8LTBh74Itl97QWd+03aZJMpbZfX8mXaYAMYtFyNyJ+HK0fPVnNiHaIABjLVvj8NTGcDidnK8DH9Uv//Q/nlp1e0925ssjdrGpCagkM6OGYBhboAr+2v58Y8EuPXdFmjeNs0RnriT5R0rtQXjKK5EyPE4/aANBwdwXXLoQSRkThAlHVvkhss1D/1PPVUuMnytatXMtmDmgXkXRqeDA34aj9NzswkoT5Y8H1llFJUEQ6XbY2Seniaa5bu+4gruRjzQ+GwEKLNHu1kph8i3oCiW7aEuHxUOZQc1HLBW7lgExgPVJucSZqqpwR7Xgns58D9Xi3SR5sR6ld1mjgsG18/LRQ0ocBvI0DDfsGNW0MygKXY361tMpY4OZ/7wWe6O0QIw6HagvByOonZ1Gj9FJXeozijknE0WguZbMklhMaf2I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(52116002)(6506007)(41300700001)(2906002)(6666004)(2616005)(26005)(86362001)(6512007)(1076003)(38100700002)(186003)(83380400001)(38350700002)(36756003)(5660300002)(7416002)(66946007)(6486002)(966005)(478600001)(4326008)(66556008)(66476007)(8936002)(8676002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KuOyzh8e9MVYcXbDY/VM8e1doXV5oSjj15pBxpfegmA6Qyj/Y8PmXDx8nZPW?=
 =?us-ascii?Q?K3BXrPujvzbqnfk5zXNwMC18ZIauEpEvqkunlBt8F/6F70+HkJIHIEyq3vGC?=
 =?us-ascii?Q?fE0cjLX/2Ice/6240T7GvHcjhCN9hkADu0vzZc12jK8PzNBfszAefH95hcGk?=
 =?us-ascii?Q?xYP+yfldRV+MeOXx7vwOAy/FvRUT9NBDc+TIXaPLBvghTPImUNR8kUdznU92?=
 =?us-ascii?Q?MgtkGjtMooBw/TXhDGrbr43Ibc2jrRAKVS321vnSKZZXY1LbwfLX6aVFzI1J?=
 =?us-ascii?Q?pOXSrbc1hkU7zGlEcfL4bpDZieGD0tWmfDTHoh8YeQjCMXroEd+OxNI1jyDJ?=
 =?us-ascii?Q?alBDdWvi100ZQtqctIY+KH+3QB06zjUQUXc4yj10T6/KIEFvSy2KtA4oj+Tf?=
 =?us-ascii?Q?O7TN/OWBNsh1wXm+9G6MfJmMK1BL/WIeCUQ9LQH8b6Sr13cP2Hlj2qb9Hb7Y?=
 =?us-ascii?Q?WONOq8qiWTQRthREzJJLwVseutQXlsQSmFM5FmyufhqtNPL60mU6ktkh4BUY?=
 =?us-ascii?Q?9Z15mOd3hZVAk5p1MrMFAhk/SdFMsHquwaJwejx3G6wyEepG8AJ7bGrsSRqj?=
 =?us-ascii?Q?G0r+tJoKG6QaGbobB5Q5vkNJPU6u30D/6DEeUv5FeI2qzdTyHAzYMqAPvm5w?=
 =?us-ascii?Q?qHmYsdDDo+BeTK2LD9adumDChRNm573eiYJhQ7caEDQPr+TzfdymcIt/G/dd?=
 =?us-ascii?Q?5XZVRoADLk0piDAT8u4Qf8DnZY0M4n+HDFG3lfIHukzYrQx0tuhYsZtvpwvY?=
 =?us-ascii?Q?7pwUjLwbrpho+uQDjcttL1rlfW4i3Pxxpxot6vq5luQBXm9GTIPV8aSBXCf4?=
 =?us-ascii?Q?P04qDY+1XUnWnGRi6PqWjhEedeumXGB9gd4LW2F7eJ2s+zZB0lD2VoIVE/sw?=
 =?us-ascii?Q?oMVK5VBoNnmbMlXJXZf0vx1LMK7t6LZMtBpDrzR/T73WKGD4lIxYtQ3V5zuE?=
 =?us-ascii?Q?U+wRQEOO64SEJqqgZnOeejtp/L4o4Mn8Cm3sCPK9puDWbmxrbLdXUI090AE5?=
 =?us-ascii?Q?ExJSXS27qLh5/3OSi0yt4TRtpwAgT3/ofIotNzhCzJvrgVstZzyiTZaJDI0/?=
 =?us-ascii?Q?NJaLAayl3BZlYL9OGTHHob8WAtBMBjt1e9YzeEdk66pD3UcvptvuVgWylZpa?=
 =?us-ascii?Q?Oqz5wQG0ZdmhoXI0/zctorRpxt+cl6hHI28CatRjA25cjCeuM8rgN0qn83fa?=
 =?us-ascii?Q?5aZ+GMnnMHdMuF9wPiYKqLifBzxqomJFJLffR+dJnYMxfsmQutm7Pg9aw8Bg?=
 =?us-ascii?Q?W68HH+fptRbjHsr7N5GadQtQVow1yiQAOir5YkloSgAvFQg05IFx8y7e25cn?=
 =?us-ascii?Q?L/88o05uSTSU3jLMzOd0R+Ypr4ZzvutLJxPPuBaCvOKN6leI4fUBem9rGkEo?=
 =?us-ascii?Q?wYjU7CahVdZjdfWQZFMEnTISEtTv3vcLYpPNHdFmBUrQobC8Vmib7MSPcUSM?=
 =?us-ascii?Q?xtq7O6LTZjEG7W/dsESP7SGX+uszHJgFVnzd0ERjMDucYGILgYtTkv7OPvzm?=
 =?us-ascii?Q?t13KbkqZBxe1/uT+brCjElPO2aQfE8jyE83UxZ47ZztFY0iQGp2ntmbBb72p?=
 =?us-ascii?Q?zuS5Tc4onAyvA9q3yCLy2iWlt3dXYz6QGSTVFNY1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3912b1fb-c19b-40d4-4091-08da75dffd4d
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 06:10:11.5763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ptahw9Xv3CIibqpRjIsNYbzuF9KbljqH/H5K7Ylmmsv0t/DillUnCjnJTUwKrMy34aa2RlFba2Kh54dGt9CMeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7721
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
v2->v3:
* Add a pattern property to allow child nodes. (Rob)

v1->v2:
Address Krzysztof's comments:
* Add a select to explicitly select the MSI bus dt-binding.
* List 'simple-pm-bus' explicitly as one item of compatible strings.
* Require compatible and reg properties.
* Put reg property just after compatible property in example.

 .../bus/fsl,imx8qxp-pixel-link-msi-bus.yaml   | 108 ++++++++++++++++++
 1 file changed, 108 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-bus.yaml

diff --git a/Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-bus.yaml b/Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-bus.yaml
new file mode 100644
index 000000000000..9fc6623a7061
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-bus.yaml
@@ -0,0 +1,108 @@
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
+    };
-- 
2.25.1

