Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C90646B5BC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbhLGI2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:28:43 -0500
Received: from mail-eopbgr50046.outbound.protection.outlook.com ([40.107.5.46]:46661
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232577AbhLGI2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:28:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hcPvBIREa/H4ub6jmv2zSG6sJKmpEBtWchl0vYVP4slYOoMMeDybReqok8IzgC5Reu99mU1E1uXJGUlHN9D6yny/yCp2pTYlgbXs8d/pmNZoHhnlvVmidIY95Bneb8pZyPI99jeQD+SRCxFE0Ir17ftmgd8X3qkG4caeEqKW0hNX2pl0OU793zVoJAPtKxNL1myfliKVEAZpJgLGWcNbVvAnKGeo+z9Uaiv2zwlpHDg1zF9x6V8d9W0sdDjC6lzG0kvyne7J2EO7VS8ODTB8N/bgltRG6bRzElLmbINp0TEY/xbzrFX+o8ISk24nNr0tnU4i6Un47AyJkXRB2cJ/xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hya/3bWzj54cTNXLhUWYF9C9ssgciYXjOVJTTdcei+0=;
 b=PxdxZFDL4hzgID/whCmkHl+CGaQbZWaprFWazNyr5KrRyeAZegqCKhSfUr2oCzicCnsbqu8mqIwCAUuZYxmfvMdrNRqmL1ElCIxGZMdbVDVMKLSojkJaxs4Rb8/o/C+7/L/WfwH5rCcBggktrLUYXusKxMgo+lX6XWvotBZKCA9acnExwvRsbzjdxK0kNw8jLpRd9vzjq9tc56UXA4nTP8sdsubmNnkB/YCtSrdDt3P+dLmryKH/P6lUQev8dCkrKdXOlBWbHzqNgFVN2R7AzR7CquZgAmMFt2PiBCZmq6DbE5ED5pP6jtpTxM6vw+gC99bbf9w4gRMuEwMZQFjcbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hya/3bWzj54cTNXLhUWYF9C9ssgciYXjOVJTTdcei+0=;
 b=TUejyQCaw8cpmS2/OGiENXlXJ30xX2lYNCN2jVOodEc+E/Z7ncDHIm2LutOfwv1coScKHiQ859HJr2cyqZjKwThIVhJ2J8zaBwi5TPldvHdyHQPuyM0koJz8DZimaHUd6/Uz3GOwvz0+XhdUGgKMP9rlGGXoYYMfzFzMUWNmVJI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM5PR04MB2978.eurprd04.prod.outlook.com (2603:10a6:206:5::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Tue, 7 Dec
 2021 08:25:06 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::90c5:793:ee65:e316]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::90c5:793:ee65:e316%6]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 08:25:06 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v14 01/13] dt-bindings: media: amphion: add amphion video codec bindings
Date:   Tue,  7 Dec 2021 16:24:16 +0800
Message-Id: <ac3a26737b2b8ab56356b07f3d1a2857ee9584f9.1638865027.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1638865027.git.ming.qian@nxp.com>
References: <cover.1638865027.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0247.apcprd06.prod.outlook.com
 (2603:1096:4:ac::31) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
Received: from lsv11149.swis.cn-sha01.nxp.com (119.31.174.70) by SG2PR06CA0247.apcprd06.prod.outlook.com (2603:1096:4:ac::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Tue, 7 Dec 2021 08:25:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64ef9cd2-cbce-4ec4-dacc-08d9b95b1344
X-MS-TrafficTypeDiagnostic: AM5PR04MB2978:EE_
X-Microsoft-Antispam-PRVS: <AM5PR04MB29785FB830171A9E35F952C6E76E9@AM5PR04MB2978.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oA9pvMzXaXOpMIQMBObYAZnhtuAQ3POAwJlcllRyHWEfEiW7cfS3Vrib1nQTLTbqFW1/8p/w+CKVvU33pJtm6nCaMd8aryd5h7rMnrQdOWfVQOAaBqMWfai2rb06njU16nMd3L5UU9IqNhi9wlEOQXVnyj/pu4VZxjTVhFU0xKzhO6C8qSh2zPAMkQnLVx/bIQMv/eMqnvlrstfL+j2aBybzhrfNGTADL7D2Dp4lXbbiSKykY91cjh5Pczv/hzU+BDOnlnexpYbgr8D7gnAmGBhSeQsVSe6ZCs60a1rm4qHYEFGaE9wzLpnVOef4V5BsxKr9XK0M324fN0QlvEAoBck47WaUgt46iMTv5UNXptSCjaZ969hBzFG1VOd7y86cdocSTRtJRPPy+goSg45pgr5J5qUhqz1m0O5zjgxWn9ynIHF/V8vQG3ifvjnNGdgetDY1C9Jyp5WAy/vEpafP7CPZLEAOxKqjCD3GTqkcFdgYV27tOmzfudvBmZVLsWXeesLSga8TSHp5KCjPVCQIhktE6fT1EIFhhr6KCMGVMtJ3PMdDznB1/kOPmFB/ZK8aEvc9iLQhU1r8FbrMiC1sblOBnLLOvyfzdc1LrO2fDKFsgvcXa1y/TVllTV0L995S61wMI0fiM5N8LFoxCWUGY/vmc8GC2FIoK3s3SNxjoO4kqXL89wZmhC1kd0prvGArH5aMlNvPZ+MTQ0xAXxA/ugo3WzTLNQ21Wx7dXCCS8x1pcfRYbZvX73R0PXChhnhuyP59tnQKpZRS1ac+sjtOxUM0Fdm7j35iKtrfCa5zuUXBVbfD6ce7sYyRdlWzP3emoIgi5UZQxA1602gHQKiFkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(7696005)(44832011)(6666004)(508600001)(966005)(316002)(5660300002)(7416002)(4326008)(8676002)(36756003)(956004)(38350700002)(38100700002)(186003)(2616005)(83380400001)(26005)(2906002)(66946007)(66476007)(8936002)(86362001)(6486002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2Sng9Nt5goRuoH94TLlCnSGOnsglPg3npgfzPM83DgO13hnOjrUbDkNEVImk?=
 =?us-ascii?Q?kpg4u9vxx00DmahO6IXdeiMz4xfWfLGEsB99oYiydmqo/S/T52EFA6m3pbch?=
 =?us-ascii?Q?V8AcKHBhHgpwMhYbhMamzF/qA64yzrwDoas5mNj+9Dj4l+TgLViNHID4IMQH?=
 =?us-ascii?Q?Wxw9CSNb5Wln+b5vZpu4wrMbMh8jqt28yHaoraWiMoY1E89IsNI3LKnrHkV5?=
 =?us-ascii?Q?PJdJrV0fH2jDn2Q+ist9ILtc7YLhOY2T2fz2eDy3GZjHjezLZGi/kgZWYCVj?=
 =?us-ascii?Q?zu66JoWqRwnycTYEpkQekRx7zCkMwaNXm3x1HHVOKIv4WoQYPwlkUfNtzz2W?=
 =?us-ascii?Q?7iYFJPf4LTSZe1iAHYF9tAHmqQikqhuHip/ROK6tXsfcR9bnCFOjRa4afMoD?=
 =?us-ascii?Q?381Utdg6cnSAVw78A/YTlpSOKOx40Oae1u3Z2Wwt0l/5W8mh/vnCveuD1oR1?=
 =?us-ascii?Q?m2jTMZo+qjy2U2VfmooWGsIBLl/UB0zRpSBme5e8QTSj21j0FMLryDcHVIdS?=
 =?us-ascii?Q?cZ/g9t9E9f6AsL8VskfapkqG5VOKLgvqPVpRr3DvOEPRMI84tqKNWLkSAMh6?=
 =?us-ascii?Q?kHfYvbJLKlNTT1nHW7ReJI3QvVa1MMpBaYy3JX2hA6ZzgriMZLuPaBH8bVKz?=
 =?us-ascii?Q?oImt7av9GiEiQzK1Qdgw4VzXR/JStdodJj0qaVF3aFY6Iv3DPC8Kj2F2tlEm?=
 =?us-ascii?Q?8xzQ7m9GAHVT28Eqw1hzHMqn2A/GQ0Ut6p8NV2zClGiYNbGi/SUy+oER48Ne?=
 =?us-ascii?Q?9RPe+SFxvJwWL9ck1mr51K20gltntPF0k+WUgLZQ51/PhlMoLKRumtP1rcum?=
 =?us-ascii?Q?GV8dnU8choOtPlaYhKJqkjLSuN0lsJfmavHVD1iQCDdlVzRSFnQww13WXS0T?=
 =?us-ascii?Q?deFwflZQj2OBgFjnKvy2Tjr8XPuwvxj9CgzFKby+QkaKVk1OzZpoqCNvP0d2?=
 =?us-ascii?Q?6CsA+COHQDuoNOljP890VIRDAJshlF12nPyfxBBzTqj78oHq37oawuF9rNUY?=
 =?us-ascii?Q?G+ZjiPjebHZCxY7AxMtphV1Xh7qKTtDk90JH0HUizJzpbOUPar53wnGcIwtC?=
 =?us-ascii?Q?jUW9vDm2wUjrNvioOWn2/4m9COGTsp9AiWKyJ0LYSIqJT2GcKXIrB9LyUMKF?=
 =?us-ascii?Q?Alm9RC4jQ3QGNOk9hWq4Ht35oATzGx+ihX2fBgt+gVhq0dph+G9BEbuIFqLM?=
 =?us-ascii?Q?3eWntomw53i64lI8ycofeRVpbUogGjpyzEp0hCV9nuoqi/S2RZcWpAWHISm/?=
 =?us-ascii?Q?wXbl81QDYxiU8/KDQhKg/qF8v7Y+sCK9NJnRR5YknM3i439AGtdjIxdUKdDw?=
 =?us-ascii?Q?q60/32WuEDCoLcizUyb///wjyssGWPRuEzv3YQ85gh1Zo8yxRW+vcn04k0Js?=
 =?us-ascii?Q?7v0p9VCb/23dwk/Ut1giFjaqCAlj/Qm/8UV/jrGgCJsCMl5fzhLNEqcvu83C?=
 =?us-ascii?Q?B1zm2vvFQf8n46hnU48g+yv4rNYp24liljWKktjYw6BGxJJNodX33eEsVKMo?=
 =?us-ascii?Q?coU7X9tfvAo7lk2LcXoApo1tQtSTdLA3ms1Jio1tFs6pkj/MVqXw+4lyyPEm?=
 =?us-ascii?Q?VFqWjUsb2xlbzpy2HeMVYUVVWUwYHLCnIy52y2Opgk+tbZB8c1x1gbSSLL6o?=
 =?us-ascii?Q?dDN9SyhmGbLxijLWmUlgrKY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ef9cd2-cbce-4ec4-dacc-08d9b95b1344
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 08:25:06.8109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ambDjxhoqWGUR2ic3Ai/k81ngdM8L5fRWlJAPFNNAfe9uBzQgq/CUv13Z9FgKLpvAyPojXxdIQTZJpI5PRnXEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB2978
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

