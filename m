Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E3049AD49
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 08:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443489AbiAYHPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 02:15:11 -0500
Received: from mail-eopbgr10045.outbound.protection.outlook.com ([40.107.1.45]:59635
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1442913AbiAYHM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 02:12:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzGhLqEBskoWlmmKjMqFqcKAWMq4nZfvfvPrDDLTytb4LgwTNncHV/EPapKr/Ow4V0j+m1TspmwPhKCnAk7sLKeslSkBm3QdvcXCbgaEo45kJ5Md0xSqNksZYgHqK//EV1BIoUsJbxt5X0BHyzMXIoS7QuWwP7bfB8kNnd/wdZG7+YzJ8dXlgiupzI/oBE0dxuaKkG7Dov5rpA/+dZI0wI/VKq0FgLUgQsKeuArXDN/FcIauzPSb/S1TG2OT8ZTVdYO1wpfAbVvtha3s3AekzgSu8wvgRxdB+NltjG7WDUwPXLemb5IH/vV7jG722O/WGRTWYwHej/h0G7ZgNV6Emg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hya/3bWzj54cTNXLhUWYF9C9ssgciYXjOVJTTdcei+0=;
 b=crcl+n9AB3XCEa9wInCIHGdSsnWs8Zlc/0FOVtOnbKfeCzjd1hKJQ6FzCe7xQC2clPPRWDFkfK+jbg3k4R8lvWLQr9DL8aUq0Zd2/FAeo7BXYny37GelbBAhpzoWraqaTEqPYidpkh/gaeTTI9tcp5/mB6MXlLq5kc2eN3ml+X5vnIcaHLC0Pmnbgi5sHb5ywD1HbN2gRftHeAA81bAyTT5qSy1RfWVTZ5T7t3/IUohiE3qR9i9b75W/cvbz+u9PK8ot2cVMrJ+SXj9CzXFkn7VRqq9OFxIyNcQKUcs0eLux6HmiSIYQTa1DXTpvRoW4bhRHnQe+SHjwu7zdA2E47Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hya/3bWzj54cTNXLhUWYF9C9ssgciYXjOVJTTdcei+0=;
 b=aMQgX97Hwy5eR390fPcQCxpONxet+82pqqMe1jVWMMZ+xZFPNTGR0Q/b+mg/c3jOKCJKPveESKrjNtJNyk6zAJk+UcZZsZTtrV+e8qD1AnxcrwoJtRDGlGNncuJjQoQy+QVaGjOqcuUmVLotIabVFGK1YuVAZW7STqCFsm05oKQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VI1PR04MB4094.eurprd04.prod.outlook.com (2603:10a6:803:43::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17; Tue, 25 Jan
 2022 07:11:55 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3d7e:6627:fdd0:9d13]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3d7e:6627:fdd0:9d13%4]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 07:11:55 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v15 01/13] dt-bindings: media: amphion: add amphion video codec bindings
Date:   Tue, 25 Jan 2022 15:11:17 +0800
Message-Id: <5dbf63cd1f73be49d45126393a88a1968de7d73e.1643077283.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1643077283.git.ming.qian@nxp.com>
References: <cover.1643077283.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0172.apcprd04.prod.outlook.com (2603:1096:4::34)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54a28091-c2d9-496f-569f-08d9dfd1f7e8
X-MS-TrafficTypeDiagnostic: VI1PR04MB4094:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB4094A7BFA814DDEC116A7574E75F9@VI1PR04MB4094.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N7rM1BBfCW8GWpqPno5sHLEA0FGoCf3cwEGExx3496V692tBGxnZXEF0umEhNTh7kA2AQewCk4rgcoDUedhKlCqMjK4duZPettqyTgrmUcYpROJISPE/VBLWxGc3ASeXHP20V0sl8N2jQBhbxJwyeIr4aNkG6u+TzZISAYhCLQisNdQ1lKGt1I1MeOBGyVgvtennhzFe+9YSuWUdfyVbCXegUpK4DwgLHLL/RMKLGh/oq2OoZaW2u24tLio6w0D1LS76O0v/0+JHtJEsh1+4cs3B3vnVsLATIUAPHP9efah28a9g6uuALwRVKByDVzGs9p7Np6fZUYYqdCWn4f0TSbXBJQNxW7N61faLqATV2t1ZrTW2GFXnn3LvGcwiJYUWu8w1DBrRUBXGVTEBKfffcC1jdDLwP1gS5nbuJCRzgFYqjrJYbx6X7bqavpxytTTOs+okolf2PuJ4NulPEsUmcHqLk09dcVr/Em3tzPwWze0ZIIJH29hulHW/mR6Lf3a3ShsFkW2D5M0PMwZ8GV1S6fOF8CbmXA77SQg3Q13+EXBZYuuj0em+tjgJRtRtXOQvqdTDJim0KA4eZU+DF1c34ddzIgFic+RpHV4Mn+xzkb3VfoQ4snavjvPeW2yC+AEF9fgpFzvceeRiirZrwkrdwmUA+4fTpTJy6iRPVeDquVR9c4ahAHPBf5lxvjns2WoDmonOjlzwGfgz+TuxWpfN6613nNy0X7S72N1gF6bZZJGGg7TTa5uJ3VSYDe/y2BHCnqGKElfU5xl77r7nWRF2lfu4IIIyMlr4LhJ/TqZxsP8RmJSgASe9yBvzZbHEB4iX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(966005)(6666004)(5660300002)(2616005)(7416002)(8676002)(36756003)(44832011)(86362001)(316002)(4326008)(38350700002)(6512007)(38100700002)(66476007)(66556008)(83380400001)(52116002)(6486002)(66946007)(6506007)(2906002)(186003)(26005)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qHi1/JCh66BaX8wdhkmDKIw0E/g1iAMOm+xzSirZuNt3YETV9E5yvgK0uw6R?=
 =?us-ascii?Q?vpw+UtTPhscDCCSYCyLhPY26B9vAbB9uTHIjLVP3OlHqUVAGyM5aLiAN5fVu?=
 =?us-ascii?Q?8l6xHxuo9StkBqepwSDH8/iJJdY5paCIQEbSXBgWPb9XTbwe6Wij4ZeH0QYe?=
 =?us-ascii?Q?voPoGVPl1f58K9QibA4UyTK1Ki9N1VpL9UGGIPh/1HwjZXvBW2Hp5LTbFNLH?=
 =?us-ascii?Q?DQbaVuuRAwPbeUhSvhgo2Oscmmh94dNqyA+HFF13cdubMZldacVDssA7X2BO?=
 =?us-ascii?Q?+pf7AxaWkxmfDYf3GLbHpX1Da8V0NAoA+DTda7/L1gFTxgdtPL4BMyqXkDEQ?=
 =?us-ascii?Q?rlHXbOmbSKRvpM2OeVZ45CawvLlH3OEZ1rYZ/yTKJy3Zx7OYXy/3M74+Ch8U?=
 =?us-ascii?Q?A3VDiEWXd3lny6L7GimN/We8jRDcQFn1QLKP6w3zGjRKk0rTjbKqnlsHJZ8W?=
 =?us-ascii?Q?LWo9nLFhRpsDCwK+VvAvirobPW2SZlWbdAMFNDOo61L/YIiJm5NMU8IyBFw9?=
 =?us-ascii?Q?wGftb9u5hNGNcgsiYe9mZ723zcCjpkGNdJ92w5VufS0lI5ir6nQEaQ1AKqnj?=
 =?us-ascii?Q?V7zqsSG6JIhj42+vRrY5FP7DzcQYhqE+hmp7z8MESoEWhWs0ZPgCxAyTwuk4?=
 =?us-ascii?Q?nkNG6Rm9vH+NblJlF1HfIKpEJU21joBsgvPF2sbP4+m22FI6fBFKXbY2qdGZ?=
 =?us-ascii?Q?h2fFm/gT5li8iK7NZz7Vst1AxdbgFDtyztp0Qhu3cbQLn0jDEPRVT+dVWjZX?=
 =?us-ascii?Q?y6I2oxsDT2zhiJ8+CTtNkvKdT6Z/jwd05uM1sSP3X5RVumAmooqa2UGsvYq1?=
 =?us-ascii?Q?zrJTC0hpWQZJOohcgzvBMtHQr9lTPH6X18ycOlHOjnITmrSS/Jw2CEZDh2n6?=
 =?us-ascii?Q?Nzt1JBUY6DOUW84fmvHv2Fzk74hn/EMp1rdHL0wB4llb8Y2pzgmg3cnpNpO3?=
 =?us-ascii?Q?rk5c/adCOITWosD//BURDl86kQBBRbziMnvxOt98t9yR1MOewHq5kqZVALgr?=
 =?us-ascii?Q?/ksja+pNDPj7E6c6HuskvU9UEzcMGflCpd9h9KMiIyk1ePviFtXOl7S7juK0?=
 =?us-ascii?Q?5NrJyeRU+979Lb4BTD2v892YclN+syb0xJzxFXDY6Rocs6z35JE/RSy1Ob9a?=
 =?us-ascii?Q?CRdrMrXNUU8SgfVu8z6Kf9wtRz5b+fZNlQTkjTrgDJR8f8YwHDuCuoZL1Jkp?=
 =?us-ascii?Q?rzNfCIhM/xf4LFdlOEZtuNHhO0rbk5N7jyCifJCpCAiD/iDRf3LVcQW+Za/I?=
 =?us-ascii?Q?zuMafHXtNLxTIvUfquFNCrqvVn3z8at1gxnI1sx22nceeNeFWAj4Wz/H5c7W?=
 =?us-ascii?Q?2saJtcbdJNz99L7EIWreWKQbnY4ZK+mzZs7ZbAh3CJO4Q1GvGMlVe8lwsXJY?=
 =?us-ascii?Q?6ajBKeqX1bSOPPa5SS3fqer16zCHotPwYQlnZVxI28QFV/6p+hmLNISWSCTz?=
 =?us-ascii?Q?afF1osQqbeYJiNILn4uSGp/OVWap9PbbX4mrnQb0pSs3CXOsN/A5GaX2v6m8?=
 =?us-ascii?Q?OVCvYxd1RqaVkcF1nkmiF/4SUZcXhNHVHmQpSjTpIlRIES5gaqFV1fp3YEYL?=
 =?us-ascii?Q?yNiWFj4QyltpqMrnbXk9NT65r6HXpgL0XgAdSJBNOJYcCFq9HiG9rBcXGPrb?=
 =?us-ascii?Q?OA9SeAijjEMXWrV336rQdQ8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54a28091-c2d9-496f-569f-08d9dfd1f7e8
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 07:11:55.2024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l5ZBPIbM89JlDsGpc7xfhZXV8OU+ASIfeLFp5ysn206H54YyTZKrkT5FvnIFlrNQbVPvp55UMdRcicZGNHkXFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4094
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding documentation for amphion
Video Processing Unit IP presents on NXP i.MX8Q

Signed-off-by: Ming Qian <ming.qian@nxp.com>
Signed-off-by: Shijie Qin <shijie.qin@nxp.com>
Signed-off-by: Zhou Peng <eagle.zhou@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/media/amphion,vpu.yaml           | 180 ++++++++++++++++++
 1 file changed, 180 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/amphion,vpu.yaml

diff --git a/Documentation/devicetree/bindings/media/amphion,vpu.yaml b/Documentation/devicetree/bindings/media/amphion,vpu.yaml
new file mode 100644
index 000000000000..a9d80eaeeeb6
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/amphion,vpu.yaml
@@ -0,0 +1,180 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/amphion,vpu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amphion VPU codec IP
+
+maintainers:
+  - Ming Qian <ming.qian@nxp.com>
+  - Shijie Qin <shijie.qin@nxp.com>
+
+description: |-
+  The Amphion MXC video encoder(Windsor) and decoder(Malone) accelerators present
+  on NXP i.MX8Q SoCs.
+
+properties:
+  $nodename:
+    pattern: "^vpu@[0-9a-f]+$"
+
+  compatible:
+    items:
+      - enum:
+          - nxp,imx8qm-vpu
+          - nxp,imx8qxp-vpu
+
+  reg:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  ranges: true
+
+patternProperties:
+  "^mailbox@[0-9a-f]+$":
+    description:
+      Each vpu encoder or decoder correspond a MU, which used for communication
+      between driver and firmware. Implement via mailbox on driver.
+    $ref: ../mailbox/fsl,mu.yaml#
+
+
+  "^vpu_core@[0-9a-f]+$":
+    description:
+      Each core correspond a decoder or encoder, need to configure them
+      separately. NXP i.MX8QM SoC has one decoder and two encoder, i.MX8QXP SoC
+      has one decoder and one encoder.
+    type: object
+
+    properties:
+      compatible:
+        items:
+          - enum:
+              - nxp,imx8q-vpu-decoder
+              - nxp,imx8q-vpu-encoder
+
+      reg:
+        maxItems: 1
+
+      power-domains:
+        maxItems: 1
+
+      mbox-names:
+        items:
+          - const: tx0
+          - const: tx1
+          - const: rx
+
+      mboxes:
+        description:
+          List of phandle of 2 MU channels for tx, 1 MU channel for rx.
+        maxItems: 3
+
+      memory-region:
+        description:
+          Phandle to the reserved memory nodes to be associated with the
+          remoteproc device. The reserved memory nodes should be carveout nodes,
+          and should be defined as per the bindings in
+          Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
+        items:
+          - description: region reserved for firmware image sections.
+          - description: region used for RPC shared memory between firmware and
+                         driver.
+
+    required:
+      - compatible
+      - reg
+      - power-domains
+      - mbox-names
+      - mboxes
+      - memory-region
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - power-domains
+
+additionalProperties: false
+
+examples:
+  # Device node example for i.MX8QM platform:
+  - |
+    #include <dt-bindings/firmware/imx/rsrc.h>
+
+    vpu: vpu@2c000000 {
+      compatible = "nxp,imx8qm-vpu";
+      ranges = <0x2c000000 0x2c000000 0x2000000>;
+      reg = <0x2c000000 0x1000000>;
+      #address-cells = <1>;
+      #size-cells = <1>;
+      power-domains = <&pd IMX_SC_R_VPU>;
+
+      mu_m0: mailbox@2d000000 {
+        compatible = "fsl,imx6sx-mu";
+        reg = <0x2d000000 0x20000>;
+        interrupts = <0 472 4>;
+        #mbox-cells = <2>;
+        power-domains = <&pd IMX_SC_R_VPU_MU_0>;
+      };
+
+      mu1_m0: mailbox@2d020000 {
+        compatible = "fsl,imx6sx-mu";
+        reg = <0x2d020000 0x20000>;
+        interrupts = <0 473 4>;
+        #mbox-cells = <2>;
+        power-domains = <&pd IMX_SC_R_VPU_MU_1>;
+      };
+
+      mu2_m0: mailbox@2d040000 {
+        compatible = "fsl,imx6sx-mu";
+        reg = <0x2d040000 0x20000>;
+        interrupts = <0 474 4>;
+        #mbox-cells = <2>;
+        power-domains = <&pd IMX_SC_R_VPU_MU_2>;
+      };
+
+      vpu_core0: vpu_core@2d080000 {
+        compatible = "nxp,imx8q-vpu-decoder";
+        reg = <0x2d080000 0x10000>;
+        power-domains = <&pd IMX_SC_R_VPU_DEC_0>;
+        mbox-names = "tx0", "tx1", "rx";
+        mboxes = <&mu_m0 0 0>,
+                 <&mu_m0 0 1>,
+                 <&mu_m0 1 0>;
+        memory-region = <&decoder_boot>, <&decoder_rpc>;
+      };
+
+      vpu_core1: vpu_core@2d090000 {
+        compatible = "nxp,imx8q-vpu-encoder";
+        reg = <0x2d090000 0x10000>;
+        power-domains = <&pd IMX_SC_R_VPU_ENC_0>;
+        mbox-names = "tx0", "tx1", "rx";
+        mboxes = <&mu1_m0 0 0>,
+                 <&mu1_m0 0 1>,
+                 <&mu1_m0 1 0>;
+        memory-region = <&encoder1_boot>, <&encoder1_rpc>;
+      };
+
+      vpu_core2: vpu_core@2d0a0000 {
+        reg = <0x2d0a0000 0x10000>;
+        compatible = "nxp,imx8q-vpu-encoder";
+        power-domains = <&pd IMX_SC_R_VPU_ENC_1>;
+        mbox-names = "tx0", "tx1", "rx";
+        mboxes = <&mu2_m0 0 0>,
+                 <&mu2_m0 0 1>,
+                 <&mu2_m0 1 0>;
+        memory-region = <&encoder2_boot>, <&encoder2_rpc>;
+      };
+    };
+
+...
-- 
2.33.0

