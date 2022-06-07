Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825FC53FCDA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 13:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242553AbiFGLEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 07:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242827AbiFGLAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 07:00:53 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150078.outbound.protection.outlook.com [40.107.15.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A75B1165;
        Tue,  7 Jun 2022 04:00:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdC0qQcJ3lElInxcWYdk2q0Wc6YGiLKI4Z+0FNeKztzP9aXSQZrM1YKKE2w8qD2u4xABA2dyt1OpkiH3CeRqkdDjN/tIj+J8LN4vXfAvNOpQGYgV7d4DBSuWAz6HtJWo8qr4eDnCmwtrkS3oxKFcdLLbSAogFnOIZVlc0F/fvn3X6RsJkmIqjU3mNUBpujVh1dEtIQFT0AGx8Rurmem5RnDq0fpXMq27kHohpAoB8n9UbGZrYZHwcXXCqx0j4pSRxYUoTYwlscoMwICTNTb7OPug0G0qmSYgtAoFl9jfAI4f0MuW2EkHKrI5M9v+XidoRPwGp3GeI5BQpYuzI1Nvcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHrLocszCbW49Q41oG93t2Dqog089ScB34vAHRvUEnU=;
 b=FKo3qayMfFyC3hoNP2FVUP72AqiGAItCdbZMUz1IyjGHfT/UOJuXHs0q40yO5d5CPzWJHfbE7A5DlNW4z7D/GuMYxKv71ibe2A1welS4s+PQX3HCcF6hqycyuXKD//tEmoXF9yg28tylyjcsGw7Pkkda8w6Ly1y00V2RgsrkVGd3sO30sqUvlFkTeDFKG9/l05OqVAkppKPNS8/x+eqsWcOylgBRSTXbzobqhmwWywTmk8rb+kXYR3V0xJb8tZqTZSkrKOBHEj1xhkWXuKqOh5BTc4QoqVe+JnUnNukCthOa4yJiyilkjJJBu6ddXRykRFoSjhQX7w+fhbN745nt7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHrLocszCbW49Q41oG93t2Dqog089ScB34vAHRvUEnU=;
 b=FdEDT2AmCd8DpE8XRm3IQN+acOQ4d6efG+wV0uirDO1J3Z29pkxX3t3vSTvSgaokYdKm52NfJ2pC+R2V5fFh0JuIb9pbXrNre5LS1O4nzmEaSaeWOgIty5SYkLuQXTmTk8jM4lp/B86kO8ErkWbPkCZN87gaGTSxxJ0CwqnnTRU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR04MB3008.eurprd04.prod.outlook.com (2603:10a6:802:f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Tue, 7 Jun
 2022 11:00:11 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1%5]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 11:00:11 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 03/10] dt-bindings: arm: freescale: Add fsl,scu-iomux yaml file
Date:   Tue,  7 Jun 2022 13:59:44 +0300
Message-Id: <20220607105951.1821519-4-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220607105951.1821519-1-abel.vesa@nxp.com>
References: <20220607105951.1821519-1-abel.vesa@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM5PR0602CA0007.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::17) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e971e647-d404-4e6d-a1b3-08da4874e48e
X-MS-TrafficTypeDiagnostic: VI1PR04MB3008:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB30089AAA62350B8E039C1A2DF6A59@VI1PR04MB3008.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dQb/SuKBoopiPjGDSS0NpOBRsxsllhe3OLeNY8vulqwUnr9EZkbcAvQdHiHhABBFiSe4C0izYzDMGJVhbuQF2B7aj0JakTodJk1WeYeEDXcATRzVgREMccgEdQ/GLnlh69Gpht4zYHBkaJr3rxNwRsGiRMqBX4Lq5TvV+K6gyRDX1cTDg/huliwHr9gXpGDOOuiEWZz2AEboVyfmjTE2hH0LTzWC01Q3Rmw449eoDa7wIv5ioYssl2BVcaEsELJELD6EvsFJYDRlE28XoqMVvtxkKg3mNC0zWjQ0RCa7c+2wqBLdPuD8xbApwqybNm1lFGgl6t63EwqDqBnLma87ovDrKUzFgkb2atM97zbbmzl0wEgjDLJ5xyrn+J3mvziH0D46RzBmKtZwIQu1gfx/Kx+8740pI7Bc47053aA7KNPd6660JH33PTn2iYLc8RNwSkBujuyCbepgG7CN1J2fqVa62oIhpGP8GVRnxYaDTYG9L0+1SqKANLiCrJ9rYTglDAR2qlF25Y7k0D5xO79rvDfmrQGvw1yCjtfTTRhE3pX8W0Vdu8XTty0WMxwtBeH+v9C1k1FVaVXZc8+8IsReXlAXZvAY93m4L0yiScsEhS1+JdogYjI13+j69/fMMjQhfQC27A+paZrq1ql0bbR4NvBVeZl0A7WsRcqbxAQR8gyvbFBDJmUOX8p8oRieqkNKeYG+njEJeiZbWlI0R70av5YZxK8Vmx/EpcxmhWHdSSYbZEX0FLM02uvN6e2qkC/fQhDA+IIvNJnDoKkJwaazwBrKQmFKQAuOihoisOr2tyOLX9NfcQ1FlyoaYTf6opezDbSGMVFLyFM+jFLdUyWzOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(6506007)(36756003)(38350700002)(38100700002)(6666004)(966005)(52116002)(6486002)(86362001)(4326008)(66476007)(8676002)(2616005)(8936002)(186003)(5660300002)(2906002)(44832011)(508600001)(66556008)(1076003)(83380400001)(316002)(54906003)(110136005)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ViCCqUOFlDNDnRuENebnRuKzrwoZRK0tgr1+7BnsNFET1zxRNGAD0vSkWVFU?=
 =?us-ascii?Q?o609nczPXsfaZKGzKVr9ITEjhowTN/vruyEXLnlbD7JUi3lVAK44KoBUXwim?=
 =?us-ascii?Q?b0nBfypkTGQVWlpam1cHXCPriAYK1RLMrGGvUfpUaSTUUzWKHARLM1AJrkjU?=
 =?us-ascii?Q?x0RX29QjbLo53Q+aSDDEhsXuVhqrl27ntY7sCCD0PY9+tS2vRhdmd3uHSVID?=
 =?us-ascii?Q?78XYLZVSDY88gKs16RvOAYtYFjntKp5ylLukBWHxZABzjM0AAa33o+YG7FDq?=
 =?us-ascii?Q?g16AkF4fUwaAfwfIOvgexAq6k2uvkgZeSZFfL1sFhVD0XUasGJTFh2J9A79g?=
 =?us-ascii?Q?I37s6kolotuj7G0lmw6oWKrWFunDKyGZBUf1HzfkWtwU6zhO4PunXPgd02vb?=
 =?us-ascii?Q?olOhTlcBQTsH8eh+Re6osZX1Ty73F/SlExW8itBtEpNBSCVS/hmwSErGuAJ0?=
 =?us-ascii?Q?48cvzMeBRfdxVstASaVOVQmStv0AS7DVBbe92oygs0wqZORRJ2zkekHqn1hu?=
 =?us-ascii?Q?iuhoBlO0FKRP4v/ZgBhxjo1fMJQmVIflszWiUX+M4tC7cpDVTHXQ4dn1jlt0?=
 =?us-ascii?Q?wyVoZWDKD9cC2VDoy9c/ksr/9YV5aX9SiWb35l9jt+pCRsYG/6ny88bBmQ7U?=
 =?us-ascii?Q?Mha8oWhtWta1FdEZXD4hNgmoQYuyqMHX7vb2W4Hrsw5WuFB3ucAoY3wYXrPU?=
 =?us-ascii?Q?VlEQYevoes/Hw4NxxK+HKxYx3nAq1XTp232Md14qDdS7TC11lhMo5tuFXGHk?=
 =?us-ascii?Q?qilrW01jpVbeC5sJDSTsm2hNlAnVOMO8n3IQUZ8g3xdQAgDkSRZspyOu2NcR?=
 =?us-ascii?Q?zWG2SSSsFNxeL6f3F/B+y22Z3YlaaZ9vridKSpWrghjQgJuxfbYfi5GkcGb+?=
 =?us-ascii?Q?7Ujsrjhv4LckrfRVI0Qtf8fhrDXyrs6EC787Jloyq7QjIL700mQeCvoFPPlu?=
 =?us-ascii?Q?kYgnLN0RldLqHsTE8zCjZxr1wAaUe/vGgh2H8lQcXIrpUtBGEtfRnTZmkIBv?=
 =?us-ascii?Q?BDKLd3lGJZ/9ttGOOyaeI81a4ut3v0DFqvfoowAHF83N3y88M43lNbBDqdGW?=
 =?us-ascii?Q?gsNqDDGu+MliRGCy0TDqT+QEdsWkuNwPatn8JC24z4SFaV95u9v761pu+PDM?=
 =?us-ascii?Q?BW2Qok3/lU5ekUmbzeHmqe64rV74+rnHleRmUkxqNUXA0H9mX9aJj77wFMUg?=
 =?us-ascii?Q?0OuBoyDjPAVmao7J2bWhaZHNtCieUFSvYW9QLqDjQSDoWKxcCMfzaFdHkdBz?=
 =?us-ascii?Q?G28dfZF2h0nWp+V/wypy97qs1sYfxyNXxXKxzrFgRlyGsmEJrb1JtvmyXNbV?=
 =?us-ascii?Q?vyZ8V7+o/dFD24xxoqA0AqWpfjoGnXNy5v1yWBqeqIcEuEfO3Dy22OQEvzgN?=
 =?us-ascii?Q?T6KnqkdpIyb2XqPGws6y1XzCZ4ungRI/qwDOat5pHT5dACw57+Fs+DINsmf1?=
 =?us-ascii?Q?UhOseI/Yi7kkE/PT8KuN2qwR2kywT9ioEttTLGA6Ws1Ym2ia6UlcF53a94M0?=
 =?us-ascii?Q?eTggjyJP5erUV3Kh9DEHQDeNYPtzArugS64b8ZMwUNJ/rsm/JVuYLA0KVg9T?=
 =?us-ascii?Q?F041WU3WwESEmh3PjKshgy9ehqAVrXlYLqnf7V57PqQL4P2YnDBbwVxGdxkk?=
 =?us-ascii?Q?b1/74jhdpH1hfeHMX/uuzoJj7162otOeTZaf6QLz5Z0s1GGlNOnqdLlvkYoN?=
 =?us-ascii?Q?FAHIMm0KX8cLzdj69w0HPHRqSNe9z9fCpKFteKa9TVVoLMswc85JxLvXtvi6?=
 =?us-ascii?Q?bWLmERlPHw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e971e647-d404-4e6d-a1b3-08da4874e48e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 11:00:11.6649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Va4tsGa4z/d2BWdCqlkM/73KWiVySrgRFO/hDVfoVvBh0XB7nw3ns02f8Ax3AoNDvk9e+9ZuWQ7iw+VtdkDNHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3008
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This documents separately the iomux child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 .../bindings/arm/freescale/fsl,scu-iomux.yaml | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,scu-iomux.yaml

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu-iomux.yaml b/Documentation/devicetree/bindings/arm/freescale/fsl,scu-iomux.yaml
new file mode 100644
index 000000000000..ae13c68331ae
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu-iomux.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/freescale/fsl,scu-iomux.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX SCU Client Device Node - Pinctrl bindings based on SCU Message Protocol
+
+maintainers:
+  - Shawn Guo <shawnguo@kernel.org>
+
+description: i.MX SCU Client Device Node
+  Client nodes are maintained as children of the relevant IMX-SCU device node.
+  This binding uses the i.MX common pinctrl binding.
+  (Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt)
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - fsl,imx8qm-iomuxc
+          - fsl,imx8qxp-iomuxc
+          - fsl,imx8dxl-iomuxc
+
+patternProperties:
+  "grp$":
+    type: object
+
+additionalProperties: false
+
+required:
+  - compatible
-- 
2.34.3

