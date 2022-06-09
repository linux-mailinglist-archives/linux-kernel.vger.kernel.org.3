Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464FA544C82
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243667AbiFIMte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242648AbiFIMtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:49:25 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30071.outbound.protection.outlook.com [40.107.3.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FF6939F0;
        Thu,  9 Jun 2022 05:49:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byWcpLvv7b81Uxkkr6mFV5/4xXhVduNiwDGkZjqC58Cb9vExaHDKimiCy/fq6Ul5C11TuEer8a3t9G26TFDLI/s5yyHnWXoKdxDs8o7Hr42qxmE3LUTSnE6UzpSyw2qYabkgYXsA2DGxIertk3kHsUxn+gWWlun8xCfaeTVaJ2hyzlHl8pp5QGKblSqIsiWZQhU3DZE6/vcVorb6AaophJQTf/j5QF31OyvuFzk4/rW+NKo/XLIXXJZCE2X8/6fyyh9c3cepMSitDqXrHDDPKdi1XIhASNlU6vovNpBnJ2LknsBCj3mAoqaYMkhQibQnvoZVWqDRH0rly9fEE7wyCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64tCl/gvybKf97tOdjZGCJj84QYQelV/iYaYcawaYtw=;
 b=f9QzhR8sfJy8DzE/rTCafZS6vkKkQ/7iRHKR1NBTDv4TesyNT1WYkMuMZMfl4zcZ25mOZCiq0a8Epu6PXV+l2DvDviGKbLfHsdYcdBbTXZhi25e2vySuH18p36GEh8Man/5K4xLCBUKnYk2Qhuj8REB23HQ2qX3AEGHwOV9h0q/PCasQNd7VnjNq95O+75GVgtcGtsICvCPBbRDw7+tTZHo+IrCQqM2Lgjimmv6P0V0fKjfXkALckid+3ouQ9VdAqg5BJsEDkHlfCbcWsp1A+YKKBbW3Rbufj0yvVZ7+bzWSHDMfAhIw7vfVeQsFmQp492ICEmEaMysmBD/cxMib5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64tCl/gvybKf97tOdjZGCJj84QYQelV/iYaYcawaYtw=;
 b=QJEpxqm6a44aw3PM3vM4NaO834KhzrrKQa7xNeNn6WY/T/n9PubDRdDfMfSvMmAm3nE2EYDYptGuDDgtBkr/LKI0vVJqaeh4XH71kY1iqzShrZLZTNWUyqvq3NHuakGRfoYbE5FdVCADYsvM/WULAnjBWkgci/SxNkXo4YWn9d8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM7PR04MB6952.eurprd04.prod.outlook.com (2603:10a6:20b:107::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Thu, 9 Jun
 2022 12:49:21 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%8]) with mapi id 15.20.5332.012; Thu, 9 Jun 2022
 12:49:21 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     aisheng.dong@nxp.com, l.stach@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 1/7] dt-bindings: soc: add i.MX93 SRC
Date:   Thu,  9 Jun 2022 20:50:54 +0800
Message-Id: <20220609125100.3496633-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220609125100.3496633-1-peng.fan@oss.nxp.com>
References: <20220609125100.3496633-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0014.apcprd06.prod.outlook.com
 (2603:1096:4:186::11) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dcaf8bd1-0a3b-4c4a-a5b7-08da4a16790a
X-MS-TrafficTypeDiagnostic: AM7PR04MB6952:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB69527A44D526BA2D4F3E84A5C9A79@AM7PR04MB6952.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3dP2M4HGkd3/Nwo3xr6Kp2NiTp8oc/gCiIcug0ieiAsR1fdnvJCi2bTYolvEZdIEKce+Q1/reCszm6dcPjWdFvYLL8wKF9WeL3Mx0xTiu5jUGvXrMWb8WuM5msTbX9eXTyugIM+fd0DkF7nGX/6kJqokWfGFHKsQrZbl7NgV6fcVLTa6b4MIMkhCC2PwofxADnYGA0A5I3zDDNnfks2/ejz4glRsTC/H8SyudJeAzF0nBaOrYDZ5P67DAzpYlhqi4Opw3OiJxDz3QS31K/wPCVyVyUKla7+TKzXFDQRREnr2TZGDHX5K6EX+4R7GDb2JAcbFySnuLBB++WSkXGusdSEpy4yDfBCPSotR9dxlq17aU42UBO+xs0ra9YVWSMTcHjYLNGBIFbZLUpiNVPl/F2IDbVPlO5rcMfjIy6MiYelRe9cvK1zhBPaoPUQPqGhxW0uf32RpAa/JtCeVHND6pxs2MdHeSXJCMqFPi/aS79AqDJl00CUD2hFe6RN84jElQAUJAkT8Ar0fGgxIpRL5vLftZYlnF2n4M0qu8O3wbPFDRaQKahkEADncYfX8nVCzRj9i5EwJ8NP297MiBzoe5pEcHsjT3kAbMv3/mSAv8BVyw4bQfEN2q0tjtiaSRnvBsPBR6jijRXxr5c7fsGi2TEWF4U/lKti9J+uc134O5XIRSGRg1azkdRPHyizr6NMU1lnl2gQC1UWkMq55/bJDut7+fQb/To+KHHufcZkXx12SiucZeg/NGdGTLiwR6Iau9+GsvY+DzF+TVobPdohEP8h80cFim2pJ2iuwDhmkeJOAaSBQr4jJrH+jwLvAYe4xi+OgiGWjo9A30wXEbf2LzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(6512007)(66556008)(8676002)(2906002)(4326008)(66476007)(26005)(6666004)(6506007)(38100700002)(52116002)(38350700002)(86362001)(316002)(8936002)(2616005)(508600001)(7416002)(1076003)(83380400001)(6486002)(966005)(186003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mffDauxDncqOMJw1tZSb/7gn162FohiFZGcDrUj8YJsvx4gPOKTYi5aEFFmZ?=
 =?us-ascii?Q?eRLwLlxGBUfxC07SM04tU2ZsVCScF6tZXLMuN639twyg3OhbXuoa2WwSZAom?=
 =?us-ascii?Q?rmsnp2ioKGxA9HMV+OfnWrCJdpJM6GUEHJ1dbMvS/eClZSg+xWwtSMZGQSSL?=
 =?us-ascii?Q?IWWvwkzy3JF4pVnGLfsf2Kw0R8UJbp8LdKe/BVi5HWPGIBL6Oc1nxgVya9zB?=
 =?us-ascii?Q?y6rw9CPwrVcO+hmDONCxIg2rO3fYTSKyw3SOgflnUuPqjY0c9Z3ViawJqhMb?=
 =?us-ascii?Q?uz2KvFr+ulB++LhdE/P6aLp9F0SCDIiJApVrcCoqtIY1cJiXryANt0IQmPnd?=
 =?us-ascii?Q?xlUwp5rUGt+m89NAUjzoe1/o1ikSo3GclS0otEF7gTSiYEuOLAZ9QZ5DlvES?=
 =?us-ascii?Q?K5Dkses4v5M6PRK54qLedjPY7pasbhgRJ2YxcWqkHgxVml+Nc2Kogl0nPEB3?=
 =?us-ascii?Q?1Pw93GNv5iYwQ/sk+DwfUPS4Muv+kryhR0N8GmNRKtoGZk2952MOUOFFqeMx?=
 =?us-ascii?Q?mm7LRRRS/IkGwHybvaiB+1rRv2JlL82sSfaoJWtQpw0EJ33I5FQVcegCmPZX?=
 =?us-ascii?Q?uFz5hzOed/MfNBGtXv/T4Wg5xIgR+/q0s/LwBu9F5K9jvrxbx8RlCPJaMU5c?=
 =?us-ascii?Q?jyEeVta0QFCBXzs+IWI5ExDRGSf4z/kp4S3y9eljcPSvscR/DxMmqbf/8ztu?=
 =?us-ascii?Q?KKpJt93mK/XnYdBFbgiqwVlQxNDOf6JQusp1Z0wf1gY4+8SBi6jiTddtcvBo?=
 =?us-ascii?Q?v1wrjPpeldWTvC3YrePeFRYS98uFYTfct9Y8RLXcl5D7sRLDM38Rsvqk8rzV?=
 =?us-ascii?Q?gxw3l00GcXmJiVvLu4u2GDk+wgJCo28QEqBheKQHhfspKGLIyNhp8pwoHDrz?=
 =?us-ascii?Q?pIO/Z7UOVzgqpu3Evo2BxFvrDTpCc8RghpP/aZLLlnxWWu3Xg/DWM3aEcAtV?=
 =?us-ascii?Q?+ArHgAlkMr3tR/jLnjipDk0u3t9B4B9Ua9pLF6MD/FETBnmZP9KeWmfeHevY?=
 =?us-ascii?Q?O+ZUBXgPOkLy29zw7sS9fIKMbqNfaXpLU/GVsIWhpZxRUFsCNCxJ40FisFxB?=
 =?us-ascii?Q?Z38vOYqwRdQNlssrVpeUAIwomo09C+UqVfiujHaVpWpn2P0DVhe1mE3UMxGe?=
 =?us-ascii?Q?wDWu4dHCkZkNMi6FZ9ZbQBBX/B2yaHHrOEBv82QJ+faZwurtO2mGyvoFCJuH?=
 =?us-ascii?Q?MYbz68ZV/HEI7/fEV+SNXICwhc6PAO/Bli2kcjVny+N0fnEJZQ0MITJClcY0?=
 =?us-ascii?Q?l9sWkZdNip8UQy3fBTdDqXfh+F5Pza7WftouxS+fRQWMckOq25bM66qXMC5F?=
 =?us-ascii?Q?CB5wzlK2S9F1bdYPfLQ0IXYV2MdiXvLnBVbO1VZhPiJtgRA+ycPxOwz2v+0t?=
 =?us-ascii?Q?EjvG16I2Ko/+W9xlQu4cbrq3JDH9wYaz3FGH0YCPk3ieTzsM0we8bL0V1TEz?=
 =?us-ascii?Q?lD2Y2UbLe5HwluLKI9tfbXl0n9A7FRYwUytYnOVsi1bTT0Q90IBqAeFcMKKQ?=
 =?us-ascii?Q?KMwj02kkjZ1KDP6I9TDm+xGxjkNfmR478wnQQ8WK1dHPxUwrg4EberRlR6z9?=
 =?us-ascii?Q?SNmoiRtyYka18vq9AskI09TNNkHpjhE2m8K3FvToH0+Yx+DX93BbNwaNp2v7?=
 =?us-ascii?Q?3WodevX7pqUzhrWkEkN5HInwieMIMCmeHqUKNJyAj89rB7UL1FdV7PxFgIit?=
 =?us-ascii?Q?hNJCjiiKrIhB1U8JfPJuLLumOfpgSvziwCAzNnDfantEAUGWMtqZsr4p3YsP?=
 =?us-ascii?Q?vXi9b5c1/Q=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcaf8bd1-0a3b-4c4a-a5b7-08da4a16790a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 12:49:20.9479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: itsJKn3Mqs0ClZL6dv3Jhip/ATQpU8kh6qr7/yadW2JtAHr22zLhhUJ+bqH6sp5453kAm2A3WML5GIMAPJnjiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6952
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add bindings for i.MX93 System Reset Controller(SRC). SRC supports
resets and power gating for mixes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../bindings/power/fsl,imx93-src.yaml         | 96 +++++++++++++++++++
 include/dt-bindings/power/fsl,imx93-power.h   | 11 +++
 2 files changed, 107 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/fsl,imx93-src.yaml
 create mode 100644 include/dt-bindings/power/fsl,imx93-power.h

diff --git a/Documentation/devicetree/bindings/power/fsl,imx93-src.yaml b/Documentation/devicetree/bindings/power/fsl,imx93-src.yaml
new file mode 100644
index 000000000000..880500a841f7
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/fsl,imx93-src.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/fsl,imx93-src.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX93 System Reset Controller
+
+maintainers:
+  - Peng Fan <peng.fan@nxp.com>
+
+description: |
+  The System Reset Controller (SRC) is responsible for the generation of
+  all the system reset signals and boot argument latching.
+
+  Its main functions are as follows,
+  - Deals with all global system reset sources from other modules,
+    and generates global system reset.
+  - Responsible for power gating of MIXs (Slices) and their memory
+    low power control.
+
+properties:
+  compatible:
+    items:
+      - const: fsl,imx93-src
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  slices:
+    type: object
+    description: list of power domains provided by this controller.
+
+    properties:
+      '#address-cells':
+        const: 1
+
+      '#size-cells':
+        const: 0
+
+    patternProperties:
+      "power-domain@[0-9]$":
+        $ref: /schemas/power/power-domain.yaml#
+
+        type: object
+        properties:
+          '#power-domain-cells':
+            const: 0
+
+          reg:
+            description: |
+              Power domain index. Valid values are defined in
+              include/dt-bindings/power/imx93-power.h for fsl,imx93-src
+            maxItems: 1
+
+          clocks:
+            description: |
+              A number of phandles to clocks that need to be enabled
+              during domain power-up sequencing to ensure reset
+              propagation into devices located inside this power domain.
+            minItems: 1
+            maxItems: 5
+
+        required:
+          - '#power-domain-cells'
+          - reg
+
+required:
+  - compatible
+  - reg
+  - slices
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx93-clock.h>
+    #include <dt-bindings/power/fsl,imx93-power.h>
+
+    system-controller@44460000 {
+        compatible = "fsl,imx93-src", "syscon";
+        reg = <0x44460000 0x10000>;
+
+        slices {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                mediamix: power-domain@0 {
+                        reg = <IMX93_POWER_DOMAIN_MEDIAMIX>;
+                        #power-domain-cells = <0>;
+                        clocks = <&clk IMX93_CLK_MEDIA_AXI>,
+                                 <&clk IMX93_CLK_MEDIA_APB>;
+                };
+        };
+    };
diff --git a/include/dt-bindings/power/fsl,imx93-power.h b/include/dt-bindings/power/fsl,imx93-power.h
new file mode 100644
index 000000000000..27fb7df80f93
--- /dev/null
+++ b/include/dt-bindings/power/fsl,imx93-power.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/*
+ *  Copyright 2022 NXP
+ */
+
+#ifndef __DT_BINDINGS_IMX93_POWER_H__
+#define __DT_BINDINGS_IMX93_POWER_H__
+
+#define IMX93_POWER_DOMAIN_MEDIAMIX		0
+
+#endif
-- 
2.25.1

