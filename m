Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F6658FC97
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 14:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235343AbiHKMm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 08:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235338AbiHKMmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:42:55 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80087.outbound.protection.outlook.com [40.107.8.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D1C89831;
        Thu, 11 Aug 2022 05:42:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcWGKa59yRLauWeFFI2xY2i6OiAVjdWg0GNqpo2jrQK+eatPMCSs0ByH4Gf3MVLYbsEUsmZDzVGBMAgXc+9EB+Xw6bKIstHiNuPgSqG+H00MYeKCLyQD0r8gNt9imVg+XrnplpFyQhgPzilMDNiOA3FcdGMJl8DCi26OgBpDwY+UAkv5+4Qi207ad+vdUifc9YA5YU29MxFpUigKZe7mBBeksFEHMhdJBvvY4Q0mdeB64h4cThJI4rWhd9+l4FSxYcWwat0to0gx4MMulBMwlbiAjACLIl9h948eukGpyVDRrSPucf/2BRj9+jPX5f8CxA4Z1O9YJCJ9t9saUNcHcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uovhpHgfSX5dVq4h4plvltEBpjSMmLqX2/Xvq72jKBU=;
 b=GXNZBkDmRRO7UM3e5s0irEd7nks6J4u/BbtAr7J8dErKyL5xkGcLsCJqDmwS/MWIk3LkEWoA37+f0oj9BcZ6UTi0foFCTszWsc9O5i425ydmIE00K98nUNwV5+Jg3rqLO+O1IT82al3vhSuFmDRN8Mnbm3gwU4PlaUUWzYtI157yijpS6FbzmNQWD5yWcwjPoFDmbQjYYfW/gy03R/eB9KbGHveToAiZfcmbvmOwX8q8ocFr8LCbfxmsKM0Qt5Ggx+wbzk1pz4sqqsCCttcCR55W8XmyZ8SR7YrXw1Li/aJfzl+evWEXP0HHsSdvxvZlDN33tkG+oaBXUwbIpyO2Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uovhpHgfSX5dVq4h4plvltEBpjSMmLqX2/Xvq72jKBU=;
 b=MoeXOm0Ruw1MbiaF9gksDh/e5q7SomwDFZqIN/9VjJeSSPQGgi46etX7dLp6+W6DQpDZKNjVfOnzcEaxRoxYy0qDkotpZeN+8q5QjdacZmzurwttywCRHO17y+VfI0CpFVOhAwmbM+ru4+0yz8cmFbtmvSOVO/abF2pgBhPMRHU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::23)
 by VI1PR0402MB2832.eurprd04.prod.outlook.com (2603:10a6:800:b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.22; Thu, 11 Aug
 2022 12:42:52 +0000
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca]) by AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca%5]) with mapi id 15.20.5525.010; Thu, 11 Aug 2022
 12:42:51 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, brgl@bgdev.pl, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev, Shenwei Wang <shenwei.wang@nxp.com>
Subject: [PATCH v4 1/3] dt-bindings: gpio: Add imx scu gpio driver bindings
Date:   Thu, 11 Aug 2022 07:41:33 -0500
Message-Id: <20220811124135.95299-2-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220811124135.95299-1-shenwei.wang@nxp.com>
References: <20220811124135.95299-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0064.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::9) To AM9PR04MB8274.eurprd04.prod.outlook.com
 (2603:10a6:20b:3e8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fd9f30e-1300-488b-8833-08da7b970127
X-MS-TrafficTypeDiagnostic: VI1PR0402MB2832:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7pmYlxh88/3rFAZYO4QKH+ImDimzrDEl2KLTayJ7X4f0kbXbXvtDsTJY0rsVVHp0bNxPHAH98+FtxPuXYWqkixZDctDoNsv5QnuthKBNkCP2pBz+TFPoTCEpcP+2Y4mHLFRKT6sgXoCWLuFi3AkIfE9Zmz5ahFfn8L/UVb4NmBJtmX09r2ZL6ELxG8y2/mkTgWIVYbd4d5gMu8OCJG+d8mee2xLt/MUlZ/1z3iqgw+VLcqBwHDUG9Voc/DnrGitJQDc9XELezaqX+V5+MoXIcVdCY73lUdwg6dKe9m0BfCAtf0nrxwMZ/2xO7NK6iulg0ach14onWvzM1KZ4paUnNYTc+KSZLaxM95JrAZhEXUsxAMm8PPc/7kEip1KVflO8tpuALehnZd88UxzZ4vcmZFKDUqj7GN9CdRf4hF9dWG6FS+/iadDw5n95vuTx56kaLPXZVeEKLIjcqu+ANhJezPZxh1iv7GC8UhS3NyWeSzfvgIA+Bv18QRX6Pc0B1V0JKFcqBrBF9+MmBmdLQ0iHIsqqyr7Hus3pl8UU/YDROA3JZchXKUnAggKxF9LiELZ7R8E2jguaweyvdLrQ1hgHBY3VMH83d687uoQD4yeRiykQLDapamzS8eBSDvgvwJT1HBgjNg1LoSJQz5js+RYjNSH/fVs+F1amS9LYGB8OgQHhu30kRLO2SSr4EbcMJycfl8NA+lrRQaD2PVMtenJlO82Ot7bT3KynzpekCDFPNtQ1ZJXInHqvdlGkZOSoavWSobvSn3feDOr3r1GF/i2cZXgoEmYu1HtQtGwDZaSwKDTu8nIV47t7o0AmVvbOwGfVMp6QzHrLFI1vbCEimW1DoJDcHQ0EY0hWiPXaRAzjeSdfySWN8aWnddPoQF+trX0Z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8274.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(6666004)(186003)(6636002)(41300700001)(478600001)(1076003)(2906002)(36756003)(316002)(26005)(7416002)(38350700002)(8936002)(6512007)(52116002)(6506007)(44832011)(2616005)(5660300002)(55236004)(86362001)(966005)(66476007)(8676002)(66556008)(66946007)(4326008)(6486002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z12fOlC9flW4varWnR7+1+9gmUfdwnO1Balap0r0ahJya9x4q0rDagVTcqjm?=
 =?us-ascii?Q?Nn+DQXScOU7an4ZF4lfOKylzkpJQ/cub1UbzhXexJQvOkoP91VpedUb8x1DN?=
 =?us-ascii?Q?7Fv/KPh47cp7luuqbad8cK5eEPjcF17sCbqA1fhHUQJvzAKCM5czFl7X6pHE?=
 =?us-ascii?Q?SZ/CsxOIzEP34fak7bnlg9HHDTVxYmyPz1DOoxB9aGhiLItvV+TZJ2aznQ+Z?=
 =?us-ascii?Q?0tsJtcPQNZCBvg1CZBsRPfEgjjd7yrtSbvJVuQ90KuppkDW38Z7PUqoP7jIG?=
 =?us-ascii?Q?zCdD3y80EnsIUeXemUgQtsuwB/MgByStdW3jGATvfD34YqLJBGbIoEF0rA38?=
 =?us-ascii?Q?tz1T5pDjexPY35Zo8w2DWLZRkwWPTd21jT1WGCDlZh3m9qu3zLGGkKhHP24a?=
 =?us-ascii?Q?+Cs4/saNqtF0e4YqaSn1LPtsSVTDkc1KVW2ajCVx0Baxm75+R9bDOvrgSCAH?=
 =?us-ascii?Q?kll+zdLF/92eKHfHgR8d5ESGX6FFAoGvR2s3pp3aQqmUIA4qilOFiW03yHEO?=
 =?us-ascii?Q?rRGackn50L97N2WP8PEa5BrEcPBJpfxO5XZ3pYlWT7BtdqBNPsD9ZgJXaD30?=
 =?us-ascii?Q?bbJBMZ0Ur9006Ohn98lb06u4CLpYmVMciDzygfdfqalcVkavc5siah8Kk+Vg?=
 =?us-ascii?Q?LBIfiMH07uvNQ+oRIulhzv0cglUt20LOJ3CD/VOqGRXGf7nMqUHArePdpPj3?=
 =?us-ascii?Q?q1WMF7hK8Ecf2SRiAfJEQ5xnkdz+F6KhZBJ+BB2/Q5pB1H4pbM8dIg41IeSg?=
 =?us-ascii?Q?RCYNkm17at9P+IP7NlPt6UDZVkdhoC8uALmtl9PAKvPaEeIOakoZVgeBVsmH?=
 =?us-ascii?Q?oIFR3dSXDXDkjd74oMaBVa4A0MZB3DUXHtbAr+uhC0PGHMp+1q4XuefJHjzb?=
 =?us-ascii?Q?hFoJSH/wfU0hg48pMyzo++2mz9lfj2Ls8nbTScG6zvw63SGG1XDROJE9LdfR?=
 =?us-ascii?Q?AfnoGPJrKONLKU3GySCVWKybPYwPZ78GphHxHv/7xHyuY+/msh+tRWy+w4Xw?=
 =?us-ascii?Q?scJP3qxpRdUDeKnn+OdGIP0JqcLEPwcAI3yiqbmiN2e74ZSwfLrYZY2ruGYi?=
 =?us-ascii?Q?7jOmrNxrOxKCl3Ks6EAjYMJgvk259g//wPB+4NqSl0zSxvldkZ15N53BKoMG?=
 =?us-ascii?Q?2HmFVT+eQ5QUWmFozzStY/1YQ8u2SOG0SZXA0JEbxyflaAg6g5tN8kvqnfPE?=
 =?us-ascii?Q?cXGnvpcf77fa5KYnGQdvLHt5ml0JhN2tB2lbuRoQ4XxYef2H82VHlsP9AAXL?=
 =?us-ascii?Q?onuf4vEJeLZAQPhZ7GP+UarHimZPpOW2ZMukZ4d84tzRHrfcTGsa/rqdUKQW?=
 =?us-ascii?Q?Lwl8dDs9rekIY/078zHzpABUhoGt7o2dFXDS013pf9DMUtqjEQCH9LnrHPqU?=
 =?us-ascii?Q?GItmIFx7KUJXa2ll+8Ypyn4XnMD/s7+zdB0PJ1It3bSSx12SSpXcYosuOPfY?=
 =?us-ascii?Q?9FgOXaI8AvVfH4hoqoDiLllLHlTlQfnVjd9YLfWGsTw93H//T+2/ntzW6ly5?=
 =?us-ascii?Q?WEIWlpsgHZNFaVcEc2ZLXsE/2TR3pwBoHML2UTzetTyVYfxrFnD01mmFXNnW?=
 =?us-ascii?Q?2WEuDgru/LYPVD2e6Ja0JJ3xpaf8CHZL3WHmalC6iUmjNiX3YJ2ST/OCSA7B?=
 =?us-ascii?Q?Sg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd9f30e-1300-488b-8833-08da7b970127
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8274.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 12:42:51.8335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lk3N1KXCN0ua9X+iAUXcAcXk9eP71LUbxsvzjF59EYU31S19u5wFeIY6sePNcR7Rs9bQ7nWxaPy4nQixNYyQ+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2832
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding document for the imx scu gpio driver.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 .../bindings/gpio/fsl,imx-sc-gpio.yaml        | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/fsl,imx-sc-gpio.yaml

diff --git a/Documentation/devicetree/bindings/gpio/fsl,imx-sc-gpio.yaml b/Documentation/devicetree/bindings/gpio/fsl,imx-sc-gpio.yaml
new file mode 100644
index 000000000000..a1b024cddc97
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/fsl,imx-sc-gpio.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/fsl,imx-sc-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GPIO driver over IMX SCU firmware API
+
+maintainers:
+  - Shenwei Wang <shenwei.wang@nxp.com>
+
+description: |
+  This module provides the standard interface to control the
+  resource pins in SCU domain on i.MX8 platforms.
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx8qxp-sc-gpio
+
+  "#gpio-cells":
+    const: 2
+
+  gpio-controller: true
+
+required:
+  - compatible
+  - "#gpio-cells"
+  - gpio-controller
+
+additionalProperties: false
+
+examples:
+  - |
+    gpio0: gpio {
+        compatible = "fsl,imx8qxp-sc-gpio";
+        gpio-controller;
+        #gpio-cells = <2>;
+    };
-- 
2.25.1

