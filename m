Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7DF4C2220
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 04:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiBXDLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 22:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiBXDLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 22:11:37 -0500
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30048.outbound.protection.outlook.com [40.107.3.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB162246379;
        Wed, 23 Feb 2022 19:11:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XP3c2p7TBsdIwRM9ven9vBlJJuGV+tVNUhaHHQxyWdy0/v9/cn5OIvjcm/CyOuM5R4SwEawZrr/ikwi++ivlViyYJhcy1yeQDtG1LeiEfKBm43fTL5cGMDeXM+GYO+qKga2dpkJcf4bHwvDsueMWQW03N0xWkJtsEvAXlQF2RhCU2WrkbknBMaiPPE5w6FQNyiund9d3SU8UnfWL79O0/THdTpJtBzgnpbT+RBWJiNK5z7fFvQ4kd7yvWzqOMv3KN4A9YOl/ZgMXPalr6Mp+mlfF1QCZOB9FLthzoLNIscp97HoLSGmqZTqBEFHG1kAVpCE9QCB9RJ1sG7wC+T6hdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hya/3bWzj54cTNXLhUWYF9C9ssgciYXjOVJTTdcei+0=;
 b=R2KCzHYar6vlist2YqeWYlJKAWLEc4ymJgrBJwcJbZW7kE/GmWarjhO2nLFss+Z5ueWNDUgNBr+SI+ofzkrVtKV1ktwXMDUs5Dl9Z9NBDSu5hmYIKs/1TdvJ9gnh7vUQg+mVL0zMakWvvANr4nslTKBYKE+qiJKxoaKxVAMiV81eZ66aez9LZGIrjcWu/sB4slih8F4hb+7dXLsZ6c9wYSYBddm5ipq2Vg3S3EU8IDWdTOqVPwo0bzvdehHMWQJZzQw72qeDfCAt1uGZf5btXSOKtzfbeghve72Ac/aeqmcJn/zYoJPOZbqB6r1LReLBNYdxe3bIALcM//koJe387Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hya/3bWzj54cTNXLhUWYF9C9ssgciYXjOVJTTdcei+0=;
 b=bdFRNdHOJfjDVD7rG6S3wY7ZwlYM2xueN9gDhJMDM7ltDxwE2EnIuy3WpQX5B/nT1nTZm0hLGAGwHWnmfuZojUY61w5nSxMrnyGUBp8AnZ7e4u96dBiJr1YN4H4FlLn8+PhBwzpI28REEoRaig9zj6f1IsMzh6cSKNtHRRc/j7I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by PA4PR04MB8013.eurprd04.prod.outlook.com (2603:10a6:102:c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Thu, 24 Feb
 2022 03:11:06 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.5017.024; Thu, 24 Feb 2022
 03:11:06 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v18 01/15] dt-bindings: media: amphion: add amphion video codec bindings
Date:   Thu, 24 Feb 2022 11:09:59 +0800
Message-Id: <0be64ca65fea1fc99bd71a0e5f788d0a3d38dc17.1645670589.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1645670589.git.ming.qian@nxp.com>
References: <cover.1645670589.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0029.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::16)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0769c182-23b2-436e-b700-08d9f7434c0c
X-MS-TrafficTypeDiagnostic: PA4PR04MB8013:EE_
X-Microsoft-Antispam-PRVS: <PA4PR04MB80134174ACA74E6C12AF58C2E73D9@PA4PR04MB8013.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b1yIr//0ZdPJCobraCS0x61A/rikjZPAi9Xjv/nL8h5cbvbdIJdOH1PMHl5MWM+X1Om6emNq9jTJCEXoui0hp3CYOoCKtWWl5yNvCWFy0Cj1sqKpjU29tAo/fWXVWSVF5+cvXbBTLEGbkfKCP3JXqxpJokEcfLIEiGmn25MI8pQkjrOnnb9OcBr7MmWuEJGkT4MdNBQssZPAxWybCmVPN6AyxnmXm5wFj7j/E90/hBU1X6LMA2lRsKoU+ZjAy5fXCDtJfdnFnS0QIduWhUcsvg2fKRMZIP550VOmHHdAQ4XgR0XG1FfZCkgaHkYR5jMOO4kLtc6QS+CPy9QdWGUGzEqsreF6mjQshYzlIKGx1K4OxhzKl0icAyjddKNJUoUJGYQo9dmnmAXrb5OFuGVd5aHtzko5cnBZPCTcgqkq5MxuRru2G6+Ja0q1vBsXFTWDKQHyF8ndJotFX7bygDmoJ/XF3bnEboFayLGoU6asKjsSwH3uYLWgkrjIOjU4NoJG5qFvOdk+OhROPImOssdDwvMNiLRmAF1BEPnueklp6eMm+G6c3NfzMgW2a8vevTiBDbVAdYkcgkFJdyGLOTdZX3phVpEgGYXS+xWfsDnELneLvfIrkp2ZmO1fdM9gL2s48owvkaYk+4cvp6HGm2VQ3mx12MxGAcPdnKTL/0kDPIGY+xdXmbCV9hEIcWRsQGG9VPiWokUVUmsznLLWaGHaI6OOTAaiO0sBKCm4osqm21Ddjj8+xBSx85Xi0h/E86v7Kw5u3dxzkh6pf/UpwtEzZE6QZA6eDJOh8n8Cdo5F8HuzQt/pQxkzaZLTuS8P/G15Ye4Om/IrwzRGTFAqqeYE9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(2616005)(44832011)(6512007)(38100700002)(38350700002)(186003)(26005)(5660300002)(966005)(508600001)(6486002)(52116002)(6506007)(86362001)(6666004)(7416002)(66946007)(8936002)(2906002)(8676002)(4326008)(83380400001)(66476007)(66556008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QBfXTT9S2pHA1q8zULUaQFkYXQqmD5R47YXXveMwz5VqOs/Mm8a+ifJs/AGx?=
 =?us-ascii?Q?kXtgkSYcq9VqFonNZrOUCXOIa7AVGwZxh4yF0RDeE0H5g8YTMV61ZHLGf1EU?=
 =?us-ascii?Q?Zj+WOLU/w1fGWHoT/akDDy24yvNCE3O1OVJVF195U9aLehi2sK+zyvpHjicd?=
 =?us-ascii?Q?rxdwAfuUWT2izXF9qm3UPLkNCwXunH6sQw2OWV6beqP6sxdcJLgN8LTM8+Mp?=
 =?us-ascii?Q?y/LoejDDS9HPT+N4UFhroJgcux5TcpDDlMP27lUwngiioC9zRI03Vt4QiITi?=
 =?us-ascii?Q?23Oa4cr/uYUn+vNvqf+eptSsCRalh2+BOo5tkOTdsnMz+kuQHlhEWfr951D/?=
 =?us-ascii?Q?DTpSOikoWc6HGUGOxLHYT2zIuoE1AMi7bNajfpTzmijdvQ6pWzvyCIwWibdP?=
 =?us-ascii?Q?1I+u426Y+MVAtcKmrs6OT/SH0nxcAYSvb0sl9QJlTfKHaFXkC3Rp8uDgUJeY?=
 =?us-ascii?Q?9DK61Yd+ro7w+riACA5peQzmsylzVJNHQjVmu5cWYtXClI7iyG+EOfRN+Zy6?=
 =?us-ascii?Q?Kv168jRmKuAmL6q1zxwXvBxSDWx9xdhetBGfo0a4uTmyxtzs1ObE94E2q9gg?=
 =?us-ascii?Q?Jd4f2jjoAlZeZGuU4rtk9Bwfg8nrAkdr0pA97Nkd4XqCb2QyyfSZ+zJECkfJ?=
 =?us-ascii?Q?8TV8m6E1uWDsw4qSN+iS7dJtd/rjlvQvjNkU5NdbnhiskxYO2w0xXyeEalha?=
 =?us-ascii?Q?1sQo/ht/nVA4TtTdu3lddzXbQzjkB2FtRlkMCsnYr7VMTKSzmWzlQbebpVcV?=
 =?us-ascii?Q?6KUIm9BhjYOmS+sKsnyZ/AeBmCg+1b5YUzs3t2CY9xFnyYBxOr12TNnuS9lR?=
 =?us-ascii?Q?Jly6p21qEvgU4rD6nxuza5ER5PPEt+9UkDfRnodYUuumrgQhYWPGagsbSdgV?=
 =?us-ascii?Q?E99nrATCeRrjQo33J8qn2fEMQw9QbnBrGmJclInyZ04Mehv1BjhXlOYMGRrN?=
 =?us-ascii?Q?BM6sWTWhNqDQ1wnNSkye9OgyAmLKjUYFcq+AqDJkLW4KGf7FkpqvVobt0mrl?=
 =?us-ascii?Q?JQ5dnGWzWYzUrcFZly2DUdep1Hc6pCNkPy57UL5ftPswCDwSvaA5K569gKoP?=
 =?us-ascii?Q?2Pk6TN2/6tWh25E0lgz/ZlnSPzVfinXnyPdm9nE6Pjksss/8zOov4U9Da7M5?=
 =?us-ascii?Q?VS+GC+e6uqNEKzxKbhIQ3iGHm3rRDyH32jRUZECR0+K74jUB5D+cfI2D040n?=
 =?us-ascii?Q?KmRwMh5YNpyCmys1V3tac+w665FJcs1oDssETPFol0JiHCjlKj7ZbcKQDFpr?=
 =?us-ascii?Q?7Us+VOwf3/JnbanZ/c45DC4esKUl8EvSoFGB91f41My/eByRQEdPkwMvIf2G?=
 =?us-ascii?Q?atttCoNeG3ThYtkE7BLBsHh4L/YiEwq/LR+RjXrZUtmEmixd5y0wp41qYMQk?=
 =?us-ascii?Q?cskCotrmb6ggpx0bYlN4icwM66QZb52+Mi8f4RnnCvO+kATunQyQlk0UiYZM?=
 =?us-ascii?Q?GBjJJiGwEmFtE+O1cPnm06SOroy2xdNeTfKu+i+y291/JBcrGHQkugrIE4NE?=
 =?us-ascii?Q?7LPV0C77XXtQL0Y5KLHovjrM8Q/puSf+1FA8S1GMVJJKHt2jfjdO9NsGl6ou?=
 =?us-ascii?Q?fg+exzBwpOSU1n+RZPyo+q78RyYLdPuVFxGeBPxmFyn2vyPLsHwb8z7Vx9pO?=
 =?us-ascii?Q?tXUlstL399UyBlV8qzI3G6E=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0769c182-23b2-436e-b700-08d9f7434c0c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 03:11:06.2281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +5CZvfwZaY7naY6NBQAv7hIMUWyR2b33IDP/y5DvOUE+q2t9PAA79PgBOqOMZ6FtUxCAHd3+rRejjTEQPr6SlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8013
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

