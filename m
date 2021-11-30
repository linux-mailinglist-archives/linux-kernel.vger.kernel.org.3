Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957C5463012
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 10:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240442AbhK3JwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 04:52:06 -0500
Received: from mail-vi1eur05on2048.outbound.protection.outlook.com ([40.107.21.48]:30112
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240416AbhK3JwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 04:52:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zg+8Z8e5reZ4F6J3pyA9C6H+oxhtQLETRfufzGudQmWzdquUSqwQSrd5bYbpDVitZ89NmyNo9RjNhFr58QMjd1IeAcBxoCRPyioK8G+8ufKXjiOLC4rj2kS4ghGMjz0zPTzCjJnklpS5d3GUKm5gwe/Vw0i1B7XP80L+vmQ9kY7aJ3cbOfm3NSLI6kQIhp+sLAcl0B3HaP+QqvzUxUF5blu4iN4CSl/PYttxFbpbLowK6VBt4IeWQAq9ZUUBv6BuL5o9PqIvDKc7QSdJ2WtTwuE5TYo03I9d+TJRXPhSbG+6wE55m9i9mZCY+FDFO4WLcJLmt3/IEF1zHSbCp41Mrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hya/3bWzj54cTNXLhUWYF9C9ssgciYXjOVJTTdcei+0=;
 b=BPJvyN0TYj0U3ejWftKTWYxlF2NZHHWdrkhUPC4N7dZnnNz7ipgIRkPU+EL5FNzZjYNE40GpBzaLM2l6NrEIEJPpZnX3fhuxLEP1WfT86Wvg4oKAOHYX8xhtGbIS6Ig06bPPupwo908Ax6L8VxQZuw829maS0ICbmezuHghuGNNgRZ4Nvywk54jnQIiFbO/QqLlKMK6/+prL5u6t9k397jAKvdoYatGxv/Poyhr99KVh7hI3KkI3kZDwooXDMtacSxnYXsa9WMGuN1oaOnNc3lLIFERGQOAlDXeqYpfR0jX3q9eps0Iz241x2rkNsLIiya9vvEe6bmH1zTk00TLTXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hya/3bWzj54cTNXLhUWYF9C9ssgciYXjOVJTTdcei+0=;
 b=LnaR1rQIjuHqGvpRPoh+ucqagKmWpBp/Qa6anthcsnJBDeDs1XL66cV8eIIpO/6BZO17Nxv+qfdtqnr6L1QXHj5chfxx2F7CqK0Q02CTKPNrxRIRDfDedvg95J0kdllG334xIvBZDm32X3A5IoHnlRdJmlACJcG8W292aydK27M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM6PR0402MB3925.eurprd04.prod.outlook.com (2603:10a6:209:1c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 09:48:40 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::fc3a:8aea:2c92:3886]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::fc3a:8aea:2c92:3886%5]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 09:48:40 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v13 01/13] dt-bindings: media: amphion: add amphion video codec bindings
Date:   Tue, 30 Nov 2021 17:48:02 +0800
Message-Id: <1d9a5b0265b9275732bb0aef4b07f185a9df4074.1638263914.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1638263914.git.ming.qian@nxp.com>
References: <cover.1638263914.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0025.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::12) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
Received: from lsv11149.swis.cn-sha01.nxp.com (119.31.174.70) by SI2P153CA0025.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::12) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Tue, 30 Nov 2021 09:48:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6393565f-099e-4d76-54ea-08d9b3e696ba
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3925:
X-Microsoft-Antispam-PRVS: <AM6PR0402MB392512D32A31FCE5678F9D2BE7679@AM6PR0402MB3925.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OKhKdLmAOJtwWeHyv4B5AJ513MNFZ02d6boIoW2E8mlyXp1+XZPSsSZDeV+Uh71aNRMHylLWqXdHpJHjgM1GT/dMDR/PUOljeNg8Xh/YtJlr4MkoyQ2b9U+CVBSK1iEpwjTKQq6Okun+auTASJM4wOfrR8PX6GEgpHHH62GO1gyhycGiHeMZ6s7Glfple/mrlYBSeNELxD98lL0VTbI25xwj7lxTMDgvasDdi1jr/sRMKBhES3RorJeajgwUuQuqJbPeoWjhTp1m7hJ9d1WpDMFMsWzkW92QVlD6i6RdRvCEc08Hg75cw/SwRlLUW0Ln0chk3zI6Tkt3S87OWUeDv0zS4nL/JgQzu5bren5633p6xsXNDOzaEmhiJnnQCQoQCCf5VFYVLqQpLJXa3f1t98laxpBohSp4kojPm1S37urHQkCSMdpHr3E5ZT+P1uibPY0uUetszBoJXQUpHHmRu6Q+luPgT2aXdAxPiB2EFOgLiP+RZsgW1QJdSQfDwIN0ui5qmgqoGvYTTjCtUg0QYB2a1xT0e6NjD7T3f3/nu1ZjZtqEUkK+eTTyamqIcGwpvOsXkzmu2kj4ldx/YFPb006O/iOcQNj80DrbJlO8EDQ8tuVlk3BrKIOAoi2zaMclvYItC0Hn3abyfM4CMbvEAICRpZHiFeNC41bEXWmO3PL1DpFi09TkvgNZVWuMg8/r6kS23RFWR0sRB8fS4dBz6PVDEiZSEDOxr4XVvd69ZJbpMbw/JYcHoOSaEZ6RH4/4U7FPRT2o3anENnMfH1/NiH0ltxhRI2yBNSUpxwxS1set/cZTa22/L4ST034ESn9bu4bmYVhYRb4FypMmZESGdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(5660300002)(52116002)(8936002)(6666004)(966005)(508600001)(66556008)(7416002)(316002)(86362001)(6486002)(26005)(186003)(956004)(36756003)(2906002)(8676002)(7696005)(44832011)(66476007)(4326008)(38350700002)(2616005)(38100700002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jkY51yc3KrDtIt0Md96GJRtvfA0LnEmqG/jzokc2agq0HgkfPj3skrGDl3aA?=
 =?us-ascii?Q?0tDO1JmOCXqyANNMS7hd8l0m/ZiuvtrYIYj3Ix4f/DXcTnzwC6XCDWjZC5PI?=
 =?us-ascii?Q?LCxpeTMSN6dcyiWotsj4jtWHcUb6INLoC7X5XOCJ7v9STf3YcBSDEz3GlScF?=
 =?us-ascii?Q?u3O0Gozlf6gF2m/ASeJyxz1UDm8vn7uQtgPYQQ1P0uCrtL6extLkdSC3BA3p?=
 =?us-ascii?Q?V0xSTDUaOD/xWS+pWqwJcZ50w6IbwmiuGx7xWMGqxo+WFeUjc0SMpUOPVhX8?=
 =?us-ascii?Q?3OLrUW7NMnmfVEFEW6z41kchGXxWuxttnYkiS/C5iNVNEivLWFXbUD5DME8I?=
 =?us-ascii?Q?0TjDo8WQEhhR2voi4vcVz+jQ6wSmjUpKqu7XPiMKA35ueTLxvNvw5x/Je22R?=
 =?us-ascii?Q?3lykfMpDXrhzFRzDaY6MSwi2HyVVGVirJrcrKgsq/wpp7bTk/qxz7jN6uCqV?=
 =?us-ascii?Q?rX2wGVImpX870wsvAThsnPuBfnAKYs5hNRD4Cjv19D3EcTuteM6u81u1ibmG?=
 =?us-ascii?Q?AE6heGIjAq/krBSV3jV8N7O0MBxAzUCmH304aREs/5SYHOb5/MQgq0HBF3v0?=
 =?us-ascii?Q?3YouhlqjWhS1Ld9NNfJ8Qxjzj+LJLnUrYN+Rj9B65eIaII4V+aks9V2CvJf3?=
 =?us-ascii?Q?HD50HaqxJ8/OT5I6e8PZnckj8bTLn7mA+uJuCw8KNoiecOrkyY+eq0aZyLfY?=
 =?us-ascii?Q?ENwJVxnVgfOzmp+2vx6VnNilQtVoZ4yGsnWAmQcfEOT8U5tPXKVd7CXcYBGK?=
 =?us-ascii?Q?nROtKr4pVzoaHzmYsmsox4evS8GEipMh5JolOsDOerLEVlhE2JfCkyt6gX/U?=
 =?us-ascii?Q?cxnrG53e8occJHGo08DgdWrcoN8NYj0SdZueYchODluzVcRQsCiExRtEwMDE?=
 =?us-ascii?Q?b44acMm0ZeHK0G8MRD2L3V3B+CeiLtY1TY7rIYHtlrtNzqpeNgEjwvTSFoFo?=
 =?us-ascii?Q?DuZ2+I81xStJR6VEvdsVoPTe3nmO9WuFgPPT9Iyr0muFA8N9oW4brLWbQwdb?=
 =?us-ascii?Q?732EKnIrZKYMrfbCdYMRt7IR28y7m5ZErKQ9wJAdpTEGv62+HNRg2M/SuJ0D?=
 =?us-ascii?Q?XXxILZ03p6BoqdR5z4X4KSpi+quKNoGvHIeYjjREVu0dmRkmeGRiysnyO8xg?=
 =?us-ascii?Q?4Z9thnahDr1vZtX+h1NYE234LTTA3gnE876Ownj37ApAZ+PjdkhornbfV1Xz?=
 =?us-ascii?Q?Dfw6tiI1EHqQfBkBYRvxAnJKBTtn+r6DhiHpO+BNpO/jskkHkONh/OHEFJ4P?=
 =?us-ascii?Q?A8ImIRAEzG1qqv9pdtus9IZREzjyvefgEtnsQx6zF1lx9mFCj4kCz8H4IUmO?=
 =?us-ascii?Q?Qyp5UQHMTwJwU47eXVFW9bd1+CsBtG5lp5bpM3NqivNVlOjp7GW4QzAl/d8g?=
 =?us-ascii?Q?jDMZEdpa+mAfyZ9XEMFdoTwcDJ3imKr/YY7QwS0+vEg3CPykR2B6sDDovlD1?=
 =?us-ascii?Q?M0orXeabNl4Tik4L56qc82aWXX0b/5TWa1+wXHuj7WhsfX8rUO8Jp5rfygN9?=
 =?us-ascii?Q?ALb5HoIXA1LxMPyHhLXX1k0w/WkoPtmcvuJx5+SpCWw0++MDKrJbQ/0aWvws?=
 =?us-ascii?Q?q4qGYshPRLwy3ndvEodjGTUxzaBpM9Hch69IgiPhqvUSY099vQZDQ07rgl5c?=
 =?us-ascii?Q?0dfVfrSVYQ5T2BJbJHFz+hA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6393565f-099e-4d76-54ea-08d9b3e696ba
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 09:48:40.3838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6vGcy209JNks+AFT5BXDgtCBw6useP5gly7KB+Y5mTc6cPjYtqhlfQ82cL0wpGJzCMGEWOV1g+qECa4vThtOVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3925
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

