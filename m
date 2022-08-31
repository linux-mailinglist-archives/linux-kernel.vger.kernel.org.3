Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A085A7FAB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbiHaONG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbiHaOM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:12:56 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DC3D759D;
        Wed, 31 Aug 2022 07:12:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hyLwpvro2L1kNAe25hH3Mmc9GypugoX8675B0FHlG/MAI1pn7fvr2Vd2Fn20U4sA4sdl28VGPDR6dVX/uNyCqRiDMeqvzZBaHB6DK7UWJC71yAEAqqR62YrGjamJ+6Okd+gph5MGkNThgbxBqyzESRATZ1vh8DYKrqtb522D18GscP+EEgdpzH5MB3ZRm7JnPsHavSzepTfjWM6Nnlfbk2mPKddPneRgN905bqRySHTgsCfDiDKBhu7t5PvI5w3jlfMcfJWfeXz2eyaqnLmSufKYdqAp8O22JitxkZI2eJYwxq57TNovxl3R4PlOYi71Ezjb8yRyoFqTPqfztT8yEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqYCQlFFCDahn0lhkdXi2eO8eV2fNTI/j7P9UPlqVbU=;
 b=FUyrDAi6WjF+tYODFYdIEtmutTdXvnoW08atQEr7pPe3+lM0l6SvSWCw5iF9ch8sF3XRMi0S0otRtJerPOhAYB19YvlBf8MJC+qlB65fZJqaaAoNmiNb1HhcebNle2jxQURZJCfKYe53BCMbYWwwYuKaZqdW2N5aJKgg3GVH9S7aHMopBp4DHfBhqDFYJXr+VkcnpUwlkd3LLMoAKtX0GCMFqecXnKa7grbqFE9NqVx5PgjgTrJdeVDaeOtrj1vUoTbaN4JbG9iR0CYjsp6+HtO+0Lka097bf8ARa0r0yUeD9Rx6T6P/P6SbAfM1hWnR9somG7xbk0dX1mP3VDy4nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqYCQlFFCDahn0lhkdXi2eO8eV2fNTI/j7P9UPlqVbU=;
 b=NGifDfxarz4TXcqxO0x8VhC6ORQKzHnvKHxuXWdrI23iBWavJr+tY4fcRZ5WJTN3KTFkWDCFJ60IgBdydrkM2KywtFvYT7oeoXyOGKUojIAX58ZZdtKvwJh73IJoUKpcPTmT6FJUoh+2ydOVSK9mrkXibZ2jiwJa2zb8IdQPStE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PR3PR04MB7355.eurprd04.prod.outlook.com (2603:10a6:102:8f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 14:12:45 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 14:12:45 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 1/8] dt-bindings: soc: imx: add binding for i.MX93 syscon
Date:   Wed, 31 Aug 2022 22:14:11 +0800
Message-Id: <20220831141418.38532-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220831141418.38532-1-peng.fan@oss.nxp.com>
References: <20220831141418.38532-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::22)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f1dbed3-9248-4dbc-f5e8-08da8b5ae05d
X-MS-TrafficTypeDiagnostic: PR3PR04MB7355:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oX7Yf4q0LkAiykaYqb/HBpKLQLrW4pGPsr2HFl/r+M+97BxxdElD6au8bbsdumT4GuidyBwB+5v1r+pgTUyvq5NO3v+UrbQBCx12j+05qdzlQ2uUYR6OvoWP8vlXX+R64v3c0ItSNyjotyJrz2Jl69xHq56vFxQ5h3zSivWYU1+mDkxHWZ9KL/S+oPsU8RTVJASGU4VOz3PfSazNMTa6fxy8fFLD7bTYBgzBc+asnzKr7L0LYVO2b02YZg2tG38FRAa8p1U6/RIo/5YAXlhEWR8OnPBsUMaSsUJgdMfRVMe0lbuNu0RnLJfYEMPSJYxYqoXtjfPrT4vfV4rmiIvHP3ptEkMUv6qJ5ibgCfBC1MMqnXCBOpJUG1eKp8mRSS3X0kdARn6POmPKDd4HBHZCh/j4A2ivRnfPsaZVluMgs3CsID3uhyVictv+xD73skN6AT69kRATbdKlpe7GzAPqlju521x3zveJIcwqbov4lcdfCrKB3+H3clyL1PEBrCKVsziQu1eow2HKyhiL+Rr/R/KQlHchTAU4ya/Yv1krhr38JM07SrhUF5czZgqQu14NEBLkyGSgZpUSYOvZlNdbHviQWeghnzvDn7wsFVoDrJ6rbwHmmcl2SzSMiS20eIlqDwq+5fmK2j/GHb7UtH+VXyYsSAwCOORuR/kwdKPkljv/2vZdpyXaL0xPD1amilicTd/XmVAFeo42gm7iLTQI6lMjuoPzuxA2YnSaKnkoKeezVIXShZHJv6XqCJ7hR2ZnWrEC8hOABMwJcumyrEYsiZxKzv+uaoImEhWVLtdbAxdjpSx5PpeCHYmO2SCFB09qg2kRL77EIb7rGYe95KQXcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(8676002)(4326008)(66476007)(66556008)(186003)(1076003)(2616005)(5660300002)(6506007)(52116002)(316002)(41300700001)(38100700002)(66946007)(26005)(6512007)(6666004)(86362001)(6486002)(478600001)(2906002)(966005)(38350700002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5qpILkOHNTpxwyuaq5uMNT/PLP6HpkkAQ1FBv3ZAkDJSOHVHoLFN5Boyd5q5?=
 =?us-ascii?Q?jc03cV6VrVmCrpidsXFd8vTzBgb9Swh0AZMI2AL3ivN3hGPSy6SVj7uJbpTp?=
 =?us-ascii?Q?6IJgxWvF6PYARI22Gn0av541bWATmVfCPXJ3vtRO6mIRBqqRPaEfUlJK/aJA?=
 =?us-ascii?Q?o0SE/dQ/LosP430VIP1FG3RZRqFJbxBqZ3X4VOBVbpk33YnDtfDRgOvVkRSZ?=
 =?us-ascii?Q?a6KsuABv+8a7WJnsuYwgFNszq1rH+W03rLJTdZCBiFvt/DfF1jtLNKKFrZmN?=
 =?us-ascii?Q?2eqnKbbgqx85Eq2S8H/ZbnX48YwWVVJPrQ9kaJnOKtrz7YGgNkbW15IGArxd?=
 =?us-ascii?Q?kXdc0kl/wg7nuwf6hCLwFjxepnTtM1ml5wwmiQNt4PzSavLQ5WkYZnvhW7bL?=
 =?us-ascii?Q?/L1vZKa7JgwmAnd7zHIFdKDhE1T1rADWkx/e4GXHcDxOKu/FEWUi3/2QGyOk?=
 =?us-ascii?Q?FszRN4U2156QSsoywgmxy6wiTjTOX7Zr2++mb16+d4fk35isjW1hzkCJ41eS?=
 =?us-ascii?Q?IXrubftgLjbMtxLrT5YxyXxGL7aXfjmgHc0nsSMwY1O0Ep3gTro0DfQblnAg?=
 =?us-ascii?Q?2aJrSS+mpjJ++0n1zrUFfLSTOYuRahT/VVeR5PnFeX0gSrr/IjSiMHdI1vTG?=
 =?us-ascii?Q?8mkuR/WOeMexC9akr7s7H8FD4qZqF0uRS1/pd9I+oZjW0j4kmezC1moMB77T?=
 =?us-ascii?Q?P9RcipKwu6nK9SsVbjei7j+2iQ71k93xn8QxRnLx568h+zncVtCDOeqBhOf/?=
 =?us-ascii?Q?LC51EE0O6lf9C+BGLJpB0F1PdK+MUvoQ1XDH/Q77WdApRd+5MDYbk5xGa9se?=
 =?us-ascii?Q?EqCUfkwb0uN1RmylJ8y09A4bMbmTOMWFMnAylGveQuifHWioqWsmIYvmnlmi?=
 =?us-ascii?Q?PgAY2LpGzYHwhual5y/EJfDQzGCwYBi/Gvq0En0vC9oiSuuBxo3VzWKJoG5T?=
 =?us-ascii?Q?JNApKMn6hiA53dDb9jTta9fWvgyhpYfOGyPgPCgnnn3mYuu11T3XZZPgCRS6?=
 =?us-ascii?Q?veBqf42Ey4uK7QYfzoPWG1Mnb5+qlyc1c0R6CzEUCgvdrBWOUEklsqQZQMpU?=
 =?us-ascii?Q?ob5+52GA6ZHpdmuTvmCUHRtIOF3f+9eY9wBuHAlJpgCiu/WPb3k/dZayJP0w?=
 =?us-ascii?Q?USNhuiX/t4F9FEKfbRHG+xJuCmsrAEI2aiCfIn+BjeLhgA1u+yluz+L8hRWw?=
 =?us-ascii?Q?EhgSbkNKp2s2+w9X7yTZ63Jz5jglXRgqNYBbrSSO/jHVtWX85/ZPUfPmTGtm?=
 =?us-ascii?Q?YTe1SGluEobpzNkl72aes102JOSsB6WUhi0Ah34RziaeHx4U4W2JOL/kES4L?=
 =?us-ascii?Q?4ukoGrfjBU6dTAPAp5BVk+XQimEhTQXya8fOe4ZVzgt3F9cwqIOq7cXuqbmm?=
 =?us-ascii?Q?QFBcLsM0KK9bKC1XpRmnn4XqmPwUCHmHcdVonhrUXeQ+CzmM93g1AsCbQJTK?=
 =?us-ascii?Q?3sReW2eCdB1GEth4Zi6J5dAUTsvfemOP+Tb1aPpjzWd469JXE/xOIaidATxm?=
 =?us-ascii?Q?MrX2WikOvvH4VFeTmk5GERD2gyUWg1b3umgXUFe371q0MK/Ix1gQj5rlNlOr?=
 =?us-ascii?Q?HBgstKyKkkH1SE0N0ReId4RlyACTtbex1el5jmps?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f1dbed3-9248-4dbc-f5e8-08da8b5ae05d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 14:12:45.6417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FQ29hXXoFx1l3M3nDdmXnzk32TtlBHUCR8CwdpfKejh1NRLe4g1188dsjIRZJs6DqvAXeNVIqYRm+lPmFNYWNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7355
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add binding doc for i.MX93 blk_ctrl_ns_aonmix and blk_ctrl_wakeupmix

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../bindings/soc/imx/fsl,imx93-syscon.yaml    | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx93-syscon.yaml

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx93-syscon.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-syscon.yaml
new file mode 100644
index 000000000000..0aeff336a74a
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-syscon.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/imx/fsl,imx93-syscon.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX93 Platform System Controller
+
+maintainers:
+  - Peng Fan <peng.fan@nxp.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - fsl,imx93-aonmix-ns-syscfg
+          - fsl,imx93-wakeupmix-syscfg
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    anomix_ns_gpr: syscon@44210000 {
+        compatible = "fsl,imx93-aonmix-ns-syscfg", "syscon";
+        reg = <0x44210000 0x1000>;
+    };
+
+...
-- 
2.37.1

