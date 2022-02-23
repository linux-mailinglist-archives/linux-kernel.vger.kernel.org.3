Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A274C119B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 12:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239111AbiBWLld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 06:41:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240094AbiBWLlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 06:41:19 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70055.outbound.protection.outlook.com [40.107.7.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44179858D;
        Wed, 23 Feb 2022 03:40:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iecdn3VvEhZXBNVy42BHzX4eG638JUABvUxKa8FVSaU9cUeKh0+9AFaQmSKmz997i5YEpJbmm+OJmZBCJ/RDmOrSL8PlbEoi0qTSHIot5EQsidv9VRlfrtroHLMUnOvZ8882lEPgi8oMcNMUdn3RL2PSrAR0xhURLXvhl8S33rBAIShKYKJFa+drzbB1B+8RvZxQEWWvCcGMDSOBmadSR/qGoXRipq7Le/gZUEc5KYf6DVXUxyvc2dswNFg6BhvRMpq9v/VTvxUSoyz9ensV2a8wfoqVeM2EmJ9KezsVouiIyd0roF6M4848pwT0Xn2doAt8dqHYMjT18dScZ4FtBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hya/3bWzj54cTNXLhUWYF9C9ssgciYXjOVJTTdcei+0=;
 b=i5yPpWBiu6eYbc6MuA41Hyy6ieZTFtsRDyA7kBmTqUUGdoE1+i7nyEnLoLJTzkC6MHjrtulGvwYe38hyuYa9DyMj9uAVB8jStl0rGzlybQ/we3U45lZKMMtQMX4h1IHlEJ8ddb6K1Tbc8INyePAqRZvGURdKAvOqAZ2eohub9cAitE33a8nbL8rjJuhfz42N/jGF5JSjPSJuYkYq/s7xi4OS0LIQQZxsR7yKOpH9c/po/BP6AUPKvXUjy9kPMjxuJEH8S2j1pugHBIangrY+I4YS2oyEUPO35hCCGJbmBR5ybzOsT61ui9PECH/FO+4/iTQOzOHQ41j5/aghbGvabA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hya/3bWzj54cTNXLhUWYF9C9ssgciYXjOVJTTdcei+0=;
 b=ehRRxFLh4F2Tp1cP3g043y0x2GTKauxjs7nEcoHpu9aKvhYM+QWZ7lK/UOxC+Njs7YhG4uISiNoniz68euhkuF8NHH/i5Q39wyruo30HH7+QYsh7Lc2mVcfDtsJD9r195m/c2Xqjp6atAuui1s4CZprvlhfbUw0w4Ry3b+Du+KM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VI1PR04MB7055.eurprd04.prod.outlook.com (2603:10a6:800:123::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Wed, 23 Feb
 2022 11:40:49 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.4995.027; Wed, 23 Feb 2022
 11:40:49 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v17 01/14] dt-bindings: media: amphion: add amphion video codec bindings
Date:   Wed, 23 Feb 2022 19:39:54 +0800
Message-Id: <0be64ca65fea1fc99bd71a0e5f788d0a3d38dc17.1645615976.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1645615976.git.ming.qian@nxp.com>
References: <cover.1645615976.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0601CA0015.apcprd06.prod.outlook.com (2603:1096:3::25)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1fd6d77-9814-43ec-4530-08d9f6c15682
X-MS-TrafficTypeDiagnostic: VI1PR04MB7055:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB7055B6E3D75E40724B5914DEE73C9@VI1PR04MB7055.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SzErWGIpm8uN5EAizt/A4BVel1hPP0AUo50MnU5uVoFmqpPC+J+GJUQiZ2dzvyivtRBT33J+s6UipQApWTgb8mrWtaqmUwIzUj9ba1/ZfmBTWIFIsq+lhfFbgBo5cGYJ5m7jvY0AQLDpgAzyxq/1qt/udHiGC4WDcecTuPUqKjW1PxGZj5GVzM5o2gQRBP+PyDKFsCiJsXqrg+japhoi6YlsJLc5LdA4W5MW2QrxaH2AEkIUla/N1G/5lt0EBOoEkRz4JQAx/6hdzVZ191dE5lcz5iQ5hX6kEl9LNyAqZ9OfHhpQoiRQ4GBjNPfhxPEBFAtIZ1Z6wgM/8LXMHhKYKun9p2CL2iMyjLi1xqasAb+zCGEGOXdcpxA9ZVz93QOSyojLVzX+UFuowyV7xopvUX7sC+aD7N7ZP/TnHhJLZK11uJAynvUuXP74YQx0p7S+HsvCPTnmcWAdNefDCtFhxE9XfHKN1TlKQNB0ibrbgS2BI2F/CsmN5dPqjaGGj9gw9b5X15rHnNADU6kJ5tEYD5XmqgMald0Sn66neCdR7Ri5yg4/7xbYDiyIJcoyCnf6OJJeYSOBgas7vx9EpMzVRYUhdCMttL8gjSNXA8oYkyWrw6wcO+e6iJEC61gtYnvboCAsOMM/XWO5h503dz5NAzQo7iMuaBejEvdQISvzbTgYO7tOq0EIbLk3xVpVsD/V/mqD6Qp0SdTmKFVpn58kK4u5KGH7h1tYgXwcXgUMOQ9WlFm9+nQj27utcmMAfsY41wryHi+uA7K08rUkpCzSjrQ4cxPmLTjSEfEnPLKDJkBp7j8VpIIoF+9G5qgGtc0OfNYhJIUHqEnpMXV1Fi/Jww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(86362001)(966005)(6486002)(8936002)(44832011)(5660300002)(7416002)(6506007)(66946007)(2906002)(66556008)(66476007)(186003)(83380400001)(52116002)(6512007)(2616005)(8676002)(4326008)(38100700002)(38350700002)(316002)(6666004)(26005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R2/i3u9kjL8GGKuPh/PgyryaJzWlviPCEk5aJVrSeNKKxBibzxDolVIICb16?=
 =?us-ascii?Q?stdOi64pijIDqT2ARScF6rsclQw81jj0SFPvOTi5uaIgcyKMOrNXu2jQVeA+?=
 =?us-ascii?Q?M/qWrSV2i+99xLSMcqN4bxKPQptHRS1cIZDjNg1t5mU4hZTOtBBFr/97SySn?=
 =?us-ascii?Q?+2FrND3xcW+uwrUiFfrg8ziyVrNlwNIZj8FNB+mvbadbTlhkW5ZOu6QRG1wq?=
 =?us-ascii?Q?/Iwne5H+lWvxBG9MdFuIa40Okpmunzy3HsGZX7hOeh98qk+4hiYUyEL0PD1r?=
 =?us-ascii?Q?6MV898ylr6gU+mxoCyjK7cpv1DsTar5D4NNs/Sv2ww8no8EiPyR+e2Hyp2ou?=
 =?us-ascii?Q?pMDgZXPeKbO2NT4E2ujo1/vr/NRzb+7Esl/5WHMY+a/ZshSuBRZKX4P9EMOi?=
 =?us-ascii?Q?4d7DZNUhtZZUm7p4PH+BE0WEF5DyVc2TObt1PAKJMiIllRnuGWac15KHa5jH?=
 =?us-ascii?Q?4ob29GPCRBwGIG0y97hBz+CeO4/FEPTX46nZYBXFjOdMiRsi2Iu3wT/kO3bu?=
 =?us-ascii?Q?IOxbKyroKl6Km7Upo0IuHd29yDExqA3oQccue31g2G9IZS6J+UffNcknYES7?=
 =?us-ascii?Q?ztdBF16cEM16bh0wLdWpeOAiNJTvCbXnicmutfbh8lxkb0kRHsbCvTSooxig?=
 =?us-ascii?Q?G0lV1V6ym/MB/7XerU3dWFlHnNy1Whtfk+0xnImbcOqAM162mj59EaGLscB9?=
 =?us-ascii?Q?WMtQBudRdKGReua5yBoycKZ2Lq/YiMJF1A5yEHfYBsq6Cz3Vy6gNyOqnOJxh?=
 =?us-ascii?Q?EKWcvh0k8crn4OwJ4I+wogGQot81rtma74OyLTIW1zDmMM5xxs1T27tnFdwU?=
 =?us-ascii?Q?h8WBxm6c1nxCIN9T8Wwc/1xzDB9Nxk6nCc057EmJpY22O/dxULvSQv0l4Snc?=
 =?us-ascii?Q?NF/k3FgGAJcs8/Kd/bVLfyNDuwUEm0pAWAg4wiU169WKVH2xrzxfyNMi6cGF?=
 =?us-ascii?Q?xPpns2ArpWJEzDBcwpJ6SFCktuqCWoSs6cb8x7s8a4eyp81bPnnd2QU0HfF3?=
 =?us-ascii?Q?wEVLfHEYomRvUfxD1Vbw40p8mfQzMXQGsOMSxS+pOM+3GzmT1obf/Nnhbsc9?=
 =?us-ascii?Q?/91G4uRHJzZFeWBPl/bgGD2/GLG24MOjmKSUwyBcvP3Rr7GpNxL+X4U7TKSX?=
 =?us-ascii?Q?Y76EPs2ZZq3DDGfTkV40/N/OSrexrJczE2DCGiT6qBG1QULnS2Vd2PsaA7X/?=
 =?us-ascii?Q?08aMLuCc94sKgIqS8jx3iBKSStcOpoNaE1D6NKH94q+PfQstDGY0MLO02ZI4?=
 =?us-ascii?Q?V/cg22QAgxl+5zGTeJ5zYKTQMcgI8um1yAaC4dde+jlGwEvwO7nEoiGaBkFq?=
 =?us-ascii?Q?81ZynXLL4Zzd8rntOVUab5z1W/g9ZSql4tYxLCgbwF5wU1Cc9m2zgtBDab3F?=
 =?us-ascii?Q?8pOpY8umo71t+iSGsCZGNjVGeFSQeet2dsaD11/H/CKMjG1vksR8mUpXq2bt?=
 =?us-ascii?Q?G+pQCCSF2uqMPQTXJVMv7zE8VB6CiLCrsaJ7tzPWP9sZydJVQ8JI6hQbxwHW?=
 =?us-ascii?Q?NXH11NuOhMRbGmFUU7X0tE2RBP40+F6MvMid0f0SFJD6dmhv5lNbkpuHwCEN?=
 =?us-ascii?Q?MQ9hqehyRpb2OAmbyezTCEQbrzSl6Hpqlu5DIpn8El5Rd3P2OBvP5Letc1QP?=
 =?us-ascii?Q?h2gzmr77ooYhpM9Hk7C64P0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1fd6d77-9814-43ec-4530-08d9f6c15682
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 11:40:49.1541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FAf/uMkES1WJP6ANRJ0jqQmrylx2oir8+DVWSqcfryXq7zIeHohAcYBuHZim9eYu9Xx17+NMCHrX5mBTX7Nrcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7055
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

