Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E57588563
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 03:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236332AbiHCBXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 21:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235999AbiHCBXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 21:23:05 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2048.outbound.protection.outlook.com [40.107.20.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E912F564D0;
        Tue,  2 Aug 2022 18:22:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fkId92v57jIKEJwwMYxkuHP2GirEGNBbhVYOQ5W+RmT9xu/K+Egw0qsH2LuX8B02PttKGZ0OPo6tXymJ/TaY1Rd8DwEbPa6j17tCIt62Xoavli8HkA8x/RJWuoDHxPtNqC4PspF87D6DvF2DPrrTe5awoJEjydxFb7YOZx5JbN+kV8wC9KO1j7l9Wk3VwP/E76s1KNfuVcRaCmpHnTaVzvAW7EVlGspHDISyY/Mu6GrXe1NpnMZKvqtHkd8vRhlOfMucJoo3L9d+wSLzMrnXVMmXAaFJfoV/pXwYPHGvVd4Z5Rxp2anNlbyWp0priJRSDw60YSNSD6z2zG3OIRUGNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1JOPxCBN+pi1hwpL/IQdZuM5jbLdNYmmlD0GppIt5Y=;
 b=LSHKhdfw3ZqUb3Th7cHQfW9RfmECnPN18nk+wcG4TMQNUv4ME46GWcWjvy1ybUHa+cw3pXS6M5UTVNS2Iiglceezemn8mIqk5k/iUAosye/a6YByRtzrfxblEt2ttesoQeH8Kfly3BhoetKomKzEi6y3NOfvnsGlgWyrq76BggBYXvyfT9FvjcRzYJh8fKygSGLI90cBsOQTZGNf/BtzRH+gFNvguIAmAl0E5WWtt/nCLxZiGWP8UZVwygBP9EZu0Es9dYXtoamor8SpHUkhNygGEBhOguVb/ni9k8j4Wj8VPzp20nkTqt4ank9WFqjaQGVe3SExf71yLbeTyFhiig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1JOPxCBN+pi1hwpL/IQdZuM5jbLdNYmmlD0GppIt5Y=;
 b=jyNxNYMh8srVKPzx5b98+xCqoS/0jB66r2kk2z02LJjtTqKS50QdG4/kUjk+HnqbdcEcKr8Lhg2iA4zq/t8ovvgskoBzGPyiNPB1K7b+QwGLL3xOZJxsXxj8/N2U1lB3YedYXSFm88F0LpbGjNPeomzxOT7NA58CL3AFI+DrMf0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by DB8PR04MB6891.eurprd04.prod.outlook.com (2603:10a6:10:112::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 3 Aug
 2022 01:22:57 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b%6]) with mapi id 15.20.5504.014; Wed, 3 Aug 2022
 01:22:57 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, saravanak@google.com,
        gregkh@linuxfoundation.org, geert+renesas@glider.be,
        krzysztof.kozlowski@linaro.org
Subject: [PATCH v2 3/3] dt-bindings: bus: Add Freescale i.MX8qxp pixel link MSI bus binding
Date:   Wed,  3 Aug 2022 09:24:21 +0800
Message-Id: <20220803012421.3410226-4-victor.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220803012421.3410226-1-victor.liu@nxp.com>
References: <20220803012421.3410226-1-victor.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:4:197::8) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7659afe3-4880-40f6-8393-08da74eeb26a
X-MS-TrafficTypeDiagnostic: DB8PR04MB6891:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bW0V2Smnpyngxr1W/jg8AuSRInYx/V+kr9FHsf0kBQfBYSjwwrVJjs/1ci0BWUftz3lF9B0qTSpwKFpt2vscxtkmwSRJ9UsxmIHtVAddEXkv3YEku4urUVLVUJKl4EVviXxcb1LYJtI2sEc/yNNguRG+z7nQwcGYSVm8SmGF86IMjkJ+Cs+fogelaAH1CNJb1G5+AwU1H7Qqxhry0FnY4UoLHZ/BIKm03oJe1vUwbXvylLjD60Erdy7n5wH7u3My4uZaOVc1OnbKwa/HoTm1dhkXpnr/f966AeWLpx6DvBfjzjm1M5RHaWRozrFm9joMs+yOMQWPgkTwkNm0mxb4pd1ECxi41L8zV1M91txgmWgwAD4ZflRV1KrlcEPQbyiOg0KN36r/gl0JEXSgOeMPs7fNsDStTBUNwYAJ35wDWIkCKTs1m/w7dM8LXxpQcQFVqDnhmatzHrD4rg0SLPLJejYlKPJwZ0WZdkGsJF2X01kp6/xdhOcOAk3VsjLzc4ebKzlWAOrptobBZThytvizO+s/hytI9T5SHIEtiwd2rTR7OcZziKb/9MvUzl4Jt3bxN+uqIoWbVzQeVKj64ts3mtwuCRWDNVJODoN89FSZCEWoeq9V5fDRaN3d57r9ULdV/umj5SCF6ccisLdz3mbGwISQ7FLm4d/V9e9NTLrGv3NAT2385M6oWsBzj3DSNQwcQJPA9ge8/GCgm5LNY5l/X0t5mo7MKs4ny8iiP9v4DiUmq9ADTPnomt+3s9VUM4gaaSsGcoPQwf1A8ix605qJK5xMhs2qkedPQT0UAb+4hwGMOrntM4YgGTyFPO1fJB8df2R7WD0h86kcWOehMkI0Gj+fNt4rZmyU4JY+o7AWFb8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(316002)(86362001)(5660300002)(7416002)(8936002)(66556008)(8676002)(66946007)(66476007)(4326008)(26005)(6512007)(1076003)(83380400001)(2616005)(186003)(52116002)(478600001)(966005)(6486002)(6666004)(38100700002)(38350700002)(6506007)(41300700001)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nSKcYp1lOiDcpcvOt2SALyMum/EmPFB7ucq4ZEdr3TgUVpfC7FIdHsbb5gy9?=
 =?us-ascii?Q?leEWRJISKlsDlEQw3o1AfLm3y9f6VcMg57K+AFWyWptVm+QsLIRdSjxgFcFw?=
 =?us-ascii?Q?NcSmWfRbbHbhkbKI0Uzn7ofbkpU2lttpXXPkxfd/3ki6KtdF898wbJ/ysHTH?=
 =?us-ascii?Q?jxGo+99MEef2j+YLbIWCrPxCZ9BaMTUgPCAXbU2zagmFdkN+mrH7tB5UbKIk?=
 =?us-ascii?Q?fUYzqsGhh5Zq9SQBjduWdOGhen/LPEfO2clTw1KHnlthmMKzYG55fcBVoRhE?=
 =?us-ascii?Q?VgB9ehA8wl9wxceFP0JASSvhModC8GynjbSx8kxBTREGaldmmJ40Rfw6u8To?=
 =?us-ascii?Q?XmVHKn1UN5VuWIpMamaloWHG/fHk0RYK6QTyAdupBo+BLBkoTIpXYnc2GWTk?=
 =?us-ascii?Q?hqd3fWadszDW0TX0MNvEzHFlr6zRss3x4zCp1ZWOBL9LitkaqX2hFQYyyReB?=
 =?us-ascii?Q?wkGz3+XELKa8PWse9Xu1io6Gi2CGk1YATiuohWPXFssueS2xj7n97dx/cSgN?=
 =?us-ascii?Q?yDEpL38K46ZsHnvketNWUGkjLWZ3ZyIxklf1K1/7IYWgta+hZ85EF8l2Tso/?=
 =?us-ascii?Q?ddPBRVOfVGXwWnStGlFCeNe2EnP3GnZDn8aw5sWqeWok2lqg2bQ5kKJM9vd4?=
 =?us-ascii?Q?pab106h6U+kaOZIOIgMvJActO6HThtAafo51aUGv1SfWxeayaXnb5+wxMpWV?=
 =?us-ascii?Q?iXNVYIT7v3SF+OHu1OIur7R4QhpLxjSo8N1WO359YY5MTsOSr5P5hzmC4gwg?=
 =?us-ascii?Q?tQlHcij0W4dL6x2hBjbEB2Ec24YP1Ux94e9MOOLOV3nYTioAplUy5ayyBilx?=
 =?us-ascii?Q?VcFC+BrKwwKnCOfJ5JYknQfQ0bvZECDP71jjECIHMC/uKE8d8+5O9qw5i08S?=
 =?us-ascii?Q?Wyl09ciy9EKyzhK025hLFmV0Fbm5Uz5pq2Rg2OwhZ/vcwpZt0OaWx2x6YokL?=
 =?us-ascii?Q?2Sh3H3fIf3ZI0zEDaAZ2aFRXwISYvk9/fJhxKh8kmDYX2oEHgVOJWDD0BhxK?=
 =?us-ascii?Q?AgeQjRf4kUvTndKpNIfKGbTgDMWzllcuPV0R56/iME+Aa51R5AjJAb+PlSQX?=
 =?us-ascii?Q?61V4B1iZaj9tYo4Ktbga1l/NH+aNrLn2n9vkYbVDmgZ1pAIy6CdNzs7zdGPR?=
 =?us-ascii?Q?Q0XPnFMd3PiGjc0omI9caGD8VVmxLDXY9XEuKtSnmthTSvJ0lfC+scmo45Hi?=
 =?us-ascii?Q?QrXmr+QZj8d/SGFr8WzjsgHuyDJOLShxlizKsJLBChOqxrVcSk50Hti4p5F6?=
 =?us-ascii?Q?r6Srbww2bBqGGvDGDTUMLu9iUBz1XjqZ1U3shgMVsy0IA0WEiUBQP1UnIEX4?=
 =?us-ascii?Q?8Akwn7pa5KCla4wHB2cM07Da/Q5lHZTXLRfIVNpKz6KkBtaGw6domEfLQp8f?=
 =?us-ascii?Q?7P3RbT5tkZkdUpxuJhO89HZXQWzBF04yve2ZWKIGVVY5VMKsf8xoqme5s6fq?=
 =?us-ascii?Q?xmRikRiwESqw2WqSFVY9d9mROmbs9JIAroJn8ME9+L9MwGRD6j08N9ObSIym?=
 =?us-ascii?Q?yjhG9htIUVO9OeIsUCxXQaChvFgAn0Q9AXEzm4NCLlV5eTqX+wySq7EFtbMU?=
 =?us-ascii?Q?D96Nj6qu0F5ZWBTN/zCWYkOyrDV2ieLPUAtMYztt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7659afe3-4880-40f6-8393-08da74eeb26a
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 01:22:57.3198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VDplbtHiB4bE7TMCP8zwys3roe5vlOtVX78/fQHWtAwVQ4pKByI9joHoTPdlZTHX3nzuWgjbKV0dVTVmmivBJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6891
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
v1->v2:
Address Krzysztof's comments:
* Add a select to explicitly select the MSI bus dt-binding.
* List 'simple-pm-bus' explicitly as one item of compatible strings.
* Require compatible and reg properties.
* Put reg property just after compatible property in example.

 .../bus/fsl,imx8qxp-pixel-link-msi-bus.yaml   | 97 +++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-bus.yaml

diff --git a/Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-bus.yaml b/Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-bus.yaml
new file mode 100644
index 000000000000..358c032041e5
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-bus.yaml
@@ -0,0 +1,97 @@
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

