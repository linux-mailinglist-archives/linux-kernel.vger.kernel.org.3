Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6CB4BD5EB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 07:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344930AbiBUGMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 01:12:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344928AbiBUGLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 01:11:55 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60058.outbound.protection.outlook.com [40.107.6.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C70A1034;
        Sun, 20 Feb 2022 22:11:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=As6FwnFbdd0SgDCi5dmr3C/SvrbXn9F6Wn1X+pB6KfPfWYFsScfnpTLTWNpr8tumGK9ihKaqi5lzFfXDcaUFjPN2UWFWx+huT1uKfVD9P6k+1p93MD+ROZU9qT97ceKilCadtKNFVUybIQJSjHCSEeeT/vstWyYbGZNukeXjoLLBe3VNk9na6PuC3pimaZSptxqnExgop+uudmgsbIMTlPZY0ZfNxogUStq/63snLj5XqqDMFm/4ZEXTCLIM2+K7IQidKmBzxGNqI83MYGj3YIWl6FCWlEDxd28aR9y6U5xuC53s97yUpqxL44mhNnE+kS5zZfBsencjUOgYRCdemw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hya/3bWzj54cTNXLhUWYF9C9ssgciYXjOVJTTdcei+0=;
 b=fRJF3cVeedd6v0Ux14311vloUwLwuu9x0ydQxRR9rfVlIn2OTifPHJoVoEtJsLeMm36GtYB1DnhOVRIHsHExVo75QCDGATMdmQ4R+gpd07KeZnHg91NZoPcj145Mb8Tn0ccKZ67e1Ip88gwx5wVts0tkSRtLOeMByO0I7A6vHo5LLiWSekg7tyPaYkDUwKZSSJ8mH1QdB6GnDxqkmvYrX3+Z50Vn/NFh2sk+bSPQn7f8vQ9qw7SwAfoZTvC/ZVuZYKpzEHF9XDrxBENN6eWaGWkUQ4SIO7LryOduz+DArfBhT40K0zm7gy7JMFSULt35xwSkeup4eq9IBkGNOSH1BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hya/3bWzj54cTNXLhUWYF9C9ssgciYXjOVJTTdcei+0=;
 b=WRbHuJg9xD57U6yxVIp55xbJc3whVJxq9GmiAvusn9cZP4Vw7Amn5qaRccoylbkm6SklX/zwq3qt1H+Hs3kgwq019k4NQuHjDOtLh9Dvqe5tFkJanN+Y+nBxihvAH76242euZ6w57i+7rflws9SY5t65pGH06uS6w/qMyvqgn38=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VI1PR04MB6064.eurprd04.prod.outlook.com (2603:10a6:803:f4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Mon, 21 Feb
 2022 06:11:28 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.4995.026; Mon, 21 Feb 2022
 06:11:28 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v16 01/13] dt-bindings: media: amphion: add amphion video codec bindings
Date:   Mon, 21 Feb 2022 14:10:20 +0800
Message-Id: <0be64ca65fea1fc99bd71a0e5f788d0a3d38dc17.1645422822.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1645422822.git.ming.qian@nxp.com>
References: <cover.1645422822.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0130.apcprd02.prod.outlook.com
 (2603:1096:4:188::8) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91f520a2-2635-4272-8ad4-08d9f500feb4
X-MS-TrafficTypeDiagnostic: VI1PR04MB6064:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB6064726C506FA667F7C89323E73A9@VI1PR04MB6064.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fIZyDjS04G4aIAu6IA1H5ARFaHltg/kaxFdGzZ2kfa/ZBCfmX3sxBHtJ6y8S3Eod/x+gvFj5iZyoJrQAonH2EDGQ+wVCXK8DeaeL64gIzJ950WInaV4Du/nvWO8rgofvR65/+q6H5N5bhwGtN9PfqMSTT0G/dTspnPKNRfJ8FUPbrOrwpE4u1o7wWd8/GjQg7NE97heEiK9hy9IuZ7DYjc5yVvj/zX6lhwb8DAzGjLDYr37J0ht+cohLBf7s+aWCgzIzFhIL0zLkdRQIeY+2KaET9fc7IzykV5t2xc0ARx5bZ2prfqDFgVbFmv/KQfEDtt3VkdmK70Uu5Z7JGEBcMPjVBHBj7+pFITP4zCtT69Y/ywqeofGRh9KV2pA8e/24KHtRwdeN2YNJYZmlk66hEsyNfdU0CjZMbdUWMmfqdLy89HQNc1WmxNQWIiTsr6ZqCBuvz/FAJJ2KF5Z+j45JpvTqypubQ1LRsTMI5aF9B4ZK2nnoZotj8YKAN4xGHoi1IsYVIQslqA5GZiM4oMBOjaxoevA8riO/WBGXzUM6GaVIwnWjlTGjNoCx3SYzbE/1axa1TW4njTUzgZN5n56CAAp0fJbOrv8zH/Ah3i4WuIJ7gKMmW/DIF2RgjjHfjAiaS67C9XRyx1Gh2CjDwy2fTOFgnoB6hyy3rnItHT7+xpwtRbpidb/te+23Qc671A9XmJm/q/cvls25NSinlieYsnsceZanVfFKvXlxIeLyFW6pN8IKFmaAyMGemD2WUzvPGmpJ+HRFXrc1ZwLuZugrXOg7pq4qaZa1M2cTVxgRnTgZGxLmVoDbCOLsYGK3aVJ4j1eFTleebtnS7qPsNV82+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(36756003)(966005)(86362001)(26005)(44832011)(316002)(6512007)(508600001)(38100700002)(83380400001)(2906002)(2616005)(38350700002)(66946007)(66476007)(66556008)(8676002)(4326008)(6506007)(6666004)(52116002)(186003)(5660300002)(8936002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QztiKbJgHMjDcZGEYU/LlKyQJy18DekJ+KBK7WlShWZVMZNl/jYXA5oJily1?=
 =?us-ascii?Q?dBL4KvpgGAXYDe2OzdaMdfnKR00NxoFOKe6r5WXLwUt8iNP6lXcYk4gqXJ4w?=
 =?us-ascii?Q?abBhqFQqkuhcTKg7Qy2SMMEtRP25qYF6ADCmSOamgn0uSfYZ9medKMiTFF/8?=
 =?us-ascii?Q?NaqUESElziUtOakmvxSbJ2jCetX6RWIVaM+f2F5n8tqBQ2H10hC8Hfeca8du?=
 =?us-ascii?Q?MmRhNYWibNaq57xWgnOghHniU2DFDsIaCupL3qJn6cJFX8n0bDwmApeGgid4?=
 =?us-ascii?Q?BQoTS0+1Mhe2OLFkylXr71ivF2kGUonSV7dPROf6GqC5DLSu/0HJ9/oYKPAB?=
 =?us-ascii?Q?Zd3C0GYUO4GXDemnTlseMn2JR9zi93wrHkE3STbiguE1eelexncRa51l+q2U?=
 =?us-ascii?Q?dt7NzYVNKf0UKmPB/Q030sSjueKICyCtnNkQhmezYQS+N21g7KOinISuVTzF?=
 =?us-ascii?Q?pBn8ITUL4wriIwDcMm33J0OmZb6N7s4NbkLQs8ajzZmyw3MtmrBuhfnCpo9g?=
 =?us-ascii?Q?JKnow80vo1QrR/8+3yGDGLcgMlxg+WXITm4P+uLYz6X7R5Bbdw0feAIEApWJ?=
 =?us-ascii?Q?Ayt5ktvckQ4Iv6p9gIPwFukGH2Rxxiv9t1dsIc44Qd8l/v1B1Av8+ruKB6yS?=
 =?us-ascii?Q?wih++7uZ/M929H132jy9324RxqGPkseONU2ehmpTxaiMn4IBl+rJVwSvCBVg?=
 =?us-ascii?Q?TiMm6EYEegWmABR56W/SF7N1M/fZKYrlo5w58YmkQVlsN2Z1YZkDFFlz24su?=
 =?us-ascii?Q?rwsD4iwrI93smS6fRmi7ZkksLe6tBSGHSUR6GLiIlB1V5Urh3oNJxrs7N4m6?=
 =?us-ascii?Q?dfSUXavxDddNQUTQkL1Osqx6P0Wu7e5a1uC2jMLezFtf8K4PIB/l8zDWiF9X?=
 =?us-ascii?Q?gvWr+q+byxdMUux8nPrwdc3/8w8n6CLp9dsKSpxE1+NSFBVzltDcKrT0bGU5?=
 =?us-ascii?Q?6q369QTtery2uyTkCNsqQ44C+sqdt4YuHGLCHjYogfbSorY0w5y+UpkueZEw?=
 =?us-ascii?Q?n2MJHFjkc6Z0ZPQD1vNCWLT5GTXe1a0oW0cWKJqVxyijBbe0z/kmPV8NVz4+?=
 =?us-ascii?Q?8Uu3a0nrkTwSzXV0fo5e1SdWW2zr0ScgAQ3ZxR+OpoVR+SLb6Kmo7Ue/h8gt?=
 =?us-ascii?Q?NPBTtPIEnUf5Hw22A6tiPKM9w6CKXs9AUPwGF3V2sml8c9K1UDu2JwT6W9OO?=
 =?us-ascii?Q?bqLUbc+tztd2qQsMyZXEh0jliQu3+AlVsrHel7gpNQVl4rvukqZt5yWCgiQU?=
 =?us-ascii?Q?SxAl6OEwCOrtCwjp3vjIrp1GLmEUW/RTbbRFcClPgODtCxGLYv4Xyt746tLM?=
 =?us-ascii?Q?tgVVAW6+3gu1+z+EWVkGsu5x1ram7CxkeUwpeujm0cRXVwPrHAdiu/piuSuh?=
 =?us-ascii?Q?i9YMukRVeT2EGs47cFmmbGnJ8HCFLWjR41bekACp+zlfrF7zQKweH4puNK3z?=
 =?us-ascii?Q?Go8Qh01Z1M3hRlFuesFrU63ED2PNklR1AjrHwAGUSjTrIh9jKlZDWNdqA3jW?=
 =?us-ascii?Q?poPjI6Zq1kqP7hZAAnLxQeb7Ll9n/OGkePJXJWlz/U+WAaYn5ihAy2O5Js7I?=
 =?us-ascii?Q?0wL65iglimwlGzoI1nbUTlUJKILypWWeQYhdSRPoNv/+uaWDbL3BzqWBOWlj?=
 =?us-ascii?Q?NN/dAOLwUu1euc8BBvACeEo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f520a2-2635-4272-8ad4-08d9f500feb4
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 06:11:27.3716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N1QUprT/wg/lFqtOfcTWL9Smtxr65YAhysgg4qkcRK9kDOVFOKGIzWaPMB57n8TjAi8g4FNSfrw3nDUPbzMyvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6064
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

