Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C66473A55
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 02:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244777AbhLNBjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 20:39:13 -0500
Received: from mail-eopbgr60083.outbound.protection.outlook.com ([40.107.6.83]:44962
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244766AbhLNBjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 20:39:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDo5Fu/gLg6Oh6rEfDbZ9CF5smaSzIJR+WkWYY+4q686+cneKP4NG5c6n4dNk7fQR2OVSnxrVjHfd89qTn/KBfSGoKxwj2ZvFaJKkwgEo8u3O7NinPtodYsFHLckNBLbOn57HiYRbCPfsYPEWC6fsHEEwGbQjycdty0PGLK48/sT50C1yhRni/0P4H4PCc1dmsAKn/T+rdvl8dWKqLSvkMsleTbke0rhPa4dZFsqQAZSibIRMyR8KjVQ6f+MohzPr0F6W36sCP8KgeLU1YP0KEZbpt7Rk8WH/mMBva83EhjbCLdJfnlQ8WZYuVK8PCq3y2I6T+hTAZzyzT8U6SNa3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJ3TMtEnrozsNt0ckpBXoHf162gQ+5pQjFOq+Npggtg=;
 b=mL3A8lvigRUgqiG+hGiC+0LfoMI+P9TfT5boRZUM7PAqtJoEfls7I2mZJ5WoPKG5GNVv6bhKFcRC9w+hOCfIu/4m6vCqB5PBlAFY5cVfHf6WHDFlQeHbw9xOVZbxRG+ZrrIBPKUZ5/vYgvean9lKfiudtOFjNs6/hgu9NFAUNkWR0m5aaCfJ1Sa2+c38XKDS+HiqXr7ot77VUmtHtYmKjc1S7u9m1Ezm1ZAzliEotPn1WStgRYEEKDD4coIbDWogjpWsL2USQf43i3KouHOBJxwUl8SKW9uzGmFTcp6WY3lq62GX2p8/H6gW1IgfyseBK/kM3flmRl1pyCA2aYqj8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJ3TMtEnrozsNt0ckpBXoHf162gQ+5pQjFOq+Npggtg=;
 b=pY7mUjua2ZCWuuRaMNSzDXeZhRrcgWEHbsJfQO0DW0WPTGjBBs1+SpKmw2iBwHmryZiT0dhOjgagR15hA2/gHpXygf78X83sYBQjNlUJ+gKJ6w0uOao0TthbgWXSEBDU6gh732rxp0Vi0LJ30lhC2qqnl51rh6wtZBNMIhfExjU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by VI1PR04MB6944.eurprd04.prod.outlook.com (2603:10a6:803:133::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Tue, 14 Dec
 2021 01:38:46 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::c84:1f0b:cc79:9226]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::c84:1f0b:cc79:9226%3]) with mapi id 15.20.4755.028; Tue, 14 Dec 2021
 01:38:46 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Biwen Li <biwen.li@nxp.com>,
        Zhiqiang Hou <Zhiqiang.Hou@nxp.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC PATCH devicetree 10/10] dt-bindings: ls-extirq: add a YAML schema for the validator
Date:   Tue, 14 Dec 2021 03:38:00 +0200
Message-Id: <20211214013800.2703568-11-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211214013800.2703568-1-vladimir.oltean@nxp.com>
References: <20211214013800.2703568-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8PR04CA0168.eurprd04.prod.outlook.com
 (2603:10a6:20b:331::23) To VI1PR04MB5136.eurprd04.prod.outlook.com
 (2603:10a6:803:55::19)
MIME-Version: 1.0
Received: from localhost.localdomain (188.25.173.50) by AS8PR04CA0168.eurprd04.prod.outlook.com (2603:10a6:20b:331::23) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Tue, 14 Dec 2021 01:38:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b88cf918-9034-4e7a-65c4-08d9bea2785b
X-MS-TrafficTypeDiagnostic: VI1PR04MB6944:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB69445AA55397400460C22ABEE0759@VI1PR04MB6944.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Eh+5NeAQ4XZ2N8XdqZGJHMBS+4CwZu1ThKRVfO9yM3I8HQNH7VnK1TuFt5FNAy/3yuXJWNwwOUmkbw8udl0/h7+uzp3ug4pnw3Q7CNZh2gTzEIH47WuXmed7+9m/EvUFLb7o4SdX4J4iM/C7ItN8Vijt4FtceATrxYBE7MS1E3iG9+GvSOT5kHPKAF9vJnCySCE6KthaSV/aTZ0Kz7YPq3RxHLZ5EgTX2TkSJsPt7KuEyHDc+IiNWXgINXswajeOuSEaAhIZs7VngqStp2c5mlZEbCkAmeT8lCaLnnfBru1xqEFShVPp+TPydsroUZCXoTXBYynd7qYzM5X5s7+UGm6IHpsZgnQSP/GCWMapqj2U93jsi/UctGArHS5DjfbzV3VCSK3XeCFWqazHLhCYD+/5/3uavvPFB0OYYPEjmBkh+898yWkW/ZHQvZMNXmiUdxKybn3wO+Yx3627SJCdbl2UirhnjB3OMito+iPmrUbUax6Wr7TX99WUtPeS00vKY/n0dxsk+RFIjUAwQCZQqJZ0T3kE6vfeJI0zzTnue45Ns8dCGFlT7nxWr2k8TC04dSYmxUwqQf2a0Nh4QyoM2BR0QyMFSSFOtOLA5dqyErr+v6HS7crONi7fwULJe6xqRhQgeB8StpP5fbPh1lU0eemvyycjleauokY5rBVCE/u/HVce6i3Cpc6h/4hF97yjdSkYd3r/CtmujkKuufhYYTENyTFiYDBm5yy7L9yX8ulGA41R8/gGNCZ8kUYZVGi1s3za30GD3sBCdDdzZe5eb6mdw1aRC/cE9uhPty7PAuRKRhEte8Q9PdMoT0Wljr8TrTfVsx+GEGthYi13wTi8lg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(966005)(1076003)(66556008)(956004)(54906003)(36756003)(8936002)(6506007)(2616005)(86362001)(508600001)(83380400001)(66476007)(66946007)(52116002)(316002)(6486002)(186003)(2906002)(4326008)(44832011)(38350700002)(6512007)(6666004)(38100700002)(26005)(5660300002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oVIMBPvKvX6h8CRQ8JdtXqUDP111xJSbHdUnBS69Q6z6p/WZ5bW098W3uV6t?=
 =?us-ascii?Q?f5SwCivkJdAwmfubONkXKCdVmjnKledBxZ5EgrU8TabrYzTQ1TnXNn8vVTV4?=
 =?us-ascii?Q?2EJZjIP4EBokpajhyGTdctLU/sGosNLQZRKcpt9HoSuSnCPIgvCdBFIsXiuN?=
 =?us-ascii?Q?gh6+lMyFEHIpnvksTS+qd+J1vWg/5nx0uffiIa6G7ogiMU9vEWF/b1TOA2/8?=
 =?us-ascii?Q?QTFBfO4MgkhzxUZD2+tFaQoW9tXokbvkOdSFvDuhFEdpSRo7UVNHaNYQDbgW?=
 =?us-ascii?Q?jD0C4NcrwBFUYpxBAcF2MYHlGMfTYRAKHZcSQHaM5D2/jGqeOmDegSpK6Xy4?=
 =?us-ascii?Q?j22Agurn3l0i/5Vt37fw5SYTLLGd9bnw1TF4IHk6RakzV0NU+Nr7zNlfgmXK?=
 =?us-ascii?Q?/LZf5R8IWbrhJIjLEqJTwAkFSihSQmrINLa91t3Z2BuWQVeovd356clZrBHG?=
 =?us-ascii?Q?EMpAIALfYA2qdDYOT2S2TsrEdMI/kLiTrVx+bB/cVezfOXJ28H0Q6maz9p43?=
 =?us-ascii?Q?sUsc3Zsu34lmogj+oGjsaDkr0fpmw+0SoGVmvC3H8QGnsBzbR/osRladytw4?=
 =?us-ascii?Q?gcVup86F1bO4zK8r+Wn+4hDqYpfQXrUZOGZM2LP/MzHHHhxPYkLr/a2nH/Pr?=
 =?us-ascii?Q?I4Z6AhICNwB5738dfh+D5a/eJoH+Gpo8wjmNE/9Rdo0Icg61fH8BmvEvTwOA?=
 =?us-ascii?Q?bSg3cky8RdPghJlOiwNcYMD3wJCoKvfthYjSd+myQu8I8lcO3w1WeXO1iEuR?=
 =?us-ascii?Q?pOG9KDN7NeZZVUif0hDJyMHaHidBf70U4BFlWpubcWWB0Jhw/IORKZWvr9bq?=
 =?us-ascii?Q?sbBXQVHPdsAHkk+fL/3uComW0Oow6FLJffm+YdSUw8pgcRxwJpZ4dgFa2hMx?=
 =?us-ascii?Q?M/B/Xu2yxH+FO1gCDCl1b+r93DvbBQG2iygOVVGco8EtYeF0M6/7bcMb1+hQ?=
 =?us-ascii?Q?90CyooZ3sHvko0RgjUvpbdDuMwyqNOmyd1qHXOaY3BW/astMI8Q0bk974Q2c?=
 =?us-ascii?Q?tijOZW4Yjhq/m8HZGWkfL3Ey34D5mpK/M1tUwdAXCdS5hCHgQ+kOQGrUoIyS?=
 =?us-ascii?Q?UN0lxEkoX8HNIqvH+Oe0cDKa7sn4KPLgdOJYNlNc6xVq8CkvDmOGikdZ6OEY?=
 =?us-ascii?Q?dP7473yEYduTh4yJOERc3Y7Kjg1neaaNUi0vvJzfWH/PwD4RQT0NST9uDfGM?=
 =?us-ascii?Q?IO2fh+fl7ehZUooHBGxKgTsf0uUOJmSqIzhYo7cTUy1Fo1hQCOSrqkd9ZLBo?=
 =?us-ascii?Q?YtvFbNUs0zp5LxpeutVyqMvZyzqjTdzDFC6NrNRj+E5SDAh8wEsQdUU9rL/C?=
 =?us-ascii?Q?LcJTA9VW1eWnw1r+q8ZhA5nJRKcOgNEcpl6G5rOXx8L0YDm0dNPQxDAbeLqX?=
 =?us-ascii?Q?Kgt4r4j9qex1Ro8dBDSLjEGTXmc42WGGajdICQjaYu0XATHi163DFzNVpNHd?=
 =?us-ascii?Q?3ARASKr7G2Gck4lmPD3HBYaROPxde3O1mtOyAZPL8lo/ESZRzKKfIMdklRFd?=
 =?us-ascii?Q?q/1EHckQLFQqPdRQyp0y76UNl4lf23Hi+9ktrQ3MsKN0A+OMpUFihR3VoGU4?=
 =?us-ascii?Q?pJSeYKQk5Zj71ikTo2pLqo1s7tnQwcmRAn/xVhG1+7RsS/8Uvddt7w1zT5I2?=
 =?us-ascii?Q?Je6xMzJp3W8SkJu67cpCTrk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b88cf918-9034-4e7a-65c4-08d9bea2785b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 01:38:46.4120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TIorb6F7EONpXSnTVCD2jrDHUiFCvUlAmrOk3rRIlKoLuX/aXzwbIsy5038peMgUkjyShgGmLV1RjkC5DnlOgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6944
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a conversion of the free-form description of the device tree
bindings to a YAML schema. The description of fsl,extirq-map is best
effort: it looks like the devicetree schema doesn't really like vendor
properties getting too complicated, and puts a bunch of descriptions on
what they can and can't describe. An array of uint32s is the best I
could come up with. It doesn't help, either, that the
schemas/interrupt-controller.yaml definition for interrupt-map, which
I was planning to use as an inspiration, is "true # FIXME", all things
which aren't valid in vendor properties.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 .../interrupt-controller/fsl,ls-extirq.txt    |  56 ---------
 .../interrupt-controller/fsl,ls-extirq.yaml   | 110 ++++++++++++++++++
 2 files changed, 110 insertions(+), 56 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
deleted file mode 100644
index cddf1aa032be..000000000000
--- a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
+++ /dev/null
@@ -1,56 +0,0 @@
-* Freescale Layerscape external IRQs
-
-Some Layerscape SOCs (LS1021A, LS1043A, LS1046A
-LS1088A, LS208xA, LX216xA) support inverting
-the polarity of certain external interrupt lines.
-
-The device node must be a child of the node representing the
-Supplemental Configuration Unit (SCFG).
-
-Required properties:
-- compatible: should be "fsl,<soc-name>-extirq", e.g. "fsl,ls1021a-extirq".
-  "fsl,ls1043a-extirq": for LS1043A, LS1046A.
-  "fsl,ls1088a-extirq": for LS1088A, LS208xA, LX216xA.
-- #interrupt-cells: Must be 2. The first element is the index of the
-  external interrupt line. The second element is the trigger type.
-- #address-cells: Must be 0.
-- interrupt-controller: Identifies the node as an interrupt controller
-- reg: Specifies the Interrupt Polarity Control Register (INTPCR) in
-  the SCFG or the External Interrupt Control Register (IRQCR) in
-  the ISC.
-- fsl,extirq-map: An array of elements through which the mapping between
-  external interrupts and GIC interrupts is specified. The first member of each
-  array element is the index of the extirq line. The second member must be
-  zero. The third member must be a phandle to the interrupt parent (the GIC).
-  The remaining number of members in an array element depends on the
-  #interrupt-cells property of the interrupt parent, and are used to specify
-  the parent interrupt.
-
-Example:
-	scfg: scfg@1570000 {
-		compatible = "fsl,ls1021a-scfg", "syscon";
-		reg = <0x0 0x1570000 0x0 0x10000>;
-		big-endian;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0x0 0x0 0x1570000 0x10000>;
-
-		extirq: interrupt-controller@1ac {
-			compatible = "fsl,ls1021a-extirq";
-			#interrupt-cells = <2>;
-			#address-cells = <0>;
-			interrupt-controller;
-			reg = <0x1ac 4>;
-			fsl,extirq-map =
-				<0 0 &gic GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>,
-				<1 0 &gic GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>,
-				<2 0 &gic GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>,
-				<3 0 &gic GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>,
-				<4 0 &gic GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
-				<5 0 &gic GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
-		};
-	};
-
-
-	interrupts-extended = <&gic GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
-			      <&extirq 1 IRQ_TYPE_LEVEL_LOW>;
diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml
new file mode 100644
index 000000000000..ead5f58949b8
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml
@@ -0,0 +1,110 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/fsl,ls-extirq.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale Layerscape external interrupt driver
+
+maintainers:
+  - Rasmus Villemoes <linux@rasmusvillemoes.dk>
+
+description: |
+  Some Layerscape SOCs (LS1021A, LS1043A, LS1046A LS1088A, LS208xA, LX216xA)
+  support inverting the polarity of certain external interrupt lines.
+  The device node must be a child of the node representing the
+  Supplemental Configuration Unit (SCFG).
+
+properties:
+  compatible:
+    oneOf:
+      - const: fsl,ls1021a-extirq
+      - const: fsl,ls1043a-extirq
+      - const: fsl,ls1088a-extirq
+      - items:
+          - const: fsl,ls1046a-extirq
+          - const: fsl,ls1043a-extirq
+      - items:
+          - const: fsl,lx2160a-extirq
+          - const: fsl,ls1088a-extirq
+      - items:
+          - const: fsl,ls2080a-extirq
+          - const: fsl,ls1088a-extirq
+
+  reg:
+    description: |
+      Specifies the offset to the Interrupt Polarity Control Register (INTPCR)
+      in the SCFG or the External Interrupt Control Register (IRQCR) in the
+      ISC.
+    maxItems: 1
+
+  "#interrupt-cells":
+    description: |
+      Specifies the number of cells needed to encode an interrupt source. Must
+      be equal to 2. The first element is the index of the external interrupt
+      line. The second element is the trigger type.
+    const: 2
+
+  "#address-cells":
+    const: 0
+
+  interrupt-controller: true
+
+  fsl,extirq-map:
+    description: |
+      An array of elements through which the mapping between external
+      interrupts and GIC interrupts is specified. This isn't really a phandle
+      array, it just contains some phandles. It should really be an array where
+      the items are extirq-map-spec elements, but it seems like the
+      vendor-props.yaml don't allow us to reference such things.
+    type: object
+    $ref: "/schemas/types.yaml#/definitions/phandle-array"
+
+required:
+  - compatible
+  - reg
+  - "#interrupt-cells"
+  - interrupt-controller
+  - fsl,extirq-map
+
+additionalProperties: false
+
+$defs:
+  extirq-map-spec:
+    description: |
+      The first member of each array element is the index of the extirq line.
+      The second member must be zero. The third member must be a phandle to the
+      interrupt parent. The remaining number of members in an array element
+      depends on the "#interrupt-cells" property of the interrupt parent, and
+      are used to specify the parent interrupt.
+    type: array
+    items:
+      $ref: "/schemas/types.yaml#/definitions/cell"
+    minItems: 4
+    maxItems: 4095
+
+examples:
+  - |
+    scfg: scfg@1570000 {
+        compatible = "fsl,ls1021a-scfg", "syscon";
+        reg = <0x0 0x1570000 0x0 0x10000>;
+        big-endian;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0x0 0x0 0x1570000 0x10000>;
+
+        extirq: interrupt-controller@1ac {
+            compatible = "fsl,ls1021a-extirq";
+            #interrupt-cells = <2>;
+            #address-cells = <0>;
+            interrupt-controller;
+            reg = <0x1ac 4>;
+            fsl,extirq-map =
+                <0 0 &gic GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>,
+                <1 0 &gic GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>,
+                <2 0 &gic GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>,
+                <3 0 &gic GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>,
+                <4 0 &gic GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
+                <5 0 &gic GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
-- 
2.25.1

